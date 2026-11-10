"""Experiment A. Take the transition sizes Lambda(n) (log p at prime powers),
subtract the clock, normalise by sqrt(x), and Fourier transform in log-time.

Signal: f(u) = (psi(e^u) - e^u) / e^(u/2), 0 <= u <= U = log X.
F(g) = int_0^U f(u) e^{-i g u} du, computed exactly from the step function psi:
  F(g) = (1/s) [ sum_{n<=X} Lambda(n) n^{-s} - psi(X) X^{-s} ] - (X^{1-s} - 1)/(1-s),  s = 1/2 + i g.
No zeta zeros are used as input.
"""
import numpy as np, sys

X = int(float(sys.argv[1])) if len(sys.argv) > 1 else 10**6

# sieve
sieve = np.ones(X + 1, dtype=bool); sieve[:2] = False
for i in range(2, int(X**0.5) + 1):
    if sieve[i]:
        sieve[i*i::i] = False
primes = np.nonzero(sieve)[0]
ns, lam = [], []
for p in primes:
    q = int(p); lp = np.log(p)
    while q <= X:
        ns.append(q); lam.append(lp); q *= int(p)
        if p > X**0.5: break
ns = np.array(ns, dtype=np.float64); lam = np.array(lam)
order = np.argsort(ns); ns = ns[order]; lam = lam[order]
logn = np.log(ns); psiX = lam.sum(); U = np.log(X)
print(f"X={X}  prime powers={len(ns)}  psi(X)={psiX:.3f}  psi(X)-X={psiX-X:.3f}  U=log X={U:.4f}")

gs = np.arange(0.5, 60.0, 0.005)
F = np.empty(len(gs), dtype=complex)
w = lam / np.sqrt(ns)
B = 400
for i in range(0, len(gs), B):
    g = gs[i:i+B][:, None]
    D = (w[None, :] * np.exp(-1j * g * logn[None, :])).sum(axis=1)
    s = 0.5 + 1j * gs[i:i+B]
    F[i:i+B] = (D - psiX * np.exp(-s * U)) / s - (np.exp((1 - s) * U) - 1) / (1 - s)

A = np.abs(F)
# local maxima above a threshold
idx = [i for i in range(1, len(A) - 1) if A[i] > A[i-1] and A[i] >= A[i+1]]
idx = sorted(idx, key=lambda i: -A[i])[:14]
true = [14.134725, 21.022040, 25.010858, 30.424876, 32.935062, 37.586178,
        40.918719, 43.327073, 48.005151, 49.773832, 52.970321, 56.446248, 59.347044]
print("\npeak g   | nearest zero | diff    | height | height*|rho|/U (1.0 = lossless mode of weight 1)")
for i in sorted(idx, key=lambda i: gs[i]):
    g = gs[i]; t = min(true, key=lambda z: abs(z - g))
    rho = abs(0.5 + 1j * t)
    print(f"{g:7.3f}  | {t:10.6f}   | {g-t:+.3f}  | {A[i]:6.3f} | {A[i]*rho/U:.3f}")
print("\nmedian |F| off-peak:", float(np.median(A)))
