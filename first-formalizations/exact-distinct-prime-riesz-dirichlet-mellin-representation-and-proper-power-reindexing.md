# First Formalization: Exact Distinct-Prime Riesz-Dirichlet Mellin Representation and Proper-Power Reindexing

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/DistinctPrimeRieszMellin.lean`](../../formalization/BuildingBlocks/DistinctPrimeRieszMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the Dirichlet series of the full Mangoldt convolution, the bijective reindexing of same-prime proper powers, the exact evaluation of the same-prime Dirichlet series $H(s)$ on $\text{Re}(s) > 1/2$, the distinct-prime Dirichlet series on $\text{Re}(s) > 1$, and its Riesz cutoff Mellin transform in Lean 4:

1. **Full Pair Dirichlet Series:**
   Formal proof that $\sum (\Lambda * \Lambda)(n) n^{-s} = (-\zeta'/\zeta)^2$ (`fullPair_hasSum`).
2. **Proper Prime-Power Bijective Reindexing:**
   Formal proof that $(p, k) \mapsto p^{k+2}$ is injective on $\mathcal{P} \times \mathbb{N}$ (`primePowerLabel_injective`).
3. **Same-Prime Dirichlet Series:**
   Formal proof that $\sum \text{samePair}(n) n^{-s} = H(s) = \sum_p \frac{\log^2 p}{(p^s - 1)^2}$ on $\text{Re}(s) > 1/2$ (`samePair_hasSum`).
4. **Distinct-Prime Dirichlet Series:**
   Formal proof that $\sum \Lambda_{\text{distinct}, 2}(n) n^{-s} = (-\zeta'/\zeta)^2 - H(s)$ on $\text{Re}(s) > 1$ (`distinctPair_hasSum`).
5. **Exact Riesz Cutoff Mellin Transform:**
   Formal proof of the Mellin transform of the distinct-prime Riesz cutoff sum (`hasMellin_distinctPrime_cutoffSum`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Full Mangoldt convolution Dirichlet series
theorem fullPair_hasSum {s : ℂ} (hs : 1 < s.re) :
    LSeriesHasSum fullPair s ((-deriv riemannZeta s / riemannZeta s) ^ 2)

-- Injective reindexing of proper prime powers
theorem primePowerLabel_injective : Function.Injective primePowerLabel

-- Same-prime diagonal Dirichlet series on Re(s) > 1/2
theorem samePair_hasSum {s : ℂ} (hs : 1 / 2 < s.re) :
    LSeriesHasSum samePair s (SamePrimeDirichlet.H s)

-- Distinct-prime Dirichlet series on Re(s) > 1
theorem distinctPair_hasSum {s : ℂ} (hs : 1 < s.re) :
    LSeriesHasSum distinctPair s
      ((-deriv riemannZeta s / riemannZeta s) ^ 2 - SamePrimeDirichlet.H s)

-- Riesz cutoff Mellin transform
theorem hasMellin_distinctPrime_cutoffSum {s : ℂ} (hs : 1 < s.re) :
    HasMellin (RieszDirichlet.cutoffSum distinctPair) (-s - 1)
      (((-deriv riemannZeta s / riemannZeta s) ^ 2 - SamePrimeDirichlet.H s) /
        (s * (s + 1)))

-- Coprime divisor expansion
theorem distinctPair_eq_coprime_sum (n : ℕ) : distinctPair n =
    ∑ d ∈ n.divisors, if d.Coprime (n / d) then lambda d * lambda (n / d) else 0

-- Finite interval cutoff formula
theorem cutoffSum_distinctPair_eq_Icc {x : ℝ} (hx : 0 ≤ x) :
    RieszDirichlet.cutoffSum distinctPair x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, ((x - n : ℝ) : ℂ) * (distinctPrimePairWeight n : ℂ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact Dirichlet series and Mellin transform of distinct prime-power pairs via bijective prime-power reindexing and same-prime diagonal subtraction.
