"""The smallest nonnegative measure that keeps Weil's form positive.
Unknown weights c_i >= 0 on a fine grid of positions x_i below e^L. Among all weight vectors for which
Q_c = pole + archimedean - sum_i c_i (A(log x_i) + A(-log x_i)) has smallest eigenvalue >= -EPS on the 2K+1 test
functions, find the one with the smallest total weight sum_i c_i. This is a convex problem, so its solution does not
depend on the starting point (the true weights are used as the starting point of the interior-point method).
The script prints where the mass of the solution sits. The grid contains the integers but nothing marks them.
Usage: python3 positivity_minimum_mass.py L K grid:lo:hi:step EPS

Outcome, 10 November 2026: L = 1.7 (numbers below 5.47), K = 34, grid 1.06, 1.08, ..., 5.46 (221 positions),
EPS = 1e-7, 81 seconds, 9 Newton stalls. Minimum total weight 1.957 (the true measure has 2.191, so the true measure is
feasible but is not the minimiser). Positions with weight above 0.1: exactly 2.00, 3.00, 4.00, 5.00, with weights
0.4886, 0.6098, 0.2576, 0.3770 (true 0.4901, 0.6343, 0.3466, 0.7198). The remaining 0.22 is spread over 31 positions,
the largest 0.05 at 4.34. The weights are biased low and get worse toward e^L, where the constraint is loose and the
objective rewards removing mass. A computation on finitely many test functions. It proves nothing about RH."""
import numpy as np, sys, time
import weil_form as weil
L, K = float(sys.argv[1]), int(sys.argv[2])
arg = sys.argv[3]
if arg.startswith("grid:"):
    lo, hi, h = [float(v) for v in arg[5:].split(":")]; xs = list(np.round(np.arange(lo, hi + 1e-9, h), 6))
else: xs = [float(v) for v in arg.split(",")]
NONNEG = True
EPS = float(sys.argv[4])      # relaxation: eigenvalues >= -EPS, weights >= -EPS
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
            H[:m, :m] = mu * (MB.reshape(m, -1) @ MB.transpose(0, 2, 1).reshape(m, -1).T).real
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
xa = np.array(xs)
c, _ = barrier(np.ones(m), c0.copy(), 0.0, False)
lam = np.linalg.eigvalsh(Q0 - np.tensordot(c, Bs, axes=1))[0]
print(f"minimum total weight {c.sum():.6f}  (true total {ctrue.sum():.6f});  smallest eigenvalue at the solution {lam:+.2e};  Newton stalls {STALLS[0]}  ({time.time()-t0:.0f}s)")
print("grid points carrying weight above 1e-4:   x : weight found   [true weight at x]")
for x, ci, ti in zip(xa, c, ctrue):
    if ci > 1e-4 or ti > 0: print(f"   {x:6.3f} : {ci:.6f}   [{ti:.6f}]")
print(f"total weight on all other grid points: {c[(c <= 1e-4) & (ctrue == 0)].sum():.2e};  largest single one: {c[(c <= 1e-4) & (ctrue == 0)].max():.2e}")
