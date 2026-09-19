# Contribution 143: Exact Disproof of Selberg Centered Primitive Positivity Pairing

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SelbergCenteredPairing.lean`](../../formalization/BuildingBlocks/SelbergCenteredPairing.lean), [`building-blocks/selberg/selberg-centered-pairing.md`](../../building-blocks/selberg/selberg-centered-pairing.md)  
**Classification:** Analytic Number Theory / Selberg Convolutions / Prime Error Primitives / Bilinear Pairings / Rigorous Counterexamples

---

## 1. Executive Summary and Mathematical Statement

In speculative dynamical and dissipative approaches to the distribution of prime numbers, it has frequently been hypothesized that the inner product (or bilinear discrete increment pairing) between the prime-error primitive $\Delta A(x)$ and the centered Selberg auto-convolution area primitive $\Delta S(x)$ must satisfy an a priori non-negativity or monotonicity condition $\langle \Delta A, \Delta S \rangle \ge 0$.

This contribution proves:

1. **Exact Closed-Form Evaluations at Initial Steps:**  
   The finite centered convolution primitive $S(x)$ and the prime-error area primitive $A(x)$ evaluate at integers $x \in \{2, 3, 4\}$ to:
   $$
   \begin{aligned}
   S(2) &= 2 \log 2 + \frac{3}{4}, \\
   S(3) &= -\frac{5}{2} \log 2 + \frac{9}{2} \log 3 + 2, \\
   S(4) &= 10 \log 2 - \frac{7}{3} \log 3 + \frac{15}{4},
   \end{aligned}
   $$
   and
   $$
   \begin{aligned}
   A(2) &= -\frac{3}{2}, \\
   A(3) &= \log 2 - 4, \\
   A(4) &= 2 \log 2 + \log 3 - \frac{15}{2}.
   \end{aligned}
   $$
2. **Refutation of Non-Negative Pairing:**
   The paired bilinear sum of consecutive increment differences over $x \in \{2, 3, 4\}$ satisfies the strict negative upper bound:
   $$
   (A(3) - A(2))(S(3) - S(2)) + (A(4) - A(3))(S(4) - S(3)) < -\frac{13}{6} \approx -2.1667 < 0.
   $$
3. **Impossibility of Naive Dissipative Selberg Pairings:**  
   This establishes a certified Lean 4 counterexample proving that no uncompensated bilinear monotonicity exists between the prime-error primitive and the centered Selberg convolution primitive.

---

## 2. Mathematical Proof

### 2.1. Exact Primitive Values
Evaluating $S(x)$ definitionally:
$$
S(x) = \sum_{a \le x} \sum_{b \le x/a} (x - ab) \Lambda(a) \Lambda(b) - x^2 \sum_{n \le x} \frac{\Lambda(n)}{n} + \sum_{n \le x} n \Lambda(n) + \frac{x^2}{2} \log x + \frac{x^2}{4} - \frac{1}{4}.
$$
Using $\Lambda(1) = 0$, $\Lambda(2) = \log 2$, $\Lambda(3) = \log 3$, and $\Lambda(4) = \log 2$:
- For $x = 2$: the sum over $ab \le 2$ has only $(1, 1), (1, 2), (2, 1)$, whose weights vanish since $\Lambda(1) = 0$. The linear terms give $2 \log 2 + 3/4$.
- For $x = 3$ and $x = 4$: explicit expansion yields the exact rational linear forms in $\log 2$ and $\log 3$.

### 2.2. Rigorous Interval Arithmetic Bounds
Using machine-verified bounds on logarithms:
$$
0.69 < \log 2 < 0.70, \quad 1.00 < \log 3 < 1.10,
$$
the consecutive differences evaluate to:
$$
\begin{aligned}
A(3) - A(2) &= \log 2 - \frac{5}{2} \in (-1.81, -1.80), \\
S(3) - S(2) &= -\frac{9}{2} \log 2 + \frac{9}{2} \log 3 + \frac{5}{4} \in (2.60, 3.10),
\end{aligned}
$$
giving a large negative product $(A(3) - A(2))(S(3) - S(2)) \approx -5$.
Similarly, for the second term, explicit non-linear arithmetic verified by `nlinarith` confirms:
$$
(A(3) - A(2))(S(3) - S(2)) + (A(4) - A(3))(S(4) - S(3)) < -\frac{13}{6} < 0.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/SelbergCenteredPairing.lean`):
```lean
theorem selbergCenteredArea_two : selbergCenteredArea 2 = 2 * Real.log 2 + 3 / 4

theorem selbergCenteredArea_three :
    selbergCenteredArea 3 = -(5 / 2 : ℝ) * Real.log 2 +
      (9 / 2 : ℝ) * Real.log 3 + 2

theorem selbergCenteredArea_four :
    selbergCenteredArea 4 = 10 * Real.log 2 - (7 / 3 : ℝ) * Real.log 3 + 15 / 4

theorem primePrimitiveArea_two : primePrimitiveArea 2 = -(3 / 2 : ℝ)

theorem primePrimitiveArea_three : primePrimitiveArea 3 = Real.log 2 - 4

theorem primePrimitiveArea_four :
    primePrimitiveArea 4 = 2 * Real.log 2 + Real.log 3 - 15 / 2

theorem selbergCenteredPairing_two_lt :
    (primePrimitiveArea 3 - primePrimitiveArea 2) *
        (selbergCenteredArea 3 - selbergCenteredArea 2) +
      (primePrimitiveArea 4 - primePrimitiveArea 3) *
        (selbergCenteredArea 4 - selbergCenteredArea 3) < -(13 / 6 : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Selberg's symmetry formula and prime error oscillations (Selberg 1949, Levinson 1969, Montgomery 1973). The rigorous refutation of proposed dissipative/positive pairings between arithmetic primitives and Selberg convolutions in Lean 4 is novel.
- **Advancement:** Establishes a machine-verified strict negative upper bound refuting naive non-negative pairing conjectures for Selberg centered primitives.
- **Target Venues:** *Experimental Mathematics* or *Bulletin of the London Mathematical Society*.
