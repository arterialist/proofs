# Exact regular-source Möbius floor-inverse obstruction below exponent two-thirds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/RegularSource.lean`](../formalization/BuildingBlocks/RegularSource.lean), [`building-blocks/prime-distribution/regular-source-mobius-obstruction.md`](../building-blocks/prime-distribution/regular-source-mobius-obstruction.md)  
**Classification:** Analytic Number Theory / Functional Analysis / Banach Spaces / Uniform Boundedness Principle / Möbius Inversion / Squarefree Density / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

This project uses boundary sources $f : \mathbb{N} \to \mathbb{R}$ as model inputs for floor Möbius inversion. The theorem asks whether imposing regularity—specifically, square-root growth $|f(q)| \le \sqrt{q}$ and 1-Lipschitz bounded first differences $|f(q+1) - f(q)| \le 1$—suffices to force its floor Möbius inverse:
$$
M(f, N) = \sum_{d=1}^N \mu(d) f\left(\left\lfloor \frac{N}{d} \right\rfloor\right)
$$
to obey an asymptotic bound $|M(f, N)| \le C N^r$ for some sublinear exponent $r$.

The theorem proves:

1. **Existence of a regular counterexample sequence for each fixed $r < 2/3$:**  
   For every exponent $r < 2/3$, there exists a fixed sequence $f : \mathbb{N} \to \mathbb{R}$ satisfying:
   - Square-root growth: $|f(q)| \le \sqrt{q}$ for all $q \in \mathbb{N}$,
   - 1-Lipschitz bounded first differences: $|f(q+1) - f(q)| \le 1$ for all $q \in \mathbb{N}$,
   such that its Möbius floor inverse exceeds every eventual bound of power $r$:
   $$
   \neg \exists C \in \mathbb{R}, \exists N_0 \in \mathbb{N}, \forall N \ge N_0, \quad |M(f, N)| \le C N^r.
   $$
2. **Failure of Uniform Boundedness for Normalized Möbius Functionals:**  
   On the Banach space $\mathcal{X}$ of regular normalized sequences $(g, h)$ endowed with the supremum norm, the family of continuous linear evaluation functionals:
   $$
   T_N(g) = \frac{1}{N^r} \sum_{d=1}^N \mu(d) \sqrt{\lfloor N/d \rfloor} g(\lfloor N/d \rfloor)
   $$
   is NOT uniformly bounded for any $r < 2/3$:
   $$
   \neg \exists C \in \mathbb{R}, \forall N \in \mathbb{N}, \quad \|T_N\|_{\mathcal{X}^*} \le C.
   $$
3. **Squarefree Terminal Half-Interval Density:**  
   For all integers $N \ge 256$, the number of squarefree integers in the terminal half $[N/2, N]$ satisfies the unconditional lower bound:
   $$
   \# \{ d \in (N/2, N] : \mu^2(d) = 1 \} \ge \frac{N}{16}.
   $$
4. **Banach-Steinhaus Deduction:**  
   By the uniform boundedness principle on the complete Banach space $\mathcal{X}$, non-uniform boundedness of operator norms implies the existence of a single, universal element $p \in \mathcal{X}$ whose trajectory $\{T_N(p)\}_{N \in \mathbb{N}}$ is unbounded, producing the desired fixed counterexample $f$.

---

This is an obstruction for a model class of regular sources. It does not describe the actual Möbius function, improve a Mertens bound, or constrain zeta zeros.

## 2. Mathematical Proof

### 2.1. Squarefree Density Lower Bound
By inclusion-exclusion on prime squares:
$$
\# \{ d \in (M, N] : \neg \text{Squarefree}(d) \} \le \sum_{2 \le k \le \sqrt{N}} \left( \frac{N - M}{k^2} + 1 \right) \le (N - M) \sum_{k=2}^\infty \frac{1}{k^2} + \sqrt{N}.
$$
Using the elementary partial fraction estimate $\sum_{k=2}^m 1/k^2 \le 3/4 - 1/m < 3/4$:
$$
\# \{ d \in (M, N] : \text{Squarefree}(d) \} \ge \frac{N - M}{4} - \sqrt{N}.
$$
Setting $M = N/2$, for $N \ge 256$, $\sqrt{N} \le N/16$, so the count exceeds $N/8 - N/16 = N/16$.

### 2.2. Functional Divergence at $r < 2/3$
Let $t \in \mathbb{N}$. Testing $T_{t^3}$ against 1-Lipschitz signed tent envelopes centered at $t^3/d$ for squarefree $d \in (t/2, t]$:
$$
\sum_{d \in (t/2, t]} \mu^2(d) \frac{t}{4} \ge \frac{t}{16} \cdot \frac{t}{4} = \frac{t^2}{64}.
$$
Since $N = t^3$, the normalized functional evaluates to:
$$
T_{t^3}(f) \asymp \frac{t^2}{(t^3)^r} = t^{2 - 3r}.
$$
For $r < 2/3$, $2 - 3r > 0$, so $t^{2 - 3r} \to \infty$ as $t \to \infty$. Thus $\|T_N\| \to \infty$.

### 2.3. Banach-Steinhaus Application
The space $\mathcal{X} = \{ (g, h) \in (c_b(\mathbb{N}))^2 : \sqrt{q+1}g(q+1) - \sqrt{q}g(q) = h(q) \}$ is a closed subspace of a Banach space, hence complete.
By the Banach-Steinhaus theorem, since $\{T_N\}$ is a family of continuous linear operators with $\sup_N \|T_N\| = \infty$, the set of $p \in \mathcal{X}$ for which $\sup_N |T_N(p)| = \infty$ is dense in $\mathcal{X}$. In particular, such a regular source exists.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.RegularSource` in `formalization/BuildingBlocks/RegularSource.lean`):
```lean
theorem reciprocal_square_sum_Icc_bound (m : ℕ) :
    (∑ k ∈ Finset.Icc 2 m, 1 / (k : ℝ) ^ 2) ≤ 3 / 4

theorem squarefree_terminal_half_lower {N : ℕ} (hN : 256 ≤ N) :
    (N : ℝ) / 16 ≤ ((squarefreeWindow (N / 2) N).card : ℝ)

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

## 4. Literature comparison and scope

- **Prior Literature:** Floor-sum asymptotics and smooth Möbius weights were
  compared with Tenenbaum (2015), the Hildebrand criterion, and the public
  formalization inventories listed in the audit ledger. That targeted search
  found no exact formalized fixed-source obstruction with the displayed
  square-root and Lipschitz hypotheses. The comparison is provisional and
  makes no endpoint or sharpness claim at $r=2/3$.
