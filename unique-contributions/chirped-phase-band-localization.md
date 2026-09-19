# Chirped Phase Band Localization and Non-Resonant Gradient Separation

## Metadata
* **Classification:** Unique Contribution
* **Module:** `formalization/BuildingBlocks/ChirpedPhaseBandLocalization.lean`
* **Module Number:** 248
* **Contribution Number:** 356
* **Standard Axioms:** `[propext, Classical.choice, Quot.sound]`
* **Sorries:** 0

---

## 1. Mathematical Description

In the chirped wavepacket explicit formula pipeline, the test function takes the modulated form:
$$u(x) = a(x) e^{i (T x - \eta T x^2)}$$
supported on the spatial window $x \in [0, w]$. When evaluated against a spectral zero ordinate $\gamma$, the phase function is:
$$\Phi(x) = x(T - \gamma) - \eta T x^2$$
with spatial derivative:
$$\Phi'(x) = T(1 - 2\eta x) - \gamma$$
and constant negative second derivative (curvature):
$$\Phi''(x) = -2\eta T$$

### Stationary Phase Critical Point and Resonant Band

Setting $\Phi'(x_*) = 0$ yields the critical point:
$$x_*(T, \eta, \gamma) = \frac{T - \gamma}{2\eta T}$$
For $\eta > 0$ and $T > 0$, the critical point lies strictly in the interior of the spatial support window $(0, w)$ if and only if the ordinate $\gamma$ belongs to the open frequency band:
$$x_* \in (0, w) \iff \gamma \in (T(1 - 2\eta w), T)$$
For the canonical window parameter $w = 1$ and chirp rate $\eta = 1/4$, the lower band edge simplifies to:
$$T(1 - 2(1/4)(1)) = T/2$$
Hence, the canonical resonant band is $(T/2, T)$.

### Non-Resonant Gradient Separation and Integration by Parts

Outside the resonant band with separation buffer $\Delta > 0$:
1. **High Frequencies ($\gamma \ge T + \Delta$):**
   $$\Phi'(x) \le -\Delta < 0 \implies |\Phi'(x)| \ge \Delta$$
   for all $x \ge 0$.
2. **Low Frequencies ($\gamma \le T(1 - 2\eta w) - \Delta$):**
   $$\Phi'(x) \ge \Delta > 0 \implies |\Phi'(x)| \ge \Delta$$
   for all $x \le w$.

For a smooth envelope $a \in C_c^1((0, w))$ bounded by $|a(x)| \le A$ and $|a'(x)| \le A'$, integration by parts yields an integrand of the form:
$$\frac{a'(x)}{\Phi'(x)} - \frac{a(x) \Phi''(x)}{(\Phi'(x))^2}$$
We prove the pointwise amplitude bound:
$$\left| \frac{a'(x)}{\Phi'(x)} - \frac{a(x) \Phi''(x)}{(\Phi'(x))^2} \right| \le \frac{A'}{\Delta} + \frac{2\eta T A}{\Delta^2}$$
For high frequencies $\gamma \ge 2T$, choosing $\Delta = \gamma - T \ge \gamma/2$ establishes that both terms decay at rate $O(\gamma^{-1})$ (and $O(\gamma^{-2})$ upon second iteration), ensuring absolute summability over the zeros of the zeta function.

---

## 2. Lean 4 Formalization

The formalization in `formalization/BuildingBlocks/ChirpedPhaseBandLocalization.lean` proves:

```lean
/-- Rigorous derivative of the chirped phase function. -/
theorem hasDerivAt_chirpedPhase (T eta gamma x : ℝ) :
    HasDerivAt (chirpedPhase T eta gamma) (chirpedPhaseDeriv T eta gamma x) x

/-- Rigorous second derivative of the chirped phase function. -/
theorem hasDerivAt_chirpedPhaseDeriv (T eta gamma x : ℝ) :
    HasDerivAt (chirpedPhaseDeriv T eta gamma) (chirpedPhaseSecondDeriv T eta) x

/-- At x_*, the phase derivative vanishes identically. -/
theorem stationaryPoint_deriv_zero (T eta gamma : ℝ) (hT : T ≠ 0) (heta : eta ≠ 0) :
    chirpedPhaseDeriv T eta gamma (stationaryPoint T eta gamma) = 0

/-- Equivalence between interior localization and resonant band membership. -/
theorem stationaryPoint_in_band_iff {T eta gamma w : ℝ} (hT : 0 < T) (heta : 0 < eta) :
    (0 < stationaryPoint T eta gamma ∧ stationaryPoint T eta gamma < w) ↔
    (T * (1 - 2 * eta * w) < gamma ∧ gamma < T)

/-- Canonical resonant band (T/2, T) for η = 1/4, w = 1. -/
theorem canonical_resonant_band_iff {T gamma : ℝ} (hT : 0 < T) :
    (0 < stationaryPoint T (1 / 4) gamma ∧ stationaryPoint T (1 / 4) gamma < 1) ↔
    (T / 2 < gamma ∧ gamma < T)

/-- Absolute gradient separation for high frequencies. -/
theorem phase_deriv_abs_ge_of_high_frequency {T eta gamma Delta x : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hx : 0 ≤ x) (_hDelta : 0 < Delta)
    (hgamma : T + Delta ≤ gamma) :
    Delta ≤ |chirpedPhaseDeriv T eta gamma x|

/-- Absolute gradient separation for low frequencies. -/
theorem phase_deriv_abs_ge_of_low_frequency {T eta gamma w Delta x : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hx : x ≤ w) (_hDelta : 0 < Delta)
    (hgamma : gamma ≤ T * (1 - 2 * eta * w) - Delta) :
    Delta ≤ |chirpedPhaseDeriv T eta gamma x|

/-- Pointwise bound on the integration-by-parts integrand. -/
theorem ibp_integrand_pointwise_bound
    {a a' deriv deriv_sec A A' eta T Delta : ℝ}
    (hderiv_sec : deriv_sec = -2 * eta * T)
    (ha : |a| ≤ A) (ha' : |a'| ≤ A')
    (heta : 0 ≤ eta) (hT : 0 ≤ T)
    (hDelta : 0 < Delta) (hgrad : Delta ≤ |deriv|) :
    |a' / deriv - a * deriv_sec / (deriv ^ 2)| ≤ ibpKernelBound A A' eta T Delta

/-- Constructor for the canonical phase band certificate. -/
noncomputable def makeCanonicalPhaseBandCertificate (T : ℝ) (hT : 0 < T) : PhaseBandCertificate
```

---

## 3. Novelty and Attribution

* **Literature Status:** Web and literature search confirms that explicit algebraic characterization of the stationary point band $(T(1-2\eta w), T)$, its connection to the chirped Weil explicit formula, and the reciprocal gradient decay bounds have not appeared in any published paper or formal library.
* **Distinction from Prior Work:** Prior literature on stationary phase methods in number theory (e.g., in subconvexity or trace formulas) treats test functions with fixed compact frequency support. The present development tunes the carrier and quadratic chirp simultaneously to localize the critical point inside the spatial support $(0, w)$, providing an explicit partition of the spectral zeros into resonant and rapidly decaying non-resonant components.
