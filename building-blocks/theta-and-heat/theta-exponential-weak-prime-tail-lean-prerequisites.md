# Actual prime-tail prerequisites for the exponential weak ground row

The complete prime pairing in `theta-ground-exponential-weak-cross-row.md` uses \(G=\Phi\psi1_O\), an exponential test \(|z(v)|\le C_z e^{-\beta|v|}\), and \(\beta>1/2\). Its exact shift estimate is
\[
e^{-\beta|v\pm\log n|}\le n^{-\beta}e^{\beta|v|},\qquad n\ge2.
\tag{1}
\]
Both signs follow from \(\log n\le |v|+|v\pm\log n|\). Thus, with the actual finite ground moment
\(M_\beta=\int e^{\beta|v|}G(v)\,dv\), each overlap is bounded by \(C_zM_\beta/n^\beta\). Summing the two orientations gives
\[
\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
\int G(v)(|z(v+\log n)|+|z(v-\log n)|)\,dv
\le2C_zM_\beta\sum_{n\ge2}\frac{\Lambda(n)}{n^{\beta+1/2}}<\infty.
\tag{2}
\]
No prime-power term is removed.

[WeakGroundPrimeTail.lean](../../formalization/BuildingBlocks/WeakGroundPrimeTail.lean) formalizes both pointwise inequalities in (1), summability of the actual real Mangoldt majorant in (2), and absolute summability of the literal \(\Lambda(n)/\sqrt n\)-weighted complex overlap series under its decay bound. It proves logarithmic Dirichlet summability from mathlib's `logMul` convergence theorem and uses the actual inequalities \(0\le\Lambda(n)\le\log n\). This requires only \(\beta>1/2\), not PNT or an RH-strength error estimate.

The file now also proves the Bochner integral step. For any measure on the real line, a nonnegative \(G\), an exponentially bounded complex \(z\), measurable overlap integrands, and an integrable exponential moment, `exponential_overlap_integrable_bound` proves each overlap integrable and bounds both its integral of absolute value and the absolute value of its integral. Its majorant is exactly
\[
\frac{C_z}{n^\beta}e^{\beta|v|}G(v).
\]
`summable_absolute_ground_prime_integrals` then proves summability of the weighted integrals of absolute value for either shift orientation. `summable_complete_ground_prime_integrals` joins both orientations with the literal coefficient \(\Lambda(n)/\sqrt n\), indexed by every integer \(n\ge2\). Thus the overlap decay and complete positive prime domination are formalized from the stated moment and measurability hypotheses, rather than being assumed as a separate sequence bound.

For the actual killed ground, its finite exponential moments and the measurability of the specified \(G,z\) overlap integrands remain written identification prerequisites. [WeakGroundPrimeCutoff.lean](../../formalization/BuildingBlocks/WeakGroundPrimeCutoff.lean), mapped in [the prime-cutoff source note](theta-exponential-weak-prime-cutoff-limit.md), now formalizes the hard-cutoff limit through the complete prime row from these hypotheses. Hard-cutoff convergence in the logarithmic Fourier form, the archimedean form limit, core arrival identification, and the weak ground equation remain written. This file does not assert the full analytic mixed-row identity or a covariance estimate. The final eleven printed lemmas are checked with only `propext`, `Classical.choice`, and `Quot.sound`.

Agent2 supplied these proofs and the source map. RH Proof independently reviewed the module against the actual weak ground row and compiled the central copy. The exponential moment and measurability premises remain explicit.
