# Unique Contribution 300: Exact Factorial Binary Infinite Energy Recurrence and Cauchy Majorant

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FactorialBinaryIntegrability.lean`](../../formalization/BuildingBlocks/FactorialBinaryIntegrability.lean), [`building-blocks/factorial-binary/integrability.md`](../../building-blocks/factorial-binary/integrability.md)  
**Classification:** Arithmetic Dynamical Systems / Dyadic Carry Renewal / Improper Lebesgue Integrability / Energy-Work-Dissipation Balance / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the dyadic dynamical theory of Legendre carry chains for factorial arithmetic, the evolution of response functions under binary digit appending $N \mapsto 2N + b$ ($b \in \{0, 1\}$) governs the total arithmetic carry energy across the infinite time horizon $\mathbb{R}^+ = (0, \infty)$. While pointwise identities hold at each time $u > 0$, establishing the global conservation and renewal law requires proving uniform improper integrability on $(0, \infty)$ and dilation invariance.

This contribution proves:

1. **Exact Infinite-Horizon Dyadic Energy Balance:**  
   For all integers $N \ge 0$ and binary digits $b \in \{0, 1\}$, the total integrated carry energy $\mathcal{E}(N) = \int_0^\infty \text{energyRow}(N, u) du$ satisfies the exact renewal recurrence:
   \[
   \mathcal{E}(2N + b) - 2\mathcal{E}(N) = \mathcal{W}(N, b) - \mathcal{D}(N),
   \]
   where $\mathcal{D}(N) = \int_0^\infty \text{densityRow}(N, u) du$ is the integrated boundary dissipation and $\mathcal{W}(N, b) = \int_0^\infty \text{workRow}(N, b, u) du$ is the integrated innovation work.
2. **Global Cauchy Majorant for Carry Energy:**  
   For all $N \ge 1$ and $u > 0$:
   \[
   \text{energyRow}(N, u) \le \frac{2 (\text{sizeBudget}(N))^2}{1 + u^2},
   \]
   where $\text{sizeBudget}(N) = \sum_{n=1}^N |\mu(n)| (1 + \lfloor N/n \rfloor)$. Since $(1 + u^2)^{-1} \in L^1(0, \infty)$, this provides an unconditional integrable majorant.
3. **Improper Integrability of All Energy Functionals:**  
   The functionals $\text{energyRow}(N, \cdot)$, $\text{densityRow}(N, \cdot)$, and $\text{workRow}(N, b, \cdot)$ are all unconditionally Lebesgue-integrable on $(0, \infty)$.
4. **Scale Invariance of Half-Argument Integrals:**  
   Under the change of variable $u \mapsto u/2$:
   \[
   \int_0^\infty \frac{1}{2} \text{energyRow}(N, u/2) du = \int_0^\infty \text{energyRow}(N, u) du = \mathcal{E}(N).
   \]
5. **Integrated Innovation Work Representation in Original Clock:**  
   The innovation work admits the canonical time representation:
   \[
   \mathcal{W}(N, b) = \int_0^\infty \left( 2 \text{response}(N, 2t) \text{innovation}(N, b, t) + \text{innovation}(N, b, t)^2 \right) w(t) dt.
   \]

---

## 2. Mathematical Proof

### 2.1. Two-Regime Response Bounds
For $t \ge 0$ and $q \ge 0$, the exponential increment satisfies $0 \le 1 - e^{-qt} \le \min(1, qt)$.
Summing over the Möbius support:
- Origin regime ($0 \le t \le 1$): $|\text{response}(N, t)| \le \sum_{n=1}^N |\mu(n)| \lfloor N/n \rfloor t \le \text{sizeBudget}(N) \cdot t$.
- Tail regime ($t \ge 1$): $|\text{response}(N, t)| \le \sum_{n=1}^N |\mu(n)| \cdot 1 \le \text{sizeBudget}(N)$.

### 2.2. Cauchy Majorization
The kernel weight satisfies $w(u) = (u(e^u - 1))^{-1} \le u^{-2}$.
Hence:
\[
\text{energyRow}(N, u) = \text{response}(N, u)^2 w(u) \le \frac{\text{response}(N, u)^2}{u^2}.
\]
- For $u \le 1$: $\text{energyRow}(N, u) \le (\text{sizeBudget}(N) u)^2 / u^2 = \text{sizeBudget}(N)^2 \le \frac{2 \text{sizeBudget}(N)^2}{1 + u^2}$.
- For $u \ge 1$: $\text{energyRow}(N, u) \le \text{sizeBudget}(N)^2 / u^2 \le \frac{2 \text{sizeBudget}(N)^2}{1 + u^2}$ (since $1 + u^2 \le 2u^2$).
Thus $\text{energyRow}(N, u) \le 2 (\text{sizeBudget}(N))^2 (1 + u^2)^{-1}$ everywhere on $(0, \infty)$.
Because $\int_0^\infty (1 + u^2)^{-1} du = \pi/2 < \infty$, the energy row is integrable.

### 2.3. Boundary Dissipation and Work Integrability
Since $\text{density}(u) \le 2 w(u)$, we have $\text{densityRow}(N, u) \le 2 \text{energyRow}(N, u)$, guaranteeing integrability of $\mathcal{D}(N)$.
The pointwise identity $\text{workRow}(N, b, u) = \frac{1}{2} \text{energyRow}(2N+b, u/2) - 2\text{energyRow}(N, u) + \text{densityRow}(N, u)$ expresses $\text{workRow}$ as a linear combination of integrable terms.
Integrating across $(0, \infty)$ and applying the dilation identity yields the dyadic renewal law.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FactorialBinaryIntegrability` in `formalization/BuildingBlocks/FactorialBinaryIntegrability.lean`):
```lean
theorem energyRow_majorant (N : ℕ) (u : ℝ) (hu : 0 < u) :
    energyRow N u ≤ 2 * sizeBudget N ^ 2 * (1 + u ^ 2)⁻¹

theorem energyRow_integrable (N : ℕ) : IntegrableOn (energyRow N) (Ioi 0)

theorem densityRow_integrable (N : ℕ) : IntegrableOn (densityRow N) (Ioi 0)

theorem workRow_integrable (N b : ℕ) (hb : b ≤ 1) :
    IntegrableOn (workRow N b) (Ioi 0)

theorem scaled_energy_integral (N : ℕ) :
    (∫ u in Ioi 0, energyRow N (u / 2) / 2) = integratedEnergy N

theorem binary_energy_infinite (N b : ℕ) (hb : b ≤ 1) :
    integratedEnergy (2 * N + b) - 2 * integratedEnergy N =
      integratedWork N b - integratedDensity N

theorem integratedWork_original_clock (N b : ℕ) :
    integratedWork N b = ∫ t in Ioi 0,
      (2 * response N (2 * t) * innovation N b t + innovation N b t ^ 2) * weight t
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Legendre carry formulas (1808); Kummer's theorem (1852); Knuth's carry analysis (1973); Diaconis and Fulman (2009) *Carries, Shuffling, and Symmetric Functions*. Machine verification of the improper continuous carry energy integral, global Cauchy majorant, and infinite dyadic renewal recurrence in Lean 4 is new.
- **Advancement:** Establishes the exact continuous-time energy-dissipation-work identity for dyadic factorial carries across the entire infinite horizon $(0, \infty)$, providing an exact foundation for non-perturbative carry estimates.
- **Target Venues:** *Ergodic Theory and Dynamical Systems* or *Advances in Applied Mathematics*.
