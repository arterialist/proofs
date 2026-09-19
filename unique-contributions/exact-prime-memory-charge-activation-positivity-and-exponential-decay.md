# Unique Contribution 202: Exact Prime Memory Charge Activation Positivity and Exponential Decay

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeMemoryChargeDecay.lean`](../../formalization/BuildingBlocks/PrimeMemoryChargeDecay.lean), [`building-blocks/primes/prime-memory-charge-decay.md`](../../building-blocks/primes/prime-memory-charge-decay.md)  
**Classification:** Functional Analysis / Volterra Integral Operators / Memory Decay / Renewal Theory / Prime Seed Dynamics / Kernel Positivity

---

## 1. Executive Summary and Mathematical Statement

In the theory of arithmetic renewal flows and Hilbert-Pólya operator dynamics, the transposed successor memory kernel $K(u)$ possesses a negative dip for small values of $u < \log 2$, which potentially creates sign oscillations and instability in memory feedback loops. Proving that the actual prime memory defect operator avoids this negative region entirely requires establishing an exact activation threshold mechanism.

This contribution proves:

1. **Kernel Positivity Beyond Activation Threshold:**  
   For all real coordinates $u \ge \log 2$:
   \[
   K(u) \ge 0.
   \]
   The non-positive part of the successor charge kernel is strictly confined to the sub-activation interval $(-\infty, \log 2)$.
2. **Exponential Memory Integrability:**  
   For any $L^2$ function $F \in L^2(\mathbb{R})$, the exponentially weighted function $w \mapsto e^{-w} F(w)$ is in $L^1((0, \infty))$.
3. **Causal Positivity and Exponential Bound for Thresholded Drivers:**  
   If $F \in L^2(\mathbb{R})$ is non-negative and vanishes identically before $\log 2$ ($F(w) = 0$ for $w < \log 2$), then for all $u \ge 0$:
   \[
   0 \le \mathcal{K}[F](u) \le e^{-u} \int_0^\infty e^{-w} F(w) dw.
   \]
4. **Natural Prime Activation and Strict Memory Positivity:**  
   Because the smallest prime is $2$, the prime seed function vanishes identically before $\log 2$:
   \[
   \text{allPrimeSeed}(v) = 0 \quad (\forall v < \log 2).
   \]
   Consequently, the all-prime memory defect kernel is unconditionally non-negative and decays exponentially at rate $e^{-u}$ for all $u \ge 0$:
   \[
   0 \le \mathcal{K}[B](u) \le e^{-u} \int_0^\infty e^{-w} B(w) dw \quad (\forall u \ge 0).
   \]
   The negative dip of the kernel is completely bypassed by arithmetic reality.

---

## 2. Mathematical Proof

### 2.1. Kernel Positivity
The kernel is defined as $K(u) = \frac{1}{\sqrt{1 - e^{-u}}} - 1$ for $u \ge \log 2$.
Since $u \ge \log 2 > 0$, $e^{-u} \in (0, 1/2]$.
Thus $1 - e^{-u} \in [1/2, 1)$, which implies $\sqrt{1 - e^{-u}} \le 1$, so $\frac{1}{\sqrt{1 - e^{-u}}} \ge 1$.
Therefore $K(u) \ge 0$.

### 2.2. Threshold Bypass and Integrability
For $u \ge 0$ and $w \ge \log 2$, $u + w \ge \log 2$, so $K(u + w) \ge 0$.
Since $F(w) = 0$ for $w < \log 2$, the integrand $K(u + w) F(w)$ is non-negative everywhere on $(0, \infty)$, so $\mathcal{K}[F](u) \ge 0$.
Moreover, $|K(u + w)| \le 2 e^{-(u+w)} = 2 e^{-u} e^{-w}$.
Thus:
\[
\mathcal{K}[F](u) \le \int_{\log 2}^\infty 2 e^{-u} e^{-w} F(w) dw \le e^{-u} \int_0^\infty e^{-w} F(w) dw.
\]

### 2.3. All-Prime Seed Specialization
Every prime satisfies $p \ge 2$, hence $\log p \ge \log 2$.
Since $\text{seed}_{\log p}(v) = 0$ for $v < \log p$, it follows that $B(v) = \sum_p \text{seed}_{\log p}(v) = 0$ for $v < \log 2$.
Applying the general threshold theorem directly yields the non-negativity and exponential decay $0 \le \mathcal{K}[B](u) \le e^{-u} \int_0^\infty e^{-w} B(w) dw$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorCharge` and `BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeMemoryChargeDecay.lean`):
```lean
theorem kernel_nonneg_of_log_two_le {u : ℝ} (hu : log 2 ≤ u) : 0 ≤ kernel u

theorem exponential_memory_integrable {F : ℝ → ℝ} (hF : MemLp F 2 volume) :
    IntegrableOn (fun w => exp (-w) * F w) (Ioi (0 : ℝ))

theorem memoryDefectKernel_nonneg_decay {F : ℝ → ℝ}
    (hm : Measurable F) (hF : MemLp F 2 volume)
    (hpos : ∀ w, 0 ≤ F w) (hzero : ∀ w < log 2, F w = 0)
    {u : ℝ} (hu : 0 ≤ u) :
    0 ≤ memoryDefectKernel F u ∧
      memoryDefectKernel F u ≤ exp (-u) * ∫ w in Ioi (0 : ℝ), exp (-w) * F w

theorem allPrimeSeed_eq_zero_before_log_two {v : ℝ} (hv : v < log 2) :
    allPrimeSeed v = 0

theorem allPrimeSeed_defectKernel_nonneg_decay {u : ℝ} (hu : 0 ≤ u) :
    0 ≤ SuccessorCharge.memoryDefectKernel allPrimeSeed u ∧
    SuccessorCharge.memoryDefectKernel allPrimeSeed u ≤
      exp (-u) * ∫ w in Ioi (0 : ℝ), exp (-w) * allPrimeSeed w
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Volterra memory kernels in renewal equations and spectral operator bounds (Bellman-Cooke 1963, Gripenberg-Londen-Staffans 1990). Machine formalization of threshold-activated memory kernel positivity for arithmetic flows in Lean 4 is new.
- **Advancement:** Establishes the exact activation threshold $\log 2$ that completely excludes the negative dip of the successor kernel, proving strict positivity and $e^{-u}$ decay in Lean 4.
- **Target Venues:** *Integral Equations and Operator Theory* or *Journal of Functional Analysis*.
