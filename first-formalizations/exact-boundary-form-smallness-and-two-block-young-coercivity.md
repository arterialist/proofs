# First Formalization: Exact Boundary Form-Smallness and Two-Block Young Coercivity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/BoundaryFormSmallness.lean`](../../formalization/BuildingBlocks/BoundaryFormSmallness.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the relative form-smallness of boundary ports under growing logarithmic coercivity, explicit cutoff selection, and two-block Young parameter majorization in Lean 4:

1. **Relative Port Coercivity Bound:**
   Formal derivation of $\mathfrak{q}_{\text{port}} \le \frac{P}{cS} \mathfrak{q}_{\text{supply}}$ (`tail_port_relative_bound`).
2. **Cutoff Scale Selection:**
   Formal proof of $P/(cS) \le \eta$ for $S \ge P/(c\eta)$ (`cutoff_for_relative_bound`).
3. **Two-Block Young Coercivity:**
   Formal derivation of the $(1+\varepsilon)$ core and $(1+1/\varepsilon)$ tail majorant (`two_block_port_upper`).
4. **Subspace Restriction Invariance:**
   Formal proof that form-smallness bounds transfer to subdomains without changing constants (`restrict_form_smallness`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Relative port form-smallness from tail coercivity
theorem tail_port_relative_bound
    {port supply normSq P c S : ℝ}
    (hP : 0 ≤ P) (hc : 0 < c) (hS : 0 < S)
    (hport : port ≤ P * normSq)
    (hsupply : c * S * normSq ≤ supply) :
    port ≤ (P / (c * S)) * supply

-- Logarithmic cutoff selection for arbitrary eta > 0
theorem cutoff_for_relative_bound
    {P c eta S : ℝ}
    (hP : 0 ≤ P) (hc : 0 < c) (heta : 0 < eta)
    (hS : P / (c * eta) ≤ S) :
    P / (c * S) ≤ eta

-- Two-block Cauchy-Young upper estimate
theorem two_block_port_upper
    {core tail mixed total eps : ℝ}
    (hmixed : 2 * mixed ≤ eps * core + (1 / eps) * tail)
    (htotal : total = core + tail + 2 * mixed) :
    total ≤ (1 + eps) * core + (1 + 1 / eps) * tail

-- Invariance under subspace restriction
theorem restrict_form_smallness
    {V : Type*} (port supply normSq : V → ℝ) (K : V → Prop)
    (eta C : ℝ)
    (h : ∀ x, port x ≤ eta * supply x + C * normSq x) :
    ∀ x, K x → port x ≤ eta * supply x + C * normSq x
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing explicit logarithmic cutoff tuning and two-block Young parameter estimation for Kato relative form-smallness in perturbed quadratic forms.
