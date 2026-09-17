import BuildingBlocks.PrimeSourceDistinctFilter

open MeasureTheory Set
open scoped Interval ENNReal

namespace BuildingBlocks.PrimeDensityFilter

open SamePrimeBirthConvolution PrimeSourceDistinctFilter ReflectionFilter

private theorem interval_eq_Icc (g : ℝ → ℝ) {a b : ℝ} (hab : a ≤ b) :
    (∫ u in a..b, g u) = ∫ u in Icc a b, g u := by
  rw [intervalIntegral.integral_of_le hab, integral_Icc_eq_integral_Ioc]

private theorem integral_exp_affine (c k a b : ℝ) (hk : k ≠ 0) :
    (∫ u in a..b, Real.exp (c + k * u)) =
      (Real.exp (c + k * b) - Real.exp (c + k * a)) / k := by
  have hd (u : ℝ) : HasDerivAt (fun u => Real.exp (c + k * u) / k)
      (Real.exp (c + k * u)) u := by
    convert (((hasDerivAt_const u c).add ((hasDerivAt_id u).const_mul k)).exp.div_const k) using 1 <;>
      simp [hk]
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun u _ => hd u)
    ((by fun_prop : Continuous (fun u : ℝ => Real.exp (c + k * u))).intervalIntegrable _ _)]
  ring

noncomputable def mixedRamp (b v : ℝ) : ℝ :=
  (Ici b).indicator (fun v => Real.exp (v / 2 - b) - Real.exp (-v / 2)) v

/-- Reflection interchanges the two literal convolution orders. -/
theorem conv_comm (f g : ℝ → ℝ) (s : ℝ) : conv f g s = conv g f s := by
  unfold conv
  have hh := intervalIntegral.integral_comp_sub_left (f := fun u => f u * g (s - u))
    (a := 0) (b := s) s
  simp only [sub_self, sub_zero, sub_sub_cancel] at hh
  rw [← hh]
  apply intervalIntegral.integral_congr
  intro u _
  ring

/-- The mixed convolution activates at the actual birth, including equality. -/
theorem birth_density_convolution {b s : ℝ} (hb : 0 ≤ b) (hs : 0 ≤ s) :
    conv (birth b) density s = mixedRamp b s := by
  have heq : (fun u => birth b u * density (s - u)) =
      (Ici b).indicator (fun u => Real.exp (s / 2 - u)) := by
    funext u
    by_cases hu : b ≤ u
    · simp only [birth, density, Set.indicator_of_mem (show u ∈ Ici b from hu)]
      rw [← Real.exp_add]
      congr 1
      ring
    · simp [birth, density, hu]
  unfold conv
  rw [heq, interval_eq_Icc _ hs, integral_indicator measurableSet_Ici,
    Measure.restrict_restrict measurableSet_Ici]
  have hset : Ici b ∩ Icc 0 s = Icc b s := by
    ext u
    simp only [mem_inter_iff, mem_Ici, mem_Icc]
    constructor
    · intro h; exact ⟨h.1, h.2.2⟩
    · intro h; exact ⟨h.1, hb.trans h.1, h.2⟩
  rw [hset]
  by_cases hbs : b ≤ s
  · rw [← interval_eq_Icc _ hbs]
    have hh := integral_exp_affine (s / 2) (-1) b s (by norm_num)
    simp only [neg_one_mul, ← sub_eq_add_neg] at hh
    rw [hh]
    simp only [mixedRamp, Set.indicator_of_mem (show s ∈ Ici b from hbs)]
    rw [show s / 2 - s = -s / 2 by ring]
    ring
  · rw [Icc_eq_empty_of_lt (lt_of_not_ge hbs)]
    simp [mixedRamp, hbs]

private theorem mixedRamp_integrable (b a c : ℝ) : IntervalIntegrable (mixedRamp b) volume a c := by
  apply (intervalIntegrable_iff').mpr
  exact ((by fun_prop : Continuous (fun v : ℝ => Real.exp (v / 2 - b) - Real.exp (-v / 2))).integrableOn_Icc).indicator measurableSet_Ici

private theorem kernel_mixed (b s v : ℝ) :
    Real.exp (-3 * (s - v) / 2) * mixedRamp b v =
      (Ici b).indicator (fun v => Real.exp (-3*s/2+2*v-b) - Real.exp (-3*s/2+v)) v := by
  by_cases hv : b ≤ v
  · simp only [mixedRamp, Set.indicator_of_mem (show v ∈ Ici b from hv), mul_sub]
    rw [← Real.exp_add, ← Real.exp_add]
    congr 2 <;> ring
  · simp [mixedRamp, hv]

/-- Closed mixed birth--density formula under the literal filter. -/
theorem filtered_mixedRamp {b s : ℝ} (hb : 0 ≤ b) (hs : 0 ≤ s) :
    L0 (mixedRamp b) s = if b ≤ s then
      (Real.exp (s/2-b) - Real.exp (b-3*s/2))/2 else 0 := by
  unfold L0
  simp_rw [kernel_mixed]
  rw [interval_eq_Icc _ hs, integral_indicator measurableSet_Ici,
    Measure.restrict_restrict measurableSet_Ici]
  have hset : Ici b ∩ Icc 0 s = Icc b s := by
    ext u
    simp only [mem_inter_iff, mem_Ici, mem_Icc]
    constructor
    · intro h; exact ⟨h.1, h.2.2⟩
    · intro h; exact ⟨h.1, hb.trans h.1, h.2⟩
  rw [hset]
  by_cases hbs : b ≤ s
  · rw [if_pos hbs, ← interval_eq_Icc _ hbs]
    rw [intervalIntegral.integral_sub
      ((by fun_prop : Continuous (fun v : ℝ => Real.exp (-3*s/2+2*v-b))).intervalIntegrable _ _)
      ((by fun_prop : Continuous (fun v : ℝ => Real.exp (-3*s/2+v))).intervalIntegrable _ _)]
    have h1 := integral_exp_affine (-3*s/2-b) 2 b s (by norm_num)
    have h2 := integral_exp_affine (-3*s/2) 1 b s (by norm_num)
    have he : (fun v : ℝ => Real.exp (-3*s/2+2*v-b)) = (fun v => Real.exp ((-3*s/2-b)+2*v)) := by funext v; congr 1; ring
    simp only [one_mul, div_one] at h2
    rw [he, h1, h2]
    simp only [mixedRamp, Set.indicator_of_mem (show s ∈ Ici b from hbs)]
    rw [show -3*s/2-b+2*s=s/2-b by ring,
      show -3*s/2-b+2*b=b-3*s/2 by ring,
      show -3*s/2+s= -s/2 by ring, show -3*s/2+b=b-3*s/2 by ring]
    ring
  · rw [if_neg hbs, Icc_eq_empty_of_lt (lt_of_not_ge hbs)]
    simp [mixedRamp, hbs]

private theorem L0_congr {s : ℝ} (hs : 0 ≤ s) {f g : ℝ → ℝ}
    (he : EqOn f g (Icc 0 s)) : L0 f s = L0 g s := by
  unfold L0
  rw [he ⟨hs, le_rfl⟩]
  congr 1
  apply intervalIntegral.integral_congr
  intro v hv
  rw [uIcc_of_le hs] at hv
  dsimp only
  rw [he hv]

theorem filtered_birth_density {b s : ℝ} (hb : 0 ≤ b) (hs : 0 ≤ s) :
    L0 (conv (birth b) density) s = if b ≤ s then
      (Real.exp (s/2-b) - Real.exp (b-3*s/2))/2 else 0 := by
  rw [L0_congr hs (fun v hv => birth_density_convolution hb hv.1), filtered_mixedRamp hb hs]

theorem filtered_density_birth {b s : ℝ} (hb : 0 ≤ b) (hs : 0 ≤ s) :
    L0 (conv density (birth b)) s = if b ≤ s then
      (Real.exp (s/2-b) - Real.exp (b-3*s/2))/2 else 0 := by
  have he : conv density (birth b) = conv (birth b) density := by funext v; exact conv_comm _ _ _
  rw [he, filtered_birth_density hb hs]

private theorem density_kernel_integral (s : ℝ) :
    (∫ v in 0..s, Real.exp (-3*(s-v)/2) * (v * Real.exp (v/2))) =
      Real.exp (s/2) * (s/2-1/4) + Real.exp (-3*s/2)/4 := by
  have he : (fun v : ℝ => Real.exp (-3*(s-v)/2) * (v * Real.exp (v/2))) =
      (fun v => v * Real.exp (-3*s/2+2*v)) := by
    funext v
    rw [mul_left_comm, ← Real.exp_add]
    congr 2
    ring
  rw [he]
  have hd (v : ℝ) : HasDerivAt
      (fun v => Real.exp (-3*s/2+2*v) * (v/2-1/4))
      (v * Real.exp (-3*s/2+2*v)) v := by
    have ha := ((hasDerivAt_const v (-3*s/2)).add ((hasDerivAt_id v).const_mul 2)).exp
    have hb := ((hasDerivAt_id v).div_const 2).sub_const (1/4)
    have hh := ha.mul hb
    change HasDerivAt (fun v => Real.exp (-3*s/2+2*v) * (v/2-1/4))
      (Real.exp (-3*s/2+2*v) * (0+2*1) * (v/2-1/4) +
        Real.exp (-3*s/2+2*v) * (1/2)) v at hh
    convert hh using 1 <;> ring
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun v _ => hd v)
    ((by fun_prop : Continuous (fun v : ℝ => v * Real.exp (-3*s/2+2*v))).intervalIntegrable _ _)]
  rw [show -3*s/2+2*s=s/2 by ring]
  simp only [mul_zero, add_zero, zero_div]
  ring

/-- Both density orders are retained, and the density square is evaluated at every age. -/
theorem filtered_density_density {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv density density) s =
      Real.exp (s/2) * (s/2+1/4) - Real.exp (-3*s/2)/4 := by
  rw [L0_congr hs (fun v hv => density_convolution hv.1)]
  unfold L0
  dsimp only
  rw [density_kernel_integral]
  ring

theorem mixed_filtered_integrable {b s : ℝ} (hs : 0 ≤ s) :
    IntervalIntegrable (fun v => Real.exp (-3*(s-v)/2) * conv (birth b) density v) volume 0 s ∧
    IntervalIntegrable (fun v => Real.exp (-3*(s-v)/2) * conv density (birth b) v) volume 0 s :=
  ⟨filtered_conv_integrable hs (birth_memLp b s) (density_memLp s),
   filtered_conv_integrable hs (density_memLp s) (birth_memLp b s)⟩

theorem density_filtered_integrable {s : ℝ} (hs : 0 ≤ s) :
    IntervalIntegrable (fun v => Real.exp (-3*(s-v)/2) * conv density density v) volume 0 s :=
  filtered_conv_integrable hs (density_memLp s) (density_memLp s)

/-- The unweighted two-birth term has exactly the normalization used by V. -/
theorem filtered_birth_pair_normalized {b c s : ℝ} (hb : 0 ≤ b) (hc : 0 ≤ c)
    (hs : 0 ≤ s) :
    L0 (conv (birth b) (birth c)) s = if b+c ≤ s then
      Real.exp (-3*s/2) * (Real.exp s - Real.exp (b+c)) else 0 := by
  change L0 (fun v => ∫ u in 0..v, birth b u * birth c (v-u)) s = _
  rw [filtered_birth_convolution hb hc hs]
  by_cases ha : b+c ≤ s
  · rw [if_pos ha]
    simp only [theta, Set.indicator_of_mem (show s-b-c ∈ Ici 0 by change 0 ≤ s-b-c; linarith)]
    simp only [mul_sub, ← Real.exp_add]
    congr 1 <;> congr 1 <;> ring
  · rw [if_neg ha]
    simp [theta, show ¬ 0 ≤ s-b-c by linarith]

/-- Summing the two mixed orders gives the complete density subtraction coefficient. -/
theorem filtered_mixed_orders_normalized {b s : ℝ} (hb : 0 ≤ b) (hs : 0 ≤ s) :
    L0 (conv (birth b) density) s + L0 (conv density (birth b)) s =
      if b ≤ s then Real.exp (-3*s/2) *
        (Real.exp (2*s) - Real.exp (2*b)) / Real.exp b else 0 := by
  rw [filtered_birth_density hb hs, filtered_density_birth hb hs]
  by_cases ha : b ≤ s
  · simp only [if_pos ha]
    have he (x : ℝ) : Real.exp (-3*s/2) * Real.exp x / Real.exp b =
        Real.exp (-3*s/2+x-b) := by rw [← Real.exp_add, ← Real.exp_sub]
    have hx : Real.exp (-3*s/2) * (Real.exp (2*s) - Real.exp (2*b)) / Real.exp b =
        Real.exp (-3*s/2+2*s-b) - Real.exp (-3*s/2+2*b-b) := by
      rw [mul_sub, sub_div, he, he]
    rw [hx]
    rw [show -3*s/2+2*s-b=s/2-b by ring,
      show -3*s/2+2*b-b=b-3*s/2 by ring]
    ring
  · simp [ha]

private theorem exp_prime_age {p : ℕ} (hp : p.Prime) (j : ℕ) :
    Real.exp ((j : ℝ) * Real.log p) = (p : ℝ)^j := by
  rw [Real.exp_nat_mul, Real.exp_log (by exact_mod_cast hp.pos)]

/-- Each actual prime-power birth pair has the required product cutoff and tent coefficient. -/
theorem prime_power_pair_evaluation {p q : ℕ} (hp : p.Prime) (hq : q.Prime)
    (j k : ℕ) {s : ℝ} (hs : 0 ≤ s) :
    (Real.log p * Real.log q) *
      L0 (conv (birth ((j : ℝ)*Real.log p)) (birth ((k : ℝ)*Real.log q))) s =
    if (p : ℝ)^j * (q : ℝ)^k ≤ Real.exp s then
      Real.exp (-3*s/2) * (Real.exp s - (p : ℝ)^j*(q : ℝ)^k) *
        Real.log p * Real.log q else 0 := by
  have hb : 0 ≤ (j : ℝ)*Real.log p := mul_nonneg (Nat.cast_nonneg j)
    (Real.log_nonneg (by exact_mod_cast hp.one_le))
  have hc : 0 ≤ (k : ℝ)*Real.log q := mul_nonneg (Nat.cast_nonneg k)
    (Real.log_nonneg (by exact_mod_cast hq.one_le))
  have he : Real.exp ((j : ℝ)*Real.log p + (k : ℝ)*Real.log q) =
      (p : ℝ)^j*(q : ℝ)^k := by rw [Real.exp_add, exp_prime_age hp, exp_prime_age hq]
  have hi : (j : ℝ)*Real.log p + (k : ℝ)*Real.log q ≤ s ↔
      (p : ℝ)^j*(q : ℝ)^k ≤ Real.exp s := by rw [← he, Real.exp_le_exp]
  rw [filtered_birth_pair_normalized hb hc hs, he]
  by_cases ha : (p : ℝ)^j*(q : ℝ)^k ≤ Real.exp s
  · rw [if_pos ha, if_pos (hi.mpr ha)]
    ring
  · rw [if_neg ha, if_neg (fun h => ha (hi.mp h))]
    ring

/-- The sum of both mixed orders for an actual power retains its full Mangoldt weight. -/
theorem prime_power_mixed_evaluation {p : ℕ} (hp : p.Prime) (j : ℕ)
    {s : ℝ} (hs : 0 ≤ s) :
    Real.log p * (L0 (conv (birth ((j : ℝ)*Real.log p)) density) s +
      L0 (conv density (birth ((j : ℝ)*Real.log p))) s) =
    if (p : ℝ)^j ≤ Real.exp s then
      Real.exp (-3*s/2) * Real.log p *
        (Real.exp (2*s) - ((p : ℝ)^j)^2) / (p : ℝ)^j else 0 := by
  have hb : 0 ≤ (j : ℝ)*Real.log p := mul_nonneg (Nat.cast_nonneg j)
    (Real.log_nonneg (by exact_mod_cast hp.one_le))
  have hi : (j : ℝ)*Real.log p ≤ s ↔ (p : ℝ)^j ≤ Real.exp s := by
    rw [← exp_prime_age hp j, Real.exp_le_exp]
  have he : Real.exp (2*((j : ℝ)*Real.log p)) = ((p : ℝ)^j)^2 := by
    rw [show 2*((j : ℝ)*Real.log p) = (j : ℝ)*Real.log p + (j : ℝ)*Real.log p by ring,
      Real.exp_add, exp_prime_age hp]
    ring
  rw [filtered_mixed_orders_normalized hb hs, exp_prime_age hp, he]
  by_cases ha : (p : ℝ)^j ≤ Real.exp s
  · rw [if_pos ha, if_pos (hi.mpr ha)]
    ring
  · rw [if_neg ha, if_neg (fun h => ha (hi.mp h))]
    ring

/-- The density-square term is the literal normalized deterministic term in V(exp s). -/
theorem density_square_normalized {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv density density) s = Real.exp (-3*s/2) *
      (Real.exp (2*s) * s/2 + Real.exp (2*s)/4 - 1/4) := by
  rw [filtered_density_density hs]
  have he : Real.exp (-3*s/2) * Real.exp (2*s) = Real.exp (s/2) := by
    rw [← Real.exp_add]
    congr 1
    ring
  calc
    _ = (Real.exp (-3*s/2) * Real.exp (2*s)) * (s/2+1/4) - Real.exp (-3*s/2)/4 := by rw [he]
    _ = _ := by ring

#print axioms prime_power_pair_evaluation
#print axioms prime_power_mixed_evaluation
#print axioms density_square_normalized
#print axioms filtered_birth_pair_normalized
#print axioms filtered_mixed_orders_normalized
#print axioms filtered_birth_density
#print axioms filtered_density_birth
#print axioms filtered_density_density
#print axioms mixed_filtered_integrable

end BuildingBlocks.PrimeDensityFilter
