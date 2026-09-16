import Mathlib.Tactic

namespace BuildingBlocks.SignedCoreGramContraction

/-!
Finite algebra for the signed theta-core Gram certificate.

The analytic construction of the core operator, the square-root factor of its
positive part, and a Moore--Penrose inverse are deliberately hypotheses.  This
file proves only the exact algebra used after those data have been validated.
-/

/-- The indefinite mean row is exactly one positive Gram row minus one
negative Gram row. -/
theorem complex_mean_gram_split (m b : ℂ) :
    2 * (b * star m).re =
      Complex.normSq (m + b) / 2 - Complex.normSq (m - b) / 2 := by
  simp [Complex.normSq_apply]
  ring

/-- Pointwise `U/W` decomposition of the complete signed core form.  The
arguments `sSq`, `kSq`, and `jSq` stand for the full weighted crossing Gram,
odd-affine Gram, and finite observation Gram respectively. -/
theorem signedCore_uw_decomposition
    (base sSq kSq jSq : ℝ) (m b : ℂ) :
    base + 2 * (b * star m).re - sSq + kSq + jSq =
      (base + Complex.normSq (m + b) / 2 + kSq + jSq) -
        (Complex.normSq (m - b) / 2 + sSq) := by
  rw [complex_mean_gram_split]
  ring

/-- Nonnegativity of `A-W*W` is exactly domination of the negative Gram
quadratic form by the positive part. -/
theorem gramDifference_nonnegative_iff {X : Type*} (qA qW : X → ℝ) :
    (∀ x, 0 ≤ qA x - qW x) ↔ ∀ x, qW x ≤ qA x := by
  constructor <;> intro h x <;> linarith [h x]

/-- A nonnegative Gram difference forces the negative Gram row to vanish on
the kernel of the positive quadratic form.  This is the kernel-inclusion part
of the singular Schur criterion. -/
theorem gramDifference_kernel_inclusion
    {X : Type*} (qA qW : X → ℝ)
    (hW : ∀ x, 0 ≤ qW x)
    (hH : ∀ x, 0 ≤ qA x - qW x) :
    ∀ x, qA x = 0 → qW x = 0 := by
  intro x hx
  have hle : qW x ≤ qA x := (gramDifference_nonnegative_iff qA qW).mp hH x
  exact le_antisymm (by simpa [hx] using hle) (hW x)

/-- For squared Hilbert norms, positivity of the Gram difference is equivalent
to the contraction inequality. -/
theorem squaredNorm_difference_nonnegative_iff
    {X Y Z : Type*}
    [SeminormedAddCommGroup Y] [SeminormedAddCommGroup Z]
    (Ahalf : X → Y) (W : X → Z) :
    (∀ x, 0 ≤ ‖Ahalf x‖ ^ 2 - ‖W x‖ ^ 2) ↔
      ∀ x, ‖W x‖ ≤ ‖Ahalf x‖ := by
  constructor
  · intro h x
    have hs : ‖W x‖ ^ 2 ≤ ‖Ahalf x‖ ^ 2 := by linarith [h x]
    exact (sq_le_sq₀ (norm_nonneg _) (norm_nonneg _)).mp hs
  · intro h x
    have hs : ‖W x‖ ^ 2 ≤ ‖Ahalf x‖ ^ 2 :=
      (sq_le_sq₀ (norm_nonneg _) (norm_nonneg _)).mpr (h x)
    linarith

/-- The contraction forces the negative row to vanish on the kernel of the
positive square-root factor. -/
theorem contraction_kernel_inclusion
    {X Y Z : Type*}
    [SeminormedAddCommGroup Y] [NormedAddCommGroup Z]
    (Ahalf : X → Y) (W : X → Z)
    (hcontract : ∀ x, ‖W x‖ ≤ ‖Ahalf x‖) :
    ∀ x, Ahalf x = 0 → W x = 0 := by
  intro x hx
  have hw : ‖W x‖ ≤ 0 := by simpa [hx] using hcontract x
  exact norm_eq_zero.mp (le_antisymm hw (norm_nonneg _))

/-- Abstract Moore--Penrose replay.  `rightOnRange` and `kernelFactor` are the
operator-analytic inputs normally proved from the pseudoinverse.  Under them,
the full contraction is equivalent to contraction of the pseudoinverse on the
range of the positive square-root factor. -/
theorem pseudoinverse_contraction_iff
    {X Y Z : Type*}
    [SeminormedAddCommGroup Y] [SeminormedAddCommGroup Z]
    (Ahalf : X → Y) (W : X → Z) (pinv : Y → X)
    (rightOnRange : ∀ y ∈ Set.range Ahalf, Ahalf (pinv y) = y)
    (kernelFactor : ∀ x, W x = W (pinv (Ahalf x))) :
    (∀ x, ‖W x‖ ≤ ‖Ahalf x‖) ↔
      ∀ y ∈ Set.range Ahalf, ‖W (pinv y)‖ ≤ ‖y‖ := by
  constructor
  · intro h y hy
    simpa [rightOnRange y hy] using h (pinv y)
  · intro h x
    rw [kernelFactor x]
    exact h (Ahalf x) ⟨x, rfl⟩

/-- Combined singular Schur criterion in square-root/pseudoinverse form.  In a
validated finite matrix application, `Ahalf` is the positive square root of
`A`, `pinv` its Moore--Penrose inverse on the range, and `kernelFactor` is
exactly the required inclusion `ker A ⊆ ker W`. -/
theorem gramDifference_nonnegative_iff_pseudoinverse_contraction
    {X Y Z : Type*}
    [SeminormedAddCommGroup Y] [SeminormedAddCommGroup Z]
    (Ahalf : X → Y) (W : X → Z) (pinv : Y → X)
    (rightOnRange : ∀ y ∈ Set.range Ahalf, Ahalf (pinv y) = y)
    (kernelFactor : ∀ x, W x = W (pinv (Ahalf x))) :
    (∀ x, 0 ≤ ‖Ahalf x‖ ^ 2 - ‖W x‖ ^ 2) ↔
      ∀ y ∈ Set.range Ahalf, ‖W (pinv y)‖ ≤ ‖y‖ := by
  rw [squaredNorm_difference_nonnegative_iff]
  exact pseudoinverse_contraction_iff Ahalf W pinv rightOnRange kernelFactor

/-- With a strictly positive Young coupling budget `C`, some positive split
parameter makes both block coefficients nonnegative exactly under the product
criterion. -/
theorem exists_young_split_iff_product
    {h g C : ℝ} (hC : 0 < C) :
    (∃ ε : ℝ, 0 < ε ∧ 0 ≤ h - ε ∧ 0 ≤ g - C ^ 2 / ε) ↔
      0 < h ∧ 0 < g ∧ C ^ 2 ≤ h * g := by
  constructor
  · rintro ⟨ε, hε, hh, hg⟩
    have hhpos : 0 < h := by linarith
    have hC2 : 0 < C ^ 2 := sq_pos_of_pos hC
    have hmul : C ^ 2 ≤ g * ε := by
      have := (div_le_iff₀ hε).mp (by linarith : C ^ 2 / ε ≤ g)
      simpa [mul_comm] using this
    have hgpos : 0 < g := by nlinarith
    have hεh : ε ≤ h := by linarith
    have : g * ε ≤ g * h := mul_le_mul_of_nonneg_left hεh hgpos.le
    constructor
    · exact hhpos
    constructor
    · exact hgpos
    · exact le_trans hmul (by simpa [mul_comm] using this)
  · rintro ⟨hh, hg, hprod⟩
    refine ⟨h, hh, by simp, ?_⟩
    have : C ^ 2 / h ≤ g := (div_le_iff₀ hh).2 (by simpa [mul_comm] using hprod)
    linarith

/-- Algebraic crossing parameter for the two Young block bounds. -/
noncomputable def youngEpsilon (h g C : ℝ) : ℝ :=
  (h - g + Real.sqrt ((h - g) ^ 2 + 4 * C ^ 2)) / 2

/-- Common value of the two block bounds at the crossing parameter. -/
noncomputable def youngConstant (h g C : ℝ) : ℝ :=
  (h + g - Real.sqrt ((h - g) ^ 2 + 4 * C ^ 2)) / 2

theorem h_sub_youngEpsilon (h g C : ℝ) :
    h - youngEpsilon h g C = youngConstant h g C := by
  simp [youngEpsilon, youngConstant]
  ring

/-- The crossing parameter is positive when the coupling budget is. -/
theorem youngEpsilon_pos {h g C : ℝ} (hC : 0 < C) :
    0 < youngEpsilon h g C := by
  have hrad : 0 ≤ (h - g) ^ 2 + 4 * C ^ 2 := by positivity
  have hsq : (g - h) ^ 2 < (h - g) ^ 2 + 4 * C ^ 2 := by
    have : 0 < C ^ 2 := sq_pos_of_pos hC
    nlinarith [sq_nonneg (h - g), sq_nonneg (g - h)]
  have hsqrt : g - h < Real.sqrt ((h - g) ^ 2 + 4 * C ^ 2) := by
    by_cases hgh : 0 ≤ g - h
    · exact (Real.lt_sqrt hgh).2 hsq
    · exact lt_of_lt_of_le (lt_of_not_ge hgh) (Real.sqrt_nonneg _)
  simp [youngEpsilon]
  linarith

/-- At the crossing parameter the complementary block has the same value. -/
theorem g_sub_div_youngEpsilon {h g C : ℝ} (hC : 0 < C) :
    g - C ^ 2 / youngEpsilon h g C = youngConstant h g C := by
  let e := youngEpsilon h g C
  let c := youngConstant h g C
  have he : 0 < e := youngEpsilon_pos hC
  have hrad : 0 ≤ (h - g) ^ 2 + 4 * C ^ 2 := by positivity
  have hsqrt := Real.sq_sqrt hrad
  have hquad : e ^ 2 + (g - h) * e - C ^ 2 = 0 := by
    dsimp [e, youngEpsilon]
    nlinarith
  have hce : h - e = c := by
    dsimp [e, c]
    exact h_sub_youngEpsilon h g C
  have hdiv : C ^ 2 / e = e + (g - h) := by
    apply (div_eq_iff he.ne').2
    nlinarith
  rw [hdiv]
  linarith

/-- Under nonnegative diagonal block margins, nonnegativity of the optimized
Young constant is exactly the determinant/product condition. -/
theorem youngConstant_nonnegative_iff_product
    {h g C : ℝ} (hh : 0 ≤ h) (hg : 0 ≤ g) :
    0 ≤ youngConstant h g C ↔ C ^ 2 ≤ h * g := by
  have hsum : 0 ≤ h + g := add_nonneg hh hg
  have hrad : 0 ≤ (h - g) ^ 2 + 4 * C ^ 2 := by positivity
  rw [youngConstant]
  constructor
  · intro hc
    have hsqrt : Real.sqrt ((h - g) ^ 2 + 4 * C ^ 2) ≤ h + g := by
      linarith
    have hsquare := (Real.sqrt_le_iff).mp hsqrt |>.2
    nlinarith
  · intro hprod
    have hsquare : (h - g) ^ 2 + 4 * C ^ 2 ≤ (h + g) ^ 2 := by
      nlinarith
    have hsqrt : Real.sqrt ((h - g) ^ 2 + 4 * C ^ 2) ≤ h + g :=
      (Real.sqrt_le_iff).2 ⟨hsum, hsquare⟩
    linarith

end BuildingBlocks.SignedCoreGramContraction

#print axioms BuildingBlocks.SignedCoreGramContraction.signedCore_uw_decomposition
#print axioms BuildingBlocks.SignedCoreGramContraction.gramDifference_nonnegative_iff_pseudoinverse_contraction
#print axioms BuildingBlocks.SignedCoreGramContraction.exists_young_split_iff_product
#print axioms BuildingBlocks.SignedCoreGramContraction.youngConstant_nonnegative_iff_product
