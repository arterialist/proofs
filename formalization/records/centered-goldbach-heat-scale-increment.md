# Centered Goldbach Heat Scale Increment and Even Packet Compensation

**Authors:** Arterialist Formalization Team  
**Date:** September 2026  
**Lean 4 Version:** 4.24.0  
**Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7` from `lake-manifest.json`
**Target Module:** `BuildingBlocks.CenteredGoldbachEvenCompensationFinite`, `BuildingBlocks.CenteredGoldbachFiniteAlgebra`, `BuildingBlocks.CenteredGoldbachAdjacentTotalsFinite`, `BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite`  
**Foundational Axioms:** Standard Lean 4 foundations (`[propext, Classical.choice, Quot.sound]`), zero custom axioms, zero `sorry` placeholders.

---

## 1. Mathematical Overview

In the additive analysis of prime distributions and the Goldbach problem, the centered prime heat source on a truncated scale $Y \in \mathbb{N}$ and frequency scale $T \ge 0$ generates a non-negative $L^2$ shell energy:
$$
 \mathcal{E}(Y, T) := \int_{e^{-T}}^1 \left( \sum_{n \le Y} \Lambda(n) e^{-nt} - \int_1^Y e^{-xt}\,dx \right)^2 dt \ge 0.
$$
Expanding this quadratic shell into its additive frequency components across total sums $N = a + b \in [2, 2Y]$ partitions the total increment into even and odd components:
$$
 \Delta \mathcal{E}(Y, T) = \Delta \mathcal{E}_{\mathrm{even}}(Y, T) + \Delta \mathcal{E}_{\mathrm{odd}}(Y, T).
$$
On the odd sector $N \in [2, Y+1]$, primes $a, b$ cannot sum to an odd number unless one of them is the even prime $2$. Consequently, the odd interior coefficient is dominated by the density and single-prime terms, producing an explicit **interior odd deficit**:
$$
 \operatorname{oddInteriorDeficit}(Y, T) := \sum_{\substack{N \in [2, Y+1] \\ N \text{ odd}}} \left[ 2\psi(N-1) - (N-1) - \mathcal{G}_{\mathrm{prime}}(N-2) \right] K_T(N),
$$
where $K_T(N) = \frac{1 - e^{-NT}}{N}$.
Because the complete shell energy is unconditionally nonnegative ($\mathcal{E}(Y, T) \ge 0$), the even Goldbach packet must energetically compensate for the odd deficit:
$$
 \operatorname{oddInteriorDeficit}(Y, T) - \operatorname{oddTransitionPacket}(Y, T) \le \Delta \mathcal{E}_{\mathrm{even}}(Y, T).
$$
Decomposing the even increment into prime-prime pairs $\mathcal{G}_{\mathrm{even}}$, left/right density marginals, and continuous pair counts yields the exact arithmetic lower bound:
$$
 \mathcal{G}_{\mathrm{even}}(Y, T) \ge \operatorname{evenLeftMarginal} + \operatorname{evenRightMarginal} - \operatorname{evenPairCount} + \operatorname{oddInteriorDeficit} - \operatorname{oddTransition}.
$$
Furthermore, on the discrete level, second differences $\nabla^2 B(N) = B(N) - 2B(N-1) + B(N-2)$ satisfy the two-terminal finite Abel identity:
$$
 \sum_{N=2}^X \nabla^2 B(N) z^N = (1-z)^2 \sum_{N=2}^{X-2} B(N) z^N + (1-z) B(X-1) z^{X-1} + (B(X) - B(X-1)) z^X.
$$

---

## 2. Formalization Details and Verified Signatures

### 2.1 Two-Terminal Finite Abel Identities (`CenteredGoldbachFiniteAlgebra.lean`)

```lean
/-- Prefix telescope for the second difference, retaining its lower endpoint. -/
theorem secondDifference_prefix (B : ℕ → 𝕜) (X : ℕ) (hX : 2 ≤ X) :
    ∑ N ∈ Icc 2 X, secondDifference B N =
      firstDifference B X - firstDifference B 1

/-- Finite Abel identity with both terminal terms. -/
theorem two_terminal_finite_abel (B : ℕ → 𝕜) (hB0 : B 0 = 0) (hB1 : B 1 = 0)
    (X : ℕ) (hX : 2 ≤ X) (z : 𝕜) :
    ∑ N ∈ Icc 2 X, secondDifference B N * z ^ N =
      (1 - z) ^ 2 * ∑ N ∈ Icc 2 (X - 2), B N * z ^ N +
      (1 - 2 * z) * B (X - 1) * z ^ (X - 1) + B X * z ^ X

/-- Equivalent endpoint form using the exact prefix `C_X = B_X - B_{X-1}`. -/
theorem two_terminal_finite_abel_prefix (B : ℕ → 𝕜)
    (hB0 : B 0 = 0) (hB1 : B 1 = 0) (X : ℕ) (hX : 2 ≤ X) (z : 𝕜) :
    ∑ N ∈ Icc 2 X, secondDifference B N * z ^ N =
      (1 - z) ^ 2 * ∑ N ∈ Icc 2 (X - 2), B N * z ^ N +
      (1 - z) * B (X - 1) * z ^ (X - 1) +
      (B X - B (X - 1)) * z ^ X

/-- Discrete energy summation by parts retaining both endpoints. -/
theorem discrete_energy_summation_by_parts (d c : ℕ → ℝ)
    (hc : ∀ N, 2 ≤ N → c N = d N - d (N - 1))
    (X : ℕ) (hX : 2 ≤ X) :
    ∑ N ∈ Icc 2 X, (c N) ^ 2 =
      c X * d X - c 2 * d 1 -
        ∑ N ∈ Icc 2 (X - 1), d N * (c (N + 1) - c N)
```

### 2.2 Even Compensation and Arithmetic Lower Bound (`CenteredGoldbachEvenCompensationFinite.lean`)

```lean
/-- Positivity of the finite heat shell. -/
theorem finiteShell_nonneg (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    0 ≤ finiteHeatScaleIncrement Y T

/-- Every finite positive heat shell forces the even centered packet to
pay the odd interior deficit after the odd transition packet is retained. -/
theorem evenPacket_compensates_odd (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    oddInteriorDeficit Y T - oddTransitionPacket Y T ≤ evenScaleIncrement Y T

/-- Exact arithmetic lower bound for the weighted even prime-prime Goldbach packet. -/
theorem evenPrimePacket_lower (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    evenLeftMarginalPacket Y T + evenRightMarginalPacket Y T -
        evenPairCountPacket Y T + oddInteriorDeficit Y T -
        oddTransitionPacket Y T ≤ evenPrimePacket Y T
```

---

## 3. Axiomatic Foundations and Verification

Verification performed via `lake env lean` in the proofs repository:
```bash
~/.elan/bin/lake env lean formalization/BuildingBlocks/CenteredGoldbachEvenCompensationFinite.lean
```
Axiom check output:
```
'BuildingBlocks.CenteredGoldbachEvenCompensationFinite.evenPacket_compensates_odd' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredGoldbachEvenCompensationFinite.evenPrimePacket_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredGoldbachFiniteAlgebra.two_terminal_finite_abel_prefix' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredGoldbachFiniteAlgebra.discrete_energy_summation_by_parts' depends on axioms: [propext, Classical.choice, Quot.sound]
```
The proofs are completely constructive up to Lean's standard classical foundations. No external axioms or unproven hypotheses are introduced.

---

## 4. Comparison with Formalized Literature

1. **Mathlib:** Mathlib's number theory library contains definitions of the prime counting function and some basic Chebyshev bounds, but has zero formalization of Goldbach convolution sums, heat scale increments, odd interior deficits, or two-terminal finite Abel second-difference identities.
2. **AFP / Coq:** The Archive of Formal Proofs contains formalizations of Dirichlet's theorem and the Prime Number Theorem (Eberl 2019), but no formal treatments of finite centered heat kernels or Goldbach packet compensation inequalities.
3. **Novelty:** This is a machine-checked formalization of the exact finite shell energy nonnegativity forcing the even Goldbach packet to bound the odd prime-density deficit.
