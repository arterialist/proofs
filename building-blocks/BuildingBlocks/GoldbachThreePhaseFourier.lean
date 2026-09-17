import BuildingBlocks.GoldbachThreePhaseEndpoint
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

/-!
# Fourier extraction for the even Goldbach three-generator phase

This module identifies the actual finite angular integral of the
parity-centered even Goldbach triangle with its algebraic first harmonic.
No limiting prime estimate is used.
-/

namespace BuildingBlocks.GoldbachThreePhaseFourier

open Real Finset intervalIntegral MeasureTheory
open scoped ComplexConjugate
open BuildingBlocks.GoldbachPrimePhaseCutFinite
open BuildingBlocks.GoldbachEvenPhaseCenterFinite
open BuildingBlocks.GoldbachThreePhaseHarmonicFinite
open BuildingBlocks.GoldbachThreePhaseEndpoint

private instance : Fact (Nat.Prime 3) := ⟨by norm_num⟩

private theorem complex_centered_pair_re (a b r s t u : ℝ) :
    (((a : ℂ) * ((Real.cos t : ℂ) + (Real.sin t : ℂ) * Complex.I) - (r : ℂ)) *
      ((b : ℂ) * conj ((Real.cos u : ℂ) + (Real.sin u : ℂ) * Complex.I) -
        (s : ℂ))).re =
      a * b * cos (t - u) - a * s * cos t - r * b * cos u + r * s := by
  simp [Complex.mul_re, Complex.sub_re, Complex.sub_im,
    Complex.add_re, Complex.add_im, Complex.conj_re, Complex.conj_im,
    Real.cos_sub]
  simp only [← Complex.ofReal_cos, ← Complex.ofReal_sin, Complex.ofReal_re]
  ring

noncomputable def threeComplexPhase (n : ℕ) (θ : ℝ) : ℂ :=
  (Real.cos ((padicValNat 3 n : ℝ) * θ) : ℂ) +
    (Real.sin ((padicValNat 3 n : ℝ) * θ) : ℂ) * Complex.I

theorem threeComplexPhase_eq_exp (n : ℕ) (θ : ℝ) :
    threeComplexPhase n θ =
      Complex.exp (((padicValNat 3 n : ℝ) * θ : ℂ) * Complex.I) := by
  unfold threeComplexPhase
  rw [Complex.exp_mul_I]
  simp only [← Complex.ofReal_mul, ← Complex.ofReal_cos, ← Complex.ofReal_sin]

theorem threeComplexPhase_three_pow (j : ℕ) (θ : ℝ) :
    threeComplexPhase (3 ^ j) θ =
      Complex.exp (((j : ℝ) * θ : ℂ) * Complex.I) := by
  rw [threeComplexPhase_eq_exp, padicValNat.prime_pow]

theorem threeComplexPhase_other_prime {p : ℕ}
    (hp : p.Prime) (hp3 : p ≠ 3) (θ : ℝ) :
    threeComplexPhase p θ = 1 := by
  letI : Fact p.Prime := ⟨hp⟩
  have hv : padicValNat 3 p = 0 := padicValNat_primes hp3.symm
  simp [threeComplexPhase, hv]

theorem threeComplexPhase_mul {m n : ℕ}
    (hm : m ≠ 0) (hn : n ≠ 0) (θ : ℝ) :
    threeComplexPhase (m * n) θ =
      threeComplexPhase m θ * threeComplexPhase n θ := by
  rw [threeComplexPhase_eq_exp, threeComplexPhase_eq_exp,
    threeComplexPhase_eq_exp, padicValNat.mul hm hn, ← Complex.exp_add]
  congr 1
  push_cast
  ring

private theorem re_finset_sum {α : Type*} (s : Finset α) (f : α → ℂ) :
    (∑ x ∈ s, f x).re = ∑ x ∈ s, (f x).re := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert x s hx ih => simp [hx, Complex.add_re, ih]

private theorem evenPairDomain_swap {N a b : ℕ} :
    (a, b) ∈ evenPairDomain N ↔ (b, a) ∈ evenPairDomain N := by
  simp [evenPairDomain, pairDomain, and_comm, add_comm]

private theorem sum_evenPair_swap (N : ℕ) (f : ℕ → ℕ → ℂ) :
    (∑ q ∈ evenPairDomain N, f q.2 q.1) =
      ∑ q ∈ evenPairDomain N, f q.1 q.2 := by
  apply Finset.sum_bij (fun q _ => (q.2, q.1))
  · intro q hq
    exact evenPairDomain_swap.mp hq
  · intro q₁ h₁ q₂ h₂ h
    simpa [Prod.swap] using congrArg Prod.swap h
  · intro q hq
    exact ⟨(q.2, q.1), evenPairDomain_swap.mpr hq, by cases q; rfl⟩
  · intro q hq
    rfl

private theorem hermitian_triangle_real (N : ℕ) (z : ℕ → ℂ) :
    conj (∑ q ∈ evenPairDomain N, z q.1 * conj (z q.2)) =
      ∑ q ∈ evenPairDomain N, z q.1 * conj (z q.2) := by
  calc
    conj (∑ q ∈ evenPairDomain N, z q.1 * conj (z q.2)) =
        ∑ q ∈ evenPairDomain N, z q.2 * conj (z q.1) := by
      simp [map_sum, map_mul, mul_comm]
    _ = _ := sum_evenPair_swap N (fun a b => z a * conj (z b))

noncomputable def complexCenteredGoldbach (N : ℕ) (θ : ℝ) : ℂ :=
  ∑ q ∈ evenPairDomain N,
    (((weight q.1 : ℂ) * threeComplexPhase q.1 θ -
        (oddReference q.1 : ℂ)) *
      ((weight q.2 : ℂ) * conj (threeComplexPhase q.2 θ) -
        (oddReference q.2 : ℂ)))

private noncomputable def centeredComplexAmplitude (n : ℕ) (θ : ℝ) : ℂ :=
  (weight n : ℂ) * threeComplexPhase n θ - (oddReference n : ℂ)

private theorem complexCenteredGoldbach_eq_hermitian (N : ℕ) (θ : ℝ) :
    complexCenteredGoldbach N θ =
      ∑ q ∈ evenPairDomain N,
        centeredComplexAmplitude q.1 θ *
          conj (centeredComplexAmplitude q.2 θ) := by
  unfold complexCenteredGoldbach
  apply Finset.sum_congr rfl
  intro q _
  simp [centeredComplexAmplitude, map_sub, map_mul]

theorem complexCenteredGoldbach_im_zero (N : ℕ) (θ : ℝ) :
    (complexCenteredGoldbach N θ).im = 0 := by
  rw [complexCenteredGoldbach_eq_hermitian]
  exact Complex.conj_eq_iff_im.mp
    (hermitian_triangle_real N (fun n => centeredComplexAmplitude n θ))

theorem complexCenteredGoldbach_re (N : ℕ) (θ : ℝ) :
    (complexCenteredGoldbach N θ).re =
      evenCenteredGoldbach N (fun n => (padicValNat 3 n : ℝ) * θ) := by
  unfold complexCenteredGoldbach evenCenteredGoldbach
  rw [re_finset_sum]
  apply Finset.sum_congr rfl
  intro q hq
  simpa [threeComplexPhase] using
    complex_centered_pair_re (weight q.1) (weight q.2)
      (oddReference q.1) (oddReference q.2)
      ((padicValNat 3 q.1 : ℝ) * θ) ((padicValNat 3 q.2 : ℝ) * θ)

theorem complexCenteredGoldbach_eq_real (N : ℕ) (θ : ℝ) :
    complexCenteredGoldbach N θ =
      (evenCenteredGoldbach N
        (fun n => (padicValNat 3 n : ℝ) * θ) : ℂ) := by
  apply Complex.ext
  · simpa using complexCenteredGoldbach_re N θ
  · simp [complexCenteredGoldbach_im_zero N θ]

noncomputable def complexAngularHarmonic (N : ℕ) : ℝ :=
  (∫ θ in (0 : ℝ)..2 * π,
    (complexCenteredGoldbach N θ).re * cos θ) / π

private theorem integral_cos_integer_frequency (k : ℤ) :
    (∫ θ in (0 : ℝ)..2 * π, cos ((k : ℝ) * θ)) =
      if k = 0 then 2 * π else 0 := by
  by_cases hk : k = 0
  · subst k
    simp
  · have hkreal : (k : ℝ) ≠ 0 := by exact_mod_cast hk
    have hsin : sin ((k : ℝ) * (2 * π)) = 0 := by
      convert Real.sin_int_mul_pi (2 * k) using 1
      push_cast
      ring_nf
    rw [intervalIntegral.integral_comp_mul_left (f := cos) hkreal]
    simp [integral_cos, hsin, hk]

private theorem cosine_product (x y : ℝ) :
    cos x * cos y = (cos (x + y) + cos (x - y)) / 2 := by
  rw [cos_add, cos_sub]
  ring

private theorem integral_cosine_first_frequency (k : ℤ) :
    (∫ θ in (0 : ℝ)..2 * π, cos ((k : ℝ) * θ) * cos θ) =
      if k = 1 ∨ k = -1 then π else 0 := by
  have hpoint (θ : ℝ) :
      cos ((k : ℝ) * θ) * cos θ =
        (cos (((k + 1 : ℤ) : ℝ) * θ) +
          cos (((k - 1 : ℤ) : ℝ) * θ)) / 2 := by
    have hp : ((k + 1 : ℤ) : ℝ) * θ = (k : ℝ) * θ + θ := by
      push_cast
      ring
    have hm : ((k - 1 : ℤ) : ℝ) * θ = (k : ℝ) * θ - θ := by
      push_cast
      ring
    rw [hp, hm, cosine_product]
  have hint (j : ℤ) :
      IntervalIntegrable (fun θ : ℝ => cos ((j : ℝ) * θ)) volume 0 (2 * π) := by
    have hc : Continuous (fun θ : ℝ => cos ((j : ℝ) * θ)) := by fun_prop
    exact hc.intervalIntegrable _ _
  simp_rw [hpoint]
  rw [intervalIntegral.integral_div,
    intervalIntegral.integral_add (hint (k + 1)) (hint (k - 1)),
    integral_cos_integer_frequency, integral_cos_integer_frequency]
  have hp : k + 1 = 0 ↔ k = -1 := by omega
  have hm : k - 1 = 0 ↔ k = 1 := by omega
  simp only [hp, hm]
  by_cases hk1 : k = 1
  · have hkm : k ≠ -1 := by omega
    simp [hk1]
  · by_cases hkm : k = -1
    · simp [hkm]
    · simp [hk1, hkm]

private theorem pair_cosine_first_frequency (m n : ℕ) :
    (∫ θ in (0 : ℝ)..2 * π,
        cos ((m : ℝ) * θ - (n : ℝ) * θ) * cos θ) =
      if m = n + 1 ∨ n = m + 1 then π else 0 := by
  have harg (θ : ℝ) :
      (((m : ℤ) - (n : ℤ) : ℤ) : ℝ) * θ =
        (m : ℝ) * θ - (n : ℝ) * θ := by
    push_cast
    ring
  simp_rw [← harg]
  rw [integral_cosine_first_frequency]
  have hiff : ((m : ℤ) - (n : ℤ) = 1 ∨ (m : ℤ) - (n : ℤ) = -1) ↔
      m = n + 1 ∨ n = m + 1 := by omega
  simp only [hiff]

private theorem single_cosine_first_frequency (m : ℕ) :
    (∫ θ in (0 : ℝ)..2 * π, cos ((m : ℝ) * θ) * cos θ) =
      if m = 1 then π else 0 := by
  have h := integral_cosine_first_frequency (m : ℤ)
  have hneg : (m : ℤ) ≠ -1 := by omega
  simpa [hneg] using h

private theorem constant_first_frequency (c : ℝ) :
    (∫ θ in (0 : ℝ)..2 * π, c * cos θ) = 0 := by
  rw [intervalIntegral.integral_const_mul]
  simp [integral_cos, sin_two_pi]

private theorem pair_projection (A B C D : ℝ) (m n : ℕ) :
    (∫ θ in (0 : ℝ)..2 * π,
      (A * cos ((m : ℝ) * θ - (n : ℝ) * θ) -
          B * cos ((m : ℝ) * θ) -
          C * cos ((n : ℝ) * θ) + D) * cos θ) =
      A * (if m = n + 1 ∨ n = m + 1 then π else 0) -
        B * (if m = 1 then π else 0) -
        C * (if n = 1 then π else 0) := by
  have hpair : IntervalIntegrable
      (fun θ : ℝ => cos ((m : ℝ) * θ - (n : ℝ) * θ) * cos θ)
      volume 0 (2 * π) := by
    have hc : Continuous (fun θ : ℝ =>
        cos ((m : ℝ) * θ - (n : ℝ) * θ) * cos θ) := by fun_prop
    exact hc.intervalIntegrable _ _
  have hm : IntervalIntegrable
      (fun θ : ℝ => cos ((m : ℝ) * θ) * cos θ)
      volume 0 (2 * π) := by
    have hc : Continuous (fun θ : ℝ => cos ((m : ℝ) * θ) * cos θ) := by fun_prop
    exact hc.intervalIntegrable _ _
  have hn : IntervalIntegrable
      (fun θ : ℝ => cos ((n : ℝ) * θ) * cos θ)
      volume 0 (2 * π) := by
    have hc : Continuous (fun θ : ℝ => cos ((n : ℝ) * θ) * cos θ) := by fun_prop
    exact hc.intervalIntegrable _ _
  have hcos : IntervalIntegrable (fun θ : ℝ => cos θ) volume 0 (2 * π) :=
    continuous_cos.intervalIntegrable _ _
  have hpoint (θ : ℝ) :
      (A * cos ((m : ℝ) * θ - (n : ℝ) * θ) -
          B * cos ((m : ℝ) * θ) -
          C * cos ((n : ℝ) * θ) + D) * cos θ =
        A * (cos ((m : ℝ) * θ - (n : ℝ) * θ) * cos θ) -
          B * (cos ((m : ℝ) * θ) * cos θ) -
          C * (cos ((n : ℝ) * θ) * cos θ) + D * cos θ := by ring
  simp_rw [hpoint]
  rw [intervalIntegral.integral_add
    (((hpair.const_mul A).sub (hm.const_mul B)).sub (hn.const_mul C))
    (hcos.const_mul D),
    intervalIntegral.integral_sub
      ((hpair.const_mul A).sub (hm.const_mul B)) (hn.const_mul C),
    intervalIntegral.integral_sub (hpair.const_mul A) (hm.const_mul B)]
  simp [pair_cosine_first_frequency, single_cosine_first_frequency]

private theorem indicator_scale {P : Prop} [Decidable P] (A : ℝ) :
    A * (if P then π else 0) = π * (A * if P then 1 else 0) := by
  by_cases h : P
  · simp [h, mul_comm]
  · simp [h]

private theorem neighbor_indicator_scale (m n : ℕ) (A : ℝ) :
    A * (if m = n + 1 ∨ n = m + 1 then π else 0) =
      π * (A * ((if m = n + 1 then 1 else 0) +
        (if n = m + 1 then 1 else 0))) := by
  by_cases hmn : m = n + 1
  · have hnm : n ≠ m + 1 := by omega
    rw [if_pos (Or.inl hmn), if_pos hmn, if_neg hnm]
    ring
  · by_cases hnm : n = m + 1
    · rw [if_pos (Or.inr hnm), if_neg hmn, if_pos hnm]
      ring
    · have hno : ¬(m = n + 1 ∨ n = m + 1) := by tauto
      rw [if_neg hno, if_neg hmn, if_neg hnm]
      ring

noncomputable def threeAngularHarmonic (N : ℕ) : ℝ :=
  (∫ θ in (0 : ℝ)..2 * π,
      evenCenteredGoldbach N
        (fun n => (padicValNat 3 n : ℝ) * θ) * cos θ) / π

theorem complexAngularHarmonic_eq_real_angular (N : ℕ) :
    complexAngularHarmonic N = threeAngularHarmonic N := by
  unfold complexAngularHarmonic threeAngularHarmonic
  simp_rw [complexCenteredGoldbach_re]

/-- For every finite cutoff, angular projection of the actual
parity-centered even Goldbach triangle is its algebraic three-adic
first harmonic. -/
theorem threeAngularHarmonic_eq (N : ℕ) :
    threeAngularHarmonic N = threeFirstHarmonic N := by
  have hint (q : ℕ × ℕ) : IntervalIntegrable
      (fun θ : ℝ =>
        (weight q.1 * weight q.2 *
            cos ((padicValNat 3 q.1 : ℝ) * θ -
              (padicValNat 3 q.2 : ℝ) * θ) -
          weight q.1 * oddReference q.2 *
            cos ((padicValNat 3 q.1 : ℝ) * θ) -
          oddReference q.1 * weight q.2 *
            cos ((padicValNat 3 q.2 : ℝ) * θ) +
          oddReference q.1 * oddReference q.2) * cos θ)
      volume 0 (2 * π) := by
    have hc : Continuous (fun θ : ℝ =>
        (weight q.1 * weight q.2 *
            cos ((padicValNat 3 q.1 : ℝ) * θ -
              (padicValNat 3 q.2 : ℝ) * θ) -
          weight q.1 * oddReference q.2 *
            cos ((padicValNat 3 q.1 : ℝ) * θ) -
          oddReference q.1 * weight q.2 *
            cos ((padicValNat 3 q.2 : ℝ) * θ) +
          oddReference q.1 * oddReference q.2) * cos θ) := by fun_prop
    exact hc.intervalIntegrable _ _
  unfold threeAngularHarmonic evenCenteredGoldbach
  simp_rw [Finset.sum_mul]
  rw [intervalIntegral.integral_finset_sum (fun q _ => hint q)]
  unfold threeFirstHarmonic
  rw [Finset.sum_div]
  apply Finset.sum_congr rfl
  intro q hq
  apply (div_eq_iff (ne_of_gt Real.pi_pos)).2
  have h := pair_projection
    (weight q.1 * weight q.2)
    (weight q.1 * oddReference q.2)
    (oddReference q.1 * weight q.2)
    (oddReference q.1 * oddReference q.2)
    (padicValNat 3 q.1) (padicValNat 3 q.2)
  rw [h]
  rw [neighbor_indicator_scale,
    indicator_scale (P := padicValNat 3 q.1 = 1),
    indicator_scale (P := padicValNat 3 q.2 = 1)]
  ring

/-- The literal finite angular integral reconstructs the actual
complete-von-Mangoldt prime error on every odd cutoff. -/
theorem threeAngularHarmonic_prime_error (k : ℕ) :
    threeAngularHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) -
          Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ)) := by
  rw [threeAngularHarmonic_eq, three_first_harmonic_prime_error]

/-- The Fourier coefficient of the original complex, completely
multiplicative three-generator phase equals the actual prime error
with every prime power and parity endpoint retained. -/
theorem complexAngularHarmonic_prime_error (k : ℕ) :
    complexAngularHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) -
          Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ)) := by
  rw [complexAngularHarmonic_eq_real_angular,
    threeAngularHarmonic_prime_error]

theorem actual_prime_error_from_angular_harmonic (k : ℕ) :
    BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) =
      threeAngularHarmonic (2 * k + 6) / (2 * Real.log 3) +
        Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) + 1 +
          Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ) := by
  have hlog : Real.log 3 ≠ 0 :=
    (Real.log_pos (by norm_num : (1 : ℝ) < 3)).ne'
  rw [threeAngularHarmonic_prime_error]
  field_simp [hlog]
  ring

/-- The inverse identity stated directly for the original complex
phase integral. -/
theorem actual_prime_error_from_complex_angular_harmonic (k : ℕ) :
    BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) =
      complexAngularHarmonic (2 * k + 6) / (2 * Real.log 3) +
        Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) + 1 +
          Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ) := by
  rw [complexAngularHarmonic_eq_real_angular]
  exact actual_prime_error_from_angular_harmonic k

#print axioms threeAngularHarmonic_eq
#print axioms threeAngularHarmonic_prime_error
#print axioms threeComplexPhase_mul
#print axioms complexCenteredGoldbach_eq_real
#print axioms complexAngularHarmonic_prime_error
#print axioms actual_prime_error_from_angular_harmonic
#print axioms actual_prime_error_from_complex_angular_harmonic

end BuildingBlocks.GoldbachThreePhaseFourier
