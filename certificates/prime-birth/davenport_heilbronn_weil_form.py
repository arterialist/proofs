"""Control experiment: Weil's quadratic form for the Davenport-Heilbronn function, which has the functional equation of
an L-function, real coefficients, no Euler product, and known zeros off the critical line (first pair near
0.8085 + 85.699i). Completed function (5/pi)^(s/2) Gamma((s+1)/2) f(s), symmetric under s -> 1-s, no pole.
For g supported in [0, L]:
   sum over zeros 1/2 + i gamma of gh(gamma) conj(gh(conj gamma))
      = archimedean term - sum_n c(n) n^(-1/2) (A(log n) + A(-log n)),     -f'/f(s) = sum c(n) n^(-s).
Because zeros lie off the line, this form cannot stay positive for all L. The script reports its smallest eigenvalues
as L grows. Double precision, so eigenvalues within about 1e-13 of zero are numerical zeros.
Usage: python3 davenport_heilbronn_weil_form.py validate     (needs dh_zeros.npy from davenport_heilbronn_zeros_on_line.py)
       python3 davenport_heilbronn_weil_form.py L:K [L:K ...]   (K must reach frequency 2 pi K / L of about 110)

Outcome, 10 November 2026.
Validation at L = 1.5, K = 2: the diagonal from the formula exceeds the sum over the 169 zeros found on the line below
260 by 0.0127 to 0.0128 in every entry, which is the size of the omitted tail (estimate 0.017).
Smallest eigenvalue: 0.94 (L=0.5), 0.30 (L=1), 0.017 (L=1.5), 4.1e-5 (L=2), 7.6e-10 (L=2.5), 3e-16 (L=3),
numerical zero (L=3.5, K=62), then two negative eigenvalues: -0.73, -0.69 (L=4, K=70), -1.33, -1.32 (L=4.5, K=79),
-1.85, -1.85 (L=5, K=88). So this form looks positive, with the same fast decay as the zeta form, until 33 coefficients
are in, and fails once 54 are in. Positivity at short support does not distinguish a function that satisfies RH from
one that violates it at height 85. The threshold agrees with displaced_zero_positivity.py: L near
log(5 * 85.7 / 2 pi) = 4.2, less a margin that grows with the distance of the zero from the line."""
import numpy as np, sys, time
from scipy.integrate import quad
import weil_form as weil
EG = 0.5772156649015329
tanth = (np.sqrt(10 - 2 * np.sqrt(5)) - 2) / (np.sqrt(5) - 1)
A5 = {0: 0.0, 1: 1.0, 2: tanth, 3: -tanth, 4: -1.0}
def logder_coeffs(N):
    a = np.array([0.0] + [A5[n % 5] for n in range(1, N + 1)]); c = np.zeros(N + 1)
    for n in range(2, N + 1):
        s = a[n] * np.log(n)
        for d in range(2, n):
            if n % d == 0: s -= c[d] * a[n // d]
        c[n] = s
    return c
def matrix(L, K):
    idx = list(range(-K, K + 1)); n = len(idx); N = int(np.exp(L)); c = logder_coeffs(max(N, 2))
    Q = np.zeros((n, n), dtype=complex)
    ms = np.array([m for m in range(2, N + 1) if c[m] != 0 and np.log(m) < L]); us = np.log(ms) if len(ms) else np.array([]); cw = c[ms] / np.sqrt(ms) if len(ms) else np.array([])
    for a, j in enumerate(idx):
        for b, k in enumerate(idx):
            if b < a: continue
            A = weil.A_fun(j, k, L); d = 1.0 if j == k else 0.0
            f = lambda u, part: (lambda v: v.real if part == 0 else v.imag)((np.exp(-2 * u) * d - np.exp(-1.5 * u) * (A(u) + A(-u)) / 2) / (1 - np.exp(-2 * u)))
            re = quad(f, 0, L, args=(0,), limit=400, epsabs=1e-13, epsrel=1e-13)[0]
            im = 0.0 if j == k else quad(f, 0, L, args=(1,), limit=400, epsabs=1e-13, epsrel=1e-13)[0]
            val = (np.log(5 / np.pi) - EG) * d + 2 * (re + 1j * im - 0.5 * np.log(1 - np.exp(-2 * L)) * d)
            if len(ms):
                wj, wk = 2 * np.pi * j / L, 2 * np.pi * k / L; D = wj - wk
                if j == k: S = 2 * np.cos(wk * us) * (L - us) / L
                else: S = (np.exp(1j * wk * us) * (1 - np.exp(1j * D * us)) + np.exp(-1j * wk * us) * (np.exp(-1j * D * us) - 1)) / (1j * D * L)
                val -= (cw * S).sum()
            Q[a, b] = val; Q[b, a] = np.conj(val)
    return idx, Q
if __name__ == "__main__":
    if sys.argv[1] == "validate":
        L, K = 1.5, 2; idx, Q = matrix(L, K); zs = np.load("dh_zeros.npy")
        D = np.zeros_like(Q)
        for a, j in enumerate(idx):
            for b, k in enumerate(idx):
                D[a, b] = sum(weil.gh(j, g, L) * np.conj(weil.gh(k, g, L)) + weil.gh(j, -g, L) * np.conj(weil.gh(k, -g, L)) for g in zs)
        print(f"validation L={L} K={K}: formula versus partial sum over the {len(zs)} zeros found on the line (tail and off-line zeros omitted)")
        print("  diagonal, formula:", np.round(np.diag(Q).real, 4)); print("  diagonal, zeros  :", np.round(np.diag(D).real, 4))
        print("  max |off-diagonal difference|:", float(np.abs(Q - D)[~np.eye(len(idx), dtype=bool)].max()))
    else:
        t0 = time.time(); c = logder_coeffs(30)
        print("first coefficients c(n) of -f'/f:", " ".join(f"{n}:{c[n]:+.3f}" for n in range(2, 13)))
        print("    L    | K  | terms n < e^L | five smallest eigenvalues")
        for L, K in [(float(a), int(b)) for a, b in (s.split(":") for s in sys.argv[1:])]:
            idx, Q = matrix(L, K); ev = np.linalg.eigvalsh(Q)
            print(f"  {L:5.2f}  | {K:2d} | {int(np.exp(L)):5d}         | " + "  ".join(f"{e:+.3e}" for e in ev[:5]) + f"   ({time.time()-t0:.0f}s)", flush=True)
