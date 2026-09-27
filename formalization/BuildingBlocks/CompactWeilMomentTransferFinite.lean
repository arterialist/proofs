import BuildingBlocks.CompactWeilDivisorEnergyFinite
import Mathlib.Tactic

open scoped BigOperators

namespace BuildingBlocks.CompactWeilMomentTransferFinite

noncomputable section

private abbrev Λ (d : ℕ) : ℝ := ArithmeticFunction.vonMangoldt d

def psi (x : ℕ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 x, Λ d

def W (N : ℕ) (g : ℕ → ℂ) : ℝ :=
  BuildingBlocks.CompactWeilDivisorEnergyFinite.complexVertexNorm N g

def E (N : ℕ) (g : ℕ → ℂ) : ℝ :=
  BuildingBlocks.CompactWeilDivisorEnergyFinite.complexHistoryEnergy N g

def Z (N : ℕ) (g : ℕ → ℂ) : ℝ :=
  Real.log (N : ℝ) / (N : ℝ) *
    ∑ m ∈ Finset.Icc 1 N, Complex.normSq (g m)

def logMoment (N : ℕ) (g : ℕ → ℂ) : ℝ :=
  (∑ m ∈ Finset.Icc 1 N,
    Real.log (m : ℝ) * Complex.normSq (g m)) / (N : ℝ)

def missingMoment (N : ℕ) (g : ℕ → ℂ) : ℝ :=
  ∑ m ∈ Finset.Icc 1 N,
    ((Real.log (N : ℝ) - Real.log (m : ℝ)) / (N : ℝ)) *
      Complex.normSq (g m)

private theorem normSq_le_two (u v : ℂ) :
    Complex.normSq u ≤
      2 * Complex.normSq (u - v) + 2 * Complex.normSq v := by
  simp only [Complex.normSq_apply, Complex.sub_re, Complex.sub_im]
  nlinarith [sq_nonneg (u.re - 2 * v.re),
    sq_nonneg (u.im - 2 * v.im)]

private theorem incoming_unweighted (N : ℕ) (g : ℕ → ℂ) :
    (∑ d ∈ Finset.Icc 1 N,
      ∑ n ∈ Finset.Icc 1 (N / d),
        Λ d * Complex.normSq (g (n * d))) =
      ∑ m ∈ Finset.Icc 1 N,
        Real.log (m : ℝ) * Complex.normSq (g m) := by
  rw [← BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
    (fun d n => Λ d * Complex.normSq (g (n * d)))]
  apply Finset.sum_congr rfl
  intro m hm
  calc
    (∑ d ∈ m.divisors, Λ d * Complex.normSq (g ((m / d) * d))) =
      (∑ d ∈ m.divisors, Λ d) * Complex.normSq (g m) := by
        rw [Finset.sum_mul]
        apply Finset.sum_congr rfl
        intro d hd
        rw [Nat.div_mul_cancel (Nat.mem_divisors.mp hd).1]
    _ = Real.log (m : ℝ) * Complex.normSq (g m) := by
        rw [ArithmeticFunction.vonMangoldt_sum]

private theorem hyperbola_swap {R : Type*} [AddCommMonoid R]
    (N : ℕ) (f : ℕ → ℕ → R) :
    (∑ d ∈ Finset.Icc 1 N,
      ∑ n ∈ Finset.Icc 1 (N / d), f n d) =
      ∑ n ∈ Finset.Icc 1 N,
        ∑ d ∈ Finset.Icc 1 (N / n), f n d := by
  classical
  rw [Finset.sum_sigma', Finset.sum_sigma']
  apply Finset.sum_bij (fun x _ => ⟨x.2, x.1⟩)
  · intro x hx
    obtain ⟨hd, hn⟩ := Finset.mem_sigma.mp hx
    obtain ⟨hd1, hdN⟩ := Finset.mem_Icc.mp hd
    obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
    have hprod : x.2 * x.1 ≤ N :=
      (Nat.le_div_iff_mul_le hd1).mp hnN
    have hnle : x.2 ≤ x.2 * x.1 := by
      calc
        x.2 = x.2 * 1 := by omega
        _ ≤ x.2 * x.1 := Nat.mul_le_mul_left _ hd1
    exact Finset.mem_sigma.mpr
      ⟨Finset.mem_Icc.mpr ⟨hn1, hnle.trans hprod⟩,
        Finset.mem_Icc.mpr ⟨hd1,
          (Nat.le_div_iff_mul_le hn1).mpr (by simpa [mul_comm] using hprod)⟩⟩
  · intro x hx y hy hxy
    have hfirst : x.2 = y.2 := congrArg Sigma.fst hxy
    have hsecond : x.1 = y.1 := by
      simpa using congrArg (fun z : Σ _ : ℕ, ℕ => z.2) hxy
    cases x
    cases y
    simp_all
  · intro y hy
    refine ⟨⟨y.2, y.1⟩, ?_, ?_⟩
    · obtain ⟨hn, hd⟩ := Finset.mem_sigma.mp hy
      obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
      obtain ⟨hd1, hdN⟩ := Finset.mem_Icc.mp hd
      have hprod : y.2 * y.1 ≤ N :=
        (Nat.le_div_iff_mul_le hn1).mp hdN
      have hdle : y.2 ≤ y.2 * y.1 := by
        calc
          y.2 = y.2 * 1 := by omega
          _ ≤ y.2 * y.1 := Nat.mul_le_mul_left _ hn1
      exact Finset.mem_sigma.mpr
        ⟨Finset.mem_Icc.mpr ⟨hd1, hdle.trans hprod⟩,
          Finset.mem_Icc.mpr ⟨hn1,
            (Nat.le_div_iff_mul_le hd1).mpr (by simpa [mul_comm] using hprod)⟩⟩
    · rfl
  · intro x hx
    rfl

private theorem incoming_edge_bound
    {N n d : ℕ} (hN : 0 < N) (hn : 0 < n) (hd : 0 < d)
    (hnd : n * d ≤ N) (g : ℕ → ℂ) :
    Λ d / (N : ℝ) * Complex.normSq (g (n * d)) ≤
      2 * (Λ d / ((n : ℝ) * (d : ℝ))) *
        Complex.normSq (g n - g (n * d)) +
      2 * (Λ d / (N : ℝ)) * Complex.normSq (g n) := by
  have hNpos : 0 < (N : ℝ) := by exact_mod_cast hN
  have hnpos : 0 < (n : ℝ) := by exact_mod_cast hn
  have hdpos : 0 < (d : ℝ) := by exact_mod_cast hd
  have hden : 0 < (n : ℝ) * (d : ℝ) := mul_pos hnpos hdpos
  have hdenle : (n : ℝ) * (d : ℝ) ≤ (N : ℝ) := by
    exact_mod_cast hnd
  have hLambda : 0 ≤ Λ d := ArithmeticFunction.vonMangoldt_nonneg
  have hfrac : Λ d / (N : ℝ) ≤ Λ d / ((n : ℝ) * (d : ℝ)) :=
    div_le_div_of_nonneg_left hLambda hden hdenle
  have hsq : 0 ≤ Complex.normSq (g n - g (n * d)) :=
    Complex.normSq_nonneg _
  have hfracSq := mul_le_mul_of_nonneg_right hfrac hsq
  have hsmall : 0 ≤ Λ d / (N : ℝ) := div_nonneg hLambda (le_of_lt hNpos)
  have hnorm := mul_le_mul_of_nonneg_left
    (normSq_le_two (g (n * d)) (g n)) hsmall
  have hsym :
      Complex.normSq (g (n * d) - g n) =
        Complex.normSq (g n - g (n * d)) := by
    simp only [Complex.normSq_apply, Complex.sub_re, Complex.sub_im]
    ring
  rw [hsym] at hnorm
  nlinarith

private theorem psi_div_bound
    {N n : ℕ} (hN : 0 < N) (hn : n ∈ Finset.Icc 1 N)
    {C : ℝ} (hC : 0 ≤ C)
    (hpsi : ∀ x : ℕ, 1 ≤ x → psi x ≤ C * (x : ℝ)) :
    psi (N / n) / (N : ℝ) ≤ C / (n : ℝ) := by
  obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
  have hnposNat : 0 < n := hn1
  have hqposNat : 0 < N / n := Nat.div_pos hnN hnposNat
  have hNpos : 0 < (N : ℝ) := by exact_mod_cast hN
  have hnpos : 0 < (n : ℝ) := by exact_mod_cast hnposNat
  have hq : psi (N / n) ≤ C * ((N / n : ℕ) : ℝ) :=
    hpsi (N / n) hqposNat
  have hprod : ((N / n : ℕ) : ℝ) * (n : ℝ) ≤ (N : ℝ) := by
    exact_mod_cast Nat.div_mul_le_self N n
  have h1 := mul_le_mul_of_nonneg_right hq (le_of_lt hnpos)
  have h2 := mul_le_mul_of_nonneg_left hprod hC
  apply (div_le_div_iff₀ hNpos hnpos).2
  nlinarith

private theorem outgoing_bound
    {N : ℕ} (hN : 0 < N) (g : ℕ → ℂ)
    {C : ℝ} (hC : 0 ≤ C)
    (hpsi : ∀ x : ℕ, 1 ≤ x → psi x ≤ C * (x : ℝ)) :
    (∑ d ∈ Finset.Icc 1 N,
      ∑ n ∈ Finset.Icc 1 (N / d),
        Λ d / (N : ℝ) * Complex.normSq (g n)) ≤ C * W N g := by
  rw [hyperbola_swap]
  have hrewrite :
      (∑ n ∈ Finset.Icc 1 N,
        ∑ d ∈ Finset.Icc 1 (N / n),
          Λ d / (N : ℝ) * Complex.normSq (g n)) =
      ∑ n ∈ Finset.Icc 1 N,
        (psi (N / n) / (N : ℝ)) * Complex.normSq (g n) := by
    apply Finset.sum_congr rfl
    intro n hn
    unfold psi
    rw [Finset.sum_div]
    rw [Finset.sum_mul]
  rw [hrewrite]
  calc
    (∑ n ∈ Finset.Icc 1 N,
      psi (N / n) / (N : ℝ) * Complex.normSq (g n)) ≤
      ∑ n ∈ Finset.Icc 1 N,
        C / (n : ℝ) * Complex.normSq (g n) := by
          apply Finset.sum_le_sum
          intro n hn
          exact mul_le_mul_of_nonneg_right
            (psi_div_bound hN hn hC hpsi) (Complex.normSq_nonneg _)
    _ = C * W N g := by
      unfold W BuildingBlocks.CompactWeilDivisorEnergyFinite.complexVertexNorm
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro n hn
      ring

private theorem logMoment_eq_incoming (N : ℕ) (g : ℕ → ℂ) :
    logMoment N g =
      ∑ d ∈ Finset.Icc 1 N,
        ∑ n ∈ Finset.Icc 1 (N / d),
          Λ d / (N : ℝ) * Complex.normSq (g (n * d)) := by
  unfold logMoment
  rw [← incoming_unweighted N g]
  rw [Finset.sum_div]
  apply Finset.sum_congr rfl
  intro d hd
  rw [Finset.sum_div]
  apply Finset.sum_congr rfl
  intro n hn
  ring

private theorem logMoment_le
    {N : ℕ} (hN : 0 < N) (g : ℕ → ℂ)
    {C : ℝ} (hC : 0 ≤ C)
    (hpsi : ∀ x : ℕ, 1 ≤ x → psi x ≤ C * (x : ℝ)) :
    logMoment N g ≤ 2 * E N g + 2 * C * W N g := by
  rw [logMoment_eq_incoming]
  have hedge :
      (∑ d ∈ Finset.Icc 1 N,
        ∑ n ∈ Finset.Icc 1 (N / d),
          Λ d / (N : ℝ) * Complex.normSq (g (n * d))) ≤
      ∑ d ∈ Finset.Icc 1 N,
        ∑ n ∈ Finset.Icc 1 (N / d),
          (2 * (Λ d / ((n : ℝ) * (d : ℝ))) *
            Complex.normSq (g n - g (n * d)) +
           2 * (Λ d / (N : ℝ)) * Complex.normSq (g n)) := by
    apply Finset.sum_le_sum
    intro d hd
    apply Finset.sum_le_sum
    intro n hn
    have hd1 := (Finset.mem_Icc.mp hd).1
    have hn1 := (Finset.mem_Icc.mp hn).1
    have hnd : n * d ≤ N := (Nat.le_div_iff_mul_le hd1).mp
      (Finset.mem_Icc.mp hn).2 |>.trans_eq (by ac_rfl)
    exact incoming_edge_bound hN hn1 hd1 hnd g
  have hsplit :
      (∑ d ∈ Finset.Icc 1 N,
        ∑ n ∈ Finset.Icc 1 (N / d),
          (2 * (Λ d / ((n : ℝ) * (d : ℝ))) *
            Complex.normSq (g n - g (n * d)) +
           2 * (Λ d / (N : ℝ)) * Complex.normSq (g n))) =
      2 * E N g +
      2 * (∑ d ∈ Finset.Icc 1 N,
        ∑ n ∈ Finset.Icc 1 (N / d),
          Λ d / (N : ℝ) * Complex.normSq (g n)) := by
    unfold E BuildingBlocks.CompactWeilDivisorEnergyFinite.complexHistoryEnergy
    have hpoint (n d : ℕ) :
        2 * (Λ d / ((n : ℝ) * (d : ℝ))) *
            Complex.normSq (g n - g (n * d)) +
          2 * (Λ d / (N : ℝ)) * Complex.normSq (g n) =
        2 * ((Λ d / ((n : ℝ) * (d : ℝ))) *
            Complex.normSq (g n - g (n * d))) +
          2 * ((Λ d / (N : ℝ)) * Complex.normSq (g n)) := by ring
    simp_rw [hpoint]
    simp_rw [Finset.sum_add_distrib]
    simp_rw [← Finset.mul_sum]
    rfl
  rw [hsplit] at hedge
  have hout := outgoing_bound hN g hC hpsi
  nlinarith

private theorem log_le_div_exp_one {x : ℝ} (hx : 0 < x) :
    Real.log x ≤ x / Real.exp 1 := by
  have he : 0 < Real.exp 1 := Real.exp_pos _
  have h := Real.log_le_sub_one_of_pos (div_pos hx he)
  rw [Real.log_div hx.ne' he.ne', Real.log_exp] at h
  nlinarith

private theorem missing_log_scalar
    {N n : ℕ} (hN : 0 < N) (hn : n ∈ Finset.Icc 1 N) :
    (Real.log (N : ℝ) - Real.log (n : ℝ)) / (N : ℝ) ≤
      1 / (Real.exp 1 * (n : ℝ)) := by
  have hNpos : 0 < (N : ℝ) := by exact_mod_cast hN
  have hnpos : 0 < (n : ℝ) := by
    exact_mod_cast (Finset.mem_Icc.mp hn).1
  have he : 0 < Real.exp 1 := Real.exp_pos _
  have hlog := log_le_div_exp_one (div_pos hNpos hnpos)
  rw [Real.log_div hNpos.ne' hnpos.ne'] at hlog
  apply (div_le_div_iff₀ hNpos (mul_pos he hnpos)).2
  have hmult := mul_le_mul_of_nonneg_right hlog
    (le_of_lt (mul_pos he hnpos))
  have hright :
      ((N : ℝ) / (n : ℝ) / Real.exp 1) *
        (Real.exp 1 * (n : ℝ)) = (N : ℝ) := by
    field_simp
  nlinarith

private theorem Z_eq_logMoment_add_missing (N : ℕ) (g : ℕ → ℂ) :
    Z N g = logMoment N g + missingMoment N g := by
  unfold Z logMoment missingMoment
  rw [Finset.mul_sum, Finset.sum_div]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  ring

private theorem missingMoment_le
    {N : ℕ} (hN : 0 < N) (g : ℕ → ℂ) :
    missingMoment N g ≤ (1 / Real.exp 1) * W N g := by
  unfold missingMoment W
    BuildingBlocks.CompactWeilDivisorEnergyFinite.complexVertexNorm
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro m hm
  have hscalar := missing_log_scalar hN hm
  have hval := mul_le_mul_of_nonneg_right hscalar
    (Complex.normSq_nonneg (g m))
  convert hval using 1
  ring

/-- The exact finite complex moment transfer. The only analytic input is
the explicitly named Chebyshev estimate for the actual von Mangoldt sum. -/
theorem complex_moment_transfer
    {N : ℕ} (hN : 0 < N) (g : ℕ → ℂ)
    {Cpsi : ℝ} (hCpsi : 0 ≤ Cpsi)
    (chebyshevPsi :
      ∀ x : ℕ, 1 ≤ x → psi x ≤ Cpsi * (x : ℝ)) :
    Z N g ≤
      2 * E N g + (2 * Cpsi + 1 / Real.exp 1) * W N g := by
  rw [Z_eq_logMoment_add_missing]
  have hlog := logMoment_le hN g hCpsi chebyshevPsi
  have hmiss := missingMoment_le hN g
  nlinarith

/-- The two-profile version used by the signed Weil packet construction.
It is slightly stronger than the published setup: no condition on the
coefficient at (1,+) is needed for this finite inequality. -/
theorem complex_two_profile_moment_transfer
    {N : ℕ} (hN : 0 < N) (gminus gplus : ℕ → ℂ)
    {Cpsi : ℝ} (hCpsi : 0 ≤ Cpsi)
    (chebyshevPsi :
      ∀ x : ℕ, 1 ≤ x → psi x ≤ Cpsi * (x : ℝ)) :
    Z N gminus + Z N gplus ≤
      2 * (E N gminus + E N gplus) +
      (2 * Cpsi + 1 / Real.exp 1) *
        (W N gminus + W N gplus) := by
  have hminus := complex_moment_transfer hN gminus hCpsi chebyshevPsi
  have hplus := complex_moment_transfer hN gplus hCpsi chebyshevPsi
  linarith

#print axioms complex_moment_transfer
#print axioms complex_two_profile_moment_transfer

end
end BuildingBlocks.CompactWeilMomentTransferFinite
