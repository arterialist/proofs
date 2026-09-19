# Contribution 69: Causal Source Convolution Distinct-Prime and Density Decomposition

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSourceDistinctFilter.lean`](../../formalization/BuildingBlocks/PrimeSourceDistinctFilter.lean)  
**Classification:** Analytic Number Theory / Causal Convolution / Diagonal-Off-Diagonal Decomposition / Prime Fluctuations

---

## 1. Executive Summary and Mathematical Statement

In the spectral and energy formulation of the Riemann Hypothesis, the cumulative arithmetic source $S(v)$ is given by the sum of causal prime birth blocks minus the continuous background density $D(v) = e^{v/2}$. The quadratic energy of the source involves the self-convolution $(S * S)(v) = \int_0^v S(u) S(v-u) \, du$ tested against the exponential reflection filter $e^{-3(s-v)/2}$.

This contribution proves:

1. **Filtered Source-Tau Residual Decomposition Theorem:**  
   For every age $s \ge 0$, the difference between the full filtered source self-convolution and the calibrated diagonal prime energy $\tau(s)$ decomposes identically into:
   $$
   \mathcal{L}_0(S * S)(s) - \tau(s) = \mathcal{L}_0(\mathrm{distinct})(s) - \mathcal{L}_0(\mathrm{mixedLeft})(s) - \mathcal{L}_0(\mathrm{mixedRight})(s) + \mathcal{L}_0(D * D)(s),
   $$
   where $\mathcal{L}_0(F)(s) = \int_0^s e^{-3(s-v)/2} F(v) \, dv$.
2. **Identification of Constituents:**  
   - **Diagonal Energy:** $\tau(s) = \mathcal{L}_0(\mathrm{diagonal}_s)(s) = \sum_{p \le e^s} \mathcal{L}_0(B_p * B_p)(s)$ coincides with the calibrated singular self-interaction of prime power ladders.
   - **Distinct Prime Off-Diagonal Energy:**  
     $$
     \mathrm{distinct}(s, v) = \sum_{p \le e^s} \sum_{q \le e^s, q \ne p} (B_p * B_q)(v).
     $$
   - **Mixed Prime-Density Interactions:**  
     $$
     \mathrm{mixedLeft}(s, v) = \sum_{p \le e^s} (B_p * D)(v), \quad \mathrm{mixedRight}(s, v) = \sum_{p \le e^s} (D * B_p)(v).
     $$
   - **Continuous Background Density Self-Convolution:**  
     Has the exact closed form:
     $$
     (D * D)(s) = \int_0^s e^{u/2} e^{(s-u)/2} \, du = s e^{s/2}.
     $$
3. **Local $L^2$ Integrability of Causal Primordial Sources:**  
   Every constituent function $B_p$, $\mathrm{frozenSum}(s)$, $D$, and the complete source $S$ belongs to $L^2([0, s])$ for every compact interval $[0, s]$, ensuring unconditional convergence and linearity of the functional $\mathcal{L}_0$.
4. **Significance for RH:**  
   Isolates the singular diagonal $\tau(s)$ exactly, proving that all non-trivial prime cancellation in the quadratic energy arises exclusively from the off-diagonal distinct-prime sum $\mathcal{L}_0(\mathrm{distinct})$ balancing the linear density drift $\mathcal{L}_0(D * D)$ and mixed couplings.

---

## 2. Mathematical Proof

### 2.1. Causal Source Representation
On any compact interval $v \in [0, s]$, $S(v) = \sum_{p \le e^s} B_p(v) - D(v)$.
Expanding the bilinear convolution $(S * S)(v) = \int_0^v S(u) S(v-u) \, du$:
$$
(S * S)(v) = \left( \sum_{p \le e^s} B_p - D \right) * \left( \sum_{q \le e^s} B_q - D \right)(v).
$$
By bilinearity of convolution on compact intervals:
$$
(S * S)(v) = \sum_{p, q \le e^s} (B_p * B_q)(v) - \sum_{p \le e^s} (B_p * D)(v) - \sum_{q \le e^s} (D * B_q)(v) + (D * D)(v).
$$

### 2.2. Splitting of Prime Pairs
The double sum over primes splits into diagonal ($p = q$) and off-diagonal ($p \ne q$):
$$
\sum_{p, q \le e^s} (B_p * B_q)(v) = \sum_{p \le e^s} (B_p * B_p)(v) + \sum_{p \ne q \le e^s} (B_p * B_q)(v) = \mathrm{diagonal}(s, v) + \mathrm{distinct}(s, v).
$$
Subtracting the diagonal term:
$$
(S * S)(v) - \mathrm{diagonal}(s, v) = \mathrm{distinct}(s, v) - \mathrm{mixedLeft}(s, v) - \mathrm{mixedRight}(s, v) + (D * D)(v).
$$

### 2.3. Filter Action and Diagonal Identification
Applying the linear filter $\mathcal{L}_0$:
$$
\mathcal{L}_0((S * S) - \mathrm{diagonal})(s) = \mathcal{L}_0(\mathrm{distinct})(s) - \mathcal{L}_0(\mathrm{mixedLeft})(s) - \mathcal{L}_0(\mathrm{mixedRight})(s) + \mathcal{L}_0(D * D)(s).
$$
Theorem `filtered_diagonal_eq_tau` establishes that $\mathcal{L}_0(\mathrm{diagonal}_s)(s) = \tau(s)$, which yields the exact result.

### 2.4. Closed Form of Density Convolution
$$
(D * D)(s) = \int_0^s e^{u/2} e^{(s-u)/2} \, du = \int_0^s e^{s/2} \, du = s e^{s/2}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSourceDistinctFilter`):
```lean
theorem source_memLp (s : ℝ) :
    MemLp source 2 (volume.restrict (Set.Icc 0 s))

theorem filtered_conv_integrable {f g : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s))) :
    IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) * conv f g v) volume 0 s

theorem filtered_diagonal_eq_tau {s : ℝ} (hs : 0 ≤ s) :
    L0 (diagonal s) s = tau s

theorem filtered_source_distinct {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv source source) s - tau s =
      L0 (distinct s) s - L0 (mixedLeft s) s - L0 (mixedRight s) s +
        L0 (conv density density) s

theorem density_convolution {s : ℝ} (hs : 0 ≤ s) :
    conv density density s = s * Real.exp (s / 2)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Prime number theorem and RH equivalences study correlations between prime powers. The explicit time-domain causal convolution decomposition separating diagonal prime energy $\tau(s)$ from distinct prime interactions and continuous density had not been formalized in Lean 4.
- **Advancement:** Establishes the exact algebraic identity for filtered source convolution and proves local $L^2$ integrability of the complete causal prime field.
- **Target Venues:** *Journal of Functional Analysis* or *Ramanujan Journal*.
