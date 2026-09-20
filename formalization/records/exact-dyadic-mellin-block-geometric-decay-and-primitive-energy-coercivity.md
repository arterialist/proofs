# Contribution 120: Exact Dyadic Mellin-Block Geometric Decay and Primitive Energy Coercivity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarseDyadicBound.lean`](../../formalization/BuildingBlocks/CoarseDyadicBound.lean), [`formalization/BuildingBlocks/CoarseBlockAnalytic.lean`](../../formalization/BuildingBlocks/CoarseBlockAnalytic.lean), [`building-blocks/prime-distribution/coarse-dyadic-bounds.md`](../../building-blocks/prime-distribution/coarse-dyadic-bounds.md)  
**Classification:** Analytic Number Theory / Riemann Zeta Function / Dyadic Mellin Transforms / Primitive Sobolev Energy / Geometric Decay / Entire Functions

---

## 1. Executive Summary and Mathematical Statement

In the analysis of the Riemann hypothesis through the dyadic Mellin series $\sum_{k=0}^\infty M_k(s)$ of the Chebyshev prime-power error function:
$$
M_k(s) = \int_{2^k}^{2^{k+1}} (\psi(\lfloor x \rfloor) - x) x^{-(s+1)} dx,
$$
the critical technical milestone is establishing uniform geometric convergence in the critical strip $\operatorname{Re}(s) > 1/2$.

This contribution proves:

1. **Entire Analyticity of Individual Dyadic Blocks:**  
   For each $k \in \mathbb{N}$ and any $X > 0$, the finite dyadic Mellin block $s \mapsto \int_X^{2X} (\psi(\lfloor x \rfloor) - x) x^{-(s+1)} dx$ is an entire function on $\mathbb{C}$, differentiable everywhere with parametric integral derivative:
   $$
   M_k'(s) = -\int_X^{2X} (\psi(\lfloor x \rfloor) - x) (\log x) x^{-(s+1)} dx.
   $$
2. **Exact Dyadic Mellin Norm Majorization:**  
   For any $X \ge 1$, $a \ge 0$, and $\operatorname{Re}(s) \ge a$:
   $$
   \|M_X(s)\| \le \sqrt{\frac{2 \mathcal{E}_{\text{prim}}(X)}{X}} X^{-(a+1)} + \|s + 1\| X^{-(a+2)} \sqrt{X \mathcal{E}_{\text{prim}}(X)}.
   $$
3. **Exact Exponent Coincidence:**  
   Under the coarse primitive energy bound $\mathcal{E}_{\text{prim}}(X) \le C X^{4+\varepsilon}$, both terms in the majorant possess identical scaling exponents:
   $$
   \frac{3+\varepsilon}{2} - (a+1) = \frac{1/2 - a + \varepsilon}{2}, \quad \frac{5+\varepsilon}{2} - (a+2) = \frac{1/2 - a + \varepsilon}{2}.
   $$
4. **Sharp Geometric Decay in the Critical Half-Plane:**  
   For any fixed $a > 1/2$ and bounded radius $\|s + 1\| \le R$, setting $\varepsilon = a - 1/2 > 0$ yields the strictly negative exponent $b = \frac{1/2 - a}{2} < 0$. Consequently, the dyadic Mellin blocks decay geometrically:
   $$
   \|M_k(s)\| \le M \cdot r^k, \quad \text{where } r = 2^{(1/2 - a)/2} \in (0, 1) \text{ and } M = \sqrt{2C} + R\sqrt{C}.
   $$

---

## 2. Mathematical Proof

### 2.1. Entire Analyticity
Writing $x^{-(s+1)} = \exp(-(s+1)\log x)$ for $x \in [X, 2X]$ with $X > 0$, the kernel $s \mapsto x^{-(s+1)}$ is entire for each $x$, and its derivative with respect to $s$ is $-(\log x) x^{-(s+1)}$.
Since $[X, 2X]$ is compact and $\psi(\lfloor x \rfloor) - x$ is bounded on $[X, 2X]$, the integrand and its derivative are bounded uniformly on compact disks $|s| \le K$. By the Leibniz rule for parametric Lebesgue integrals, $M_X(s)$ is holomorphic on all of $\mathbb{C}$.

### 2.2. Dyadic Mellin Norm Majorization
Using the exact summation-by-parts Mellin formula:
$$
M_X(s) = P(2X) (2X)^{-(s+1)} + (s+1) \int_X^{2X} P(x) x^{-(s+2)} dx,
$$
where $P(x) = \int_X^x (\psi(\lfloor u \rfloor) - u) du$.
Taking norms:
$$
\|M_X(s)\| \le |P(2X)| (2X)^{-(\sigma+1)} + \|s+1\| \int_X^{2X} |P(x)| x^{-(\sigma+2)} dx.
$$
Substituting $|P(2X)| \le \sqrt{\frac{2\mathcal{E}_{\text{prim}}(X)}{X}}$, $x^{-(\sigma+2)} \le X^{-(a+2)}$, and $\int_X^{2X} |P(x)| dx \le \sqrt{X \mathcal{E}_{\text{prim}}(X)}$ yields the inequality.

### 2.3. Exponent Matching and Geometric Convergence
Substituting $\mathcal{E}_{\text{prim}}(X) \le C X^{4+\varepsilon}$:
$$
\sqrt{\frac{2\mathcal{E}_{\text{prim}}(X)}{X}} X^{-(a+1)} \le \sqrt{2C} X^{(3+\varepsilon)/2 - a - 1} = \sqrt{2C} X^{\frac{1/2 - a + \varepsilon}{2}},
$$
and:
$$
X^{-(a+2)} \sqrt{X \mathcal{E}_{\text{prim}}(X)} \le \sqrt{C} X^{-(a+2) + (5+\varepsilon)/2} = \sqrt{C} X^{\frac{1/2 - a + \varepsilon}{2}}.
$$
Setting $\varepsilon = a - 1/2 > 0$:
$$
\frac{1/2 - a + \varepsilon}{2} = \frac{1/2 - a + (a - 1/2)}{2} = \frac{1/2 - a}{2} < 0.
$$
For $X = 2^k$, $X^b = (2^b)^k = r^k$ with $r = 2^{(1/2 - a)/2} < 1$, establishing uniform geometric decay.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive`):
```lean
theorem coarsePrime_finiteMellin_differentiable {X : ℝ} (hX : 0 < X) :
    Differentiable ℂ (fun s : ℂ => ∫ x in X..(2 * X),
      (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1)))

theorem coarseMellinBlock_analytic (k : ℕ) :
    AnalyticOnNhd ℂ (coarseMellinBlock k) Set.univ

lemma coarsePrime_mellin_norm_le {X a : ℝ} (hX : 1 ≤ X) (ha : 0 ≤ a)
    {s : ℂ} (hs : a ≤ s.re) :
    ‖∫ x in X..(2 * X), (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))‖ ≤
      Real.sqrt (2 * coarsePrimitiveSquare X / X) * X ^ (-(a + 1)) +
      ‖s + 1‖ * (X ^ (-(a + 2)) * Real.sqrt (X * coarsePrimitiveSquare X))

lemma coarseMellinBlock_power_bound (hb : CoarsePrimitiveBound) {a R : ℝ}
    (ha : 1 / 2 < a) (hR : 0 ≤ R) :
    ∃ M b : ℝ, 0 < M ∧ b < 0 ∧ ∀ (k : ℕ) (s : ℂ),
      a ≤ s.re → ‖s + 1‖ ≤ R →
      ‖coarseMellinBlock k s‖ ≤ M * ((2 : ℝ) ^ k) ^ b

lemma coarseMellinBlock_geometric_bound (hb : CoarsePrimitiveBound) {a R : ℝ}
    (ha : 1 / 2 < a) (hR : 0 ≤ R) :
    ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧ ∀ (k : ℕ) (s : ℂ),
      a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dyadic decompositions in harmonic analysis and prime number theory (Littlewood-Paley theory, Tao 2014). Formalizing the entire analyticity of discontinuous prime error Mellin blocks and their uniform geometric decay $r^k$ with $r < 1$ in the half-plane $\operatorname{Re}(s) > 1/2$ governed by primitive Sobolev energy in Lean 4 is novel.
- **Advancement:** Establishes machine-verified uniform geometric decay of dyadic Mellin blocks under primitive energy coercivity.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Functional Analysis*.
