import BuildingBlocks.DistinctPrimeRieszMellin
import BuildingBlocks.EtaBaselineMellin
import BuildingBlocks.EtaRieszKernel
import BuildingBlocks.EtaRieszDirichlet
import BuildingBlocks.LogDerivativePole

open scoped BigOperators

namespace BuildingBlocks.ActualCenteredMellin

/-- The actual atom-plus-Lebesgue cross term, with every Mangoldt atom up
to the real cutoff. The eta kernel vanishes at its birth endpoint. -/
noncomputable def etaSum (x : ℝ) : ℂ :=
  ∑ j ∈ Finset.range ⌊x⌋₊,
    (ArithmeticFunction.vonMangoldt (j+1) : ℂ) * EtaRieszKernel.kernel (j+1) x

/-- The full centered square before the same-prime part is removed. -/
noncomputable def N (x : ℝ) : ℂ :=
  RieszDirichlet.cutoffSum DistinctPrimeRieszMellin.fullPair x -
    2 * etaSum x + EtaBaselineMellin.B x

/-- The entire same-prime contribution, including all proper powers. -/
noncomputable def T (x : ℝ) : ℂ :=
  RieszDirichlet.cutoffSum DistinctPrimeRieszMellin.samePair x

/-- The actual distinct-prime centered tent. This definition consists only of
finite arithmetic cutoff sums and the full explicit baseline. -/
noncomputable def V (x : ℝ) : ℂ :=
  RieszDirichlet.cutoffSum DistinctPrimeRieszMellin.distinctPair x -
    2 * etaSum x + EtaBaselineMellin.B x

theorem V_eq_N_sub_T (x : ℝ) : V x = N x - T x := by
  unfold V N T
  rw [DistinctPrimeRieszMellin.distinctPair_eq]
  simp only [RieszDirichlet.cutoffSum, Pi.sub_apply, sub_mul,
    Finset.sum_sub_distrib]
  ring

theorem etaSum_eq_Icc {x : ℝ} (hx : 0 ≤ x) :
    etaSum x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((ArithmeticFunction.vonMangoldt n *
          ((x^2 - (n : ℝ)^2) / (2 * n)) : ℝ) : ℂ) := by
  unfold etaSum
  apply Finset.sum_bij (fun j _ => j+1)
  · intro j hj
    simp only [Finset.mem_range] at hj
    simp only [Finset.mem_Icc]
    omega
  · intro i hi j hj hij
    omega
  · intro n hn
    simp only [Finset.mem_Icc] at hn
    exact ⟨n-1, Finset.mem_range.mpr (by omega), by omega⟩
  · intro j hj
    have hjn : j+1 ≤ ⌊x⌋₊ := by simpa only [Finset.mem_range] using hj
    have hjx : (j : ℝ)+1 ≤ x := by
      have hcast : (j : ℝ)+1 ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hjn
      exact hcast.trans (Nat.floor_le hx)
    by_cases hlt : (j : ℝ)+1 < x
    · simp [EtaRieszKernel.kernel, hlt]
    · have he : x = (j : ℝ)+1 := le_antisymm (le_of_not_gt hlt) hjx
      simp [EtaRieszKernel.kernel, he]

/-- The real cutoff formula retains the factor minus two, both eta components,
all ordered distinct-prime coefficients, and the baseline's constant term. -/
theorem V_eq_real_cutoff {x : ℝ} (hx : 0 ≤ x) :
    V x =
      ((∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((x - n) * distinctPrimePairWeight n -
          ArithmeticFunction.vonMangoldt n * ((x^2 - (n : ℝ)^2) / n)) : ℝ) : ℂ) +
        EtaBaselineMellin.B x := by
  unfold V
  rw [DistinctPrimeRieszMellin.cutoffSum_distinctPair_eq_Icc hx, etaSum_eq_Icc hx]
  push_cast
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  congr 1
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : (n : ℂ) ≠ 0 := by
    have := (Finset.mem_Icc.mp hn).1
    exact_mod_cast (show n ≠ 0 by omega)
  field_simp

/-- The finite eta sum is exactly the readout whose infinite Mellin exchange
is justified in EtaRieszDirichlet, with no arithmetic identification assumed. -/
theorem etaSum_eq_crossTerm : etaSum = EtaRieszDirichlet.crossTerm := rfl

/-- Mellin transform of the actual centered distinct-prime cutoff sum on
its absolute-convergence half-plane. All same-prime proper powers are removed
by the proved coefficient identity, and the eta cross term has coefficient -2. -/
theorem hasMellin_V {s : ℂ} (hs : 1 < s.re) :
    HasMellin V (-s-1)
      ((LogDerivativePole.centeredZetaLogDerivative s ^ 2 -
        SamePrimeDirichlet.H s) / (s * (s+1))) := by
  have hd := DistinctPrimeRieszMellin.hasMellin_distinctPrime_cutoffSum hs
  have he : HasMellin etaSum (-s-1)
      ((-deriv riemannZeta s / riemannZeta s) / ((s-1)*(s+1))) := by
    rw [etaSum_eq_crossTerm]
    exact EtaRieszDirichlet.hasMellin_crossTerm hs
  have hb := EtaBaselineMellin.hasMellin_B hs
  have he2 := hasMellin_const_smul he.1 (2 : ℂ)
  have hsub := hasMellin_sub hd.1 he2.1
  have hsum := hasMellin_add hsub.1 hb.1
  change HasMellin
    (fun x => RieszDirichlet.cutoffSum DistinctPrimeRieszMellin.distinctPair x -
      (2 : ℂ) • etaSum x + EtaBaselineMellin.B x) (-s-1) _
  refine ⟨hsum.1, ?_⟩
  rw [hsum.2, hsub.2, hd.2, he2.2, he.2, hb.2]
  have h0 : s ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have h1 : s-1 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have h2 : s+1 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  simp only [LogDerivativePole.centeredZetaLogDerivative, logDeriv_apply,
    neg_div, smul_eq_mul]
  field_simp
  ring

end BuildingBlocks.ActualCenteredMellin
