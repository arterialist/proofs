import numpy as np, sys
N = int(sys.argv[1])
delta = np.load(f"delta_{N}.npy"); y = np.load(f"y_{N}.npy")
n = np.arange(1, N + 1)
# arithmetic data
mu = np.ones(N + 1, dtype=int); omega = np.zeros(N + 1, dtype=int); isp = np.ones(N + 1, dtype=bool); isp[:2] = False
for p in range(2, N + 1):
    if isp[p]:
        isp[2*p::p] = False
        mu[p::p] *= -1; omega[p::p] += 1
        mu[p*p::p*p] = 0
mu = mu[1:]; omega = omega[1:]; isp = isp[1:]
d2 = 1 - np.cumsum(delta)
print("first 30 steps:  n, mu(n), y_n, Delta_n")
for i in range(30):
    print(f"{i+1:3d} {mu[i]:+d} {y[i]:+.6f} {delta[i]:.3e}")
print()
print("budget released by step N (1 - d_N^2):", 1 - d2[-1], "  d_N^2 =", d2[-1], " d_N^2 log N =", d2[-1]*np.log(N))
tot = delta.sum()
for name, mask in [("n=1", n == 1), ("primes", isp), ("squarefree, 2 primes", (mu != 0) & (omega == 2)),
                   ("squarefree, 3+ primes", (mu != 0) & (omega >= 3)), ("not squarefree", mu == 0)]:
    print(f"{name:24s} count={mask.sum():5d}  share of released budget={delta[mask].sum()/tot:.6f}  sum Delta={delta[mask].sum():.6e}")
print()
# sign of y_n against mu(n), for n >= 2
m = n >= 2
agree = (np.sign(y[m]) == -mu[m]) & (mu[m] != 0)
print("sign(y_n) == -mu(n) among squarefree n>=2:", agree.sum(), "of", (mu[m] != 0).sum())
agree2 = (np.sign(y[m]) == mu[m]) & (mu[m] != 0)
print("sign(y_n) == +mu(n) among squarefree n>=2:", agree2.sum())
# scaled size by class in the top half of the range
top = n > N // 2
sc = delta * n * np.log(n + 1)**2
ys = y * np.sqrt(n) * np.log(n + 1)
for name, mask in [("primes", isp), ("sqfree 2 primes", (mu != 0) & (omega == 2)), ("sqfree 3+ primes", (mu != 0) & (omega >= 3)),
                   ("not squarefree", mu == 0)]:
    mm = mask & top
    print(f"{name:18s} mean Delta*n*log^2 n = {sc[mm].mean():.5f}   median = {np.median(sc[mm]):.5f}   mean y*sqrt(n)*log n = {ys[mm].mean():+.5f}  sd = {ys[mm].std():.5f}")
# correlation of y_n sqrt(n) log n with mu(n)
print("corr(y_n*sqrt(n)*log n, mu(n)) over top half:", np.corrcoef(ys[top], mu[top])[0, 1])
# Mertens function for the cloud picture
M = np.cumsum(mu)
for k in [100, 1000, N]:
    print(f"M({k}) = {M[k-1]}")
