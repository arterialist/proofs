# Contribution 168: Exact Double Pole Persistence and Unremovable Zeta-Zero Spectral Singularities

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/LogDerivativePole.lean`](../../formalization/BuildingBlocks/LogDerivativePole.lean), [`building-blocks/meromorphic/log-derivative-pole.md`](../../building-blocks/meromorphic/log-derivative-pole.md)  
**Classification:** Analytic Number Theory / Complex Analysis / Meromorphic Functions / Logarithmic Derivatives / Spectral Singularities / Off-Critical Zero Obstructions

---

## 1. Executive Summary and Mathematical Statement

In spectral and variational approaches to the Riemann Hypothesis, a central question is whether the non-trivial zeros $\rho$ of $\zeta(s)$ can be cancelled or regularized away by subtracting background terms or Dirichlet series $H(s)$. If an off-critical zero $\rho$ with $\text{Re}(\rho) > 1/2$ exists, does the squared centered logarithmic derivative retain an unremovable singularity?

This contribution proves:

1. **Local Analytic Unit Factorization and Logarithmic Residue:**  
   If $f(z) = (z - \rho)^m u(z)$ locally at $\rho$ with $u$ analytic and $u(\rho) \ne 0$, then in a punctured neighborhood $\dot{\mathcal{N}}(\rho)$:
   $$
   \frac{f'(z)}{f(z)} = \frac{m}{z - \rho} + \frac{u'(z)}{u(z)},
   $$
   with $\frac{u'}{u}$ analytic at $\rho$.
2. **General Double Pole Persistence Theorem:**  
   Let $G(z) = -\frac{m}{z - \rho} + R(z)$ with $m \ge 1$ and $R$ analytic at $\rho$. Let $H, Q$ be analytic at $\rho$ with $Q(\rho) \ne 0$. Then the function $Q(z)(G(z)^2 - H(z))$ has a pole of exact order $2$ at $\rho$, and its leading Laurent coefficient is strictly non-zero:
   $$
   \text{ord}_\rho\left( Q \cdot (G^2 - H) \right) = -2, \quad \text{Coeff}_{-2} = Q(\rho) \cdot m^2 \ne 0.
   $$
   Subtracting ANY analytic function $H(z)$ CANNOT cancel the double pole of $G(z)^2$.
3. **Finite Positive Analytic Order of Zeta Zeros:**  
   Every non-trivial zero $\rho \ne 1$ of the Riemann zeta function has a well-defined finite positive analytic multiplicity $m \in \mathbb{N}_{\ge 1}$:
   $$
   \text{ord}_\rho(\zeta) = m \ge 1.
   $$
4. **Persistence of Double Pole at Any Off-Critical Zeta Zero:**  
   For any zero $\rho$ of $\zeta(s)$ with $\text{Re}(\rho) > 1/2$ and $\rho \ne 1$, and for ANY function $H(s)$ analytic at $\rho$ (such as the same-prime Dirichlet series $H(s)$), the weighted squared centered logarithmic derivative:
   $$
   \Phi(s) = \mathcal{M}(s) \cdot \left( \left(-\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}\right)^2 - H(s) \right)
   $$
   **strictly possesses a double pole at $s = \rho$** of exact order $-2$ with non-zero trailing coefficient:
   $$
   \text{ord}_\rho(\Phi) = -2, \quad \text{Coeff}_{-2} = \mathcal{M}(\rho) \cdot m^2 \ne 0.
   $$

---

## 2. Mathematical Proof

### 2.1. Logarithmic Residue Expansion
Given $f(z) = (z - \rho)^m u(z)$ near $\rho$, by the product rule for logarithmic derivatives:
$$
\frac{f'(z)}{f(z)} = \frac{((z - \rho)^m)'}{(z - \rho)^m} + \frac{u'(z)}{u(z)} = \frac{m(z - \rho)^{m-1}}{(z - \rho)^m} + \frac{u'(z)}{u(z)} = \frac{m}{z - \rho} + \frac{u'(z)}{u(z)}.
$$
Since $u(\rho) \ne 0$ and $u$ is analytic at $\rho$, $u'/u$ is analytic at $\rho$.

### 2.2. Laurent Coefficient and Order Preservation
With $G(z) = -\frac{m}{z - \rho} + R(z)$:
$$
G(z)^2 - H(z) = \left( -\frac{m}{z - \rho} + R(z) \right)^2 - H(z) = \frac{m^2}{(z - \rho)^2} - \frac{2m R(z)}{z - \rho} + R(z)^2 - H(z).
$$
Multiplying by $(z - \rho)^2$:
$$
(z - \rho)^2 (G(z)^2 - H(z)) = m^2 - 2m(z - \rho) R(z) + (z - \rho)^2 (R(z)^2 - H(z)).
$$
Define $K(z) = Q(z) \left( (-(m) + (z - \rho) R(z))^2 - (z - \rho)^2 H(z) \right)$.
At $z = \rho$:
$$
K(\rho) = Q(\rho) \cdot ((-m)^2 - 0) = Q(\rho) \cdot m^2.
$$
Since $m \ge 1$ and $Q(\rho) \ne 0$, $K(\rho) \ne 0$.
Moreover, $K$ is analytic at $\rho$.
Therefore, $Q(z)(G(z)^2 - H(z)) = (z - \rho)^{-2} K(z)$ has exact meromorphic order $-2$, and its trailing coefficient is $K(\rho) = Q(\rho) m^2 \ne 0$.

### 2.3. Application to Zeta Zeros
At any zero $\rho \ne 1$ of $\zeta(s)$, $\zeta(s)$ is analytic. By identity theorem for non-constant analytic functions, $\text{ord}_\rho(\zeta) = m \in [1, \infty)$.
Thus $-\zeta'/\zeta$ has a simple pole with residue $-m$.
The centering term $\frac{s}{s-1}$ is analytic at $\rho \ne 1$.
The same-prime Dirichlet series $H(s) = \sum_p \frac{\log^2 p}{(p^s - 1)^2}$ converges absolutely on $\text{Re}(s) > 1/2$, so it is analytic at $\rho$.
The multiplier $\mathcal{M}(s)$ is analytic and non-zero on $\text{Re}(s) > 1/2$.
Applying the persistence theorem proves that $\Phi(s)$ must have an unremovable double pole at $\rho$ with coefficient $\mathcal{M}(\rho) m^2 \ne 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.LogDerivativePole` in `formalization/BuildingBlocks/LogDerivativePole.lean`):
```lean
theorem logDeriv_of_factorization {f u : ℂ → ℂ} {ρ : ℂ} {m : ℕ}
    (hu : AnalyticAt ℂ u ρ) (hu0 : u ρ ≠ 0)
    (hfactor : f =ᶠ[𝓝 ρ] fun z => (z - ρ) ^ m * u z) :
    logDeriv f =ᶠ[𝓝[≠] ρ] fun z => (m : ℂ) / (z - ρ) + logDeriv u z

theorem double_pole_persistence {G R H Q : ℂ → ℂ} {ρ : ℂ} {m : ℕ}
    (hm : 1 ≤ m) (hR : AnalyticAt ℂ R ρ) (hH : AnalyticAt ℂ H ρ)
    (hQ : AnalyticAt ℂ Q ρ) (hQ0 : Q ρ ≠ 0)
    (hG : G =ᶠ[𝓝[≠] ρ] fun z => -(m : ℂ) / (z - ρ) + R z) :
    meromorphicOrderAt (fun z => Q z * (G z ^ 2 - H z)) ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt (fun z => Q z * (G z ^ 2 - H z)) ρ = Q ρ * (m : ℂ) ^ 2

theorem zeta_zero_finite_order {ρ : ℂ} (hρ : ρ ≠ 1) (hz : riemannZeta ρ = 0) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m

theorem actual_zeta_zero_double_pole {ρ : ℂ} {H : ℂ → ℂ}
    (hρre : (1 : ℝ) / 2 < ρ.re) (hρ : ρ ≠ 1) (hz : riemannZeta ρ = 0)
    (hH : AnalyticAt ℂ H ρ) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧
      meromorphicOrderAt (fun s => ShiftedZetaMultiplier.M s *
        (centeredZetaLogDerivative s ^ 2 - H s)) ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt (fun s => ShiftedZetaMultiplier.M s *
        (centeredZetaLogDerivative s ^ 2 - H s)) ρ =
          ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ∧
      ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ≠ 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Meromorphic properties of logarithmic derivatives (Titchmarsh 1986). The exact machine-verified persistence of order $-2$ poles and unremovable leading Laurent coefficients under arbitrary analytic background subtractions has not been previously formalized in Lean 4.
- **Advancement:** Proves in Lean 4 that any hypothetical off-critical zero of $\zeta(s)$ generates an unremovable double pole in the regularized prime-pair autocorrelation transform, with strictly non-zero Laurent coefficient $\mathcal{M}(\rho)m^2 \ne 0$.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Journal of Mathematical Analysis and Applications*.
