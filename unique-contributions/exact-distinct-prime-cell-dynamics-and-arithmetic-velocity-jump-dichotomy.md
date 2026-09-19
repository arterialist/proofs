# Unique Contribution 284: Exact Distinct-Prime Cell Dynamics and Arithmetic Velocity Jump Dichotomy

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/DistinctPrimeDynamics.lean`](../../formalization/BuildingBlocks/DistinctPrimeDynamics.lean), [`building-blocks/distinct-primes/dynamics.md`](../../building-blocks/distinct-primes/dynamics.md)  
**Classification:** Analytic Number Theory / Continuous Embedding / Dynamical Systems / Geometric Shock Waves / Prime Powers / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the geometric analysis of prime pair distributions, one constructs continuous piece-wise differentiable trajectory cells $\text{cell}(N, x)$ compensating both the discrete atom at $x = 1$ and the continuous Lebesgue background on $[1, \infty)$. 

This contribution proves:

1. **Exact Discrete Arithmetic Endpoint Readout:**  
   The continuous trajectory evaluated at the integer boundary $x = N$ precisely reproduces the discrete arithmetic coprime pair area:
   \[
   \text{cell}(N, N) = \text{distinctPrimeArea}(N).
   \]
2. **$C^0$ Continuous Interface Gluing:**  
   Adjacent cell formulas meet continuously at every integer boundary $x = N + 1$:
   \[
   \text{cell}(N+1, N+1) = \text{cell}(N, N+1),
   \]
   proving that the global composite trajectory $x \mapsto \text{cell}(\lfloor x \rfloor, x)$ is everywhere continuous on $[1, \infty)$.
3. **Arithmetic Velocity Jump Dichotomy:**  
   At integer interfaces $x = N + 1$, the first derivative undergoes an exact jump impulse:
   \[
   \Delta \text{slope}(N+1) = \text{slope}_{N+1}(N+1) - \text{slope}_N(N+1) = w_{\text{distinct}}(N+1) - 2 \Lambda(N+1).
   \]
   This establishes a sharp dichotomy between prime powers and composites:
   - **Prime Powers ($N+1 = p^k$):** The distinct prime weight vanishes identically ($w_{\text{distinct}}(p^k) = 0$), producing a strictly negative deceleration impulse:
     \[
     \Delta \text{slope}(p^k) = -2 \log p < 0.
     \]
   - **Composites with $\ge 2$ Distinct Prime Factors:** The von Mangoldt function vanishes identically ($\Lambda(N+1) = 0$), producing a strictly non-negative acceleration impulse:
     \[
     \Delta \text{slope}(N+1) = w_{\text{distinct}}(N+1) \ge 0.
     \]
4. **Second-Derivative Curvature Defect:**  
   The jump in the second derivative (curvature) is purely localized at prime powers:
   \[
   \Delta \text{curvature}(N+1) = -\frac{2\Lambda(N+1)}{N+1}.
   \]
5. **Exact Compensating Initial Conditions:**  
   The initial cell and slope at $x = 1$ satisfy:
   \[
   \text{cell}(1, 1) = 0, \quad \text{slope}(1, 1) = 1,
   \]
   where the initial positive unit velocity $+1$ is directly provided by the compensating Dirac atom at the origin.

---

## 2. Mathematical Proof

### 2.1. Trajectory Construction and Interface Continuity
The cell function is defined by:
\[
\text{cell}(N, x) = x P_N + M_N - x^2 \Lambda_N + \frac{1}{2} x^2 \log x + \frac{1}{4} x^2 - \frac{1}{4},
\]
where $P_N = \sum_{n \le N} w_{\text{dist}}(n)$, $M_N = \sum_{n \le N} n(\Lambda(n) - w_{\text{dist}}(n))$, and $\Lambda_N = \sum_{n \le N} \Lambda(n)/n$.
Under the step $N \to N+1$:
\[
P_{N+1} - P_N = w_{\text{dist}}(N+1), \quad M_{N+1} - M_N = (N+1)(\Lambda(N+1) - w_{\text{dist}}(N+1)), \quad \Lambda_{N+1} - \Lambda_N = \frac{\Lambda(N+1)}{N+1}.
\]
Subtracting the two cells:
\[
\text{cell}(N+1, x) - \text{cell}(N, x) = (x - (N+1)) \left( w_{\text{dist}}(N+1) - (x + N + 1) \frac{\Lambda(N+1)}{N+1} \right).
\]
Setting $x = N+1$ gives $\text{cell}(N+1, N+1) - \text{cell}(N, N+1) = 0$, establishing interface continuity.

### 2.2. Slope Jump and Impulse Dichotomy
Differentiating with respect to $x$:
\[
\text{slope}(N, x) = P_N - 2 x \Lambda_N + x \log x + x.
\]
Evaluating the jump at $x = N+1$:
\[
\text{slope}_{N+1}(N+1) - \text{slope}_N(N+1) = (P_{N+1} - P_N) - 2(N+1)(\Lambda_{N+1} - \Lambda_N) = w_{\text{dist}}(N+1) - 2 \Lambda(N+1).
\]
At prime powers $N+1 = p^k$, any pair $a, b \ge 1$ with $ab = p^k$ has $a = p^i, b = p^{k-i}$, both powers of the same prime $p$. Thus no distinct prime pairs exist, so $w_{\text{dist}}(p^k) = 0$. Since $\Lambda(p^k) = \log p$, the jump simplifies to $-2 \log p < 0$.
For integers with at least two distinct prime factors, $\Lambda(n) = 0$, so the jump is $w_{\text{dist}}(n) \ge 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.DistinctPrimeDynamics` in `formalization/BuildingBlocks/DistinctPrimeDynamics.lean`):
```lean
theorem cell_at_integer (N : ℕ) : cell N N = distinctPrimeArea N

theorem cell_join (N : ℕ) : cell (N + 1) (N + 1 : ℕ) = cell N (N + 1 : ℕ)

theorem slope_jump (N : ℕ) :
    slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) =
      distinctPrimePairWeight (N + 1) -
        2 * ArithmeticFunction.vonMangoldt (N + 1)

theorem slope_jump_prime_pow {N p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k)
    (hN : N + 1 = p ^ k) :
    slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) = -2 * Real.log p

theorem slope_jump_prime_pow_neg {N p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k)
    (hN : N + 1 = p ^ k) :
    slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) < 0

theorem slope_jump_nonneg_of_not_prime_pow (N : ℕ)
    (hN : ¬IsPrimePow (N + 1)) :
    0 ≤ slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ)

theorem initial_cell_and_slope : cell 1 1 = 0 ∧ slope 1 1 = 1
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Continuous embeddings of arithmetic functions, Dirichlet divisor problems, and discrete shocks in arithmetic progressions (Iwaniec & Kowalski 2004). A continuous geometric cell embedding reproducing distinct prime pair areas with signed velocity jump dichotomies at integer interfaces in Lean 4 is new.
- **Advancement:** Unveils a physical dynamical mechanism where primes act as negative velocity impulses (deceleration shocks) while composite interactions act as positive velocity impulses, preserving continuous trajectories throughout.
- **Target Venues:** *Communications in Mathematical Physics* or *Nonlinearity*.
