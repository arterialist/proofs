# First Formalization in Lean 4: Renewal Bernoulli Cell Moments and Double-Primitive Deficit

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/RenewalBernoulliCellMoments.lean`](../../formalization/BuildingBlocks/RenewalBernoulliCellMoments.lean)  
**Dependencies:** `Mathlib.Analysis.SpecialFunctions.Integrals.Basic`, `Mathlib.Tactic`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the study of the causal renewal operator and the critical line explicit formula, the integer-minus-continuum discrepancy kernel on logarithmic cells expands into polynomial profiles:
\[
f_0(r) = -\frac{1}{2}r^2 + \frac{1}{2}r - \frac{1}{12}, \qquad
f_1(r) = \frac{5}{12}r^3 - \frac{1}{4}r^2 - \frac{1}{24}r, \qquad
f_2(r) = -\frac{11}{32}r^4 + \frac{1}{6}r^3 + \frac{1}{48}r^2 + \frac{23}{2880}.
\]

This Lean 4 development formalizes the exact polynomial integrations proving:
1. **Vanishing Moments:** The mean of $f_0$ is zero (`f0_mean`), the first moment of $f_0$ is zero (`f0_first_moment`), and the mean of $f_1$ is zero (`f1_mean`).
2. **Surviving Moments:** The second moment of $f_0$ is $-1/360$, the first moment of $f_1$ is $1/144$, and the mean of $f_2$ is $-7/576$.
3. **Exact Surviving Phase Coefficient:** The exact real linear combination of moments evaluating the surviving phase coefficient for cell Laplace transforms:
   \[
   \int_0^1 \left[f_2(r) - (z+1)r f_1(r) + \frac{(z+1)(z+2)}{2}r^2 f_0(r)\right]dr = -\frac{(2z+7)(2z+9)}{2880}.
   \]
4. **Double Primitive Identities:** The twice-integrated profiles evaluate to:
   \[
   \int_0^r (r-t)f_0(t)dt = -\frac{r^2(1-r)^2}{24} \le 0 \qquad (\forall r \in \mathbb{R}),
   \]
   and
   \[
   \int_0^r (r-t)f_1(t)dt = -\frac{r^3[1+3r(1-r)]}{144} < 0 \qquad (\forall r \in (0, 1]).
   \]

---

## 2. Machine-Verified Theorems

```lean
noncomputable def f0 (r : ℝ) : ℝ :=
  (-1 / 2 : ℝ) * r ^ 2 + (1 / 2 : ℝ) * r + (-1 / 12 : ℝ)

noncomputable def f1 (r : ℝ) : ℝ :=
  (5 / 12 : ℝ) * r ^ 3 - (1 / 4 : ℝ) * r ^ 2 - (1 / 24 : ℝ) * r

noncomputable def f2 (r : ℝ) : ℝ :=
  (-11 / 32 : ℝ) * r ^ 4 + (1 / 6 : ℝ) * r ^ 3 +
    (1 / 48 : ℝ) * r ^ 2 + (23 / 2880 : ℝ)

theorem f0_mean : (∫ r in (0 : ℝ)..1, f0 r) = 0
theorem f0_first_moment : (∫ r in (0 : ℝ)..1, r * f0 r) = 0
theorem f0_second_moment : (∫ r in (0 : ℝ)..1, r ^ 2 * f0 r) = -(1 / 360 : ℝ)
theorem f1_mean : (∫ r in (0 : ℝ)..1, f1 r) = 0
theorem f1_first_moment : (∫ r in (0 : ℝ)..1, r * f1 r) = (1 / 144 : ℝ)
theorem f2_mean : (∫ r in (0 : ℝ)..1, f2 r) = -(7 / 576 : ℝ)

theorem phase_coefficient_real (z : ℝ) :
    (∫ r in (0 : ℝ)..1,
      f2 r - (z + 1) * r * f1 r +
        ((z + 1) * (z + 2) / 2) * r ^ 2 * f0 r) =
      -((2 * z + 7) * (2 * z + 9)) / 2880

theorem f0_double_primitive (r : ℝ) :
    (∫ t in (0 : ℝ)..r, (r - t) * f0 t) =
      -(r ^ 2 * (1 - r) ^ 2) / 24

theorem f0_double_primitive_nonpos (r : ℝ) :
    (∫ t in (0 : ℝ)..r, (r - t) * f0 t) ≤ 0

theorem f1_double_primitive (r : ℝ) :
    (∫ t in (0 : ℝ)..r, (r - t) * f1 t) =
      -(r ^ 3 * (1 + 3 * r * (1 - r))) / 144

theorem f1_double_primitive_nonpos {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r ≤ 1) :
    (∫ t in (0 : ℝ)..r, (r - t) * f1 t) ≤ 0

theorem f1_double_primitive_neg {r : ℝ} (hr0 : 0 < r) (hr1 : r ≤ 1) :
    (∫ t in (0 : ℝ)..r, (r - t) * f1 t) < 0
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/RenewalBernoulliCellMoments.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.RenewalBernoulliCellMoments.f0_mean' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f0_first_moment' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f0_second_moment' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f1_mean' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f1_first_moment' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f2_mean' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.phase_coefficient_real' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f0_double_primitive' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f0_double_primitive_nonpos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f1_double_primitive' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f1_double_primitive_nonpos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.RenewalBernoulliCellMoments.f1_double_primitive_neg' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on foundational axioms with zero custom postulates.
