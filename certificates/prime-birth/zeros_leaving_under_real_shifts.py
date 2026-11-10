"""Just past the critical point. The family Xi(t + i a) + Xi(t - i a), parametrized by tau = a^2:
  tau >= 1/4 : all zeros real (de Bruijn 1950, unconditional);  0 <= tau < 1/4 : all zeros real iff no zeta zero with
  real part > 1/2 + a;  tau < 0 means a real shift b: Xi(t + b) + Xi(t - b).
A pair of real zeros with gap g becomes complex once b exceeds about g/2. Count how many zeros leave the real axis
below height T for small real shifts b, using Xi(t) = -w(t) Z(t), w(t) = (t^2 + 1/4)/2 * pi^(-1/4) |Gamma(1/4 + i t/2)|."""
import numpy as np
from scipy.special import loggamma
import mirror as m  # mirror.py in this folder
T = 20000.0
ts = np.arange(12.0, T, 0.004)
def rs_Z(t):
    a = np.sqrt(t / (2 * np.pi)); N = np.floor(a).astype(int); p = a - N
    Z = np.zeros(len(t)); th = m.theta(t)
    for n in range(1, N.max() + 1):
        Z += np.where(n <= N, 2 * np.cos(th - t * np.log(n)) / np.sqrt(n), 0.0)
    psi = np.cos(2 * np.pi * (p * p - p - 1 / 16)) / np.cos(2 * np.pi * p)
    return Z + (-1.0) ** (N - 1) * (t / (2 * np.pi)) ** -0.25 * psi
def logw(t): return np.log((t * t + 0.25) / 2) + np.real(loggamma(0.25 + 0.5j * t))
Z0 = rs_Z(ts)
n0 = int(np.count_nonzero(np.sign(Z0[1:]) != np.sign(Z0[:-1])))
gaps = np.diff(ts[np.nonzero(np.sign(Z0[1:]) != np.sign(Z0[:-1]))[0]])
print(f"zeros of Z in (12, {T:g}): {n0};  smallest gaps: {np.round(np.sort(gaps)[:5], 4)}")
print(" real shift b | tau = -b^2 | real zeros | zeros that left the real axis")
for b in [0.01, 0.02, 0.03, 0.05, 0.08, 0.12, 0.2, 0.3, 0.5]:
    k = int(round(b / 0.004))
    tm = ts[k:-k]
    # Xi(t+b) + Xi(t-b) up to the common positive factor w(t): ratio of weights w(t+b)/w(t), w(t-b)/w(t)
    G = np.exp(logw(tm + b) - logw(tm)) * Z0[2 * k:] + np.exp(logw(tm - b) - logw(tm)) * Z0[: -2 * k]
    n = int(np.count_nonzero(np.sign(G[1:]) != np.sign(G[:-1])))
    print(f" {k*0.004:12.3f} | {-(k*0.004)**2:10.5f} | {n:10d} | {n0 - n}")
