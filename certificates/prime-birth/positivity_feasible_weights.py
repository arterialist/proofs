"""How far does positivity alone pin down the primes?
Q_c = pole + archimedean - sum_i c_i (A(u_i) + A(-u_i)) on test functions supported in [0, L], with unknown weights c_i
at candidate positions x_i (u_i = log x_i). The true data is c = log p / sqrt(q) at prime powers q = p^k and 0 elsewhere.
The script finds, for each candidate (or for the total weight in a window around each half-integer), the smallest and
largest value for which some choice of the other weights keeps Q_c positive semidefinite on the 2K+1 test functions,
optionally with all weights nonnegative, and optionally relaxed to "smallest eigenvalue >= -EPS, weights >= -EPS".
Method: log-det barrier, damped Newton steps, double precision. Each bound is accurate to about
(number of test functions) * (final barrier parameter); a row is flagged if the true value falls outside its range.
Usage: python3 positivity_feasible_weights.py L K x1,x2,...|grid:lo:hi:step [nonneg|signed] [window half-width or 0] [EPS]

Outcome, 10 November 2026. This is a computation with the true primes on a finite set of test functions. It assumes
nothing and proves nothing about RH.
1. Six candidates 1.5, 2, 2.5, 3, 3.5, 4, signed weights, L = 1.45 (numbers below 4.26), K = 24. Allowed ranges:
   x=1.5 [-3.7e-4, 2e-7];  x=2 [0.490125, 0.491354] (true 0.490129);  x=2.5 [-4.7e-3, 5e-5];
   x=3 [0.63373, 0.65122] (true 0.63428);  x=3.5 [-0.064, 0.0069];  x=4 [0.136, 0.783] (true 0.347).
   The same run at K = 5 agrees to 8 digits with a 50-digit implementation of the same method.
2. Twelve signed candidates with 11 test functions: the feasible set is unbounded. The number of test functions has to
   exceed the number of candidates by a wide margin before the ranges mean anything.
3. Dense grid 1.1, 1.2, ..., nonnegative weights, relaxation EPS = 1e-7, total weight within 0.2 of each centre:
   L = 1.0, K = 16:   x=1.5 at most 2.4e-3;  x=2 in [0.473, 0.534].
   L = 1.45, K = 24:  x=1.5 at most 1.4e-5;  x=2 in [0.49004, 0.49022];  x=2.5 at most 1.1e-3;
                      x=3 in [0.6299, 0.6387];  x=3.5 at most 0.036.  (13 Newton stalls; treat as lower bounds on widths.)
   L = 2.0, K = 40:   x=1.5 at most 7.0e-6;  x=2 in [0.490084, 0.490154];  x=2.5 at most 4.0e-4;
                      x=3 in [0.6328, 0.6350];  x=3.5 at most 7.8e-3;  x=4 in [0.328, 0.354] (true 0.347).
                      x=5 in [0.660, 0.730] (true 0.720);  x=6 at most 0.012.  (58 Newton stalls; same caveat.)
   So positivity plus nonnegativity locates the prime powers 2, 3, 4 and excludes weight at 1.5, 2.5, 3.5, with
   accuracy that improves as the support grows and degrades toward e^L."""
import numpy as np, sys, time
import weil_form as weil
L, K = float(sys.argv[1]), int(sys.argv[2])
arg = sys.argv[3]
if arg.startswith("grid:"):
    lo, hi, h = [float(v) for v in arg[5:].split(":")]; xs = list(np.round(np.arange(lo, hi + 1e-9, h), 6))
else: xs = [float(v) for v in arg.split(",")]
NONNEG = len(sys.argv) > 4 and sys.argv[4] == "nonneg"
EPS = float(sys.argv[6]) if len(sys.argv) > 6 else 0.0      # relaxation: eigenvalues >= -EPS, weights >= -EPS
MU_END = max(EPS * 1e-3, 1e-12) if EPS else 1e-9
idx, pole, arch, _ = weil.matrices(L, K)
Q0 = pole + arch; Q0 = (Q0 + Q0.conj().T) / 2
n = len(idx); m = len(xs); Bs = []
for x in xs:
    u = np.log(x); B = np.zeros((n, n), dtype=complex)
    for a, j in enumerate(idx):
        for b, k in enumerate(idx):
            A = weil.A_fun(j, k, L); B[a, b] = A(u) + A(-u)
    Bs.append((B + B.conj().T) / 2)
Bs = np.array(Bs)
def truth(x):
    r = round(x)
    if abs(x - r) > 1e-9 or r < 2: return 0.0
    for p in range(2, r + 1):
        if all(p % d for d in range(2, int(p**0.5) + 1)):
            q = p
            while q < r: q *= p
            if q == r: return float(np.log(p) / np.sqrt(r))
    return 0.0
ctrue = np.array([truth(x) for x in xs])
Mof = lambda c, s=0.0: Q0 + (s + EPS) * np.eye(n) - np.tensordot(c, Bs, axes=1)
def ok(c, s):
    if NONNEG and c.min() <= -EPS: return False
    try: np.linalg.cholesky(Mof(c, s)); return True
    except np.linalg.LinAlgError: return False
STALLS = [0]
def barrier(obj, c, s, with_s, mu_end=None):
    """follow the central path of  obj.c (+ s)  - mu log det(Q_c + s I) (- mu sum log(c_i + EPS)); damped Newton steps,
    step length 1/(1 + Newton decrement), which keeps a self-concordant barrier feasible and decreasing"""
    mu_end = MU_END if mu_end is None else mu_end
    d = m + (1 if with_s else 0); mu = 1.0
    while mu > mu_end:
        for it in range(400):
            Mi = np.linalg.inv(Mof(c, s)); MB = Mi @ Bs                       # (m, n, n)
            g = np.zeros(d); H = np.zeros((d, d))
            g[:m] = obj + mu * np.trace(MB, axis1=1, axis2=2).real
            H[:m, :m] = mu * np.einsum("iab,jba->ij", MB, MB).real
            if NONNEG: g[:m] -= mu / (c + EPS); H[:m, :m] += np.diag(mu / (c + EPS)**2)
            if with_s:
                g[m] = 1 - mu * np.trace(Mi).real; H[m, m] = mu * np.trace(Mi @ Mi).real
                H[:m, m] = H[m, :m] = -mu * np.einsum("iab,ba->i", MB, Mi).real
            step = np.linalg.lstsq(H, -g, rcond=None)[0]; lam = np.sqrt(max(-g @ step, 0.0) / mu)
            if lam < 1e-5: break
            al = 1.0 if lam < 0.2 else 1.0 / (1.0 + lam)
            while not ok(c + al * step[:m], s + (al * step[m] if with_s else 0.0)):
                al /= 2
                if al < 1e-30: break
            c = c + al * step[:m]
            if with_s: s = s + al * step[m]
        else: STALLS[0] += 1
        mu /= 10 ** 0.5
    return c, s
t0 = time.time()
print(f"L={L} (numbers below {np.exp(L):.2f} can enter), K={K} ({n} test functions), {m} candidates"
      f"{', weights required nonnegative' if NONNEG else ''}")
print(f"smallest eigenvalue at the true weights {np.linalg.eigvalsh(Q0 - np.tensordot(ctrue, Bs, axes=1))[0]:.3e}")
if EPS:
    print(f"relaxed problem: smallest eigenvalue >= -{EPS:g}" + (f", weights >= -{EPS:g}" if NONNEG else ""))
    c0, _ = barrier(np.zeros(m), ctrue.copy(), 0.0, False, 1e-2 * EPS)
else:
    start = np.full(m, 1e-3) if NONNEG else np.zeros(m)
    c0, s0 = barrier(np.zeros(m), start, 2.0, True, 1e-7)
    print(f"largest reachable smallest eigenvalue {-s0:.4e}   ({time.time()-t0:.0f}s)")
    if s0 >= 0: print("no strictly feasible point found at this barrier accuracy; rerun with a relaxation EPS"); sys.exit()
    if -s0 > 1e3: print("the positive semidefinite set is unbounded for this many candidates and test functions; stop"); sys.exit()
WIN = float(sys.argv[5]) if len(sys.argv) > 5 and float(sys.argv[5]) > 0 else None
xa = np.array(xs)
if WIN is None:
    print("   x      | true weight | smallest feasible | largest feasible | width")
    targets = [(f"{x:6.3f}", (np.arange(m) == i).astype(float)) for i, x in enumerate(xs)]
else:
    print(f"   total weight within {WIN} of the centre x, other weights free")
    print("   x      | true weight | smallest feasible | largest feasible | width")
    cs = np.arange(np.ceil(2 * xa.min()) / 2, xa.max() + 1e-9, 0.5)
    targets = [(f"{cx:6.3f}", (np.abs(xa - cx) <= WIN + 1e-9).astype(float)) for cx in cs]
for name, w in targets:
    out = []
    for sign in (1.0, -1.0):
        c, _ = barrier(sign * w, c0.copy(), 0.0, False)
        out.append(w @ c)
    tv = w @ ctrue; tag = "  prime power" if tv > 0 else ""
    if not (out[0] <= tv + 1e-9 and tv - 1e-9 <= out[1]): tag += "  NOT CONVERGED (true value outside the reported range)"
    print(f"   {name} | {tv:11.8f} | {out[0]:17.8f} | {out[1]:16.8f} | {out[1]-out[0]:.3e}{tag}", flush=True)
print(f"({time.time()-t0:.0f}s; Newton stalls: {STALLS[0]})")
