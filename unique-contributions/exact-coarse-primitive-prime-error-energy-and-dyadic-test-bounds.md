# Unique Contribution 116: Exact Coarse-Primitive Prime-Error Energy and Dyadic Test Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarsePrimitive.lean`](../../formalization/BuildingBlocks/CoarsePrimitive.lean), [`building-blocks/prime-distribution/coarse-primitive.md`](../../building-blocks/prime-distribution/coarse-primitive.md)  
**Classification:** Analytic Number Theory / Chebyshev Prime Errors / Primitive Energy Functional / Summation by Parts / Dyadic Mellin Blocks

---

## 1. Executive Summary and Mathematical Statement

In the study of the Chebyshev prime-power error function:
\[
E(x) = \psi(\lfloor x \rfloor) - x,
\]
its discontinuities and floor jumps create technical obstructions for direct $L^2$ or Sobolev pairings. To overcome this without assuming unproved pointwise error bounds, we define the dyadic primitive energy functional:
\[
\mathcal{E}_{\text{prim}}(X) = \int_X^{2X} \left[ \left(\int_X^t E(x) dx\right)^2 + \left(\int_t^{2X} E(x) dx\right)^2 \right] dt.
\]

This contribution proves:

1. **Terminal Mass Control by Primitive Energy:**  
   Without any pointwise hypothesis on the prime error $E(x)$, the terminal mass $\int_X^{2X} E(x) dx$ is strictly controlled by the primitive energy:
   \[
   X \left( \int_X^{2X} E(x) dx \right)^2 \le 2 \mathcal{E}_{\text{prim}}(X) \implies \left| \int_X^{2X} E(x) dx \right| \le \sqrt{\frac{2 \mathcal{E}_{\text{prim}}(X)}{X}}.
   \]
2. **Exact Summation by Parts with Floor Jumps:**  
   For any test function $w \in C^1([X, 2X])$, despite the discontinuous jumps of $E(x)$, integration by parts holds rigorously with right-derivatives:
   \[
   \int_X^{2X} E(x) w(x) dx = w(2X) \int_X^{2X} E(x) dx - \int_X^{2X} w'(x) \left( \int_X^x E(u) du \right) dx.
   \]
3. **Exact Dyadic Mellin Block Formula:**  
   Applying this to $w(x) = x^{-(s+1)}$ for any $s \in \mathbb{C}$ gives:
   \[
   \int_X^{2X} E(x) x^{-(s+1)} dx = (2X)^{-(s+1)} \int_X^{2X} E(x) dx + (s+1) \int_X^{2X} x^{-(s+2)} \left( \int_X^x E(u) du \right) dx.
   \]
4. **Universal Test-Function Estimate:**  
   If $\|w'\|_{L^\infty([X, 2X])} \le K$, then:
   \[
   \left\| \int_X^{2X} E(x) w(x) dx \right\| \le \sqrt{\frac{2 \mathcal{E}_{\text{prim}}(X)}{X}} \|w(2X)\| + K \sqrt{X \mathcal{E}_{\text{prim}}(X)}.
   \]

---

## 2. Mathematical Proof

### 2.1. Terminal Mass Inequality
Let $P(t) = \int_X^t E(x) dx$ and $S(t) = \int_t^{2X} E(x) dx$. By additivity of integrals over adjacent intervals, $P(t) + S(t) = P(2X)$ for all $t \in [X, 2X]$.
Using the Cauchy-Schwarz elementary square inequality $(a + b)^2 \le 2(a^2 + b^2)$:
\[
P(2X)^2 = (P(t) + S(t))^2 \le 2(P(t)^2 + S(t)^2).
\]
Integrating $t$ over $[X, 2X]$ of length $X$:
\[
X P(2X)^2 = \int_X^{2X} P(2X)^2 dt \le 2 \int_X^{2X} (P(t)^2 + S(t)^2) dt = 2 \mathcal{E}_{\text{prim}}(X).
\]
Dividing by $X > 0$ yields the result.

### 2.2. Summation by Parts
The floor function $\lfloor x \rfloor$ is right-continuous and piecewise constant, making $\psi(\lfloor x \rfloor) - x$ measurable and right-continuous. The Lebesgue integral $P(x) = \int_X^x E(u) du$ is continuous and has right-derivative $P'_+(x) = E(x)$ everywhere.
By the integration-by-parts identity for functions with right-derivatives:
\[
\int_X^{2X} P'_+(x) w(x) dx = P(2X) w(2X) - P(X) w(X) - \int_X^{2X} P(x) w'(x) dx.
\]
Since $P(X) = 0$, this yields the exact formula.

### 2.3. Test-Function Bound
By the triangle inequality:
\[
\left\| \int_X^{2X} E(x) w(x) dx \right\| \le |P(2X)| \|w(2X)\| + \int_X^{2X} |P(x)| \|w'(x)\| dx.
\]
Using $\|w'\|_{L^\infty} \le K$ and Cauchy-Schwarz on the integral of $|P(x)|$:
\[
\left(\int_X^{2X} |P(x)| dx\right)^2 \le X \int_X^{2X} P(x)^2 dx \le X \mathcal{E}_{\text{prim}}(X),
\]
giving $\int_X^{2X} |P(x)| dx \le \sqrt{X \mathcal{E}_{\text{prim}}(X)}$.
Combining this with $|P(2X)| \le \sqrt{2 \mathcal{E}_{\text{prim}}(X)/X}$ completes the proof.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive`):
```lean
theorem coarse_terminal_mass_sq_le {X : ℝ} (hX : 0 ≤ X) :
    X * coarsePrefix X (2 * X) ^ 2 ≤ 2 * coarsePrimitiveSquare X

theorem coarsePrime_summation_by_parts {X : ℝ} {w w' : ℝ → ℂ}
    (hw : ContinuousOn w [[X, 2 * X]])
    (hd : ∀ x ∈ Ioo (min X (2 * X)) (max X (2 * X)), HasDerivAt w (w' x) x)
    (hi : IntervalIntegrable w' volume X (2 * X)) :
    (∫ x in X..(2 * X), (primeErrorReal x : ℂ) * w x) =
      (coarsePrefix X (2 * X) : ℂ) * w (2 * X) -
      ∫ x in X..(2 * X), (coarsePrefix X x : ℂ) * w' x

theorem coarsePrime_mellin_block {X : ℝ} (hX : 0 < X) (s : ℂ) :
    (∫ x in X..(2 * X), (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) =
      (coarsePrefix X (2 * X) : ℂ) * (2 * X : ℂ) ^ (-(s + 1)) +
      (s + 1) * ∫ x in X..(2 * X),
        (coarsePrefix X x : ℂ) * (x : ℂ) ^ (-(s + 2))

theorem coarsePrime_test_bound {X K : ℝ} (hX : 0 < X) (hK : 0 ≤ K)
    {w w' : ℝ → ℂ} (hw : ContinuousOn w [[X, 2 * X]])
    (hd : ∀ x ∈ Ioo (min X (2 * X)) (max X (2 * X)), HasDerivAt w (w' x) x)
    (hi : IntervalIntegrable w' volume X (2 * X))
    (hbound : ∀ x ∈ Ioc X (2 * X), ‖w' x‖ ≤ K) :
    ‖∫ x in X..(2 * X), (primeErrorReal x : ℂ) * w x‖ ≤
      Real.sqrt (2 * coarsePrimitiveSquare X / X) * ‖w (2 * X)‖ +
      K * Real.sqrt (X * coarsePrimitiveSquare X)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Explicit formula smoothing and dyadic decomposition (Cramér 1920, Montgomery 1971, Goldston 1982). Controlling discontinuous prime errors via their continuous primitive $L^2$ energy without point-evaluation hypotheses in Lean 4 is novel.
- **Advancement:** Establishes machine-verified quantitative test-function bounds for actual discontinuous prime errors via primitive energy.
- **Target Venues:** *Quarterly Journal of Mathematics* or *Monatshefte für Mathematik*.
