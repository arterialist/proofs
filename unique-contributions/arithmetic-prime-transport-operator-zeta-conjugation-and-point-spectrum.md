# Unique Contribution 84: Arithmetic Prime-Transport Operator Zeta-Conjugation and Point Spectrum

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ArithmeticTransport.lean`](../../formalization/BuildingBlocks/ArithmeticTransport.lean)  
**Classification:** Analytic Number Theory / Arithmetic Functions / Dirichlet Convolution / Spectral Theory of Arithmetic Operators

---

## 1. Executive Summary and Mathematical Statement

In the algebraic theory of arithmetic functions, the second generalized von Mangoldt function $\Lambda_2 = \Lambda \log + \Lambda * \Lambda$ arises from differentiating the Dirichlet series $-\zeta'(s)/\zeta(s)$. Generalizing this construction to an arbitrary arithmetic function $f : \mathbb{N} \to \mathbb{R}$ yields the **arithmetic prime-transport operator**:
\[
(\mathcal{T} f)(n) = f(n) \log n + (\Lambda * f)(n).
\]

This contribution proves:

1. **Exact Zeta-Conjugation to Logarithmic Multiplication:**  
   Dirichlet convolution with the constant arithmetic function $\zeta(n) \equiv 1$ exactly conjugates the prime-transport operator $\mathcal{T}$ into pointwise multiplication by $\log n$:
   \[
   \zeta * (\mathcal{T} f) = (\zeta * f) \cdot \log n.
   \]
2. **Möbius Inversion Formula for Transport:**  
   Applying Möbius inversion directly yields:
   \[
   \mathcal{T} f = \mu * ((\zeta * f) \cdot \log n),
   \]
   and for functions of the form $f = \mu * g$, the action simplifies to $\mathcal{T}(\mu * g) = \mu * (g \cdot \log n)$.
3. **One-Dimensional Kernel Characterization:**  
   The algebraic nullspace $\ker(\mathcal{T})$ of the prime-transport operator on arithmetic functions is exactly one-dimensional and spanned by the Möbius function $\mu$:
   \[
   \mathcal{T} f = 0 \iff f(n) = f(1) \mu(n), \quad \forall n \in \mathbb{N}.
   \]
4. **Complete Point Spectrum Characterization:**  
   The point eigenvalues $\lambda \in \mathbb{R}$ of $\mathcal{T}$ on non-zero arithmetic functions are exactly the logarithms of positive integers:
   \[
   \operatorname{Spec}_{\mathrm{point}}(\mathcal{T}) = \{\log k : k \in \mathbb{N}_{\ge 1}\}.
   \]
   For each eigenvalue $\lambda = \log k$, the eigenspace contains the dilated Möbius eigenvector $f_k = \mu * \delta_k$, with explicit values:
   \[
   f_k(n) = \begin{cases} \mu(n/k) & \text{if } k \mid n, \\ 0 & \text{otherwise}. \end{cases}
   \]
5. **Unconditional Eigenvalue Positivity:**  
   Every algebraic eigenvalue $\lambda$ of the arithmetic prime-transport operator satisfies $\lambda \ge 0$.

---

## 2. Mathematical Proof

### 2.1. Zeta Conjugation Identity
By Selberg-type identities, $\Lambda * \zeta = \log$ and $(\zeta * f) \log = \zeta * (f \log) + (\zeta \log) * f$.
Computing $\zeta * (\mathcal{T} f)$:
\[
\zeta * (f \log + \Lambda * f) = \zeta * (f \log) + (\zeta * \Lambda) * f = \zeta * (f \log) + \log * f = (\zeta * f) \log.
\]
Convolving on the left with $\mu$ and using $\mu * \zeta = 1$ proves $\mathcal{T} f = \mu * ((\zeta * f) \log)$.

### 2.2. Nullspace Derivation
If $\mathcal{T} f = 0$, then $(\zeta * f)(n) \log n = 0$ for all $n$.
For $n = 1$, $\log 1 = 0$, so $(\zeta * f)(1) = f(1)$ is unconstrained.
For $n \ge 2$, $\log n \ne 0$, forcing $(\zeta * f)(n) = 0$.
Thus $\zeta * f = f(1) \delta_1 = f(1) \cdot 1$. Convolving with $\mu$ yields $f = f(1) \mu$.

### 2.3. Point Spectrum Determination
If $\mathcal{T} f = \lambda f$ with $f \ne 0$, then $g = \zeta * f \ne 0$.
Convolving with $\zeta$ gives $g(n) \log n = \lambda g(n)$.
Since $g \ne 0$, there exists $k \ge 1$ with $g(k) \ne 0$.
Evaluating at $n = k$ yields $g(k) \log k = \lambda g(k)$, so $\lambda = \log k \ge 0$.
Conversely, choosing $g = \delta_k$ yields the eigenvector $f = \mu * \delta_k \ne 0$ with eigenvalue $\log k$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ArithmeticTransport`):
```lean
theorem zeta_mul_primeTransport (f : ArithmeticFunction ℝ) :
    (ArithmeticFunction.zeta : ArithmeticFunction ℝ) * primeTransport f =
      ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log

theorem primeTransport_conjugation (f : ArithmeticFunction ℝ) :
    primeTransport f = (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      (((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log)

theorem primeTransport_kernel_iff (f : ArithmeticFunction ℝ) :
    primeTransport f = 0 ↔
      ∀ n : ℕ, f n = f 1 * (ArithmeticFunction.moebius n : ℝ)

theorem primeTransport_eigenvalues (lam : ℝ) :
    (∃ f : ArithmeticFunction ℝ, f ≠ 0 ∧ ∀ n, primeTransport f n = lam * f n) ↔
      ∃ k : ℕ, k ≠ 0 ∧ lam = Real.log k

theorem primeTransport_eigenvalue_nonneg {lam : ℝ}
    (h : ∃ f : ArithmeticFunction ℝ, f ≠ 0 ∧ ∀ n, primeTransport f n = lam * f n) :
    0 ≤ lam
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Selberg's formula $\Lambda_2 = \Lambda \log + \Lambda * \Lambda$ is classical. However, abstracting $\mathcal{T} f = f \log + \Lambda * f$ as a linear operator on the space of arithmetic functions, proving its exact Dirichlet conjugation to logarithmic multiplication, and characterizing its point spectrum as precisely $\{\log k\}_{k \ge 1}$ with dilated Möbius eigenvectors had never been formalized in Lean 4.
- **Advancement:** Establishes the complete spectral decomposition and nullspace of the arithmetic prime-transport operator.
- **Target Venues:** *Journal of Number Theory* or *Linear Algebra and its Applications*.
