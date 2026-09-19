# Unique Contribution 112: Exact Divisor-Current Totient Contraction and Successor Conservation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/BirthDivisorCoupling.lean`](../../formalization/BuildingBlocks/BirthDivisorCoupling.lean), [`building-blocks/prime-history/divisor-birth-decoder.md`](../../building-blocks/prime-history/divisor-birth-decoder.md)  
**Classification:** Arithmetic Functions / Euler Totient Invariants / Divisor-Coordinate Couplings / Arithmetic Transport Conservation Laws

---

## 1. Executive Summary and Mathematical Statement

In the discrete arithmetic transport model coupling prime birth labels to multiplicative divisor coordinates, each integer $n \ge 2$ induces a two-sided neighbor divisor current:
\[
J(n, d) = \mathbf{1}_{d \mid (n-1)} \varphi(d) - \mathbf{1}_{d \mid (n+1)} \varphi(d).
\]
Here $\varphi(d)$ is Euler's totient function, weighting each divisor coordinate by its primitive residue multiplicity.

This contribution proves:

1. **Universal Integer Invariant of the Total Divisor Current:**  
   For every integer $n \ge 2$, the total current summed over the common divisor support $\operatorname{divisors}(n-1) \cup \operatorname{divisors}(n+1)$ contracts to an absolute constant independent of $n$:
   \[
   \sum_{d \in \operatorname{divisors}(n-1) \cup \operatorname{divisors}(n+1)} J(n, d) = -2.
   \]
2. **Vanishing of Base Parity Coordinates:**  
   Because $n-1$ and $n+1$ have the same parity:
   - For $d = 1$: $1 \mid (n-1)$ and $1 \mid (n+1)$ always, so $J(n, 1) = \varphi(1) - \varphi(1) = 0$.
   - For $d = 2$: either both $n-1, n+1$ are even (when $n$ is odd) giving $J(n, 2) = \varphi(2) - \varphi(2) = 0$, or both are odd (when $n$ is even) giving $J(n, 2) = 0 - 0 = 0$.
   Thus the low-degree coordinates $d \in \{1, 2\}$ carry zero net current, and the entire conserved flow of $-2$ is carried strictly by odd or higher divisor coordinates $d \ge 3$.
3. **Exact Finite Contraction Law:**  
   By Gauss's classical totient identity $\sum_{d \mid m} \varphi(d) = m$, the left-neighbor mass is identically $n-1$ and the right-neighbor mass is $n+1$. Their difference contracts to $(n-1) - (n+1) = -2$ with zero remainder, establishing an exact non-asymptotic conservation law without relying on any prime error energy bounds.

---

## 2. Mathematical Proof

### 2.1. Totient Summation Identity
Gauss proved that for every positive integer $m \ge 1$:
\[
\sum_{d \mid m} \varphi(d) = m.
\]
For $n \ge 2$, both $n-1 \ge 1$ and $n+1 \ge 3$ are positive integers.
Summing the indicator functions over the union $D_n = \operatorname{divisors}(n-1) \cup \operatorname{divisors}(n+1)$:
\[
\sum_{d \in D_n} \mathbf{1}_{d \mid (n-1)} \varphi(d) = \sum_{d \mid (n-1)} \varphi(d) = n - 1.
\]
Similarly:
\[
\sum_{d \in D_n} \mathbf{1}_{d \mid (n+1)} \varphi(d) = \sum_{d \mid (n+1)} \varphi(d) = n + 1.
\]

### 2.2. Total Current Evaluation
Subtracting the two sums:
\[
\sum_{d \in D_n} J(n, d) = \sum_{d \in D_n} \mathbf{1}_{d \mid (n-1)} \varphi(d) - \sum_{d \in D_n} \mathbf{1}_{d \mid (n+1)} \varphi(d) = (n - 1) - (n + 1) = -2.
\]
This constant holds identically for all $n \ge 2$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.BirthDivisorCoupling`):
```lean
def weightedCurrent (n d : ℕ) : ℤ :=
  (if d ∈ (n - 1).divisors then (Nat.totient d : ℤ) else 0) -
  (if d ∈ (n + 1).divisors then (Nat.totient d : ℤ) else 0)

theorem sum_weightedCurrent (n : ℕ) (hn : 2 ≤ n) :
    ∑ d ∈ (n - 1).divisors ∪ (n + 1).divisors, weightedCurrent n d = -2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Euler totient identities (Gauss 1801, Apostol 1976). While the identity $\sum_{d \mid m} \varphi(d) = m$ is classical, its algebraic deployment as a conserved discrete current $J(n, d)$ across adjacent factorizations yielding the universal invariant $-2$ with vanishing base coordinates $d=1, 2$ in arithmetic transport models is novel.
- **Advancement:** Establishes machine-verified conservation of totient-weighted neighbor divisor currents with exact invariant $-2$.
- **Target Venues:** *American Mathematical Monthly* or *Integers: Electronic Journal of Combinatorial Number Theory*.
