import Mathlib.NumberTheory.LSeries.Dirichlet
import Mathlib.NumberTheory.LSeries.Deriv
import Mathlib.Data.Nat.Factorization.PrimePow
import BuildingBlocks.RiemannZetaCenteredLogDeriv
import BuildingBlocks.SamePrimeDirichlet

/-!
# The series `∑ Λ(n) log n / n^w` and its double pole at `w = 1`

For real `w > 1` let `T(w) = ∑_n Λ(n) log n / n^w`. Then

* `T(w) = Re (ζ'/ζ)'(w)`, from Mathlib's `LSeries ↗Λ = -ζ'/ζ` and termwise differentiation;
* `(w-1)^2 T(w) → 1` as `w → 1⁺`, because `ζ'/ζ = U'/U - 1/(s-1)` near `1` with
  `U(s) = (s-1)ζ(s)` analytic and nonvanishing at `1` (`RiemannZetaCenteredLogDeriv`);
* `T(w) = ∑_p (log p)^2 / p^w + E(w)` with `0 ≤ E(w) ≤ 8 ∑_p (log p)^2 / p^2` for `w > 1`,
  by reindexing the prime powers through `Nat.Primes.prodNatEquiv`.

These give the double pole `(2σ-1)^2 ∑_p (log p)^2 p^{-2σ} → 1` used for the sharp constant of the
actual critical sum.
-/

open LSeries ArithmeticFunction Filter Topology
open scoped LSeries.notation

namespace BuildingBlocks.PrimePowerLogSeries

open RiemannZetaCenteredLogDeriv SamePrimeDirichlet

/-- The coefficients `Λ(n) log n`. -/
noncomputable def a (n : ℕ) : ℝ := Λ n * Real.log n

theorem a_nonneg (n : ℕ) : 0 ≤ a n :=
  mul_nonneg vonMangoldt_nonneg (Real.log_natCast_nonneg n)

/-- The real Dirichlet series `∑ Λ(n) log n / n^w`. -/
noncomputable def T (w : ℝ) : ℝ := ∑' n : ℕ, a n / (n : ℝ) ^ w

/-! ### The series as an L-series -/

theorem term_logMul_eq (w : ℝ) (n : ℕ) :
    term (logMul ↗Λ) (w : ℂ) n = ((a n / (n : ℝ) ^ w : ℝ) : ℂ) := by
  unfold term logMul a
  split_ifs with h
  · subst h
    simp
  · have hn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
    have hc : ((n : ℕ) : ℂ) = (((n : ℝ)) : ℂ) := by norm_cast
    dsimp only
    rw [hc, Complex.ofReal_div, Complex.ofReal_mul, Complex.ofReal_cpow hn, ← Complex.ofReal_log hn]
    ring

theorem abscissa_vonMangoldt_lt {w : ℝ} (hw : 1 < w) :
    abscissaOfAbsConv ↗Λ < ((w : ℂ)).re := by
  have h1 : abscissaOfAbsConv ↗Λ ≤ ((1 : ℝ) : EReal) :=
    abscissaOfAbsConv_le_of_forall_lt_LSeriesSummable
      (fun y hy => LSeriesSummable_vonMangoldt (by simpa using hy))
  have h2 : ((1 : ℝ) : EReal) < (((w : ℂ)).re : EReal) := by
    rw [Complex.ofReal_re]
    exact EReal.coe_lt_coe_iff.mpr hw
  exact lt_of_le_of_lt h1 h2

theorem summable_a_div {w : ℝ} (hw : 1 < w) : Summable (fun n : ℕ => a n / (n : ℝ) ^ w) := by
  have h : LSeriesSummable (logMul ↗Λ) (w : ℂ) :=
    LSeriesSummable_logMul_of_lt_re (abscissa_vonMangoldt_lt hw)
  have h' : Summable (fun n : ℕ => ((a n / (n : ℝ) ^ w : ℝ) : ℂ)) := by
    refine h.congr (fun n => ?_)
    exact term_logMul_eq w n
  exact Complex.summable_ofReal.mp h'

theorem T_eq_LSeries {w : ℝ} (hw : 1 < w) :
    ((T w : ℝ) : ℂ) = LSeries (logMul ↗Λ) (w : ℂ) := by
  unfold T LSeries
  rw [Complex.ofReal_tsum]
  exact tsum_congr (fun n => (term_logMul_eq w n).symm)

/-- `∑ Λ(n) log n / n^w = (ζ'/ζ)'(w)` for real `w > 1`. -/
theorem LSeries_logMul_eq_deriv {w : ℝ} (hw : 1 < w) :
    LSeries (logMul ↗Λ) (w : ℂ) =
      deriv (fun s : ℂ => deriv riemannZeta s / riemannZeta s) (w : ℂ) := by
  have habs := abscissa_vonMangoldt_lt hw
  have h1 : deriv (LSeries ↗Λ) (w : ℂ) = -LSeries (logMul ↗Λ) (w : ℂ) := LSeries_deriv habs
  have h2 : LSeries ↗Λ =ᶠ[𝓝 (w : ℂ)] fun s => -deriv riemannZeta s / riemannZeta s := by
    have hopen : IsOpen {s : ℂ | 1 < s.re} := isOpen_lt continuous_const Complex.continuous_re
    filter_upwards [hopen.mem_nhds (by simpa using hw)] with s hs
    exact LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs
  have h3 : deriv (LSeries ↗Λ) (w : ℂ) =
      deriv (fun s : ℂ => -deriv riemannZeta s / riemannZeta s) (w : ℂ) := h2.deriv_eq
  have h4 : deriv (fun s : ℂ => -deriv riemannZeta s / riemannZeta s) (w : ℂ) =
      -deriv (fun s : ℂ => deriv riemannZeta s / riemannZeta s) (w : ℂ) := by
    have hf : (fun s : ℂ => -deriv riemannZeta s / riemannZeta s) =
        fun s => -(deriv riemannZeta s / riemannZeta s) := by
      funext s
      ring
    rw [hf, show (fun s : ℂ => -(deriv riemannZeta s / riemannZeta s)) =
      -(fun s : ℂ => deriv riemannZeta s / riemannZeta s) from rfl, deriv.neg]
  rw [h3, h4] at h1
  linear_combination h1

/-! ### The double pole at `1` -/

/-- `ζ'/ζ = U'/U - 1/(s-1)` away from `1` where `U ≠ 0`. -/
theorem logDeriv_zeta_eq {s : ℂ} (hs : s ≠ 1) (hu : U s ≠ 0) :
    deriv riemannZeta s / riemannZeta s = deriv U s / U s - 1 / (s - 1) := by
  have h := G_eq_Gext_of_ne hs hu
  unfold G Gext at h
  have hs1 : (s - 1 : ℂ) ≠ 0 := sub_ne_zero.mpr hs
  have e : deriv riemannZeta s / riemannZeta s = deriv U s / U s + 1 - s / (s - 1) := by
    linear_combination -h
  rw [e]
  field_simp
  ring

theorem hasDerivAt_one_div_sub {s : ℂ} (hs : s ≠ 1) :
    HasDerivAt (fun z : ℂ => 1 / (z - 1)) (-(1 / (s - 1) ^ 2)) s := by
  have hs1 : (s - 1 : ℂ) ≠ 0 := sub_ne_zero.mpr hs
  have h := (hasDerivAt_inv hs1).comp s ((hasDerivAt_id s).sub_const 1)
  refine (h.congr_deriv ?_).congr_of_eventuallyEq ?_
  · field_simp
  · exact Filter.Eventually.of_forall (fun z => by simp [one_div])

/-- Near `1`, `(ζ'/ζ)' = (U'/U)' + 1/(s-1)^2`. -/
theorem deriv_logDeriv_zeta_eq {s : ℂ} (hs : s ≠ 1) (hU : ∀ᶠ z in 𝓝 s, U z ≠ 0) :
    deriv (fun z : ℂ => deriv riemannZeta z / riemannZeta z) s =
      deriv (fun z : ℂ => deriv U z / U z) s + 1 / (s - 1) ^ 2 := by
  have heq : (fun z : ℂ => deriv riemannZeta z / riemannZeta z) =ᶠ[𝓝 s]
      fun z => deriv U z / U z - 1 / (z - 1) := by
    filter_upwards [hU, isOpen_ne.mem_nhds hs] with z hz hz1
    exact logDeriv_zeta_eq hz1 hz
  rw [heq.deriv_eq]
  have hV : DifferentiableAt ℂ (fun z : ℂ => deriv U z / U z) s :=
    ((analyticAt_U s).deriv.differentiableAt).div (analyticAt_U s).differentiableAt hU.self_of_nhds
  have hinv := hasDerivAt_one_div_sub hs
  rw [(hV.hasDerivAt.fun_sub hinv).deriv]
  ring

theorem continuousAt_deriv_V :
    ContinuousAt (deriv (fun z : ℂ => deriv U z / U z)) 1 := by
  have hV : AnalyticAt ℂ (fun z : ℂ => deriv U z / U z) 1 :=
    (analyticAt_U 1).deriv.div (analyticAt_U 1) (by simp)
  exact hV.deriv.continuousAt

/-- The double pole: `(w-1)^2 (ζ'/ζ)'(w) → 1` as `w → 1⁺` along the reals. -/
theorem tendsto_sq_mul_deriv_logDeriv :
    Tendsto (fun w : ℝ => (((w : ℂ) - 1) ^ 2) *
      deriv (fun z : ℂ => deriv riemannZeta z / riemannZeta z) (w : ℂ))
      (𝓝[>] (1 : ℝ)) (𝓝 1) := by
  obtain ⟨O, hO, hOopen, h1O⟩ := eventually_nhds_iff.mp eventually_U_ne_zero
  have hcast : Tendsto (fun w : ℝ => (w : ℂ)) (𝓝[>] (1 : ℝ)) (𝓝 ((1 : ℝ) : ℂ)) :=
    Complex.continuous_ofReal.continuousAt.tendsto.mono_left nhdsWithin_le_nhds
  have hcast' : Tendsto (fun w : ℝ => (w : ℂ)) (𝓝[>] (1 : ℝ)) (𝓝 (1 : ℂ)) := by
    simpa using hcast
  have hevO : ∀ᶠ w : ℝ in 𝓝[>] (1 : ℝ), (w : ℂ) ∈ O := hcast' (hOopen.mem_nhds h1O)
  have hev1 : ∀ᶠ w : ℝ in 𝓝[>] (1 : ℝ), (w : ℂ) ≠ 1 := by
    filter_upwards [self_mem_nhdsWithin] with w hw
    intro h
    have := congrArg Complex.re h
    simp at this
    have hw' : (1 : ℝ) < w := hw
    linarith
  have hlim : Tendsto (fun w : ℝ => (((w : ℂ) - 1) ^ 2) *
      deriv (fun z : ℂ => deriv U z / U z) (w : ℂ) + 1) (𝓝[>] (1 : ℝ)) (𝓝 1) := by
    have h1 : Tendsto (fun w : ℝ => ((w : ℂ) - 1) ^ 2) (𝓝[>] (1 : ℝ)) (𝓝 0) := by
      have : Tendsto (fun w : ℝ => ((w : ℂ) - 1) ^ 2) (𝓝[>] (1 : ℝ)) (𝓝 (((1 : ℂ) - 1) ^ 2)) :=
        (hcast'.sub_const 1).pow 2
      simpa using this
    have h2 : Tendsto (fun w : ℝ => deriv (fun z : ℂ => deriv U z / U z) (w : ℂ)) (𝓝[>] (1 : ℝ))
        (𝓝 (deriv (fun z : ℂ => deriv U z / U z) 1)) :=
      continuousAt_deriv_V.tendsto.comp hcast'
    have := (h1.mul h2).add_const (1 : ℂ)
    simpa using this
  refine hlim.congr' ?_
  filter_upwards [hevO, hev1] with w hwO hw1
  have hU : ∀ᶠ z in 𝓝 (w : ℂ), U z ≠ 0 := by
    filter_upwards [hOopen.mem_nhds hwO] with z hz
    exact hO z hz
  rw [deriv_logDeriv_zeta_eq hw1 hU]
  have hne : ((w : ℂ) - 1) ≠ 0 := sub_ne_zero.mpr hw1
  field_simp

/-- `(w-1)^2 T(w) → 1` as `w → 1⁺`. -/
theorem tendsto_sq_mul_T : Tendsto (fun w : ℝ => (w - 1) ^ 2 * T w) (𝓝[>] (1 : ℝ)) (𝓝 1) := by
  have h := (Complex.continuous_re.tendsto _).comp tendsto_sq_mul_deriv_logDeriv
  have h1 : (1 : ℂ).re = 1 := by simp
  rw [h1] at h
  refine h.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with w hw
  have hw' : (1 : ℝ) < w := hw
  show ((((w : ℂ) - 1) ^ 2) * deriv (fun z : ℂ => deriv riemannZeta z / riemannZeta z) (w : ℂ)).re =
    (w - 1) ^ 2 * T w
  rw [← LSeries_logMul_eq_deriv hw', ← T_eq_LSeries hw',
    show (((w : ℂ) - 1) ^ 2) = ((((w - 1) ^ 2 : ℝ)) : ℂ) by push_cast; ring,
    ← Complex.ofReal_mul, Complex.ofReal_re]

/-! ### Reindexing by prime powers -/

/-- The prime-power term `(k+1) (log p)^2 / p^{(k+1) w}`. -/
noncomputable def g (w : ℝ) (q : Nat.Primes × ℕ) : ℝ :=
  ((q.2 : ℝ) + 1) * (Real.log (q.1 : ℕ)) ^ 2 / ((q.1 : ℕ) : ℝ) ^ (((q.2 : ℝ) + 1) * w)

theorem a_primePow (p : Nat.Primes) (k : ℕ) :
    a ((p : ℕ) ^ (k + 1)) = ((k : ℝ) + 1) * (Real.log (p : ℕ)) ^ 2 := by
  unfold a
  rw [vonMangoldt_apply_pow (Nat.succ_ne_zero k), vonMangoldt_apply_prime p.prop, Nat.cast_pow,
    Real.log_pow]
  push_cast
  ring

theorem rpow_primePow (p : Nat.Primes) (k : ℕ) (w : ℝ) :
    ((((p : ℕ) ^ (k + 1) : ℕ)) : ℝ) ^ w = ((p : ℕ) : ℝ) ^ (((k : ℝ) + 1) * w) := by
  rw [Nat.cast_pow, ← Real.rpow_natCast, ← Real.rpow_mul (Nat.cast_nonneg _)]
  push_cast
  ring_nf

theorem a_div_primePow (p : Nat.Primes) (k : ℕ) (w : ℝ) :
    a ((p : ℕ) ^ (k + 1)) / ((((p : ℕ) ^ (k + 1) : ℕ)) : ℝ) ^ w = g w (p, k) := by
  rw [a_primePow, rpow_primePow]
  rfl

theorem support_a_div_subset (w : ℝ) :
    Function.support (fun n : ℕ => a n / (n : ℝ) ^ w) ⊆ {n : ℕ | IsPrimePow n} := by
  intro n hn
  simp only [Function.mem_support] at hn
  by_contra h
  apply hn
  simp [a, vonMangoldt_eq_zero_iff.mpr h]

theorem T_eq_tsum_g {w : ℝ} (hw : 1 < w) : T w = ∑' q : Nat.Primes × ℕ, g w q := by
  unfold T
  have h1 : (∑' n : ℕ, a n / (n : ℝ) ^ w) =
      ∑' x : {n : ℕ // IsPrimePow n}, a (x : ℕ) / ((x : ℕ) : ℝ) ^ w :=
    (tsum_subtype_eq_of_support_subset (support_a_div_subset w)).symm
  rw [h1, ← Nat.Primes.prodNatEquiv.tsum_eq]
  apply tsum_congr
  rintro ⟨p, k⟩
  rw [Nat.Primes.coe_prodNatEquiv_apply]
  exact a_div_primePow p k w

theorem summable_g {w : ℝ} (hw : 1 < w) : Summable (g w) := by
  have h := summable_a_div hw
  have h2 : Summable (fun x : {n : ℕ // IsPrimePow n} => a (x : ℕ) / ((x : ℕ) : ℝ) ^ w) :=
    h.subtype _
  have h3 := (Nat.Primes.prodNatEquiv.summable_iff
    (f := fun x : {n : ℕ // IsPrimePow n} => a (x : ℕ) / ((x : ℕ) : ℝ) ^ w)).mpr h2
  refine h3.congr ?_
  rintro ⟨p, k⟩
  show a ((Nat.Primes.prodNatEquiv (p, k) : ℕ)) / ((Nat.Primes.prodNatEquiv (p, k) : ℕ) : ℝ) ^ w =
    g w (p, k)
  rw [Nat.Primes.coe_prodNatEquiv_apply]
  exact a_div_primePow p k w

theorem g_nonneg (w : ℝ) (q : Nat.Primes × ℕ) : 0 ≤ g w q := by
  unfold g
  positivity

theorem g_zero (w : ℝ) (p : Nat.Primes) : g w (p, 0) = primeMajorant (w / 2) p := by
  unfold g primeMajorant
  simp only [Nat.cast_zero, zero_add, one_mul]
  rw [show 2 * (w / 2) = w by ring]

theorem primeMajorant_nonneg (σ : ℝ) (p : Nat.Primes) : 0 ≤ primeMajorant σ p := by
  unfold primeMajorant
  positivity

/-- The tail `E(w) = ∑_p ∑_{k ≥ 1} (k+1)(log p)^2 / p^{(k+1)w}`. -/
noncomputable def E (w : ℝ) : ℝ := ∑' p : Nat.Primes, ∑' k : ℕ, g w (p, k + 1)

theorem summable_fiber_tail {w : ℝ} (hw : 1 < w) :
    Summable (fun p : Nat.Primes => ∑' k : ℕ, g w (p, k + 1)) := by
  have hg := summable_g hw
  refine Summable.of_nonneg_of_le (fun p => tsum_nonneg (fun k => g_nonneg w _)) (fun p => ?_) hg.prod
  rw [(hg.prod_factor p).tsum_eq_zero_add]
  linarith [g_nonneg w (p, 0)]

theorem T_eq_S_add_E {w : ℝ} (hw : 1 < w) :
    T w = (∑' p : Nat.Primes, primeMajorant (w / 2) p) + E w := by
  have hg := summable_g hw
  rw [T_eq_tsum_g hw, hg.tsum_prod' (fun p => hg.prod_factor p)]
  have hfib : ∀ p : Nat.Primes, (∑' k : ℕ, g w (p, k)) = g w (p, 0) + ∑' k : ℕ, g w (p, k + 1) :=
    fun p => (hg.prod_factor p).tsum_eq_zero_add
  simp_rw [hfib, g_zero]
  have hS : Summable (fun p : Nat.Primes => primeMajorant (w / 2) p) :=
    primeMajorant_summable (by linarith)
  exact hS.tsum_add (summable_fiber_tail hw)

theorem E_nonneg (w : ℝ) : 0 ≤ E w :=
  tsum_nonneg (fun p => tsum_nonneg (fun k => g_nonneg w _))

/-- `k + 2 ≤ 2 (3/2)^k`. -/
theorem nat_add_two_le (k : ℕ) : ((k : ℝ) + 2) ≤ 2 * (3 / 2 : ℝ) ^ k := by
  induction k with
  | zero => norm_num
  | succ n ih =>
    rw [pow_succ]
    push_cast
    nlinarith [ih, pow_nonneg (by norm_num : (0 : ℝ) ≤ 3 / 2) n]

theorem g_succ_le {w : ℝ} (hw : 1 ≤ w) (p : Nat.Primes) (k : ℕ) :
    g w (p, k + 1) ≤ (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2 * (2 * (3 / 4 : ℝ) ^ k) := by
  unfold g
  have hp2 : (2 : ℝ) ≤ ((p : ℕ) : ℝ) := by exact_mod_cast p.prop.two_le
  have hp0 : (0 : ℝ) < ((p : ℕ) : ℝ) := by linarith
  have hp1 : (1 : ℝ) ≤ ((p : ℕ) : ℝ) := by linarith
  simp only [Nat.cast_add, Nat.cast_one]
  have hexp : ((k : ℝ) + 1 + 1) ≤ ((k : ℝ) + 1 + 1) * w := by nlinarith
  have hden1 : ((p : ℕ) : ℝ) ^ ((k : ℝ) + 1 + 1) ≤ ((p : ℕ) : ℝ) ^ (((k : ℝ) + 1 + 1) * w) :=
    Real.rpow_le_rpow_of_exponent_le hp1 hexp
  have hden2 : ((p : ℕ) : ℝ) ^ ((k : ℝ) + 1 + 1) = ((p : ℕ) : ℝ) ^ 2 * ((p : ℕ) : ℝ) ^ k := by
    rw [show ((k : ℝ) + 1 + 1) = ((k + 2 : ℕ) : ℝ) by push_cast; ring, Real.rpow_natCast]
    ring
  have hpk : (2 : ℝ) ^ k ≤ ((p : ℕ) : ℝ) ^ k := pow_le_pow_left₀ (by norm_num) hp2 k
  have hden : ((p : ℕ) : ℝ) ^ 2 * (2 : ℝ) ^ k ≤ ((p : ℕ) : ℝ) ^ (((k : ℝ) + 1 + 1) * w) := by
    calc ((p : ℕ) : ℝ) ^ 2 * (2 : ℝ) ^ k ≤ ((p : ℕ) : ℝ) ^ 2 * ((p : ℕ) : ℝ) ^ k :=
          mul_le_mul_of_nonneg_left hpk (by positivity)
      _ = ((p : ℕ) : ℝ) ^ ((k : ℝ) + 1 + 1) := hden2.symm
      _ ≤ _ := hden1
  have hnum : ((k : ℝ) + 1 + 1) * (Real.log (p : ℕ)) ^ 2 ≤
      2 * (3 / 2 : ℝ) ^ k * (Real.log (p : ℕ)) ^ 2 := by
    have := nat_add_two_le k
    have hl : 0 ≤ (Real.log (p : ℕ)) ^ 2 := sq_nonneg _
    nlinarith
  have hpos : 0 < ((p : ℕ) : ℝ) ^ 2 * (2 : ℝ) ^ k := by positivity
  calc ((k : ℝ) + 1 + 1) * (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ (((k : ℝ) + 1 + 1) * w)
      ≤ 2 * (3 / 2 : ℝ) ^ k * (Real.log (p : ℕ)) ^ 2 / (((p : ℕ) : ℝ) ^ 2 * (2 : ℝ) ^ k) := by
        apply div_le_div₀ (by positivity) hnum hpos hden
    _ = (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2 * (2 * (3 / 4 : ℝ) ^ k) := by
        have h34 : (3 / 4 : ℝ) ^ k = (3 / 2 : ℝ) ^ k / 2 ^ k := by
          rw [← div_pow]
          norm_num
        rw [h34]
        field_simp

theorem tsum_two_mul_geom : (∑' k : ℕ, 2 * (3 / 4 : ℝ) ^ k) = 8 := by
  rw [tsum_mul_left, tsum_geometric_of_lt_one (by norm_num) (by norm_num)]
  norm_num

theorem fiber_tail_le {w : ℝ} (hw : 1 ≤ w) (p : Nat.Primes) :
    (∑' k : ℕ, g w (p, k + 1)) ≤ 8 * ((Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2) := by
  have hgeom : Summable (fun k : ℕ =>
      (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2 * (2 * (3 / 4 : ℝ) ^ k)) :=
    ((summable_geometric_of_lt_one (by norm_num) (by norm_num)).mul_left 2).mul_left _
  have hs : Summable (fun k : ℕ => g w (p, k + 1)) :=
    Summable.of_nonneg_of_le (fun k => g_nonneg w _) (fun k => g_succ_le hw p k) hgeom
  calc (∑' k : ℕ, g w (p, k + 1))
      ≤ ∑' k : ℕ, (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2 * (2 * (3 / 4 : ℝ) ^ k) :=
        hs.tsum_le_tsum (fun k => g_succ_le hw p k) hgeom
    _ = (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2 * ∑' k : ℕ, 2 * (3 / 4 : ℝ) ^ k := tsum_mul_left
    _ = 8 * ((Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2) := by rw [tsum_two_mul_geom]; ring

/-- The constant bounding the prime-power tail. -/
noncomputable def C₂ : ℝ := 8 * ∑' p : Nat.Primes, (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2

theorem summable_log_sq_div_sq :
    Summable (fun p : Nat.Primes => (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2) := by
  have h := (summable_log_sq_div_rpow (t := 2) (by norm_num)).subtype (fun n : ℕ => Nat.Prime n)
  refine h.congr ?_
  intro p
  show (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ (2 : ℝ) = (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ 2
  rw [Real.rpow_two]

theorem E_le {w : ℝ} (hw : 1 < w) : E w ≤ C₂ := by
  unfold E C₂
  rw [← tsum_mul_left]
  exact (summable_fiber_tail hw).tsum_le_tsum (fun p => fiber_tail_le hw.le p)
    (summable_log_sq_div_sq.mul_left 8)

/-- Two-sided comparison between `T(w)` and the prime part `∑_p (log p)^2 / p^w`. -/
theorem S_le_T_le {w : ℝ} (hw : 1 < w) :
    (∑' p : Nat.Primes, primeMajorant (w / 2) p) ≤ T w ∧
      T w ≤ (∑' p : Nat.Primes, primeMajorant (w / 2) p) + C₂ := by
  rw [T_eq_S_add_E hw]
  exact ⟨by linarith [E_nonneg w], by linarith [E_le hw]⟩

end BuildingBlocks.PrimePowerLogSeries
