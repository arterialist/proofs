# Unique Contribution 283: Exact Fixed-Coefficient Decay and Finite-Quotient Repair Impossibility

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FixedCoefficient.lean`](../../formalization/BuildingBlocks/FixedCoefficient.lean), [`building-blocks/mertens-transfer/fixed-coefficient.md`](../../building-blocks/mertens-transfer/fixed-coefficient.md)  
**Classification:** Analytic Number Theory / Functional Analysis / Dual Nyman–Beurling Theory / Mertens Function / Obstruction Theory / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the dual Nyman–Beurling framework, the natural quotient coefficients $c_N(q) = M(\lfloor N/q \rfloor) - M(\lfloor N/(q+1) \rfloor)$ fail to produce an $L^2$ Cauchy sequence due to the $O(\sqrt{N})$ oscillation of the Mertens function $M(N)$. A natural question is whether one can repair the convergence by modifying a finite number of initial coefficients $c_N(1), \dots, c_N(K)$ to absorb low-frequency boundary defects.

This contribution proves:

1. **Universal $\sqrt{N}$ Vanishing of Fixed Coefficients:**  
   If an arbitrary triangular array $c_N(q)$ ($1 \le q \le N$) yields an $L^2(0, \infty)$ Cauchy sequence $\sum_{q=1}^N c_N(q) \rho\left(\frac{q}{Nx}\right)$, then for EVERY fixed integer $j \ge 1$:
   \[
   \lim_{N \to \infty} \frac{c_N(j)}{\sqrt{N}} = 0.
   \]
2. **Impossibility of Finite Quotient Repairs:**  
   Let $K \in \mathbb{N}$ be arbitrary. If an array $c_N(q)$ modifies the first $K$ coefficients in any arbitrary manner but coincides with the quotient coefficients $c_N(q) = M(\lfloor N/q \rfloor) - M(\lfloor N/(q+1) \rfloor)$ for $q > K$, then under the established Mertens oscillation premise ($\limsup_{N \to \infty} M(N)^2/N > 0$), the sequence:
   \[
   x \mapsto \sum_{q=1}^N c_N(q) \rho\left(\frac{q}{Nx}\right)
   \]
   CANNOT be Cauchy in $L^2(0, \infty)$.
3. **Impossibility of $L^2$ Convergence to Arbitrary Limits:**  
   No finite modification of the quotient array can converge in $L^2(0, \infty)$ to ANY target function $g \in L^2(0, \infty)$.
4. **Window Moment Representation and Inversion:**  
   The arithmetic window moments $W_j(c, N) = \sum_{q=1}^j q \cdot c_N(q) \lfloor j/q \rfloor$ satisfy:
   \[
   \frac{W_j(c, N)}{\sqrt{N}} = \sum_{q=1}^{j-1} q \cdot \frac{c_N(q)}{\sqrt{N}} \left\lfloor \frac{j}{q} \right\rfloor + j \frac{c_N(j)}{\sqrt{N}},
   \]
   enabling exact triangular inversion by strong mathematical induction.
5. **Non-Asymptotic Cauchy Lower Bound on Window Moments:**  
   For $(j+1)M \le N$:
   \[
   \frac{W_j(c, N)^2}{N} \le 24 (j+1)^4 \int_0^\infty (\text{arrayFraction}(c, N, x) - \text{arrayFraction}(c, M, x))^2 dx.
   \]

---

## 2. Mathematical Proof

### 2.1. Window Moment Lower Bound
Under the reciprocal isometry, on the window $x \in (j/N, (j+1)/N)$, the reciprocal kernel simplifies to $1 - \frac{q \lfloor j/q \rfloor}{Nx}$.
Summing over $q$ yields:
\[
\text{arrayImage}(c, N, x) = \sum_{q=1}^N c_N(q) - \frac{W_j(c, N)}{Nx}.
\]
For $(j+1)M \le N$, $x < (j+1)/N \le 1/M$, so $x$ falls in the constant window of $M$, where $\text{arrayImage}(c, M, x) = \sum_{q=1}^M c_M(q)$.
The window variance inequality on $[j, j+1]$ yields:
\[
\int_j^{j+1} (B - A/u)^2 du \ge \frac{A^2}{24 (j+1)^4},
\]
where $A = W_j(c, N)$ and $B = \sum c_N - \sum c_M$.
Scaling $u = Nx$ gives the stated Cauchy lower bound.

### 2.2. Strong Induction on Fixed Coefficients
If the array is Cauchy, then $W_j(c, N)^2 / N \to 0$, hence $W_j(c, N)/\sqrt{N} \to 0$.
We prove $c_N(j)/\sqrt{N} \to 0$ by strong induction on $j$:
- Base case $j = 1$: $W_1(c, N) = c_N(1)$, so $c_N(1)/\sqrt{N} \to 0$.
- Induction step: Assume $c_N(q)/\sqrt{N} \to 0$ for all $q < j$.
  From $W_j(c, N)/\sqrt{N} = \sum_{q < j} q \lfloor j/q \rfloor \frac{c_N(q)}{\sqrt{N}} + j \frac{c_N(j)}{\sqrt{N}}$, the sum over $q < j$ vanishes by the induction hypothesis.
  Since $j > 0$, dividing by $j$ gives $c_N(j)/\sqrt{N} \to 0$.

### 2.3. Obstruction to Finite Quotient Repairs
If $c_N(q) = \text{quotientCoefficient}(N, q)$ for $q > K$, consider $j = K + 1$.
By the quotient coefficient definition:
\[
c_N(K+1) = M\left(\left\lfloor \frac{N}{K+1} \right\rfloor\right) - M\left(\left\lfloor \frac{N}{K+2} \right\rfloor\right).
\]
Under the established Mertens oscillation premise, this cannot vanish faster than $\sqrt{N}$. This contradicts $c_N(K+1)/\sqrt{N} \to 0$, proving that the sequence cannot be Cauchy.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/FixedCoefficient.lean`):
```lean
theorem array_window_distance_lower (c : ℕ → ℕ → ℝ) {N M j : ℕ}
    (hM : 0 < M) (hj : 0 < j) (hNM : (j + 1) * M ≤ N) :
    windowMoment c N j ^ 2 / (N : ℝ) ≤ 24 * ((j : ℝ) + 1) ^ 4 *
      ∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - arrayFraction c M x) ^ 2

theorem windowMoment_sq_tendsto_of_cauchy (c : ℕ → ℕ → ℝ) (h : ArrayCauchy c)
    {j : ℕ} (hj : 0 < j) :
    Tendsto (fun N : ℕ => windowMoment c N j ^ 2 / (N : ℝ)) atTop (𝓝 0)

theorem fixed_coefficient_tendsto_of_cauchy (c : ℕ → ℕ → ℝ) (h : ArrayCauchy c)
    {j : ℕ} (hj : 0 < j) :
    Tendsto (fun N : ℕ => c N j / Real.sqrt (N : ℝ)) atTop (𝓝 0)

theorem finite_quotient_repair_not_cauchy (c : ℕ → ℕ → ℝ) (K : ℕ)
    (heq : ∀ᶠ N : ℕ in atTop, ∀ q, K < q → q ≤ N → c N q = (quotientCoefficient N q : ℝ))
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ ArrayCauchy c

theorem finite_quotient_repair_not_convergent (c : ℕ → ℕ → ℝ) (K : ℕ) (g : ℝ → ℝ)
    (heq : ∀ᶠ N : ℕ in atTop, ∀ q, K < q → q ≤ N → c N q = (quotientCoefficient N q : ℝ))
    (hI : ∀ N : ℕ, 0 < N →
      IntegrableOn (fun x => (arrayFraction c N x - g x) ^ 2) (Set.Ioi (0 : ℝ)))
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ Tendsto (fun N : ℕ =>
      ∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - g x) ^ 2) atTop (𝓝 0)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Nyman–Beurling criterion, Báez-Duarte's natural step function (2003), and Balazard (2000). The mathematical impossibility of repairing quotient dual approximations via finite-rank modifications in Lean 4 is new.
- **Advancement:** Establishes that the Mertens oscillation obstacle is an infinite-dimensional defect that permeates all dyadic windows, proving that any successful approximation must modify an unbounded number of coefficients.
- **Target Venues:** *Journal of Functional Analysis* or *Mathematische Zeitschrift*.
