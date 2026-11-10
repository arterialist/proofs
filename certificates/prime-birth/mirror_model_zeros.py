"""The mirror model built from the primes born so far (after S. Gonek, "Finite Euler products and the Riemann
hypothesis", 2012). This script tracks its zeros ON the critical line only.

WARNING. The model also has zeros OFF the line: for primes up to 101 and 9.3 < t < 199.7 there are 66 with
1/2 < Re s < 0.9 and about 250 with Re s < 1, clustered toward Re s = 1 and moving left as primes are added.
It has poles on Re s = 1, so a winding number over a region containing that line counts zeros minus poles.
An earlier reading of that winding number as "no zeros off the line" was wrong.

P_X(s) = prod_{p<=X} (1 - p^(-s))^(-1) never vanishes. Model: zeta_X(s) = P_X(s) + chi(s) conj(P_X(1 - conj(s))).
On the critical line zeta_X(1/2+it) = 2 e^(-i theta(t)) F_X(t) with F_X(t) = Re( e^(i theta(t)) P_X(1/2+it) ) real,
so its zeros on the line are the sign changes of F_X. With no primes F = cos(theta(t)) and the zeros are set by the
gamma-factor phase alone. Each prime moves them along the line.
The total phase theta(t) + arg P_X(1/2+it) increases whenever theta'(t) = (1/2) log(t/2 pi) exceeds the speed at which
the prime phase can turn back, which is at most sum_{p<=X} log p / (sqrt p - 1); then no two zeros on the line can collide."""
import numpy as np, mpmath as mp, sys
T = float(sys.argv[1]) if len(sys.argv) > 1 else 200.0
ts = np.arange(0.5, T, 0.002)
theta = np.array([float(mp.siegeltheta(t)) for t in ts])
true = [float(mp.im(mp.zetazero(k))) for k in range(1, int(mp.nzeros(T)) + 1)]
def primes_upto(X): return [p for p in range(2, X + 1) if all(p % r for r in range(2, int(p**0.5) + 1))]
print(f"true zeros with 0 < t < {T:g}: {len(true)}")
print(" primes up to | zeros of the model on the line | mean distance to the true zeros | max distance | prime phase speed bound | clock speed at T")
for X in [1, 2, 3, 5, 11, 31, 101, 307, 1009]:
    ps = primes_upto(X)
    logP = np.zeros(len(ts), dtype=complex)
    for p in ps: logP -= np.log(1 - p ** -0.5 * np.exp(-1j * ts * np.log(p)))
    F = np.real(np.exp(1j * theta) * np.exp(logP))
    idx = np.nonzero(np.sign(F[1:]) != np.sign(F[:-1]))[0]
    zs = np.array([ts[i] - F[i] * (ts[i+1] - ts[i]) / (F[i+1] - F[i]) for i in idx]); zs = zs[zs > 9]
    d = np.array([np.min(np.abs(zs - t0)) for t0 in true])
    speed = sum(np.log(p) / (np.sqrt(p) - 1) for p in ps)
    print(f" {X:12d} | {len(zs):30d} | {d.mean():31.3f} | {d.max():12.3f} | {speed:23.2f} | {0.5*np.log(T/(2*np.pi)):.2f}")
