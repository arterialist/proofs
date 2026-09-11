"""Certify failure of the Laguerre inequality for actual F at argument -7.

Install python-flint==0.9.0, then run this file with Python 3.
See ../theta-mellin-bernstein-obstruction.md for the proof and error bounds.
Arb encloses all arithmetic and finite-interval quadrature. Explicit bounds
below include the omitted theta series and the Taylor and integration tails.
No statement about zeros of Xi itself follows from this test.
"""
from flint import arb, acb, ctx

ctx.prec = 300
degree = 160
r = arb(1)/8
pi = arb.pi()
factorials = [arb(1)]
for k in range(1, degree+1):
    factorials.append(factorials[-1]*k)
coeff = [arb(0) for _ in range(degree+1)]
for n in range(1, 25):
    p = pi*n*n
    exponent = [-p*arb(2)**j/factorials[j] for j in range(degree+1)]
    exponential = [(-p).exp()]
    for j in range(1, degree+1):
        exponential.append(sum((k*exponent[k]*exponential[j-k]
                               for k in range(1, j+1)), arb(0))/j)
    for j in range(0, degree+1, 2):
        coeff[j] += sum((exponential[j-k]*(
            4*p*p*(arb(9)/2)**k-6*p*(arb(5)/2)**k
        )/factorials[k] for k in range(j+1)), arb(0))

# On |u|<=1/2 the complete theta kernel has modulus <10000.
# Its n>=25 tail has modulus <=952*25^4 exp(-25^2/2).
# Cauchy bounds the coefficient errors by tail_disk*2^j.
tail_disk = 952*arb(25)**4*(-arb(625)/2).exp()
# Integral on [r,3] of the n>=9 tail, including moment derivatives <=2.
tail_integral = 6*r**(-16)*25*160*arb(9)**4*(-arb(243)).exp()
# For u>=3, u^-16*(2|log u|)^j<=1 for j=0,1,2.
T = arb(6).exp()
tail_infinity = 16*pi*T**(arb(5)/4)*(-pi*T).exp()


def integral_power(p, order):
    """Integral_0^r u^(p-1) (2|log u|)^order du, p>0."""
    L = -r.log()
    a = r**p/p
    if order == 1:
        a *= 2*(L+1/p)
    elif order == 2:
        a *= 4*((L+1/p)**2+1/p**2)
    return a


def mellin_derivative(order):
    # M(2s) and its s derivatives, analytically continued to s=-8.
    values = []
    coefficient_error = arb(0)
    for k in range(0, degree+1, 2):
        p = arb(k-15)
        a = r**p/p
        if order == 1:
            a *= 2*(r.log()-1/p)
        elif order == 2:
            a *= 4*((r.log()-1/p)**2+1/p**2)
        values.append(coeff[k]*a)
        coefficient_error += tail_disk*arb(2)**k*abs(a)
    # Even Taylor remainder: 10000*(4u^2)^81/(1-4u^2).
    taylor_error = (arb(16)/15)*10000*arb(4)**81*integral_power(arb(147), order)

    def integrand(u, analytic):
        log_factor = (2*u.log(analytic=analytic))**order
        p = pi*(2*u).exp()
        phi = (u/2).exp()*sum((
            (4*(n*n*p)**2-6*n*n*p)*(-n*n*p).exp()
            for n in range(1, 9)), acb(0))
        return u**(-16)*log_factor*phi

    cuts = [r, arb(1)/4, arb(1)/2, arb(1), arb(2), arb(3)]
    quad = sum((acb.integral(integrand, a, b,
                            abs_tol=arb(2)**(-210), rel_tol=arb(2)**(-210),
                            eval_limit=200000, depth_limit=40)
                for a, b in zip(cuts, cuts[1:])), acb(0))
    assert quad.imag.contains(0)
    assert quad.is_finite()
    error = 2*(coefficient_error+taylor_error)+tail_integral+tail_infinity
    result = 2*(sum(values, arb(0))+quad.real)+arb(0, error.upper())
    print('derivative', order, 'M(2s) at s=-8:', result, flush=True)
    print('explicit tail radius:', error, flush=True)
    return result


m0, m1, m2 = [mellin_derivative(j) for j in range(3)]
# Coarse bounds used in the rational proof in the companion note.
assert arb(-7281) < m0 and m0 < arb(-7280)
assert arb(4902) < m1 and m1 < arb(4903)
assert arb(-74929) < m2 and m2 < arb(-74928)
assert not m0.contains(0)
from fractions import Fraction
rational_lower = (Fraction(74928, 7281) - Fraction(4903, 7280)**2
                  - Fraction(22, 7)**2 / 2
                  - 4*sum((Fraction(1, (2*j-1)**2) for j in range(1, 9)), Fraction(0)))
assert rational_lower == Fraction(37218077686879, 420224790585600)
assert rational_lower > Fraction(177, 2000)
# Trigamma(-15/2)=pi^2/2+4 sum_{j=1}^8(2j-1)^-2.
trigamma = pi*pi/2+4*sum((1/arb(2*j-1)**2 for j in range(1, 9)), arb(0))
curvature = m2/m0-(m1/m0)**2-trigamma
print('D^2 log|F| at F argument -7:', curvature, flush=True)
assert curvature > arb('0.09327')
assert curvature < arb('0.09328')
print('CERTIFIED: F fails (F-prime)^2-F*F-double-prime >= 0 at -7.', flush=True)
