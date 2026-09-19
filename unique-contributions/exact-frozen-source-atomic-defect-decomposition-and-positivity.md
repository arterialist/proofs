# Unique Contribution 113: Exact Frozen-Source Atomic Defect Decomposition and Positivity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenSource.lean`](../../formalization/BuildingBlocks/ChargeFrozenSource.lean), [`formalization/BuildingBlocks/ChargeOriginalBirth.lean`](../../formalization/BuildingBlocks/ChargeOriginalBirth.lean), [`formalization/BuildingBlocks/ChargeBirthSummability.lean`](../../formalization/BuildingBlocks/ChargeBirthSummability.lean)  
**Classification:** Analytic Number Theory / Transfer Operators / Chebyshev Error Dynamics / Successor Charge Defects / Definite Defect Positivity

---

## 1. Executive Summary and Mathematical Statement

The frozen prime-error source at integer cutoff $N \ge 2$ on the logarithmic half-line $v \in (0, \infty)$ is defined by:
\[
S_N(v) = e^{-v/2} \left( \psi(\lfloor \min(e^v, N) \rfloor) - \min(e^v, N) \right).
\]
Its causal extension sets $S_N(v) = 0$ for $v < 0$ and satisfies the exact initial value $S_N(0) = -1$.

This contribution proves:

1. **Exact Atomic Decomposition with Terminal Tail:**  
   For every $v > 0$, the source decomposes into prime-power step atoms, a continuous background growth mode, and a non-negative terminal tail:
   \[
   S_N(v) = \sum_{n=2}^N \Lambda(n) \beta_n(v) - e^{v/2} + \text{tail}_N(v),
   \]
   where $\beta_n(v) = \mathbf{1}_{n \le e^v} e^{-v/2}$ and $\text{tail}_N(v) = \mathbf{1}_{e^v > N} (e^v - N) e^{-v/2} \ge 0$.
2. **Defect Decoupling of the Growth Mode:**  
   Because $\text{defect}(e^{v/2}) = 0$ identically under the successor transfer operator (Contribution 111), the background growth mode completely drops out of the defect functional:
   \[
   \text{defect}(S_N) = \sum_{n=2}^N \Lambda(n) \text{defect}(\beta_n) + \text{defect}(\text{tail}_N).
   \]
3. **Exact Closed Arithmetic Atom Defect:**  
   For each integer atom $n \ge 2$, $\text{defect}(\beta_n) = \text{correction}(n)$, yielding the exact defect expansion:
   \[
   \text{defect}(S_N) = \sum_{n=2}^N \Lambda(n) \text{correction}(n) + \text{defect}(\text{tail}_N).
   \]
4. **Unconditional Definite Defect Positivity:**  
   Since each atomic correction satisfies $\text{correction}(n) \ge 0$, $\Lambda(n) \ge 0$, and the kernel-tail product satisfies $\text{kernel}(v) \cdot \text{tail}_N(v) \ge 0$ pointwise on $(0, \infty)$, the initial charge defect is unconditionally non-negative:
   \[
   \text{defect}(S_N) \ge 0.
   \]

---

## 2. Mathematical Proof

### 2.1. Pointwise Decomposition
For $v > 0$, let $x = e^v$. If $x \le N$, then $\min(x, N) = x$, $\lfloor x \rfloor \le N$, and:
\[
\psi(\lfloor x \rfloor) = \sum_{n=2}^N \Lambda(n) \mathbf{1}_{n \le x}.
\]
Multiplying by $e^{-v/2}$ gives $\sum_{n=2}^N \Lambda(n) \beta_n(v) - x e^{-v/2} = \sum_{n=2}^N \Lambda(n) \beta_n(v) - e^{v/2}$.
If $x > N$, then $\min(x, N) = N$, $\lfloor \min(x, N) \rfloor = N$, and $\psi(N) = \sum_{n=2}^N \Lambda(n) = \sum_{n=2}^N \Lambda(n) \beta_n(v) e^{v/2}$ (since $n \le N < x$).
Then:
\[
e^{-v/2} (\psi(N) - N) = \sum_{n=2}^N \Lambda(n) \beta_n(v) - e^{v/2} + (x - N) e^{-v/2}.
\]
Setting $\text{tail}_N(v) = (e^v - N) e^{-v/2} \ge 0$ for $e^v > N$ verifies the decomposition.

### 2.2. Defect Linearity and Growth Vanishing
By definition, $\text{defect}(f) = \frac{1}{2} \int_0^\infty \text{kernel}(v) f(v) dv$.
Using $\text{defect}(e^{v/2}) = 0$ (proved in `ChargeDensityEvaluation.original_defect_growth`):
\[
\text{defect}(S_N) = \sum_{n=2}^N \Lambda(n) \text{defect}(\beta_n) - 0 + \text{defect}(\text{tail}_N).
\]
Substituting $\text{defect}(\beta_n) = \text{correction}(n)$ yields the exact sum.

### 2.3. Positivity
For $v > \log N \ge \log 2$, $e^{-v} < 1/2$, so $\text{kernel}(v) = \frac{1}{\sqrt{1 - e^{-v}}} - 1 > 0$.
Since $\text{tail}_N(v) \ge 0$ for $v > \log N$ and vanishes for $v \le \log N$, the integrand $\text{kernel}(v) \text{tail}_N(v) \ge 0$ everywhere on $(0, \infty)$, so $\text{defect}(\text{tail}_N) \ge 0$.
Combined with $\Lambda(n) \ge 0$ and $\text{correction}(n) \ge 0$, every term is non-negative, proving $\text{defect}(S_N) \ge 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenSource`):
```lean
theorem source_decomposition {N : ℕ} (hN : 2 ≤ N) {v : ℝ} (_hv : 0 < v) :
    source N v = (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) -
      Real.exp (v / 2) + tail N v

theorem kernel_tail_integrable (N : ℕ) :
    IntegrableOn (fun v => kernel v * tail N v) (Ioi (0 : ℝ))

theorem kernel_tail_nonnegative {N : ℕ} (hN : 2 ≤ N) (v : ℝ) :
    0 ≤ kernel v * tail N v

theorem original_defect_source {N : ℕ} (hN : 2 ≤ N) :
    defect (source N) =
      (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * ChargeBirthSummability.correction n) +
        defect (tail N)

theorem original_defect_source_nonnegative {N : ℕ} (hN : 2 ≤ N) :
    0 ≤ defect (source N)

theorem causalSource_at_origin {N : ℕ} (hN : 2 ≤ N) : causalSource N 0 = -1

theorem original_defect_causalSource_nonnegative {N : ℕ} (hN : 2 ≤ N) :
    0 ≤ defect (causalSource N)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Prime counting functions and explicit formulas (Riemann 1859, Montgomery-Vaughan 2007). The dynamical formulation of the Chebyshev step error $\psi(\lfloor e^v \rfloor) - e^v$ as an exact atomic sum plus positive tail under the successor charge transfer operator with unconditionally positive defect $\text{defect}(S_N) \ge 0$ is novel.
- **Advancement:** Establishes machine-verified atomic decomposition and unconditional non-negativity of the frozen Chebyshev error charge defect.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Functional Analysis*.
