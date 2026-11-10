"""Experiment C. Does an even clock see what was done to the primes?

Delete a random sparse set S of primes: prime p is deleted with probability p^(alpha-1).
The surviving 'integers' are the n with no prime factor in S; N_B(x) counts them.
The surviving primes have psi_B(x) = x - x^alpha/alpha + ..., i.e. a real zero of the new zeta at alpha > 1/2.
Question: how even is the new clock, N_B(x) = a x + R(x)?  Measure the exponent of R.
D(x) = N_B(2x) - 2 N_B(x) = R(2x) - 2 R(x) removes the unknown constant a exactly.
Candidates for the exponent: alpha/2 (random-set heuristic), 2 alpha/(alpha+2) (proved bound, alpha < 2/3), 1/2.
"""
import numpy as np, sys, time
X = int(float(sys.argv[1])) if len(sys.argv) > 1 else 10**8
alphas = [0.6, 0.7, 0.8, 0.9]
seeds = [1, 2, 3]

t0 = time.time()
sieve = np.ones(X + 1, dtype=bool); sieve[:2] = False
for i in range(2, int(X**0.5) + 1):
    if sieve[i]:
        sieve[i*i::i] = False
primes = np.nonzero(sieve)[0]
del sieve
print(f"primes up to {X}: {len(primes)}  ({time.time()-t0:.0f}s)", flush=True)

xs = np.unique(np.round(np.exp(np.linspace(np.log(1e3), np.log(X / 2), 4000))).astype(np.int64))
edges = np.exp(np.linspace(np.log(1e3), np.log(X / 2), 13))

def run(alpha, seed):
    rng = np.random.default_rng(seed)
    S = primes[rng.random(len(primes)) < primes.astype(np.float64) ** (alpha - 1)]
    alive = np.ones(X + 1, dtype=bool); alive[0] = False
    for p in S:
        alive[p::p] = False
    Nb = np.cumsum(alive, dtype=np.int64)
    D = Nb[2 * xs] - 2 * Nb[xs]
    # the surviving primes: psi_B(x) - x, checked at X against -x^alpha/alpha
    lam = np.log(primes.astype(np.float64)); keep = alive[primes]
    theta_B = lam[keep].sum()
    return len(S), D, theta_B

for alpha in alphas:
    rms_all = []
    for seed in seeds:
        nS, D, thB = run(alpha, seed)
        rms = []
        for lo, hi in zip(edges[:-1], edges[1:]):
            m = (xs >= lo) & (xs < hi)
            rms.append(np.sqrt(np.mean(D[m].astype(np.float64) ** 2)))
        rms_all.append(rms)
        print(f"alpha={alpha} seed={seed} |S|={nS}  theta_B(X)-X={thB-X:.0f}  -X^a/a={-X**alpha/alpha:.0f}  ({time.time()-t0:.0f}s)", flush=True)
    rms = np.sqrt(np.mean(np.array(rms_all) ** 2, axis=0))
    mid = np.sqrt(edges[:-1] * edges[1:])
    sel = mid > 1e5
    slope, icpt = np.polyfit(np.log(mid[sel]), np.log(rms[sel]), 1)
    print(f"ALPHA {alpha}: fitted clock exponent = {slope:.3f}   alpha/2 = {alpha/2:.3f}   2a/(a+2) = {2*alpha/(alpha+2):.3f}   sqrt = 0.5")
    print("   x ~", " ".join(f"{m:9.2e}" for m in mid))
    print("   rms", " ".join(f"{r:9.1f}" for r in rms))
    print("   rms/x^(a/2)", " ".join(f"{r/m**(alpha/2):9.3f}" for r, m in zip(rms, mid)), flush=True)
