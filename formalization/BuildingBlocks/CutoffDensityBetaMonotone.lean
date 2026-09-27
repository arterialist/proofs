import BuildingBlocks.DensityPrimeCovarianceFinite
import Mathlib.Tactic

/-!
The actual cutoff density mean `E_x(x/n - 1)` increases strictly for every
real `x > 1`, across changes of integer support. The proof reduces each
fixed-support interval to a rational function in three reciprocal-root sums,
checks the small supports by exact rational intervals, and proves the large
supports by induction. It removes the monotonicity premise from the finite
full prime-power density/prime covariance theorem and sums the signs over
all prime colors in the original cutoff law. The zero covariance before a
prime enters the cutoff is also checked.

These are unconditional arithmetic signs. They do not prove the combined
two-history sign or the Riemann hypothesis.
-/

namespace BuildingBlocks.CutoffDensityBetaMonotone

noncomputable section

/-- An exact monotonicity transfer for the rational cutoff-density mean. -/
theorem rational_beta_strict_of_twice_center
    {A B C x y : ℝ}
    (hA : 0 < A) (hB : 0 < B) (hC : 0 < C)
    (hx : 0 < x * A - C) (hD : 0 ≤ x * A - 2 * C) (hxy : x < y) :
    (x ^ 2 * B - 2 * x * A + C) / (x * A - C) <
      (y ^ 2 * B - 2 * y * A + C) / (y * A - C) := by
  have hy : 0 < y * A - C := by nlinarith [mul_pos (sub_pos.mpr hxy) hA]
  have hxpos : 0 < x := by nlinarith [hA, hC, hx]
  have hH : 0 < x ^ 2 * A * B - 2 * x * B * C + A * C := by
    have h0 : 0 ≤ x * B * (x * A - 2 * C) := mul_nonneg (mul_nonneg hxpos.le hB.le) hD
    have h1 : 0 < A * C := mul_pos hA hC
    nlinarith
  have hbr : 0 < A * B * x * y - B * C * (x + y) + A * C := by
    have h0 : 0 < B * (y-x) * (x*A-C) := mul_pos (mul_pos hB (sub_pos.mpr hxy)) hx
    nlinarith [hH]
  apply (div_lt_div_iff₀ hx hy).2
  have hfac : 0 < (y-x) * (A * B * x * y - B * C * (x+y) + A*C) := mul_pos (sub_pos.mpr hxy) hbr
  nlinarith [hfac]

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone

noncomputable section

private def A (N : ℕ) : ℝ := ∑ k ∈ Finset.range N, 1 / Real.sqrt (k + 1 : ℕ)
private def B (N : ℕ) : ℝ := ∑ k ∈ Finset.range N, 1 / ((k + 1 : ℕ) * Real.sqrt (k + 1 : ℕ))
private def C (N : ℕ) : ℝ := ∑ k ∈ Finset.range N, Real.sqrt (k + 1 : ℕ)
private def D (N : ℕ) : ℝ := (N : ℝ) * A N - 2 * C N

private theorem A_succ (N : ℕ) : A (N+1) = A N + 1 / Real.sqrt (N+1 : ℕ) := by
  simp [A, Finset.sum_range_succ]
private theorem B_succ (N : ℕ) : B (N+1) = B N + 1 / ((N+1 : ℕ) * Real.sqrt (N+1 : ℕ)) := by
  simp [B, Finset.sum_range_succ]
private theorem C_succ (N : ℕ) : C (N+1) = C N + Real.sqrt (N+1 : ℕ) := by
  simp [C, Finset.sum_range_succ]
private theorem A_pos {N : ℕ} (hN : 0 < N) : 0 < A N := by
  calc
    0 < ∑ k ∈ Finset.range N, (1 : ℝ) / Real.sqrt (k+1 : ℕ) := by
      apply Finset.sum_pos'
      · intro k hk
        positivity
      · exact ⟨0, Finset.mem_range.mpr hN, by norm_num⟩
    _ = A N := rfl
private theorem B_pos {N : ℕ} (hN : 0 < N) : 0 < B N := by
  calc
    0 < ∑ k ∈ Finset.range N, (1 : ℝ) / ((k+1 : ℕ) * Real.sqrt (k+1 : ℕ)) := by
      apply Finset.sum_pos'
      · intro k hk
        positivity
      · exact ⟨0, Finset.mem_range.mpr hN, by norm_num⟩
    _ = B N := rfl
private theorem C_pos {N : ℕ} (hN : 0 < N) : 0 < C N := by
  calc
    0 < ∑ k ∈ Finset.range N, Real.sqrt (k+1 : ℕ) := by
      apply Finset.sum_pos'
      · intro k hk
        positivity
      · exact ⟨0, Finset.mem_range.mpr hN, by norm_num⟩
    _ = C N := rfl

private theorem D_succ (N : ℕ) : D (N+1) = D N + A N - Real.sqrt (N+1 : ℕ) := by
  have hsq : Real.sqrt (N+1 : ℕ) ^ 2 = (N+1 : ℕ) := by
    rw [Real.sq_sqrt] <;> positivity
  simp only [Nat.cast_add, Nat.cast_one] at hsq
  have hs : Real.sqrt (N+1 : ℕ) ≠ 0 := by positivity
  rw [D, A_succ, C_succ, D]
  push_cast
  field_simp
  nlinarith [hsq]

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem A_three_gt_two : (2 : ℝ) < A 3 := by
  have hs2 : Real.sqrt (2:ℝ) < 3/2 := by
    nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2), Real.sqrt_nonneg 2]
  have hs3 : Real.sqrt (3:ℝ) < 2 := by
    nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 3), Real.sqrt_nonneg 3]
  have ht2 : (2/3:ℝ) < 1 / Real.sqrt 2 := by
    apply (div_lt_div_iff₀ (by norm_num : (0:ℝ)<3) (Real.sqrt_pos.2 (by norm_num))).2
    nlinarith [hs2]
  have ht3 : (1/2:ℝ) < 1 / Real.sqrt 3 := by
    apply (div_lt_div_iff₀ (by norm_num : (0:ℝ)<2) (Real.sqrt_pos.2 (by norm_num))).2
    nlinarith [hs3]
  have hh : (2:ℝ) < 1 + 1 / Real.sqrt 2 + 1 / Real.sqrt 3 := by linarith
  convert hh using 1 <;> norm_num [A, Finset.sum_range_succ]

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem A_gt_next_sqrt {N : ℕ} (hN : 3 ≤ N) :
    Real.sqrt (N+1 : ℕ) < A N := by
  induction N, hN using Nat.le_induction with
  | base =>
      convert A_three_gt_two using 1 <;> norm_num
  | succ N hN ih =>
      rw [A_succ]
      have hs : 0 < Real.sqrt (N+1 : ℕ) := by positivity
      have hu : 0 < 1 / Real.sqrt (N+1 : ℕ) := by positivity
      have ht : 0 ≤ Real.sqrt (N+2 : ℕ) := Real.sqrt_nonneg _
      have hsq1 : Real.sqrt (N+1 : ℕ)^2 = (N:ℝ)+1 := by
        rw [Real.sq_sqrt (by positivity)]
        push_cast
        ring
      have hsq2 : Real.sqrt (N+2 : ℕ)^2 = (N:ℝ)+2 := by
        rw [Real.sq_sqrt (by positivity)]
        push_cast
        ring
      have hmul : Real.sqrt (N+1 : ℕ) * (1 / Real.sqrt (N+1 : ℕ)) = 1 := by
        field_simp
      have hstep : Real.sqrt (N+2 : ℕ) <
          Real.sqrt (N+1 : ℕ) + 1 / Real.sqrt (N+1 : ℕ) := by
        nlinarith [sq_nonneg (1 / Real.sqrt (N+1 : ℕ))]
      exact lt_trans hstep (add_lt_add_right ih _)

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem D_six_formula : D 6 = 3 + Real.sqrt 2 - 4 * Real.sqrt 5 / 5 - Real.sqrt 6 := by
  have hinv (z : ℝ) (hz : 0 < z) : (Real.sqrt z)⁻¹ = Real.sqrt z / z := by
    have hs : Real.sqrt z ^ 2 = z := Real.sq_sqrt hz.le
    have hp : Real.sqrt z ≠ 0 := (Real.sqrt_pos.2 hz).ne'
    field_simp
    nlinarith [hs]
  norm_num [D, A, C, Finset.sum_range_succ]
  rw [hinv 2 (by norm_num), hinv 3 (by norm_num), hinv 5 (by norm_num),
      hinv 6 (by norm_num)]
  ring

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem D_six_pos : 0 < D 6 := by
  have h2 : (7/5:ℝ) < Real.sqrt 2 := by
    nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2), Real.sqrt_nonneg 2]
  have h5 : Real.sqrt 5 < (9/4:ℝ) := by
    nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 5), Real.sqrt_nonneg 5]
  have h6 : Real.sqrt 6 < (5/2:ℝ) := by
    nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 6), Real.sqrt_nonneg 6]
  rw [D_six_formula]
  linarith

private theorem D_pos_of_six {N : ℕ} (hN : 6 ≤ N) : 0 < D N := by
  induction N, hN using Nat.le_induction with
  | base => exact D_six_pos
  | succ N hN ih =>
      rw [D_succ]
      have hA : Real.sqrt (N+1 : ℕ) < A N := A_gt_next_sqrt (by omega)
      linarith

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

/-- The actual density mean on a fixed integer support. -/
def betaOnSupport (N : ℕ) (x : ℝ) : ℝ :=
  (x ^ 2 * B N - 2 * x * A N + C N) / (x * A N - C N)

/-- Unconditional strict monotonicity on every fixed support with at least six terms.
This theorem uses the actual reciprocal-square-root weights. -/
theorem betaOnSupport_strict_of_six {N : ℕ} {x y : ℝ}
    (hN : 6 ≤ N) (hx : (N:ℝ) ≤ x) (hxy : x < y) :
    betaOnSupport N x < betaOnSupport N y := by
  have hA : 0 < A N := A_pos (by omega)
  have hB : 0 < B N := B_pos (by omega)
  have hC : 0 < C N := C_pos (by omega)
  have hD : 0 < (N:ℝ) * A N - 2 * C N := D_pos_of_six hN
  have hxD : 0 ≤ x * A N - 2 * C N := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hx) hA.le]
  have hxden : 0 < x * A N - C N := by linarith
  exact rational_beta_strict_of_twice_center hA hB hC hxden hxD hxy

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem small_root_intervals :
    (1414/1000:ℝ) < Real.sqrt 2 ∧ Real.sqrt 2 < (1415/1000:ℝ) ∧
    (1732/1000:ℝ) < Real.sqrt 3 ∧ Real.sqrt 3 < (1733/1000:ℝ) ∧
    (2236/1000:ℝ) < Real.sqrt 5 ∧ Real.sqrt 5 < (2237/1000:ℝ) := by
  have h2 := Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)
  have h3 := Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 3)
  have h5 := Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 5)
  have h2n := Real.sqrt_nonneg (2:ℝ)
  have h3n := Real.sqrt_nonneg (3:ℝ)
  have h5n := Real.sqrt_nonneg (5:ℝ)
  constructor
  · nlinarith
  constructor
  · nlinarith
  constructor
  · nlinarith
  constructor
  · nlinarith
  constructor
  · nlinarith
  · nlinarith

private theorem small_inv_intervals :
    (706/1000:ℝ) < 1 / Real.sqrt 2 ∧ 1 / Real.sqrt 2 < (708/1000:ℝ) ∧
    (577/1000:ℝ) < 1 / Real.sqrt 3 ∧ 1 / Real.sqrt 3 < (578/1000:ℝ) ∧
    (447/1000:ℝ) < 1 / Real.sqrt 5 ∧ 1 / Real.sqrt 5 < (448/1000:ℝ) := by
  rcases small_root_intervals with ⟨h2l,h2u,h3l,h3u,h5l,h5u⟩
  have hs2 : 0 < Real.sqrt (2:ℝ) := by positivity
  have hs3 : 0 < Real.sqrt (3:ℝ) := by positivity
  have hs5 : 0 < Real.sqrt (5:ℝ) := by positivity
  constructor
  · apply (lt_div_iff₀ hs2).2
    nlinarith
  constructor
  · apply (div_lt_iff₀ hs2).2
    nlinarith
  constructor
  · apply (lt_div_iff₀ hs3).2
    nlinarith
  constructor
  · apply (div_lt_iff₀ hs3).2
    nlinarith
  constructor
  · apply (lt_div_iff₀ hs5).2
    nlinarith
  · apply (div_lt_iff₀ hs5).2
    nlinarith

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem H_pos_of_intervals
    {t A B C al bl bu cl cu : ℝ}
    (ht : 0 ≤ t) (hal : 0 ≤ al) (hbl : 0 ≤ bl) (hcl : 0 ≤ cl)
    (hbu : 0 ≤ bu) (hcu : 0 ≤ cu)
    (hA : al ≤ A) (hBl : bl ≤ B) (hBu : B ≤ bu)
    (hCl : cl ≤ C) (hCu : C ≤ cu)
    (hcert : 0 < t^2 * al * bl - 2*t*bu*cu + al*cl) :
    0 < t^2 * A * B - 2*t*B*C + A*C := by
  have hAB : al * bl ≤ A * B := mul_le_mul hA hBl hbl (le_trans hal hA)
  have hBC : B * C ≤ bu * cu := mul_le_mul hBu hCu (le_trans hcl hCl) hbu
  have hAC : al * cl ≤ A * C := mul_le_mul hA hCl hcl (le_trans hal hA)
  have hABs : t^2 * (al*bl) ≤ t^2 * (A*B) := mul_le_mul_of_nonneg_left hAB (sq_nonneg t)
  have hBCs : (2*t) * (B*C) ≤ (2*t)*(bu*cu) :=
    mul_le_mul_of_nonneg_left hBC (by positivity)
  nlinarith

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem small_two_bounds :
    (1706/1000:ℝ) ≤ A 2 ∧ (1353/1000:ℝ) ≤ B 2 ∧ B 2 ≤ (1354/1000:ℝ) ∧
    (2414/1000:ℝ) ≤ C 2 ∧ C 2 ≤ (2415/1000:ℝ) := by
  rcases small_root_intervals with ⟨r2l,r2u,_,_,_,_⟩
  rcases small_inv_intervals with ⟨i2l,i2u,_,_,_,_⟩
  simp only [one_div] at i2l i2u
  constructor
  · norm_num [A, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [B, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [B, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [C, Finset.sum_range_succ]
    linarith
  · norm_num [C, Finset.sum_range_succ]
    linarith

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem small_three_bounds :
    (2283/1000:ℝ) ≤ A 3 ∧ (1545/1000:ℝ) ≤ B 3 ∧ B 3 ≤ (1547/1000:ℝ) ∧
    (4146/1000:ℝ) ≤ C 3 ∧ C 3 ≤ (4148/1000:ℝ) := by
  rcases small_root_intervals with ⟨r2l,r2u,r3l,r3u,_,_⟩
  rcases small_inv_intervals with ⟨i2l,i2u,i3l,i3u,_,_⟩
  simp only [one_div] at i2l i2u i3l i3u
  constructor
  · norm_num [A, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [B, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [B, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [C, Finset.sum_range_succ]
    linarith
  · norm_num [C, Finset.sum_range_succ]
    linarith

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem small_four_bounds :
    (2783/1000:ℝ) ≤ A 4 ∧ (1670/1000:ℝ) ≤ B 4 ∧ B 4 ≤ (1672/1000:ℝ) ∧
    (6146/1000:ℝ) ≤ C 4 ∧ C 4 ≤ (6148/1000:ℝ) := by
  rcases small_root_intervals with ⟨r2l,r2u,r3l,r3u,_,_⟩
  rcases small_inv_intervals with ⟨i2l,i2u,i3l,i3u,_,_⟩
  simp only [one_div] at i2l i2u i3l i3u
  constructor
  · norm_num [A, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [B, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [B, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [C, Finset.sum_range_succ]
    linarith
  · norm_num [C, Finset.sum_range_succ]
    linarith

private theorem small_five_bounds :
    (3230/1000:ℝ) ≤ A 5 ∧ (1759/1000:ℝ) ≤ B 5 ∧ B 5 ≤ (1762/1000:ℝ) ∧
    (8382/1000:ℝ) ≤ C 5 ∧ C 5 ≤ (8385/1000:ℝ) := by
  rcases small_root_intervals with ⟨r2l,r2u,r3l,r3u,r5l,r5u⟩
  rcases small_inv_intervals with ⟨i2l,i2u,i3l,i3u,i5l,i5u⟩
  simp only [one_div] at i2l i2u i3l i3u i5l i5u
  constructor
  · norm_num [A, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [B, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [B, Finset.sum_range_succ]
    linarith
  constructor
  · norm_num [C, Finset.sum_range_succ]
    linarith
  · norm_num [C, Finset.sum_range_succ]
    linarith

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem H_two_pos :
    0 < (2:ℝ)^2 * A 2 * B 2 - 2*2*B 2*C 2 + A 2*C 2 := by
  rcases small_two_bounds with ⟨ha,hbl,hbu,hcl,hcu⟩
  exact H_pos_of_intervals (t:=2) (al:=1706/1000) (bl:=1353/1000)
    (bu:=1354/1000) (cl:=2414/1000) (cu:=2415/1000)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) ha hbl hbu hcl hcu (by norm_num)

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem H_three_pos :
    0 < (3:ℝ)^2 * A 3 * B 3 - 2*3*B 3*C 3 + A 3*C 3 := by
  rcases small_three_bounds with ⟨ha,hbl,hbu,hcl,hcu⟩
  exact H_pos_of_intervals (t:=3) (al:=2283/1000) (bl:=1545/1000)
    (bu:=1547/1000) (cl:=4146/1000) (cu:=4148/1000)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) ha hbl hbu hcl hcu (by norm_num)

private theorem H_four_pos :
    0 < (4:ℝ)^2 * A 4 * B 4 - 2*4*B 4*C 4 + A 4*C 4 := by
  rcases small_four_bounds with ⟨ha,hbl,hbu,hcl,hcu⟩
  exact H_pos_of_intervals (t:=4) (al:=2783/1000) (bl:=1670/1000)
    (bu:=1672/1000) (cl:=6146/1000) (cu:=6148/1000)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) ha hbl hbu hcl hcu (by norm_num)

private theorem H_five_pos :
    0 < (5:ℝ)^2 * A 5 * B 5 - 2*5*B 5*C 5 + A 5*C 5 := by
  rcases small_five_bounds with ⟨ha,hbl,hbu,hcl,hcu⟩
  exact H_pos_of_intervals (t:=5) (al:=3230/1000) (bl:=1759/1000)
    (bu:=1762/1000) (cl:=8382/1000) (cu:=8385/1000)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) ha hbl hbu hcl hcu (by norm_num)

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem rational_beta_strict_of_H
    {A B C x y : ℝ}
    (hA : 0 < A) (hB : 0 < B) (hx : 0 < x*A-C)
    (hH : 0 < x^2*A*B - 2*x*B*C + A*C) (hxy : x<y) :
    (x ^ 2 * B - 2 * x * A + C) / (x * A - C) <
      (y ^ 2 * B - 2 * y * A + C) / (y * A - C) := by
  have hy : 0 < y*A-C := by nlinarith [mul_pos (sub_pos.mpr hxy) hA]
  have hbr : 0 < A*B*x*y - B*C*(x+y)+A*C := by
    have hs : 0 < B*(y-x)*(x*A-C) := mul_pos (mul_pos hB (sub_pos.mpr hxy)) hx
    nlinarith [hH]
  apply (div_lt_div_iff₀ hx hy).2
  have hs : 0 < (y-x)*(A*B*x*y-B*C*(x+y)+A*C) :=
    mul_pos (sub_pos.mpr hxy) hbr
  nlinarith

private theorem H_pos_from_endpoint
    {A B C a x : ℝ} (hA : 0 < A) (hB : 0 < B)
    (hden : 0 < a*A-C)
    (hH : 0 < a^2*A*B - 2*a*B*C + A*C) (hax : a ≤ x) :
    0 < x^2*A*B - 2*x*B*C + A*C := by
  have hxden : 0 < x*A-C := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hax) hA.le]
  have hm : 0 ≤ B*(x-a)*(A*(x+a)-2*C) := by
    apply mul_nonneg (mul_nonneg hB.le (sub_nonneg.mpr hax))
    nlinarith [mul_nonneg (sub_nonneg.mpr hax) hA.le]
  nlinarith [hm]

private theorem betaOnSupport_strict_from_endpoint
    {N : ℕ} {x y : ℝ} (hN : 0 < N)
    (hden : 0 < (N:ℝ)*A N-C N)
    (hH : 0 < (N:ℝ)^2*A N*B N-2*(N:ℝ)*B N*C N + A N*C N)
    (hx : (N:ℝ) ≤ x) (hxy : x<y) :
    betaOnSupport N x < betaOnSupport N y := by
  have hA := A_pos hN
  have hB := B_pos hN
  have hxden : 0 < x*A N-C N := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hx) hA.le]
  have hxH := H_pos_from_endpoint hA hB hden hH hx
  exact rational_beta_strict_of_H hA hB hxden hxH hxy

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem small_endpoint_cert {N : ℕ} (hN : 2 ≤ N) (hN5 : N ≤ 5) :
    0 < (N:ℝ)*A N-C N ∧
    0 < (N:ℝ)^2*A N*B N-2*(N:ℝ)*B N*C N + A N*C N := by
  interval_cases N
  · rcases small_two_bounds with ⟨ha,_,_,_,hc⟩
    constructor
    · norm_num at *
      nlinarith
    · norm_num at *
      convert H_two_pos using 1 <;> ring
  · rcases small_three_bounds with ⟨ha,_,_,_,hc⟩
    constructor
    · norm_num at *
      nlinarith
    · norm_num at *
      convert H_three_pos using 1 <;> ring
  · rcases small_four_bounds with ⟨ha,_,_,_,hc⟩
    constructor
    · norm_num at *
      nlinarith
    · norm_num at *
      convert H_four_pos using 1 <;> ring
  · rcases small_five_bounds with ⟨ha,_,_,_,hc⟩
    constructor
    · norm_num at *
      nlinarith
    · norm_num at *
      convert H_five_pos using 1 <;> ring

/-- Strict increase of the actual finite-support density mean for all supports N≥2. -/
theorem betaOnSupport_strict_of_two {N : ℕ} {x y : ℝ}
    (hN : 2 ≤ N) (hx : (N:ℝ) ≤ x) (hxy : x<y) :
    betaOnSupport N x < betaOnSupport N y := by
  by_cases h6 : 6 ≤ N
  · exact betaOnSupport_strict_of_six h6 hx hxy
  · have h5 : N ≤ 5 := by omega
    obtain ⟨hden,hH⟩ := small_endpoint_cert hN h5
    exact betaOnSupport_strict_from_endpoint (by omega) hden hH hx hxy

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem beta_one_formula {x : ℝ} (hx : 1 < x) : betaOnSupport 1 x = x-1 := by
  have hne : x-1 ≠ 0 := ne_of_gt (sub_pos.mpr hx)
  norm_num [betaOnSupport, A, B, C, Finset.sum_range_succ]
  field_simp
  ring

theorem betaOnSupport_strict {N : ℕ} {x y : ℝ}
    (hN : 1 ≤ N) (hx : (N:ℝ) ≤ x) (hx1 : 1 < x) (hxy : x<y) :
    betaOnSupport N x < betaOnSupport N y := by
  by_cases h2 : 2 ≤ N
  · exact betaOnSupport_strict_of_two h2 hx hxy
  · have hN1 : N=1 := by omega
    subst N
    rw [beta_one_formula hx1, beta_one_formula (by linarith)]
    linarith

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

private theorem beta_seam (N : ℕ) :
    betaOnSupport (N+1) ((N+1:ℕ):ℝ) = betaOnSupport N ((N+1:ℕ):ℝ) := by
  have hs : Real.sqrt (N+1 : ℕ) ≠ 0 := by positivity
  have hsq : Real.sqrt (N+1 : ℕ)^2 = ((N+1:ℕ):ℝ) := by
    rw [Real.sq_sqrt (by positivity)]
  simp only [betaOnSupport, A_succ, B_succ, C_succ]
  congr 1
  · field_simp
    nlinarith [hsq]
  · field_simp
    nlinarith [hsq]

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite

private theorem cutoffMass_succ (N : ℕ) (x : ℝ) :
    cutoffMass (N+1) x = cutoffMass N x + cutoffWeight x (N+1) := by
  unfold cutoffMass
  rw [← Finset.insert_Icc_right_eq_Icc_add_one (by omega : 1 ≤ N+1)]
  rw [Finset.sum_insert (by simp only [Finset.mem_Icc]; omega)]
  ring

private theorem densityMass_succ (N : ℕ) (x : ℝ) :
    densityMass (N+1) x = densityMass N x + cutoffWeight x (N+1) * densityScore x (N+1) := by
  unfold densityMass
  rw [← Finset.insert_Icc_right_eq_Icc_add_one (by omega : 1 ≤ N+1)]
  rw [Finset.sum_insert (by simp only [Finset.mem_Icc]; omega)]
  ring

private theorem cutoffWeight_formula {n : ℕ} {x : ℝ}
    (hn : (n:ℝ) ≤ x) : cutoffWeight x n = (x-n) / Real.sqrt n := by
  by_cases h : (n:ℝ) < x
  · simp [cutoffWeight, h]
  · have heq : x = (n:ℝ) := le_antisymm (le_of_not_gt h) hn
    simp [cutoffWeight, h, heq]

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite

private theorem cutoffMass_eq_poly (N : ℕ) {x : ℝ} (hx : (N:ℝ) ≤ x) :
    cutoffMass N x = x * A N - C N := by
  induction N generalizing x with
  | zero => simp [cutoffMass, A, C]
  | succ N ih =>
      have hN : (N:ℝ) ≤ x := by exact le_trans (by exact_mod_cast Nat.le_succ N) hx
      have hNs : ((N+1:ℕ):ℝ) ≤ x := by simpa using hx
      rw [cutoffMass_succ, ih hN, cutoffWeight_formula hNs, A_succ, C_succ]
      have hs : Real.sqrt (N+1 : ℕ) ≠ 0 := by positivity
      have hsq : Real.sqrt (N+1 : ℕ)^2 = ((N+1:ℕ):ℝ) := by
        rw [Real.sq_sqrt (by positivity)]
      field_simp
      nlinarith [hsq]

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite

private theorem densityMass_eq_poly (N : ℕ) {x : ℝ} (hx : (N:ℝ) ≤ x) :
    densityMass N x = x^2 * B N - 2*x*A N + C N := by
  induction N generalizing x with
  | zero => simp [densityMass, A, B, C]
  | succ N ih =>
      have hN : (N:ℝ) ≤ x := by exact le_trans (by exact_mod_cast Nat.le_succ N) hx
      have hNs : ((N+1:ℕ):ℝ) ≤ x := by simpa using hx
      rw [densityMass_succ, ih hN, cutoffWeight_formula hNs,
          A_succ, B_succ, C_succ]
      unfold densityScore
      have hz : ((N+1:ℕ):ℝ) ≠ 0 := by positivity
      have hs : Real.sqrt (N+1 : ℕ) ≠ 0 := by positivity
      have hsq : Real.sqrt (N+1 : ℕ)^2 = ((N+1:ℕ):ℝ) := by
        rw [Real.sq_sqrt (by positivity)]
      field_simp
      nlinarith [hsq]

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite

/-- The finite rational function is exactly the original density mean when
all N positive integers are in the cutoff support (including a zero endpoint). -/
theorem densityMean_eq_betaOnSupport (N : ℕ) {x : ℝ} (hx : (N:ℝ) ≤ x) :
    densityMean N x = betaOnSupport N x := by
  unfold densityMean betaOnSupport
  rw [densityMass_eq_poly N hx, cutoffMass_eq_poly N hx]

/-- The original finite density mean is strictly increasing on a fixed
support, with no monotonicity hypothesis. -/
theorem densityMean_strict_on_support {N : ℕ} {x y : ℝ}
    (hN : 1 ≤ N) (hx : (N:ℝ) ≤ x) (hx1 : 1 < x) (hxy : x < y) :
    densityMean N x < densityMean N y := by
  rw [densityMean_eq_betaOnSupport N hx,
      densityMean_eq_betaOnSupport N (le_trans hx hxy.le)]
  exact betaOnSupport_strict hN hx hx1 hxy

end
end BuildingBlocks.CutoffDensityBetaMonotone

#print axioms BuildingBlocks.CutoffDensityBetaMonotone.betaOnSupport_strict
#print axioms BuildingBlocks.CutoffDensityBetaMonotone.densityMean_strict_on_support
#print axioms BuildingBlocks.CutoffDensityBetaMonotone.densityMean_eq_betaOnSupport

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite

private theorem densityMean_stable {M N : ℕ} {x : ℝ}
    (hMN : M ≤ N) (hx : x ≤ (M:ℝ)+1) :
    densityMean N x = densityMean M x := by
  unfold densityMean
  rw [densityMass_stable hMN hx, cutoffMass_stable hMN hx]

/-- Full strict increase for the actual cutoff density mean, including
all changes of integer support. -/
theorem densityMean_strict_global (N : ℕ) (hN : 1 ≤ N) :
    ∀ {x y : ℝ}, 1 < x → x < y → y ≤ (N:ℝ)+1 → densityMean N x < densityMean N y := by
  induction N, hN using Nat.le_induction with
  | base =>
      intro x y hx hxy hy
      exact densityMean_strict_on_support (N:=1) (by omega) (by simpa using hx.le) hx hxy
  | succ N hN ih =>
      intro x y hx hxy hy
      by_cases hyN : y ≤ (N:ℝ)+1
      · rw [densityMean_stable (Nat.le_succ N) hyN,
            densityMean_stable (Nat.le_succ N) (by linarith : x ≤ (N:ℝ)+1)]
        exact ih hx hxy hyN
      · have hNmid : ((N+1:ℕ):ℝ) < y := by push_cast; linarith
        by_cases hxN : ((N+1:ℕ):ℝ) ≤ x
        · exact densityMean_strict_on_support (N:=N+1) (by omega) hxN hx hxy
        · have hxlt : x < (N:ℝ)+1 := by push_cast at hxN; linarith
          have hseam : densityMean (N+1) ((N+1:ℕ):ℝ) =
              densityMean N ((N+1:ℕ):ℝ) :=
            densityMean_stable (Nat.le_succ N) (by push_cast; rfl)
          calc
            densityMean (N+1) x = densityMean N x :=
              densityMean_stable (Nat.le_succ N) hxlt.le
            _ < densityMean N ((N+1:ℕ):ℝ) :=
              ih hx (by simpa only [Nat.cast_add, Nat.cast_one] using hxlt)
                 (by push_cast; rfl)
            _ = densityMean (N+1) ((N+1:ℕ):ℝ) := hseam.symm
            _ < densityMean (N+1) y :=
              densityMean_strict_on_support (N:=N+1) (by omega)
                (by rfl) (by exact_mod_cast (show 1 < N+1 by omega)) hNmid

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite

private theorem densityMass_nonneg (N : ℕ) (x : ℝ) : 0 ≤ densityMass N x := by
  unfold densityMass
  apply Finset.sum_nonneg
  intro n hn
  have hnR : 0 < (n:ℝ) := by
    exact_mod_cast (Finset.mem_Icc.mp hn).1
  by_cases h : (n:ℝ) < x
  · have hs : 0 ≤ densityScore x n := by
      unfold densityScore
      exact sub_nonneg.mpr ((le_div_iff₀ hnR).2 (by linarith))
    have hw : 0 ≤ cutoffWeight x n := by
      simp only [cutoffWeight, if_pos h]
      exact div_nonneg (sub_nonneg.mpr h.le) (Real.sqrt_nonneg _)
    exact mul_nonneg hw hs
  · simp [cutoffWeight, h]

private theorem densityMean_nonneg (N : ℕ) (x : ℝ) : 0 ≤ densityMean N x := by
  unfold densityMean
  exact div_nonneg (densityMass_nonneg N x) (cutoffMass_nonneg N x)

private theorem densityMean_zero_of_le_one (N : ℕ) {x : ℝ} (hx : x ≤ 1) :
    densityMean N x = 0 := by
  rw [densityMean_stable (M:=0) (N:=N) (by omega) (by simpa using hx)]
  simp [densityMean, densityMass, cutoffMass]

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.DensityPrimeCovarianceFinite

/-- All prime-power dilates weakly decrease the actual density mean, including
those that fall below the first integer cutoff. -/
theorem densityMean_primePower_dilate_le
    {N p j : ℕ} {x : ℝ} (hN : 1 ≤ N) (hp : 1 < p) (hj : 1 ≤ j)
    (hx : 1 < x) (hupper : x ≤ (N:ℝ)+1) :
    densityMean N (x / (p:ℝ)^j) ≤ densityMean N x := by
  have hpR : (1:ℝ) < p := by exact_mod_cast hp
  have hpow : (1:ℝ) < (p:ℝ)^j := one_lt_pow₀ hpR (by omega)
  have hlt : x / (p:ℝ)^j < x := div_lt_self (by linarith) hpow
  by_cases hlow : x / (p:ℝ)^j ≤ 1
  · rw [densityMean_zero_of_le_one N hlow]
    exact densityMean_nonneg N x
  · exact (densityMean_strict_global N hN (lt_of_not_ge hlow) hlt hupper).le

/-- The first prime-power dilation is strictly lower whenever x>p. -/
theorem densityMean_prime_dilate_lt
    {N p : ℕ} {x : ℝ} (hN : 1 ≤ N) (hp : 1 < p)
    (hxp : (p:ℝ) < x) (hupper : x ≤ (N:ℝ)+1) :
    densityMean N (x / p) < densityMean N x := by
  have hpR : (1:ℝ) < p := by exact_mod_cast hp
  have hp0 : (0:ℝ) < p := by linarith
  have hlow : 1 < x / (p:ℝ) := (one_lt_div hp0).mpr hxp
  have hlt : x / (p:ℝ) < x := div_lt_self (by linarith) hpR
  exact densityMean_strict_global N hN hlow hlt hupper

/-- Unconditional strict negative density/prime covariance for the actual
finite full prime-power score, without a monotonicity hypothesis. -/
theorem actual_densityPrimeCovariance_neg
    {N p : ℕ} {x : ℝ} (hN : 1 ≤ N) (hp : p.Prime)
    (hxp : (p:ℝ) < x) (hupper : x ≤ (N:ℝ)+1) :
    densityPrimeCovariance N N p x < 0 := by
  apply densityPrimeCovariance_neg_of_densityMean_monotone hN hN hp.one_lt hxp
  · intro j hj
    exact densityMean_primePower_dilate_le hN hp.one_lt (Finset.mem_Icc.mp hj).1
      (lt_trans (by exact_mod_cast hp.one_lt) hxp) hupper
  · exact densityMean_prime_dilate_lt hN hp.one_lt hxp hupper

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite

/-- Strict negative covariance for the original full prime-power score. -/
theorem actual_fullDensityPrimeCovariance_neg
    {N p : ℕ} {x : ℝ} (hN : 1 ≤ N) (hp : p.Prime)
    (hxp : (p:ℝ) < x) (hupper : x ≤ (N:ℝ)+1) :
    fullDensityPrimeMoment N p x -
      densityMean N x * fullScoreMean N p x < 0 := by
  rw [fullDensityPrimeMoment_eq_cofactor hp hupper,
      fullScoreMean_eq_primeMean hp hupper]
  exact actual_densityPrimeCovariance_neg hN hp hxp hupper

end
end BuildingBlocks.CutoffDensityBetaMonotone

#print axioms BuildingBlocks.CutoffDensityBetaMonotone.densityMean_strict_global
#print axioms BuildingBlocks.CutoffDensityBetaMonotone.actual_densityPrimeCovariance_neg
#print axioms BuildingBlocks.CutoffDensityBetaMonotone.actual_fullDensityPrimeCovariance_neg

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite

def primeColors (N : ℕ) : Finset ℕ :=
  (Finset.Icc 2 N).filter Nat.Prime

def totalScore (N n : ℕ) : ℝ :=
  ∑ p ∈ primeColors N, fullPrimeScore p n

def fullTotalMean (N : ℕ) (x : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N, cutoffWeight x n * totalScore N n) /
    cutoffMass N x

def fullTotalDensityMoment (N : ℕ) (x : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * densityScore x n * totalScore N n) /
    cutoffMass N x

def fullTotalDensityCovariance (N : ℕ) (x : ℝ) : ℝ :=
  fullTotalDensityMoment N x - densityMean N x * fullTotalMean N x

private theorem fullTotalDensityMoment_eq_sum (N : ℕ) (x : ℝ) :
    fullTotalDensityMoment N x =
      ∑ p ∈ primeColors N, fullDensityPrimeMoment N p x := by
  unfold fullTotalDensityMoment fullDensityPrimeMoment totalScore
  simp_rw [Finset.mul_sum]
  rw [Finset.sum_comm]
  rw [Finset.sum_div]

private theorem fullTotalMean_eq_sum (N : ℕ) (x : ℝ) :
    fullTotalMean N x =
      ∑ p ∈ primeColors N, fullScoreMean N p x := by
  unfold fullTotalMean fullScoreMean totalScore
  simp_rw [Finset.mul_sum]
  rw [Finset.sum_comm]
  rw [Finset.sum_div]

private theorem fullTotalDensityCovariance_eq_sum (N : ℕ) (x : ℝ) :
    fullTotalDensityCovariance N x =
      ∑ p ∈ primeColors N,
        (fullDensityPrimeMoment N p x -
          densityMean N x * fullScoreMean N p x) := by
  unfold fullTotalDensityCovariance
  rw [fullTotalDensityMoment_eq_sum, fullTotalMean_eq_sum]
  rw [Finset.sum_sub_distrib]
  simp only [← Finset.mul_sum]

end
end BuildingBlocks.CutoffDensityBetaMonotone

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite

private theorem actual_fullDensityPrimeCovariance_nonpos
    {N p : ℕ} {x : ℝ} (hN : 1 ≤ N) (hp : p.Prime)
    (hx : 1 < x) (hupper : x ≤ (N:ℝ)+1) :
    fullDensityPrimeMoment N p x -
      densityMean N x * fullScoreMean N p x ≤ 0 := by
  have hZ : 0 < cutoffMass N x := cutoffMass_pos hN hx
  have hlog : 0 ≤ Real.log (p:ℝ) :=
    (Real.log_pos (by exact_mod_cast hp.one_lt)).le
  have hsum : 0 ≤ ∑ j ∈ Finset.Icc 1 N,
      (p:ℝ)^j * cutoffMass N (x / (p:ℝ)^j) *
        (densityMean N x - densityMean N (x / (p:ℝ)^j)) := by
    apply Finset.sum_nonneg
    intro j hj
    apply mul_nonneg
    · apply mul_nonneg
      · positivity
      · exact cutoffMass_nonneg N _
    · exact sub_nonneg.mpr (densityMean_primePower_dilate_le hN hp.one_lt
        (Finset.mem_Icc.mp hj).1 hx hupper)
  have hneg : 0 ≤ -(fullDensityPrimeMoment N p x -
      densityMean N x * fullScoreMean N p x) := by
    rw [negative_full_densityPrimeCovariance_eq hp hupper]
    exact mul_nonneg (div_nonneg hlog hZ.le) hsum
  linarith

/-- The entire original prime-color sum has strictly negative covariance
with the actual cutoff density score, for every real 2<x≤N+1. -/
theorem actual_fullTotalDensityCovariance_neg
    {N : ℕ} {x : ℝ} (hN : 2 ≤ N)
    (hx : 2 < x) (hupper : x ≤ (N:ℝ)+1) :
    fullTotalDensityCovariance N x < 0 := by
  rw [fullTotalDensityCovariance_eq_sum]
  have hsum : (∑ p ∈ primeColors N,
      (fullDensityPrimeMoment N p x -
        densityMean N x * fullScoreMean N p x)) <
        ∑ p ∈ primeColors N, (0:ℝ) := by
    apply Finset.sum_lt_sum
    · intro p hpC
      have hp : p.Prime := (Finset.mem_filter.mp hpC).2
      exact actual_fullDensityPrimeCovariance_nonpos (by omega) hp (by linarith) hupper
    · refine ⟨2, ?_, ?_⟩
      · exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr ⟨le_rfl,hN⟩, Nat.prime_two⟩
      · exact actual_fullDensityPrimeCovariance_neg (by omega) Nat.prime_two hx hupper
  simpa using hsum

end
end BuildingBlocks.CutoffDensityBetaMonotone

#print axioms BuildingBlocks.CutoffDensityBetaMonotone.actual_fullTotalDensityCovariance_neg

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite

/-- A prime larger than the sampled positive integer has no valuation
contribution to the original full prime-power score. -/
theorem fullPrimeScore_zero_of_lt {p n : ℕ} (hn : 1 ≤ n) (h : n < p) :
    fullPrimeScore p n = 0 := by
  simp [fullPrimeScore, Nat.factorization_eq_zero_of_lt h]

/-- Enlarging the prime-color cutoff past the active integer support does
not change the original full arithmetic score on any sample n≤M. -/
theorem totalScore_stable {M N n : ℕ}
    (hn : 1 ≤ n) (hnM : n ≤ M) (hMN : M ≤ N) :
    totalScore N n = totalScore M n := by
  have hsubset : primeColors M ⊆ primeColors N := by
    intro p hp
    obtain ⟨hpI,hprime⟩ := Finset.mem_filter.mp hp
    exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hpI).1, (Finset.mem_Icc.mp hpI).2.trans hMN⟩,
      hprime⟩
  unfold totalScore
  symm
  apply Finset.sum_subset hsubset
  intro p hpN hpM
  have hpM' : M < p := by
    have hnot : ¬ p ≤ M := by
      intro hle
      apply hpM
      obtain ⟨hpI,hprime⟩ := Finset.mem_filter.mp hpN
      exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr
        ⟨(Finset.mem_Icc.mp hpI).1, hle⟩, hprime⟩
    omega
  exact fullPrimeScore_zero_of_lt hn (lt_of_le_of_lt hnM hpM')

end
end BuildingBlocks.CutoffDensityBetaMonotone

#print axioms BuildingBlocks.CutoffDensityBetaMonotone.fullPrimeScore_zero_of_lt
#print axioms BuildingBlocks.CutoffDensityBetaMonotone.totalScore_stable

namespace BuildingBlocks.CutoffDensityBetaMonotone
noncomputable section

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.DensityPrimeCovarianceFinite

/-- The original full density/prime covariance vanishes before the first
p-sample enters the cutoff. This is the zero endpoint of equation (1). -/
theorem actual_fullDensityPrimeCovariance_zero_before_prime
    {N p : ℕ} {x : ℝ} (hp : p.Prime) (hx1 : 1 < x)
    (hxp : x ≤ (p:ℝ)) (hupper : x ≤ (N:ℝ)+1) :
    fullDensityPrimeMoment N p x -
      densityMean N x * fullScoreMean N p x = 0 := by
  have hterm : ∀ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * fullPrimeScore p n = 0 := by
    intro n hn
    by_cases h : (n:ℝ) < x
    · have hnp : n < p := by
        exact_mod_cast (lt_of_lt_of_le h hxp)
      rw [fullPrimeScore_zero_of_lt (Finset.mem_Icc.mp hn).1 hnp]
      ring
    · simp [cutoffWeight, h]
  have hmean : fullScoreMean N p x = 0 := by
    unfold fullScoreMean
    have hs : (∑ n ∈ Finset.Icc 1 N,
        cutoffWeight x n * fullPrimeScore p n) = 0 :=
      Finset.sum_eq_zero hterm
    rw [hs]
    simp
  have hmoment : fullDensityPrimeMoment N p x = 0 := by
    unfold fullDensityPrimeMoment
    have hs : (∑ n ∈ Finset.Icc 1 N,
        cutoffWeight x n * densityScore x n * fullPrimeScore p n) = 0 := by
      apply Finset.sum_eq_zero
      intro n hn
      calc
        cutoffWeight x n * densityScore x n * fullPrimeScore p n =
            (cutoffWeight x n * fullPrimeScore p n) * densityScore x n := by ring
        _ = 0 := by rw [hterm n hn]; ring
    rw [hs]
    simp
  rw [hmean, hmoment]
  ring

end
end BuildingBlocks.CutoffDensityBetaMonotone

#print axioms BuildingBlocks.CutoffDensityBetaMonotone.actual_fullDensityPrimeCovariance_zero_before_prime
