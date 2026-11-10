"""Experiment C4. Isolate the drift. alpha = 0.6 and 0.65, where alpha - 1/2 is far below alpha/2.
All variants delete the same primes below 1000; above 1000 they follow different densities:
  plain: p^(a-1);  c-corrected: p^(a-1) - c * p^(a/2-1) for c = 0.25, 0.5, 0.75.
Theory says the drift has coefficient proportional to 1/Gamma(c - 1/2), zero at c = 1/2.

Outcome, 10 November 2026, X = 4e8: confirmed at both alpha. Mean of D near x = 1.1e8, alpha = 0.6:
c = 0: +9.3, c = 0.25: +5.2, c = 0.5: +1.3, c = 0.75: -3.1 (alpha = 0.65: +14.0, +7.0, +0.7, -6.4).
The root-mean-square size barely moves (32 to 30), so the correction removes the drift and leaves the noise."""
import numpy as np, time, sys
X = int(float(sys.argv[1])) if len(sys.argv) > 1 else 4 * 10**8
t0 = time.time()
sieve = np.ones(X + 1, dtype=bool); sieve[:2] = False
for i in range(2, int(X**0.5) + 1):
    if sieve[i]: sieve[i*i::i] = False
primes = np.nonzero(sieve)[0]; del sieve
pf = primes.astype(np.float64)
xs = np.unique(np.round(np.exp(np.linspace(np.log(1e4), np.log(X / 2), 8000))).astype(np.int64))
edges = np.exp(np.linspace(np.log(1e4), np.log(X / 2), 9)); mid = np.sqrt(edges[:-1] * edges[1:])
def greedy(q):
    c = np.cumsum(q)
    return primes[np.floor(c) > np.floor(np.concatenate(([0.0], c[:-1])))]
def clock(S):
    alive = np.ones(X + 1, dtype=bool); alive[0] = False
    for p in S: alive[p::p] = False
    Nb = np.cumsum(alive, dtype=np.int32).astype(np.int64)
    D = (Nb[2 * xs] - 2 * Nb[xs]).astype(np.float64)
    rms = np.array([np.sqrt(np.mean(D[(xs >= lo) & (xs < hi)] ** 2)) for lo, hi in zip(edges[:-1], edges[1:])])
    mean = np.array([np.mean(D[(xs >= lo) & (xs < hi)]) for lo, hi in zip(edges[:-1], edges[1:])])
    return rms, mean
for alpha in [0.6, 0.65]:
    print(f"alpha={alpha}  ({time.time()-t0:.0f}s)   x:", " ".join(f"{m:8.1e}" for m in mid))
    for c in [0.0, 0.25, 0.5, 0.75]:
        q = pf ** (alpha - 1) - np.where(pf > 1000, c * pf ** (alpha / 2 - 1), 0.0)
        S = greedy(q); rms, mean = clock(S)
        print(f"   c={c:4.2f} |S|={len(S):7d} mean", " ".join(f"{r:8.1f}" for r in mean))
        print(f"   {'':19s} rms ", " ".join(f"{r:8.1f}" for r in rms), flush=True)
    print(f"   {'x^(a/2)/log^1.5':19s}     ", " ".join(f"{r:8.1f}" for r in mid ** (alpha / 2) / np.log(mid) ** 1.5))
print(f"done {time.time()-t0:.0f}s")
