"""Experiment C2. Same as clock_vs_primes.py but the deleted set is as regular as a set of primes can be:
walk through the primes, add p^(alpha-1) to an accumulator, delete p each time the accumulator passes 1.
The deleted-count then matches its smooth target to within 1 at every x (a random set misses by about x^(alpha/2)).
Question: does a perfectly regular deletion give a more even clock than a random one?"""
import numpy as np, time
X = 10**8
t0 = time.time()
sieve = np.ones(X + 1, dtype=bool); sieve[:2] = False
for i in range(2, int(X**0.5) + 1):
    if sieve[i]: sieve[i*i::i] = False
primes = np.nonzero(sieve)[0]; del sieve
xs = np.unique(np.round(np.exp(np.linspace(np.log(1e3), np.log(X / 2), 4000))).astype(np.int64))
edges = np.exp(np.linspace(np.log(1e3), np.log(X / 2), 13)); mid = np.sqrt(edges[:-1] * edges[1:])
def clock(S):
    alive = np.ones(X + 1, dtype=bool); alive[0] = False
    for p in S: alive[p::p] = False
    Nb = np.cumsum(alive, dtype=np.int64)
    D = (Nb[2 * xs] - 2 * Nb[xs]).astype(np.float64)
    return np.array([np.sqrt(np.mean(D[(xs >= lo) & (xs < hi)] ** 2)) for lo, hi in zip(edges[:-1], edges[1:])])
for alpha in [0.6, 0.8, 0.9]:
    q = primes.astype(np.float64) ** (alpha - 1)
    c = np.cumsum(q)
    greedy = primes[np.floor(c) > np.floor(np.concatenate(([0.0], c[:-1])))]
    rg = clock(greedy)
    rr = []
    for seed in range(4):
        rng = np.random.default_rng(100 + seed)
        rr.append(clock(primes[rng.random(len(primes)) < q]))
    rr = np.sqrt(np.mean(np.array(rr) ** 2, axis=0))
    sel = mid > 1e5
    sg = np.polyfit(np.log(mid[sel]), np.log(rg[sel]), 1)[0]; sr = np.polyfit(np.log(mid[sel]), np.log(rr[sel]), 1)[0]
    print(f"alpha={alpha}: |greedy S|={len(greedy)}  exponent greedy={sg:.3f}  random={sr:.3f}   alpha/2={alpha/2:.3f}  alpha/(2(1+alpha))={alpha/(2*(1+alpha)):.3f}  ({time.time()-t0:.0f}s)")
    print("   x      ", " ".join(f"{m:8.1e}" for m in mid))
    print("   greedy ", " ".join(f"{r:8.1f}" for r in rg))
    print("   random ", " ".join(f"{r:8.1f}" for r in rr), flush=True)
