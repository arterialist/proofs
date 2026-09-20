# Contribution 297: Exact Narrow Pole-Null Wave Packets and Critical Pole Annihilation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/NarrowPoleNullPacket.lean`](../../formalization/BuildingBlocks/NarrowPoleNullPacket.lean), [`building-blocks/compact-scattering/narrow-pole-null-packet.md`](../../building-blocks/compact-scattering/narrow-pole-null-packet.md)  
**Classification:** Harmonic Analysis / Smooth Bump Functions / Mellin Transforms / Spectral Pole Annihilation / Localized Wave Packets / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In spectral approaches to the Riemann zeta function (such as the Connes trace formula, Burnol's test function spaces, and scattering models), the background poles of $\zeta(s)$ at $s = 1$ and $s = 0$ generate divergent boundary terms. To isolate the discrete critical zeros from the trivial pole contributions, one requires test functions whose Mellin transforms vanish identically at $s = \pm 1/2$ while maintaining arbitrarily tight, localized compact support.

This contribution proves:

1. **Existence of Smooth Narrow Pole-Null Complex Wave Packets:**  
   For any geometric period or channel length $L > 0$, there exists a smooth test function $\eta \in C_c^\infty(\mathbb{R}, \mathbb{C})$ satisfying:
   - Non-trivial normalization: $\eta(0) = 1$ and $\int_\mathbb{R} |\eta(v)|^2 dv > 0$,
   - Narrow sub-interval support: $\text{supp}(\eta) \subset (-L/32, 9L/32) \subset (-L, L)$,
   - Simultaneous vanishing of Mellin moments at both critical poles:
     $$
     \int_\mathbb{R} \eta(v) e^{v/2} dv = 0, \qquad \int_\mathbb{R} \eta(v) e^{-v/2} dv = 0.
     $$
2. **Exact Three-Point Difference Stencil Annihilation:**  
   For any smooth bump $\kappa \in C_c^\infty(\mathbb{R})$ and shift $\epsilon > 0$, the carrier functional:
   $$
   \mathcal{C}_\epsilon \kappa(v) = \kappa(v) - (e^{\epsilon/2} + e^{-\epsilon/2}) \kappa(v - \epsilon) + \kappa(v - 2\epsilon)
   $$
   has Mellin moment factorizing identically as:
   $$
   \int_\mathbb{R} (\mathcal{C}_\epsilon \kappa)(v) e^{sv} dv = (e^{s\epsilon} - e^{\epsilon/2})(e^{s\epsilon} - e^{-\epsilon/2}) \int_\mathbb{R} \kappa(v) e^{sv} dv.
   $$
   At $s = \pm 1/2$, the polynomial factor vanishes identically for any base bump $\kappa$.
3. **Strict Positivity of $L^2$ Energy:**  
   The constructed packet is strictly $L^2$-integrable with positive energy $\int_\mathbb{R} |\eta(v)|^2 dv > 0$.
4. **Preservation of Smoothness and Support Localization:**  
   Choosing $\delta = L/32$ and $\epsilon = L/8$, the support of $\mathcal{C}_\epsilon \kappa$ lies strictly in $(-\delta, 2\epsilon + \delta) = (-L/32, 9L/32)$, preventing overlap across adjacent prime scattering intervals.

---

## 2. Mathematical Proof

### 2.1. Characteristic Annihilation Polynomial
Consider the difference operator $D = \delta_0 - C \delta_\epsilon + \delta_{2\epsilon}$ acting on $v \mapsto e^{sv}$.
Its eigenvalue is:
$$
P(s) = 1 - C e^{s\epsilon} + e^{2s\epsilon}.
$$
Setting $C = e^{\epsilon/2} + e^{-\epsilon/2} = 2 \cosh(\epsilon/2)$:
$$
P(s) = 1 - (e^{\epsilon/2} + e^{-\epsilon/2}) e^{s\epsilon} + e^{2s\epsilon} = (e^{s\epsilon} - e^{\epsilon/2})(e^{s\epsilon} - e^{-\epsilon/2}).
$$
Evaluating at $s = 1/2$:
$$
P(1/2) = (e^{\epsilon/2} - e^{\epsilon/2})(e^{\epsilon/2} - e^{-\epsilon/2}) = 0.
$$
Evaluating at $s = -1/2$:
$$
P(-1/2) = (e^{-\epsilon/2} - e^{\epsilon/2})(e^{-\epsilon/2} - e^{-\epsilon/2}) = 0.
$$
Hence $P(\pm 1/2) = 0$ identically.

### 2.2. Moment Factorization and Geometry
By translation invariance of Lebesgue measure:
$$
\int_\mathbb{R} \kappa(v - d) e^{sv} dv = e^{sd} \int_\mathbb{R} \kappa(v) e^{sv} dv.
$$
Applying linearity gives:
$$
\int_\mathbb{R} (\mathcal{C}_\epsilon \kappa)(v) e^{sv} dv = P(s) \int_\mathbb{R} \kappa(v) e^{sv} dv.
$$
For $\text{supp}(\kappa) \subset (-\delta, \delta)$, each shifted bump $\kappa(v - k\epsilon)$ has support in $(k\epsilon - \delta, k\epsilon + \delta)$.
The union of supports for $k \in \{0, 1, 2\}$ is contained in $(-\delta, 2\epsilon + \delta)$.
With $\delta = L/32$ and $\epsilon = L/8 = 4L/32$:
$$
2\epsilon + \delta = 8L/32 + L/32 = 9L/32.
$$
Since $\delta < \epsilon$, $\kappa(-\epsilon) = \kappa(-2\epsilon) = 0$, so $\mathcal{C}_\epsilon \kappa(0) = \kappa(0) = 1$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.NarrowPoleNullPacket` in `formalization/BuildingBlocks/NarrowPoleNullPacket.lean`):
```lean
theorem pole_polynomial (epsilon s : ℝ) (hs : s = 1 / 2 ∨ s = -(1 / 2)) :
    1 - (Real.exp (epsilon / 2) + Real.exp (-epsilon / 2)) * Real.exp (s * epsilon) +
      Real.exp (s * (2 * epsilon)) = 0

theorem carrier_pole_moments {kappa : ℝ → ℝ} (hk : Continuous kappa)
    (hc : HasCompactSupport kappa) (epsilon : ℝ) :
    moment (carrier kappa epsilon (Real.exp (epsilon / 2) + Real.exp (-epsilon / 2))) (1 / 2) = 0 ∧
    moment (carrier kappa epsilon (Real.exp (epsilon / 2) + Real.exp (-epsilon / 2))) (-(1 / 2)) = 0

theorem exists_narrow_complex_pole_null {L : ℝ} (hL : 0 < L) :
    ∃ eta : ℝ → ℂ, HasCompactSupport eta ∧ ContDiff ℝ ∞ eta ∧ eta 0 = 1 ∧
      (∀ v, eta v ≠ 0 → -(L / 32) < v ∧ v < 9 * L / 32) ∧
      MeasureTheory.Integrable (fun v => Complex.normSq (eta v)) ∧
      (0 < ∫ v : ℝ, Complex.normSq (eta v)) ∧
      complexMoment eta (1 / 2) = 0 ∧ complexMoment eta (-(1 / 2)) = 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Connes (1999) non-commutative geometry and trace formulas; Burnol (2001) scattering matrices and local test functions; Meyer (2001). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Explicitly constructs test states orthogonal to background poles at $s = \pm 1/2$ without losing compact support, enabling localized spectral analysis of prime scattering channels free from pole divergences.
- **Target Venues:** *Journal of Functional Analysis* or *Letters in Mathematical Physics*.
