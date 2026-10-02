import Zeta23.Statement.SeamClosed

open Complex Set
open scoped BigOperators ComplexConjugate

noncomputable section

namespace ShiftedJordanAudit

def window (T₁ T₂ : ℝ) : Finset ℂ := (Zeta23.zerosIn_finite T₁ T₂).toFinset

def simple (T₁ T₂ : ℝ) : Finset ℂ := by
  classical
  exact (window T₁ T₂).filter (fun ρ => ρ.re = 1 / 2 ∧ Zeta23.zeroMult ρ = 1)

def cancelled (a T₁ T₂ : ℝ) : Finset ℂ := by
  classical
  exact (simple T₁ T₂).filter (fun ρ => riemannZeta (ρ - (a : ℂ)) = 0)

def retained (a T₁ T₂ : ℝ) : Finset ℂ := by
  classical
  exact (simple T₁ T₂).filter (fun ρ => riemannZeta (ρ - (a : ℂ)) ≠ 0)

theorem mem_window {ρ : ℂ} {T₁ T₂ : ℝ} :
    ρ ∈ window T₁ T₂ ↔ Zeta23.IsNontrivialZero ρ ∧ T₁ < ρ.im ∧ ρ.im ≤ T₂ := by
  classical
  simp [window, Zeta23.zerosIn]

theorem mem_simple {ρ : ℂ} {T₁ T₂ : ℝ} :
    ρ ∈ simple T₁ T₂ ↔ ρ ∈ window T₁ T₂ ∧ ρ.re = 1 / 2 ∧ Zeta23.zeroMult ρ = 1 := by
  classical
  simp [simple]

theorem simple_card (T₁ T₂ : ℝ) : (simple T₁ T₂).card = Zeta23.N0simple T₁ T₂ := by
  classical
  have hfin : (Zeta23.zerosIn T₁ T₂ ∩ {ρ | ρ.re = 1 / 2} ∩
      {ρ | Zeta23.zeroMult ρ = 1}).Finite :=
    ((Zeta23.zerosIn_finite T₁ T₂).inter_of_left _).inter_of_left _
  rw [Zeta23.N0simple, Set.ncard_eq_toFinset_card _ hfin]
  congr 1
  ext ρ
  simp [simple, window, and_assoc]

theorem shift_left_mem {a T₁ T₂ : ℝ} (ha : 0 < a) (ha₂ : a < 1 / 2)
    {ρ : ℂ} (hρ : ρ ∈ cancelled a T₁ T₂) : ρ - (a : ℂ) ∈ window T₁ T₂ := by
  classical
  obtain ⟨hρs, hz⟩ := Finset.mem_filter.mp hρ
  obtain ⟨hρw, hre, _⟩ := mem_simple.mp hρs
  obtain ⟨_, hlow, hhigh⟩ := mem_window.mp hρw
  apply mem_window.mpr
  refine ⟨⟨hz, ?_, ?_⟩, ?_, ?_⟩
  · simp only [Complex.sub_re, Complex.ofReal_re, hre]
    linarith
  · simp only [Complex.sub_re, Complex.ofReal_re, hre]
    linarith
  · simpa using hlow
  · simpa using hhigh

theorem reflect_left_eq_right {a : ℝ} {ρ : ℂ} (hre : ρ.re = 1 / 2) :
    Zeta23.reflect (ρ - (a : ℂ)) = ρ + (a : ℂ) := by
  apply Complex.ext
  · simp only [Zeta23.reflect, Complex.sub_re, Complex.one_re, Complex.conj_re,
      Complex.ofReal_re, Complex.add_re]
    linarith
  · simp [Zeta23.reflect]

theorem shift_right_mem {a T₁ T₂ : ℝ} (ha : 0 < a) (ha₂ : a < 1 / 2)
    {ρ : ℂ} (hρ : ρ ∈ cancelled a T₁ T₂) : ρ + (a : ℂ) ∈ window T₁ T₂ := by
  classical
  have hleft := mem_window.mp (shift_left_mem ha ha₂ hρ)
  have hre := (mem_simple.mp (Finset.mem_filter.mp hρ).1).2.1
  have hz := Zeta23.zeta_reflect_zero _ hleft.1
  rw [reflect_left_eq_right hre] at hz
  exact mem_window.mpr ⟨hz, by simpa using hleft.2⟩

theorem cancellation_count (a T₁ T₂ : ℝ) (ha : 0 < a) (ha₂ : a < 1 / 2) :
    (simple T₁ T₂).card + 2 * (cancelled a T₁ T₂).card ≤ Zeta23.Ncount T₁ T₂ := by
  classical
  let S := simple T₁ T₂
  let C := cancelled a T₁ T₂
  let L := C.image (fun ρ => ρ - (a : ℂ))
  let R := C.image (fun ρ => ρ + (a : ℂ))
  have hSre : ∀ ρ ∈ S, ρ.re = 1 / 2 := fun ρ hρ => (mem_simple.mp hρ).2.1
  have hCre : ∀ ρ ∈ C, ρ.re = 1 / 2 := fun ρ hρ => hSre ρ (Finset.mem_filter.mp hρ).1
  have hLre : ∀ ρ ∈ L, ρ.re = 1 / 2 - a := by
    intro ρ hρ
    obtain ⟨σ, hσ, rfl⟩ := Finset.mem_image.mp hρ
    simp [hCre σ hσ]
  have hRre : ∀ ρ ∈ R, ρ.re = 1 / 2 + a := by
    intro ρ hρ
    obtain ⟨σ, hσ, rfl⟩ := Finset.mem_image.mp hρ
    simp [hCre σ hσ]
  have hSL : Disjoint S L := by
    apply Finset.disjoint_left.mpr
    intro ρ hS hL
    linarith [hSre ρ hS, hLre ρ hL]
  have hSR : Disjoint S R := by
    apply Finset.disjoint_left.mpr
    intro ρ hS hR
    linarith [hSre ρ hS, hRre ρ hR]
  have hLR : Disjoint L R := by
    apply Finset.disjoint_left.mpr
    intro ρ hL hR
    linarith [hLre ρ hL, hRre ρ hR]
  have hLcard : L.card = C.card := Finset.card_image_of_injective C (fun _ _ h => sub_left_injective h)
  have hRcard : R.card = C.card := Finset.card_image_of_injective C (by
    intro ρ σ h
    have h' := congrArg (fun z : ℂ => z - (a : ℂ)) h
    simpa using h')
  have hunion : (S ∪ L ∪ R).card = S.card + 2 * C.card := by
    rw [Finset.card_union_of_disjoint (Finset.disjoint_union_left.mpr ⟨hSR, hLR⟩),
      Finset.card_union_of_disjoint hSL, hLcard, hRcard]
    omega
  have hsub : S ∪ L ∪ R ⊆ window T₁ T₂ := by
    intro ρ hρ
    rcases Finset.mem_union.mp hρ with hSL | hR
    · rcases Finset.mem_union.mp hSL with hS | hL
      · exact (mem_simple.mp hS).1
      · obtain ⟨σ, hσ, rfl⟩ := Finset.mem_image.mp hL
        exact shift_left_mem ha ha₂ hσ
    · obtain ⟨σ, hσ, rfl⟩ := Finset.mem_image.mp hR
      exact shift_right_mem ha ha₂ hσ
  have hweight : (window T₁ T₂).card ≤ ∑ ρ ∈ window T₁ T₂, Zeta23.zeroMult ρ := by
    rw [Finset.card_eq_sum_ones]
    exact Finset.sum_le_sum fun ρ hρ => Zeta23.zetaSeam.one_le_mult ρ (mem_window.mp hρ).1
  have hsum : (∑ ρ ∈ window T₁ T₂, Zeta23.zeroMult ρ) = Zeta23.Ncount T₁ T₂ := by
    rw [Zeta23.Ncount, finsum_mem_eq_finite_toFinset_sum _ (Zeta23.zerosIn_finite T₁ T₂)]
    rfl
  rw [← hunion]
  exact (Finset.card_le_card hsub).trans (hweight.trans_eq hsum)

theorem retained_count (a T₁ T₂ : ℝ) (ha : 0 < a) (ha₂ : a < 1 / 2) :
    3 * Zeta23.N0simple T₁ T₂ ≤ Zeta23.Ncount T₁ T₂ + 2 * (retained a T₁ T₂).card := by
  classical
  have hpartition : (cancelled a T₁ T₂).card + (retained a T₁ T₂).card =
      (simple T₁ T₂).card := by
    exact Finset.card_filter_add_card_filter_not _
  have hc := cancellation_count a T₁ T₂ ha ha₂
  rw [simple_card] at hc hpartition
  omega

theorem uniform_retained_of_local_simple_density (κ : ℝ)
    (hκ : ∀ ε > 0, ∃ T₀ : ℝ, ∀ T ≥ T₀,
      (κ - ε) * (Zeta23.Ncount T (2 * T) : ℝ) ≤ Zeta23.N0simple T (2 * T)) :
    ∀ ε > 0, ∃ T₀ : ℝ, ∀ T ≥ T₀, ∀ a : ℝ, 0 < a → a < 1 / 2 →
      ((3 * κ - 1) / 2 - ε) * (Zeta23.Ncount T (2 * T) : ℝ) ≤
        (retained a T (2 * T)).card := by
  intro ε hε
  obtain ⟨T₀, hT₀⟩ := hκ (2 * ε / 3) (by linarith)
  refine ⟨T₀, fun T hT a ha ha₂ => ?_⟩
  have hc := retained_count a T (2 * T) ha ha₂
  have hcR : 3 * (Zeta23.N0simple T (2 * T) : ℝ) ≤
      (Zeta23.Ncount T (2 * T) : ℝ) + 2 * ((retained a T (2 * T)).card : ℝ) := by
    exact_mod_cast hc
  have hs := hT₀ T hT
  linarith

#print axioms cancellation_count
#print axioms retained_count
#print axioms uniform_retained_of_local_simple_density
#check Zeta23.zeta_reflect_zero
#check Zeta23.zeta_mult_reflect
#check Zeta23.zerosIn_finite
#check Zeta23.zetaSeam

end ShiftedJordanAudit
