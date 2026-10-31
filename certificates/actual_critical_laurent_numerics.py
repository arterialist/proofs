# Laurent expansion of the continued transform F(s) = M(s)(G(s)^2 - Hext(s)) at s = 1/2:
# u^3 F(1/2+u) = -1/3 + c1 u + c2 u^2 + ...   with c1 = 8/9 - gamma/3 (Lean), c2 to be found.
import numpy as np, mpmath as mp, math
mp.mp.dps = 30
P = 10**7
sieve = np.ones(P+1, dtype=bool); sieve[:2] = False
for i in range(2, int(P**0.5)+1):
    if sieve[i]: sieve[i*i::i] = False
primes = np.nonzero(sieve)[0].astype(np.float64)
logp2 = np.log(primes)**2
def D(sig):   # sum_p (log p)^2 r^3 (2+r)/(1-r^2)^2, r = p^{-sig}
    r = primes**(-sig)
    return float(np.sum(logp2 * r**3 * (2+r) / (1-r*r)**2))
def F(sig):
    S = mp.mpf(sig)
    M = mp.zeta(S + mp.mpf(1)/2) / (S*(S+1))
    G = -mp.zeta(S, derivative=1)/mp.zeta(S) - S/(S-1)
    # (zeta'/zeta)'(2S) = (zeta'' zeta - zeta'^2)/zeta^2 at 2S
    z = mp.zeta(2*S); z1 = mp.zeta(2*S, derivative=1); z2 = mp.zeta(2*S, derivative=2)
    dlog = (z2*z - z1*z1)/(z*z)
    Hext = dlog + mp.mpf(D(sig))
    return M*(G*G - Hext)
gamma = mp.euler
c1 = mp.mpf(8)/9 - gamma/3
print("c1 (Lean) =", mp.nstr(c1, 8))
us = [0.005, 0.01, 0.02, 0.03, 0.04, 0.06, 0.08]
vals = []
for u in us:
    Fu = F(0.5+u) * mp.mpf(u)**3
    vals.append(float(Fu))
    print(f"u={u:.3f}  u^3 F = {mp.nstr(Fu, 10)}   (u^3F + 1/3)/u = {mp.nstr((Fu + mp.mpf(1)/3)/u, 8)}   ((u^3F+1/3)/u - c1)/u = {mp.nstr(((Fu + mp.mpf(1)/3)/u - c1)/u, 6)}")
# quadratic fit in u of (u^3 F + 1/3 - c1 u)/u^2 to extract c2 (and c3)
A = np.array([[1.0, u, u*u] for u in us]); y = np.array([(v + 1/3 - float(c1)*u)/(u*u) for u, v in zip(us, vals)])
coef, *_ = np.linalg.lstsq(A, y, rcond=None)
print("fit (u^3F + 1/3 - c1 u)/u^2 = c2 + c3 u + c4 u^2:  c2=%.4f c3=%.3f c4=%.2f" % tuple(coef))
