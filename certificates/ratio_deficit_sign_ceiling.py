#!/usr/bin/env python3
"""Height ceiling of the ratio-deficit zero-exclusion method. Requires mpmath.

The Lean bounded-height theorem (RiemannZetaRatioSurplus) refutes a zero at
s = sigma + i t, 1/2 < sigma <= 1, by comparing the exact value
normImRatio(rho) = 1/|rho(rho-1)|^2 that holds at a zero with a majorant of
    normImRatio(s) = Im(Lambda_0(s)) / ((2 sigma - 1) t)
valid on a whole band of heights. Since Lambda_0(s) = Lambda(s) + 1/s + 1/(1-s),
    normImRatio(s) - 1/|s(s-1)|^2 = Im(Lambda(s)) / ((2 sigma - 1) t),
so a majorant that refutes every point of a band can exist only where this
gap is negative throughout the band, i.e. where Im(Lambda(sigma + i t)) < 0
for sigma just right of 1/2. By Cauchy-Riemann that is where Lambda(1/2 + i t)
is increasing in t. Lambda(1/2 + i t) is negative on [0, 14.13), vanishes at the
first zero and reaches its first local maximum shortly after; past that point
the gap is positive and no valid majorant can refute the band.

This script prints the gap at sigma = 0.55 on a grid of heights and locates
the first zero and the first turning point. It is a finite numerical check of
the sign structure, not a certificate over continuous parameters.
"""

import mpmath as mp

mp.mp.dps = 30


def completed_zeta(s):
    return mp.pi ** (-s / 2) * mp.gamma(s / 2) * mp.zeta(s)


def norm_im_ratio(s):
    sig, t = mp.re(s), mp.im(s)
    lam0 = completed_zeta(s) + 1 / s + 1 / (1 - s)
    return mp.im(lam0) / ((2 * sig - 1) * t)


def main():
    heights = [1, 3, 5, 7, 7.465, 8, 9, 10, 12, 14, 14.13, 14.2, 15, 15.5, 16, 17, 18, 20, 21, 22]
    print(" t      gap = normImRatio - 1/|s(s-1)|^2   (sigma = 0.55)")
    signs = {}
    for t in heights:
        s = mp.mpc(mp.mpf("0.55"), t)
        gap = norm_im_ratio(s) - 1 / abs(s * (s - 1)) ** 2
        signs[t] = mp.sign(gap)
        print(f"{t:7.3f}   {mp.nstr(gap, 5):>12}")
    f = lambda t: mp.re(completed_zeta(mp.mpc(0.5, t)))
    df = lambda t: mp.diff(f, t)
    zero1 = mp.findroot(f, 14.1)
    turn1 = mp.findroot(df, 15.5)
    print("first zero of Lambda(1/2 + i t):      ", mp.nstr(zero1, 12))
    print("first turning point after it:         ", mp.nstr(turn1, 12))
    # finite assertions of the sign structure
    assert all(signs[t] < 0 for t in heights if t <= 15), "gap must be negative below the turning point"
    assert all(signs[t] > 0 for t in heights if 16 <= t <= 21), "gap must be positive after the turning point"
    assert 14.13 < zero1 < 14.14
    assert 15 < turn1 < 16
    print("sign structure checks passed")


if __name__ == "__main__":
    main()
