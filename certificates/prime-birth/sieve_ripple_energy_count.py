"""The real sieve as a deletion system. Delete every prime p <= N, N = sqrt(X). The survivors in (N, X] are exactly
the primes in (N, X]. R(x) = (pi(x) - pi(N) + 1) - a x, a = prod_{p<=N} (1 - 1/p), and Legendre's formula says
R(x) = - sum_{d | P(N)} mu(d) frac(x/d).
Counting each sawtooth's energy on its own (no cross terms beyond exact resonance) predicts
   variance of R near x  ~  (a^2/12) * sum_{q <= c x, q squarefree, N-smooth} prod_{p|q} (p+1)/(p-1).
Compare with the measured variance of R on [X/2, X] after removing a smooth trend, and with the value the
Riemann hypothesis implies for the prime-counting fluctuation, (2 + gamma - log 4 pi) x / log^2 x."""
import numpy as np, sys
X = int(float(sys.argv[1])) if len(sys.argv) > 1 else 10**7
N = int(X**0.5)
sieve = np.ones(X + 1, dtype=bool); sieve[:2] = False
for i in range(2, N + 1):
    if sieve[i]: sieve[i*i::i] = False
primes = np.nonzero(sieve)[0]; small = primes[primes <= N]
a = float(np.prod(1 - 1 / small.astype(np.float64)))
surv = sieve.copy(); surv[: N + 1] = False; surv[1] = True
n = np.arange(X + 1, dtype=np.float64)
R = np.cumsum(surv) - a * n
# weights on squarefree N-smooth q
w = np.ones(X + 1); prod = np.ones(X + 1)
for p in small:
    p = int(p); w[p::p] *= (p + 1) / (p - 1); prod[p::p] *= p
ok = prod == n; ok[0] = False
W = np.cumsum(np.where(ok, w, 0.0)); Dcount = np.cumsum(ok)
print(f"X={X} N={N} a={a:.6f}  (2 e^-gamma / log X = {2*np.exp(-0.5772156649)/np.log(X):.6f})")
print(f"squarefree N-smooth q <= X: {int(Dcount[X])} = {Dcount[X]/X:.4f} X;  weighted W(X) = {W[X]/X:.4f} X   (theory: 1.5198 * 0.3069 = 0.4664)")
lo = X // 2
u = n[lo + 1: X + 1]; Rw = R[lo + 1: X + 1]
t = (u - 0.75 * X) / X
for deg in [1, 3, 5]:
    res = Rw - np.polyval(np.polyfit(t, Rw, deg), t)
    print(f"  trend degree {deg}: measured variance = {res.var():10.2f}   rms = {res.std():8.2f}")
res = Rw - np.polyval(np.polyfit(t, Rw, 3), t); var = res.var()
xm = 0.75 * X
for c in [0.25, 0.5, 0.75, 1.0]:
    pred = a * a / 12 * W[int(c * xm)]
    print(f"  ripple count with cutoff c={c}: predicted variance = {pred:10.2f}   measured/predicted = {var/pred:.3f}")
rh = (2 + 0.5772156649 - np.log(4 * np.pi)) * xm / np.log(xm) ** 2
print(f"  RH value (2+gamma-log 4pi) x/log^2 x at x=0.75X: {rh:.2f}   measured/RH = {var/rh:.3f}")
