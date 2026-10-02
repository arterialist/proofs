import ShiftedJordanCount

open Complex Set ShiftedJordanAudit
open scoped BigOperators ComplexConjugate

noncomputable section

namespace ShiftedJordanCommonAudit

def bad (T₁ T₂ : ℝ) : Finset ℂ := by
  classical
  exact (simple T₁ T₂).filter (fun ρ => ∃ σ : ℂ,
    σ ∈ window T₁ T₂ ∧ σ.re < 1 / 2 ∧ σ.im = ρ.im)

def good (T₁ T₂ : ℝ) : Finset ℂ := by
  classical
  exact (simple T₁ T₂).filter (fun ρ => ¬ ∃ σ : ℂ,
    σ ∈ window T₁ T₂ ∧ σ.re < 1 / 2 ∧ σ.im = ρ.im)

def chosenLeft (T₁ T₂ : ℝ) (ρ : ℂ) : ℂ := by
  classical
  exact if hρ : ρ ∈ bad T₁ T₂ then Classical.choose (Finset.mem_filter.mp hρ).2 else 0

theorem chosenLeft_spec {T₁ T₂ : ℝ} {ρ : ℂ} (hρ : ρ ∈ bad T₁ T₂) :
    chosenLeft T₁ T₂ ρ ∈ window T₁ T₂ ∧
      (chosenLeft T₁ T₂ ρ).re < 1 / 2 ∧ (chosenLeft T₁ T₂ ρ).im = ρ.im := by
  classical
  simp only [chosenLeft, dif_pos hρ]
  exact Classical.choose_spec (Finset.mem_filter.mp hρ).2

theorem reflected_mem_window {T₁ T₂ : ℝ} {σ : ℂ} (hσ : σ ∈ window T₁ T₂) :
    Zeta23.reflect σ ∈ window T₁ T₂ := by
  obtain ⟨hz, hl, hu⟩ := mem_window.mp hσ
  exact mem_window.mpr ⟨Zeta23.zeta_reflect_zero _ hz, by simpa [Zeta23.reflect] using hl,
    by simpa [Zeta23.reflect] using hu⟩

theorem common_count (T₁ T₂ : ℝ) :
    Zeta23.N0simple T₁ T₂ + 2 * (bad T₁ T₂).card ≤ Zeta23.Ncount T₁ T₂ := by
  classical
  let S := simple T₁ T₂
  let B := bad T₁ T₂
  let L := B.image (chosenLeft T₁ T₂)
  let R := B.image (fun ρ => Zeta23.reflect (chosenLeft T₁ T₂ ρ))
  have hSre : ∀ ρ ∈ S, ρ.re = 1 / 2 := fun ρ hρ => (mem_simple.mp hρ).2.1
  have hBre : ∀ ρ ∈ B, ρ.re = 1 / 2 := fun ρ hρ => hSre ρ (Finset.mem_filter.mp hρ).1
  have hLre : ∀ σ ∈ L, σ.re < 1 / 2 := by
    intro σ hσ
    obtain ⟨ρ, hρ, rfl⟩ := Finset.mem_image.mp hσ
    exact (chosenLeft_spec hρ).2.1
  have hRre : ∀ σ ∈ R, 1 / 2 < σ.re := by
    intro σ hσ
    obtain ⟨ρ, hρ, rfl⟩ := Finset.mem_image.mp hσ
    simp only [Zeta23.reflect, Complex.sub_re, Complex.one_re, Complex.conj_re]
    linarith [(chosenLeft_spec hρ).2.1]
  have hSL : Disjoint S L := by
    apply Finset.disjoint_left.mpr
    intro σ hS hL
    linarith [hSre σ hS, hLre σ hL]
  have hSR : Disjoint S R := by
    apply Finset.disjoint_left.mpr
    intro σ hS hR
    linarith [hSre σ hS, hRre σ hR]
  have hLR : Disjoint L R := by
    apply Finset.disjoint_left.mpr
    intro σ hL hR
    linarith [hLre σ hL, hRre σ hR]
  have hLcard : L.card = B.card := Finset.card_image_of_injOn (by
    intro ρ hρ τ hτ h
    apply Complex.ext
    · rw [hBre ρ hρ, hBre τ hτ]
    · have hh := congrArg Complex.im h
      rwa [(chosenLeft_spec hρ).2.2, (chosenLeft_spec hτ).2.2] at hh)
  have hRcard : R.card = B.card := Finset.card_image_of_injOn (by
    intro ρ hρ τ hτ h
    apply Complex.ext
    · rw [hBre ρ hρ, hBre τ hτ]
    · have hh := congrArg Complex.im h
      simp only [Zeta23.reflect, Complex.sub_im, Complex.one_im, Complex.conj_im,
        zero_sub, neg_neg] at hh
      rwa [(chosenLeft_spec hρ).2.2, (chosenLeft_spec hτ).2.2] at hh)
  have hunion : (S ∪ L ∪ R).card = S.card + 2 * B.card := by
    rw [Finset.card_union_of_disjoint (Finset.disjoint_union_left.mpr ⟨hSR, hLR⟩),
      Finset.card_union_of_disjoint hSL, hLcard, hRcard]
    omega
  have hsub : S ∪ L ∪ R ⊆ window T₁ T₂ := by
    intro σ hσ
    rcases Finset.mem_union.mp hσ with hSL | hR
    · rcases Finset.mem_union.mp hSL with hS | hL
      · exact (mem_simple.mp hS).1
      · obtain ⟨ρ, hρ, rfl⟩ := Finset.mem_image.mp hL
        exact (chosenLeft_spec hρ).1
    · obtain ⟨ρ, hρ, rfl⟩ := Finset.mem_image.mp hR
      exact reflected_mem_window (chosenLeft_spec hρ).1
  have hweight : (window T₁ T₂).card ≤ ∑ ρ ∈ window T₁ T₂, Zeta23.zeroMult ρ := by
    rw [Finset.card_eq_sum_ones]
    exact Finset.sum_le_sum fun ρ hρ => Zeta23.zetaSeam.one_le_mult ρ (mem_window.mp hρ).1
  have hsum : (∑ ρ ∈ window T₁ T₂, Zeta23.zeroMult ρ) = Zeta23.Ncount T₁ T₂ := by
    rw [Zeta23.Ncount, finsum_mem_eq_finite_toFinset_sum _ (Zeta23.zerosIn_finite T₁ T₂)]
    rfl
  rw [← simple_card, ← hunion]
  exact (Finset.card_le_card hsub).trans (hweight.trans_eq hsum)

theorem common_good_count (T₁ T₂ : ℝ) :
    3 * Zeta23.N0simple T₁ T₂ ≤ Zeta23.Ncount T₁ T₂ + 2 * (good T₁ T₂).card := by
  classical
  have hp : (bad T₁ T₂).card + (good T₁ T₂).card = (simple T₁ T₂).card :=
    Finset.card_filter_add_card_filter_not _
  rw [simple_card] at hp
  have hc := common_count T₁ T₂
  omega

theorem good_unique_in_window {T₁ T₂ : ℝ} {ρ : ℂ} (hρ : ρ ∈ good T₁ T₂)
    {σ : ℂ} (hσ : σ ∈ window T₁ T₂) (him : σ.im = ρ.im) : σ = ρ := by
  classical
  obtain ⟨hρS, hnot⟩ := Finset.mem_filter.mp hρ
  have hre := (mem_simple.mp hρS).2.1
  rcases lt_trichotomy σ.re (1 / 2 : ℝ) with hlt | heq | hgt
  · exact False.elim (hnot ⟨σ, hσ, hlt, him⟩)
  · apply Complex.ext
    · rw [heq, hre]
    · exact him
  · have href := reflected_mem_window hσ
    have hleft : (Zeta23.reflect σ).re < 1 / 2 := by
      simp only [Zeta23.reflect, Complex.sub_re, Complex.one_re, Complex.conj_re]
      linarith
    have hri : (Zeta23.reflect σ).im = ρ.im := by simpa [Zeta23.reflect] using him
    exact False.elim (hnot ⟨Zeta23.reflect σ, href, hleft, hri⟩)

theorem good_unique_nontrivial_zero {T₁ T₂ : ℝ} {ρ : ℂ} (hρ : ρ ∈ good T₁ T₂)
    {σ : ℂ} (hσ : Zeta23.IsNontrivialZero σ) (him : σ.im = ρ.im) : σ = ρ := by
  classical
  have hρw := (mem_simple.mp (Finset.mem_filter.mp hρ).1).1
  have hρI := (mem_window.mp hρw).2
  apply good_unique_in_window hρ _ him
  apply mem_window.mpr
  exact ⟨hσ, by simpa [him] using hρI⟩

theorem good_all_shifts_nonzero {T₁ T₂ : ℝ} {ρ : ℂ} (hρ : ρ ∈ good T₁ T₂) :
    ∀ a : ℝ, 0 < a → a < 1 / 2 → riemannZeta (ρ - (a : ℂ)) ≠ 0 := by
  classical
  intro a ha ha₂ hz
  have hρS := (Finset.mem_filter.mp hρ).1
  have hc : ρ ∈ cancelled a T₁ T₂ := Finset.mem_filter.mpr ⟨hρS, hz⟩
  have hs := shift_left_mem ha ha₂ hc
  have heq := good_unique_in_window hρ hs (by simp)
  have hh := congrArg Complex.re heq
  simp only [Complex.sub_re, Complex.ofReal_re] at hh
  linarith

theorem uniform_common_good_of_local_simple_density (κ : ℝ)
    (hκ : ∀ ε > 0, ∃ T₀ : ℝ, ∀ T ≥ T₀,
      (κ - ε) * (Zeta23.Ncount T (2 * T) : ℝ) ≤ Zeta23.N0simple T (2 * T)) :
    ∀ ε > 0, ∃ T₀ : ℝ, ∀ T ≥ T₀,
      ((3 * κ - 1) / 2 - ε) * (Zeta23.Ncount T (2 * T) : ℝ) ≤ (good T (2 * T)).card ∧
      ∀ ρ ∈ good T (2 * T),
        (∀ σ : ℂ, Zeta23.IsNontrivialZero σ → σ.im = ρ.im → σ = ρ) ∧
        (∀ a : ℝ, 0 < a → a < 1 / 2 → riemannZeta (ρ - (a : ℂ)) ≠ 0) := by
  intro ε hε
  obtain ⟨T₀, hT₀⟩ := hκ (2 * ε / 3) (by linarith)
  refine ⟨T₀, fun T hT => ⟨?_, ?_⟩⟩
  · have hc := common_good_count T (2 * T)
    have hcR : 3 * (Zeta23.N0simple T (2 * T) : ℝ) ≤
        (Zeta23.Ncount T (2 * T) : ℝ) + 2 * ((good T (2 * T)).card : ℝ) := by
      exact_mod_cast hc
    have hs := hT₀ T hT
    linarith
  · intro ρ hρ
    exact ⟨fun _ hs him => good_unique_nontrivial_zero hρ hs him, good_all_shifts_nonzero hρ⟩

#print axioms common_count
#print axioms common_good_count
#print axioms good_unique_nontrivial_zero
#print axioms good_all_shifts_nonzero
#print axioms uniform_common_good_of_local_simple_density

end ShiftedJordanCommonAudit
