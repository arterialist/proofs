"""Experiment C3. A prediction from the analysis of the deleted-primes system.
If the deleted set S has count li(x^alpha) with no further structure, the new zeta has a square-root branch point
at alpha/2 (from the squares of deleted primes), and the clock error gets a steady drift ~ x^(alpha/2)/log^(3/2) x.
Prediction: deleting slightly fewer primes, following Riemann's correction
   count(x) = li(x^a) - (1/2) li(x^(a/2)) - (1/3) li(x^(a/3)) - ...   (density p^(a-1) - p^(a/2-1)/2 - p^(a/3-1)/3 ...),
removes the drift and makes the clock more even. Compare plain greedy with corrected greedy.

Outcome, 10 November 2026, X = 1e8: this version did NOT confirm the prediction. Both corrections flipped the sign
of the drift and enlarged it. Likely cause, not separately tested: changing the density at small primes changes which of 2, 3, 5, ...
get deleted, which rescales every constant, and for alpha >= 0.7 a second drift term near x^(alpha-1/2) is of comparable
size at this range. deleted_primes_clock_drift.py repeats the test with the small primes held fixed and alpha = 0.6, 0.65,
and there the drift vanishes at the predicted coefficient 1/2. Cite that script, not this one."""
import numpy as np, time, sys
X = int(float(sys.argv[1])) if len(sys.argv) > 1 else 10**8
t0 = time.time()
sieve = np.ones(X + 1, dtype=bool); sieve[:2] = False
for i in range(2, int(X**0.5) + 1):
    if sieve[i]: sieve[i*i::i] = False
primes = np.nonzero(sieve)[0]; del sieve
pf = primes.astype(np.float64)
xs = np.unique(np.round(np.exp(np.linspace(np.log(1e3), np.log(X / 2), 6000))).astype(np.int64))
edges = np.exp(np.linspace(np.log(1e4), np.log(X / 2), 9)); mid = np.sqrt(edges[:-1] * edges[1:])
MU = {1: 1, 2: -1, 3: -1, 5: -1, 6: 1, 7: -1, 10: 1, 11: -1, 13: -1, 14: 1, 15: 1}
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
for alpha in [0.7, 0.8, 0.9]:
    plain = pf ** (alpha - 1)
    corr = sum(MU[k] / k * pf ** (alpha / k - 1) for k in MU)       # density of Riemann's R(x^alpha)
    half = pf ** (alpha - 1) - 0.5 * pf ** (alpha / 2 - 1)           # only the square correction
    print(f"alpha={alpha}  ({time.time()-t0:.0f}s)")
    print("   x                 ", " ".join(f"{m:8.1e}" for m in mid))
    for name, q in [("plain greedy", plain), ("minus half squares", half), ("full Riemann corr", corr)]:
        S = greedy(q); rms, mean = clock(S)
        print(f"   {name:18s} rms ", " ".join(f"{r:8.1f}" for r in rms), f"  |S|={len(S)}")
        print(f"   {'':18s} mean", " ".join(f"{r:8.1f}" for r in mean), flush=True)
    drift = mid ** (alpha / 2) / np.log(mid) ** 1.5
    print(f"   {'x^(a/2)/log^1.5':18s}     ", " ".join(f"{r:8.1f}" for r in drift))
