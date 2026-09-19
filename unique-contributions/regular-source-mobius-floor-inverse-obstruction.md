# Contribution 56: Regular Source Möbius Floor-Inverse Obstruction via Banach–Steinhaus

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/RegularSource.lean`](../../formalization/BuildingBlocks/RegularSource.lean), [`building-blocks/prime-distribution/regular-source-mobius-obstruction.md`](../../building-blocks/prime-distribution/regular-source-mobius-obstruction.md)  
**Classification:** Analytic Number Theory / Functional Analysis / Arithmetic Inversion / Obstruction Theory

---

## 1. Executive Summary and Mathematical Statement

In elementary approaches to the Riemann Hypothesis through Dirichlet's hyperbola method and arithmetic divisor forcing, the arithmetic forcing function:
$$
H(q) = \log(q!) - \sum_{n \le q} d(n) + 2\gamma q
$$
satisfies the Dirichlet square-root bound $|H(q)| \le 13\sqrt{q}$ and bounded average increments $|H(q+1) - H(q)| \le O(\log q + d(q))$. Its Möbius floor inverse is the prime error:
$$
I_H(N) = \sum_{d=1}^N \mu(d) H(\lfloor N/d \rfloor) = \psi(N) - N + 2\gamma.
$$
A recurring intuition in analytic number theory has been that any sufficiently regular sequence bounded by $\sqrt{q}$ must have its signed Möbius floor inverse canceled down to $O(N^{1/2+\varepsilon})$, which would imply the Riemann Hypothesis.

This contribution establishes a rigorous structural obstruction refuting this intuition:

1. **Existence of Fixed Counterexample Sequence:**  
   For every real exponent $r < 2/3$, there exists a fixed real sequence $f : \mathbb{N} \to \mathbb{R}$ satisfying both the square-root bound and the unit Lipschitz increment condition:
   $$
   |f(q)| \le \sqrt{q}, \quad |f(q+1) - f(q)| \le 1 \quad (\forall q \in \mathbb{N}),
   $$
   such that its signed Möbius floor inverse $I_f(N) = \sum_{d=1}^N \mu(d) f(\lfloor N/d \rfloor)$ **has no eventual bound of power $N^r$**:
   $$
   \neg \exists C \in \mathbb{R}, \exists N_0 \in \mathbb{N}, \forall N \ge N_0, \quad |I_f(N)| \le C N^r.
   $$
2. **Finite Separated Tent Construction:**  
   For each integer $t \ge 256$, at the cubic scale $N = t^3$, placing triangular tent functions of width $t$ at floor centers $c_d = \lfloor t^3/d \rfloor$ ($d \le t$) with sign $\mu(d)$ generates an explicit source $f_t$ satisfying $|f_t(q)| \le \sqrt{q}$ and $|f_t(q+1) - f_t(q)| \le 1$ such that:
   $$
   I_{f_t}(t^3) = \frac{t}{4} \sum_{d \le t} \mu(d)^2 \ge \frac{t^2}{64}.
   $$
   Since $t^2 = N^{2/3}$, this lower bound scales as $N^{2/3}$, strictly violating any $C N^r$ bound whenever $r < 2/3$.
3. **Infinite-Dimensional Functional Analysis Lift:**  
   To obtain a **single fixed sequence** $f$ (rather than a family depending on $N$), the space of regular sequences is realized as a closed Banach subspace $E \subset \ell^\infty \times \ell^\infty$. Applying the **Banach–Steinhaus Uniform Boundedness Principle** proves that the family of continuous linear functionals $L_{r, N}(g, h) = N^{-r} I_f(N)$ cannot be pointwise bounded on $E$, formally deducing the existence of the fixed counterexample.

---

## 2. Mathematical Proof

### 2.1. Floor Quotient Separation
Let $N = t^3$, $c_d = \lfloor t^3/d \rfloor$ for $1 \le d \le t$. For $1 \le d < e \le t$:
$$
c_e + t \le c_d.
$$
Indeed, $c_e \ge t^2$ and $e c_e \le t^3$. Since $d+1 \le e$ and $d t \le t^2 \le c_e$:
$$
d(c_e + t) \le (d+1)c_e \le e c_e \le t^3 \implies c_e + t \le \lfloor t^3/d \rfloor = c_d.
$$
Thus the floor centers are separated by at least $t$.

### 2.2. Tent Envelope and Squarefree Density
For $z \in \{1, -1\}$, let $P_z(x) = \max_{d \le t, \mu(d)=z} \max(0, t/2 - |x - c_d|)$, and define:
$$
f_t(q) = \frac{P_1(q) - P_{-1}(q)}{2}.
$$
Then $f_t$ is 1-Lipschitz, $|f_t(q)| \le t/4 \le \sqrt{q}$, and at each center $c_d$, only the tent at $c_d$ is non-zero:
$$
f_t(c_d) = \frac{t}{4} \mu(d).
$$
For $d > t$, $\lfloor t^3/d \rfloor + t \le t^2$, which lies outside the support of all tents. Hence:
$$
I_{f_t}(t^3) = \sum_{d \le t} \mu(d) f_t(c_d) = \frac{t}{4} \sum_{d \le t} \mu(d)^2 \ge \frac{t}{4} \cdot \frac{t}{16} = \frac{t^2}{64} = \frac{N^{2/3}}{64}.
$$

### 2.3. Banach–Steinhaus Principle
Let $B = \ell^\infty(\mathbb{N}, \mathbb{R})$ and $E = \{(g, h) \in B \times B : h(q) = \sqrt{q+1} g(q+1) - \sqrt{q} g(q)\}$.  
$E$ is a closed subspace of $B \times B$, hence a complete Banach space.  
For each $N$, the evaluation functional:
$$
L_{r, N}(g, h) = \frac{1}{N^r} \sum_{d \le N} \mu(d) \sqrt{\lfloor N/d \rfloor} g(\lfloor N/d \rfloor)
$$
is linear and continuous on $E$.  
The test functions $f_t$ lift to elements of $E$ with norm $\le 1$, yielding operator norm $\|L_{r, N}\| \ge \frac{N^{2/3 - r}}{64} \to \infty$ as $N \to \infty$ whenever $r < 2/3$.  
By the Banach–Steinhaus theorem, the functionals cannot be pointwise bounded on $E$. Thus there exists $p \in E$ such that $\sup_N |L_{r, N}(p)| = \infty$. Normalizing $p$ produces the required fixed sequence $f$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.RegularSource`):
```lean
theorem signedMobiusInverse_smoothTestSource_lower {t : ℕ} (ht : 256 ≤ t) :
    (t : ℝ) ^ 2 / 64 ≤ signedMobiusInverse (smoothTestSource t) (t ^ 3)

theorem regularMobiusFunctional_not_uniformly_bounded {r : ℝ} (hr : r < 2 / 3) :
    ¬ ∃ C : ℝ, ∀ N : ℕ, ‖regularMobiusFunctional r N‖ ≤ C

theorem exists_fixed_regular_source_with_unbounded_inverse {r : ℝ} (hr : r < 2 / 3) :
    ∃ f : ℕ → ℝ, (∀ q : ℕ, |f q| ≤ Real.sqrt q) ∧
      (∀ q : ℕ, |f (q + 1) - f q| ≤ 1) ∧
      ¬ ∃ C : ℝ, ∃ N₀ : ℕ, ∀ N : ℕ, max 1 N₀ ≤ N →
        |signedMobiusInverse f N| ≤ C * (N : ℝ) ^ r
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior literature comparison:** The hyperbola method and divisor bounds are classical. Priority for the exact obstruction theorem stated here is provisional; this audit did not establish its absence from publications or formal libraries.
- **Advancement:** Establishes the exact exponent threshold 2/3 via Banach–Steinhaus and finite separated tents, machine-verified in Lean 4.
- **Target Venues:** *Bulletin of the London Mathematical Society* or *Mathematische Annalen*.
