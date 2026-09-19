# First Formalization: Exact Completed Zeta Circle Pole Cancellation and Xi Contour Equivalence

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompletedZetaPoleCorrections.lean`](../../formalization/BuildingBlocks/CompletedZetaPoleCorrections.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact circle contour integration identities connecting $\Lambda'/\Lambda$ to $\xi'/\xi$, proving complete cancellation of the polar residues at $s=0$ and $s=1$ via vanishing Mellin boundary moments in Lean 4:

1. **Logarithmic Derivative Pole Corrections:**
   Formal proof of `completed_log_derivative_corrections`: $\Lambda'/\Lambda = \xi'/\xi - 1/s - 1/(s-1)$.
2. **General Circle Contour Correction Theorem:**
   Formal proof of `entire_completed_circle_corrections`: Evaluating the polar residues via Cauchy's integral formula to yield the boundary correction $-(2\pi i)(F(0) + F(1))$.
3. **Grand Pole Cancellation Theorem:**
   Formal proof of `pole_null_completed_circle`: When test function $f$ satisfies $\mathcal{M}[f](\pm 1/2) = 0$, the polar residues vanish and $\oint F \Lambda'/\Lambda = \oint F \xi'/\xi$.
4. **Finite Euler-Product Block Invariance:**
   Formal proof of `finite_block_pole_null_completed_circle`: Extension of the pole-null identity to finite Euler-product approximations with $M$ blocks.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Logarithmic derivative pole decomposition
theorem completed_log_derivative_corrections (s : ℂ) (hs0 : s ≠ 0) (hs1 : s ≠ 1)
    (hx : xi s ≠ 0) :
    logDeriv completedRiemannZeta s = logDeriv xi s - 1 / s - 1 / (s - 1)

-- Circle contour formula with explicit pole residues
theorem entire_completed_circle_corrections (F : ℂ → ℂ) (hF : Differentiable ℂ F)
    (c : ℂ) (R : ℝ) (hR : 0 ≤ R) (hx : ∀ w ∈ sphere c R, xi w ≠ 0)
    (h0 : (0 : ℂ) ∈ ball c R) (h1 : (1 : ℂ) ∈ ball c R) :
    (∮ w in C(c, R), F w * logDeriv completedRiemannZeta w) =
      (∮ w in C(c, R), F w * logDeriv xi w) -
        (2 * Real.pi * Complex.I) * (F 0 + F 1)

-- Grand pole cancellation theorem via vanishing Mellin moments
theorem pole_null_completed_circle {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hp : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (hR : 0 ≤ R) (hx : ∀ w ∈ sphere c R, xi w ≠ 0)
    (h0 : (0 : ℂ) ∈ ball c R) (h1 : (1 : ℂ) ∈ ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
      logDeriv completedRiemannZeta w) =
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
      logDeriv xi w)

-- Finite prime block invariance
theorem finite_block_pole_null_completed_circle {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (primes : Finset ℕ)
    (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hplus : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (hR : 0 ≤ R) (hx : ∀ w ∈ sphere c R, xi w ≠ 0)
    (h0 : (0 : ℂ) ∈ ball c R) (h1 : (1 : ℂ) ∈ ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
        logDeriv completedRiemannZeta w) =
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w * logDeriv xi w)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing circle contour integration formulas connecting $\Lambda'/\Lambda$ directly to $\xi'/\xi$, with verified exact pole cancellation under vanishing boundary Mellin moments.
