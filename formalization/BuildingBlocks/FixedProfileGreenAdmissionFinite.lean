import BuildingBlocks.LargestPrimeSquarefreePackets
import Mathlib.Analysis.InnerProductSpace.Basic

namespace BuildingBlocks.FixedProfileGreenAdmissionFinite

open Finset Real
open scoped BigOperators ArithmeticFunction.Moebius

noncomputable section

abbrev μR (n : ℕ) : ℝ := (ArithmeticFunction.moebius n : ℝ)

/-- The literal fixed-profile Green Gram kernel. -/
def greenKernel (d e : ℕ) : ℝ :=
  (2 * ((|((d : ℤ) - e)| : ℝ) + 1) * exp (-2 * (max d e : ℕ)) -
      exp (-2 * ((d + e : ℕ) : ℝ))) / (8 * d * e)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℝ H]

/-- Complete old Möbius packet over all divisors of the old squarefree product. -/
def oldPacket (G : ℕ → H) (N : ℕ) : H :=
  ∑ d ∈ N.divisors, μR d • G d

/-- Complete newly attached packet, including its `e = 1` face. -/
def delayedPacket (G : ℕ → H) (N p : ℕ) : H :=
  ∑ e ∈ N.divisors, μR e • G (p * e)

/-- All genuinely delayed/cofactor faces (`e > 1` for a divisor packet). -/
def delayedTail (G : ℕ → H) (N p : ℕ) : H :=
  ∑ e ∈ N.divisors.erase 1, μR e • G (p * e)

/-- The exact doubled-energy admission convention. -/
def doubledIncrement (F U : H) : ℝ :=
  2 * (inner ℝ U U - 2 * inner ℝ F U)

theorem delayedPacket_eq_base_add_tail (G : ℕ → H) {N p : ℕ} (hN : N ≠ 0) :
    delayedPacket G N p = G p + delayedTail G N p := by
  have h1 : 1 ∈ N.divisors := by simp [hN]
  have hs := Finset.sum_erase_add (N.divisors) (fun e => μR e • G (p * e)) h1
  unfold delayedPacket delayedTail
  calc
    (∑ e ∈ N.divisors, μR e • G (p * e)) =
        (∑ e ∈ N.divisors.erase 1, μR e • G (p * e)) + μR 1 • G (p * 1) := hs.symm
    _ = G p + ∑ e ∈ N.divisors.erase 1, μR e • G (p * e) := by
      simp [μR, add_comm]

/-- Exact separation of the base face, all delayed faces, and the old cross. -/
theorem doubledIncrement_decomposition (F g V : H) :
    doubledIncrement F (g + V) =
      2 * (inner ℝ g g - 2 * inner ℝ F g +
        (2 * inner ℝ g V + inner ℝ V V - 2 * inner ℝ F V)) := by
  simp only [doubledIncrement, inner_add_left, inner_add_right]
  rw [real_inner_comm V g]
  ring

/-- Exact perturbation identity.  This isolates the only data required from a
finite-horizon approximation: errors in the old and delayed packet vectors. -/
theorem doubledIncrement_perturbation (F U E V : H) :
    doubledIncrement (F + E) (U + V) - doubledIncrement F U =
      2 * (2 * inner ℝ U V + inner ℝ V V - 2 * inner ℝ F V -
        2 * inner ℝ E U - 2 * inner ℝ E V) := by
  simp only [doubledIncrement, inner_add_left, inner_add_right]
  rw [real_inner_comm V U]
  ring

/-- A strict negative limiting admission transfers once the complete finite
horizon error is smaller than its literal margin. -/
theorem negative_increment_of_error_lt_margin {Δ ΔX : ℝ}
    (hΔ : Δ < 0) (herr : |ΔX - Δ| < |Δ|) : ΔX < 0 := by
  rw [abs_of_neg hΔ] at herr
  have hlo := (abs_lt.mp herr).2
  linarith

/-- Positive counterpart of the fixed-packet stability statement. -/
theorem positive_increment_of_error_lt_margin {Δ ΔX : ℝ}
    (hΔ : 0 < Δ) (herr : |ΔX - Δ| < |Δ|) : 0 < ΔX := by
  rw [abs_of_pos hΔ] at herr
  have hlo := (abs_lt.mp herr).1
  linarith

/-- Scalar finite kernel version, retaining every ordered old/delayed face. -/
def kernelIncrement (K : ℕ → ℕ → ℝ) (N p : ℕ) : ℝ :=
  2 * ((∑ d ∈ N.divisors, ∑ e ∈ N.divisors,
      μR d * μR e * K (p * e) (p * d)) -
    2 * (∑ d ∈ N.divisors, ∑ e ∈ N.divisors,
      μR d * μR e * K e (p * d)))

/-- Exact finite Gram dictionary for the complete actual Möbius packet. -/
theorem kernelIncrement_eq_doubledIncrement
    (G : ℕ → H) (K : ℕ → ℕ → ℝ) (N p : ℕ)
    (hK : ∀ d e, inner ℝ (G d) (G e) = K d e) :
    kernelIncrement K N p =
      doubledIncrement (oldPacket G N) (delayedPacket G N p) := by
  simp only [kernelIncrement, doubledIncrement, oldPacket, delayedPacket,
    sum_inner, inner_sum, real_inner_smul_left, real_inner_smul_right, hK]
  ring_nf

/-- The lower old rows in the base-face cross. -/
def lowerOldCross (K : ℕ → ℕ → ℝ) (N p : ℕ) : ℝ :=
  ∑ d ∈ N.divisors with d < p, μR d * K d p

/-- The upper old rows; these are the `J_p` cofactor faces. -/
def upperOldCross (K : ℕ → ℕ → ℝ) (N p : ℕ) : ℝ :=
  ∑ d ∈ N.divisors with p < d, μR d * K d p

/-- If the new prime is absent from the old product, there is literally no `d=p` row. -/
theorem new_row_absent {N p : ℕ} (hp : ¬p ∣ N) : p ∉ N.divisors := by
  intro hm
  exact hp (Nat.mem_divisors.mp hm).1

/-- Exact lower/upper split, conditional only on the literal absence of `p`. -/
theorem oldCross_eq_lower_add_upper
    (K : ℕ → ℕ → ℝ) {N p : ℕ} (hp : ¬p ∣ N) :
    (∑ d ∈ N.divisors, μR d * K d p) =
      lowerOldCross K N p + upperOldCross K N p := by
  classical
  rw [← Finset.sum_filter_add_sum_filter_not N.divisors (fun d => d < p)
    (fun d => μR d * K d p)]
  congr 1
  unfold upperOldCross
  have heq : {d ∈ N.divisors | ¬ d < p} = {d ∈ N.divisors | p < d} := by
    ext d
    simp only [Finset.mem_filter]
    constructor
    · intro h
      refine ⟨h.1, ?_⟩
      have hne : d ≠ p := by
        intro he
        subst d
        exact hp (Nat.mem_divisors.mp h.1).1
      omega
    · intro h
      exact ⟨h.1, by omega⟩
  rw [heq]


/-- The source's closed-endpoint truncated Möbius tent. -/
def truncatedTClosed (p : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 p, μR n * ((p : ℝ) / n - 1)

/-- The same finite tent with its identically-zero endpoint removed. -/
def truncatedT (p : ℕ) : ℝ :=
  ∑ n ∈ Ico 1 p, μR n * ((p : ℝ) / n - 1)

def reciprocalPrefixBelow (p : ℕ) : ℝ :=
  ∑ n ∈ Ico 1 p, μR n / n

def mertensBelow (p : ℕ) : ℝ :=
  ∑ n ∈ Ico 1 p, μR n

theorem truncatedTClosed_eq_truncatedT (p : ℕ) :
    truncatedTClosed p = truncatedT p := by
  classical
  symm
  apply Finset.sum_subset (s₁ := Ico 1 p) (s₂ := Icc 1 p)
  · intro n hn
    simp only [mem_Ico, mem_Icc] at hn ⊢
    omega
  · intro n hnIcc hnIco
    simp only [mem_Icc, mem_Ico] at hnIcc hnIco
    have hn : n = p := by omega
    subst n
    have hp0 : p ≠ 0 := by omega
    have hpR : (p : ℝ) ≠ 0 := by exact_mod_cast hp0
    have hz : (p : ℝ) / p - 1 = 0 := by rw [div_self hpR]; norm_num
    rw [hz, mul_zero]

theorem truncatedT_eq_main_term (p : ℕ) :
    truncatedT p = (p : ℝ) * reciprocalPrefixBelow p - mertensBelow p := by
  simp only [truncatedT, reciprocalPrefixBelow, mertensBelow]
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  ring

/-- Exact finite lower-row main term used in the Green admission calculation. -/
theorem truncatedTClosed_eq_main_term (p : ℕ) :
    truncatedTClosed p = (p : ℝ) * reciprocalPrefixBelow p - mertensBelow p := by
  rw [truncatedTClosed_eq_truncatedT, truncatedT_eq_main_term]

/-- Pure finite sign extraction.  The only input is the already evaluated lower
Green row; diagonal, upper-row `J`, and delayed faces remain explicit. -/
theorem scaled_increment_main_sign
    {p : ℕ} (hp : 0 < p) (Δ diag J D A B : ℝ)
    (hΔ : Δ / 2 = diag -
      2 * (exp (-2 * (p : ℝ)) / (4 * p) *
        (truncatedTClosed p + A - B / 2) + J) + D) :
    (p : ℝ) * exp (2 * p) * Δ = -truncatedTClosed p +
      (2 * p * exp (2 * p) * diag - A + B / 2 -
        4 * p * exp (2 * p) * J + 2 * p * exp (2 * p) * D) := by
  have hpR : (p : ℝ) ≠ 0 := by positivity
  have hexp : exp ((p : ℝ) * 2) * exp (-((p : ℝ) * 2)) = 1 := by
    rw [← Real.exp_add]
    norm_num
  have hΔ' : Δ = 2 * (diag -
      2 * (exp (-2 * (p : ℝ)) / (4 * p) *
        (truncatedTClosed p + A - B / 2) + J) + D) := by linarith
  rw [hΔ']
  field_simp [hpR]
  ring_nf
  rw [hexp]
  ring

#print axioms delayedPacket_eq_base_add_tail
#print axioms doubledIncrement_decomposition
#print axioms doubledIncrement_perturbation
#print axioms negative_increment_of_error_lt_margin
#print axioms positive_increment_of_error_lt_margin
#print axioms kernelIncrement_eq_doubledIncrement
#print axioms new_row_absent
#print axioms oldCross_eq_lower_add_upper
#print axioms truncatedTClosed_eq_truncatedT
#print axioms truncatedT_eq_main_term
#print axioms truncatedTClosed_eq_main_term
#print axioms scaled_increment_main_sign

end
end BuildingBlocks.FixedProfileGreenAdmissionFinite
