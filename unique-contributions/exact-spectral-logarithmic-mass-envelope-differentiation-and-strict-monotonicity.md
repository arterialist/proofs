# Unique Contribution 211: Exact Spectral Logarithmic Mass Envelope Differentiation and Strict Monotonicity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/LogarithmicMassEnvelope.lean`](../../formalization/BuildingBlocks/LogarithmicMassEnvelope.lean), [`building-blocks/envelope/logarithmic-mass-envelope.md`](../../building-blocks/envelope/logarithmic-mass-envelope.md)  
**Classification:** Real Analysis / Convex Analysis / Spectral Theory / Moment Envelopes / Monotone Operators / Analytic Number Theory

---

## 1. Executive Summary and Mathematical Statement

In the spectral theory of truncated counting functions and layer-cake moment bounds for arithmetic sums, the scaling function:
\[
E_A(h) = h \left(1 + \log\left(1 + \frac{A}{h}\right)\right) \quad (A \ge 0, h > 0)
\]
serves as the universal upper envelope bounding the accumulated spectral mass. Establishing that this envelope is strictly increasing with respect to the bandwidth/window parameter $h$ without invoking asymptotic approximations is essential for rigorous multiscale majorization.

This contribution proves:

1. **Exact Scale Derivative Formula:**  
   For all parameters $A \ge 0$ and $h > 0$:
   \[
   \frac{d}{dh} E_A(h) = 1 + \log\left(1 + \frac{A}{h}\right) - \frac{A}{A + h}.
   \]
2. **Strict Positivity of the Scale Derivative:**  
   Because $\log(1 + A/h) \ge 0$ and $\frac{A}{A + h} < 1$ for all $A \ge 0, h > 0$:
   \[
   \frac{d}{dh} E_A(h) > 1 + 0 - 1 = 0.
   \]
3. **Strict Monotonicity on the Half-Line:**  
   $E_A(h)$ is strictly increasing on $(0, \infty)$:
   \[
   0 < h_1 < h_2 \implies E_A(h_1) < E_A(h_2).
   \]
4. **Non-Decreasing Envelope Majorization:**  
   For any bandwidths $0 < h \le H$:
   \[
   E_A(h) \le E_A(H).
   \]

---

## 2. Mathematical Proof

### 2.1. Product Rule and Logarithmic Differentiation
Write $E_A(h) = h \cdot 1 + h \log(1 + A/h)$.
The first term differentiates to $1$.
For the second term, applying the product and chain rules:
\[
\frac{d}{dh} [h \log(1 + A/h)] = 1 \cdot \log(1 + A/h) + h \cdot \frac{1}{1 + A/h} \cdot \left(-\frac{A}{h^2}\right)
\]
\[
= \log(1 + A/h) - \frac{A}{h (1 + A/h)} = \log(1 + A/h) - \frac{A}{A + h}.
\]
Adding the derivative of the first term yields the exact expression:
\[
E_A'(h) = 1 + \log\left(1 + \frac{A}{h}\right) - \frac{A}{A + h}.
\]

### 2.2. Strict Positivity
Since $A \ge 0$ and $h > 0$, $1 + A/h \ge 1$, so $\log(1 + A/h) \ge 0$.
Furthermore, $A < A + h$ implies $\frac{A}{A + h} < 1$.
Consequently:
\[
E_A'(h) = \left( 1 - \frac{A}{A + h} \right) + \log\left(1 + \frac{A}{h}\right) = \frac{h}{A + h} + \log\left(1 + \frac{A}{h}\right) > 0.
\]

### 2.3. Strict Monotonicity
Since the open half-line $(0, \infty)$ is convex and $E_A'(h) > 0$ everywhere on $(0, \infty)$, the mean value theorem / `strictMonoOn_of_deriv_pos` guarantees that $E_A$ is strictly monotonically increasing on $(0, \infty)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.LogarithmicMassEnvelope` in `formalization/BuildingBlocks/LogarithmicMassEnvelope.lean`):
```lean
lemma hasDerivAt_envelope {A h : ℝ} (hA : 0 ≤ A) (hh : 0 < h) :
    HasDerivAt (envelope A)
      (1 + Real.log (1 + A / h) - A / (A + h)) h

lemma envelope_derivative_pos {A h : ℝ} (hA : 0 ≤ A) (hh : 0 < h) :
    0 < 1 + Real.log (1 + A / h) - A / (A + h)

theorem envelope_strictMonoOn {A : ℝ} (hA : 0 ≤ A) :
    StrictMonoOn (envelope A) (Set.Ioi 0)

theorem envelope_le {A h H : ℝ} (hA : 0 ≤ A) (hh : 0 < h)
    (hH : h ≤ H) : envelope A h ≤ envelope A H
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Logarithmic Sobolev and entropy envelopes in spectral counting and concentration inequalities (Ledoux 2001, Boucheron-Lugosi-Bousquet 2013). Machine formalization of the exact non-asymptotic derivative and strict monotonicity of $h(1 + \log(1 + A/h))$ in Lean 4 is new.
- **Advancement:** Establishes the exact derivative formula $1 + \log(1 + A/h) - A/(A+h)$ and proves unconditional strict monotonicity on $(0, \infty)$ in Lean 4.
- **Target Venues:** *Real Analysis Exchange* or *Journal of Mathematical Analysis and Applications*.
