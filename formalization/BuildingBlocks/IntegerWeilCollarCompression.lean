import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Tactic

/-!
# Integer endpoint collar support geometry

At `a k = log k / 2`, the open physical collar between consecutive integer endpoints
contains no two points separated by `log q` for any integer `q ≥ 2`.
Consequently products of two collar-supported functions with this relative translation vanish.

This module proves support geometry and its pointwise/integral consequences. It does not
construct a Weil operator, its old/new cross blocks, or its harmonic Schur complement.
-/

open Set MeasureTheory

namespace BuildingBlocks.IntegerWeilCollarCompression

/-- Physical logarithmic support radius at the integer endpoint `k`. -/
noncomputable def radius (k : ℕ) : ℝ := Real.log (k : ℝ) / 2

/-- The open two-sided physical collar added between endpoints `k` and `k + 1`. -/
def collar (k : ℕ) : Set ℝ :=
  Ioo (-radius (k + 1)) (-radius k) ∪ Ioo (radius k) (radius (k + 1))

theorem radius_nonneg {k : ℕ} (hk : 1 ≤ k) : 0 ≤ radius k := by
  apply div_nonneg _ (by norm_num)
  exact Real.log_nonneg (by exact_mod_cast hk)

/-- Each same-side collar width is strictly less than the shortest integer logarithm. -/
theorem collar_width_lt_log_two {k : ℕ} (hk : 1 ≤ k) :
    radius (k + 1) - radius k < Real.log 2 := by
  have hkpos : 0 < (k : ℝ) := by exact_mod_cast (by omega : 0 < k)
  have hkone : 1 ≤ (k : ℝ) := by exact_mod_cast hk
  have hnext : (k + 1 : ℝ) ≤ 2 * (k : ℝ) := by linarith
  have hlog := Real.log_le_log (by positivity : 0 < (k : ℝ) + 1) hnext
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hkpos.ne'] at hlog
  have htwo : 0 < Real.log 2 := Real.log_pos (by norm_num)
  simp only [radius, Nat.cast_add, Nat.cast_one]
  linarith

/-- Integer discreteness leaves no integer logarithm strictly between consecutive endpoints. -/
theorem integer_log_gap {k q : ℕ} (hk : 1 ≤ k) (hq : 2 ≤ q) :
    Real.log (q : ℝ) ≤ Real.log (k : ℝ) ∨
      Real.log ((k + 1 : ℕ) : ℝ) ≤ Real.log (q : ℝ) := by
  have hkpos : 0 < (k : ℝ) := by exact_mod_cast (by omega : 0 < k)
  have hqpos : 0 < (q : ℝ) := by exact_mod_cast (by omega : 0 < q)
  by_cases hqk : q ≤ k
  · exact Or.inl (Real.log_le_log hqpos (by exact_mod_cast hqk))
  · exact Or.inr (Real.log_le_log (by positivity) (by exact_mod_cast (by omega : k + 1 ≤ q)))

/-- No two physical collar points differ by the logarithm of an integer at least two. -/
theorem no_integer_log_difference {k q : ℕ} (hk : 1 ≤ k) (hq : 2 ≤ q)
    {x y : ℝ} (hx : x ∈ collar k) (hy : y ∈ collar k) :
    y - x ≠ Real.log (q : ℝ) := by
  have hw := collar_width_lt_log_two hk
  have ha := radius_nonneg hk
  have hqlog : Real.log 2 ≤ Real.log (q : ℝ) :=
    Real.log_le_log (by norm_num) (by exact_mod_cast hq)
  have hqpos : 0 < Real.log (q : ℝ) :=
    Real.log_pos (by exact_mod_cast (by omega : 1 < q))
  have hgap := integer_log_gap hk hq
  simp only [collar, mem_union, mem_Ioo] at hx hy
  intro heq
  rcases hx with hx | hx <;> rcases hy with hy | hy
  · linarith
  · rcases hgap with hgap | hgap <;> simp only [radius] at hx hy <;> linarith
  · linarith
  · linarith

/-- The collar and the preimage of the collar under an integer logarithmic shift are disjoint. -/
theorem collar_disjoint_shift_preimage {k q : ℕ} (hk : 1 ≤ k) (hq : 2 ≤ q) :
    Disjoint (collar k) ((fun x : ℝ => x + Real.log (q : ℝ)) ⁻¹' collar k) := by
  apply Set.disjoint_left.mpr
  intro x hx hy
  exact no_integer_log_difference hk hq hx hy (by ring)

/-- Mixed translated products vanish for any two complex functions supported in the collar. -/
theorem conjugate_shift_mul_eq_zero {k q : ℕ} (hk : 1 ≤ k) (hq : 2 ≤ q)
    {f g : ℝ → ℂ} (hf : Function.support f ⊆ collar k)
    (hg : Function.support g ⊆ collar k) (x : ℝ) :
    star (f x) * g (x + Real.log (q : ℝ)) = 0 := by
  classical
  by_cases hfx : f x = 0
  · simp [hfx]
  have hx : x ∈ collar k := hf (by simpa only [Function.mem_support] using hfx)
  have hgx : g (x + Real.log (q : ℝ)) = 0 := by
    by_contra hne
    have hy : x + Real.log (q : ℝ) ∈ collar k :=
      hg (by simpa only [Function.mem_support] using hne)
    exact no_integer_log_difference hk hq hx hy (by ring)
  simp [hgx]

/-- The mixed translation correlation vanishes for every measure, without extra integrability
assumptions: the integrand is identically zero. This does not identify an operator compression. -/
theorem integral_conjugate_shift_mul_eq_zero {k q : ℕ} (hk : 1 ≤ k) (hq : 2 ≤ q)
    {f g : ℝ → ℂ} (hf : Function.support f ⊆ collar k)
    (hg : Function.support g ⊆ collar k) (μ : Measure ℝ) :
    ∫ x, star (f x) * g (x + Real.log (q : ℝ)) ∂μ = 0 := by
  simp only [conjugate_shift_mul_eq_zero hk hq hf hg, integral_zero]

end BuildingBlocks.IntegerWeilCollarCompression

#print axioms BuildingBlocks.IntegerWeilCollarCompression.radius_nonneg
#print axioms BuildingBlocks.IntegerWeilCollarCompression.collar_width_lt_log_two
#print axioms BuildingBlocks.IntegerWeilCollarCompression.integer_log_gap
#print axioms BuildingBlocks.IntegerWeilCollarCompression.no_integer_log_difference
#print axioms BuildingBlocks.IntegerWeilCollarCompression.collar_disjoint_shift_preimage
#print axioms BuildingBlocks.IntegerWeilCollarCompression.conjugate_shift_mul_eq_zero
#print axioms BuildingBlocks.IntegerWeilCollarCompression.integral_conjugate_shift_mul_eq_zero
