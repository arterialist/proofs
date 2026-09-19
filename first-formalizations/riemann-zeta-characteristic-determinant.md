# Quadratic spectral parameter and an RH-equivalent reality predicate

**Module Path**: `formalization/BuildingBlocks/RiemannZetaCharacteristicDeterminant.lean`  
**Root Module**: `formalization/BuildingBlocks.lean`  
**Dependencies**:
- `BuildingBlocks.RiemannZetaMasterGrandUnification`
- `BuildingBlocks.RiemannZetaRealAxisDischarge`
- `BuildingBlocks.RiemannZetaRealAxisUnconditional`
- `BuildingBlocks.ChirpedSpectralSupportConfinement`
- `BuildingBlocks.CriticalTransformRH`

---

## 1. Mathematical and Formal Context

In analytic number theory and spectral geometry (Edwards, Titchmarsh, Berry–Keating, Connes), the completed Riemann xi function satisfies the functional equation $\xi(1 - s) = \xi(s)$. By Hadamard's factorization theorem, its genus-1 product can be symmetrically paired into quadratic factors in the invariant spectral parameter:
$$z(s) = s(1 - s)$$
Under this quadratic mapping, critical zeros $\rho = 1/2 + i\gamma$ map to strictly real eigenvalues:
$$\lambda_\rho = \rho(1 - \rho) = \frac{1}{4} + \gamma^2 \in \mathbb{R}_{>0}$$
Conversely, any hypothetical off-line zero $\rho = \sigma + i\gamma$ with $\sigma \ne 1/2$ and $\gamma \ne 0$ maps to a non-real spectral eigenvalue whose imaginary part exhibits non-vanishing dispersion:
$$\operatorname{Im}(\lambda_\rho) = \gamma(1 - 2\sigma) \ne 0$$

The module machine-checks the following algebraic facts and logical repackagings. Worldwide priority has not been established by a reproducible proof-assistant literature search:
1. The reflection-invariant quadratic parameter map $z(s)$ and its coordinate decomposition in Lean's `Complex` algebra;
2. The rigorous equivalence between critical line confinement $\operatorname{Re}(s) = 1/2$ and eigenvalue reality $\operatorname{Im}(z(s)) = 0$;
3. The resolvent kernel trace formula $R(w, x) = (w - x)^{-1}$ on the real axis, proving that off-line zeros create an inescapable imaginary defect $\operatorname{Im}(R) \ne 0$;
4. The deduction of empty off-line zero support (`RightOfflineSupport = ∅`) from the spectral reality condition;
5. The logical equivalence between `CharacteristicSpectralReality` and `RiemannHypothesis`;
6. The canonical embedding and ingestion of all six autonomous operator systems into a unified characteristic determinant system (`ZetaCharacteristicDeterminantSystem`).

---

`CharacteristicSpectralReality` is a global condition on every non-trivial zeta zero. Its equivalence with RH does not construct the condition independently. Likewise, `ZetaCharacteristicDeterminantSystem` is a record whose existence is proved equivalent to RH, and the constructors from autonomous systems require those systems as arguments.

---

## 2. Machine-Verified Declarations

All declarations in `RiemannZetaCharacteristicDeterminant.lean` have been compiled in Lean 4 and verified against the foundational axioms `[propext, Classical.choice, Quot.sound]`:

| Lean 4 Identifier | Mathematical Meaning | Axiom Profile |
| :--- | :--- | :--- |
| `spectralParam` | Quadratic spectral parameter $z(s) = s(1 - s)$ | Def |
| `spectralParam_reflection` | Reflection invariance $z(1 - s) = z(s)$ | Standard |
| `spectralParam_re` | Real part formula $\sigma(1 - \sigma) + t^2$ | Standard |
| `spectralParam_im` | Imaginary part formula $t(1 - 2\sigma)$ | Standard |
| `spectralParam_im_eq_zero_iff` | Reality criterion: for $t \ne 0$, $\operatorname{Im}(z) = 0 \iff \sigma = 1/2$ | Standard |
| `spectralParam_im_of_critical_line` | Critical line points have identically real spectral parameter | Standard |
| `spectralParam_re_pos_of_critical_line` | Critical line eigenvalues are strictly positive ($1/4 + t^2 > 0$) | Standard |
| `spectralParam_im_ne_zero` | Non-critical non-real candidates have $\operatorname{Im}(z) \ne 0$ | Standard |
| `spectralParam_im_neg_of_right_upper` | Right upper quadrant dispersion $\operatorname{Im}(z) < 0$ | Standard |
| `spectralParam_im_pos_of_left_upper` | Left upper quadrant dispersion $\operatorname{Im}(z) > 0$ | Standard |
| `charFactor` | Characteristic factor $1 - z/w$ | Def |
| `charFactorAt` | Characteristic factor evaluated at eigenvalue | Def |
| `charFactorAt_self` | Characteristic factor vanishes at its eigenvalue | Standard |
| `charFactorAt_reflection` | Characteristic factor vanishes at reflected point $1 - \rho$ | Standard |
| `charResolvent` | Characteristic resolvent kernel $(w - z)^{-1}$ | Def |
| `charResolvent_real_axis_im` | Imaginary part of resolvent on the real axis | Standard |
| `charResolvent_real_on_critical_line` | Resolvent is strictly real on the critical line | Standard |
| `charResolvent_im_ne_zero_of_offline` | Resolvent has non-zero imaginary part for off-line candidates | Standard |
| `im_ne_zero_of_mem_rightOfflineSupport` | Points in `RightOfflineSupport` have non-zero imaginary part | Standard |
| `spectralParam_im_ne_zero_of_mem_rightOfflineSupport` | Points in `RightOfflineSupport` have non-zero imaginary eigenvalue | Standard |
| `rightOfflineSupport_empty_of_spectral_reality` | Off-line spectral reality forces `RightOfflineSupport = ∅` | Standard |
| `CharacteristicSpectralReality` | Global reality condition on all non-trivial zeros | Def |
| `rightOfflineSupport_empty_of_csr` | Emptiness of right off-line support from CSR | Standard |
| `rightHalfZeroFree_of_csr` | Right-half zero-freeness from CSR | Standard |
| `RiemannHypothesis_of_csr` | Deduction of Mathlib `RiemannHypothesis` from CSR | Standard |
| `csr_of_RiemannHypothesis` | Deduction of CSR from `RiemannHypothesis` | Standard |
| `characteristic_spectral_reality_iff_RiemannHypothesis` | Master equivalence: CSR $\iff$ `RiemannHypothesis` | Standard |
| `ZetaCharacteristicDeterminantSystem` | Global characteristic determinant system record | Def |
| `characteristicSystem_of_RH` | Canonical constructor from `RiemannHypothesis` | Standard |
| `characteristicSystem_of_master` | Canonical constructor from `MasterGrandUnification` | Standard |
| `RiemannHypothesis_of_characteristicSystem` | Deduction of RH from characteristic system | Standard |
| `rightHalfZeroFree_of_characteristicSystem` | Deduction of `RightHalfZeroFree` from characteristic system | Standard |
| `rightOfflineSupport_empty_of_characteristicSystem` | Deduction of `RightOfflineSupport = ∅` from characteristic system | Standard |
| `masterGrandUnification_of_characteristicSystem` | Deduction of `MasterGrandUnification` from characteristic system | Standard |
| `characteristicSystem_nonempty_iff_RiemannHypothesis` | Nonempty system $\iff$ `RiemannHypothesis` | Standard |
| `characteristicSystem_nonempty_iff_master` | Nonempty system $\iff$ `MasterGrandUnification` | Standard |
| `characteristicSystem_of_autonomous_weil` | Ingestion from `AutonomousWeilTraceSystem` | Standard |
| `characteristicSystem_of_autonomous_operator` | Ingestion from `AutonomousOperatorTraceSystem` | Standard |
| `characteristicSystem_of_autonomous_fredholm` | Ingestion from `AutonomousFredholmDeterminantSystem` | Standard |
| `characteristicSystem_of_autonomous_carleman` | Ingestion from `AutonomousCarlemanResolventSystem` | Standard |
| `characteristicSystem_of_autonomous_linear_bridge` | Ingestion from `AutonomousLinearBridgeSystem` | Standard |
| `characteristicSystem_of_autonomous_canonical` | Ingestion from `AutonomousCanonicalEvaluationSystem` | Standard |

---

## 3. Verification Commands

```bash
# Verify Module 301 standalone
~/.elan/bin/lake env lean formalization/BuildingBlocks/RiemannZetaCharacteristicDeterminant.lean

# Verify root build (7,964 targets)
~/.elan/bin/lake build BuildingBlocks
```
