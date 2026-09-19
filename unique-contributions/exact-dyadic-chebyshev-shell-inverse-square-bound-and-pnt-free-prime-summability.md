# Unique Contribution 199: Exact Dyadic Chebyshev Shell Inverse-Square Bound and PNT-Free Prime Summability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedActivityBound.lean`](../../formalization/BuildingBlocks/PrimeSeedActivityBound.lean), [`building-blocks/primes/prime-seed-activity-bound.md`](../../building-blocks/primes/prime-seed-activity-bound.md)  
**Classification:** Analytic Number Theory / Chebyshev Shell Methods / Dyadic Partitioning / Basel Majorization / PNT Independence / Prime Series Convergence

---

## 1. Executive Summary and Mathematical Statement

In analytic number theory, the convergence of the reciprocal sum $\sum_{p} \frac{1}{p \log p} < \infty$ is conventionally proved using the Prime Number Theorem (PNT), which requires complex analysis and zero-free regions of the Riemann zeta function. In constructive foundations of arithmetic renewal processes, it is essential that the finite activity of the prime jump measure be established without circularity—that is, purely from elementary Chebyshev bounds without presupposing PNT, RH, or asymptotic prime densities.

This contribution proves:

1. **Chebyshev Majorization of Prime Logarithm Sums:**  
   For any subset of primes $S \subseteq [1, M]$:
   \[
   \sum_{p \in S} \log p \le \psi(M).
   \]
2. **Pointwise Logarithmic Weight Inequality:**  
   For all real numbers $1 < x \le y$:
   \[
   \frac{1}{y \log y} \le \frac{\log y}{x \log^2 x}.
   \]
3. **Inverse-Square Logarithmic Shell Bound:**  
   For any dyadic prime shell $S \subseteq [N, 2N]$ with $N \ge 2$:
   \[
   \sum_{p \in S} \frac{1}{p \log p} \le \frac{8 \log 2}{\log^2 N}.
   \]
   The linear factor $N$ from Chebyshev's bound $\psi(2N) \le 8 N \log 2$ cancels the linear denominator $N$ exactly, producing an inverse-square logarithmic decay $\log^{-2} N$.
4. **Dyadic Logarithmic Fibers:**  
   Partitioning the primes into fibers $\text{logFiber}(k) = \{ p \in \mathcal{P} : \lfloor \log_2 p \rfloor = k \}$, each fiber is finite and bounded by $2^k \le p < 2^{k+1}$. For each $k \ge 1$:
   \[
   \sum_{p \in \text{logFiber}(k)} \frac{1}{p \log p} \le \frac{8}{\log 2} \cdot \frac{1}{k^2}.
   \]
5. **Unconditional Basel Convergence (PNT-Free):**  
   Summing across all fibers $k \ge 1$, the prime series is majorized by the convergent Basel series $\sum_{k=1}^\infty \frac{1}{k^2}$:
   \[
   \sum_{p \in \mathcal{P}} \frac{1}{p \log p} \le \frac{8}{\log 2} \sum_{k=1}^\infty \frac{1}{k^2} < \infty.
   \]
   This establishes the finite total activity of the prime renewal Lévy measure unconditionally, completely independent of PNT or RH.

---

## 2. Mathematical Proof

### 2.1. Chebyshev Bound on Prime Shells
On $S \subseteq [N, 2N]$, each $p \in S$ satisfies $p \ge N$.
By the weight inequality, $\frac{1}{p \log p} \le \frac{\log p}{N \log^2 N}$.
Summing over $p \in S$:
\[
\sum_{p \in S} \frac{1}{p \log p} \le \frac{\sum_{p \in S} \log p}{N \log^2 N} \le \frac{\psi(2N)}{N \log^2 N}.
\]
Using Chebyshev's elementary upper bound $\psi(2N) \le 4(\log 2)(2N) = 8 N \log 2$:
\[
\sum_{p \in S} \frac{1}{p \log p} \le \frac{8 N \log 2}{N \log^2 N} = \frac{8 \log 2}{\log^2 N}.
\]

### 2.2. Dyadic Shells and Basel Majorization
Setting $N = 2^k$, we have $\log(2^k) = k \log 2$.
Thus:
\[
\frac{8 \log 2}{\log^2(2^k)} = \frac{8 \log 2}{k^2 \log^2 2} = \frac{8}{\log 2} \cdot \frac{1}{k^2}.
\]
Since $\sum_{k=1}^\infty \frac{1}{k^2} = \frac{\pi^2}{6} < \infty$, the comparison test yields convergence of the full sum over all primes:
\[
\sum_{p \in \mathcal{P}} \frac{1}{p \log p} = \sum_{k=1}^\infty \sum_{p \in \text{logFiber}(k)} \frac{1}{p \log p} < \infty.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedActivityBound.lean`):
```lean
theorem sum_log_primes_le_psi (S : Finset ℕ) (M : ℕ)
    (hprime : ∀ p ∈ S, p.Prime) (hM : ∀ p ∈ S, p ≤ M) :
    (∑ p ∈ S, log (p : ℝ)) ≤ BuildingBlocks.CoarsePrimitive.psi M

theorem prime_shell_activity_le (S : Finset ℕ) (N : ℕ) (hN : 2 ≤ N)
    (hprime : ∀ p ∈ S, p.Prime)
    (hlo : ∀ p ∈ S, N ≤ p) (hhi : ∀ p ∈ S, p ≤ 2 * N) :
    (∑ p ∈ S, 1 / ((p : ℝ) * log p)) ≤ 8 * log 2 / log (N : ℝ) ^ 2

theorem finite_logFiber (k : ℕ) : (logFiber k).Finite

theorem logFiber_weight_le {k : ℕ} (hk : 1 ≤ k) :
    (∑' p : logFiber k, 1 / ((p.val : ℝ) * log p.val)) ≤
      (8 / log 2) * (1 / (k : ℝ) ^ 2)

theorem summable_prime_reciprocal_mul_log :
    Summable (fun p : Nat.Primes => 1 / ((p : ℝ) * log p))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Summability of $\sum \frac{1}{p \log p}$ is standard in analytic number theory (Hardy-Wright 1979, Tenenbaum 1995), but typically deduced from Mertens' theorem or PNT. The explicit dyadic inverse-square shell bound formalization without PNT in Lean 4 is new.
- **Advancement:** Formalizes the non-circular proof that Chebyshev's linear bound $\psi(M) \le C M$ implies $\sum_{p \in [N, 2N]} \frac{1}{p \log p} \le \frac{8 \log 2}{\log^2 N}$ and establishes Basel majorization in Lean 4.
- **Target Venues:** *American Mathematical Monthly* or *Journal of Number Theory*.
