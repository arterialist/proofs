"""Exact rational enclosure of the shared-ordinate proportion.

Put theta=1/sqrt(2), C=cos(theta), S=sin(theta)/theta. Then
kappa=3/2-C/S and q=(3*kappa-1)/2. Alternating Taylor sums
bound C and S using theta^2=1/2. Certified comparisons use
fractions only; decimals are display values.
"""

from decimal import Decimal, localcontext
from fractions import Fraction
import json
from math import factorial


def partial(last: int, shift: int) -> Fraction:
    return sum(
        (Fraction((-1) ** k, 2 ** k * factorial(2 * k + shift))
         for k in range(last + 1)),
        Fraction(0),
    )


def decimal(value: Fraction) -> str:
    with localcontext() as context:
        context.prec = 60
        return str(Decimal(value.numerator) / Decimal(value.denominator))


c_lo, c_hi = partial(21, 0), partial(20, 0)
s_lo, s_hi = partial(21, 1), partial(20, 1)
if not 0 < c_lo < c_hi or not 0 < s_lo < s_hi:
    raise RuntimeError("The positive Taylor enclosures failed")
k_lo = Fraction(3, 2) - c_hi / s_lo
k_hi = Fraction(3, 2) - c_lo / s_hi
q_lo, q_hi = (3 * k_lo - 1) / 2, (3 * k_hi - 1) / 2
if not Fraction(508751, 10**6) < q_lo < q_hi < Fraction(508752, 10**6):
    raise RuntimeError("The shared-ordinate decimal enclosure failed")
if not Fraction(672500703679411, 10**15) < k_lo < k_hi < Fraction(672500703679412, 10**15):
    raise RuntimeError("The simple-critical decimal enclosure failed")
print(json.dumps({
    "method": "alternating rational Taylor bounds at theta squared=1/2",
    "kappa_lower_exact": str(k_lo),
    "kappa_upper_exact": str(k_hi),
    "shared_lower_exact": str(q_lo),
    "shared_upper_exact": str(q_hi),
    "shared_lower_display": decimal(q_lo),
    "shared_upper_display": decimal(q_hi),
    "strictly_above_one_half": q_lo > Fraction(1, 2),
    "strictly_above_0_508751": q_lo > Fraction(508751, 10**6),
    "rounded_0_672500703679412_exceeds_kappa":
        k_hi < Fraction(672500703679412, 10**15),
}, indent=2))
