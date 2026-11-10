"""Ripple count across the sieve range. Delete all primes p <= N. The survivors are the N-rough numbers,
Phi(x, N) of them up to x, and R(x) = Phi(x, N) - a x = - sum_{d | P(N)} mu(d) frac(x/d).
For N < x < N^2 the survivors are 1 and the primes, so that range is the prime-counting error.
Independent-ripple prediction for the variance of the oscillating part of R near x:
    V(c) = (a^2/12) * sum_{q <= c x, squarefree, N-smooth} prod_{p | q} (p+1)/(p-1).
Measured: variance of R on [X, 2X] after removing a cubic trend. u = log(1.5 X)/log N."""
import numpy as np, sys, bisect
N = int(sys.argv[1]); TOP = int(float(sys.argv[2]))
small = [p for p in range(2, N + 1) if all(p % r for r in range(2, int(p**0.5) + 1))]
a = 1.0
for p in small: a *= 1 - 1 / p
alive = np.ones(TOP + 1, dtype=bool); alive[0] = False
for p in small: alive[p::p] = False
Phi = np.cumsum(alive, dtype=np.int32); del alive
# squarefree N-smooth q with weights, by depth-first search
qs = []; ws = []
LIM = 2 * TOP
def dfs(i, d, w):
    qs.append(d); ws.append(w)
    for j in range(i, len(small)):
        p = small[j]
        if d * p > LIM: break
        dfs(j + 1, d * p, w * (p + 1) / (p - 1))
sys.setrecursionlimit(100000); dfs(0, 1, 1.0)
order = np.argsort(qs); qs = np.array(qs, dtype=np.float64)[order]; W = np.cumsum(np.array(ws)[order])
def Wat(y):
    k = np.searchsorted(qs, y, side="right")
    return W[k - 1] if k > 0 else 0.0
print(f"N={N}: {len(small)} primes deleted, a={a:.6f}, squarefree N-smooth q <= {LIM:.1e}: {len(qs)}")
print("     X        u   measured var |  V(0.25)   V(0.5)    V(1)  | measured/V(0.5)")
X = max(4 * N, 1000)
while 2 * X <= TOP:
    u = np.arange(X + 1, 2 * X + 1, dtype=np.float64)
    Rw = Phi[X + 1: 2 * X + 1] - a * u
    t = (u - 1.5 * X) / X
    res = Rw - np.polyval(np.polyfit(t, Rw, 3), t)
    var = float(res.var()); xm = 1.5 * X
    v = [a * a / 12 * Wat(c * xm) for c in (0.25, 0.5, 1.0)]
    print(f"{X:10d} {np.log(xm)/np.log(N):5.2f} {var:12.3f} | {v[0]:9.3f} {v[1]:9.3f} {v[2]:9.3f} | {var/v[1]:7.3f}")
    X *= 4
