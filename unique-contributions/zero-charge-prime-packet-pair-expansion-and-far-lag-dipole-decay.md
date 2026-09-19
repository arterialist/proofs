# Contribution 52: Zero-Charge Prime Packet Pair-Kernel Expansion and Far-Lag Dipole Decay

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualTerminalPrimeTraceFinite.lean`](../../formalization/BuildingBlocks/ActualTerminalPrimeTraceFinite.lean), [`first-formalizations/zero-charge-prime-packet-pair-expansion.md`](../../first-formalizations/zero-charge-prime-packet-pair-expansion.md)  
**Classification:** Analytic Number Theory / Multipolar Expansions / Heat Kernels / Potential Theory

---

## 1. Executive Summary and Mathematical Statement

In the far-lag interaction of prime-power heat packets under a scale dilation parameter $k > 0$, the pair interaction kernel between discrete charges $a_i$ at positions $x_i > 0$ is governed by the bilinear sum:
$$
\mathcal{K}_k(a, x) := \sum_{i, j \in s} \frac{a_i a_j}{k x_j + x_i}.
$$
For a general charge configuration, as $k \to \infty$, the expansion begins with an $O(k^{-1})$ monopole term:
$$
\frac{1}{k} \left( \sum_{i \in s} a_i \right) \left( \sum_{j \in s} \frac{a_j}{x_j} \right).
$$
This contribution establishes:

1. **Universal Zero-Charge Monopole Cancellation:**  
   Whenever the total net charge vanishes, $\sum_{i \in s} a_i = 0$, the $O(k^{-1})$ monopole term vanishes identically:
   $$
   \sum_{i, j \in s} a_i \frac{a_j}{k x_j} = \frac{1}{k} \left( \sum_{i \in s} a_i \right) \left( \sum_{j \in s} \frac{a_j}{x_j} \right) = 0.
   $$
2. **Exact Algebraic Dipole-Quadrupole Expansion:**  
   The pairwise sum admits the exact algebraic decomposition:
   $$
   \sum_{i \in s} \sum_{j \in s} \frac{a_i a_j}{k x_j + x_i} = -\frac{1}{k^2} \left( \sum_{i \in s} a_i x_i \right) \left( \sum_{j \in s} \frac{a_j}{x_j^2} \right) + \sum_{i, j \in s} \frac{a_i a_j x_i^2}{k^2 x_j^2 (k x_j + x_i)}.
   $$
   The leading term is strictly $O(k^{-2})$, given by the product of the discrete dipole moment $\sum a_i x_i$ and the inverse-square moment $\sum a_j / x_j^2$, with an exact rational remainder that decays as $O(k^{-3})$.
3. **Application to Terminal-Compensated Prime Packets:**  
   For the centered prime-power source $c_n = \Lambda(n) - 1$ ($n \le N$) augmented by the frozen boundary compensation $c_{N+1} = -(\psi(N) - N)$ placed at position $x = N$:
   - The total packet charge vanishes identically: $\sum_{n=1}^{N+1} c_n = 0$.
   - The Laplace heat transform of this discrete packet matches the terminal-compensated source:
     $$
     \sum_{n=1}^{N+1} c_n e^{-x_n t} = \sum_{n=1}^N (\Lambda(n) - 1) e^{-nt} - (\psi(N) - N) e^{-Nt}.
     $$
   - The pair interaction kernel between prime-power charges exhibits **unconditional far-lag dipole decay $O(k^{-2})$**, eliminating long-range monopole divergence.

---

## 2. Mathematical Proof

### 2.1. Exact Rational Partial Fractions
For any $k, x_i, x_j > 0$:
$$
\frac{1}{k x_j + x_i} = \frac{1}{k x_j} - \frac{x_i}{k^2 x_j^2} + \frac{x_i^2}{k^2 x_j^2 (k x_j + x_i)}.
$$
Multiplying by $a_i a_j$ and summing over all $i, j \in s$:
1. The first sum factors as:
   $$
   \sum_{i, j \in s} \frac{a_i a_j}{k x_j} = \frac{1}{k} \left( \sum_{i \in s} a_i \right) \left( \sum_{j \in s} \frac{a_j}{x_j} \right) = \frac{1}{k} \cdot 0 \cdot \sum_{j \in s} \frac{a_j}{x_j} = 0.
   $$
2. The second sum factors as:
   $$
   -\sum_{i, j \in s} \frac{(a_i x_i) (a_j / x_j^2)}{k^2} = -\frac{1}{k^2} \left( \sum_{i \in s} a_i x_i \right) \left( \sum_{j \in s} \frac{a_j}{x_j^2} \right).
   $$
3. The third sum is the exact remainder:
   $$
   \sum_{i, j \in s} \frac{a_i a_j x_i^2}{k^2 x_j^2 (k x_j + x_i)}.
   $$

### 2.2. Terminal Prime Packet Verification
The discrete packet error is $\operatorname{packetError}(N) = \sum_{n=1}^N (\Lambda(n) - 1) = \psi(N) - N$.  
Setting $c_n = \Lambda(n) - 1$ for $n \le N$ and $c_{N+1} = -(\psi(N) - N)$, the sum over $n \in \{1, \dots, N+1\}$ is:
$$
\sum_{n=1}^{N+1} c_n = (\psi(N) - N) - (\psi(N) - N) = 0.
$$
Thus, the zero-charge condition is satisfied identically for all $N \ge 1$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualTerminalPrimeTraceFinite`):
```lean
theorem zero_charge_pair_kernel_expansion {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (a x : ι → ℝ) (k : ℝ)
    (hk : 0 < k) (hx : ∀ i ∈ s, 0 < x i)
    (hzero : ∑ i ∈ s, a i = 0) :
    (∑ i ∈ s, ∑ j ∈ s, a i * a j / (k * x j + x i)) =
      -((∑ i ∈ s, a i * x i) * (∑ j ∈ s, a j / x j ^ 2)) / k ^ 2 +
        ∑ i ∈ s, ∑ j ∈ s,
          a i * a j * x i ^ 2 /
            (k ^ 2 * x j ^ 2 * (k * x j + x i))

theorem packetCoefficient_sum_zero (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 (N + 1), packetCoefficient N n) = 0

theorem packet_heat_eq_discrete_terminal (N : ℕ) (t : ℝ) :
    (∑ n ∈ Finset.Icc 1 (N + 1),
      packetCoefficient N n * Real.exp (-(packetPosition N n * t))) =
      BuildingBlocks.GoldbachHeat.finiteHeat
        BuildingBlocks.GoldbachHeat.centeredCoefficient N t -
        BuildingBlocks.CoarsePrimitive.primeErrorReal (N : ℝ) *
          Real.exp (-((N : ℝ) * t))

theorem packet_pair_kernel_expansion (N : ℕ) (hN : 1 ≤ N)
    (k : ℝ) (hk : 0 < k) :
    (∑ i ∈ Finset.Icc 1 (N + 1),
      ∑ j ∈ Finset.Icc 1 (N + 1),
        packetCoefficient N i * packetCoefficient N j /
          (k * packetPosition N j + packetPosition N i)) =
      -((∑ i ∈ Finset.Icc 1 (N + 1),
          packetCoefficient N i * packetPosition N i) *
        (∑ j ∈ Finset.Icc 1 (N + 1),
          packetCoefficient N j / packetPosition N j ^ 2)) / k ^ 2 +
        ∑ i ∈ Finset.Icc 1 (N + 1),
          ∑ j ∈ Finset.Icc 1 (N + 1),
            packetCoefficient N i * packetCoefficient N j *
              packetPosition N i ^ 2 /
              (k ^ 2 * packetPosition N j ^ 2 *
                (k * packetPosition N j + packetPosition N i))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Multipolar expansions are classical in electrostatics and potential theory. However, the exact discrete multipole decomposition applied to the arithmetic prime-power discrepancy packet $(\Lambda(n) - 1)$ with terminal Chebyshev compensation is novel.
- **Advancement:** Establishes the exact algebraic identity proving far-lag dipole decay $O(k^{-2})$ of prime discrepancy packets under dilation without approximations.
- **Target Venues:** *Advances in Applied Mathematics* or *Journal of Mathematical Analysis and Applications*.
