"""Design of an explicit kernel with safety margins for a certified UPPER bound on the prime mass in a window [UA, UB] of u
(Corollary 6 of building-blocks/weil-and-spectral/admissible-systems-xi-kernel-comparison.md).
Monomial basis S_i (the even function with transform (t/10)^(2i) Xi^2), degree 16.
Upper kernel hU = sum beta_i S_i with beta_i >= 0:  hU >= 1 + MARG on [UA, UB],  hU >= floor(u) on [0, UMAX] outside;
minimise int hU dmu_Lambda.  floor(u) = K1 * h4(u)/h4(0) + K2 * Psi(u)/Psi(0), h4 the certified degree-8 kernel.
Constraints are enforced by cutting planes; coefficients are rounded to DIG digits and the rounded kernel is rescanned.
The file also contains an earlier design of a lower kernel with a penalty term (kind = -1); the lower kernel actually
certified comes from xi_kernel_window_design_lower.py, which needs no penalty.
Needs kern_mp_D24.pkl (python3 xi_kernel_table.py 24) in the current directory.
Usage: python3 xi_kernel_window_design.py UA UB K1 K2 UMAX DIG MARG PAD        (used: 0.63 0.76 0.3 0.002 3.0 10 1e-4 0.01)

Outcome, 10 November 2026: upper kernel, coefficients of t^(2i):
   [192.7779014, 3.959614914, 0.06592039741, 0.0005995292912, 4.954190381e-6, 1.738108178e-8, 1.390956481e-10, 0, 1.762076328e-15],
   int h dmu_Lambda = 0.491195155 (uncertified value; the certificate script gives <= 0.4911979).
"""
import mpmath as mp, numpy as np, sys
from scipy.optimize import linprog
import xi_kernel_fine as kfine
mp.mp.dps = 50
R = 8; UA = mp.mpf(sys.argv[1]); UB = mp.mpf(sys.argv[2]); K1 = mp.mpf(sys.argv[3]); K2 = mp.mpf(sys.argv[4]); UMAX = mp.mpf(sys.argv[5]); DIG = int(sys.argv[6])
MARG = mp.mpf(sys.argv[7]); PAD = mp.mpf(sys.argv[8]); BETA1 = mp.mpf("1.5567e-5")
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
b16 = [mp.mpf(x) for x in ("2.25482059", "5.24395214", "6.98139727", "5.51936758", "3.87866857", "1.31919267", "0.953422988", "0", "0.116486515")]
h4 = lambda u: mp.fsum(b4[i] * S(u)[i] for i in range(5)); h40 = h4(mp.mpf(0)); psi0 = S(mp.mpf(0))[0]
floor = lambda u: K1 * h4(u) / h40 + K2 * S(u)[0] / psi0
inJU = lambda u: UA <= u <= UB
inJL = lambda u: UA - PAD < u < UB + PAD
OPTS = {"primal_feasibility_tolerance": 1e-10, "dual_feasibility_tolerance": 1e-10}
objS = [mp.fsum(w * S(mp.log(n))[i] for n, w in PP) for i in range(R + 1)]
def refined(c_mp, rows, rhs, lb, rounds=6):
    """min c.x s.t. rows.x <= rhs, x >= lb (lb entries may be None)"""
    n = len(c_mp); sc = [max(abs(x) for x in r) for r in rows]
    A = np.array([[float(x / s) for x in r] for r, s in zip(rows, sc)]); cs = max(abs(x) for x in c_mp); c = [float(x / cs) for x in c_mp]
    r = linprog(c, A_ub=A, b_ub=[float(x / s) for x, s in zip(rhs, sc)], bounds=[(None if l is None else float(l), None) for l in lb], method="highs-ds", options=OPTS)
    if r.status != 0: return None
    x = [mp.mpf(float(v)) for v in r.x]
    for it in range(rounds):
        slack = [(rh - mp.fsum(rw[k] * x[k] for k in range(n))) / s for rw, rh, s in zip(rows, rhs, sc)]
        viol = max([mp.mpf(0)] + [-v for v in slack] + [(l - xv) for l, xv in zip(lb, x) if l is not None])
        if viol < mp.mpf(10) ** -38 and it > 0: break
        delta = max(viol, mp.mpf(10) ** -40) * 100
        r = linprog(c, A_ub=A, b_ub=[float(min(v / delta, mp.mpf(10) ** 12)) for v in slack],
                    bounds=[(None if l is None else float((l - xv) / delta), None) for l, xv in zip(lb, x)], method="highs-ds", options=OPTS)
        if r.status != 0: break
        x = [x[k] + delta * mp.mpf(float(r.x[k])) for k in range(n)]
    return x
def design(kind):
    inJ = inJU if kind > 0 else inJL
    pts = sorted(set(u for u in us if u <= UMAX) | {UA, UB, UA - PAD, UB + PAD})
    for it in range(30):
        rows = []; rhs = []
        for u in pts:
            s = S(u)
            if kind > 0:                                   # hU >= target
                tgt = (1 + MARG) if inJ(u) else floor(u); rows.append([-x for x in s]); rhs.append(-tgt)
            else:                                          # hL <= target ; variables (gam_0..gam_R, kappa)
                tgt = (1 - MARG) if inJ(u) else -floor(u); rows.append(list(s) + [mp.mpf(0)]); rhs.append(tgt)
        if kind > 0:
            x = refined(objS, rows, rhs, [mp.mpf(0)] * (R + 1)); 
        else:
            for i in range(R + 1):
                e = [mp.mpf(0)] * (R + 2); e[i] = mp.mpf(1); e[-1] = -b16[i]; rows.append(e); rhs.append(mp.mpf(0))
                e = [mp.mpf(0)] * (R + 2); e[i] = mp.mpf(-1); e[-1] = -b16[i]; rows.append(e); rhs.append(mp.mpf(0))
            x = refined([-v for v in objS] + [BETA1 / 2], rows, rhs, [None] * (R + 1) + [mp.mpf(0)])
        if x is None: return None
        h = lambda u: mp.fsum(x[i] * S(u)[i] for i in range(R + 1))
        new = []; worst = mp.mpf(0)
        for i in range(len(pts) - 1):
            a_, b_ = pts[i], pts[i + 1]
            if b_ - a_ < mp.mpf(10) ** -8 or inJ(a_) != inJ(b_): continue
            u = (a_ + b_) / 2
            tgt = ((1 + MARG) if inJ(u) else floor(u)) if kind > 0 else ((1 - MARG) if inJ(u) else -floor(u))
            sl_end = min(kind * (h(a_) - (((1 + MARG) if inJ(a_) else floor(a_)) if kind > 0 else ((1 - MARG) if inJ(a_) else -floor(a_)))),
                         kind * (h(b_) - (((1 + MARG) if inJ(b_) else floor(b_)) if kind > 0 else ((1 - MARG) if inJ(b_) else -floor(b_)))))
            ref = floor(u) if not inJ(u) else MARG
            if sl_end < 5 * ref:
                v = kind * (h(u) - tgt)
                if v < -ref * mp.mpf("0.02"): new.append(u); worst = min(worst, v / ref)
        val = mp.fsum(objS[i] * x[i] for i in range(R + 1)) - ((x[-1] * BETA1 / 2) if kind < 0 else 0)
        print(f"   {'upper' if kind > 0 else 'lower'} kernel, round {it}: value {mp.nstr(val, 9)}, {len(new)} new points, worst shortfall {mp.nstr(worst, 3)}" + (f", kappa {mp.nstr(x[-1], 4)}" if kind < 0 else ""), flush=True)
        if not new: break
        pts = sorted(set(pts) | set(new))
    return x, pts
if __name__ == "__main__":
    for kind in (+1, -1):
        res = design(kind)
        if res is None: print("failed"); continue
        x, pts = res; inJ = inJU if kind > 0 else inJL
        co_ = [mp.mpf(mp.nstr(v, DIG)) for v in x[:R + 1]]
        if kind < 0:                                           # smallest kappa that dominates the rounded coefficients
            kap = max((abs(co_[i]) / b16[i]) for i in range(R + 1) if b16[i] != 0); assert co_[7] == 0 or abs(co_[7]) < mp.mpf(10) ** -30
            co_[7] = mp.mpf(0); kap = mp.mpf(mp.nstr(kap * (1 + mp.mpf(10) ** -8), 10))
        h = lambda u: mp.fsum(co_[i] * S(u)[i] for i in range(R + 1))
        val = mp.fsum(objS[i] * co_[i] for i in range(R + 1))
        # scan of the rounded kernel
        wJ = None; wO = None
        for i in range(len(pts) - 1):
            for f in (0, mp.mpf(1) / 3, mp.mpf(2) / 3):
                u = pts[i] + f * (pts[i + 1] - pts[i])
                if u > UMAX: continue
                if inJ(u):
                    d = kind * (h(u) - 1); wJ = d if wJ is None else min(wJ, d)
                else:
                    d = kind * h(u) / floor(u); wO = d if wO is None else min(wO, d)
        a_, b_ = (UA, UB) if kind > 0 else (UA - PAD, UB + PAD)
        print(f"{'UPPER' if kind > 0 else 'LOWER'} kernel, window u in [{mp.nstr(a_, 4)}, {mp.nstr(b_, 4)}] (x in [{mp.nstr(mp.exp(a_), 6)}, {mp.nstr(mp.exp(b_), 6)}])")
        print("   coefficients of (t/10)^(2i):", [mp.nstr(v, DIG) for v in co_])
        print("   alpha (coefficients of t^(2i)):", [mp.nstr(v / mp.mpf(10) ** (2 * i), DIG) for i, v in enumerate(co_)])
        print(f"   int h dmu_Lambda = {mp.nstr(val, 12)};  h(0) = {mp.nstr(h(mp.mpf(0)), 10)}" + (f";  kappa = {mp.nstr(kap, 10)};  bound = {mp.nstr(val - kap * BETA1 / 2, 10)}" if kind < 0 else f";  bound = {mp.nstr(val, 10)}"))
        print(f"   scan: smallest margin inside the window {mp.nstr(wJ, 3)} (want >= about MARG);  smallest ratio to the floor outside {mp.nstr(wO, 3)} (want near 1)")
