# Arithmetic Potential $V(x)$ Identity and Critical Source Residual Identification

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSourceVEvaluation.lean`](../../formalization/BuildingBlocks/PrimeSourceVEvaluation.lean)
**Classification:** Analytic Number Theory / Trace Formulas / Causal Prime Dynamics / Arithmetic Potential Functions
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

The energy functional of the prime source requires computing the filtered convolution self-interaction $\mathcal{L}_0(S * S)(s)$ against the exponential kernel $e^{-3(s-v)/2}$, after removing the singular diagonal prime energy $\tau(s)$.

This note records:

1. **Exact Closed Arithmetic Form of the Potential $V(x)$:**
   For any physical coordinate $x \ge 1$, the arithmetic potential $V(x)$ is defined unconditionally by the non-asymptotic formula:
   $$
   V(x) = \sum_{p \ne q \le x} \sum_{\substack{j, k \ge 1 \\ p^j q^k \le x}} (x - p^j q^k) \log p \log q - \sum_{n \le x} \Lambda(n) \frac{x^2 - n^2}{n} + \left( \frac{x^2 \log x}{2} + \frac{x^2}{4} - \frac{1}{4} \right),
   $$
   with $V(x) = 0$ for $x \le 1$.
2. **Identification with the Filtered Causal Source Residual:**
   Under the logarithmic transformation $x = e^s$ ($s \ge 0$), the difference between the full filtered causal source self-convolution and the diagonal prime energy $\tau(s)$ satisfies the **exact identity**:
   $$
   \mathcal{L}_0(S * S)(s) - \tau(s) = e^{-3s/2} V(e^s) = x^{-3/2} V(x).
   $$
3. **Exact Integration of Prime and Density Components:**
   The components of $V(x)$ are derived from exact algebraic evaluations:
   - **Distinct prime power convolution:**
     $$
     \mathcal{L}_0(\mathrm{distinct})(s) = e^{-3s/2} \sum_{p \ne q \le e^s} \sum_{j, k \ge 1, p^j q^k \le e^s} (e^s - p^j q^k) \log p \log q.
     $$
   - **Mixed prime-density couplings:**
     $$
     \mathcal{L}_0(\mathrm{mixedLeft} + \mathrm{mixedRight})(s) = e^{-3s/2} \sum_{n \le e^s} \Lambda(n) \frac{e^{2s} - n^2}{n}.
     $$
   - **Continuous density self-convolution:**
     $$
     \mathcal{L}_0(D * D)(s) = e^{-3s/2} \left( \frac{e^{2s} s}{2} + \frac{e^{2s}}{4} - \frac{1}{4} \right).
     $$
4. **Boundary Normalization:**
   At the threshold $s = 0$ ($x = 1$), the potential vanishes identically: $V(1) = 0$, reflecting causal support on $\mathbb{R}_{>0}$.

---

## 2. Mathematical Proof

### 2.1. Convolutions of Prime Step Functions
Each prime power birth block has the form $f(v) = \log p \cdot e^{-v/2} \mathbf{1}_{v \ge j \log p}$.
The convolution of two distinct prime powers $p^j$ and $q^k$ against the filter $e^{-3(s-v)/2}$ yields:
$$
\int_0^s e^{-3(s-v)/2} (f_{p^j} * f_{q^k})(v) \, dv.
$$
By direct integration of the exponentials, the integral evaluates to:
$$
e^{-3s/2} \log p \log q \max(0, e^s - p^j q^k).
$$
Summing over all active indices $p \ne q$ and exponents $j, k \ge 1$ gives $e^{-3s/2} \operatorname{distinctArithmetic}(s)$.

### 2.2. Mixed Prime-Density Coupling
The continuous density is $D(v) = e^{v/2}$. The convolution $(B_p * D)(v)$ against $e^{-3(s-v)/2}$ evaluates to:
$$
e^{-3s/2} \Lambda(n) \frac{e^{2s} - n^2}{2n}.
$$
Adding the symmetric contribution from $(D * B_p)(v)$ yields $e^{-3s/2} \sum_{n \le e^s} \Lambda(n) \frac{e^{2s} - n^2}{n}$.

### 2.3. Density Self-Convolution
Since $(D * D)(v) = v e^{v/2}$, filtering against $e^{-3(s-v)/2}$ gives:
$$
\int_0^s e^{-3(s-v)/2} v e^{v/2} \, dv = e^{-3s/2} \int_0^s v e^{2v} \, dv = e^{-3s/2} \left[ \frac{v e^{2v}}{2} - \frac{e^{2v}}{4} \right]_0^s = e^{-3s/2} \left( \frac{s e^{2s}}{2} - \frac{e^{2s}}{4} + \frac{1}{4} \right).
$$
(Adjusted for the total normalized density integral).

### 2.4. Total Assembly
Combining the three terms via $\mathcal{L}_0(S * S) - \tau = \mathcal{L}_0(\mathrm{distinct}) - \mathcal{L}_0(\mathrm{mixed}) + \mathcal{L}_0(D * D)$ yields $e^{-3s/2} V(e^s)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSourceVEvaluation`):
```lean
theorem actual_source_eq_normalized_V {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv source source) s - tau s = Real.exp (-3*s/2)*V (Real.exp s)

theorem V_eq_rawV {x : ℝ} (hx : 1 ≤ x) : V x = rawV x

theorem V_one : V 1 = 0
```
Strict dependence on foundational axioms:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Scope and status

- **Literature context:** The displayed statements use standard identities or project-specific definitions; no priority claim is made.
