import Mathlib.Data.Complex.Basic
import Mathlib.Tactic

/-!
Finite algebra for the first radius-two edge-cell reversal ledger.  Analytic
reversal of the actual symmetric edge measure is an explicit hypothesis;
this file does not evaluate any ground-dependent integral.
-/

namespace PaidThetaCompensation.RadiusTwoEdgeReversalFinite

def reduced (r : Fin 16 → ℂ) : Fin 10 → ℂ
  | 0 => r 0
  | 1 => r 1
  | 2 => r 2
  | 3 => r 3
  | 4 => r 4
  | 5 => r 6
  | 6 => r 8
  | 7 => r 9
  | 8 => r 12
  | _ => r 13

def reconstructed (s : Fin 10 → ℂ) : Fin 16 → ℂ
  | 0 => s 0
  | 1 => s 1
  | 2 => s 2
  | 3 => s 3
  | 4 => s 4
  | 5 => -(s 0 + s 1 + s 4)
  | 6 => s 5
  | 7 => -(s 2 + s 3 + s 5)
  | 8 => s 6
  | 9 => s 7
  | 10 => -s 6
  | 11 => -s 7
  | 12 => s 8
  | 13 => s 9
  | 14 => -s 8
  | _ => -s 9

def reversalRelations (r : Fin 16 → ℂ) : Prop :=
  r 0 + r 1 + r 4 + r 5 = 0 ∧
  r 2 + r 3 + r 6 + r 7 = 0 ∧
  r 8 + r 10 = 0 ∧ r 9 + r 11 = 0 ∧
  r 12 + r 14 = 0 ∧ r 13 + r 15 = 0

theorem reduced_reconstructed (s : Fin 10 → ℂ) :
    reduced (reconstructed s) = s := by
  funext i
  fin_cases i <;> rfl

theorem reconstructed_reduced (r : Fin 16 → ℂ)
    (h : reversalRelations r) : reconstructed (reduced r) = r := by
  rcases h with ⟨h₁, h₂, h₃, h₄, h₅, h₆⟩
  funext i
  fin_cases i <;> simp [reconstructed, reduced] <;>
    first
    | linear_combination -h₁
    | linear_combination -h₂
    | linear_combination -h₃
    | linear_combination -h₄
    | linear_combination -h₅
    | linear_combination -h₆

theorem relations_of_reconstructed (s : Fin 10 → ℂ) :
    reversalRelations (reconstructed s) := by
  simp [reversalRelations, reconstructed] <;> abel <;> simp

#print axioms reduced_reconstructed
#print axioms reconstructed_reduced
#print axioms relations_of_reconstructed

end PaidThetaCompensation.RadiusTwoEdgeReversalFinite
