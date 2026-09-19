# Unique Contribution 251: Exact Completed Zeta Circle Pole Cancellation and Xi Contour Equivalence

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompletedZetaPoleCorrections.lean`](../../formalization/BuildingBlocks/CompletedZetaPoleCorrections.lean), [`building-blocks/archimedean/completed-zeta-pole-corrections.md`](../../building-blocks/archimedean/completed-zeta-pole-corrections.md)  
**Classification:** Analytic Number Theory / Complex Analysis / Contour Integration / Cauchy Residue Theory / Completed Riemann Zeta / Riemann Xi Function / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

The completed Riemann zeta function $\Lambda(s)$ possesses simple poles at $s=0$ and $s=1$ with residue $-1$ and $+1$ respectively, whereas the Riemann $\xi$ function $\xi(s)$ is entire. When integrating the logarithmic derivative $\Lambda'/\Lambda$ against an entire test weight $F(s)$ along a closed circle contour $C(c, R)$ enclosing both $0$ and $1$, the poles contribute discrete correction terms proportional to $2\pi i(F(0) + F(1))$.

This contribution proves:

1. **Exact Logarithmic Derivative Pole Formula:**  
   For any $s \ne 0, 1$ with $\xi(s) \ne 0$:
   \[
   \frac{\Lambda'(s)}{\Lambda(s)} = \frac{\xi'(s)}{\xi(s)} - \frac{1}{s} - \frac{1}{s - 1}.
   \]
2. **General Entire Contour Correction Theorem:**  
   For any entire function $F(s)$ (`Differentiable ℂ F`) and circle contour $C(c, R)$ with $0, 1 \in B(c, R)$ and $\xi(w) \ne 0$ on the boundary sphere:
   \[
   \oint_{C(c, R)} F(w) \frac{\Lambda'(w)}{\Lambda(w)} \, dw = \oint_{C(c, R)} F(w) \frac{\xi'(w)}{\xi(w)} \, dw - 2\pi i (F(0) + F(1)).
   \]
3. **Grand Pole Cancellation Theorem:**  
   For any centered test pair $f, g$ whose Mellin moments vanish at $\pm 1/2$:
   \[
   \mathcal{M}[f](-1/2) = 0 \quad \text{and} \quad \mathcal{M}[f](1/2) = 0,
   \]
   the centered physical residue weight satisfies $F(0) = 0$ and $F(1) = 0$. Consequently, the polar residues vanish identically:
   \[
   \oint_{C(c, R)} F(w) \frac{\Lambda'(w)}{\Lambda(w)} \, dw = \oint_{C(c, R)} F(w) \frac{\xi'(w)}{\xi(w)} \, dw.
   \]
4. **Finite Euler-Product Block Invariance:**  
   The exact contour identity holds unconditionally for all finite prime truncations and arbitrary Euler-product blocks $M$.

---

## 2. Mathematical Proof

### 2.1. Logarithmic Derivative Relation
Since $\xi(s) = \frac{s(s-1)}{2} \Lambda(s)$, applying the logarithmic derivative product rule gives:
\[
\frac{\xi'(s)}{\xi(s)} = \frac{1}{s} + \frac{1}{s - 1} + \frac{\Lambda'(s)}{\Lambda(s)}.
\]
Rearranging:
\[
\frac{\Lambda'(s)}{\Lambda(s)} = \frac{\xi'(s)}{\xi(s)} - \frac{1}{s} - \frac{1}{s - 1}.
\]

### 2.2. Contour Integration and Cauchy Residue Theorem
Multiplying by $F(w)$ and integrating over $C(c, R)$:
\[
\oint_{C(c, R)} F(w) \frac{\Lambda'(w)}{\Lambda(w)} \, dw = \oint_{C(c, R)} F(w) \frac{\xi'(w)}{\xi(w)} \, dw - \oint_{C(c, R)} \frac{F(w)}{w} \, dw - \oint_{C(c, R)} \frac{F(w)}{w - 1} \, dw.
\]
By Cauchy's integral formula for entire functions $F(w)$:
\[
\oint_{C(c, R)} \frac{F(w)}{w} \, dw = 2\pi i F(0), \quad \oint_{C(c, R)} \frac{F(w)}{w - 1} \, dw = 2\pi i F(1).
\]
Substituting yields:
\[
\oint_{C(c, R)} F(w) \frac{\Lambda'(w)}{\Lambda(w)} \, dw = \oint_{C(c, R)} F(w) \frac{\xi'(w)}{\xi(w)} \, dw - 2\pi i (F(0) + F(1)).
\]

### 2.3. Pole Cancellation via Mellin Moment Vanishing
The physical weight $F(w) = \text{centeredWeight}(f, g)(w)$ is constructed from the Mellin transforms $\mathcal{M}[f](w - 1/2)$ and $\mathcal{M}[g](w - 1/2)$.
At $w = 0$: $w - 1/2 = -1/2$, so $\mathcal{M}[f](-1/2) = 0 \implies F(0) = 0$.
At $w = 1$: $w - 1/2 = +1/2$, so $\mathcal{M}[f](+1/2) = 0 \implies F(1) = 0$.
Hence $F(0) + F(1) = 0 + 0 = 0$, and the contour integral of $\Lambda'/\Lambda$ coincides exactly with that of $\xi'/\xi$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompletedZetaPoleCorrections` in `formalization/BuildingBlocks/CompletedZetaPoleCorrections.lean`):
```lean
theorem completed_log_derivative_corrections (s : ℂ) (hs0 : s ≠ 0) (hs1 : s ≠ 1)
    (hx : xi s ≠ 0) :
    logDeriv completedRiemannZeta s = logDeriv xi s - 1 / s - 1 / (s - 1)

theorem entire_completed_circle_corrections (F : ℂ → ℂ) (hF : Differentiable ℂ F)
    (c : ℂ) (R : ℝ) (hR : 0 ≤ R) (hx : ∀ w ∈ sphere c R, xi w ≠ 0)
    (h0 : (0 : ℂ) ∈ ball c R) (h1 : (1 : ℂ) ∈ ball c R) :
    (∮ w in C(c, R), F w * logDeriv completedRiemannZeta w) =
      (∮ w in C(c, R), F w * logDeriv xi w) -
        (2 * Real.pi * Complex.I) * (F 0 + F 1)

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
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Cauchy's integral formula and contour integration of completed Dirichlet series (Riemann 1859, Weil 1952, Bombieri 2000). A machine-verified formal proof in Lean 4 proving exact pole cancellation $F(0) + F(1) = 0$ and the equivalence of circle integrals of $\Lambda'/\Lambda$ and $\xi'/\xi$ is new.
- **Advancement:** Establishes a rigorous bridge between contour integration of the completed zeta function and the entire spectral function $\xi$ without pole singularities.
- **Target Venues:** *Journal of Functional Analysis* or *Complex Analysis and Operator Theory*.
