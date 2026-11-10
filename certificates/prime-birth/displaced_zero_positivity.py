"""How long must the support be before one off-line zero pair breaks Weil positivity?
Synthetic test on the zero side. Take the zeta zeros below height TMAX (Riemann-Siegel, accurate to about 1e-3, which
is enough here), pick the two neighbouring zeros closest to height T0, and replace them by a pair off the line at their
midpoint: real parts 1/2 +- delta. The form  Q(g) = sum over zeros of gh(gamma) conj(gh(conj gamma))  on functions g
supported in [0, L] is then no longer a sum of squares. For each L the script reports the smallest eigenvalue of Q on
the span of e^{2 pi i k u/L} with frequency within W of +-T0 (a subspace, so a negative value here is a true negative).
Heuristic to test: functions supported in an interval of length L have Fourier transforms that can vanish on at most
L/(2 pi) points per unit length, and the zeros near T0 have log(T0/2 pi)/(2 pi) per unit length, so the pair should stay
invisible until L is near log(T0 / 2 pi).

Outcome, 10 November 2026. First L (step 0.25) with an eigenvalue below -1e-9, next to log(T0/2 pi):
  T0 = 49:   1.75 (delta 0.1), 1.75 (delta 0.3);  log = 2.05
  T0 = 100:  2.75, 2.50;  log = 2.77
  T0 = 200:  3.50, 3.25;  log = 3.46
  T0 = 401:  4.25, 3.50;  log = 4.16
  T0 = 801:  4.75, 4.25;  log = 4.85
  T0 = 1600: 5.50, 4.50;  log = 5.54
Past the threshold the negative eigenvalue is of order delta and grows with L. Below it the form is positive to
double precision. Reading: positivity for support length L, which uses the primes below e^L, tests RH only up to height
about 2 pi e^L. This is a numerical observation on a synthetic zero set, with a 1e-9 detection floor. It is not a theorem."""
import numpy as np, sys
import mirror as m
def rs_Z(t):
    a = np.sqrt(t / (2 * np.pi)); N = np.floor(a).astype(int); p = a - N
    Z = np.zeros(len(t)); th = m.theta(t)
    for n in range(1, N.max() + 1):
        Z += np.where(n <= N, 2 * np.cos(th - t * np.log(n)) / np.sqrt(n), 0.0)
    return Z + (-1.0) ** (N - 1) * (t / (2 * np.pi)) ** -0.25 * np.cos(2 * np.pi * (p * p - p - 1 / 16)) / np.cos(2 * np.pi * p)
TMAX = 3000.0; ts = np.arange(12.0, TMAX, 0.002); Z = rs_Z(ts)
i = np.nonzero(np.sign(Z[1:]) != np.sign(Z[:-1]))[0]
zeros = ts[i] - Z[i] * (ts[i + 1] - ts[i]) / (Z[i + 1] - Z[i])
print(f"{len(zeros)} zeros below {TMAX:g}; first: {np.round(zeros[:3], 3)}")
def vec(freqs, z, L):                                   # Fourier transforms of e^{i w u}/sqrt(L) on [0, L] at the points z
    x = z[None, :] + freqs[:, None]
    return (np.exp(1j * x * L) - 1) / (1j * x * np.sqrt(L))
def lam_min(L, T0, delta, W=45.0):
    k = np.arange(int(np.floor((T0 - W) * L / (2 * np.pi))), int(np.ceil((T0 + W) * L / (2 * np.pi))) + 1)
    fr = 2 * np.pi * np.concatenate([k, -k]) / L
    j = int(np.argmin(np.abs(0.5 * (zeros[:-1] + zeros[1:]) - T0))); mid = 0.5 * (zeros[j] + zeros[j + 1])
    keep = np.delete(zeros, [j, j + 1]); real = np.concatenate([keep, -keep])
    G = vec(fr, real.astype(complex), L); M = G @ G.conj().T
    for sgn in (1, -1):
        a = vec(fr, np.array([sgn * mid + 1j * delta]), L)[:, 0]; b = vec(fr, np.array([sgn * mid - 1j * delta]), L)[:, 0]
        M += np.outer(a, b.conj()) + np.outer(b, a.conj())
    return np.linalg.eigvalsh((M + M.conj().T) / 2)[0], mid
Ls = np.arange(1.0, 9.01, 0.25)
print("smallest eigenvalue by L (values within 1e-9 of zero are numerical zeros)")
for T0 in [50.0, 100.0, 200.0, 400.0, 800.0, 1600.0]:
    for delta in [0.1, 0.3]:
        vals = [lam_min(L, T0, delta) for L in Ls]; mid = vals[0][1]; lam = np.array([v[0] for v in vals])
        neg = Ls[lam < -1e-9]; first = neg[0] if len(neg) else float("nan")
        prof = " ".join(f"{L:g}:{x:.1e}" for L, x in zip(Ls, lam) if x < -1e-9)[:150]
        print(f"T0={mid:8.2f} delta={delta}: first L with a negative eigenvalue {first:5.2f};  log(T0/2pi) = {np.log(mid/(2*np.pi)):.2f};  {prof}", flush=True)
