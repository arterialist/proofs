import Mathlib.Data.Matrix.Basic
import Mathlib.Tactic

namespace BuildingBlocks.ThetaSignedCoreFiniteBlock

open Finset Matrix
open scoped BigOperators

noncomputable section

variable {N : ℕ}

/-- The diagonal killed-core spectral contribution in equation (16). -/
def spectralTerm (lambda : Fin N → ℝ) (alpha : ℝ) (i j : Fin N) : ℝ :=
  if i = j then lambda j - alpha else 0

/-- The two complete mean-correction entries. -/
def meanTerm (m ac : Fin N → ℝ) (i j : Fin N) : ℝ :=
  m j * ac i + ac j * m i

/-- The negative weighted affine-covariance entry. -/
def covarianceTerm (a : ℝ) (covarianceGram : Matrix (Fin N) (Fin N) ℝ)
    (i j : Fin N) : ℝ :=
  -(covarianceGram i j / a)

/-- The positive complete odd-affine rank-one entry. -/
def oddAffineTerm (dQ : ℝ) (k : Fin N → ℝ) (i j : Fin N) : ℝ :=
  k j * k i / dQ

/-- The retained finite prime-observation Gram entry. -/
def primeObservationTerm (primeGram : Matrix (Fin N) (Fin N) ℝ)
    (i j : Fin N) : ℝ :=
  primeGram i j

/-- The complete finite signed-core compression. The covariance and prime Gram
entries remain inputs because their analytic edge realizations are separate. -/
def signedCoreMatrix (lambda : Fin N → ℝ) (alpha a dQ : ℝ)
    (m ac k : Fin N → ℝ)
    (covarianceGram primeGram : Matrix (Fin N) (Fin N) ℝ) :
    Matrix (Fin N) (Fin N) ℝ :=
  fun i j => spectralTerm lambda alpha i j + meanTerm m ac i j +
    covarianceTerm a covarianceGram i j + oddAffineTerm dQ k i j +
      primeObservationTerm primeGram i j

/-- Exact entry decomposition corresponding to equation (16). -/
theorem signedCoreMatrix_entry
    (lambda : Fin N → ℝ) (alpha a dQ : ℝ) (m ac k : Fin N → ℝ)
    (covarianceGram primeGram : Matrix (Fin N) (Fin N) ℝ) (i j : Fin N) :
    signedCoreMatrix lambda alpha a dQ m ac k covarianceGram primeGram i j =
      spectralTerm lambda alpha i j + meanTerm m ac i j +
        covarianceTerm a covarianceGram i j + oddAffineTerm dQ k i j +
          primeObservationTerm primeGram i j := rfl

/-- Real quadratic evaluation of a finite matrix. -/
def quadratic (G : Matrix (Fin N) (Fin N) ℝ) (c : Fin N → ℝ) : ℝ :=
  dotProduct c (G.mulVec c)

/-- The complete compressed quadratic form is the coherent sum of its spectral,
mean, covariance, odd-affine, and prime-observation pieces. No absolute values
are inserted between components. -/
theorem signedCore_quadratic_decomposition
    (lambda : Fin N → ℝ) (alpha a dQ : ℝ) (m ac k c : Fin N → ℝ)
    (covarianceGram primeGram : Matrix (Fin N) (Fin N) ℝ) :
    quadratic (signedCoreMatrix lambda alpha a dQ m ac k
      covarianceGram primeGram) c =
      quadratic (spectralTerm lambda alpha) c +
      quadratic (meanTerm m ac) c +
      quadratic (covarianceTerm a covarianceGram) c +
      quadratic (oddAffineTerm dQ k) c +
      quadratic (primeObservationTerm primeGram) c := by
  have hmatrix :
      signedCoreMatrix lambda alpha a dQ m ac k covarianceGram primeGram =
        spectralTerm lambda alpha + meanTerm m ac +
          covarianceTerm a covarianceGram + oddAffineTerm dQ k +
            primeObservationTerm primeGram := by
    ext i j
    rfl
  rw [hmatrix]
  unfold quadratic
  repeat' rw [Matrix.add_mulVec, dotProduct_add]

/-- The scalar certificate in equation (18). `low` and `next` are rigorous
lower enclosures; no sign is built into this definition. -/
def cStar (low next CV epsilon : ℝ) : ℝ :=
  min (low - epsilon) (next - CV - CV ^ 2 / epsilon)

theorem cStar_le_low (low next CV epsilon : ℝ) :
    cStar low next CV epsilon ≤ low - epsilon := by
  exact min_le_left _ _

theorem cStar_le_high (low next CV epsilon : ℝ) :
    cStar low next CV epsilon ≤ next - CV - CV ^ 2 / epsilon := by
  exact min_le_right _ _

/-- Algebraic form of the complementary-spectrum estimate (17). The analytic
compression bound and Young estimate enter only through `hH`. -/
theorem finiteBlock_lower_bound
    {F H lowNormSq highNormSq low next CV epsilon : ℝ}
    (hF : H ≤ F)
    (hH : (low - epsilon) * lowNormSq +
      (next - CV - CV ^ 2 / epsilon) * highNormSq ≤ H)
    (hlow : 0 ≤ lowNormSq) (hhigh : 0 ≤ highNormSq) :
    cStar low next CV epsilon * (lowNormSq + highNormSq) ≤ F := by
  have hl := cStar_le_low low next CV epsilon
  have hh := cStar_le_high low next CV epsilon
  calc
    cStar low next CV epsilon * (lowNormSq + highNormSq) =
        cStar low next CV epsilon * lowNormSq +
          cStar low next CV epsilon * highNormSq := by ring
    _ ≤ (low - epsilon) * lowNormSq +
        (next - CV - CV ^ 2 / epsilon) * highNormSq := by
          gcongr
    _ ≤ H := hH
    _ ≤ F := hF

/-- Conditional implication in equation (18): a nonnegative evaluated
certificate proves the complete finite-block lower comparison. -/
theorem cStar_nonneg_implies_finiteBlock_nonneg
    {F H lowNormSq highNormSq low next CV epsilon : ℝ}
    (hF : H ≤ F)
    (hH : (low - epsilon) * lowNormSq +
      (next - CV - CV ^ 2 / epsilon) * highNormSq ≤ H)
    (hlow : 0 ≤ lowNormSq) (hhigh : 0 ≤ highNormSq)
    (hc : 0 ≤ cStar low next CV epsilon) :
    0 ≤ F := by
  have hbound := finiteBlock_lower_bound hF hH hlow hhigh
  exact (mul_nonneg hc (add_nonneg hlow hhigh)).trans hbound

/-- Strict positivity gives the stated coercive finite-block bound. -/
theorem cStar_pos_implies_finiteBlock_coercive
    {F H normSq lowNormSq highNormSq low next CV epsilon : ℝ}
    (hnorm : normSq = lowNormSq + highNormSq)
    (hF : H ≤ F)
    (hH : (low - epsilon) * lowNormSq +
      (next - CV - CV ^ 2 / epsilon) * highNormSq ≤ H)
    (hlow : 0 ≤ lowNormSq) (hhigh : 0 ≤ highNormSq)
    (_hc : 0 < cStar low next CV epsilon) :
    cStar low next CV epsilon * normSq ≤ F := by
  rw [hnorm]
  exact finiteBlock_lower_bound hF hH hlow hhigh

#print axioms signedCoreMatrix_entry
#print axioms signedCore_quadratic_decomposition
#print axioms cStar_le_low
#print axioms cStar_le_high
#print axioms finiteBlock_lower_bound
#print axioms cStar_nonneg_implies_finiteBlock_nonneg
#print axioms cStar_pos_implies_finiteBlock_coercive

end
end BuildingBlocks.ThetaSignedCoreFiniteBlock
