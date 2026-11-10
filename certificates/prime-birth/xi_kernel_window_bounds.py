"""Two-sided bounds for the prime measure of any admissible system of conductor 1 on windows of x = e^u
(section 5.3 of building-blocks/weil-and-spectral/admissible-systems-xi-kernel-comparison.md).
Kernels with transform Xi^2 * (even polynomial). 50-digit kernel table; each LP vertex is recomputed at 50 digits.
Upper bound on mu(J):  min int h_w dmu_Lambda   s.t.  w >= 0,  h_w >= 1 on J,  h_w >= 0 on the rest of [log x0, U].
Lower bound on mu(J):  max int h_v dmu_Lambda - kappa beta1/2   s.t.  |v| <= kappa w1,  h_v <= 1 on J,  h_v <= 0 on the rest,
with w1 the conductor-bound kernel of degree 2*D1 and beta1 = 2 int h_{w1} dmu_Lambda >= int Xi^2 w1 dm.
Constraints are imposed on a grid (step 0.004 in u, plus the points log n) up to u = U only, so the printed numbers
are computations, not certified bounds.
Usage: python3 xi_kernel_window_bounds.py kern_mp_D16.pkl x0 U D1 D        (for example 1.05 3.2 14 14)

Outcome, 10 November 2026, x0 = 1.05, U = 3.2, D1 = D = 14 (degree 28), certificate B1 = 1.28003e-10.
   window          true mass    lower bound    upper bound      (largest constraint violation below 1e-40 in every row)
   [1.05, 1.90]    0            0              2.75e-8
   [1.90, 2.10]    0.4901291    0.490128941    0.490129082
   [1.99, 2.01]    0.4901291    0.490122137    0.49012908
   [2.10, 2.90]    0            0              1.78e-6
   [2.90, 3.10]    0.6342841    0.634277598    0.634284453
   [3.10, 3.90]    0            0              4.31e-5
   [3.90, 4.10]    0.3465736    0.346435238    0.346579324
   [4.10, 4.90]    0            0              4.02e-4
   [4.90, 5.10]    0.7197625    0.718818225    0.719783836
   [5.10, 6.90]    0            0              0.0478
   [6.90, 7.10]    0.7354849    0.563698991    0.751548127
   [7.10, 7.90]    0            0              0.1645
   [7.90, 8.10]    0.2450645    0              0.2889
"""
import mpmath as mp, numpy as np, sys
from scipy.optimize import linprog
import xi_kernel_conductor_lp as C
mp.mp.dps = 50
K, ug, PP, Pt, tm, x0, UMAX = C.K, C.ug, C.PP, C.Pt, C.tm, C.x0, C.UMAX
D1 = int(sys.argv[4]); D = int(sys.argv[5])
B1, a1, hmin1, wmin1, touch1, tag1 = C.solve(D1)
beta1 = B1                                                # h1(0) = 1
print(f"certificate kernel: degree {2*D1}, B1 = {mp.nstr(B1, 6)}, smallest grid value {mp.nstr(hmin1, 2)}")
a1f = np.array([float(x) for x in a1]); w1 = Pt[:D1 + 1, tm].T @ a1f
V = Pt[:D + 1, tm].T
objK = [mp.fsum(w * K[mp.log(n)][k] for n, w in PP) for k in range(D + 1)]
def polished(c_mp, rows_mp, rhs_mp, nvar):
    """min c.x s.t. rows.x <= rhs; LP in double on rescaled rows, vertex re-solved in high precision"""
    sc = [max(abs(x) for x in r) for r in rows_mp]
    A = np.array([[float(x / s) for x in r] for r, s in zip(rows_mp, sc)]); b = np.array([float(x / s) for x, s in zip(rhs_mp, sc)])
    cs = max(abs(x) for x in c_mp)
    r = linprog([float(x / cs) for x in c_mp], A_ub=A, b_ub=b, bounds=[(None, None)] * nvar, method="highs-ds",
                options={"primal_feasibility_tolerance": 1e-10, "dual_feasibility_tolerance": 1e-10})
    if r.status != 0: return None
    act = np.argsort(r.slack)[:nvar]
    M = mp.matrix(nvar, nvar); y = mp.matrix(nvar, 1)
    for i, j in enumerate(act):
        for k in range(nvar): M[i, k] = rows_mp[j][k] / sc[j]
        y[i] = rhs_mp[j] / sc[j]
    try:
        x = mp.lu_solve(M, y); x = [x[k] for k in range(nvar)]
    except Exception:
        x = [mp.mpf(float(v)) for v in r.x]                       # degenerate vertex: keep the double-precision solution
    viol = max((mp.fsum(rw[k] * x[k] for k in range(nvar)) - rh) / s for rw, rh, s in zip(rows_mp, rhs_mp, sc))
    return mp.fsum(c_mp[k] * x[k] for k in range(nvar)), viol, x
def upper(lo, hi):
    rows = []; rhs = []
    for u in ug:
        rows.append([-K[u][k] for k in range(D + 1)]); rhs.append(mp.mpf(-1) if mp.log(lo) <= u <= mp.log(hi) else mp.mpf(0))
    for j in range(V.shape[0]): rows.append([mp.mpf(-float(x)) for x in V[j]]); rhs.append(mp.mpf(0))
    return polished(objK, rows, rhs, D + 1)
def lower(lo, hi):
    rows = []; rhs = []
    for u in ug:
        rows.append([K[u][k] for k in range(D + 1)] + [mp.mpf(0)]); rhs.append(mp.mpf(1) if mp.log(lo) <= u <= mp.log(hi) else mp.mpf(0))
    for j in range(V.shape[0]):
        rows.append([mp.mpf(float(x)) for x in V[j]] + [mp.mpf(-float(w1[j]))]); rhs.append(mp.mpf(0))
        rows.append([mp.mpf(-float(x)) for x in V[j]] + [mp.mpf(-float(w1[j]))]); rhs.append(mp.mpf(0))
    res = polished([-x for x in objK] + [beta1 / 2], rows, rhs, D + 2)
    return None if res is None else (-res[0], res[1], res[2])
def truth(lo, hi): return sum(float(w) for n, w in PP if lo <= n <= hi)
print(f"windows of x; kernels of degree {2*D}; prime measure assumed supported in x >= {x0}; kernel signs imposed on a grid up to x = {float(mp.exp(UMAX)):.1f}")
print("   window        | true mass  | lower bound  (violation) | upper bound  (violation)")
for lo, hi in [(x0, 1.9), (1.9, 2.1), (1.99, 2.01), (2.1, 2.9), (2.9, 3.1), (3.1, 3.9), (3.9, 4.1), (4.1, 4.9), (4.9, 5.1), (5.1, 6.9), (6.9, 7.1), (7.1, 7.9), (7.9, 8.1)]:
    lb = lower(lo, hi); ub = upper(lo, hi)
    f = lambda v: "      failed            " if v is None else f"{mp.nstr(v[0], 9):>12s} ({mp.nstr(v[1], 1):>7s})"
    print(f"   [{lo:4.2f}, {hi:4.2f}]  | {truth(lo, hi):10.7f} | {f(lb)} | {f(ub)}", flush=True)
