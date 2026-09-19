# Exact Additive Heat Gram Positivity and Cauchy-Lipschitz Embedding

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/AdditiveHeatPairing.lean`](../../formalization/BuildingBlocks/AdditiveHeatPairing.lean),
**Classification:** Functional Analysis / Hilbert Spaces / Positive-Definite Kernels / Cauchy-Hilbert Matrices / Lipschitz Embeddings / Formalized Mathematics
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

In the geometric embedding of prime scale parameters into Hilbert function spaces, prime birth locations $x \ge 1$ are mapped to relaxation wave packets in $L^2(0, \infty)$ via the birth map:
$$
\text{birth}(x)(t) = e^{-xt}, \qquad t > 0.
$$
The inner product between two such states in $L^2(0, \infty)$ generates the classical Cauchy-Hilbert kernel $\langle \text{birth}(x), \text{birth}(y) \rangle = \frac{1}{x+y}$.

This note records:

1. **Global 1/2-Lipschitz Hilbert Space Embedding:**
   The birth map $x \mapsto \text{birth}(x)$ from the closed half-line $[1, \infty)$ into $L^2(0, \infty)$ is globally Lipschitz continuous with sharp Lipschitz constant $L = 1/2$:
   $$
   \| \text{birth}(x) - \text{birth}(y) \|_{L^2(0, \infty)} \le \frac{1}{2} |x - y|.
   $$
2. **Exact Metric Tensor of the Exponential Heat Curve:**
   For any $x, y \ge 1$:
   $$
   \| \text{birth}(x) - \text{birth}(y) \|_{L^2(0, \infty)}^2 = \frac{(x - y)^2}{2xy(x+y)}.
   $$
3. **Strict Positivity of the Finite Additive Heat Gram Form:**
   For any finite family of nodes $x_i > 0$ and weights $c_i \in \mathbb{R}$:
   $$
   \sum_{i, j \in S} \frac{c_i c_j}{x_i + x_j} = \int_0^\infty \left( \sum_{i \in S} c_i e^{-x_i t} \right)^2 dt \ge 0.
   $$
   This provides an exact integral representation of the Cauchy-Hilbert matrix $\left[ \frac{1}{x_i + x_j} \right]$ as a positive-semidefinite Gramian operator.
4. **Exact Integral Formula for Differences of Exponentials:**
   For all $x, y > 0$:
   $$
   \int_0^\infty (e^{-xt} - e^{-yt})^2 dt = \frac{(x - y)^2}{2xy(x+y)} \le \frac{(x - y)^2}{4} \quad (\text{for } x, y \ge 1).
   $$
5. **Elementary Laplace Kernel Representation:**
   $\int_0^\infty e^{-xt} e^{-yt} dt = \frac{1}{x+y}$ for all $x, y > 0$.

---

## 2. Mathematical Proof

### 2.1. Laplace Pairing and Gram Identity
For $x, y > 0$, the function $t \mapsto e^{-(x+y)t}$ is integrable on $(0, \infty)$:
$$
\int_0^\infty e^{-xt} e^{-yt} dt = \int_0^\infty e^{-(x+y)t} dt = \left[ \frac{e^{-(x+y)t}}{-(x+y)} \right]_0^\infty = \frac{1}{x+y}.
$$
Squaring the linear combination profile $P(t) = \sum_{i \in S} c_i e^{-x_i t}$:
$$
P(t)^2 = \sum_{i, j \in S} c_i c_j e^{-(x_i + x_j)t}.
$$
Integrating term-by-term yields $\int_0^\infty P(t)^2 dt = \sum_{i, j} \frac{c_i c_j}{x_i + x_j} \ge 0$.

### 2.2. Metric Tensor Identity
Expanding the square difference:
$$
(e^{-xt} - e^{-yt})^2 = e^{-2xt} - 2e^{-(x+y)t} + e^{-2yt}.
$$
Integrating over $(0, \infty)$:
$$
\int_0^\infty (e^{-xt} - e^{-yt})^2 dt = \frac{1}{2x} - \frac{2}{x+y} + \frac{1}{2y} = \frac{y(x+y) - 4xy + x(x+y)}{2xy(x+y)} = \frac{(x-y)^2}{2xy(x+y)}.
$$

### 2.3. Uniform 1/2-Lipschitz Bound
For $x \ge 1$ and $y \ge 1$, $x y \ge 1$ and $x + y \ge 2$, hence:
$$
2xy(x+y) \ge 2 \cdot 1 \cdot 2 = 4.
$$
Therefore:
$$
\| \text{birth}(x) - \text{birth}(y) \|_{L^2}^2 = \frac{(x-y)^2}{2xy(x+y)} \le \frac{(x-y)^2}{4},
$$
and taking square roots yields $\| \text{birth}(x) - \text{birth}(y) \|_{L^2} \le \frac{1}{2} |x - y|$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.AdditiveHeatPairing` in `formalization/BuildingBlocks/AdditiveHeatPairing.lean`):
```lean
theorem exponential_pair_integral {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    (∫ t : ℝ in Ioi 0, Real.exp (-x * t) * Real.exp (-y * t)) = 1 / (x + y)

theorem finite_additive_gram_nonnegative {ι : Type*} (s : Finset ι)
    (x c : ι → ℝ) (hx : ∀ i ∈ s, 0 < x i) :
    0 ≤ ∑ i ∈ s, ∑ j ∈ s, c i * c j / (x i + x j)

theorem birth_distance_square (x y : Ici (1 : ℝ)) :
    ‖birth x - birth y‖ ^ 2 =
      ((x : ℝ) - (y : ℝ)) ^ 2 / (2 * (x : ℝ) * (y : ℝ) * ((x : ℝ) + (y : ℝ)))

theorem birth_distance_bound (x y : Ici (1 : ℝ)) :
    ‖birth x - birth y‖ ≤ ‖(x : ℝ) - (y : ℝ)‖ / 2

theorem birth_lipschitz : LipschitzWith (1 / 2 : NNReal) birth
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Scope and status

- **Literature context:** The displayed statements use standard identities or project-specific definitions; no priority claim is made.
