# Unique Contribution 164: Exact Distinct-Prime Riesz-Dirichlet Mellin Representation and Proper-Power Reindexing

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/DistinctPrimeRieszMellin.lean`](../../formalization/BuildingBlocks/DistinctPrimeRieszMellin.lean), [`building-blocks/mellin/distinct-prime-riesz-mellin.md`](../../building-blocks/mellin/distinct-prime-riesz-mellin.md)  
**Classification:** Analytic Number Theory / Dirichlet Series / Mellin Transforms / Prime-Power Reindexing / Riesz Typical Means / Same-Prime Diagonals

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of prime-pair correlations, isolating the off-diagonal terms where two prime powers originate from distinct primes is essential to avoid diagonal singularities. In standard analytic number theory, this separation is often done heuristically.

This contribution proves:

1. **Bijective Prime-Power Reindexing of Same-Prime Diagonals:**  
   The arithmetic function labeling proper prime powers $\text{primePowerLabel}(p, k) = p^{k+2}$ is strictly injective from $\mathcal{P} \times \mathbb{N}$ to $\mathbb{N}$. Every same-prime pair coefficient vanishes outside the range of this map:
   \[
   n \notin \text{range}(\text{primePowerLabel}) \implies \text{samePair}(n) = 0.
   \]
2. **Exact Same-Prime Dirichlet Series Identity:**  
   For all $\text{Re}(s) > 1/2$, the Dirichlet series of the same-prime coefficients converges absolutely and evaluates identically to:
   \[
   \sum_{n=1}^\infty \frac{\text{samePair}(n)}{n^s} = H(s) = \sum_{p \in \mathcal{P}} \frac{\log^2 p}{(p^s - 1)^2}.
   \]
3. **Exact Distinct-Prime Dirichlet Series Identity:**  
   For all $\text{Re}(s) > 1$, the Dirichlet series of the distinct-prime convolution pair evaluates to:
   \[
   \sum_{n=1}^\infty \frac{\Lambda_{\text{distinct}, 2}(n)}{n^s} = \left( -\frac{\zeta'(s)}{\zeta(s)} \right)^2 - H(s),
   \]
   where $\Lambda_{\text{distinct}, 2}(n) = \sum_{d \mid n, \gcd(d, n/d) = 1} \Lambda(d)\Lambda(n/d)$.
4. **Exact Riesz Cutoff Mellin Transform:**  
   For all $\text{Re}(s) > 1$, the Mellin transform of the discrete distinct-prime Riesz cutoff sum evaluates in closed form to:
   \[
   \mathcal{M}\left( \sum_{n \le x} (x - n)\Lambda_{\text{distinct}, 2}(n) \right)(-s-1) = \frac{\left( -\frac{\zeta'(s)}{\zeta(s)} \right)^2 - H(s)}{s(s+1)}.
   \]

---

## 2. Mathematical Proof

### 2.1. Bijective Reindexing and Same-Prime Series
A pair of prime powers $p^j$ and $q^k$ share the same base prime if and only if $p = q$. In this case, their product is $p^{j+k}$ with weight $\log^2 p$.
Setting $m = j + k$, since $j, k \ge 1$, we have $m \ge 2$. There are $(m - 1)$ ways to express $m$ as a sum of two positive integers, so the coefficient at $n = p^m$ is $(m - 1)\log^2 p$.
Under the bijective labeling $(p, k) \mapsto p^{k+2}$ with $k = m - 2 \ge 0$:
\[
\sum_{n=1}^\infty \frac{\text{samePair}(n)}{n^s} = \sum_{p \in \mathcal{P}} \log^2 p \sum_{k=0}^\infty \frac{k+1}{p^{(k+2)s}}.
\]
Summing the geometric derivative series:
\[
\sum_{k=0}^\infty (k+1) u^k = \frac{1}{(1-u)^2} \quad (|u| < 1),
\]
with $u = p^{-s}$ (which satisfies $|u| = p^{-\text{Re}(s)} < p^{-1/2} < 1$ for $\text{Re}(s) > 1/2$):
\[
p^{-2s} \sum_{k=0}^\infty (k+1) p^{-ks} = \frac{p^{-2s}}{(1 - p^{-s})^2} = \frac{1}{(p^s - 1)^2}.
\]
Thus, the sum equals $\sum_p \frac{\log^2 p}{(p^s - 1)^2} = H(s)$, converging absolutely on $\text{Re}(s) > 1/2$.

### 2.2. Full and Distinct-Prime Dirichlet Series
The full pair is the Dirichlet convolution $\Lambda * \Lambda$. By the convolution theorem for $L$-series, its Dirichlet series is the square of the logarithmic derivative of $\zeta(s)$:
\[
\sum_{n=1}^\infty \frac{(\Lambda * \Lambda)(n)}{n^s} = \left( -\frac{\zeta'(s)}{\zeta(s)} \right)^2 \quad (\text{Re}(s) > 1).
\]
Since $\Lambda_{\text{distinct}, 2} = \Lambda * \Lambda - \text{samePair}$, subtracting the two absolutely convergent series on $\text{Re}(s) > 1$ yields:
\[
\sum_{n=1}^\infty \frac{\Lambda_{\text{distinct}, 2}(n)}{n^s} = \left( -\frac{\zeta'(s)}{\zeta(s)} \right)^2 - H(s).
\]

### 2.3. Riesz-Dirichlet Mellin Transform
Applying Perron's formula / the Riesz-Dirichlet Mellin integration theorem (`RieszDirichlet.hasMellin_cutoffSum`):
If $\sum c_n n^{-s}$ converges absolutely to $A(s)$ on $\text{Re}(s) > \sigma_0 > 0$, then for all $\text{Re}(s) > \sigma_0$:
\[
\mathcal{M}\left( \sum_{n \le x} (x - n) c_n \right)(-s-1) = \frac{A(s)}{s(s+1)}.
\]
Substituting $c_n = \Lambda_{\text{distinct}, 2}(n)$ and $A(s) = (-\zeta'/\zeta)^2 - H(s)$ produces the exact result.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.DistinctPrimeRieszMellin` in `formalization/BuildingBlocks/DistinctPrimeRieszMellin.lean`):
```lean
theorem fullPair_hasSum {s : ℂ} (hs : 1 < s.re) :
    LSeriesHasSum fullPair s ((-deriv riemannZeta s / riemannZeta s) ^ 2)

theorem primePowerLabel_injective : Function.Injective primePowerLabel

theorem samePair_hasSum {s : ℂ} (hs : 1 / 2 < s.re) :
    LSeriesHasSum samePair s (SamePrimeDirichlet.H s)

theorem distinctPair_hasSum {s : ℂ} (hs : 1 < s.re) :
    LSeriesHasSum distinctPair s
      ((-deriv riemannZeta s / riemannZeta s) ^ 2 - SamePrimeDirichlet.H s)

theorem hasMellin_distinctPrime_cutoffSum {s : ℂ} (hs : 1 < s.re) :
    HasMellin (RieszDirichlet.cutoffSum distinctPair) (-s - 1)
      (((-deriv riemannZeta s / riemannZeta s) ^ 2 - SamePrimeDirichlet.H s) /
        (s * (s + 1)))

theorem distinctPair_eq_coprime_sum (n : ℕ) : distinctPair n =
    ∑ d ∈ n.divisors, if d.Coprime (n / d) then lambda d * lambda (n / d) else 0

theorem cutoffSum_distinctPair_eq_Icc {x : ℝ} (hx : 0 ≤ x) :
    RieszDirichlet.cutoffSum distinctPair x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, ((x - n : ℝ) : ℂ) * (distinctPrimePairWeight n : ℂ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Classical studies of prime pairs (Hardy-Littlewood 1923, Goldston-Montgomery 1987). Prior formal libraries lacked machine-verified proofs of prime-power reindexing bijections and the exact Riesz-Dirichlet Mellin transform of distinct-prime correlations.
- **Advancement:** Establishes the exact Dirichlet series and Mellin transform for distinct prime-power pairs with certified bijective reindexing and zero custom axioms in Lean 4.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
