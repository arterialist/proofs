"""Exact rational certificate for the divisor Gram obstruction at x=27."""
from fractions import Fraction as F
from math import isqrt

c = {2:-180, 3:-221, 4:-24, 5:-172, 6:254, 7:-121,
     8:110, 9:157, 10:300, 11:-40, 12:146, 14:301,
     15:393, 16:94, 18:-10, 20:76, 21:342, 22:220,
     24:-85, 25:10}
lower = upper = F(0)
scale = 10**12
for n in range(1, 27):
    f = sum(v for d,v in c.items() if n % d == 0)
    g = sum(v*w for d,v in c.items() for e,w in c.items()
            if n % (d*e) == 0)
    coefficient = (27-n)*(f*f-g)
    root_lower = F(isqrt(n*scale*scale), scale)
    root_upper = (root_lower if root_lower**2 == n
                  else root_lower + F(1, scale))
    assert root_lower**2 <= n <= root_upper**2
    if coefficient >= 0:
        lower += coefficient/root_upper
        upper += coefficient/root_lower
    else:
        lower += coefficient/root_lower
        upper += coefficient/root_upper
assert lower > F(-128697, 200)       # -643.485
assert upper < F(-6434849, 10000)    # -643.4849

print("Composite Gram obstruction certified: -643.485 < value < -643.4849 < 0")
