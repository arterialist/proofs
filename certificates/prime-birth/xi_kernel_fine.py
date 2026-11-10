"""Evaluate the tabulated kernels K_k of xi_kernel_table.py at arbitrary points u, at 50 digits. Rebuilds the
orthonormal polynomial basis from the recurrence stored in the table and applies the same trapezoid rule.
Used by xi_kernel_conductor_cutting_plane.py.
"""
import mpmath as mp, pickle
mp.mp.dps = 50
class Fine:
    def __init__(self, path):
        T = pickle.load(open(path, "rb")); self.D = T["D"]; rec = T["rec"]; n0 = T["norm0"]; self.T = T
        xi = lambda s: mp.mpf(0.5) * s * (s - 1) * mp.pi ** (-s / 2) * mp.gamma(s / 2) * mp.zeta(s)
        dt = mp.mpf(1) / 20; N = 2600; self.ts = [dt * j for j in range(N + 1)]
        x2 = [mp.re(xi(mp.mpc(0.5, t))) ** 2 for t in self.ts]
        mu = [x2[j] * dt * (mp.mpf(1) / 2 if j == 0 else 1) for j in range(N + 1)]
        s = [(t / 10) ** 2 for t in self.ts]
        P = [[n0] * (N + 1)]
        for k in range(self.D):
            a, b = rec[k]
            v = [(s[j] - a) * P[k][j] - (rec[k - 1][1] * P[k - 1][j] if k > 0 else 0) for j in range(N + 1)]
            P.append([x / b for x in v])
        self.F = [[P[k][j] * mu[j] / mp.pi for j in range(N + 1)] for k in range(self.D + 1)]
    def K(self, u, D=None):
        D = self.D if D is None else D
        cs = [mp.cos(t * u) for t in self.ts]
        return [mp.fsum(self.F[k][j] * cs[j] for j in range(len(cs))) for k in range(D + 1)]
