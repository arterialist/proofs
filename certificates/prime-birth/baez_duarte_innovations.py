"""Experiment B. Baez-Duarte form of Nyman-Beurling, read in time N.

H = L^2(0,inf), chi = 1_(0,1], rho_k(x) = frac(1/(k x)).
d_N^2 = dist(chi, span{rho_1..rho_N})^2.  RH <=> d_N -> 0  (Baez-Duarte 2003).
Each step N adds one function, so d_N^2 only decreases:
  Delta_N = d_{N-1}^2 - d_N^2 >= 0,   and RH <=> sum_N Delta_N = ||chi||^2 = 1.
Gram entries from Vasyunin's formula; <chi,rho_a> = (log a + 1 - gamma)/a.
"""
import numpy as np, sys, time
N = int(sys.argv[1]) if len(sys.argv) > 1 else 1500
EG = 0.5772156649015329
c0 = (np.log(2*np.pi) - EG) / 2

t0 = time.time()
# Vasyunin sums V(r,k) = sum_{m=1}^{k-1} frac(m r / k) cot(pi m / k), r mod k
off = np.zeros(N + 2, dtype=np.int64)
for k in range(1, N + 1):
    off[k + 1] = off[k] + k
Vflat = np.zeros(off[N + 1])
for k in range(2, N + 1):
    m = np.arange(1, k, dtype=np.int64)
    cot = 1.0 / np.tan(np.pi * m / k)
    r = np.arange(k, dtype=np.int64)
    M = (m[:, None] * r[None, :]) % k
    Vflat[off[k]:off[k] + k] = (M * cot[:, None]).sum(axis=0) / k
print(f"Vasyunin sums done in {time.time()-t0:.1f}s", flush=True)

def gram_row(a, bs):
    g = np.gcd(a, bs); h = a // g; k = bs // g
    Vhk = Vflat[off[k] + (h % k)]
    Vkh = Vflat[off[h] + (k % h)]
    val = c0 * (1.0/h + 1.0/k) + (k - h) / (2.0*h*k) * np.log(h / k) - np.pi / (2.0*h*k) * (Vhk + Vkh)
    return val / g

if __name__ == "__main__":
    idx = np.arange(1, N + 1, dtype=np.int64)
    G = np.empty((N, N))
    for a in range(1, N + 1):
        G[a - 1] = gram_row(a, idx)
    print("symmetry error:", np.abs(G - G.T).max())
    G = (G + G.T) / 2
    b = (np.log(idx) + 1 - EG) / idx
    L = np.linalg.cholesky(G)
    import scipy.linalg as sl
    y = sl.solve_triangular(L, b, lower=True)
    delta = y**2                    # Delta_N
    d2 = 1 - np.cumsum(delta)       # d_N^2
    np.save(f"delta_{N}.npy", delta); np.save(f"y_{N}.npy", y)
    print(f"total {time.time()-t0:.1f}s")
    for n in [1, 2, 3, 5, 10, 30, 100, 300, 1000, 2000, 3000, 5000]:
        if n <= N:
            print(f"N={n:5d}  d_N^2={d2[n-1]:.6f}  d_N^2*log N={d2[n-1]*np.log(max(n,2)):.5f}")
