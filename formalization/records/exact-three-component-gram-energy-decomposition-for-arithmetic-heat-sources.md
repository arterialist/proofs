# Contribution 90: Exact Three-Component Gram Energy Decomposition for Arithmetic Heat Sources

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualHeatDensityPairing.lean`](../../formalization/BuildingBlocks/ActualHeatDensityPairing.lean), [`formalization/BuildingBlocks/AdditiveHeatPairing.lean`](../../formalization/BuildingBlocks/AdditiveHeatPairing.lean)  
**Classification:** Analytic Number Theory / Parabolic Equations / Hilbert Space Energy / Gram Matrix Decomposition

---

## 1. Executive Summary and Mathematical Statement

For any cutoff $N \ge 1$, the continuous $L^2(0, \infty)$ Hilbert energy of the prime fluctuation heat source:
$$
S_N(t) = \sum_{n=1}^N \Lambda(n) e^{-nt} - \int_1^N e^{-tx} dx - e^{-t}
$$
measures the aggregate quadratic deviation of the discrete prime spectrum from the continuous density background under the heat semigroup.

This contribution proves:

1. **Exact Evaluation of Continuous Density Self-Energy:**  
   The $L^2(0, \infty)$ energy of the continuous heat density $\text{density}_N(t) = \int_1^N e^{-tx} dx$ evaluates to the exact closed elementary expression:
   $$
   \int_0^\infty (\text{density}_N(t))^2 dt = 2N \log(2N) - 2(N+1)\log(N+1) + 2\log 2.
   $$
2. **Exact Discrete-Continuous Cross Coupling:**  
   For any coordinate $x \ge 1$, the heat pairing between a discrete exponential $e^{-xt}$ and the continuous density is an exact logarithm:
   $$
   \int_0^\infty e^{-xt} \text{density}_N(t) dt = \log\left( \frac{x + N}{x + 1} \right).
   $$
3. **Complete Three-Component Gram Energy Theorem:**  
   The total $L^2(0, \infty)$ Hilbert energy of the arithmetic heat source $S_N(t)$ evaluates to the exact closed three-component formula:
   $$
   \int_0^\infty S_N(t)^2 dt = \sum_{i,j=0}^N \frac{c_i c_j}{x_i + x_j} - 2 \sum_{i=0}^N c_i \log\left(\frac{x_i + N}{x_i + 1}\right) + \Big[ 2N \log(2N) - 2(N+1)\log(N+1) + 2\log 2 \Big],
   $$
   where $x_n = \max(n, 1)$ and $c_n = \Lambda(n) - [n=1]$.
4. **Architectural Significance:**  
   This establishes that the continuous infinite-dimensional $L^2(0, \infty)$ norm of prime fluctuations is completely equivalent to an explicit, purely algebraic finite matrix sum without any numerical quadrature or asymptotic approximation error.

---

## 2. Mathematical Proof

### 2.1. Continuous Density Self-Energy
By Fubini's theorem exchanging the $t$-integral with the double spatial integral:
$$
\int_0^\infty \left(\int_1^N e^{-tx} dx\right)^2 dt = \int_1^N \int_1^N \left(\int_0^\infty e^{-(x+y)t} dt\right) dx dy = \int_1^N \int_1^N \frac{1}{x+y} dx dy.
$$
Integrating $y \in [1, N]$ gives $\int_1^N (\log(x+N) - \log(x+1)) dx$.
Integrating $x \in [1, N]$ using $\int \log(u) du = u \log u - u$ yields:
$$
[ (x+N)\log(x+N) - (x+N) - (x+1)\log(x+1) + (x+1) ]_1^N = 2N \log(2N) - 2(N+1)\log(N+1) + 2\log 2.
$$

### 2.2. Discrete-Continuous Pairing
Similarly, exchanging integrals:
$$
\int_0^\infty e^{-xt} \left(\int_1^N e^{-yt} dy\right) dt = \int_1^N \left(\int_0^\infty e^{-(x+y)t} dt\right) dy = \int_1^N \frac{1}{x+y} dy = \log\left(\frac{x+N}{x+1}\right).
$$

### 2.3. Assembling the Arithmetic Gram Matrix
Representing $S_N(t) = \operatorname{profile}(t) - \text{density}_N(t)$ with coefficients $c_n$ and coordinates $x_n$, expanding the square and integrating yields the discrete Cauchy Gram term $\sum \frac{c_i c_j}{x_i + x_j}$, the cross-term $-2 \sum c_i \log\frac{x_i+N}{x_i+1}$, and the continuous density term.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualHeatDensityPairing`):
```lean
theorem density_square_closed_formula (N : ℕ) (hN : 1 ≤ N) :
    (∫ t : ℝ in Ioi 0, density N t ^ 2) =
      2 * (N : ℝ) * Real.log (2 * (N : ℝ)) -
        2 * ((N : ℝ) + 1) * Real.log ((N : ℝ) + 1) + 2 * Real.log 2

theorem mixed_density_integral (N : ℕ) (hN : 1 ≤ N) (x : ℝ) (hx : 1 ≤ x) :
    (∫ t : ℝ in Ioi 0, Real.exp (-x * t) * density N t) =
      Real.log ((x + N) / (x + 1))

theorem actual_source_gram (N : ℕ) (hN : 1 ≤ N) :
    (∫ t : ℝ in Ioi 0, source N t ^ 2) =
      (∑ i ∈ Finset.range (N + 1), ∑ j ∈ Finset.range (N + 1),
        atomicCoefficient i * atomicCoefficient j / (atomicCoordinate i + atomicCoordinate j)) -
      2 * (∑ i ∈ Finset.range (N + 1), atomicCoefficient i *
        Real.log ((atomicCoordinate i + N) / (atomicCoordinate i + 1))) +
      (2 * (N : ℝ) * Real.log (2 * (N : ℝ)) -
        2 * ((N : ℝ) + 1) * Real.log ((N : ℝ) + 1) + 2 * Real.log 2)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior literature comparison:** Heat-kernel pairings of arithmetic functions are classical. This audit did not establish publication or formalization priority for the exact three-component formula.
- **Advancement:** Establishes the exact algebraic Gram decomposition of prime heat source energy.
- **Target Venues:** *Journal of Functional Analysis* or *Journal of Number Theory*.
