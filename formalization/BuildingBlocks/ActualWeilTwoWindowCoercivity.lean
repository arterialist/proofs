import BuildingBlocks.ActualWeilIsolatedPrimePowerCone

/-!
Exact finite certificate, active-window arithmetic and scalar reduction for
the complete actual Weil two-window estimate. Analytic Fourier/digamma and
full Weil-form identifications remain explicit named hypotheses.
No theorem asserts unrestricted Weil positivity or RH.
-/

namespace BuildingBlocks.ActualWeilIsolatedPrimePowerCone

/-- The actual positive-lag support window for a packet centered at log q
    contains precisely the integer bases 2 through q. -/
theorem active_integer_window_iff (q n : ℕ)
    (hq : 8 ≤ q) (hn : 2 ≤ n) :
    Real.log (n : ℝ) < Real.log (q : ℝ) + (1 : ℝ) / (4 * q) ↔ n ≤ q := by
  have hqpos : (0 : ℝ) < q := by exact_mod_cast (show 0 < q by omega)
  have hnpos : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hwpos : (0 : ℝ) < 1 / (4 * (q : ℝ)) := by positivity
  constructor
  · intro hwin
    by_contra hnot
    have hgt : q < n := by omega
    have hlog : 0 < Real.log (n : ℝ) - Real.log (q : ℝ) := by
      have hreal : (q : ℝ) < n := by exact_mod_cast hgt
      linarith [Real.log_lt_log hqpos hreal]
    have hgap := isolated_log_spacing q n hq hn (by omega)
    rw [abs_of_pos hlog] at hgap
    linarith
  · intro hnq
    have hreal : (n : ℝ) ≤ q := by exact_mod_cast hnq
    have hlog : Real.log (n : ℝ) ≤ Real.log (q : ℝ) :=
      Real.log_le_log hnpos hreal
    linarith

end BuildingBlocks.ActualWeilIsolatedPrimePowerCone

/-!
Finite scalar reduction for the actual-zeta two-window packet inequality.

The analytic inputs are explicit hypotheses: the single-window gamma bounds,
the Cauchy bounds on the exact prime and gamma cross rows, and the exact
pole-null full Weil decomposition. No theorem here proves those inputs or RH.
-/

/-!
Finite scalar reduction for the actual-zeta two-window packet inequality.

The analytic inputs are explicit hypotheses: the single-window gamma bounds,
the Cauchy bounds on the exact prime and gamma cross rows, and the exact
pole-null full Weil decomposition. No theorem here proves those inputs or RH.
-/

namespace BuildingBlocks.ActualWeilTwoWindowCoercivity

theorem narrow_packet_direct_sum_scalar
    (A B gammaL gammaR c crossPrime crossGamma kappa Q : ℝ)
    (hN : 0 < A + B)
    (hGammaL : (4 / 3 : ℝ) * A ≤ gammaL)
    (hGammaR : (4 / 3 : ℝ) * B ≤ gammaR)
    (hc0 : 0 ≤ c) (hc : c < 3 / 4)
    (hk : kappa < 1 / 28)
    (hPrimeCross : 2 * crossPrime ≤ A + B)
    (hGammaCross : 2 * crossGamma ≤ kappa * (A + B))
    (hExactWeilPoleNull :
      Q = gammaL + gammaR - 2 * c * crossPrime - 2 * crossGamma) :
    (23 / 42 : ℝ) * (A + B) < Q := by
  have hPrimeScaled := mul_le_mul_of_nonneg_left hPrimeCross hc0
  have hCoef : (c + kappa) * (A + B) <
      (3 / 4 + 1 / 28 : ℝ) * (A + B) := by
    exact mul_lt_mul_of_pos_right (by linarith) hN
  nlinarith [hPrimeScaled]

end BuildingBlocks.ActualWeilTwoWindowCoercivity

namespace BuildingBlocks.ActualWeilTwoWindowCoercivity

open BuildingBlocks.ActualWeilIsolatedPrimePowerCone

/-- Elementary uniform bound on the actual prime-power coefficient. -/
private theorem actual_prime_power_coeff_bounds
    (p j : ℕ) (hp : Nat.Prime p) (hj : 0 < j) :
    0 ≤ Real.log p / Real.sqrt (p ^ j : ℕ) ∧
      Real.log p / Real.sqrt (p ^ j : ℕ) < 3 / 4 := by
  have hpOne : (1 : ℝ) ≤ p := by
    exact_mod_cast (show 1 ≤ p from Nat.one_le_iff_ne_zero.mpr hp.ne_zero)
  have hpPos : (0 : ℝ) < p := by linarith
  have hpqNat : p ≤ p ^ j := le_self_pow hp.one_le (by omega)
  have hpq : (p : ℝ) ≤ (p ^ j : ℕ) := by exact_mod_cast hpqNat
  have hqPos : (0 : ℝ) < (p ^ j : ℕ) := by linarith
  have hqNonneg : (0 : ℝ) ≤ (p ^ j : ℕ) := hqPos.le
  have hsqrtPos : 0 < Real.sqrt (p ^ j : ℕ) := Real.sqrt_pos.2 hqPos
  have hlogNonneg : 0 ≤ Real.log p := Real.log_nonneg hpOne
  have hlogLe : Real.log p ≤ Real.log (p ^ j : ℕ) :=
    Real.log_le_log hpPos hpq
  have hcoeff0 : 0 ≤ Real.log p / Real.sqrt (p ^ j : ℕ) :=
    div_nonneg hlogNonneg hsqrtPos.le
  have hcoeffLe : Real.log p / Real.sqrt (p ^ j : ℕ) ≤
      Real.log (p ^ j : ℕ) / Real.sqrt (p ^ j : ℕ) :=
    div_le_div_of_nonneg_right hlogLe hsqrtPos.le
  have hExpGt : (8 / 3 : ℝ) < Real.exp 1 := by
    linarith [Real.exp_one_gt_d9]
  have hExpPos : 0 < Real.exp 1 := Real.exp_pos 1
  have hTangent :=
    Real.exp_one_mul_le_exp
      (x := Real.log (Real.sqrt (p ^ j : ℕ)))
  rw [Real.exp_log hsqrtPos, Real.log_sqrt hqNonneg] at hTangent
  have hGeneral :
      Real.log (p ^ j : ℕ) / Real.sqrt (p ^ j : ℕ) ≤
        2 / Real.exp 1 := by
    apply (div_le_div_iff₀ hsqrtPos hExpPos).mpr
    nlinarith [hTangent]
  have hExpBound : (2 : ℝ) / Real.exp 1 < 3 / 4 := by
    apply (div_lt_iff₀ hExpPos).mpr
    nlinarith [hExpGt]
  exact ⟨hcoeff0, lt_of_le_of_lt (hcoeffLe.trans hGeneral) hExpBound⟩

/-!
The exact finite prime row is now obtained from the already published
`complete_prime_row_qge8`, rather than inserted as an analytic hypothesis.
For independent left/right packets, `corr(q)=crossPrime`; its theorem uses
`corr(q)=-gSq`, so the substitution is `gSq=-crossPrime`.

The support-to-correlation implication and the pole-null Weil identity
remain named analytic hypotheses. In applications `A=||u||²`, `B=||v||²`,
`crossPrime=⟨u,v⟩`, and `crossGamma=I(u,v)`.
-/
theorem actual_narrow_packet_direct_sum
    (p j : ℕ) (corr : ℕ → ℝ)
    (A B gammaL gammaR crossPrime crossGamma kappa Q : ℝ)
    (hp : Nat.Prime p) (hj : 0 < j) (hq8 : 8 ≤ p ^ j)
    (hcorrSupport : ∀ n ∈ Finset.Ico 2 (p ^ j + 1),
      (1 : ℝ) / (4 * (p ^ j : ℕ)) <
        |Real.log (n : ℝ) - Real.log (p ^ j : ℕ)| → corr n = 0)
    (hqCorr : corr (p ^ j) = crossPrime)
    (hNorm : 0 < A + B)
    (hGammaL : (4 / 3 : ℝ) * A ≤ gammaL)
    (hGammaR : (4 / 3 : ℝ) * B ≤ gammaR)
    (hGammaCrossCoeff : kappa < 1 / 28)
    (hPrimeCross : 2 * crossPrime ≤ A + B)
    (hGammaCross : 2 * crossGamma ≤ kappa * (A + B))
    (hExactWeilGlobalPoleNull :
      Q = gammaL + gammaR - 2 * crossGamma +
        primeRow (Finset.Ico 2 (p ^ j + 1)) corr) :
    (23 / 42 : ℝ) * (A + B) < Q := by
  have hRow := complete_prime_row_qge8 p j corr (-crossPrime)
    hp hj hq8 hcorrSupport (by simpa using hqCorr)
  have hExactScalar :
      Q = gammaL + gammaR -
        2 * (Real.log p / Real.sqrt (p ^ j : ℕ)) * crossPrime -
        2 * crossGamma := by
    rw [hExactWeilGlobalPoleNull, hRow]
    ring
  obtain ⟨hPrimeCoeffNonneg, hPrimeCoeffBound⟩ :=
    actual_prime_power_coeff_bounds p j hp hj
  exact narrow_packet_direct_sum_scalar A B gammaL gammaR
    (Real.log p / Real.sqrt (p ^ j : ℕ)) crossPrime crossGamma kappa Q
    hNorm hGammaL hGammaR hPrimeCoeffNonneg hPrimeCoeffBound
    hGammaCrossCoeff hPrimeCross hGammaCross hExactScalar

end BuildingBlocks.ActualWeilTwoWindowCoercivity

namespace BuildingBlocks.ActualGammaIntegerCert

def term (j n : ℕ) : ℕ :=
  160000 * j * j / ((4 * n + 1) * ((4 * n + 1) ^ 2 + 4 * j * j))

def row (j : ℕ) : ℕ :=
  (Finset.range 64).sum (term j)

def block (k : ℕ) : ℕ :=
  (Finset.range 21).sum (fun j => row (k + j))

theorem blocks :
    block 0 = 1126550 ∧ block 21 = 1452301 ∧
    block 42 = 1553555 ∧ block 63 = 1611931 := by
  decide

theorem total : block 0 + block 21 + block 42 + block 63 = 5744337 := by
  rw [blocks.1, blocks.2.1, blocks.2.2.1, blocks.2.2.2]

end BuildingBlocks.ActualGammaIntegerCert

#print axioms BuildingBlocks.ActualGammaIntegerCert.blocks
#print axioms BuildingBlocks.ActualGammaIntegerCert.total
#print axioms BuildingBlocks.ActualWeilIsolatedPrimePowerCone.active_integer_window_iff
#print axioms BuildingBlocks.ActualWeilTwoWindowCoercivity.actual_narrow_packet_direct_sum
