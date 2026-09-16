import BuildingBlocks.FactorialIntegerBirth

open Finset
namespace BuildingBlocks.FactorialBirthDivisorGhost

/-- Birth at a positive integer; zero has no additive predecessor arrival. -/
noncomputable def arrival (n : ℕ) (t : ℝ) : ℝ :=
  if n = 0 then 0 else FactorialIntegerBirth.birth (n - 1) t

/-- The elementary divisor observation of the complete arrival history. -/
noncomputable def ghost (n : ℕ) (t : ℝ) : ℝ :=
  (1 - Real.exp (-t)) * Real.exp (-((n - 1 : ℕ) : ℝ) * t)

/-- Literal birth inversion, with all factor pairs retained. -/
theorem arrival_inversion (n : ℕ) (hn : 0 < n) (t : ℝ) :
    (∑ x ∈ n.divisorsAntidiagonal, (ArithmeticFunction.moebius x.1 : ℝ) *
      ghost x.2 t) = arrival n t := by
  obtain ⟨N, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : n ≠ 0)
  simp only [arrival, Nat.succ_ne_zero, if_false, Nat.succ_sub_one]
  rw [FactorialIntegerBirth.actual_birth_divisors]
  rw [Nat.sum_divisorsAntidiagonal (fun d q => (ArithmeticFunction.moebius d : ℝ) * ghost q t)]
  rw [mul_sum]
  apply sum_congr rfl
  intro d hd
  have hdiv := (Nat.mem_divisors.mp hd).1
  have he : (N + 1) / d = N / d + (if d ∣ N + 1 then 1 else 0) := Nat.succ_div
  have he' : (N + 1) / d = N / d + 1 := by
    simpa only [Nat.succ_eq_add_one, if_pos hdiv] using he
  have hq : ((N + 1) / d - 1 : ℕ) = N / d := by
    rw [he', Nat.add_sub_cancel]
  unfold ghost
  rw [hq]
  ring

/-- Complete divisor histories cancel to the elementary integer observation. -/
theorem actual_divisor_ghost (n : ℕ) (hn : 0 < n) (t : ℝ) :
    (∑ d ∈ n.divisors, arrival d t) = ghost n t := by
  exact (ArithmeticFunction.sum_eq_iff_sum_mul_moebius_eq
    (f := fun k => arrival k t) (g := fun k => ghost k t)).mpr
    (fun k hk => arrival_inversion k hk t) n hn

/-- Complete ordered divisor-pair products retain every collision. -/
theorem actual_pair_ghost (n : ℕ) (hn : 0 < n) (t : ℝ) :
    (∑ d ∈ n.divisors, ∑ e ∈ n.divisors, arrival d t * arrival e t) =
      (ghost n t) ^ 2 := by
  simp_rw [← mul_sum]
  rw [← sum_mul, actual_divisor_ghost n hn t, pow_two]

/-- The elementary pair observation is a scalar multiple of the doubled-clock observation. -/
theorem ghost_double_clock (n : ℕ) (t : ℝ) :
    (ghost n t) ^ 2 =
      ((1 - Real.exp (-t)) / (1 + Real.exp (-t))) * ghost n (2 * t) := by
  have hden : 1 + Real.exp (-t) ≠ 0 := by positivity
  have ht : Real.exp (-(2 * t)) = Real.exp (-t) ^ 2 := by
    rw [show -(2 * t) = -t + -t by ring, Real.exp_add, pow_two]
  have hn : Real.exp (-((n - 1 : ℕ) : ℝ) * (2 * t)) =
      Real.exp (-((n - 1 : ℕ) : ℝ) * t) ^ 2 := by
    rw [show -((n - 1 : ℕ) : ℝ) * (2 * t) =
      -((n - 1 : ℕ) : ℝ) * t + -((n - 1 : ℕ) : ℝ) * t by ring,
      Real.exp_add, pow_two]
  unfold ghost
  rw [ht, hn]
  field_simp
  ring

end BuildingBlocks.FactorialBirthDivisorGhost
#print axioms BuildingBlocks.FactorialBirthDivisorGhost.arrival_inversion
#print axioms BuildingBlocks.FactorialBirthDivisorGhost.actual_divisor_ghost

#print axioms BuildingBlocks.FactorialBirthDivisorGhost.actual_pair_ghost
#print axioms BuildingBlocks.FactorialBirthDivisorGhost.ghost_double_clock
