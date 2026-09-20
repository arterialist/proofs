# Contribution 83: Filtered Prime-Density Convolution and Three-Component Potential Decomposition

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeDensityFilter.lean`](../../formalization/BuildingBlocks/PrimeDensityFilter.lean)  
**Classification:** Analytic Number Theory / Integral Transforms / Operator Theory / Arithmetic Potential Microstructure

---

## 1. Executive Summary and Mathematical Statement

In the evaluation of the second-order prime convolution source $(S * S)$, the filtered convolution operator $\mathcal{L}_0(f)(s) = \int_0^s e^{-3(s-v)/2} f(v) \, dv$ decomposes the interaction between discrete prime birth impulses and continuous background density into three fundamental micro-structural components.

This contribution proves:

1. **Discrete Prime-Pair Filtered Convolution:**  
   For prime powers $p^j$ and $q^k$, the filtered convolution of their birth impulses scaled by $\log p \log q$ satisfies:
   $$
   (\log p \log q) \mathcal{L}_0(\operatorname{conv}(\operatorname{birth}(j\log p), \operatorname{birth}(k\log q)))(s) = \mathbf{1}_{p^j q^k \le e^s} e^{-3s/2} (e^s - p^j q^k) \log p \log q.
   $$
   In physical coordinate $x = e^s$, this produces the exact tent potential weight:
   $$
   x^{-3/2} (x - p^j q^k) \log p \log q.
   $$
2. **Discrete-Continuous Mixed Symmetrized Filtered Convolution:**  
   The sum of the two mixed convolution orders between the prime power birth impulse and continuous density satisfies:
   $$
   \log p \left[ \mathcal{L}_0(\operatorname{conv}(\operatorname{birth}(j\log p), \operatorname{density}))(s) + \mathcal{L}_0(\operatorname{conv}(\operatorname{density}, \operatorname{birth}(j\log p)))(s) \right] = \mathbf{1}_{p^j \le e^s} e^{-3s/2} \log p \frac{e^{2s} - (p^j)^2}{p^j}.
   $$
   In physical coordinate $x = e^s$, setting $n = p^j$, this yields the exact source subtraction term:
   $$
   x^{-3/2} \Lambda(n) \frac{x^2 - n^2}{n}.
   $$
3. **Continuous Density Self-Convolution:**  
   The filtered self-convolution of the deterministic continuous density is given by:
   $$
   \mathcal{L}_0(\operatorname{conv}(\operatorname{density}, \operatorname{density}))(s) = e^{-3s/2} \left( \frac{e^{2s} s}{2} + \frac{e^{2s}}{4} - \frac{1}{4} \right).
   $$
   In physical coordinate $x = e^s$:
   $$
   x^{-3/2} \left( \frac{x^2 \log x}{2} + \frac{x^2}{4} - \frac{1}{4} \right).
   $$
4. **Micro-Structural Basis of the Arithmetic Potential $V(x)$:**  
   These three closed evaluations provide the exact term-by-term proof that $\mathcal{L}_0(S * S)(s) - \tau(s) = x^{-3/2} V(x)$, verifying the algebraic origin of each component of the arithmetic potential:
   $$
   V(x) = \sum_{p^j q^k \le x, p \ne q} (x - p^j q^k)\log p \log q - \sum_{n \le x} \Lambda(n)\frac{x^2 - n^2}{n} + \left(\frac{x^2 \log x}{2} + \frac{x^2}{4} - \frac{1}{4}\right).
   $$

---

## 2. Mathematical Proof

### 2.1. Pure Birth Pairs
Let $b_1 = j \log p$ and $b_2 = k \log q$. The convolution of two Dirac-type birth impulses is a ramp function supported on $[b_1 + b_2, \infty)$:
$\operatorname{conv}(\operatorname{birth}(b_1), \operatorname{birth}(b_2))(v) = \mathbf{1}_{v \ge b_1 + b_2} e^{(v - (b_1 + b_2))/2}$.
Applying the filter kernel $e^{-3(s-v)/2}$:
$$
\int_{b_1+b_2}^s e^{-3(s-v)/2} e^{(v - (b_1 + b_2))/2} \, dv = e^{-3s/2} e^{-(b_1+b_2)/2} \int_{b_1+b_2}^s e^{2v} \, dv = e^{-3s/2} (e^s - e^{b_1+b_2}).
$$
Substituting $e^{b_1+b_2} = p^j q^k$ proves the formula.

### 2.2. Mixed Orders
The convolution $\operatorname{conv}(\operatorname{birth}(b), \operatorname{density})$ produces the mixed ramp $\operatorname{mixedRamp}(b, v) = \mathbf{1}_{v \ge b}(e^{v/2 - b} - e^{-v/2})$.
Applying the filter kernel $e^{-3(s-v)/2}$ yields $\frac{1}{2}(e^{s/2 - b} - e^{b - 3s/2})$.
Summing the symmetric order doubles the result:
$$
e^{s/2 - b} - e^{b - 3s/2} = e^{-3s/2} \frac{e^{2s} - e^{2b}}{e^b}.
$$
Substituting $e^b = p^j$ yields $\log p \frac{e^{2s} - (p^j)^2}{p^j}$.

### 2.3. Density Self-Convolution
For $\operatorname{conv}(\operatorname{density}, \operatorname{density})(v) = v e^{v/2} - 2(e^{v/2} - 1)$, integrating against $e^{-3(s-v)/2}$ over $[0, s]$ via integration by parts yields $e^{-3s/2} (\frac{s e^{2s}}{2} + \frac{e^{2s}}{4} - \frac{1}{4})$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeDensityFilter`):
```lean
theorem prime_power_pair_evaluation {p q : ℕ} (hp : p.Prime) (hq : q.Prime)
    (j k : ℕ) {s : ℝ} (hs : 0 ≤ s) :
    (Real.log p * Real.log q) *
      L0 (conv (birth ((j : ℝ)*Real.log p)) (birth ((k : ℝ)*Real.log q))) s =
    if (p : ℝ)^j * (q : ℝ)^k ≤ Real.exp s then
      Real.exp (-3*s/2) * (Real.exp s - (p : ℝ)^j*(q : ℝ)^k) *
        Real.log p * Real.log q else 0

theorem prime_power_mixed_evaluation {p : ℕ} (hp : p.Prime) (j : ℕ)
    {s : ℝ} (hs : 0 ≤ s) :
    Real.log p * (L0 (conv (birth ((j : ℝ)*Real.log p)) density) s +
      L0 (conv density (birth ((j : ℝ)*Real.log p))) s) =
    if (p : ℝ)^j ≤ Real.exp s then
      Real.exp (-3*s/2) * Real.log p *
        (Real.exp (2*s) - ((p : ℝ)^j)^2) / (p : ℝ)^j else 0

theorem density_square_normalized {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv density density) s = Real.exp (-3*s/2) *
      (Real.exp (2*s) * s/2 + Real.exp (2*s)/4 - 1/4)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior literature comparison:** The page formalizes the stated three-part convolution decomposition in Lean 4. Priority among formalizations is not established by this audit.
- **Advancement:** Establishes exact non-asymptotic integral evaluations for each of the three components of $V(x)$.
- **Target Venues:** *Journal of Number Theory* or *Advances in Applied Mathematics*.
