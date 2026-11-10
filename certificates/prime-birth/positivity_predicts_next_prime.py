"""Does positivity force each prime to appear, given the earlier ones?
Start from the pole and archimedean terms of Weil's form and a list of known primes (with all their powers, weights
log p / sqrt(p^k)). Let the support length L grow. Stage 1: find the first L at which the form with only the known
primes has a negative eigenvalue. Stage 2: at a few L past that point, try one extra atom at position x (grid step
0.02) with weight c >= 0 and report, for each x, the best achievable smallest eigenvalue (maximised over c). Positions
where it is >= 0 are the only places a single new atom can sit. Double precision: eigenvalues within 1e-11 of zero are
numerical zeros, and the search stops being reliable once the true form's lowest eigenvalue is below that (L near 2.2).
Usage: python3 positivity_predicts_next_prime.py K known_primes(comma list, 'none', or 'raw:2,3' for no prime powers) Lstart Lend Lstep [signed]

Outcome, 10 November 2026. A computation on 2K+1 test functions with the true pole and archimedean terms. It assumes
nothing about RH and proves nothing about it.
  no primes, K=16:        form positive up to L = 0.75, eigenvalue -0.068 at L = 0.80 (numbers below 2.23).
                          Atom allowed at x in [1.94, 2.08] (L=0.8), {2.00, 2.02} (L=0.9), only 2.00 (L=1.05),
                          weight 0.4900 (log 2/sqrt 2 = 0.49013).
  known 2, K=16:          positive up to L = 1.10, -0.021 at L = 1.15 (below 3.16). Atom allowed only at 3.00 from
                          L = 1.25, weight 0.63428 at L = 1.40 (log 3/sqrt 3 = 0.63428).
  atoms 2, 3, no powers:  positive up to L = 1.40, -0.021 at L = 1.45 (below 4.26). Atom allowed only at 4.00,
                          weight 0.34657 (log 2/2 = 0.34657). So the prime power 4 is forced with the weight of 2.
  known 2, 3, K=20:       positive up to L = 1.60, -0.029 at L = 1.65 (below 5.21). Only 5.00, weight 0.71976
                          (log 5/sqrt 5 = 0.71976).
  known 2, 3, 5, K=24:    numerically zero through L = 1.95 (below 7.03), so nothing is needed at 6;
                          -0.126 at L = 2.00. Only 7.00, weight 0.73548 (log 7/sqrt 7 = 0.73548).
With signed weights a second family appears: a negative atom at x between 1.02 and 1.24 also restores positivity in the
first stage. Negative mass near x = 1 acts like adding a multiple of the identity, so it always helps.
Why this is plausible (a sketch, conditional on RH, not a proof): if RH holds the form is sum |gh(gamma)|^2 over the
zeros. A change of the prime measure by a signed measure d changes the form by minus the cosine transform of d. In the
limit of long support, positivity then needs that cosine transform to be <= 0 everywhere, so -d is positive definite
and must have its largest mass at lag 0, that is at x = 1, where no prime power lives. The finite-L computation shows
how fast this rigidity sets in.
"""
import numpy as np, sys
from scipy.optimize import minimize_scalar
import weil_form as weil
K = int(sys.argv[1]); spec = sys.argv[2]
POWERS = not spec.startswith("raw:")                     # "raw:2,3" = atoms at 2 and 3 only, no prime powers added
spec = spec[4:] if not POWERS else spec
known = [] if spec == "none" else [int(v) for v in spec.split(",")]
Ls = np.arange(float(sys.argv[3]), float(sys.argv[4]) + 1e-9, float(sys.argv[5]))
TOL = 1e-11
CLO = -3.0 if (len(sys.argv) > 6 and sys.argv[6] == 'signed') else 0.0      # new atom's weight: nonnegative unless 'signed'
def atom(idx, L, x):
    n = len(idx); u = np.log(x); B = np.zeros((n, n), dtype=complex)
    for a, j in enumerate(idx):
        for b, k in enumerate(idx):
            A = weil.A_fun(j, k, L); B[a, b] = A(u) + A(-u)
    return (B + B.conj().T) / 2
def base(L):
    idx, pole, arch, _ = weil.matrices(L, K); Q = pole + arch; Q = (Q + Q.conj().T) / 2
    for p in known:
        q = p
        while np.log(q) < L:
            Q = Q - np.log(p) / np.sqrt(q) * atom(idx, L, q); q *= p
            if not POWERS: break
    return idx, Q
print(f"known primes {known}{' with their powers' if POWERS else ', no powers included'}, K={K}")
first = None
for L in Ls:
    idx, Q = base(L); lam = np.linalg.eigvalsh(Q)[0]
    print(f"  L={L:.3f} (numbers below {np.exp(L):.3f}): smallest eigenvalue with the known primes only {lam:+.3e}")
    if lam < -TOL and first is None: first = L
if first is None: print("no negative eigenvalue in this range"); sys.exit()
print(f"first negative at L={first:.3f}: without a new atom, positivity fails once numbers below {np.exp(first):.3f} are allowed")
for L in [first, first + 0.1, first + 0.25, first + 0.4]:
    idx, Q = base(L); lo = max(known) + 0.02 if known else 1.02
    xs = np.arange(np.ceil(lo * 50) / 50, np.exp(L) - 1e-9, 0.02); best = []
    for x in xs:
        B = atom(idx, L, x)
        r = minimize_scalar(lambda c: -np.linalg.eigvalsh(Q - c * B)[0], bounds=(CLO, 3), method="bounded", options={"xatol": 1e-12})
        best.append((-r.fun, r.x))
    lam = np.array([b[0] for b in best]); cs = np.array([b[1] for b in best]); okx = xs[lam > -TOL]
    i = int(np.argmax(lam))
    print(f"  L={L:.3f}: one new atom restores positivity for x in " + (f"[{okx.min():.2f}, {okx.max():.2f}] ({len(okx)} grid points)" if len(okx) else "NO position")
          + f";  best x={xs[i]:.2f}, weight {cs[i]:.5f}, eigenvalue {lam[i]:+.2e};  log(p)/sqrt(p) at the nearest integer {np.log(round(xs[i]))/np.sqrt(round(xs[i])):.5f}")
    if len(okx): print("     weights along the allowed positions: " + " ".join(f"{x:.2f}:{c:.4f}" for x, c, l in zip(xs, cs, lam) if l > -TOL)[:400])
