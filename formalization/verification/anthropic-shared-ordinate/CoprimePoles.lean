import CommonPoles

open Complex

noncomputable section

namespace ShiftedJordanCommonAudit

def eulerDeletion (a : ℝ) (P : Finset ℕ) (s : ℂ) : ℂ :=
  ∏ p ∈ P, (1 - Complex.exp (((a : ℂ) - s) * (Real.log p : ℂ))) /
    (1 - Complex.exp (-s * (Real.log p : ℂ)))

theorem local_deletion_nonzero {a : ℝ} {ρ : ℂ} {p : ℕ}
    (ha : a < 1 / 2) (hre : ρ.re = 1 / 2) (hp : p.Prime) :
    (1 - Complex.exp (((a : ℂ) - ρ) * (Real.log p : ℂ))) ≠ 0 ∧
      (1 - Complex.exp (-ρ * (Real.log p : ℂ))) ≠ 0 := by
  have hpR : 1 < (p : ℝ) := by exact_mod_cast hp.one_lt
  have hl : 0 < Real.log (p : ℝ) := Real.log_pos hpR
  have hn : ‖Complex.exp (((a : ℂ) - ρ) * (Real.log p : ℂ))‖ < 1 := by
    rw [Complex.norm_exp, Real.exp_lt_one_iff]
    simp only [Complex.mul_re, Complex.sub_re, Complex.ofReal_re,
      Complex.ofReal_im, mul_zero, sub_zero, hre]
    exact mul_neg_of_neg_of_pos (by linarith) hl
  have hd : ‖Complex.exp (-ρ * (Real.log p : ℂ))‖ < 1 := by
    rw [Complex.norm_exp, Real.exp_lt_one_iff]
    simp only [Complex.mul_re, Complex.neg_re, Complex.neg_im,
      Complex.ofReal_re, Complex.ofReal_im, mul_zero, sub_zero, hre]
    exact mul_neg_of_neg_of_pos (by norm_num) hl
  constructor
  · intro h
    have he : Complex.exp (((a : ℂ) - ρ) * (Real.log p : ℂ)) = 1 :=
      (sub_eq_zero.mp h).symm
    exact (ne_of_lt hn) (by rw [he]; simp)
  · intro h
    have he : Complex.exp (-ρ * (Real.log p : ℂ)) = 1 := (sub_eq_zero.mp h).symm
    exact (ne_of_lt hd) (by rw [he]; simp)

theorem eulerDeletion_nonzero {a : ℝ} {ρ : ℂ} {P : Finset ℕ}
    (ha : a < 1 / 2) (hre : ρ.re = 1 / 2) (hP : ∀ p ∈ P, p.Prime) :
    eulerDeletion a P ρ ≠ 0 := by
  unfold eulerDeletion
  apply Finset.prod_ne_zero_iff.mpr
  intro p hp
  obtain ⟨hn, hd⟩ := local_deletion_nonzero ha hre (hP p hp)
  exact div_ne_zero hn hd

theorem eulerDeletion_analyticAt {a : ℝ} {ρ : ℂ} {P : Finset ℕ}
    (ha : a < 1 / 2) (hre : ρ.re = 1 / 2) (hP : ∀ p ∈ P, p.Prime) :
    AnalyticAt ℂ (eulerDeletion a P) ρ := by
  unfold eulerDeletion
  apply Finset.analyticAt_fun_prod P
  intro p hp
  have hnum : AnalyticAt ℂ
      (fun s : ℂ => Complex.exp (((a : ℂ) - s) * (Real.log p : ℂ))) ρ := by
    exact ((analyticAt_const.sub analyticAt_id).mul analyticAt_const).cexp
  have hden : AnalyticAt ℂ
      (fun s : ℂ => Complex.exp (-s * (Real.log p : ℂ))) ρ := by
    exact (analyticAt_id.neg.mul analyticAt_const).cexp
  exact (analyticAt_const.sub hnum).div (analyticAt_const.sub hden)
    (local_deletion_nonzero ha hre (hP p hp)).2

theorem depleted_ratio_simple_pole {a : ℝ} {ρ : ℂ} {P : Finset ℕ}
    (ha : 0 < a) (ha₂ : a < 1 / 2)
    (hρ : Zeta23.IsNontrivialZero ρ) (hre : ρ.re = 1 / 2)
    (hm : Zeta23.zeroMult ρ = 1)
    (hret : riemannZeta (ρ - (a : ℂ)) ≠ 0)
    (hP : ∀ p ∈ P, p.Prime) :
    meromorphicOrderAt
      (fun s : ℂ => eulerDeletion a P s * (riemannZeta (s - (a : ℂ)) / riemannZeta s)) ρ =
        (-1 : ℤ) := by
  have hshift : ρ - (a : ℂ) ≠ 1 := by
    intro h
    have hh := congrArg Complex.re h
    simp only [Complex.sub_re, Complex.ofReal_re, Complex.one_re, hre] at hh
    linarith
  have hζ : AnalyticAt ℂ riemannZeta ρ :=
    Zeta23.riemannZeta_analyticOnNhd_compl_one ρ hρ.not_trivial.2
  have hnum : AnalyticAt ℂ (fun s : ℂ => riemannZeta (s - (a : ℂ))) ρ :=
    (Zeta23.riemannZeta_analyticOnNhd_compl_one _ hshift).comp
      (f := fun s : ℂ => s - (a : ℂ)) (analyticAt_id.sub analyticAt_const)
  have hord : analyticOrderAt riemannZeta ρ = 1 :=
    (ENat.toNat_eq_iff_eq_natCast _ 1).mp hm
  have hdenOrder : meromorphicOrderAt riemannZeta ρ = (1 : ℤ) := by
    rw [hζ.meromorphicOrderAt_eq, hord]
    simp
  have hnumOrder : meromorphicOrderAt (fun s : ℂ => riemannZeta (s - (a : ℂ))) ρ = 0 := by
    rw [hnum.meromorphicOrderAt_eq, hnum.analyticOrderAt_eq_zero.mpr hret]
    simp
  have hratio : meromorphicOrderAt
      (fun s : ℂ => riemannZeta (s - (a : ℂ)) / riemannZeta s) ρ = (-1 : ℤ) := by
    rw [fun_meromorphicOrderAt_div hnum.meromorphicAt hζ.meromorphicAt,
      hnumOrder, hdenOrder]
    norm_num
  change meromorphicOrderAt
    ((eulerDeletion a P) * (fun s : ℂ => riemannZeta (s - (a : ℂ)) / riemannZeta s)) ρ = _
  rw [meromorphicOrderAt_mul_of_ne_zero (eulerDeletion_analyticAt ha₂ hre hP)
    (eulerDeletion_nonzero ha₂ hre hP)]
  exact hratio

theorem good_all_shifts_all_finite_deletions_simple_poles {T₁ T₂ : ℝ} {ρ : ℂ}
    (hρ : ρ ∈ good T₁ T₂) :
    ∀ a : ℝ, 0 < a → a < 1 / 2 → ∀ P : Finset ℕ, (∀ p ∈ P, p.Prime) →
      meromorphicOrderAt
        (fun s : ℂ => eulerDeletion a P s * (riemannZeta (s - (a : ℂ)) / riemannZeta s)) ρ =
          (-1 : ℤ) := by
  intro a ha ha₂ P hP
  obtain ⟨hw, hre, hm⟩ := ShiftedJordanAudit.mem_simple.mp (Finset.mem_filter.mp hρ).1
  exact depleted_ratio_simple_pole ha ha₂ (ShiftedJordanAudit.mem_window.mp hw).1
    hre hm (good_all_shifts_nonzero hρ a ha ha₂) hP

#print axioms local_deletion_nonzero
#print axioms eulerDeletion_nonzero
#print axioms eulerDeletion_analyticAt
#print axioms depleted_ratio_simple_pole
#print axioms good_all_shifts_all_finite_deletions_simple_poles

end ShiftedJordanCommonAudit
