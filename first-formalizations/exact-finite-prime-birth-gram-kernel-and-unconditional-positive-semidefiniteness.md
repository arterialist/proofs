# First Formalization: Exact Finite Prime Birth Gram Kernel and Unconditional Positive Semi-Definiteness

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenBirthFiniteGram.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthFiniteGram.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact arithmetic definition of the symmetric prime Gram kernel, its identification with the continuous $L^2$ inner product, and the unconditional positive semi-definiteness of the resulting quadratic form on arbitrary finite subsets in Lean 4:

1. **Finite Square Integrability:**
   Formal proof that $(\sum_{n \in s} c_n \text{increment}(n, v))^2$ is integrable on $(0, \infty)$ for any finite set $s \subset \mathbb{N}_{\ge 2}$ (`finite_square_integrable`).
2. **Double-Sum Energy Expansion:**
   Formal proof of `finite_energy_eq_double_sum`:
   $$
   \int_0^\infty \left( \sum_{n \in s} c_n \text{increment}(n, v) \right)^2 dv = \sum_{m \in s} \sum_{n \in s} c_m c_n \int_0^\infty \text{increment}(m, v) \text{increment}(n, v) dv.
   $$
3. **Kernel Equivalence:**
   Formal proof that `birth_gram_eq_kernel` equates the continuous $L^2$ inner product to `gramKernel m n`.
4. **Finite Kernel Energy Formula:**
   Formal proof of `finite_energy_eq_kernel`:
   $$
   \int_0^\infty \left( \sum_{n \in s} c_n \text{increment}(n, v) \right)^2 dv = \sum_{m \in s} \sum_{n \in s} c_m c_n \text{gramKernel}(m, n).
   $$
5. **Unconditional Positive Semi-Definiteness:**
   Formal proof of `finite_kernel_quadratic_nonnegative`:
   $$
   \sum_{m \in s} \sum_{n \in s} c_m c_n \text{gramKernel}(m, n) \ge 0.
   $$

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Equivalence of continuous L² inner product with the arithmetic Gram kernel
theorem birth_gram_eq_kernel {m n : ℕ} (hm : 2 ≤ m) (hn : 2 ≤ n) :
    (∫ v in Ioi (0 : ℝ), increment m v * increment n v) = gramKernel m n

-- Quadratic energy of an arbitrary finite linear combination of prime increments
theorem finite_energy_eq_kernel (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 2 ≤ n) :
    (∫ v in Ioi (0 : ℝ), (∑ n ∈ s, c n * increment n v)^2) =
      ∑ m ∈ s, ∑ n ∈ s, c m * c n * gramKernel m n

-- Unconditional positive semi-definiteness of the prime Gram kernel
theorem finite_kernel_quadratic_nonnegative (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 2 ≤ n) : 0 ≤ ∑ m ∈ s, ∑ n ∈ s, c m * c n * gramKernel m n
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that the arithmetic prime Gram kernel $\text{gramKernel}(m, n)$ defines an unconditionally positive semi-definite matrix on any finite set of scales $s \subset \mathbb{N}_{\ge 2}$, establishing a rigorous RKHS structure for prime birth increments.
