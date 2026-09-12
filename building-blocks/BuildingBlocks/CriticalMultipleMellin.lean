import BuildingBlocks.SummableIntegrals
import Mathlib.Analysis.MellinTransform
import Mathlib.NumberTheory.LSeries.RiemannZeta
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open MeasureTheory Set
open scoped BigOperators

namespace BuildingBlocks.CriticalMultipleMellin

noncomputable def scaled (f : ℝ → ℂ) (d x : ℝ) : ℂ :=
  (Real.sqrt d : ℂ) * f (x / d)

/-- Every positive integer multiple through the real cutoff is retained. -/
noncomputable def cutoffSum (f : ℝ → ℂ) (x : ℝ) : ℂ :=
  ∑ n ∈ Finset.range ⌊x⌋₊, scaled f (n + 1) x

noncomputable def integrand (f : ℝ → ℂ) (s : ℂ) (x : ℝ) : ℂ :=
  (x : ℂ) ^ (-s - 2) * f x

lemma sqrt_cpow {d : ℝ} (hd : 0 < d) :
    (Real.sqrt d : ℂ) = (d : ℂ) ^ (1 / 2 : ℂ) := by
  rw [Real.sqrt_eq_rpow, Complex.ofReal_cpow hd.le]
  norm_num

lemma scale_coefficient {d : ℝ} (hd : 0 < d) (s : ℂ) :
    (Real.sqrt d : ℂ) * ((d⁻¹ : ℝ) : ℂ) ^ (-(-s - 1)) =
      (d : ℂ) ^ (-s - 1 / 2) := by
  rw [sqrt_cpow hd, Complex.ofReal_inv, Complex.inv_cpow]
  · rw [← Complex.cpow_neg, ← Complex.cpow_add _ _ (Complex.ofReal_ne_zero.mpr hd.ne')]
    congr 1
    ring
  · rw [Complex.arg_ofReal_of_nonneg hd.le]
    exact ne_of_lt Real.pi_pos

theorem hasMellin_scaled {f : ℝ → ℂ} {s m : ℂ} (hf : HasMellin f (-s - 1) m)
    {d : ℝ} (hd : 0 < d) :
    HasMellin (scaled f d) (-s - 1) ((d : ℂ) ^ (-s - 1 / 2) * m) := by
  have hc : MellinConvergent (fun x => f (x / d)) (-s - 1) := by
    simpa only [div_eq_mul_inv, mul_comm] using
      (MellinConvergent.comp_mul_left (f := f) (s := -s - 1) (inv_pos.mpr hd)).2 hf.1
  constructor
  · simpa only [scaled, smul_eq_mul] using hc.const_smul (Real.sqrt d : ℂ)
  · change mellin (fun x => (Real.sqrt d : ℂ) • f (x / d)) (-s - 1) = _
    rw [mellin_const_smul]
    have he : mellin (fun x => f (x / d)) (-s - 1) =
        ((d⁻¹ : ℝ) : ℂ) ^ (-(-s - 1)) * m := by
      simpa only [div_eq_mul_inv, mul_comm, smul_eq_mul, hf.2] using
        mellin_comp_mul_left f (-s - 1) (inv_pos.mpr hd)
    rw [he, smul_eq_mul, ← mul_assoc, scale_coefficient hd]

lemma scaled_integrand {f : ℝ → ℂ} {d x : ℝ} (hd : 0 < d) (hx : 0 < x)
    (s : ℂ) :
    integrand (scaled f d) s x =
      (d : ℂ) ^ (-s - 3 / 2) * integrand f s (x / d) := by
  have hbase : (x : ℂ) ^ (-s - 2) =
      (d : ℂ) ^ (-s - 2) * ((x / d : ℝ) : ℂ) ^ (-s - 2) := by
    rw [← Complex.mul_cpow_ofReal_nonneg hd.le (div_pos hx hd).le, ← Complex.ofReal_mul,
      mul_div_cancel₀ x hd.ne']
  unfold integrand scaled
  rw [hbase, sqrt_cpow hd]
  have hp : (d : ℂ) ^ (-s - 2) * (d : ℂ) ^ (1 / 2 : ℂ) =
      (d : ℂ) ^ (-s - 3 / 2) := by
    rw [← Complex.cpow_add _ _ (Complex.ofReal_ne_zero.mpr hd.ne')]
    congr 1
    ring
  calc
    _ = ((d : ℂ) ^ (-s - 2) * (d : ℂ) ^ (1 / 2 : ℂ)) *
        (((x / d : ℝ) : ℂ) ^ (-s - 2) * f (x / d)) := by ring
    _ = _ := by rw [hp]

/-- The Jacobian changes the norm factor to `d^(-Re(s)-1/2)`. -/
theorem integral_norm_scaled (f : ℝ → ℂ) (s : ℂ) {d : ℝ} (hd : 0 < d) :
    (∫ x : ℝ in Ioi 0, ‖integrand (scaled f d) s x‖) =
      d ^ (-s.re - 1 / 2) * (∫ x : ℝ in Ioi 0, ‖integrand f s x‖) := by
  have he : EqOn (fun x => ‖integrand (scaled f d) s x‖)
      (fun x => ‖(d : ℂ) ^ (-s - 3 / 2)‖ * ‖integrand f s (x / d)‖) (Ioi 0) := by
    intro x hx
    dsimp only
    rw [scaled_integrand hd hx, norm_mul]
  rw [setIntegral_congr_fun measurableSet_Ioi he, integral_const_mul]
  have hc : (∫ x : ℝ in Ioi 0, ‖integrand f s (x / d)‖) =
      d * (∫ x : ℝ in Ioi 0, ‖integrand f s x‖) := by
    simpa only [div_eq_mul_inv, mul_comm, mul_zero, inv_inv, smul_eq_mul] using
      integral_comp_mul_left_Ioi (fun x => ‖integrand f s x‖) 0 (inv_pos.mpr hd)
  rw [hc, ← mul_assoc, Complex.norm_cpow_eq_rpow_re_of_pos hd]
  have hp : d ^ (-s - 3 / 2).re * d = d ^ (-s.re - 1 / 2) := by
    rw [← Real.rpow_add_one hd.ne']
    congr 1
    norm_num
    ring
  rw [hp]

lemma scaled_zero_outside_cutoff {f : ℝ → ℂ}
    (hf : ∀ x : ℝ, x ≤ 1 → f x = 0) (x : ℝ) {n : ℕ}
    (hn : n ∉ Finset.range ⌊x⌋₊) : scaled f (n + 1) x = 0 := by
  have hn0 : ⌊x⌋₊ ≤ n := Nat.le_of_not_gt (by simpa using hn)
  have hnr : (⌊x⌋₊ : ℝ) ≤ n := by exact_mod_cast hn0
  have hx := Nat.lt_floor_add_one x
  have hxd : x / ((n : ℝ) + 1) ≤ 1 := (div_le_one (by positivity)).2 (by linarith)
  simp [scaled, hf _ hxd]

theorem tsum_scaled_eq_cutoff {f : ℝ → ℂ}
    (hf : ∀ x : ℝ, x ≤ 1 → f x = 0) (x : ℝ) :
    (∑' n : ℕ, scaled f (n + 1) x) = cutoffSum f x := by
  apply tsum_eq_sum
  intro n hn
  exact scaled_zero_outside_cutoff hf x hn

lemma tsum_integrand {f : ℝ → ℂ} (hf : ∀ x : ℝ, x ≤ 1 → f x = 0)
    (s : ℂ) (x : ℝ) :
    (∑' n : ℕ, integrand (scaled f (n + 1)) s x) = integrand (cutoffSum f) s x := by
  rw [tsum_eq_sum (s := Finset.range ⌊x⌋₊)]
  · simp only [integrand, cutoffSum, Finset.mul_sum]
  · intro n hn
    simp [integrand, scaled_zero_outside_cutoff hf x hn]

/-- Absolute convergence justifies the full square-root multiple shift.
The only function hypotheses are support above one and Mellin convergence. -/
theorem hasMellin_cutoffSum {f : ℝ → ℂ} {s m : ℂ} (hs : (1 : ℝ) / 2 < s.re)
    (hzero : ∀ x : ℝ, x ≤ 1 → f x = 0) (hf : HasMellin f (-s - 1) m) :
    HasMellin (cutoffSum f) (-s - 1) (riemannZeta (s + 1 / 2) * m) := by
  have hF : ∀ n : ℕ, IntegrableOn (integrand (scaled f (n + 1)) s) (Ioi 0) := by
    intro n
    simpa only [MellinConvergent, integrand, smul_eq_mul,
      show (-s - 1) - 1 = -s - 2 by ring] using
      (hasMellin_scaled hf (show (0 : ℝ) < n + 1 by positivity)).1
  have hp : Summable (fun n : ℕ => (n + 1 : ℝ) ^ (-s.re - 1 / 2)) := by
    simpa only [Nat.cast_add, Nat.cast_one] using
      (summable_nat_add_iff 1).2 (Real.summable_nat_rpow.2 (by linarith : -s.re - 1 / 2 < -1))
  have hnorm : Summable (fun n : ℕ => ∫ x : ℝ in Ioi 0,
      ‖integrand (scaled f (n + 1)) s x‖) := by
    have hh (n : ℕ) := integral_norm_scaled f s (show (0 : ℝ) < n + 1 by positivity)
    simp_rw [hh]
    exact hp.mul_right (∫ x : ℝ in Ioi 0, ‖integrand f s x‖)
  have heq : (fun x : ℝ => ∑' n : ℕ, integrand (scaled f (n + 1)) s x) =
      integrand (cutoffSum f) s := by
    funext x
    exact tsum_integrand hzero s x
  have hint := SummableIntegrals.integrable_tsum_of_summable_integral_norm hF hnorm
  rw [heq] at hint
  constructor
  · simpa only [MellinConvergent, integrand, smul_eq_mul,
      show (-s - 1) - 1 = -s - 2 by ring] using hint
  · have hswap := integral_tsum_of_summable_integral_norm hF hnorm
    rw [heq] at hswap
    change (∫ x : ℝ in Ioi 0, (x : ℂ) ^ ((-s - 1) - 1) * cutoffSum f x) = _
    rw [show (-s - 1) - 1 = -s - 2 by ring]
    change (∫ x : ℝ in Ioi 0, integrand (cutoffSum f) s x) = _
    rw [← hswap]
    have hm (n : ℕ) : (∫ x : ℝ in Ioi 0, integrand (scaled f (n + 1)) s x) =
        ((n + 1 : ℝ) : ℂ) ^ (-s - 1 / 2) * m := by
      simpa only [mellin, integrand, smul_eq_mul,
        show (-s - 1) - 1 = -s - 2 by ring] using
        (hasMellin_scaled hf (show (0 : ℝ) < n + 1 by positivity)).2
    simp_rw [hm]
    rw [tsum_mul_right]
    congr 1
    rw [zeta_eq_tsum_one_div_nat_add_one_cpow (show 1 < (s + 1 / 2).re by
      norm_num
      linarith)]
    apply tsum_congr
    intro n
    rw [show -s - 1 / 2 = -(s + 1 / 2) by ring, Complex.cpow_neg]
    simp only [Complex.ofReal_add, Complex.ofReal_natCast, Complex.ofReal_one, one_div]

end BuildingBlocks.CriticalMultipleMellin
