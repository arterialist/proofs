import Mathlib.Analysis.Normed.Operator.BanachSteinhaus
import Mathlib.Topology.ContinuousMap.Bounded.Normed
import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Data.Nat.Squarefree
import Mathlib.Data.Real.Sqrt
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Push

/-!
A fixed square-root-bounded sequence with bounded first differences whose
Möbius floor inverse exceeds every eventual bound of a specified power below 2/3.
The construction and mathematical sources are described in
../../building-blocks/prime-distribution/regular-source-mobius-obstruction.md.
-/

open Finset Filter
open scoped BigOperators Topology BoundedContinuousFunction
set_option maxSynthPendingDepth 3

namespace BuildingBlocks.RegularSource

theorem reciprocal_square_sum_Icc_bound (m : ℕ) :
    (∑ k ∈ Finset.Icc 2 m, 1 / (k : ℝ) ^ 2) ≤ 3 / 4 := by
  by_cases hm : 2 ≤ m
  · have hstrong : ∀ n : ℕ, 2 ≤ n →
        (∑ k ∈ Finset.Icc 2 n, 1 / (k : ℝ) ^ 2) ≤ 3 / 4 - 1 / (n : ℝ) := by
      intro n hn
      induction n, hn using Nat.le_induction with
      | base => norm_num
      | succ n hn ih =>
        have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
        have hh : 1 / ((n : ℝ) + 1) ^ 2 ≤ 1 / (n : ℝ) - 1 / ((n : ℝ) + 1) := by
          rw [show 1 / (n : ℝ) - 1 / ((n : ℝ) + 1) =
            1 / ((n : ℝ) * ((n : ℝ) + 1)) by field_simp; ring]
          apply one_div_le_one_div_of_le (by positivity)
          nlinarith
        rw [Finset.sum_Icc_succ_top (by omega : 2 ≤ n + 1)]
        push_cast
        linarith
    have hh := hstrong m hm
    have hp : 0 ≤ 1 / (m : ℝ) := by positivity
    linarith
  · have he : Finset.Icc 2 m = ∅ := Finset.Icc_eq_empty_of_lt (by omega)
    rw [he, Finset.sum_empty]
    norm_num

theorem multiples_Ioc_card (M N q : ℕ) (hq : 0 < q) :
    ((Finset.Ioc M N).filter (fun n => q ∣ n)).card = N / q - M / q := by
  classical
  have hh : ((Finset.Ioc M N).filter (fun n => q ∣ n)).card =
      (Finset.Ioc (M / q) (N / q)).card := by
    apply Finset.card_bij (fun n _ => n / q)
    · intro n hn
      obtain ⟨hn, hqd⟩ := Finset.mem_filter.mp hn
      obtain ⟨hMn, hnN⟩ := Finset.mem_Ioc.mp hn
      apply Finset.mem_Ioc.mpr
      constructor
      · apply (Nat.div_lt_iff_lt_mul hq).mpr
        simpa [Nat.div_mul_cancel hqd] using hMn
      · exact Nat.div_le_div_right hnN
    · intro n hn k hk he
      have hqn := (Finset.mem_filter.mp hn).2
      have hqk := (Finset.mem_filter.mp hk).2
      calc
        n = (n / q) * q := (Nat.div_mul_cancel hqn).symm
        _ = (k / q) * q := by rw [he]
        _ = k := Nat.div_mul_cancel hqk
    · intro k hk
      obtain ⟨hMk, hkN⟩ := Finset.mem_Ioc.mp hk
      refine ⟨k * q, Finset.mem_filter.mpr ⟨Finset.mem_Ioc.mpr ⟨?_, ?_⟩,
        dvd_mul_left q k⟩, Nat.mul_div_cancel k hq⟩
      · exact (Nat.div_lt_iff_lt_mul hq).mp hMk
      · exact (Nat.le_div_iff_mul_le hq).mp hkN
  simpa using hh

theorem natCast_div_lower (M q : ℕ) (hq : 0 < q) :
    (M : ℝ) / q - 1 ≤ ((M / q : ℕ) : ℝ) := by
  have hqr : (0 : ℝ) < q := by exact_mod_cast hq
  have hn : M < (M / q + 1) * q :=
    (Nat.div_lt_iff_lt_mul hq).mp (Nat.lt_succ_self (M / q))
  have hnr : (M : ℝ) < (((M / q : ℕ) : ℝ) + 1) * q := by exact_mod_cast hn
  have hh := (div_lt_iff₀ hqr).mpr hnr
  linarith

theorem multiples_Ioc_card_bound {M N q : ℕ} (hMN : M ≤ N) (hq : 0 < q) :
    (((Finset.Ioc M N).filter (fun n => q ∣ n)).card : ℝ) ≤
      ((N : ℝ) - M) / q + 1 := by
  rw [multiples_Ioc_card M N q hq, Nat.cast_sub (Nat.div_le_div_right hMN)]
  have hl := natCast_div_lower M q hq
  have hu : ((N / q : ℕ) : ℝ) ≤ (N : ℝ) / q := Nat.cast_div_le
  calc
    _ ≤ (N : ℝ) / q - ((M : ℝ) / q - 1) := sub_le_sub hu hl
    _ = _ := by ring

def squarefreeWindow (M N : ℕ) : Finset ℕ :=
  (Finset.Ioc M N).filter Squarefree

def squarefulWindow (M N : ℕ) : Finset ℕ :=
  (Finset.Ioc M N).filter (fun n => ¬ Squarefree n)

theorem squarefulWindow_subset_square_multiples (M N : ℕ) :
    squarefulWindow M N ⊆ (Finset.Icc 2 N.sqrt).biUnion
      (fun k => (Finset.Ioc M N).filter (fun n => k * k ∣ n)) := by
  intro n hn
  obtain ⟨hwin, hns⟩ := Finset.mem_filter.mp hn
  obtain ⟨hMn, hnN⟩ := Finset.mem_Ioc.mp hwin
  simp only [Nat.squarefree_iff_prime_squarefree, not_forall, not_not] at hns
  obtain ⟨p, hp, hpd⟩ := hns
  have hpN : p ≤ N.sqrt := Nat.le_sqrt.mpr
    ((Nat.le_of_dvd (by omega : 0 < n) hpd).trans hnN)
  exact Finset.mem_biUnion.mpr ⟨p, Finset.mem_Icc.mpr ⟨hp.two_le, hpN⟩,
    Finset.mem_filter.mpr ⟨hwin, hpd⟩⟩

theorem squarefulWindow_card_bound {M N : ℕ} (hMN : M ≤ N) :
    ((squarefulWindow M N).card : ℝ) ≤
      (3 / 4 : ℝ) * ((N : ℝ) - M) + N.sqrt := by
  have hc : (squarefulWindow M N).card ≤
      ∑ k ∈ Finset.Icc 2 N.sqrt, ((Finset.Ioc M N).filter (fun n => k * k ∣ n)).card :=
    (Finset.card_le_card (squarefulWindow_subset_square_multiples M N)).trans
      Finset.card_biUnion_le
  have hcr : ((squarefulWindow M N).card : ℝ) ≤
      ∑ k ∈ Finset.Icc 2 N.sqrt,
        (((Finset.Ioc M N).filter (fun n => k * k ∣ n)).card : ℝ) := by exact_mod_cast hc
  have hterm : ∀ k ∈ Finset.Icc 2 N.sqrt,
      (((Finset.Ioc M N).filter (fun n => k * k ∣ n)).card : ℝ) ≤
        ((N : ℝ) - M) * (1 / (k : ℝ) ^ 2) + 1 := by
    intro k hk
    have hk0 : 0 < k := by have := (Finset.mem_Icc.mp hk).1; omega
    have hh := multiples_Ioc_card_bound hMN (Nat.mul_pos hk0 hk0)
    simpa [Nat.cast_mul, pow_two, div_eq_mul_inv] using hh
  have hh := hcr.trans (Finset.sum_le_sum hterm)
  rw [Finset.sum_add_distrib, ← Finset.mul_sum, Finset.sum_const, nsmul_eq_mul, mul_one] at hh
  have hnon : (0 : ℝ) ≤ (N : ℝ) - M := sub_nonneg.mpr (by exact_mod_cast hMN)
  have hsum := mul_le_mul_of_nonneg_left (reciprocal_square_sum_Icc_bound N.sqrt) hnon
  have hcard : ((Finset.Icc 2 N.sqrt).card : ℝ) ≤ N.sqrt := by
    have hn : (Finset.Icc 2 N.sqrt).card ≤ N.sqrt := by simp
    exact_mod_cast hn
  linarith

theorem squarefreeWindow_card_lower {M N : ℕ} (hMN : M ≤ N) :
    ((N : ℝ) - M) / 4 - N.sqrt ≤ ((squarefreeWindow M N).card : ℝ) := by
  have hh := Finset.filter_card_add_filter_neg_card_eq_card
    (s := Finset.Ioc M N) Squarefree
  have hc : ((squarefreeWindow M N).card : ℝ) + ((squarefulWindow M N).card : ℝ) =
      (N : ℝ) - M := by
    have he := congrArg (fun n : ℕ => (n : ℝ)) hh
    simpa [squarefreeWindow, squarefulWindow, Nat.cast_sub hMN] using he
  have hu := squarefulWindow_card_bound hMN
  linarith

/-- An explicit elementary positive density in the terminal half interval. -/
theorem squarefree_terminal_half_lower {N : ℕ} (hN : 256 ≤ N) :
    (N : ℝ) / 16 ≤ ((squarefreeWindow (N / 2) N).card : ℝ) := by
  have hm : 16 ≤ N.sqrt := Nat.le_sqrt.mpr (by norm_num; exact hN)
  have hmul : 16 * N.sqrt ≤ N :=
    (Nat.mul_le_mul_right N.sqrt hm).trans (Nat.sqrt_le N)
  have hmulr : (16 : ℝ) * N.sqrt ≤ N := by exact_mod_cast hmul
  have hhalf : ((N / 2 : ℕ) : ℝ) ≤ (N : ℝ) / 2 := by
    simpa using (Nat.cast_div_le (m := N) (n := 2) (α := ℝ))
  have hh := squarefreeWindow_card_lower (Nat.div_le_self N 2)
  linarith

noncomputable def signedMobiusInverse (f : ℕ → ℝ) (N : ℕ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) * f (N / d)

theorem moebius_square_sum_ge_squarefree_half (m : ℕ) :
    ((squarefreeWindow (m / 2) m).card : ℝ) ≤
      ∑ d ∈ Finset.Icc 1 m, (ArithmeticFunction.moebius d : ℝ) ^ 2 := by
  have hsub : squarefreeWindow (m / 2) m ⊆ Finset.Icc 1 m := by
    intro d hd
    have hh := Finset.mem_Ioc.mp (Finset.mem_filter.mp hd).1
    exact Finset.mem_Icc.mpr ⟨by omega, hh.2⟩
  have he : ∀ d ∈ squarefreeWindow (m / 2) m,
      (ArithmeticFunction.moebius d : ℝ) ^ 2 = 1 := by
    intro d hd
    have hs := (Finset.mem_filter.mp hd).2
    have hh : |(ArithmeticFunction.moebius d : ℝ)| = 1 := by
      exact_mod_cast ArithmeticFunction.abs_moebius_eq_one_of_squarefree hs
    nlinarith [sq_abs (ArithmeticFunction.moebius d : ℝ)]
  have hh := Finset.sum_le_sum_of_subset_of_nonneg
    (f := fun d => (ArithmeticFunction.moebius d : ℝ) ^ 2) hsub
    (fun _ _ _ => sq_nonneg _)
  simpa [Finset.sum_congr rfl he] using hh

theorem larger_power_not_eventually_bounded {a b : ℝ} (hab : a < b) :
    ¬ ∃ C : ℝ, ∃ N₀ : ℕ, ∀ N : ℕ, N₀ ≤ N → (N : ℝ) ^ b ≤ C * (N : ℝ) ^ a := by
  rintro ⟨C, N₀, hC⟩
  have hlim : Tendsto (fun N : ℕ => (N : ℝ) ^ (b - a)) atTop atTop :=
    (tendsto_rpow_atTop (sub_pos.mpr hab)).comp tendsto_natCast_atTop_atTop
  obtain ⟨N, hN, hlarge⟩ := ((eventually_ge_atTop (max N₀ 1)).and
    (hlim.eventually (eventually_gt_atTop C))).exists
  have hn1 : 1 ≤ N := le_trans (le_max_right _ _) hN
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast (show 0 < N by omega)
  have hh := hC N (le_trans (le_max_left _ _) hN)
  rw [Real.rpow_sub hn] at hlarge
  have hpos : 0 < (N : ℝ) ^ a := Real.rpow_pos_of_pos hn _
  have hg := (lt_div_iff₀ hpos).mp hlarge
  linarith

/-- A finite continuous linear functional on the Banach space of bounded real
sequences. Its weights are the actual Möbius values and floor quotients. -/
noncomputable def normalizedMobiusFunctional (r : ℝ) (N : ℕ) :
    (ℕ →ᵇ ℝ) →L[ℝ] ℝ :=
  ((N : ℝ) ^ r)⁻¹ • ∑ d ∈ Finset.Icc 1 N,
    ((ArithmeticFunction.moebius d : ℝ) * Real.sqrt (N / d : ℕ)) •
      BoundedContinuousFunction.evalCLM ℝ (N / d)

theorem normalizedMobiusFunctional_apply (r : ℝ) (N : ℕ) (g : ℕ →ᵇ ℝ) :
    normalizedMobiusFunctional r N g =
      signedMobiusInverse (fun q => Real.sqrt q * g q) N / (N : ℝ) ^ r := by
  simp only [normalizedMobiusFunctional, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.sum_apply, BoundedContinuousFunction.evalCLM_apply,
    smul_eq_mul, signedMobiusInverse]
  rw [div_eq_mul_inv, mul_comm]
  congr 1
  apply Finset.sum_congr rfl
  intro d _
  ring

theorem sqrt_normalized_source_bound {f : ℕ → ℝ}
    (hf : ∀ q : ℕ, |f q| ≤ Real.sqrt q) (q : ℕ) :
    ‖f q / Real.sqrt q‖ ≤ 1 := by
  by_cases hq : q = 0
  · simp [hq]
  · have hs : 0 < Real.sqrt (q : ℝ) := Real.sqrt_pos.mpr
      (by exact_mod_cast Nat.pos_of_ne_zero hq)
    rw [Real.norm_eq_abs, abs_div, abs_of_pos hs]
    exact (div_le_one hs).mpr (hf q)

noncomputable def sqrtNormalizedSource (f : ℕ → ℝ)
    (hf : ∀ q : ℕ, |f q| ≤ Real.sqrt q) : ℕ →ᵇ ℝ :=
  BoundedContinuousFunction.ofNormedAddCommGroupDiscrete
    (fun q => f q / Real.sqrt q) 1 (sqrt_normalized_source_bound hf)

theorem sqrtNormalizedSource_norm_le (f : ℕ → ℝ)
    (hf : ∀ q : ℕ, |f q| ≤ Real.sqrt q) : ‖sqrtNormalizedSource f hf‖ ≤ 1 :=
  (BoundedContinuousFunction.norm_le (by norm_num : (0 : ℝ) ≤ 1)).mpr
    (sqrt_normalized_source_bound hf)

theorem sqrtNormalizedSource_recovery (f : ℕ → ℝ)
    (hf : ∀ q : ℕ, |f q| ≤ Real.sqrt q) (q : ℕ) :
    Real.sqrt q * sqrtNormalizedSource f hf q = f q := by
  change Real.sqrt q * (f q / Real.sqrt q) = f q
  by_cases hq : q = 0
  · have hf0 : f 0 = 0 := by
      have hh := hf 0
      simpa using hh
    simp [hq, hf0]
  · have hs : Real.sqrt (q : ℝ) ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr
      (by exact_mod_cast Nat.pos_of_ne_zero hq))
    field_simp

noncomputable def sourceTent (A c x : ℝ) : ℝ := max 0 (A - |x - c|)

theorem sourceTent_nonneg (A c x : ℝ) : 0 ≤ sourceTent A c x := le_max_left _ _

theorem sourceTent_le {A : ℝ} (hA : 0 ≤ A) (c x : ℝ) : sourceTent A c x ≤ A := by
  exact max_le hA (sub_le_self _ (abs_nonneg _))

theorem sourceTent_zero {A c x : ℝ} (h : A ≤ |x - c|) : sourceTent A c x = 0 := by
  exact max_eq_left (sub_nonpos.mpr h)

theorem sourceTent_center {A : ℝ} (hA : 0 ≤ A) (c : ℝ) : sourceTent A c c = A := by
  simp [sourceTent, hA]

theorem sourceTent_abs_sub_le (A c x y : ℝ) :
    |sourceTent A c x - sourceTent A c y| ≤ |x - y| := by
  have hm := abs_max_sub_max_le_max (0 : ℝ) (A - |x - c|) 0 (A - |y - c|)
  have ha := abs_abs_sub_abs_le_abs_sub (x - c) (y - c)
  have he : (A - |x - c|) - (A - |y - c|) = -(|x - c| - |y - c|) := by ring
  have he' : (x - c) - (y - c) = x - y := by ring
  simp only [sub_self, abs_zero, he, abs_neg] at hm
  rw [max_eq_right (abs_nonneg (|x - c| - |y - c|))] at hm
  rw [he'] at ha
  exact hm.trans ha

theorem finite_sup_abs_sub_le {ι : Type*} {s : Finset ι} (hs : s.Nonempty)
    (u v : ι → ℝ) (L : ℝ) (h : ∀ i ∈ s, |u i - v i| ≤ L) :
    |s.sup' hs u - s.sup' hs v| ≤ L := by
  have hu : s.sup' hs u ≤ s.sup' hs v + L := by
    apply Finset.sup'_le
    intro i hi
    have hh := (abs_le.mp (h i hi)).2
    have hv := Finset.le_sup' v hi
    linarith
  have hv : s.sup' hs v ≤ s.sup' hs u + L := by
    apply Finset.sup'_le
    intro i hi
    have hh := (abs_le.mp (h i hi)).1
    have hu := Finset.le_sup' u hi
    linarith
  exact abs_le.mpr ⟨by linarith, by linarith⟩

/-- Upper envelope of tents with a chosen Möbius sign. The zero index ensures
that the finite supremum is defined and contributes the constant zero. -/
noncomputable def signedTentEnvelope (t : ℕ) (z : ℤ) (x : ℝ) : ℝ :=
  (Finset.range (t + 1)).sup' (by simp) (fun d =>
    if 0 < d ∧ ArithmeticFunction.moebius d = z then
      sourceTent ((t : ℝ) / 2) (t ^ 3 / d : ℕ) x else 0)

theorem signedTentEnvelope_nonneg (t : ℕ) (z : ℤ) (x : ℝ) :
    0 ≤ signedTentEnvelope t z x := by
  unfold signedTentEnvelope
  apply Finset.le_sup'_of_le _ (b := 0) (by simp)
  simp

theorem signedTentEnvelope_le (t : ℕ) (z : ℤ) (x : ℝ) :
    signedTentEnvelope t z x ≤ (t : ℝ) / 2 := by
  unfold signedTentEnvelope
  apply Finset.sup'_le
  intro d _
  split_ifs
  · exact sourceTent_le (by positivity) _ _
  · positivity

theorem signedTentEnvelope_abs_sub_le (t : ℕ) (z : ℤ) (x y : ℝ) :
    |signedTentEnvelope t z x - signedTentEnvelope t z y| ≤ |x - y| := by
  apply finite_sup_abs_sub_le
  intro d _
  split_ifs
  · exact sourceTent_abs_sub_le _ _ _ _
  · simp

/-- Half the difference of the positive and negative envelopes is 1-Lipschitz. -/
noncomputable def smoothTestSource (t q : ℕ) : ℝ :=
  (signedTentEnvelope t 1 q - signedTentEnvelope t (-1) q) / 2

theorem smoothTestSource_abs_le (t q : ℕ) : |smoothTestSource t q| ≤ (t : ℝ) / 4 := by
  have hp := signedTentEnvelope_nonneg t 1 q
  have hn := signedTentEnvelope_nonneg t (-1) q
  have hup := signedTentEnvelope_le t 1 q
  have hun := signedTentEnvelope_le t (-1) q
  unfold smoothTestSource
  rw [abs_le]
  constructor <;> linarith

theorem smoothTestSource_abs_sub_le (t q k : ℕ) :
    |smoothTestSource t q - smoothTestSource t k| ≤ |(q : ℝ) - k| := by
  have hp := signedTentEnvelope_abs_sub_le t 1 q k
  have hn := signedTentEnvelope_abs_sub_le t (-1) q k
  have hh := abs_sub_le (signedTentEnvelope t 1 q - signedTentEnvelope t 1 k)
    0 (signedTentEnvelope t (-1) q - signedTentEnvelope t (-1) k)
  have he : smoothTestSource t q - smoothTestSource t k =
      ((signedTentEnvelope t 1 q - signedTentEnvelope t 1 k) -
       (signedTentEnvelope t (-1) q - signedTentEnvelope t (-1) k)) / 2 := by
    unfold smoothTestSource
    ring
  rw [he, abs_div]
  rw [abs_of_pos (by norm_num : (0 : ℝ) < 2)]
  simp only [sub_zero, zero_sub, abs_neg] at hh
  linarith

theorem smoothTestSource_increment_le (t q : ℕ) :
    |smoothTestSource t (q + 1) - smoothTestSource t q| ≤ 1 := by
  simpa using smoothTestSource_abs_sub_le t (q + 1) q

theorem cubic_quotient_lower {t d : ℕ} (hd : d ∈ Finset.Icc 1 t) :
    t ^ 2 ≤ t ^ 3 / d := by
  obtain ⟨hd1, hdt⟩ := Finset.mem_Icc.mp hd
  apply (Nat.le_div_iff_mul_le (by omega)).mpr
  nlinarith [Nat.mul_le_mul_left (t ^ 2) hdt]

theorem cubic_quotient_gap {t d e : ℕ} (hd : 1 ≤ d) (hde : d < e) (he : e ≤ t) :
    t ^ 3 / e + t ≤ t ^ 3 / d := by
  have hq := cubic_quotient_lower (Finset.mem_Icc.mpr ⟨by omega, he⟩)
  have hf := Nat.div_mul_le_self (t ^ 3) e
  have hm := Nat.mul_le_mul_right (t ^ 3 / e) (show d + 1 ≤ e by omega)
  have hdt := Nat.mul_le_mul_right t (show d ≤ t by omega)
  apply (Nat.le_div_iff_mul_le (by omega)).mpr
  nlinarith

theorem cubic_quotient_abs_gap {t d e : ℕ} (hd : d ∈ Finset.Icc 1 t)
    (he : e ∈ Finset.Icc 1 t) (hne : d ≠ e) :
    (t : ℝ) ≤ |((t ^ 3 / d : ℕ) : ℝ) - (t ^ 3 / e : ℕ)| := by
  obtain ⟨hd1, hdt⟩ := Finset.mem_Icc.mp hd
  obtain ⟨he1, het⟩ := Finset.mem_Icc.mp he
  rcases lt_or_gt_of_ne hne with hlt | hgt
  · have hh : ((t ^ 3 / e : ℕ) : ℝ) + t ≤ (t ^ 3 / d : ℕ) := by
      exact_mod_cast cubic_quotient_gap hd1 hlt het
    linarith [le_abs_self (((t ^ 3 / d : ℕ) : ℝ) - (t ^ 3 / e : ℕ))]
  · have hh : ((t ^ 3 / d : ℕ) : ℝ) + t ≤ (t ^ 3 / e : ℕ) := by
      exact_mod_cast cubic_quotient_gap he1 hgt hdt
    have ha := neg_le_abs (((t ^ 3 / d : ℕ) : ℝ) - (t ^ 3 / e : ℕ))
    linarith

theorem cubic_quotient_tail_gap {t d : ℕ} (hd : t < d) :
    t ^ 3 / d + t ≤ t ^ 2 := by
  have hf := Nat.div_mul_le_self (t ^ 3) d
  have hm := Nat.mul_le_mul_left (t ^ 3 / d) (show t + 1 ≤ d by omega)
  by_contra hnot
  have hlarge : t ^ 2 + 1 ≤ t ^ 3 / d + t := by omega
  have hmul := Nat.mul_le_mul_right (t + 1) hlarge
  nlinarith

theorem signedTentEnvelope_at_quotient {t d : ℕ} (hd : d ∈ Finset.Icc 1 t) (z : ℤ) :
    signedTentEnvelope t z (t ^ 3 / d : ℕ) =
      if ArithmeticFunction.moebius d = z then (t : ℝ) / 2 else 0 := by
  have hd1 := (Finset.mem_Icc.mp hd).1
  have hdt := (Finset.mem_Icc.mp hd).2
  by_cases hz : ArithmeticFunction.moebius d = z
  · rw [if_pos hz]
    apply le_antisymm (signedTentEnvelope_le t z _)
    unfold signedTentEnvelope
    apply Finset.le_sup'_of_le _ (b := d) (Finset.mem_range.mpr (by omega))
    rw [if_pos ⟨by omega, hz⟩, sourceTent_center (by positivity)]
  · rw [if_neg hz]
    apply le_antisymm _ (signedTentEnvelope_nonneg t z _)
    unfold signedTentEnvelope
    apply Finset.sup'_le
    intro e he
    have her := Finset.mem_range.mp he
    split_ifs with h
    · have hewin : e ∈ Finset.Icc 1 t := Finset.mem_Icc.mpr
        ⟨by omega, by omega⟩
      have hne : d ≠ e := by intro hh; subst e; exact hz h.2
      have hgap := cubic_quotient_abs_gap hd hewin hne
      rw [sourceTent_zero (by linarith)]
    · rfl

theorem smoothTestSource_at_small_divisor {t d : ℕ} (hd : d ∈ Finset.Icc 1 t) :
    smoothTestSource t (t ^ 3 / d) = (ArithmeticFunction.moebius d : ℝ) * t / 4 := by
  unfold smoothTestSource
  rw [signedTentEnvelope_at_quotient hd, signedTentEnvelope_at_quotient hd]
  have hh := ArithmeticFunction.abs_moebius_le_one (n := d)
  have hab := abs_le.mp hh
  have hcases : ArithmeticFunction.moebius d = -1 ∨ ArithmeticFunction.moebius d = 0 ∨
      ArithmeticFunction.moebius d = 1 := by omega
  rcases hcases with h | h | h <;> norm_num [h] <;> ring

theorem signedTentEnvelope_zero_below {t : ℕ} {x : ℝ}
    (hx : x + (t : ℝ) / 2 ≤ (t : ℝ) ^ 2) (z : ℤ) :
    signedTentEnvelope t z x = 0 := by
  apply le_antisymm _ (signedTentEnvelope_nonneg t z x)
  unfold signedTentEnvelope
  apply Finset.sup'_le
  intro d hd
  have hdr := Finset.mem_range.mp hd
  split_ifs with h
  · have hdwin : d ∈ Finset.Icc 1 t := Finset.mem_Icc.mpr
      ⟨by omega, by omega⟩
    have hq : (t : ℝ) ^ 2 ≤ (t ^ 3 / d : ℕ) := by
      exact_mod_cast cubic_quotient_lower hdwin
    have ha := neg_le_abs (x - ((t ^ 3 / d : ℕ) : ℝ))
    rw [sourceTent_zero (by linarith)]
  · rfl

theorem smoothTestSource_at_large_divisor {t d : ℕ} (hd : t < d) :
    smoothTestSource t (t ^ 3 / d) = 0 := by
  have hg : ((t ^ 3 / d : ℕ) : ℝ) + t ≤ (t : ℝ) ^ 2 := by
    exact_mod_cast cubic_quotient_tail_gap hd
  have hx : ((t ^ 3 / d : ℕ) : ℝ) + (t : ℝ) / 2 ≤ (t : ℝ) ^ 2 := by
    linarith [Nat.cast_nonneg (α := ℝ) t]
  simp [smoothTestSource, signedTentEnvelope_zero_below hx]

theorem smoothTestSource_sq_le {t : ℕ} (ht : 1 ≤ t) (q : ℕ) :
    smoothTestSource t q ^ 2 ≤ (q : ℝ) := by
  by_cases hq : (q : ℝ) + (t : ℝ) / 2 ≤ (t : ℝ) ^ 2
  · simp [smoothTestSource, signedTentEnvelope_zero_below hq]
  · have ht1 : (1 : ℝ) ≤ t := by exact_mod_cast ht
    have hb := smoothTestSource_abs_le t q
    have hh : smoothTestSource t q ^ 2 ≤ ((t : ℝ) / 4) ^ 2 := by
      have hh := (sq_le_sq₀ (abs_nonneg (smoothTestSource t q))
        (show (0 : ℝ) ≤ (t : ℝ) / 4 by positivity)).mpr hb
      simpa only [sq_abs] using hh
    nlinarith

theorem smoothTestSource_abs_le_sqrt {t : ℕ} (ht : 1 ≤ t) (q : ℕ) :
    |smoothTestSource t q| ≤ Real.sqrt q := by
  have hs := smoothTestSource_sq_le ht q
  have hr := Real.sq_sqrt (show (0 : ℝ) ≤ q by positivity)
  have hp := Real.sqrt_nonneg (q : ℝ)
  nlinarith [sq_abs (smoothTestSource t q), abs_nonneg (smoothTestSource t q)]

theorem signedMobiusInverse_smoothTestSource {t : ℕ} (ht : 1 ≤ t) :
    signedMobiusInverse (smoothTestSource t) (t ^ 3) =
      (t : ℝ) / 4 * ∑ d ∈ Finset.Icc 1 t, (ArithmeticFunction.moebius d : ℝ) ^ 2 := by
  have ht3 : t ≤ t ^ 3 := by nlinarith [sq_nonneg (t - 1 : ℤ)]
  have hsub : Finset.Icc 1 t ⊆ Finset.Icc 1 (t ^ 3) := Finset.Icc_subset_Icc le_rfl ht3
  unfold signedMobiusInverse
  rw [← Finset.sum_subset hsub (by
    intro d hd hnot
    have hd1 := (Finset.mem_Icc.mp hd).1
    have hlarge : t < d := by
      simp only [Finset.mem_Icc, not_and, not_le] at hnot
      exact hnot hd1
    rw [smoothTestSource_at_large_divisor hlarge, mul_zero])]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hd
  rw [smoothTestSource_at_small_divisor hd]
  ring

theorem signedMobiusInverse_smoothTestSource_lower {t : ℕ} (ht : 256 ≤ t) :
    (t : ℝ) ^ 2 / 64 ≤ signedMobiusInverse (smoothTestSource t) (t ^ 3) := by
  have hh := (squarefree_terminal_half_lower ht).trans (moebius_square_sum_ge_squarefree_half t)
  have hp := mul_le_mul_of_nonneg_left hh (show (0 : ℝ) ≤ (t : ℝ) / 4 by positivity)
  rw [signedMobiusInverse_smoothTestSource (by omega : 1 ≤ t)]
  nlinarith

/-- Square-root magnitude and bounded first differences together still do not
give a uniform Möbius floor-inverse estimate below exponent 2/3. -/
theorem signedMobiusInverse_no_uniform_regular_bound {r : ℝ} (hr : r < 2 / 3) :
    ¬ ∃ C : ℝ, ∃ N₀ : ℕ, ∀ f : ℕ → ℝ,
      (∀ q : ℕ, |f q| ≤ Real.sqrt q) → (∀ q : ℕ, |f (q + 1) - f q| ≤ 1) →
      ∀ N : ℕ, max 1 N₀ ≤ N → |signedMobiusInverse f N| ≤ C * (N : ℝ) ^ r := by
  rintro ⟨C, N₀, hc⟩
  apply larger_power_not_eventually_bounded (show 3 * r < (2 : ℝ) by linarith)
  refine ⟨64 * C, max 256 N₀, ?_⟩
  intro t ht
  have ht256 : 256 ≤ t := (le_max_left _ _).trans ht
  have htN : N₀ ≤ t := (le_max_right _ _).trans ht
  have ht1 : 1 ≤ t := by omega
  have htt : t ≤ t ^ 3 := by nlinarith [sq_nonneg (t - 1 : ℤ)]
  have hb := hc (smoothTestSource t) (smoothTestSource_abs_le_sqrt ht1)
    (smoothTestSource_increment_le t) (t ^ 3) (by omega)
  have hl := (signedMobiusInverse_smoothTestSource_lower ht256).trans
    (le_abs_self (signedMobiusInverse (smoothTestSource t) (t ^ 3)))
  have he : ((t ^ 3 : ℕ) : ℝ) ^ r = (t : ℝ) ^ (3 * r) := by
    push_cast
    exact (Real.rpow_natCast_mul (Nat.cast_nonneg t) 3 r).symm
  rw [he] at hb
  calc
    (t : ℝ) ^ (2 : ℝ) = (t : ℝ) ^ (2 : ℕ) := Real.rpow_natCast _ 2
    _ ≤ (C * (t : ℝ) ^ (3 * r)) * 64 :=
      (div_le_iff₀ (by norm_num : (0 : ℝ) < 64)).mp (hl.trans hb)
    _ = _ := by ring

local notation "SeqPair" => (ℕ →ᵇ ℝ) × (ℕ →ᵇ ℝ)

/-- The constraint records the first difference of sqrt(q) times the first
bounded sequence in the second bounded sequence. -/
noncomputable def sourceDifferenceConstraint (q : ℕ) : SeqPair →L[ℝ] ℝ :=
  (BoundedContinuousFunction.evalCLM ℝ q).comp (ContinuousLinearMap.snd ℝ _ _) -
    Real.sqrt (q + 1 : ℕ) • ((BoundedContinuousFunction.evalCLM ℝ (q + 1)).comp
      (ContinuousLinearMap.fst ℝ _ _)) +
    Real.sqrt q • ((BoundedContinuousFunction.evalCLM ℝ q).comp
      (ContinuousLinearMap.fst ℝ _ _))

theorem sourceDifferenceConstraint_apply (q : ℕ) (p : SeqPair) :
    sourceDifferenceConstraint q p =
      p.2 q - Real.sqrt (q + 1 : ℕ) * p.1 (q + 1) + Real.sqrt q * p.1 q := by
  rfl

noncomputable def regularSourceSpace : Submodule ℝ SeqPair :=
  ⨅ q : ℕ, LinearMap.ker (sourceDifferenceConstraint q)

noncomputable def regularSourceNormedSpace : NormedSpace ℝ regularSourceSpace :=
  Submodule.normedSpace regularSourceSpace

attribute [local instance] regularSourceNormedSpace

theorem mem_regularSourceSpace (p : SeqPair) : p ∈ regularSourceSpace ↔
    ∀ q : ℕ, Real.sqrt (q + 1 : ℕ) * p.1 (q + 1) - Real.sqrt q * p.1 q = p.2 q := by
  simp only [regularSourceSpace, Submodule.mem_iInf, LinearMap.mem_ker,
    sourceDifferenceConstraint_apply]
  constructor <;> intro h q <;> have hh := h q <;> linarith

theorem regularSourceSpace_isClosed : IsClosed (regularSourceSpace : Set SeqPair) := by
  simp only [regularSourceSpace, Submodule.coe_iInf]
  exact isClosed_iInter (fun q => ContinuousLinearMap.isClosed_ker (sourceDifferenceConstraint q))

noncomputable def sourceDifferenceSequence (f : ℕ → ℝ)
    (hd : ∀ q : ℕ, |f (q + 1) - f q| ≤ 1) : ℕ →ᵇ ℝ :=
  BoundedContinuousFunction.ofNormedAddCommGroupDiscrete (fun q => f (q + 1) - f q) 1
    (by simpa only [Real.norm_eq_abs] using hd)

noncomputable def liftRegularSource (f : ℕ → ℝ) (hf : ∀ q : ℕ, |f q| ≤ Real.sqrt q)
    (hd : ∀ q : ℕ, |f (q + 1) - f q| ≤ 1) : regularSourceSpace :=
  ⟨(sqrtNormalizedSource f hf, sourceDifferenceSequence f hd),
    (mem_regularSourceSpace _).mpr (by
      intro q
      simp only [sqrtNormalizedSource_recovery]
      rfl)⟩

theorem liftRegularSource_norm_le (f : ℕ → ℝ) (hf : ∀ q : ℕ, |f q| ≤ Real.sqrt q)
    (hd : ∀ q : ℕ, |f (q + 1) - f q| ≤ 1) : ‖liftRegularSource f hf hd‖ ≤ 1 := by
  change ‖(sqrtNormalizedSource f hf, sourceDifferenceSequence f hd)‖ ≤ 1
  rw [norm_prod_le_iff]
  refine ⟨sqrtNormalizedSource_norm_le f hf, ?_⟩
  apply (BoundedContinuousFunction.norm_le (by norm_num : (0 : ℝ) ≤ 1)).mpr
  simpa only [sourceDifferenceSequence, BoundedContinuousFunction.coe_ofNormedAddCommGroupDiscrete,
    Real.norm_eq_abs] using hd

noncomputable def regularMobiusFunctional (r : ℝ) (N : ℕ) : regularSourceSpace →L[ℝ] ℝ :=
  (normalizedMobiusFunctional r N).comp
    ((ContinuousLinearMap.fst ℝ (ℕ →ᵇ ℝ) (ℕ →ᵇ ℝ)).comp regularSourceSpace.subtypeL)

theorem regularMobiusFunctional_apply (r : ℝ) (N : ℕ) (p : regularSourceSpace) :
    regularMobiusFunctional r N p =
      signedMobiusInverse (fun q => Real.sqrt q * p.1.1 q) N / (N : ℝ) ^ r := by
  exact normalizedMobiusFunctional_apply r N p.1.1

theorem regularMobiusFunctional_lift (r : ℝ) (N : ℕ) (f : ℕ → ℝ)
    (hf : ∀ q : ℕ, |f q| ≤ Real.sqrt q) (hd : ∀ q : ℕ, |f (q + 1) - f q| ≤ 1) :
    regularMobiusFunctional r N (liftRegularSource f hf hd) =
      signedMobiusInverse f N / (N : ℝ) ^ r := by
  rw [regularMobiusFunctional_apply]
  change signedMobiusInverse (fun q => Real.sqrt q * sqrtNormalizedSource f hf q) N /
    (N : ℝ) ^ r = _
  simp only [sqrtNormalizedSource_recovery]

theorem regularMobiusFunctional_not_uniformly_bounded {r : ℝ} (hr : r < 2 / 3) :
    ¬ ∃ C : ℝ, ∀ N : ℕ, ‖regularMobiusFunctional r N‖ ≤ C := by
  rintro ⟨C, hc⟩
  apply signedMobiusInverse_no_uniform_regular_bound hr
  refine ⟨C, 0, ?_⟩
  intro f hf hd N hN
  have hn : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hp := Real.rpow_pos_of_pos hn r
  have hh := (regularMobiusFunctional r N).le_opNorm (liftRegularSource f hf hd)
  have hb : ‖regularMobiusFunctional r N (liftRegularSource f hf hd)‖ ≤ C :=
    hh.trans ((mul_le_mul_of_nonneg_left (liftRegularSource_norm_le f hf hd)
      (norm_nonneg _)).trans (by simpa using hc N))
  rw [regularMobiusFunctional_lift, Real.norm_eq_abs, abs_div, abs_of_pos hp] at hb
  exact (div_le_iff₀ hp).mp hb

noncomputable def regularSpaceSource (p : regularSourceSpace) (q : ℕ) : ℝ :=
  Real.sqrt q * p.1.1 q / max 1 ‖p‖

theorem regularSpaceSource_bounds (p : regularSourceSpace) :
    (∀ q : ℕ, |regularSpaceSource p q| ≤ Real.sqrt q) ∧
    (∀ q : ℕ, |regularSpaceSource p (q + 1) - regularSpaceSource p q| ≤ 1) := by
  have hb : (0 : ℝ) < max 1 ‖p‖ := lt_of_lt_of_le (by norm_num) (le_max_left _ _)
  have hfst : ‖p.1.1‖ ≤ ‖p‖ := norm_fst_le p.1
  have hsnd : ‖p.1.2‖ ≤ ‖p‖ := norm_snd_le p.1
  have hg : ∀ q : ℕ, |p.1.1 q| ≤ max 1 ‖p‖ := by
    intro q
    have hh : |p.1.1 q| ≤ ‖p.1.1‖ := by simpa using p.1.1.norm_coe_le_norm q
    exact hh.trans (hfst.trans (le_max_right _ _))
  have hh : ∀ q : ℕ, |p.1.2 q| ≤ max 1 ‖p‖ := by
    intro q
    have hh : |p.1.2 q| ≤ ‖p.1.2‖ := by simpa using p.1.2.norm_coe_le_norm q
    exact hh.trans (hsnd.trans (le_max_right _ _))
  constructor
  · intro q
    unfold regularSpaceSource
    rw [abs_div, abs_mul, abs_of_nonneg (Real.sqrt_nonneg _), abs_of_pos hb]
    apply (div_le_iff₀ hb).mpr
    exact mul_le_mul_of_nonneg_left (hg q) (Real.sqrt_nonneg _)
  · intro q
    unfold regularSpaceSource
    rw [← sub_div, (mem_regularSourceSpace p.1).mp p.2 q,
      abs_div, abs_of_pos hb]
    exact (div_le_one hb).mpr (hh q)

theorem regularMobiusFunctional_scaled_source (r : ℝ) (N : ℕ) (p : regularSourceSpace) :
    regularMobiusFunctional r N p = max 1 ‖p‖ *
      signedMobiusInverse (regularSpaceSource p) N / (N : ℝ) ^ r := by
  have hb : max 1 ‖p‖ ≠ 0 := ne_of_gt
    (lt_of_lt_of_le (by norm_num : (0 : ℝ) < 1) (le_max_left _ _))
  rw [regularMobiusFunctional_apply]
  congr 1
  unfold signedMobiusInverse
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d _
  unfold regularSpaceSource
  field_simp

/-- For each exponent below 2/3, a fixed square-root-bounded source with
bounded first differences has no eventual Möbius floor-inverse bound of that power. -/
theorem exists_fixed_regular_source_with_unbounded_inverse {r : ℝ} (hr : r < 2 / 3) :
    ∃ f : ℕ → ℝ, (∀ q : ℕ, |f q| ≤ Real.sqrt q) ∧
      (∀ q : ℕ, |f (q + 1) - f q| ≤ 1) ∧
      ¬ ∃ C : ℝ, ∃ N₀ : ℕ, ∀ N : ℕ, max 1 N₀ ≤ N →
        |signedMobiusInverse f N| ≤ C * (N : ℝ) ^ r := by
  classical
  letI : CompleteSpace regularSourceSpace := regularSourceSpace_isClosed.completeSpace_coe
  by_contra hnot
  have hgood : ∀ f : ℕ → ℝ, (∀ q : ℕ, |f q| ≤ Real.sqrt q) →
      (∀ q : ℕ, |f (q + 1) - f q| ≤ 1) →
      ∃ C : ℝ, ∃ N₀ : ℕ, ∀ N : ℕ, max 1 N₀ ≤ N →
        |signedMobiusInverse f N| ≤ C * (N : ℝ) ^ r := by
    intro f hf hd
    by_contra hbad
    exact hnot ⟨f, hf, hd, hbad⟩
  apply regularMobiusFunctional_not_uniformly_bounded hr
  apply banach_steinhaus
  intro p
  obtain ⟨C, N₀, hc⟩ := hgood (regularSpaceSource p)
    (regularSpaceSource_bounds p).1 (regularSpaceSource_bounds p).2
  let B := max 1 ‖p‖
  have hb : (0 : ℝ) < B := lt_of_lt_of_le (by norm_num) (le_max_left _ _)
  let A := ∑ k ∈ Finset.range (max 1 N₀), ‖regularMobiusFunctional r k p‖
  have hA : 0 ≤ A := Finset.sum_nonneg (fun _ _ => norm_nonneg _)
  refine ⟨A + |B * C|, ?_⟩
  intro N
  by_cases hN : max 1 N₀ ≤ N
  · have hn : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
    have hp := Real.rpow_pos_of_pos hn r
    have hh := hc N hN
    have he := regularMobiusFunctional_scaled_source r N p
    rw [he, Real.norm_eq_abs, abs_div, abs_mul, abs_of_pos hb, abs_of_pos hp]
    have hmul := mul_le_mul_of_nonneg_left hh hb.le
    have hbound : B * |signedMobiusInverse (regularSpaceSource p) N| /
        (N : ℝ) ^ r ≤ B * C := by
      apply (div_le_iff₀ hp).mpr
      nlinarith
    exact hbound.trans (by linarith [le_abs_self (B * C)])
  · have hmem : N ∈ Finset.range (max 1 N₀) := Finset.mem_range.mpr (by omega)
    have hh : ‖regularMobiusFunctional r N p‖ ≤ A :=
      Finset.single_le_sum (f := fun k => ‖regularMobiusFunctional r k p‖)
        (fun _ _ => norm_nonneg _) hmem
    exact hh.trans (le_add_of_nonneg_right (abs_nonneg _))

end BuildingBlocks.RegularSource
