"""Exact normalization fixtures for the even-character family identity."""
import sympy as s
z=s.symbols('z');records=[]
for q in [5,7,11,13,17,19,23]:
    g=s.primitive_root(q);m=(q-1)//2;phi=s.Poly(s.cyclotomic_poly(m,z),z)
    for j in range(q-1):
        a=pow(g,j,q)
        coeff=sum(z**((k*j)%m) for k in range(1,m))
        expected=m*int(a in [1,q-1])-1
        assert s.rem(s.Poly(coeff-expected,z),phi).is_zero
    records.append({'prime':q,'generator':int(g),'even_nonprincipal_characters':m-1,
                    'residue_coefficients_checked':q-1})
h,t=s.symbols('h t',positive=True)
assert s.integrate(2*(h-t),(t,0,h))==h*h

"""Independent exact normalization checks; no L-function value calculations."""
import sympy as sp

z, a, h, t = sp.symbols('z a h t')
rows = []
for q in (3, 5, 7, 11):
    generator = int(sp.primitive_root(q))
    order = q - 1
    phi = sp.Poly(sp.cyclotomic_poly(order, z), z)
    even = [k for k in range(order) if k % 2 == 0]
    assert len(even) == order // 2
    assert len(even[1:]) == (q - 3) // 2
    # Use all characters as order-(q-1) roots, independently of the preceding
    # smaller root order for the even subgroup.
    for exponent in range(order):
        residue = pow(generator, exponent, q)
        projected = sum(z ** ((k * exponent) % order) for k in even[1:])
        target = order // 2 * int(residue in (1, q - 1)) - 1
        assert sp.rem(sp.Poly(projected - target, z), phi).is_zero
    rows.append({'q': q, 'even_nonprincipal_count': len(even) - 1})

# Check the full paired Taylor formula for a polynomial with symbolic coefficients.
coeffs = sp.symbols('c0:7')
f = sum(c * a ** k for k, c in enumerate(coeffs))
second = sp.diff(f, a, 2)
paired = f.subs(a, 1 + h) + f.subs(a, 1 - h) - 2 * f.subs(a, 1)
integrated = sp.integrate((h - t) * (second.subs(a, 1 + t) + second.subs(a, 1 - t)), (t, 0, h))
assert sp.expand(paired - integrated) == 0
assert sp.integrate(2 * (h - t), (t, 0, h)) == h ** 2

# Actual even nonprincipal character modulo 5, retaining the ramified prime.
def chi5(n):
    return {0: 0, 1: 1, 2: -1, 3: -1, 4: 1}[n % 5]

twisted = {}
for n in range(1, 33):
    twisted[n] = sum(int(sp.mobius(d)) * chi5(n // d) for d in sp.divisors(n))
    assert sum(twisted[d] for d in sp.divisors(n)) == chi5(n)
assert twisted[1] == 1 and twisted[5] == -1 and twisted[25] == 0


print('Exact character projectors, paired Taylor identity and full conductor-prime convolution checks passed.')
