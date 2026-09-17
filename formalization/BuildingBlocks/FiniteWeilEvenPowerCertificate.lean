import Mathlib.Tactic
import Mathlib.Data.Nat.Prime.Basic

namespace BuildingBlocks.FiniteWeilEvenPowerCertificate

set_option maxHeartbeats 0
set_option maxRecDepth 100000

def squareBases : List ℕ := [89, 97, 101, 103, 107, 109, 113]

theorem bounded_certificate :
    ∀ q ∈ Finset.range 116, ∀ k ∈ Finset.range 14,
      Nat.Prime q → 2 ≤ k → k % 2 = 0 →
      3 * 10007 ≤ 4 * q ^ k → 3 * q ^ k ≤ 4 * 10007 →
      k = 2 ∧ q ∈ squareBases := by
  decide

theorem all_even_prime_powers {q k : ℕ} (hq : Nat.Prime q)
    (hk : 2 ≤ k) (heven : k % 2 = 0)
    (hlo : 3 * 10007 ≤ 4 * q ^ k) (hhi : 3 * q ^ k ≤ 4 * 10007) :
    k = 2 ∧ q ∈ squareBases := by
  have hq2 : 2 ≤ q := hq.two_le
  have hk14 : k < 14 := by
    by_contra hn
    have h14 : 14 ≤ k := by omega
    have ha : (2 : ℕ) ^ 14 ≤ 2 ^ k := pow_le_pow_right' (by omega) h14
    have hb : (2 : ℕ) ^ k ≤ q ^ k := pow_le_pow_left' hq2 k
    norm_num at ha
    omega
  have hq116 : q < 116 := by
    have ha : q ^ 2 ≤ q ^ k := pow_le_pow_right' (by omega) hk
    by_contra hn
    have hb : 116 ≤ q := by omega
    have hc : (116 : ℕ) ^ 2 ≤ q ^ 2 := pow_le_pow_left' hb 2
    norm_num at hc
    omega
  exact bounded_certificate q (Finset.mem_range.mpr hq116)
    k (Finset.mem_range.mpr hk14) hq hk heven hlo hhi

theorem square_bases_valid : ∀ q ∈ squareBases,
    Nat.Prime q ∧ 3 * 10007 ≤ 4 * q ^ 2 ∧ 3 * q ^ 2 ≤ 4 * 10007 := by
  norm_num [squareBases]

theorem exact_classification {q k : ℕ} (hq : Nat.Prime q)
    (hk : 2 ≤ k) (heven : k % 2 = 0) :
    (3 * 10007 ≤ 4 * q ^ k ∧ 3 * q ^ k ≤ 4 * 10007) ↔
      (k = 2 ∧ q ∈ squareBases) := by
  constructor
  · rintro ⟨hlo, hhi⟩
    exact all_even_prime_powers hq hk heven hlo hhi
  · rintro ⟨rfl, hmem⟩
    exact (square_bases_valid q hmem).2

#print axioms bounded_certificate
#print axioms all_even_prime_powers
#print axioms square_bases_valid
#print axioms exact_classification

end BuildingBlocks.FiniteWeilEvenPowerCertificate
