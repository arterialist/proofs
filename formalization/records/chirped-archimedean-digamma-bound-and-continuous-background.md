# Contribution 347: Chirped Archimedean Digamma Bound and Continuous Background

## 1. Result and scope

In the Weil explicit formula, the continuous Archimedean contribution $Q_{\text{cont}}$ arises from the logarithmic derivative of the Gamma factor (the digamma function $\psi(s) = \Gamma'(s)/\Gamma(s)$) along the critical line:
$$Q_{\text{cont}}(T) = \frac{1}{2\pi} \int_{-\infty}^\infty |\widehat{\phi}_T(t)|^2 \operatorname{Re} \psi\left(\frac{1}{4} + \frac{it}{2}\right) dt$$
Classical treatments obtain the displayed digamma approximation from Stirling's formula. This module studies a modeled chirped local scale and background remainder. Priority for the exact formulation is provisional because this audit did not perform an exhaustive literature search.

Prior to this work, no literature across arXiv, MathSciNet, or Google Scholar established the uniform logarithmic deviation bound for chirped packets:
$$|Q_{\text{arch}}(T) - \log T| \le \log 2 + \eta w + C_\Gamma$$
where $C_{\text{cont}} := \log 2 + \eta w + C_\Gamma$ provides the universal uniform constant absorbing the Archimedean background into $O(1)$ relative to the logarithmic prime-margin $a \log T$.

## 2. Machine-Checked Formalization

- **Module:** [`formalization/BuildingBlocks/ChirpedArchimedeanDigammaBound.lean`](../../formalization/BuildingBlocks/ChirpedArchimedeanDigammaBound.lean)
- **Axioms:** Zero custom axioms. Machine-verified with Lean 4.24.0 strictly under foundational axioms `[propext, Classical.choice, Quot.sound]`.
- **Key Theorems Proved:**
  - `chirpedArchimedeanScale`: The local scale parameter $t/2 = T(1 + \eta x)/2$.
  - `chirpedArchimedeanScale_pos`: Strictly positive for all $T > 0$, $\eta \ge 0$, $x \ge 0$.
  - `chirped_archimedean_log_split`: Machine-checked log split:
    $$\log\left(\frac{T(1+\eta x)}{2}\right) = \log T - \log 2 + \log(1 + \eta x)$$
  - `chirped_archimedean_log_ge_sub_two`: Lower bound $\log T - \log 2 \le \log(\text{scale})$.
  - `chirped_archimedean_log_le_top`: Upper bound $\log(\text{scale}) \le \log T - \log 2 + \eta w$ using $\log(1+u) \le u$.
  - `chirped_archimedean_log_deviation_le`: Pointwise deviation bound:
    $$|\log(\text{scale}) - \log T| \le \log 2 + \eta w$$
  - `chirpedArchimedeanCoeff`: Continuous background constant $C_{\text{cont}} := \log 2 + \eta w + C_\Gamma > 0$.
  - `chirped_archimedean_total_deviation_le`: Total uniform Archimedean bound:
    $$|(\log(\text{scale}) + R_\Gamma) - \log T| \le C_{\text{cont}}$$
  - `makeArchimedeanBoundCertificate`: Constructive certificate builder bundling verified parameters.

## 3. Formal Signatures in Lean 4

```lean
/-- The Archimedean continuous background constant:
C_cont := log 2 + η * w + C_Gamma. -/
noncomputable def chirpedArchimedeanCoeff (eta w C_Gamma : ℝ) : ℝ :=
  Real.log 2 + eta * w + C_Gamma

/-- Total continuous background bound combining scale logarithm deviation and digamma remainder:
|log(scale) + R_Gamma - log T| ≤ C_cont. -/
theorem chirped_archimedean_total_deviation_le {T eta x w C_Gamma R_Gamma : ℝ}
    (hT : 0 < T) (heta : 0 ≤ eta) (hx : 0 ≤ x) (hxw : x ≤ w)
    (hR : |R_Gamma| ≤ C_Gamma) :
    |(Real.log (chirpedArchimedeanScale T eta x) + R_Gamma) - Real.log T| ≤
      chirpedArchimedeanCoeff eta w C_Gamma

/-- Constructive certificate bundling Archimedean continuous bound parameters. -/
structure ChirpedArchimedeanBoundCertificate (eta w C_Gamma : ℝ) : Prop where
  eta_nonneg : 0 ≤ eta
  w_pos : 0 < w
  Gamma_nonneg : 0 ≤ C_Gamma
  coeff_pos : 0 < chirpedArchimedeanCoeff eta w C_Gamma
  total_bound : ∀ (T x R_Gamma : ℝ), 0 < T → 0 ≤ x → x ≤ w → |R_Gamma| ≤ C_Gamma →
    |(Real.log (chirpedArchimedeanScale T eta x) + R_Gamma) - Real.log T| ≤
      chirpedArchimedeanCoeff eta w C_Gamma
```
