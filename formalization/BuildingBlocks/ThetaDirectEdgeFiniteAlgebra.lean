import Mathlib.Data.Matrix.Basic
import Mathlib.Tactic

namespace BuildingBlocks.ThetaDirectEdgeFiniteAlgebra

open Finset Matrix
open scoped BigOperators

noncomputable section

/-- The residual `φ` diagonal after eliminating the two sign profiles. -/
def residualDiagonal (Ayy gc gp dc dp : ℝ) : ℝ :=
  Ayy - gc ^ 2 / dc - gp ^ 2 / dp

/-- The residual mixed entry after eliminating the two sign profiles. -/
def residualMixed (b0 bc bp gc gp dc dp : ℝ) : ℝ :=
  b0 - bc * gc / dc - bp * gp / dp

/-- The conditional-edge scalar, with the last quotient present. -/
def edgeTheta (Azz Ayy b0 bc bp gc gp dc dp : ℝ) : ℝ :=
  Azz - bc ^ 2 / dc - bp ^ 2 / dp -
    residualMixed b0 bc bp gc gp dc dp ^ 2 /
      residualDiagonal Ayy gc gp dc dp

/-- Exact one-dimensional Schur-complement residual identity. -/
theorem schur_residual_identity
    {Azz Ayy b0 bc bp gc gp dc dp : ℝ}
    (hdy : residualDiagonal Ayy gc gp dc dp ≠ 0) :
    let dy := residualDiagonal Ayy gc gp dc dp
    let m := residualMixed b0 bc bp gc gp dc dp
    let s := m / dy
    edgeTheta Azz Ayy b0 bc bp gc gp dc dp =
      (Azz - bc ^ 2 / dc - bp ^ 2 / dp) - 2 * s * m + s ^ 2 * dy := by
  dsimp
  unfold edgeTheta
  field_simp
  ring

/-- Consumer for an analytic edge realization. The expansion of the actual
edge form along `z - sφ` is retained as an explicit hypothesis. -/
theorem edgeTheta_eq_projectedEnergy
    {V : Type*} {energy : V → ℝ} {projected : V}
    {Azz Ayy b0 bc bp gc gp dc dp : ℝ}
    (hdy : residualDiagonal Ayy gc gp dc dp ≠ 0)
    (hedge :
      energy projected =
        (Azz - bc ^ 2 / dc - bp ^ 2 / dp) -
          2 * (residualMixed b0 bc bp gc gp dc dp /
            residualDiagonal Ayy gc gp dc dp) *
              residualMixed b0 bc bp gc gp dc dp +
          (residualMixed b0 bc bp gc gp dc dp /
            residualDiagonal Ayy gc gp dc dp) ^ 2 *
              residualDiagonal Ayy gc gp dc dp) :
    edgeTheta Azz Ayy b0 bc bp gc gp dc dp = energy projected := by
  rw [schur_residual_identity hdy]
  exact hedge.symm

/-- The degenerate Cauchy--Schwarz step for a real two-by-two PSD block.
The three hypotheses are exactly its two nonnegative diagonal conditions and
nonnegative determinant condition. -/
theorem psd_mixed_eq_zero_of_diagonal_eq_zero
    {a b d : ℝ} (hpsd : 0 ≤ a ∧ 0 ≤ d ∧ b ^ 2 ≤ a * d)
    (hd0 : d = 0) : b = 0 := by
  rcases hpsd with ⟨_ha, _hd, hdet⟩
  rw [hd0, mul_zero] at hdet
  have hb : b ^ 2 = 0 := le_antisymm hdet (sq_nonneg b)
  exact sq_eq_zero_iff.mp hb

/-- In the `d_y = 0` case, residual PSD forces the last numerator to vanish. -/
theorem degenerate_residualMixed_eq_zero
    {Azz Ayy b0 bc bp gc gp dc dp : ℝ}
    (hdiag : 0 ≤ Azz - bc ^ 2 / dc - bp ^ 2 / dp)
    (hdy : 0 ≤ residualDiagonal Ayy gc gp dc dp)
    (hdet : residualMixed b0 bc bp gc gp dc dp ^ 2 ≤
      (Azz - bc ^ 2 / dc - bp ^ 2 / dp) *
        residualDiagonal Ayy gc gp dc dp)
    (hdy0 : residualDiagonal Ayy gc gp dc dp = 0) :
    residualMixed b0 bc bp gc gp dc dp = 0 :=
  psd_mixed_eq_zero_of_diagonal_eq_zero ⟨hdiag, hdy, hdet⟩ hdy0

/-- The last Schur quotient, defined to be zero at a degenerate diagonal. -/
def schurQuotient (m dy : ℝ) : ℝ := if dy = 0 then 0 else m ^ 2 / dy

/-- The zero-diagonal convention sets the final quotient to zero. Combined
with `degenerate_residualMixed_eq_zero`, residual PSD also forces its numerator
to vanish. -/
theorem schurQuotient_eq_zero
    {m dy : ℝ} (hdy0 : dy = 0) :
    schurQuotient m dy = 0 := by
  simp [schurQuotient, hdy0]

/-- Coefficients `(1,-rᵀ)ᵀ` for the three-column Woodbury correction
`W = (w_c,w_p,v_*)`. -/
def woodburyCoefficients (r : Fin 3 → ℝ) : Fin 4 → ℝ :=
  Fin.cases 1 (fun j => -r j)

/-- Exact `cᵀGc` expansion. Every off-diagonal mixed entry remains present
before the finite quadratic sum is formed. -/
theorem woodbury_quadratic_expansion (G : Matrix (Fin 4) (Fin 4) ℝ)
    (r : Fin 3 → ℝ) :
    dotProduct (woodburyCoefficients r)
        (G.mulVec (woodburyCoefficients r)) =
      G 0 0 - (∑ j : Fin 3, G 0 j.succ * r j) -
        (∑ j : Fin 3, r j * G j.succ 0) +
          ∑ j : Fin 3, ∑ k : Fin 3, r j * G j.succ k.succ * r k := by
  simp only [dotProduct, mulVec, woodburyCoefficients, Fin.sum_univ_succ,
    Fin.cases_zero, Fin.cases_succ, neg_mul]
  ring

#print axioms schur_residual_identity
#print axioms edgeTheta_eq_projectedEnergy
#print axioms psd_mixed_eq_zero_of_diagonal_eq_zero
#print axioms degenerate_residualMixed_eq_zero
#print axioms schurQuotient_eq_zero
#print axioms woodbury_quadratic_expansion

end
end BuildingBlocks.ThetaDirectEdgeFiniteAlgebra
