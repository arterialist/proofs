# Contribution 152: Exact Hyperbola Product Grouping and Sub-Root Möbius Annihilation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/HyperbolaProduct.lean`](../../formalization/BuildingBlocks/HyperbolaProduct.lean), [`building-blocks/successor-and-division/hyperbola-product.md`](../../building-blocks/successor-and-division/hyperbola-product.md)  
**Classification:** Analytic Number Theory / Dirichlet Hyperbola Method / Möbius Inversion / Factor Pair Bijections / Sub-Root Annihilation

---

## 1. Executive Summary and Mathematical Statement

The Dirichlet hyperbola method partitions regions of the form $\{(a, b) : a b \le N\}$ into symmetric domains. When evaluating weighted Möbius sums over hyperbola regions, regrouping the double sum by the product variable $k = ab$ produces effective arithmetic coefficients $c_N(k) = \sum_{d \mid k, \, k^2 \le Nd} \mu(d)$. 

This contribution proves:

1. **Exact Factor-Pair Bijection:**  
   For any commutative monoid $R$ and bivariate function $f: \mathbb{N} \to \mathbb{N} \to R$:
   $$
   \sum_{n=1}^N \sum_{d \mid n} f(d, n/d) = \sum_{a=1}^N \sum_{b=1}^{\lfloor N/a \rfloor} f(a, b).
   $$
2. **Sub-Root Annihilation of Hyperbola Coefficients:**  
   For any integer truncation $N$ and product index $k$, the hyperbola coefficient $c_N(k) = \sum_{d \mid k, \, k^2 \le Nd} \mu(d)$ satisfies:
   $$
   c_N(k) = \mathbf{1}_{k=1} \quad \text{for all } k \le \sqrt{N}.
   $$
   That is, for every $2 \le k \le \sqrt{N}$, $c_N(k) = 0$ identically!
3. **Complementary Cutoff Formula:**  
   For every $k \ge 2$:
   $$
   c_N(k) = - \sum_{d \mid k, \, Nd < k^2} \mu(d).
   $$
4. **Exact Weighted Hyperbola Product Identity:**  
   For an arbitrary real weight function $w: \mathbb{N} \to \mathbb{R}$:
   $$
   \sum_{k=1}^N c_N(k) w(k) = \sum_{n=1}^N \mu(n) \sum_{m=1}^{\lfloor \sqrt{N/n} \rfloor} w(nm).
   $$

---

## 2. Mathematical Proof

### 2.1. Factor-Pair Bijection
We construct the explicit mapping between the dependent pair $(n, d)$ with $1 \le n \le N, d \mid n$ and the product pair $(a, b)$ with $1 \le a \le N, 1 \le b \le \lfloor N/a \rfloor$:
$$
\Phi(n, d) = (d, n/d).
$$
Its two-sided inverse is given by $\Psi(a, b) = (ab, a)$.
Since $d \mid n$ and $1 \le n \le N$, $1 \le d \le N$ and $1 \le n/d \le \lfloor N/d \rfloor$. Conversely, for any $1 \le a \le N$ and $1 \le b \le \lfloor N/a \rfloor$, $ab \le N$ and $a \mid ab$. Thus $\Phi$ is a bijection of finite index sets.

### 2.2. Sub-Root Annihilation
When $k^2 \le N$, for every positive divisor $d \mid k$, we have $d \ge 1$, so $N \le Nd$.
Therefore:
$$
k^2 \le N \le Nd \quad \text{for every divisor } d \mid k.
$$
The condition $k^2 \le Nd$ in the sum defining $c_N(k)$ is trivially satisfied for all $d \mid k$:
$$
c_N(k) = \sum_{d \mid k} \mu(d).
$$
By the fundamental identity of Möbius inversion $\sum_{d \mid k} \mu(d) = \mathbf{1}_{k=1}$, we have $c_N(1) = 1$ and $c_N(k) = 0$ for all $2 \le k \le \sqrt{N}$.

### 2.3. Complementary Cutoff
For any $k \ge 2$, $\sum_{d \mid k} \mu(d) = 0$.
Splitting the sum into divisors satisfying $k^2 \le Nd$ and divisors satisfying $Nd < k^2$:
$$
\sum_{d \mid k, \, k^2 \le Nd} \mu(d) + \sum_{d \mid k, \, Nd < k^2} \mu(d) = \sum_{d \mid k} \mu(d) = 0.
$$
Thus $c_N(k) = -\sum_{d \mid k, \, Nd < k^2} \mu(d)$.

### 2.4. Weighted Hyperbola Product Identity
Consider the bivariate function $f(n, m) = \mathbf{1}_{(nm)^2 \le Nn} \mu(n) w(nm)$.
Applying the factor-pair bijection to $k = nm$:
$$
\sum_{k=1}^N c_N(k) w(k) = \sum_{k=1}^N \sum_{d \mid k} f(d, k/d) = \sum_{n=1}^N \sum_{m=1}^{\lfloor N/n \rfloor} f(n, m).
$$
The condition $(nm)^2 \le Nn$ simplifies by dividing by $n > 0$ to $n m^2 \le N$, which is equivalent to $m^2 \le N/n$, or $m \le \lfloor \sqrt{N/n} \rfloor$.
Filtering the inner sum over $m$ from $1 \le m \le \lfloor N/n \rfloor$ to $1 \le m \le \lfloor \sqrt{N/n} \rfloor$:
$$
\sum_{k=1}^N c_N(k) w(k) = \sum_{n=1}^N \mu(n) \sum_{m=1}^{\lfloor \sqrt{N/n} \rfloor} w(nm).
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.HyperbolaProduct` in `formalization/BuildingBlocks/HyperbolaProduct.lean`):
```lean
theorem sum_divisors_eq_sum_factor_pairs {R : Type*} [AddCommMonoid R]
    (N : ℕ) (f : ℕ → ℕ → R) :
    ∑ n ∈ Finset.Icc 1 N, ∑ d ∈ n.divisors, f d (n / d) =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a), f a b

theorem moebius_divisor_sum (n : ℕ) :
    ∑ d ∈ n.divisors, ArithmeticFunction.moebius d = if n = 1 then 1 else 0

theorem hyperbolaProductCoefficient_small {N k : ℕ} (hk : k * k ≤ N) :
    hyperbolaProductCoefficient N k = if k = 1 then 1 else 0

theorem hyperbolaProductCoefficient_complement {N k : ℕ} (hk : k ≠ 1) :
    hyperbolaProductCoefficient N k =
      -(∑ d ∈ k.divisors, if N * d < k * k then ArithmeticFunction.moebius d else 0)

theorem hyperbolaProductCoefficient_weighted_sum (N : ℕ) (w : ℕ → ℝ) :
    (∑ k ∈ Icc 1 N, (hyperbolaProductCoefficient N k : ℝ) * w k) =
      ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        ∑ m ∈ Icc 1 (N / n).sqrt, w (n * m)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet hyperbola method and Vaughan's identity (Dirichlet 1849, Vaughan 1977). In typical analytic number theory texts, the square-root hyperbola cutoff is treated via boundary splits rather than an exact product-indexed arithmetic coefficient identity with sub-root vanishing.
- **Advancement:** Machine-checked exact algebra of hyperbola product coefficients and sub-root annihilation in Lean 4.
- **Target Venues:** *Discrete Mathematics* or *Journal of Number Theory*.
