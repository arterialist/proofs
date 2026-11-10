"""Zeros of the Davenport-Heilbronn function on the critical line below T (sign changes of the completed function).
Writes dh_zeros.npy, used by the validation mode of davenport_heilbronn_weil_form.py.
Usage: python3 davenport_heilbronn_zeros_on_line.py 260       (about 4 minutes; finds 169 zeros, the first at 5.0942)"""
import numpy as np, mpmath as mp, sys
mp.mp.dps = 20
T = float(sys.argv[1])
th = mp.atan((mp.sqrt(10 - 2 * mp.sqrt(5)) - 2) / (mp.sqrt(5) - 1))
chi = {1: 1, 2: 1j, 3: -1j, 4: -1}
def Lf(s, conj=False): return 5 ** (-s) * sum((mp.conj(chi[a]) if conj else chi[a]) * mp.zeta(s, mp.mpf(a) / 5) for a in range(1, 5))
def f(s): return (mp.exp(-1j * th) * Lf(s) + mp.exp(1j * th) * Lf(s, True)) / (2 * mp.cos(th))
def Z(t):
    s = mp.mpc(0.5, t); ph = mp.im(mp.loggamma((s + 1) / 2)) + t / 2 * mp.log(5 / mp.pi)
    return mp.re(mp.exp(1j * ph) * f(s))
ts = np.arange(0.05, T, 0.04); v = [Z(t) for t in ts]; zs = []
for a, b, x, y in zip(ts[:-1], ts[1:], v[:-1], v[1:]):
    if x * y < 0: zs.append(float(mp.findroot(Z, (a, b), solver="anderson")))
np.save("dh_zeros.npy", np.array(zs)); print(len(zs), "zeros on the line below", T); print(np.round(zs[:12], 4))
