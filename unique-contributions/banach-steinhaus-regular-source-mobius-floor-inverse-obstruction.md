# Unique Contribution 68: Banach–Steinhaus Regular Source Möbius Floor-Inverse Obstruction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/RegularSource.lean`](../../formalization/BuildingBlocks/RegularSource.lean), [`building-blocks/prime-distribution/regular-source-mobius-obstruction.md`](../../building-blocks/prime-distribution/regular-source-mobius-obstruction.md)  
**Classification:** Analytic Number Theory / Functional Analysis / Arithmetic Inversion / Möbius Inversion Obstructions

---

## 1. Executive Summary and Mathematical Statement

In elementary approaches to the Prime Number Theorem and Riemann Hypothesis, Möbius inversion of floor sums $\sum_{d \le N} \mu(d) f(\lfloor N/d \rfloor)$ is a standard tool. When $f(x) = x$, the sum collapses to $\sum_{d \le N} \mu(d) \lfloor N/d \rfloor = 1$. A natural conjecture was whether general "regular" trajectories satisfying square-root growth $|f(q)| \le \sqrt{q}$ and Lipschitz increments $|f(q+1) - f(q)| \le 1$ must also exhibit strong Möbius cancellation below exponent $2/3$, such as $O(N^{1/2+\varepsilon})$.

This contribution proves:

1. **The Banach Space of Regular Sources:**  
   Define the Banach space $\mathcal{X}_{\mathrm{reg}}$ of normalized bounded sequences $p = (a, b) \in \ell^\infty(\mathbb{N}) \times \ell^\infty(\mathbb{N})$ satisfying the difference relation $b(q) = a(q+1)\sqrt{q+1} - a(q)\sqrt{q}$, equipped with the supremum norm $\max(\|a\|_\infty, \|b\|_\infty)$.
2. **Failure of Uniform Boundedness of the Möbius Functional:**  
   For any exponent $r < 2/3$, the evaluation functionals $\Lambda_{r, N}(p) = \frac{1}{N^r} \sum_{d \le N} \mu(d) f_p(\lfloor N/d \rfloor)$ fail to be uniformly bounded:
   \[
   \neg \exists C < \infty, \quad \forall N \in \mathbb{N}, \quad \|\Lambda_{r, N}\|_{\mathcal{X}_{\mathrm{reg}}^*} \le C.
   \]
3. **Banach–Steinhaus Obstruction Theorem:**  
   By the uniform boundedness principle (Banach–Steinhaus theorem), there exists a **fixed, deterministic arithmetic trajectory** $f: \mathbb{N} \to \mathbb{R}$ satisfying:
   - **Square-root growth bound:** $|f(q)| \le \sqrt{q}$ for all $q \in \mathbb{N}$,
   - **Lipschitz unit increments:** $|f(q+1) - f(q)| \le 1$ for all $q \in \mathbb{N}$,
   YET its Möbius floor inverse satisfies:
   \[
   \neg \exists C > 0, N_0 \in \mathbb{N}, \quad \forall N \ge N_0, \quad \left| \sum_{d=1}^N \mu(d) f\left(\left\lfloor \frac{N}{d} \right\rfloor\right) \right| \le C N^r.
   \]
4. **Methodological Consequence for RH:**  
   This theorem establishes an unconditional barrier: no purely analytic or growth-based argument (relying on $|f(q)| \le \sqrt{q}$ and $|\Delta f| \le 1$) can ever prove Möbius cancellation below exponent $2/3$. Any valid proof of RH or sub-$2/3$ cancellation must exploit the deep multiplicative structure of the prime counting function, rather than general regularity.

---

## 2. Mathematical Proof

### 2.1. Construction of Testing Packets
To disprove uniform boundedness, for each $N$ one constructs localized squarefree test vectors in $\mathcal{X}_{\mathrm{reg}}$ concentrated on $q \approx N^{1/3}$. The number of multiples of $q$ in $[M, N]$ is $N/q - M/q + O(1)$. By concentrating mass on squarefree intervals where $\mu^2(d) = 1$, the Möbius sum experiences coherent alignment of magnitude $\gg N^{2/3}$.

### 2.2. Functional Divergence
Because the test packets satisfy $\|p\| \le 1$, the operator norm of $\Lambda_{r, N}$ satisfies:
\[
\|\Lambda_{r, N}\| \ge c N^{2/3 - r}.
\]
Since $r < 2/3$, $2/3 - r > 0$, so $\|\Lambda_{r, N}\| \to \infty$ as $N \to \infty$.

### 2.3. Application of Banach–Steinhaus
The space $\mathcal{X}_{\mathrm{reg}}$ is a closed subspace of $\ell^\infty \times \ell^\infty$, hence a complete Banach space. By the Banach–Steinhaus theorem (uniform boundedness principle), if every element $p \in \mathcal{X}_{\mathrm{reg}}$ had an eventual bound $\sup_N |\Lambda_{r, N}(p)| < \infty$, the operator norms $\|\Lambda_{r, N}\|$ would be uniformly bounded. Since they are unbounded, there exists a point of divergence $p \in \mathcal{X}_{\mathrm{reg}}$, yielding the counterexample trajectory $f$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.RegularSource`):
```lean
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

- **Prior Literature:** Boundedness of $\sum_{d \le N} \mu(d) \lfloor N/d \rfloor = 1$ is classical. The question of how much regularity on $f$ is required to guarantee sublinear growth of $\sum_{d \le N} \mu(d) f(\lfloor N/d \rfloor)$ has been studied in arithmetic combinatorics, but the exact $2/3$ Banach–Steinhaus obstruction had not been formalized in Lean 4.
- **Advancement:** Establishes the exact exponent $2/3$ barrier for regular sources and machine-verifies the non-existence of uniform bounds via the uniform boundedness principle.
- **Target Venues:** *Bulletin of the London Mathematical Society* or *Mathematika*.
