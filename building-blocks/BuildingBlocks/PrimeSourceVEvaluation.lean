import BuildingBlocks.PrimeDensityFilter

open MeasureTheory Set Finset
open scoped Interval ENNReal BigOperators

namespace BuildingBlocks.PrimeSourceVEvaluation

open CoarsePrimitive SamePrimeBirthConvolution SamePrimeBlockCalibration PrimeBlockSource
  PrimeSourceDistinctFilter PrimeDensityFilter ReflectionFilter

private abbrev LP (s : ℝ) (f : ℝ → ℝ) := MemLp f 2 (volume.restrict (Set.Icc 0 s))
private abbrev WI (s : ℝ) (f : ℝ → ℝ) :=
  IntervalIntegrable (fun v => Real.exp (-3*(s-v)/2)*f v) volume 0 s

private theorem l0_congr {s : ℝ} (hs : 0 ≤ s) {f g : ℝ → ℝ}
    (he : EqOn f g (Set.Icc 0 s)) : L0 f s = L0 g s := by
  unfold L0
  rw [he ⟨hs, le_rfl⟩]
  congr 1
  apply intervalIntegral.integral_congr
  intro v hv
  have hv' : v ∈ Set.Icc 0 s := by simpa [uIcc_of_le hs] using hv
  dsimp only
  rw [he hv']

private theorem l0_sum (J : Finset ℕ) (F : ℕ → ℝ → ℝ) (s : ℝ)
    (hi : ∀ j ∈ J, WI s (F j)) :
    L0 (fun v => ∑ j ∈ J, F j v) s = ∑ j ∈ J, L0 (F j) s := by
  unfold L0
  simp_rw [Finset.mul_sum]
  rw [intervalIntegral.integral_finset_sum hi, Finset.sum_sub_distrib]

private theorem wi_sum (J : Finset ℕ) (F : ℕ → ℝ → ℝ) (s : ℝ)
    (hi : ∀ j ∈ J, WI s (F j)) : WI s (fun v => ∑ j ∈ J, F j v) := by
  unfold WI
  simp only [Finset.mul_sum]
  convert (IntervalIntegrable.sum J (a := 0) (b := s)
    (f := fun j v => Real.exp (-3*(s-v)/2)*F j v) hi) using 1
  funext v
  simp

private theorem l0_const (c : ℝ) (F : ℝ → ℝ) (s : ℝ) :
    L0 (fun v => c*F v) s = c*L0 F s := by
  unfold L0
  have he : (fun v => Real.exp (-3*(s-v)/2)*(c*F v)) =
      (fun v => c*(Real.exp (-3*(s-v)/2)*F v)) := by funext v; ring
  rw [he, intervalIntegral.integral_const_mul]
  ring

private theorem conv_congr {s v : ℝ} (hv : v ∈ Set.Icc 0 s)
    {f f' g g' : ℝ → ℝ} (hf : EqOn f f' (Set.Icc 0 s))
    (hg : EqOn g g' (Set.Icc 0 s)) : conv f g v = conv f' g' v := by
  unfold conv
  apply intervalIntegral.integral_congr
  intro u hu
  have hu' : u ∈ Set.Icc 0 v := by simpa [uIcc_of_le hv.1] using hu
  dsimp only
  rw [hf ⟨hu'.1, hu'.2.trans hv.2⟩,
    hg ⟨sub_nonneg.mpr hu'.2, by linarith [hu'.1, hv.2]⟩]

private theorem conv_sum_left {s v : ℝ} (hv : v ∈ Set.Icc 0 s)
    (J : Finset ℕ) (F : ℕ → ℝ → ℝ) (g : ℝ → ℝ)
    (hF : ∀ j ∈ J, LP s (F j)) (hg : LP s g) :
    conv (fun u => ∑ j ∈ J, F j u) g v = ∑ j ∈ J, conv (F j) g v := by
  unfold conv
  simp only [Finset.sum_mul]
  exact intervalIntegral.integral_finset_sum (fun j hj => conv_integrand hv (hF j hj) hg)

private theorem fc_sum_left {s : ℝ} (hs : 0 ≤ s)
    (J : Finset ℕ) (F : ℕ → ℝ → ℝ) (g : ℝ → ℝ)
    (hF : ∀ j ∈ J, LP s (F j)) (hg : LP s g) :
    L0 (conv (fun u => ∑ j ∈ J, F j u) g) s =
      ∑ j ∈ J, L0 (conv (F j) g) s := by
  rw [l0_congr hs (fun v hv => conv_sum_left hv J F g hF hg)]
  exact l0_sum J _ s (fun j hj => filtered_conv_integrable hs (hF j hj) hg)

private theorem fc_sum_right {s : ℝ} (hs : 0 ≤ s)
    (J : Finset ℕ) (F : ℕ → ℝ → ℝ) (g : ℝ → ℝ)
    (hF : ∀ j ∈ J, LP s (F j)) (hg : LP s g) :
    L0 (conv g (fun u => ∑ j ∈ J, F j u)) s =
      ∑ j ∈ J, L0 (conv g (F j)) s := by
  have he (f g : ℝ → ℝ) : conv f g = conv g f := by funext v; exact conv_comm _ _ _
  rw [he g, fc_sum_left hs J F g hF hg]
  apply Finset.sum_congr rfl
  intro j _
  rw [he (F j)]

private theorem fc_const_left (c s : ℝ) (f g : ℝ → ℝ) :
    L0 (conv (fun u => c*f u) g) s = c*L0 (conv f g) s := by
  have he : conv (fun u => c*f u) g = fun v => c*conv f g v := by
    funext v
    unfold conv
    simp only [mul_assoc]
    exact intervalIntegral.integral_const_mul _ _
  rw [he, l0_const]

private theorem fc_const_right (c s : ℝ) (f g : ℝ → ℝ) :
    L0 (conv f (fun u => c*g u)) s = c*L0 (conv f g) s := by
  have he (f g : ℝ → ℝ) : conv f g = conv g f := by funext v; exact conv_comm _ _ _
  rw [he f, fc_const_left, he g]

/-- Freeze the complete Mangoldt history directly, reusing the actual psi identity. -/
theorem frozenSum_eq_mangoldt_births {s v : ℝ} (hv : v ≤ s) :
    frozenSum s v = ∑ n ∈ Finset.Icc 1 ⌊Real.exp s⌋₊,
      ArithmeticFunction.vonMangoldt n * birth (Real.log n) v := by
  rw [frozenSum_eq hv, primeBlockSum_eq_psi, psi_eq_sum_Icc, Finset.mul_sum]
  have hN := Nat.floor_mono (Real.exp_le_exp.mpr hv)
  calc
    _ = ∑ n ∈ Finset.Icc 1 ⌊Real.exp v⌋₊,
        ArithmeticFunction.vonMangoldt n * birth (Real.log n) v := by
      apply Finset.sum_congr rfl
      intro n hn
      have hn1 := (Finset.mem_Icc.mp hn).1
      have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
      have hnexp : (n : ℝ) ≤ Real.exp v := (Nat.le_floor_iff (Real.exp_pos v).le).mp (Finset.mem_Icc.mp hn).2
      have hlog : Real.log n ≤ v := (Real.log_le_iff_le_exp hn0).mpr hnexp
      simp [birth, hlog, mul_comm]
    _ = _ := by
      apply Finset.sum_subset
      · intro n hn
        exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hn).1, (Finset.mem_Icc.mp hn).2.trans hN⟩
      · intro n hn hnot
        have hn1 := (Finset.mem_Icc.mp hn).1
        have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
        have hlog : ¬Real.log n ≤ v := by
          intro h
          have hne := (Real.log_le_iff_le_exp hn0).mp h
          exact hnot (Finset.mem_Icc.mpr ⟨hn1, (Nat.le_floor_iff (Real.exp_pos v).le).mpr hne⟩)
        simp [birth, hlog]

noncomputable def mixedArithmetic (s : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 ⌊Real.exp s⌋₊,
    ArithmeticFunction.vonMangoldt n * (Real.exp (2*s) - (n : ℝ)^2) / n

/-- Both filtered density orders regroup into the single complete Mangoldt sum. -/
theorem filtered_mixed_arithmetic {s : ℝ} (hs : 0 ≤ s) :
    L0 (mixedLeft s) s + L0 (mixedRight s) s = Real.exp (-3*s/2)*mixedArithmetic s := by
  have hP : ∀ p ∈ primesAt s, LP s (primeBlock p) :=
    fun p hp => primeBlock_memLp (Finset.mem_filter.mp hp).2 s
  have hL : L0 (mixedLeft s) s = L0 (conv (frozenSum s) density) s := by
    symm
    exact l0_congr hs (fun v hv => conv_sum_left hv _ _ _ hP (density_memLp s))
  have hR : L0 (mixedRight s) s = L0 (conv density (frozenSum s)) s := by
    apply l0_congr hs
    intro v hv
    dsimp only [mixedRight]
    simp_rw [conv_comm density]
    exact (conv_sum_left hv _ _ _ hP (density_memLp s)).symm
  let F : ℕ → ℝ → ℝ := fun n v => ArithmeticFunction.vonMangoldt n * birth (Real.log n) v
  have hF (n : ℕ) : LP s (F n) := (birth_memLp (Real.log n) s).const_mul _
  have he : EqOn (frozenSum s) (fun v => ∑ n ∈ Finset.Icc 1 ⌊Real.exp s⌋₊, F n v) (Set.Icc 0 s) :=
    fun v hv => frozenSum_eq_mangoldt_births hv.2
  rw [hL, hR, l0_congr hs (fun v hv => conv_congr hv he (fun _ _ => rfl)),
    l0_congr hs (fun v hv => conv_congr hv (fun _ _ => rfl) he),
    fc_sum_left hs _ F density (fun n _ => hF n) (density_memLp s),
    fc_sum_right hs _ F density (fun n _ => hF n) (density_memLp s)]
  rw [← Finset.sum_add_distrib]
  unfold mixedArithmetic
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro n hn
  dsimp only [F]
  rw [fc_const_left, fc_const_right, ← mul_add]
  have hn1 := (Finset.mem_Icc.mp hn).1
  have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hb : 0 ≤ Real.log n := Real.log_nonneg (by exact_mod_cast hn1)
  have hnexp : (n : ℝ) ≤ Real.exp s := (Nat.le_floor_iff (Real.exp_pos s).le).mp (Finset.mem_Icc.mp hn).2
  have hbs : Real.log n ≤ s := (Real.log_le_iff_le_exp hn0).mpr hnexp
  rw [filtered_mixed_orders_normalized hb hs, if_pos hbs, Real.exp_log hn0]
  have he2 : Real.exp (2*Real.log n) = (n : ℝ)^2 := by
    rw [show 2*Real.log n=Real.log n+Real.log n by ring, Real.exp_add, Real.exp_log hn0]
    ring
  rw [he2]
  ring

noncomputable def pairArithmetic (p q : ℕ) (s : ℝ) : ℝ :=
  ∑ j ∈ Finset.Icc 1 ⌊Real.exp s⌋₊, ∑ k ∈ Finset.Icc 1 ⌊Real.exp s⌋₊,
    if (p : ℝ)^j*(q : ℝ)^k ≤ Real.exp s then
      (Real.exp s - (p : ℝ)^j*(q : ℝ)^k)*Real.log p*Real.log q else 0

/-- All locally active exponents in two actual prime blocks have the literal product tent. -/
theorem filtered_primeBlock_pair {p q : ℕ} (hp : p.Prime) (hq : q.Prime)
    {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv (primeBlock p) (primeBlock q)) s = Real.exp (-3*s/2)*pairArithmetic p q s := by
  have hep : EqOn (primeBlock p) (block ⌊Real.exp s⌋₊ p) (Set.Icc 0 s) :=
    fun v hv => (block_eq_primeBlock_on hp hv.2).symm
  have heq : EqOn (primeBlock q) (block ⌊Real.exp s⌋₊ q) (Set.Icc 0 s) :=
    fun v hv => (block_eq_primeBlock_on hq hv.2).symm
  rw [l0_congr hs (fun v hv => conv_congr hv hep heq)]
  let J := Finset.Icc 1 ⌊Real.exp s⌋₊
  let fp : ℕ → ℝ → ℝ := fun j => birth ((j : ℝ)*Real.log p)
  let fq : ℕ → ℝ → ℝ := fun k => birth ((k : ℝ)*Real.log q)
  have hfp (j : ℕ) : LP s (fp j) := birth_memLp _ s
  have hfq (k : ℕ) : LP s (fq k) := birth_memLp _ s
  change L0 (conv (fun v => Real.log p * ∑ j ∈ J, fp j v)
    (fun v => Real.log q * ∑ k ∈ J, fq k v)) s = _
  rw [fc_const_left, fc_const_right,
    fc_sum_left hs J fp _ (fun j _ => hfp j) (memLp_finset_sum J (fun k _ => hfq k))]
  have he : (∑ j ∈ J, L0 (conv (fp j) (fun v => ∑ k ∈ J, fq k v)) s) =
      ∑ j ∈ J, ∑ k ∈ J, L0 (conv (fp j) (fq k)) s := by
    apply Finset.sum_congr rfl
    intro j _
    exact fc_sum_right hs J fq (fp j) (fun k _ => hfq k) (hfp j)
  rw [he]
  unfold pairArithmetic
  change Real.log p * (Real.log q * ∑ j ∈ J, ∑ k ∈ J, L0 (conv (fp j) (fq k)) s) =
    Real.exp (-3*s/2) * ∑ j ∈ J, ∑ k ∈ J, _
  simp only [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j _
  apply Finset.sum_congr rfl
  intro k _
  dsimp only [fp, fq]
  rw [← mul_assoc, prime_power_pair_evaluation hp hq j k hs]
  split_ifs <;> ring

noncomputable def distinctArithmetic (s : ℝ) : ℝ :=
  ∑ p ∈ primesAt s, ∑ q ∈ (primesAt s).erase p, pairArithmetic p q s

/-- The outer sum retains ordered distinct primes and every active exponent pair. -/
theorem filtered_distinct_arithmetic {s : ℝ} (hs : 0 ≤ s) :
    L0 (distinct s) s = Real.exp (-3*s/2)*distinctArithmetic s := by
  have hP : ∀ p ∈ primesAt s, LP s (primeBlock p) :=
    fun p hp => primeBlock_memLp (Finset.mem_filter.mp hp).2 s
  have hi : ∀ p ∈ primesAt s, ∀ q ∈ (primesAt s).erase p,
      WI s (conv (primeBlock p) (primeBlock q)) := fun p hp q hq =>
    filtered_conv_integrable hs (hP p hp) (hP q (Finset.mem_of_mem_erase hq))
  unfold distinct distinctArithmetic
  rw [l0_sum _ _ s (fun p hp => wi_sum _ _ s (fun q hq => hi p hp q hq)), Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro p hp
  rw [l0_sum _ _ s (fun q hq => hi p hp q hq), Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro q hq
  exact filtered_primeBlock_pair (Finset.mem_filter.mp hp).2
    (Finset.mem_filter.mp (Finset.mem_of_mem_erase hq)).2 hs

/-- Literal finite V in logarithmic age, with ordered distinct-prime products and complete Lambda. -/
noncomputable def VAtAge (s : ℝ) : ℝ :=
  distinctArithmetic s - mixedArithmetic s +
    (Real.exp (2*s)*s/2 + Real.exp (2*s)/4 - 1/4)

/-- Exact normalized V identification; this is an equality, with no sign premise. -/
theorem actual_source_V {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv source source) s - tau s = Real.exp (-3*s/2)*VAtAge s := by
  rw [filtered_source_distinct hs, filtered_distinct_arithmetic hs, density_square_normalized hs]
  have hm := filtered_mixed_arithmetic hs
  unfold VAtAge
  nlinarith

/-- The finite arithmetic V(x), without a logarithmic reparametrization in its definition. -/
noncomputable def rawV (x : ℝ) : ℝ :=
  (∑ p ∈ (Finset.Icc 2 ⌊x⌋₊).filter Nat.Prime,
    ∑ q ∈ ((Finset.Icc 2 ⌊x⌋₊).filter Nat.Prime).erase p,
    ∑ j ∈ Finset.Icc 1 ⌊x⌋₊, ∑ k ∈ Finset.Icc 1 ⌊x⌋₊,
      if (p : ℝ)^j*(q : ℝ)^k ≤ x then
        (x-(p : ℝ)^j*(q : ℝ)^k)*Real.log p*Real.log q else 0) -
  (∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
    ArithmeticFunction.vonMangoldt n * (x^2-(n : ℝ)^2)/n) +
  (x^2*Real.log x/2+x^2/4-1/4)

theorem VAtAge_eq_rawV (s : ℝ) : VAtAge s = rawV (Real.exp s) := by
  have he : Real.exp (2*s) = (Real.exp s)^2 := by
    rw [show 2*s=s+s by ring, Real.exp_add]
    ring
  simp only [VAtAge, rawV, distinctArithmetic, pairArithmetic, mixedArithmetic,
    primesAt, Real.log_exp, he]

@[simp] theorem rawV_one : rawV 1 = 0 := by norm_num [rawV]

/-- The original causal convention: no arithmetic area exists before x=1. -/
noncomputable def V (x : ℝ) : ℝ := if x ≤ 1 then 0 else rawV x

theorem V_eq_rawV {x : ℝ} (hx : 1 ≤ x) : V x = rawV x := by
  by_cases h : x ≤ 1
  · have he : x = 1 := le_antisymm h hx
    simp [V, he]
  · simp [V, h]

theorem V_eq_zero_of_le_one {x : ℝ} (hx : x ≤ 1) : V x = 0 := by simp [V, hx]

theorem VAtAge_eq {s : ℝ} (hs : 0 ≤ s) : VAtAge s = V (Real.exp s) := by
  rw [V_eq_rawV (Real.one_le_exp_iff.mpr hs), VAtAge_eq_rawV]

/-- Full filtered actual-source identity at x=exp(s), preserving every finite birth. -/
theorem actual_source_eq_normalized_V {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv source source) s - tau s = Real.exp (-3*s/2)*V (Real.exp s) := by
  rw [actual_source_V hs, VAtAge_eq hs]

@[simp] theorem V_one : V 1 = 0 := by simp [V]

#print axioms actual_source_eq_normalized_V
#print axioms V_one
#print axioms filtered_primeBlock_pair
#print axioms filtered_distinct_arithmetic
#print axioms actual_source_V
#print axioms frozenSum_eq_mangoldt_births
#print axioms filtered_mixed_arithmetic

end BuildingBlocks.PrimeSourceVEvaluation
