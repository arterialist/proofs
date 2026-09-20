# Contribution 140: Exact Critical Tail Radon Measure and Measurable Cutoff Algebra

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCriticalMeasure.lean`](../../formalization/BuildingBlocks/ActualCriticalMeasure.lean), [`building-blocks/measure/actual-critical-measure.md`](../../building-blocks/measure/actual-critical-measure.md)  
**Classification:** Measure Theory / Analytic Number Theory / Measurable Floor Sums / Critical Tail Measures / Laplace Convergence Sets

---

## 1. Executive Summary and Mathematical Statement

In the rigorous foundation of Laplace-Mellin spectral methods, proving that arithmetic sums with floor cutoffs $x \mapsto \sum_{n < \lfloor x \rfloor} F(n, x)$ define Borel-measurable functions and induce bona fide Radon measures is a prerequisite for applying Bochner integration, Fubini's theorem, and Landau's singularity theorem.

This contribution proves:

1. **Borel Measurability of Arithmetic Floor-Cutoff Sums:**  
   If $F: \mathbb{N} \times \mathbb{R} \to \mathbb{C}$ is measurable in $x$ for each $n$, then the floor-truncated sum:
   $$
   x \mapsto \sum_{n < \lfloor x \rfloor} F(n, x)
   $$
   is Borel measurable on $\mathbb{R}$. Consequently, $V(x)$, $W(x)$, and the negative tail $-W_{\text{tail}, A}(x)$ are Borel measurable.
2. **Construction of the Critical Tail Radon Measure:**  
   The critical tail measure $\mu_A$ on $\mathbb{R}_{>1}$ is defined with density $\rho_A(x) = \operatorname{ofReal}(x^{-2} \operatorname{Re}(-W_{\text{tail}, A}(x)))$.
   Under the eventual sign condition $\operatorname{Re}(W(x)) \le 0$ on $(A, \infty)$, $\mu_A$ is a non-negative measure.
3. **Exact Mass-to-Mellin-Norm Identity:**  
   For any real $\sigma \in \mathbb{R}$, the Laplace mass with observable $t(x) = \max(\log x, 0)$ satisfies:
   $$
   \int_1^\infty e^{-\sigma t(x)} d\mu_A(x) = \int_1^\infty \| x^{-\sigma - 2} (-W_{\text{tail}, A}(x)) \| dx.
   $$
4. **Non-Emptiness of the Convergence Set:**  
   For any cutoff $A \ge 1$ under the sign condition, the convergence set of the tail Laplace measure is non-empty, containing the entire ray $(1, \infty)$ and witnessed at $\sigma = 2$.

---

## 2. Mathematical Proof

### 2.1. Measurability of Floor Sums
Consider the map $H: \mathbb{R} \times \mathbb{N} \to \mathbb{C}$ given by $H(x, N) = \sum_{n=0}^{N-1} F(n, x)$.
For fixed $N$, $x \mapsto H(x, N)$ is a finite sum of measurable functions, hence measurable.
Since $\mathbb{N}$ is countable, $H(x, N)$ is product measurable.
The floor function $x \mapsto \lfloor x \rfloor$ is measurable because the preimage of any integer singleton $\{k\}$ is the half-open interval $[k, k+1)$, which is Borel.
Composing $H$ with the measurable map $x \mapsto (x, \lfloor x \rfloor)$ proves that $x \mapsto \sum_{n < \lfloor x \rfloor} F(n, x)$ is Borel measurable.

### 2.2. Mass Identity
The density is $\rho_A(x) = x^{-2} \operatorname{Re}(-W_{\text{tail}, A}(x))$.
Using the exponential identity $x^{-2} e^{-\sigma \log x} = x^{-\sigma - 2}$ and the fact that $-W_{\text{tail}, A}(x)$ is non-negative and real:
$$
\rho_A(x) e^{-\sigma \log x} = x^{-\sigma - 2} (-W_{\text{tail}, A}(x)) = \| x^{-\sigma - 2} (-W_{\text{tail}, A}(x)) \|.
$$
Integrating over $(1, \infty)$ yields the mass identity.

### 2.3. Convergence at $\sigma = 2$
Since $\mathcal{M}(-W_{\text{tail}, A})(-s-1)$ converges absolutely for $\operatorname{Re}(s) > 1$, setting $s = 2$ gives a finite $L^1$ norm, so $\sigma = 2$ belongs to the convergence set.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCriticalMeasure`):
```lean
theorem measurable_cutoff (F : ℕ → ℝ → ℂ) (hF : ∀ n, Measurable (F n)) :
    Measurable (fun x : ℝ => ∑ n ∈ Finset.range ⌊x⌋₊, F n x)

theorem measurable_W : Measurable ActualCriticalMellin.W

theorem measurable_tailDensity (A : ℝ) : Measurable (tailDensity A)

lemma real_weight_identity {x : ℝ} (hx : 0 < x) (σ : ℝ) :
    x ^ (-2 : ℝ) * Real.exp (-σ * Real.log x) = x ^ (-σ - 2)

theorem laplace_mass_eq_norm {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) (σ : ℝ) :
    LaplaceConvergenceAbscissa.mass (tailMeasure A) time σ =
      ∫⁻ x : ℝ in Ioi 1, ‖(x : ℂ) ^ (-(σ : ℂ) - 2) *
        MellinCompactCorrection.negativeWTail A x‖ₑ

theorem laplace_integrable {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {σ : ℝ} (hσ : 1 < σ) :
    Integrable (fun x => Real.exp (-σ * time x)) (tailMeasure A)

theorem convergenceSet_nonempty {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    (LaplaceConvergenceAbscissa.convergenceSet (tailMeasure A) time).Nonempty
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Measure-theoretic foundations of arithmetic functions with floor cutoffs and Laplace transforms (Hewitt-Stromberg 1965, Widder 1941). The formal verification of floor sum measurability and critical tail measure mass identities in Lean 4 is novel.
- **Advancement:** Establishes machine-verified Borel measurability and mass-to-norm equivalence for floor-cutoff critical measures.
- **Target Venues:** *Real Analysis Exchange* or *Journal of Mathematical Analysis and Applications*.
