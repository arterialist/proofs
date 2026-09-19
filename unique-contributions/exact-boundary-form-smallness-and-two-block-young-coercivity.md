# Contribution 122: Exact Boundary Form-Smallness and Two-Block Young Coercivity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/BoundaryFormSmallness.lean`](../../formalization/BuildingBlocks/BoundaryFormSmallness.lean), [`building-blocks/operator-positivity/boundary-form-smallness.md`](../../building-blocks/operator-positivity/boundary-form-smallness.md)  
**Classification:** Operator Theory / Quadratic Forms / Relative Boundedness / Form Smallness / Logarithmic Cutoffs / Two-Block Perturbations

---

## 1. Executive Summary and Mathematical Statement

In the KLMN operator perturbation theorem and Kato form-smallness criteria, boundary port terms must be controlled relative to the unperturbed Hamiltonian:
$$
\mathfrak{q}_{\text{port}}(u) \le \eta \, \mathfrak{q}_{\text{supply}}(u) + C \|u\|^2, \quad \eta < 1.
$$
When the supply form enjoys coercivity growing with a logarithmic cutoff parameter $S$:
$$
c S \|u\|^2 \le \mathfrak{q}_{\text{supply}}(u),
$$
this contribution establishes explicit scalar and two-block estimates achieving arbitrary form-smallness $\eta > 0$.

This contribution proves:

1. **Exact Coercivity Relative Form-Smallness:**  
   If $\mathfrak{q}_{\text{port}} \le P \|u\|^2$ and $c S \|u\|^2 \le \mathfrak{q}_{\text{supply}}$ with $P \ge 0$, $c > 0$, and $S > 0$, then:
   $$
   \mathfrak{q}_{\text{port}} \le \frac{P}{c S} \mathfrak{q}_{\text{supply}}.
   $$
2. **Explicit Cutoff Criterion for Arbitrary Smallness:**  
   For any prescribed relative form bound $\eta > 0$, choosing the logarithmic cutoff scale:
   $$
   S \ge \frac{P}{c \eta} \implies \frac{P}{c S} \le \eta.
   $$
3. **Sharp Two-Block Young Coercivity:**  
   For a decomposed system with core, tail, and off-diagonal cross pairing satisfying Cauchy-Schwarz $2 \mathfrak{q}_{\text{mixed}} \le \varepsilon \mathfrak{q}_{\text{core}} + \frac{1}{\varepsilon} \mathfrak{q}_{\text{tail}}$ for any $\varepsilon > 0$:
   $$
   \mathfrak{q}_{\text{total}} = \mathfrak{q}_{\text{core}} + \mathfrak{q}_{\text{tail}} + 2 \mathfrak{q}_{\text{mixed}} \le (1 + \varepsilon) \mathfrak{q}_{\text{core}} + \left(1 + \frac{1}{\varepsilon}\right) \mathfrak{q}_{\text{tail}}.
   $$
4. **Subspace Restriction Invariance:**  
   Form-smallness estimates transfer identically with invariant constants to any invariant subspace or finite-dimensional kernel $K \subset V$.

---

## 2. Mathematical Proof

### 2.1. Relative Port Bound
From $c S \|u\|^2 \le \mathfrak{q}_{\text{supply}}$ and $c, S > 0$, we have $\|u\|^2 \le \frac{1}{c S} \mathfrak{q}_{\text{supply}}$.
Multiplying by $P \ge 0$:
$$
\mathfrak{q}_{\text{port}} \le P \|u\|^2 \le \frac{P}{c S} \mathfrak{q}_{\text{supply}}.
$$

### 2.2. Cutoff Selection
If $S \ge \frac{P}{c \eta}$ with $P > 0, c > 0, \eta > 0$:
$$
c S \ge \frac{P}{\eta} \implies \frac{P}{c S} \le \eta.
$$
If $P = 0$, $0 \le \eta$ holds trivially for any $S > 0$.

### 2.3. Two-Block Young Bound
Substituting $2 \mathfrak{q}_{\text{mixed}} \le \varepsilon \mathfrak{q}_{\text{core}} + \frac{1}{\varepsilon} \mathfrak{q}_{\text{tail}}$ into the total decomposition:
$$
\mathfrak{q}_{\text{total}} = \mathfrak{q}_{\text{core}} + \mathfrak{q}_{\text{tail}} + 2 \mathfrak{q}_{\text{mixed}} \le \mathfrak{q}_{\text{core}} + \mathfrak{q}_{\text{tail}} + \varepsilon \mathfrak{q}_{\text{core}} + \frac{1}{\varepsilon} \mathfrak{q}_{\text{tail}} = (1 + \varepsilon) \mathfrak{q}_{\text{core}} + \left(1 + \frac{1}{\varepsilon}\right) \mathfrak{q}_{\text{tail}}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`PaidThetaCompensation`):
```lean
theorem tail_port_relative_bound
    {port supply normSq P c S : ℝ}
    (hP : 0 ≤ P) (hc : 0 < c) (hS : 0 < S)
    (hport : port ≤ P * normSq)
    (hsupply : c * S * normSq ≤ supply) :
    port ≤ (P / (c * S)) * supply

theorem cutoff_for_relative_bound
    {P c eta S : ℝ}
    (hP : 0 ≤ P) (hc : 0 < c) (heta : 0 < eta)
    (hS : P / (c * eta) ≤ S) :
    P / (c * S) ≤ eta

theorem two_block_port_upper
    {core tail mixed total eps : ℝ}
    (hmixed : 2 * mixed ≤ eps * core + (1 / eps) * tail)
    (htotal : total = core + tail + 2 * mixed) :
    total ≤ (1 + eps) * core + (1 + 1 / eps) * tail

theorem restrict_form_smallness
    {V : Type*} (port supply normSq : V → ℝ) (K : V → Prop)
    (eta C : ℝ)
    (h : ∀ x, port x ≤ eta * supply x + C * normSq x) :
    ∀ x, K x → port x ≤ eta * supply x + C * normSq x
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Kato form-smallness and quadratic form perturbations (Kato 1966, Reed-Simon II 1975). Formal verification of logarithmic cutoff form-smallness parameter tuning and two-block Young estimates in Lean 4 is novel.
- **Advancement:** Establishes machine-verified quantitative relative form-smallness bounds under growing logarithmic tail coercivity.
- **Target Venues:** *Journal of Operator Theory* or *Operators and Matrices*.
