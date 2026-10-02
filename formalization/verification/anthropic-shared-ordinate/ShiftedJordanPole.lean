import Zeta23.Statement.SeamClosed
import Mathlib.Analysis.Meromorphic.Order

open Complex Filter Set

noncomputable section

namespace ShiftedJordanPoleAudit

theorem shifted_ratio_order_at_retained_simple_zero {a : ℝ} {ρ : ℂ}
    (hρ : Zeta23.IsNontrivialZero ρ) (hm : Zeta23.zeroMult ρ = 1)
    (hshift : ρ - (a : ℂ) ≠ 1) (hret : riemannZeta (ρ - (a : ℂ)) ≠ 0) :
    meromorphicOrderAt (fun s : ℂ => riemannZeta (s - (a : ℂ)) / riemannZeta s - 1) ρ =
      (-1 : ℤ) := by
  have hζ : AnalyticAt ℂ riemannZeta ρ :=
    Zeta23.riemannZeta_analyticOnNhd_compl_one ρ hρ.not_trivial.2
  have haff : AnalyticAt ℂ (fun s : ℂ => s - (a : ℂ)) ρ :=
    analyticAt_id.sub analyticAt_const
  have hnum : AnalyticAt ℂ (fun s : ℂ => riemannZeta (s - (a : ℂ))) ρ :=
    (Zeta23.riemannZeta_analyticOnNhd_compl_one _ hshift).comp
      (f := fun s : ℂ => s - (a : ℂ)) haff
  have hord : analyticOrderAt riemannZeta ρ = 1 := by
    exact (ENat.toNat_eq_iff_eq_natCast _ 1).mp hm
  have hdenOrder : meromorphicOrderAt riemannZeta ρ = (1 : ℤ) := by
    rw [hζ.meromorphicOrderAt_eq, hord]
    simp
  have hnumOrder : meromorphicOrderAt (fun s : ℂ => riemannZeta (s - (a : ℂ))) ρ = 0 := by
    rw [hnum.meromorphicOrderAt_eq, hnum.analyticOrderAt_eq_zero.mpr hret]
    simp
  have hratio : meromorphicOrderAt (fun s : ℂ => riemannZeta (s - (a : ℂ)) / riemannZeta s) ρ =
      (-1 : ℤ) := by
    rw [fun_meromorphicOrderAt_div hnum.meromorphicAt hζ.meromorphicAt,
      hnumOrder, hdenOrder]
    norm_num
  change meromorphicOrderAt ((fun s : ℂ => riemannZeta (s - (a : ℂ)) / riemannZeta s) +
      (fun _ : ℂ => -1)) ρ = (-1 : ℤ)
  rw [meromorphicOrderAt_add_eq_left_of_lt (MeromorphicAt.const (-1) ρ)]
  · exact hratio
  · rw [hratio]
    rw [meromorphicOrderAt_const]
    norm_num
    exact WithTop.coe_lt_coe.mpr (by norm_num : (-1 : ℤ) < 0)

theorem shifted_ratio_order_on_critical_line {a : ℝ} (ha : 0 < a) {ρ : ℂ}
    (hρ : Zeta23.IsNontrivialZero ρ) (hre : ρ.re = 1 / 2)
    (hm : Zeta23.zeroMult ρ = 1) (hret : riemannZeta (ρ - (a : ℂ)) ≠ 0) :
    meromorphicOrderAt (fun s : ℂ => riemannZeta (s - (a : ℂ)) / riemannZeta s - 1) ρ =
      (-1 : ℤ) := by
  apply shifted_ratio_order_at_retained_simple_zero hρ hm _ hret
  intro h
  have hh := congrArg Complex.re h
  simp only [Complex.sub_re, Complex.ofReal_re, Complex.one_re, hre] at hh
  linarith

theorem retained_simple_derivative_ne_zero {ρ : ℂ}
    (hρ : Zeta23.IsNontrivialZero ρ) (hm : Zeta23.zeroMult ρ = 1) :
    deriv riemannZeta ρ ≠ 0 := by
  have hζ : AnalyticAt ℂ riemannZeta ρ :=
    Zeta23.riemannZeta_analyticOnNhd_compl_one ρ hρ.not_trivial.2
  have hord : analyticOrderAt riemannZeta ρ = (1 : ℕ) :=
    (ENat.toNat_eq_iff_eq_natCast _ 1).mp hm
  have hd := (analyticOrderAt_eq_nat_iff_iteratedDeriv_eq_zero hζ).mp hord
  simpa using hd.2

#print axioms shifted_ratio_order_at_retained_simple_zero
#print axioms retained_simple_derivative_ne_zero
#print axioms shifted_ratio_order_on_critical_line
#check riemannZeta_residue_one
#check riemannZeta_ne_zero_of_one_lt_re

end ShiftedJordanPoleAudit
