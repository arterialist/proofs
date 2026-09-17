import BuildingBlocks.CoarseDyadicBound
import BuildingBlocks.CoarseBlockAnalytic
import BuildingBlocks.CoarseSummation

open Filter Set MeasureTheory
open scoped Topology BigOperators

namespace BuildingBlocks.CoarsePrimitive

/-- The actual coarse energy condition gives a summable uniform majorant on
any compact subset of the critical right half-plane. -/
theorem coarseMellinBlock_compact_majorant_of_bound (hb : CoarsePrimitiveBound)
    {K : Set ℂ} (hK : IsCompact K) (hsub : K ⊆ {s | (1 : ℝ) / 2 < s.re}) :
    ∃ u : ℕ → ℝ, Summable u ∧ ∀ k s, s ∈ K → ‖coarseMellinBlock k s‖ ≤ u k :=
  coarseMellinBlock_compact_majorant
    (fun _ _ ha hR => coarseMellinBlock_geometric_bound hb ha hR) hK hsub

theorem coarseMellinBlock_tendstoLocallyUniformlyOn (hb : CoarsePrimitiveBound) :
    TendstoLocallyUniformlyOn
      (fun t : Finset ℕ => fun s => ∑ k ∈ t, coarseMellinBlock k s)
      coarseMellinSum atTop {s | (1 : ℝ) / 2 < s.re} :=
  coarseMellinBlock_tendstoLocallyUniformlyOn_of_geometric
    (fun _ _ ha hR => coarseMellinBlock_geometric_bound hb ha hR)

theorem coarseMellinSum_analytic (hb : CoarsePrimitiveBound) :
    AnalyticOnNhd ℂ coarseMellinSum {s | (1 : ℝ) / 2 < s.re} :=
  coarseMellinSum_analytic_of_geometric
    (fun k s => coarseMellinBlock_analytic k s (Set.mem_univ s))
    (fun _ _ ha hR => coarseMellinBlock_geometric_bound hb ha hR)

end BuildingBlocks.CoarsePrimitive
