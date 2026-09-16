import BuildingBlocks.ActualCompactHeatEndpoint
import Mathlib.Tactic

/-!
# Finite terminal prime-trace kernel

The exact zero-charge algebra behind the far-lag expansion of the
terminal-compensated actual heat packets. The arithmetic sign,
prime-cutoff limit, and analytic oscillation are separate obligations.
-/

namespace BuildingBlocks.ActualTerminalPrimeTraceFinite

open scoped BigOperators

noncomputable section

/-- A zero-charge finite source has no `k⁻¹` term in its complete
pair kernel. The remaining identity retains every ordered pair and the
exact rational remainder. -/
theorem zero_charge_pair_kernel_expansion {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (a x : ι → ℝ) (k : ℝ)
    (hk : 0 < k) (hx : ∀ i ∈ s, 0 < x i)
    (hzero : ∑ i ∈ s, a i = 0) :
    (∑ i ∈ s, ∑ j ∈ s, a i * a j / (k * x j + x i)) =
      -((∑ i ∈ s, a i * x i) * (∑ j ∈ s, a j / x j ^ 2)) / k ^ 2 +
        ∑ i ∈ s, ∑ j ∈ s,
          a i * a j * x i ^ 2 /
            (k ^ 2 * x j ^ 2 * (k * x j + x i)) := by
  have hterm (i j : ι) (hi : i ∈ s) (hj : j ∈ s) :
      a i * a j / (k * x j + x i) =
        a i * (a j / (k * x j)) -
          (a i * x i) * (a j / x j ^ 2) / k ^ 2 +
          a i * a j * x i ^ 2 /
            (k ^ 2 * x j ^ 2 * (k * x j + x i)) := by
    have hkj : k * x j ≠ 0 := ne_of_gt (mul_pos hk (hx j hj))
    have hjn : x j ≠ 0 := ne_of_gt (hx j hj)
    have hden : k * x j + x i ≠ 0 :=
      ne_of_gt (add_pos (mul_pos hk (hx j hj)) (hx i hi))
    field_simp
    ring
  have hfirst :
      (∑ i ∈ s, ∑ j ∈ s, a i * (a j / (k * x j))) = 0 := by
    calc
      (∑ i ∈ s, ∑ j ∈ s, a i * (a j / (k * x j))) =
          ∑ i ∈ s, a i * (∑ j ∈ s, a j / (k * x j)) := by
            apply Finset.sum_congr rfl
            intro i hi
            rw [Finset.mul_sum]
      _ = (∑ i ∈ s, a i) * (∑ j ∈ s, a j / (k * x j)) := by
            rw [Finset.sum_mul]
      _ = 0 := by rw [hzero]; ring
  have hsecond :
      (∑ i ∈ s, ∑ j ∈ s,
        (a i * x i) * (a j / x j ^ 2) / k ^ 2) =
      (∑ i ∈ s, a i * x i) * (∑ j ∈ s, a j / x j ^ 2) / k ^ 2 := by
    calc
      (∑ i ∈ s, ∑ j ∈ s,
        (a i * x i) * (a j / x j ^ 2) / k ^ 2) =
          ∑ i ∈ s, (a i * x i) *
            (∑ j ∈ s, a j / x j ^ 2) / k ^ 2 := by
            apply Finset.sum_congr rfl
            intro i hi
            calc
              (∑ j ∈ s,
                (a i * x i) * (a j / x j ^ 2) / k ^ 2) =
                  ∑ j ∈ s, ((a i * x i) / k ^ 2) *
                    (a j / x j ^ 2) := by
                    apply Finset.sum_congr rfl
                    intro j hj
                    ring
              _ = ((a i * x i) / k ^ 2) *
                    (∑ j ∈ s, a j / x j ^ 2) := by
                    rw [Finset.mul_sum]
              _ = (a i * x i) *
                    (∑ j ∈ s, a j / x j ^ 2) / k ^ 2 := by ring
      _ = (∑ i ∈ s, a i * x i) *
          (∑ j ∈ s, a j / x j ^ 2) / k ^ 2 := by
            calc
              (∑ i ∈ s, (a i * x i) *
                (∑ j ∈ s, a j / x j ^ 2) / k ^ 2) =
                  ∑ i ∈ s, (a i * x i) *
                    ((∑ j ∈ s, a j / x j ^ 2) / k ^ 2) := by
                    apply Finset.sum_congr rfl
                    intro i hi
                    ring
              _ = (∑ i ∈ s, a i * x i) *
                    ((∑ j ∈ s, a j / x j ^ 2) / k ^ 2) := by
                    rw [Finset.sum_mul]
              _ = (∑ i ∈ s, a i * x i) *
                    (∑ j ∈ s, a j / x j ^ 2) / k ^ 2 := by ring
  calc
    (∑ i ∈ s, ∑ j ∈ s, a i * a j / (k * x j + x i)) =
        ∑ i ∈ s, ∑ j ∈ s,
          (a i * (a j / (k * x j)) -
            (a i * x i) * (a j / x j ^ 2) / k ^ 2 +
            a i * a j * x i ^ 2 /
              (k ^ 2 * x j ^ 2 * (k * x j + x i))) := by
          apply Finset.sum_congr rfl
          intro i hi
          apply Finset.sum_congr rfl
          intro j hj
          exact hterm i j hi hj
    _ = -((∑ i ∈ s, a i * x i) *
          (∑ j ∈ s, a j / x j ^ 2)) / k ^ 2 +
          ∑ i ∈ s, ∑ j ∈ s,
            a i * a j * x i ^ 2 /
              (k ^ 2 * x j ^ 2 * (k * x j + x i)) := by
          simp_rw [Finset.sum_add_distrib, Finset.sum_sub_distrib]
          rw [hfirst, hsecond]
          ring

#print axioms zero_charge_pair_kernel_expansion

/-- The complete discrete centered prime-power prefix, including the
coefficient `-1` at `n = 1`. -/
noncomputable def packetError (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, BuildingBlocks.GoldbachHeat.centeredCoefficient n

/-- The terminal weight is the actual prime-power error `ψ(N) - N`. -/
theorem packetError_eq_primeErrorReal (N : ℕ) :
    packetError N = BuildingBlocks.CoarsePrimitive.primeErrorReal (N : ℝ) := by
  unfold packetError BuildingBlocks.CoarsePrimitive.primeErrorReal
  simp only [Nat.floor_natCast]
  rw [BuildingBlocks.CoarsePrimitive.psi_eq_sum_Icc]
  simp only [BuildingBlocks.GoldbachHeat.centeredCoefficient,
    Finset.sum_sub_distrib]
  simp

/-- Use `N + 1` as a separate label for the terminal atom at position `N`.
The label preserves both the original arrival at `N` and its compensation. -/
noncomputable def packetCoefficient (N n : ℕ) : ℝ :=
  if n = N + 1 then -packetError N
  else BuildingBlocks.GoldbachHeat.centeredCoefficient n

noncomputable def packetPosition (N n : ℕ) : ℝ :=
  if n = N + 1 then (N : ℝ) else (n : ℝ)

theorem packetCoefficient_sum_zero (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 (N + 1), packetCoefficient N n) = 0 := by
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]
  have hprefix :
      (∑ n ∈ Finset.Icc 1 N, packetCoefficient N n) = packetError N := by
    unfold packetError
    apply Finset.sum_congr rfl
    intro n hn
    have hnN := (Finset.mem_Icc.mp hn).2
    simp [packetCoefficient, show n ≠ N + 1 by omega]
  rw [hprefix]
  simp [packetCoefficient]

/-- The separate-label packet has exactly the heat transform of the
discrete source `τ_N`, retaining the n=1 atom and the terminal arrival. -/
theorem packet_heat_eq_discrete_terminal (N : ℕ) (t : ℝ) :
    (∑ n ∈ Finset.Icc 1 (N + 1),
      packetCoefficient N n * Real.exp (-(packetPosition N n * t))) =
      BuildingBlocks.GoldbachHeat.finiteHeat
        BuildingBlocks.GoldbachHeat.centeredCoefficient N t -
        BuildingBlocks.CoarsePrimitive.primeErrorReal (N : ℝ) *
          Real.exp (-((N : ℝ) * t)) := by
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]
  have hprefix :
      (∑ n ∈ Finset.Icc 1 N,
        packetCoefficient N n * Real.exp (-(packetPosition N n * t))) =
        BuildingBlocks.GoldbachHeat.finiteHeat
          BuildingBlocks.GoldbachHeat.centeredCoefficient N t := by
    unfold BuildingBlocks.GoldbachHeat.finiteHeat
    apply Finset.sum_congr rfl
    intro n hn
    have hnN := (Finset.mem_Icc.mp hn).2
    simp [packetCoefficient, packetPosition, show n ≠ N + 1 by omega]
  rw [hprefix]
  simp [packetCoefficient, packetPosition, packetError_eq_primeErrorReal]
  ring

theorem packetPosition_pos (N : ℕ) (hN : 1 ≤ N) :
    ∀ n ∈ Finset.Icc 1 (N + 1), 0 < packetPosition N n := by
  intro n hn
  unfold packetPosition
  split_ifs with h
  · exact_mod_cast hN
  · have hn1 := (Finset.mem_Icc.mp hn).1
    exact_mod_cast hn1

/-- The actual discrete centered packet with its separate frozen terminal
atom inherits the exact far-lag kernel expansion. No prime sum or analytic
limit is taken in this theorem. -/
theorem packet_pair_kernel_expansion (N : ℕ) (hN : 1 ≤ N)
    (k : ℝ) (hk : 0 < k) :
    (∑ i ∈ Finset.Icc 1 (N + 1),
      ∑ j ∈ Finset.Icc 1 (N + 1),
        packetCoefficient N i * packetCoefficient N j /
          (k * packetPosition N j + packetPosition N i)) =
      -((∑ i ∈ Finset.Icc 1 (N + 1),
          packetCoefficient N i * packetPosition N i) *
        (∑ j ∈ Finset.Icc 1 (N + 1),
          packetCoefficient N j / packetPosition N j ^ 2)) / k ^ 2 +
        ∑ i ∈ Finset.Icc 1 (N + 1),
          ∑ j ∈ Finset.Icc 1 (N + 1),
            packetCoefficient N i * packetCoefficient N j *
              packetPosition N i ^ 2 /
              (k ^ 2 * packetPosition N j ^ 2 *
                (k * packetPosition N j + packetPosition N i)) := by
  exact zero_charge_pair_kernel_expansion (Finset.Icc 1 (N + 1))
    (packetCoefficient N) (packetPosition N) k hk
    (packetPosition_pos N hN) (packetCoefficient_sum_zero N)

#print axioms packetCoefficient_sum_zero
#print axioms packetError_eq_primeErrorReal
#print axioms packet_heat_eq_discrete_terminal
#print axioms packet_pair_kernel_expansion

end

end BuildingBlocks.ActualTerminalPrimeTraceFinite
