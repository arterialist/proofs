# Contribution 118: Exact Joint-Mellin Principal Part at Arbitrary-Multiplicity Zeta Zeros

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ZetaPole.lean`](../../formalization/BuildingBlocks/ZetaPole.lean), [`building-blocks/weil-and-spectral/zeta-pole.md`](../../building-blocks/weil-and-spectral/zeta-pole.md)  
**Classification:** Analytic Number Theory / Riemann Zeta Function / Logarithmic Derivatives / Laurent Expansions / Joint Mellin Transforms / Meromorphic Continuation

---

## 1. Executive Summary and Mathematical Statement

In the spectral formulation of the Riemann hypothesis via the joint arithmetic Mellin transform:
$$
\mathcal{M}(s) = -\frac{\zeta'(s)}{s \zeta(s)} - \frac{1}{s - 1} + \frac{2\gamma}{s},
$$
the presence and character of its poles govern the spectral test forms on the real line.

This contribution proves:

1. **Rigorous Local Logarithmic Derivative Factorization:**  
   If $f$ is analytic at $\rho \in \mathbb{C}$, not locally zero, and satisfies $f(\rho) = 0$, then there exists an exact positive integer multiplicity $m \in \mathbb{N}_{\ge 1}$ and an analytic germ $a(z)$ at $\rho$ such that on a punctured neighborhood $\dot{\mathcal{N}}(\rho)$:
   $$
   \frac{f'(z)}{f(z)} = \frac{m}{z - \rho} + a(z).
   $$
   This is established purely through analytic factorization $f(z) = (z - \rho)^m g(z)$ with $g(\rho) \ne 0$, without postulating simple zeros.
2. **Global Non-Vanishing of the Zeta Function:**  
   Because $\mathbb{C} \setminus \{1\}$ is connected and $\zeta(2) = \pi^2 / 6 \ne 0$, the Riemann zeta function is not identically zero on any neighborhood of any point $s \ne 1$.
3. **Exact Simple Pole and Residue of the Joint Mellin Transform:**  
   For any zeta zero $\rho \in \mathbb{C}$ with $\rho \ne 0$ and $\rho \ne 1$ of arbitrary multiplicity $m \ge 1$, the joint Mellin transform has an exact simple pole at $s = \rho$ with residue:
   $$
   \operatorname{Res}_{s = \rho} \mathcal{M}(s) = -\frac{m}{\rho} \ne 0,
   $$
   and an analytic regular part $A(s)$ at $\rho$:
   $$
   \mathcal{M}(s) = \frac{-m/\rho}{s - \rho} + A(s), \quad \lim_{s \to \rho, s \ne \rho} (s - \rho) \mathcal{M}(s) = -\frac{m}{\rho}.
   $$

---

## 2. Mathematical Proof

### 2.1. Analytic Factorization of Logarithmic Derivatives
Let $f$ be analytic at $\rho$ and not locally zero. By the isolated zeros theorem for analytic functions on normed spaces, there exists an integer $m \ge 1$ and a germ $g$ analytic at $\rho$ with $g(\rho) \ne 0$ such that $f(z) = (z - \rho)^m g(z)$ in a neighborhood of $\rho$.
Taking the logarithmic derivative:
$$
\frac{f'(z)}{f(z)} = \operatorname{logDeriv}((z - \rho)^m g(z)) = \operatorname{logDeriv}((z - \rho)^m) + \operatorname{logDeriv}(g(z)).
$$
By the power rule and chain rule:
$$
\operatorname{logDeriv}((z - \rho)^m) = m \operatorname{logDeriv}(z - \rho) = \frac{m}{z - \rho}.
$$
Setting $a(z) = \frac{g'(z)}{g(z)}$, since $g$ is analytic and $g(\rho) \ne 0$, $a(z)$ is analytic at $\rho$.

### 2.2. Application to Riemann Zeta
Since $\zeta(s)$ is analytic on $\mathbb{C} \setminus \{1\}$ and not locally zero at $\rho \notin \{0, 1\}$, there exists $m \ge 1$ and analytic $b(s)$ such that $\frac{\zeta'(s)}{\zeta(s)} = \frac{m}{s - \rho} + b(s)$.
Then:
$$
-\frac{\zeta'(s)}{s \zeta(s)} = -\frac{m}{s(s - \rho)} - \frac{b(s)}{s}.
$$
Using the partial fraction identity:
$$
\frac{1}{s(s - \rho)} = \frac{1}{\rho(s - \rho)} - \frac{1}{\rho s},
$$
we have:
$$
-\frac{\zeta'(s)}{s \zeta(s)} = -\frac{m/\rho}{s - \rho} + \frac{m}{\rho s} - \frac{b(s)}{s}.
$$
Adding $-\frac{1}{s - 1} + \frac{2\gamma}{s}$:
$$
\mathcal{M}(s) = \frac{-m/\rho}{s - \rho} + \left( \frac{m}{\rho s} - \frac{b(s)}{s} - \frac{1}{s - 1} + \frac{2\gamma}{s} \right).
$$
Letting $A(s) = \frac{m}{\rho s} - \frac{b(s)}{s} - \frac{1}{s - 1} + \frac{2\gamma}{s}$. Since $\rho \ne 0$ and $\rho \ne 1$, each term in $A(s)$ is analytic at $\rho$, so $A(s)$ is analytic at $\rho$.
Since $m \ge 1$ and $\rho \ne 0$, $-m/\rho \ne 0$. Multiplying by $(s - \rho)$ and taking the limit $s \to \rho$ yields $-m/\rho$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks`):
```lean
theorem zeta_analytic_off_pole :
    AnalyticOnNhd ℂ riemannZeta ({1}ᶜ : Set ℂ)

theorem zeta_not_locally_zero {s : ℂ} (hs : s ≠ 1) :
    ¬ ∀ᶠ z in 𝓝 s, riemannZeta z = 0

theorem analytic_logDerivative_principal_part {f : ℂ → ℂ} {ρ : ℂ}
    (hf : AnalyticAt ℂ f ρ) (hn : ¬ ∀ᶠ z in 𝓝 ρ, f z = 0)
    (hzero : f ρ = 0) :
    ∃ m : ℕ, 0 < m ∧ ∃ a : ℂ → ℂ, AnalyticAt ℂ a ρ ∧
      ∀ᶠ z in 𝓝[≠] ρ, deriv f z / f z = (m : ℂ) / (z - ρ) + a z

theorem zeta_jointMellin_principal_part {ρ : ℂ} (hρ0 : ρ ≠ 0) (hρ1 : ρ ≠ 1)
    (hzero : riemannZeta ρ = 0) :
    ∃ m : ℕ, 0 < m ∧ ∃ a : ℂ → ℂ, AnalyticAt ℂ a ρ ∧
      (∀ᶠ s in 𝓝[≠] ρ,
        -deriv riemannZeta s / (s * riemannZeta s) - 1 / (s - 1) +
          (2 * (Real.eulerMascheroniConstant : ℂ)) / s =
        (-(m : ℂ) / ρ) / (s - ρ) + a s) ∧
      Tendsto (fun s : ℂ => (s - ρ) *
        (-deriv riemannZeta s / (s * riemannZeta s) - 1 / (s - 1) +
          (2 * (Real.eulerMascheroniConstant : ℂ)) / s))
        (𝓝[≠] ρ) (𝓝 (-(m : ℂ) / ρ)) ∧ -(m : ℂ) / ρ ≠ 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Analytic continuation and zero spectra of the Riemann zeta function (Titchmarsh 1986, Edwards 1974). Explicit formalization of the meromorphic Laurent principal part and residue $-m/\rho$ for the joint Mellin operator under arbitrary zero multiplicity in Lean 4 is novel.
- **Advancement:** Establishes machine-verified Laurent principal part and non-zero residues of the joint Mellin transform at any zeta zero.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Journal of Mathematical Analysis and Applications*.
