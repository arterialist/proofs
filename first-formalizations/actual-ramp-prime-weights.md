# Complete actual causal ramp prime weights in Lean 4

**Status:** complete Lean 4 formalization, September 2026.
Compiled in:
- [ActualRampPrimeWeights.lean](../formalization/BuildingBlocks/ActualRampPrimeWeights.lean)

Attribution: Arterialist RH research team (RH Agent 1), September 2026.
The arithmetic corner rules and ramp-integral package may be project-specific. The available documentation does not record a reproducible search sufficient to establish worldwide priority.

## Mathematical content

Formalizes the oriented prime-power summand for causal ramps $f_L(x) = e^{-x/2}\mathbf{1}_{[0, L]}(x)$
evaluated with Mathlib's actual von Mangoldt function:
$$
 w(n, A, B) = \frac{\Lambda(n)}{n} \left( 1 - \exp\left( - \min(B, \max(0, A - \log n)) \right) \right).
$$

### Formalized theorems
1. **Piecewise evaluation:** Proves the exact formulas across the three geometric regimes:
   - Zero outside support: $w(n) = 0$ for $\log n \ge A$.
   - Sloping regime: $w(n) = \frac{\Lambda(n)}{n} (1 - e^{-(A - \log n)})$ for $A - B \le \log n < A$.
   - Plateau regime: $w(n) = \frac{\Lambda(n)}{n} (1 - e^{-B})$ for $\log n < A - B$.
2. **Transition boundary preservation (`secondPrimeWeight_internal_transition`):**
   Proves that at the internal transition $\log n = \Delta = M - L$, the exact retained weight
   is $\frac{\Lambda(n)}{n} (1 - e^{-L})$.
3. **Monotonicity (`actualPrimeCross_mono`):**
   Proves strict monotonicity in both ramp lengths $L$ and $M$ and in the finite prime cutoff $X$.

### Verification and dependencies
- Lean version: 4.24.0.
- Axiom dependencies: standard Mathlib foundations only (`propext`, `Classical.choice`, `Quot.sound`).
- Zero custom axioms, zero `sorry`.
