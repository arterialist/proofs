"""Lower bound for the conductor of an admissible system by degree, with iterative refinement of the linear program.
Same problem as xi_kernel_conductor_lp.py:  min B(w) = 2 sum Lambda(n) n^(-1/2) h_w(log n)  with h_w(0) = 1,
w >= 0 on a t grid and h_w >= 0 on a u grid (step 0.004 plus the points log n) in [log x0, UMAX].
After a double-precision solve the residuals are recomputed at 50 digits and the same LP is solved again in shifted,
rescaled variables a = a_k + delta * y, which is an exact reformulation; a few rounds remove the solver's tolerance.
The sign of h_w is not checked between grid points or beyond UMAX: computations, not certified bounds.
Usage: python3 xi_kernel_conductor_lp_refined.py kern_mp_D24.pkl 1.05 3.2      (table from `python3 xi_kernel_table.py 24`)

Outcome, 10 November 2026. Degree of w : B(w)   (smallest grid value of h/h(0) at most 1e-17 in absolute value, min w = +2.3)
    8: 3.70424e-4    12: 4.588e-5    16: 3.52037e-6    20: 4.24732e-8    24: 1.62117e-9    28: 1.28003e-10    32: 1.0005e-12
These agree with the vertex-recomputed values of xi_kernel_conductor_lp.py through degree 28. Degree 36 failed and at
degree 40 the weight w went negative (-2e-3), so those are not reported.
"""
import mpmath as mp, numpy as np, pickle, sys
from scipy.optimize import linprog
mp.mp.dps = 50
T = pickle.load(open(sys.argv[1], "rb")); Dmax = T["D"]; us = T["us"]; K = T["K"]; PP = T["PP"]
x0 = float(sys.argv[2]); UMAX = float(sys.argv[3])
Pt = np.array(T["P_on_t"]); tt = np.arange(Pt.shape[1]) * 0.1; tm = tt <= 70.0
ug = [u for u in us if mp.log(x0) <= u <= UMAX]
def solve(D, rounds=6):
    n = D + 1
    rows = [[K[u][k] for k in range(n)] for u in ug] + [[mp.mpf(float(x)) for x in Pt[:n, j]] for j in np.nonzero(tm)[0]]
    sc = [max(abs(x) for x in r) for r in rows]
    A = np.array([[float(x / s) for x in r] for r, s in zip(rows, sc)])            # rows scaled, constraint A a >= 0
    c_mp = [2 * mp.fsum(w * K[mp.log(nn)][k] for nn, w in PP) for k in range(n)]; cs = max(abs(x) for x in c_mp)
    c = np.array([float(x / cs) for x in c_mp]); K0 = [K[mp.mpf(0)][k] for k in range(n)]; e = np.array([[float(x) for x in K0]])
    opts = {"primal_feasibility_tolerance": 1e-10, "dual_feasibility_tolerance": 1e-10}
    r = linprog(c, A_ub=-A, b_ub=np.zeros(len(rows)), A_eq=e, b_eq=[1.0], bounds=[(None, None)] * n, method="highs-ds", options=opts)
    if r.status != 0: return None
    a = [mp.mpf(float(x)) for x in r.x]
    for it in range(rounds):
        slack = [mp.fsum(rw[k] * a[k] for k in range(n)) / s for rw, s in zip(rows, sc)]          # should be >= 0
        eqres = 1 - mp.fsum(K0[k] * a[k] for k in range(n))
        viol = max([mp.mpf(0)] + [-x for x in slack] + [abs(eqres)])
        delta = max(viol, mp.mpf(10) ** -40) * 100
        # y: A y >= -slack/delta, e.y = eqres/delta, minimise c.y
        bub = np.array([float(min(x / delta, mp.mpf(10) ** 12)) for x in slack])
        r = linprog(c, A_ub=-A, b_ub=bub, A_eq=e, b_eq=[float(eqres / delta)], bounds=[(None, None)] * n, method="highs-ds", options=opts)
        if r.status != 0: break
        a = [a[k] + delta * mp.mpf(float(r.x[k])) for k in range(n)]
        if viol < mp.mpf(10) ** -38: break
    h = lambda u: mp.fsum(a[k] * K[u][k] for k in range(n))
    h0 = h(mp.mpf(0)); B = mp.fsum(a[k] * c_mp[k] for k in range(n)) / h0
    hv = [h(u) / h0 for u in ug]; wv = Pt[:n, tm].T @ np.array([float(x) for x in a])
    touch = [float(mp.exp(ug[i])) for i in range(1, len(ug) - 1) if hv[i] <= hv[i - 1] and hv[i] <= hv[i + 1] and abs(hv[i]) < mp.mpf(10) ** -12 * max(hv[i - 1], hv[i + 1]) * 1e6 and ug[i] < 3.0]
    return B, a, min(hv), wv.min(), touch
if __name__ == "__main__":
    print(f"x0 = {x0}; kernel >= 0 imposed on the grid in [log x0, {UMAX}]; LP refined at 50 digits")
    for D in range(4, Dmax + 1, 2):
        res = solve(D)
        if res is None: print(f"degree {2*D}: failed"); continue
        B, a, hmin, wmin, touch = res
        print(f"degree {2*D:2d}: B = {mp.nstr(B, 6):>12s};  smallest grid value of h/h(0) = {mp.nstr(hmin, 2):>9s};  min w = {wmin:+.1e}", flush=True)
