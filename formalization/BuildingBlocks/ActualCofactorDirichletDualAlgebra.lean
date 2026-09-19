import BuildingBlocks.HyperbolaProduct
import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

/-!
# Exact Cofactor Dirichlet Dual Algebra

This module establishes the exact finite algebra connecting divisor convolutions,
proper cofactors, Dirichlet polynomials, and prime-power rows for arbitrary
complex test weights and completely multiplicative weights.

Key results:
- `sum_divisors_swap`: Exact involution invariance of divisor sums $d \mapsto n/d$.
- `factor_pairs_swap`: Exact transposition of factor pairs on the hyperbolic domain $ab \le N$.
- `proper_cofactor_pairs_swap`: Transposition of proper-cofactor double sums ($k \ge 2$).
- `primeRow_eq_logRow_sub_cofactors`: The prime row is identically equal to the non-oscillatory
  logarithmic row minus the proper-cofactor dilated prime rows.
- `primeRowSqrt_eq_logRowSqrt_sub_cofactors`: Square-root normalized version matching the Weil form.
- `multiplicative_dirichlet_convolution_primeRow`: The exact Dirichlet convolution
  $\sum_{k \le N} \chi(k) \mathrm{primeRow}(\lfloor N/k \rfloor, \chi) = \mathrm{logRow}(N, \chi)$.
- `truncated_prime_cofactor_identity`: Truncated Dirichlet sum decomposition against high cofactors.
-/

namespace BuildingBlocks.ActualCofactorDirichletDualAlgebra

open Finset BigOperators

/-- Divisor sum reordering via the involution $d \mapsto n/d$. -/
theorem sum_divisors_swap {R : Type*} [AddCommMonoid R]
    (n : ℕ) (hn : n ≠ 0) (f : ℕ → ℕ → R) :
    (∑ d ∈ n.divisors, f d (n / d)) = ∑ d ∈ n.divisors, f (n / d) d := by
  have hnpos : 0 < n := Nat.pos_of_ne_zero hn
  apply Finset.sum_bij (fun d _ => n / d)
  · intro d hd
    obtain ⟨hdn, -⟩ := Nat.mem_divisors.mp hd
    exact Nat.mem_divisors.mpr ⟨Nat.div_dvd_of_dvd hdn, hn⟩
  · intro a ha b hb hab
    obtain ⟨han, -⟩ := Nat.mem_divisors.mp ha
    obtain ⟨hbn, -⟩ := Nat.mem_divisors.mp hb
    have ha_le := Nat.le_of_dvd hnpos han
    have ha_pos := Nat.pos_of_dvd_of_pos han hnpos
    have hdiv_pos : 0 < n / a := Nat.div_pos ha_le ha_pos
    have h1 : n / a * a = n := Nat.div_mul_cancel han
    have h2 : n / b * b = n := Nat.div_mul_cancel hbn
    have h3 : n / a * a = n / a * b := by
      calc
        n / a * a = n := h1
        _ = n / b * b := h2.symm
        _ = n / a * b := by rw [hab]
    exact Nat.eq_of_mul_eq_mul_left hdiv_pos h3
  · intro b hb
    obtain ⟨hbn, -⟩ := Nat.mem_divisors.mp hb
    refine ⟨n / b, Nat.mem_divisors.mpr ⟨Nat.div_dvd_of_dvd hbn, hn⟩, ?_⟩
    exact Nat.div_div_self hbn hn
  · intro d hd
    obtain ⟨hdn, -⟩ := Nat.mem_divisors.mp hd
    rw [Nat.div_div_self hdn hn]

/-- Exact transposition of factor pairs on the hyperbolic domain $a \cdot b \le N$. -/
theorem factor_pairs_swap {R : Type*} [AddCommMonoid R]
    (N : ℕ) (f : ℕ → ℕ → R) :
    (∑ a ∈ Icc 1 N, ∑ b ∈ Icc 1 (N / a), f a b) =
      ∑ b ∈ Icc 1 N, ∑ a ∈ Icc 1 (N / b), f a b := by
  classical
  rw [← BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N f]
  rw [← BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N (fun b a => f a b)]
  apply Finset.sum_congr rfl
  intro n hn
  obtain ⟨hn1, _⟩ := Finset.mem_Icc.mp hn
  have hne0 : n ≠ 0 := by omega
  exact sum_divisors_swap n hne0 f

/-- Splitting the first element off an interval sum in an additive group. -/
theorem sum_Icc_split_first {R : Type*} [AddCommGroup R]
    {N : ℕ} (hN : 1 ≤ N) (f : ℕ → R) :
    (∑ k ∈ Icc 1 N, f k) = f 1 + ∑ k ∈ Icc 2 N, f k := by
  have hrest : (Ioc 1 N : Finset ℕ) = Icc 2 N := by
    ext k; simp only [mem_Ioc, mem_Icc]; omega
  rw [Finset.Icc_eq_cons_Ioc hN, Finset.sum_cons, hrest]

/-- Exact transposition of proper-cofactor factor pairs ($k \ge 2$). -/
theorem proper_cofactor_pairs_swap {R : Type*} [AddCommGroup R]
    (N : ℕ) (f : ℕ → ℕ → R) :
    (∑ d ∈ Icc 1 N, ∑ k ∈ Icc 2 (N / d), f d k) =
      ∑ k ∈ Icc 2 N, ∑ d ∈ Icc 1 (N / k), f d k := by
  by_cases hN : 1 ≤ N
  · have hswap := factor_pairs_swap N f
    have hleft :
        (∑ d ∈ Icc 1 N, ∑ k ∈ Icc 1 (N / d), f d k) =
          (∑ d ∈ Icc 1 N, f d 1) + ∑ d ∈ Icc 1 N, ∑ k ∈ Icc 2 (N / d), f d k := by
      rw [← Finset.sum_add_distrib]
      apply Finset.sum_congr rfl
      intro d hd
      obtain ⟨hdpos, hdN⟩ := Finset.mem_Icc.mp hd
      have hdiv : 1 ≤ N / d := Nat.div_pos hdN hdpos
      exact sum_Icc_split_first hdiv (fun k => f d k)
    have hright :
        (∑ k ∈ Icc 1 N, ∑ d ∈ Icc 1 (N / k), f d k) =
          (∑ d ∈ Icc 1 (N / 1), f d 1) + ∑ k ∈ Icc 2 N, ∑ d ∈ Icc 1 (N / k), f d k := by
      exact sum_Icc_split_first hN (fun k => ∑ d ∈ Icc 1 (N / k), f d k)
    rw [Nat.div_one] at hright
    rw [hleft, hright] at hswap
    exact add_left_cancel hswap
  · have hN0 : N = 0 := by omega
    subst hN0
    simp

/-- The exact prime-power row on $[1, N]$ with arbitrary complex test weight $g$. -/
noncomputable def primeRow (N : ℕ) (g : ℕ → ℂ) : ℂ :=
  ∑ n ∈ Icc 1 N, (ArithmeticFunction.vonMangoldt n : ℂ) * g n

/-- The exact logarithmic row on $[1, N]$ with arbitrary complex test weight $g$. -/
noncomputable def logRow (N : ℕ) (g : ℕ → ℂ) : ℂ :=
  ∑ n ∈ Icc 1 N, (Real.log (n : ℝ) : ℂ) * g n

/-- Exact expansion of the logarithmic row into complete divisor futures via $\Lambda * 1 = \log$. -/
theorem weighted_log_eq_complete_future (N : ℕ) (g : ℕ → ℂ) :
    logRow N g =
      ∑ d ∈ Icc 1 N, (ArithmeticFunction.vonMangoldt d : ℂ) *
        ∑ k ∈ Icc 1 (N / d), g (d * k) := by
  classical
  dsimp [logRow]
  calc
    _ = ∑ n ∈ Icc 1 N, ∑ d ∈ n.divisors,
          (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * (n / d)) := by
      apply Finset.sum_congr rfl
      intro n hn
      have hlog : (Real.log (n : ℝ) : ℂ) =
          ∑ d ∈ n.divisors, (ArithmeticFunction.vonMangoldt d : ℂ) := by
        exact_mod_cast ArithmeticFunction.vonMangoldt_sum (n := n).symm
      rw [hlog, Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro d hd
      rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
    _ = ∑ d ∈ Icc 1 N, ∑ k ∈ Icc 1 (N / d),
          (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * k) := by
      exact BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
        (fun d k => (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * k))
    _ = _ := by
      apply Finset.sum_congr rfl
      intro d _
      rw [Finset.mul_sum]

/-- The prime-power row equals the logarithmic row minus the sum of proper-cofactor dilated prime rows. -/
theorem primeRow_eq_logRow_sub_cofactors (N : ℕ) (g : ℕ → ℂ) :
    primeRow N g = logRow N g -
      ∑ k ∈ Icc 2 N, primeRow (N / k) (fun d => g (k * d)) := by
  classical
  by_cases hN : 1 ≤ N
  · have hlog := weighted_log_eq_complete_future N g
    have hdist :
        (∑ d ∈ Icc 1 N, (ArithmeticFunction.vonMangoldt d : ℂ) *
          ∑ k ∈ Icc 1 (N / d), g (d * k)) =
        ∑ d ∈ Icc 1 N, ∑ k ∈ Icc 1 (N / d),
          (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * k) := by
      apply Finset.sum_congr rfl
      intro d _
      rw [Finset.mul_sum]
    have hswap := factor_pairs_swap N
      (fun d k => (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * k))
    have houter := sum_Icc_split_first hN
      (fun k => ∑ d ∈ Icc 1 (N / k),
        (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * k))
    rw [Nat.div_one] at houter
    have hprime1 :
        (∑ d ∈ Icc 1 N, (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * 1)) =
          primeRow N g := by
      dsimp [primeRow]
      apply Finset.sum_congr rfl
      intro d _
      rw [mul_one]
    have hrest_eq :
        (∑ k ∈ Icc 2 N, ∑ d ∈ Icc 1 (N / k),
          (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * k)) =
        ∑ k ∈ Icc 2 N, primeRow (N / k) (fun d => g (k * d)) := by
      apply Finset.sum_congr rfl
      intro k _
      dsimp [primeRow]
      apply Finset.sum_congr rfl
      intro d _
      rw [mul_comm k d]
    rw [hdist, hswap, houter, hprime1, hrest_eq] at hlog
    rw [hlog]
    ring
  · have hN0 : N = 0 := by omega
    subst hN0
    dsimp [primeRow, logRow]
    simp

/-- Square-root normalized prime row matching the Weil explicit formula convention. -/
noncomputable def primeRowSqrt (N : ℕ) (h : ℕ → ℂ) : ℂ :=
  primeRow N (fun n => h n / (Real.sqrt (n : ℝ) : ℂ))

/-- Square-root normalized logarithmic row. -/
noncomputable def logRowSqrt (N : ℕ) (h : ℕ → ℂ) : ℂ :=
  logRow N (fun n => h n / (Real.sqrt (n : ℝ) : ℂ))

/-- Square-root normalized prime row decomposition. -/
theorem primeRowSqrt_eq_logRowSqrt_sub_cofactors (N : ℕ) (h : ℕ → ℂ) :
    primeRowSqrt N h = logRowSqrt N h -
      ∑ k ∈ Icc 2 N, primeRow (N / k) (fun d => h (k * d) / (Real.sqrt ((k * d : ℕ) : ℝ) : ℂ)) := by
  dsimp [primeRowSqrt, logRowSqrt]
  exact primeRow_eq_logRow_sub_cofactors N (fun n => h n / (Real.sqrt (n : ℝ) : ℂ))

/-- For completely multiplicative weights, the prime-power row convolution with $\chi$ recovers the logarithmic row. -/
theorem multiplicative_dirichlet_convolution_primeRow (N : ℕ) (χ : ℕ → ℂ)
    (hN : 1 ≤ N) (hχ1 : χ 1 = 1) (hχ_mul : ∀ k d, χ (k * d) = χ k * χ d) :
    (∑ k ∈ Icc 1 N, χ k * primeRow (N / k) χ) = logRow N χ := by
  have hsplit := sum_Icc_split_first hN (fun k => χ k * primeRow (N / k) χ)
  rw [Nat.div_one, hχ1, one_mul] at hsplit
  have hsub := primeRow_eq_logRow_sub_cofactors N χ
  have hfactor :
      (∑ k ∈ Icc 2 N, primeRow (N / k) (fun d => χ (k * d))) =
        ∑ k ∈ Icc 2 N, χ k * primeRow (N / k) χ := by
    apply Finset.sum_congr rfl
    intro k hk
    dsimp [primeRow]
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro d hd
    rw [hχ_mul k d]
    ring
  rw [hfactor] at hsub
  rw [hsplit]
  linear_combination hsub

/-- Truncated interval split for proper cofactors at an intermediate cutoff $K \in [2, N]$. -/
theorem truncated_cofactor_split (N K : ℕ) (hK : 2 ≤ K) (hKN : K ≤ N)
    (f : ℕ → ℂ) :
    (∑ k ∈ Icc 2 N, f k) =
      (∑ k ∈ Icc 2 K, f k) + ∑ k ∈ Icc (K + 1) N, f k := by
  have hsplit : (Icc 2 N : Finset ℕ) = Icc 2 K ∪ Icc (K + 1) N := by
    ext x
    simp only [mem_Icc, mem_union]
    omega
  have hdisj : Disjoint (Icc 2 K) (Icc (K + 1) N) := by
    rw [Finset.disjoint_iff_ne]
    intro a ha b hb
    simp only [mem_Icc] at ha hb
    omega
  rw [hsplit, Finset.sum_union hdisj]

/-- Truncated Dirichlet cofactor decomposition against high cofactors. -/
theorem truncated_prime_cofactor_identity (N K : ℕ) (χ : ℕ → ℂ)
    (hK : 2 ≤ K) (hKN : K ≤ N) (hχ1 : χ 1 = 1) (hχ_mul : ∀ k d, χ (k * d) = χ k * χ d) :
    (∑ k ∈ Icc 1 K, χ k * primeRow (N / k) χ) =
      logRow N χ - ∑ k ∈ Icc (K + 1) N, χ k * primeRow (N / k) χ := by
  have hN : 1 ≤ N := by omega
  have hconv := multiplicative_dirichlet_convolution_primeRow N χ hN hχ1 hχ_mul
  have hsplit1 := sum_Icc_split_first hN (fun k => χ k * primeRow (N / k) χ)
  rw [Nat.div_one, hχ1, one_mul] at hsplit1
  have hsplit2 :
      (∑ k ∈ Icc 1 N, χ k * primeRow (N / k) χ) =
        (∑ k ∈ Icc 1 K, χ k * primeRow (N / k) χ) +
          ∑ k ∈ Icc (K + 1) N, χ k * primeRow (N / k) χ := by
    have hset : (Icc 1 N : Finset ℕ) = Icc 1 K ∪ Icc (K + 1) N := by
      ext x; simp only [mem_Icc, mem_union]; omega
    have hdisj : Disjoint (Icc 1 K) (Icc (K + 1) N) := by
      rw [Finset.disjoint_iff_ne]
      intro a ha b hb
      simp only [mem_Icc] at ha hb
      omega
    rw [hset, Finset.sum_union hdisj]
  rw [hsplit2] at hconv
  linear_combination hconv

end BuildingBlocks.ActualCofactorDirichletDualAlgebra

#print axioms BuildingBlocks.ActualCofactorDirichletDualAlgebra.sum_divisors_swap
#print axioms BuildingBlocks.ActualCofactorDirichletDualAlgebra.factor_pairs_swap
#print axioms BuildingBlocks.ActualCofactorDirichletDualAlgebra.proper_cofactor_pairs_swap
#print axioms BuildingBlocks.ActualCofactorDirichletDualAlgebra.primeRow_eq_logRow_sub_cofactors
#print axioms BuildingBlocks.ActualCofactorDirichletDualAlgebra.primeRowSqrt_eq_logRowSqrt_sub_cofactors
#print axioms BuildingBlocks.ActualCofactorDirichletDualAlgebra.multiplicative_dirichlet_convolution_primeRow
#print axioms BuildingBlocks.ActualCofactorDirichletDualAlgebra.truncated_prime_cofactor_identity
