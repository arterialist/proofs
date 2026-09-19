# Unique Contribution 172: Exact Factorial-Geometric Mertens Convolution and Quotient-Floor Square Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FactorialGeometricMertens.lean`](../../formalization/BuildingBlocks/FactorialGeometricMertens.lean), [`building-blocks/primes/factorial-geometric-mertens.md`](../../building-blocks/primes/factorial-geometric-mertens.md)  
**Classification:** Analytic Number Theory / Multiplicative Number Theory / Factorial Carry Oscillations / Mertens Function / Hyperbola Duality / Discrete Geometry

---

## 1. Executive Summary and Mathematical Statement

The study of arithmetic functions under exponential smoothing often introduces continuous integral transforms. In factorial binary carry oscillations, however, the response function admits an exact, purely discrete representation directly linked to the Mertens function through geometric weighting.

This contribution proves:

1. **Exact Finite Quotient Triangle Duality:**  
   For any arithmetic sequence $a(n)$, any real scale parameter $q$, and any positive integer $N$:
   \[
   \sum_{n=1}^N a(n) \sum_{j=0}^{\lfloor N/n \rfloor - 1} q^j = \sum_{j=0}^{N-1} q^j \sum_{n=1}^{\lfloor N/(j+1) \rfloor} a(n).
   \]
   This identity establishes an exact discrete duality across the hyperbolic lattice $n(j+1) \le N$ without continuous approximations.
2. **Quotient-Floor Repetition Multiplicity Bound:**  
   For any clock horizon $X$, scale index $j \ge 1$, and non-negative test sequence $f$:
   \[
   \sum_{N=1}^X f(\lfloor N/j \rfloor)^2 \le j \sum_{m=0}^X f(m)^2.
   \]
   Each quotient-floor value $m = \lfloor N/j \rfloor$ can repeat at most $j$ times on $[1, X]$, establishing an exact operator bound on quotient-floor sampling.
3. **Exact Geometric Mertens Representation of Factorial Carry Response:**  
   For the factorial binary carry response $R_N(t) = \sum_{n=1}^N \mu(n) (1 - e^{-(N/n)t})$, the function admits the exact finite identity for all $t \in \mathbb{R}$:
   \[
   R_N(t) = (1 - e^{-t}) \sum_{j=0}^{N-1} e^{-jt} M\left( \left\lfloor \frac{N}{j+1} \right\rfloor \right),
   \]
   where $M(x) = \sum_{n \le x} \mu(n)$ is the classical Mertens function.

---

## 2. Mathematical Proof

### 2.1. Quotient Triangle Duality
Notice the equivalence of conditions for positive integers $n$ and $j+1$:
\[
j+1 \le \lfloor N/n \rfloor \iff (j+1) n \le N \iff n \le \lfloor N/(j+1) \rfloor.
\]
Writing the double sum with an indicator:
\[
\sum_{n=1}^N a(n) \sum_{j < N/n} q^j = \sum_{n=1}^N \sum_{j=0}^{N-1} a(n) q^j \mathbf{1}_{(j+1)n \le N}.
\]
Exchanging the order of summation:
\[
\sum_{j=0}^{N-1} q^j \sum_{n=1}^N a(n) \mathbf{1}_{n \le \lfloor N/(j+1) \rfloor} = \sum_{j=0}^{N-1} q^j \sum_{n=1}^{\lfloor N/(j+1) \rfloor} a(n).
\]

### 2.2. Quotient-Floor Multiplicity Bound
Fiberwise grouping according to $m = \lfloor N/j \rfloor$:
\[
\sum_{N=1}^X f(\lfloor N/j \rfloor)^2 = \sum_{m=0}^X \left( \#\{ N \in [1, X] : \lfloor N/j \rfloor = m \} \right) f(m)^2.
\]
The condition $\lfloor N/j \rfloor = m$ implies $m j \le N < (m+1) j$.
The number of integers $N$ in $[mj, (m+1)j)$ is exactly $j$.
Therefore:
\[
\#\{ N \in [1, X] : \lfloor N/j \rfloor = m \} \le j.
\]
Substituting this upper bound yields $j \sum_{m=0}^X f(m)^2$.

### 2.3. Exact Geometric Representation
For each $m = \lfloor N/n \rfloor$, the finite geometric sum identity gives:
\[
1 - e^{-mt} = (1 - e^{-t}) \sum_{j=0}^{m-1} e^{-jt}.
\]
Setting $a(n) = \mu(n)$ and $q = e^{-t}$ in the quotient triangle duality:
\[
R_N(t) = \sum_{n=1}^N \mu(n) (1 - e^{-(N/n)t}) = (1 - e^{-t}) \sum_{n=1}^N \mu(n) \sum_{j=0}^{\lfloor N/n \rfloor - 1} e^{-jt}
\]
\[
= (1 - e^{-t}) \sum_{j=0}^{N-1} e^{-jt} \sum_{n=1}^{\lfloor N/(j+1) \rfloor} \mu(n) = (1 - e^{-t}) \sum_{j=0}^{N-1} e^{-jt} M\left( \left\lfloor \frac{N}{j+1} \right\rfloor \right).
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FactorialGeometricMertens` in `formalization/BuildingBlocks/FactorialGeometricMertens.lean`):
```lean
theorem quotient_triangle (N : ℕ) (a : ℕ → ℝ) (q : ℝ) :
    (∑ n ∈ Icc 1 N, a n * ∑ j ∈ range (N / n), q ^ j) =
      ∑ j ∈ range N, q ^ j * ∑ n ∈ Icc 1 (N / (j + 1)), a n

theorem quotient_floor_square_bound (X j : ℕ) (hj : 0 < j) (f : ℕ → ℝ) :
    (∑ N ∈ Icc 1 X, f (N / j) ^ 2) ≤
      (j : ℝ) * ∑ m ∈ range (X + 1), f m ^ 2

theorem response_geometric (N : ℕ) (t : ℝ) :
    FactorialBinaryCarry.response N t =
      (1 - Real.exp (-t)) * ∑ j ∈ range N,
        Real.exp (-t) ^ j * (BuildingBlocks.MertensTransfer.mertens (N / (j + 1)) : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet divisor problems and arithmetic sums with geometric weights (Vinogradov 1954, Montgomery 1971). Exact identities reducing exponential smoothing of arithmetic functions directly to geometric convolutions of the Mertens function have not previously been formalized in Lean 4.
- **Advancement:** Establishes the exact identity $R_N(t) = (1 - e^{-t})\sum_{j < N} e^{-jt} M(\lfloor N/(j+1) \rfloor)$ and the floor-multiplicity bound $\le j \sum f(m)^2$ in Lean 4.
- **Target Venues:** *Discrete Mathematics* or *Integers: Electronic Journal of Combinatorial Number Theory*.
