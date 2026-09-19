# First Formalization: Exact Same-Prime Birth Convolution and Filtered Partition Multiplicity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeBirthConvolution.lean`](../../formalization/BuildingBlocks/SamePrimeBirthConvolution.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact continuous convolution of delayed prime birth histories, its transformation under the canonical causal filter $\mathcal{L}_0$, and the exact partition multiplicity identity for prime-power pairs in Lean 4:

1. **Birth History Convolution:**
   Formal proof that $\int_0^s \text{birth}_b(u) \text{birth}_c(s-u) \, du = \text{ramp}_{b+c}(s)$ (`birth_convolution`).
2. **Filter Action on Ramp Signals:**
   Formal proof that $\mathcal{L}_0(\text{ramp}_d)(s) = e^{-d/2} \theta(s - d)$ (`filtered_ramp`).
3. **Filtered Convolution Identity:**
   Formal proof that $\mathcal{L}_0(\text{birth}_b * \text{birth}_c)(s) = e^{-(b+c)/2}\theta(s - (b+c))$ (`filtered_birth_convolution`).
4. **Exponent Partition Multiplicity:**
   Formal proof that summing over all pairs $(j, m-j)$ yields $(m-1) e^{-m\ell/2}\theta(s - m\ell)$ (`filtered_pairs_by_total`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact birth convolution
theorem birth_convolution {b c s : ℝ} (hb : 0 ≤ b) (hc : 0 ≤ c) (hs : 0 ≤ s) :
    (∫ u in 0..s, birth b u * birth c (s - u)) = ramp (b + c) s

-- Causal filter on ramp
theorem filtered_ramp {d s : ℝ} (hd : 0 ≤ d) (hs : 0 ≤ s) :
    L0 (ramp d) s = Real.exp (-d / 2) * theta (s - d)

-- Filtered birth convolution
theorem filtered_birth_convolution {b c s : ℝ} (hb : 0 ≤ b) (hc : 0 ≤ c) (hs : 0 ≤ s) :
    L0 (fun v => ∫ u in 0..v, birth b u * birth c (v - u)) s =
      Real.exp (-(b + c) / 2) * theta (s - b - c)

-- Partition multiplicity identity
theorem filtered_pairs_by_total {ell s : ℝ} (hell : 0 ≤ ell) (hs : 0 ≤ s)
    {m : ℕ} (hm : 2 ≤ m) :
    (∑ j ∈ Finset.Icc 1 (m - 1),
      L0 (fun v => ∫ u in 0..v, birth ((j : ℝ) * ell) u *
        birth (((m - j : ℕ) : ℝ) * ell) (v - u)) s) =
      ((m - 1 : ℕ) : ℝ) * (Real.exp (-((m : ℝ) * ell) / 2) * theta (s - (m : ℝ) * ell))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving that continuous renewal convolutions of delayed prime birth histories map under causal Volterra filtering to exact partition-multiplicity weighted shifted responses $(m-1)e^{-m\ell/2}\theta(s - m\ell)$.
