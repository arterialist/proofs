"""A linear program with no primes and no zeros in its input.
N(t) = -(1/2) Re psi(1/4 + i t/2) + (1/2) log pi - (1/2)/(1/4 + t^2) comes from the pole of zeta and the Gamma factor.
For a measure mu = (e^{u/2} - omega(u)) du on u > 0, Weil's functional with mu in place of the primes equals
    W_mu(h_g) = (1/pi) int |g^(t)|^2 (omega_c(t) - N(t)) dt,     omega_c(t) = int_0^inf omega(u) cos(tu) du,
so it is positive exactly when omega_c - N is a nonnegative measure (pi times the "zero" measure of the system), and
mu is a nonnegative measure exactly when omega(u) <= e^{u/2}. For the true zeta data and under RH, omega_c - N is pi
times the sum of point masses at the ordinates of the zeros and e^{u/2} - omega is the sum of Lambda(n)/sqrt(n) at log n.
Unknown: x(t) = omega_c(t) on 0 <= t <= T, with x >= N, and x = 0 beyond T (allowed, since N < 0 there).
omega(u) = (2/pi) int_0^T x(t) cos(tu) dt.
Constraints: omega(u) <= e^{u/2} + s for 0 < u <= U, and omega(u) >= e^{u/2} - s for u < log XLOW (no "prime" mass
below x = XLOW). Minimise s. Solved with scipy's HiGHS on a grid in t and u.
Usage: python3 explicit_formula_double_positivity_lp.py T dt U du [XLOW, default 1 = no lower condition] [q]
       q = 3 or 4 switches to the Dedekind zeta function of the imaginary quadratic field of discriminant -q
       (Gamma factor Gamma(s), conductor q, simple pole; true prime weights (1 + chi(n)) Lambda(n)/sqrt(n))

Outcome, 10 November 2026. A computation on a truncated, discretised problem. It proves nothing about RH.
XLOW = 1 (no condition), T=60, U=3: s = 0.0024, point masses on the zero side at 14.01, 20.14, 22.95, 24.55, ...,
   which are not the zeta zeros; with x - max(N,0) capped at 1, s = 0.0032. So without a condition near x = 1 the
   solution is far from unique.
XLOW = 1.9, T=200, U=2.5 (9 s): s = 2.8e-4. Zero side, centre:mass of the first clusters: 14.12:0.99, 20.91:0.97,
   24.78:0.91, 30.25:0.92, 32.79:1.04, 37.28:0.93 (true zeros 14.13, 21.02, 25.01, 30.42, 32.94, 37.59). Total mass
   79.19, and zeta has 79.2 zeros below 200 by the counting formula. Prime side, x:mass of the peaks:
   2.003:0.477, 3.008:0.631, 4.047:0.344, 5.035:0.692, 7.188:0.559 (true 2:0.490, 3:0.634, 4:0.347, 5:0.720, 7:0.735).
XLOW = 1.5 and XLOW = 1.2, same T and U: s = 2.7e-4 and the same first zeros and the same peaks at 2, 3, 4, 5.
XLOW = 1.9, T=400, U=3 (103 s): s = 8e-5. Zero side: 14.13:1.00, 20.99:0.98, 30.40:0.95, 32.98:0.90, 37.39:0.89,
   41.06:0.85, 43.25:0.97, 47.90:0.91, 49.63:1.00, and the third zero split as 24.77:0.74 + 25.60:0.28.
XLOW = 1.5, T=400, U=3 (151 s): s = 8e-5. Zero side: 14.13:1.00, 20.99:0.99, 30.41:0.96, 32.92:0.98, 37.40:0.90,
   41.02:0.83, 43.19:0.98, 48.00:0.94, 49.53:0.84. Prime side: 2.000:0.485, 3.002:0.628, then broader peaks near
   3.99, 5.02, 7.1, 8.8, 10.9, 13.1 that the narrow window undercounts. Mass within 0.016 of log 6, log 10, log 12,
   log 14, log 15: 1e-4, 1.6e-3, 1.6e-3, 1e-4, 1e-4.
XLOW = 1.5, T=800, dt=0.04, U=3.5 (835 s): s = 1e-5. Zero side: 14.13:1.00, 21.00:0.99, 25.14:0.86 (+24.17:0.16),
   30.33:0.81 (+31.20:0.26), 32.98:0.92, 40.78:0.85, 43.34:0.95, 47.97:0.89, 49.43:0.83. Prime side: 2.000:0.487,
   3.000:0.629, then broader peaks.
HOW MUCH IS FORCED (explicit_formula_double_positivity_lp_ranges.py, T=200, U=2.5, XLOW=1.5, tolerance 2 s*): over all
   solutions, the zero-side mass in [13.6, 14.6) ranges from 0.52 to 1.01 and below 13 it is at most 0.054, but the
   windows around the second, third and fourth zeros range from 0 to more than 1. The prime-side mass in [1.9, 2.1)
   ranges from 0.447 to 0.494 and in [2.2, 2.8) from 0 to 0.129. So at this size the constraints pin the weight of 2
   and part of the first zero; the agreement of the higher zeros is a property of the minimal-s solution and is not
   forced once the tolerance is doubled.
NEGATIVE RESULT for q = 4 and q = 3 (Gaussian and Eisenstein fields): at T=200, U=2.5; T=300, U=3; and T=400, U=4.5
   the minimal-s solution is NOT the field's data. Example, q = 4, T=400, U=4.5, XLOW=1.9: s = 3e-5, zero-side
   clusters at 5.73, 7.98, 9.44, 10.58, 12.81 (true 6.02, 10.24, 12.99, 14.13), prime-side mass 0.044 at 2 and 0.017
   at 5 (true 0.490 and 1.440). For q = 3 a few features are near the truth (8.00:0.95 against 8.04; 0.93 at 7 against
   1.47) and most are not. So the degree-one result does not show a general mechanism.
One web search found no paper that does this computation. That is not a novelty claim.
"""
import numpy as np, sys, time
from scipy.optimize import linprog
from scipy.special import digamma
T, dt, U, du = float(sys.argv[1]), float(sys.argv[2]), float(sys.argv[3]), float(sys.argv[4])
XLOW = float(sys.argv[5]) if len(sys.argv) > 5 else 1.0          # no prime mass below x = XLOW: omega(u) = e^{u/2} (within s) for u < log XLOW
XCAP = None
Q = int(sys.argv[6]) if len(sys.argv) > 6 else 0                    # 0: zeta. q = 3, 4, 7, 8, ...: Dedekind zeta of the imaginary quadratic field of discriminant -q
if Q == 0: N = lambda t: -0.5 * digamma(0.25 + 0.5j * t).real + 0.5 * np.log(np.pi) - 0.5 / (0.25 + t * t)
else: N = lambda t: -0.5 * (np.log(Q) - 2 * np.log(2 * np.pi) + 2 * digamma(0.5 + 1j * t).real) - 0.5 / (0.25 + t * t)
tg = np.arange(dt / 2, T, dt); Ng = N(tg); ug = np.arange(du, U + 1e-9, du)
A = (2 / np.pi) * np.cos(np.outer(ug, tg)) * dt                    # omega(u_i) = sum_j A_ij x_j
nt, nu = len(tg), len(ug); t0 = time.time()
c = np.zeros(nt + 1); c[-1] = 1.0
low = ug < np.log(XLOW)
A_ub = np.vstack([np.hstack([A, -np.ones((nu, 1))]), np.hstack([-A[low], -np.ones((low.sum(), 1))])]); b_ub = np.concatenate([np.exp(ug / 2), -np.exp(ug[low] / 2)])
bounds = [(Ng[j], None if XCAP is None else max(Ng[j], 0) + XCAP) for j in range(nt)] + [(None, None)]
r = linprog(c, A_ub=A_ub, b_ub=b_ub, bounds=bounds, method="highs")
x = r.x[:nt]; s = r.x[-1]; om = A @ x; slack_t = (x - Ng) * dt / np.pi; slack_u = np.exp(ug / 2) + s - om
print(f"{'zeta' if Q == 0 else 'imaginary quadratic field, discriminant -' + str(Q)}: T={T} dt={dt} U={U} du={du}, no prime mass below x={XLOW}: status {r.status}, minimal s = {s:+.5f}   ({time.time()-t0:.0f}s)")
def clusters(pos, mass, gap, floor):
    out = []; cur = []
    for p, w in zip(pos, mass):
        if w <= floor: continue
        if cur and p - cur[-1][0] > gap: out.append(cur); cur = []
        cur.append((p, w))
    if cur: out.append(cur)
    return [(sum(p * w for p, w in c) / sum(w for p, w in c), sum(w for p, w in c)) for c in out]
import mpmath as mp
zz = [float(mp.im(mp.zetazero(k))) for k in range(1, 16)]
KNOWN = {4: [6.0209, 10.2437, 12.9881, 16.3426, 18.2920, 21.4506, 23.2784, 25.7288, 28.3596], 3: [8.0397, 11.2492, 15.7046, 18.2620, 20.4558, 24.0594, 26.5779, 28.2182]}
if Q in KNOWN: zz = sorted(zz[:5] + KNOWN[Q])
CHI = {4: {1: 1, 3: -1}, 3: {1: 1, 2: -1}, 7: {1: 1, 2: 1, 3: -1, 4: 1, 5: -1, 6: -1}, 8: {1: 1, 3: 1, 5: -1, 7: -1}}
def lam(n):
    for p_ in range(2, n + 1):
        if all(p_ % d_ for d_ in range(2, int(p_**0.5) + 1)):
            q_ = p_
            while q_ < n: q_ *= p_
            if q_ == n: return np.log(p_)
    return 0.0
truew = {n: (1 + (CHI[Q].get(n % Q, 0) if Q else 0)) * lam(n) / np.sqrt(n) for n in range(2, int(np.exp(U)) + 1)}
cl = clusters(tg, slack_t, 0.6, 0.02)
print("zero side: clusters of mass (centre : mass), then the true zeros:")
print("   found: " + "  ".join(f"{p:.2f}:{w:.2f}" for p, w in cl[:15]))
print("   true : " + "  ".join(f"{z:.2f}" for z in zz[:15]))
print(f"   total mass {slack_t.sum():.2f} in [0, {T:g}]" + (f";  zeta has about {T/(2*np.pi)*np.log(T/(2*np.pi*np.e)) + 7/8:.1f} zeros there" if Q == 0 else ""))
dens = slack_u * du
half = max(2 * np.pi / T, 2 * du)                                   # a peak collects the mass within +-2 pi/T in u (the resolution of the cutoff)
order = np.argsort(dens)[::-1]; used = np.zeros(nu, dtype=bool); peaks = []
for i in order:
    if used[i] or dens[i] < 0.02 * dens.max(): continue
    win = np.abs(ug - ug[i]) <= half
    if used[win].any(): used |= win; continue
    w = dens[win].sum(); peaks.append((float((ug[win] * dens[win]).sum() / w), float(w))); used |= win
peaks.sort()
print(f"prime side: peaks of the mass e^(u/2) + s - omega(u) (x = e^u : mass within +-{half:.3f} in u), keeping those above 0.08:")
print("   found: " + "  ".join(f"{np.exp(p):.3f}:{w:.3f}" for p, w in peaks if w > 0.08))
print("   true : " + "  ".join(f"{n}:{w:.3f}" for n, w in truew.items() if w > 0))
print("   mass found within the same window of log n, for every integer n: " + "  ".join(f"{n}:{dens[np.abs(ug - np.log(n)) <= half].sum():.3f}" for n in range(2, int(np.exp(U)) + 1)))
print(f"   mass outside these peaks: {dens.sum() - sum(w for p, w in peaks if w > 0.08):.3f} of {dens.sum():.3f}")
