# Literal theta jump energy: almost everywhere invariance and absolute contraction

[PhysicalThetaJumpEnergy.lean](../../formalization/BuildingBlocks/PhysicalThetaJumpEnergy.lean) defines the extended nonnegative edge mass
\[
e_h(a)=\int_{\mathbb R}\operatorname{ofReal}\!
 \left(\Phi(u+a)\Phi(u)[h(u+a)-h(u)]^2\right)\,du
\]
and the literal energies
\[
E_c(h)=\int_{a>0}\operatorname{ofReal}(r(a))e_h(a)\,da,\qquad
E_p(h)=\sum_{n\ge2}\operatorname{ofReal}
 \left(\frac{\Lambda(n)}{\sqrt n}\right)e_h(\log n),
\quad E(h)=E_c(h)+E_p(h).
\]
These are ENNReal lintegrals and sums, so infinite energy is retained rather than assigned a zero real integral. The definitions use the actual theta series and continuous kernel, and the complete Mangoldt family.

The published written energy convention counts each undirected edge once by integrating positive displacements. Translation of Lebesgue measure and the squared-difference identity prove \(e_h(-a)=e_h(a)\) for every \(a\) and every real function \(h\), including infinite edge mass. Thus reverse orientations are retained by this exact symmetry, not discarded by a bound or by selecting favorable primes. Every prime power remains in the sum.

If \(h=g\) almost everywhere in Lebesgue measure, the same equality holds after translation by every fixed displacement. Intersecting the two null-set complements therefore gives \(e_h(a)=e_g(a)\) for every \(a\). Substitution into the outer integral and countable sum gives equality of each energy and their sum. This requires neither a convergence nor a finite-energy premise.

For the actual exterior \(O=\{|u|>R\}\), define
\[
h_O(u)=1_O(u)h(u),\qquad E_O(h)=E(h_O).
\]
The module proves that exterior almost everywhere equality suffices for full almost everywhere equality of the zero extensions, hence for equal killed energies. The energy is taken on the whole line after extension. In particular cross-boundary jump differences remain, retaining the complete killing departure cost. It is not an internal-only exterior edge energy.

The inequality
\[
\big||x|-|y|\big|\le|x-y|
\]
and positivity of the literal theta weights give \(e_{|h|}(a)\le e_h(a)\). Monotonicity of ENNReal integration and summation gives separately
\[
E_c(|h|)\le E_c(h),\qquad E_p(|h|)\le E_p(h),\qquad E(|h|)\le E(h).
\]
Since taking absolute values commutes with zero extension, the same contraction holds for the killed energy. This is the classical absolute-value contraction realized for the complete actual theta energy, not an arithmetic sign estimate.

These definitions and identities establish the representative-invariance and positive-ground minimization prerequisites. The separate literal theta measure module transfers the almost everywhere equivalence to the Hilbert measure. This module does not prove finite energy of a smooth core, closability, completeness of the maximal graph norm, density of the smooth core, or equality of that maximal domain with the closed form. No selfadjoint operator or ground eigenfunction has yet been constructed in Lean. Those construction steps, ground boundedness and the complete weak equation remain separate obligations; both pole terms remain in the eventual physical Weil relation. No sharp-gap, covariance-residual, or RH claim follows.

The module also exports representative invariance directly for \(\nu\) and its exterior restriction, and defines hilbertEnergy and exteriorHilbertEnergy on the literal full/exterior Lp spaces. maximalExteriorDomain is precisely the set where the latter ENNReal energy is finite. This defines the candidate maximal domain, not its closedness, linear-subspace structure, graph-norm completeness, smooth-core density, or equality to the published written closed form. No such property is inferred from the definition.

The covariance research branch supplied these fourteen declarations. Root independently reviewed the positive-displacement convention, translation of null sets, exterior restriction, positivity used for contraction and the distinction between an extended finite-energy set and a closed form domain. These are classical jump-energy constructions; no novelty claim is made.

Root also formalizes the exact pointwise three-sector split of the killed square: internal/exterior-exterior differences, exterior-to-core departure h(u)^2, and core-to-exterior departure h(u+a)^2. When both endpoints are in the core the square is zero. The strict exterior convention assigns boundary points to the killed core in this split. Multiplication by the literal positive theta edge weight preserves the identity. This explicitly exposes both crossing costs before any integration; deleting them changes the killed energy. The split does not assert a spectral lower bound.

All fifteen declarations independently compile with only propext, Classical.choice and Quot.sound, without warnings in this module.
