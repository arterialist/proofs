# Unique Contribution 158: Exact Arithmetic Prime Transport Operator and Spectral Classification

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ArithmeticTransport.lean`](../../formalization/BuildingBlocks/ArithmeticTransport.lean), [`building-blocks/transport/arithmetic-transport.md`](../../building-blocks/transport/arithmetic-transport.md)  
**Classification:** Analytic Number Theory / Spectral Theory / Arithmetic Operators / Von Mangoldt Convolution / Selberg Weight / Point Spectrum

---

## 1. Executive Summary and Mathematical Statement

The second von Mangoldt weight $\Lambda_2(n) = \Lambda(n)\log n + (\Lambda * \Lambda)(n)$ governs Selberg's symmetry formula. Abstracting this action onto the space of all arithmetic functions yields the linear operator $\mathcal{T}(f) = f \cdot \log + \Lambda * f$.

This contribution proves:

1. **Exact Zeta-Conjugation to the Logarithm Multiplication Operator:**  
   Under Dirichlet convolution with the zeta function $\zeta$, the prime transport operator $\mathcal{T}$ is exactly diagonalized into multiplication by $\log n$:
   \[
   \zeta * \mathcal{T}(f) = (\zeta * f) \cdot \log \iff \mathcal{T}(f) = \mu * ((\zeta * f) \cdot \log).
   \]
2. **Exact Kernel Characterization:**  
   The algebraic nullspace of $\mathcal{T}$ is precisely the one-dimensional subspace spanned by the Möbius function:
   \[
   \mathcal{T}(f) = 0 \iff f(n) = f(1)\mu(n).
   \]
3. **Complete Spectral Classification of Point Eigenvalues:**  
   A non-zero arithmetic function $f$ satisfies $\mathcal{T}(f) = \lambda f$ if and only if:
   \[
   \lambda = \log k \quad \text{for some integer } k \ge 1,
   \]
   with the explicit eigenvector given by $f_k = \mu * \delta_k$.
4. **Unconditional Spectral Positivity:**  
   Every point eigenvalue of the prime transport operator is non-negative: $\lambda = \log k \ge 0$.
5. **Initial Value Uniqueness:**  
   Two arithmetic functions satisfying $\mathcal{T}(f) = \mathcal{T}(g)$ and the boundary condition $f(1) = g(1)$ are identically equal: $f = g$.

---

## 2. Mathematical Proof

### 2.1. Exact Zeta-Conjugation
By definition of $\mathcal{T}(f) = f \cdot \log + \Lambda * f$:
\[
\zeta * \mathcal{T}(f) = \zeta * (f \cdot \log) + \zeta * (\Lambda * f).
\]
From `log_weighted_convolution`, for any arithmetic functions $g, h$:
\[
(g * h) \cdot \log = (g \cdot \log) * h + g * (h \cdot \log).
\]
Setting $g = \zeta$ and $h = f$:
\[
(\zeta * f) \cdot \log = (\zeta \cdot \log) * f + \zeta * (f \cdot \log).
\]
Since $\zeta \cdot \log = \zeta * \Lambda = \Lambda * \zeta$:
\[
(\zeta * f) \cdot \log = (\Lambda * \zeta) * f + \zeta * (f \cdot \log) = \zeta * (\Lambda * f) + \zeta * (f \cdot \log) = \zeta * \mathcal{T}(f).
\]
Convolving on the left by $\mu = \zeta^{-1}$:
\[
\mathcal{T}(f) = \mu * (\zeta * \mathcal{T}(f)) = \mu * ((\zeta * f) \cdot \log).
\]

### 2.2. Nullspace Characterization
If $\mathcal{T}(f) = 0$, then $(\zeta * f)(n) \log n = 0$ for all $n \ge 1$.
- For $n = 1$, $\log 1 = 0$, so $(\zeta * f)(1) = f(1)$ is arbitrary.
- For $n \ge 2$, $\log n \ne 0$, which forces $(\zeta * f)(n) = 0$.
Thus, $(\zeta * f) = f(1) \cdot \delta_1$.
Convolving with $\mu$:
\[
f = \mu * (\zeta * f) = \mu * (f(1)\delta_1) = f(1)\mu.
\]

### 2.3. Complete Spectral Classification
Suppose $\mathcal{T}(f) = \lambda f$ with $f \ne 0$.
Convolving with $\zeta$:
\[
\zeta * \mathcal{T}(f) = \lambda (\zeta * f) \implies ((\zeta * f) \cdot \log)(n) = \lambda (\zeta * f)(n)
\]
\[
\implies (\log n - \lambda) (\zeta * f)(n) = 0 \quad \text{for all } n \ge 1.
\]
Since $f \ne 0$, its invertible transform $\zeta * f \ne 0$. Thus there exists some integer $k \ge 1$ such that $(\zeta * f)(k) \ne 0$.
For this $k$, $(\log k - \lambda) = 0$, which proves $\lambda = \log k \ge 0$.
Conversely, for any $k \ge 1$, let $f_k = \mu * \delta_k$. Then $\zeta * f_k = \delta_k$, and:
\[
\mathcal{T}(f_k) = \mu * ((\zeta * f_k) \cdot \log) = \mu * (\delta_k \cdot \log) = \mu * (\log k \cdot \delta_k) = \log k (\mu * \delta_k) = \log k \cdot f_k.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/ArithmeticTransport.lean`):
```lean
theorem primeTransport_vonMangoldt :
    primeTransport ArithmeticFunction.vonMangoldt = selbergWeight

theorem zeta_mul_primeTransport (f : ArithmeticFunction ℝ) :
    (ArithmeticFunction.zeta : ArithmeticFunction ℝ) * primeTransport f =
      ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log

theorem primeTransport_conjugation (f : ArithmeticFunction ℝ) :
    primeTransport f = (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      (((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log)

theorem primeTransport_moebius :
    primeTransport (ArithmeticFunction.moebius : ArithmeticFunction ℝ) = 0

theorem primeTransport_eigenvalues (lam : ℝ) :
    (∃ f : ArithmeticFunction ℝ, f ≠ 0 ∧ ∀ n, primeTransport f n = lam * f n) ↔
      ∃ k : ℕ, k ≠ 0 ∧ lam = Real.log k

theorem primeTransport_eigenvalue_nonneg {lam : ℝ}
    (h : ∃ f : ArithmeticFunction ℝ, f ≠ 0 ∧ ∀ n, primeTransport f n = lam * f n) :
    0 ≤ lam

theorem primeTransport_kernel_iff (f : ArithmeticFunction ℝ) :
    primeTransport f = 0 ↔
      ∀ n : ℕ, f n = f 1 * (ArithmeticFunction.moebius n : ℝ)

theorem primeTransport_unique_of_initial {f g : ArithmeticFunction ℝ}
    (he : primeTransport f = primeTransport g) (h1 : f 1 = g 1) : f = g
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Selberg (1949), Erdős (1949), Shapiro (1950) on generalized von Mangoldt weights. Operators $\mathcal{T}(f) = f \log + \Lambda * f$ were treated purely combinatorially.
- **Advancement:** Complete operator-theoretic and spectral classification of the prime transport operator in Lean 4, identifying the exact spectrum $\{\log k : k \in \mathbb{N}_{\ge 1}\}$, eigenvectors $\mu * \delta_k$, and 1-dimensional Möbius kernel.
- **Target Venues:** *Linear Algebra and its Applications* or *Journal of Number Theory*.
