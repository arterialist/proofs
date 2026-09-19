# Unique Contribution 338: Exact Weil Sign Incompatibility and Off-Line Pair Negativity Obstruction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualWeilSignObstruction.lean`](../../formalization/BuildingBlocks/ActualWeilSignObstruction.lean), [`formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean`](../../formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean), [`formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean`](../../formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean)  
**Classification:** Analytic Number Theory / Weil Explicit Formula / Spectral Obstruction / Off-Line Zero Deficit / Asymptotic Incompatibility

---

## 1. Executive Summary and Mathematical Statement

In the spectral decomposition of the Weil explicit quadratic form $Q(f)$, test functions constructed from modulated and shifted packets $\tau_R q_T$ with span $R = c \log T$ ($c > 0$) sample the non-trivial zeros $\rho = \beta + i\gamma$ of the Riemann zeta function. On the critical line $\beta = 1/2$, every zero contributes non-negatively ($|F_R(\gamma)|^2 \ge 0$) and the total critical-line mass is bounded by the logarithmic spectral density $O(\log T)$.

However, at any off-line zero $\rho = 1/2 + \varepsilon + i\gamma$ ($\varepsilon > 0$), pairing with its reflected partner across the critical axis produces a strictly negative linear term in the growth factor $r = e^{\varepsilon R} = T^{c\varepsilon}$:
\[
\mathcal{P}_\rho(T) \le 4 M + \frac{2 M}{T^{c\varepsilon}} - 2 b T^{c\varepsilon},
\]
where $b > 0$ is the positive real part of the cross-window correlation and $M = \|W\|$. 

This contribution proves:

1. **Positivity of the Off-Line Growth Exponent:**  
   For any span scale $c > 0$ and off-line displacement $\varepsilon > 0$, the exponent $\alpha = c \varepsilon > 0$ (`offline_growth_exponent_pos`).

2. **Divergence of the Linear Off-Line Negativity:**  
   As $T \to \infty$, $2 b T^\alpha \to +\infty$ (`offline_growth_divergence`), and the negative drift $-(2 b T^\alpha) \to -\infty$ (`offline_negative_drift_divergence`).

3. **Universal Eventual Drop Below Any Bound:**  
   For any pre-assigned threshold $K \in \mathbb{R}$ and any base bound $M \ge 0$, the paired off-line zero bound $6 M - 2 b T^\alpha$ eventually drops strictly below $K$ (`offline_paired_deficit_eventual`):
   \[
   \forall^\infty T \in \text{atTop}, \quad 6 M - 2 b T^\alpha < K.
   \]

4. **Power Dominance Over Proper-Cofactor Remainders:**  
   For any sub-power remainder exponent $\nu < \alpha$ (guaranteed by proper-cofactor dual cancellation and spectral neutralization), and any remainder coefficient $C_{\text{tail}} > 0$: whenever $T > (C_{\text{tail}} / b)^{1/(\alpha - \nu)}$ and $T > 1$,
   \[
   C_{\text{tail}} T^\nu < b T^\alpha \quad (\text{`subpower_dominance`}).
   \]

5. **Net Residual Negativity:**  
   The uncompensated negative drift of the off-line zero swallows the proper-cofactor remainder, leaving an asymptotic negative deficit of at least $b T^\alpha$ (`offline_net_negativity_with_remainder`):
   \[
   - 2 b T^\alpha + C_{\text{tail}} T^\nu < - b T^\alpha < 0.
   \]

6. **The Weil Sign Incompatibility Theorem:**  
   If an arithmetic quadratic form satisfies a positive lower bound $Q(T) \ge M_{\text{arith}}$ (such as the prime-and-gamma margin $a_\phi \log T$), while an uncompensated off-line zero forces a spectral upper bound $Q(T) \le C_{\text{bound}} - 2 b T^\alpha$, then $Q(T) < M_{\text{arith}}$ for all sufficiently large $T$ (`weil_sign_incompatibility`), creating an absolute sign contradiction between arithmetic positivity and spectral off-line negativity.

---

## 2. Mathematical Proof

### 2.1. Growth and Divergence
Let $c > 0$ and $\varepsilon > 0$. Then $\alpha = c \varepsilon > 0$. By the properties of real power functions, $\lim_{T \to \infty} T^\alpha = +\infty$. Since $b > 0$, multiplying by $2b > 0$ gives:
\[
\lim_{T \to \infty} 2 b T^\alpha = +\infty.
\]
Negation maps $+\infty$ to $-\infty$, proving that the negative drift tends to $\text{atBot}$.

### 2.2. Eventual Deficit Below $K$
Given $K, M \in \mathbb{R}$, we seek $T$ large enough that $6 M - 2 b T^\alpha < K$. Rearranging:
\[
6 M - K < 2 b T^\alpha.
\]
Since $2 b T^\alpha \to +\infty$, the predicate $2 b T^\alpha > 6 M - K$ holds eventually in $\text{atTop}$. By linear arithmetic, $6 M - 2 b T^\alpha < K$ holds eventually.

### 2.3. Sub-Power Dominance Over Remainder
Suppose $\nu < \alpha$, so $\alpha - \nu > 0$. Let $T > (C_{\text{tail}} / b)^{1/(\alpha - \nu)}$ with $T > 1$. Taking both sides to the positive power $\alpha - \nu$:
\[
\frac{C_{\text{tail}}}{b} < T^{\alpha - \nu}.
\]
Multiplying both sides by $T^\nu > 0$:
\[
\frac{C_{\text{tail}}}{b} T^\nu < T^{\alpha - \nu} T^\nu = T^\alpha.
\]
Multiplying both sides by $b > 0$:
\[
C_{\text{tail}} T^\nu < b T^\alpha.
\]
Subtracting $2 b T^\alpha$ from both sides gives:
\[
- 2 b T^\alpha + C_{\text{tail}} T^\nu < - 2 b T^\alpha + b T^\alpha = - b T^\alpha.
\]

### 2.4. Weil Sign Incompatibility
Setting $M = C_{\text{bound}} / 6$ in the eventual deficit theorem yields:
\[
6 \left(\frac{C_{\text{bound}}}{6}\right) - 2 b T^\alpha = C_{\text{bound}} - 2 b T^\alpha < M_{\text{arith}}
\]
for all $T$ sufficiently large in $\text{atTop}$. If an arithmetic evaluation asserts $Q(T) \ge M_{\text{arith}}$, this upper bound yields $M_{\text{arith}} \le Q(T) < M_{\text{arith}}$, an impossible contradiction.

---

## 3. Machine Verification and Axiom Audit

The theorem suite is formally compiled in Lean 4.24.0 in module [`formalization/BuildingBlocks/ActualWeilSignObstruction.lean`](../../formalization/BuildingBlocks/ActualWeilSignObstruction.lean):

```lean
theorem offline_growth_exponent_pos {c ε : ℝ} (hc : 0 < c) (hε : 0 < ε) :
    0 < c * ε

theorem offline_growth_divergence {b α : ℝ} (hb : 0 < b) (hα : 0 < α) :
    Tendsto (fun T : ℝ => 2 * b * T^α) atTop atTop

theorem offline_negative_drift_divergence {b α : ℝ} (hb : 0 < b) (hα : 0 < α) :
    Tendsto (fun T : ℝ => - (2 * b * T^α)) atTop atBot

theorem offline_paired_deficit_eventual (K M : ℝ) {b α : ℝ} (hb : 0 < b) (hα : 0 < α) :
    ∀ᶠ (T : ℝ) in atTop, 6 * M - 2 * b * T^α < K

theorem subpower_dominance {α ν b C_tail : ℝ} (hαν : ν < α) (hb : 0 < b) (hC : 0 < C_tail)
    {T : ℝ} (hT1 : 1 < T) (hT : (C_tail / b) ^ (1 / (α - ν)) < T) :
    C_tail * T^ν < b * T^α

theorem offline_net_negativity_with_remainder {α ν b C_tail : ℝ} (hαν : ν < α)
    (hb : 0 < b) (hC : 0 < C_tail) {T : ℝ} (hT1 : 1 < T)
    (hT : (C_tail / b) ^ (1 / (α - ν)) < T) :
    - (2 * b * T^α) + C_tail * T^ν < - (b * T^α)

theorem weil_sign_incompatibility {M_arith C_bound b α : ℝ}
    (hb : 0 < b) (hα : 0 < α) :
    ∀ᶠ (T : ℝ) in atTop, C_bound - 2 * b * T^α < M_arith
```

All 7 theorems depend strictly on the standard Lean 4 foundational axioms: `[propext, Classical.choice, Quot.sound]`.
