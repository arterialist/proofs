# Arithmetic coefficient transport: zeta conjugation and algebraic point spectrum

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ArithmeticTransport.lean`](../formalization/BuildingBlocks/ArithmeticTransport.lean)
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This is an algebraic formalization on `ArithmeticFunction ℝ`. The word “point spectrum” below
refers to the explicitly quantified eigenvalue statement; the module does not define a Hilbert-space
completion, boundedness, self-adjointness, or topological spectrum.

This formalization establishes the spectral theory and conjugation of the arithmetic prime-transport operator $(\mathcal{T} f)(n) = f(n) \log n + (\Lambda * f)(n)$ in Lean 4:

1. **Zeta-Conjugation Identity:**
   Formal proof that $\zeta * (\mathcal{T} f) = (\zeta * f) \cdot \log$ (`zeta_mul_primeTransport`).
2. **Möbius Inversion Formula:**
   Formal derivation of $\mathcal{T} f = \mu * ((\zeta * f) \cdot \log)$ (`primeTransport_conjugation`).
3. **One-Dimensional Kernel:**
   Formal characterization that $\ker(\mathcal{T}) = \mathbb{R} \cdot \mu$ (`primeTransport_kernel_iff`).
4. **Point Spectrum and Dilated Möbius Eigenvectors:**
   Formal proof that the point spectrum consists exactly of $\{\log k : k \ge 1\}$ (`primeTransport_eigenvalues`), with dilated eigenvectors $f_k = \mu * \delta_k$ (`primeTransport_delta_eigenvector`).
5. **Eigenvalue Non-Negativity:**
   Formal proof that every point eigenvalue satisfies $\lambda \ge 0$ (`primeTransport_eigenvalue_nonneg`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact zeta-conjugation to logarithmic multiplication
theorem zeta_mul_primeTransport (f : ArithmeticFunction ℝ) :
    (ArithmeticFunction.zeta : ArithmeticFunction ℝ) * primeTransport f =
      ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log

-- Möbius inversion representation
theorem primeTransport_conjugation (f : ArithmeticFunction ℝ) :
    primeTransport f = (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      (((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log)

-- One-dimensional Möbius nullspace
theorem primeTransport_kernel_iff (f : ArithmeticFunction ℝ) :
    primeTransport f = 0 ↔
      ∀ n : ℕ, f n = f 1 * (ArithmeticFunction.moebius n : ℝ)

-- Exact point spectrum {log k : k ≥ 1}
theorem primeTransport_eigenvalues (lam : ℝ) :
    (∃ f : ArithmeticFunction ℝ, f ≠ 0 ∧ ∀ n, primeTransport f n = lam * f n) ↔
      ∃ k : ℕ, k ≠ 0 ∧ lam = Real.log k

-- Non-negativity of eigenvalues
theorem primeTransport_eigenvalue_nonneg {lam : ℝ}
    (h : ∃ f : ArithmeticFunction ℝ, f ≠ 0 ∧ ∀ n, primeTransport f n = lam * f n) :
    0 ≤ lam
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 of the spectral theory of the arithmetic prime-transport operator, establishing that its point spectrum on arithmetic functions is exactly $\{\log k\}_{k \ge 1}$ and that its kernel is spanned by $\mu$.
