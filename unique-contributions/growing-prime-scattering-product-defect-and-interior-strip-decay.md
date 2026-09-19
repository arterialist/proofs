# Unique Contribution 58: Growing Prime Scattering Product Defect and Interior Strip Decay

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/GrowingPrimeScatteringBounds.lean`](../../formalization/BuildingBlocks/GrowingPrimeScatteringBounds.lean), [`formalization/BuildingBlocks/PairedScatteringDefect.lean`](../../formalization/BuildingBlocks/PairedScatteringDefect.lean), [`formalization/BuildingBlocks/CompactLocalScatteringSigns.lean`](../../formalization/BuildingBlocks/CompactLocalScatteringSigns.lean)  
**Classification:** Analytic Number Theory / Scattering Theory / Critical Strip Geometry / Defect Estimates

---

## 1. Executive Summary and Mathematical Statement

In the scattering theory formulation of the Riemann zeta function, local scattering multipliers $M_p(z, M)$ associated with prime $p$ and history depth $M$ approximate the local Euler factor ratio across the critical line. Understanding the uniform convergence and product defect bounds of finite prime blocks across the interior of the critical strip $|\operatorname{Re}(z)| \le 1/2 - \delta$ ($\delta > 0$) is central to controlling regularized Fredholm determinants and scattering phase shifts.

This contribution establishes:

1. **Exact Paired Multiplier Tail Factorization:**  
   For any prime $p$ with history truncation $M$, the paired scattering multiplier $\operatorname{paired}(p, z, M) = M_p(z, M) M_p(-z, M)$ factorizes via exact tail defects:
   \[
   \operatorname{paired}(p, z, M) = (1 - \operatorname{tail}_p(z, M))(1 - \operatorname{tail}_p(-z, M)).
   \]
2. **Uniform Single-Prime Tail Decay in the Critical Strip:**  
   For any prime $p \ge P > 1$ and parameter $z \in \mathbb{C}$ satisfying $|\operatorname{Re}(z)| \le 1/2 - \delta$:
   \[
   \|\operatorname{defect}_p(z, M)\| \le P^{-M\delta} \left( 1 + \frac{1}{\delta \log P} \right).
   \]
   The tail decay is strictly geometric in the truncation level $M$, with rate governed by $P^{-\delta}$.
3. **Uniform Block Product Defect Bound:**  
   For any finite set $s$ of primes with $\min(s) \ge P > 1$, the total deviation of the finite prime block scattering product from unity satisfies:
   \[
   \left\| \left( \prod_{p \in s} \operatorname{paired}(p, z, M) \right) - 1 \right\| \le \exp\left( |s| (2B + B^2) \right) - 1,
   \]
   where $B = P^{-M\delta} \left( 1 + \frac{1}{\delta \log P} \right)$.
4. **Weighted Low-High Shell Splitting:**  
   Provides exact decomposition and comparison bounds for infinite weighted sums over prime blocks split into low and high index subsets (`actual_block_weighted_tsum_comparison`), proving that high-prime scattering tails can be controlled uniformly by tuning the history cutoff $M$ relative to $\delta$.

---

## 2. Mathematical Proof

### 2.1. Multiplier Tail Factorization
For parameter $r = 1/\sqrt{p}$ and phases $x = p^z$, $y = p^{-z}$ (so $xy = 1$):
The truncated multiplier is:
\[
M(r, x, y, M) = -r x + (1 - r^2) \sum_{j=0}^{M-1} (r y)^j.
\]
Summing the geometric series:
\[
(1 - r^2) \frac{1 - (r y)^M}{1 - r y} = \frac{1 - r^2}{1 - r y} - \frac{(1 - r^2)(r y)^M}{1 - r y}.
\]
Subtracting $r x$ and using $(1 - r x) - r x(1 - r y) = 1 - r^2$, this factors as:
\[
M(r, x, y, M) = \frac{1 - r x}{1 - r y} (1 - \operatorname{tail}(r, x, y, M)), \quad \text{where} \quad \operatorname{tail}(r, x, y, M) = \frac{(1 - r^2)(r y)^M}{1 - r x}.
\]
Multiplying by $M(r, y, x, M)$ cancels the rational prefactors $((1-rx)/(1-ry)) \cdot ((1-ry)/(1-rx)) = 1$, leaving:
\[
\operatorname{paired}(p, z, M) = (1 - \operatorname{tail}(r, x, y, M))(1 - \operatorname{tail}(r, y, x, M)).
\]

### 2.2. Critical Strip Norm Estimate
When $|\operatorname{Re}(z)| \le 1/2 - \delta$:
\[
\|r y\| = p^{-1/2} p^{-\operatorname{Re}(z)} \le p^{-\delta} \le P^{-\delta} < 1.
\]
The denominator satisfies $\|1 - r x\| \ge 1 - \|r x\| \ge 1 - P^{-\delta}$. Using the elementary convex inequality $1 - e^{-u} \ge u/(1+u)$ for $u = \delta \log P$:
\[
\frac{1}{1 - P^{-\delta}} = \frac{1}{1 - e^{-\delta \log P}} \le \frac{1 + \delta \log P}{\delta \log P}.
\]
Therefore, the tail norm is bounded by:
\[
B = P^{-M\delta} \frac{1 + \delta \log P}{\delta \log P}.
\]

### 2.3. Block Product Defect
For each prime $p \in s$:
\[
\|1 - \operatorname{paired}(p, z, M)\| \le 2B + B^2.
\]
Applying the general product estimate $\|\prod_{i \in s} (1 - d_i) - 1\| \le \exp(\sum \|d_i\|) - 1$:
\[
\left\| \prod_{p \in s} \operatorname{paired}(p, z, M) - 1 \right\| \le \exp\left( \sum_{p \in s} (2B + B^2) \right) - 1 = \exp\left( |s| (2B + B^2) \right) - 1.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.GrowingPrimeScatteringBounds`):
```lean
theorem actual_uniform_tail_bound (p : ℕ) (hp : 2 ≤ p) (P : ℝ)
    (hP : 1 < P) (hPp : P ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    ‖originalDefect (p : ℝ) z M‖ ≤
      Real.exp (-(M : ℝ) * (delta * Real.log P)) *
        ((1 + delta * Real.log P) / (delta * Real.log P))

theorem actual_uniform_block_comparison (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (P : ℝ) (hP : 1 < P)
    (hPs : ∀ p ∈ s, P ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    let B := Real.exp (-(M : ℝ) * (delta * Real.log P)) *
      ((1 + delta * Real.log P) / (delta * Real.log P))
    ‖(∏ p ∈ s, paired p z M) - 1‖ ≤
      Real.exp ((s.card : ℝ) * (2 * B + B ^ 2)) - 1
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Scattering matrices for the automorphic Laplacian on $\mathrm{SL}(2, \mathbb{Z}) \backslash \mathbb{H}$ involve Euler products $\zeta(2s)/\zeta(2s+1)$. Truncated scattering multipliers and their uniform block product bounds in the critical strip interior have not previously been formalized or proved in this setting.
- **Advancement:** Establishes explicit geometric decay $P^{-M\delta}$ and finite block product bounds verified in Lean 4.
- **Target Venues:** *Journal of Functional Analysis* or *Communications in Mathematical Physics*.
