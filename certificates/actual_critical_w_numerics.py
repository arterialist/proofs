# Numerical sanity check of the constants -1/6 and c1 = 8/9 - gamma/3 for
# W(x) = sum_{d<=x} sqrt(d) V(x/d), with V from ActualCenteredMellin:
# V(y) = sum_{n<=y} b(n)(y-n)_+ - 2 sum_{j<y} Lambda(j) (y^2-j^2)/(2j) + B(y),
# b(n) = sum_{d|n, gcd(d,n/d)=1} Lambda(d) Lambda(n/d), B(y) = y^2 log y/2 + y^2/4 - 1/4 (y>1).
import math, sys
import numpy as np
X = int(sys.argv[1]) if len(sys.argv) > 1 else 10**6
spf = np.zeros(X+1, dtype=np.int64)
for i in range(2, X+1):
    if spf[i] == 0:
        spf[i::i][spf[i::i] == 0] = i
Lam = np.zeros(X+1)
b = np.zeros(X+1)
for n in range(2, X+1):
    p = spf[n]; m = n; a = 0
    while m % p == 0: m //= p; a += 1
    if m == 1:
        Lam[n] = math.log(p)
    else:
        q = spf[m]; mm = m
        while mm % q == 0: mm //= q
        if mm == 1:   # n = p^a q^b, p != q
            b[n] = 2.0*math.log(p)*math.log(q)
nn = np.arange(X+1, dtype=np.float64)
S0 = np.cumsum(b); S1 = np.cumsum(b*nn)
with np.errstate(divide='ignore', invalid='ignore'):
    P0 = np.cumsum(np.where(nn > 0, Lam/np.where(nn > 0, nn, 1), 0.0))
P1 = np.cumsum(Lam*nn)
def V(y):
    if y <= 1: return 0.0
    k = int(math.floor(y))
    pair = y*S0[k] - S1[k]
    eta = (y*y/2.0)*P0[k] - 0.5*P1[k]
    B = y*y*math.log(y)/2.0 + y*y/4.0 - 0.25
    return pair - 2.0*eta + B
def W(x):
    terms = [math.sqrt(d)*V(x/d) for d in range(1, int(math.floor(x))+1)]
    return math.fsum(terms)
gamma = 0.5772156649015329
c1 = 8/9 - gamma/3
print(f"c1 = {c1:.6f}")
for x in [10**3, 3*10**3, 10**4, 3*10**4, 10**5, 3*10**5, 10**6]:
    if x > X: break
    w = W(x); L = math.log(x); s = x**1.5
    r1 = w/(s*L*L); r2 = (w + s*L*L/6)/(s*L)
    print(f"x={x:>8}  W/(x^1.5 log^2 x) = {r1:+.5f}   (W + x^1.5 log^2 x/6)/(x^1.5 log x) = {r2:+.5f}")
