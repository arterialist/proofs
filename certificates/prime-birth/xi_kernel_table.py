"""High-precision table of the kernels K_k(u) = (1/pi) int_0^inf Xi(t)^2 pi_k(t^2) cos(tu) dt, where the pi_k are
polynomials in s = (t/10)^2, orthonormal for the weight Xi(t)^2 dt on [0, inf) (Stieltjes recurrence on the grid).
K_k is the even function with Fourier transform Xi^2 pi_k. 50 digits; trapezoid rule with step 0.05 on [0, 130]
(for these entire, rapidly decaying integrands its error is far below 1e-50 for u <= 6).
Writes kern_mp_D<D>.pkl in the current directory (about 3 MB for D = 16; do not commit it).
Usage: python3 xi_kernel_table.py 16          (about one minute)
"""
import mpmath as mp, numpy as np, pickle, time, sys
mp.mp.dps = 50
D = int(sys.argv[1]); t0 = time.time()
xi = lambda s: mp.mpf(0.5) * s * (s - 1) * mp.pi ** (-s / 2) * mp.gamma(s / 2) * mp.zeta(s)
dt = mp.mpf(1) / 20; N = 2600
ts = [dt * j for j in range(N + 1)]
x2 = [mp.re(xi(mp.mpc(0.5, t))) ** 2 for t in ts]
mu = [x2[j] * dt * (mp.mpf(1) / 2 if j == 0 else 1) for j in range(N + 1)]          # weights for int_0^inf
s = [(t / 10) ** 2 for t in ts]
P = [[mp.mpf(1) / mp.sqrt(mp.fsum(mu))] * (N + 1)]; bprev = mp.mpf(0); rec = []
for k in range(D):
    a = mp.fsum(mu[j] * s[j] * P[k][j] ** 2 for j in range(N + 1))
    v = [(s[j] - a) * P[k][j] - (bprev * P[k - 1][j] if k > 0 else 0) for j in range(N + 1)]
    b = mp.sqrt(mp.fsum(mu[j] * v[j] ** 2 for j in range(N + 1))); P.append([x / b for x in v]); rec.append((a, b)); bprev = b
print(f"basis done ({time.time()-t0:.0f}s)", flush=True)
F = [[P[k][j] * mu[j] / mp.pi for j in range(N + 1)] for k in range(D + 1)]
def vonm(n):
    for p in range(2, n + 1):
        if all(p % d for d in range(2, int(p**0.5) + 1)):
            q = p
            while q < n: q *= p
            if q == n: return mp.log(p)
    return mp.mpf(0)
PP = [(n, vonm(n) / mp.sqrt(n)) for n in range(2, 60) if vonm(n) > 0]
us = sorted(set([mp.mpf(0)] + [mp.mpf(i) / 250 for i in range(1, 1001)] + [mp.log(n) for n, w in PP]))     # 0 .. 4 step 0.004, plus log n
K = {}
for i, u in enumerate(us):
    cs = [mp.cos(t * u) for t in ts]
    K[u] = [mp.fsum(F[k][j] * cs[j] for j in range(N + 1)) for k in range(D + 1)]
    if i % 200 == 0: print(f"  u index {i}/{len(us)} ({time.time()-t0:.0f}s)", flush=True)
pickle.dump({"D": D, "us": us, "K": K, "PP": PP, "rec": rec, "ts": ts, "P_on_t": [[float(P[k][j]) for j in range(0, N + 1, 2)] for k in range(D + 1)],
             "norm0": P[0][0]}, open(f"kern_mp_D{D}.pkl", "wb"))
print(f"done D={D} ({time.time()-t0:.0f}s)")
