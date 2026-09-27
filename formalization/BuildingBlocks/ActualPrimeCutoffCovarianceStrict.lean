import BuildingBlocks.ActualPrimeCutoffCovarianceFinite
import Mathlib.Analysis.Convex.SpecificFunctions.Pow
import Mathlib.Analysis.Calculus.Deriv.MeanValue

/-!
The full cross-prime covariance sign for the actual cutoff law. A strict
finite-grid ratio inequality is proved by decreasing increment ratios;
that inequality yields increasing integer-dilation weights on all real
cutoffs, including support seams. The cofactor covariance identity then
gives strict negativity for every pair of distinct active primes, retaining
all prime powers. The covariance is zero before either prime enters the
cutoff.

This is an unconditional arithmetic sign, not the combined two-history
sign needed for the Riemann hypothesis.
-/

namespace BuildingBlocks.ActualPrimeCutoffCovarianceStrict
open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
noncomputable section

def A (N : ℕ) : ℝ := ∑ n ∈ Finset.Icc 1 N, (Real.sqrt n)⁻¹
def C (N : ℕ) : ℝ := ∑ n ∈ Finset.Icc 1 N, Real.sqrt n
def T (N : ℕ) : ℝ := C N / A N

private theorem A_succ (N : ℕ) : A (N+1) = A N + (Real.sqrt (N+1 : ℕ))⁻¹ := by
  unfold A
  rw [Finset.sum_Icc_succ_top (by omega)]

private theorem C_succ (N : ℕ) : C (N+1) = C N + Real.sqrt (N+1 : ℕ) := by
  unfold C
  rw [Finset.sum_Icc_succ_top (by omega)]

private theorem A_pos {N : ℕ} (hN : 1 ≤ N) : 0 < A N := by
  unfold A
  apply Finset.sum_pos'
  · intro n hn
    have hn0 : 0 < n := (Finset.mem_Icc.mp hn).1
    have hn0R : (0 : ℝ) < n := by exact_mod_cast hn0
    exact le_of_lt (inv_pos.mpr (Real.sqrt_pos.2 hn0R))
  · exact ⟨1, Finset.mem_Icc.mpr ⟨le_refl _, hN⟩, by simp⟩

private theorem A_integral_bound {N : ℕ} (hN : 1 ≤ N) :
    A N ≤ 2 * Real.sqrt N - 1 := by
  induction N, hN using Nat.le_induction with
  | base => norm_num [A]
  | succ N hN ih =>
      have hs : 0 ≤ Real.sqrt (N : ℝ) := Real.sqrt_nonneg _
      have ht : 0 < Real.sqrt ((N+1 : ℕ) : ℝ) := Real.sqrt_pos.2 (by positivity)
      have hss : (Real.sqrt (N : ℝ))^2 = N := Real.sq_sqrt (by positivity)
      have htt : (Real.sqrt ((N+1 : ℕ) : ℝ))^2 = (N+1 : ℕ) :=
        Real.sq_sqrt (by positivity)
      have hgap : (Real.sqrt ((N+1 : ℕ) : ℝ))⁻¹ ≤
          2 * (Real.sqrt ((N+1 : ℕ) : ℝ) - Real.sqrt (N : ℝ)) := by
        rw [← one_div]
        apply (div_le_iff₀ ht).2
        have hsq := sq_nonneg (Real.sqrt ((N+1 : ℕ) : ℝ) - Real.sqrt (N : ℝ))
        push_cast at htt
        simp only [Nat.cast_add, Nat.cast_one] at hsq ⊢
        nlinarith [hsq]
      rw [A_succ]
      linarith

private theorem C_lt_succ_mul_A {N : ℕ} (hN : 1 ≤ N) :
    C N < (N+1 : ℕ) * A N := by
  unfold C A
  rw [Finset.mul_sum]
  apply Finset.sum_lt_sum
  · intro n hn
    have hn0 : (0 : ℝ) < n := by exact_mod_cast (Finset.mem_Icc.mp hn).1
    have hsq : 0 < Real.sqrt (n : ℝ) := Real.sqrt_pos.2 hn0
    have hsq2 : (Real.sqrt (n : ℝ)) ^ 2 = n := Real.sq_sqrt hn0.le
    have hnn : (n : ℝ) < (N+1 : ℕ) := by exact_mod_cast Nat.lt_succ_of_le (Finset.mem_Icc.mp hn).2
    have hval : Real.sqrt (n : ℝ) = (n : ℝ) * (Real.sqrt (n : ℝ))⁻¹ := by
      apply (eq_div_iff hsq.ne').2
      nlinarith [hsq2]
    exact le_of_lt (calc
      Real.sqrt (n : ℝ) = (n : ℝ) * (Real.sqrt (n : ℝ))⁻¹ := hval
      _ < (N+1 : ℕ) * (Real.sqrt (n : ℝ))⁻¹ :=
        mul_lt_mul_of_pos_right hnn (inv_pos.mpr hsq))
  · refine ⟨1, Finset.mem_Icc.mpr ⟨le_refl _, hN⟩, ?_⟩
    simp
    have : (0 : ℝ) < N := by exact_mod_cast hN
    linarith

private theorem T_succ_gt {N : ℕ} (hN : 1 ≤ N) : T N < T (N+1) := by
  have hA := A_pos hN
  have hAs := A_pos (show 1 ≤ N+1 by omega)
  have hsq : 0 < Real.sqrt (N+1 : ℕ) := Real.sqrt_pos.2 (by positivity)
  have hsq2 : (Real.sqrt (N+1 : ℕ)) ^ 2 = (N+1 : ℕ) := Real.sq_sqrt (by positivity)
  have hcomp := C_lt_succ_mul_A hN
  rw [T, T, A_succ, C_succ]
  have hden : 0 < A N + (Real.sqrt (N+1 : ℕ))⁻¹ :=
    add_pos hA (inv_pos.mpr hsq)
  apply (div_lt_div_iff₀ hA hden).2
  have hkey : C N * (Real.sqrt (N+1 : ℕ))⁻¹ <
      Real.sqrt (N+1 : ℕ) * A N := by
    calc
      C N * (Real.sqrt (N+1 : ℕ))⁻¹ = C N / Real.sqrt (N+1 : ℕ) := by ring
      _ < ((N+1 : ℕ) : ℝ) * A N / Real.sqrt (N+1 : ℕ) :=
        div_lt_div_of_pos_right hcomp hsq
      _ = Real.sqrt (N+1 : ℕ) * A N := by
        apply (div_eq_iff hsq.ne').2
        calc
          ((N+1 : ℕ) : ℝ) * A N = (Real.sqrt (N+1 : ℕ))^2 * A N := by rw [hsq2]
          _ = (Real.sqrt (N+1 : ℕ) * A N) * Real.sqrt (N+1 : ℕ) := by ring
  nlinarith [hkey]

private theorem T_mono_pos {m N : ℕ} (hm : 1 ≤ m) (hmN : m ≤ N) :
    T m ≤ T N := by
  induction N, hmN using Nat.le_induction with
  | base => rfl
  | succ N hmn ih =>
      exact ih.trans (T_succ_gt (hm.trans hmn)).le

/-- The entire dilation comparison (3) follows formally from the strict
finite-grid step (2), proved later in this module by increment ratios. -/
theorem finiteGrid_dilation_of_step
    (hstep : ∀ n, 1 ≤ n → T (n+1) / ((n+2 : ℕ) : ℝ) < T n / ((n+1 : ℕ) : ℝ))
    {a m N : ℕ} (ha : 2 ≤ a) (hm : 1 ≤ m)
    (hlo : a*m ≤ N) (hhi : N < a*(m+1)) :
    T N < (a : ℝ) * T m := by
  let M := a*(m+1)-1
  have hstep' : StrictAnti (fun n : ℕ => T (n+1) / ((n+2 : ℕ) : ℝ)) :=
    strictAnti_nat_of_succ_lt (fun n => by
      simpa [Nat.add_assoc, Nat.add_left_comm, Nat.add_comm] using hstep (n+1) (by omega))
  have hprodpos : 0 < a*(m+1) := Nat.mul_pos (by omega) (by omega)
  have hM : M + 1 = a*(m+1) := by
    dsimp [M]
    omega
  have hNM : N ≤ M := by omega
  have hmul : m ≤ a*m := by
    simpa [mul_comm] using Nat.mul_le_mul_right m (show 1 ≤ a by omega)
  have hmM : m < M := by
    have hexpand : a*(m+1)=a*m+a := by ring
    omega
  have hratio : T M / (((M+1 : ℕ) : ℝ)) < T m / (((m+1 : ℕ) : ℝ)) := by
    have hle : m-1 < M-1 := by omega
    have hh := hstep' hle
    have hMpred : M-1+2=M+1 := by omega
    have hmpred : m-1+2=m+1 := by omega
    simpa only [← Nat.cast_add, hMpred, hmpred,
      Nat.sub_add_cancel (by omega : 1 ≤ m),
      Nat.sub_add_cancel (by omega : 1 ≤ M)] using hh
  have hdenm : (0 : ℝ) < (m+1 : ℕ) := by positivity
  have hdenM : (0 : ℝ) < (M+1 : ℕ) := by positivity
  have hbound : T M < (a : ℝ) * T m := by
    rw [div_lt_div_iff₀ hdenM hdenm, hM] at hratio
    have hcast : (((a*(m+1) : ℕ) : ℝ)) = (a : ℝ) * (m+1 : ℕ) := by push_cast; ring
    rw [hcast] at hratio
    nlinarith [hratio]
  exact (T_mono_pos (by omega : 1 ≤ N) hNM).trans_lt hbound

private theorem cutoffMass_piece {N : ℕ} {x : ℝ}
    (hx : (N : ℝ) ≤ x) : cutoffMass N x = x * A N - C N := by
  unfold cutoffMass A C
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  have hnle : (n : ℝ) ≤ N := by exact_mod_cast (Finset.mem_Icc.mp hn).2
  have hn0 : (0 : ℝ) < n := by
    exact_mod_cast (Finset.mem_Icc.mp hn).1
  have hsn : 0 < Real.sqrt (n : ℝ) := Real.sqrt_pos.2 hn0
  have hss : (Real.sqrt (n : ℝ))^2 = n := Real.sq_sqrt hn0.le
  have hnx : (n : ℝ) ≤ x := hnle.trans hx
  have hweight : cutoffWeight x n = (x-n)/Real.sqrt n := by
    by_cases hlt : (n : ℝ) < x
    · simp [cutoffWeight, hlt]
    · have heq : (n : ℝ) = x := le_antisymm hnx (le_of_not_gt hlt)
      simp [cutoffWeight, heq]
  rw [hweight]
  rw [div_eq_mul_inv]
  have heq : (n : ℝ) * (Real.sqrt (n : ℝ))⁻¹ = Real.sqrt n := by
    field_simp [hsn.ne']
    nlinarith [hss]
  linear_combination -heq

def Ffixed (N a : ℕ) (x : ℝ) : ℝ :=
  (a : ℝ) * cutoffMass N (x/a) / cutoffMass N x

private theorem Ffixed_piece {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hxlo : (N : ℝ) ≤ x)
    (hxhi : x ≤ (N : ℝ)+1) :
    Ffixed N a x =
      (x * A (N/a) - (a : ℝ)*C (N/a)) / (x*A N-C N) := by
  have haR : (0 : ℝ) < a := by exact_mod_cast ha
  have hmle : a*(N/a) ≤ N := Nat.mul_div_le N a
  have hmleR : (a : ℝ) * (N/a : ℕ) ≤ N := by exact_mod_cast hmle
  have hprodle : ((N/a : ℕ) : ℝ) * (a : ℝ) ≤ N := by
    simpa [mul_comm] using hmleR
  have hxdiv : ((N/a : ℕ) : ℝ) ≤ x/a :=
    (le_div_iff₀ haR).2 (hprodle.trans hxlo)
  unfold Ffixed
  rw [← cutoffMass_dilated_stable ha hxhi,
    cutoffMass_piece hxdiv, cutoffMass_piece hxlo]
  congr 1
  have hne : (a : ℝ) ≠ 0 := haR.ne'
  field_simp

/-- Equation (4), in its finite-cell strict-comparison form. Its arithmetic
input is the explicitly named grid step (2), discharged below. -/
theorem Ffixed_strict_cell_of_step
    (hstep : ∀ n, 1 ≤ n → T (n+1) / ((n+2 : ℕ) : ℝ) < T n / ((n+1 : ℕ) : ℝ))
    {N a : ℕ} {x y : ℝ} (ha : 2 ≤ a) (haN : a ≤ N)
    (hx : (N : ℝ) ≤ x) (hxy : x < y) (hy : y ≤ (N : ℝ)+1) :
    Ffixed N a x < Ffixed N a y := by
  let m := N/a
  have ha0 : 0 < a := by omega
  have hm1 : 1 ≤ m := by
    dsimp [m]
    exact (Nat.le_div_iff_mul_le ha0).2 (by simpa using haN)
  have hlo : a*m ≤ N := Nat.mul_div_le N a
  have hhi : N < a*(m+1) := Nat.lt_mul_div_succ N ha0
  have hTN : T N < (a : ℝ)*T m :=
    finiteGrid_dilation_of_step hstep ha hm1 hlo hhi
  have hN1 : 1 ≤ N := le_trans (by omega : 1 ≤ a) haN
  have hAN : 0 < A N := A_pos hN1
  have hAm : 0 < A m := A_pos hm1
  have hTC : C N * A m < (a : ℝ)*C m*A N := by
    apply (div_lt_div_iff₀ hAN hAm).1
    simpa [T, mul_div_assoc] using hTN
  have hxend : x ≤ (N : ℝ)+1 := hxy.le.trans hy
  have hylo : (N : ℝ) ≤ y := hx.trans hxy.le
  have hx1 : 1 < x := by
    have : (2 : ℝ) ≤ N := by exact_mod_cast (ha.trans haN)
    linarith
  have hy1 : 1 < y := hx1.trans hxy
  have hZx : 0 < x*A N-C N := by
    rw [← cutoffMass_piece hx]
    exact cutoffMass_pos hN1 hx1
  have hZy : 0 < y*A N-C N := by
    rw [← cutoffMass_piece hylo]
    exact cutoffMass_pos hN1 hy1
  rw [Ffixed_piece ha0 hx hxend, Ffixed_piece ha0 hylo hy]
  apply (div_lt_div_iff₀ hZx hZy).2
  have hprod : 0 < (y-x) * ((a : ℝ)*C m*A N-C N*A m) :=
    mul_pos (sub_pos.mpr hxy) (sub_pos.mpr hTC)
  nlinarith [hprod]

private theorem Ffixed_stable {M N a : ℕ} {x : ℝ}
    (hMN : M ≤ N) (ha : 1 ≤ a) (hx0 : 0 ≤ x)
    (hx : x ≤ (M : ℝ)+1) : Ffixed N a x = Ffixed M a x := by
  have haR : (1 : ℝ) ≤ a := by exact_mod_cast ha
  have hxa : x / (a : ℝ) ≤ (M : ℝ)+1 :=
    (div_le_self hx0 haR).trans hx
  unfold Ffixed
  rw [cutoffMass_stable hMN hx, cutoffMass_stable hMN hxa]

private theorem Ffixed_strict_cell_cap_of_step
    (hstep : ∀ n, 1 ≤ n → T (n+1) / ((n+2 : ℕ) : ℝ) < T n / ((n+1 : ℕ) : ℝ))
    {K N a : ℕ} {x y : ℝ} (ha : 2 ≤ a) (haN : a ≤ N)
    (hNK : N ≤ K) (hx : (N : ℝ) ≤ x) (hxy : x < y)
    (hy : y ≤ (N : ℝ)+1) :
    Ffixed K a x < Ffixed K a y := by
  have hx0 : 0 ≤ x := by
    have : (0 : ℝ) ≤ N := by positivity
    linarith
  have hy0 : 0 ≤ y := le_trans hx0 hxy.le
  have hxhi : x ≤ (N : ℝ)+1 := hxy.le.trans hy
  rw [Ffixed_stable hNK (by omega : 1 ≤ a) hx0 hxhi,
    Ffixed_stable hNK (by omega : 1 ≤ a) hy0 hy]
  exact Ffixed_strict_cell_of_step hstep ha haN hx hxy hy

/-- Glue the exact closed-cell comparisons across every integer breakpoint.
No differentiability at a cutoff integer is assumed. -/
theorem Ffixed_strict_upto_of_step
    (hstep : ∀ n, 1 ≤ n → T (n+1) / ((n+2 : ℕ) : ℝ) < T n / ((n+1 : ℕ) : ℝ))
    {a B : ℕ} (ha : 2 ≤ a) (haB : a ≤ B) :
    ∀ K, B ≤ K → ∀ x y : ℝ,
      (a : ℝ) ≤ x → x < y → y ≤ (B : ℝ)+1 →
        Ffixed K a x < Ffixed K a y := by
  induction B, haB using Nat.le_induction with
  | base =>
      intro K hK x y hax hxy hy
      exact Ffixed_strict_cell_cap_of_step hstep ha (le_refl a) hK hax hxy hy
  | succ B haB ih =>
      intro K hK x y hax hxy hy
      have hBK : B ≤ K := by omega
      have hB1K : B+1 ≤ K := hK
      by_cases hyB : y ≤ (B : ℝ)+1
      · exact ih K hBK x y hax hxy hyB
      · have hylo : (B+1 : ℕ) < y := by
          have : (B+1 : ℕ) = (B : ℝ)+1 := by push_cast; ring
          exact_mod_cast lt_of_not_ge hyB
        have hcast : ((B+1 : ℕ) : ℝ) = (B : ℝ)+1 := by push_cast; ring
        by_cases hxB : (B+1 : ℕ) ≤ x
        · exact Ffixed_strict_cell_cap_of_step hstep ha (by omega : a ≤ B+1)
            hB1K hxB hxy (by simpa [Nat.cast_add] using hy)
        · have hxlt : x < (B+1 : ℕ) := lt_of_not_ge hxB
          have hleft : Ffixed K a x < Ffixed K a (B+1) :=
            ih K hBK x (B+1) hax (by simpa [hcast] using hxlt)
              (by simp)
          have hright : Ffixed K a (B+1) < Ffixed K a y :=
            Ffixed_strict_cell_cap_of_step hstep ha (by omega : a ≤ B+1)
              hB1K (by simp [hcast]) (by simpa [hcast] using hylo)
              (by simpa [Nat.cast_add] using hy)
          exact hleft.trans hright

private theorem cutoffMass_zero_of_le_one (N : ℕ) {x : ℝ} (hx : x ≤ 1) :
    cutoffMass N x = 0 := by
  unfold cutoffMass
  apply Finset.sum_eq_zero
  intro n hn
  exact cutoffWeight_eq_zero_of_le_one hx (Finset.mem_Icc.mp hn).1

private theorem Ffixed_zero_of_le {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hx : x ≤ a) : Ffixed N a x = 0 := by
  have haR : (0 : ℝ) < a := by exact_mod_cast ha
  have hxa : x/(a : ℝ) ≤ 1 := (div_le_iff₀ haR).2 (by simpa using hx)
  simp [Ffixed, cutoffMass_zero_of_le_one N hxa]

private theorem Ffixed_pos_of_gt {N a : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (ha : 0 < a) (hx : (a : ℝ) < x) :
    0 < Ffixed N a x := by
  have haR : (0 : ℝ) < a := by exact_mod_cast ha
  have hxa : 1 < x/(a : ℝ) := (one_lt_div haR).2 hx
  have hx1 : 1 < x := by
    have ha1 : (1 : ℝ) ≤ a := by exact_mod_cast ha
    linarith
  unfold Ffixed
  exact div_pos (mul_pos haR (cutoffMass_pos hN hxa)) (cutoffMass_pos hN hx1)

/-- All real dilation ratios are nondecreasing on the active finite cutoff,
and strictly increasing once the dilation becomes active. -/
theorem Ffixed_mono_of_step
    (hstep : ∀ n, 1 ≤ n → T (n+1) / ((n+2 : ℕ) : ℝ) < T n / ((n+1 : ℕ) : ℝ))
    {N a : ℕ} {x y : ℝ} (hN : 1 ≤ N) (ha : 2 ≤ a)
    (hxy : x < y) (hy : y ≤ (N : ℝ)+1) :
    Ffixed N a x ≤ Ffixed N a y := by
  by_cases haN : a ≤ N
  · by_cases hya : y ≤ a
    · rw [Ffixed_zero_of_le (by omega : 0 < a) (le_trans hxy.le hya),
          Ffixed_zero_of_le (by omega : 0 < a) hya]
    · have hay : (a : ℝ) < y := lt_of_not_ge hya
      by_cases hxa : x ≤ a
      · rw [Ffixed_zero_of_le (by omega : 0 < a) hxa]
        exact (Ffixed_pos_of_gt hN (by omega : 0 < a) hay).le
      · have hax : (a : ℝ) ≤ x := le_of_not_ge hxa
        exact (Ffixed_strict_upto_of_step hstep ha haN N (le_refl N)
          x y hax hxy hy).le
  · have hNa : N < a := Nat.lt_of_not_ge haN
    have hNaR : (N : ℝ)+1 ≤ a := by exact_mod_cast (show N+1 ≤ a by omega)
    have hya : y ≤ (a : ℝ) := hy.trans hNaR
    rw [Ffixed_zero_of_le (by omega : 0 < a) (hxy.le.trans hya),
        Ffixed_zero_of_le (by omega : 0 < a) hya]

theorem Ffixed_strict_of_step
    (hstep : ∀ n, 1 ≤ n → T (n+1) / ((n+2 : ℕ) : ℝ) < T n / ((n+1 : ℕ) : ℝ))
    {N a : ℕ} {x y : ℝ} (ha : 2 ≤ a) (haN : a ≤ N)
    (hxy : x < y) (hay : (a : ℝ) < y) (hy : y ≤ (N : ℝ)+1) :
    Ffixed N a x < Ffixed N a y := by
  by_cases hxa : x ≤ a
  · rw [Ffixed_zero_of_le (by omega : 0 < a) hxa]
    exact Ffixed_pos_of_gt (le_trans (by omega : 1 ≤ a) haN)
      (by omega : 0 < a) hay
  · exact Ffixed_strict_upto_of_step hstep ha haN N (le_refl N)
      x y (le_of_not_ge hxa) hxy hy

theorem primeMean_eq_log_sum_Ffixed (N J p : ℕ) (x : ℝ) :
    primeMean N J p x =
      Real.log p * ∑ j ∈ Finset.Icc 1 J, Ffixed N (p^j) x := by
  unfold primeMean
  simp only [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  unfold Ffixed
  rw [Nat.cast_pow]
  ring

/-- Equation (5) plus the strict first-power term: the actual full prime
score mean increases as soon as the prime is inside the cutoff. -/
theorem primeMean_strict_of_grid_step
    (hstep : ∀ n, 1 ≤ n → T (n+1) / ((n+2 : ℕ) : ℝ) < T n / ((n+1 : ℕ) : ℝ))
    {N J p : ℕ} {x y : ℝ} (hp : p.Prime) (hJ : 1 ≤ J)
    (hxy : x < y) (hpy : (p : ℝ) < y) (hy : y ≤ (N : ℝ)+1) :
    primeMean N J p x < primeMean N J p y := by
  have hp2 : 2 ≤ p := hp.two_le
  have hpN : p ≤ N := by
    have h : (p : ℝ) < (N+1 : ℕ) := lt_of_lt_of_le hpy (by simpa [Nat.cast_add] using hy)
    have hn : p < N+1 := by exact_mod_cast h
    omega
  have hN1 : 1 ≤ N := le_trans (by omega : 1 ≤ p) hpN
  have hlog : 0 < Real.log (p : ℝ) := Real.log_pos (by exact_mod_cast hp.one_lt)
  rw [primeMean_eq_log_sum_Ffixed, primeMean_eq_log_sum_Ffixed]
  apply mul_lt_mul_of_pos_left _ hlog
  apply Finset.sum_lt_sum
  · intro j hj
    have hj1 : 1 ≤ j := (Finset.mem_Icc.mp hj).1
    have hpow : 2 ≤ p^j :=
      hp2.trans (Nat.le_self_pow (by omega : j ≠ 0) p)
    exact Ffixed_mono_of_step hstep hN1 hpow hxy hy
  · refine ⟨1, Finset.mem_Icc.mpr ⟨le_refl _, hJ⟩, ?_⟩
    simpa using Ffixed_strict_of_step hstep hp2 hpN hxy hpy hy

/-- The original full cutoff score covariance has the published strict
negative sign, conditionally on just the finite-grid inequality (2). All
integer cutoffs, real endpoints, and prime-power terms are handled above. -/
theorem fullCovariance_neg_of_grid_step
    (hstep : ∀ n, 1 ≤ n → T (n+1) / ((n+2 : ℕ) : ℝ) < T n / ((n+1 : ℕ) : ℝ))
    {N p q : ℕ} {x : ℝ} (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q)
    (hpx : (p : ℝ) < x) (hqx : (q : ℝ) < x)
    (hxN : x ≤ (N : ℝ)+1) :
    fullCrossMoment N p q x -
      fullScoreMean N p x * fullScoreMean N q x < 0 := by
  have hpN : p ≤ N := by
    have h : (p : ℝ) < (N+1 : ℕ) := lt_of_lt_of_le hpx (by simpa [Nat.cast_add] using hxN)
    have hn : p < N+1 := by exact_mod_cast h
    omega
  have hN : 1 ≤ N := hp.one_lt.le.trans hpN
  have hx0 : 0 < x := lt_trans (by exact_mod_cast hp.pos) hpx
  have hmono : ∀ j ∈ Finset.Icc 1 N,
      primeMean N N q (x / (p : ℝ) ^ j) ≤ primeMean N N q x := by
    intro j hj
    have hj0 : j ≠ 0 := by
      have := (Finset.mem_Icc.mp hj).1
      omega
    have hpow : 1 < (p : ℝ)^j := by
      exact_mod_cast Nat.one_lt_pow hj0 hp.one_lt
    have hlt : x / (p : ℝ)^j < x := div_lt_self hx0 hpow
    exact (primeMean_strict_of_grid_step hstep hq hN hlt hqx hxN).le
  have hstrict : primeMean N N q (x / p) < primeMean N N q x := by
    have hpR : (1 : ℝ) < p := by exact_mod_cast hp.one_lt
    exact primeMean_strict_of_grid_step hstep hq hN
      (div_lt_self hx0 hpR) hqx hxN
  have hcov := crossCovariance_neg_of_primeMean_monotone hN hN hp.one_lt hpx hmono hstrict
  unfold crossCovariance at hcov
  rw [fullCrossMoment_eq_crossMoment hN hp hq hpq hxN,
      fullScoreMean_eq_primeMean hp hxN,
      fullScoreMean_eq_primeMean hq hxN]
  exact hcov

end
end BuildingBlocks.ActualPrimeCutoffCovarianceStrict

#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceStrict.T_succ_gt
#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceStrict.A_integral_bound
#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceStrict.finiteGrid_dilation_of_step
#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceStrict.Ffixed_strict_cell_of_step
#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceStrict.primeMean_strict_of_grid_step
#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceStrict.fullCovariance_neg_of_grid_step


namespace BuildingBlocks.ActualPrimeCutoffCovarianceStrict

noncomputable section

private theorem grid_A_succ (N : ℕ) :
    A (N+1) = A N + (Real.sqrt (N+1 : ℕ))⁻¹ := by
  unfold A
  rw [Finset.sum_Icc_succ_top (by omega)]

private theorem grid_C_succ (N : ℕ) :
    C (N+1) = C N + Real.sqrt (N+1 : ℕ) := by
  unfold C
  rw [Finset.sum_Icc_succ_top (by omega)]

private theorem grid_A_bound {N : ℕ} (hN : 1 ≤ N) :
    A N ≤ 2 * Real.sqrt N - 1 := by
  induction N, hN using Nat.le_induction with
  | base => norm_num [A]
  | succ N hN ih =>
      have hs : 0 ≤ Real.sqrt (N : ℝ) := Real.sqrt_nonneg _
      have ht : 0 < Real.sqrt ((N+1 : ℕ) : ℝ) := Real.sqrt_pos.2 (by positivity)
      have hss : (Real.sqrt (N : ℝ))^2 = N := Real.sq_sqrt (by positivity)
      have htt : (Real.sqrt ((N+1 : ℕ) : ℝ))^2 = (N+1 : ℕ) :=
        Real.sq_sqrt (by positivity)
      have hgap : (Real.sqrt ((N+1 : ℕ) : ℝ))⁻¹ ≤
          2 * (Real.sqrt ((N+1 : ℕ) : ℝ) - Real.sqrt (N : ℝ)) := by
        rw [← one_div]
        apply (div_le_iff₀ ht).2
        have hsq := sq_nonneg (Real.sqrt ((N+1 : ℕ) : ℝ) - Real.sqrt (N : ℝ))
        push_cast at htt
        simp only [Nat.cast_add, Nat.cast_one] at hsq ⊢
        nlinarith [hsq]
      rw [grid_A_succ]
      linarith

private theorem grid_threshold {r s t : ℝ}
    (hr : 1 ≤ r) (hrs : r < s) (hst : s < t)
    (hsq : s^2 = r^2+1) (htq : t^2=s^2+1) :
    2*r-1 < (s+t)*(1-1/(s*t)) := by
  have hs : 0 < s := lt_of_le_of_lt (by linarith : 0 ≤ r) hrs
  have ht : 0 < t := hs.trans hst
  have hgap : 1/s ≤ 2*(s-r) := by
    apply (div_le_iff₀ hs).2
    nlinarith [sq_nonneg (s-r)]
  have hinv1 : 1/s ≤ 1 := by
    apply (div_le_iff₀ hs).2
    linarith
  have hinv2 : 1/t < 1/s := by
    apply (div_lt_div_iff₀ ht hs).2
    linarith
  have hident : (s+t)*(1-1/(s*t)) = s+t-1/s-1/t := by
    field_simp
    ring
  rw [hident]
  linarith

private def grid_h (n : ℕ) : ℝ := A n / Real.sqrt (n+1) + 1/(n+1 : ℕ)

private theorem grid_h_strict_succ (n : ℕ) : grid_h n < grid_h (n+1) := by
  by_cases hn : n = 0
  · subst n
    norm_num [grid_h, A]
    have hs2 : (Real.sqrt 2)^2 = (2 : ℝ) := Real.sq_sqrt (by norm_num)
    have hslt : Real.sqrt 2 < 2 := by
      nlinarith [Real.sqrt_nonneg (2 : ℝ)]
    have hsinv : (Real.sqrt 2)⁻¹ > 1/2 := by
      rw [inv_eq_one_div]
      apply (div_lt_div_iff₀ (by norm_num : (0 : ℝ) < 2)
        (Real.sqrt_pos.2 (by norm_num : (0 : ℝ) < 2))).2
      linarith
    linarith
  · have hn1 : 1 ≤ n := by omega
    let r : ℝ := Real.sqrt n
    let s : ℝ := Real.sqrt (n+1)
    let t : ℝ := Real.sqrt (n+2)
    have hr : 1 ≤ r := by
      dsimp [r]
      have hnR : (1 : ℝ) ≤ n := by exact_mod_cast hn1
      nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ n by positivity),
        Real.sqrt_nonneg (n : ℝ)]
    have hrs : r < s := by
      dsimp [r, s]
      exact Real.sqrt_lt_sqrt (by positivity) (by exact_mod_cast Nat.lt_succ_self n)
    have hst : s < t := by
      dsimp [s, t]
      exact Real.sqrt_lt_sqrt (by positivity) (by exact_mod_cast Nat.lt_succ_self (n+1))
    have hs : 0 < s := lt_of_le_of_lt (by linarith : 0 ≤ r) hrs
    have ht : 0 < t := hs.trans hst
    have hsq : s^2 = r^2+1 := by
      dsimp [r, s]
      rw [Real.sq_sqrt (by positivity), Real.sq_sqrt (by positivity)]
    have htq : t^2 = s^2+1 := by
      dsimp [s, t]
      rw [Real.sq_sqrt (by positivity), Real.sq_sqrt (by positivity)]
      push_cast
      ring
    have hA : A n < (s+t)*(1-1/(s*t)) :=
      (grid_A_bound hn1).trans_lt (grid_threshold hr hrs hst hsq htq)
    have hfac : grid_h (n+1)-grid_h n =
        (1/s-1/t)*((s+t)*(1-1/(s*t))-A n) := by
      have halg : (A n+1/s)/t+1/t^2-(A n/s+1/s^2) =
          (1/s-1/t)*((s+t)*(1-1/(s*t))-A n) := by
        have hdiff :
            ((A n+1/s)/t+1/t^2-(A n/s+1/s^2)) -
              ((1/s-1/t)*((s+t)*(1-1/(s*t))-A n)) =
                (s^2+1-t^2)/(s*t) := by
          field_simp
          ring
        have hzero : (s^2+1-t^2)/(s*t)=0 := by rw [htq]; ring
        rw [hzero] at hdiff
        exact sub_eq_zero.mp hdiff
      have hleft : grid_h (n+1)-grid_h n =
          (A n+1/s)/t+1/t^2-(A n/s+1/s^2) := by
        unfold grid_h
        rw [grid_A_succ]
        have hsEq : Real.sqrt ((n+1 : ℕ) : ℝ) = s := by
          dsimp [s]
          push_cast
          ring
        have hsEq' : Real.sqrt ((n : ℝ)+1) = s := rfl
        have htEq : Real.sqrt (((n+1 : ℕ) : ℝ)+1) = t := by
          dsimp [t]
          congr 1
          push_cast
          ring
        have hsN : (((n+1 : ℕ) : ℝ)) = s^2 := by
          dsimp [s]
          rw [Real.sq_sqrt (by positivity)]
          push_cast
          ring
        have htN : (((n+1+1 : ℕ) : ℝ)) = t^2 := by
          dsimp [t]
          rw [Real.sq_sqrt (by positivity)]
          push_cast
          ring
        rw [hsEq, hsEq', htEq, hsN, htN]
        simp [one_div]
      exact hleft.trans halg
    have hfactor : 0 < 1/s-1/t := by
      apply sub_pos.mpr
      apply (div_lt_div_iff₀ ht hs).2
      linarith
    have := mul_pos hfactor (sub_pos.mpr hA)
    linarith

private theorem grid_A_nonneg (n : ℕ) : 0 ≤ A n := by
  unfold A
  apply Finset.sum_nonneg
  intro k hk
  exact inv_nonneg.mpr (Real.sqrt_nonneg _)

private theorem grid_A_pos {n : ℕ} (hn : 1 ≤ n) : 0 < A n := by
  unfold A
  apply Finset.sum_pos'
  · intro k hk
    exact inv_nonneg.mpr (Real.sqrt_nonneg _)
  · refine ⟨1, Finset.mem_Icc.mpr ⟨le_refl _, hn⟩, ?_⟩
    norm_num

private def grid_D (n : ℕ) : ℝ := (n+1)*A n
private def grid_R (n : ℕ) : ℝ := 1/(1+grid_h n)

private theorem grid_D_pos {n : ℕ} (hn : 1 ≤ n) : 0 < grid_D n := by
  unfold grid_D
  exact mul_pos (by positivity) (grid_A_pos hn)

private theorem grid_h_nonneg (n : ℕ) : 0 ≤ grid_h n := by
  unfold grid_h
  exact add_nonneg (div_nonneg (grid_A_nonneg n) (Real.sqrt_nonneg _)) (by positivity)

private theorem grid_R_pos (n : ℕ) : 0 < grid_R n := by
  unfold grid_R
  exact div_pos (by norm_num) (by linarith [grid_h_nonneg n])

private theorem grid_R_strict_succ (n : ℕ) : grid_R (n+1) < grid_R n := by
  unfold grid_R
  apply (div_lt_div_iff₀ (by linarith [grid_h_nonneg (n+1)])
    (by linarith [grid_h_nonneg n])).2
  linarith [grid_h_strict_succ n]

private theorem grid_D_increment (n : ℕ) :
    grid_D (n+1)-grid_D n = (1+grid_h n)*Real.sqrt (n+1 : ℕ) := by
  have hs : 0 < Real.sqrt (n+1 : ℕ) := Real.sqrt_pos.2 (by positivity)
  have hs2 : (Real.sqrt (n+1 : ℕ))^2 = (n+1 : ℕ) := Real.sq_sqrt (by positivity)
  let s : ℝ := Real.sqrt (n+1 : ℕ)
  have hsn : s ≠ 0 := by exact ne_of_gt hs
  have hnum : (((n+1+1 : ℕ) : ℝ)) = s^2+1 := by
    dsimp [s]
    rw [hs2]
    push_cast
    ring
  have hden : (((n+1 : ℕ) : ℝ)) = s^2 := hs2.symm
  calc
    grid_D (n+1)-grid_D n = A n + ((n+1+1 : ℕ) : ℝ)/s := by
      unfold grid_D
      rw [grid_A_succ]
      dsimp [s]
      simp only [Nat.cast_add, Nat.cast_one]
      ring
    _ = A n+s+1/s := by
      rw [hnum]
      field_simp [hsn]
      ring
    _ = (1+grid_h n)*Real.sqrt (n+1 : ℕ) := by
      unfold grid_h
      have hsEq : Real.sqrt ((n : ℝ)+1) = s := by
        dsimp [s]
        push_cast
        ring
      have hsEq' : Real.sqrt ((n+1 : ℕ) : ℝ) = s := by
        dsimp [s]
      rw [hsEq, hsEq', hden]
      change A n+s+1/s = (1+(A n/s+1/s^2))*s
      field_simp [hsn]
      ring

private theorem grid_D_increment_pos (n : ℕ) :
    0 < grid_D (n+1)-grid_D n := by
  rw [grid_D_increment]
  exact mul_pos (by linarith [grid_h_nonneg n])
    (Real.sqrt_pos.2 (by positivity))

private theorem grid_increment_ratio (n : ℕ) :
    (C (n+1)-C n)/(grid_D (n+1)-grid_D n) = grid_R n := by
  rw [grid_C_succ, grid_D_increment]
  have hs : Real.sqrt (n+1 : ℕ) ≠ 0 := (Real.sqrt_pos.2 (by positivity)).ne'
  unfold grid_R
  rw [add_sub_cancel_left]
  field_simp

private theorem grid_ratio_update {x y a b : ℝ}
    (hy : 0 < y) (hb : 0 < b) (h : a/b < x/y) :
    a/b < (x+a)/(y+b) ∧ (x+a)/(y+b) < x/y := by
  have hk : a*y < x*b := (div_lt_div_iff₀ hb hy).1 h
  constructor
  · apply (div_lt_div_iff₀ hb (add_pos hy hb)).2
    nlinarith
  · apply (div_lt_div_iff₀ (add_pos hy hb) hy).2
    nlinarith

private theorem grid_R_lt_average {n : ℕ} (hn : 1 ≤ n) :
    grid_R n < C n / grid_D n := by
  induction n, hn using Nat.le_induction with
  | base =>
      have hbase : grid_R 0 = C 1 / grid_D 1 := by
        norm_num [grid_R, grid_h, grid_D, A, C]
      exact (grid_R_strict_succ 0).trans_eq hbase
  | succ n hn ih =>
      have hinc : (C (n+1)-C n)/(grid_D (n+1)-grid_D n) <
          C n/grid_D n := by
        rw [grid_increment_ratio]
        exact ih
      have hup := grid_ratio_update (grid_D_pos hn)
        (grid_D_increment_pos n) hinc
      have hnext : grid_R n < C (n+1)/grid_D (n+1) := by
        rw [← grid_increment_ratio]
        convert hup.1 using 1 <;> ring
      exact (grid_R_strict_succ n).trans hnext

private theorem grid_average_eq_T {n : ℕ} (hn : 1 ≤ n) :
    C n/grid_D n = T n/((n+1 : ℕ):ℝ) := by
  unfold grid_D T
  have hA : A n ≠ 0 := (grid_A_pos hn).ne'
  have hn1 : (((n+1 : ℕ) : ℝ)) ≠ 0 := by positivity
  field_simp [hA, hn1]
  push_cast
  ring

/-- Strict finite-grid step, via increasing h and decreasing increment ratios. -/
theorem finiteGrid_step_increment (N : ℕ) (hN : 1 ≤ N) :
    T (N+1) / ((N+2 : ℕ) : ℝ) < T N / ((N+1 : ℕ) : ℝ) := by
  have hinc : (C (N+1)-C N)/(grid_D (N+1)-grid_D N) <
      C N/grid_D N := by
    rw [grid_increment_ratio]
    exact grid_R_lt_average hN
  have hup := grid_ratio_update (grid_D_pos hN)
    (grid_D_increment_pos N) hinc
  have hval : C (N+1)/grid_D (N+1) < C N/grid_D N := by
    convert hup.2 using 1 <;> ring
  rw [grid_average_eq_T (by omega : 1 ≤ N+1), grid_average_eq_T hN] at hval
  convert hval using 1 <;> congr 1 <;> omega

#print axioms finiteGrid_step_increment

end
end BuildingBlocks.ActualPrimeCutoffCovarianceStrict


namespace BuildingBlocks.ActualPrimeCutoffCovarianceStrict
open BuildingBlocks.ActualPrimeCutoffCovarianceFinite

noncomputable section

/-- Original full-score strict covariance, with the finite-grid step discharged. -/
theorem fullCovariance_neg_grid_integrated
    {N p q : ℕ} {x : ℝ} (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q)
    (hpx : (p : ℝ) < x) (hqx : (q : ℝ) < x)
    (hxN : x ≤ (N : ℝ)+1) :
    fullCrossMoment N p q x -
      fullScoreMean N p x * fullScoreMean N q x < 0 :=
  fullCovariance_neg_of_grid_step
    (fun n hn => finiteGrid_step_increment n hn) hp hq hpq hpx hqx hxN

end
end BuildingBlocks.ActualPrimeCutoffCovarianceStrict

#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceStrict.fullCovariance_neg_grid_integrated


namespace BuildingBlocks.ActualPrimeCutoffCovarianceStrict

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite

noncomputable section

private theorem fullPrimeScore_zero_of_lt {p n : ℕ}
    (hnp : n < p) : fullPrimeScore p n = 0 := by
  simp [fullPrimeScore, Nat.factorization_eq_zero_of_lt hnp]

private theorem weighted_score_zero_of_cutoff {x : ℝ} {p n : ℕ}
    (hxp : x ≤ (p : ℝ)) :
    cutoffWeight x n * fullPrimeScore p n = 0 := by
  by_cases hnx : (n : ℝ) < x
  · have hnp : n < p := by exact_mod_cast (lt_of_lt_of_le hnx hxp)
    rw [fullPrimeScore_zero_of_lt hnp]
    ring
  · simp [cutoffWeight, hnx]

private theorem fullScoreMean_zero_of_cutoff {N p : ℕ} {x : ℝ}
    (hxp : x ≤ (p : ℝ)) : fullScoreMean N p x = 0 := by
  unfold fullScoreMean
  have hs : (∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * fullPrimeScore p n) = 0 := by
    apply Finset.sum_eq_zero
    intro n hn
    exact weighted_score_zero_of_cutoff hxp
  rw [hs]
  simp

private theorem fullCrossMoment_zero_left {N p q : ℕ} {x : ℝ}
    (hxp : x ≤ (p : ℝ)) : fullCrossMoment N p q x = 0 := by
  unfold fullCrossMoment
  have hs : (∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * fullPrimeScore p n * fullPrimeScore q n) = 0 := by
    apply Finset.sum_eq_zero
    intro n hn
    rw [weighted_score_zero_of_cutoff hxp]
    ring
  rw [hs]
  simp

/-- The full prime-power cross covariance vanishes when either score is
inactive on the actual cutoff support. No prime hypothesis is needed. -/
theorem fullCovariance_zero_before_either_prime
    {N p q : ℕ} {x : ℝ}
    (h : x ≤ (p : ℝ) ∨ x ≤ (q : ℝ)) :
    fullCrossMoment N p q x -
      fullScoreMean N p x * fullScoreMean N q x = 0 := by
  rcases h with hxp | hxq
  · rw [fullCrossMoment_zero_left hxp, fullScoreMean_zero_of_cutoff hxp]
    ring
  · have hcross : fullCrossMoment N p q x = fullCrossMoment N q p x := by
      unfold fullCrossMoment
      congr 1
      apply Finset.sum_congr rfl
      intro n hn
      ring
    rw [hcross, fullCrossMoment_zero_left hxq, fullScoreMean_zero_of_cutoff hxq]
    ring

end
end BuildingBlocks.ActualPrimeCutoffCovarianceStrict

#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceStrict.fullCovariance_zero_before_either_prime
