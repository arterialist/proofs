# Contribution 45: Causal Prime Source Birth Step Energy Increment and Discrepancy Work Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenBirthWork.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthWork.lean), [`formalization/BuildingBlocks/ChargeFrozenBirthMetric.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthMetric.lean)  
**Classification:** Prime Number Theory / Operator Theory / Causal Dynamical Systems

---

## 1. Executive Summary and Mathematical Statement

In the time-domain formulation of the Riemann explicit formula, the causal prime source $a_N(v)$ represents the cumulative discrepancy between the Chebyshev step function $\psi(e^v)$ and the continuous Archimedean scale $e^v$, damped by the critical factor $e^{-v/2}$:
$$
a_N(v) = (\min(\psi(e^v), \psi(N)) - \min(e^v, N)) e^{-v/2}.
$$
As the cutoff increases from $N$ to $N+1$, the source experiences an arithmetic birth increment $\delta_N(v) = a_{N+1}(v) - a_N(v)$.

This contribution establishes the exact closed-form evaluation of the $L^2(0, \infty)$ energy change under each discrete arithmetic step:
$$
\int_0^\infty (a_{N+1}(v))^2 dv - \int_0^\infty (a_N(v))^2 dv = \Delta_{\mathrm{work}}(N) + \Delta_{\mathrm{ramp}}(N) + \Delta_{\mathrm{atom}}(N),
$$
where:
1. **The Discrepancy Cross-Work:**
   $$
   \Delta_{\mathrm{work}}(N) = 2(\psi(N) - N) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right)
   $$
   intertwining the accumulated Chebyshev error $\psi(N) - N$ with the elementary prime discrepancy increment $\frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right)$.
2. **The Geometric Ramp Energy:**
   $$
   \Delta_{\mathrm{ramp}}(N) = 1 + \frac{N}{N+1} - 2N \log\left(1 + \frac{1}{N}\right) = \int_{\log N}^{\log(N+1)} (e^v - N)^2 e^{-v} dv > 0.
   $$
3. **The Discrete Prime Atom Energy:**
   $$
   \Delta_{\mathrm{atom}}(N) = \frac{(\Lambda(N+1) - 1)^2}{N+1} = \int_{\log(N+1)}^\infty (\Lambda(N+1) - 1)^2 e^{-v} dv \ge 0.
   $$

---

## 2. Mathematical Proof and Structural Decomposition

### 2.1. Piecewise Anatomy of the Increment
For $v > 0$:
- **Dormant Horizon ($e^v \le N$):** Both $a_{N+1}(v)$ and $a_N(v)$ evaluate to $(\psi(e^v) - e^v)e^{-v/2}$, so $\delta_N(v) = 0$.
- **Ramp Transition ($N < e^v < N+1$):** Here $\lfloor e^v \rfloor = N$. Thus $\psi(e^v) = \psi(N)$, while the upper bound in $a_{N+1}$ allows $e^v$ to grow linearly:
  $$
  \delta_N(v) = -(e^v - N) e^{-v/2}.
  $$
- **Terminal Plateau ($e^v \ge N+1$):** Both sources freeze at their terminal values:
  $$
  \delta_N(v) = (\psi(N+1) - (N+1) - (\psi(N) - N)) e^{-v/2} = (\Lambda(N+1) - 1) e^{-v/2}.
  $$

### 2.2. Evaluation of the Cross-Work Integral
On $v \in (0, \log N)$, $\delta_N(v) = 0$.  
On $v \in (\log N, \log(N+1))$, $a_N(v) = (\psi(N) - N) e^{-v/2}$, so:
$$
\int_{\log N}^{\log(N+1)} a_N(v) \delta_N(v) dv = -(\psi(N) - N) \int_{\log N}^{\log(N+1)} (1 - N e^{-v}) dv = -(\psi(N) - N) \left( \log\frac{N+1}{N} - \frac{1}{N+1} \right).
$$
On $v \in (\log(N+1), \infty)$:
$$
\int_{\log(N+1)}^\infty a_N(v) \delta_N(v) dv = (\psi(N) - N)(\Lambda(N+1) - 1) \frac{1}{N+1}.
$$
Summing both contributions yields the exact identity:
$$
\int_0^\infty a_N(v) \delta_N(v) dv = (\psi(N) - N) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right).
$$

### 2.3. Closed-Form Evaluation of the Ramp Energy
Expanding $(e^v - N)^2 e^{-v} = e^v - 2N + N^2 e^{-v}$ and integrating on $[\log N, \log(N+1)]$:
$$
\int_{\log N}^{\log(N+1)} (e^v - 2N + N^2 e^{-v}) dv = (N+1 - N) - 2N \log\frac{N+1}{N} + N^2 \left(\frac{1}{N} - \frac{1}{N+1}\right)
$$
$$
= 1 - 2N \log\left(1 + \frac{1}{N}\right) + \frac{N}{N+1}.
$$

---

## 3. Machine Verification and Axiom Audit

All results are formally machine-checked in Lean 4.24.0:
```lean
theorem source_increment_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), causalSource N v * increment N v) =
      (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) /
        ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ)))

theorem ramp_square_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioo (Real.log (N : ℝ)) (Real.log ((N + 1 : ℕ) : ℝ)),
      (Real.exp v - (N : ℝ))^2 * Real.exp (-v)) =
        1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ))

theorem full_square_integral_increment {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (causalSource (N + 1) v)^2) -
      (∫ v in Ioi (0 : ℝ), (causalSource N v)^2) =
        2 * (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) /
          ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ))) +
        1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ)) +
          (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 / ((N + 1 : ℕ) : ℝ)
```
Axiom audit confirms dependence strictly on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior literature comparison:** Classical explicit-formula work studies prime-number-theorem discrepancy energies through asymptotic or smoothed formulations. This audit did not verify a prior occurrence of the exact discrete recurrence formalized here, but no exhaustive priority search is documented.
- **Advancement:** Establishes the exact microscopic energy law governing the time-domain causal prime process.
- **Target Venues:** *Advances in Applied Mathematics* or *Journal of Number Theory*.
