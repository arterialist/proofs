import BuildingBlocks.ActualPrimeCutoffCovarianceFinite

/-! Finite conic transfer from upper-orthant event products to increasing-coordinate moments. The arithmetic upper-orthant inequality is an explicit hypothesis in the transfer theorem. -/

namespace BuildingBlocks.ActualCutoffOrthantMoments

open Finset

noncomputable section

variable {Ω : Type*} [Fintype Ω] {ι : Type*} [DecidableEq ι]

def expect (μ : Ω → ℝ) (u : Ω → ℝ) : ℝ :=
  ∑ ω : Ω, μ ω * u ω

private theorem product_sum_expansion (S : Finset ι) (K : Finset ℕ)
    (a b : ι → ℕ → ℝ) :
    (∏ p ∈ S, ∑ k ∈ K, a p k * b p k) =
      ∑ κ ∈ S.pi (fun _ => K),
        (∏ p ∈ S.attach, a p.1 (κ p.1 p.2)) *
          (∏ p ∈ S.attach, b p.1 (κ p.1 p.2)) := by
  classical
  rw [Finset.prod_sum]
  apply Finset.sum_congr rfl
  intro κ hκ
  rw [← Finset.prod_mul_distrib]

private theorem expectation_product_expansion (S : Finset ι) (K : Finset ℕ)
    (μ : Ω → ℝ) (a : ι → ℕ → ℝ) (B : ι → ℕ → Ω → ℝ) :
    expect μ (fun ω => ∏ p ∈ S, ∑ k ∈ K, a p k * B p k ω) =
      ∑ κ ∈ S.pi (fun _ => K),
        (∏ p ∈ S.attach, a p.1 (κ p.1 p.2)) *
          expect μ (fun ω => ∏ p ∈ S.attach, B p.1 (κ p.1 p.2) ω) := by
  classical
  simp only [expect]
  simp_rw [product_sum_expansion S K a (fun p k => B p k _)]
  simp_rw [Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro κ hκ
  apply Finset.sum_congr rfl
  intro ω hω
  ring

private theorem product_expectation_expansion (S : Finset ι) (K : Finset ℕ)
    (μ : Ω → ℝ) (a : ι → ℕ → ℝ) (B : ι → ℕ → Ω → ℝ) :
    (∏ p ∈ S, expect μ (fun ω => ∑ k ∈ K, a p k * B p k ω)) =
      ∑ κ ∈ S.pi (fun _ => K),
        (∏ p ∈ S.attach, a p.1 (κ p.1 p.2)) *
          (∏ p ∈ S.attach,
            expect μ (fun ω => B p.1 (κ p.1 p.2) ω)) := by
  classical
  have hE : ∀ p, expect μ (fun ω => ∑ k ∈ K, a p k * B p k ω) =
      ∑ k ∈ K, a p k * expect μ (B p k) := by
    intro p
    simp only [expect]
    simp_rw [Finset.mul_sum]
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro k hk
    apply Finset.sum_congr rfl
    intro ω hω
    ring
  simp_rw [hE]
  exact product_sum_expansion S K a (fun p k => expect μ (B p k))

/-- A finite upper-orthant product inequality extends to every product of
nonnegative conic combinations of its coordinate events. The hypothesis
is the exact orthant inequality, with no probabilistic independence assumed. -/
theorem conic_orthant_transfer (S : Finset ι) (K : Finset ℕ)
    (μ : Ω → ℝ) (a : ι → ℕ → ℝ) (B : ι → ℕ → Ω → ℝ)
    (ha : ∀ p ∈ S, ∀ k ∈ K, 0 ≤ a p k)
    (horth : ∀ κ ∈ S.pi (fun _ => K),
      expect μ (fun ω => ∏ p ∈ S.attach, B p.1 (κ p.1 p.2) ω) ≤
        ∏ p ∈ S.attach, expect μ (B p.1 (κ p.1 p.2))) :
    expect μ (fun ω => ∏ p ∈ S, ∑ k ∈ K, a p k * B p k ω) ≤
      ∏ p ∈ S, expect μ (fun ω => ∑ k ∈ K, a p k * B p k ω) := by
  classical
  rw [expectation_product_expansion, product_expectation_expansion]
  apply Finset.sum_le_sum
  intro κ hκ
  apply mul_le_mul_of_nonneg_left (horth κ hκ)
  apply Finset.prod_nonneg
  intro p hp
  exact ha p.1 p.2 (κ p.1 p.2) (Finset.mem_pi.mp hκ p.1 p.2)

private def increment (f : ℕ → ℝ) : ℕ → ℝ
  | 0 => f 0
  | k+1 => f (k+1) - f k

private theorem increment_sum (f : ℕ → ℝ) (m : ℕ) :
    ∑ k ∈ Finset.range (m+1), increment f k = f m := by
  induction m with
  | zero => simp [increment]
  | succ m ih =>
      rw [Finset.sum_range_succ, ih]
      simp [increment]

private theorem valuation_expansion (f : ℕ → ℝ) {J v : ℕ} (hv : v ≤ J) :
    (∑ k ∈ Finset.range (J+1),
      increment f k * (if k ≤ v then (1 : ℝ) else 0)) = f v := by
  classical
  simp_rw [mul_ite, mul_one, mul_zero]
  rw [← Finset.sum_filter]
  have hfilter : (Finset.range (J+1)).filter (fun k => k ≤ v) =
      Finset.range (v+1) := by
    ext k
    simp
    omega
  rw [hfilter]
  exact increment_sum f v

/-- Equation (8) as a finite combinatorial consequence of the precise
upper-orthant inequality, with all valuation levels through the actual
finite support bound J and the empty coordinate family included. -/
theorem monotone_valuation_moment_of_orthant
    (S : Finset ι) (J : ℕ) (μ : Ω → ℝ)
    (v : ι → Ω → ℕ) (f : ι → ℕ → ℝ)
    (hv : ∀ p ∈ S, ∀ ω, v p ω ≤ J)
    (hf0 : ∀ p ∈ S, 0 ≤ f p 0)
    (hfmono : ∀ p ∈ S, ∀ k < J, f p k ≤ f p (k+1))
    (horth : ∀ κ ∈ S.pi (fun _ => Finset.range (J+1)),
      expect μ (fun ω => ∏ p ∈ S.attach,
        if κ p.1 p.2 ≤ v p.1 ω then (1 : ℝ) else 0) ≤
      ∏ p ∈ S.attach, expect μ (fun ω =>
        if κ p.1 p.2 ≤ v p.1 ω then (1 : ℝ) else 0)) :
    expect μ (fun ω => ∏ p ∈ S, f p (v p ω)) ≤
      ∏ p ∈ S, expect μ (fun ω => f p (v p ω)) := by
  classical
  let a : ι → ℕ → ℝ := fun p k => increment (f p) k
  let B : ι → ℕ → Ω → ℝ :=
    fun p k ω => if k ≤ v p ω then 1 else 0
  have ha : ∀ p ∈ S, ∀ k ∈ Finset.range (J+1), 0 ≤ a p k := by
    intro p hp k hk
    cases k with
    | zero => exact hf0 p hp
    | succ k =>
        change 0 ≤ f p (k+1) - f p k
        have hkJ : k < J := by simpa using hk
        exact sub_nonneg.mpr (hfmono p hp k hkJ)
  have hex (p : ι) (hp : p ∈ S) (ω : Ω) :
      (∑ k ∈ Finset.range (J+1), a p k * B p k ω) = f p (v p ω) := by
    exact valuation_expansion (f p) (hv p hp ω)
  have htransfer := conic_orthant_transfer S (Finset.range (J+1)) μ a B ha horth
  have hleft :
      expect μ (fun ω => ∏ p ∈ S,
        ∑ k ∈ Finset.range (J+1), a p k * B p k ω) =
      expect μ (fun ω => ∏ p ∈ S, f p (v p ω)) := by
    unfold expect
    apply Finset.sum_congr rfl
    intro ω hω
    congr 1
    apply Finset.prod_congr rfl
    intro p hp
    exact hex p hp ω
  have hright :
      (∏ p ∈ S, expect μ (fun ω =>
        ∑ k ∈ Finset.range (J+1), a p k * B p k ω)) =
      ∏ p ∈ S, expect μ (fun ω => f p (v p ω)) := by
    apply Finset.prod_congr rfl
    intro p hp
    unfold expect
    apply Finset.sum_congr rfl
    intro ω hω
    congr 1
    exact hex p hp ω
  rw [hleft, hright] at htransfer
  exact htransfer

end
end BuildingBlocks.ActualCutoffOrthantMoments

namespace BuildingBlocks.ActualCutoffOrthantMoments

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite

noncomputable section

/-- The finite sample space of the actual cutoff law. -/
def cutoffSample (N : ℕ) := {n : ℕ // n ∈ Finset.Icc 1 N}

instance (N : ℕ) : Fintype (cutoffSample N) :=
  Finset.fintypeCoeSort (Finset.Icc 1 N)

/-- The actual cutoff probability mass on a finite support that covers n<x. -/
def cutoffProbMass (N : ℕ) (x : ℝ) (n : cutoffSample N) : ℝ :=
  cutoffWeight x n.1 / cutoffMass N x

theorem cutoffProbMass_total {N : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (hx : 1 < x) :
    ∑ n : cutoffSample N, cutoffProbMass N x n = 1 := by
  classical
  change (∑ n ∈ (Finset.Icc 1 N).attach,
    cutoffWeight x n.1 / cutoffMass N x) = 1
  rw [← Finset.sum_div, Finset.sum_attach]
  exact div_self (cutoffMass_pos hN hx).ne'

/-- Finite cutoff equation (8), conditioned only on the explicit orthant
product inequality for every selection of prime-power thresholds. Distinctness
of coordinates is enforced by the prime Finset. The x>1 and x≤N+1
hypotheses ensure this is the full actual probability law. -/
theorem actual_cutoff_moment_of_orthant
    {N : ℕ} {x : ℝ} (hN : 1 ≤ N) (hx : 1 < x)
    (_hxN : x ≤ (N : ℝ)+1)
    (S : Finset ℕ) (_hS : ∀ p ∈ S, p.Prime)
    (f : ℕ → ℕ → ℝ)
    (hf0 : ∀ p ∈ S, 0 ≤ f p 0)
    (hfmono : ∀ p ∈ S, ∀ k < N, f p k ≤ f p (k+1))
    (horth : ∀ κ ∈ S.pi (fun _ => Finset.range (N+1)),
      expect (cutoffProbMass N x)
        (fun n => ∏ p ∈ S.attach,
          if κ p.1 p.2 ≤ n.1.factorization p.1 then (1 : ℝ) else 0) ≤
      ∏ p ∈ S.attach,
        expect (cutoffProbMass N x)
          (fun n => if κ p.1 p.2 ≤ n.1.factorization p.1 then (1 : ℝ) else 0)) :
    expect (cutoffProbMass N x)
      (fun n => ∏ p ∈ S, f p (n.1.factorization p)) ≤
    ∏ p ∈ S,
      expect (cutoffProbMass N x) (fun n => f p (n.1.factorization p)) := by
  classical
  have hmass : 0 < cutoffMass N x := cutoffMass_pos hN hx
  have hv : ∀ p ∈ S, ∀ n : cutoffSample N, n.1.factorization p ≤ N := by
    intro p hp n
    have hn0 : n.1 ≠ 0 := by
      have hn := (Finset.mem_Icc.mp n.2).1
      omega
    exact (Nat.factorization_lt p hn0).le.trans (Finset.mem_Icc.mp n.2).2
  exact monotone_valuation_moment_of_orthant S N (cutoffProbMass N x)
    (fun p n => n.1.factorization p) f hv hf0 hfmono horth

end
end BuildingBlocks.ActualCutoffOrthantMoments

#print axioms BuildingBlocks.ActualCutoffOrthantMoments.monotone_valuation_moment_of_orthant
#print axioms BuildingBlocks.ActualCutoffOrthantMoments.actual_cutoff_moment_of_orthant
