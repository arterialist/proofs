import BuildingBlocks.ArithmeticTransport
import Mathlib.LinearAlgebra.Matrix.Hermitian

open Finset Matrix
open scoped BigOperators Matrix

namespace BuildingBlocks

/-- Matrix on coordinates 1,...,N, obtained by applying the actual arithmetic
operator to each coefficient basis vector. The finite domain is all ℝ^N. -/
noncomputable def finitePrimeTransport (N : ℕ) : Matrix (Fin N) (Fin N) ℝ :=
  fun i j => primeTransport (arithmeticDelta (j.val + 1) (by omega)) (i.val + 1)

theorem finitePrimeTransport_apply (N : ℕ) (i j : Fin N) :
    finitePrimeTransport N i j =
      (if i = j then Real.log (i.val + 1) else 0) +
        if j.val + 1 ∣ i.val + 1 then
          ArithmeticFunction.vonMangoldt ((i.val + 1) / (j.val + 1)) else 0 := by
  rw [finitePrimeTransport, primeTransport_apply_divisors]
  simp only [arithmeticDelta_apply, mul_ite, mul_one, mul_zero]
  simp only [Finset.sum_ite_eq', Nat.mem_divisors]
  by_cases hij : i = j
  · subst j
    simp
  · have hval : i.val ≠ j.val := fun hh => hij (Fin.ext hh)
    simp [hij, hval]

theorem finitePrimeTransport_two :
    finitePrimeTransport 2 = !![0, 0; Real.log 2, Real.log 2] := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [finitePrimeTransport_apply,
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]

/-- With the ordinary Euclidean inner product this actual arithmetic matrix
is not symmetric, already on the coordinates 1 and 2. -/
theorem finitePrimeTransport_not_hermitian {N : ℕ} (hN : 2 ≤ N) :
    ¬ (finitePrimeTransport N).IsHermitian := by
  intro hh
  let i : Fin N := ⟨0, by omega⟩
  let j : Fin N := ⟨1, by omega⟩
  have he := congrArg (fun A : Matrix (Fin N) (Fin N) ℝ => A i j) hh.eq
  have hij : i ≠ j := by intro h; have := congrArg Fin.val h; simp [i, j] at this
  simp only [Matrix.conjTranspose_apply, star_trivial, finitePrimeTransport_apply] at he
  have hl : Real.log 2 = 0 := by
    simpa [i, j, hij, Ne.symm hij, ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two] using he
  exact (ne_of_gt (Real.log_pos (by norm_num : (1 : ℝ) < 2))) hl

theorem finitePrimeTransport_not_symmetric {N : ℕ} (hN : 2 ≤ N) :
    ¬ (finitePrimeTransport N).toEuclideanLin.IsSymmetric :=
  fun h => finitePrimeTransport_not_hermitian hN (Matrix.isHermitian_iff_isSymmetric.mpr h)

/-- Positive diagonal coordinate weights cannot repair this mismatch. -/
theorem finiteTransport_two_diagonal_weight_not_hermitian (w₁ w₂ : ℝ) (hw₂ : 0 < w₂) :
    ¬ (Matrix.diagonal ![w₁, w₂] * finitePrimeTransport 2).IsHermitian := by
  intro hh
  have he := congrArg (fun A : Matrix (Fin 2) (Fin 2) ℝ => A 0 1) hh.eq
  have hz : w₂ * Real.log 2 = 0 := by
    simpa [Matrix.conjTranspose_apply, finitePrimeTransport_two, Matrix.mul_apply] using he
  exact (ne_of_gt (mul_pos hw₂ (Real.log_pos (by norm_num : (1 : ℝ) < 2)))) hz

/-- The two-coordinate divisor transform and its exact inverse. -/
theorem finiteTransport_two_conjugation :
    !![(1 : ℝ), 0; 1, 1] * finitePrimeTransport 2 =
      !![0, 0; 0, Real.log 2] * !![1, 0; 1, 1] ∧
    !![(1 : ℝ), 0; -1, 1] * !![1, 0; 1, 1] = 1 := by
  rw [finitePrimeTransport_two]
  constructor <;> ext i j <;> fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply]

/-- Pulling the Euclidean inner product back by divisor summation makes
this matrix symmetric. The Gram matrix is not diagonal. -/
theorem finiteTransport_two_gram_symmetry :
    (!![(2 : ℝ), 1; 1, 1] * finitePrimeTransport 2).IsHermitian := by
  rw [finitePrimeTransport_two]
  apply Matrix.IsHermitian.ext
  intro i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply]

theorem finiteTransport_two_gram_positive (x : Fin 2 → ℝ) (hx : x ≠ 0) :
    0 < x 0 ^ 2 + (x 0 + x 1) ^ 2 := by
  have hx0 : x 0 ≠ 0 ∨ x 1 ≠ 0 := by
    by_contra hh
    push_neg at hh
    apply hx
    ext i
    fin_cases i <;> simp [hh.1, hh.2]
  rcases hx0 with h0 | h1
  · have := sq_pos_of_ne_zero h0
    nlinarith [sq_nonneg (x 0 + x 1)]
  · by_cases h0 : x 0 = 0
    · simp [h0, sq_pos_of_ne_zero h1]
    · have := sq_pos_of_ne_zero h0
      nlinarith [sq_nonneg (x 0 + x 1)]

end BuildingBlocks
