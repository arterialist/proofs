# Scalar structure of the literal killed energy domain

[PhysicalThetaJumpHomogeneity.lean](BuildingBlocks/PhysicalThetaJumpHomogeneity.lean) uses the published actual theta edge masses and complete continuous/prime energies. For every real function \(h\), scalar \(c\), and displacement \(a\), it proves
\[
e_{ch}(a)=\operatorname{ofReal}(c^2)e_h(a).
\]
The pointwise squared displacement scales by \(c^2\). Its ENNReal coefficient is finite, so the finite-constant lintegral theorem applies without assuming measurability or finite energy of \(h\). These are extended nonnegative integrals, not real Bochner integrals with a nonintegrable-zero convention.

Passing through the continuous integral and complete prime-power sum gives separately
\[
E_c(ch)=\operatorname{ofReal}(c^2)E_c(h),\qquad
E_p(ch)=\operatorname{ofReal}(c^2)E_p(h),\qquad
E(ch)=\operatorname{ofReal}(c^2)E(h).
\]
All prime powers remain. The underlying positive-displacement convention is justified by the previously compiled reverse-edge identity and does not remove reverse orientations.

Zero extension commutes with scalar multiplication, so the literal killed energy obeys
\[
E_O(ch)=\operatorname{ofReal}(c^2)E_O(h).
\]
The zero full and killed energies are also proved. Every formula remains valid with infinite energy, including \(c=0\), using the standard ENNReal multiplication convention.

On ExteriorGroundSpace, scalar multiplication of canonical Lp representatives is only an almost everywhere identity. The module uses the Lp scalar identity together with the published exterior-measure representative invariance of killed energy. It thus proves exact homogeneity of exteriorHilbertEnergy and its zero value at the zero Hilbert vector.

The defined candidate maximalExteriorDomain is the set where that actual energy is finite. Finiteness of \(c^2\) and the ENNReal product bound now prove that this domain contains zero and is closed under EVERY real scalar multiplication.

This establishes scalar structure, not the full vector-subspace or closed-form theorem. Closure under addition, quadratic polarization, graph-norm completeness, smooth-core density, and equality of maximal and closed domains remain to be proved with the required measurable integral identities. No operator, actual normalized ground, ground equation, arithmetic residual bound, sharp gap, or RH result is assumed or concluded.

The covariance research branch supplied the eleven declarations. Root independently reviewed the finite scalar coefficient in the extended integral theorem, complete prime-power summation, zero-times-infinity case and the Lp representative transfer. These are classical quadratic scaling identities; no novelty claim is made.

All eleven printed declarations independently compile with only propext, Classical.choice and Quot.sound, without warnings in this module.
