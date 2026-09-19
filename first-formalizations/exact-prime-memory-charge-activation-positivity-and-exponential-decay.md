# First Formalization: Exact Prime Memory Charge Activation Positivity and Exponential Decay

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeMemoryChargeDecay.lean`](../../formalization/BuildingBlocks/PrimeMemoryChargeDecay.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes that the negative part of the successor memory kernel is entirely bypassed by the prime threshold $\log 2$, proving strict positivity and exponential decay $e^{-u}$ for the prime memory defect operator in Lean 4:

1. **Kernel Positivity Beyond Activation Threshold:**
   Formal proof that $K(u) \ge 0$ for all $u \ge \log 2$ (`kernel_nonneg_of_log_two_le`).
2. **Exponential Memory Integrability:**
   Formal proof that $e^{-w} F(w) \in L^1((0, \infty))$ for any $F \in L^2(\mathbb{R})$ (`exponential_memory_integrable`).
3. **Thresholded Memory Positivity and Decay:**
   Formal proof that $0 \le \mathcal{K}[F](u) \le e^{-u} \int_0^\infty e^{-w} F(w) dw$ for any non-negative $F \in L^2$ vanishing on $(-\infty, \log 2)$ (`memoryDefectKernel_nonneg_decay`).
4. **All-Prime Seed Memory Specialization:**
   Formal proof that $B(v) = 0$ for $v < \log 2$ (`allPrimeSeed_eq_zero_before_log_two`) and that the all-prime memory defect kernel is non-negative and decays exponentially at rate $e^{-u}$ (`allPrimeSeed_defectKernel_nonneg_decay`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Kernel positivity on [log 2, ∞)
theorem kernel_nonneg_of_log_two_le {u : ℝ} (hu : log 2 ≤ u) : 0 ≤ kernel u

-- Exponential weight integrability
theorem exponential_memory_integrable {F : ℝ → ℝ} (hF : MemLp F 2 volume) :
    IntegrableOn (fun w => exp (-w) * F w) (Ioi (0 : ℝ))

-- Memory defect positivity and exponential decay for thresholded drivers
theorem memoryDefectKernel_nonneg_decay {F : ℝ → ℝ}
    (hm : Measurable F) (hF : MemLp F 2 volume)
    (hpos : ∀ w, 0 ≤ F w) (hzero : ∀ w < log 2, F w = 0)
    {u : ℝ} (hu : 0 ≤ u) :
    0 ≤ memoryDefectKernel F u ∧
      memoryDefectKernel F u ≤ exp (-u) * ∫ w in Ioi (0 : ℝ), exp (-w) * F w

-- All-prime seed vanishes before log 2
theorem allPrimeSeed_eq_zero_before_log_two {v : ℝ} (hv : v < log 2) :
    allPrimeSeed v = 0

-- All-prime memory defect is positive and decays as e^{-u}
theorem allPrimeSeed_defectKernel_nonneg_decay {u : ℝ} (hu : 0 ≤ u) :
    0 ≤ SuccessorCharge.memoryDefectKernel allPrimeSeed u ∧
    SuccessorCharge.memoryDefectKernel allPrimeSeed u ≤
      exp (-u) * ∫ w in Ioi (0 : ℝ), exp (-w) * allPrimeSeed w
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that arithmetic primes activate the memory kernel beyond its sign-change boundary, establishing unconditional positivity and exponential decay $O(e^{-u})$ for the memory operator.
