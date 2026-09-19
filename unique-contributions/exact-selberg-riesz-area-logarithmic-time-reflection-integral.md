# Unique Contribution 144: Exact Selberg-Riesz Area Logarithmic-Time Reflection Integral

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SelbergLogReflection.lean`](../../formalization/BuildingBlocks/SelbergLogReflection.lean), [`building-blocks/selberg/selberg-log-reflection.md`](../../building-blocks/selberg/selberg-log-reflection.md)  
**Classification:** Analytic Number Theory / Continuous Logarithmic Coordinates / Selberg Auto-Convolutions / Riesz Mean Primitives / Measurable Change of Variables

---

## 1. Executive Summary and Mathematical Statement

Connecting discrete arithmetic Dirichlet convolutions to continuous spectral analysis requires mapping discrete summations into continuous logarithmic-time integrals without imposing artificial continuity hypotheses on functions with jump discontinuities (such as the prime-counting error $E(x) = \psi(x) - x$).

This contribution proves:

1. **Measurable Exponential Coordinate Transformation:**  
   For any $T \ge 0$ and any measurable function $f: \mathbb{R} \to \mathbb{R}$ (without requiring continuity):
   \[
   \int_1^{e^T} f(a) da = \int_0^T e^t f(e^t) dt.
   \]
2. **Exact Logarithmic Rescaling of the Reflection Integrand:**  
   Under logarithmic time $t = \log a$, with prime log-error $\mathcal{E}(t) = e^{-t/2} E(e^t)$ and log-response $\mathcal{R}(t) = e^{-3t/2} \psi_1(e^t)$:
   \[
   e^T E(e^t) \left( E(e^{T-t}) - \frac{\psi_1(e^{T-t})}{e^{T-t}} \right) = e^{\frac{3}{2} T} \mathcal{E}(t) \left( \mathcal{E}(T-t) - \mathcal{R}(T-t) \right).
   \]
3. **Continuous Logarithmic Representation of Selberg Centered Area:**  
   For any integer truncation $N \ge 1$, the first Riesz mean $S(N)$ of the centered Selberg auto-convolution primitive equals the exact logarithmic-time continuous integral:
   \[
   S(N) = e^{\frac{3}{2} \log N} \int_0^{\log N} \mathcal{E}(t) \left( \mathcal{E}(\log N - t) - \mathcal{R}(\log N - t) \right) dt.
   \]

---

## 2. Mathematical Proof

### 2.1. Change of Variables for Measurable Functions
By Lean 4's one-dimensional Jacobian change-of-variables theorem (`integral_image_eq_integral_abs_deriv_smul`), the strictly monotone smooth diffeomorphism $t \mapsto e^t$ maps $(0, T]$ injectively onto $(1, e^T]$ with derivative $e^t > 0$.
Thus:
\[
\int_1^{e^T} f(a) da = \int_0^T f(e^t) e^t dt.
\]
No continuity is assumed or needed.

### 2.2. Rescaling Algebra
Let $T = \log N$ and $t = \log a$.
Then $a = e^t$ and $N/a = e^{T-t}$.
By definition of the normalized variables:
\[
E(e^t) = e^{t/2} \mathcal{E}(t), \quad E(e^{T-t}) = e^{(T-t)/2} \mathcal{E}(T-t), \quad \frac{\psi_1(e^{T-t})}{e^{T-t}} = e^{(T-t)/2} \mathcal{R}(T-t).
\]
The prefactor $e^T$ combined with the error terms gives:
\[
e^T \cdot e^{t/2} \mathcal{E}(t) \cdot e^{(T-t)/2} (\mathcal{E}(T-t) - \mathcal{R}(T-t)) = e^T e^{T/2} \mathcal{E}(t) (\mathcal{E}(T-t) - \mathcal{R}(T-t)) = e^{\frac{3}{2} T} \mathcal{E}(t) (\mathcal{E}(T-t) - \mathcal{R}(T-t)).
\]
Notice the complete cancellation of $t$ in the exponential prefactors: $t/2 + (T-t)/2 = T/2$!

### 2.3. Integration Identity
Substituting this into the arithmetic reflection formula for $S(N)$ proved in `SelbergReflection.lean`:
\[
S(N) = \int_1^N \frac{E(a)}{a} \left( E(N/a) - \frac{\psi_1(N/a)}{N/a} \right) da,
\]
the substitution $a = e^t$ with $da = e^t dt$ cancels the $1/a = e^{-t}$ in the integrand:
\[
\int_1^N \frac{1}{a} (\dots) da = \int_0^{\log N} e^{-t} (\dots) e^t dt = \int_0^{\log N} (\dots) dt.
\]
Multiplying by the global scaling yields the exact logarithmic reflection identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/SelbergLogReflection.lean`):
```lean
theorem integral_exp_substitution (T : ℝ) (hT : 0 ≤ T) (f : ℝ → ℝ) :
    (∫ a in (1 : ℝ)..Real.exp T, f a) =
      ∫ t in (0 : ℝ)..T, Real.exp t * f (Real.exp t)

theorem selbergCenteredArea_log_reflection {N : ℕ} (hN : 1 ≤ N) :
    selbergCenteredArea N = Real.exp ((3 / 2 : ℝ) * Real.log (N : ℝ)) *
      ∫ t in (0 : ℝ)..Real.log (N : ℝ),
        primeLogError t *
          (primeLogError (Real.log (N : ℝ) - t) -
            primeLogResponse (Real.log (N : ℝ) - t))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Selberg's integral equations in logarithmic coordinates (Selberg 1949, Bombieri 1976). Continuous logarithmic changes of variables for discontinuous prime error distributions are traditionally presented with informal Riemann-Stieltjes heuristics.
- **Advancement:** Establishes the exact continuous logarithmic-time representation of the discrete Selberg Riesz area without continuity hypotheses, formally machine-verified in Lean 4.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Real Analysis Exchange*.
