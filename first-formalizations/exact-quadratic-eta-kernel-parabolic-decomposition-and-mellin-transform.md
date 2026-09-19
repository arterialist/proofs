# First Formalization: Exact Quadratic Eta-Kernel Parabolic Decomposition and Mellin Transform

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/EtaRieszKernel.lean`](../../formalization/BuildingBlocks/EtaRieszKernel.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact parabolic decomposition of the quadratic eta kernel into a linear Riesz tent plus quadratic excess, proves its algebraic factorization, evaluates its Mellin transform $\frac{a^{-s}}{(s-1)(s+1)}$ on $\text{Re}(s) > 1$, and establishes the exact real $L^1$ norm formula in Lean 4:

1. **Parabolic Excess Decomposition:**
   Formal proof that $K_\eta(a, x) = \text{tent}_a(x) + \frac{(\max(x - a, 0))^2}{2a}$ (`kernel_eq_tent_add_square`).
2. **Algebraic Factorization:**
   Formal proof that $\frac{x^2 - a^2}{2a} x^{-s-2} = \frac{1}{2a}(x^{-s} - a^2 x^{-s-2})$ (`kernel_power_eq`).
3. **Mellin Transform on $(a, \infty)$:**
   Formal proof of integrability (`integrableOn_kernel_power`) and closed-form Mellin integral $\frac{a^{-s}}{(s-1)(s+1)}$ (`integral_kernel_power`).
4. **Continuous Mellin Assertion:**
   Formal proof that $\mathcal{M}(K_\eta(a, \cdot))(-s-1) = \frac{a^{-s}}{(s-1)(s+1)}$ on $\text{Re}(s) > 1$ (`hasMellin_kernel`).
5. **Exact Real $L^1$ Norm Formula:**
   Formal proof that the $L^1$ norm integral equals $\frac{a^{-\text{Re}(s)}}{(\text{Re}(s) - 1)(\text{Re}(s) + 1)}$ (`integral_norm_kernel`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Support vanishing
theorem kernel_eq_zero {a x : ℝ} (hx : x ≤ a) : kernel a x = 0

-- Exact decomposition into linear tent + quadratic excess
theorem kernel_eq_tent_add_square {a : ℝ} (ha : 0 < a) (x : ℝ) :
    kernel a x = RieszTentMellin.tent a x +
      (((max (x - a) 0) ^ 2 / (2 * a) : ℝ) : ℂ)

-- Integrability and closed-form evaluation
theorem integrableOn_kernel_power {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) *
      (x : ℂ) ^ (-s - 2)) (Ioi a)

theorem hasMellin_kernel {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    HasMellin (kernel a) (-s - 1) ((a : ℂ) ^ (-s) / ((s - 1) * (s + 1)))

-- Exact real L¹ norm integral
theorem integral_norm_kernel {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi 0, ‖(x : ℂ) ^ (-s - 2) * kernel a x‖) =
      a ^ (-s.re) / ((s.re - 1) * (s.re + 1))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that the quadratic birth kernel decomposes into the Riesz linear mean plus quadratic excess and computing its exact Mellin transform and $L^1$ norm in closed form.
