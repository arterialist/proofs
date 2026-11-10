"""Lower bound for the conductor of an admissible system, by linear programming over kernels h_w with transform
Xi(t)^2 w(t), w an even polynomial (Corollary 1 of building-blocks/weil-and-spectral/admissible-systems-xi-kernel-comparison.md):
     log(1/q) <= B(w) = 2 sum_n Lambda(n) n^(-1/2) h_w(log n) / h_w(0)      whenever w >= 0 and h_w >= 0 on the support of mu.
The double-precision LP (rows rescaled) finds the active constraints; the vertex they define is then solved at 50 digits
from the kernel table of xi_kernel_table.py, and the bound and every grid constraint are re-evaluated at 50 digits.
The sign of h_w is imposed on a grid (step 0.004 in u, plus the points log n) for log x0 <= u <= UMAX only.
It is not checked between grid points or beyond UMAX, so the printed numbers are computations, not certified bounds.
Usage: python3 xi_kernel_conductor_lp.py kern_mp_D16.pkl x0 UMAX        (for example 1.05 3.2)

Outcome, 10 November 2026, x0 = 1.05, UMAX = 3.2. Degree of w : B(w):
   0: 7.52e-2 (from the double-precision run; here the degree-0 and degree-4 LPs are degenerate)   4: 6.19e-3
   8: 3.70424e-4    12: 4.588e-5    16: 3.52037e-6    20: 4.24727e-8    24: 1.62117e-9    28: 1.28003e-10
In every case the smallest grid value of h_w/h_w(0) is below 1e-50 in absolute value and min w = +2.3.
The kernel vanishes on the grid at pairs of neighbouring points near x = 2, 3, 4, 5, 7, 8, 9 (in that order as the
degree grows). Degree 32 was not resolved by the double-precision solver.
Caveats found in review: at UMAX = 3.2 the degree-0 and degree-4 kernels are below the 1e-50 noise floor of the table
for x above about 20, so those two LPs must be run with UMAX = 2.5 (then B = 0.0751971 and 0.00619232). The fixed grid
lets the kernels dip to about -1e-6 between grid points near u = log 2, so none of these values is a valid bound; see
xi_kernel_conductor_cutting_plane.py for the corrected values, which are 0.1 to 6 percent larger.
"""
import mpmath as mp, numpy as np, pickle, sys
from scipy.optimize import linprog
mp.mp.dps = 50
T = pickle.load(open(sys.argv[1], "rb")); Dmax = T["D"]; us = T["us"]; K = T["K"]; PP = T["PP"]
x0 = float(sys.argv[2]); UMAX = float(sys.argv[3])
Pt = np.array(T["P_on_t"]); tt = np.arange(Pt.shape[1]) * 0.1; tm = tt <= 70.0
ug = [u for u in us if mp.log(x0) <= u <= UMAX]
def solve(D):
    rows = []; scs = []
    for u in ug:
        r = [K[u][k] for k in range(D + 1)]; sc = max(abs(x) for x in r); rows.append([float(x / sc) for x in r]); scs.append(sc)
    obj_mp = [2 * mp.fsum(w * K[mp.log(n)][k] for n, w in PP) for k in range(D + 1)]
    sco = max(abs(x) for x in obj_mp); K0 = [K[mp.mpf(0)][k] for k in range(D + 1)]
    W = Pt[:D + 1, tm].T; Wn = W / np.abs(W).max(axis=1, keepdims=True)
    A_ub = -np.vstack([np.array(rows), Wn]); nu = len(rows)
    r = linprog([float(x / sco) for x in obj_mp], A_ub=A_ub, b_ub=np.zeros(A_ub.shape[0]), A_eq=np.array([[float(x) for x in K0]]), b_eq=[1.0],
                bounds=[(None, None)] * (D + 1), method="highs-ds", options={"primal_feasibility_tolerance": 1e-10, "dual_feasibility_tolerance": 1e-10})
    if r.status != 0: return None
    act = np.argsort(r.slack)[:D]                                     # D active inequality rows + the normalisation = D+1 equations
    if (act >= nu).any(): tag = "w-active"
    else: tag = ""
    A = mp.matrix(D + 1, D + 1); b = mp.matrix(D + 1, 1); A[0, :] = mp.matrix([K0]); b[0] = 1
    for i, j in enumerate(act):
        if j < nu: A[i + 1, :] = mp.matrix([[K[ug[j]][k] / scs[j] for k in range(D + 1)]])
        else: A[i + 1, :] = mp.matrix([[mp.mpf(float(x)) for x in Wn[j - nu]]])
    try: a = mp.lu_solve(A, b)
    except ZeroDivisionError: return None
    a = [a[k] for k in range(D + 1)]
    h = lambda u: mp.fsum(a[k] * K[u][k] for k in range(D + 1))
    B = mp.fsum(a[k] * obj_mp[k] for k in range(D + 1))
    hv = [h(u) for u in ug]; hmin = min(hv); wv = W @ np.array([float(x) for x in a])
    touch = sorted(float(mp.exp(ug[j])) for j in act if j < nu)
    return B, a, hmin, wv.min(), touch, tag
if __name__ == "__main__":
    print(f"x0 = {x0}; kernel >= 0 imposed on the grid in [log x0, {UMAX}]")
    for D in range(0, Dmax + 1, 2):
        res = solve(D)
        if res is None: print(f"degree {2*D}: failed"); continue
        B, a, hmin, wmin, touch, tag = res
        print(f"degree {2*D:2d}: B = {mp.nstr(B, 6):>12s};  smallest grid value of h/h(0) = {mp.nstr(hmin, 3):>10s};  min w = {wmin:+.1e};  kernel vanishes at x = {np.round(touch, 3)} {tag}", flush=True)
