import BuildingBlocks.SelbergIdentity
import BuildingBlocks.PrimePrimitiveFormula

open scoped BigOperators

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

/-- The actual weighted second von Mangoldt identity, reindexed by all
positive factor pairs with product at most `N`. -/
theorem selbergWeight_weighted_moebius (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * selbergWeight n) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d), w (d * q) * Real.log (q : ℝ) ^ 2 := by
  have hpoint (n : ℕ) : w n * selbergWeight n =
      ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        (w (d * (n / d)) * Real.log (n / d : ℕ) ^ 2) := by
    rw [selbergWeight_moebius_formula, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro d hd
    rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
    ring
  simp_rw [hpoint]
  rw [sum_divisors_eq_sum_factor_pairs N
    (fun d q => (ArithmeticFunction.moebius d : ℝ) *
      (w (d * q) * Real.log (q : ℝ) ^ 2))]
  simp only [Finset.mul_sum]

/-- The same actual weighted source, with its prime-power logarithmic term
and its complete ordered divisor-convolution term both retained. -/
theorem selbergWeight_weighted_vonMangoldt (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * selbergWeight n) =
      (∑ n ∈ Finset.Icc 1 N,
        w n * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      ∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a), w (a * b) * ArithmeticFunction.vonMangoldt b := by
  have hpoint (n : ℕ) : w n * selbergWeight n =
      w n * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ) +
      ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt d *
        (w (d * (n / d)) * ArithmeticFunction.vonMangoldt (n / d)) := by
    rw [selbergWeight_apply, mul_add]
    congr 1
    · ring
    · rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro d hd
      rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
      ring
  simp_rw [hpoint]
  rw [Finset.sum_add_distrib, sum_divisors_eq_sum_factor_pairs N
    (fun a b => ArithmeticFunction.vonMangoldt a *
      (w (a * b) * ArithmeticFunction.vonMangoldt b))]
  simp only [Finset.mul_sum]

/-- Exact finite Selberg readout for an arbitrary real weight. -/
theorem selberg_weighted_identity (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N,
      w n * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      (∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a), w (a * b) * ArithmeticFunction.vonMangoldt b) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d), w (d * q) * Real.log (q : ℝ) ^ 2 := by
  rw [← selbergWeight_weighted_vonMangoldt, selbergWeight_weighted_moebius]

/-- Integer tent specialization. Every factor pair with product `N` is
included and has coefficient zero, rather than being removed from the range. -/
theorem selberg_tent_identity (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N,
      ((N : ℝ) - n) * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      (∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a),
          ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt b) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d),
          ((N : ℝ) - (d * q : ℕ)) * Real.log (q : ℝ) ^ 2 :=
  selberg_weighted_identity N (fun n => (N : ℝ) - n)

/-- The signed Möbius tent sum is nonnegative by its exact arithmetic readout. -/
theorem selberg_moebius_tent_nonneg (N : ℕ) :
    0 ≤ ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      ∑ q ∈ Finset.Icc 1 (N / d),
        ((N : ℝ) - (d * q : ℕ)) * Real.log (q : ℝ) ^ 2 := by
  rw [← selbergWeight_weighted_moebius N (fun n => (N : ℝ) - n)]
  apply Finset.sum_nonneg
  intro n hn
  apply mul_nonneg _ (selbergWeight_nonneg n)
  apply sub_nonneg.mpr
  exact_mod_cast (Finset.mem_Icc.mp hn).2

/-- The exact triangular weight whose von Mangoldt readout is the prime
part of the coarse dyadic terminal mass. -/
def dyadicTerminalWeight (X n : ℕ) : ℝ :=
  if n ≤ X then (X : ℝ) else ((2 * X : ℕ) : ℝ) - (n : ℝ)

theorem dyadicTerminalWeight_nonneg_of_le {X n : ℕ} (hn : n ≤ 2 * X) :
    0 ≤ dyadicTerminalWeight X n := by
  unfold dyadicTerminalWeight
  split_ifs
  · exact Nat.cast_nonneg X
  · apply sub_nonneg.mpr
    exact_mod_cast hn

/-- The triangular Selberg readout retains the old-prime block, the open
lower endpoint, and the zero-weight upper endpoint exactly. -/
theorem dyadicTerminalWeight_prime_sum (X : ℕ) :
    (∑ n ∈ Finset.Icc 1 (2 * X),
      dyadicTerminalWeight X n * ArithmeticFunction.vonMangoldt n) =
        dyadicTerminalPrimeMass X := by
  have hdisj : Disjoint (Finset.Icc 1 X) (Finset.Ioc X (2 * X)) := by
    rw [Finset.disjoint_left]
    intro n hnIcc hnIoc
    simp only [Finset.mem_Icc] at hnIcc
    simp only [Finset.mem_Ioc] at hnIoc
    omega
  have hsplit (f : ℕ → ℝ) :
      (∑ n ∈ Finset.Icc 1 (2 * X), f n) =
        (∑ n ∈ Finset.Icc 1 X, f n) +
          ∑ n ∈ Finset.Ioc X (2 * X), f n := by
    calc
      (∑ n ∈ Finset.Icc 1 (2 * X), f n) =
          ∑ n ∈ Finset.Icc 1 X ∪ Finset.Ioc X (2 * X), f n := by
            apply Finset.sum_congr
            · ext n
              simp only [Finset.mem_Icc, Finset.mem_union, Finset.mem_Ioc]
              omega
            · intro n hn
              rfl
      _ = _ := Finset.sum_union hdisj
  rw [hsplit]
  unfold dyadicTerminalPrimeMass
  congr 1
  · rw [psi_eq_sum_Icc, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro n hn
    simp only [dyadicTerminalWeight, if_pos (Finset.mem_Icc.mp hn).2]
  · apply Finset.sum_congr rfl
    intro n hn
    simp only [dyadicTerminalWeight, if_neg (not_le.mpr (Finset.mem_Ioc.mp hn).1)]

/-- Splitting `log n` at `log X` isolates the exact terminal channel and
retains the complete logarithmic deviation. -/
theorem dyadicTerminalWeight_log_decomposition (X : ℕ) :
    (∑ n ∈ Finset.Icc 1 (2 * X),
      dyadicTerminalWeight X n * ArithmeticFunction.vonMangoldt n *
        Real.log (n : ℝ)) =
      Real.log (X : ℝ) * dyadicTerminalPrimeMass X +
        ∑ n ∈ Finset.Icc 1 (2 * X),
          dyadicTerminalWeight X n * ArithmeticFunction.vonMangoldt n *
            (Real.log (n : ℝ) - Real.log (X : ℝ)) := by
  rw [← dyadicTerminalWeight_prime_sum X]
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  ring

/-- Exact source-specific balance for the missing dyadic terminal channel.
The ordered `Λ * Λ` term is nonnegative because the triangular weight is
nonnegative on the displayed range, but no estimate for the signed Möbius
or logarithmic-deviation terms is asserted. -/
theorem selberg_dyadic_terminal_mass_balance (X : ℕ) :
    Real.log (X : ℝ) *
          (coarseTerminalMassFinite X + 3 * (X : ℝ) ^ 2 / 2) +
        (∑ n ∈ Finset.Icc 1 (2 * X),
          dyadicTerminalWeight X n * ArithmeticFunction.vonMangoldt n *
            (Real.log (n : ℝ) - Real.log (X : ℝ))) +
        (∑ a ∈ Finset.Icc 1 (2 * X), ArithmeticFunction.vonMangoldt a *
          ∑ b ∈ Finset.Icc 1 (2 * X / a),
            dyadicTerminalWeight X (a * b) * ArithmeticFunction.vonMangoldt b) =
      ∑ d ∈ Finset.Icc 1 (2 * X), (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (2 * X / d),
          dyadicTerminalWeight X (d * q) * Real.log (q : ℝ) ^ 2 := by
  have hmass : coarseTerminalMassFinite X + 3 * (X : ℝ) ^ 2 / 2 =
      dyadicTerminalPrimeMass X := by
    unfold coarseTerminalMassFinite
    ring
  rw [hmass, ← dyadicTerminalWeight_log_decomposition]
  exact selberg_weighted_identity (2 * X) (dyadicTerminalWeight X)

/-- The complete ordered two-prime term in the terminal balance is
nonnegative, with every factor pair and prime power retained. -/
theorem selberg_dyadic_terminal_convolution_nonneg (X : ℕ) :
    0 ≤ ∑ a ∈ Finset.Icc 1 (2 * X), ArithmeticFunction.vonMangoldt a *
      ∑ b ∈ Finset.Icc 1 (2 * X / a),
        dyadicTerminalWeight X (a * b) * ArithmeticFunction.vonMangoldt b := by
  apply Finset.sum_nonneg
  intro a ha
  apply mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
  apply Finset.sum_nonneg
  intro b hb
  apply mul_nonneg
  · apply dyadicTerminalWeight_nonneg_of_le
    simpa [mul_comm] using
      (Nat.le_div_iff_mul_le (Finset.mem_Icc.mp ha).1).mp
        (Finset.mem_Icc.mp hb).2
  · exact ArithmeticFunction.vonMangoldt_nonneg

/-- Dropping only the proved nonnegative ordered-prime term gives an exact
unconditional one-sided constraint on the terminal channel. The right side
and logarithmic deviation remain signed. -/
theorem selberg_dyadic_terminal_mass_le_signed_readout (X : ℕ) :
    Real.log (X : ℝ) *
          (coarseTerminalMassFinite X + 3 * (X : ℝ) ^ 2 / 2) +
        (∑ n ∈ Finset.Icc 1 (2 * X),
          dyadicTerminalWeight X n * ArithmeticFunction.vonMangoldt n *
            (Real.log (n : ℝ) - Real.log (X : ℝ))) ≤
      ∑ d ∈ Finset.Icc 1 (2 * X), (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (2 * X / d),
          dyadicTerminalWeight X (d * q) * Real.log (q : ℝ) ^ 2 := by
  have hbal := selberg_dyadic_terminal_mass_balance X
  have hpos := selberg_dyadic_terminal_convolution_nonneg X
  linarith

#print axioms dyadicTerminalWeight_prime_sum
#print axioms selberg_dyadic_terminal_mass_balance
#print axioms selberg_dyadic_terminal_mass_le_signed_readout

end BuildingBlocks
