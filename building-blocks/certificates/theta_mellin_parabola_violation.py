"""One complete-theta complex Mellin zero outside the proposed parabola.

Requires Python 3 and python-flint 0.9.0. Run normally, without Python -O.
The decimal center denotes an exact rational complex number. Arb encloses its
representation, all arithmetic, and quadrature. This script certifies one disk,
not a zero search. H(s)=M(2s); L(s)=F(s+1) has the same zeros in this nonreal disk.
"""
from flint import arb, acb, ctx

ctx.prec = 400
D = 160
r = arb(1) / 8
pi = arb.pi()
s0 = acb(
    arb('-15.7411007975796356324473173878716903235743262045'),
    arb('11.4066450665758241266568702313955444990207623847'))
R = arb(2) ** -140
sigma_lo = (s0.real - R).lower()
sigma_hi = (s0.real + R).upper()
assert sigma_hi <= -1
assert s0.imag > R


def theta_coefficients():
    factorials = [arb(1)]
    for k in range(1, D + 1):
        factorials.append(factorials[-1] * k)
    coefficients = [arb(0) for _ in range(D + 1)]
    for n in range(1, 25):
        p = pi * n * n
        exponent = [-p * arb(2)**j / factorials[j] for j in range(D + 1)]
        exponential = [(-p).exp()]
        for j in range(1, D + 1):
            exponential.append(sum(
                (k * exponent[k] * exponential[j-k] for k in range(1, j+1)),
                arb(0)) / j)
        for j in range(0, D + 1, 2):
            coefficients[j] += sum((exponential[j-k] * (
                4*p*p*(arb(9)/2)**k - 6*p*(arb(5)/2)**k
            ) / factorials[k] for k in range(j+1)), arb(0))
    # Complete kernel is even. Cauchy's inequality on |u| <= 1/2
    # encloses the omitted n >= 25 coefficients, not just the finite sum.
    disk_tail = 952 * arb(25)**4 * (-arb(625)/2).exp()
    for k in range(0, D + 1, 2):
        coefficients[k] += arb(0, (disk_tail * arb(2)**k).upper())
    return coefficients


def log_power_integral(p, order):
    """Integral_0^r u^(p-1) (2|log u|)^order du, p > 0."""
    assert p > 0
    z = r**p / p
    ell = -r.log()
    if order == 1:
        z *= 2 * (ell + 1/p)
    elif order == 2:
        z *= 4 * ((ell + 1/p)**2 + 1/p**2)
    return z


# The full even Taylor remainder is at most
# (16/15)*10000*4^81*u^162 on [0,1/8].
taylor_constant = arb(16)/15 * 10000 * arb(4)**81
taylor_p = 2*sigma_lo + D + 3
assert taylor_p > 0
U = max(arb(1), r**(2*sigma_lo), arb(3)**(2*sigma_hi))
# Complete n >= 9 theta tail on [r,3], including the outer factor 2.
# The common factor 25 bounds (2|log u|)^j for j <= 2.
theta_integral_tail = 6 * U * 25 * 160 * arb(9)**4 * (-arb(243)).exp()
T = arb(6).exp()
# Since sigma_hi <= -1, u^(2 sigma_hi)(2 log u)^j <= 1 on u >= 3, j <= 2.
infinity_tail = 16*pi*T**(arb(5)/4)*(-pi*T).exp()
coeff = theta_coefficients()


def continued_monomial(s, k, order):
    p = 2*s + k + 1
    assert not p.contains(0)
    z = (p*r.log()).exp() / p
    if order == 1:
        z *= 2 * (r.log() - 1/p)
    elif order == 2:
        z *= 4 * ((r.log() - 1/p)**2 + 1/p**2)
    return z


def mellin_at_center(order):
    small = sum((coeff[k] * continued_monomial(s0, k, order)
                 for k in range(0, D + 1, 2)), acb(0))

    def integrand(u, analytic):
        log_u = u.log(analytic=analytic)
        p = pi * (2*u).exp()
        phi = (u/2).exp() * sum((
            (4*(n*n*p)**2 - 6*n*n*p) * (-n*n*p).exp()
            for n in range(1, 9)), acb(0))
        return (2*s0*log_u).exp() * (2*log_u)**order * phi

    cuts = [r, arb(1)/4, arb(1)/2, arb(1), arb(2), arb(3)]
    quad = sum((acb.integral(
        integrand, a, b, abs_tol=arb(2)**-270, rel_tol=arb(2)**-270,
        eval_limit=200000, depth_limit=40)
        for a, b in zip(cuts, cuts[1:])), acb(0))
    assert quad.is_finite()
    error = (2*taylor_constant*log_power_integral(taylor_p, order)
             + theta_integral_tail + infinity_tail)
    # A complex error of modulus <= error is enclosed by this rectangle.
    padding = arb(0, error.upper())
    value = 2*(small + quad) + acb(padding, padding)
    assert value.is_finite()
    print('H derivative', order, 'at exact decimal center:', value, flush=True)
    print('explicit analytic error bound:', error, flush=True)
    return value


def second_derivative_bound():
    """Uniform absolute bound for H'' on the closed radius-R disk."""
    small_bound = arb(0)
    for k in range(0, D + 1, 2):
        q = (2*s0 + k + 1).abs_lower() - 2*R
        assert q > 0
        monomial_bound = 4*r**(2*sigma_lo+k+1)/q * (
            ((-r.log())+1/q)**2 + 1/q**2)
        small_bound += coeff[k].abs_upper() * monomial_bound
    # For all real u>=0, Phi(u) < 40: q_n(u) <= 40 n^4 exp(-3 n^2),
    # and the sum of n^4 exp(-3 n^2) is < 1 by its geometric ratio bound.
    # Thus the COMPLETE [r,3] integral of the absolute second derivative
    # is at most 2 * 3 * U * 25 * 40; no omitted-theta term is needed here.
    middle_bound = 6*U*25*40
    return (2*small_bound + middle_bound
            + 2*taylor_constant*log_power_integral(taylor_p, 2)
            + infinity_tail).upper()


if __name__ == '__main__':
    H0 = mellin_at_center(0)
    H1 = mellin_at_center(1)
    H2 = second_derivative_bound()
    left = H0.abs_upper() + R*R*H2/2
    right = R*H1.abs_lower()
    margin = (s0.imag-R)**2 + s0.real-R - arb(1)/4
    print('disk radius:', R, flush=True)
    print('uniform |H double-prime| bound:', H2, flush=True)
    print('Rouche left:', left, flush=True)
    print('Rouche right:', right, flush=True)
    print('whole-disk parabolic violation margin:', margin, flush=True)
    assert left < right
    assert margin > 0
    print('PROVED: exactly one simple zero of L in this disk; its entire disk '
          'is nonreal and strictly outside the proposed admissible parabola.', flush=True)
