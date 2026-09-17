"""Exact rational algebra for quartic-reciprocal-defect-region.md.

Requires SymPy. No numerical root finding or external input files.
"""
import sympy as sp

L, S, T, x, u, v = sp.symbols("L S T x u v")
M, N = L + S, L + S + T
q, p, w = 1 - 1 / L, 1 - 1 / M, 1 - 1 / N
a = 4 / (q * p * w)
b = 6 / (q**2 * p**2 * w)
c = 4 / (q**3 * p**2 * w)
d = 1 / (q**3 * p**2 * w)
A = sp.factor(b - 3 * a**2 / 8)
B = sp.factor(c - a * b / 2 + a**3 / 8)
C = sp.factor(d - a * c / 4 + a**2 * b / 16 - 3 * a**4 / 256)
assert sp.cancel(A + 6 * L**2 * M**2 * N /
                 ((L - 1)**2 * (M - 1)**2 * (N - 1)**2)) == 0

determinants = {
    3: -8 * A**3 + 32 * A * C - 36 * B**2,
    4: (256 * C**3 - 128 * A**2 * C**2 + 144 * A * B**2 * C
        - 27 * B**4 + 16 * A**4 * C - 4 * A**3 * B**2),
}
factors = {
    3: 192 * L**5 * M**4 * N**2 /
       ((L - 1)**6 * (M - 1)**6 * (N - 1)**4),
    4: 256 * L**9 * M**6 * N**3 /
       ((L - 1)**12 * (M - 1)**10 * (N - 1)**6),
}
lower_bounds = {
    3: {2: 4, 1: 28, 0: 40},
    4: {4: 64, 3: 1312, 2: 7248, 1: 14080, 0: 3200},
}
for order in (3, 4):
    # This also checks that the normalized expression is a polynomial.
    polynomial = sp.Poly(sp.cancel(determinants[order] / factors[order]), L, S, T)
    translated = sp.Poly(sp.expand(polynomial.as_expr().subs(
        {L: 5 + x, S: 1 + 2 * u, T: 1 + 2 * v}, simultaneous=True)), x)
    assert set(power[0] for power, _ in translated.terms()) == set(lower_bounds[order])
    for (power,), expression in translated.terms():
        coefficient = sp.Poly(expression, u, v)
        assert coefficient.degree(u) <= 7 and coefficient.degree(v) <= 7
        bernstein = [
            sum(value * sp.binomial(i, a_) / sp.binomial(7, a_)
                * sp.binomial(j, b_) / sp.binomial(7, b_)
                for (a_, b_), value in coefficient.terms()
                if a_ <= i and b_ <= j)
            for i in range(8) for j in range(8)
        ]
        assert min(bernstein) >= lower_bounds[order][power] > 0
    print(f"P_{order}: all exact bidegree-(7,7) Bernstein bounds proved")
