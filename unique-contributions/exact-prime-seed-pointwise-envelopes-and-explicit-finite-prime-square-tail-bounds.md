# Contribution 185: Exact Prime Seed Pointwise Envelopes and Explicit Finite-Prime Square Tail Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedPointwise.lean`](../../formalization/BuildingBlocks/PrimeSeedPointwise.lean), [`building-blocks/primes/prime-seed-pointwise.md`](../../building-blocks/primes/prime-seed-pointwise.md)  
**Classification:** Analytic Number Theory / Sieve Methods / Prime Envelopes / Dyadic Decomposition / Explicit Bounds / Prime Zeta Tails

---

## 1. Executive Summary and Mathematical Statement

Pointwise and tail bounds for the continuous prime successor seed $\text{seed}_L(v)$ across all clock intervals provide the uniform decay estimates required for the convergence of full-infinite-prime renewal operators. Establishing explicit constants without relying on asymptotic notation $\mathcal{O}(\cdot)$ or unverified hypotheses is essential for certified interval verification.

This contribution proves:

1. **Uniform Pointwise Global Upper Envelope:**  
   For every clock $L > 0$ and all $v \in \mathbb{R}$:
   $$
   \text{seed}_L(v) \le e^{-v/2}.
   $$
   The strict floor inequality $v < (\lfloor v/L \rfloor + 1)L$ controls all proper-power histories simultaneously.
2. **Exact Piecewise Clock Envelopes:**  
   For any prime $p > 1$ and evaluation point $v$:
   - On the primary interval $v < 2 \log p$: $\text{seed}_{\log p}(v) \le \frac{e^{v/2}}{p^2}$.
   - On the secondary interval $2 \log p \le v < 3 \log p$: $\text{seed}_{\log p}(v) = \frac{e^{v/2}}{p^3}$.
3. **Explicit Dyadic Prime Shell Bounds:**  
   For any dyadic prime shell $S \subseteq [N, 2N]$ with $N \ge 1$:
   $$
   \sum_{p \in S} \frac{\log p}{p^2} \le \frac{8 \log 2}{N}.
   $$
   Summing across all dyadic shells $2^{j+K}$ yields the exact geometric tail:
   $$
   \sum_{p \ge 2^K} \frac{\log p}{p^2} \le \frac{16 \log 2}{2^K}.
   $$
4. **Explicit Continuous Threshold Tail Bounds:**  
   For any real threshold $Y \ge 2$ and ANY finite set of primes $S$ strictly greater than $Y$ ($p > Y$):
   $$
   \sum_{p \in S} \frac{\log p}{p^2} \le \frac{32 \log 2}{Y},
   $$
   and consequently:
   $$
   \sum_{p \in S} \frac{1}{p^2} \le \frac{32 \log 2}{Y \log Y}.
   $$
   No primes above $Y$ are discarded, and the bound is entirely effective with absolute constant $32 \log 2 \approx 22.18$.

---

## 2. Mathematical Proof

### 2.1. Global Upper Envelope
If $v < L$, $\text{seed}_L(v) = 0 \le e^{-v/2}$.
If $v \ge L$, by the definition of the floor function, $v/L < \lfloor v/L \rfloor + 1$, hence $v < (\lfloor v/L \rfloor + 1)L$.
Thus $v/2 - (\lfloor v/L \rfloor + 1)L < v/2 - v = -v/2$.
Monotonicity of the exponential yields $\text{seed}_L(v) \le e^{-v/2}$.

### 2.2. Dyadic Shell Summation
On any set of primes $S \subseteq [N, 2N]$, each prime satisfies $p \ge N$, so $\frac{\log p}{p^2} \le \frac{\log p}{N^2}$.
Thus $\sum_{p \in S} \frac{\log p}{p^2} \le \frac{1}{N^2} \sum_{p \in S} \log p$.
Since $\sum_{p \le 2N} \log p \le \psi(2N) \le (4 \log 2)(2N) = 8 (\log 2) N$ by the Chebyshev linear bound:
$$
\sum_{p \in S} \frac{\log p}{p^2} \le \frac{8 (\log 2) N}{N^2} = \frac{8 \log 2}{N}.
$$

### 2.3. Dyadic Partition Sum
For $N = 2^k$, the shell bound is $\frac{8 \log 2}{2^k}$.
Summing over all scales $k = K + j$ for $j \ge 0$:
$$
\sum_{j=0}^\infty \frac{8 \log 2}{2^{K+j}} = \frac{8 \log 2}{2^K} \sum_{j=0}^\infty 2^{-j} = \frac{16 \log 2}{2^K}.
$$
For any real $Y \ge 2$, let $N = \lfloor Y \rfloor$ and $K = \lfloor \log_2 N \rfloor$.
Then $2^K \le N \le Y \le 2^{K+1}$, so $2^K \ge Y/2$.
Substituting into the dyadic bound gives $\frac{16 \log 2}{Y/2} = \frac{32 \log 2}{Y}$.
Dividing by $\log Y$ gives the unweighted square tail $\sum_{p \in S} \frac{1}{p^2} \le \frac{32 \log 2}{Y \log Y}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedPointwise.lean`):
```lean
theorem seed_le_exp_neg_half {L : ℝ} (hL : 0 < L) (v : ℝ) :
    seed L v ≤ exp (-v / 2)

theorem prime_seed_first_envelope {p v : ℝ} (hp : 1 < p) (hv : v < 2 * log p) :
    seed (log p) v ≤ exp (v / 2) / p ^ 2

theorem prime_seed_second_envelope {p v : ℝ} (hp : 1 < p)
    (hlo : 2 * log p ≤ v) (hhi : v < 3 * log p) :
    seed (log p) v = exp (v / 2) / p ^ 3

theorem finite_prime_log_square_tail (S : Finset Nat.Primes) {Y : ℝ} (hY : 2 ≤ Y)
    (hlo : ∀ p ∈ S, Y < (p : ℝ)) :
    (∑ p ∈ S, log (p : ℝ) / (p : ℝ) ^ 2) ≤ (32 * log 2) / Y

theorem finite_prime_square_tail (S : Finset Nat.Primes) {Y : ℝ} (hY : 2 ≤ Y)
    (hlo : ∀ p ∈ S, Y < (p : ℝ)) :
    (∑ p ∈ S, 1 / (p : ℝ) ^ 2) ≤ (32 * log 2) / (Y * log Y)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Explicit bounds on prime reciprocal sums and Chebyshev function estimates (Rosser-Schoenfeld 1962, Dusart 2018). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes pointwise envelopes $\text{seed}_L(v) \le e^{-v/2}$ and proves explicit finite tail bounds $\sum_{p \in S} \frac{1}{p^2} \le \frac{32 \log 2}{Y \log Y}$ in Lean 4.
- **Target Venues:** *Mathematics of Computation* or *Acta Arithmetica*.
