/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Finite mean-square and reciprocal-correlation algebra for the balanced
actual Möbius tail.

Written source:
../../building-blocks/weil-and-spectral/actual-mobius-reciprocal-short-shift-reduction.md.

This file proves only finite algebra and real exponent identities. It does
not assert a bound for a Möbius correlation or an exponential sum.
-/
import BuildingBlocks.ActualMobiusFreeFactorPruning
import Mathlib.Data.Complex.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace BuildingBlocks.ActualMobiusReciprocalCorrelation

/-- Expanding a finite bilinear mean value produces its exact two-point
kernel. This is stated over a commutative semiring so the result contains no
analytic assumptions. -/
theorem finiteBilinearKernelExpansion {κ ν R : Type*} [CommSemiring R]
    (K : Finset κ) (Q : Finset ν)
    (a b : ν → R) (χ ψ : κ → ν → R) :
    ∑ k ∈ K,
        (∑ n ∈ Q, a n * χ k n) * (∑ n ∈ Q, b n * ψ k n) =
      ∑ n₁ ∈ Q, ∑ n₂ ∈ Q,
        a n₁ * b n₂ * (∑ k ∈ K, χ k n₁ * ψ k n₂) := by
  calc
    _ = ∑ k ∈ K, ∑ n₁ ∈ Q, ∑ n₂ ∈ Q,
          (a n₁ * χ k n₁) * (b n₂ * ψ k n₂) := by
            apply Finset.sum_congr rfl
            intro k hk
            rw [Finset.sum_mul]
            apply Finset.sum_congr rfl
            intro n₁ hn₁
            rw [Finset.mul_sum]
    _ = ∑ n₁ ∈ Q, ∑ k ∈ K, ∑ n₂ ∈ Q,
          (a n₁ * χ k n₁) * (b n₂ * ψ k n₂) := by
            rw [Finset.sum_comm]
    _ = ∑ n₁ ∈ Q, ∑ n₂ ∈ Q, ∑ k ∈ K,
          (a n₁ * χ k n₁) * (b n₂ * ψ k n₂) := by
            apply Finset.sum_congr rfl
            intro n₁ hn₁
            rw [Finset.sum_comm]
    _ = _ := by
      apply Finset.sum_congr rfl
      intro n₁ hn₁
      apply Finset.sum_congr rfl
      intro n₂ hn₂
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro k hk
      ring

/-- Complex mean square as an exact signed two-point correlation. -/
theorem finiteMeanSquareExpansion {κ ν : Type*}
    (K : Finset κ) (Q : Finset ν) (a : ν → ℂ) (χ : κ → ν → ℂ) :
    ∑ k ∈ K,
        (∑ n ∈ Q, a n * χ k n) *
          (starRingEnd ℂ) (∑ n ∈ Q, a n * χ k n) =
      ∑ n₁ ∈ Q, ∑ n₂ ∈ Q,
        a n₁ * star (a n₂) *
          (∑ k ∈ K, χ k n₁ * star (χ k n₂)) := by
  simp_rw [map_sum (starRingEnd ℂ), map_mul (starRingEnd ℂ)]
  exact finiteBilinearKernelExpansion K Q a (fun n => star (a n))
    χ (fun k n => star (χ k n))

/-- For unit phases, the diagonal of the expanded mean square is exactly
the number of modes times the coefficient square mass. -/
theorem finiteMeanSquareDiagonal {κ ν : Type*}
    (K : Finset κ) (Q : Finset ν) (a : ν → ℂ) (χ : κ → ν → ℂ)
    (hunit : ∀ k ∈ K, ∀ n ∈ Q, χ k n * star (χ k n) = 1) :
    ∑ n ∈ Q, a n * star (a n) *
        (∑ k ∈ K, χ k n * star (χ k n)) =
      (K.card : ℂ) * ∑ n ∈ Q, a n * star (a n) := by
  calc
    _ = ∑ n ∈ Q, a n * star (a n) * (K.card : ℂ) := by
      apply Finset.sum_congr rfl
      intro n hn
      congr 1
      calc
        ∑ k ∈ K, χ k n * star (χ k n) = ∑ _k ∈ K, (1 : ℂ) := by
          apply Finset.sum_congr rfl
          intro k hk
          exact hunit k hk n hn
        _ = (K.card : ℂ) := by simp
    _ = _ := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro n hn
      ring

/-- In the primitive free-factor block t = 1, the reciprocal phase gap for
a shift h is exact; no Taylor expansion is used. -/
theorem primitiveReciprocalGap {N n h : ℝ}
    (hn : n ≠ 0) (hnh : n + h ≠ 0) :
    N * (1 / n - 1 / (n + h)) = N * h / (n * (n + h)) := by
  field_simp
  ring

/-- In the primitive block n ≍ D. With mode length L = DT/N,
multiplying the reciprocal gap scale Nh/D² gives exactly Th/D. -/
theorem reciprocalCoherenceScale {D T N h : ℝ} (hD : D ≠ 0) (hN : N ≠ 0) :
    (D * T / N) * (N * h / D ^ 2) = T * h / D := by
  field_simp

/-- Exact real form of additive reciprocity.  The integer `ell` records the
whole turn discarded by the additive character.  For the standard inverse
representatives, `u` is an inverse of `q` modulo `r` and `v` is an inverse
of `r` modulo `q`. -/
theorem additiveReciprocityExact {q r u v ell : ℝ}
    (hq : q ≠ 0) (hr : r ≠ 0)
    (hbezout : q * u + r * v = 1 + ell * q * r) :
    u / r + v / q = ell + 1 / (q * r) := by
  field_simp
  nlinarith

/-- Under additive reciprocity, the antisymmetric Hermitian phase is twice
one Kloosterman fraction minus the ordinary reciprocal perturbation (up to
an integer).  It is therefore not the symmetric reciprocal phase itself. -/
theorem hermitianReciprocityExact {q r u v ell : ℝ}
    (hq : q ≠ 0) (hr : r ≠ 0)
    (hbezout : q * u + r * v = 1 + ell * q * r) :
    u / r - v / q = 2 * (u / r) - ell - 1 / (q * r) := by
  rw [show v / q = ell + 1 / (q * r) - u / r by
    linarith [additiveReciprocityExact hq hr hbezout]]
  ring

/-- At the current endpoint, the off-diagonal power required by the
reciprocal second moment is (2λ-3)/5, before the requested final margin. -/
theorem endpointCorrelationThreshold (lambda : ℝ) :
    BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint lambda - 1 =
      (2 * lambda - 3) / 5 := by
  unfold BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint
  ring

/-- Rewriting the strict correlation requirement at the endpoint. -/
theorem endpointCorrelationMargin {lambda eta rho : ℝ}
    (h : BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint lambda - 1 +
      2 * eta < rho) :
    (2 * lambda - 3) / 5 + 2 * eta < rho := by
  rw [← endpointCorrelationThreshold lambda]
  exact h

/-- At the current endpoint, the diagonal exponent margin
`(lambda - d*) / 2` is exactly `(3 lambda - 2) / 10`. -/
theorem endpointDiagonalThreshold (lambda : ℝ) :
    (lambda - BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint lambda) / 2 =
      (3 * lambda - 2) / 10 := by
  unfold BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint
  ring

/-- A convenient exponent for the absolutely bounded zero-resonance branch. -/
noncomputable def zeroBranchRho (lambda : ℝ) : ℝ :=
  (lambda - 1) / 2

/-- At the endpoint, `zeroBranchRho` lies above the required correlation
threshold by exactly `(lambda + 1) / 10`. -/
theorem zeroBranchRho_lower_margin (lambda : ℝ) :
    zeroBranchRho lambda -
        (BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint lambda - 1) =
      (lambda + 1) / 10 := by
  unfold zeroBranchRho BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint
  ring

/-- The absolute zero-resonance estimate `D^3/N` permits every
`rho < lambda - d*`; `zeroBranchRho` stays below that ceiling by the same
margin `(lambda + 1) / 10`. -/
theorem zeroBranchRho_upper_margin (lambda : ℝ) :
    (lambda - BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint lambda) -
        zeroBranchRho lambda =
      (lambda + 1) / 10 := by
  unfold zeroBranchRho BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint
  ring

/-- If the requested final saving uses less than half the lower margin, the
absolute zero-resonance bound satisfies the strict off-diagonal condition. -/
theorem zeroBranch_supports_final_margin {lambda eta : ℝ}
    (hmargin : 20 * eta < lambda + 1) :
    BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint lambda - 1 +
        2 * eta < zeroBranchRho lambda := by
  have hgap := zeroBranchRho_lower_margin lambda
  linarith

end BuildingBlocks.ActualMobiusReciprocalCorrelation
