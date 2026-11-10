"""Choose an explicit kernel with a safety margin and rounded coefficients, for rigorous certification by
xi_kernel_conductor_certificate.py.
w(t) = sum_{r=0}^{R} alpha_r t^(2r) with alpha_r >= 0;  h(u) = sum_r alpha_r M_r(u),  M_r(u) = int Phi^(r)(v) Phi^(r)(v-u) dv
(the even function with transform t^(2r) Xi(t)^2). The LP minimises B = 2 sum Lambda(n) n^(-1/2) h(log n) with h(0) = 1
and h(u) >= KAPPA * Psi(u)/Psi(0) on the grid in [0, UMAX]. The coefficients are then rounded to DIG digits and
everything is re-evaluated at 50 digits. Needs kern_mp_D16.pkl from xi_kernel_table.py in the current directory.
Usage: python3 xi_kernel_explicit_kernel.py R KAPPA UMAX DIG

Outcome, 10 November 2026.
R = 4, KAPPA = 0.004, UMAX = 3.0, DIG = 6:  alpha = [2.27942, 0.0506854, 0.000783157, 2.13792e-6, 7.48483e-8],
   h(0) = 1.00000097083, B = 6.6985551e-4 (q >= 0.99933037), smallest h/h(0) on [0, 1.2] about 2.96e-4 near u = log 2.
R = 6, KAPPA = 0.0005, UMAX = 3.0, DIG = 7:  alpha = [2.258739, 0.05216107, 0.0007103534, 4.97466e-6, 4.918306e-8, 0, 1.584807e-12],
   h(0) = 0.999999995562, B = 8.3460966e-5 (q >= 0.99991654).
   WARNING: xi_kernel_conductor_certificate.py certifies that this R = 6 kernel is NEGATIVE (about -9.6e-10) near
   u = 1.4712, between the grid points used here. It is not a valid kernel for Corollary 1. The R = 4 kernel is
   certified positive on [0, 4].
"""
import mpmath as mp, numpy as np, pickle, sys
from scipy.optimize import linprog
mp.mp.dps = 50
T = pickle.load(open("kern_mp_D16.pkl", "rb")); us = T["us"]; K = T["K"]; PP = T["PP"]; rec = T["rec"]; n0 = T["norm0"]
R = int(sys.argv[1]); KAPPA = mp.mpf(sys.argv[2]); UMAX = mp.mpf(sys.argv[3]); DIG = int(sys.argv[4])
# monomial coefficients of the orthonormal polynomials pi_k(s), s = (t/10)^2:  s pi_k = b_k pi_{k+1} + a_k pi_k + b_{k-1} pi_{k-1}
co = [[n0]]
for k in range(R):
    a, b = rec[k]; prev = co[k]; new = [mp.mpf(0)] * (k + 2)
    for i, c in enumerate(prev): new[i + 1] += c; new[i] -= a * c
    if k > 0:
        for i, c in enumerate(co[k - 1]): new[i] -= rec[k - 1][1] * c
    co.append([x / b for x in new])
# M_r(u) in units t^(2r): solve the triangular system  K_k = sum_i co[k][i] * S_i,  S_i = kernel of s^i = M_i / 10^(2i)
def S(u):
    out = []
    for k in range(R + 1):
        out.append((K[u][k] - mp.fsum(co[k][i] * out[i] for i in range(k))) / co[k][k])
    return out
ug = [u for u in us if u <= UMAX]
Su = {u: S(u) for u in ug}
for n, w in PP:
    if mp.log(n) not in Su: Su[mp.log(n)] = S(mp.log(n))
psi0 = Su[mp.mpf(0)][0]
rows = []; rhs = []
for u in ug:
    r = Su[u]; sc = max(abs(x) for x in r); rows.append([-float(x / sc) for x in r]); rhs.append(-float(KAPPA * r[0] / psi0 / sc))
obj_mp = [2 * mp.fsum(w * Su[mp.log(n)][i] for n, w in PP) for i in range(R + 1)]; sco = max(abs(x) for x in obj_mp)
res = linprog([float(x / sco) for x in obj_mp], A_ub=np.array(rows), b_ub=rhs, A_eq=np.array([[float(x) for x in Su[mp.mpf(0)]]]), b_eq=[1.0],
              bounds=[(0, None)] * (R + 1), method="highs")
assert res.status == 0, res.message
beta = [mp.mpf(mp.nstr(mp.mpf(float(x)), DIG)) for x in res.x]                 # coefficients of s^i, rounded
h = lambda u: mp.fsum(beta[i] * Su[u][i] for i in range(R + 1))
h0 = h(mp.mpf(0)); B = mp.fsum(beta[i] * obj_mp[i] for i in range(R + 1)) / h0
margin = min(((h(u) - 0) / h0, u) for u in ug)
floor = min(((h(u) / h0) / (Su[u][0] / psi0), u) for u in ug)
alpha = [beta[i] / mp.mpf(10) ** (2 * i) for i in range(R + 1)]
print(f"R={R} (degree {2*R} in t), kappa={mp.nstr(KAPPA,3)}, grid to u={mp.nstr(UMAX,3)}")
print("coefficients of (t/10)^(2i):", [mp.nstr(b, DIG) for b in beta])
print("alpha_r (coefficients of t^(2r)):", [mp.nstr(a, DIG) for a in alpha])
print(f"h(0) = {mp.nstr(h0, 12)};  B = 2 sum Lambda n^-1/2 h(log n)/h(0) = {mp.nstr(B, 8)};  q >= {mp.nstr(mp.exp(-B), 10)}")
print(f"min of h/h(0) on the grid: {mp.nstr(margin[0], 4)} at u = {mp.nstr(margin[1], 5)};  min of [h/h(0)]/[Psi/Psi(0)]: {mp.nstr(floor[0], 4)} at u = {mp.nstr(floor[1], 5)}")
for uu in (0.004, 0.2, 0.5, 0.692, 0.696, 1.0, 1.1, 1.388, 1.6, 2.0, 2.6, 3.0):
    u = min(ug, key=lambda z: abs(z - uu)); print(f"   u={mp.nstr(u,5)}: h/h(0) = {mp.nstr(h(u)/h0, 6)},  Psi/Psi(0) = {mp.nstr(Su[u][0]/psi0, 4)}")
