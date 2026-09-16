"""Certify a negative phase of the actual centered renewal multiplier.

Run: uv run --with python-flint python renewal_critical_phase_interval.py
Python-flint's Arb/Acb arithmetic encloses zeta and all subsequent
operations. The target is the exact rational point 1/2 + 12i.
"""

from flint import acb, arb, ctx


ctx.prec = 192
s = acb(arb(1) / 2, 12)
zeta_value = s.zeta()
multiplier = zeta_value.imag / 12 + arb(1) / (arb(12) ** 2 + arb(1) / 4)

assert multiplier > -arb(56) / 1000
assert multiplier < -arb(54) / 1000
print("-0.056 < m(12) < -0.054", multiplier)
