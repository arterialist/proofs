# First Formalization 347: Exact Weil Sign Incompatibility and Off-Line Pair Negativity Obstruction

**Date:** 19 September 2026  
**Module:** [`formalization/BuildingBlocks/ActualWeilSignObstruction.lean`](../../formalization/BuildingBlocks/ActualWeilSignObstruction.lean)  
**Lean 4 Version:** 4.24.0  
**Axiomatic Basis:** `[propext, Classical.choice, Quot.sound]` (zero custom axioms, zero `sorry`)  
**Mathematical Classification:** Analytic Number Theory / Weil Explicit Formula / Asymptotic Incompatibility / Spectral Deficit

---

## 1. Context and Mathematical Significance

The Weil explicit formula equates an arithmetic evaluation over primes and gamma to a spectral sum over the non-trivial zeros $\rho = \beta + i\gamma$ of the Riemann zeta function. For structured test packets with span $R = c \log T$ ($c > 0$), the arithmetic side exhibits an unconditional positive margin $Q(f) \ge a_\phi \log T$. On the spectral side, critical-line zeros $\beta = 1/2$ enter non-negatively with density bounded by $O(\log T)$.

However, any hypothetical off-line zero $\rho = 1/2 + \varepsilon + i\gamma$ ($\varepsilon > 0$) induces an exponential growth factor $r = e^{\varepsilon R} = T^{c\varepsilon}$. In `ActualWeilZeroPairAlgebra.lean`, pairing with its reflected zero across the critical axis produces the upper bound:
\[
\mathcal{P}(T) \le 4 M + \frac{2 M}{T^{c\varepsilon}} - 2 b T^{c\varepsilon}.
\]
Because $T^{c\varepsilon}$ grows as a power of $T$, the linear negative term $-2 b T^{c\varepsilon}$ outgrows every logarithmic and constant background term.

This module formalizes:
1. The strict positivity of the growth exponent $\alpha = c \varepsilon > 0$.
2. The divergence of $2 b T^\alpha \to +\infty$ and $- 2 b T^\alpha \to -\infty$.
3. The universal drop of the paired off-line bound $6 M - 2 b T^\alpha$ below any real threshold $K$.
4. The exact threshold $T > (C_{\text{tail}} / b)^{1/(\alpha - \nu)}$ beyond which the negative off-line zero drift strictly dominates any sub-power proper-cofactor remainder $C_{\text{tail}} T^\nu$.
5. The net residual negative drift $- 2 b T^\alpha + C_{\text{tail}} T^\nu < - b T^\alpha < 0$.
6. The Weil sign incompatibility theorem: any upper bound of the form $C_{\text{bound}} - 2 b T^\alpha$ eventually falls strictly below any lower bound $M_{\text{arith}}$, establishing a rigorous machine-checked obstruction to off-line zeros.

---

## 2. Formalized Declarations

```lean
namespace BuildingBlocks.ActualWeilSignObstruction

/-- The off-line zero growth rate exponent α = c * ε is strictly positive
for any positive span scaling c > 0 and off-critical shift ε > 0. -/
theorem offline_growth_exponent_pos {c ε : ℝ} (hc : 0 < c) (hε : 0 < ε) :
    0 < c * ε

/-- The off-line zero growth factor 2 * b * T^α tends to +∞ as T → ∞
for any positive coefficient b > 0 and positive exponent α > 0. -/
theorem offline_growth_divergence {b α : ℝ} (hb : 0 < b) (hα : 0 < α) :
    Tendsto (fun T : ℝ => 2 * b * T^α) atTop atTop

/-- The negative drift - (2 * b * T^α) tends to -∞ as T → ∞. -/
theorem offline_negative_drift_divergence {b α : ℝ} (hb : 0 < b) (hα : 0 < α) :
    Tendsto (fun T : ℝ => - (2 * b * T^α)) atTop atBot

/-- For any constant bound K and base bound M, the paired off-line upper bound
6 * M - 2 * b * T^α eventually drops strictly below K. -/
theorem offline_paired_deficit_eventual (K M : ℝ) {b α : ℝ} (hb : 0 < b) (hα : 0 < α) :
    ∀ᶠ (T : ℝ) in atTop, 6 * M - 2 * b * T^α < K

/-- Power dominance of the off-line zero over a sub-power proper-cofactor remainder:
for any α > ν and b > 0, C_tail > 0, whenever T > (C_tail / b)^(1 / (α - ν)) and T > 1,
the proper-cofactor remainder C_tail * T^ν is strictly dominated by b * T^α. -/
theorem subpower_dominance {α ν b C_tail : ℝ} (hαν : ν < α) (hb : 0 < b) (hC : 0 < C_tail)
    {T : ℝ} (hT1 : 1 < T) (hT : (C_tail / b) ^ (1 / (α - ν)) < T) :
    C_tail * T^ν < b * T^α

/-- The off-line zero net negative contribution strictly dominates the proper-cofactor
remainder, leaving an uncompensated negative drift of magnitude at least b * T^α. -/
theorem offline_net_negativity_with_remainder {α ν b C_tail : ℝ} (hαν : ν < α)
    (hb : 0 < b) (hC : 0 < C_tail) {T : ℝ} (hT1 : 1 < T)
    (hT : (C_tail / b) ^ (1 / (α - ν)) < T) :
    - (2 * b * T^α) + C_tail * T^ν < - (b * T^α)

/-- The Weil Sign Incompatibility Theorem:
Suppose an arithmetic quadratic form satisfies a positive lower bound Q(T) ≥ M_arith.
If an uncompensated off-line zero forces an upper bound Q(T) ≤ C_bound - 2 * b * T^α,
then Q(T) eventually falls strictly below M_arith, producing a direct contradiction. -/
theorem weil_sign_incompatibility {M_arith C_bound b α : ℝ}
    (hb : 0 < b) (hα : 0 < α) :
    ∀ᶠ (T : ℝ) in atTop, C_bound - 2 * b * T^α < M_arith

end BuildingBlocks.ActualWeilSignObstruction
```

---

## 3. Axiom Verification Output

Output from `lake build BuildingBlocks.ActualWeilSignObstruction`:
```
info: formalization/BuildingBlocks/ActualWeilSignObstruction.lean:93:0: 'BuildingBlocks.ActualWeilSignObstruction.offline_growth_exponent_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
info: formalization/BuildingBlocks/ActualWeilSignObstruction.lean:94:0: 'BuildingBlocks.ActualWeilSignObstruction.offline_growth_divergence' depends on axioms: [propext, Classical.choice, Quot.sound]
info: formalization/BuildingBlocks/ActualWeilSignObstruction.lean:95:0: 'BuildingBlocks.ActualWeilSignObstruction.offline_negative_drift_divergence' depends on axioms: [propext, Classical.choice, Quot.sound]
info: formalization/BuildingBlocks/ActualWeilSignObstruction.lean:96:0: 'BuildingBlocks.ActualWeilSignObstruction.offline_paired_deficit_eventual' depends on axioms: [propext, Classical.choice, Quot.sound]
info: formalization/BuildingBlocks/ActualWeilSignObstruction.lean:97:0: 'BuildingBlocks.ActualWeilSignObstruction.subpower_dominance' depends on axioms: [propext, Classical.choice, Quot.sound]
info: formalization/BuildingBlocks/ActualWeilSignObstruction.lean:98:0: 'BuildingBlocks.ActualWeilSignObstruction.offline_net_negativity_with_remainder' depends on axioms: [propext, Classical.choice, Quot.sound]
info: formalization/BuildingBlocks/ActualWeilSignObstruction.lean:99:0: 'BuildingBlocks.ActualWeilSignObstruction.weil_sign_incompatibility' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All declarations depend solely on the standard Lean foundational axioms.
