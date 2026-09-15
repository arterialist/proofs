import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts
import BuildingBlocks.CoarsePrimitive

open MeasureTheory Set

namespace FinitePrimeSourceIntegration

/-- A counting atom paired with a derivative, retaining both endpoints. -/
theorem atom_integral {F D : ℝ → ℝ} {a b t : ℝ}
    (ht : t ∈ Icc a b) (hD : Continuous D)
    (hderiv : ∀ x, HasDerivAt F (D x) x) :
    (∫ x in a..b, (if t < x then D x else 0)) = F b - F t := by
  have hi : IntervalIntegrable D volume a b := hD.intervalIntegrable a b
  have hind : IntervalIntegrable ((Iic t).indicator D) volume a b :=
    ⟨hi.1.indicator measurableSet_Iic, hi.2.indicator measurableSet_Iic⟩
  have he : (fun x => if t < x then D x else 0) =
      (fun x => D x - (Iic t).indicator D x) := by
    funext x
    by_cases hx : x ≤ t
    · simp [Set.indicator, hx, not_lt.mpr hx]
    · simp [Set.indicator, hx, lt_of_not_ge hx]
  rw [he, intervalIntegral.integral_sub hi hind]
  have hl := intervalIntegral.integral_indicator (f := D) (μ := volume) ht
  change (∫ x in a..b, D x) - (∫ x in a..b, {x | x ≤ t}.indicator D x) = _
  rw [hl, intervalIntegral.integral_eq_sub_of_hasDerivAt (fun x _ => hderiv x)
      (hD.intervalIntegrable a b),
    intervalIntegral.integral_eq_sub_of_hasDerivAt (fun x _ => hderiv x)
      (hD.intervalIntegrable a t)]
  ring

/-- The birth time itself has zero Lebesgue measure. -/
theorem closed_atom_integral {F D : ℝ → ℝ} {a b t : ℝ}
    (ht : t ∈ Icc a b) (hD : Continuous D)
    (hderiv : ∀ x, HasDerivAt F (D x) x) :
    (∫ x in a..b, (if t ≤ x then D x else 0)) = F b - F t := by
  calc
    (∫ x in a..b, (if t ≤ x then D x else 0)) =
        ∫ x in a..b, (if t < x then D x else 0) := by
      apply intervalIntegral.integral_congr_ae
      filter_upwards [Ioi_ae_eq_Ici (μ := volume) (a := t)] with x hx
      intro _
      have hx' : t < x ↔ t ≤ x := iff_of_eq hx
      simp only [← hx']
    _ = F b - F t := atom_integral ht hD hderiv

/-- Literal finite prefix with the actual von Mangoldt mass at every integer. -/
noncomputable def psiFinite (N : ℕ) (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 2 N, if (n : ℝ) ≤ x then ArithmeticFunction.vonMangoldt n else 0

theorem closed_atom_intervalIntegrable {D : ℝ → ℝ} (hD : Continuous D)
    (a b t : ℝ) :
    IntervalIntegrable (fun x => if t ≤ x then D x else 0) volume a b := by
  have hi : IntervalIntegrable D volume a b := hD.intervalIntegrable a b
  have hind : IntervalIntegrable ((Ici t).indicator D) volume a b :=
    ⟨hi.1.indicator measurableSet_Ici, hi.2.indicator measurableSet_Ici⟩
  simpa only [Set.indicator, mem_Ici] using hind

theorem psiFinite_derivative_integral {F D : ℝ → ℝ} (N : ℕ)
    (hD : Continuous D) (hderiv : ∀ x, HasDerivAt F (D x) x) :
    (∫ x in (1 : ℝ)..(N : ℝ), psiFinite N x * D x) =
      ∑ n ∈ Finset.Icc 2 N,
        ArithmeticFunction.vonMangoldt n * (F N - F n) := by
  have he : (fun x => psiFinite N x * D x) =
      (fun x => ∑ n ∈ Finset.Icc 2 N,
        ArithmeticFunction.vonMangoldt n * (if (n : ℝ) ≤ x then D x else 0)) := by
    funext x
    unfold psiFinite
    rw [Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro n _
    by_cases hx : (n : ℝ) ≤ x <;> simp [hx]
  rw [he, intervalIntegral.integral_finset_sum]
  · apply Finset.sum_congr rfl
    intro n hn
    have ht : (n : ℝ) ∈ Icc (1 : ℝ) (N : ℝ) := by
      have hn' := Finset.mem_Icc.mp hn
      constructor
      · exact_mod_cast (show 1 ≤ n by omega)
      · exact_mod_cast hn'.2
    rw [intervalIntegral.integral_const_mul, closed_atom_integral ht hD hderiv]
  · intro n _
    exact (closed_atom_intervalIntegrable hD 1 N n).const_mul _

theorem psiFinite_mul_intervalIntegrable {D : ℝ → ℝ} (N : ℕ)
    (hD : Continuous D) (a b : ℝ) :
    IntervalIntegrable (fun x => psiFinite N x * D x) volume a b := by
  have hs := IntervalIntegrable.sum (μ := volume) (a := a) (b := b)
    (Finset.Icc 2 N)
    (f := fun n : ℕ => fun x : ℝ => ArithmeticFunction.vonMangoldt n *
      (if (n : ℝ) ≤ x then D x else 0))
    (fun n _ => (closed_atom_intervalIntegrable hD a b n).const_mul
      (ArithmeticFunction.vonMangoldt n))
  convert hs using 1
  funext x
  simp only [psiFinite, Finset.sum_apply, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro n _
  by_cases hx : (n : ℝ) ≤ x <;> simp [hx]

/-- Exact finite prime-error integration by parts, with the endpoint correction explicit. -/
theorem prime_error_integration {F D : ℝ → ℝ} (N : ℕ)
    (hD : Continuous D) (hderiv : ∀ x, HasDerivAt F (D x) x) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * F n) -
        (∫ x in (1 : ℝ)..(N : ℝ), F x) =
      -(∫ x in (1 : ℝ)..(N : ℝ), (psiFinite N x - x) * D x) +
        ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n) - (N : ℝ)) *
          F N + F 1 := by
  have hF : Continuous F := continuous_iff_continuousAt.mpr
    (fun x => (hderiv x).continuousAt)
  have hi : IntervalIntegrable D volume (1 : ℝ) (N : ℝ) :=
    hD.intervalIntegrable 1 N
  have hxD : IntervalIntegrable (fun x : ℝ => x * D x) volume 1 N :=
    (continuous_id.mul hD).intervalIntegrable 1 N
  have hdens := intervalIntegral.integral_mul_deriv_eq_deriv_mul_of_hasDerivAt
    (u := fun x : ℝ => x) (v := F) (u' := fun _ => (1 : ℝ)) (v' := D)
    continuous_id.continuousOn hF.continuousOn (fun x _ => hasDerivAt_id x)
    (fun x _ => hderiv x) (continuous_const.intervalIntegrable 1 N) hi
  simp only [one_mul] at hdens
  have herr : (fun x => (psiFinite N x - x) * D x) =
      (fun x => psiFinite N x * D x - x * D x) := by
    funext x
    ring
  rw [herr, intervalIntegral.integral_sub (psiFinite_mul_intervalIntegrable N hD 1 N) hxD,
    psiFinite_derivative_integral N hD hderiv, hdens]
  simp_rw [mul_sub]
  rw [Finset.sum_sub_distrib, ← Finset.sum_mul]
  ring

/-- Vanishing endpoints remove their correction, without removing any prime-power atom. -/
theorem prime_error_integration_zero_endpoints {F D : ℝ → ℝ} (N : ℕ)
    (hD : Continuous D) (hderiv : ∀ x, HasDerivAt F (D x) x)
    (hF1 : F 1 = 0) (hFN : F N = 0) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * F n) -
        (∫ x in (1 : ℝ)..(N : ℝ), F x) =
      -(∫ x in (1 : ℝ)..(N : ℝ), (psiFinite N x - x) * D x) := by
  simpa only [hF1, hFN, mul_zero, add_zero] using
    prime_error_integration N hD hderiv

/-- On its covered interval the finite prefix is the original prime-counting function. -/
theorem psiFinite_eq_original {N : ℕ} {x : ℝ} (hx0 : 0 ≤ x) (hxN : x ≤ N) :
    psiFinite N x = BuildingBlocks.CoarsePrimitive.psi ⌊x⌋₊ := by
  have hfloor : ⌊x⌋₊ ≤ N := by
    simpa only [Nat.floor_natCast] using (Nat.floor_mono hxN)
  have hsub : Finset.Icc 2 N ⊆ Finset.range (N + 1) := by
    intro n hn
    exact Finset.mem_range.mpr (by have := (Finset.mem_Icc.mp hn).2; omega)
  have he : psiFinite N x = ∑ n ∈ Finset.range (N + 1),
      if (n : ℝ) ≤ x then ArithmeticFunction.vonMangoldt n else 0 := by
    unfold psiFinite
    apply Finset.sum_subset hsub
    intro n hn hnnot
    have hnN : n ≤ N := by have := Finset.mem_range.mp hn; omega
    have hnsmall : n = 0 ∨ n = 1 := by
      have : ¬(2 ≤ n ∧ n ≤ N) := by simpa only [Finset.mem_Icc] using hnnot
      omega
    rcases hnsmall with rfl | rfl <;> simp
  rw [he]
  have hsub' : Finset.range (⌊x⌋₊ + 1) ⊆ Finset.range (N + 1) :=
    Finset.range_mono (Nat.add_le_add_right hfloor 1)
  calc
    (∑ n ∈ Finset.range (N + 1),
        if (n : ℝ) ≤ x then ArithmeticFunction.vonMangoldt n else 0) =
      ∑ n ∈ Finset.range (⌊x⌋₊ + 1),
        if (n : ℝ) ≤ x then ArithmeticFunction.vonMangoldt n else 0 := by
      symm
      apply Finset.sum_subset hsub'
      intro n _ hnnot
      have hn : ¬ n ≤ ⌊x⌋₊ := by
        have : ¬ n < ⌊x⌋₊ + 1 := by simpa only [Finset.mem_range] using hnnot
        omega
      have hnx : ¬ (n : ℝ) ≤ x := fun h => hn ((Nat.le_floor_iff hx0).mpr h)
      simp only [hnx, if_false]
    _ = BuildingBlocks.CoarsePrimitive.psi ⌊x⌋₊ := by
      unfold BuildingBlocks.CoarsePrimitive.psi
      apply Finset.sum_congr rfl
      intro n hn
      have hn' : n ≤ ⌊x⌋₊ := by have := Finset.mem_range.mp hn; omega
      simp only [(Nat.le_floor_iff hx0).mp hn', if_true]

/-- The finite identity consumes the original real prime error, without a substitute source. -/
theorem original_prime_error_integration {F D : ℝ → ℝ} {N : ℕ}
    (hN : 1 ≤ N) (hD : Continuous D) (hderiv : ∀ x, HasDerivAt F (D x) x)
    (hF1 : F 1 = 0) (hFN : F N = 0) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * F n) -
        (∫ x in (1 : ℝ)..(N : ℝ), F x) =
      -(∫ x in (1 : ℝ)..(N : ℝ),
        BuildingBlocks.CoarsePrimitive.primeErrorReal x * D x) := by
  rw [prime_error_integration_zero_endpoints N hD hderiv hF1 hFN]
  congr 1
  apply intervalIntegral.integral_congr
  intro x hx
  have hNR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  rw [uIcc_of_le hNR] at hx
  have hx0 : 0 ≤ x := le_trans (by norm_num : (0 : ℝ) ≤ 1) hx.1
  change (psiFinite N x - x) * D x =
    BuildingBlocks.CoarsePrimitive.primeErrorReal x * D x
  rw [psiFinite_eq_original hx0 hx.2]
  rfl

/-- Original-source integration by parts with the full terminal and initial charge. -/
theorem original_prime_error_integration_endpoints {F D : ℝ → ℝ} {N : ℕ}
    (hN : 1 ≤ N) (hD : Continuous D) (hderiv : ∀ x, HasDerivAt F (D x) x) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * F n) -
        (∫ x in (1 : ℝ)..(N : ℝ), F x) =
      -(∫ x in (1 : ℝ)..(N : ℝ),
        BuildingBlocks.CoarsePrimitive.primeErrorReal x * D x) +
        BuildingBlocks.CoarsePrimitive.primeErrorReal N * F N + F 1 := by
  have hNR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hint : (∫ x in (1 : ℝ)..(N : ℝ), (psiFinite N x - x) * D x) =
      ∫ x in (1 : ℝ)..(N : ℝ),
        BuildingBlocks.CoarsePrimitive.primeErrorReal x * D x := by
    apply intervalIntegral.integral_congr
    intro x hx
    rw [uIcc_of_le hNR] at hx
    have hx0 : 0 ≤ x := le_trans (by norm_num : (0 : ℝ) ≤ 1) hx.1
    change (psiFinite N x - x) * D x = _
    rw [psiFinite_eq_original hx0 hx.2]
    rfl
  have hterminal :
      (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n) - (N : ℝ) =
        BuildingBlocks.CoarsePrimitive.primeErrorReal N := by
    have hp := psiFinite_eq_original (N := N)
      (show (0 : ℝ) ≤ N by positivity) (le_refl (N : ℝ))
    have he : psiFinite N N =
        ∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n := by
      unfold psiFinite
      apply Finset.sum_congr rfl
      intro n hn
      have hnN : (n : ℝ) ≤ N := by exact_mod_cast (Finset.mem_Icc.mp hn).2
      simp only [hnN, if_true]
    rw [← he, hp]
    rfl
  simpa only [hint, hterminal] using prime_error_integration N hD hderiv

#print axioms original_prime_error_integration_endpoints
#print axioms atom_integral
#print axioms closed_atom_integral
#print axioms closed_atom_intervalIntegrable
#print axioms psiFinite_derivative_integral
#print axioms psiFinite_mul_intervalIntegrable
#print axioms prime_error_integration
#print axioms prime_error_integration_zero_endpoints
#print axioms psiFinite_eq_original
#print axioms original_prime_error_integration

end FinitePrimeSourceIntegration
