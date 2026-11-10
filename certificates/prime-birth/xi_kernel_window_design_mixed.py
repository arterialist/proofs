"""Design of degree-24 window kernels with coefficients of either sign, for the certified two-sided bounds of
Corollary 6 of building-blocks/weil-and-spectral/admissible-systems-xi-kernel-comparison.md.

This script only proposes kernels. Nothing it prints is a certified bound. The certificate is
xi_kernel_conductor_certificate.py (kernel set "deg24"), which also proves w > 0 by an exact Sturm check.

w(t) = sum_{i<=R} beta_i (t/10)^(2i) with beta_i free. Required: w >= DELTA * w16 on a grid of t (w16 is the certified
degree-16 polynomial), then w > 0 is checked exactly by a Sturm chain after rounding.
Upper kernel: h_w >= 1 + MARG on [UA, UB], h_w >= floor outside; minimise int h_w dmu_Lambda.
Lower kernel: h_w >= -(1 - MARG) on (UA - PAD, UB + PAD), h_w >= floor outside; minimise int h_w dmu_Lambda
(then every admissible system of conductor <= 1 has mass at least minus that value in the window).
floor(u) = K1 * h4(u)/h4(0) + K2 * Psi(u)/Psi(0) + FAC * E(u). Here h4 is the certified degree-8 kernel and E(u) is the
chord term h0^2/8 sup|h''| that the certificate (lattice 2^-12) charged a previous version of the kernel near u. Without
the E term the kernels touch a floor of size 1e-11 near u = 2.123, below the certificate's resolution, and four or five
cells stay undecided. Constraints are enforced by cutting planes in u. Coefficients are rounded to DIG digits and rescanned.

Needs kern_mp_D24.pkl (python3 xi_kernel_table.py 24) in the current directory. The optional arguments PREV and FAC need
lattice_tables.npz, written by  python3 xi_kernel_conductor_certificate.py 12 deg24 lattice_tables.npz .
Usage: python3 xi_kernel_window_design_mixed.py UA UB K1 K2 UMAX DIG MARG PAD R DELTA kinds [PREV [FAC]]
   kinds is "u", "l" or "ul"; PREV is the log of a previous run of this script with the same window.
Used on 10 November 2026:
   window at 2:  0.63 0.76 0.3 0.002 3.0 12 1e-4 0.01 12 0.001 ul   and then the same with  <log> 3
   window at 3:  1.04 1.16 3 0.02 3.0 12 1e-3 0.01 12 0.001 ul      and then the same with  <log> 3
Outcome (uncertified design values): at 2, upper 0.4902354691 and lower 0.4900151766; at 3, upper 0.6368912377 and
lower 0.6308324811. The certified values are in the docstring of the certificate script.
"""
import mpmath as mp, numpy as np, sys
from fractions import Fraction
from scipy.optimize import linprog
import xi_kernel_fine as kfine
mp.mp.dps = 50
UA, UB, K1, K2, UMAX = [mp.mpf(v) for v in sys.argv[1:6]]; DIG = int(sys.argv[6]); MARG = mp.mpf(sys.argv[7]); PAD = mp.mpf(sys.argv[8])
R = int(sys.argv[9]); DELTA = mp.mpf(sys.argv[10]); KINDS = sys.argv[11]
PREV = sys.argv[12] if len(sys.argv) > 12 else None; FAC = float(sys.argv[13]) if len(sys.argv) > 13 else 3.0
ERRTAB = {}
if PREV:
    import re
    _t = open(PREV).read(); _A = np.load("lattice_tables.npz")["A"]; _NH = 4096; _c8 = (1.0 / _NH) ** 2 / 8
    for _kind, _blk in ((1, _t.split("UPPER kernel")[1].split("LOWER kernel")[0]), (-1, _t.split("LOWER kernel")[1])):
        _al = [abs(float(x.strip().strip("'"))) for x in re.search(r"alpha \(coefficients of t\^\(2i\)\): \[(.*?)\]", _blk).group(1).split(",")]
        ERRTAB[_kind] = _c8 * sum(a * _A[r + 1] for r, a in enumerate(_al))
def extra(kind, u):
    """FAC times the chord term h0^2/8 sup|h''| that the certificate (lattice 2^-12) charges the previous kernel near u."""
    if not PREV: return mp.mpf(0)
    j = int(mp.floor(u * 4096)); E = ERRTAB[kind]
    return mp.mpf(FAC * float(E[max(j - 1, 0):min(j + 2, len(E))].max()))
F = kfine.Fine("kern_mp_D24.pkl"); T = F.T; us = T["us"]; Ktab = T["K"]; PP = T["PP"]; rec = T["rec"]; n0 = T["norm0"]
co = [[n0]]
for k in range(R):
    a, b = rec[k]; prev = co[k]; new = [mp.mpf(0)] * (k + 2)
    for i, c in enumerate(prev): new[i + 1] += c; new[i] -= a * c
    if k > 0:
        for i, c in enumerate(co[k - 1]): new[i] -= rec[k - 1][1] * c
    co.append([x / b for x in new])
cache = {}
def S(u):
    if u in cache: return cache[u]
    Kv = Ktab[u] if u in Ktab else F.K(u); out = []
    for k in range(R + 1): out.append((Kv[k] - mp.fsum(co[k][i] * out[i] for i in range(k))) / co[k][k])
    cache[u] = out; return out
b4 = [mp.mpf(x) for x in ("2.27942", "5.06854", "7.83157", "2.13792", "7.48483")]
b16 = [mp.mpf(x) for x in ("2.25482059", "5.24395214", "6.98139727", "5.51936758", "3.87866857", "1.31919267", "0.953422988", "0", "0.116486515")] + [mp.mpf(0)] * (R - 8)
h4 = lambda u: mp.fsum(b4[i] * S(u)[i] for i in range(5)); h40 = h4(mp.mpf(0)); psi0 = S(mp.mpf(0))[0]
floor0 = lambda u: K1 * h4(u) / h40 + K2 * S(u)[0] / psi0
OPTS = {"primal_feasibility_tolerance": 1e-10, "dual_feasibility_tolerance": 1e-10}
objS = [mp.fsum(w * S(mp.log(n))[i] for n, w in PP) for i in range(R + 1)]
tgrid = [mp.mpf(j) / 4 for j in range(0, 481)]                      # t = 0 .. 120 step 0.25
trows = []; trhs = []
for t in tgrid:
    s = (t / 10) ** 2; pw = [s ** i for i in range(R + 1)]
    trows.append([-x for x in pw]); trhs.append(-DELTA * mp.fsum(b16[i] * pw[i] for i in range(R + 1)))
def refined(c_mp, rows, rhs, rounds=6):
    n = len(c_mp); sc = [max(abs(x) for x in r) for r in rows]
    A = np.array([[float(x / s) for x in r] for r, s in zip(rows, sc)]); cs = max(abs(x) for x in c_mp); c = [float(x / cs) for x in c_mp]
    r = linprog(c, A_ub=A, b_ub=[float(x / s) for x, s in zip(rhs, sc)], bounds=[(None, None)] * n, method="highs-ds", options=OPTS)
    if r.status != 0: return None
    x = [mp.mpf(float(v)) for v in r.x]
    for it in range(rounds):
        slack = [(rh - mp.fsum(rw[k] * x[k] for k in range(n))) / s for rw, rh, s in zip(rows, rhs, sc)]
        viol = max([mp.mpf(0)] + [-v for v in slack])
        if viol < mp.mpf(10) ** -38 and it > 0: break
        delta = max(viol, mp.mpf(10) ** -40) * 100
        r = linprog(c, A_ub=A, b_ub=[float(min(v / delta, mp.mpf(10) ** 12)) for v in slack], bounds=[(None, None)] * n, method="highs-ds", options=OPTS)
        if r.status != 0: break
        x = [x[k] + delta * mp.mpf(float(r.x[k])) for k in range(n)]
    return x
def sturm_positive(coefs):
    """True if p(s) = sum coefs[i] s^i (exact Fractions) has p(0) > 0 and no real root in (0, inf)."""
    def trim(p):
        while p and p[-1] == 0: p = p[:-1]
        return p
    def rem(a, b):
        a = a[:]
        while len(a) >= len(b) and a:
            f = a[-1] / b[-1]; sh = len(a) - len(b)
            for i in range(len(b)): a[i + sh] -= f * b[i]
            a = trim(a)
        return a
    p0 = trim(coefs[:]); p1 = trim([i * p0[i] for i in range(1, len(p0))]); chain = [p0, p1]
    while len(chain[-1]) > 1:
        r = rem(chain[-2], chain[-1])
        if not r: break
        chain.append([-x for x in r])
    sgn = lambda v: (v > 0) - (v < 0)
    at0 = [sgn(p[0]) for p in chain]; atinf = [sgn(p[-1]) for p in chain]
    var = lambda seq: sum(1 for a, b in zip([s for s in seq if s != 0][:-1], [s for s in seq if s != 0][1:]) if a != b)
    return coefs[0] > 0 and var(at0) - var(atinf) == 0
def design(kind):
    inJ = (lambda u: UA <= u <= UB) if kind > 0 else (lambda u: UA - PAD < u < UB + PAD)
    fcache = {}
    def floor(u):
        if u not in fcache: fcache[u] = floor0(u) + extra(kind, u)
        return fcache[u]
    tgt = (lambda u: (1 + MARG) if inJ(u) else floor(u)) if kind > 0 else (lambda u: -(1 - MARG) if inJ(u) else floor(u))
    pts = sorted(set(u for u in us if u <= UMAX) | {UA, UB, UA - PAD, UB + PAD})
    for it in range(30):
        rows = [[-x for x in S(u)] for u in pts] + trows; rhs = [-tgt(u) for u in pts] + trhs
        x = refined(objS, rows, rhs)
        if x is None: return None
        k = lambda u: mp.fsum(x[i] * S(u)[i] for i in range(R + 1)); new = []; worst = mp.mpf(0)
        for i in range(len(pts) - 1):
            a_, b_ = pts[i], pts[i + 1]
            if b_ - a_ < mp.mpf(10) ** -8: continue
            u = (a_ + b_) / 2; ref = floor(u) if not inJ(u) else MARG
            if min(k(a_) - tgt(a_), k(b_) - tgt(b_)) < 5 * ref or inJ(a_) != inJ(b_):
                v = k(u) - tgt(u)
                if v < -ref * mp.mpf("0.02"): new.append(u); worst = min(worst, v / ref)
        val = mp.fsum(objS[i] * x[i] for i in range(R + 1))
        print(f"   {'upper' if kind > 0 else 'lower'} round {it}: int h dmu_Lambda = {mp.nstr(val, 10)}, {len(new)} new points, worst {mp.nstr(worst, 3)}", flush=True)
        if not new: break
        pts = sorted(set(pts) | set(new))
    co_ = [mp.mpf(mp.nstr(v, DIG)) for v in x]
    k = lambda u: mp.fsum(co_[i] * S(u)[i] for i in range(R + 1)); val = mp.fsum(objS[i] * co_[i] for i in range(R + 1))
    wJ = None; wO = None
    for i in range(len(pts) - 1):
        for f in (0, mp.mpf(1) / 3, mp.mpf(2) / 3):
            u = pts[i] + f * (pts[i + 1] - pts[i])
            if u > UMAX: continue
            if inJ(u): d = (k(u) - 1) if kind > 0 else (k(u) + 1); wJ = d if wJ is None else min(wJ, d)
            else: d = k(u) / floor(u); wO = d if wO is None else min(wO, d)
    alpha = [Fraction(mp.nstr(co_[i], DIG + 5)) / Fraction(10) ** (2 * i) for i in range(R + 1)]       # exact coefficients of t^(2i) = s^i with s = t^2
    ok = sturm_positive(alpha)
    a_, b_ = (UA, UB) if kind > 0 else (UA - PAD, UB + PAD)
    print(f"{'UPPER' if kind > 0 else 'LOWER'} kernel, degree {2*R}, window u in [{mp.nstr(a_, 4)}, {mp.nstr(b_, 4)}]")
    print("   alpha (coefficients of t^(2i)):", [mp.nstr(v / mp.mpf(10) ** (2 * i), DIG) for i, v in enumerate(co_)])
    print(f"   int h dmu_Lambda = {mp.nstr(val, 12)}  => " + (f"mu(window) <= {mp.nstr(val, 10)}" if kind > 0 else f"mu(window) >= {mp.nstr(-val, 10)}") + f";  h(0) = {mp.nstr(k(mp.mpf(0)), 10)}")
    print(f"   scan: smallest margin inside the window {mp.nstr(wJ, 3)} (MARG = {mp.nstr(MARG, 2)});  smallest ratio to the floor outside {mp.nstr(wO, 3)}")
    print(f"   Sturm (exact rationals): w(t) > 0 for all real t: {ok}", flush=True)
for ch in KINDS:
    design(+1 if ch == "u" else -1)
