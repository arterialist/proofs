# Unique Contribution 67: Causal Successor-Predecessor Adjoint Duality and Isometry-Projection Algebra

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorCriticalLift.lean`](../../formalization/BuildingBlocks/SuccessorCriticalLift.lean)  
**Classification:** Operator Algebras / Transfer Semigroups / Partial Isometries / Toeplitz Systems

---

## 1. Executive Summary and Mathematical Statement

In non-commutative geometry and arithmetic dynamical systems, the continuous dilation semigroup $x \mapsto \lambda x$ interacts with the discrete shift $x \mapsto x+1$. When represented on logarithmic critical coordinates $u = \log x \in (0, \infty)$, the additive unit shift becomes the non-linear transfer operator $T$, whose operator-theoretic adjoint and projection structure have previously remained unformalized.

This contribution proves:

1. **Exact Causal Predecessor Adjoint:**  
   The $L^2(0, \infty)$ Hilbert adjoint of the causal successor operator $(T f)(v) = \sqrt{\frac{e^v}{1 + e^v}} f(\log(1 + e^v))$ is given explicitly by the causal predecessor operator:
   \[
   (P f)(u) = \begin{cases} \frac{1}{\sqrt{1 - e^{-u}}} f(\log(e^u - 1)) & u > \log 2 \\ 0 & u \le \log 2, \end{cases}
   \]
   satisfying the exact duality:
   \[
   \langle f, T g \rangle_{L^2(0, \infty)} = \langle P f, g \rangle_{L^2(0, \infty)} \quad (\forall f, g \in L^2(0, \infty)).
   \]
2. **Left-Inversion and Unilateral Shift Algebra:**  
   The composition of successor and predecessor satisfies:
   \[
   (T \circ P)(f) = f \quad \text{on } (0, \infty),
   \]
   so $T$ is a left-inverse of $P$. In the opposite direction:
   \[
   (P \circ T)(f) = \mathbf{1}_{(\log 2, \infty)} f,
   \]
   which is the orthogonal projection onto functions supported away from the initial cell $(0, \log 2)$.
3. **Exact Isometry and Co-Isometry Mass Conservation:**  
   - The predecessor $P$ is an **exact isometry** on $L^2(0, \infty)$:
     \[
     \|P f\|_{L^2(0, \infty)}^2 = \|f\|_{L^2(0, \infty)}^2.
     \]
   - The successor $T$ is a **co-isometry** whose output mass equals the input mass restricted to $(\log 2, \infty)$:
     \[
     \|T f\|_{L^2(0, \infty)}^2 = \int_{\log 2}^\infty |f(u)|^2 \, du.
     \]
4. **Unitary Conjugation of the Physical Discrete Shift:**  
   Under the unitary transformation $U: L^2(1, \infty) \to L^2(0, \infty)$ defined by $(U H)(u) = e^{u/2} H(e^u)$, $T$ and $P$ conjugate precisely to the physical unit shifts:
   \[
   T(U H)(v) = e^{v/2} H(e^v + 1), \quad P(U H)(u) = e^{u/2} H(e^u - 1) \cdot \mathbf{1}_{u > \log 2}.
   \]

---

## 2. Mathematical Proof

### 2.1. Adjoint Identity
Let $\sigma(v) = \log(1 + e^v)$. The diffeomorphism $\sigma: (0, \infty) \to (\log 2, \infty)$ has derivative $J(v) = e^v/(1 + e^v)$.
By change of variables:
\[
\int_0^\infty f(v) (T g)(v) \, dv = \int_0^\infty f(v) \sqrt{J(v)} g(\sigma(v)) \, dv.
\]
Setting $u = \sigma(v)$, we have $v = \log(e^u - 1)$ and $dv = du / J(v) = w(u) du / \sqrt{J(v)}$, where $w(u) = 1/\sqrt{1 - e^{-u}}$.
Then $f(v) \sqrt{J(v)} dv = f(\log(e^u - 1)) w(u) du$.
Since $P f(u) = 0$ for $u \le \log 2$, integrating over $(\log 2, \infty)$ is identical to integrating $P f(u) g(u)$ over $(0, \infty)$.

### 2.2. Composition and Projection
For $v > 0$, $\sigma(v) > \log 2$, so:
\[
(T P f)(v) = \sqrt{J(v)} (P f)(\sigma(v)) = \sqrt{J(v)} w(\sigma(v)) f(\log(e^{\sigma(v)} - 1)).
\]
Since $\sqrt{J(v)} w(\sigma(v)) = 1$ and $\log(e^{\sigma(v)} - 1) = v$, this simplifies identically to $f(v)$.
Conversely, if $u > \log 2$, $(P T f)(u) = w(u) \sqrt{J(\sigma^{-1}(u))} f(\sigma(\sigma^{-1}(u))) = f(u)$. If $u \le \log 2$, $P(T f)(u) = 0$.

### 2.3. $L^2$ Norms
By the change of variables theorem for non-negative integrals (without assuming finite mass):
\[
\int_0^\infty |T f(v)|^2 \, dv = \int_0^\infty J(v) |f(\sigma(v))|^2 \, dv = \int_{\log 2}^\infty |f(u)|^2 \, du.
\]
For $P$:
\[
\int_0^\infty |P f(u)|^2 \, du = \int_{\log 2}^\infty w(u)^2 |f(\log(e^u - 1))|^2 \, du.
\]
Substituting $v = \log(e^u - 1)$ where $w(u)^2 du = dv$:
\[
\int_0^\infty |P f(u)|^2 \, du = \int_0^\infty |f(v)|^2 \, dv = \|f\|_{L^2(0, \infty)}^2.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorCharge`):
```lean
theorem successor_predecessor_adjoint (f g : ℝ → ℝ) :
    (∫ v in Ioi (0 : ℝ), f v * successor g v) =
      ∫ u in Ioi (0 : ℝ), predecessor f u * g u

theorem successor_predecessor (f : ℝ → ℝ) {v : ℝ} (hv : 0 < v) :
    successor (predecessor f) v = f v

theorem predecessor_successor (f : ℝ → ℝ) (u : ℝ) :
    predecessor (successor f) u = (Ioi (log 2)).indicator f u

theorem successor_square_lintegral (f : ℝ → ℝ) :
    (∫⁻ v in Ioi (0 : ℝ), ENNReal.ofReal (successor f v ^ 2)) =
      ∫⁻ u in Ioi (log 2), ENNReal.ofReal (f u ^ 2)

theorem predecessor_square_lintegral (f : ℝ → ℝ) :
    (∫⁻ u in Ioi (0 : ℝ), ENNReal.ofReal (predecessor f u ^ 2)) =
      ∫⁻ v in Ioi (0 : ℝ), ENNReal.ofReal (f v ^ 2)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Unilateral shift representations and partial isometries are central in operator algebras (Cuntz algebras, Toeplitz operators). Their exact realization for non-linear logarithmic shifts on $L^2(\mathbb{R}_{>0})$ had not previously been machine-checked.
- **Advancement:** Proves that the logarithmic shift is a pure co-isometry with explicit isometric adjoint and projection kernel on $(\log 2, \infty)$.
- **Target Venues:** *Journal of Operator Theory* or *Integral Equations and Operator Theory*.
