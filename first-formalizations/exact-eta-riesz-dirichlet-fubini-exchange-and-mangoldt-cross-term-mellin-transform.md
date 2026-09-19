# First Formalization: Exact Eta-Riesz-Dirichlet Fubini Exchange and Mangoldt Cross-Term Mellin Transform

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/EtaRieszDirichlet.lean`](../../formalization/BuildingBlocks/EtaRieszDirichlet.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the equivalence between infinite series of truncated quadratic eta kernels and finite cutoff sums, proves the general Fubini exchange theorem for Mellin transforms of Dirichlet sequences, and evaluates the exact Mellin transform of the von Mangoldt cross term in Lean 4:

1. **Finite Truncation Equivalence:**
   Formal proof that $K_\eta(n+1, x) = 0$ for $n \ge \lfloor x \rfloor$ (`kernel_eq_zero_outside_cutoff`) and that the infinite series reduces to the finite cutoff sum (`tsum_tents_eq_cutoff`).
2. **General Dirichlet Cutoff Mellin Transform:**
   Formal proof that $\sum \|c(n+1)\| (n+1)^{-\sigma} < \infty \implies \mathcal{M}(S_c)(-s-1) = \frac{\sum c(n) n^{-s}}{(s-1)(s+1)}$ (`hasMellin_cutoffSum`).
3. **Von Mangoldt Cross-Term Evaluation:**
   Formal proof that $\mathcal{M}(\text{crossTerm})(-s-1) = \frac{-\zeta'(s)/\zeta(s)}{(s-1)(s+1)}$ on $\text{Re}(s) > 1$ (`hasMellin_crossTerm`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Truncation outside floor interval
theorem kernel_eq_zero_outside_cutoff (x : ℝ) {n : ℕ}
    (hn : n ∉ Finset.range ⌊x⌋₊) : EtaRieszKernel.kernel (n + 1) x = 0

-- Reduction of infinite series to finite cutoff sum
theorem tsum_tents_eq_cutoff (c : ℕ → ℂ) (x : ℝ) :
    (∑' n : ℕ, c (n + 1) * EtaRieszKernel.kernel (n + 1) x) = cutoffSum c x

-- General Fubini-justified Dirichlet Mellin formula
theorem hasMellin_cutoffSum (c : ℕ → ℂ) {s : ℂ} (hs : 1 < s.re)
    (hc : Summable (fun n : ℕ => ‖c (n + 1)‖ * (n + 1 : ℝ) ^ (-s.re))) :
    HasMellin (cutoffSum c) (-s - 1)
      ((∑' n : ℕ, c (n + 1) * ((n + 1 : ℝ) : ℂ) ^ (-s)) / ((s - 1) * (s + 1)))

-- Von Mangoldt cross-term Mellin transform
theorem hasMellin_crossTerm {s : ℂ} (hs : 1 < s.re) :
    HasMellin crossTerm (-s-1)
      ((-deriv riemannZeta s / riemannZeta s) / ((s-1)*(s+1)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the general Fubini exchange theorem for truncated quadratic eta kernels and evaluating the exact continuous Mellin transform of the von Mangoldt cross term.
