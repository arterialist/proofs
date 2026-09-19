# Unique Contribution 131: Exact Zero-Charge Pair Kernel Expansion and Terminal Prime Trace

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualTerminalPrimeTraceFinite.lean`](../../formalization/BuildingBlocks/ActualTerminalPrimeTraceFinite.lean), [`building-blocks/heat-flow/actual-terminal-prime-trace-finite.md`](../../building-blocks/heat-flow/actual-terminal-prime-trace-finite.md)  
**Classification:** Analytic Number Theory / Prime Trace Packets / Heat Kernel Flows / Zero-Charge Cancellation / Far-Lag Asymptotics

---

## 1. Executive Summary and Mathematical Statement

In the trace formula and heat kernel formulation of prime distributions, the centered prime packet truncated at $N$ has non-vanishing net charge equal to the Chebyshev error $\psi(N) - N$. Appending a terminal compensation atom $-(\psi(N) - N)$ creates a discrete zero-charge source distribution on $\mathbb{R}_{>0}$. In the pair-interaction kernel with dilation parameter $k > 0$:
\[
K_k(x, y) = \frac{1}{k y + x},
\]
an arbitrary finite source has a leading $k^{-1}$ singularity as $k \to \infty$.

This contribution proves:

1. **Exact Zero-Charge Singularity Cancellation:**  
   For any finite set $s$ of sources $a_i$ at positive positions $x_i > 0$ with exact zero net charge $\sum_{i \in s} a_i = 0$, the $k^{-1}$ leading term vanishes identically:
   \[
   \sum_{i \in s} \sum_{j \in s} \frac{a_i a_j}{k x_j + x_i} = -\frac{1}{k^2} \left( \sum_{i \in s} a_i x_i \right) \left( \sum_{j \in s} \frac{a_j}{x_j^2} \right) + \sum_{i \in s} \sum_{j \in s} \frac{a_i a_j x_i^2}{k^2 x_j^2 (k x_j + x_i)}.
   \]
2. **Identification of Truncated Net Charge with Chebyshev Error:**  
   For the centered discrete prime coefficients $c(n) = \Lambda(n) - 1$:
   \[
   \sum_{n=1}^N c(n) = \psi(N) - N.
   \]
3. **Exact Zero Net Charge of Terminal-Compensated Packet:**  
   Defining $c_N(n) = c(n)$ for $n \le N$ and $c_N(N+1) = -(\psi(N) - N)$ at position $x_{N+1} = N$:
   \[
   \sum_{n=1}^{N+1} c_N(n) = 0.
   \]
4. **Exact Discrete Terminal Heat Transform:**  
   For all $t \in \mathbb{R}$:
   \[
   \sum_{n=1}^{N+1} c_N(n) e^{-x_n t} = \sum_{n=1}^N (\Lambda(n) - 1) e^{-n t} - (\psi(N) - N) e^{-N t}.
   \]
5. **Universal Far-Lag Pair Kernel Expansion for Terminal Prime Packets:**  
   The terminal-compensated prime packet satisfies the exact zero-charge expansion, eliminating the $k^{-1}$ leading term and giving an explicit $O(k^{-3})$ rational remainder.

---

## 2. Mathematical Proof

### 2.1. Algebraic Decomposition of Kernel Entries
For each pair of sources $(i, j)$:
\[
\frac{1}{k x_j + x_i} = \frac{1}{k x_j} \left( 1 - \frac{x_i}{k x_j + x_i} \right) = \frac{1}{k x_j} - \frac{x_i}{k^2 x_j^2} + \frac{x_i^2}{k^2 x_j^2 (k x_j + x_i)}.
\]
Multiplying by $a_i a_j$:
\[
\frac{a_i a_j}{k x_j + x_i} = a_i \frac{a_j}{k x_j} - \frac{(a_i x_i)(a_j / x_j^2)}{k^2} + \frac{a_i a_j x_i^2}{k^2 x_j^2 (k x_j + x_i)}.
\]

### 2.2. Zero-Charge Vanishing of Leading Singularity
Summing the first term over all $i, j \in s$:
\[
\sum_{i \in s} \sum_{j \in s} a_i \frac{a_j}{k x_j} = \left( \sum_{i \in s} a_i \right) \left( \sum_{j \in s} \frac{a_j}{k x_j} \right) = 0 \cdot \sum_{j \in s} \frac{a_j}{k x_j} = 0,
\]
due strictly to the zero-charge condition $\sum_{i \in s} a_i = 0$.

### 2.3. Quadratic Coefficient Factorization
Summing the second term over $i, j \in s$:
\[
\sum_{i \in s} \sum_{j \in s} \frac{(a_i x_i)(a_j / x_j^2)}{k^2} = \frac{1}{k^2} \left( \sum_{i \in s} a_i x_i \right) \left( \sum_{j \in s} \frac{a_j}{x_j^2} \right),
\]
which factors completely into the first dipole moment $\sum a_i x_i$ times the inverse-square charge $\sum a_j / x_j^2$.

### 2.4. Terminal Prime Packet Compensation
The prefix sum evaluates to:
\[
\sum_{n=1}^N (\Lambda(n) - 1) = \sum_{n=1}^N \Lambda(n) - \sum_{n=1}^N 1 = \psi(N) - N.
\]
Adding the $(N+1)$-th atom with weight $-(\psi(N) - N)$ yields a sum of zero, verifying the exact applicability of the algebraic expansion.

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

theorem packetError_eq_primeErrorReal (N : ℕ) :
    packetError N = BuildingBlocks.CoarsePrimitive.primeErrorReal (N : ℝ)

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

- **Prior Literature:** Multipole expansions and kernel asymptotics in electrostatics and potential theory (Kellogg 1929, Greengard-Rokhlin 1987). The machine formalization of exact zero-charge leading singularity cancellation and terminal prime-power error compensation in Lean 4 is novel.
- **Advancement:** Establishes machine-verified exact cancellation of the $k^{-1}$ divergence for terminal-compensated prime packets.
- **Target Venues:** *Journal of Number Theory* or *Journal of Mathematical Analysis and Applications*.
