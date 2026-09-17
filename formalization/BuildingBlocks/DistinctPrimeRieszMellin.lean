import BuildingBlocks.SelbergDistinctPrimes
import BuildingBlocks.SamePrimeDirichlet
import BuildingBlocks.RieszDirichlet
import Mathlib.NumberTheory.LSeries.Dirichlet
import Mathlib.NumberTheory.LSeries.Linearity
import Mathlib.Data.Nat.Prime.Int

open scoped BigOperators LSeries.notation

namespace BuildingBlocks.DistinctPrimeRieszMellin

noncomputable def lambda (n : ℕ) : ℂ := ArithmeticFunction.vonMangoldt n
noncomputable def fullPair : ℕ → ℂ := LSeries.convolution lambda lambda
noncomputable def samePair (n : ℕ) : ℂ := samePrimePairWeight n
noncomputable def distinctPair (n : ℕ) : ℂ := distinctPrimePairWeight n

theorem fullPair_eq (n : ℕ) : fullPair n =
    ((ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n : ℝ) := by
  simp only [fullPair, LSeries.convolution_def, ArithmeticFunction.mul_apply,
    lambda, Complex.ofReal_sum, Complex.ofReal_mul]

theorem distinctPair_eq : distinctPair = fullPair - samePair := by
  funext n
  simp only [distinctPair, distinctPrimePairWeight, Complex.ofReal_sub,
    Pi.sub_apply, fullPair_eq, samePair]

theorem fullPair_hasSum {s : ℂ} (hs : 1 < s.re) :
    LSeriesHasSum fullPair s ((-deriv riemannZeta s / riemannZeta s) ^ 2) := by
  have hl : LSeriesHasSum lambda s (-deriv riemannZeta s / riemannZeta s) :=
    LSeriesHasSum_iff.mpr ⟨ArithmeticFunction.LSeriesSummable_vonMangoldt hs,
      ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs⟩
  simpa only [fullPair, pow_two] using hl.convolution hl

def primePowerLabel (i : Nat.Primes × ℕ) : ℕ := (i.1 : ℕ) ^ (i.2 + 2)

theorem primePowerLabel_injective : Function.Injective primePowerLabel := by
  rintro ⟨p, k⟩ ⟨q, l⟩ h
  obtain ⟨hpq, hkl⟩ := p.property.pow_inj q.property
    (show (p : ℕ) ^ ((k + 1) + 1) = (q : ℕ) ^ ((l + 1) + 1) by
      simpa only [primePowerLabel, Nat.add_assoc] using h)
  apply Prod.ext
  · exact Subtype.ext hpq
  · omega

theorem samePair_zero_outside_range {n : ℕ} (hn : n ∉ Set.range primePowerLabel) :
    samePair n = 0 := by
  unfold samePair
  rw [samePrimePairWeight_eq_zero_unless_proper_power]
  · rfl
  · rintro ⟨p, k, hp, hk, hpk⟩
    apply hn
    refine ⟨(⟨p, hp⟩, k - 2), ?_⟩
    simpa only [primePowerLabel, Nat.sub_add_cancel hk] using hpk

theorem term_eq_mul_cpow_neg (c : ℕ → ℂ) (s : ℂ) {n : ℕ} (hn : n ≠ 0) :
    LSeries.term c s n = c n * (n : ℂ) ^ (-s) := by
  rw [LSeries.term_of_ne_zero hn, Complex.cpow_neg, div_eq_mul_inv]

theorem samePair_term_at_prime_power (s : ℂ) (i : Nat.Primes × ℕ) :
    LSeries.term samePair s (primePowerLabel i) =
      SamePrimeDirichlet.powerTerm i.1 i.2 s := by
  rcases i with ⟨p, k⟩
  dsimp only [primePowerLabel]
  rw [term_eq_mul_cpow_neg _ _ (pow_ne_zero _ p.property.ne_zero)]
  unfold samePair
  rw [samePrimePairWeight_prime_pow p.property (by omega)]
  rw [Nat.cast_pow, ← Complex.natCast_cpow_natCast_mul]
  rw [Complex.cpow_nat_mul]
  simp only [SamePrimeDirichlet.powerTerm, SamePrimeDirichlet.primeRatio,
    Complex.ofReal_mul, Complex.ofReal_sub, Complex.ofReal_pow,
    Complex.ofReal_one, Nat.cast_add, Nat.cast_ofNat]
  push_cast
  ring

/-- The actual proper-power coefficients reindex bijectively by prime and
exponent. This proves their Dirichlet series, rather than postulating it. -/
theorem samePair_hasSum {s : ℂ} (hs : 1 / 2 < s.re) :
    LSeriesHasSum samePair s (SamePrimeDirichlet.H s) := by
  have hout : ∀ n, n ∉ Set.range primePowerLabel → LSeries.term samePair s n = 0 := by
    intro n hn
    simp [LSeries.term, samePair_zero_outside_range hn]
  apply primePowerLabel_injective.hasSum_iff hout |>.mp
  have h := (SamePrimeDirichlet.powerTerm_norm_summable hs).of_norm.hasSum
  change HasSum (fun i : Nat.Primes × ℕ => SamePrimeDirichlet.powerTerm i.1 i.2 s)
    (SamePrimeDirichlet.expanded s) at h
  rw [SamePrimeDirichlet.expanded_eq_H hs] at h
  exact h.congr_fun (fun i => samePair_term_at_prime_power s i)

theorem distinctPair_hasSum {s : ℂ} (hs : 1 < s.re) :
    LSeriesHasSum distinctPair s
      ((-deriv riemannZeta s / riemannZeta s) ^ 2 - SamePrimeDirichlet.H s) := by
  rw [distinctPair_eq]
  exact LSeriesHasSum.sub (fullPair_hasSum hs) (samePair_hasSum (s := s) (by linarith))

/-- Convert ordinary absolute L-series convergence to the exact positive-index
bound used by the Riesz Fubini theorem. -/
theorem summable_norm_succ_of_LSeriesSummable {c : ℕ → ℂ} {s : ℂ}
    (hc : LSeriesSummable c s) :
    Summable (fun n : ℕ => ‖c (n + 1)‖ * (n + 1 : ℝ) ^ (-s.re)) := by
  have hn := hc.norm.comp_injective Nat.succ_injective
  apply hn.congr
  intro n
  change ‖LSeries.term c s (n + 1)‖ = ‖c (n + 1)‖ * (n + 1 : ℝ) ^ (-s.re)
  rw [LSeries.norm_term_eq, if_neg (by omega : n + 1 ≠ 0)]
  simp only [Nat.cast_add, Nat.cast_one, Real.rpow_neg (by positivity : (0 : ℝ) ≤ n + 1),
    div_eq_mul_inv]

theorem tsum_succ_eq_of_LSeriesHasSum {c : ℕ → ℂ} {s A : ℂ}
    (hc : LSeriesHasSum c s A) :
    (∑' n : ℕ, c (n + 1) * ((n + 1 : ℝ) : ℂ) ^ (-s)) = A := by
  have ht := hc.summable.tsum_eq_zero_add
  rw [LSeries.term_zero, zero_add] at ht
  calc
    _ = ∑' n : ℕ, LSeries.term c s (n + 1) := by
      apply tsum_congr
      intro n
      rw [term_eq_mul_cpow_neg _ _ (by omega : n + 1 ≠ 0)]
      simp
    _ = ∑' n : ℕ, LSeries.term c s n := ht.symm
    _ = A := hc.tsum_eq

theorem hasMellin_cutoffSum_of_LSeriesHasSum {c : ℕ → ℂ} {s A : ℂ}
    (hs : 0 < s.re) (hc : LSeriesHasSum c s A) :
    HasMellin (RieszDirichlet.cutoffSum c) (-s - 1) (A / (s * (s + 1))) := by
  have h := RieszDirichlet.hasMellin_cutoffSum c hs
    (summable_norm_succ_of_LSeriesSummable hc.LSeriesSummable)
  rw [tsum_succ_eq_of_LSeriesHasSum hc] at h
  exact h

/-- The actual distinct-prime Riesz sum has this Mellin transform on its
ordinary absolute-convergence domain. Every ordered pair and proper power is
accounted for by the coefficient identifications above. -/
theorem hasMellin_distinctPrime_cutoffSum {s : ℂ} (hs : 1 < s.re) :
    HasMellin (RieszDirichlet.cutoffSum distinctPair) (-s - 1)
      (((-deriv riemannZeta s / riemannZeta s) ^ 2 - SamePrimeDirichlet.H s) /
        (s * (s + 1))) :=
  hasMellin_cutoffSum_of_LSeriesHasSum (by linarith) (distinctPair_hasSum hs)

theorem distinctPair_eq_coprime_sum (n : ℕ) : distinctPair n =
    ∑ d ∈ n.divisors, if d.Coprime (n / d) then lambda d * lambda (n / d) else 0 := by
  classical
  simp only [distinctPair, distinctPrimePairWeight_eq_coprime_sum, Complex.ofReal_sum]
  apply Finset.sum_congr rfl
  intro d hd
  split_ifs <;> simp [lambda]

/-- The infinite-series proof consumes this actual finite cutoff, including
the coefficient at one and the zero-weight birth endpoint. -/
theorem cutoffSum_distinctPair_eq_Icc {x : ℝ} (hx : 0 ≤ x) :
    RieszDirichlet.cutoffSum distinctPair x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, ((x - n : ℝ) : ℂ) * (distinctPrimePairWeight n : ℂ) := by
  unfold RieszDirichlet.cutoffSum
  apply Finset.sum_bij (fun j _ => j + 1)
  · intro j hj
    simp only [Finset.mem_range] at hj
    simp only [Finset.mem_Icc]
    omega
  · intro i hi j hj hij
    omega
  · intro n hn
    simp only [Finset.mem_Icc] at hn
    exact ⟨n - 1, Finset.mem_range.mpr (by omega), by omega⟩
  · intro j hj
    have hjn : j + 1 ≤ ⌊x⌋₊ := by simpa only [Finset.mem_range] using hj
    have hjx : (j : ℝ) + 1 ≤ x := by
      have hcast : (j : ℝ) + 1 ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hjn
      exact hcast.trans (Nat.floor_le hx)
    simp only [distinctPair, RieszTentMellin.tent, Nat.cast_add, Nat.cast_one,
      max_eq_left (sub_nonneg.mpr hjx)]
    ring

end BuildingBlocks.DistinctPrimeRieszMellin
