import BuildingBlocks.CompactWeilDivisorRayleighFinite
import Mathlib.Tactic

/-!
# Complete divisor-packet energy

The exact finite graph identity behind the critical Weil packet's
prime deficit. Every von Mangoldt prime-power edge is retained.
The analytic gamma and pole forms are separate obligations.
-/

namespace BuildingBlocks.CompactWeilDivisorEnergyFinite

open scoped BigOperators

noncomputable section

private abbrev Λ (d : ℕ) : ℝ := ArithmeticFunction.vonMangoldt d

private def edgeWeight (n d : ℕ) : ℝ := Λ d / ((n : ℝ) * d)

private theorem hyperbola_sum_swap {R : Type*} [AddCommMonoid R]
    (N : ℕ) (f : ℕ → ℕ → R) :
    (∑ d ∈ Finset.Icc 1 N,
      ∑ n ∈ Finset.Icc 1 (N / d), f n d) =
      ∑ n ∈ Finset.Icc 1 N,
        ∑ d ∈ Finset.Icc 1 (N / n), f n d := by
  classical
  rw [Finset.sum_sigma', Finset.sum_sigma']
  apply Finset.sum_bij (fun x _ => ⟨x.2, x.1⟩)
  · intro x hx
    obtain ⟨hd, hn⟩ := Finset.mem_sigma.mp hx
    obtain ⟨hd1, hdN⟩ := Finset.mem_Icc.mp hd
    obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
    have hprod : x.2 * x.1 ≤ N :=
      (Nat.le_div_iff_mul_le hd1).mp hnN
    have hnle : x.2 ≤ x.2 * x.1 := by
      calc
        x.2 = x.2 * 1 := by omega
        _ ≤ x.2 * x.1 := Nat.mul_le_mul_left _ hd1
    exact Finset.mem_sigma.mpr
      ⟨Finset.mem_Icc.mpr ⟨hn1, hnle.trans hprod⟩,
        Finset.mem_Icc.mpr ⟨hd1,
          (Nat.le_div_iff_mul_le hn1).mpr (by simpa [mul_comm] using hprod)⟩⟩
  · intro x hx y hy hxy
    have hfirst : x.2 = y.2 := congrArg Sigma.fst hxy
    have hsecond : x.1 = y.1 := by
      simpa using congrArg (fun z : Σ _ : ℕ, ℕ => z.2) hxy
    cases x
    cases y
    simp_all
  · intro y hy
    refine ⟨⟨y.2, y.1⟩, ?_, ?_⟩
    · obtain ⟨hn, hd⟩ := Finset.mem_sigma.mp hy
      obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
      obtain ⟨hd1, hdN⟩ := Finset.mem_Icc.mp hd
      have hprod : y.2 * y.1 ≤ N :=
        (Nat.le_div_iff_mul_le hn1).mp hdN
      have hdle : y.2 ≤ y.2 * y.1 := by
        calc
          y.2 = y.2 * 1 := by omega
          _ ≤ y.2 * y.1 := Nat.mul_le_mul_left _ hn1
      exact Finset.mem_sigma.mpr
        ⟨Finset.mem_Icc.mpr ⟨hd1, hdle.trans hprod⟩,
          Finset.mem_Icc.mpr ⟨hn1,
            (Nat.le_div_iff_mul_le hd1).mpr (by simpa [mul_comm] using hprod)⟩⟩
    · rfl
  · intro x hx
    rfl

def vertexNorm (N : ℕ) (g : ℕ → ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, g n ^ 2 / (n : ℝ)

/-- The ordered pair is counted twice, exactly as in the symmetric
compression of the complete Weil prime shifts. -/
def primeGraph (N : ℕ) (g : ℕ → ℝ) : ℝ :=
  2 * ∑ d ∈ Finset.Icc 1 N,
    ∑ n ∈ Finset.Icc 1 (N / d),
      edgeWeight n d * g n * g (n * d)

def historyEnergy (N : ℕ) (g : ℕ → ℝ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 N,
    ∑ n ∈ Finset.Icc 1 (N / d),
      edgeWeight n d * (g n - g (n * d)) ^ 2

theorem historyEnergy_nonneg (N : ℕ) (g : ℕ → ℝ) :
    0 ≤ historyEnergy N g := by
  unfold historyEnergy
  apply Finset.sum_nonneg
  intro d hd
  apply Finset.sum_nonneg
  intro n hn
  have hnpos : 0 < (n : ℝ) := by
    exact_mod_cast (Finset.mem_Icc.mp hn).1
  have hdpos : 0 < (d : ℝ) := by
    exact_mod_cast (Finset.mem_Icc.mp hd).1
  exact mul_nonneg
    (div_nonneg ArithmeticFunction.vonMangoldt_nonneg
      (le_of_lt (mul_pos hnpos hdpos)))
    (sq_nonneg _)

/-- The finite boundary remainder before the weighted hyperbola sum is
regrouped pointwise. Balazard's prime inequality signs that regrouped
remainder; the sign is not assumed by the identity below. -/
def boundaryEnergy (N : ℕ) (g : ℕ → ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N,
      (Real.log (N : ℝ) - Real.log (n : ℝ)) * g n ^ 2 / (n : ℝ)) -
    ∑ d ∈ Finset.Icc 1 N,
      ∑ n ∈ Finset.Icc 1 (N / d), edgeWeight n d * g n ^ 2

/-- The finite arithmetic boundary potential at vertex `n`. Its
nonnegativity follows from the Balazard inequality, which is not yet
formalized in this module. -/
def boundaryDefect (N n : ℕ) : ℝ :=
  Real.log (N : ℝ) - Real.log (n : ℝ) -
    ∑ d ∈ Finset.Icc 1 (N / n), Λ d / (d : ℝ)

/-- Exact regrouping of the global boundary remainder by its actual
integer vertices. This identifies the precise inequality still needed
for a formally proved nonnegative boundary. -/
theorem boundaryEnergy_eq_pointwise (N : ℕ) (g : ℕ → ℝ) :
    boundaryEnergy N g =
      ∑ n ∈ Finset.Icc 1 N,
        boundaryDefect N n * g n ^ 2 / (n : ℝ) := by
  unfold boundaryEnergy boundaryDefect
  rw [hyperbola_sum_swap N (fun n d => edgeWeight n d * g n ^ 2)]
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  have hinner :
      (∑ d ∈ Finset.Icc 1 (N / n), edgeWeight n d * g n ^ 2) =
        (∑ d ∈ Finset.Icc 1 (N / n), Λ d / (d : ℝ)) *
          g n ^ 2 / (n : ℝ) := by
    calc
      (∑ d ∈ Finset.Icc 1 (N / n), edgeWeight n d * g n ^ 2) =
          ∑ d ∈ Finset.Icc 1 (N / n),
            (Λ d / (d : ℝ)) * (g n ^ 2 / (n : ℝ)) := by
            apply Finset.sum_congr rfl
            intro d hd
            unfold edgeWeight
            ring
      _ = (∑ d ∈ Finset.Icc 1 (N / n), Λ d / (d : ℝ)) *
            (g n ^ 2 / (n : ℝ)) := by rw [Finset.sum_mul]
      _ = (∑ d ∈ Finset.Icc 1 (N / n), Λ d / (d : ℝ)) *
            g n ^ 2 / (n : ℝ) := by ring
  rw [hinner]
  ring

/-- Incoming prime-power edge mass at a vertex is exactly its logarithm.
This is the complete identity `∑_{d∣m} Λ(d) = log m` with the
factor-pair bijection and no prime-power truncation. -/
theorem incoming_square_eq_log (N : ℕ) (g : ℕ → ℝ) :
    (∑ d ∈ Finset.Icc 1 N,
      ∑ n ∈ Finset.Icc 1 (N / d),
        edgeWeight n d * g (n * d) ^ 2) =
      ∑ m ∈ Finset.Icc 1 N,
        Real.log (m : ℝ) * g m ^ 2 / (m : ℝ) := by
  rw [← BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
    (fun d n => edgeWeight n d * g (n * d) ^ 2)]
  apply Finset.sum_congr rfl
  intro m hm
  calc
    (∑ d ∈ m.divisors, edgeWeight (m / d) d * g ((m / d) * d) ^ 2) =
      ∑ d ∈ m.divisors, Λ d / (m : ℝ) * g m ^ 2 := by
        apply Finset.sum_congr rfl
        intro d hd
        have hprod : (m / d) * d = m :=
          Nat.div_mul_cancel (Nat.mem_divisors.mp hd).1
        simp only [edgeWeight]
        rw [hprod, ← Nat.cast_mul, hprod]
    _ = (∑ d ∈ m.divisors, Λ d) / (m : ℝ) * g m ^ 2 := by
        rw [Finset.sum_div]
        rw [Finset.sum_mul]
    _ = Real.log (m : ℝ) * g m ^ 2 / (m : ℝ) := by
        rw [ArithmeticFunction.vonMangoldt_sum]
        ring

/-- Exact ground-state transform of the full divisor-packet prime form.
The first term on the right is a positive square because `Λ ≥ 0`;
the boundary term is left with its literal finite arithmetic content. -/
theorem prime_deficit_eq_history_add_boundary (N : ℕ) (g : ℕ → ℝ) :
    Real.log (N : ℝ) * vertexNorm N g - primeGraph N g =
      historyEnergy N g + boundaryEnergy N g := by
  have hin := incoming_square_eq_log N g
  unfold vertexNorm primeGraph historyEnergy boundaryEnergy
  simp_rw [sub_sq, mul_add, mul_sub, Finset.sum_add_distrib,
    Finset.sum_sub_distrib]
  rw [hin]
  rw [Finset.mul_sum]
  have hlog :
      (∑ n ∈ Finset.Icc 1 N,
          Real.log (N : ℝ) * (g n ^ 2 / (n : ℝ))) =
        (∑ n ∈ Finset.Icc 1 N,
          Real.log (n : ℝ) * g n ^ 2 / (n : ℝ)) +
        (∑ n ∈ Finset.Icc 1 N,
          (Real.log (N : ℝ) - Real.log (n : ℝ)) * g n ^ 2 / (n : ℝ)) := by
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro n hn
    ring
  have hcross :
      (∑ d ∈ Finset.Icc 1 N,
        ∑ n ∈ Finset.Icc 1 (N / d),
          edgeWeight n d * (2 * g n * g (n * d))) =
        2 * ∑ d ∈ Finset.Icc 1 N,
          ∑ n ∈ Finset.Icc 1 (N / d),
            edgeWeight n d * g n * g (n * d) := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro d hd
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro n hn
    ring
  rw [hlog, hcross]
  ring

/-- The complete arithmetic graph identity in its pointwise form.
The separate Balazard inequality would make every displayed boundary
coefficient nonnegative, but this theorem asserts the exact identity. -/
theorem prime_deficit_eq_history_add_pointwise (N : ℕ) (g : ℕ → ℝ) :
    Real.log (N : ℝ) * vertexNorm N g - primeGraph N g =
      historyEnergy N g +
        ∑ n ∈ Finset.Icc 1 N,
          boundaryDefect N n * g n ^ 2 / (n : ℝ) := by
  rw [prime_deficit_eq_history_add_boundary, boundaryEnergy_eq_pointwise]

#print axioms incoming_square_eq_log
#print axioms historyEnergy_nonneg
#print axioms boundaryEnergy_eq_pointwise
#print axioms prime_deficit_eq_history_add_boundary
#print axioms prime_deficit_eq_history_add_pointwise

end

end BuildingBlocks.CompactWeilDivisorEnergyFinite

namespace BuildingBlocks.CompactWeilDivisorEnergyFinite

open scoped BigOperators ComplexConjugate

noncomputable section

private abbrev Λc (d : ℕ) : ℝ := ArithmeticFunction.vonMangoldt d

private def complexEdgeWeight (n d : ℕ) : ℝ :=
  Λc d / ((n : ℝ) * d)

/-- Weighted vertex norm for complex packet coefficients. -/
def complexVertexNorm (N : ℕ) (g : ℕ → ℂ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, Complex.normSq (g n) / (n : ℝ)

/-- Hermitian prime graph, written as twice the real part of every oriented
prime-power edge. -/
def complexPrimeGraph (N : ℕ) (g : ℕ → ℂ) : ℝ :=
  2 * ∑ d ∈ Finset.Icc 1 N,
    ∑ n ∈ Finset.Icc 1 (N / d),
      complexEdgeWeight n d * (g n * conj (g (n * d))).re

/-- Complex divisor-history energy with every von Mangoldt edge retained. -/
def complexHistoryEnergy (N : ℕ) (g : ℕ → ℂ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 N,
    ∑ n ∈ Finset.Icc 1 (N / d),
      complexEdgeWeight n d * Complex.normSq (g n - g (n * d))

/-- The same literal finite boundary remainder for complex coefficients. -/
def complexBoundaryEnergy (N : ℕ) (g : ℕ → ℂ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N,
      (Real.log (N : ℝ) - Real.log (n : ℝ)) *
        Complex.normSq (g n) / (n : ℝ)) -
    ∑ d ∈ Finset.Icc 1 N,
      ∑ n ∈ Finset.Icc 1 (N / d),
        complexEdgeWeight n d * Complex.normSq (g n)

private theorem complexVertexNorm_eq_parts (N : ℕ) (g : ℕ → ℂ) :
    complexVertexNorm N g = vertexNorm N (fun n => (g n).re) +
      vertexNorm N (fun n => (g n).im) := by
  unfold complexVertexNorm vertexNorm
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  rw [Complex.normSq_apply]
  ring

private theorem complexPrimeGraph_eq_parts (N : ℕ) (g : ℕ → ℂ) :
    complexPrimeGraph N g = primeGraph N (fun n => (g n).re) +
      primeGraph N (fun n => (g n).im) := by
  unfold complexPrimeGraph primeGraph complexEdgeWeight edgeWeight Λc Λ
  rw [← mul_add]
  apply congrArg (fun x : ℝ => 2 * x)
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro d hd
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  simp [Complex.mul_re]
  ring

private theorem complexHistoryEnergy_eq_parts (N : ℕ) (g : ℕ → ℂ) :
    complexHistoryEnergy N g = historyEnergy N (fun n => (g n).re) +
      historyEnergy N (fun n => (g n).im) := by
  unfold complexHistoryEnergy historyEnergy complexEdgeWeight edgeWeight Λc Λ
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro d hd
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  simp only [Complex.normSq_apply, Complex.sub_re, Complex.sub_im]
  ring

/-- The complete complex divisor-history energy is nonnegative. -/
theorem complexHistoryEnergy_nonneg (N : ℕ) (g : ℕ → ℂ) :
    0 ≤ complexHistoryEnergy N g := by
  rw [complexHistoryEnergy_eq_parts]
  exact add_nonneg
    (historyEnergy_nonneg N (fun n => (g n).re))
    (historyEnergy_nonneg N (fun n => (g n).im))

private theorem complexBoundaryEnergy_eq_parts (N : ℕ) (g : ℕ → ℂ) :
    complexBoundaryEnergy N g = boundaryEnergy N (fun n => (g n).re) +
      boundaryEnergy N (fun n => (g n).im) := by
  unfold complexBoundaryEnergy boundaryEnergy complexEdgeWeight edgeWeight Λc Λ
  simp only [Complex.normSq_apply]
  simp_rw [mul_add, add_div, Finset.sum_add_distrib]
  ring

/-- Exact complex ground-state transform of the complete divisor-packet prime
form. This is the Hermitian extension needed by the compact Weil form; it
uses no positivity or analytic hypothesis. -/
theorem complex_prime_deficit_eq_history_add_boundary
    (N : ℕ) (g : ℕ → ℂ) :
    Real.log (N : ℝ) * complexVertexNorm N g - complexPrimeGraph N g =
      complexHistoryEnergy N g + complexBoundaryEnergy N g := by
  rw [complexVertexNorm_eq_parts, complexPrimeGraph_eq_parts,
    complexHistoryEnergy_eq_parts, complexBoundaryEnergy_eq_parts]
  have hre := prime_deficit_eq_history_add_boundary N (fun n => (g n).re)
  have him := prime_deficit_eq_history_add_boundary N (fun n => (g n).im)
  linarith

/-- Complex pointwise form of the exact divisor-history conservation law. -/
theorem complex_prime_deficit_eq_history_add_pointwise
    (N : ℕ) (g : ℕ → ℂ) :
    Real.log (N : ℝ) * complexVertexNorm N g - complexPrimeGraph N g =
      complexHistoryEnergy N g +
        ∑ n ∈ Finset.Icc 1 N,
          boundaryDefect N n * Complex.normSq (g n) / (n : ℝ) := by
  rw [complex_prime_deficit_eq_history_add_boundary]
  rw [complexBoundaryEnergy_eq_parts]
  rw [boundaryEnergy_eq_pointwise, boundaryEnergy_eq_pointwise]
  simp only [Complex.normSq_apply]
  rw [← Finset.sum_add_distrib]
  apply congrArg (fun x : ℝ => complexHistoryEnergy N g + x)
  apply Finset.sum_congr rfl
  intro n hn
  ring

#print axioms complex_prime_deficit_eq_history_add_boundary
#print axioms complex_prime_deficit_eq_history_add_pointwise
#print axioms complexHistoryEnergy_nonneg

end

end BuildingBlocks.CompactWeilDivisorEnergyFinite
