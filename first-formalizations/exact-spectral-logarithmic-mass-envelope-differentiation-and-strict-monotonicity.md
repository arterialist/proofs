# First Formalization: Exact Spectral Logarithmic Mass Envelope Differentiation and Strict Monotonicity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/LogarithmicMassEnvelope.lean`](../../formalization/BuildingBlocks/LogarithmicMassEnvelope.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact classical derivative and strict monotonicity of the spectral logarithmic mass envelope $E_A(h) = h(1 + \log(1 + A/h))$ in Lean 4:

1. **Exact Scale Derivative Formula:**
   Formal proof that $\frac{d}{dh} E_A(h) = 1 + \log(1 + A/h) - \frac{A}{A+h}$ (`hasDerivAt_envelope`).
2. **Strict Derivative Positivity:**
   Formal proof that $1 + \log(1 + A/h) - \frac{A}{A+h} > 0$ for all $A \ge 0$ and $h > 0$ (`envelope_derivative_pos`).
3. **Strict Monotonicity on $(0, \infty)$:**
   Formal proof of `StrictMonoOn (envelope A) (Set.Ioi 0)` via derivative positivity on convex domains (`envelope_strictMonoOn`).
4. **Scale Monotonicity Bound:**
   Formal proof that $0 < h \le H \implies E_A(h) \le E_A(H)$ (`envelope_le`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact derivative of the logarithmic envelope
lemma hasDerivAt_envelope {A h : ℝ} (hA : 0 ≤ A) (hh : 0 < h) :
    HasDerivAt (envelope A)
      (1 + Real.log (1 + A / h) - A / (A + h)) h

-- Strict positivity of the envelope derivative
lemma envelope_derivative_pos {A h : ℝ} (hA : 0 ≤ A) (hh : 0 < h) :
    0 < 1 + Real.log (1 + A / h) - A / (A + h)

-- Strict monotonicity on (0, ∞)
theorem envelope_strictMonoOn {A : ℝ} (hA : 0 ≤ A) :
    StrictMonoOn (envelope A) (Set.Ioi 0)

-- Monotonicity bound between scales
theorem envelope_le {A h H : ℝ} (hA : 0 ≤ A) (hh : 0 < h)
    (hH : h ≤ H) : envelope A h ≤ envelope A H
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 computing the exact classical derivative and proving the unconditional strict monotonicity of the logarithmic mass envelope $h(1 + \log(1 + A/h))$ without asymptotic approximations.
