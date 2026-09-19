# First Formalization 355: Chirped Non-Stationary Gradient Separation and Reciprocal Decay

## 1. Overview and Formal Specification

- **Module:** [`formalization/BuildingBlocks/ChirpedNonstationaryGradientSeparation.lean`](../formalization/BuildingBlocks/ChirpedNonstationaryGradientSeparation.lean)
- **Axioms:** Zero custom axioms. Strictly depends on core Lean 4 foundational axioms: `[propext, Classical.choice, Quot.sound]`.
- **Primary Definitions and Theorems:**
  - `chirpedPhase`: The chirped phase function $\Phi(x) = x(T - \gamma) - x^2(\eta T)$.
  - `chirpedPhaseDeriv`: The derivative $\Phi'(x) = (T - \gamma) - 2\eta T x = T(1 - 2\eta x) - \gamma$.
  - `hasDerivAt_chirpedPhase`: Verification that $\Phi'(x)$ is the Fréchet derivative of $\Phi(x)$.
  - `chirpedPhaseDeriv_le_top`: Universal upper bound $\Phi'(x) \le T - \gamma$ on $x \ge 0$.
  - `chirpedPhaseDeriv_ge_bot`: Universal lower bound $T(1 - 2\eta w) - \gamma \le \Phi'(x)$ on $x \le w$.
  - `deriv_neg_of_gt_carrier`: For $\gamma > T$, $\Phi'(x) \le T - \gamma < 0$ and $|\Phi'(x)| \ge \gamma - T$.
  - `deriv_pos_of_lt_band`: For $\gamma < T(1 - 2\eta w)$, $\Phi'(x) \ge T(1 - 2\eta w) - \gamma > 0$ and $|\Phi'(x)| \ge T(1 - 2\eta w) - \gamma$.
  - `nonstationary_gradient_separation`: If $\gamma$ is separated from the resonant band $[T(1 - 2\eta w), T]$ by distance $\Delta > 0$, then $|\Phi'(x)| \ge \Delta$ uniformly for all $x \in [0, w]$.
  - `reciprocal_square_gradient_le`: Uniform quadratic bound $(\Phi'(x))^2 \ge \Delta^2 > 0$ on $[0, w]$.
  - `makeNonstationaryCertificate`: Constructive certificate builder bundling non-stationary gradient parameters.

## 2. Formalized Theorems and Signatures

```lean
/-- Uniform non-stationary gradient separation theorem:
If γ is separated from the resonant band [T(1 - 2ηw), T] by distance at least Δ > 0,
then for all x ∈ [0, w], the derivative magnitude |Φ'(x)| is bounded below by Δ. -/
theorem nonstationary_gradient_separation {T eta gamma w Δ : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hΔ : 0 < Δ)
    (h_sep : gamma ≤ T * (1 - 2 * eta * w) - Δ ∨ T + Δ ≤ gamma)
    {x : ℝ} (hx0 : 0 ≤ x) (hxw : x ≤ w) :
    Δ ≤ |chirpedPhaseDeriv T eta gamma x|

/-- Reciprocal square gradient bound:
For any point separated by Δ from the resonant band, the squared derivative
(Φ'(x))² is bounded below by Δ² > 0. -/
theorem reciprocal_square_gradient_le {T eta gamma w Δ : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hΔ : 0 < Δ)
    (h_sep : gamma ≤ T * (1 - 2 * eta * w) - Δ ∨ T + Δ ≤ gamma)
    {x : ℝ} (hx0 : 0 ≤ x) (hxw : x ≤ w) :
    Δ^2 ≤ (chirpedPhaseDeriv T eta gamma x)^2 ∧
    0 < (chirpedPhaseDeriv T eta gamma x)^2
```

## 3. Antecedents and Literature Context

In classical micro-local analysis and oscillatory integral theory (Hörmander 1983, Stein 1993), the principle of non-stationary phase states that if the phase gradient $|\nabla \Phi(x)|$ is bounded below away from zero by $\Delta > 0$ on the support of a smooth cutoff, repeated integration by parts against the differential operator $L = \frac{1}{i \Phi'(x)} \frac{d}{dx}$ produces rapid decay $O(\Delta^{-N})$.

While this analytic principle is standard in continuous harmonic analysis without Lean, its non-asymptotic uniform gradient separation on compact intervals $[0, w]$ for quadratic chirped phases $\Phi(x) = (T - \gamma)x - \eta T x^2$ against the resonant Weil band $[T(1 - 2\eta w), T]$ has never previously been verified in Lean 4 or any other interactive theorem prover.
