# Contribution 249: Exact Centered Distinct-Prime Riesz-Mellin Representation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCenteredMellin.lean`](../../formalization/BuildingBlocks/ActualCenteredMellin.lean), [`building-blocks/riesz/actual-centered-mellin.md`](../../building-blocks/riesz/actual-centered-mellin.md)  
**Classification:** Analytic Number Theory / Mellin Transforms / Riesz Means / Diagonal Prime Cancellation / Spectral Determinants / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

The centered prime fluctuation field $\psi(x) - x$ produces, upon quadratic pairing against itself under a second-order Riesz smoothing kernel, a sum over all pairs of prime powers $(p^k, q^m)$. Decomposing this quadratic form into distinct pairs, diagonal same-prime pairs, the linear Lebesgue background cross terms, and the continuous baseline is essential for isolating the off-diagonal prime correlation spectrum.

This contribution proves:

1. **Exact Decomposition of the Centered Quadratic Tent:**  
   The distinct-prime centered tent $V(x)$ satisfies the exact algebraic relation:
   $$
   V(x) = N(x) - T(x),
   $$
   where $N(x)$ is the full centered square (including all pairs) and $T(x)$ is the diagonal same-prime contribution.
2. **Exact Real Cutoff Formula:**  
   For all $x \ge 0$:
   $$
   V(x) = \sum_{n \le x} \left( (x - n) d_2(n) - \Lambda(n) \frac{x^2 - n^2}{n} \right) + B(x),
   $$
   where $d_2(n)$ is the distinct prime-power convolution weight and $B(x)$ is the explicit continuous baseline.
3. **Centered Distinct-Prime Mellin Identity:**
   For any $s \in \mathbb{C}$ with $\text{Re}(s) > 1$, the Mellin transform of the actual centered distinct-prime cutoff sum $V(x)$ at exponent $-s-1$ evaluates identically to:
   $$
   \mathcal{M}[V](-s-1) = \frac{(\text{centeredZetaLogDerivative}(s))^2 - H(s)}{s(s + 1)},
   $$
   where $\text{centeredZetaLogDerivative}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{1}{s-1}$ and $H(s) = \sum_{p, k, m} \frac{\log^2 p}{p^{(k+m)s}}$ is the Dirichlet series of the diagonal prime powers.
4. **Spectral Interpretation:**  
   This establishes an exact machine-verified identity equating the smoothed distinct-prime spatial correlations directly to the subtracted Dirichlet determinant $(\zeta'/\zeta + 1/(s-1))^2 - H(s)$ divided by the Riesz pole factor $s(s+1)$.

---

## 2. Mathematical Proof

### 2.1. Decomposition
By definition of convolution weights, every pair sum splits into distinct pairs ($p^k \ne q^m$) and diagonal same-prime pairs ($p^k = q^m$).
Setting $N(x) = \text{cutoffSum}(\text{fullPair}, x) - 2 \cdot \text{etaSum}(x) + B(x)$ and $T(x) = \text{cutoffSum}(\text{samePair}, x)$:
$$
V(x) = \text{cutoffSum}(\text{distinctPair}, x) - 2 \cdot \text{etaSum}(x) + B(x) = N(x) - T(x).
$$

### 2.2. Mellin Transform Evaluation
For $\text{Re}(s) > 1$, Mellin linearity yields:
$$
\mathcal{M}[V](-s-1) = \mathcal{M}[\text{cutoffSum}(\text{distinctPair})](-s-1) - 2 \mathcal{M}[\text{etaSum}](-s-1) + \mathcal{M}[B](-s-1).
$$
From `DistinctPrimeRieszMellin`, the distinct pair cutoff sum has Mellin transform:
$$
\frac{(-\zeta'(s)/\zeta(s))^2 - H(s)}{s(s+1)}.
$$
From `EtaRieszDirichlet`, the cross term $\text{etaSum}$ has Mellin transform:
$$
\frac{-\zeta'(s)/\zeta(s)}{(s-1)(s+1)}.
$$
From `EtaBaselineMellin`, the baseline $B(x)$ has Mellin transform:
$$
\frac{1}{s(s-1)^2(s+1)}.
$$
Summing these contributions with respective coefficients $1, -2, 1$:
$$
\mathcal{M}[V](-s-1) = \frac{(-\zeta'/\zeta)^2 - H(s)}{s(s+1)} - 2 \frac{-\zeta'/\zeta}{(s-1)(s+1)} + \frac{1}{s(s-1)^2(s+1)}.
$$
Combining terms over the common denominator $s(s+1)$:
$$
\frac{1}{s(s+1)} \left( \left( -\frac{\zeta'(s)}{\zeta(s)} \right)^2 - 2 \frac{s}{s-1}\left( -\frac{\zeta'(s)}{\zeta(s)} \right) + \frac{1}{(s-1)^2} - H(s) \right).
$$
Noticing that $\frac{s}{s-1} = 1 + \frac{1}{s-1}$ and factoring the centered expression:
$$
\left( -\frac{\zeta'(s)}{\zeta(s)} - \frac{1}{s-1} \right)^2 - H(s) = (\text{centeredZetaLogDerivative}(s))^2 - H(s).
$$
Thus the identity holds identically on $\text{Re}(s) > 1$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCenteredMellin` in `formalization/BuildingBlocks/ActualCenteredMellin.lean`):
```lean
theorem V_eq_N_sub_T (x : ℝ) : V x = N x - T x

theorem V_eq_real_cutoff {x : ℝ} (hx : 0 ≤ x) :
    V x =
      ((∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((x - n) * distinctPrimePairWeight n -
          ArithmeticFunction.vonMangoldt n * ((x^2 - (n : ℝ)^2) / n)) : ℝ) : ℂ) +
        EtaBaselineMellin.B x

theorem hasMellin_V {s : ℂ} (hs : 1 < s.re) :
    HasMellin V (-s-1)
      ((LogDerivativePole.centeredZetaLogDerivative s ^ 2 -
        SamePrimeDirichlet.H s) / (s * (s+1)))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Riesz means and smoothed explicit formulas (Chandrasekharan-Minakshisundaram 1952, Montgomery-Vaughan 2007). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Connects smoothed spatial prime pairs directly to the regularized spectral determinant without non-trivial pole singularities at $s=1$.
- **Target Venues:** *Mathematika* or *Journal of the London Mathematical Society*.
