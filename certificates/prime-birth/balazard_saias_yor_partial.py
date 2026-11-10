"""Idea 8: one number that is zero exactly when RH holds (Balazard, Saias, Yor 1999).
J = integral over the whole critical line of log|zeta(1/2+it)| / (1/4 + t^2) dt.
Jensen's formula gives J = 2 pi * sum over zeros with Re rho > 1/2 of log|rho/(1-rho)|, so J >= 0 always and J = 0 <=> RH.
Compute the partial integral J(T) = 2 * int_0^T ... and watch it approach 0."""
import mpmath as mp, numpy as np, time
mp.mp.dps = 15
t0 = time.time()
h = 0.004
checkpoints = [1, 5, 10, 14, 20, 30, 50, 100, 200, 400, 800, 1500]
T = checkpoints[-1]
n = int(T / h)
acc = 0.0; out = []; ci = 0
prev = None
for k in range(n + 1):
    t = k * h
    z = abs(mp.siegelz(t)) if t > 0 else abs(mp.zeta(0.5))
    val = (float(mp.log(z)) if z > 0 else -40.0) / (0.25 + t * t)
    if prev is not None: acc += 0.5 * h * (val + prev)
    prev = val
    if ci < len(checkpoints) and t >= checkpoints[ci] - 1e-9:
        print(f"T={checkpoints[ci]:5d}   J(T) = {2*acc:+.6f}    ({time.time()-t0:.0f}s)", flush=True); ci += 1
