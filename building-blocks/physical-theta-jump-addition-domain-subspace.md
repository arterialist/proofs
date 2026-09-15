# The literal finite-energy exterior domain is a real subspace

PhysicalThetaJumpAddition.lean uses the published actual continuous, complete prime-power and killed ENNReal energies. It proves measurability and addition bounds needed for the finite-energy domain.

For a Borel real representative \(h\), the joint edge integrand
\[
(a,u)\longmapsto\operatorname{ofReal}
 \{\Phi(u+a)\Phi(u)[h(u+a)-h(u)]^2\}
\]
is measurable. The parameter-lintegral theorem therefore proves that \(a\mapsto e_h(a)\) is measurable.

The elementary real inequality \((x+y)^2\le2(x^2+y^2)\), multiplied by the positive actual theta edge weight, gives
\[
f_{h+g}(a,u)\le2[f_h(a,u)+f_g(a,u)].
\]
Monotonicity and the measured-one-summand lintegral addition theorem give
\[
e_{h+g}(a)\le2[e_h(a)+e_g(a)].
\]
Only the Borel measurability of \(h\) is required here; the second representative \(g\) may be arbitrary. The continuous outer integral uses measurability of its \(h\) term, and the complete prime sum uses ENNReal sum addition and distributivity. Consequently
\[
E_c(h+g)\le2[E_c(h)+E_c(g)],\quad
E_p(h+g)\le2[E_p(h)+E_p(g)],\quad
E(h+g)\le2[E(h)+E(g)].
\]
These are extended-energy statements and preserve infinite values. Every prime power is retained, and the positive-displacement convention remains the exact symmetric convention established by reverse-edge equality.

Zero extension commutes with addition and preserves Borel measurability, so the same addition bound holds for the actual killed energy. Its full-line edge definition retains both core-crossing departure costs.

For actual exterior Hilbert vectors, chosen Lp representatives need not be Borel pointwise or respect addition pointwise. The first vector has an almost everywhere strongly measurable representative in the exterior measure; its globally strongly measurable mk representative is Borel. The module combines its almost everywhere equality with the Lp addition identity and the published killed-energy representative dictionary. Thus, without assuming Borel regularity of the original vectors,
\[
E_O^{\rm Hilbert}(h+g)\le
2[E_O^{\rm Hilbert}(h)+E_O^{\rm Hilbert}(g)].
\]
If both energies are finite, the right side is finite. Together with the already published zero and scalar closure, this constructs exteriorFormDomain as an actual real Submodule of ExteriorGroundSpace, with carrier exactly maximalExteriorDomain.

This proves algebraic subspace structure, not topological closedness or completeness in the form graph norm. Quadratic polarization, graph-norm completeness, smooth-core density and maximal-domain identification remain further obligations before a represented selfadjoint killed operator and its ground can be constructed. No ground, operator equation, sharp-gap premise, arithmetic residual sign, or RH claim is introduced.

Attribution: RH Agent2 supplied the proof and Lean formalization. RH Proof independently reviewed the representative transfer, extended integrals and complete prime sum, and compiled the published module against the pinned Lean 4.24.0/mathlib workspace. The inequalities are standard quadratic estimates; this batch formalizes their application to the literal theta energy.
