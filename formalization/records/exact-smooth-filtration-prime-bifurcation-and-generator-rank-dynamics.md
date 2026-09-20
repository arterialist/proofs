# Contribution 313: Exact Smooth Filtration Prime Bifurcation and Generator Rank Dynamics

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/Model.lean`](../../formalization/BuildingBlocks/Model.lean), [`building-blocks/smooth-filtration/model.md`](../../building-blocks/smooth-filtration/model.md)  
**Classification:** Number Theory / Dynamical Systems / Smooth Numbers / Prime Event Filtering / Monoid Filtrations / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the algebraic modeling of prime generation as a discrete dynamical filtration, the state $\text{before}(n)$ represents the multiplicative submonoid of positive integers whose prime factors are strictly smaller than $n$ ($\text{smoothNumbers}(n)$). A central structural question is characterizing exactly when the filtration grows and how its free generator rank evolves.

This contribution proves:

1. **Exact Prime Bifurcation of State Transitions:**  
   The filtration undergoes a strict transition at step $n$ if and only if $n$ is prime:
   $$
   \text{before}(n+1) \ne \text{before}(n) \iff n \text{ is prime}.
   $$
   Similarly, an integer $n \in \mathbb{N}_{\ge 1}$ is absent from its own prior state if and only if it is prime:
   $$
   n \notin \text{before}(n) \iff n \text{ is prime}.
   $$
2. **Canonical Monoid Isomorphism at Prime Steps:**  
   At every prime $p$, the state at step $p+1$ decomposes canonically into the direct product of the non-negative integers (representing powers of $p$) and the prior state:
   $$
   \mathbb{N} \times \text{before}(p) \simeq \text{before}(p+1), \qquad (k, m) \mapsto p^k m.
   $$
3. **Exact Indicator Dynamics of Generator Rank:**  
   The number of active prime generators $\text{generatorRank}(n) = |\{p < n : p \text{ is prime}\}|$ satisfies the exact difference equation:
   $$
   \text{generatorRank}(n+1) = \text{generatorRank}(n) + \mathbf{1}_{\text{Prime}}(n).
   $$
4. **Information Preservation Under Forward Embeddings:**  
   For any $n \le k$, the natural inclusion map:
   $$
   \text{retain}(n \le k) : \text{before}(n) \hookrightarrow \text{before}(k)
   $$
   is strictly injective, establishing that forward discrete time steps lose no prime factor information.
5. **Divisor and Monoid Closure:**  
   Each stage $\text{before}(n)$ is multiplicatively closed ($a, b \in \text{before}(n) \implies ab \in \text{before}(n)$) and divisor-hereditary ($a \in \text{before}(n), b \mid a \implies b \in \text{before}(n)$).

---

## 2. Mathematical Proof

### 2.1. State Change Characterization
1. **If $n$ is not prime:**  
   By `Nat.smoothNumbers_succ`, every prime divisor $p \mid m$ satisfying $p < n + 1$ must satisfy $p \le n$. Since $n$ is composite or 0/1, $p \ne n$, hence $p < n$. Thus $\text{before}(n+1) = \text{before}(n)$.
2. **If $n$ is prime:**  
   $n$ has prime factor $n$, so $n \notin \text{before}(n)$ (since $n < n$ is false).
   However, $n \in \text{before}(n+1)$ because all its prime factors equal $n < n+1$.
   Therefore $\text{before}(n+1) \ne \text{before}(n)$.

### 2.2. Prime Step Equivalence
By the Fundamental Theorem of Arithmetic (unique prime factorization), every positive integer $m \in \text{before}(p+1)$ factors uniquely as $m = p^k \cdot m'$, where $p \nmid m'$.
Since all prime factors of $m$ are $< p + 1$, all prime factors of $m'$ are $< p+1$ and $\ne p$, which implies they are strictly $< p$.
Thus $m' \in \text{before}(p)$, establishing the bijection $\mathbb{N} \times \text{before}(p) \simeq \text{before}(p+1)$.

### 2.3. Generator Rank Update
The set of primes below $n+1$ is $\{p < n+1 : p \text{ prime}\}$.
If $n$ is prime, this set is $\{p < n : p \text{ prime}\} \cup \{n\}$, so the cardinality increments by 1.
If $n$ is not prime, the set is unchanged, so the cardinality increments by 0.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/Model.lean`):
```lean
theorem new_generator_iff_prime {n : ℕ} (hn : 0 < n) :
    n ∉ before n ↔ n.Prime

theorem state_changes_iff_prime (n : ℕ) :
    before (n + 1) ≠ before n ↔ n.Prime

def prime_step_equiv {p : ℕ} (hp : p.Prime) :
    ℕ × before p ≃ before (p + 1)

theorem generatorRank_succ (n : ℕ) :
    generatorRank (n + 1) = generatorRank n + if n.Prime then 1 else 0

theorem retain_injective {n k : ℕ} (h : n ≤ k) :
    Function.Injective (retain h)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** De Bruijn (1951) *On the number of positive integers $\le x$ and free of prime factors $> y$*; Hildebrand & Tenenbaum (1993) *Integers without large prime factors*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes an exact dynamical systems and filtration perspective on prime generation with machine-certified rank dynamics and monoid product decomposition.
- **Target Venues:** *Integers* or *Journal of Integer Sequences*.
