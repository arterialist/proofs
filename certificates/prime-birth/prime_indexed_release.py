"""Idea 2 of the hour: releases indexed by primes.
V_N = closed span of rho_d over all N-smooth integers d (every dilation built from the primes born so far).
delta_N^2 = dist(chi, V_N)^2 decreases only when a new prime is born, and RH <=> delta_N -> 0.
Compute delta_N^2 with d truncated at D, for D = 1e3, 1e4, 1e5, to see convergence in D."""
import numpy as np, math, sys, functools
EG = 0.5772156649015329; c0 = (math.log(2 * math.pi) - EG) / 2
@functools.lru_cache(maxsize=None)
def V(h, k):
    if k == 1: return 0.0
    m = np.arange(1, k, dtype=np.int64)
    return float((((m * (h % k)) % k) / k * (1.0 / np.tan(np.pi * m / k))).sum())
def gram(a, b):
    g = math.gcd(a, b); h, k = a // g, b // g
    return (c0 * (1 / h + 1 / k) + (k - h) / (2 * h * k) * math.log(h / k) - math.pi / (2 * h * k) * (V(h, k) + V(k, h))) / g
def smooth(primes, D):
    out = [1]
    for p in primes:
        new = []
        for d in out:
            q = d
            while q <= D:
                new.append(q); q *= p
        out = new
    return sorted(out)
def dist2(ds):
    n = len(ds); G = np.empty((n, n))
    for i in range(n):
        for j in range(i, n):
            G[i, j] = G[j, i] = gram(ds[i], ds[j])
    b = np.array([(math.log(d) + 1 - EG) / d for d in ds])
    # scale to unit diagonal for conditioning
    s = 1 / np.sqrt(np.diag(G)); Gs = G * s[:, None] * s[None, :]; bs = b * s
    w, U = np.linalg.eigh(Gs); keep = w > 1e-10 * w.max()
    c = (U[:, keep].T @ bs) / np.sqrt(w[keep])
    return 1 - float(c @ c), int(keep.sum()), n
allp = [2, 3, 5, 7, 11, 13]
print("primes born | D      | #dilations (kept) | delta^2")
for k in range(1, len(allp) + 1):
    for D in [10**3, 10**4, 10**5]:
        ds = smooth(allp[:k], D)
        if len(ds) > 700: continue
        d2, kept, n = dist2(ds)
        print(f"up to {allp[k-1]:2d}    | {D:6d} | {n:4d} ({kept:4d})       | {d2:.6f}", flush=True)
