# Unique Contribution 75: Chronological Divisibility Turán Determinant and Sub-Multiplicativity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChronologicalDivisibility.lean`](../../formalization/BuildingBlocks/ChronologicalDivisibility.lean)  
**Classification:** Analytic Number Theory / Probabilistic Number Theory / Turán Inequalities / Log-Concavity / Divisibility Correlations

---

## 1. Executive Summary and Mathematical Statement

In the probabilistic modeling of integer divisibility (such as the Kubilius model or Turán–Kubilius inequalities), divisibility events $E_r = \{n : r \mid n\}$ are asymptotically independent with marginal densities $1/r$. In the causal, continuous-time formulation of arithmetic aggregation via the square-root weighted tent function:
\[
S(x) = \sum_{j=1}^{\lfloor x \rfloor} \frac{x - j}{\sqrt{j}},
\]
one introduces the exact non-asymptotic chronological divisibility probability:
\[
\mathbb{P}(r \mid x) = \frac{\sqrt{r} S(x/r)}{S(x)}.
\]

This contribution proves:

1. **Monotone Growth of Divisibility Probability:**  
   For every positive integer dilation $r \ge 1$, the normalized probability $\mathbb{P}(r \mid x)$ is strictly monotone non-decreasing in the clock variable $x \in (1, \infty)$:
   \[
   \forall x \le y \in (1, \infty), \quad \mathbb{P}(r \mid x) \le \mathbb{P}(r \mid y).
   \]
   At $r = 1$, $\mathbb{P}(1 \mid x) = 1$ identically.
2. **Multiplicative Turán Inequality for Dilation Determinants:**  
   For all integer dilations $a, b \ge 1$ and all scales $x > 1$, the $2 \times 2$ dilation determinant is unconditionally non-negative:
   \[
   \det \begin{pmatrix} S(x/a) & S(x) \\ S(x/(ab)) & S(x/b) \end{pmatrix} = S(x/a) S(x/b) - S(x) S(x/(ab)) \ge 0.
   \]
3. **Exact Sub-Multiplicativity (Negative Association of Divisibility):**  
   The joint probability of divisibility by a composite product $ab$ is strictly bounded by the product of its marginal probabilities:
   \[
   \mathbb{P}(ab \mid x) \le \mathbb{P}(a \mid x) \cdot \mathbb{P}(b \mid x).
   \]
4. **Significance for Arithmetic Sifting:**  
   Proves that in the continuous chronological tent measure, divisibility events exhibit unconditional **negative dependence (sub-multiplicativity)**. This guarantees that inclusion-exclusion sieve sums do not experience positive reinforcement blow-ups, providing a rigorous geometric foundation for sifting arithmetic progressions.

---

## 2. Mathematical Proof

### 2.1. Piecewise Affine Representation
On each unit cell $[n, n+1]$, $S(x)$ is affine: $S(x) = x \sum_{j=1}^n j^{-1/2} - \sum_{j=1}^n \sqrt{j}$.
The cross product of affine coefficients $a d - r c b$ is proven non-negative by induction on cell sizes, establishing that the affine ratio $\frac{S(x/r)}{S(x)}$ has non-negative derivative on each cell.
Since $S(x)$ is continuous across cell boundaries (as the newly added summand $(n+1 - (n+1))/\sqrt{n+1} = 0$ vanishes at integer endpoints), piecewise monotonicity extends to global monotonicity on $(1, \infty)$.

### 2.2. Turán Determinant
For $x > 1$ and $a, b \ge 1$, if $x/a > 1$, then $x/a \le x$.
Applying monotonicity of $\mathbb{P}(b \mid \cdot)$ between the two points $x/a$ and $x$:
\[
\mathbb{P}(b \mid x/a) \le \mathbb{P}(b \mid x).
\]
Substituting the definition of $\mathbb{P}(b \mid \cdot)$:
\[
\frac{\sqrt{b} S((x/a)/b)}{S(x/a)} \le \frac{\sqrt{b} S(x/b)}{S(x)}.
\]
Simplifying $\sqrt{b}$ and cross-multiplying (since $S(x/a) > 0$ and $S(x) > 0$):
\[
S(x/(ab)) S(x) \le S(x/a) S(x/b),
\]
which is $S(x/a) S(x/b) - S(x) S(x/(ab)) \ge 0$.
If $x/a \le 1$, then $S(x/a) = 0$ and $S(x/(ab)) = 0$, so the inequality holds trivially with $0 = 0$.

### 2.3. Sub-Multiplicativity
Dividing the Turán inequality by $S(x)^2$ and scaling by $\sqrt{ab} = \sqrt{a} \sqrt{b}$:
\[
\frac{\sqrt{ab} S(x/(ab))}{S(x)} \le \left(\frac{\sqrt{a} S(x/a)}{S(x)}\right) \left(\frac{\sqrt{b} S(x/b)}{S(x)}\right),
\]
which is exactly $\mathbb{P}(ab \mid x) \le \mathbb{P}(a \mid x) \mathbb{P}(b \mid x)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChronologicalDivisibility`):
```lean
theorem probability_monotoneOn {r : ℕ} (hr : 1 ≤ r) :
    MonotoneOn (probability r) (Set.Ioi 1)

theorem determinant_nonneg {a b : ℕ} (ha : 1 ≤ a) (hb : 1 ≤ b)
    {x : ℝ} (hx : 1 < x) :
    0 ≤ S (x / a) * S (x / b) - S x * S (x / (a * b : ℕ))

theorem probability_mul_le {a b : ℕ} (ha : 1 ≤ a) (hb : 1 ≤ b)
    {x : ℝ} (hx : 1 < x) :
    probability (a * b) x ≤ probability a x * probability b x

theorem S_pos {x : ℝ} (hx : 1 < x) : 0 < S x
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Turán inequalities typically concern orthogonal polynomials or log-concave sequences. The multiplicative Turán determinant and negative dependence of divisibility in continuous-time tent functions had not been formalized in Lean 4.
- **Advancement:** Establishes the exact Turán determinant non-negativity and sub-multiplicativity of divisibility events in the chronological tent measure.
- **Target Venues:** *Journal of Number Theory* or *Combinatorics, Probability and Computing*.
