# Contribution 311: Exact Logarithmic Layercake Representation and Cauchy Moment Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/LogarithmicLayercake.lean`](../../formalization/BuildingBlocks/LogarithmicLayercake.lean), [`building-blocks/spectral-tail/layercake.md`](../../building-blocks/spectral-tail/layercake.md)  
**Classification:** Measure Theory / Real Analysis / Layer-Cake Representation / Spectral Moments / Cauchy Tail Domination / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

A central technical obstacle in spectral distribution theory is obtaining non-circular control over logarithmic moments $\int_{\mathbb{R}} r(x) \log(2 + |x|) dx$ when the spectral density $r(x)$ is only known to have finite mass $H = \int r(x) dx$ and point-decay majorized by a Cauchy kernel $r(x) \le \frac{A}{1 + x^2}$.

This contribution proves:

1. **Exact Logarithmic Layer-Cake Formula:**  
   For any Borel measure $\mu$ on $\mathbb{R}$:
   $$
   \int_{\mathbb{R}} \log\left(\frac{2 + |x|}{2}\right) d\mu(x) = \int_0^\infty \mu(\{x \in \mathbb{R} : |x| > t\}) \frac{1}{2 + t} dt.
   $$
2. **Explicit Two-Regime Truncation Bound:**  
   If the tail measure satisfies $\mu(\{x : |x| > t\}) \le \min(H, 2A/t)$ for all $t > 0$, then for any truncation threshold $R > 0$:
   $$
   \int_{\mathbb{R}} \log\left(\frac{2 + |x|}{2}\right) d\mu(x) \le H \log\left(\frac{2 + R}{2}\right) + \frac{2A}{R}.
   $$
3. **Optimal Threshold Minimization:**  
   Setting the optimal balance radius $R = \frac{2A}{H}$ minimizes the sum, yielding the sharp upper bound:
   $$
   \int_{\mathbb{R}} \log\left(\frac{2 + |x|}{2}\right) d\mu(x) \le H \left( \log\left(1 + \frac{A}{H}\right) + 1 \right).
   $$
4. **Complete Logarithmic Spectral Moment Majorization:**  
   For any non-negative measurable density $r \in L^1(\mathbb{R})$ with $\int r = H \ge 0$ and $r(x) \le \frac{A}{1 + x^2}$ ($A > 0$):
   $$
   \int_{-\infty}^\infty r(x) \log(2 + |x|) dx \le H \left( \log 2 + \log\left(1 + \frac{A}{H}\right) + 1 \right).
   $$
   When $H = 0$, the moment vanishes identically.
5. **Universal Logarithmic Integrability:**  
   Under Cauchy tail domination, $x \mapsto r(x) \log(2 + |x|)$ is Lebesgue integrable on $\mathbb{R}$ without requiring higher-order polynomial decay.

---

## 2. Mathematical Proof

### 2.1. Layer-Cake Primitive
The kernel $k(t) = \frac{1}{2+t}$ has primitive $\int_0^t \frac{1}{2+x} dx = \log(2+t) - \log 2$.
By Fubini–Tonelli / the layer-cake theorem (`lintegral_comp_eq_lintegral_meas_lt_mul`), for any measure $\mu$:
$$
\int_{\mathbb{R}} (\log(2+|x|) - \log 2) d\mu(x) = \int_0^\infty \mu(\{x : |x| > t\}) \frac{1}{2+t} dt.
$$

### 2.2. Two-Regime Tail Integration
Given $\mu(\{|x| > t\}) \le \min(H, 2A/t)$, split $(0, \infty) = (0, R] \cup (R, \infty)$:
1. On $(0, R]$, bound $\mu(\{|x| > t\}) \le H$:
   $$
   \int_0^R \mu(\{|x| > t\}) \frac{1}{2+t} dt \le H \int_0^R \frac{1}{2+t} dt = H (\log(2+R) - \log 2).
   $$
2. On $(R, \infty)$, bound $\mu(\{|x| > t\}) \le 2A/t$ and $\frac{1}{2+t} \le \frac{1}{t}$:
   $$
   \int_R^\infty \mu(\{|x| > t\}) \frac{1}{2+t} dt \le 2A \int_R^\infty \frac{1}{t(2+t)} dt \le 2A \int_R^\infty \frac{1}{t^2} dt = \frac{2A}{R}.
   $$
Summing both contributions gives $\le H \log(1 + R/2) + \frac{2A}{R}$.

### 2.3. Optimization at $R = 2A/H$
Substitute $R = \frac{2A}{H}$:
$$
H \log\left(1 + \frac{2A/H}{2}\right) + \frac{2A}{2A/H} = H \log\left(1 + \frac{A}{H}\right) + H = H \left( \log\left(1 + \frac{A}{H}\right) + 1 \right).
$$
Adding the constant baseline $\int H \log 2$:
$$
\int r(x) \log(2+|x|) dx \le H \left( \log 2 + \log\left(1 + \frac{A}{H}\right) + 1 \right).
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.LogarithmicLayercake` in `formalization/BuildingBlocks/LogarithmicLayercake.lean`):
```lean
lemma logarithmic_layercake (μ : Measure ℝ) :
    (∫⁻ x : ℝ, ENNReal.ofReal (Real.log (2+|x|)-Real.log 2) ∂μ) =
      ∫⁻ t in Ioi (0 : ℝ), μ {x : ℝ | t < |x|} * ENNReal.ofReal (1/(2+t))

lemma logarithmic_layercake_le {μ : Measure ℝ} {H A R : ℝ}
    (hH : 0 ≤ H) (hA : 0 ≤ A) (hR : 0 < R)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    (∫⁻ x : ℝ, ENNReal.ofReal (Real.log (2+|x|)-Real.log 2) ∂μ) ≤
      ENNReal.ofReal (H*(Real.log (2+R)-Real.log 2)+2*A/R)

lemma optimized_increment_bound {μ : Measure ℝ} {H A : ℝ}
    (hH : 0 < H) (hA : 0 < A)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    (∫ x : ℝ, Real.log (2+|x|)-Real.log 2 ∂μ) ≤
      H*(Real.log (1+A/H)+1)

lemma density_log_moment_nonnegative_mass {r : ℝ → ℝ} {A H : ℝ}
    (hm : Measurable r) (hr : Integrable r) (hn : ∀ x, 0 ≤ r x)
    (hA : 0 < A) (hH : 0 ≤ H) (hMass : (∫ x, r x)=H)
    (hb : ∀ x, r x ≤ A/(1+x^2)) :
    Integrable (fun x : ℝ => r x * Real.log (2+|x|)) ∧
    (∫ x : ℝ, r x * Real.log (2+|x|)) ≤
      H*(Real.log 2+Real.log (1+A/H)+1)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Lieb & Loss (2001) *Analysis* (Layer-cake representation); Hardy, Littlewood & Pólya (1952) *Inequalities*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes non-circular, sharp logarithmic moment bounds parameterized solely by mass $H$ and Cauchy constant $A$.
- **Target Venues:** *Real Analysis Exchange* or *Journal of Mathematical Analysis and Applications*.
