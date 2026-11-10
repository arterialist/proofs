"""Ranges for the linear program of explicit_formula_double_positivity_lp.py (zeta data).
First solve for the minimal tolerance s*. Then fix the tolerance at FACTOR * s* and compute, over ALL solutions of the
constraints, the smallest and largest mass the zero side can put in some windows of t and the prime side in some
windows of x = e^u. Narrow ranges mean the constraints pin the solution; wide ranges mean they do not.
Usage: python3 explicit_formula_double_positivity_lp_ranges.py T dt U du XLOW FACTOR      (each window is two LPs; slow)

Outcome, 10 November 2026: T=200, dt=0.04, U=2.5, du=0.005, XLOW=1.5, FACTOR=2 (s* = 2.4e-4).
zero side, window: smallest to largest mass (true):
   [0, 13): 0 to 0.054 (0);  [13.6, 14.6): 0.522 to 1.008 (1);  [15.2, 20): 0 to 0.559 (0);  [20.5, 21.5): 0 to 1.082 (1);
   [22, 24.3): 0 to 1.378 (0);  [24.5, 25.5): 0 to 1.092 (1);  [26, 29.8): 0 to 1.331 (0);  [29.9, 30.9): 0 to 1.387 (1).
prime side: [1.9, 2.1): 0.447 to 0.494 (0.490);  [2.2, 2.8): 0 to 0.129 (0). The later prime windows had not finished
after 10 more minutes and were not recorded.
"""
import numpy as np, sys, time
from scipy.optimize import linprog
from scipy.special import digamma
T, dt, U, du, XLOW, FACTOR = float(sys.argv[1]), float(sys.argv[2]), float(sys.argv[3]), float(sys.argv[4]), float(sys.argv[5]), float(sys.argv[6])
N = lambda t: -0.5 * digamma(0.25 + 0.5j * t).real + 0.5 * np.log(np.pi) - 0.5 / (0.25 + t * t)
tg = np.arange(dt / 2, T, dt); Ng = N(tg); ug = np.arange(du, U + 1e-9, du); nt, nu = len(tg), len(ug)
A = (2 / np.pi) * np.cos(np.outer(ug, tg)) * dt; low = ug < np.log(XLOW); t0 = time.time()
A1 = np.vstack([np.hstack([A, -np.ones((nu, 1))]), np.hstack([-A[low], -np.ones((low.sum(), 1))])]); b1 = np.concatenate([np.exp(ug / 2), -np.exp(ug[low] / 2)])
c = np.zeros(nt + 1); c[-1] = 1.0
r = linprog(c, A_ub=A1, b_ub=b1, bounds=[(Ng[j], None) for j in range(nt)] + [(None, None)], method="highs"); s0 = r.x[-1]
print(f"T={T} U={U} x0={XLOW}: minimal tolerance s* = {s0:.2e}; ranges at tolerance {FACTOR} s*   ({time.time()-t0:.0f}s)")
S = FACTOR * s0
A2 = np.vstack([A, -A[low]]); b2 = np.concatenate([np.exp(ug / 2) + S, -np.exp(ug[low] / 2) + S]); bnd = [(Ng[j], None) for j in range(nt)]
def rng(cvec, const=0.0):
    out = []
    for sign in (1, -1):
        r = linprog(sign * cvec, A_ub=A2, b_ub=b2, bounds=bnd, method="highs")
        out.append(sign * r.fun + const if r.status == 0 else (float("-inf") if sign == 1 else float("inf")))
    return out
print("zero side: mass in a window of t (true value)")
for a, b, true in [(0, 13.0, 0), (13.6, 14.6, 1), (15.2, 20.0, 0), (20.5, 21.5, 1), (22.0, 24.3, 0), (24.5, 25.5, 1), (26.0, 29.8, 0), (29.9, 30.9, 1)]:
    w = ((tg >= a) & (tg < b)).astype(float) * dt / np.pi               # mass = sum (x - N) dt/pi
    lo, hi = rng(w, -(w * Ng).sum())
    print(f"   [{a:5.1f}, {b:5.1f}): {lo:7.3f} to {hi:7.3f}   ({true})   ({time.time()-t0:.0f}s)", flush=True)
print("prime side: mass in a window of x = e^u (true value)")
for a, b, true in [(1.9, 2.1, 0.490), (2.2, 2.8, 0.0), (2.9, 3.1, 0.634), (3.2, 3.8, 0.0), (3.85, 4.15, 0.347), (4.8, 5.2, 0.720), (5.6, 6.4, 0.0)]:
    m = (ug >= np.log(a)) & (ug < np.log(b))
    w = -(A[m].sum(axis=0)) * du                                         # mass = sum (e^{u/2} - omega(u)) du
    lo, hi = rng(w, (np.exp(ug[m] / 2)).sum() * du)
    print(f"   [{a:4.2f}, {b:4.2f}): {lo:7.3f} to {hi:7.3f}   ({true})   ({time.time()-t0:.0f}s)", flush=True)
