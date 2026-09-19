# Unique Contribution 228: Exact Arithmetic Source Birth Work and Energy Increment Formula

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenBirthWork.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthWork.lean), [`building-blocks/charge/charge-frozen-birth-work.md`](../../building-blocks/charge/charge-frozen-birth-work.md)  
**Classification:** Analytic Number Theory / Mathematical Physics / Energy Dynamics / Prime Birth Work / Discrete Step Transitions / Hilbert Space Invariants

---

## 1. Executive Summary and Mathematical Statement

In the dynamics of arithmetic fluctuations, passing from scale $N$ to scale $N+1$ changes the continuous causal energy $\|\text{causalSource}(N)\|_{L^2}^2$. The variation is governed by the work done by the existing field on the newly injected prime birth perturbation:
\[
W(N) = \langle \text{causalSource}(N), \text{increment}(N) \rangle_{L^2} = \int_0^\infty \text{causalSource}(N, v) \text{increment}(N, v) \, dv.
\]
This contribution proves:

1. **Integrability and Support Decoupling:**  
   The cross-term $\text{causalSource}(N, v) \text{increment}(N, v)$ is integrable on $(0, \infty)$ and vanishes identically on the interior interval $(0, \log N]$.
2. **Exact Prime Birth Work Formula:**  
   For every integer $N \ge 2$, the work done by the causal source on the scale increment factors into the total accumulated Chebyshev error times the localized logarithmic spectral discrepancy:
   \[
   \int_0^\infty \text{causalSource}(N, v) \text{increment}(N, v) \, dv = (\psi(N) - N) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right).
   \]
3. **Exact Global Energy Increment Formula:**  
   The step-by-step variation in the physical $L^2((0, \infty))$ energy evaluates in closed form:
   \[
   \begin{aligned}
   \int_0^\infty (\text{causalSource}(N+1, v))^2 \, dv - \int_0^\infty (\text{causalSource}(N, v))^2 \, dv &= 2 (\psi(N) - N) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right) \\
   &\quad + 1 + \frac{N}{N+1} - 2N \log\left(1 + \frac{1}{N}\right) + \frac{(\Lambda(N+1) - 1)^2}{N+1}.
   \end{aligned}
   \]
4. **Conservation and Boundary Cancellation:**  
   Intermediate boundary terms generated at $v = \log(N+1)$ between the continuous background ramp and the terminal exponential tail cancel exactly, proving that arithmetic source energy evolves through discrete Markovian work transfers.

---

## 2. Mathematical Proof

### 2.1. Domain Splitting
Let $a = \log N$ and $b = \log(N+1)$. The domain $(0, \infty)$ is partitioned into $(0, a]$, $(a, b)$, and $(b, \infty)$.
On $(0, a]$, $\text{increment}(N, v) = 0$, so the integral on $(0, a]$ vanishes identically.

### 2.2. Ramp Work
On $(a, b)$, $\text{causalSource}(N, v) = (\psi(N) - N)e^{-v/2}$, while $\text{increment}(N, v) = -(e^v - N)e^{-v/2}$.
Their product is $-(\psi(N) - N)(1 - N e^{-v})$.
Integrating from $a$ to $b$:
\[
\int_a^b -(\psi(N) - N)(1 - N e^{-v}) \, dv = -(\psi(N) - N) \left( \log\left(1 + \frac{1}{N}\right) - \frac{1}{N+1} \right).
\]

### 2.3. Terminal Work
On $(b, \infty)$, both functions are in their exponential tails:
\[
\text{causalSource}(N, v) = (\psi(N) - N) e^{-v/2}, \quad \text{increment}(N, v) = (\Lambda(N+1) - 1) e^{-v/2}.
\]
Their product is $(\psi(N) - N)(\Lambda(N+1) - 1) e^{-v}$.
Integrating from $b$ to $\infty$:
\[
\int_b^\infty e^{-v} \, dv = e^{-b} = \frac{1}{N+1}.
\]
The terminal integral is therefore $(\psi(N) - N) \frac{\Lambda(N+1) - 1}{N+1}$.

### 2.4. Total Work and Energy Variation
Adding the ramp work and terminal work:
\[
(\psi(N) - N) \left( -\log\left(1 + \frac{1}{N}\right) + \frac{1}{N+1} + \frac{\Lambda(N+1)}{N+1} - \frac{1}{N+1} \right) = (\psi(N) - N) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right).
\]
The boundary term $\frac{1}{N+1}$ cancels identically.
Expanding $\|\text{causalSource}(N+1)\|_{L^2}^2 = \|\text{causalSource}(N) + \text{increment}(N)\|_{L^2}^2 = \|\text{causalSource}(N)\|_{L^2}^2 + 2\langle \text{causalSource}(N), \text{increment}(N) \rangle + \|\text{increment}(N)\|_{L^2}^2$ and substituting the ramp self-energy from Contribution 227 finishes the proof.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenBirthWork` in `formalization/BuildingBlocks/ChargeFrozenBirthWork.lean`):
```lean
theorem source_increment_integrable {N : ℕ} (hN : 2 ≤ N) :
    IntegrableOn (fun v => causalSource N v * increment N v) (Ioi (0 : ℝ))

theorem source_increment_ramp {N : ℕ} (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log (N : ℝ) < v) (hv1 : v < Real.log ((N + 1 : ℕ) : ℝ)) :
    causalSource N v * increment N v =
      -(psi N - (N : ℝ)) * (1 - (N : ℝ) * Real.exp (-v))

theorem source_increment_terminal {N : ℕ} (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log ((N + 1 : ℕ) : ℝ) < v) :
    causalSource N v * increment N v =
      (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v)

theorem source_increment_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), causalSource N v * increment N v) =
      (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) /
        ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ)))

theorem full_square_integral_increment {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (causalSource (N + 1) v)^2) -
      (∫ v in Ioi (0 : ℝ), (causalSource N v)^2) =
        2 * (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) /
          ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ))) +
        1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ)) +
          (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 / ((N + 1 : ℕ) : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Discrete energy methods in differential equations and stepwise variation formulas (Tenenbaum 2015, Iwaniec-Kowalski 2004). The exact closed-form evaluation of cross-work and energy increments for arithmetic source fields in Lean 4 is new.
- **Advancement:** Provides an exact closed-form recurrence for arithmetic energy without any asymptotic truncation error.
- **Target Venues:** *Journal of Number Theory* or *Journal of Mathematical Analysis and Applications*.
