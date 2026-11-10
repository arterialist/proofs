"""Off-line zeros of the mirror model by sigma band, for sharp and soft (Fejer) births.
zeta_X(s) = exp(L(s)) + chi(s) conj(exp(L(1 - conj s))),  L(s) = sum_{prime powers n<=X} (Lambda(n)/log n) w(n) n^(-s).
With a finite sum L the function exp(L) is entire, so winding numbers count zeros (no poles to cancel them).

Outcome, 10 November 2026, zeros with 9.3 < t < 199.7 in the bands (0.5005,0.55), (0.55,0.6), (0.6,0.7), (0.7,0.8),
(0.8,0.9), (0.9,1.0); a question mark is a count the contour integration did not resolve to an integer:
  sharp cutoff X=100:    0, 0, 0, 0, 22, 74
  sharp cutoff X=1000:   0, 0, 0, 48, 154, 209?
  sharp cutoff X=10000:  0, 2, 56, 322, 579, 1362?
  Fejer weights X=100:   0, 0, 0, 0, 0, 0
  Fejer weights X=1000:  0, 0, 0, 0, 0, 0
  Fejer weights X=10000: 0, 0, 0, 0, 0, 144?
So the sharp-cutoff model has many zeros off the line and they move toward the line as X grows. The model is not a
family of functions with all zeros on the line, and nothing here bears on RH."""
import numpy as np, sys, time
from scipy.special import loggamma
import mirror as m
def model(s, X, kind, chunk=100):
    n, c = m.prime_powers(X); w = c * m.weights(n, X, kind); ln = np.log(n)
    out = np.empty(len(s), dtype=complex)
    for a in range(0, len(s), 4000):
        ss = s[a:a+4000]; s2 = 1 - np.conj(ss)
        L1 = np.zeros(len(ss), dtype=complex); L2 = np.zeros(len(ss), dtype=complex)
        for b in range(0, len(n), chunk):
            L1 += (np.exp(-np.outer(ss, ln[b:b+chunk])) * w[b:b+chunk][None, :]).sum(axis=1)
            L2 += (np.exp(-np.outer(s2, ln[b:b+chunk])) * w[b:b+chunk][None, :]).sum(axis=1)
        logchi = (ss - 0.5) * np.log(np.pi) + loggamma((1 - ss) / 2) - loggamma(ss / 2)
        out[a:a+4000] = np.exp(L1) + np.exp(logchi) * np.conj(np.exp(L2))
    return out
def wind(X, kind, s_lo, s_hi, t_lo, t_hi, nv, nh):
    path = np.concatenate([np.linspace(s_lo, s_hi, nh) + 1j * t_lo, s_hi + 1j * np.linspace(t_lo, t_hi, nv),
                           np.linspace(s_hi, s_lo, nh) + 1j * t_hi, s_lo + 1j * np.linspace(t_hi, t_lo, nv), [s_lo + 1j * t_lo]])
    d = np.diff(np.angle(model(path, X, kind))); d = (d + np.pi) % (2 * np.pi) - np.pi
    return int(round(d.sum() / (2 * np.pi))), np.abs(d).max()
if __name__ == "__main__":
    t_lo, t_hi = float(sys.argv[1]), float(sys.argv[2])
    Xs = [int(float(x)) for x in sys.argv[3].split(",")]
    kinds = sys.argv[4].split(",")
    bands = [(0.5005, 0.55), (0.55, 0.6), (0.6, 0.7), (0.7, 0.8), (0.8, 0.9), (0.9, 1.0)]
    t0 = time.time()
    print(f"zeros of the mirror model by sigma band, {t_lo} < t < {t_hi}")
    for kind in kinds:
        for X in Xs:
            row = []
            nv = int(max(60000, (t_hi - t_lo) * 400 * max(1, np.log(X) / 4)))
            for (a, b) in bands:
                w, mx = wind(X, kind, a, b, t_lo, t_hi, nv, 6000); row.append(f"{w:4d}" + ("?" if mx > 2.6 else " "))
            print(f"{kind:5s} X={X:7d}: " + " | ".join(f"({a},{b}): {r}" for (a, b), r in zip(bands, row)) + f"   ({time.time()-t0:.0f}s)", flush=True)
