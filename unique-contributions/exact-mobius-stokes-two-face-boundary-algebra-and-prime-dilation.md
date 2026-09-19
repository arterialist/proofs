# Unique Contribution 298: Exact Möbius–Stokes Two-Face Boundary Algebra and Prime Dilation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/MobiusStokesFiniteBoundary.lean`](../../formalization/BuildingBlocks/MobiusStokesFiniteBoundary.lean), [`building-blocks/mertens-transfer/mobius-stokes-boundary.md`](../../building-blocks/mertens-transfer/mobius-stokes-boundary.md)  
**Classification:** Analytic Number Theory / Mertens Function / Discrete Stokes Formula / Prime Dilation / Boundary Algebra / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the discrete geometry of arithmetic functions, the cancellation of the Mertens sum $M(N) = \sum_{n \le N} \mu(n)$ over an interval $(D, N]$ can be viewed as an arithmetic Stokes theorem. When dilated by a prime factor $p$, the bulk mass on $(D, N]$ splits into primitive multiples $p \cdot m$ (where $p \nmid m$) and square-divisible terms (which vanish identically).

This contribution proves:

1. **Exact Möbius–Stokes Two-Face Boundary Identity:**  
   For any prime $p$ and any integers $D \le N$:
   \[
   \sum_{d \in (D, N]} \mu(d) = \sum_{\substack{m \in (\max(D, \lfloor N/p \rfloor), N] \\ p \nmid m}} \mu(m) - \sum_{\substack{m \in (\lfloor D/p \rfloor, \min(D, \lfloor N/p \rfloor)] \\ p \nmid m}} \mu(m).
   \]
   This demonstrates that the internal bulk cancels completely, reducing the entire interval sum to two discrete boundary faces consisting exclusively of $p$-coprime integers.
2. **Unconditional Prime Dilation Splitting:**  
   The bulk mass decomposes as the difference of non-divisible faces at the original scale and the floor-scaled range:
   \[
   \text{bulkMass}(D, N) = \text{notDvdFace}(p, D, N) - \text{notDvdFace}(p, \lfloor D/p \rfloor, \lfloor N/p \rfloor).
   \]
3. **Exact Primitive Bijection and Sign Inversion:**  
   The map $d \mapsto d/p$ is a bijection between primitive multiples $\{d \in (D, N] : p \mid d, p^2 \nmid d\}$ and cofactors $\{m \in (\lfloor D/p \rfloor, \lfloor N/p \rfloor] : p \nmid m\}$, satisfying $\mu(d) = -\mu(d/p)$.
4. **Complete Elimination of Square-Divisible Terms:**  
   For any prime $p$, if $p \mid d$ and $p \mid (d/p)$, then $\mu(d) = 0$, so no higher-order multiples survive.
5. **Finite Stokes Observed Identity (Observation Prefix):**  
   For any coefficient sequence $F$ and observation parameter $q$:
   \[
   (1 - q) \sum_{i=0}^n F_{i+1} q^i = (1 - q)^2 \sum_{i=0}^{n-1} C_{i+1} q^i + (1 - q) C_{n+1} q^n,
   \]
   where $C_A = \sum_{j=1}^A F_j$.

---

## 2. Mathematical Proof

### 2.1. Partition of the Interval by Divisibility
Split $(D, N]$ into integers coprime to $p$ and multiples of $p$:
\[
\sum_{d \in (D, N]} \mu(d) = \sum_{\substack{d \in (D, N] \\ p \nmid d}} \mu(d) + \sum_{\substack{d \in (D, N] \\ p \mid d, p^2 \nmid d}} \mu(d) + \sum_{\substack{d \in (D, N] \\ p^2 \mid d}} \mu(d).
\]
The third sum vanishes identically because $\mu$ is supported on squarefree integers.
For the second sum, every $d$ can be written uniquely as $d = p m$ with $m \in (\lfloor D/p \rfloor, \lfloor N/p \rfloor]$ and $p \nmid m$.
By multiplicativity, $\mu(p m) = \mu(p)\mu(m) = -\mu(m)$. Thus:
\[
\sum_{d \in (D, N]} \mu(d) = \text{notDvdFace}(p, D, N) - \text{notDvdFace}(p, \lfloor D/p \rfloor, \lfloor N/p \rfloor).
\]

### 2.2. Overlap Cancellation and Boundary Reduction
Expressing each face via the prefix sum $S(X) = \sum_{m \le X, p \nmid m} \mu(m)$:
\[
\text{notDvdFace}(p, D, N) = S(N) - S(D),
\]
\[
\text{notDvdFace}(p, \lfloor D/p \rfloor, \lfloor N/p \rfloor) = S(\lfloor N/p \rfloor) - S(\lfloor D/p \rfloor).
\]
Subtracting the two:
\[
(S(N) - S(D)) - (S(\lfloor N/p \rfloor) - S(\lfloor D/p \rfloor)) = (S(N) - S(\max(D, \lfloor N/p \rfloor))) - (S(\min(D, \lfloor N/p \rfloor)) - S(\lfloor D/p \rfloor)).
\]
Converting back to interval sums yields the exact two-face identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.MobiusStokesFiniteBoundary` in `formalization/BuildingBlocks/MobiusStokesFiniteBoundary.lean`):
```lean
theorem primitive_multiples_reindex {p D N : ℕ} (hp : p.Prime) :
    (∑ d ∈ primitiveMultiples p D N, ArithmeticFunction.moebius d) =
      -(∑ m ∈ primitiveCofactors p D N, ArithmeticFunction.moebius m)

theorem bulkMass_prime_split {p D N : ℕ} (hp : p.Prime) :
    bulkMass D N = notDvdFace p D N - notDvdFace p (D / p) (N / p)

theorem notDvd_interval_two_face {p D N : ℕ} (hDN : D ≤ N) :
    notDvdFace p D N - notDvdFace p (D / p) (N / p) =
      notDvdFace p (Nat.max D (N / p)) N -
        notDvdFace p (D / p) (Nat.min D (N / p))

theorem prime_dilation_two_face {p D N : ℕ} (hp : p.Prime) (hDN : D ≤ N) :
    bulkMass D N =
      notDvdFace p (Nat.max D (N / p)) N -
        notDvdFace p (D / p) (Nat.min D (N / p))

theorem finite_stokes_observed (F : ℕ → R) (q : R) (n : ℕ) :
    (1 - q) * futurePrefix F (n + 1) q =
      (1 - q) ^ 2 * (∑ i ∈ Finset.range n, charge F (i + 1) * q ^ i) +
        (1 - q) * charge F (n + 1) * q ^ n
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Axer (1910) Tauberian theorems and floor identities; Delange (1954); Vaughan (1977) identity; Heath-Brown (1982) identity. Machine verification of the exact discrete two-face boundary cancellation and prime dilation algebra in Lean 4 is new.
- **Advancement:** Establishes a purely combinatorial, non-asymptotic Stokes boundary formula for the Möbius function under prime dilations, showing that bulk interior sums reduce strictly to two isolated boundary faces of $p$-coprime elements.
- **Target Venues:** *Discrete Mathematics* or *Journal of Number Theory*.
