import Mathlib.NumberTheory.LSeries.Dirichlet
import Mathlib.Analysis.Complex.LocallyUniformLimit
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Analysis.Normed.Ring.InfiniteSum
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Absolute and locally uniform convergence of the actual same-prime series.
The exponent index k represents every proper power k+2, with multiplicity k+1.
No zero-free or RH assumption occurs. -/
namespace BuildingBlocks.SamePrimeDirichlet
open scoped BigOperators Topology
open Complex LSeries

lemma summable_log_sq_div_rpow {t : ℝ} (ht : 1 < t) :
    Summable (fun n : ℕ => (Real.log n)^2 / (n : ℝ)^t) := by
  have h : LSeriesSummable (logMul (logMul (1 : ℕ → ℂ))) (t : ℂ) :=
    LSeriesSummable_logMul_of_lt_re (by
      simp only [abscissaOfAbsConv_logMul, abscissaOfAbsConv_one, ofReal_re]
      exact_mod_cast ht)
  apply h.norm.congr
  intro n
  rw [norm_term_eq]
  by_cases hn : n = 0
  · simp [hn]
  · simp [hn, logMul, ← natCast_log, Complex.norm_real, Real.norm_eq_abs,
      ← pow_two, sq_abs]

noncomputable def primeMajorant (σ : ℝ) (p : Nat.Primes) : ℝ :=
  (Real.log (p : ℕ))^2 / (p : ℝ)^(2*σ)

lemma primeMajorant_summable {σ : ℝ} (hσ : 1/2 < σ) :
    Summable (primeMajorant σ) := by
  exact (summable_log_sq_div_rpow (by linarith : 1 < 2*σ)).subtype _

noncomputable def primeRatio (p : Nat.Primes) (s : ℂ) : ℂ :=
  (p : ℂ)^(-s)

noncomputable def powerTerm (p : Nat.Primes) (k : ℕ) (s : ℂ) : ℂ :=
  (Real.log (p : ℕ) : ℂ)^2 * (k+1) * primeRatio p s ^ (k+2)

lemma norm_primeRatio (p : Nat.Primes) (s : ℂ) :
    ‖primeRatio p s‖ = (p : ℝ)^(-s.re) := by
  exact norm_natCast_cpow_of_pos p.property.pos (-s)

lemma norm_primeRatio_le {σ : ℝ} (p : Nat.Primes) {s : ℂ}
    (hs : σ ≤ s.re) : ‖primeRatio p s‖ ≤ (p : ℝ)^(-σ) := by
  rw [norm_primeRatio]
  apply Real.rpow_le_rpow_of_exponent_le
  · exact_mod_cast p.property.one_lt.le
  · linarith

lemma prime_rpow_le_two {σ : ℝ} (hσ : 0 ≤ σ) (p : Nat.Primes) :
    (p : ℝ)^(-σ) ≤ (2 : ℝ)^(-σ) := by
  exact Real.rpow_le_rpow_of_exponent_nonpos (by norm_num)
    (by exact_mod_cast p.property.two_le) (by linarith)

lemma two_rpow_lt_one {σ : ℝ} (hσ : 0 < σ) :
    (2 : ℝ)^(-σ) < 1 := by
  exact Real.rpow_lt_one_of_one_lt_of_neg (by norm_num) (by linarith)

lemma norm_powerTerm_le {σ : ℝ} (hσ : 0 ≤ σ) (p : Nat.Primes) (k : ℕ)
    {s : ℂ} (hs : σ ≤ s.re) :
    ‖powerTerm p k s‖ ≤ primeMajorant σ p *
      (((k : ℝ)+1) * ((2 : ℝ)^(-σ))^k) := by
  have hp0 : (0 : ℝ) ≤ p := by positivity
  have hq := norm_primeRatio_le p hs
  have hr := hq.trans (prime_rpow_le_two hσ p)
  have hsq : ((p : ℝ)^(-σ))^2 = 1 / (p : ℝ)^(2*σ) := by
    rw [← Real.rpow_natCast, ← Real.rpow_mul hp0]
    norm_num only [Nat.cast_ofNat]
    rw [show (-σ) * (2 : ℝ) = -(2*σ) by ring, Real.rpow_neg hp0]
    simp only [one_div]
  have he : ‖powerTerm p k s‖ =
      (Real.log (p : ℕ))^2 * ((k : ℝ)+1) *
        (‖primeRatio p s‖^2 * ‖primeRatio p s‖^k) := by
    have hk : ‖(k : ℂ)+1‖ = (k : ℝ)+1 := by
      simpa only [Nat.cast_add, Nat.cast_one] using Complex.norm_natCast (k+1)
    simp only [powerTerm, norm_mul, norm_pow, Complex.norm_real, Real.norm_eq_abs,
      sq_abs, hk, show k+2 = 2+k by omega, pow_add]
  rw [he]
  calc
    _ ≤ (Real.log (p : ℕ))^2 * ((k : ℝ)+1) *
        (((p : ℝ)^(-σ))^2 * ((2 : ℝ)^(-σ))^k) := by gcongr
    _ = _ := by rw [hsq]; unfold primeMajorant; ring

noncomputable def majorant (σ : ℝ) (i : Nat.Primes × ℕ) : ℝ :=
  primeMajorant σ i.1 * (((i.2 : ℝ)+1) * ((2 : ℝ)^(-σ))^i.2)

lemma majorant_summable {σ : ℝ} (hσ : 1/2 < σ) : Summable (majorant σ) := by
  have hr0 : 0 ≤ (2 : ℝ)^(-σ) := by positivity
  have hr : ‖(2 : ℝ)^(-σ)‖ < 1 := by
    rw [Real.norm_eq_abs, abs_of_nonneg hr0]
    exact two_rpow_lt_one (by linarith)
  have hg : Summable (fun k : ℕ => ((k : ℝ)+1) * ((2 : ℝ)^(-σ))^k) := by
    simpa using (hasSum_choose_mul_geometric_of_norm_lt_one (𝕜 := ℝ) 1 hr).summable
  exact (primeMajorant_summable hσ).mul_of_nonneg hg
    (fun p => by unfold primeMajorant; positivity) (fun k => by positivity)

theorem powerTerm_norm_summable {s : ℂ} (hs : 1/2 < s.re) :
    Summable (fun i : Nat.Primes × ℕ => ‖powerTerm i.1 i.2 s‖) := by
  exact (majorant_summable hs).of_nonneg_of_le (fun _ => norm_nonneg _)
    (fun i => norm_powerTerm_le (by linarith) i.1 i.2 le_rfl)

theorem powerTerm_differentiable (p : Nat.Primes) (k : ℕ) :
    Differentiable ℂ (powerTerm p k) := by
  have hp : (p : ℂ) ≠ 0 := by exact_mod_cast p.property.ne_zero
  have hq : Differentiable ℂ (primeRatio p) :=
    differentiable_id.neg.const_cpow (Or.inl hp)
  exact (hq.pow (k+2)).const_mul _

noncomputable def expanded (s : ℂ) : ℂ :=
  ∑' i : Nat.Primes × ℕ, powerTerm i.1 i.2 s

/-- A single summable majorant controls all powers on the entire indicated
closed half-plane, hence also every compact subset of its interior. -/
theorem uniform_majorant {σ : ℝ} (hσ : 1/2 < σ) :
    Summable (majorant σ) ∧
    ∀ (i : Nat.Primes × ℕ) (s : ℂ), σ ≤ s.re →
      ‖powerTerm i.1 i.2 s‖ ≤ majorant σ i :=
  ⟨majorant_summable hσ, fun i s hs =>
    norm_powerTerm_le (by linarith) i.1 i.2 hs⟩

theorem expanded_differentiableOn {σ : ℝ} (hσ : 1/2 < σ) :
    DifferentiableOn ℂ expanded {s : ℂ | σ < s.re} := by
  apply differentiableOn_tsum_of_summable_norm (majorant_summable hσ)
  · intro i
    exact (powerTerm_differentiable i.1 i.2).differentiableOn
  · exact isOpen_lt continuous_const continuous_re
  · intro i s hs
    exact norm_powerTerm_le (by linarith) i.1 i.2 hs.le

theorem powerTerm_eq_cpow (p : Nat.Primes) (k : ℕ) (s : ℂ) :
    powerTerm p k s =
      (Real.log (p : ℕ) : ℂ)^2 * (k+1) *
        (p : ℂ)^(-((k+2 : ℕ) : ℂ) * s) := by
  rw [show -((k+2 : ℕ) : ℂ) * s = ((k+2 : ℕ) : ℂ) * (-s) by ring,
    Complex.cpow_nat_mul]
  rfl

noncomputable def samePrimeTerm (p : Nat.Primes) (s : ℂ) : ℂ :=
  (Real.log (p : ℕ) : ℂ)^2 * primeRatio p s ^ 2 / (1-primeRatio p s)^2

theorem samePrimeTerm_eq_cpow (p : Nat.Primes) (s : ℂ) :
    samePrimeTerm p s =
      (Real.log (p : ℕ) : ℂ)^2 * (p : ℂ)^(-2*s) /
        (1-(p : ℂ)^(-s))^2 := by
  have hc := Complex.cpow_nat_mul (p : ℂ) 2 (-s)
  norm_num only [Nat.cast_ofNat] at hc
  rw [show (-2 : ℂ)*s = (2 : ℂ)*(-s) by ring, hc]
  rfl

/-- Every exponent k+2 is retained, with its exact multiplicity k+1. -/
theorem powerTerm_hasSum (p : Nat.Primes) {s : ℂ} (hs : 0 < s.re) :
    HasSum (fun k => powerTerm p k s) (samePrimeTerm p s) := by
  have hq : ‖primeRatio p s‖ < 1 :=
    (norm_primeRatio_le p le_rfl).trans_lt
      ((prime_rpow_le_two hs.le p).trans_lt (two_rpow_lt_one hs))
  have h := (hasSum_choose_mul_geometric_of_norm_lt_one
    (𝕜 := ℂ) 1 hq).mul_left
      ((Real.log (p : ℕ) : ℂ)^2 * primeRatio p s ^ 2)
  convert h using 1
  · funext k
    simp only [Nat.choose_one_right, Nat.cast_add, Nat.cast_one, powerTerm, pow_add]
    ring
  · unfold samePrimeTerm
    ring

noncomputable def H (s : ℂ) : ℂ := ∑' p : Nat.Primes, samePrimeTerm p s

theorem H_eq_prime_sum (s : ℂ) :
    H s = ∑' p : Nat.Primes,
      (Real.log (p : ℕ) : ℂ)^2 * (p : ℂ)^(-2*s) /
        (1-(p : ℂ)^(-s))^2 :=
  tsum_congr (fun p => samePrimeTerm_eq_cpow p s)

theorem samePrimeTerm_norm_summable {s : ℂ} (hs : 1/2 < s.re) :
    Summable (fun p : Nat.Primes => ‖samePrimeTerm p s‖) := by
  have h := powerTerm_norm_summable hs
  apply h.prod.of_nonneg_of_le (fun _ => norm_nonneg _)
  intro p
  rw [← (powerTerm_hasSum p (by linarith : 0 < s.re)).tsum_eq]
  exact norm_tsum_le_tsum_norm (h.prod_factor p)

theorem expanded_eq_H {s : ℂ} (hs : 1/2 < s.re) : expanded s = H s := by
  have hj := (powerTerm_norm_summable hs).of_norm
  rw [expanded, hj.tsum_prod]
  exact tsum_congr (fun p => (powerTerm_hasSum p (by linarith)).tsum_eq)

theorem expanded_uniformConvergence {σ : ℝ} (hσ : 1/2 < σ) :
    TendstoUniformlyOn
      (fun t : Finset (Nat.Primes × ℕ) => fun s : ℂ =>
        ∑ i ∈ t, powerTerm i.1 i.2 s)
      expanded Filter.atTop {s : ℂ | σ ≤ s.re} := by
  exact tendstoUniformlyOn_tsum (majorant_summable hσ)
    (fun i s hs => norm_powerTerm_le (by linarith) i.1 i.2 hs)

theorem H_differentiableOn_right {σ : ℝ} (hσ : 1/2 < σ) :
    DifferentiableOn ℂ H {s : ℂ | σ < s.re} := by
  apply (expanded_differentiableOn hσ).congr
  intro s hs
  exact (expanded_eq_H (hσ.trans hs)).symm

/-- The actual same-prime Euler series is holomorphic on Re s > 1/2. -/
theorem H_differentiableOn :
    DifferentiableOn ℂ H {s : ℂ | 1/2 < s.re} := by
  intro s hs
  change 1/2 < s.re at hs
  let σ : ℝ := (1/2 + s.re)/2
  have hσ : 1/2 < σ := by dsimp [σ]; linarith
  have hxs : σ < s.re := by dsimp [σ]; linarith
  exact ((H_differentiableOn_right hσ).differentiableAt
    ((isOpen_lt continuous_const continuous_re).mem_nhds hxs)).differentiableWithinAt

theorem H_analyticAt {s : ℂ} (hs : 1/2 < s.re) : AnalyticAt ℂ H s :=
  H_differentiableOn.analyticAt
    ((isOpen_lt continuous_const continuous_re).mem_nhds hs)

end BuildingBlocks.SamePrimeDirichlet
