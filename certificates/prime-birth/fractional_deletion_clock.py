"""Experiment C5. Fractional deletion: remove the fraction p^(alpha-1) of each prime p instead of whole primes.
Exact identity: averaging the whole-prime random deletion over all outcomes gives
   E N_B(x) = sum_{n<=x} g(n),  g(n) = prod_{p | n} (1 - p^(alpha-1)),  with Dirichlet series zeta(s)/zeta(s+1-alpha).
So the averaged system has a zeta zero at alpha and, under RH, clock error of exponent alpha - 1/2.
Whole-prime deletion adds rounding noise of exponent about alpha/2 (measured in deleted_primes_clock_random.py).
Here: measure the clock error of the averaged system directly. D(x) = G(2x) - 2 G(x)."""
import numpy as np, time, sys
X = int(float(sys.argv[1])) if len(sys.argv) > 1 else 2 * 10**7
t0 = time.time()
sieve = np.ones(X + 1, dtype=bool); sieve[:2] = False
for i in range(2, int(X**0.5) + 1):
    if sieve[i]: sieve[i*i::i] = False
primes = np.nonzero(sieve)[0]; del sieve
xs = np.unique(np.round(np.exp(np.linspace(np.log(1e3), np.log(X / 2), 4000))).astype(np.int64))
edges = np.exp(np.linspace(np.log(1e3), np.log(X / 2), 9)); mid = np.sqrt(edges[:-1] * edges[1:])
for alpha in [0.6, 0.7, 0.8, 0.9]:
    g = np.ones(X + 1); g[0] = 0.0
    for p in primes:
        g[p::p] *= 1.0 - float(p) ** (alpha - 1)
    G = np.cumsum(g)
    D = G[2 * xs] - 2 * G[xs]
    rms = np.array([np.sqrt(np.mean(D[(xs >= lo) & (xs < hi)] ** 2)) for lo, hi in zip(edges[:-1], edges[1:])])
    sel = mid > 3e4
    slope = np.polyfit(np.log(mid[sel]), np.log(rms[sel]), 1)[0]
    print(f"alpha={alpha}: fitted exponent of averaged clock error = {slope:.3f}   alpha-1/2 = {alpha-0.5:.2f}   alpha/2 = {alpha/2:.2f}   ({time.time()-t0:.0f}s)")
    print("   x   ", " ".join(f"{m:8.1e}" for m in mid))
    print("   rms ", " ".join(f"{r:8.3f}" for r in rms), flush=True)
