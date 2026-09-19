# Unique Contribution 197: Exact Prime Seed L² Strong Cutoff Convergence and Uniform Operator Approximation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedSquareConvergence.lean`](../../formalization/BuildingBlocks/PrimeSeedSquareConvergence.lean), [`building-blocks/primes/prime-seed-square-convergence.md`](../../building-blocks/primes/prime-seed-square-convergence.md)  
**Classification:** Functional Analysis / Operator Theory / Causal Renewal Operators / Strong L² Convergence / Dominated Convergence / Uniform Unit-Ball Approximations

---

## 1. Executive Summary and Mathematical Statement

In the operator-theoretic formulation of the prime renewal equation, the all-prime memory kernel acts on input functions $f \in L^2((0, \infty))$ via the causal memory operator $\mathcal{K}_{\text{all}}[f](v) = \int_0^\infty \text{allPrimeSeed}(v - u) f(u) du$. While the total seed mass $\int B = \infty$ diverges, the collective seed is square-integrable: $B \in L^2(\mathbb{R})$. A vital open problem was proving that finite prime cutoffs $\mathcal{K}_P$ converge to $\mathcal{K}_{\text{all}}$ in the uniform operator topology over the $L^2$ unit ball, with uniform bounds holding simultaneously across all output ages $v \in \mathbb{R}$.

This contribution proves:

1. **Pointwise Stabilization:**  
   At any fixed output age $v \in \mathbb{R}$, for all cutoffs $P \ge \lfloor e^v \rfloor + 1$, the finite prime seed coincides identically with the full all-prime seed:
   \[
   \text{finitePrimeSeed}(P, v) = \text{allPrimeSeed}(v).
   \]
2. **Monotone $L^2$ Domination:**  
   The pointwise squared error is uniformly bounded by the square of the un-truncated seed:
   \[
   (\text{allPrimeSeed}(v) - \text{finitePrimeSeed}(P, v))^2 \le \text{allPrimeSeed}(v)^2 \in L^1(\mathbb{R}).
   \]
3. **Strong $L^2(\mathbb{R})$ Convergence:**  
   By the Lebesgue Dominated Convergence Theorem applied with integrable majorant $B^2 \in L^1(\mathbb{R})$:
   \[
   \lim_{P \to \infty} \|\text{allPrimeSeed} - \text{finitePrimeSeed}(P)\|_{L^2(\mathbb{R})} = 0.
   \]
4. **Cauchy-Schwarz Pointwise Operator Error Bound:**  
   For any half-line source $f \in L^2((0, \infty))$ and any output age $v \in \mathbb{R}$:
   \[
   |\mathcal{K}_{\text{all}}[f](v) - \mathcal{K}_P[f](v)| \le \|\text{allPrimeSeed} - \text{finitePrimeSeed}(P)\|_{L^2(\mathbb{R})} \cdot \|f\|_{L^2((0, \infty))}.
   \]
5. **Uniform Convergence in Output Age:**  
   For any fixed source $f \in L^2((0, \infty))$, the convergence is uniform across the entire real line:
   \[
   \lim_{P \to \infty} \sup_{v \in \mathbb{R}} |\mathcal{K}_{\text{all}}[f](v) - \mathcal{K}_P[f](v)| = 0.
   \]
6. **Uniform Operator Approximation on the $L^2$ Unit Ball:**  
   For every $\varepsilon > 0$, there exists an integer cutoff $P_0$ such that for all $P \ge P_0$, for ALL source functions in the half-line unit ball ($\|f\|_{L^2((0, \infty))} \le 1$), and for ALL ages $v \in \mathbb{R}$:
   \[
   |\mathcal{K}_{\text{all}}[f](v) - \mathcal{K}_P[f](v)| < \varepsilon.
   \]
   Thus $\mathcal{K}_P \to \mathcal{K}_{\text{all}}$ in the operator norm of $\mathcal{B}(L^2((0, \infty)), L^\infty(\mathbb{R}))$.

---

## 2. Mathematical Proof

### 2.1. Pointwise Stabilization and Domination
For $p > P \ge \lfloor e^v \rfloor + 1 > e^v$, we have $\log p > v$.
By causality, $\text{seed}_{\log p}(v) = 0$.
Thus the tail $\sum_{p > P} \text{seed}_{\log p}(v) = 0$, proving $\text{finitePrimeSeed}(P, v) = \text{allPrimeSeed}(v)$.
Since $0 \le \text{finitePrimeSeed} \le \text{allPrimeSeed}$, the difference is between 0 and $\text{allPrimeSeed}$, so its square is dominated by $\text{allPrimeSeed}^2$.

### 2.2. Dominated Convergence
Since $\text{allPrimeSeed} \in L^2(\mathbb{R})$ (`integrable_allPrimeSeed_square`), the dominating function $\text{allPrimeSeed}^2$ is integrable on $\mathbb{R}$.
Pointwise, $(\text{allPrimeSeed}(v) - \text{finitePrimeSeed}(P, v))^2 \to 0$ for every $v$.
By the dominated convergence theorem (`tendsto_integral_of_dominated_convergence`), the integral of the squared difference tends to 0.
Taking square roots yields $\|\text{allPrimeSeed} - \text{finitePrimeSeed}(P)\|_{L^2} \to 0$.

### 2.3. Operator Bounds
Writing the difference of causal memories:
\[
\mathcal{K}_{\text{all}}[f](v) - \mathcal{K}_P[f](v) = \int_0^\infty (\text{allPrimeSeed}(v - u) - \text{finitePrimeSeed}(P, v - u)) f(u) du.
\]
By the Cauchy-Schwarz inequality on $(0, \infty)$:
\[
\left| \int_0^\infty (B - B_P)(v - u) f(u) du \right| \le \left( \int_0^\infty (B - B_P)(v - u)^2 du \right)^{1/2} \|f\|_{L^2((0, \infty))}.
\]
Substituting $w = v - u$:
\[
\int_0^\infty (B - B_P)(v - u)^2 du \le \int_{-\infty}^\infty (B - B_P)(w)^2 dw = \|B - B_P\|_{L^2(\mathbb{R})}^2.
\]
Thus the bound is independent of $v$.
For $\|f\|_{L^2} \le 1$, the right-hand side is bounded by $\|B - B_P\|_{L^2}$, which is smaller than $\varepsilon$ for $P \ge P_0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedSquareConvergence.lean`):
```lean
theorem cutoff_seed_eventually_eq (v : ℝ) :
    ∀ᶠ P : ℕ in atTop, finitePrimeSeed (primesBelow P) v = allPrimeSeed v

theorem cutoff_seed_square_error_bound (P : ℕ) (v : ℝ) :
    (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2 ≤ allPrimeSeed v ^ 2

theorem cutoff_seed_square_error_tendsto :
    Tendsto (fun P : ℕ => ∫ v, (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2)
      atTop (𝓝 0)

theorem cutoff_seed_sqrt_error_tendsto :
    Tendsto (fun P : ℕ => sqrt (∫ v,
      (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2)) atTop (𝓝 0)

theorem cutoff_memory_error_bound (P : ℕ) {f : ℝ → ℝ}
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    |SuccessorCharge.causalMemory allPrimeSeed f v -
      SuccessorCharge.causalMemory (finitePrimeSeed (primesBelow P)) f v| ≤
      sqrt (∫ w, (allPrimeSeed w - finitePrimeSeed (primesBelow P) w) ^ 2) *
        sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2)

theorem cutoff_memory_uniform {f : ℝ → ℝ}
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) {ε : ℝ} (hε : 0 < ε) :
    ∃ P₀ : ℕ, ∀ P ≥ P₀, ∀ v : ℝ,
      |SuccessorCharge.causalMemory allPrimeSeed f v -
        SuccessorCharge.causalMemory (finitePrimeSeed (primesBelow P)) f v| < ε

theorem cutoff_memory_uniform_unit_ball {ε : ℝ} (hε : 0 < ε) :
    ∃ P₀ : ℕ, ∀ P ≥ P₀, ∀ f : ℝ → ℝ,
      MemLp f 2 (volume.restrict (Ioi (0 : ℝ))) →
      (∫ u in Ioi (0 : ℝ), f u ^ 2) ≤ 1 → ∀ v : ℝ,
      |SuccessorCharge.causalMemory allPrimeSeed f v -
        SuccessorCharge.causalMemory (finitePrimeSeed (primesBelow P)) f v| < ε
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Integral operators and convolution kernels in $L^2$ (Halmos-Sunder 1978, Reed-Simon 1980). Machine formalization of $L^2$ convergence via dominated convergence and uniform operator bounds on $L^2$ unit balls for prime renewal kernels in Lean 4 is new.
- **Advancement:** Proves $\|B - B_P\|_{L^2} \to 0$ and establishes uniform approximation of the causal memory operator on the entire unit ball of $L^2((0, \infty))$ in Lean 4.
- **Target Venues:** *Journal of Functional Analysis* or *Integral Equations and Operator Theory*.
