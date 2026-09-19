# First Formalization: Exact Same-Prime Block Calibration and Proper-Power Multiplicity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeBlockCalibration.lean`](../../formalization/BuildingBlocks/SamePrimeBlockCalibration.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the finite exponent partition duality identity, the moving cutoff freezing theorem, the exact filtered prime block autoconvolution, and the master all-prime diagonal calibration identity $\sum_p \mathcal{L}_0(\text{primeBlock}_p * \text{primeBlock}_p) = \tau(s)$ in Lean 4:

1. **Partition Summation Identity:**
   Formal proof that $\sum_{j=1}^N \sum_{k=1}^N F(j+k) = \sum_{m=2}^N (m - 1) F(m)$ for sequences vanishing beyond $N$ (`sum_pairs_by_total`).
2. **Moving Cutoff Freezing:**
   Formal proof that $\text{primeBlock}_p(v) = \text{block}_{\lfloor e^s \rfloor}(p, v)$ on $[0, s]$ (`actual_convolution_eq_block`).
3. **Filtered Prime Block Formula:**
   Formal proof that $\mathcal{L}_0(\text{primeBlock}_p * \text{primeBlock}_p)(s) = \sum_{m=2}^{\lfloor e^s \rfloor} \frac{(m-1)\log^2 p}{\sqrt{p^m}} \theta(s - m\log p)$ (`filtered_primeBlock_by_total`).
4. **Master All-Prime Calibration:**
   Formal proof that the sum of all filtered prime blocks equals $\tau(s)$ unconditionally (`actual_tau_calibration`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Partition summation identity via constructive bijection
theorem sum_pairs_by_total (N : ℕ) (F : ℕ → ℝ)
    (hzero : ∀ m, N < m → F m = 0) :
    (∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N, F (j + k)) =
      ∑ m ∈ Finset.Icc 2 N, ((m - 1 : ℕ) : ℝ) * F m

-- Moving cutoff freezing
theorem actual_convolution_eq_block {p : ℕ} (hp : p.Prime) {s v : ℝ}
    (hv : v ∈ Icc 0 s) :
    (∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) =
      ∫ u in 0..v, block ⌊Real.exp s⌋₊ p u * block ⌊Real.exp s⌋₊ p (v - u)

-- Filtered prime block formula
theorem filtered_primeBlock_by_total {p : ℕ} (hp : p.Prime) {s : ℝ} (hs : 0 ≤ s) :
    L0 (fun v => ∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) s =
      ∑ m ∈ Finset.Icc 2 ⌊Real.exp s⌋₊,
        SamePrimeHistoryResidual.weight p m * theta (s - (m : ℝ) * Real.log p)

-- Master all-prime diagonal calibration
theorem actual_tau_calibration {s : ℝ} (hs : 0 ≤ s) :
    (∑ p ∈ Finset.Icc 2 ⌊Real.exp s⌋₊, if p.Prime then
      L0 (fun v => ∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) s else 0) = tau s
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing that the spectral diagonal $\tau(s)$ coincides identically with the sum of all filtered autoconvolutions of individual prime-power blocks, with exact proper-power multiplicities derived combinatorially without approximation.
