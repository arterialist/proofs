# Check  int_1^inf W(x) x^{-s-2} dx  =  M(s) (G(s)^2 - H(s)),  M = zeta(s+1/2)/(s(s+1)),
# G = -zeta'/zeta(s) - s/(s-1),  H = sum_p (log p)^2 p^{-2s}/(1-p^{-s})^2,  for s = 2, 3.
import math, sys
import numpy as np
import mpmath as mp
from sympy import primerange
PR=[mp.mpf(q) for q in primerange(2, 200000)]
X = int(sys.argv[1]) if len(sys.argv) > 1 else 10000
src = open(__file__.replace('actual_critical_transform_numerics.py','actual_critical_w_numerics.py')).read().split("gamma = 0.577")[0].replace("X = int(sys.argv[1]) if len(sys.argv) > 1 else 10**6", "X = %d" % X)
exec(src)
# Gauss-Legendre nodes on [n, n+1]
gl_x, gl_w = np.polynomial.legendre.leggauss(10)
def W_vec(xs, n):
    # xs in (n, n+1); all floors fixed: floor(x/d) = floor(n/d)
    d = np.arange(1, n+1, dtype=np.float64)
    k = (n // np.arange(1, n+1)).astype(np.int64)
    s0 = S0[k]; s1 = S1[k]; p0 = P0[k]; p1 = P1[k]
    out = np.empty(len(xs))
    for i, x in enumerate(xs):
        y = x / d
        B = np.where(y > 1, y*y*np.log(np.maximum(y, 1e-300))/2 + y*y/4 - 0.25, 0.0)
        V = y*s0 - s1 - 2*((y*y/2)*p0 - 0.5*p1) + B
        out[i] = np.dot(np.sqrt(d), V)
    return out
for s in [2.0, 3.0]:
    total = 0.0
    for n in range(1, X):
        xs = n + 0.5 + 0.5*gl_x; ws = 0.5*gl_w
        total += float(np.dot(ws, W_vec(xs, n) * xs**(-s-2)))
    mp.mp.dps = 20
    S = mp.mpf(s)
    M = mp.zeta(S + mp.mpf(1)/2) / (S*(S+1))
    G = -mp.zeta(S, derivative=1)/mp.zeta(S) - S/(S-1)
    H = mp.fsum(mp.log(q)**2 * q**(-2*S) / (1 - q**(-S))**2 for q in PR)
    rhs = M*(G*G - H)
    print(f"s={s}: LHS(num, up to X={X}) = {total:.6f}   RHS = M(G^2-H) = {float(rhs):.6f}   M={float(M):.5f} G={float(G):.5f} H={float(H):.5f}")
