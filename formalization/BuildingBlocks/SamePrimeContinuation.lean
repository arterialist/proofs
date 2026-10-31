import BuildingBlocks.PrimePowerLogSeries
import BuildingBlocks.ZetaPole
import Mathlib.NumberTheory.LSeries.Nonvanishing
import Mathlib.NumberTheory.LSeries.Nonvanishing

/-!
# Analytic continuation of the same-prime series across the critical line

The same-prime series `H(s) = ∑_p (log p)² p^{-2s}/(1 - p^{-s})²` of `SamePrimeDirichlet`
converges absolutely only for `Re s > 1/2`. Writing `r = p^{-s}`, the per-prime identity

  `r²/(1-r)² = r²/(1-r²)² + r³(2+r)/(1-r²)²`

splits `H` into `∑_p (log p)² r²/(1-r²)²`, which is `∑_n Λ(n) log n · n^{-2s} = (ζ'/ζ)'(2s)` for
`Re s > 1/2` (reindexing prime powers through `Nat.Primes.prodNatEquiv`), and a remainder
`D(s) = ∑_p (log p)² r³(2+r)/(1-r²)²` that converges absolutely for `Re s > 1/3`. Hence

  `Hext(s) = (ζ'/ζ)'(2s) + D(s)`

is analytic at every `s` with `Re s > 1/3`, `2s ≠ 1`, `ζ(2s) ≠ 0`, and agrees with `H` on
`Re s > 1/2`. In particular `Hext` is analytic at every point `1/2 + iγ`, `γ ≠ 0`, of the
critical line (where `ζ(1 + 2iγ) ≠ 0`), which is what the pole analysis of the transform
`M (G² - H)` at a zero on the line needs.
-/

open Filter Topology LSeries ArithmeticFunction
open scoped LSeries.notation

namespace BuildingBlocks.SamePrimeContinuation

open SamePrimeDirichlet PrimePowerLogSeries RiemannZetaCenteredLogDeriv

/-! ### The L-series `∑ Λ(n) log n / n^w` for complex `w` -/

theorem abscissa_vonMangoldt_lt' {w : ℂ} (hw : 1 < w.re) :
    abscissaOfAbsConv ↗Λ < w.re := by
  have h1 : abscissaOfAbsConv ↗Λ ≤ ((1 : ℝ) : EReal) :=
    abscissaOfAbsConv_le_of_forall_lt_LSeriesSummable
      (fun y hy => LSeriesSummable_vonMangoldt (by simpa using hy))
  exact lt_of_le_of_lt h1 (EReal.coe_lt_coe_iff.mpr hw)

/-- `∑ Λ(n) log n / n^w = (ζ'/ζ)'(w)` for complex `w` with `Re w > 1`. -/
theorem LSeries_logMul_eq_deriv' {w : ℂ} (hw : 1 < w.re) :
    LSeries (logMul ↗Λ) w =
      deriv (fun s : ℂ => deriv riemannZeta s / riemannZeta s) w := by
  have habs := abscissa_vonMangoldt_lt' hw
  have h1 : deriv (LSeries ↗Λ) w = -LSeries (logMul ↗Λ) w := LSeries_deriv habs
  have h2 : LSeries ↗Λ =ᶠ[𝓝 w] fun s => -deriv riemannZeta s / riemannZeta s := by
    have hopen : IsOpen {s : ℂ | 1 < s.re} := isOpen_lt continuous_const Complex.continuous_re
    filter_upwards [hopen.mem_nhds hw] with s hs
    exact LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs
  have h3 : deriv (LSeries ↗Λ) w =
      deriv (fun s : ℂ => -deriv riemannZeta s / riemannZeta s) w := h2.deriv_eq
  have h4 : deriv (fun s : ℂ => -deriv riemannZeta s / riemannZeta s) w =
      -deriv (fun s : ℂ => deriv riemannZeta s / riemannZeta s) w := by
    have hf : (fun s : ℂ => -deriv riemannZeta s / riemannZeta s) =
        fun s => -(deriv riemannZeta s / riemannZeta s) := by
      funext s
      ring
    rw [hf, show (fun s : ℂ => -(deriv riemannZeta s / riemannZeta s)) =
      -(fun s : ℂ => deriv riemannZeta s / riemannZeta s) from rfl, deriv.neg]
  rw [h3, h4] at h1
  linear_combination h1

/-! ### Reindexing by prime powers -/

theorem term_logMul_primePow (w : ℂ) (p : Nat.Primes) (k : ℕ) :
    term (logMul ↗Λ) w ((p : ℕ) ^ (k + 1)) =
      (((k : ℂ) + 1) * (Real.log (p : ℕ) : ℂ) ^ 2) * ((p : ℂ) ^ (-w)) ^ (k + 1) := by
  have hp0 : ((p : ℕ) ^ (k + 1) : ℕ) ≠ 0 := pow_ne_zero _ p.prop.ne_zero
  have hpR : (0 : ℝ) < (p : ℕ) := by exact_mod_cast p.prop.pos
  rw [term_of_ne_zero hp0]
  unfold logMul
  simp only
  rw [vonMangoldt_apply_pow (Nat.succ_ne_zero k), vonMangoldt_apply_prime p.prop]
  have hlog : Complex.log (((p : ℕ) ^ (k + 1) : ℕ) : ℂ) =
      ((k : ℂ) + 1) * (Real.log (p : ℕ) : ℂ) := by
    rw [← Complex.natCast_log, Nat.cast_pow, Real.log_pow]
    push_cast
    ring
  have hpow : (((p : ℕ) ^ (k + 1) : ℕ) : ℂ) ^ w = ((p : ℂ) ^ w) ^ (k + 1) := by
    rw [Nat.cast_pow, ← Complex.cpow_natCast (p : ℂ) (k + 1)]
    have hlogp : Complex.log (p : ℂ) = (Real.log (p : ℕ) : ℂ) :=
      (Complex.natCast_log (n := (p : ℕ))).symm
    have him0 : (Complex.log (p : ℂ) * (((k + 1 : ℕ) : ℂ))).im = 0 := by
      rw [hlogp, Complex.im_ofReal_mul, Complex.natCast_im, mul_zero]
    rw [← Complex.cpow_mul w (by rw [him0]; exact neg_neg_of_pos Real.pi_pos)
      (by rw [him0]; exact Real.pi_pos.le), ← Complex.cpow_nat_mul]
  rw [hlog, hpow, Complex.cpow_neg, inv_pow]
  push_cast
  ring

theorem support_term_subset (w : ℂ) :
    Function.support (term (logMul ↗Λ) w) ⊆ {n : ℕ | IsPrimePow n} := by
  intro n hn
  simp only [Function.mem_support] at hn
  by_contra h
  apply hn
  by_cases hn0 : n = 0
  · subst hn0
    exact term_zero _ _
  · rw [term_of_ne_zero hn0]
    unfold logMul
    simp [vonMangoldt_eq_zero_iff.mpr h]

theorem LSeries_eq_tsum_primePow (w : ℂ) :
    LSeries (logMul ↗Λ) w =
      ∑' q : Nat.Primes × ℕ, term (logMul ↗Λ) w ((q.1 : ℕ) ^ (q.2 + 1)) := by
  unfold LSeries
  have h1 : (∑' n : ℕ, term (logMul ↗Λ) w n) =
      ∑' x : {n : ℕ // IsPrimePow n}, term (logMul ↗Λ) w (x : ℕ) :=
    (tsum_subtype_eq_of_support_subset (support_term_subset w)).symm
  rw [h1, ← Nat.Primes.prodNatEquiv.tsum_eq]
  apply tsum_congr
  rintro ⟨p, k⟩
  rw [Nat.Primes.coe_prodNatEquiv_apply]

theorem summable_term_primePow {w : ℂ} (hw : 1 < w.re) :
    Summable (fun q : Nat.Primes × ℕ => term (logMul ↗Λ) w ((q.1 : ℕ) ^ (q.2 + 1))) := by
  have h : LSeriesSummable (logMul ↗Λ) w :=
    LSeriesSummable_logMul_of_lt_re (abscissa_vonMangoldt_lt' hw)
  have h2 : Summable (fun x : {n : ℕ // IsPrimePow n} => term (logMul ↗Λ) w (x : ℕ)) :=
    h.subtype _
  have h3 := (Nat.Primes.prodNatEquiv.summable_iff
    (f := fun x : {n : ℕ // IsPrimePow n} => term (logMul ↗Λ) w (x : ℕ))).mpr h2
  refine h3.congr ?_
  rintro ⟨p, k⟩
  show term (logMul ↗Λ) w ((Nat.Primes.prodNatEquiv (p, k) : ℕ)) = _
  rw [Nat.Primes.coe_prodNatEquiv_apply]

theorem norm_cpow_neg_lt_one (p : Nat.Primes) {w : ℂ} (hw : 0 < w.re) :
    ‖(p : ℂ) ^ (-w)‖ < 1 := by
  rw [Complex.norm_natCast_cpow_of_pos p.prop.pos]
  simp only [Complex.neg_re]
  exact Real.rpow_lt_one_of_one_lt_of_neg (by exact_mod_cast p.prop.one_lt) (by linarith)

/-- The prime-power fibre sums to the closed form `(log p)² r/(1-r)²`, `r = p^{-w}`. -/
theorem hasSum_primePow_fiber (p : Nat.Primes) {w : ℂ} (hw : 0 < w.re) :
    HasSum (fun k : ℕ => term (logMul ↗Λ) w ((p : ℕ) ^ (k + 1)))
      ((Real.log (p : ℕ) : ℂ) ^ 2 * ((p : ℂ) ^ (-w) / (1 - (p : ℂ) ^ (-w)) ^ 2)) := by
  have hq := norm_cpow_neg_lt_one p hw
  have h := (hasSum_choose_mul_geometric_of_norm_lt_one (𝕜 := ℂ) 1 hq).mul_left
    ((Real.log (p : ℕ) : ℂ) ^ 2 * (p : ℂ) ^ (-w))
  convert h using 1
  · funext k
    rw [term_logMul_primePow]
    simp only [Nat.choose_one_right, Nat.cast_add, Nat.cast_one, pow_succ]
    ring
  · ring

/-- `∑ Λ(n) log n / n^w = ∑_p (log p)² p^{-w}/(1 - p^{-w})²` for `Re w > 1`. -/
theorem LSeries_logMul_eq_prime_sum {w : ℂ} (hw : 1 < w.re) :
    LSeries (logMul ↗Λ) w =
      ∑' p : Nat.Primes,
        (Real.log (p : ℕ) : ℂ) ^ 2 * ((p : ℂ) ^ (-w) / (1 - (p : ℂ) ^ (-w)) ^ 2) := by
  rw [LSeries_eq_tsum_primePow]
  have hs := summable_term_primePow hw
  rw [hs.tsum_prod' (fun p => hs.prod_factor p)]
  exact tsum_congr (fun p => (hasSum_primePow_fiber p (by linarith)).tsum_eq)

/-! ### The remainder `D` -/

/-- The per-prime difference `(log p)² r³(2+r)/(1-r²)²`, `r = p^{-s}`. -/
noncomputable def dTerm (p : Nat.Primes) (s : ℂ) : ℂ :=
  (Real.log (p : ℕ) : ℂ) ^ 2 *
    (primeRatio p s ^ 3 * (2 + primeRatio p s) / (1 - primeRatio p s ^ 2) ^ 2)

/-- `D(s) = ∑_p (log p)² r³(2+r)/(1-r²)²`. -/
noncomputable def D (s : ℂ) : ℂ := ∑' p : Nat.Primes, dTerm p s

theorem norm_primeRatio_lt_one (p : Nat.Primes) {s : ℂ} (hs : 0 < s.re) :
    ‖primeRatio p s‖ < 1 :=
  (norm_primeRatio_le p le_rfl).trans_lt
    ((prime_rpow_le_two hs.le p).trans_lt (two_rpow_lt_one hs))

theorem one_sub_sq_ne_zero {r : ℂ} (hr : ‖r‖ < 1) : (1 - r ^ 2) ≠ 0 := by
  intro h
  have h1 : r ^ 2 = 1 := by linear_combination -h
  have h2 : ‖r ^ 2‖ < 1 := by
    rw [norm_pow]
    exact pow_lt_one₀ (norm_nonneg r) hr (by norm_num)
  rw [h1, norm_one] at h2
  exact lt_irrefl _ h2

theorem one_sub_ne_zero {r : ℂ} (hr : ‖r‖ < 1) : (1 - r) ≠ 0 := by
  intro h
  have h1 : r = 1 := by linear_combination -h
  rw [h1, norm_one] at hr
  exact lt_irrefl _ hr

/-- The per-prime identity: `samePrimeTerm = (log p)² r²/(1-r²)² + dTerm`. -/
theorem samePrimeTerm_eq_add (p : Nat.Primes) {s : ℂ} (hs : 0 < s.re) :
    samePrimeTerm p s =
      (Real.log (p : ℕ) : ℂ) ^ 2 * ((p : ℂ) ^ (-(2 * s)) / (1 - (p : ℂ) ^ (-(2 * s))) ^ 2) +
        dTerm p s := by
  have hr := norm_primeRatio_lt_one p hs
  have h2 : (p : ℂ) ^ (-(2 * s)) = primeRatio p s ^ 2 := by
    unfold primeRatio
    rw [show -(2 * s) = ((2 : ℕ) : ℂ) * (-s) by push_cast; ring, Complex.cpow_nat_mul]
  rw [h2]
  unfold samePrimeTerm dTerm
  have h1 := one_sub_ne_zero hr
  have h3 := one_sub_sq_ne_zero hr
  field_simp
  try ring

theorem dTerm_differentiableOn {σ : ℝ} (hσ : 0 < σ) (p : Nat.Primes) :
    DifferentiableOn ℂ (dTerm p) {s : ℂ | σ < s.re} := by
  intro s hs
  have hs' : 0 < s.re := lt_trans hσ hs
  have hp : (p : ℂ) ≠ 0 := by exact_mod_cast p.prop.ne_zero
  have hq : DifferentiableAt ℂ (primeRatio p) s :=
    (differentiable_id.neg.const_cpow (Or.inl hp)) s
  have hden : (1 - primeRatio p s ^ 2) ^ 2 ≠ 0 :=
    pow_ne_zero 2 (one_sub_sq_ne_zero (norm_primeRatio_lt_one p hs'))
  apply DifferentiableAt.differentiableWithinAt
  unfold dTerm
  exact (differentiableAt_const _).mul
    (((hq.pow 3).mul ((differentiableAt_const _).add hq)).div
      (((differentiableAt_const _).sub (hq.pow 2)).pow 2) hden)

/-- The majorant `3 (log p)² p^{-3σ} / (1 - 2^{-2σ})²`. -/
noncomputable def dMajorant (σ : ℝ) (p : Nat.Primes) : ℝ :=
  3 / (1 - (2 : ℝ) ^ (-(2 * σ))) ^ 2 * ((Real.log (p : ℕ)) ^ 2 / (p : ℝ) ^ (3 * σ))

theorem dMajorant_summable {σ : ℝ} (hσ : 1 / 3 < σ) : Summable (dMajorant σ) :=
  ((summable_log_sq_div_rpow (by linarith : 1 < 3 * σ)).subtype _).mul_left _

theorem norm_dTerm_le {σ : ℝ} (hσ : 0 < σ) (p : Nat.Primes) {s : ℂ} (hs : σ ≤ s.re) :
    ‖dTerm p s‖ ≤ dMajorant σ p := by
  set r := primeRatio p s with hr
  have hra : ‖r‖ ≤ (p : ℝ) ^ (-σ) := norm_primeRatio_le p hs
  have hr2 : (p : ℝ) ^ (-σ) ≤ (2 : ℝ) ^ (-σ) := prime_rpow_le_two hσ.le p
  have hr1 : (2 : ℝ) ^ (-σ) < 1 := two_rpow_lt_one hσ
  have hr0 : 0 ≤ ‖r‖ := norm_nonneg _
  have hp0 : (0 : ℝ) < (p : ℝ) := by exact_mod_cast p.prop.pos
  have h2σ : (2 : ℝ) ^ (-(2 * σ)) = ((2 : ℝ) ^ (-σ)) ^ 2 := by
    rw [← Real.rpow_natCast, ← Real.rpow_mul (by norm_num)]
    congr 1
    push_cast
    ring
  have hc : 0 < 1 - (2 : ℝ) ^ (-(2 * σ)) := by
    rw [h2σ]
    have : ((2 : ℝ) ^ (-σ)) ^ 2 < 1 := pow_lt_one₀ (by positivity) hr1 (by norm_num)
    linarith
  -- lower bound for the denominator
  have hden : 1 - (2 : ℝ) ^ (-(2 * σ)) ≤ ‖1 - r ^ 2‖ := by
    have h1 : ‖r ^ 2‖ ≤ (2 : ℝ) ^ (-(2 * σ)) := by
      rw [norm_pow, h2σ]
      exact pow_le_pow_left₀ hr0 (hra.trans hr2) 2
    calc 1 - (2 : ℝ) ^ (-(2 * σ)) ≤ 1 - ‖r ^ 2‖ := by linarith
      _ = ‖(1 : ℂ)‖ - ‖r ^ 2‖ := by rw [norm_one]
      _ ≤ ‖1 - r ^ 2‖ := norm_sub_norm_le _ _
  have hnum : ‖r ^ 3 * (2 + r)‖ ≤ (p : ℝ) ^ (-(3 * σ)) * 3 := by
    rw [norm_mul, norm_pow]
    have h3 : ‖r‖ ^ 3 ≤ ((p : ℝ) ^ (-σ)) ^ 3 := pow_le_pow_left₀ hr0 hra 3
    have h3' : ((p : ℝ) ^ (-σ)) ^ 3 = (p : ℝ) ^ (-(3 * σ)) := by
      rw [← Real.rpow_natCast, ← Real.rpow_mul hp0.le]
      congr 1
      push_cast
      ring
    have h4 : ‖(2 : ℂ) + r‖ ≤ 3 := by
      calc ‖(2 : ℂ) + r‖ ≤ ‖(2 : ℂ)‖ + ‖r‖ := norm_add_le _ _
        _ ≤ 2 + 1 := by
          gcongr
          · norm_num
          · exact hra.trans (hr2.trans hr1.le)
        _ = 3 := by norm_num
    calc ‖r‖ ^ 3 * ‖(2 : ℂ) + r‖ ≤ ((p : ℝ) ^ (-σ)) ^ 3 * 3 :=
          mul_le_mul h3 h4 (norm_nonneg _) (by positivity)
      _ = (p : ℝ) ^ (-(3 * σ)) * 3 := by rw [h3']
  unfold dTerm dMajorant
  rw [norm_mul, norm_pow, Complex.norm_real, Real.norm_eq_abs, sq_abs, norm_div, norm_pow]
  have hL : 0 ≤ (Real.log (p : ℕ)) ^ 2 := sq_nonneg _
  have hden2 : (1 - (2 : ℝ) ^ (-(2 * σ))) ^ 2 ≤ ‖1 - r ^ 2‖ ^ 2 :=
    pow_le_pow_left₀ hc.le hden 2
  have hpos2 : 0 < (1 - (2 : ℝ) ^ (-(2 * σ))) ^ 2 := by positivity
  have hdiv : ‖r ^ 3 * (2 + r)‖ / ‖1 - r ^ 2‖ ^ 2 ≤
      (p : ℝ) ^ (-(3 * σ)) * 3 / (1 - (2 : ℝ) ^ (-(2 * σ))) ^ 2 :=
    div_le_div₀ (by positivity) hnum hpos2 hden2
  have hrp : (p : ℝ) ^ (-(3 * σ)) = 1 / (p : ℝ) ^ (3 * σ) := by
    rw [Real.rpow_neg hp0.le, one_div]
  calc (Real.log (p : ℕ)) ^ 2 * (‖r ^ 3 * (2 + r)‖ / ‖1 - r ^ 2‖ ^ 2)
      ≤ (Real.log (p : ℕ)) ^ 2 *
          ((p : ℝ) ^ (-(3 * σ)) * 3 / (1 - (2 : ℝ) ^ (-(2 * σ))) ^ 2) :=
        mul_le_mul_of_nonneg_left hdiv hL
    _ = 3 / (1 - (2 : ℝ) ^ (-(2 * σ))) ^ 2 * ((Real.log (p : ℕ)) ^ 2 / (p : ℝ) ^ (3 * σ)) := by
        rw [hrp]
        try ring

theorem D_differentiableOn {σ : ℝ} (hσ : 1 / 3 < σ) :
    DifferentiableOn ℂ D {s : ℂ | σ < s.re} := by
  unfold D
  exact Complex.differentiableOn_tsum_of_summable_norm (dMajorant_summable hσ)
    (fun p => dTerm_differentiableOn (by linarith) p)
    (isOpen_lt continuous_const Complex.continuous_re)
    (fun p s hs => norm_dTerm_le (by linarith) p (le_of_lt hs))

theorem D_analyticAt {s : ℂ} (hs : 1 / 3 < s.re) : AnalyticAt ℂ D s := by
  set σ : ℝ := (1 / 3 + s.re) / 2 with hσdef
  have hσ : 1 / 3 < σ := by rw [hσdef]; linarith
  have hσs : σ < s.re := by rw [hσdef]; linarith
  exact (D_differentiableOn hσ).analyticAt
    ((isOpen_lt continuous_const Complex.continuous_re).mem_nhds hσs)

theorem summable_dTerm {s : ℂ} (hs : 1 / 3 < s.re) : Summable (fun p : Nat.Primes => dTerm p s) :=
  Summable.of_norm_bounded (dMajorant_summable hs) (fun p => norm_dTerm_le (by linarith) p le_rfl)

/-! ### The continuation -/

/-- `H(s) = ∑ Λ(n) log n · n^{-2s} + D(s)` for `Re s > 1/2`. -/
theorem H_eq_LSeries_add_D {s : ℂ} (hs : 1 / 2 < s.re) :
    H s = LSeries (logMul ↗Λ) (2 * s) + D s := by
  have h2 : 1 < (2 * s).re := by
    simp only [Complex.mul_re, Complex.re_ofNat, Complex.im_ofNat, zero_mul, sub_zero]
    linarith
  rw [LSeries_logMul_eq_prime_sum h2]
  unfold H D
  have hsum1 : Summable (fun p : Nat.Primes => samePrimeTerm p s) :=
    (samePrimeTerm_norm_summable hs).of_norm
  have hsumD : Summable (fun p : Nat.Primes => dTerm p s) := summable_dTerm (by linarith)
  have hsumT : Summable (fun p : Nat.Primes =>
      (Real.log (p : ℕ) : ℂ) ^ 2 * ((p : ℂ) ^ (-(2 * s)) / (1 - (p : ℂ) ^ (-(2 * s))) ^ 2)) := by
    refine (hsum1.sub hsumD).congr (fun p => ?_)
    rw [samePrimeTerm_eq_add p (by linarith)]
    ring
  rw [← hsumT.tsum_add hsumD]
  exact tsum_congr (fun p => samePrimeTerm_eq_add p (by linarith))

/-- The continuation `(ζ'/ζ)'(2s) + D(s)` of the same-prime series. -/
noncomputable def Hext (s : ℂ) : ℂ :=
  deriv (fun z : ℂ => deriv riemannZeta z / riemannZeta z) (2 * s) + D s

theorem Hext_eq_H {s : ℂ} (hs : 1 / 2 < s.re) : Hext s = H s := by
  have h2 : 1 < (2 * s).re := by
    simp only [Complex.mul_re, Complex.re_ofNat, Complex.im_ofNat, zero_mul, sub_zero]
    linarith
  unfold Hext
  rw [H_eq_LSeries_add_D hs, LSeries_logMul_eq_deriv' h2]

/-- `Hext` is analytic wherever `Re s > 1/3`, `2s ≠ 1` and `ζ(2s) ≠ 0`. -/
theorem Hext_analyticAt {s : ℂ} (hs : 1 / 3 < s.re) (h1 : 2 * s ≠ 1)
    (hz : riemannZeta (2 * s) ≠ 0) : AnalyticAt ℂ Hext s := by
  have hζ : AnalyticAt ℂ riemannZeta (2 * s) := zeta_analytic_off_pole _ h1
  have hq : AnalyticAt ℂ (fun z : ℂ => deriv riemannZeta z / riemannZeta z) (2 * s) :=
    hζ.deriv.div hζ hz
  have hd : AnalyticAt ℂ (deriv (fun z : ℂ => deriv riemannZeta z / riemannZeta z)) (2 * s) :=
    hq.deriv
  have hcomp : AnalyticAt ℂ
      (fun s : ℂ => deriv (fun z : ℂ => deriv riemannZeta z / riemannZeta z) (2 * s)) s :=
    hd.comp (analyticAt_const.mul analyticAt_id)
  exact hcomp.add (D_analyticAt hs)

/-- On the critical line away from `1/2`, `Hext` is analytic. -/
theorem Hext_analyticAt_line {ρ : ℂ} (hρ : ρ.re = 1 / 2) (hρim : ρ.im ≠ 0) :
    AnalyticAt ℂ Hext ρ := by
  have h1 : 2 * ρ ≠ 1 := by
    intro h
    have := congrArg Complex.im h
    simp at this
    exact hρim this
  have hre : (1 : ℝ) ≤ (2 * ρ).re := by
    rw [Complex.mul_re, hρ]
    norm_num
  have hz : riemannZeta (2 * ρ) ≠ 0 := riemannZeta_ne_zero_of_one_le_re hre
  exact Hext_analyticAt (by rw [hρ]; norm_num) h1 hz

end BuildingBlocks.SamePrimeContinuation
