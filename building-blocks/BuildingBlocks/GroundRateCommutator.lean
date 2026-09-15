import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace BuildingBlocks.GroundRateCommutator

/-- Incoming displacement with the literal ground-rate pattern c(u) H(u+a). -/
def incoming (c H : ℝ → ℝ) (a : ℝ) (F : ℝ → ℝ) (u : ℝ) : ℝ :=
  c u * H (u + a) * F (u + a)

/-- Pointwise multiplication by a departure profile. -/
def holding (d F : ℝ → ℝ) (u : ℝ) : ℝ := d u * F u

/-- The full displacement generator retains its departure profile. -/
def generator (c H d : ℝ → ℝ) (a : ℝ) (F : ℝ → ℝ) (u : ℝ) : ℝ :=
  holding d F u - incoming c H a F u

theorem incoming_two_path_defect (c H F : ℝ → ℝ) (u a b : ℝ) :
    incoming c H a (incoming c H b F) u - incoming c H b (incoming c H a F) u =
      c u * H (u + a + b) *
        (c (u + a) * H (u + a) - c (u + b) * H (u + b)) * F (u + a + b) := by
  have hab : u + b + a = u + a + b := by ring
  simp only [incoming, hab]
  ring

theorem incoming_holding_defect (c H d F : ℝ → ℝ) (u a : ℝ) :
    incoming c H a (holding d F) u - holding d (incoming c H a F) u =
      c u * H (u + a) * (d (u + a) - d u) * F (u + a) := by
  simp only [incoming, holding]
  ring

theorem complete_generator_defect (c H dc dp F : ℝ → ℝ) (u a b : ℝ) :
    generator c H dc a (generator c H dp b F) u -
      generator c H dp b (generator c H dc a F) u =
      c u * H (u + a + b) *
        (c (u + a) * H (u + a) - c (u + b) * H (u + b)) * F (u + a + b) +
      c u * H (u + b) * (dc (u + b) - dc u) * F (u + b) +
      c u * H (u + a) * (dp u - dp (u + a)) * F (u + a) := by
  have hab : u + b + a = u + a + b := by ring
  simp only [generator, holding, incoming, hab]
  ring

/-- The clock density cancels c at the starting endpoint. -/
def two_path_pairing (c H F : ℝ → ℝ) (u a b : ℝ) : ℝ :=
  H u * H (u + a + b) *
    (c (u + a) * H (u + a) - c (u + b) * H (u + b)) * F u * F (u + a + b)

theorem reversed_two_path_pairing (c H F : ℝ → ℝ) (u a b : ℝ) :
    two_path_pairing c H F (u + a + b) (-a) (-b) = -two_path_pairing c H F u a b := by
  have h1 : u + a + b + -a = u + b := by ring
  have h2 : u + a + b + -b = u + a := by ring
  simp only [two_path_pairing, h1, h2, add_neg_cancel_right]
  ring

#print axioms incoming_two_path_defect
#print axioms incoming_holding_defect
#print axioms complete_generator_defect
#print axioms reversed_two_path_pairing
end BuildingBlocks.GroundRateCommutator
