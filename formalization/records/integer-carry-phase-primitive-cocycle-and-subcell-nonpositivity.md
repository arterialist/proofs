# Contribution 35: Integer-Scale Carry Phase, Double-Telescoping Primitive Cocycle, and Unconditional Subcell Nonpositivity

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Primary Reference:** [`building-blocks/theta-and-heat/integer-carry-heat-work-and-weight-obstruction.md`](../../building-blocks/theta-and-heat/integer-carry-heat-work-and-weight-obstruction.md)  
**Lean Formalization:** [`formalization/BuildingBlocks/IntegerCarryPhase.lean`](../../formalization/BuildingBlocks/IntegerCarryPhase.lean), [`formalization/BuildingBlocks/IntegerCarryPrimitiveAnalytic.lean`](../../formalization/BuildingBlocks/IntegerCarryPrimitiveAnalytic.lean), [`formalization/BuildingBlocks/IntegerCarryPrimitiveIntegral.lean`](../../formalization/BuildingBlocks/IntegerCarryPrimitiveIntegral.lean), [`formalization/BuildingBlocks/IntegerCarryPrimitiveBounds.lean`](../../formalization/BuildingBlocks/IntegerCarryPrimitiveBounds.lean), [`formalization/BuildingBlocks/IntegerCarryIntegrationByParts.lean`](../../formalization/BuildingBlocks/IntegerCarryIntegrationByParts.lean)  
**Target Venue:** *Journal of Mathematical Analysis and Applications* or *Proceedings of the American Mathematical Society*

---

## 1. Result and scope

In harmonic analysis and prime distribution, counting-function discrepancies such as $\psi(x) - x$ and heat-trace kernels $\sum \Lambda(n) e^{-nt}$ exhibit oscillations intimately tied to arithmetic floor carries $\lfloor m x \rfloor - m\lfloor x \rfloor$. Prior literature lacks an exact closed theory of the continuous primitives of these floor-carry phases, their multiplicative scaling cocycles, and their sign properties on the continuum.

This work establishes the complete theory of the integer-scale carry phase:
$$
\xi_m(x) = \lfloor m\{x\}\rfloor - \frac{m-1}{2} = m\left(\{x\} - \frac{1}{2}\right) - \left(\{mx\} - \frac{1}{2}\right) \qquad (m \in \mathbb{N}_{\ge 1}).
$$

**Theorem (Integer Carry Cocycles, Subcell Nonpositivity, and Integration by Parts).**  
1. **Multiplicative Floor Cocycle:** For all natural scales $m, n \ge 1$ and all $x \in \mathbb{R}$,
   $$
   \xi_{mn}(x) = n \xi_m(x) + \xi_n(mx).
   $$
2. **Continuous Primitive with Vanishing Integer Trace:** The canonical continuous primitive of $\xi_m(x)$ is given by:
   $$
   \Xi_m(x) = -\frac{m}{2}\{x\}(1-\{x\}) + \frac{1}{2m}\{mx\}(1-\{mx\}),
   $$
   which satisfies $\Xi_m(N) = 0$ for all integers $N \in \mathbb{Z}$, and on each subcell $[N + j/m, N + (j+1)/m]$ has derivative $\Xi_m'(x) = \xi_m(x)$.
3. **Primitive Scaling Cocycle:** The primitive obeys the exact dilation cocycle:
   $$
   \Xi_{mn}(x) = n \Xi_m(x) + \frac{1}{m}\Xi_n(mx).
   $$
4. **Unconditional Real-Line Nonpositivity:** For every integer scale $m \ge 1$ and every point $x \in \mathbb{R}$, the primitive is unconditionally nonpositive:
   $$
   -\frac{m}{8} \le \Xi_m(x) \le 0.
   $$
   Consequently, the definite integral of the carry phase from the unit origin satisfies:
   $$
   -\frac{m}{8} \le \int_1^x \xi_m(y) dy \le 0 \qquad (\forall x \in \mathbb{R}).
   $$
5. **Integer Obstruction (Failure of Real Scales):** For non-integer real dilations $r \notin \mathbb{N}$, nonpositivity fails and a non-vanishing origin boundary trace appears: for instance, at $r = 3/2$, $\Xi_{3/2}(1) = 1/12 > 0$.
6. **Uniform $O(1/m^2)$ Limiting Gap:** The normalized non-negative primitives converge uniformly to the parabolic profile with an explicit sharp error:
   $$
   0 \le \frac{1}{2}\{x\}(1-\{x\}) - \frac{-\Xi_m(x)}{m} = \frac{\{mx\}(1-\{mx\})}{2m^2} \le \frac{1}{8m^2}.
   $$
7. **Boundary-Free Integration by Parts:** For any $C^1$ test function $g$:
   $$
   \int_1^X \xi_m(x) g(x) dx = \Xi_m(X) g(X) - \int_1^X \Xi_m(x) g'(x) dx,
   $$
   with identically vanishing initial boundary trace $\Xi_m(1) = 0$, suppressing exponential energy growth and yielding unconditional polynomial bounds on the centered heat response $S_m(T) \le \frac{m}{6}[(T+5)^3 - 125]$.

---

## 2. Mathematical Proof Architecture

### 2.1 The Subcell Decomposition
For $x \in \mathbb{R}$, write $\{x\} = \frac{j + s}{m}$ where $j = \lfloor m\{x\}\rfloor \in \{0, 1, \dots, m-1\}$ and $s = \{mx\} \in [0, 1)$.
Then:
$$
1 - \{x\} = \frac{m - j - s}{m}.
$$
The primitive evaluated at $x$ takes the form:
$$
2m \Xi_m(x) = s(1-s) - m^2 \{x\}(1-\{x\}) = s(1-s) - (j+s)(m - j - s).
$$

### 2.2 The Quadratic Subcell Product Bound
To prove $\Xi_m(x) \le 0$, it suffices to show $s(1-s) \le (j+s)(m-j-s)$.
Expanding the right-hand side as an affine function in $s \in [0, 1]$:
$$
(j+s)(m-j-s) - s(1-s) = j(m-j) + s(m - 2j - 1).
$$
At $s = 0$, this equals $j(m-j) \ge 0$ since $0 \le j \le m-1$.
At $s = 1$, it equals $j(m-j) + m - 2j - 1 = (j+1)(m - (j+1)) \ge 0$ since $j+1 \le m$.
By linear interpolation:
$$
(j+s)(m-j-s) - s(1-s) = j(m-j)(1-s) + (j+1)(m-j-1)s \ge 0.
$$
Because both endpoints are non-negative, the expression is non-negative for all $s \in [0, 1]$.
Hence $s(1-s) \le (j+s)(m-j-s)$, which proves $2m \Xi_m(x) \le 0$, establishing $\Xi_m(x) \le 0$ unconditionally on $\mathbb{R}$.

### 2.3 The Lower Bound
Using the unit parabolic bound $0 \le \{y\}(1-\{y\}) \le 1/4$, we have:
$$
\Xi_m(x) = -\frac{m}{2}\{x\}(1-\{x\}) + \frac{1}{2m}\{mx\}(1-\{mx\}) \ge -\frac{m}{2} \cdot \frac{1}{4} + 0 = -\frac{m}{8}.
$$

---

## 3. Literature Comparison

| Feature | Standard Discrepancy Literature | Real-Dilation Models | This Work |
|---|---|---|---|
| **Floor Carry Representation** | Heuristic sawtooth estimates | Continuous dilation $r \in \mathbb{R}$ | **Exact integer floor carry $\xi_m(x) = \lfloor m\{x\}\rfloor - \frac{m-1}{2}$** |
| **Primitive Sign** | Unsigned / oscillating | Positive at origin ($\Xi_{3/2}(1) = 1/12$) | **Unconditionally nonpositive $\Xi_m(x) \le 0$ for all $m \in \mathbb{N}$** |
| **Initial Trace** | Non-vanishing boundary terms | Non-zero origin defect $\Xi_r(1) \ne 0$ | **Identically vanishing initial trace $\Xi_m(1) = 0$** |
| **Scaling Identity** | None | Broken cocycles | **Exact multiplicative cocycle $\Xi_{mn}(x) = n\Xi_m(x) + \frac{1}{m}\Xi_n(mx)$** |
| **Uniform Rate** | Qualitative | Weak asymptotic | **Sharp $1/(8m^2)$ uniform envelope bound** |
| **Formalization** | None | None | **5 complete Lean 4 modules compiled with zero `sorry`** |

---

## 4. Formalization and Reproducibility

- Lean 4 formalization files:
  - [`formalization/BuildingBlocks/IntegerCarryPhase.lean`](../../formalization/BuildingBlocks/IntegerCarryPhase.lean)
  - [`formalization/BuildingBlocks/IntegerCarryPrimitiveAnalytic.lean`](../../formalization/BuildingBlocks/IntegerCarryPrimitiveAnalytic.lean)
  - [`formalization/BuildingBlocks/IntegerCarryPrimitiveIntegral.lean`](../../formalization/BuildingBlocks/IntegerCarryPrimitiveIntegral.lean)
  - [`formalization/BuildingBlocks/IntegerCarryPrimitiveBounds.lean`](../../formalization/BuildingBlocks/IntegerCarryPrimitiveBounds.lean)
  - [`formalization/BuildingBlocks/IntegerCarryIntegrationByParts.lean`](../../formalization/BuildingBlocks/IntegerCarryIntegrationByParts.lean)
- Machine-checked under Lean 4.24.0.
- Foundational axioms: strictly `[propext, Classical.choice, Quot.sound]`.
