"""Tools for the mirror model. F(t) = Re( e^(i theta(t)) * exp(L(t)) ),  L(t) = sum_n c_n n^(-kappa - i t),
with c_n = Lambda(n)/log n * weight(n) over prime powers n <= X (so exp(L) is the Euler product when weight = 1).
Phase Phi(t) = theta(t) + Im L(t);  speed v(t) = theta'(t) + d/dt Im L(t) = theta'(t) - Re sum_n c_n log n * n^(-kappa - i t)."""
import numpy as np

def theta(t):
    return t / 2 * np.log(t / (2 * np.pi)) - t / 2 - np.pi / 8 + 1 / (48 * t) + 7 / (5760 * t**3)
def theta_prime(t):
    return 0.5 * np.log(t / (2 * np.pi)) - 1 / (48 * t**2)

_sieve_cache = {}
def prime_powers(X):
    """return arrays n, Lambda(n)/log n for prime powers n <= X"""
    if X in _sieve_cache: return _sieve_cache[X]
    s = np.ones(X + 1, dtype=bool); s[:2] = False
    for i in range(2, int(X**0.5) + 1):
        if s[i]: s[i*i::i] = False
    ps = np.nonzero(s)[0]
    ns = [ps.astype(np.float64)]; cs = [np.ones(len(ps))]
    for p in ps[ps <= int(X**0.5)]:
        q = int(p) * int(p); k = 2
        while q <= X:
            ns.append(np.array([float(q)])); cs.append(np.array([1.0 / k])); q *= int(p); k += 1
    n = np.concatenate(ns); c = np.concatenate(cs); o = np.argsort(n)
    _sieve_cache[X] = (n[o], c[o]); return _sieve_cache[X]

def weights(n, X, kind):
    if kind == "sharp": return np.ones(len(n))
    if kind == "fejer": return 1 - np.log(n) / np.log(X)
    if kind == "sq": return (1 - np.log(n) / np.log(X)) ** 2
    raise ValueError(kind)

def L_and_speed(ts, X, kappa=0.5, kind="sharp", chunk=400):
    n, c = prime_powers(X); w = c * weights(n, X, kind); ln = np.log(n); amp = w * n ** (-kappa)
    L = np.zeros(len(ts), dtype=complex); D = np.zeros(len(ts))
    for a in range(0, len(n), chunk):
        E = np.exp(-1j * np.outer(ts, ln[a:a+chunk])) * amp[a:a+chunk][None, :]
        L += E.sum(axis=1); D += (E.real * ln[a:a+chunk][None, :]).sum(axis=1)
    return L, D     # speed = theta'(t) - D

def crossings(ts, X, kappa=0.5, kind="sharp"):
    L, D = L_and_speed(ts, X, kappa, kind)
    F = np.real(np.exp(1j * theta(ts) + L))
    idx = np.nonzero(np.sign(F[1:]) != np.sign(F[:-1]))[0]
    v = theta_prime(ts) - D
    zeros = ts[idx] - F[idx] * (ts[idx + 1] - ts[idx]) / (F[idx + 1] - F[idx])
    return zeros, v[idx], v

def expected_count(t1, t2):
    """number of zeta zeros with t1 < gamma < t2 predicted by the smooth formula theta/pi (no S(t) term)"""
    return (theta(np.array([t2]))[0] - theta(np.array([t1]))[0]) / np.pi
