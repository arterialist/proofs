"""Weil's quadratic form on test functions supported in [0, L], built from the primes below e^L.
For g on [0, L] with gh(t) = int g(u) e^{itu} du, the explicit formula gives
  sum over zeros rho = 1/2 + i gamma of gh(gamma) conj(gh(conj gamma))
    = pole terms + archimedean term - sum_n Lambda(n) n^(-1/2) (A(log n) + A(-log n)),   A(u) = int g(v) conj(g(v-u)) dv.
If RH holds the left side is sum |gh(gamma)|^2 >= 0, so the form is positive semidefinite for every L.
Basis: g_k(u) = e^{2 pi i k u / L}/sqrt(L), k = -K..K."""
import numpy as np, mpmath as mp
from scipy.integrate import quad
EG = 0.5772156649015329
def A_fun(j, k, L):
    wj, wk = 2 * np.pi * j / L, 2 * np.pi * k / L; D = wj - wk
    def A(u):
        if abs(u) >= L: return 0.0 + 0j
        if j == k: I = L - abs(u)
        elif u >= 0: I = (1 - np.exp(1j * D * u)) / (1j * D)
        else: I = (np.exp(1j * D * u) - 1) / (1j * D)
        return np.exp(1j * wk * u) * I / L
    return A
def gh(j, z, L):
    w = 2 * np.pi * j / L
    return (np.exp(1j * (z + w) * L) - 1) / (1j * (z + w) * np.sqrt(L))
def prime_powers_upto(x):
    out = []
    for p in range(2, int(x) + 1):
        if all(p % r for r in range(2, int(p**0.5) + 1)):
            q = p
            while q <= x: out.append((q, np.log(p))); q *= p
    return out
def matrices(L, K):
    idx = list(range(-K, K + 1)); n = len(idx)
    pole = np.zeros((n, n), dtype=complex); arch = np.zeros((n, n), dtype=complex)
    prime = {}                                        # contribution of each prime (all its powers), to be subtracted
    pp = prime_powers_upto(np.exp(L))
    for a, j in enumerate(idx):
        for b, k in enumerate(idx):
            A = A_fun(j, k, L); d = 1.0 if j == k else 0.0
            pole[a, b] = gh(j, 0.5j, L) * np.conj(gh(k, -0.5j, L)) + gh(j, -0.5j, L) * np.conj(gh(k, 0.5j, L))
            f = lambda u, part: (lambda v: v.real if part == 0 else v.imag)((np.exp(-2 * u) * d - np.exp(-u / 2) * (A(u) + A(-u)) / 2) / (1 - np.exp(-2 * u)))
            re = quad(f, 0, L, args=(0,), limit=400, epsabs=1e-13, epsrel=1e-13)[0]
            im = quad(f, 0, L, args=(1,), limit=400, epsabs=1e-13, epsrel=1e-13)[0]
            tail = -0.5 * np.log(1 - np.exp(-2 * L)) * d
            arch[a, b] = -(EG + np.log(np.pi)) * d + 2 * (re + 1j * im + tail)
    for q, lp in pp:
        p = int(round(np.exp(lp)))
        M = prime.setdefault(p, np.zeros((n, n), dtype=complex))
        for a, j in enumerate(idx):
            for b, k in enumerate(idx):
                A = A_fun(j, k, L); u = np.log(q)
                M[a, b] += lp / np.sqrt(q) * (A(u) + A(-u))
    return idx, pole, arch, prime
if __name__ == "__main__":
    # validation against a direct sum over zeros
    L, K = 2.0, 2
    idx, pole, arch, prime = matrices(L, K)
    Q = pole + arch - sum(prime.values())
    zs = [float(mp.im(mp.zetazero(n))) for n in range(1, 301)]
    direct = np.zeros_like(Q)
    for a, j in enumerate(idx):
        for b, k in enumerate(idx):
            direct[a, b] = sum(gh(j, g, L) * np.conj(gh(k, g, L)) + gh(j, -g, L) * np.conj(gh(k, -g, L)) for g in zs)
    print("validation, L=2, K=2: explicit-formula matrix vs partial sum over the first 300 zeros (tail of the sum is about 0.003)")
    print("  diagonal, formula:", np.round(np.diag(Q).real, 4)); print("  diagonal, zeros  :", np.round(np.diag(direct).real, 4))
    print("  max |off-diagonal difference|:", float(np.abs(Q - direct)[~np.eye(len(idx), dtype=bool)].max()))
    print("  Hermitian defect:", float(np.abs(Q - Q.conj().T).max()), " eigenvalues:", np.round(np.linalg.eigvalsh((Q + Q.conj().T) / 2), 6))
