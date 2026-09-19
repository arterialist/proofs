# Contribution 280: Exact All-Prime Seed $L^2$ Integrability and Three-Region Tail Splitting

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean), [`building-blocks/prime-seed/all-prime-square.md`](../../building-blocks/prime-seed/all-prime-square.md)  
**Classification:** Analytic Number Theory / Causal Prime Sources / Lévy Processes / $L^2$ Integrability / Harmonic Analysis / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the theory of arithmetic causal sources, the collective all-prime seed $\text{allPrimeSeed}(v) = \sum_{p \in \mathcal{P}} \text{seed}(\log p, v)$ sums over every prime without truncation, where each prime creates an exact floor cell of amplitude. Because the seed has infinite total integral $\int_0^\infty \text{allPrimeSeed}(v) dv = \infty$ (mirroring the divergence of $\sum 1/p$), its square-integrability is subtle and requires sharp cancellation.

This contribution proves:

1. **Unconditional $L^2(\mathbb{R})$ Integrability of the Complete All-Prime Seed:**  
   Without assuming the Riemann Hypothesis, zero-free regions, or the Prime Number Theorem:
   $$
   \int_\mathbb{R} \left( \sum_{p \in \mathcal{P}} \text{seed}(\log p, v) \right)^2 dv < \infty \quad \iff \quad \text{allPrimeSeed} \in L^2(\mathbb{R}).
   $$
2. **Pointwise Decay of the All-Prime Seed:**  
   For all ages $v \ge 3 \log 2$:
   $$
   v \cdot \text{allPrimeSeed}(v) \le 64 \log 2 + 30 \implies \text{allPrimeSeed}(v) = O(1/v).
   $$
3. **Three-Region Prime Tail Splitting:**  
   For any finite prime set $S$ and $v \ge 3 \log 2$, partitioning primes into:
   - Small primes $p \le e^{v/3}$: $\sum_{p \in A} \text{seed}(\log p, v) \le e^{-v/6}$.
   - Middle primes $e^{v/3} < p \le e^{v/2}$: $\sum_{p \in M} \text{seed}(\log p, v) \le 4 e^{-v/6}$, controlled by the cubic tail bound $\sum_{p > Z} p^{-3} \le 4/Z^2$.
   - Large primes $p > e^{v/2}$: $\sum_{p \in D} \text{seed}(\log p, v) \le \frac{64 \log 2}{v}$, controlled by the quadratic tail bound $\sum_{p > Z} p^{-2} \le \frac{32 \log 2}{Z \log Z}$.
   Yielding the universal non-asymptotic bound:
   $$
   \text{finitePrimeSeed}(S, v) \le \frac{64 \log 2}{v} + 5 e^{-v/6}.
   $$
4. **Finite Lévy Activity Integrability:**  
   The age-normalized profile is integrable:
   $$
   \int_\mathbb{R} \frac{\text{allPrimeSeed}(v)}{v} dv < \infty,
   $$
   derived from the finite total mass of the all-prime Lévy measure on $(0, \infty)$.
5. **Quadratic Majorization Principle:**  
   For all $v \ge 3 \log 2$:
   $$
   \text{allPrimeSeed}(v)^2 \le (64 \log 2 + 30) \frac{\text{allPrimeSeed}(v)}{v},
   $$
   converting the $L^1$ finiteness of the Lévy measure directly into $L^2$ finiteness of the seed.

---

## 2. Mathematical Proof

### 2.1. Three-Region Decomposition
Fix $v \ge 3 \log 2$ and partition primes $p \in S$:
1. **Small primes ($p \le e^{v/3}$):**  
   Each individual seed satisfies $\text{seed}(\log p, v) \le e^{-v/2}$. The number of primes $p \le Z = e^{v/3}$ is bounded trivially by $|A| \le Z = e^{v/3}$. Thus:
   $$
   \sum_{p \in A} \text{seed}(\log p, v) \le |A| e^{-v/2} \le e^{v/3} e^{-v/2} = e^{-v/6}.
   $$
2. **Middle primes ($e^{v/3} < p \le e^{v/2}$):**  
   In this range, $\text{seed}(\log p, v) \le e^{v/2} p^{-3}$.
   Using the cubic prime tail bound $\sum_{p > Z} p^{-3} \le 4/Z^2$ with $Z = e^{v/3}$:
   $$
   \sum_{p \in M} \text{seed}(\log p, v) \le e^{v/2} \frac{4}{(e^{v/3})^2} = 4 e^{v/2 - 2v/3} = 4 e^{-v/6}.
   $$
3. **Large primes ($p > e^{v/2}$):**  
   In this range, $\text{seed}(\log p, v) \le e^{v/2} p^{-2}$.
   Using the quadratic prime tail bound $\sum_{p > Y} p^{-2} \le \frac{32 \log 2}{Y \log Y}$ with $Y = e^{v/2}$:
   $$
   \sum_{p \in D} \text{seed}(\log p, v) \le e^{v/2} \frac{32 \log 2}{e^{v/2} (v/2)} = \frac{64 \log 2}{v}.
   $$
Summing the three regions gives $\text{finitePrimeSeed}(S, v) \le \frac{64 \log 2}{v} + 5 e^{-v/6}$.

### 2.2. Pointwise Age Bound
Multiplying by $v$:
$$
v \cdot \text{finitePrimeSeed}(S, v) \le 64 \log 2 + 5 v e^{-v/6}.
$$
Since $x e^{-x} \le 1$ for all $x \ge 0$, setting $x = v/6$ gives $v e^{-v/6} \le 6$.
Hence $5 v e^{-v/6} \le 30$, yielding $v \cdot \text{finitePrimeSeed}(S, v) \le 64 \log 2 + 30$.

### 2.3. $L^2$ Integrability
For $v \ge 3 \log 2$:
$$
\text{allPrimeSeed}(v)^2 = \text{allPrimeSeed}(v) \cdot \frac{v \cdot \text{allPrimeSeed}(v)}{v} \le (64 \log 2 + 30) \frac{\text{allPrimeSeed}(v)}{v}.
$$
Since $\int_0^\infty \frac{\text{allPrimeSeed}(v)}{v} dv < \infty$ by the finite total mass of the all-prime Lévy measure, the tail $\int_{3 \log 2}^\infty \text{allPrimeSeed}(v)^2 dv$ converges.
On $[0, 3 \log 2]$, only finitely many primes have $\log p \le 3 \log 2$, so the function is a finite sum of compactly supported $L^2$ profiles. Thus $\text{allPrimeSeed} \in L^2(\mathbb{R})$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean`):
```lean
theorem finite_seed_three_region_bound (S : Finset Nat.Primes) {v : ℝ} (hv : 3 * log 2 ≤ v) :
    finitePrimeSeed S v ≤ (64 * log 2) / v + 5 * exp (-v / 6)

theorem allPrimeSeed_age_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    v * allPrimeSeed v ≤ 64 * log 2 + 30

theorem integrable_allPrimeSeed_div_age : Integrable (fun v => allPrimeSeed v / v)

theorem allPrimeSeed_square_tail_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    allPrimeSeed v ^ 2 ≤ (64 * log 2 + 30) * (allPrimeSeed v / v)

theorem integrable_allPrimeSeed_square : Integrable (fun v => allPrimeSeed v ^ 2)

theorem allPrimeSeed_memLp_two : MemLp allPrimeSeed 2 volume
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Prime counting functions, Chebyshev bounds, and Poisson point processes of primes (Billingsley 1995, Tenenbaum 2015). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes non-asymptotic $L^2$ energy bounds on the complete prime seed without assuming PNT or RH, resolving the infinite first moment obstacle via Lévy measure majorization.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Proceedings of the American Mathematical Society*.
