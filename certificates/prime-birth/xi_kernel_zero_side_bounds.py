"""Upper bounds for the zero measure of any admissible system of conductor 1 on intervals of t without zeta zeros
(section 5.4 of building-blocks/weil-and-spectral/admissible-systems-xi-kernel-comparison.md).
Corollary 3: if w >= 0, h_w >= 0 on the support of mu, and Xi(t)^2 w(t) >= 1 on I, then
     m(I) <= int w Xi^2 dm <= 2 int h_w dmu_Lambda.
LP over even polynomials w of degree 2D; sign conditions on grids (u up to U with step 0.004, t with step 0.1 up to 70);
each vertex is recomputed at 50 digits. The printed numbers are computations, not certified bounds.
Usage: python3 xi_kernel_zero_side_bounds.py kern_mp_D16.pkl x0 U D1 D        (for example 1.05 3.2 14 14)

Outcome, 10 November 2026, x0 = 1.05, U = 3.2, degree 28. Upper bound for m(I); every interval contains no zeta zero
(the first zeros are at 14.1347, 21.0220, 25.0109, 30.4249); constraint violations below 1e-40.
   [0, 5]: 4.1e-10      [0, 10]: 3.4e-9      [0, 12]: 2.2e-8      [0, 13]: 1.1e-7      [0, 13.9]: 3.8e-6
   [14.4, 15]: 3.8e-6   [15, 20]: 4.3e-6     [15, 20.8]: 1.4e-4   [21.3, 24.8]: 1.2e-3   [22, 24]: 4.6e-5
   [25.3, 30.2]: 1.2e-2   [26, 29]: 2.9e-4
"""
import mpmath as mp, numpy as np, sys
import xi_kernel_window_bounds as Wd
mp.mp.dps = 50
K, ug, PP, Pt, tm, D = Wd.K, Wd.ug, Wd.PP, Wd.Pt, Wd.tm, Wd.D
tt = np.arange(Pt.shape[1]) * 0.1
xi = lambda s: mp.mpf(0.5) * s * (s - 1) * mp.pi ** (-s / 2) * mp.gamma(s / 2) * mp.zeta(s)
xi2_on = [mp.re(xi(mp.mpc(0.5, float(t)))) ** 2 if ok else None for t, ok in zip(tt, tm)]
V = Pt[:D + 1, :].T
objK = [2 * mp.fsum(w * K[mp.log(n)][k] for n, w in PP) for k in range(D + 1)]
def bound(lo, hi):
    rows = []; rhs = []
    for u in ug: rows.append([-K[u][k] for k in range(D + 1)]); rhs.append(mp.mpf(0))
    for j in np.nonzero(tm)[0]:
        rows.append([mp.mpf(-float(x)) for x in V[j]]); rhs.append(-1 / xi2_on[j] if lo <= tt[j] <= hi else mp.mpf(0))
    return Wd.polished(objK, rows, rhs, D + 1)
if __name__ == "__main__":
    print(f"kernels of degree {2*D}; upper bounds for the zero-measure mass of any admissible system of conductor 1")
    for lo, hi in [(0, 5), (0, 10), (0, 12), (0, 13), (0, 13.9), (14.4, 15), (15, 20), (15, 20.8), (21.3, 24.8), (22, 24), (25.3, 30.2), (26, 29)]:
        r = bound(lo, hi)
        print(f"   [{lo:5.1f}, {hi:5.1f}]: " + ("failed" if r is None else f"{mp.nstr(r[0], 5):>12s}   (largest constraint violation {mp.nstr(r[1], 1)})"), flush=True)
