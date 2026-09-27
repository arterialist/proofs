import BuildingBlocks.ActualVolterraIdentity
import BuildingBlocks.PrimeScoreDivisorIdentity
import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Tactic

/-! Exact finite all-prime-power cofactor reindexing for Eq22, plus abstract centered convolution algebra. The convolution symbol laws require a named ring homomorphism and named Mellin identities; this file supplies no analytic inversion or RH bound. -/

namespace BuildingBlocks.ActualEq22Residual

open Finset
open BuildingBlocks.ActualVolterraIdentity
open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite
open BuildingBlocks.PrimeScoreDivisorIdentity

noncomputable section

private theorem sum_divisors_eq_cutoff_indicator
    (N n : ℕ) (hn : n ∈ Finset.Icc 1 N) (f : ℕ → ℝ) :
    (∑ q ∈ n.divisors, f q) =
      ∑ q ∈ Finset.Icc 1 N, if q ∣ n then f q else 0 := by
  obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
  have hn0 : n ≠ 0 := by omega
  have hsub : n.divisors ⊆ Finset.Icc 1 N := by
    intro q hq
    obtain ⟨hdiv, _⟩ := Nat.mem_divisors.mp hq
    exact Finset.mem_Icc.mpr
      ⟨Nat.pos_of_dvd_of_pos hdiv hn1, (Nat.le_of_dvd hn1 hdiv).trans hnN⟩
  calc
    _ = ∑ q ∈ n.divisors, if q ∣ n then f q else 0 := by
      apply Finset.sum_congr rfl
      intro q hq
      simp [(Nat.mem_divisors.mp hq).1]
    _ = ∑ q ∈ Finset.Icc 1 N, if q ∣ n then f q else 0 := by
      apply Finset.sum_subset hsub
      intro q hq hnot
      have hnd : ¬q ∣ n := by
        intro hd
        exact hnot (Nat.mem_divisors.mpr ⟨hd, hn0⟩)
      simp [hnd]

private theorem completeScore_eq_cutoff_divisor_sum
    (N n : ℕ) (hn : n ∈ Finset.Icc 1 N) :
    completeScore n =
      ∑ q ∈ Finset.Icc 1 N,
        if q ∣ n then Real.sqrt (q : ℝ) * ArithmeticFunction.vonMangoldt q else 0 := by
  have hn0 : n ≠ 0 := by
    have := (Finset.mem_Icc.mp hn).1
    omega
  unfold completeScore
  rw [← weighted_divisor_prime_score hn0]
  exact sum_divisors_eq_cutoff_indicator N n hn _

/-- The original sample-side density/score numerator is exactly the full
von Mangoldt prime-power dilation of the density mass. -/
theorem DnumOn_eq_prime_dilation {N : ℕ} {x : ℝ}
    (hx : x ≤ (N : ℝ) + 1) :
    DnumOn N x =
      ∑ q ∈ Finset.Icc 1 N,
        ArithmeticFunction.vonMangoldt q *
          ((q : ℝ) * densityMass N (x / q)) := by
  unfold DnumOn
  calc
    (∑ n ∈ Finset.Icc 1 N,
        cutoffWeight x n * densityScore x n * completeScore n) =
      ∑ n ∈ Finset.Icc 1 N,
        cutoffWeight x n * densityScore x n *
          ∑ q ∈ Finset.Icc 1 N,
            if q ∣ n then Real.sqrt (q : ℝ) * ArithmeticFunction.vonMangoldt q
            else 0 := by
              apply Finset.sum_congr rfl
              intro n hn
              rw [completeScore_eq_cutoff_divisor_sum N n hn]
    _ = ∑ q ∈ Finset.Icc 1 N,
          ArithmeticFunction.vonMangoldt q *
            ∑ n ∈ Finset.Icc 1 N,
              cutoffWeight x n * densityScore x n *
                (if q ∣ n then Real.sqrt (q : ℝ) else 0) := by
              simp_rw [Finset.mul_sum]
              rw [Finset.sum_comm]
              apply Finset.sum_congr rfl
              intro q hq
              apply Finset.sum_congr rfl
              intro n hn
              split_ifs <;> ring
    _ = _ := by
      apply Finset.sum_congr rfl
      intro q hq
      rw [cutoff_prime_power_density_mass (Finset.mem_Icc.mp hq).1 hx]

def scoreMassOn (N : ℕ) (y : ℝ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 N, cutoffWeight y d * completeScore d

private theorem scoreMassOn_stable {M N : ℕ} {y : ℝ}
    (hMN : M ≤ N) (hy : y ≤ (M : ℝ) + 1) :
    scoreMassOn N y = scoreMassOn M y := by
  unfold scoreMassOn
  symm
  apply Finset.sum_subset
  · intro n hn
    exact Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hn).1, (Finset.mem_Icc.mp hn).2.trans hMN⟩
  · intro n hnN hnM
    have hnlarge : M < n := by
      have hnlo := (Finset.mem_Icc.mp hnN).1
      have hnot : ¬n ≤ M := by
        intro hnle
        exact hnM (Finset.mem_Icc.mpr ⟨hnlo, hnle⟩)
      omega
    have hnot : ¬(n : ℝ) < y := by
      have hcast : (M : ℝ) + 1 ≤ n := by exact_mod_cast hnlarge
      exact not_lt.mpr (hy.trans hcast)
    simp [cutoffWeight, hnot]

private theorem ArawOn_stable_local {M N : ℕ} {y : ℝ}
    (hMN : M ≤ N) (hy : y ≤ (M : ℝ) + 1) :
    ArawOn N y = ArawOn M y := by
  change densityMass N y / 2 - scoreMassOn N y =
    densityMass M y / 2 - scoreMassOn M y
  rw [densityMass_stable hMN hy, scoreMassOn_stable hMN hy]

theorem ArawOn_floor_dilation_eq_Araw {x : ℝ} (hx : 1 ≤ x)
    {q : ℕ} (hq : q ∈ Finset.Icc 1 ⌊x⌋₊) :
    ArawOn ⌊x⌋₊ (x / q) = Araw (x / q) := by
  obtain ⟨hq1, hqN⟩ := Finset.mem_Icc.mp hq
  have hqpos : (0 : ℝ) < q := by exact_mod_cast hq1
  have hq_le_x : (q : ℝ) ≤ x :=
    (by exact_mod_cast hqN : (q : ℝ) ≤ ⌊x⌋₊).trans (Nat.floor_le (by linarith))
  have hq_real : (1 : ℝ) ≤ q := by exact_mod_cast hq1
  have hyx : x / (q : ℝ) ≤ x := div_le_self (by linarith) hq_real
  have hfloor : ⌊x / (q : ℝ)⌋₊ ≤ ⌊x⌋₊ := Nat.floor_mono hyx
  have hybound : x / (q : ℝ) ≤ (⌊x / (q : ℝ)⌋₊ : ℝ) + 1 :=
    (Nat.lt_floor_add_one (x / q)).le
  unfold Araw
  exact ArawOn_stable_local hfloor hybound

private theorem Araw_one : Araw 1 = 0 := by
  simp [Araw, ArawOn, densityMass, cutoffWeight]

/-- The original cofactor form of the full prime-score/density T numerator. -/
def TnumOn (N : ℕ) (x : ℝ) : ℝ :=
  ∑ q ∈ Finset.Icc 1 N,
    ArithmeticFunction.vonMangoldt q * (q : ℝ) *
      (densityMass N (x / q) - scoreMassOn N (x / q))

theorem TnumOn_sub_DnumOn_half_eq_prime_dilation {N : ℕ} {x : ℝ}
    (hx : x ≤ (N : ℝ) + 1) :
    TnumOn N x - DnumOn N x / 2 =
      ∑ q ∈ Finset.Icc 1 N,
        ArithmeticFunction.vonMangoldt q * (q : ℝ) * ArawOn N (x / q) := by
  rw [DnumOn_eq_prime_dilation hx]
  unfold TnumOn ArawOn scoreMassOn
  rw [Finset.sum_div, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro q hq
  ring

def Tnum (x : ℝ) : ℝ := TnumOn ⌊x⌋₊ x

/-- Finite candidates with `2 ≤ q < x`; their von Mangoldt weights vanish
unless `q` is a prime power. -/
def strictPrimePowerSet (x : ℝ) : Finset ℕ :=
  (Finset.Icc 2 ⌊x⌋₊).filter (fun q => (q : ℝ) < x)

/-- The nonzero von Mangoldt support inside the strict cutoff. -/
def activePrimePowerSet (x : ℝ) : Finset ℕ :=
  (strictPrimePowerSet x).filter IsPrimePow

def strictPrimeDilation (x : ℝ) : ℝ :=
  ∑ q ∈ strictPrimePowerSet x,
    ArithmeticFunction.vonMangoldt q * (q : ℝ) * Araw (x / q)

theorem strictPrimeDilation_eq_primePowerSum (x : ℝ) :
    strictPrimeDilation x =
      ∑ q ∈ activePrimePowerSet x,
        ArithmeticFunction.vonMangoldt q * (q : ℝ) * Araw (x / q) := by
  unfold strictPrimeDilation activePrimePowerSet
  symm
  apply Finset.sum_subset
  · intro q hq
    exact (Finset.mem_filter.mp hq).1
  · intro q hq hnot
    have hnp : ¬IsPrimePow q := by
      intro hp
      exact hnot (Finset.mem_filter.mpr ⟨hq, hp⟩)
    simp [ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr hnp]

theorem Tnum_sub_Dnum_half_eq_strictPrimeDilation {x : ℝ} (hx : 1 ≤ x) :
    Tnum x - Dnum x / 2 = strictPrimeDilation x := by
  let N := ⌊x⌋₊
  have hxN : x ≤ (N : ℝ) + 1 := (Nat.lt_floor_add_one x).le
  have hNx : (N : ℝ) ≤ x := Nat.floor_le (by linarith)
  unfold Tnum Dnum
  rw [TnumOn_sub_DnumOn_half_eq_prime_dilation hxN]
  have hadaptive :
      (∑ q ∈ Finset.Icc 1 N,
        ArithmeticFunction.vonMangoldt q * (q : ℝ) * ArawOn N (x / q)) =
      ∑ q ∈ Finset.Icc 1 N,
        ArithmeticFunction.vonMangoldt q * (q : ℝ) * Araw (x / q) := by
    apply Finset.sum_congr rfl
    intro q hq
    rw [ArawOn_floor_dilation_eq_Araw hx hq]
  rw [hadaptive]
  unfold strictPrimeDilation strictPrimePowerSet
  symm
  apply Finset.sum_subset
  · intro q hq
    have hq2 := (Finset.mem_Icc.mp (Finset.mem_filter.mp hq).1).1
    exact Finset.mem_Icc.mpr ⟨by omega, (Finset.mem_Icc.mp (Finset.mem_filter.mp hq).1).2⟩
  · intro q hq hnot
    obtain ⟨hq1, hqN⟩ := Finset.mem_Icc.mp hq
    by_cases hqeq : q = 1
    · subst q
      simp [ArithmeticFunction.vonMangoldt_apply_one]
    have hq2 : 2 ≤ q := by omega
    have hnotlt : ¬(q : ℝ) < x := by
      intro hlt
      exact hnot (Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr ⟨hq2, hqN⟩, hlt⟩)
    have hqle : (q : ℝ) ≤ x :=
      (by exact_mod_cast hqN : (q : ℝ) ≤ N).trans hNx
    have hqxeq : (q : ℝ) = x := le_antisymm hqle (le_of_not_gt hnotlt)
    have hqpos : (0 : ℝ) < q := by exact_mod_cast hq1
    have hdiv : x / (q : ℝ) = 1 := by
      rw [← hqxeq]
      exact div_self hqpos.ne'
    simp [hdiv, Araw_one]

theorem actual_residual_eq_volterra_sub_strictPrimeDilation {x : ℝ}
    (hx : 1 ≤ x) :
    Rnum x - Tnum x =
      x ^ 2 * (∫ y in (1 : ℝ)..x, Araw y / y ^ 3) -
        ∑ q ∈ strictPrimePowerSet x,
          ArithmeticFunction.vonMangoldt q * (q : ℝ) * Araw (x / q) := by
  have hV := volterra_actual_all_real hx
  have hT := Tnum_sub_Dnum_half_eq_strictPrimeDilation hx
  unfold strictPrimeDilation at hT
  linarith

private theorem scoreMass_adaptive_eq_Z_mu {y : ℝ} (hy : 1 < y) :
    scoreMassOn ⌊y⌋₊ y = Z y * mu y := by
  have hfloor : 1 ≤ ⌊y⌋₊ := by
    apply (Nat.le_floor_iff (by linarith : 0 ≤ y)).2
    simpa using hy.le
  have hZ : Z y ≠ 0 := (cutoffMass_pos hfloor hy).ne'
  unfold scoreMassOn mu
  dsimp only [Z] at hZ ⊢
  field_simp [hZ]

private theorem densityMass_floor_dilation_eq_Z_beta {x : ℝ}
    {q : ℕ} (hq : q ∈ strictPrimePowerSet x) :
    densityMass ⌊x⌋₊ (x / q) = Z (x / q) * beta (x / q) := by
  have hqI : q ∈ Finset.Icc 1 ⌊x⌋₊ := by
    obtain ⟨h, _⟩ := Finset.mem_filter.mp hq
    obtain ⟨h2, hN⟩ := Finset.mem_Icc.mp h
    exact Finset.mem_Icc.mpr ⟨by omega, hN⟩
  obtain ⟨_, hqx⟩ := Finset.mem_filter.mp hq
  have hq1 : (1 : ℝ) ≤ q := by
    have h2 := (Finset.mem_Icc.mp hqI).1
    exact_mod_cast h2
  have hyx : x / (q : ℝ) ≤ x := div_le_self (by linarith) hq1
  have hfloor : ⌊x / (q : ℝ)⌋₊ ≤ ⌊x⌋₊ := Nat.floor_mono hyx
  have hybound : x / (q : ℝ) ≤ (⌊x / (q : ℝ)⌋₊ : ℝ) + 1 :=
    (Nat.lt_floor_add_one (x / q)).le
  rw [densityMass_stable hfloor hybound]
  exact densityMass_eq_mass_mul_densityMean _ _

private theorem scoreMass_floor_dilation_eq_Z_mu {x : ℝ}
    {q : ℕ} (hq : q ∈ strictPrimePowerSet x) :
    scoreMassOn ⌊x⌋₊ (x / q) = Z (x / q) * mu (x / q) := by
  have hqI : q ∈ Finset.Icc 1 ⌊x⌋₊ := by
    obtain ⟨h, _⟩ := Finset.mem_filter.mp hq
    obtain ⟨h2, hN⟩ := Finset.mem_Icc.mp h
    exact Finset.mem_Icc.mpr ⟨by omega, hN⟩
  obtain ⟨_, hqx⟩ := Finset.mem_filter.mp hq
  have hq1 : (1 : ℝ) ≤ q := by
    have h2 := (Finset.mem_Icc.mp hqI).1
    exact_mod_cast h2
  have hyx : x / (q : ℝ) ≤ x := div_le_self (by linarith) hq1
  have hfloor : ⌊x / (q : ℝ)⌋₊ ≤ ⌊x⌋₊ := Nat.floor_mono hyx
  have hybound : x / (q : ℝ) ≤ (⌊x / (q : ℝ)⌋₊ : ℝ) + 1 :=
    (Nat.lt_floor_add_one (x / q)).le
  rw [scoreMassOn_stable hfloor hybound]
  have hqpos : (0 : ℝ) < q := by
    have h2 := (Finset.mem_Icc.mp hqI).1
    exact_mod_cast h2
  exact scoreMass_adaptive_eq_Z_mu ((one_lt_div hqpos).2 hqx)

/-- The literal normalized cofactor `T` numerator in the published notation. -/
def Tnormalized (x : ℝ) : ℝ :=
  ∑ q ∈ strictPrimePowerSet x,
    ArithmeticFunction.vonMangoldt q * (q : ℝ) *
      (Z (x / q) * (beta (x / q) - mu (x / q)))

theorem Tnormalized_eq_primePowerSum (x : ℝ) :
    Tnormalized x =
      ∑ q ∈ activePrimePowerSet x,
        ArithmeticFunction.vonMangoldt q * (q : ℝ) *
          (Z (x / q) * (beta (x / q) - mu (x / q))) := by
  unfold Tnormalized activePrimePowerSet
  symm
  apply Finset.sum_subset
  · intro q hq
    exact (Finset.mem_filter.mp hq).1
  · intro q hq hnot
    have hnp : ¬IsPrimePow q := by
      intro hp
      exact hnot (Finset.mem_filter.mpr ⟨hq, hp⟩)
    simp [ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr hnp]

/-- The published dimensionless mixed moment `T`, with the complete
von Mangoldt prime-power weight `Λ(q) q Z(x/q) / Z(x)`. -/
def T (x : ℝ) : ℝ :=
  ∑ q ∈ activePrimePowerSet x,
    (ArithmeticFunction.vonMangoldt q * (q : ℝ) * Z (x / q) / Z x) *
      (beta (x / q) - mu (x / q))

theorem Z_mul_T_eq_Tnormalized {x : ℝ} (hx : 1 < x) :
    Z x * T x = Tnormalized x := by
  have hfloor : 1 ≤ ⌊x⌋₊ := by
    apply (Nat.le_floor_iff (by linarith : 0 ≤ x)).2
    simpa using hx.le
  have hZ : Z x ≠ 0 := (cutoffMass_pos hfloor hx).ne'
  rw [Tnormalized_eq_primePowerSum]
  unfold T
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro q hq
  field_simp [hZ]

theorem Tnum_eq_Tnormalized {x : ℝ} (hx : 1 ≤ x) :
    Tnum x = Tnormalized x := by
  unfold Tnum TnumOn Tnormalized
  have hsum :
      (∑ q ∈ Finset.Icc 1 ⌊x⌋₊,
        ArithmeticFunction.vonMangoldt q * (q : ℝ) *
          (densityMass ⌊x⌋₊ (x / q) - scoreMassOn ⌊x⌋₊ (x / q))) =
      ∑ q ∈ strictPrimePowerSet x,
        ArithmeticFunction.vonMangoldt q * (q : ℝ) *
          (densityMass ⌊x⌋₊ (x / q) - scoreMassOn ⌊x⌋₊ (x / q)) := by
    symm
    apply Finset.sum_subset
    · intro q hq
      obtain ⟨h, _⟩ := Finset.mem_filter.mp hq
      obtain ⟨h2, hN⟩ := Finset.mem_Icc.mp h
      exact Finset.mem_Icc.mpr ⟨by omega, hN⟩
    · intro q hq hnot
      obtain ⟨hq1, hqN⟩ := Finset.mem_Icc.mp hq
      by_cases hqeq : q = 1
      · subst q
        simp [ArithmeticFunction.vonMangoldt_apply_one]
      have hq2 : 2 ≤ q := by omega
      have hnotlt : ¬(q : ℝ) < x := by
        intro hlt
        exact hnot (Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr ⟨hq2, hqN⟩, hlt⟩)
      have hqle : (q : ℝ) ≤ x :=
        (by exact_mod_cast hqN : (q : ℝ) ≤ ⌊x⌋₊).trans
          (Nat.floor_le (by linarith : 0 ≤ x))
      have hqxeq : (q : ℝ) = x := le_antisymm hqle (le_of_not_gt hnotlt)
      have hqpos : (0 : ℝ) < q := by exact_mod_cast hq1
      have hdiv : x / (q : ℝ) = 1 := by
        rw [← hqxeq]
        exact div_self hqpos.ne'
      rw [hdiv]
      simp [densityMass, scoreMassOn, cutoffWeight]
  rw [hsum]
  apply Finset.sum_congr rfl
  intro q hq
  rw [densityMass_floor_dilation_eq_Z_beta hq,
      scoreMass_floor_dilation_eq_Z_mu hq]
  ring

/-- The literal normalized cofactor residual, with exactly the active
von Mangoldt prime powers and no conditional analytic hypothesis. -/
theorem actual_residual_eq_volterra_sub_primePowers {x : ℝ} (hx : 1 ≤ x) :
    Rnum x - Tnormalized x =
      x ^ 2 * (∫ y in (1 : ℝ)..x, Araw y / y ^ 3) -
        ∑ q ∈ activePrimePowerSet x,
          ArithmeticFunction.vonMangoldt q * (q : ℝ) * Araw (x / q) := by
  calc
    _ = Rnum x - Tnum x := by rw [Tnum_eq_Tnormalized hx]
    _ = x ^ 2 * (∫ y in (1 : ℝ)..x, Araw y / y ^ 3) -
        strictPrimeDilation x := by
          simpa [strictPrimeDilation] using
            actual_residual_eq_volterra_sub_strictPrimeDilation hx
    _ = _ := by rw [strictPrimeDilation_eq_primePowerSum]

/-- Equation (1) minus equation (5) in the published notation. The left
side is the literal `Z_x(E_xR-T)` numerator. -/
theorem actual_residual_eq_published_T {x : ℝ} (hx : 1 < x) :
    Rnum x - Z x * T x =
      x ^ 2 * (∫ y in (1 : ℝ)..x, Araw y / y ^ 3) -
        ∑ q ∈ activePrimePowerSet x,
          ArithmeticFunction.vonMangoldt q * (q : ℝ) * Araw (x / q) := by
  rw [Z_mul_T_eq_Tnormalized hx]
  exact actual_residual_eq_volterra_sub_primePowers hx.le

#print axioms Tnum_eq_Tnormalized
#print axioms strictPrimeDilation_eq_primePowerSum
#print axioms actual_residual_eq_volterra_sub_primePowers
#print axioms actual_residual_eq_published_T

#print axioms DnumOn_eq_prime_dilation
#print axioms TnumOn_sub_DnumOn_half_eq_prime_dilation
#print axioms Tnum_sub_Dnum_half_eq_strictPrimeDilation
#print axioms actual_residual_eq_volterra_sub_strictPrimeDilation

namespace Convolution

variable {A : Type*} [CommRing A]

/-- In the intended model, ring multiplication is multiplicative convolution. -/
def unoriginatedRow (η K : A) : A := (η * η) * K

/-- The single centered cross row.  The minus sign is forced by
`Mellin(η) = -g`. -/
def singleRow (η K : A) : A := -(η * K)

/-- The origin atom applied to the kernel. -/
def originRow (K : A) : A := K

/-- The complete centered row uses `η - δ₁`, with `δ₁ = 1`. -/
def completeRow (η K : A) : A := ((η - 1) * (η - 1)) * K

theorem completeRow_eq_unoriginated_add_cross_add_origin (η K : A) :
    completeRow η K =
      unoriginatedRow η K + 2 * singleRow η K + originRow K := by
  unfold completeRow unoriginatedRow singleRow originRow
  ring

variable {B : Type*} [CommRing B]

/-- An abstract multiplicative Mellin symbol map. The premise `M η = -g`
is named; it is an analytic input in the actual prime-error application. -/
theorem symbol_unoriginatedRow (M : A →+* B) (η K : A) (g k : B)
    (hη : M η = -g) (hK : M K = k) :
    M (unoriginatedRow η K) = g ^ 2 * k := by
  simp [unoriginatedRow, hη, hK]
  ring

theorem symbol_singleRow (M : A →+* B) (η K : A) (g k : B)
    (hη : M η = -g) (hK : M K = k) :
    M (singleRow η K) = g * k := by
  simp [singleRow, hη, hK]

theorem symbol_originRow (M : A →+* B) (K : A) (k : B)
    (hK : M K = k) :
    M (originRow K) = k := by
  simpa [originRow] using hK

theorem symbol_completeRow (M : A →+* B) (η K : A) (g k : B)
    (hη : M η = -g) (hK : M K = k) :
    M (completeRow η K) = (g + 1) ^ 2 * k := by
  simp [completeRow, hη, hK]
  ring

#print axioms completeRow_eq_unoriginated_add_cross_add_origin
#print axioms symbol_unoriginatedRow
#print axioms symbol_completeRow


end Convolution


end
end BuildingBlocks.ActualEq22Residual
