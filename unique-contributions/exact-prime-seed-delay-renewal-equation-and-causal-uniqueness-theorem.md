# Unique Contribution 187: Exact Prime Seed Delay Renewal Equation and Causal Uniqueness Theorem

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedDelay.lean`](../../formalization/BuildingBlocks/PrimeSeedDelay.lean), [`building-blocks/primes/prime-seed-delay.md`](../../building-blocks/primes/prime-seed-delay.md)  
**Classification:** Delay Equations / Renewal Theory / Causal Dynamical Systems / Prime Successor Seeds / Unconditional Uniqueness

---

## 1. Executive Summary and Mathematical Statement

The prime successor seed $\text{seed}_L(v)$ governs the continuous memory evolution of prime-arrival renewal operators. In renewal theory, identifying the exact functional delay equation satisfied by the seed and establishing its unconditional uniqueness without growth assumptions is critical for structural identification.

This contribution proves:

1. **Clock Shift Scaling Law:**  
   For any clock $L > 0$ and any age $v \ge L$:
   \[
   \text{seed}_L(v + L) = e^{-L/2} \text{seed}_L(v).
   \]
2. **Exact Delay Renewal Equation:**  
   The full causal prime successor seed satisfies the exact inhomogeneous delay equation on the entire real line $\mathbb{R}$:
   \[
   \text{seed}_L(v) = \text{initialCell}_L(v) + e^{-L/2} \text{seed}_L(v - L),
   \]
   where $\text{initialCell}_L(v) = e^{v/2 - 2L} \mathbf{1}_{[L, 2L)}(v)$. The source is non-zero on the first interval $[L, 2L)$ and zero elsewhere.
3. **Exact $N$-Step Unrolled Delay Identity:**  
   For any inhomogeneous delay equation $f(v) = g(v) + r f(v - L)$ and any integer $N \in \mathbb{N}$:
   \[
   f(v) = \left( \sum_{j=0}^{N-1} r^j g(v - j L) \right) + r^N f(v - N L).
   \]
4. **Finite Complete-History Expansion:**  
   For any finite observation point $v < (N+1)L$, causality causes the terminal history term to vanish identically ($v - NL < L \implies \text{seed}_L(v - NL) = 0$), leaving:
   \[
   \text{seed}_L(v) = \sum_{j=0}^{N-1} e^{-j L / 2} \text{initialCell}_L(v - j L).
   \]
5. **Unconditional Causal Uniqueness Theorem:**  
   Let $f : \mathbb{R} \to \mathbb{R}$ be any causal function ($f(v) = 0$ for $v < L$) satisfying the delay renewal equation:
   \[
   f(v) = \text{initialCell}_L(v) + e^{-L/2} f(v - L) \quad \text{for all } v \in \mathbb{R}.
   \]
   Then $f$ is identically equal to $\text{seed}_L$:
   \[
   f \equiv \text{seed}_L.
   \]
   No growth bounds, square-integrability hypotheses, or Riemann Hypothesis assumptions are required.

---

## 2. Mathematical Proof

### 2.1. Delay Renewal Equation
If $v < L$, $v - L < 0 < L$, so $\text{seed}_L(v) = 0$, $\text{initialCell}_L(v) = 0$, and $\text{seed}_L(v - L) = 0$. Both sides vanish.
If $L \le v < 2L$, then $v - L < L$, so $\text{seed}_L(v - L) = 0$, and $\text{seed}_L(v) = \text{initialCell}_L(v) = \text{cellDensity}(L, 0, v)$. Both sides match.
If $v \ge 2L$, then $v - L \ge L$. Setting $w = v - L \ge L$, by `seed_add_clock`:
\[
\text{seed}_L(w + L) = e^{-L/2} \text{seed}_L(w) \implies \text{seed}_L(v) = e^{-L/2} \text{seed}_L(v - L).
\]
Since $v \ge 2L$, $\text{initialCell}_L(v) = 0$. The equation holds for all $v \in \mathbb{R}$.

### 2.2. Finite Unrolling and Unconditional Uniqueness
Let $N \in \mathbb{N}$ satisfy $N > v/L$. Then $v < NL < (N+1)L$.
Unrolling the delay equation $N$ times yields:
\[
f(v) = \sum_{j=0}^{N-1} (e^{-L/2})^j \text{initialCell}_L(v - jL) + (e^{-L/2})^N f(v - NL).
\]
Since $v < NL$, $v - NL < 0 < L$.
Because $f$ is causal, $f(v - NL) = 0$.
Thus the terminal term vanishes completely:
\[
f(v) = \sum_{j=0}^{N-1} (e^{-L/2})^j \text{initialCell}_L(v - jL).
\]
Applying the identical unrolling to $\text{seed}_L(v)$ yields the exact same finite sum.
Therefore $f(v) = \text{seed}_L(v)$ for every $v \in \mathbb{R}$, proving $f \equiv \text{seed}_L$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedDelay.lean`):
```lean
theorem seed_add_clock {L v : ℝ} (hL : 0 < L) (hv : L ≤ v) :
    seed L (v + L) = exp (-L / 2) * seed L v

theorem seed_delay_equation {L : ℝ} (hL : 0 < L) (v : ℝ) :
    seed L v = initialCell L v + exp (-L / 2) * seed L (v - L)

theorem iterate_delay {f g : ℝ → ℝ} {L r : ℝ}
    (h : ∀ v, f v = g v + r * f (v - L)) (N : ℕ) (v : ℝ) :
    f v = (∑ j ∈ Finset.range N, r ^ j * g (v - j * L)) +
      r ^ N * f (v - N * L)

theorem seed_finite_history {L v : ℝ} (hL : 0 < L) (N : ℕ)
    (hv : v < (N + 1 : ℝ) * L) :
    seed L v = ∑ j ∈ Finset.range N,
      exp (-L / 2) ^ j * initialCell L (v - j * L)

theorem seed_unique {L : ℝ} (hL : 0 < L) {f : ℝ → ℝ}
    (hzero : ∀ v < L, f v = 0)
    (hdelay : ∀ v, f v = initialCell L v + exp (-L / 2) * f (v - L)) :
    f = seed L
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Classical renewal equations (Feller 1968, Bellman-Cooke 1963) and delay differential/difference equations (Hale-Verduyn Lunel 1993). Formally proving the exact delay renewal equation and unconditional uniqueness for prime-successor memory seeds in Lean 4 is new.
- **Advancement:** Proves that the prime seed is the unique causal solution to its delay renewal equation without any growth or integrability assumptions in Lean 4.
- **Target Venues:** *Journal of Integral Equations and Applications* or *SIAM Journal on Mathematical Analysis*.
