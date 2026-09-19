# complex pair-energy algebra and conditional modular assembly

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Module:** [`formalization/BuildingBlocks/ChirpedPairEnergyAlgebra.lean`](../../formalization/BuildingBlocks/ChirpedPairEnergyAlgebra.lean)
**Classification:** machine-checked complex-number inequalities with a conditional spectral interface
**Priority status:** no priority claim; this is a building block

## What Lean proves

For complex `W` and `u`, positive `T`, `norm u = 1`, and a supplied bound `b <= (W * u).re`, the module bounds `chirpedPairEnergy` by `4 * norm W / T + 2 * norm W / T ^ 3 - 2 * b * T`.

For `T >= 1`, it bounds the two positive terms by `6 * norm W`. Negating and adding this constant yields `absorbedPairEnergy_lower`.

`makePairedModularComponents` requires arbitrary functions `Q_crit`, `Q_tail`, `Q_diag`, and `Q_cross`, together with every analytic bound and the exact balance identity. `PairedZeroData` stores the same decisive data. The RH theorem assumes a witness producing it for every candidate high-frequency zero.

## Boundary of the result

Lean proves complex algebra once the projection inequality is supplied. It does not prove that an actual off-critical zero yields these quantities or the modular balance identity. The conditional refutation is not an autonomous zero exclusion. No exhaustive priority search is documented.

No custom axioms or `sorry` placeholders are used.
