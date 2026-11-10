"""Lower bound for the conductor of an admissible system by degree, as a semi-infinite linear program solved by cutting
planes (section 5.2 of building-blocks/weil-and-spectral/admissible-systems-xi-kernel-comparison.md).
Constraints h_w(u) >= 0 start on the grid of the kernel table. After each solve (refined at 50 digits) the kernel is
evaluated between neighbouring constraint points wherever it is small, and the most negative points are added as new
constraints. It stops when no sampled value is below -1e-3 * B. This removes the dips between grid points that a
fixed grid allows, which xi_kernel_conductor_certificate.py found in a degree-12 kernel. The sign of h_w beyond UMAX
is still not checked, and the final kernels still have sampled values as low as -1e-3 * B, so these are computations
and not certified bounds.
Usage: python3 xi_kernel_conductor_cutting_plane.py kern_mp_D24.pkl 1.05 3.2 4,6,8,10,12,14,16 [v]

Outcome, 10 November 2026, x0 = 1.05, UMAX = 3.2. Degree of w : B(w)   (fixed-grid value in brackets)
    8: 3.70702e-4 (3.70424e-4)    12: 4.6451e-5 (4.588e-5)    16: 3.58819e-6 (3.52037e-6)    20: 4.43806e-8 (4.24732e-8)
   24: 1.70447e-9 (1.62117e-9)    28: 1.35252e-10 (1.28003e-10)    32: 1.07683e-12 (1.0005e-12)
min w = +2.3 on the t grid in every case. About 3 minutes for degree 32.
"""
import mpmath as mp, numpy as np, pickle, sys, time
from scipy.optimize import linprog
import xi_kernel_fine as kfine
mp.mp.dps = 50
path = sys.argv[1]; x0 = float(sys.argv[2]); UMAX = float(sys.argv[3])
F = kfine.Fine(path); T = F.T; Dmax = T["D"]; us = T["us"]; Ktab = T["K"]; PP = T["PP"]
Pt = np.array(T["P_on_t"]); tt = np.arange(Pt.shape[1]) * 0.1; tm = tt <= 70.0
OPTS = {"primal_feasibility_tolerance": 1e-10, "dual_feasibility_tolerance": 1e-10}
cache = {}
def Kat(u):
    if u in Ktab: return Ktab[u]
    if u not in cache: cache[u] = F.K(u)
    return cache[u]
def lp(D, pts, rounds=6):
    n = D + 1
    rows = [Kat(u)[:n] for u in pts] + [[mp.mpf(float(x)) for x in Pt[:n, j]] for j in np.nonzero(tm)[0]]
    sc = [max(abs(x) for x in r) for r in rows]
    A = np.array([[float(x / s) for x in r] for r, s in zip(rows, sc)])
    c_mp = [2 * mp.fsum(w * Ktab[mp.log(nn)][k] for nn, w in PP) for k in range(n)]; cs = max(abs(x) for x in c_mp)
    c = np.array([float(x / cs) for x in c_mp]); K0 = Ktab[mp.mpf(0)][:n]; e = np.array([[float(x) for x in K0]])
    r = linprog(c, A_ub=-A, b_ub=np.zeros(len(rows)), A_eq=e, b_eq=[1.0], bounds=[(None, None)] * n, method="highs-ds", options=OPTS)
    if r.status != 0: return None
    a = [mp.mpf(float(x)) for x in r.x]
    for it in range(rounds):
        slack = [mp.fsum(rw[k] * a[k] for k in range(n)) / s for rw, s in zip(rows, sc)]
        eqres = 1 - mp.fsum(K0[k] * a[k] for k in range(n))
        viol = max([mp.mpf(0)] + [-x for x in slack] + [abs(eqres)])
        if viol < mp.mpf(10) ** -38 and it > 0: break
        delta = max(viol, mp.mpf(10) ** -40) * 100
        r = linprog(c, A_ub=-A, b_ub=np.array([float(min(x / delta, mp.mpf(10) ** 12)) for x in slack]), A_eq=e, b_eq=[float(eqres / delta)],
                    bounds=[(None, None)] * n, method="highs-ds", options=OPTS)
        if r.status != 0: break
        a = [a[k] + delta * mp.mpf(float(r.x[k])) for k in range(n)]
    B = mp.fsum(a[k] * c_mp[k] for k in range(n)) / mp.fsum(a[k] * K0[k] for k in range(n))
    wmin = (Pt[:n, tm].T @ np.array([float(x) for x in a])).min()
    return B, a, wmin
def solve(D, TOL=mp.mpf("1e-3"), maxit=40, verbose=False):
    n = D + 1; pts = sorted(u for u in us if mp.log(x0) <= u <= UMAX)
    h = lambda a, u: mp.fsum(a[k] * kk for k, kk in enumerate(Kat(u)[:n]))
    for it in range(maxit):
        res = lp(D, pts)
        if res is None: return None
        B, a, wmin = res; h0 = h(a, mp.mpf(0)); vals = [h(a, u) / h0 for u in pts]
        # cells where the kernel is small compared with its neighbourhood: sample inside
        new = []; worst = mp.mpf(0)
        for i in range(len(pts) - 1):
            lo, hi = pts[i], pts[i + 1]
            if hi - lo < mp.mpf(10) ** -9: continue
            ref = max(vals[max(i - 12, 0)], vals[min(i + 13, len(pts) - 1)], mp.mpf(10) ** -60)
            if min(vals[i], vals[i + 1]) < ref * mp.mpf("0.02"):
                best = (mp.mpf(0), None)
                for f in (mp.mpf(1) / 4, mp.mpf(1) / 2, mp.mpf(3) / 4):
                    u = lo + f * (hi - lo); v = h(a, u) / h0
                    if v < best[0]: best = (v, u)
                if best[1] is not None:
                    new.append(best[1]); worst = min(worst, best[0])
        if verbose: print(f"      iteration {it}: B = {mp.nstr(B, 6)}, {len(new)} new points, worst sampled value {mp.nstr(worst, 3)}, min w {wmin:+.1e}", flush=True)
        if not new or -worst < TOL * abs(B): return B, a, wmin, worst, it, len(pts)
        pts = sorted(set(pts) | set(new))
    return B, a, wmin, worst, maxit, len(pts)
if __name__ == "__main__":
    t0 = time.time()
    print(f"x0 = {x0}; kernel >= 0 on [log x0, {UMAX}], enforced by cutting planes; stop when the worst sampled value is above -1e-3 * B")
    for D in [int(v) for v in sys.argv[4].split(",")]:
        res = solve(D, verbose=len(sys.argv) > 5)
        if res is None: print(f"degree {2*D}: LP failed"); continue
        B, a, wmin, worst, it, npts = res
        print(f"degree {2*D:2d}: B = {mp.nstr(B, 6):>12s};  worst sampled value of h/h(0) {mp.nstr(worst, 2):>9s};  min w = {wmin:+.1e};  {it} rounds, {npts} constraint points   ({time.time()-t0:.0f}s)", flush=True)
