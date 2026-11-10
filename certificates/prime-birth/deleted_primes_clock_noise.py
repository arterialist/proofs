"""Experiment C6. Rounding noise of whole-prime deletion, measured against its exact average.
noise(x) = D_seed(x) - D_avg(x), where D = N(2x) - 2N(x), N_seed counts survivors after deleting each prime with
probability p^(alpha-1), and N_avg(x) = sum_{n<=x} prod_{p|n} (1 - p^(alpha-1)) is the exact mean over outcomes.
Reports the root-mean-square of the noise over seeds and x-windows and its growth exponent.
Prediction: about x^(alpha/2) / sqrt(log x)."""
import numpy as np, time, sys
X = int(float(sys.argv[1])) if len(sys.argv) > 1 else 5 * 10**7
SEEDS = 10
t0 = time.time()
sieve = np.ones(X + 1, dtype=bool); sieve[:2] = False
for i in range(2, int(X**0.5) + 1):
    if sieve[i]: sieve[i*i::i] = False
primes = np.nonzero(sieve)[0]; del sieve
pf = primes.astype(np.float64)
xs = np.unique(np.round(np.exp(np.linspace(np.log(1e3), np.log(X / 2), 3000))).astype(np.int64))
edges = np.exp(np.linspace(np.log(1e3), np.log(X / 2), 10)); mid = np.sqrt(edges[:-1] * edges[1:])
for alpha in [0.6, 0.7, 0.8, 0.9]:
    q = pf ** (alpha - 1)
    g = np.ones(X + 1); g[0] = 0.0
    for p, qp in zip(primes, q): g[p::p] *= 1.0 - qp
    G = np.cumsum(g); Davg = G[2 * xs] - 2 * G[xs]; del g, G
    sq = np.zeros(len(mid))
    for seed in range(SEEDS):
        rng = np.random.default_rng(1000 + seed)
        alive = np.ones(X + 1, dtype=bool); alive[0] = False
        for p in primes[rng.random(len(primes)) < q]: alive[p::p] = False
        Nb = np.cumsum(alive, dtype=np.int32).astype(np.int64)
        noise = (Nb[2 * xs] - 2 * Nb[xs]) - Davg
        sq += np.array([np.mean(noise[(xs >= lo) & (xs < hi)] ** 2) for lo, hi in zip(edges[:-1], edges[1:])])
    rms = np.sqrt(sq / SEEDS)
    sel = mid > 3e4
    slope = np.polyfit(np.log(mid[sel]), np.log(rms[sel]), 1)[0]
    slope2 = np.polyfit(np.log(mid[sel]), np.log(rms[sel] * np.sqrt(np.log(mid[sel]))), 1)[0]
    print(f"alpha={alpha}: noise exponent = {slope:.3f}; after removing 1/sqrt(log x): {slope2:.3f};  alpha/2 = {alpha/2:.2f}  alpha-1/2 = {alpha-0.5:.2f}  ({time.time()-t0:.0f}s)")
    print("   x   ", " ".join(f"{m:8.1e}" for m in mid))
    print("   rms ", " ".join(f"{r:8.1f}" for r in rms), flush=True)
