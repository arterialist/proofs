# First Formalization in Lean 4: Full-Kappa Slope Finite Resummation and Rectangular Mass

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/FullKappaSlopeFinite.lean`](../../formalization/BuildingBlocks/FullKappaSlopeFinite.lean)  
**Dependencies:** `Mathlib.Tactic`, `BuildingBlocks.KappaCoefficientPositivity`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the evaluation of bilinear Möbius–Stokes boundary sums, the rectangular two-slope dilation sum is defined by:
\[
K(A, B) = \sum_{a=0}^{A-1}\sum_{b=0}^{B-1} \kappa_{a+b}.
\]

This Lean 4 module formalizes the exact algebraic resummation of the rectangular kernel:
1. **Slope Primitive Difference:** Proves $\kappa_m = g_m - g_{m+1}$, where $g_m = m\log\frac{m}{m+1}$ (with $g_0 = 0$).
2. **Factorial-Logarithm Prefix Form:** Proves that the prefix sum $H(n) = \sum_{m=1}^n g_m$ has the closed form:
   \[
   H(n) = \log(n!) - n\log(n+1) = \log\frac{n!}{(n+1)^n}.
   \]
3. **Prefix and Min/Max Rectangular Boundary Identities:** Proves:
   \[
   K(A, B) = \operatorname{prefixG}(A) + \operatorname{prefixG}(B) - \operatorname{prefixG}(A+B),
   \]
   and for $A, B \ge 1$:
   \[
   K(A, B) = H(\min(A, B) - 1) + H(\max(A, B) - 1) - H(A + B - 1).
   \]
4. **Strict Positivity and Monotonicity:** Proves $K(A, B) > 0$ for all $A, B > 0$, strict monotonicity $K(A, B) < K(A+1, B)$, and coordinatewise weak monotonicity $A \le A' \land B \le B' \implies K(A, B) \le K(A', B')$.

---

## 2. Machine-Verified Theorems

```lean
def g (m : ℕ) : ℝ := -tauNat m

theorem kappa_eq_g_sub_g_succ (m : ℕ) :
    kappa m = g m - g (m + 1)

def prefixG (n : ℕ) : ℝ := ∑ m ∈ Finset.range n, g m
def H (n : ℕ) : ℝ := ∑ m ∈ Finset.range n, g (m + 1)

theorem H_eq_log_factorial_sub (n : ℕ) :
    H n = Real.log (n.factorial : ℝ) -
      (n : ℝ) * Real.log ((n : ℝ) + 1)

theorem H_eq_log_factorial_ratio (n : ℕ) :
    H n = Real.log ((n.factorial : ℝ) / (((n : ℝ) + 1) ^ n))

def K (A B : ℕ) : ℝ :=
  ∑ a ∈ Finset.range A, ∑ b ∈ Finset.range B, kappa (a + b)

theorem K_eq_prefix (A B : ℕ) :
    K A B = prefixG A + prefixG B - prefixG (A + B)

theorem K_eq_H_min_max {A B : ℕ} (hA : 1 ≤ A) (hB : 1 ≤ B) :
    K A B = H (Nat.min A B - 1) + H (Nat.max A B - 1) -
      H (A + B - 1)

theorem K_pos {A B : ℕ} (hA : 0 < A) (hB : 0 < B) : 0 < K A B

theorem K_strictMono_left {A B : ℕ} (hB : 0 < B) : K A B < K (A + 1) B

theorem K_strictMono_right {A B : ℕ} (hA : 0 < A) : K A B < K A (B + 1)

theorem K_mono {A A' B B' : ℕ} (hAA : A ≤ A') (hBB : B ≤ B') :
    K A B ≤ K A' B'
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/FullKappaSlopeFinite.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.FullKappaSlopeFinite.kappa_eq_g_sub_g_succ' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.FullKappaSlopeFinite.K_eq_prefix' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.FullKappaSlopeFinite.K_eq_H_min_max' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.FullKappaSlopeFinite.K_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.FullKappaSlopeFinite.K_strictMono_left' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.FullKappaSlopeFinite.K_mono' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on foundational axioms with zero custom postulates.
