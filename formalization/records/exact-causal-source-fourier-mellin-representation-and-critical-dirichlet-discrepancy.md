# Contribution 225: Exact Causal Source Fourier-Mellin Representation and Critical Dirichlet Discrepancy

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenFourier.lean`](../../formalization/BuildingBlocks/ChargeFrozenFourier.lean), [`building-blocks/charge/charge-frozen-fourier.md`](../../building-blocks/charge/charge-frozen-fourier.md)  
**Classification:** Harmonic Analysis / Analytic Number Theory / Fourier Transforms / Mellin Transforms / Dirichlet Polynomials / Chebyshev Functions

---

## 1. Executive Summary and Mathematical Statement

Connecting time-domain prime counting dynamics to the critical line $\text{Re}(s) = 1/2$ requires an exact harmonic transform relating the causal arithmetic step function to the truncated Dirichlet series. 

This contribution proves:

1. **Atomic and Centering Decomposition:**  
   The causal arithmetic source decomposes into a discrete prime-power sum and a continuous background centering term:
   $$
   \text{causalSource}(N, v) = \sum_{n=2}^N \Lambda(n) \beta_n(v) - \text{centering}(N, v),
   $$
   where $\beta_n(v) = \mathbf{1}_{[\log n, \infty)}(v) e^{-v/2}$ and $\text{centering}(N, v) = \mathbf{1}_{[0, \infty)}(v) \min(e^v, N) e^{-v/2}$.
2. **Exact Fourier Transform of Prime Step Atoms:**  
   With the critical line Mellin variable $w(\xi) = \frac{1}{2} + i\xi$, the Fourier transform of the prime-power step atom $\beta_n$ is:
   $$
   \int_{-\infty}^\infty e^{-i \xi v} \beta_n(v) \, dv = \frac{e^{-w(\xi)\log n}}{w(\xi)} = \frac{n^{-w(\xi)}}{w(\xi)}.
   $$
3. **Exact Fourier Transform of Continuous Centering:**  
   The Fourier transform of the continuous background centering evaluates to:
   $$
   \int_{-\infty}^\infty e^{-i \xi v} \text{centering}(N, v) \, dv = \frac{N^{1 - w(\xi)} - 1}{1 - w(\xi)} + \frac{N^{1 - w(\xi)}}{w(\xi)} = \int_1^N x^{-w(\xi)} \, dx + \frac{N^{1 - w(\xi)}}{w(\xi)}.
   $$
4. **Closed-Form Fourier-Mellin Theorem:**
   For every $N \ge 2$ and every real frequency $\xi \in \mathbb{R}$:
   $$
   \int_{-\infty}^\infty e^{-i \xi v} \text{causalSource}(N, v) \, dv = \frac{-1 + \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} - \int_1^N x^{-w(\xi)} dx}{w(\xi)}.
   $$
   This formula establishes that the angular Fourier transform of the real-line causal source is identically equal to the truncated Chebyshev-zeta discrepancy along the critical line $\text{Re}(s) = 1/2$, with the seed $-1$, Dirichlet polynomial $\sum_{n \le N} \Lambda(n) n^{-w}$, and continuous baseline $-\int_1^N x^{-w} dx$ scaled by $1/w(\xi)$.

---

## 2. Mathematical Proof

### 2.1. Decomposition
For $v \ge 0$, $\text{causalSource}(N, v) = (\psi(\lfloor \min(e^v, N) \rfloor) - \min(e^v, N)) e^{-v/2}$.
The Chebyshev function decomposes over prime powers: $\psi(x) = \sum_{2 \le n \le x} \Lambda(n)$.
Thus $\psi(\lfloor \min(e^v, N) \rfloor) = \sum_{n=2}^N \Lambda(n) \mathbf{1}_{\{n \le e^v\}}$.
Multiplying by $e^{-v/2}$ and subtracting $\text{centering}(N, v) = \min(e^v, N) e^{-v/2}$ yields the identity. For $v < 0$, both sides vanish identically.

### 2.2. Atomic Fourier Transform
For $n \ge 1$:
$$
\int_{-\infty}^\infty e^{-i \xi v} \beta_n(v) \, dv = \int_{\log n}^\infty e^{-i \xi v} e^{-v/2} \, dv = \int_{\log n}^\infty e^{-(1/2 + i\xi) v} \, dv = \int_{\log n}^\infty e^{-w(\xi) v} \, dv.
$$
Since $\text{Re}(-w(\xi)) = -1/2 < 0$, the integral converges to:
$$
\left[ \frac{e^{-w(\xi) v}}{-w(\xi)} \right]_{\log n}^\infty = \frac{e^{-w(\xi)\log n}}{w(\xi)} = \frac{n^{-w(\xi)}}{w(\xi)}.
$$

### 2.3. Centering Fourier Transform
The centering term splits at $v = \log N$:
On $[0, \log N]$, $\min(e^v, N) e^{-v/2} = e^{v/2}$. The Fourier integrand is $e^{(1/2 - i\xi) v} = e^{(1 - w(\xi)) v}$.
Integrating from $0$ to $\log N$ gives $\frac{e^{(1-w(\xi))\log N} - 1}{1 - w(\xi)} = \frac{N^{1 - w(\xi)} - 1}{1 - w(\xi)} = \int_1^N x^{-w(\xi)} dx$.
On $(\log N, \infty)$, $\min(e^v, N) e^{-v/2} = N e^{-v/2}$. Integrating gives $N \frac{e^{-w(\xi)\log N}}{w(\xi)} = \frac{N^{1 - w(\xi)}}{w(\xi)}$.

### 2.4. Algebraic Consolidation
Subtracting the centering integral from the atomic sum and using $N^{1-w(\xi)} = N \cdot N^{-w(\xi)}$:
$$
\frac{1}{w(\xi)} \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} - \left( \frac{N^{1-w(\xi)} - 1}{1 - w(\xi)} + \frac{N^{1-w(\xi)}}{w(\xi)} \right).
$$
Putting over the common denominator $w(\xi)(1 - w(\xi))$ or combining terms directly yields:
$$
\frac{-1 + \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} - \int_1^N x^{-w(\xi)} dx}{w(\xi)}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenFourier` in `formalization/BuildingBlocks/ChargeFrozenFourier.lean`):
```lean
theorem causalSource_eq_atoms_sub_centering {N : ℕ} (hN : 2 ≤ N) (v : ℝ) :
    causalSource N v =
      (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) -
        centering N v

theorem beta_fourier_integral {n : ℕ} (hn : 0 < n) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (beta n v : ℂ)) =
      Complex.exp (-w ξ * (Real.log (n : ℝ) : ℂ)) / w ξ

theorem centering_fourier_integral {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (centering N v : ℂ)) =
      (Complex.exp ((1 - w ξ) * (Real.log (N : ℝ) : ℂ)) - 1) / (1 - w ξ) +
        (N : ℂ) * Complex.exp (-w ξ * (Real.log (N : ℝ) : ℂ)) / w ξ

theorem density_mellin_integral {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ)) =
      (Complex.exp ((1 - w ξ) * (Real.log (N : ℝ) : ℂ)) - 1) / (1 - w ξ)

theorem causalSource_fourier_mellin {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (causalSource N v : ℂ)) =
      (-1 + (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
        (n : ℂ) ^ (-w ξ)) -
        (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))) / w ξ
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Explicit formulas for Dirichlet polynomials and truncated Perron integrals (Perron 1908, Montgomery 1971, Iwaniec-Kowalski 2004). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes a completely formalized closed-form bridge between real-line arithmetic step dynamics and critical-line Dirichlet polynomials.
- **Target Venues:** *Journal of Fourier Analysis and Applications* or *Proceedings of the American Mathematical Society*.
