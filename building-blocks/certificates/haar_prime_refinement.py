"""Exact rational log enclosures for the X=4 Haar test; including the complete translated forcing."""
from fractions import Fraction as F

def log_interval(n, terms=24):
    t = F(n - 1, n + 1)
    lo = 2 * sum((t ** (2*k+1) / (2*k+1) for k in range(terms)), F(0))
    hi = lo + 2 * t ** (2*terms+1) / ((2*terms+1)*(1-t*t))
    return lo, hi

for n, lo, hi in [(2, F(69,100), F(70,100)), (5, F(160,100), F(161,100)), (7, F(194,100), F(195,100))]:
    lower, upper = log_interval(n)
    assert lo < lower < upper < hi

a4_upper = (4-F(160,100)-F(194,100))**2/4
a2_lower = ((F(160,100)-1)**2+(F(194,100)-1)**2)/2
assert a2_lower > a4_upper

# W_4(d), d >= 0, obtained directly from the three polynomial pieces of r.
pieces = [
    (F(0),F(1),[F(0),F(0),F(-3,16),F(7,64)]),
    (F(1),F(2),[F(1,6),F(-1,2),F(5,16),F(-11,192)]),
    (F(2),F(4),[F(-1,3),F(1,4),F(-1,16),F(1,192)]),
]
def wint(end, weighted=False):
    result = F(0)
    for left,right,coeffs in pieces:
        right = min(right,end)
        if right <= left:
            continue
        if weighted:
            coeffs = [4*coeffs[0]]+[4*coeffs[k]-coeffs[k-1] for k in range(1,len(coeffs))]+[-coeffs[-1]]
        result += sum((v*(right**(k+1)-left**(k+1))/(k+1) for k,v in enumerate(coeffs)),F(0))
    return result
assert -2*(wint(F(1))+wint(F(3))) == F(61,192)
assert -2*wint(F(4)) == F(1,4)
assert 2*wint(F(4),weighted=True) == F(-13,20)
forcing_lower = F(61,192)*F(354,100)+F(1,4)*F(69,100)-F(1,12)*F(161,100)*F(195,100)-F(1,96)*F(161,100)*F(70,100)-F(5,32)*F(195,100)*F(70,100)-F(13,20)
assert forcing_lower == F(3853,24000) > 0

print("Exact Haar log enclosures and translated forcing lower bound passed.")
