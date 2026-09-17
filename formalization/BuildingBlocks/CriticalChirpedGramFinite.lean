import BuildingBlocks.PostBranchPrefixSchurFinite

/-!
# Finite Gram bound for a critical-span packet constellation

This is the finite-dimensional algebra used after analytic row bounds have
been established. The kernel and coefficients are complex; no symmetry is
needed for this lower bound. The estimates for the actual zeta prime kernel
and the archimedean term are separate written analytic arguments.
-/

namespace BuildingBlocks.CriticalChirpedGramFinite

open scoped BigOperators

noncomputable section

variable {ι : Type*} [Fintype ι]

def crossForm (p : ι → ι → ℂ) (c : ι → ℂ) : ℂ :=
  ∑ i, ∑ j, c j * star (c i) * p i j

def energy (c : ι → ℂ) : ℝ :=
  ∑ i, ‖c i‖ ^ 2

def gramLower (d : ℝ) (p : ι → ι → ℂ) (c : ι → ℂ) : ℝ :=
  d * energy c - (crossForm p c).re

private theorem crossForm_norm_le_quadratic
    (p : ι → ι → ℂ) (c : ι → ℂ) :
    ‖crossForm p c‖ ≤
      PostBranchPrefixSchurFinite.quadratic
        (fun i j => ‖p i j‖) (fun i => ‖c i‖) := by
  calc
    ‖crossForm p c‖ ≤ ∑ i, ‖∑ j, c j * star (c i) * p i j‖ := by
      simpa only [crossForm] using
        (norm_sum_le Finset.univ
          (fun i => ∑ j, c j * star (c i) * p i j))
    _ ≤ ∑ i, ∑ j, ‖c j * star (c i) * p i j‖ := by
      apply Finset.sum_le_sum
      intro i hi
      simpa only using (norm_sum_le Finset.univ
        (fun j => c j * star (c i) * p i j))
    _ = PostBranchPrefixSchurFinite.quadratic
          (fun i j => ‖p i j‖) (fun i => ‖c i‖) := by
      simp only [PostBranchPrefixSchurFinite.quadratic, norm_mul, norm_star]
      apply Finset.sum_congr rfl
      intro i hi
      apply Finset.sum_congr rfl
      intro j hj
      ring

/-- A uniform absolute row and column budget controls the finite complex
cross term and leaves the diagonal margin `d - R`. -/
theorem gramLower_ge_margin
    (d R : ℝ) (p : ι → ι → ℂ) (c : ι → ℂ)
    (hrow : ∀ i, ∑ j, ‖p i j‖ ≤ R)
    (hcol : ∀ j, ∑ i, ‖p i j‖ ≤ R) :
    (d - R) * energy c ≤ gramLower d p c := by
  have hschur :
      |PostBranchPrefixSchurFinite.quadratic
          (fun i j => ‖p i j‖) (fun i => ‖c i‖)| ≤ R * energy c := by
    apply PostBranchPrefixSchurFinite.quadratic_abs_le_of_row_col
    · intro i
      simpa only [abs_norm] using hrow i
    · intro j
      simpa only [abs_norm] using hcol j
  have hcross : (crossForm p c).re ≤ R * energy c := by
    calc
      (crossForm p c).re ≤ |(crossForm p c).re| := le_abs_self _
      _ ≤ ‖crossForm p c‖ := Complex.abs_re_le_norm _
      _ ≤ PostBranchPrefixSchurFinite.quadratic
          (fun i j => ‖p i j‖) (fun i => ‖c i‖) :=
            crossForm_norm_le_quadratic p c
      _ ≤ |PostBranchPrefixSchurFinite.quadratic
          (fun i j => ‖p i j‖) (fun i => ‖c i‖)| := le_abs_self _
      _ ≤ R * energy c := hschur
  dsimp [gramLower]
  nlinarith

/-- For a Hermitian kernel, the column budget follows from the row budget. -/
theorem gramLower_ge_margin_of_hermitian
    (d R : ℝ) (p : ι → ι → ℂ) (c : ι → ℂ)
    (hherm : ∀ i j, p j i = star (p i j))
    (hrow : ∀ i, ∑ j, ‖p i j‖ ≤ R) :
    (d - R) * energy c ≤ gramLower d p c := by
  apply gramLower_ge_margin d R p c hrow
  intro j
  calc
    ∑ i, ‖p i j‖ = ∑ i, ‖p j i‖ := by
      apply Finset.sum_congr rfl
      intro i hi
      rw [hherm j i, norm_star]
    _ ≤ R := hrow j

end
end BuildingBlocks.CriticalChirpedGramFinite

#print axioms BuildingBlocks.CriticalChirpedGramFinite.gramLower_ge_margin
#print axioms BuildingBlocks.CriticalChirpedGramFinite.gramLower_ge_margin_of_hermitian
