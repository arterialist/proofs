# First Formalization: Exact Arithmetic Prime Transport Operator and Spectral Classification

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ArithmeticTransport.lean`](../../formalization/BuildingBlocks/ArithmeticTransport.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the prime transport operator $\mathcal{T}(f) = f \cdot \log + \Lambda * f$ acting on the module of arithmetic functions, its exact conjugation to multiplication by $\log n$, its complete point spectrum $\{\log k\}_{k \ge 1}$, its one-dimensional Möbius kernel, and the unique determination from initial boundary data in Lean 4:

1. **Selberg Weight Evaluation:**
   Formal proof that $\mathcal{T}(\Lambda) = \Lambda_2$ (`primeTransport_vonMangoldt`).
2. **Exact Conjugation Formula:**
   Formal proof that $\zeta * \mathcal{T}(f) = (\zeta * f) \cdot \log$ (`zeta_mul_primeTransport`) and $\mathcal{T}(f) = \mu * ((\zeta * f) \cdot \log)$ (`primeTransport_conjugation`).
3. **Möbius Kernel Invariance:**
   Formal proof that $\mathcal{T}(\mu) = 0$ (`primeTransport_moebius`) and $\ker(\mathcal{T}) = \mathbb{R} \cdot \mu$ (`primeTransport_kernel_iff`).
4. **Complete Spectral Characterization:**
   Formal proof that the point eigenvalues are exactly $\{\log k : k \ge 1\}$ with explicit eigenvectors $\mu * \delta_k$ (`primeTransport_eigenvalues`), and non-negativity $\lambda \ge 0$ (`primeTransport_eigenvalue_nonneg`).
5. **Initial Value Determinism:**
   Formal proof that $\mathcal{T}(f) = \mathcal{T}(g) \wedge f(1) = g(1) \implies f = g$ (`primeTransport_unique_of_initial`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Transport operator reproduces Selberg symmetry weight on von Mangoldt
theorem primeTransport_vonMangoldt :
    primeTransport ArithmeticFunction.vonMangoldt = selbergWeight

-- Exact conjugation to log multiplication
theorem zeta_mul_primeTransport (f : ArithmeticFunction ℝ) :
    (ArithmeticFunction.zeta : ArithmeticFunction ℝ) * primeTransport f =
      ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log

-- Inverse representation via Moebius convolution
theorem primeTransport_conjugation (f : ArithmeticFunction ℝ) :
    primeTransport f = (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      (((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log)

-- Complete spectral classification of point eigenvalues
theorem primeTransport_eigenvalues (lam : ℝ) :
    (∃ f : ArithmeticFunction ℝ, f ≠ 0 ∧ ∀ n, primeTransport f n = lam * f n) ↔
      ∃ k : ℕ, k ≠ 0 ∧ lam = Real.log k

-- Complete kernel characterization: nullspace is span(Moebius)
theorem primeTransport_kernel_iff (f : ArithmeticFunction ℝ) :
    primeTransport f = 0 ↔
      ∀ n : ℕ, f n = f 1 * (ArithmeticFunction.moebius n : ℝ)

-- Uniqueness from initial boundary condition
theorem primeTransport_unique_of_initial {f g : ArithmeticFunction ℝ}
    (he : primeTransport f = primeTransport g) (h1 : f 1 = g 1) : f = g
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified spectral theory of arithmetic convolution operators in Lean 4, establishing the complete point spectrum and eigenspace decomposition of the prime transport operator without analytic approximations.
