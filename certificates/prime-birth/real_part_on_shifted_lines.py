"""Idea: averaging that provably pins zeros (de Bruijn 1950).
H_a(t) = Xi(t + i a) + Xi(t - i a) = 2 Re xi(1/2 + a + i t).
Theorem (de Bruijn): if all zeros of Xi lie in |Im| <= D then all zeros of H_a lie in |Im| <= sqrt(max(D^2 - a^2, 0)).
Unconditionally D <= 1/2, so for a >= 1/2 every zero of H_a is real. RH <=> the same for every a > 0.
Watch the real zeros of H_a slide to the zeta zeros as a decreases from 1 to 0."""
import numpy as np, mpmath as mp
from scipy.special import loggamma
mp.mp.dps = 20
ts = np.arange(5.0, 100.0, 0.01)
def phase(a):
    s = 0.5 + a + 1j * ts
    logarch = np.log(s) + np.log(s - 1) - (s / 2) * np.log(np.pi) + loggamma(s / 2)     # log of s(s-1) pi^(-s/2) Gamma(s/2)
    z = np.array([complex(mp.zeta(complex(x))) for x in s])
    return np.imag(logarch) + np.angle(z), np.abs(z)
true = [14.1347, 21.0220, 25.0109, 30.4249, 32.9351, 37.5862, 40.9187, 43.3271, 48.0052, 49.7738]
print("true zeros:", " ".join(f"{z:8.3f}" for z in true), " ... 29 below 100")
for a in [2.0, 1.0, 0.5, 0.25, 0.1, 0.03, 0.01]:
    ph, _ = phase(a)
    F = np.cos(ph)                                        # sign of Re xi(1/2 + a + it)
    idx = np.nonzero(np.sign(F[1:]) != np.sign(F[:-1]))[0]
    zs = ts[idx] - F[idx] * 0.01 / (F[idx + 1] - F[idx])
    sp = np.diff(zs) * np.log(zs[:-1] / (2 * np.pi)) / (2 * np.pi)
    print(f"a={a:5.2f}: {len(zs):2d} real zeros below 100; first ten:", " ".join(f"{z:8.3f}" for z in zs[:10]), f"  spacing variance {sp.var():.3f}")
