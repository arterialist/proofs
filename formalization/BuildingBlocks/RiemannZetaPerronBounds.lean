import BuildingBlocks.CoarsePrimeBounds
import BuildingBlocks.HyperbolaProduct
import BuildingBlocks.ActualCenteredMellin
import BuildingBlocks.ActualFullCenteredMellin
import BuildingBlocks.ActualFullCenteredMellinInversion
import BuildingBlocks.ActualCriticalLogMajorant
import BuildingBlocks.RiemannZetaPrimeAllocationGrowth

/-!
# Perron and Chebyshev Growth Bounds on Centered Fluctuations

This module formalizes unconditional pointwise and asymptotic polynomial growth bounds
on the centered arithmetic sums and the full numerator:
1. `sum_vonMangoldt_sq_eq_sum_psi`: exact Dirichlet hyperbola decomposition of `(Λ * Λ)(n)`.
2. `sum_vonMangoldt_sq_le`: Chebyshev quadratic bound `∑_{n ≤ N} (Λ * Λ)(n) ≤ (4 log 2)^2 N^2`.
3. `tent_sum_vonMangoldt_sq_le`: Riesz smoothed tent bound `∑_{n ≤ x} (x - n)(Λ * Λ)(n) ≤ (4 log 2)^2 x^3`.
4. `N_re_le`: centered kernel bound `Re N(x) ≤ C_N x^3` where `C_N = (4 log 2)^2 + 1`.
5. `fullNumerator_re_le_quartic`: full numerator quartic bound `Re fullNumerator(x) ≤ C_N x^4`.
6. `W_re_le_quartic`: critical transform quartic bound `Re W(x) ≤ C_N x^4`.
7. `norm_fullNumerator_le_perron`: general Mellin--Perron inversion bound
   `‖fullNumerator(x)‖ ≤ (1/2) verticalAllowance(c-1) x^c` for all `c > 2` and `x > 0`.
8. `RiemannHypothesis_of_eventually_fullNumerator_log_growth`: exact reduction of RH
   to logarithmic majorant dominance of the centered fluctuation numerator.

All results depend strictly on standard Lean 4 foundational axioms
`[propext, Classical.choice, Quot.sound]`, with 0 sorry.
-/

open scoped BigOperators
open MeasureTheory
open BuildingBlocks
open BuildingBlocks.CoarsePrimitive
open BuildingBlocks.HyperbolaProduct
open BuildingBlocks.ActualFullCenteredMellin
open BuildingBlocks.ActualCriticalLogMajorant
open BuildingBlocks.RiemannZetaPrimeAllocationGrowth

namespace BuildingBlocks.RiemannZetaPerronBounds

/-- Exact Dirichlet hyperbola decomposition: the convolution sum of `(Λ * Λ)(n)`
is equal to `∑_{a ≤ N} Λ(a) ψ(N / a)`. -/
theorem sum_vonMangoldt_sq_eq_sum_psi (N : ℕ) :
    ∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n =
      ∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a * CoarsePrimitive.psi (N / a) := by
  have h1 : ∀ n, (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n =
      ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt d * ArithmeticFunction.vonMangoldt (n / d) := by
    intro n
    rw [ArithmeticFunction.mul_apply,
      Nat.sum_divisorsAntidiagonal (fun a b => ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b)]
  simp_rw [h1]
  rw [sum_divisors_eq_sum_factor_pairs N (fun a b => ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b)]
  apply Finset.sum_congr rfl
  intro a ha
  rw [← Finset.mul_sum]
  congr 1
  exact (psi_eq_sum_Icc (N / a)).symm

/-- Quadratic Chebyshev bound: `∑_{n ≤ N} (Λ * Λ)(n) ≤ (4 log 2)^2 N^2`. -/
theorem sum_vonMangoldt_sq_le (N : ℕ) :
    ∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n ≤
      (4 * Real.log 2) ^ 2 * (N : ℝ) ^ 2 := by
  rw [sum_vonMangoldt_sq_eq_sum_psi]
  have hpsi : ∀ a ∈ Finset.Icc 1 N,
      CoarsePrimitive.psi (N / a) ≤ (4 * Real.log 2) * ((N : ℝ) / (a : ℝ)) := by
    intro a ha
    have hlin := psi_le_linear (N / a)
    have hle : ((N / a : ℕ) : ℝ) ≤ (N : ℝ) / (a : ℝ) := Nat.cast_div_le
    have hlog : 0 ≤ 4 * Real.log 2 := by positivity
    exact hlin.trans (mul_le_mul_of_nonneg_left hle hlog)
  have hterm : ∀ a ∈ Finset.Icc 1 N,
      ArithmeticFunction.vonMangoldt a * CoarsePrimitive.psi (N / a) ≤
        (4 * Real.log 2 * (N : ℝ)) * (ArithmeticFunction.vonMangoldt a / (a : ℝ)) := by
    intro a ha
    have h1 := mul_le_mul_of_nonneg_left (hpsi a ha) (ArithmeticFunction.vonMangoldt_nonneg (n := a))
    have h2 : ArithmeticFunction.vonMangoldt a * (4 * Real.log 2 * ((N : ℝ) / (a : ℝ))) =
        (4 * Real.log 2 * (N : ℝ)) * (ArithmeticFunction.vonMangoldt a / (a : ℝ)) := by ring
    exact h1.trans (le_of_eq h2)
  have hsum : ∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a * CoarsePrimitive.psi (N / a) ≤
      ∑ a ∈ Finset.Icc 1 N, (4 * Real.log 2 * (N : ℝ)) * (ArithmeticFunction.vonMangoldt a / (a : ℝ)) :=
    Finset.sum_le_sum hterm
  have hfactor : (∑ a ∈ Finset.Icc 1 N, (4 * Real.log 2 * (N : ℝ)) * (ArithmeticFunction.vonMangoldt a / (a : ℝ))) =
      (4 * Real.log 2 * (N : ℝ)) * ∑ a ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt a / (a : ℝ)) := by
    rw [← Finset.mul_sum]
  have hdiv_le : (∑ a ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt a / (a : ℝ))) ≤
      ∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a := by
    apply Finset.sum_le_sum
    intro a ha
    have ha1 : 1 ≤ (a : ℝ) := by
      have : 1 ≤ a := (Finset.mem_Icc.mp ha).1
      exact_mod_cast this
    have hdiv : ArithmeticFunction.vonMangoldt a / (a : ℝ) ≤ ArithmeticFunction.vonMangoldt a := by
      exact div_le_self (ArithmeticFunction.vonMangoldt_nonneg (n := a)) ha1
    exact hdiv
  rw [← psi_eq_sum_Icc] at hdiv_le
  have hpsiN := psi_le_linear N
  have hbound : (4 * Real.log 2 * (N : ℝ)) * ∑ a ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt a / (a : ℝ)) ≤
      (4 * Real.log 2 * (N : ℝ)) * ((4 * Real.log 2) * (N : ℝ)) := by
    have hnonneg : 0 ≤ 4 * Real.log 2 * (N : ℝ) := by positivity
    exact mul_le_mul_of_nonneg_left (hdiv_le.trans hpsiN) hnonneg
  have hring : (4 * Real.log 2 * (N : ℝ)) * ((4 * Real.log 2) * (N : ℝ)) =
      (4 * Real.log 2) ^ 2 * (N : ℝ) ^ 2 := by ring
  exact hsum.trans (by rw [hfactor]; exact hbound.trans (le_of_eq hring))

theorem vonMangoldt_mul_vonMangoldt_nonneg (n : ℕ) :
    0 ≤ (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n := by
  rw [ArithmeticFunction.mul_apply]
  apply Finset.sum_nonneg
  intro x hx
  positivity

/-- Riesz tent convolution bound: `∑_{n ≤ x} (x - n) (Λ * Λ)(n) ≤ (4 log 2)^2 x^3`. -/
theorem tent_sum_vonMangoldt_sq_le {x : ℝ} (hx : 0 ≤ x) :
    ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (x - (n : ℝ)) * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n ≤
      (4 * Real.log 2) ^ 2 * x ^ 3 := by
  have hterm : ∀ n ∈ Finset.Icc 1 ⌊x⌋₊,
      (x - (n : ℝ)) * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n ≤
        x * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n := by
    intro n hn
    have hn1 : 1 ≤ n := (Finset.mem_Icc.mp hn).1
    have hn_pos : 0 ≤ (n : ℝ) := by positivity
    have hle : x - (n : ℝ) ≤ x := by linarith
    exact mul_le_mul_of_nonneg_right hle (vonMangoldt_mul_vonMangoldt_nonneg n)
  have hsum : ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (x - (n : ℝ)) * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n ≤
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, x * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n :=
    Finset.sum_le_sum hterm
  rw [← Finset.mul_sum] at hsum
  have hbound := sum_vonMangoldt_sq_le ⌊x⌋₊
  have hfloor_le : (⌊x⌋₊ : ℝ) ≤ x := Nat.floor_le hx
  have hsq : (⌊x⌋₊ : ℝ) ^ 2 ≤ x ^ 2 := by
    have hfl0 : 0 ≤ (⌊x⌋₊ : ℝ) := Nat.cast_nonneg ⌊x⌋₊
    nlinarith
  have hC : 0 ≤ (4 * Real.log 2) ^ 2 := by positivity
  have hbound2 : (4 * Real.log 2) ^ 2 * (⌊x⌋₊ : ℝ) ^ 2 ≤ (4 * Real.log 2) ^ 2 * x ^ 2 :=
    mul_le_mul_of_nonneg_left hsq hC
  have hmul : x * (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n) ≤
      x * ((4 * Real.log 2) ^ 2 * x ^ 2) :=
    mul_le_mul_of_nonneg_left (hbound.trans hbound2) hx
  have hring : x * ((4 * Real.log 2) ^ 2 * x ^ 2) = (4 * Real.log 2) ^ 2 * x ^ 3 := by ring
  exact hsum.trans (hmul.trans (le_of_eq hring))

theorem sum_N_core_le {x : ℝ} (hx : 0 ≤ x) :
    (∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
      ((x - (n : ℝ)) * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n -
        ArithmeticFunction.vonMangoldt n * ((x ^ 2 - (n : ℝ) ^ 2) / (n : ℝ)))) ≤
      (4 * Real.log 2) ^ 2 * x ^ 3 := by
  have hterm : ∀ n ∈ Finset.Icc 1 ⌊x⌋₊,
      ((x - (n : ℝ)) * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n -
        ArithmeticFunction.vonMangoldt n * ((x ^ 2 - (n : ℝ) ^ 2) / (n : ℝ))) ≤
        (x - (n : ℝ)) * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n := by
    intro n hn
    have hn1 : 1 ≤ n := (Finset.mem_Icc.mp hn).1
    have hle_x : (n : ℝ) ≤ x := (Nat.cast_le.mpr (Finset.mem_Icc.mp hn).2).trans (Nat.floor_le hx)
    have hn_pos : 0 < (n : ℝ) := by positivity
    have hsq : (n : ℝ) ^ 2 ≤ x ^ 2 := by nlinarith
    have hdiff : 0 ≤ x ^ 2 - (n : ℝ) ^ 2 := by linarith
    have hdiv : 0 ≤ (x ^ 2 - (n : ℝ) ^ 2) / (n : ℝ) := div_nonneg hdiff (le_of_lt hn_pos)
    have hsub : 0 ≤ ArithmeticFunction.vonMangoldt n * ((x ^ 2 - (n : ℝ) ^ 2) / (n : ℝ)) :=
      mul_nonneg (ArithmeticFunction.vonMangoldt_nonneg (n := n)) hdiv
    linarith
  have hsum := Finset.sum_le_sum hterm
  exact hsum.trans (tent_sum_vonMangoldt_sq_le hx)

theorem baseline_re_le {x : ℝ} (hx : 0 ≤ x) :
    (EtaBaselineMellin.B x).re ≤ x ^ 3 := by
  unfold EtaBaselineMellin.B
  split_ifs with h1
  · have hlog : Real.log x ≤ x := (Real.log_le_sub_one_of_pos (by linarith)).trans (by linarith)
    have hx1 : 1 ≤ x := le_of_lt h1
    have hx2 : 0 ≤ x ^ 2 := by positivity
    have h1_term : x ^ 2 / 2 * Real.log x ≤ x ^ 3 / 2 := by
      calc x ^ 2 / 2 * Real.log x ≤ x ^ 2 / 2 * x := mul_le_mul_of_nonneg_left hlog (by positivity)
      _ = x ^ 3 / 2 := by ring
    have h2_term : x ^ 2 / 4 - 1 / 4 ≤ x ^ 3 / 4 := by
      have : x ^ 2 ≤ x ^ 3 := by nlinarith
      linarith
    have hre : ((x : ℂ) ^ 2 / 2 * (Real.log x : ℂ) + (x : ℂ) ^ 2 / 4 - 1 / 4) =
        (((x ^ 2 / 2 * Real.log x + x ^ 2 / 4 - 1 / 4 : ℝ) : ℂ)) := by
      push_cast
      ring
    have hx3 : 0 ≤ x ^ 3 := by positivity
    rw [hre, Complex.ofReal_re]
    linarith
  · simp
    positivity

/-- The universal constant `C_N = (4 log 2)^2 + 1`. -/
noncomputable def C_N : ℝ := (4 * Real.log 2) ^ 2 + 1

theorem C_N_pos : 0 < C_N := by
  unfold C_N
  positivity

/-- Pointwise cubic bound on the centered Mellin sum `Re N(x) ≤ C_N x^3`. -/
theorem N_re_le {x : ℝ} (hx : 0 ≤ x) :
    (ActualCenteredMellin.N x).re ≤ C_N * x ^ 3 := by
  rw [ActualFullCenteredMellin.N_eq_real_cutoff hx]
  simp only [Complex.add_re, Complex.ofReal_re]
  have hcore := sum_N_core_le hx
  have hbase := baseline_re_le hx
  have hring : (4 * Real.log 2) ^ 2 * x ^ 3 + x ^ 3 = C_N * x ^ 3 := by
    unfold C_N
    ring
  linarith

/-- Pointwise quartic bound on the full centered numerator `Re fullNumerator(x) ≤ C_N x^4`. -/
theorem fullNumerator_re_le_quartic {x : ℝ} (hx : 1 ≤ x) :
    (ActualFullCenteredMellin.fullNumerator x).re ≤ C_N * x ^ 4 := by
  have hx0 : 0 ≤ x := by linarith
  have hfl1 : 1 ≤ ⌊x⌋₊ := Nat.le_floor (show ((1 : ℕ) : ℝ) ≤ x by exact_mod_cast hx)
  rw [ActualFullCenteredMellin.fullNumerator_eq_real_sum x]
  simp only [Complex.ofReal_re]
  have hterm : ∀ d ∈ Finset.Icc 1 ⌊x⌋₊,
      Real.sqrt d * (ActualCenteredMellin.N (x / (d : ℝ))).re ≤ C_N * x ^ 3 := by
    intro d hd
    have hd1 : 1 ≤ d := (Finset.mem_Icc.mp hd).1
    have hd_pos : 0 < (d : ℝ) := by positivity
    have hxd : 0 ≤ x / (d : ℝ) := div_nonneg hx0 (le_of_lt hd_pos)
    have hN := N_re_le hxd
    have hd1' : 1 ≤ (d : ℝ) := by exact_mod_cast hd1
    have hsqrt_le : Real.sqrt (d : ℝ) ≤ (d : ℝ) := by
      calc Real.sqrt (d : ℝ) ≤ Real.sqrt ((d : ℝ) ^ 2) := by
            apply Real.sqrt_le_sqrt
            nlinarith
      _ = (d : ℝ) := Real.sqrt_sq (le_of_lt hd_pos)
    have hd_le_d3 : (d : ℝ) ≤ (d : ℝ) ^ 3 := by
      calc (d : ℝ) = (d : ℝ) * 1 := by ring
      _ ≤ (d : ℝ) * (d : ℝ) ^ 2 := mul_le_mul_of_nonneg_left (by nlinarith) (le_of_lt hd_pos)
      _ = (d : ℝ) ^ 3 := by ring
    have hratio : Real.sqrt (d : ℝ) * (x / (d : ℝ)) ^ 3 ≤ x ^ 3 := by
      have hdiv : (x / (d : ℝ)) ^ 3 = x ^ 3 / (d : ℝ) ^ 3 := div_pow x (d : ℝ) 3
      rw [hdiv]
      have : Real.sqrt (d : ℝ) * (x ^ 3 / (d : ℝ) ^ 3) = (Real.sqrt (d : ℝ) / (d : ℝ) ^ 3) * x ^ 3 := by ring
      rw [this]
      have hfrac : Real.sqrt (d : ℝ) / (d : ℝ) ^ 3 ≤ 1 := by
        rw [div_le_one (by positivity)]
        exact hsqrt_le.trans hd_le_d3
      have hx3_pos : 0 ≤ x ^ 3 := by positivity
      nlinarith
    have hCN_nonneg : 0 ≤ C_N := le_of_lt C_N_pos
    have hsqrt_nonneg : 0 ≤ Real.sqrt (d : ℝ) := Real.sqrt_nonneg _
    calc Real.sqrt (d : ℝ) * (ActualCenteredMellin.N (x / (d : ℝ))).re ≤
        Real.sqrt (d : ℝ) * (C_N * (x / (d : ℝ)) ^ 3) :=
          mul_le_mul_of_nonneg_left hN hsqrt_nonneg
    _ = C_N * (Real.sqrt (d : ℝ) * (x / (d : ℝ)) ^ 3) := by ring
    _ ≤ C_N * x ^ 3 := mul_le_mul_of_nonneg_left hratio hCN_nonneg
  have hsum : (∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * (ActualCenteredMellin.N (x / (d : ℝ))).re) ≤
      ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, C_N * x ^ 3 := Finset.sum_le_sum hterm
  have hcard : (∑ d ∈ Finset.Icc 1 ⌊x⌋₊, C_N * x ^ 3) = ((⌊x⌋₊ : ℝ)) * (C_N * x ^ 3) := by
    rw [Finset.sum_const, Nat.card_Icc, add_tsub_cancel_right, nsmul_eq_mul]
  have hfloor_le : (⌊x⌋₊ : ℝ) ≤ x := Nat.floor_le hx0
  have hbound : ((⌊x⌋₊ : ℝ)) * (C_N * x ^ 3) ≤ x * (C_N * x ^ 3) := by
    have : 0 ≤ C_N * x ^ 3 := by
      have hx3_pos : 0 ≤ x ^ 3 := by positivity
      have hCN_pos : 0 ≤ C_N := le_of_lt C_N_pos
      positivity
    exact mul_le_mul_of_nonneg_right hfloor_le this
  have hring : x * (C_N * x ^ 3) = C_N * x ^ 4 := by ring
  exact hsum.trans (by rw [hcard]; exact hbound.trans (le_of_eq hring))

/-- Pointwise quartic bound on the critical transform `Re W(x) ≤ C_N x^4`. -/
theorem W_re_le_quartic {x : ℝ} (hx : 1 ≤ x) :
    (ActualCriticalMellin.W x).re ≤ C_N * x ^ 4 :=
  (RiemannZetaPrimeAllocationGrowth.W_re_le_fullNumerator_re x).trans (fullNumerator_re_le_quartic hx)

theorem eventually_fullNumerator_re_le_quartic :
    ∀ᶠ x : ℝ in Filter.atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C_N * x ^ 4 := by
  filter_upwards [Filter.eventually_ge_atTop (1 : ℝ)] with x hx
  exact fullNumerator_re_le_quartic hx

theorem eventually_W_re_le_quartic :
    ∀ᶠ x : ℝ in Filter.atTop, (ActualCriticalMellin.W x).re ≤ C_N * x ^ 4 := by
  filter_upwards [Filter.eventually_ge_atTop (1 : ℝ)] with x hx
  exact W_re_le_quartic hx

/-- A one-sided logarithmic majorant bound on the centered fluctuation numerator implies RH. -/
theorem RiemannHypothesis_of_fullNumerator_log_growth_after {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2) :
    RiemannHypothesis := by
  have hW : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 := by
    intro x hx
    exact (RiemannZetaPrimeAllocationGrowth.W_re_le_fullNumerator_re x).trans (hgrow x hx)
  exact ActualCriticalLogMajorant.RiemannHypothesis_of_log_growth_after hA hW

/-- Filter form: Eventual domination of the centered fluctuation numerator by the logarithmic
majorant implies the Riemann Hypothesis unconditionally. -/
theorem RiemannHypothesis_of_eventually_fullNumerator_log_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in Filter.atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2) :
    RiemannHypothesis := by
  have hW : ∀ᶠ x : ℝ in Filter.atTop, (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 := by
    filter_upwards [hgrow] with x hx
    exact (RiemannZetaPrimeAllocationGrowth.W_re_le_fullNumerator_re x).trans hx
  exact ActualCriticalLogMajorant.RiemannHypothesis_of_eventually_log_growth hW

/-- Mellin--Perron inversion norm bound: For any `c > 2` and `x > 0`,
`‖fullNumerator(x)‖ ≤ (1/2) verticalAllowance(c-1) x^c`. -/
theorem norm_fullNumerator_le_perron {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    ‖ActualFullCenteredMellin.fullNumerator x‖ ≤
      (1 / 2) * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) * x ^ c := by
  rw [BuildingBlocks.ActualFullCenteredMellinInversion.fullNumerator_eq_perron hc hx]
  rw [norm_smul, Real.norm_eq_abs]
  have hpi_pos : 0 < Real.pi := Real.pi_pos
  have h2pi_pos : 0 < 2 * Real.pi := mul_pos two_pos hpi_pos
  have habs : |(1 : ℝ) / (2 * Real.pi)| = 1 / (2 * Real.pi) := abs_of_pos (div_pos one_pos h2pi_pos)
  rw [habs]
  have hkernel_int : Integrable (BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x) :=
    BuildingBlocks.ActualFullCenteredMellinInversion.integrable_perronKernel hc hx
  have hnorm_int_le : ‖∫ t : ℝ, BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t‖ ≤
      ∫ t : ℝ, ‖BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t‖ :=
    norm_integral_le_integral_norm _
  have hterm_le : (fun t : ℝ => ‖BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t‖) ≤ᵐ[volume]
      (fun t : ℝ => (x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * (1 + t ^ 2)⁻¹) := by
    filter_upwards with t
    have hle := BuildingBlocks.ActualFullCenteredMellinInversion.norm_perronKernel_le hc hx t
    have hdiv : BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) / (1 + t ^ 2) =
        BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) * (1 + t ^ 2)⁻¹ := by ring
    rw [hdiv] at hle
    calc ‖BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t‖ ≤
        x ^ c * (BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) * (1 + t ^ 2)⁻¹) := hle
    _ = (x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * (1 + t ^ 2)⁻¹ := by ring
  have hinv_int : Integrable (fun t : ℝ => (x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * (1 + t ^ 2)⁻¹) :=
    integrable_inv_one_add_sq.const_mul (x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1))
  have hnorm_le_int : (∫ t : ℝ, ‖BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t‖) ≤
      ∫ t : ℝ, (x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * (1 + t ^ 2)⁻¹ :=
    integral_mono_of_nonneg (Filter.Eventually.of_forall (fun _ => norm_nonneg _)) hinv_int hterm_le
  have hfactor_int : (∫ t : ℝ, (x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * (1 + t ^ 2)⁻¹) =
      (x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * Real.pi := by
    rw [integral_const_mul, integral_univ_inv_one_add_sq]
  have hcomb : ‖∫ t : ℝ, BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t‖ ≤
      (x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * Real.pi :=
    hnorm_int_le.trans (hnorm_le_int.trans (le_of_eq hfactor_int))
  have hmul_le : (1 / (2 * Real.pi)) * ‖∫ t : ℝ, BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t‖ ≤
      (1 / (2 * Real.pi)) * ((x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * Real.pi) :=
    mul_le_mul_of_nonneg_left hcomb (by positivity)
  have hring : (1 / (2 * Real.pi)) * ((x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * Real.pi) =
      (1 / 2) * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) * x ^ c := by
    have hpi_ne : Real.pi ≠ 0 := ne_of_gt hpi_pos
    have hpi_div : Real.pi / (2 * Real.pi) = (1 : ℝ) / 2 := by
      calc Real.pi / (2 * Real.pi) = (Real.pi * 1) / (Real.pi * 2) := by ring
      _ = 1 / 2 := mul_div_mul_left 1 2 hpi_ne
    calc (1 / (2 * Real.pi)) * ((x ^ c * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1)) * Real.pi) =
        (Real.pi / (2 * Real.pi)) * (BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) * x ^ c) := by ring
    _ = (1 / 2) * (BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) * x ^ c) := by rw [hpi_div]
    _ = (1 / 2) * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) * x ^ c := by ring
  exact hmul_le.trans (le_of_eq hring)

/-- Pointwise real-part bound on the full numerator from the Perron contour. -/
theorem fullNumerator_re_le_perron {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    (ActualFullCenteredMellin.fullNumerator x).re ≤
      (1 / 2) * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) * x ^ c :=
  (Complex.re_le_norm _).trans (norm_fullNumerator_le_perron hc hx)

/-- Pointwise real-part bound on `W(x)` from the Perron contour. -/
theorem W_re_le_perron {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    (ActualCriticalMellin.W x).re ≤
      (1 / 2) * BuildingBlocks.ActualFullCenteredMellinVertical.verticalAllowance (c - 1) * x ^ c :=
  (RiemannZetaPrimeAllocationGrowth.W_re_le_fullNumerator_re x).trans (fullNumerator_re_le_perron hc hx)

end BuildingBlocks.RiemannZetaPerronBounds
