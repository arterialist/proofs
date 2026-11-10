"""Locate the off-line zeros of the mirror model zeta_X(s) = P_X(s) + chi(s) conj(P_X(1 - conj s)) in 1/2 < sigma < 1."""
import numpy as np, sys
from scipy.special import loggamma
def primes_upto(X): return [p for p in range(2, X + 1) if all(p % r for r in range(2, int(p**0.5) + 1))]
def model(s, logps):
    s = np.asarray(s, dtype=complex); shp = s.shape; s = s.ravel(); out = np.empty(len(s), dtype=complex)
    for a in range(0, len(s), 20000):
        ss = s[a:a+20000]; s2 = 1 - np.conj(ss)
        lp = -np.log(1 - np.exp(-np.outer(ss, logps))).sum(axis=1)
        lq = -np.log(1 - np.exp(-np.outer(s2, logps))).sum(axis=1)
        logchi = (ss - 0.5) * np.log(np.pi) + loggamma((1 - ss) / 2) - loggamma(ss / 2)
        out[a:a+20000] = np.exp(lp) + np.exp(logchi) * np.conj(np.exp(lq))
    return out.reshape(shp)
def find(X, t_lo, t_hi, s_lo=0.502, s_hi=0.985):
    logps = np.log(np.array(primes_upto(X), dtype=float))
    sig = np.arange(s_lo, s_hi, 0.003); tt = np.arange(t_lo, t_hi, 0.006)
    S, T = np.meshgrid(sig, tt, indexing="ij")
    A = np.abs(model(S + 1j * T, logps))
    inner = A[1:-1, 1:-1]
    mask = (inner < A[:-2, 1:-1]) & (inner < A[2:, 1:-1]) & (inner < A[1:-1, :-2]) & (inner < A[1:-1, 2:])
    cand = np.argwhere(mask); zs = []
    for i, j in cand:
        z = complex(sig[i + 1], tt[j + 1])
        for _ in range(40):                                  # Newton with numerical derivative
            f = model(np.array([z]), logps)[0]; h = 1e-6
            d = (model(np.array([z + h]), logps)[0] - model(np.array([z - h]), logps)[0]) / (2 * h)
            if d == 0: break
            step = f / d
            if abs(step) > 0.05: step *= 0.05 / abs(step)
            z -= step
            if abs(step) < 1e-11: break
        if abs(model(np.array([z]), logps)[0]) < 1e-8 and s_lo - 0.001 < z.real < 1.0 and t_lo <= z.imag <= t_hi:
            if all(abs(z - w) > 1e-5 for w in zs): zs.append(z)
    return np.array(zs)
if __name__ == "__main__":
    for X in [11, 31, 101]:
        zs = find(X, 9.3, 199.7)
        r = zs.real
        print(f"primes <= {X:4d}: off-line zeros found with 0.502 < sigma < 1, 9.3 < t < 199.7: {len(zs)};  "
              f"sigma < 0.6: {(r<0.6).sum()}, 0.6-0.8: {((r>=0.6)&(r<0.8)).sum()}, 0.8-0.9: {((r>=0.8)&(r<0.9)).sum()}, 0.9-1: {(r>=0.9).sum()};  smallest sigma {r.min():.4f} at t={zs[np.argmin(r)].imag:.2f}", flush=True)
        # by height
        for lo, hi in [(9.3, 50), (50, 100), (100, 150), (150, 199.7)]:
            m = (zs.imag >= lo) & (zs.imag < hi)
            print(f"      t in [{lo},{hi}): {m.sum()} zeros, of which sigma < 0.9: {(m & (r < 0.9)).sum()}")
