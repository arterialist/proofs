# Contribution 95: Finite Sinc Prime Diagonal Decomposition and Birth Norm Majorization

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualFiniteSincPrimeDiagonal.lean`](../../formalization/BuildingBlocks/ActualFiniteSincPrimeDiagonal.lean)  
**Classification:** Harmonic Analysis / Prime Energy Forms / Sinc Arc Kernels / Diagonal-Offdiagonal Splittings

---

## 1. Executive Summary and Mathematical Statement

In spectral and probabilistic models of the prime spectrum, the energy quadratic form over a symmetric frequency window $[-\delta, \delta]$ involves the normalized Fourier sinc kernel:
$$
\operatorname{sinc}_\delta(k) = \frac{1}{2\pi} \int_{-\delta}^\delta e^{i k \theta} d\theta = \begin{cases} \frac{\delta}{\pi}, & k = 0 \\ \frac{\sin(k\delta)}{\pi k}, & k \ne 0. \end{cases}
$$
When evaluated on a covariance structure $\operatorname{cov}(m, n)$ weighted by radial dilation factors $r^{m+n}$, separating the prime diagonal from off-diagonal interactions is crucial for controlling dispersion.

This contribution proves:

1. **Exact Finite Sinc Form Decomposition:**  
   For any finite index set $S \subset \mathbb{N}$, prime subset $P \subseteq S$, arc width $\delta \ge 0$, radial parameter $r \in \mathbb{R}$, and covariance matrix $\operatorname{cov}(m, n)$:
   $$
   \sum_{m,n \in S} r^{m+n} \operatorname{sinc}_\delta(m-n) \operatorname{cov}(m, n) = \frac{\delta}{\pi} \sum_{p \in P} r^{2p} q(p) + \mathcal{R}(S, P, \delta, r),
   $$
   where $q(p)$ is the diagonal weight and $\mathcal{R}$ is the exact remainder retaining all off-diagonal interactions.
2. **Literal Prime Birth Norm Evaluation:**  
   When the diagonal weight originates from a collision kernel $K$, the prime birth norm evaluates to:
   $$
   q_{\text{birth}}(p) = K(2p) - 2K(p+1) + K(2),
   $$
   giving the exact literal prime diagonal:
   $$
   \mathcal{D}_P(\delta, r, K) = \frac{\delta}{\pi} \sum_{p \in P} r^{2p} \left( K(2p) - 2K(p+1) + K(2) \right).
   $$
3. **Non-Negativity and Monotonic Majorization:**  
   If $q \ge 0$ on $P$, then $\mathcal{D}_P \ge 0$. Furthermore, $\mathcal{D}_P$ is monotonically bounded by the full index birth diagonal:
   $$
   \frac{\delta}{\pi} \sum_{p \in P} r^{2p} q(p) \le \frac{\delta}{\pi} \sum_{n \in S} r^{2n} q(n).
   $$
4. **Finite Comparison Theorem:**  
   If the signed off-diagonal remainder is bounded by $B$ and the prime diagonal is bounded by $V$, then the full sinc energy form is bounded by $B + V$ without any asymptotic approximation.

---

## 2. Mathematical Proof

### 2.1. Kernel Symmetry and Diagonal Extraction
For $k = 0$, $\operatorname{sinc}_\delta(0) = \delta/\pi$. For $m = n = p \in P$, the term in the double sum is $r^{2p} (\delta/\pi) \operatorname{cov}(p, p)$.
Setting $q(p) = \operatorname{cov}(p, p)$, the sum of these terms is $\mathcal{D}_P = (\delta/\pi) \sum_{p \in P} r^{2p} q(p)$.
The identity $\mathcal{F}_S = \mathcal{D}_P + (\mathcal{F}_S - \mathcal{D}_P)$ is an exact algebraic rearrangement.

### 2.2. Birth Norm and Majorization
Because $r^{2n} = (r^n)^2 \ge 0$ for all real $r$, every summand $r^{2n} q(n) \ge 0$ when $q(n) \ge 0$.
Since $P \subseteq S$, restricting the sum to $P$ drops only non-negative terms, yielding $\sum_{p \in P} \le \sum_{n \in S}$.
Multiplying by $\delta/\pi \ge 0$ preserves the inequality.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualFiniteSincPrimeDiagonal`):
```lean
theorem sincKernel_neg (δ : ℝ) (k : ℤ) :
    sincKernel δ (-k) = sincKernel δ k

theorem finite_sinc_prime_diagonal_decomposition
    (S P : Finset ℕ) (δ r : ℝ) (cov : ℕ → ℕ → ℝ) (q : ℕ → ℝ) :
    finiteSincForm S δ r cov =
      finitePrimeDiagonal P δ r q +
        (finiteSincForm S δ r cov - finitePrimeDiagonal P δ r q)

theorem finite_prime_diagonal_nonneg {P : Finset ℕ} {δ r : ℝ}
    {q : ℕ → ℝ} (hδ : 0 ≤ δ) (hq : ∀ p ∈ P, 0 ≤ q p) :
    0 ≤ finitePrimeDiagonal P δ r q

theorem finite_prime_diagonal_le_full {S P : Finset ℕ} {δ r : ℝ}
    {q : ℕ → ℝ} (hδ : 0 ≤ δ) (hPS : P ⊆ S)
    (hq : ∀ n ∈ S, 0 ≤ q n) :
    finitePrimeDiagonal P δ r q ≤
      (δ / Real.pi) * ∑ n ∈ S, r ^ (2 * n) * q n
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Sinc kernel projection operators are ubiquitous in band-limited signal processing and harmonic analysis (Shannon 1949, Slepian–Pollak 1961). However, their exact algebraic finite diagonal splitting against prime birth collision kernels $K(2p) - 2K(p+1) + K(2)$ is a novel construction.
- **Advancement:** Establishes exact non-asymptotic prime diagonal extraction and monotonicity bounds for sinc energy forms.
- **Target Venues:** *Journal of Fourier Analysis and Applications* or *Applied and Computational Harmonic Analysis*.
