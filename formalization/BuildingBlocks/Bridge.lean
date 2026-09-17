import BuildingBlocks.Model
import BuildingBlocks.Target
import Mathlib.NumberTheory.EulerProduct.DirichletLSeries
import Mathlib.NumberTheory.VonMangoldt

open Filter
open scoped Topology BigOperators

namespace BuildingBlocks

noncomputable def eulerState (n : ℕ) (s : ℂ) : ℂ :=
  ∏ p ∈ Nat.primesBelow n, (1 - (p : ℂ) ^ (-s))⁻¹

theorem eulerState_succ (n : ℕ) (s : ℂ) :
    eulerState (n + 1) s =
      if n.Prime then (1 - (n : ℂ) ^ (-s))⁻¹ * eulerState n s
      else eulerState n s := by
  classical
  unfold eulerState
  rw [Nat.primesBelow_succ]
  split_ifs with hp
  · exact Finset.prod_insert (Nat.notMem_primesBelow n)
  · rfl

/-- Every finite Euler state is nonzero throughout the positive half-plane.
This does not assert convergence of these states in the critical strip. -/
theorem eulerState_ne_zero (n : ℕ) {s : ℂ} (hs : 0 < s.re) :
    eulerState n s ≠ 0 := by
  apply Finset.prod_ne_zero_iff.mpr
  intro p hp
  apply inv_ne_zero
  apply sub_ne_zero.mpr
  have hprime := Nat.prime_of_mem_primesBelow hp
  have hnorm : ‖(p : ℂ) ^ (-s)‖ < 1 := by
    rw [← Complex.ofReal_natCast,
      Complex.norm_cpow_eq_rpow_re_of_pos (Nat.cast_pos.mpr hprime.pos), Complex.neg_re]
    exact Real.rpow_lt_one_of_one_lt_of_neg
      (Nat.one_lt_cast.mpr hprime.one_lt) (neg_neg_of_pos hs)
  intro heq
  rw [← heq, norm_one] at hnorm
  exact (lt_irrefl (1 : ℝ)) hnorm

/-- Established connection, confined to the domain of absolute convergence. -/
theorem eulerState_tendsto {s : ℂ} (hs : 1 < s.re) :
    Tendsto (fun n => eulerState n s) atTop (𝓝 (riemannZeta s)) :=
  riemannZeta_eulerProduct hs

/-- Prime-power weighted observable at an integer cutoff. -/
noncomputable def psi (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.range (N + 1), ArithmeticFunction.vonMangoldt n

theorem psi_succ (N : ℕ) :
    psi (N + 1) = psi N + ArithmeticFunction.vonMangoldt (N + 1) := by
  exact Finset.sum_range_succ _ (N + 1)

theorem impulse_at_prime_power {p k : ℕ} (hp : p.Prime) (hk : k ≠ 0) :
    ArithmeticFunction.vonMangoldt (p ^ k) = Real.log p := by
  rw [ArithmeticFunction.vonMangoldt_apply_pow hk,
    ArithmeticFunction.vonMangoldt_apply_prime hp]

theorem impulse_support (n : ℕ) :
    0 < ArithmeticFunction.vonMangoldt n ↔ IsPrimePow n :=
  ArithmeticFunction.vonMangoldt_pos_iff

theorem reconstruct_log (n : ℕ) :
    ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt d = Real.log n :=
  ArithmeticFunction.vonMangoldt_sum

theorem prime_power_series {s : ℂ} (hs : 1 < s.re) :
    LSeries (fun n => (ArithmeticFunction.vonMangoldt n : ℂ)) s =
      -deriv riemannZeta s / riemannZeta s :=
  ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs

/-- The decisive unresolved estimate. This is a proposition definition, not an
axiom, hypothesis of the elementary theorems, or claimed theorem. -/
def PrimeFluctuationBound : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∃ N₀ : ℕ,
    ∀ N : ℕ, N₀ ≤ N →
      |psi N - (N : ℝ)| ≤ C * (N : ℝ) ^ ((1 : ℝ) / 2 + ε)

/-- A separate formalization obligation for a known analytic implication.
The theorem `target_of_primeFluctuationBound` in `PrimeIntegral.lean` now proves
this implication. This definition itself makes no assertion of truth. -/
def AnalyticBridgeObligation : Prop := PrimeFluctuationBound → Target

end BuildingBlocks
