# Carrier and core-radius algebra for adjustable chirp rate

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Classification:** machine-checked real algebra

**Lean module:** [`ChirpedUniversalCarrierTuning.lean`](../../formalization/BuildingBlocks/ChirpedUniversalCarrierTuning.lean)

For positive $\gamma$ and target $T_*$, the module chooses a parameter $\eta\in(0,1)$ and defines $T=\gamma/(1-\eta)$. It proves $T>T_*$, a stated phase derivative vanishes at the chosen point, and a modeled core radius lies inside the unit interval. Combined with an existing power-dominance lemma, `universal_offline_carrier_exists` produces a carrier at which $A\log T+C<2bT^{2d}$.

These are valid real-variable facts. They do not show that changing $\eta$ preserves an actual Weil test family, its arithmetic estimates, its spectral decomposition, or constants uniform in $\eta$. The module contains no zeta zero and no explicit-formula evaluation. It therefore removes a scalar size restriction inside a conditional model, not a computational zero-height cutoff in an RH proof.

The lemma may be useful if the analytic bounds can later be proved uniformly over the adjustable chirp rate.
