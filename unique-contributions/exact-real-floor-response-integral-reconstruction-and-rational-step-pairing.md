# Contribution 294: Exact Real-Floor Response Integral Reconstruction and Rational Step Pairing

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FactorialRealCellSteps.lean`](../../formalization/BuildingBlocks/FactorialRealCellSteps.lean), [`building-blocks/factorial-cells/real-steps.md`](../../building-blocks/factorial-cells/real-steps.md)  
**Classification:** Real Analysis / Harmonic Analysis / Factorial Cell Phases / Rational Step Functions / Möbius Renewal / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the dual phase theory of factorial cells, the total binary carry response $\text{response}(N, t)$ captures the non-local carry accumulation across all dyadic scales. Proving that this discrete carry response can be reconstructed as a continuous integral of real floor-indexed Möbius sums against the smooth inverse test phase $-\text{inverseTestPhase}(x, t)$ requires exact rational step-pairing identities.

This contribution proves:

1. **Exact Continuous Integral Reconstruction of Carry Response:**  
   For all $N \ge 1$ and all clock parameters $t > 0$:
   $$
   \int_1^N \left( \sum_{n=1}^N \mu(n) \left\lfloor \frac{\lfloor N/n \rfloor}{x} \right\rfloor \right) (-\text{inverseTestPhase}(x, t)) dx = \text{response}(N, t) - (1 - e^{-t}).
   $$
2. **Single Quotient Floor Harmonic Renewal Identity:**  
   For any integer $q \ge 1$, any $t > 0$, and any terminal cutoff $X \ge q$:
   $$
   \int_1^X \left\lfloor \frac{q}{x} \right\rfloor (-\text{inverseTestPhase}(x, t)) dx = \text{centeredTest}(t, q).
   $$
3. **Exact Counting of Rational Step Endpoints:**  
   For all real arguments $x \ge 1$ and integers $q \ge 1$:
   $$
   \left\lfloor \frac{q}{x} \right\rfloor = \sum_{k=1}^q \mathbf{1}_{x \le q/k}.
   $$
4. **Lebesgue Interval Integrability of Step Indicators:**  
   For every rational threshold $a \in \mathbb{R}$, the indicator $(-\text{inverseTestPhase}(x, t)) \mathbf{1}_{x \le a}$ is Lebesgue interval-integrable on $[1, X]$ unconditionally.
5. **Exact Double Sum Pairing:**  
   Interchanging summation and integration yields an exact representation of the real-floor response as a finite sum of moving inverse test evaluations at rational points $q/k$.

---

## 2. Mathematical Proof

### 2.1. Floor Function as a Sum of Indicators
For $x \ge 1$ and $q \ge 1$:
$$
x \le \frac{q}{k} \iff k x \le q \iff k \le \frac{q}{x} \iff k \le \lfloor q/x \rfloor.
$$
Therefore, the number of integers $k \in \{1, \dots, q\}$ satisfying $x \le q/k$ is precisely $\lfloor q/x \rfloor$:
$$
\lfloor q/x \rfloor = \sum_{k=1}^q \mathbf{1}_{x \le q/k}.
$$

### 2.2. Integration Against the Inverse Test Phase
Multiplying by $-\text{inverseTestPhase}(x, t)$ and integrating over $[1, X]$ with $X \ge q$:
$$
\int_1^X \lfloor q/x \rfloor (-\text{inverseTestPhase}(x, t)) dx = \sum_{k=1}^q \int_1^{q/k} (-\text{inverseTestPhase}(x, t)) dx.
$$
By the Fundamental Theorem of Calculus for the moving inverse test function (Unique Contribution 288):
$$
\int_1^{q/k} (-\text{inverseTestPhase}(x, t)) dx = \text{movingInverseTest}(t, q/k).
$$
Summing over $k \in \{1, \dots, q\}$:
$$
\sum_{k=1}^q \text{movingInverseTest}(t, q/k) = \text{centeredTest}(t, q).
$$

### 2.3. Möbius-Weighted Assembly
Multiplying by $\mu(n)$ and setting $q = \lfloor N/n \rfloor$:
$$
\int_1^N \left( \sum_{n=1}^N \mu(n) \left\lfloor \frac{\lfloor N/n \rfloor}{x} \right\rfloor \right) (-\text{inverseTestPhase}(x, t)) dx = \sum_{n=1}^N \mu(n) \text{centeredTest}(t, \lfloor N/n \rfloor).
$$
By the rational jump pairing theorem for factorial binary carries:
$$
\sum_{n=1}^N \mu(n) \text{centeredTest}(t, \lfloor N/n \rfloor) = \text{response}(N, t) - (1 - e^{-t}).
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FactorialRealCellPhase` in `formalization/BuildingBlocks/FactorialRealCellSteps.lean`):
```lean
theorem real_floor_step_sum (q : ℕ) {x : ℝ} (hx : 1 ≤ x) :
    (⌊(q : ℝ) / x⌋₊ : ℝ) =
      ∑ k ∈ Finset.Icc 1 q, if x ≤ (q : ℝ) / k then (1 : ℝ) else 0

theorem real_floor_inversePhase_integral (q : ℕ) {t X : ℝ} (ht : 0 < t)
    (hq : 0 < q) (hqX : (q : ℝ) ≤ X) :
    (∫ x in (1 : ℝ)..X, (⌊(q : ℝ) / x⌋₊ : ℝ) * (-inverseTestPhase x t)) = centeredTest t q

theorem actual_real_floor_response_integral (N : ℕ) {t : ℝ} (ht : 0 < t) (hN : 0 < N) :
    (∫ x in (1 : ℝ)..N,
      (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        (⌊((N / n : ℕ) : ℝ) / x⌋₊ : ℝ)) * (-inverseTestPhase x t)) =
      BuildingBlocks.FactorialBinaryCarry.response N t - (1 - exp (-t))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** De la Vallée Poussin (1896) step-integral methods; Vinogradov's method of fractional parts; Perron summation formulas. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes a rigorous analytical bridge converting discrete double-floor sums $\lfloor \lfloor N/n \rfloor / x \rfloor$ into continuous integrals of smooth test phases, eliminating discrete boundary jumps via exact rational step pairing.
- **Target Venues:** *Analysis & PDE* or *Expositiones Mathematicae*.
