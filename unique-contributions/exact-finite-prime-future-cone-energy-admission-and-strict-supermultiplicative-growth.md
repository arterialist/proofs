# Unique Contribution 325: Exact Finite Prime Future-Cone Energy Admission and Strict Supermultiplicative Growth

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FinitePrimeFutureConeEnergy.lean`](../../formalization/BuildingBlocks/FinitePrimeFutureConeEnergy.lean), [`building-blocks/prime-future-cone/finite-energy.md`](../../building-blocks/prime-future-cone/finite-energy.md)  
**Classification:** Analytic Number Theory / Hilbert Space Geometry / Beurling-Nyman Systems / Prime Adjunction / Energy Growth / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

A central question in constructing Hilbert spaces with prime future cones and proving the non-degeneracy of squarefree divisor cubes is controlling the energy $\mathcal{E}(S) = \sum_{m < \prod_{q \in S} q} (\text{cubePrefix}(S, m))^2$ as fresh primes are adjoined.

This contribution proves:

1. **Exact Prime Adjunction Difference Identity:**  
   For any finite set of primes $S$ and fresh prime $p \notin S$:
   \[
   \text{cubePrefix}(S \cup \{p\}, m) = \text{cubePrefix}(S, m) - \text{cubePrefix}(S, \lfloor m/p \rfloor).
   \]
2. **Exact Dilated Reverse Triangle Inequality:**  
   For any vectors $f$ and $g$ satisfying $\|g\|^2 = p \|f\|^2$:
   \[
   (\sqrt{p} - 1)^2 \|f\|^2 \le \|f - g\|^2.
   \]
3. **Exact Dilated Energy Scaling:**  
   For any history $F$ on length $N$:
   \[
   \sum_{m=0}^{p N - 1} F(\lfloor m/p \rfloor)^2 = p \sum_{n=0}^{N-1} F(n)^2.
   \]
4. **Exact Energy Lower Bound Under Prime Adjunction:**  
   For any nonempty finite set of primes $S$ and fresh prime $p \notin S$:
   \[
   (\sqrt{p} - 1)^2 \mathcal{E}(S) \le \mathcal{E}(S \cup \{p\}).
   \]
5. **Strict Energy Growth for Primes $p \ge 5$:**  
   Since $p \ge 5 \implies \sqrt{p} \ge \sqrt{5} > 2 \implies (\sqrt{p} - 1)^2 > 1$, adjoining any prime $p \ge 5$ strictly increases the completed energy:
   \[
   \mathcal{E}(S) < \mathcal{E}(S \cup \{p\}) \qquad (\forall p \ge 5, p \notin S).
   \]

---

## 2. Mathematical Proof

### 2.1. Cube Prefix Split
Every subset $T \subseteq S \cup \{p\}$ either does not contain $p$ ($T \subseteq S$) or contains $p$ ($T = T' \cup \{p\}$ with $T' \subseteq S$).
The subsets without $p$ contribute $\text{cubePrefix}(S, m)$.
The subsets containing $p$ have cardinality $|T'| + 1$ (introducing a minus sign) and product $p \prod_{q \in T'} q$.
The condition $p \prod_{q \in T'} q \le m$ is equivalent to $\prod_{q \in T'} q \le \lfloor m/p \rfloor$.
Thus their sum is $-\text{cubePrefix}(S, \lfloor m/p \rfloor)$.

### 2.2. Reverse Triangle
By Cauchy-Schwarz, $\sum f_i g_i \le \|f\| \|g\| = \sqrt{p} \|f\|^2$.
Expanding $\|f - g\|^2 = \|f\|^2 + \|g\|^2 - 2 \sum f_i g_i \ge (1 + p - 2 \sqrt{p}) \|f\|^2 = (\sqrt{p} - 1)^2 \|f\|^2$.

### 2.3. Strictly Increasing Energy
For $p \ge 5$, $(\sqrt{p} - 1)^2 \ge (\sqrt{5} - 1)^2 = 6 - 2\sqrt{5} = 6 - \sqrt{20} > 6 - 4.48 = 1.52 > 1$.
Since $\mathcal{E}(S) > 0$ for any nonempty prime set $S$ (as $\text{cubePrefix}(S, 1) = 1$), strict inequality follows:
$\mathcal{E}(S) < (\sqrt{p}-1)^2 \mathcal{E}(S) \le \mathcal{E}(S \cup \{p\})$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FinitePrimeFutureConeEnergy` in `formalization/BuildingBlocks/FinitePrimeFutureConeEnergy.lean`):
```lean
theorem cubePrefix_insert (S : Finset ℕ) (p m : ℕ)
    (hp : 0 < p) (hps : p ∉ S) :
    cubePrefix (insert p S) m = cubePrefix S m - cubePrefix S (m / p)

theorem finite_energy_reverse_triangle {ι : Type*} (s : Finset ι)
    (f g : ι → ℝ) (p : ℕ)
    (hg : (∑ i ∈ s, g i ^ 2) = (p : ℝ) * ∑ i ∈ s, f i ^ 2) :
    (Real.sqrt (p : ℝ) - 1) ^ 2 * (∑ i ∈ s, f i ^ 2) ≤
      ∑ i ∈ s, (f i - g i) ^ 2

theorem dilated_energy (p N : ℕ) (hp : 0 < p) (F : ℕ → ℝ) :
    (∑ m ∈ Finset.range (p * N), (F (m / p)) ^ 2) =
      (p : ℝ) * ∑ m ∈ Finset.range N, (F m) ^ 2

theorem cubeEnergy_insert (S : Finset ℕ) (hS : S.Nonempty)
    (hprime : ∀ q ∈ S, Nat.Prime q) (p : ℕ)
    (hp : Nat.Prime p) (hps : p ∉ S) :
    (Real.sqrt (p : ℝ) - 1) ^ 2 * cubeEnergy S ≤
      cubeEnergy (insert p S)

theorem cubeEnergy_insert_strict (S : Finset ℕ) (hS : S.Nonempty)
    (hprime : ∀ q ∈ S, Nat.Prime q) (p : ℕ)
    (hp : Nat.Prime p) (hps : p ∉ S) (hp5 : 5 ≤ p) :
    cubeEnergy S < cubeEnergy (insert p S)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Beurling (1955) *A closure problem related to the Riemann Zeta-function*; Nyman (1950) *On the one-dimensional translation group*; Bagchi (2006) *On the Nyman-Beurling criterion for the Riemann hypothesis*. Machine verification of finite prime future cone energy growth and strict increase for $p \ge 5$ in Lean 4 is new.
- **Advancement:** Establishes the exact supermultiplicative energy factor $(\sqrt{p}-1)^2$ under prime adjunction in finite squarefree cubes, guaranteeing strict divergence of prime-cone energies.
- **Target Venues:** *Journal of Functional Analysis* or *Proceedings of the AMS*.
