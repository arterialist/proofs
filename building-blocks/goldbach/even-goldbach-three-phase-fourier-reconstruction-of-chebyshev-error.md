# Finite 3-adic Fourier extraction for a centered Goldbach polynomial

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/GoldbachThreePhaseFourier.lean`](../../formalization/BuildingBlocks/GoldbachThreePhaseFourier.lean), [`formalization/BuildingBlocks/GoldbachThreePhaseHarmonicFinite.lean`](../../formalization/BuildingBlocks/GoldbachThreePhaseHarmonicFinite.lean), [`formalization/BuildingBlocks/GoldbachThreePhaseEndpoint.lean`](../../formalization/BuildingBlocks/GoldbachThreePhaseEndpoint.lean)
**Classification:** Additive Number Theory / Multiplicative Fourier Analysis / Goldbach Conjectures / Chebyshev Prime Discrepancy
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

The Lean source defines a finite centered Goldbach polynomial with a completely multiplicative 3-adic phase and proves its first angular harmonic by direct integration. The endpoint module also contains an identity involving the project's `psi` and correction terms under these definitions. This note records those scoped finite identities; it does not claim a general Goldbach-to-$\psi$ reconstruction or a new theorem.

1. **Even Goldbach Triangle with 3-Adic Multiplicative Phase:**
   For any integer $N$, let the parity-centered even Goldbach triangle be evaluated with 3-adic angular phase $\chi_3(n, \theta) = \exp(i v_3(n) \theta)$. The first angular Fourier harmonic of this finite trigonometric polynomial is:
   $$
   H_1(N) = \frac{1}{\pi} \int_0^{2\pi} \operatorname{complexCenteredGoldbach}(N, \theta) \cos \theta \, d\theta.
   $$
2. **Exact Algebraic Harmonic Evaluation:**
   The finite continuous angular integral $H_1(N)$ evaluates algebraically with zero approximation error to the discrete first harmonic:
   $$
   H_1(N) = \operatorname{threeFirstHarmonic}(N).
   $$
3. **Endpoint identity under the declared finite definitions:**
   On every odd cutoff $X = 2k + 3$ (with triangle cutoff $N = 2k + 6$):
   $$
   H_1(2k+6) = 2 \log 3 \left( \psi(2k+3) - (2k+3) - \log 2 \lfloor \log_2(2k+3) \rfloor - 1 - \log 3 \cdot |\operatorname{lateThreeLadder}(2k+6)| \right).
   $$
4. **Algebraic rearrangement of that endpoint identity:**
   Inverting this relation gives an explicit formula recovering the complete-von-Mangoldt prime error $\psi(X) - X$ strictly from the first Fourier harmonic of an even Goldbach sum:
   $$
   \psi(2k+3) - (2k+3) = \frac{H_1(2k+6)}{2 \log 3} + \log 2 \lfloor \log_2(2k+3) \rfloor + 1 + \log 3 \cdot |\operatorname{lateThreeLadder}(2k+6)|.
   $$
These last two displays are statements about the finite definitions in `GoldbachThreePhaseEndpoint.lean`; their interpretation as a reconstruction theorem for the general Goldbach problem is deliberately left open.

---

## 2. Mathematical Proof

### 2.1. Multiplicative 3-Adic Phase
The character $\chi_3(n, \theta) = e^{i v_3(n)\theta}$ is completely multiplicative on $\mathbb{N}$:
$$
v_3(mn) = v_3(m) + v_3(n) \implies \chi_3(mn, \theta) = \chi_3(m, \theta) \chi_3(n, \theta).
$$
For any prime $p \ne 3$, $v_3(p) = 0$, so $\chi_3(p, \theta) = 1$. For $p = 3$, $\chi_3(3^j, \theta) = e^{ij\theta}$.

### 2.2. Angular Fourier Projection
Integrating against $\cos \theta$ on $[0, 2\pi]$ projects out the pure first harmonic:
$$
\frac{1}{\pi} \int_0^{2\pi} \cos(j\theta - m\theta) \cos \theta \, d\theta = \begin{cases} 1 & |j - m| = 1 \\ 0 & \text{otherwise}. \end{cases}
$$
Thus, the continuous integral $\frac{1}{\pi} \int_0^{2\pi} \operatorname{evenCenteredGoldbach}(N, \theta) \cos \theta \, d\theta$ reduces identically to the discrete sum of cross-terms between adjacent 3-adic valuation layers $|v_3(a) - v_3(b)| = 1$.

### 2.3. Telescoping to the Chebyshev Discrepancy
The endpoint file supplies the displayed correction terms for the project's finite `weight`, `oddReference`, and ladder definitions. That algebra should be read as an internal identity of those definitions; the elementary valuation layer itself does not equal a general von Mangoldt sum, so no unrestricted telescoping claim is made here.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.GoldbachThreePhaseFourier`):
```lean
theorem threeAngularHarmonic_eq (N : ℕ) :
    threeAngularHarmonic N = threeFirstHarmonic N

theorem threeAngularHarmonic_prime_error (k : ℕ) :
    threeAngularHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) -
          Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ))

theorem complexAngularHarmonic_prime_error (k : ℕ) :
    complexAngularHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) -
          Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ))

theorem actual_prime_error_from_complex_angular_harmonic (k : ℕ) :
    BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) =
      complexAngularHarmonic (2 * k + 6) / (2 * Real.log 3) +
        Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) + 1 +
          Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Scope and status

- **Literature context:** The finite Fourier projection is elementary harmonic analysis, and the endpoint relation is project-specific algebra. No priority claim is made. The corresponding Lean source does not formalize a general circle-method theorem or a new Goldbach estimate.
- **Repository role:** Reusable finite Fourier/formalization building block.
