import BuildingBlocks.PrimeHistoryFullW
import BuildingBlocks.ActualPrimeOrthantMoment
import BuildingBlocks.HyperbolaProduct
import BuildingBlocks.PrimeScoreDivisorIdentity
import Mathlib.Algebra.Order.Floor.Semifield
import Mathlib.Tactic

/-! An exact finite divisor-response identity for the original critical W.
All three coefficient rows retain the distinct-prime same-color subtraction,
the full von Mangoldt density term, and the continuous baseline. This does
not assert the signed inequality needed for RH.
-/

namespace BuildingBlocks.PrimeHistoryDivisorResponse

open Finset
open BuildingBlocks.PrimeHistoryCoefficientIdentification
open BuildingBlocks.PrimeHistoryFullW
open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.PrimeScoreDivisorIdentity
open BuildingBlocks.ActualCutoffOrthantMoments

noncomputable section

private def active (x : ℝ) (d : ℕ) : ℝ := if x / d ≤ 1 then 0 else 1

private theorem coefficientRawV_one : coefficientRawV 1 = 0 := by
  norm_num [coefficientRawV, distinctPrimePairWeight, samePrimePairWeight]

def Watomic (x : ℝ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * active x d *
    (∑ n ∈ Finset.Icc 1 ⌊x/d⌋₊,
      (x/d-n)*distinctPrimePairWeight n)

def Wdensity (x : ℝ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * active x d *
    (∑ n ∈ Finset.Icc 1 ⌊x/d⌋₊,
      ArithmeticFunction.vonMangoldt n*((x/d)^2-(n : ℝ)^2)/n)

def Wbaseline (x : ℝ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * active x d *
    ((x/d)^2*Real.log (x/d)/2+(x/d)^2/4-1/4)

/-- The original W, with no same-prime or density term discarded, splits
exactly into its existing coefficient-defined atomic, mixed, and continuous
pieces. This is a finite identity, not equation (22). -/
theorem W_eq_three_parts (x : ℝ) :
    W x = Watomic x - Wdensity x + Wbaseline x := by
  unfold W Watomic Wdensity Wbaseline
  rw [← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro d hd
  unfold active coefficientV coefficientRawV
  by_cases h : x / (d : ℝ) ≤ 1
  · simp [h]
  · simp [h]
    ring

private theorem retained_ratio_one_le {x : ℝ} {d : ℕ}
    (hd : d ∈ Finset.Icc 1 ⌊x⌋₊) : 1 ≤ x/d := by
  have hd0 : (0 : ℝ) < d := by exact_mod_cast (Finset.mem_Icc.mp hd).1
  have hx0 : 0 ≤ x := by
    have hd1 : 1 ≤ ⌊x⌋₊ := (Finset.mem_Icc.mp hd).1.trans
      (Finset.mem_Icc.mp hd).2
    by_contra h
    have : ⌊x⌋₊ = 0 := Nat.floor_of_nonpos (le_of_not_ge h)
    omega
  have hdle : (d : ℝ) ≤ x :=
    (Nat.le_floor_iff hx0).mp (Finset.mem_Icc.mp hd).2
  exact (one_le_div hd0).2 hdle

/-- Remove the causal indicator from the atomic part on exactly the
retained W support. At the equality endpoint the tent is zero. -/
theorem Watomic_eq_unrestricted (x : ℝ) :
    Watomic x =
      ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, ∑ m ∈ Finset.Icc 1 (⌊x⌋₊/d),
        Real.sqrt d * (x/d-m) * distinctPrimePairWeight m := by
  unfold Watomic
  apply Finset.sum_congr rfl
  intro d hd
  rw [Nat.floor_div_natCast]
  by_cases he : x/d ≤ 1
  · have hr : x/d = 1 := le_antisymm he (retained_ratio_one_le hd)
    have hfloor : ⌊x⌋₊/d = 1 := by
      rw [← Nat.floor_div_natCast, hr]
      norm_num
    simp [active, hfloor, hr]
  · simp [active, he, Finset.mul_sum, mul_assoc]

/-- The complete von Mangoldt row has the same harmless equality endpoint. -/
theorem Wdensity_eq_unrestricted (x : ℝ) :
    Wdensity x =
      ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, ∑ m ∈ Finset.Icc 1 (⌊x⌋₊/d),
        Real.sqrt d * ArithmeticFunction.vonMangoldt m *
          ((x/d)^2-(m : ℝ)^2)/m := by
  unfold Wdensity
  apply Finset.sum_congr rfl
  intro d hd
  rw [Nat.floor_div_natCast]
  by_cases he : x/d ≤ 1
  · have hr : x/d = 1 := le_antisymm he (retained_ratio_one_le hd)
    have hfloor : ⌊x⌋₊/d = 1 := by
      rw [← Nat.floor_div_natCast, hr]
      norm_num
    simp [active, hfloor, hr]
  · simp only [active, if_neg he, mul_one]
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro m hm
    ring

/-- The exact individual multiplicative-tent normalization. -/
theorem cofactor_tent_weight (c : ℕ → ℝ) {d m : ℕ} {x : ℝ}
    (hd : 0 < d) (hm : 0 < m) (hcut : (d*m : ℝ) ≤ x) :
    Real.sqrt d * (x/d-m) * c m =
      cutoffWeight x (d*m) * Real.sqrt m * c m := by
  have hdR : (0 : ℝ) < d := by exact_mod_cast hd
  have hmR : (0 : ℝ) < m := by exact_mod_cast hm
  have hdmR : (0 : ℝ) < (d*m : ℕ) := by exact_mod_cast Nat.mul_pos hd hm
  have hsd : Real.sqrt (d : ℝ) ≠ 0 := (Real.sqrt_pos.2 hdR).ne'
  have hsm : Real.sqrt (m : ℝ) ≠ 0 := (Real.sqrt_pos.2 hmR).ne'
  have hsq : (Real.sqrt (d : ℝ))^2 = d := Real.sq_sqrt hdR.le
  have hroot : Real.sqrt ((d*m : ℕ) : ℝ) =
      Real.sqrt (d : ℝ) * Real.sqrt (m : ℝ) := by
    rw [Nat.cast_mul, Real.sqrt_mul hdR.le]
  have hweight : cutoffWeight x (d*m) =
      (x-(d*m : ℕ))/Real.sqrt (d*m : ℕ) := by
    by_cases hlt : (d : ℝ) * m < x
    · simp [cutoffWeight, Nat.cast_mul, hlt]
    · have heq : (d : ℝ) * m = x := le_antisymm hcut (le_of_not_gt hlt)
      simp [cutoffWeight, Nat.cast_mul, heq]
  rw [hweight, hroot, Nat.cast_mul]
  field_simp
  rw [hsq]

/-- Atomic normalization with the repository's actual distinct-prime
coefficient, which includes the literal same-prime subtraction. -/
theorem atomic_cofactor_weight {d m : ℕ} {x : ℝ}
    (hd : 0 < d) (hm : 0 < m) (hcut : (d*m : ℝ) ≤ x) :
    Real.sqrt d * (x/d-m) * distinctPrimePairWeight m =
      cutoffWeight x (d*m) * Real.sqrt m * distinctPrimePairWeight m :=
  cofactor_tent_weight distinctPrimePairWeight hd hm hcut

/-- Exact normalization of the full von Mangoldt mixed term. The extra
`1+x/(dm)` factor must be retained; its constant part supplies the
linear score term in equation (22). -/
theorem mixed_cofactor_weight {d m : ℕ} {x : ℝ}
    (hd : 0 < d) (hm : 0 < m) (hcut : (d*m : ℝ) ≤ x) :
    Real.sqrt d * ArithmeticFunction.vonMangoldt m *
      ((x/d)^2-(m : ℝ)^2)/m =
      cutoffWeight x (d*m) * (1+x/(d*m : ℕ)) *
        Real.sqrt m * ArithmeticFunction.vonMangoldt m := by
  have hdR : (0 : ℝ) < d := by exact_mod_cast hd
  have hmR : (0 : ℝ) < m := by exact_mod_cast hm
  have hdmR : (0 : ℝ) < (d*m : ℕ) := by exact_mod_cast Nat.mul_pos hd hm
  have hbase := cofactor_tent_weight
    (fun _ => (1 : ℝ)) hd hm hcut
  simp only [mul_one] at hbase
  calc
    _ = (Real.sqrt d * (x/d-m)) * (1+x/(d*m : ℕ)) *
          ArithmeticFunction.vonMangoldt m := by
      rw [Nat.cast_mul]
      field_simp
      ring
    _ = (cutoffWeight x (d*m) * Real.sqrt m) *
          (1+x/(d*m : ℕ)) * ArithmeticFunction.vonMangoldt m := by
      rw [hbase]
    _ = _ := by ring

/-- Global finite reindex of the exact atomic coefficient of W onto the
original cutoff law. This is the nontrivial `(d,m) ↔ (n,d∣n)` step; its
remaining pointwise divisor score is not replaced by an assumed moment. -/
theorem atomic_row_reindex (N : ℕ) (x : ℝ) (hNx : (N : ℝ) ≤ x) :
    (∑ d ∈ Finset.Icc 1 N, ∑ m ∈ Finset.Icc 1 (N/d),
      Real.sqrt d * (x/d-m) * distinctPrimePairWeight m) =
    ∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n *
        (∑ m ∈ n.divisors, Real.sqrt m * distinctPrimePairWeight m) := by
  classical
  rw [← BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
    (fun d m => Real.sqrt d * (x/d-m) * distinctPrimePairWeight m)]
  apply Finset.sum_congr rfl
  intro n hn
  obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
  have hnNR : (n : ℝ) ≤ N := by exact_mod_cast hnN
  have hnx : (n : ℝ) ≤ x := hnNR.trans hNx
  rw [Finset.mul_sum]
  calc
    (∑ d ∈ n.divisors,
      Real.sqrt d * (x/d-(n/d : ℕ)) * distinctPrimePairWeight (n/d)) =
      ∑ d ∈ n.divisors,
        cutoffWeight x n * Real.sqrt (n/d : ℕ) * distinctPrimePairWeight (n/d) := by
      apply Finset.sum_congr rfl
      intro d hdmem
      obtain ⟨hdvd, hn0⟩ := Nat.mem_divisors.mp hdmem
      have hd : 0 < d := Nat.pos_of_dvd_of_pos hdvd hn1
      have hm : 0 < n/d := Nat.div_pos (Nat.le_of_dvd hn1 hdvd) hd
      have hmul : d*(n/d) = n := by
        simpa [Nat.mul_comm] using Nat.div_mul_cancel hdvd
      have hcut : ((d*(n/d) : ℕ) : ℝ) ≤ x := by simpa [hmul] using hnx
      have hcut' : (d : ℝ) * (n/d : ℕ) ≤ x := by
        simpa [Nat.cast_mul] using hcut
      simpa [hmul] using atomic_cofactor_weight hd hm hcut'
    _ = _ := by
      simp_rw [mul_assoc]
      rw [← Finset.mul_sum]
      have hdiv := Nat.sum_div_divisors n
        (fun m => Real.sqrt (m : ℝ) * distinctPrimePairWeight m)
      rw [hdiv, Finset.mul_sum]

/-- The equally exact mixed von Mangoldt reindex. The factor `1+x/n`
contains both the linear score and the density coupling; neither is
discarded. -/
theorem mixed_row_reindex (N : ℕ) (x : ℝ) (hNx : (N : ℝ) ≤ x) :
    (∑ d ∈ Finset.Icc 1 N, ∑ m ∈ Finset.Icc 1 (N/d),
      Real.sqrt d * ArithmeticFunction.vonMangoldt m *
        ((x/d)^2-(m : ℝ)^2)/m) =
    ∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * (1+x/n) *
        (∑ m ∈ n.divisors,
          Real.sqrt m * ArithmeticFunction.vonMangoldt m) := by
  classical
  rw [← BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
    (fun d m => Real.sqrt d * ArithmeticFunction.vonMangoldt m *
      ((x/d)^2-(m : ℝ)^2)/m)]
  apply Finset.sum_congr rfl
  intro n hn
  obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
  have hnNR : (n : ℝ) ≤ N := by exact_mod_cast hnN
  have hnx : (n : ℝ) ≤ x := hnNR.trans hNx
  rw [Finset.mul_sum]
  calc
    (∑ d ∈ n.divisors,
      Real.sqrt d * ArithmeticFunction.vonMangoldt (n/d) *
        ((x/d)^2-(n/d : ℕ)^2)/(n/d : ℕ)) =
      ∑ d ∈ n.divisors,
        cutoffWeight x n * (1+x/n) * Real.sqrt (n/d : ℕ) *
          ArithmeticFunction.vonMangoldt (n/d) := by
      apply Finset.sum_congr rfl
      intro d hdmem
      obtain ⟨hdvd, hn0⟩ := Nat.mem_divisors.mp hdmem
      have hd : 0 < d := Nat.pos_of_dvd_of_pos hdvd hn1
      have hm : 0 < n/d := Nat.div_pos (Nat.le_of_dvd hn1 hdvd) hd
      have hmul : d*(n/d) = n := by
        simpa [Nat.mul_comm] using Nat.div_mul_cancel hdvd
      have hcut : (d : ℝ) * (n/d : ℕ) ≤ x := by
        have hmulR : (d : ℝ) * (n/d : ℕ) = n := by exact_mod_cast hmul
        rw [hmulR]
        exact hnx
      simpa [hmul] using mixed_cofactor_weight hd hm hcut
    _ = _ := by
      simp_rw [mul_assoc]
      rw [← Finset.mul_sum, ← Finset.mul_sum]
      have hdiv := Nat.sum_div_divisors n
        (fun m => Real.sqrt (m : ℝ) * ArithmeticFunction.vonMangoldt m)
      rw [hdiv, Finset.mul_sum, Finset.mul_sum]

/-- The exact remaining continuous baseline from the same coefficient V. -/
def R (z : ℝ) : ℝ :=
  (1+z)^2 / (2*z) * Real.log (1+z) - 1/2 - 3*z/4

private def B (y : ℝ) : ℝ :=
  y^2 * Real.log y / 2 + y^2 / 4 - 1 / 4

private theorem baseline_factor {x : ℝ} {n : ℕ}
    (hn : 0 < n) (hxn : (n : ℝ) < x) :
    Real.sqrt n * B (x/n) =
      cutoffWeight x n * (1 + (x/n-1) + R (x/n-1)) := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hroot : Real.sqrt (n : ℝ) ≠ 0 := (Real.sqrt_pos.2 hnR).ne'
  have hsq : (Real.sqrt (n : ℝ))^2 = n := Real.sq_sqrt hnR.le
  have hgap : x / n - 1 ≠ 0 := by
    apply ne_of_gt
    exact sub_pos.mpr ((one_lt_div hnR).mpr hxn)
  have hxn0 : x - (n : ℝ) ≠ 0 := ne_of_gt (sub_pos.mpr hxn)
  have hlog : 1 + (x / n - 1) = x / n := by ring
  rw [cutoffWeight, if_pos hxn]
  unfold B R
  rw [hlog]
  field_simp [hgap, hxn0, hroot, ne_of_gt hnR]
  rw [hsq]
  ring

private theorem baseline_factor_le {x : ℝ} {n : ℕ}
    (hn : 0 < n) (hxn : (n : ℝ) ≤ x) :
    Real.sqrt n * B (x/n) =
      cutoffWeight x n * (1 + (x/n-1) + R (x/n-1)) := by
  rcases hxn.lt_or_eq with hlt | heq
  · exact baseline_factor hn hlt
  · have hnR : (0 : ℝ) < n := by exact_mod_cast hn
    rw [← heq]
    simp [B, cutoffWeight, hnR.ne']

/-- Exact baseline row on the full active cutoff support, including `n=x`
as a zero endpoint. -/
theorem Wbaseline_eq_cutoff_row {x : ℝ} (hx : 1 < x) :
    Wbaseline x = ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
      cutoffWeight x n * (1 + (x/n-1) + R (x/n-1)) := by
  unfold Wbaseline
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : 0 < n := (Finset.mem_Icc.mp hn).1
  have hnx : (n : ℝ) ≤ x :=
    (Nat.le_floor_iff (by linarith : 0 ≤ x)).mp (Finset.mem_Icc.mp hn).2
  have hfactor := baseline_factor_le hn0 hnx
  by_cases hlt : (n : ℝ) < x
  · have hnR : (0 : ℝ) < n := by exact_mod_cast hn0
    have hnot : ¬x / (n : ℝ) ≤ 1 :=
      not_le.mpr ((one_lt_div hnR).mpr hlt)
    simpa [active, B, hnot] using hfactor
  · have heq : (n : ℝ) = x := le_antisymm hnx (le_of_not_gt hlt)
    have hnR : (0 : ℝ) < n := by exact_mod_cast hn0
    rw [← heq]
    simp [active, cutoffWeight, hnR.ne']

/-- Complete finite divisor-response identity for the literal W. The
divisor sums are the exact atomic and von Mangoldt scores; this theorem
does not yet replace the first by a prime-color square or the second by
the complete prime-score sum. -/
theorem W_eq_divisor_response {x : ℝ} (hx : 1 < x) :
    W x = ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
      cutoffWeight x n *
        ((∑ m ∈ n.divisors, Real.sqrt m * distinctPrimePairWeight m) -
         (1+x/n) *
           (∑ m ∈ n.divisors,
             Real.sqrt m * ArithmeticFunction.vonMangoldt m) +
         (1+(x/n-1)+R (x/n-1))) := by
  have hfloor : ((⌊x⌋₊ : ℕ) : ℝ) ≤ x :=
    Nat.floor_le (by linarith : 0 ≤ x)
  rw [W_eq_three_parts, Watomic_eq_unrestricted, Wdensity_eq_unrestricted,
    Wbaseline_eq_cutoff_row hx, atomic_row_reindex ⌊x⌋₊ x hfloor,
    mixed_row_reindex ⌊x⌋₊ x hfloor]
  rw [← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  ring

/-- The complete von Mangoldt divisor row in the original W is exactly the
sum of all p-adic prime scores. The distinct-prime row remains in divisor
form; no sign or bound for W is assumed. -/
theorem W_eq_prime_score_response {x : ℝ} (hx : 1 < x) :
    W x = ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
      cutoffWeight x n *
        ((∑ m ∈ n.divisors, Real.sqrt m * distinctPrimePairWeight m) -
         (1+x/n) * (∑ p ∈ n.primeFactors, fullPrimeScore p n) +
         (1+(x/n-1)+R (x/n-1))) := by
  rw [W_eq_divisor_response hx]
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : n ≠ 0 := Nat.ne_of_gt (Finset.mem_Icc.mp hn).1
  rw [weighted_divisor_prime_score hn0]

def divisorResponse (x : ℝ) (n : ℕ) : ℝ :=
  (∑ m ∈ n.divisors, Real.sqrt m * distinctPrimePairWeight m) -
    (1+x/n) *
      (∑ m ∈ n.divisors,
        Real.sqrt m * ArithmeticFunction.vonMangoldt m) +
    (1+(x/n-1)+R (x/n-1))

/-- The exact original W divided by the actual cutoff mass is the
expectation of its complete finite divisor response under the original
cutoff probability law. The pointwise identification of that response
with the prime-color quadratic is a separate arithmetic theorem. -/
theorem W_normalized_eq_actual_expectation {x : ℝ} (hx : 1 < x) :
    W x / cutoffMass ⌊x⌋₊ x =
      BuildingBlocks.ActualCutoffOrthantMoments.expect (cutoffProbMass ⌊x⌋₊ x)
        (fun n : cutoffSample ⌊x⌋₊ => divisorResponse x n.1) := by
  classical
  rw [W_eq_divisor_response hx]
  unfold BuildingBlocks.ActualCutoffOrthantMoments.expect cutoffProbMass
  change (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, cutoffWeight x n * divisorResponse x n) /
      cutoffMass ⌊x⌋₊ x =
    ∑ n ∈ (Finset.Icc 1 ⌊x⌋₊).attach,
      cutoffWeight x n.1 / cutoffMass ⌊x⌋₊ x * divisorResponse x n.1
  rw [Finset.sum_div]
  calc
    (∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        cutoffWeight x n * divisorResponse x n / cutoffMass ⌊x⌋₊ x) =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        cutoffWeight x n / cutoffMass ⌊x⌋₊ x * divisorResponse x n := by
      apply Finset.sum_congr rfl
      intro n hn
      ring
    _ = _ := (Finset.sum_attach (Finset.Icc 1 ⌊x⌋₊)
      (fun n : ℕ => cutoffWeight x n / cutoffMass ⌊x⌋₊ x * divisorResponse x n)).symm

#print axioms W_eq_three_parts
#print axioms atomic_cofactor_weight
#print axioms mixed_cofactor_weight
#print axioms atomic_row_reindex
#print axioms mixed_row_reindex
#print axioms W_eq_divisor_response
#print axioms W_eq_prime_score_response
#print axioms W_normalized_eq_actual_expectation

end
end BuildingBlocks.PrimeHistoryDivisorResponse
