"""Ripple test. S = a finite set of primes, b(n) = 1 iff no prime of S divides n, N(x) = sum_{n<=x} b(n),
a = prod_{p in S} (1 - 1/p), R(x) = N(x) - a x.  Exact identity: R(x) = - sum_{d in D} mu(d) frac(x/d),
D = squarefree products of primes of S.

Predictions checked here:
 (1) For q in D, q > 1:  (1/X) | sum_{X<n<=2X} R(n) e(n/q) |  ->  a / (2 phi(q) sin(pi/q)), which is about
     (a / 2 pi) q / phi(q) for large q (the table prints the large-q form).   For q not in D: -> 0.
 (2) Variance of R over [X, 2X]  ~  (a^2 / 12) * sum_{q in D, q <= cX} prod_{p | q} (p+1)/(p-1)   for some c of order 1.
"""
import numpy as np, sys, math
X = int(float(sys.argv[1])) if len(sys.argv) > 1 else 10**7
alpha = float(sys.argv[2]) if len(sys.argv) > 2 else 0.6
mode = sys.argv[3] if len(sys.argv) > 3 else "greedy"
TOP = 2 * X
sieve = np.ones(TOP + 1, dtype=bool); sieve[:2] = False
for i in range(2, int(TOP**0.5) + 1):
    if sieve[i]: sieve[i*i::i] = False
primes = np.nonzero(sieve)[0]; pf = primes.astype(np.float64)
if mode == "greedy":
    q_ = pf ** (alpha - 1) - np.where(pf > 1000, 0.5 * pf ** (alpha / 2 - 1), 0.0)
    c = np.cumsum(q_); S = primes[np.floor(c) > np.floor(np.concatenate(([0.0], c[:-1])))]
else:
    rng = np.random.default_rng(5); S = primes[rng.random(len(primes)) < pf ** (alpha - 1)]
Sset = set(int(p) for p in S)
alive = np.ones(TOP + 1, dtype=bool); alive[0] = False
for p in S: alive[p::p] = False
a = float(np.prod(1.0 - 1.0 / S.astype(np.float64)))
n = np.arange(TOP + 1, dtype=np.float64)
R = np.cumsum(alive).astype(np.float64) - a * n
print(f"X={X} alpha={alpha} mode={mode} |S|={len(S)} first S: {S[:12].tolist()}  a={a:.6f}")
win = slice(X + 1, 2 * X + 1); u = n[win]; Rw_raw = R[win]
# The part of R coming from d > x does not oscillate inside the window (frac(x/d) = x/d); it is a slow drift.
# Remove a cubic trend so that only the oscillating part is tested.
t = (u - 1.5 * X) / X
coef = np.polyfit(t, Rw_raw, 3); Rw = Rw_raw - np.polyval(coef, t)
print(f"raw window mean={Rw_raw.mean():.1f}, raw rms about mean={Rw_raw.std():.1f}; after removing a cubic trend rms={Rw.std():.2f}")
def phi(q):
    r = q; m = q; p = 2
    while p * p <= m:
        if m % p == 0:
            r -= r // p
            while m % p == 0: m //= p
        p += 1
    if m > 1: r -= r // m
    return r
def inD(q):
    m = q; p = 2
    while p * p <= m:
        if m % p == 0:
            if p not in Sset: return False
            m //= p
            if m % p == 0: return False
        p += 1
    return m == 1 or m in Sset
print("\n(1) ripple amplitude at frequency 1/q:   q | in D | measured | a/(2 phi(q) sin(pi/q)) | large-q form")
Sl = [int(p) for p in S]
notS = [int(p) for p in primes[:400] if int(p) not in Sset]
tests = Sl[:4] + [Sl[10], Sl[40], Sl[150]] + notS[:3] + [notS[30]] + [Sl[0]*Sl[1], Sl[1]*Sl[3], Sl[0]*notS[0], Sl[0]**2, 30, 1000]
for q in tests:
    amp = abs(np.sum(Rw * np.exp(2j * np.pi * u / q))) / X
    d = inD(q); pred = a / (2 * np.pi) * q / phi(q) if d else 0.0
    exact = a / (2 * phi(q) * np.sin(np.pi / q)) if d else 0.0
    print(f"   {q:8d} | {str(d):5s} | {amp:.5f} | {exact:.5f} | {pred:.5f}")
# (2) weighted count of D by depth-first search
vals = []
def dfs(i, d, w):
    vals.append((d, w))
    for j in range(i, len(Sl)):
        p = Sl[j]
        if d * p > 4 * X: break
        dfs(j + 1, d * p, w * (p + 1) / (p - 1))
sys.setrecursionlimit(10000); dfs(0, 1, 1.0)
dv = np.array([v[0] for v in vals], dtype=np.float64); wv = np.array([v[1] for v in vals])
var = float(np.var(Rw)); mean = float(np.mean(Rw))
print(f"\n(2) R on [X,2X]: mean={mean:.2f}  variance={var:.2f}  rms about mean={var**0.5:.2f}")
for cc in [0.125, 0.25, 0.5, 1.0, 2.0, 4.0]:
    W = wv[dv <= cc * X].sum()
    print(f"   c={cc:5.3f}: (a^2/12) * W(cX) = {a*a/12*W:10.2f}   count D(cX) = {(dv <= cc*X).sum()}   ratio measured/predicted = {var/(a*a/12*W):.3f}")
