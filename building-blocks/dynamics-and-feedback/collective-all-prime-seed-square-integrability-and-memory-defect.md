# Collective All-Prime Seed Square-Integrability and Transposed Memory Defect Representation

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean), [`formalization/BuildingBlocks/AllPrimeMemoryKernel.lean`](../../formalization/BuildingBlocks/AllPrimeMemoryKernel.lean), [`formalization/BuildingBlocks/MemoryChargeFubini.lean`](../../formalization/BuildingBlocks/MemoryChargeFubini.lean)
**Classification:** Analytic Number Theory / Operator Theory / Stochastic Processes / Volterra Kernels
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

Let $\operatorname{seed}(a, v) = e^{-v/2} \mathbf{1}_{v \ge a} (1 - e^{-(v-a)})$ denote the elementary birth seed of a prime jump $a = \log p$.
The collective all-prime seed:
$$
\operatorname{allPrimeSeed}(v) = \sum_{p} \operatorname{seed}(\log p, v)
$$
superimposes all prime birth seeds across the entire sequence of prime numbers.

This note records:

1. **Three-Scale Geometric Enclosure:**
   Decomposing primes into small ($p \le e^{v/3}$), middle ($e^{v/3} < p \le e^{v/2}$), and large ($p > e^{v/2}$) scales yields the sharp universal uniform bound:
   $$
   v \cdot \operatorname{allPrimeSeed}(v) \le 64 \log 2 + 30, \quad \text{for all } v \ge 3 \log 2.
   $$
2. **Unconditional $L^2$ Square-Integrability:**
   Squaring the tail gives $(\operatorname{allPrimeSeed}(v))^2 \le (64 \log 2 + 30) \frac{\operatorname{allPrimeSeed}(v)}{v}$.
   Because the total Lévy activity $\int_0^\infty \frac{\operatorname{allPrimeSeed}(v)}{v} dv < \infty$ is finite (as the underlying Lévy measure has finite mass), the collective all-prime seed is **unconditionally square-integrable on $\mathbb{R}$**:
   $$
   \operatorname{allPrimeSeed} \in L^2(\mathbb{R}, dv).
   $$
   Crucially, this holds **without assuming the Riemann Hypothesis, the Prime Number Theorem, or any zero-free region**.
3. **Transposed Integral Representation of Relative Charge Defect:**
   For any $f \in L^2(0, \infty)$, the relative charge defect of the causal memory operator admits an exact transposed integral representation:
   $$
   \operatorname{defect}(\operatorname{causalMemory}(\operatorname{allPrimeSeed}, f)) = \int_0^\infty \operatorname{memoryDefectKernel}(\operatorname{allPrimeSeed}, u) f(u) du,
   $$
   where $\operatorname{memoryDefectKernel}(F, u) = \frac{1}{2} \int_0^\infty \operatorname{kernel}(v) F(v - u) dv$.
4. **Commutator Identity on $L^2(0, \infty)$:**
   The commutator between the charge compensation operator $\operatorname{compensated}$ and the causal memory convolution $\operatorname{causalMemory}(\operatorname{allPrimeSeed}, \cdot)$ evaluates pointwise to the integral operator with explicit kernel:
   $$
   \operatorname{compensated}(\operatorname{causalMemory}(F, f))(v) - \operatorname{causalMemory}(F, \operatorname{compensated}(f))(v) = \int_0^\infty K_F(v, u) f(u) du.
   $$

---

## 2. Mathematical Proof and Dyadic Truncations

### 2.1. Scale Dissection
For a fixed age $v \ge 3\log 2$:
- **Small primes ($p \le e^{v/3}$):**
  The prime count is bounded by $\pi(e^{v/3}) \le e^{v/3}$. Each seed is bounded by $e^{-v/2}$.
  Sum $\le e^{v/3} e^{-v/2} = e^{-v/6}$.
- **Middle primes ($e^{v/3} < p \le e^{v/2}$):**
  The second envelope gives $\operatorname{seed}(\log p, v) \le e^{v/2} / p^3$.
  By the prime cube tail $\sum_{p > Z} 1/p^3 \le 4/Z^2$ at $Z = e^{v/3}$:
  $$
  e^{v/2} \sum_{p > e^{v/3}} \frac{1}{p^3} \le e^{v/2} \frac{4}{e^{2v/3}} = 4 e^{-v/6}.
  $$
- **Large primes ($p > e^{v/2}$):**
  The first envelope gives $\operatorname{seed}(\log p, v) \le e^{v/2} / p^2$.
  By Chebyshev's square tail at $Y = e^{v/2}$:
  $$
  \sum_{p > Y} \frac{1}{p^2} \le \frac{32 \log 2}{Y \log Y} \implies e^{v/2} \frac{32 \log 2}{e^{v/2} (v/2)} = \frac{64 \log 2}{v}.
  $$
Summing all three contributions gives $\operatorname{allPrimeSeed}(v) \le \frac{64 \log 2}{v} + 5 e^{-v/6}$, and multiplying by $v$ yields $v \cdot \operatorname{allPrimeSeed}(v) \le 64 \log 2 + 30$.

### 2.2. $L^2$ Majorant and Finite Activity
For $v \ge 3\log 2$, we have $(\operatorname{allPrimeSeed}(v))^2 \le (64 \log 2 + 30) \frac{\operatorname{allPrimeSeed}(v)}{v}$.
For $v < 3\log 2$, only primes with $\log p \le 3\log 2 \implies p \le 8$ can contribute, so the sum contains only $\{2, 3, 5, 7\}$, which is trivially in $L^2$.
Because $\int_0^\infty \frac{\operatorname{allPrimeSeed}(v)}{v} dv = \mu_{\mathrm{Levy}}(\mathbb{R}) < \infty$, the majorant is integrable, establishing that $\operatorname{allPrimeSeed} \in L^2(\mathbb{R}, dv)$.

---

## 3. Machine Verification and Axiom Audit

All theorems are formally machine-checked in Lean 4.24.0:
```lean
theorem allPrimeSeed_age_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    v * allPrimeSeed v ≤ 64 * log 2 + 30

theorem integrable_allPrimeSeed_square : Integrable (fun v => allPrimeSeed v ^ 2)

theorem allPrimeSeed_memLp_two : MemLp allPrimeSeed 2 volume

theorem allPrimeSeed_defect_causalMemory {f : ℝ → ℝ}
    (hmf : Measurable f) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    SuccessorCharge.defect (SuccessorCharge.causalMemory allPrimeSeed f) =
      ∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel allPrimeSeed u * f u

theorem allPrimeSeed_corrected_kernel_identity {f : ℝ → ℝ}
    (hmf : Measurable f) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.compensated (SuccessorCharge.causalMemory allPrimeSeed f) v -
      SuccessorCharge.causalMemory allPrimeSeed (SuccessorCharge.compensated f) v =
      ∫ u in Ioi (0 : ℝ), SuccessorCharge.correctedMemoryKernel allPrimeSeed v u * f u
```
Axiom audit confirms dependence strictly on foundational axioms:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Scope and status

- **Literature context:** The displayed statements use standard identities or project-specific definitions; no priority claim is made.
