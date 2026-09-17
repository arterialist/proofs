import BuildingBlocks.CyclotomicFareyMass
import BuildingBlocks.CyclotomicBoundarySums

open Finset
open scoped BigOperators

namespace BuildingBlocks.CyclotomicBoundary

private theorem harmonic_nonneg_real (N : ℕ) : (0 : ℝ) ≤ harmonic N := by
  simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast]
  exact Finset.sum_nonneg (fun _ _ => by positivity)

/-- A direct consequence of the exact arithmetic formula for the actual mass.
The geometric sector identity remains an explicit premise. -/
theorem fareySectorMass_le_harmonic_div (h : FareySectorMassIdentity)
    {n N : ℕ} (hn : 1 ≤ n) (hnN : n ≤ N) (hN : 2 ≤ N) :
    fareySectorMass n N ≤ (harmonic N : ℝ) / n := by
  have hb : fareyDenominatorBlock n N ⊆ Finset.Icc 1 N := by
    intro b hb
    obtain ⟨hbl, hbu⟩ := Finset.mem_Icc.mp (Finset.mem_filter.mp hb).1
    exact Finset.mem_Icc.mpr ⟨by omega, hbu⟩
  have hs : (∑ b ∈ fareyDenominatorBlock n N, (1 : ℝ) / b) ≤
      (harmonic N : ℝ) := by
    calc
      _ ≤ ∑ b ∈ Finset.Icc 1 N, (1 : ℝ) / b :=
        Finset.sum_le_sum_of_subset_of_nonneg hb (fun _ _ _ => by positivity)
      _ = _ := by
        simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv,
          Rat.cast_natCast, one_div]
  rw [h n N hn hnN hN]
  change (1 / (n : ℝ)) * (∑ b ∈ fareyDenominatorBlock n N, 1 / (b : ℝ)) ≤ _
  calc
    _ ≤ (1 / (n : ℝ)) * (harmonic N : ℝ) :=
      mul_le_mul_of_nonneg_left hs (by positivity)
    _ = _ := by ring

/-- The floor square-root band stays below half the cutoff, including N=2,3. -/
theorem two_mul_nat_sqrt_le {N : ℕ} (hN : 2 ≤ N) : 2 * Nat.sqrt N ≤ N := by
  by_cases hs : Nat.sqrt N ≤ 1
  · omega
  · have hs2 : 2 ≤ Nat.sqrt N := by omega
    nlinarith [Nat.sqrt_le' N]

/-- The actual late small-conductor selection, conditional only on the
geometric sector identity. Birth conductors are excluded by the index set. -/
theorem fareySmallSelectedMass_le_two_mul_div (h : FareySectorMassIdentity)
    {N Y : ℕ} (hN : 3 ≤ N) (hY : 2 * Y < N) :
    (∑ n ∈ (Finset.Icc 1 (N - 1)).filter (fun n => n ≤ Y), fareySectorMass n N) ≤
      2 * (Y : ℝ) / N := by
  let s := (Finset.Icc 1 (N - 1)).filter (fun n => n ≤ Y)
  have hNr : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hc : s.card ≤ Y := by
    calc
      _ ≤ (Finset.Icc 1 Y).card := Finset.card_le_card (by
        intro n hn
        obtain ⟨hi, hy⟩ := Finset.mem_filter.mp hn
        exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hi).1, hy⟩)
      _ = _ := by simp
  have hp : ∀ n ∈ s, fareySectorMass n N ≤ 2 / (N : ℝ) := by
    intro n hn
    obtain ⟨hi, hy⟩ := Finset.mem_filter.mp hn
    obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hi
    have hlt : n < N := by omega
    have hage : (0 : ℝ) < (N - n : ℕ) := by
      exact_mod_cast (show 0 < N - n by omega)
    calc
      _ ≤ 1 / ((N - n : ℕ) : ℝ) := fareySectorMass_le_inv_age h hn1 hlt
      _ ≤ 2 / (N : ℝ) := by
        apply (div_le_div_iff₀ hage hNr).mpr
        norm_num only [one_mul]
        exact_mod_cast (show N ≤ 2 * (N - n) by omega)
  change (∑ n ∈ s, fareySectorMass n N) ≤ _
  calc
    _ ≤ ∑ _n ∈ s, (2 / (N : ℝ)) := Finset.sum_le_sum hp
    _ = (s.card : ℝ) * (2 / (N : ℝ)) := by simp
    _ ≤ (Y : ℝ) * (2 / (N : ℝ)) :=
      mul_le_mul_of_nonneg_right (by exact_mod_cast hc) (by positivity)
    _ = _ := by ring

/-- The actual moving age-band selection has the square-root mass bound.
The N=3 cutoff is included without a separate value calculation. -/
theorem fareyRecentSelectedMass_le_two_harmonic_div_sqrt (h : FareySectorMassIdentity)
    {N : ℕ} (hN : 3 ≤ N) :
    (∑ n ∈ (Finset.Icc 1 (N - 1)).filter (fun n => N - n ≤ Nat.sqrt N),
      fareySectorMass n N) ≤ 2 * (harmonic N : ℝ) / Real.sqrt N := by
  let s := (Finset.Icc 1 (N - 1)).filter (fun n => N - n ≤ Nat.sqrt N)
  have hhalf : 2 * Nat.sqrt N ≤ N := two_mul_nat_sqrt_le (by omega)
  have hNr : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hH : (0 : ℝ) ≤ harmonic N := harmonic_nonneg_real N
  have hc : s.card ≤ Nat.sqrt N := by
    calc
      _ ≤ (Finset.Icc (N - Nat.sqrt N) (N - 1)).card :=
        Finset.card_le_card (by
          intro n hn
          obtain ⟨hi, ha⟩ := Finset.mem_filter.mp hn
          obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hi
          exact Finset.mem_Icc.mpr ⟨by omega, hnN⟩)
      _ = _ := by rw [Nat.card_Icc]; omega
  have hp : ∀ n ∈ s, fareySectorMass n N ≤ 2 * (harmonic N : ℝ) / N := by
    intro n hn
    obtain ⟨hi, ha⟩ := Finset.mem_filter.mp hn
    obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hi
    have hnr : (0 : ℝ) < n := by exact_mod_cast hn1
    have hnlo : (N : ℝ) ≤ 2 * n := by
      exact_mod_cast (show N ≤ 2 * n by omega)
    calc
      _ ≤ (harmonic N : ℝ) / n :=
        fareySectorMass_le_harmonic_div h hn1 (by omega) (by omega)
      _ ≤ 2 * (harmonic N : ℝ) / N := by
        apply (div_le_div_iff₀ hnr hNr).mpr
        nlinarith [mul_le_mul_of_nonneg_left hnlo hH]
  change (∑ n ∈ s, fareySectorMass n N) ≤ _
  calc
    _ ≤ ∑ _n ∈ s, (2 * (harmonic N : ℝ) / N) := Finset.sum_le_sum hp
    _ = (s.card : ℝ) * (2 * (harmonic N : ℝ) / N) := by simp
    _ ≤ (Nat.sqrt N : ℝ) * (2 * (harmonic N : ℝ) / N) :=
      mul_le_mul_of_nonneg_right (by exact_mod_cast hc) (by positivity)
    _ ≤ Real.sqrt N * (2 * (harmonic N : ℝ) / N) :=
      mul_le_mul_of_nonneg_right Real.nat_sqrt_le_real_sqrt (by positivity)
    _ = (2 * (harmonic N : ℝ)) * (Real.sqrt N / N) := by ring
    _ = _ := by rw [Real.sqrt_div_self']; ring

end BuildingBlocks.CyclotomicBoundary
