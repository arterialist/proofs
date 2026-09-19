# Contribution 89: Finite Heat Source Formula, Exponential Decay, and L² Integrability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualFiniteHeatSource.lean`](../../formalization/BuildingBlocks/ActualFiniteHeatSource.lean)  
**Classification:** Analytic Number Theory / Parabolic Heat Equations / Chebyshev Fluctuations / $L^2$ Semigroups

---

## 1. Executive Summary and Mathematical Statement

The explicit formula relates primes to zeros through spectral trace formulas. By smoothing the discrete von Mangoldt measure $\sum_{n=1}^N \Lambda(n) \delta_n$ against the heat semigroup kernel $e^{-tx}$, one obtains the **finite heat source**:
$$
S_N(t) = \sum_{n=1}^N \Lambda(n) e^{-nt} - \int_1^N e^{-tx} dx - e^{-t}.
$$

This contribution proves:

1. **Exact Closed Elementary Heat Source Formula:**  
   For all $t \ne 0$:
   $$
   S_N(t) = \sum_{n=1}^N \Lambda(n) e^{-nt} - \frac{e^{-t} - e^{-Nt}}{t} - e^{-t}.
   $$
2. **Chebyshev Zero-Temperature Equivalence:**  
   At $t = 0$, the finite heat source recovers the exact unnormalized Chebyshev error:
   $$
   S_N(0) = \psi(N) - N.
   $$
3. **Exact Incremental Successor Step:**  
   Advancing the cutoff from $N$ to $N+1$ adds the exact local prime power pulse minus the continuum heat strip:
   $$
   S_{N+1}(t) - S_N(t) = \Lambda(N+1) e^{-(N+1)t} - \int_N^{N+1} e^{-tx} dx.
   $$
4. **Uniform Exponential Envelope Bound:**  
   For all $t \ge 0$ and $N \ge 1$:
   $$
   |S_N(t)| \le (\psi(N) + N) e^{-t}.
   $$
5. **Unconditional $L^2(0, \infty)$ Square Integrability:**  
   For every $N \ge 1$, the finite heat source is square integrable on $(0, \infty)$:
   $$
   \int_0^\infty S_N(t)^2 dt \le \frac{1}{2} (\psi(N) + N)^2 < \infty.
   $$

---

## 2. Mathematical Proof

### 2.1. Continuum Integral Evaluation
The continuum heat integral evaluates directly:
$$
\int_1^N e^{-tx} dx = \left[ -\frac{e^{-tx}}{t} \right]_1^N = \frac{e^{-t} - e^{-Nt}}{t}.
$$
Substituting into the definition yields the closed expression.
Taking the limit as $t \to 0^+$ by L'Hôpital's rule gives $\lim_{t \to 0} \frac{e^{-t} - e^{-Nt}}{t} = N - 1$.
Thus $S_N(0) = \psi(N) - (N - 1) - 1 = \psi(N) - N$.

### 2.2. Successor Increment
By linearity of sums and additivity of integrals:
$$
S_{N+1}(t) - S_N(t) = \Lambda(N+1) e^{-(N+1)t} - \left(\int_1^{N+1} e^{-tx} dx - \int_1^N e^{-tx} dx\right) = \Lambda(N+1) e^{-(N+1)t} - \int_N^{N+1} e^{-tx} dx.
$$

### 2.3. Exponential Bound and $L^2$ Convergence
Since $n \ge 1$ and $x \ge 1$, for $t \ge 0$ we have $e^{-nt} \le e^{-t}$ and $e^{-tx} \le e^{-t}$.
Thus:
$$
\left| \sum_{n=1}^N \Lambda(n) e^{-nt} \right| \le \psi(N) e^{-t}, \quad \left| \int_1^N e^{-tx} dx \right| \le (N-1) e^{-t}, \quad |e^{-t}| = e^{-t}.
$$
Applying the triangle inequality gives $|S_N(t)| \le (\psi(N) + (N-1) + 1) e^{-t} = (\psi(N) + N) e^{-t}$.
Squaring gives $|S_N(t)|^2 \le (\psi(N) + N)^2 e^{-2t}$.
Integrating on $(0, \infty)$:
$$
\int_0^\infty S_N(t)^2 dt \le (\psi(N) + N)^2 \int_0^\infty e^{-2t} dt = \frac{1}{2} (\psi(N) + N)^2 < \infty.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualFiniteHeatSource`):
```lean
theorem source_formula (N : ℕ) (t : ℝ) (ht : t ≠ 0) :
    source N t =
      (∑ n ∈ Finset.range (N + 1), Λ n * Real.exp (-(n : ℝ) * t)) -
        (Real.exp (-t) - Real.exp (-(N : ℝ) * t)) / t - Real.exp (-t)

theorem source_at_zero (N : ℕ) :
    source N 0 = (∑ n ∈ Finset.range (N + 1), Λ n) - (N : ℝ)

theorem source_successor (N : ℕ) (t : ℝ) :
    source (N + 1) t - source N t =
      Λ (N + 1) * Real.exp (-((N + 1 : ℕ) : ℝ) * t) -
        ∫ x : ℝ in (N : ℝ)..(N + 1 : ℕ), Real.exp (-t * x)

theorem source_norm_bound (N : ℕ) (hN : 1 ≤ N) (t : ℝ) (ht : 0 ≤ t) :
    ‖source N t‖ ≤ variationBound N * Real.exp (-t)

theorem source_square_integrable (N : ℕ) (hN : 1 ≤ N) :
    IntegrableOn (fun t : ℝ => source N t ^ 2) (Ioi 0)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Heat kernel regularization of prime sums is studied in mathematical physics (e.g., Berry–Keating, Connes, Lapidus). However, the explicit non-asymptotic closed formula, exact boundary reduction to the Chebyshev error $S_N(0) = \psi(N) - N$, and uniform exponential decay bound $|S_N(t)| \le (\psi(N) + N) e^{-t}$ had not been machine-verified.
- **Advancement:** Establishes the exact closed form, exponential envelope, and unconditional $L^2(0, \infty)$ square integrability of the finite heat source.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Letters in Mathematical Physics*.
