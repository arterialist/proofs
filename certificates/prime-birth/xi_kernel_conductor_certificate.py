#!/usr/bin/env python3
"""Interval-arithmetic certificate for an explicit kernel built from Riemann's Phi function.

This script certifies numerical properties of two explicit real functions. It
says nothing about the Riemann hypothesis.

DEFINITIONS

  Phi(u) = 2 * sum_{n>=1} (2 pi^2 n^4 e^{9u/2} - 3 pi n^2 e^{5u/2}) exp(-pi n^2 e^{2u}).

Phi is even. This is a classical fact, equivalent to the functional equation
of the Jacobi theta function. It is used here as an input and is not proved by
the script. The series is used only for u >= 0, together with
Phi^(r)(-u) = (-1)^r Phi^(r)(u). With y = pi n^2 e^{2u} the n-th term of
Phi^(r)(u) is 2 e^{u/2} q_r(y) e^{-y}, where q_0 = 2y^2 - 3y and
q_{r+1} = q_r/2 + 2y q_r' - 2y q_r (exact rational coefficients).

  M_r(u) = int_R Phi^(r)(v) Phi^(r)(v - u) dv,   Psi = M_0,
  h(u)   = sum_r alpha_r M_r(u),

with the decimal coefficients alpha_r below read as exact rationals:

  R = 4: alpha = [2.27942, 0.0506854, 0.000783157, 2.13792e-6, 7.48483e-8]
  R = 6: alpha = [2.258739, 0.05216107, 0.0007103534, 4.97466e-6, 4.918306e-8,
                  0, 1.584807e-12]
  R = 8: alpha = [2.25482059, 0.0524395214, 0.000698139727, 5.51936758e-6,
                  3.87866857e-8, 1.31919267e-10, 9.53422988e-13, 0, 1.16486515e-17]
         (added after the first two; designed by cutting planes with all
         coefficients nonnegative and a margin above the R = 4 kernel)

Lambda is the von Mangoldt function (Lambda(p^k) = log p, otherwise 0).

WHAT THE SCRIPT COMPUTES (all bounds rounded outward, including the printed
decimals)

  (C1) an enclosure of Psi(0), an enclosure of Psi(0.05), and an enclosure of
       eps_Psi = 2 sum_{n>=2} Lambda(n) n^(-1/2) Psi(log n), with the part
       n > 60 bounded in closed form;
  (C2) for each kernel, an enclosure of h(0) and an enclosure of
       2 sum_{n>=2} Lambda(n) n^(-1/2) h(log n), with |h| bounded in closed
       form for n > 60;
  (C3) for each kernel, a lower bound for h on every lattice cell of [0, 4],
       and the decision whether all of them are positive;
  (C4) upper bounds T_k for sup |h| on [3 + 0.1k, 3 + 0.1(k+1)], k = 0..29,
       and a closed-form bound for sup |h| on u >= 6.

METHOD AND WHY IT IS RIGOROUS

  1. Series tail. For u >= 0 put y1 = pi e^{2u} >= pi > 1. Let |q_r|_1 be the
     sum of the absolute values of the coefficients of q_r (degree r+2). The
     n-th term of Phi^(r)(u) is at most
     2 e^{u/2} |q_r|_1 (n^2 y1)^(r+2) exp(-n^2 y1) in absolute value, and for
     n > N consecutive bounds have ratio at most
     rho = ((N+2)/(N+1))^(2r+4) exp(-(2N+3) pi) < 1/2, so the terms n > N sum
     to at most the bound for n = N+1 divided by (1 - rho). The same estimate
     from n = 1 on gives, for all real v,
       |Phi^(r)(v)| <= D_r e^{(2r+4.5)|v|} exp(-pi e^{2|v|}),
       D_r = 2 |q_r|_1 pi^(r+2) sum_{n>=1} n^(2r+4) exp(-(n^2-1) pi).
  2. Point and cell enclosures. With h0 = 2^-12 and V = 2.625, the values
     Phi^(r)(k h0), 0 <= k <= V/h0 + 1, r = 0..12, are enclosed with mpmath
     interval arithmetic (40 digits). The sup of |Phi^(12)| on each cell
     [k h0, (k+1) h0] is bounded by evaluating the series on the interval
     argument. For r < 12 the cell sup of |Phi^(r)| is bounded by the larger
     endpoint value plus (h0/2) times the cell sup of |Phi^(r+1)| (mean value
     theorem from the nearer endpoint).
  3. Quadrature. For u_j = j h0 the integral M_r(u_j) is computed by composite
     Simpson on [u_j - V', V + h0], where V' = V + h0 for even j and V' = V
     for odd j, so that the number of steps is even. On each panel the error
     is at most (h0^5/90) times the sup of the absolute value of the fourth
     derivative of the integrand, which is
     sum_i C(4,i) Phi^(r+i)(v) Phi^(r+4-i)(v - u_j) and is bounded with the
     cell sups. The omitted part of the line is at most
     2 sup|Phi^(r)| int_V^inf |Phi^(r)|, and the last integral is at most
     D_r g(V) / (2 pi e^{2V} - (2r+4.5)) with g(v) = e^{(2r+4.5)v} exp(-pi e^{2v}),
     because g'/g <= -(2 pi e^{2V} - (2r+4.5)) < 0 on v >= V.
  4. Between lattice points. The second derivative of M_r is -M_{r+1}
     (integration by parts), so on a cell [u_j, u_{j+1}] the second derivative
     of h is at most sum_r |alpha_r| A_{r+1}[j] in absolute value, where
     A_r[j] is a Riemann upper sum for int |Phi^(r)(v)| |Phi^(r)(v - u)| dv
     that is valid for every u in the cell (v - u ranges over two neighbouring
     cells and the larger sup is used), plus the truncation term of step 3.
     The linear interpolant of a C^2 function g on a cell of width h0 differs
     from g by at most (h0^2/8) times the sup of the absolute value of its
     second derivative. This gives an enclosure of h(u) at every real u in
     [0, 4.1], in particular a lower bound on every cell (C3) and enclosures
     at the points u = log n.
  5. Closed form for large u. From step 1 and e^{2a} + e^{2b} >= 2 e^{a+b},
     for u >= 2,
       |M_r(u)| <= D_r^2 e^{p u} exp(-2 pi e^u) (u + 1/(2 pi e^u - p)),  p = 2r + 4.5,
     and the right side is decreasing in u (the script checks the conditions
     2 pi e^u > p and u (2 pi e^u - p) > 1 where it uses this). It bounds the
     sums over n > 60, where Lambda(n) <= log n and the bounds decrease at
     least geometrically with ratio (62/61)^(2r+6) e^{-2 pi}, and it bounds
     sup |h| beyond the lattice.
  6. Floating point. The correlation sums over the lattice are done with numpy
     in double precision, on centre and radius data converted outward from the
     interval enclosures. A sum of n <= 21510 products has rounding error at
     most (n + 11) 2^-53 < 2.5e-12 times the sum of the absolute values of the
     terms. The script adds 1e-11 times that sum, the propagated radii, a
     relative 1e-9 on the whole error budget, and an absolute 1e-290 that
     covers underflow. The final combinations with alpha_r, the interpolation
     and the prime sums are done in interval arithmetic.

WHAT IS TAKEN FROM OUTSIDE

  The evenness of Phi, the standard Simpson and linear interpolation error
  formulas, the standard rounding error bound for floating-point sums, and the
  correctness of mpmath interval arithmetic and of IEEE double arithmetic in
  numpy. The script has not been checked by a proof assistant.

REPRODUCE

  python3 certificates/prime-birth/xi_kernel_conductor_certificate.py

The run takes about 40 seconds. An optional argument m sets h0 = 2^-m; m = 10
runs in about 6 seconds and gives the same decisions with wider enclosures.

OUTCOME (run on 10 November 2026, h0 = 2^-12)

  (C1) Psi(0) in [0.3197518119573, 0.3197518119662]
       Psi(0.05) in [0.315696769885, 0.315696817052]
       sum_{2<=n<=60} Lambda(n) n^(-1/2) Psi(log n)
           in [0.0120222071958, 0.0120222162423]
       sum_{n>60} log(n) n^(-1/2) |Psi(log n)| <= 8.057e-155
       eps_Psi in [0.0240444143914, 0.0240444324847]
       eps_Psi / Psi(0) in [0.0751971169251, 0.0751971735125]

  Kernel R = 4
  (C2) h(0) in [1.000000970811, 1.000000970839]
       2 sum_{n>=2} Lambda(n) n^(-1/2) h(log n)
           in [0.00066980688089, 0.00066991457984]
       (the part n > 60 is at most 2 * 6.928e-137 and is included)
       that sum divided by h(0) in [0.00066980623055, 0.00066991392948]
  (C3) h(u) > 0 for every real u in [0, 4]. On [0, 1.2] the infimum of
       h(u)/h(0) lies in [2.1901419e-6, 2.1964066e-6] and the minimiser lies in
       [1.125977, 1.126953]. It is not near log 2: on
       [0.6, 0.8] one has h >= 2.8635e-4.
  (C4) T_0..T_10 (lattice): 5.429e-38, 3.344e-43, 4.918e-49, 1.594e-55,
       9.002e-63, 7.666e-71, 8.513e-80, 8.964e-90, 7.852e-101, 3.867e-113,
       8.468e-127. T_11..T_29 (closed form): 7.223e-135, 1.245e-151,
       3.238e-170, 8.165e-191, 1.23e-213, 6.429e-239, 6.453e-267, 6.441e-298,
       3.083e-332, 3.17e-370, 2.887e-412, 8.699e-459, 2.941e-510, 3.356e-567,
       3.434e-630, 7.302e-700, 6.397e-777, 3.853e-862, 2.213e-956.
       sup_{u>=6} |h(u)| <= 1.363e-1060.

  Kernel R = 6
  (C2) h(0) in [0.9999999955483, 0.9999999955766]
       2 sum_{n>=2} Lambda(n) n^(-1/2) h(log n)
           in [8.3408757466e-5, 8.352108291e-5]
       that sum divided by h(0) in [8.3408757835e-5, 8.3521083282e-5]
  (C3) FAILS. This kernel is not nonnegative: h(6026/4096) lies in
       [-9.603701e-10, -9.603538e-10], and h < 0 is certified at the four
       lattice points 6025/4096 .. 6028/4096 (u from 1.470947 to 1.471680).
       h > 0 is certified on [0, 1.470459] and on [1.472168, 4].
  (C4) T_0 = 1.809e-34, T_10 = 2.107e-121, T_29 = 1.308e-943 (full table in
       the output), sup_{u>=6} |h(u)| <= 1.203e-1047.

  Kernel R = 8 (added later the same day; h0 = 2^-12)
  (C2) h(0) in [0.9999999995084, 0.9999999995367]
       2 sum_{n>=2} Lambda(n) n^(-1/2) h(log n)
           in [1.5453049306e-5, 1.5566427933e-5]
       that sum divided by h(0) in [1.5453049313e-5, 1.5566427941e-5]
  (C3) h(u) > 0 for every real u in [0, 4]. On [0, 1.2] the infimum of
       h(u)/h(0) lies in [1.1752581e-7, 1.2786779e-7], near u = 1.1007.
       Lower bounds on [0.1k, 0.1(k+1)], k = 0..9: 0.91111, 0.68538, 0.41759,
       0.19524, 0.061994, 0.0088836, 2.3809e-6, 2.4492e-5, 0.0019933, 0.00048511.
  (C4) T_10 = 1.731e-116, T_11 = 7.534e-115, then decreasing (full table in
       the output), sup_{u>=6} |h(u)| <= 5.678e-1034.
  With h0 = 2^-13 (argument 13; needs the assertion on the rounding pad
  relaxed to 5e-12, which the 1e-11 pad still covers) the same kernel gives
  the tighter 2 sum ... <= 1.5521710886e-5.

  Window kernels U2 and L2 (added later the same day, after the audit; they go
  through the same code, plus a short block that reports cell bounds inside
  and outside a window; h0 = 2^-12). Both have nonnegative coefficients
  (degree 16); they are designed by xi_kernel_window_design.py and
  xi_kernel_window_design_lower.py.
  U2: h > 0 on [0, 4]; h >= 1.0000875 on every cell covering [0.63, 0.76];
      sum_{n>=2} Lambda(n) n^(-1/2) h(log n) <= 0.49119789231 + 1.2e-114.
  L2: h >= -0.99992559 on the cells covering [0.62, 0.77], that is on
      [2539/4096, 3154/4096] = [0.619873, 0.770020]; h > 0 on every other
      cell of [0, 4]; sum_{n>=2} Lambda(n) n^(-1/2) h(log n) <= -0.48717835675
      + 3.9e-114.

  U3, L3 (window near u = log 3) and G23 (the gap between 2 and 3), designed
  with the same two scripts and wider margins (arguments 1.04 1.16 3 0.02 3.0
  10 1e-3 0.01 and 0.80 1.00 3 0.02 3.0 10 1e-3 0.01):
  U3:  h > 0 on [0, 4]; h >= 1.0007871 on every cell covering [1.04, 1.16];
       sum_{n>=2} Lambda(n) n^(-1/2) h(log n) <= 0.66170812861 + 2.5e-113.
  L3:  h >= -0.99908118 on [4218/4096, 4793/4096] = [1.029785, 1.170166];
       h > 0 on every other cell of [0, 4];
       sum_{n>=2} Lambda(n) n^(-1/2) h(log n) <= -0.57562411716 + 7.3e-113.
  G23: h > 0 on [0, 4]; h >= 1.0009733 on every cell covering [0.8, 1.0];
       sum_{n>=2} Lambda(n) n^(-1/2) h(log n) <= 0.014007355327 + 1.6e-113.

  An independent audit on 10 November 2026 rederived the bounds of steps 1
  to 5, traced the indices, and compared about 4000 internal enclosures with
  separately computed values; it found no error. Its two small repairs (the
  last partial cell of [0, 1.2], and an assertion that V is a lattice point)
  are applied.

  Comparison with the independent non-rigorous values quoted for these
  kernels: all agree with the enclosures except Psi(log 5), quoted as
  8.980973e-09, which lies below the enclosure
  [8.980982629e-9, 8.981078656e-9] by a relative 1.1e-6. A separate 30-digit
  quadrature gives 8.98099444e-9. The quoted statement that the minimum of
  h/h(0) on [0, 1.2] is about 2.96e-4 near log 2 (R = 4) does not hold; see
  (C3).
"""

import math
import sys
import time
from decimal import Decimal
from fractions import Fraction

import numpy as np
from mpmath import iv, mp

iv.dps = 40
mp.dps = 50

LOG2_NH = 12
if len(sys.argv) > 1:
    LOG2_NH = int(sys.argv[1])
NH = 1 << LOG2_NH              # h0 = 1/NH
V_NUM = Fraction(21, 8)        # v-lattice covers [0, V_NUM + h0]
K = int(V_NUM * NH)
assert K == V_NUM * NH            # the truncation point V must be a lattice point
U_NUM = Fraction(41, 10)       # u-lattice covers [0, U_NUM] at least
J = int(math.ceil(U_NUM * NH)) + 1
assert (2 * K + 20) * 2.0 ** -53 < 2.5e-12   # keeps the 1e-11 rounding pad valid
N0 = 60                        # prime powers up to N0 are treated numerically
U_REPORT = 3                   # the T_k table starts here
U_POS_CAP = 4                  # positivity is tested up to here
U_FAR = 6                      # closed-form bound beyond here

KERNELS = {
    "R=4": ["2.27942", "0.0506854", "0.000783157", "2.13792e-6", "7.48483e-8"],
    "R=6": ["2.258739", "0.05216107", "0.0007103534", "4.97466e-6",
            "4.918306e-8", "0", "1.584807e-12"],
    "R=8": ["2.25482059", "0.0524395214", "0.000698139727", "5.51936758e-6", "3.87866857e-8",
            "1.31919267e-10", "9.53422988e-13", "0", "1.16486515e-17"],
    "U2": ["192.7779014", "3.959614914", "0.06592039741", "0.0005995292912", "4.954190381e-6",
           "1.738108178e-8", "1.390956481e-10", "0", "1.762076328e-15"],
    "L2": ["1220.800154", "28.93268369", "0.3723188798", "0.002872879735", "1.940677066e-5",
           "6.551462272e-8", "4.621451718e-10", "0", "5.605901241e-15"],
    "U3": ["4681.017422", "107.6991329", "1.536999666", "0.01018574292", "8.051835769e-5",
           "2.735600934e-7", "2.635593653e-9", "0", "3.554419576e-14"],
    "L3": ["22431.67095", "523.7339458", "6.878384543", "0.05613023865", "0.000387100216",
           "1.379400156e-6", "9.219381289e-9", "0", "1.065657205e-13"],
    "G23": ["4474.921543", "104.0618952", "1.386609903", "0.0110032152", "7.664294594e-5",
            "2.627366923e-7", "1.872102231e-9", "0", "2.267788331e-14"],
}
WINDOWS = {"U2": (Fraction(63, 100), Fraction(76, 100)), "L2": (Fraction(62, 100), Fraction(77, 100)),
           "U3": (Fraction(104, 100), Fraction(116, 100)), "L3": (Fraction(103, 100), Fraction(117, 100)),
           "G23": (Fraction(80, 100), Fraction(100, 100))}
RM = max(len(a) for a in KERNELS.values()) - 1   # largest r in any kernel
TOP = RM + 6                                     # highest derivative order evaluated

PI = iv.pi
H0 = iv.mpf(1) / NH
INF = math.inf


def LO(x):
    """Lower endpoint of an interval as an exact mp number."""
    return mp.make_mpf(x._mpi_[0])


def HI(x):
    """Upper endpoint of an interval as an exact mp number."""
    return mp.make_mpf(x._mpi_[1])


def f_up(x):
    """A float that is >= the upper endpoint of the interval x."""
    b = HI(x)
    f = math.nextafter(float(b), INF)
    assert mp.mpf(f) >= b
    return f


def su(v, n=6):
    """Decimal string with n significant digits that is >= v."""
    v = mp.mpf(v)
    s = mp.nstr(v, n)
    if mp.mpf(s) < v:
        s = mp.nstr(v + abs(v) * mp.mpf(10) ** (1 - n), n)
    assert mp.mpf(s) >= v
    return s


def sd(v, n=6):
    """Decimal string with n significant digits that is <= v."""
    v = mp.mpf(v)
    s = mp.nstr(v, n)
    if mp.mpf(s) > v:
        s = mp.nstr(v - abs(v) * mp.mpf(10) ** (1 - n), n)
    assert mp.mpf(s) <= v
    return s


def ss(x, n=12):
    """Outward-rounded decimal rendering of an interval."""
    return "[%s, %s]" % (sd(LO(x), n), su(HI(x), n))


def frac_iv(fr):
    return iv.mpf(fr.numerator) / fr.denominator


# ---------------------------------------------------------------- polynomials
def q_polys(rmax):
    q = [Fraction(0), Fraction(-3), Fraction(2)]
    out = [q]
    for _ in range(rmax):
        new = [Fraction(0)] * (len(q) + 1)
        for jj, c in enumerate(q):
            new[jj] += c / 2 + 2 * jj * c
            new[jj + 1] -= 2 * c
        q = new
        out.append(q)
    return out


QF = q_polys(TOP)
QIV = [[frac_iv(c) for c in q] for q in QF]
Q1 = [frac_iv(sum(abs(c) for c in q)) for q in QF]
for q in QF:
    assert q[0] == 0


def rho_tail(N, r):
    """Upper bound for the ratio of consecutive tail bounds, n >= N+1, u >= 0."""
    rho = (iv.mpf(N + 2) / (N + 1)) ** (2 * r + 4) * iv.exp(-(2 * N + 3) * PI)
    assert HI(rho) < 0.5
    return rho


RHO = {N: [rho_tail(N, r) for r in range(TOP + 1)] for N in (2, 3, 7, 30)}


def phi_derivs(x, N, orders):
    """Enclosures of Phi^(r) on the interval x (x >= 0), for r in orders."""
    e2 = iv.exp(2 * x)
    eh = iv.exp(x / 2)
    y1 = PI * e2
    acc = {r: iv.mpf(0) for r in orders}
    for n in range(1, N + 1):
        y = y1 * (n * n)
        ey = iv.exp(-y)
        for r in orders:
            c = QIV[r]
            s = c[-1]
            for a in c[-2:0:-1]:
                s = s * y + a
            acc[r] += s * y * ey
    yN = y1 * ((N + 1) ** 2)
    eyN = iv.exp(-yN)
    out = {}
    for r in orders:
        t = HI(Q1[r] * yN ** (r + 2) * eyN / (1 - RHO[N][r]))
        out[r] = 2 * eh * (acc[r] + iv.mpf([-t, t]))
    return out


def n_terms(k):
    v = Fraction(k, NH)
    if v < Fraction(1, 2):
        return 7
    if v < 1:
        return 3
    return 2


# D_r, the constant of the global bound of step 1
def d_const(r):
    Ng = 30
    s = iv.mpf(0)
    for n in range(1, Ng + 1):
        s += iv.mpf(n) ** (2 * r + 4) * iv.exp(-(n * n - 1) * PI)
    t = iv.mpf(Ng + 1) ** (2 * r + 4) * iv.exp(-((Ng + 1) ** 2 - 1) * PI)
    s += iv.mpf([0, HI(t / (1 - RHO[Ng][r]))])
    return 2 * Q1[r] * PI ** (r + 2) * s


D = [d_const(r) for r in range(TOP + 1)]


def tail_int(r, V):
    """Upper bound (interval) for int_V^inf |Phi^(r)|."""
    p = iv.mpf(4 * r + 9) / 2
    c = 2 * PI * iv.exp(2 * V) - p
    assert LO(c) > 0
    return D[r] * iv.exp(p * V - PI * iv.exp(2 * V)) / c


def cf_term(r, u):
    """Closed-form upper bound (interval) for |M_r(u)|, valid for u >= 2."""
    p = iv.mpf(4 * r + 9) / 2
    c = 2 * PI * iv.exp(u) - p
    assert LO(u) >= 2 and LO(c) > 0 and LO(u * c) > 1
    return D[r] ** 2 * iv.exp(p * u - 2 * PI * iv.exp(u)) * (u + 1 / c)


def cf_bound(u, absalpha):
    tot = iv.mpf(0)
    for r, a in enumerate(absalpha):
        if HI(a) > 0:
            tot += a * cf_term(r, u)
    return tot


def cf_prime_tail(absalpha):
    """Upper bound for sum_{n > N0} log(n) n^(-1/2) |sum_r alpha_r M_r(log n)|."""
    n = iv.mpf(N0 + 1)
    tot = iv.mpf(0)
    for r, a in enumerate(absalpha):
        if HI(a) > 0:
            rho = (iv.mpf(N0 + 2) / (N0 + 1)) ** (2 * r + 6) * iv.exp(-2 * PI)
            assert HI(rho) < 0.5
            t = iv.log(n) / iv.sqrt(n) * cf_term(r, iv.log(n))
            tot += a * t / (1 - rho)
    return tot


def von_mangoldt_table(N):
    out = []
    for n in range(2, N + 1):
        p = next(d for d in range(2, n + 1) if n % d == 0)
        m = n
        while m % p == 0:
            m //= p
        if m == 1:
            out.append((n, p))
    return out


def main():
    t0 = time.time()
    print("h0 = 1/%d, v-lattice to %s + h0 (K = %d), u-lattice to %.6f (J = %d), "
          "orders 0..%d" % (NH, V_NUM, K, J / NH, J, TOP))

    # ---------------------------------------------------- point enclosures
    orders = list(range(TOP + 1))
    Pc = np.zeros((TOP + 1, K + 2))
    Pe = np.zeros((TOP + 1, K + 2))
    odd_at_zero = 0.0
    for k in range(K + 2):
        x = iv.mpf(k) / NH
        vals = phi_derivs(x, n_terms(k), orders)
        for r in orders:
            X = vals[r]
            c = float(X.mid)
            Pc[r, k] = c
            Pe[r, k] = f_up(abs(X - iv.mpf(c)))
            if k == 0 and r % 2 == 1:
                assert LO(X) <= 0 <= HI(X)
                odd_at_zero = max(odd_at_zero, f_up(abs(X)))
    print("points done  %.1fs; odd derivatives at 0 enclose 0, |.| <= %.2e"
          % (time.time() - t0, odd_at_zero))

    # ----------------------------------------------------- cell sup bounds
    S = np.zeros((TOP + 1, K + 1))
    for k in range(K + 1):
        x = iv.mpf([iv.mpf(k) / NH, iv.mpf(k + 1) / NH])
        S[TOP, k] = f_up(abs(phi_derivs(x, n_terms(k), [TOP])[TOP]))
    h0f = 1.0 / NH
    for r in range(TOP - 1, -1, -1):
        up = np.abs(Pc[r]) + Pe[r]
        S[r] = (np.maximum(up[:-1], up[1:]) + 0.5 * h0f * S[r + 1]) * (1 + 1e-14) + 1e-320
    print("cells done   %.1fs" % (time.time() - t0))

    # full-line arrays: points m = -(K+1)..K+1, cells m = -(K+1)..K
    Pcf, Pef, Sf, Wf = [], [], [], []
    for r in orders:
        sg = -1.0 if r % 2 else 1.0
        Pcf.append(np.concatenate((sg * Pc[r, :0:-1], Pc[r])))
        Pef.append(np.concatenate((Pe[r, :0:-1], Pe[r])))
        sf = np.concatenate((S[r, ::-1], S[r]))
        Sf.append(sf)
        Wf.append(np.maximum(sf[:-1], sf[1:]))
    assert len(Pcf[0]) == 2 * K + 3 and len(Sf[0]) == 2 * K + 2

    # remainders of the truncated line
    Vv = frac_iv(V_NUM)
    REM = []
    for r in range(RM + 2):
        beyond = D[r] * iv.exp(iv.mpf(4 * r + 9) / 2 * Vv - PI * iv.exp(2 * Vv))
        gsup = max(float(S[r].max()), f_up(beyond))
        REM.append(f_up(2 * iv.mpf(gsup) * tail_int(r, Vv)))
    print("line truncation remainders: max %.2e" % max(REM))

    # ------------------------------------------------ lattice correlations
    C4 = (1.0, 4.0, 6.0, 4.0, 1.0)
    Mc = np.zeros((RM + 1, J + 1))
    Mr = np.zeros((RM + 1, J + 1))
    A = np.zeros((RM + 2, J))       # A[r][j], r = 1..RM+1, cell j = [u_j, u_{j+1}]
    simp_coef = h0f ** 5 / 90.0
    for j in range(J + 1):
        lo = j - K - 1 if j % 2 == 0 else j - K
        i0 = lo + K + 1
        a0 = i0 - j
        n = 2 * K + 2 - i0
        assert n % 2 == 0 and n >= 2 and a0 >= 0
        for r in range(RM + 1):
            X = Pcf[r][i0:]
            Y = Pcf[r][a0:a0 + n + 1]
            prod = X * Y
            tot = 4.0 * prod[1::2].sum() + 2.0 * prod[0::2].sum() - prod[0] - prod[-1]
            absS = np.abs(prod).sum()
            EX = Pef[r][i0:]
            EY = Pef[r][a0:a0 + n + 1]
            rad = (np.abs(X) * EY + np.abs(Y) * EX + EX * EY).sum()
            cb = C4[0] * Sf[r][i0:i0 + n] * Sf[r + 4][a0:a0 + n]
            for i in range(1, 5):
                cb = cb + C4[i] * Sf[r + i][i0:i0 + n] * Sf[r + 4 - i][a0:a0 + n]
            pan = np.maximum(cb[0::2], cb[1::2]).sum()
            val = (h0f / 3.0) * tot
            err = (h0f / 3.0) * (4e-11 * absS + 4.0 * rad) + simp_coef * pan + REM[r]
            Mc[r, j] = val
            Mr[r, j] = err * (1 + 1e-9) + abs(val) * 1e-15 + 1e-290
        if j < J:
            for r in range(1, RM + 2):
                s = np.dot(Sf[r][j + 1:2 * K + 2], Wf[r][0:2 * K - j + 1])
                A[r, j] = h0f * s * (1 + 1e-9) + REM[r] + 1e-290
    print("lattice done %.1fs" % (time.time() - t0))

    c8 = H0 * H0 / 8
    PM = iv.mpf([-1, 1])

    def lattice_iv(r):
        return [iv.mpf(float(Mc[r, j])) + PM * iv.mpf(float(Mr[r, j]))
                for j in range(J + 1)]

    Miv = [lattice_iv(r) for r in range(RM + 1)]

    def encl(u, vals, curv):
        """Enclosure of g(u) from lattice enclosures vals and cell bounds curv
        for sup |g''|, by linear interpolation with remainder h0^2/8 sup|g''|."""
        t = u * NH
        ja = int(mp.floor(LO(t)))
        jb = int(mp.floor(HI(t)))
        assert 0 <= ja and jb < J
        lo, hi = None, None
        for jj in range(ja, jb + 1):
            th = t - jj
            th = iv.mpf([max(LO(th), mp.mpf(0)), min(HI(th), mp.mpf(1))])
            e = (1 - th) * vals[jj] + th * vals[jj + 1] + PM * curv[jj] * c8
            lo = LO(e) if lo is None else min(lo, LO(e))
            hi = HI(e) if hi is None else max(hi, HI(e))
        return iv.mpf([lo, hi])

    primes_pow = von_mangoldt_table(N0)

    def prime_sum(vals, curv):
        tot = iv.mpf(0)
        for n, p in primes_pow:
            tot += iv.log(p) / iv.sqrt(n) * encl(iv.log(n), vals, curv)
        return tot

    discrepancies = []

    def refcheck(label, e, rstr):
        """Compare an enclosure with an independent decimal value. The value is
        allowed half a unit in its last quoted digit."""
        d = Decimal(rstr)
        rv = mp.mpf(rstr)
        half = mp.mpf(10) ** d.as_tuple().exponent / 2
        dist = max(LO(e) - rv, rv - HI(e), mp.mpf(0))
        if dist <= half:
            return "independent %s: consistent" % rstr
        discrepancies.append(label)
        return ("independent %s: OUTSIDE the enclosure by %s (relative %s)"
                % (rstr, mp.nstr(dist, 3), mp.nstr(dist / abs(rv), 3)))

    # ------------------------------------------------------------- (C1)
    print()
    print("=== (C1) Psi = M_0 ===")
    psi = Miv[0]
    psi_curv = [iv.mpf(float(A[1, j])) for j in range(J)]
    print("Psi(0) in %s" % ss(psi[0], 13))
    e = encl(iv.mpf(1) / 20, psi, psi_curv)
    print("Psi(0.05) in %s" % ss(e, 12))
    ref = {1: "0.319751811962", 2: "2.415804e-02", 3: "2.853575e-04",
           4: "1.861007e-06", 5: "8.980973e-09"}
    for n in range(1, 6):
        e = psi[0] if n == 1 else encl(iv.log(n), psi, psi_curv)
        print("  Psi(log %d) in %s   %s"
              % (n, ss(e, 10), refcheck("Psi(log %d)" % n, e, ref[n])))
    ps = prime_sum(psi, psi_curv)
    tl = HI(cf_prime_tail([iv.mpf(1)]))
    print("sum_{2<=n<=%d} Lambda(n) n^(-1/2) Psi(log n) in %s" % (N0, ss(ps, 12)))
    print("sum_{n>%d} log(n) n^(-1/2) |Psi(log n)| <= %s" % (N0, su(tl, 4)))
    eps = 2 * (ps + PM * tl)
    print("eps_Psi in %s" % ss(eps, 12))
    print("eps_Psi / Psi(0) in %s" % ss(eps / psi[0], 12))

    # -------------------------------------------------------- (C2)-(C4)
    refs_h = [("0.2", "0.691453"), ("0.5", "0.0662987"), ("0.696", "0.000295625"),
              ("1.0", "0.00105541"), ("1.1", "3.88521e-5"), ("1.388", "0.000358634"),
              ("1.6", "4.56475e-5"), ("2.0", "4.49673e-9"), ("2.6", "3.86134e-22"),
              ("3.0", "5.42823e-38")]
    refs_k = {"R=4": ("1.00000097083", "0.00066985551"),
              "R=6": ("0.999999995562", "8.3460966e-5"),
              "R=8": ("0.99999999952207", "1.5505961e-5"),
              "U2": ("85.69761078", "0.011463450"), "L2": ("541.4080838", "-0.0017997323"),
              "U3": ("2076.636015", "0.00063722773"), "L3": ("9955.019816", "-0.00011570551"), "G23": ("1984.765586", "1.4054411e-5")}
    jtest = U_POS_CAP * NH
    assert jtest <= J
    summary = {}
    for name, astr in KERNELS.items():
        print()
        print("=== kernel %s, alpha = [%s] ===" % (name, ", ".join(astr)))
        alpha = [frac_iv(Fraction(s)) for s in astr]
        absal = [abs(a) for a in alpha]
        R = len(alpha) - 1
        hv = []
        for j in range(J + 1):
            s = iv.mpf(0)
            for r in range(R + 1):
                s += alpha[r] * Miv[r][j]
            hv.append(s)
        hc = []
        for j in range(J):
            s = iv.mpf(0)
            for r in range(R + 1):
                s += absal[r] * iv.mpf(float(A[r + 1, j]))
            hc.append(iv.mpf(HI(s)))
        h0v = hv[0]
        print("(C2) h(0) in %s   %s"
              % (ss(h0v, 13), refcheck(name + " h(0)", h0v, refs_k[name][0])))
        ps = prime_sum(hv, hc)
        tl = HI(cf_prime_tail(absal))
        print("     sum_{2<=n<=%d} Lambda(n) n^(-1/2) h(log n) in %s" % (N0, ss(ps, 11)))
        print("     sum_{n>%d} log(n) n^(-1/2) |h(log n)| <= %s" % (N0, su(tl, 4)))
        tot = 2 * (ps + PM * tl)
        print("     2 sum_{n>=2} Lambda(n) n^(-1/2) h(log n) in %s" % ss(tot, 11))
        Bq = tot / h0v
        print("     B = that sum / h(0) in %s   %s"
              % (ss(Bq, 11), refcheck(name + " B", Bq, refs_k[name][1])))

        # (C3) positivity cell by cell
        low = [min(LO(hv[j]), LO(hv[j + 1])) - HI(hc[j] * c8) for j in range(J)]
        bad = [j for j in range(jtest) if not low[j] > 0]
        neg = [j for j in range(jtest + 1) if HI(hv[j]) < 0]
        if not bad:
            print("(C3) CERTIFIED: h(u) > 0 for every u in [0, %d] (%d cells)"
                  % (U_POS_CAP, jtest))
            summary[name] = "h > 0 on [0, %d] certified" % U_POS_CAP
        else:
            print("(C3) NOT CERTIFIED on [0, %d]: %d cells have no positive lower "
                  "bound; all of them lie in [%.6f, %.6f]; h > 0 is certified on "
                  "[0, %.6f] and on [%.6f, %d]"
                  % (U_POS_CAP, len(bad), bad[0] / NH, (bad[-1] + 1) / NH,
                     bad[0] / NH, (bad[-1] + 1) / NH, U_POS_CAP))
            summary[name] = "h > 0 on [0, %d] NOT certified" % U_POS_CAP
        if neg:
            jn = min(neg, key=lambda jj: HI(hv[jj]))
            print("     DISPROVED: h(u) < 0 is certified at %d lattice points, from "
                  "u = %d/%d = %.6f to u = %d/%d = %.6f; at u = %d/%d = %.6f, h in %s"
                  % (len(neg), neg[0], NH, neg[0] / NH, neg[-1], NH, neg[-1] / NH,
                     jn, NH, jn / NH, ss(hv[jn], 8)))
            summary[name] = ("h is NOT nonnegative: h(%d/%d) <= %s < 0 certified"
                             % (jn, NH, su(HI(hv[jn]), 6)))
        if name in WINDOWS:
            wa, wb = WINDOWS[name]
            ja_in, jb_in = math.ceil(wa * NH), math.floor(wb * NH)          # cells inside [wa, wb]
            ja_out, jb_out = math.floor(wa * NH), math.ceil(wb * NH)        # cells covering [wa, wb]
            print("     WINDOW [%s, %s]: min of cell lower bounds over cells inside it, [%d/%d, %d/%d]: %s"
                  % (wa, wb, ja_in, NH, jb_in, NH, sd(min(low[j] for j in range(ja_in, jb_in)), 8)))
            print("     WINDOW: min of cell lower bounds over cells covering it, [%d/%d, %d/%d]: %s"
                  % (ja_out, NH, jb_out, NH, sd(min(low[j] for j in range(ja_out, jb_out)), 8)))
            outside = [j for j in range(jtest) if (j < ja_out or j >= jb_out)]
            badout = [j for j in outside if not low[j] > 0]
            print("     WINDOW: cells outside [%d/%d, %d/%d] and inside [0, %d] without a positive lower bound: %d%s"
                  % (ja_out, NH, jb_out, NH, U_POS_CAP, len(badout),
                     "" if not badout else " (first at u = %.6f, last at u = %.6f)" % (badout[0] / NH, badout[-1] / NH)))
        j12 = math.ceil(Fraction(12, 10) * NH)
        jmin = min(range(j12), key=lambda jj: low[jj])
        print("     smallest cell lower bound of h on [0, 1.2]: %s on [%.6f, %.6f]; "
              "h at the left end of that cell in %s"
              % (sd(low[jmin], 8), jmin / NH, (jmin + 1) / NH, ss(hv[jmin], 8)))
        print("     hence inf of h(u)/h(0) over [0, 1.2] lies in [%s, %s]"
              % (sd(LO(iv.mpf(low[jmin]) / h0v), 8), su(HI(hv[jmin] / h0v), 8)))
        print("     curvature bound sup|h''| on that cell: %s; chord term "
              "h0^2/8 sup|h''|: %s" % (su(HI(hc[jmin]), 5), su(HI(hc[jmin] * c8), 4)))
        if not bad:
            worst = min(range(jtest), key=lambda jj: low[jj] / HI(hv[jj]))
            print("     smallest (cell lower bound)/(lattice upper value) on [0, %d]: "
                  "%.4f at u = %.4f"
                  % (U_POS_CAP, float(low[worst] / HI(hv[worst])), worst / NH))
        print("     bounds for h on [0.1k, 0.1(k+1)] (lower, upper):")
        for k in range(U_REPORT * 10):
            ja = int(math.floor(Fraction(k, 10) * NH))
            jb = int(math.ceil(Fraction(k + 1, 10) * NH))
            lo_k = min(low[ja:jb])
            hi_k = max(HI(iv.mpf(max(HI(hv[jj]), HI(hv[jj + 1]))) + hc[jj] * c8)
                       for jj in range(ja, jb))
            print("       k=%2d  [%.1f, %.1f]  %s  %s"
                  % (k, k / 10, (k + 1) / 10, sd(lo_k, 5), su(hi_k, 5)))
        if name == "R=4":
            for us, rstr in refs_h:
                e = encl(frac_iv(Fraction(us)), hv, hc) / h0v
                print("     h(%s)/h(0) in %s   %s"
                      % (us, ss(e, 9), refcheck("h(%s)/h(0)" % us, e, rstr)))

        # (C4) T_k table
        print("(C4) T_k >= sup |h| on [%d + 0.1k, %d + 0.1(k+1)]; 'lattice' uses the "
              "enclosures and the chord term, 'closed' the closed-form bound at the "
              "left end" % (U_REPORT, U_REPORT))
        nk = (U_FAR - U_REPORT) * 10
        for k in range(nk):
            a = Fraction(U_REPORT) + Fraction(k, 10)
            b = a + Fraction(1, 10)
            closed = HI(cf_bound(frac_iv(a), absal))
            ja = int(math.floor(a * NH))
            jb = int(math.ceil(b * NH))
            best, src = closed, "closed"
            if jb <= J:
                num = mp.mpf(0)
                for jj in range(ja, jb):
                    cand = HI(iv.mpf(max(HI(abs(hv[jj])), HI(abs(hv[jj + 1])))) + hc[jj] * c8)
                    num = max(num, cand)
                if num < closed:
                    best, src = num, "lattice"
            print("     k=%2d  [%.1f, %.1f]  T_k = %s  (%s)"
                  % (k, float(a), float(b), su(best, 4), src))
        far = HI(cf_bound(iv.mpf(U_FAR), absal))
        print("     sup_{u >= %d} |h(u)| <= %s" % (U_FAR, su(far, 4)))

    print()
    print("total time %.1fs" % (time.time() - t0))
    for name in KERNELS:
        print("SUMMARY %s: %s" % (name, summary[name]))
    print("independent values outside the enclosures: %s"
          % (", ".join(discrepancies) if discrepancies else "none"))
    return 0 if summary["R=4"].endswith("certified") and "NOT" not in summary["R=4"] else 1


if __name__ == "__main__":
    sys.exit(main())
