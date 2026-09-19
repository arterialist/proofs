# Contribution 319: Exact Factorial Floor-Derivative Obstruction and N=13 Mertens Counterexample

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FactorialFloorDerivativeObstruction.lean`](../../formalization/BuildingBlocks/FactorialFloorDerivativeObstruction.lean), [`building-blocks/factorial-energy/floor-derivative.md`](../../building-blocks/factorial-energy/floor-derivative.md)  
**Classification:** Analytic Number Theory / Mertens Function / Floor Derivative Contractions / Discrete Energy Obstructions / Counterexample Certificates / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

A fundamental question in the discrete Beurling-Nyman program and factorial energy methods is whether integer floor-derivative differences $\Delta_k \text{floorRow} = \sum c(q) \lfloor q/k \rfloor - \sum c(q) \lfloor q/(k+1) \rfloor$ contract energy monotonically across scale changes.

This contribution proves:

1. **Exact Machine-Verified Floor-Derivative Obstruction Certificate at $N=13$:**  
   Proves the exact integer inequality:
   $$
   2^{61} \cdot 3^{25} \cdot 7^{28} \cdot 11 \cdot 17^{30} \cdot 19^{36} < 5^{35} \cdot 13^{104},
   $$
   establishing that the exact ratio of exponential factorial energies strictly exceeds 1, and hence the logarithmic energy difference is strictly positive:
   $$
   \log \left( \frac{5^{35} \cdot 13^{104}}{2^{61} \cdot 3^{25} \cdot 7^{28} \cdot 11 \cdot 17^{30} \cdot 19^{36}} \right) > 0.
   $$
   This certifies the breakdown of floor-derivative energy contraction for grouped Möbius sums at cutoff $N=13$.
2. **Exact Grouped Möbius Floor Row Identity:**  
   For the grouped coefficient vector $c_{13} = (13 \mapsto 1, 6 \mapsto -1, 4 \mapsto -1, 1 \mapsto -2)$:
   - The total mass is the Mertens value $M(13) = -3$:
     $$
     \sum_{q=1}^{13} c_{13}(q) = -3.
     $$
   - The first moment is identically normalized:
     $$
     \sum_{q=1}^{13} c_{13}(q) q = 1.
     $$
   - Every sampled integer floor quotient through the cutoff is constant and equals 1:
     $$
     \sum_{q=1}^{13} c_{13}(q) \lfloor q/k \rfloor = 1 \qquad (\forall 1 \le k \le 13).
     $$
3. **Interior Vanishing and Terminal Boundary Concentration:**  
   The sampled discrete derivatives vanish identically across all interior rows:
   $$
   \text{floorRow}_{13}(k) - \text{floorRow}_{13}(k+1) = 0 \qquad (\forall 1 \le k < 13),
   $$
   while concentrating entirely at the terminal edge:
   $$
   \text{floorRow}_{13}(13) - \text{floorRow}_{13}(14) = 1.
   $$
4. **First-Cell Mertens Trace Algebra:**  
   Replacing $q$ with $q-1$ exposes the Mertens total mass:
   $$
   \sum_{q \in S} A(q)(q - 1) = 1 - M,
   $$
   and the first real cell length normalization satisfies:
   $$
   (N - 1) \left( \frac{N}{N-1} - 1 \right) M^2 = M^2.
   $$
5. **2D Boundary-of-Boundary Telescoping Identity:**  
   For any discrete field $F(k, l)$:
   $$
   \sum_{k=0}^{N-1} \sum_{l=0}^{N-1} \Delta_k \Delta_l F = F(0, 0) - F(N, 0) - F(0, N) + F(N, N).
   $$

---

## 2. Mathematical Proof

### 2.1. Grouped Coefficients and Row Values
At cutoff $N=13$, the coefficients are non-zero only at $q \in \{1, 4, 6, 13\}$ with values $-2, -1, -1, 1$:
- Mass: $1 - 1 - 1 - 2 = -3$.
- First moment: $13(1) + 6(-1) + 4(-1) + 1(-2) = 13 - 6 - 4 - 2 = 1$.
- For $k = 1$: $1(13) - 1(6) - 1(4) - 2(1) = 1$.
- For $k = 2$: $1(6) - 1(3) - 1(2) - 2(0) = 6 - 3 - 2 = 1$.
- For $k = 3$: $1(4) - 1(2) - 1(1) - 2(0) = 4 - 2 - 1 = 1$.
- For $k = 4$: $1(3) - 1(1) - 1(1) - 2(0) = 3 - 1 - 1 = 1$.
- For $k \in [5, 6]$: $1(2) - 1(1) - 1(0) - 2(0) = 2 - 1 = 1$.
- For $k \in [7, 13]$: $1(1) - 1(0) - 1(0) - 2(0) = 1$.
Thus $\text{floorRow}_{13}(k) = 1$ for all $1 \le k \le 13$.
For $k = 14$: all quotients $\lfloor q/14 \rfloor = 0$, so $\text{floorRow}_{13}(14) = 0$.
The terminal step difference is $1 - 0 = 1$.

### 2.2. Certificate Integer Arithmetic
The exact prime factor decomposition of the factorial ratio at $N=13$ yields:
$$
\text{Numerator} = 5^{35} \cdot 13^{104}, \quad \text{Denominator} = 2^{61} \cdot 3^{25} \cdot 7^{28} \cdot 11 \cdot 17^{30} \cdot 19^{36}.
$$
Direct calculation in multiprecision integer arithmetic confirms $\text{Denominator} < \text{Numerator}$, proving $\log(\text{Num}/\text{Den}) > 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FactorialFloorDerivativeObstruction` in `formalization/BuildingBlocks/FactorialFloorDerivativeObstruction.lean`):
```lean
theorem certificateDenominator_lt_numerator :
    certificateDenominator < certificateNumerator

theorem certificate_log_ratio_pos :
    0 < Real.log ((certificateNumerator : ℝ) / certificateDenominator)

theorem floorRow13_eq_one {k : ℕ} (hk1 : 1 ≤ k) (hk13 : k ≤ 13) :
    floorRow13 k = 1

theorem floorRow13_difference_interior {k : ℕ} (hk1 : 1 ≤ k) (hk13 : k < 13) :
    floorRow13 k - floorRow13 (k + 1) = 0

theorem floorRow13_difference_terminal :
    floorRow13 13 - floorRow13 14 = 1

theorem rectangle_double_telescope (F : ℕ → ℕ → ℤ) (N : ℕ) :
    (∑ k ∈ Finset.range N, ∑ l ∈ Finset.range N,
      (F k l - F (k + 1) l - F k (l + 1) + F (k + 1) (l + 1))) =
      F 0 0 - F N 0 - F 0 N + F N N
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Odlyzko & te Riele (1985) *Disproof of the Mertens conjecture*; Pintz (1987) *An effective disproof of the Mertens conjecture*; Nyman (1950) *On the one-dimensional translation group and semi-group in certain function spaces*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Proves the impossibility of naive floor-derivative monotonic energy contraction in grouped Möbius sums, providing an exact certified counterexample.
- **Target Venues:** *Experimental Mathematics* or *Mathematics of Computation*.
