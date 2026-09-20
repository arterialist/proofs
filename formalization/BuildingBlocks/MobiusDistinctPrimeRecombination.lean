import BuildingBlocks.ArithmeticTransport
import BuildingBlocks.SelbergDistinctPrimes

open scoped ArithmeticFunction

namespace BuildingBlocks

/-- The arithmetic-function version of the distinct-prime pair weight.
It retains the full von Mangoldt function before subtracting the repeated
prime-base contribution. -/
noncomputable def distinctPrimePairFunction : ArithmeticFunction ℝ :=
  ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt -
    ArithmeticFunction.vonMangoldt.pmul ArithmeticFunction.log +
    ArithmeticFunction.vonMangoldt.pmul ArithmeticFunction.vonMangoldt

theorem distinctPrimePairFunction_apply (n : ℕ) :
    distinctPrimePairFunction n = distinctPrimePairWeight n := by
  unfold distinctPrimePairFunction distinctPrimePairWeight samePrimePairWeight
  change
    (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n -
        ArithmeticFunction.vonMangoldt n * Real.log n +
        ArithmeticFunction.vonMangoldt n * ArithmeticFunction.vonMangoldt n =
      (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n -
        ArithmeticFunction.vonMangoldt n *
          (Real.log n - ArithmeticFunction.vonMangoldt n)
  ring

private theorem pmul_neg (f g : ArithmeticFunction ℝ) :
    (-f).pmul g = -(f.pmul g) := by
  ext n
  change (-f n) * g n = -(f n * g n)
  ring

private theorem pmul_assoc (f g h : ArithmeticFunction ℝ) :
    (f.pmul g).pmul h = f.pmul (g.pmul h) := by
  ext n
  simp only [ArithmeticFunction.pmul_apply]
  ring

/-- Convolving the exact distinct-prime Selberg weight with the actual
Möbius function leaves a pointwise Möbius log-square term plus the
prime-power correction. No prime power is discarded. -/
theorem moebius_mul_distinctPrimePairFunction :
    (ArithmeticFunction.moebius : ArithmeticFunction ℝ) * distinctPrimePairFunction =
      (ArithmeticFunction.moebius : ArithmeticFunction ℝ).pmul
          (ArithmeticFunction.log.pmul ArithmeticFunction.log) +
        (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
          ArithmeticFunction.vonMangoldt.pmul ArithmeticFunction.vonMangoldt := by
  let mu : ArithmeticFunction ℝ := ArithmeticFunction.moebius
  let L : ArithmeticFunction ℝ := ArithmeticFunction.vonMangoldt
  let ell : ArithmeticFunction ℝ := ArithmeticFunction.log
  have hmuL : mu * L = -(mu.pmul ell) := by
    have h := primeTransport_moebius
    change mu.pmul ell + L * mu = 0 at h
    rw [mul_comm L mu] at h
    linear_combination h
  have hder := log_weighted_convolution mu L
  have hA :
      mu.pmul ell * L =
        -(mu.pmul (ell.pmul ell)) - mu * L.pmul ell := by
    rw [hmuL, pmul_neg] at hder
    change -(mu.pmul ell).pmul ell =
      mu.pmul ell * L + mu * L.pmul ell at hder
    rw [pmul_assoc] at hder
    linear_combination -hder
  change mu * (L * L - L.pmul ell + L.pmul L) =
    mu.pmul (ell.pmul ell) + mu * L.pmul L
  rw [mul_add, mul_sub, ← mul_assoc, hmuL]
  linear_combination -hA

theorem moebius_distinctPrimePairWeight_formula (n : ℕ) :
    ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        distinctPrimePairWeight (n / d) =
      (ArithmeticFunction.moebius n : ℝ) * Real.log n ^ 2 +
        ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
          ArithmeticFunction.vonMangoldt (n / d) ^ 2 := by
  have h := congrArg (fun f : ArithmeticFunction ℝ => f n)
    moebius_mul_distinctPrimePairFunction
  simp only [ArithmeticFunction.mul_apply, distinctPrimePairFunction_apply,
    ArithmeticFunction.add_apply, ArithmeticFunction.pmul_apply,
    ArithmeticFunction.intCoe_apply, ArithmeticFunction.log_apply] at h
  rw [Nat.sum_divisorsAntidiagonal
      (fun a b => (ArithmeticFunction.moebius a : ℝ) * distinctPrimePairWeight b),
    Nat.sum_divisorsAntidiagonal
      (fun a b => (ArithmeticFunction.moebius a : ℝ) *
        (ArithmeticFunction.vonMangoldt b * ArithmeticFunction.vonMangoldt b))] at h
  simpa only [pow_two] using h

#print axioms moebius_mul_distinctPrimePairFunction
#print axioms moebius_distinctPrimePairWeight_formula

end BuildingBlocks
