"""Symmetry without an Euler product: the Davenport-Heilbronn function.
f(s) = (1/2) sec(th) [ e^(-i th) L(s, chi) + e^(i th) L(s, chi-bar) ],  chi the character mod 5 with chi(2) = i,
tan(th) = (sqrt(10 - 2 sqrt 5) - 2)/(sqrt 5 - 1). It satisfies the same kind of functional equation as an L-function,
has real coefficients, has NO Euler product, and is known to have zeros off the critical line.
Completed function Lam(s) = (5/pi)^((s+1)/2) Gamma((s+1)/2) f(s), with Lam(s) = Lam(1-s), real on the critical line.
W_kappa(t) = Re Lam(kappa + i t). Count its real zeros below height 120 as kappa decreases to 1/2. For zeta the
matching count stays constant for every kappa >= 1/2 tested (real_part_on_shifted_lines.py); here it must drop each
time kappa passes the real part of an off-line zero.

Outcome, 10 November 2026: 69 real zeros at kappa = 3, 68 from kappa = 1.5 down to 0.82 (one real zero lost below
t = 14), 66 at kappa = 0.79 (pair lost near t = 85.7, the known zero 0.8085 + 85.699i), 64 at
kappa = 0.63 (pair lost near t = 114.2, the known zero 0.6508 + 114.163i), and 64 down to 0.501. About 12 minutes."""
import numpy as np, mpmath as mp
from scipy.special import loggamma
mp.mp.dps = 15
T = 120.0; ts = np.arange(1.0, T, 0.02)
th = mp.atan((mp.sqrt(10 - 2 * mp.sqrt(5)) - 2) / (mp.sqrt(5) - 1))
chi = {1: 1, 2: 1j, 3: -1j, 4: -1}
def L(s, conj=False):
    return 5 ** (-s) * sum((mp.conj(chi[a]) if conj else chi[a]) * mp.zeta(s, mp.mpf(a) / 5) for a in range(1, 5))
def f(s):
    return (mp.exp(-1j * th) * L(s) + mp.exp(1j * th) * L(s, True)) / (2 * mp.cos(th))
# check: real coefficients / reality on the critical line
s0 = mp.mpc(0.5, 20.0)
lam0 = (5 / mp.pi) ** ((s0 + 1) / 2) * mp.gamma((s0 + 1) / 2) * f(s0)
print("check: imaginary/real part ratio of the completed function on the critical line at t=20:", mp.nstr(abs(lam0.imag / lam0.real), 5))
def count(kappa, func, archlog):
    s = kappa + 1j * ts
    vals = np.array([complex(func(mp.mpc(float(x.real), float(x.imag)))) for x in s])
    ph = np.imag(archlog(s)) + np.angle(vals)
    F = np.cos(ph); idx = np.nonzero(np.sign(F[1:]) != np.sign(F[:-1]))[0]
    return len(idx), ts[idx]
arch_dh = lambda s: ((s + 1) / 2) * np.log(5 / np.pi) + loggamma((s + 1) / 2)
print(" kappa | real zeros of W_kappa below 120")
prev = None
for kappa in [3.0, 1.5, 1.0, 0.9, 0.82, 0.79, 0.70, 0.66, 0.63, 0.55, 0.501]:
    n1, z1 = count(kappa, f, arch_dh)
    note = ""
    if prev is not None and n1 != prev[0]:
        gone = [x for x in prev[1] if np.min(np.abs(z1 - x)) > 0.6] if len(z1) else list(prev[1])
        note = f"   <- count changed; zeros lost near t = {np.round(gone[:4], 1)}"
    print(f" {kappa:5.3f} | {n1:4d}{note}", flush=True)
    prev = (n1, z1)
