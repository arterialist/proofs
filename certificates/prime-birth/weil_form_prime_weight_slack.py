"""Weil's quadratic form on [0, L] in multiprecision: smallest eigenvalue and the slack in each prime's weight.
Same construction as weil_form.py (validated there against a sum over zeros), with mpmath at 60 digits.
The slack of a prime p is the range of changes to its weight log p (all powers together, other primes fixed) that
keeps the form positive semidefinite on the 2K+1 test functions.

Outcome, 10 November 2026. Smallest eigenvalue: 1.6e-6 (L=1, K=4), 5.4e-11 (L=1.5, K=4), 2.6e-13 (L=2, K=4),
2.0e-16 (L=2, K=6), 3.5e-19 (L=2.5, K=6), 4.7e-21 (L=3, K=6). These still fall as K grows (1.0e-21 at L=2, K=10 and
3.7e-25 at K=14, see weil_lowest_eigenvector_zeros.py), so the column e^(-14.1347 L) is only a reference scale and not
a fit. Slack at L=3, K=6, as a fraction of the weight: prime 2 from -4.1e-18 to +1.8e-20, prime 3 from -7.1e-18 to
+1.1e-19, prime 5 about 1e-16, prime 7 about 1e-15, prime 11 about 1e-11, prime 13 about 1e-10, prime 17 about 1e-6,
prime 19 about 0.5 percent. This assumes nothing: it is a computation with the true primes, and positive eigenvalues
here are consistent with RH but test it only at low height (see displaced_zero_positivity.py)."""
import mpmath as mp, time, sys
mp.mp.dps = 60
def build(L, K):
    L = mp.mpf(L); idx = list(range(-K, K + 1)); n = len(idx)
    w = {k: 2 * mp.pi * k / L for k in idx}
    def A(j, k, u):
        if abs(u) >= L: return mp.mpc(0)
        D = w[j] - w[k]
        if j == k: I = L - abs(u)
        elif u >= 0: I = (1 - mp.exp(1j * D * u)) / (1j * D)
        else: I = (mp.exp(1j * D * u) - 1) / (1j * D)
        return mp.exp(1j * w[k] * u) * I / L
    def gh(j, z): return (mp.exp(1j * (z + w[j]) * L) - 1) / (1j * (z + w[j]) * mp.sqrt(L))
    Q = mp.matrix(n, n); B = {}
    pps = []
    for p in range(2, int(mp.exp(L)) + 1):
        if all(p % r for r in range(2, int(p**0.5) + 1)):
            q = p
            while q <= mp.exp(L): pps.append((p, q)); q *= p
    half = mp.mpc(0, 0.5)
    for a, j in enumerate(idx):
        for b, k in enumerate(idx):
            if b < a: continue
            d = 1 if j == k else 0
            pole = gh(j, half) * mp.conj(gh(k, -half)) + gh(j, -half) * mp.conj(gh(k, half))
            f = lambda u: (mp.exp(-2 * u) * d - mp.exp(-u / 2) * (A(j, k, u) + A(j, k, -u)) / 2) / (1 - mp.exp(-2 * u))
            arch = -(mp.euler + mp.log(mp.pi)) * d + 2 * (mp.quad(f, mp.linspace(0, L, 9)) - mp.log(1 - mp.exp(-2 * L)) * d / 2)
            val = pole + arch
            for p, q in pps:
                t = mp.log(p) / mp.sqrt(q) * (A(j, k, mp.log(q)) + A(j, k, -mp.log(q)))
                M = B.setdefault(p, mp.matrix(n, n)); M[a, b] = M[a, b] + t
                if a != b: M[b, a] = M[b, a] + mp.conj(t)
                val -= t
            Q[a, b] = val
            if a != b: Q[b, a] = mp.conj(val)
    return Q, B
t0 = time.time()
print("    L (primes below) | K | smallest eigenvalue | reference scale e^(-14.1347 L) | slack in weight of each prime: down, up")
for L, K in [(1.0, 4), (1.5, 4), (2.0, 4), (2.0, 6), (2.5, 6), (3.0, 6)]:
    Q, B = build(L, K)
    ev = mp.eigh(Q, eigvals_only=True)
    lam = min(ev)
    out = []
    for p in sorted(B):
        try:
            vals = mp.eig(mp.inverse(B[p]) * Q, left=False, right=False)
            re = [v.real for v in vals if abs(v.imag) < mp.mpf(10) ** -30 * (1 + abs(v.real))]
            up = min([v for v in re if v > 0], default=mp.inf); dn = max([v for v in re if v < 0], default=-mp.inf)
            out.append(f"p={p}: {mp.nstr(dn, 3)}, {mp.nstr(up, 3)}")
        except Exception as e:
            out.append(f"p={p}: failed ({type(e).__name__})")
    print(f"{L:5.1f} ({float(mp.exp(L)):6.1f})      | {K} | {mp.nstr(lam, 4):>19s} | {mp.nstr(mp.exp(-mp.mpf('14.1347') * L), 3):>10s} | " + "   ".join(out) + f"   ({time.time()-t0:.0f}s)", flush=True)
