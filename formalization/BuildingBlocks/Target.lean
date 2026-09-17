import Mathlib.NumberTheory.LSeries.RiemannZeta

namespace BuildingBlocks

/-- The full mathlib Riemann hypothesis, stated but NOT proved here. -/
def Target : Prop := RiemannHypothesis

/-- Statement audit only. This equivalence does not prove either proposition. -/
theorem target_iff_full_statement : Target ↔
    ∀ s : ℂ, riemannZeta s = 0 →
      (¬ ∃ n : ℕ, s = -2 * (n + 1)) →
      s ≠ 1 → s.re = 1 / 2 := Iff.rfl

end BuildingBlocks
