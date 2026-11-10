"""Design of an explicit kernel with safety margins for a certified LOWER bound on the prime mass in a window, from
Corollary 2 alone (Corollary 6 of building-blocks/weil-and-spectral/admissible-systems-xi-kernel-comparison.md).
w' = sum beta_i (t/10)^(2i), beta_i >= 0;  k = h_{w'} = sum beta_i S_i  with  k(u) >= floor(u) outside the open window
(UA-PAD, UB+PAD) and k(u) >= -(1 - MARG) inside it.  Minimise int k dmu_Lambda.  For an admissible system of conductor
<= 1, int k dmu <= int k dmu_Lambda, and int k dmu >= -mu(window) up to the far tail, so mu(window) >= -int k dmu_Lambda.
Reuses the table, basis conversion, floor and refined LP of xi_kernel_window_design.py (same command-line arguments).
Usage: python3 xi_kernel_window_design_lower.py 0.63 0.76 0.3 0.002 3.0 10 1e-4 0.01

Outcome, 10 November 2026: window u in (0.62, 0.77); coefficients of t^(2i):
   [1220.800154, 28.93268369, 0.3723188798, 0.002872879735, 1.940677066e-5, 6.551462272e-8, 4.621451718e-10, 0, 5.605901241e-15],
   int k dmu_Lambda = -0.4871945895 (uncertified value; the certificate script gives <= -0.4871783).
"""
import mpmath as mp, numpy as np, sys
import xi_kernel_window_design as W        # reuses its table, basis conversion, floor and LP refinement (its own main loop runs first)
mp.mp.dps = 50
R, S, floor, us, UMAX, UA, UB, PAD, MARG, objS, refined, DIG = W.R, W.S, W.floor, W.us, W.UMAX, W.UA, W.UB, W.PAD, W.MARG, W.objS, W.refined, W.DIG
inJ = lambda u: UA - PAD < u < UB + PAD
tgt = lambda u: -(1 - MARG) if inJ(u) else floor(u)
pts = sorted(set(u for u in us if u <= UMAX) | {UA - PAD, UB + PAD})
for it in range(30):
    rows = [[-x for x in S(u)] for u in pts]; rhs = [-tgt(u) for u in pts]
    x = refined(objS, rows, rhs, [mp.mpf(0)] * (R + 1)); assert x is not None
    k = lambda u: mp.fsum(x[i] * S(u)[i] for i in range(R + 1))
    new = []; worst = mp.mpf(0)
    for i in range(len(pts) - 1):
        a_, b_ = pts[i], pts[i + 1]
        if b_ - a_ < mp.mpf(10) ** -8: continue
        u = (a_ + b_) / 2
        if inJ(a_) != inJ(b_) and not inJ(u): continue                       # cannot happen: window endpoints are grid points
        ref = floor(u) if not inJ(u) else MARG
        if min(k(a_) - tgt(a_), k(b_) - tgt(b_)) < 5 * ref or inJ(a_) != inJ(b_):
            v = k(u) - tgt(u)
            if v < -ref * mp.mpf("0.02"): new.append(u); worst = min(worst, v / ref)
    val = mp.fsum(objS[i] * x[i] for i in range(R + 1))
    print(f"   round {it}: int k dmu_Lambda = {mp.nstr(val, 10)}, {len(new)} new points, worst shortfall {mp.nstr(worst, 3)}", flush=True)
    if not new: break
    pts = sorted(set(pts) | set(new))
co_ = [mp.mpf(mp.nstr(v, DIG)) for v in x]
k = lambda u: mp.fsum(co_[i] * S(u)[i] for i in range(R + 1)); val = mp.fsum(objS[i] * co_[i] for i in range(R + 1))
wJ = None; wO = None
for i in range(len(pts) - 1):
    for f in (0, mp.mpf(1) / 3, mp.mpf(2) / 3):
        u = pts[i] + f * (pts[i + 1] - pts[i])
        if u > UMAX: continue
        if inJ(u): d = k(u) + 1; wJ = d if wJ is None else min(wJ, d)
        else: d = k(u) / floor(u); wO = d if wO is None else min(wO, d)
print(f"LOWER-bound kernel k, window u in ({mp.nstr(UA - PAD, 4)}, {mp.nstr(UB + PAD, 4)}) (x in ({mp.nstr(mp.exp(UA - PAD), 6)}, {mp.nstr(mp.exp(UB + PAD), 6)}))")
print("   coefficients of (t/10)^(2i):", [mp.nstr(v, DIG) for v in co_])
print("   alpha (coefficients of t^(2i)):", [mp.nstr(v / mp.mpf(10) ** (2 * i), DIG) for i, v in enumerate(co_)])
print(f"   int k dmu_Lambda = {mp.nstr(val, 12)}, so mu(window) >= {mp.nstr(-val, 10)};  k(0) = {mp.nstr(k(mp.mpf(0)), 10)}")
print(f"   scan: smallest value of k + 1 inside the window {mp.nstr(wJ, 3)} (want >= about MARG);  smallest ratio k/floor outside {mp.nstr(wO, 3)} (want near 1)")
