# Zero-Charge Prime Packet Pair-Kernel Expansion and Far-Lag Dipole Decay

**Authors:** Arterialist Formalization Team  
**Date:** September 2026  
**Lean 4 Version:** 4.24.0  
**Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7` from `lake-manifest.json`
**Target Module:** `BuildingBlocks.ActualTerminalPrimeTraceFinite`  
**Foundational Axioms:** Standard Lean 4 foundations (`[propext, Classical.choice, Quot.sound]`), zero custom axioms, zero `sorry` placeholders.

---

## 1. Mathematical Overview

In the far-lag interaction of prime-power heat packets, the pairwise kernel between charges $a_i$ at positions $x_i > 0$ under a dilation parameter $k > 0$ is governed by the bilinear sum:
$$
 \mathcal{K}_k(a, x) := \sum_{i, j \in s} \frac{a_i a_j}{k x_j + x_i}.
$$
For a generic charge configuration, the expansion in inverse powers of $k$ as $k \to \infty$ begins with an $O(k^{-1})$ monopole term:
$$
 \frac{1}{k} \sum_{i, j \in s} a_i \frac{a_j}{x_j} = \frac{1}{k} \left( \sum_{i \in s} a_i \right) \left( \sum_{j \in s} \frac{a_j}{x_j} \right).
$$
When the total net charge vanishes, $\sum_{i \in s} a_i = 0$, this monopole term vanishes identically:
$$
 \sum_{i, j \in s} a_i \frac{a_j}{k x_j} = \frac{1}{k} \left(\sum_{i \in s} a_i\right) \left(\sum_{j \in s} \frac{a_j}{x_j}\right) = 0.
$$
The exact rational identity then isolates the next non-vanishing term, which is strictly of order $k^{-2}$:
$$
 \sum_{i, j \in s} \frac{a_i a_j}{k x_j + x_i} = -\frac{1}{k^2} \left(\sum_{i \in s} a_i x_i\right) \left(\sum_{j \in s} \frac{a_j}{x_j^2}\right) + \sum_{i, j \in s} \frac{a_i a_j x_i^2}{k^2 x_j^2 (k x_j + x_i)}.
$$
The first coefficient is the product of the discrete dipole moment $\sum a_i x_i$ and the inverse-square quadrupole moment $\sum a_j / x_j^2$, with an exact rational remainder that decays as $O(k^{-3})$.

This general theorem applies directly to the discrete centered prime-power packet with frozen terminal compensation:
- At integers $n \le N$, the charge is $c_n = \Lambda(n) - 1$.
- At the terminal label $n = N + 1$ (positioned at $x = N$), the compensating charge is $-(\psi(N) - N)$.
- The total charge satisfies $\sum_{n=1}^{N+1} c_n = 0$.
- Its Laplace heat transform exactly reproduces the discrete terminal-compensated source $\operatorname{finiteHeat}(N, t) - (\psi(N) - N) e^{-Nt}$.
- The pair kernel between prime-power charges under dilation $k$ has identically zero $k^{-1}$ monopole, guaranteeing far-lag dipole decay $O(k^{-2})$.

---

## 2. Formalization Details and Verified Signatures

### 2.1 General Zero-Charge Expansion (`ActualTerminalPrimeTraceFinite.lean`)

```lean
/-- A zero-charge finite source has no `k⁻¹` term in its complete pair kernel. -/
theorem zero_charge_pair_kernel_expansion {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (a x : ι → ℝ) (k : ℝ)
    (hk : 0 < k) (hx : ∀ i ∈ s, 0 < x i)
    (hzero : ∑ i ∈ s, a i = 0) :
    (∑ i ∈ s, ∑ j ∈ s, a i * a j / (k * x j + x i)) =
      -((∑ i ∈ s, a i * x i) * (∑ j ∈ s, a j / x j ^ 2)) / k ^ 2 +
        ∑ i ∈ s, ∑ j ∈ s,
          a i * a j * x i ^ 2 /
            (k ^ 2 * x j ^ 2 * (k * x j + x i))
```

### 2.2 Prime-Power Packet Definitions and Heat Equivalence

```lean
/-- Terminal weight is the actual prime error ψ(N) - N. -/
theorem packetError_eq_primeErrorReal (N : ℕ) :
    packetError N = BuildingBlocks.CoarsePrimitive.primeErrorReal (N : ℝ)

/-- Total packet charge vanishes identically. -/
theorem packetCoefficient_sum_zero (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 (N + 1), packetCoefficient N n) = 0

/-- Laplace transform matches discrete terminal heat source. -/
theorem packet_heat_eq_discrete_terminal (N : ℕ) (t : ℝ) :
    (∑ n ∈ Finset.Icc 1 (N + 1),
      packetCoefficient N n * Real.exp (-(packetPosition N n * t))) =
      BuildingBlocks.GoldbachHeat.finiteHeat
        BuildingBlocks.GoldbachHeat.centeredCoefficient N t -
        BuildingBlocks.CoarsePrimitive.primeErrorReal (N : ℝ) *
          Real.exp (-((N : ℝ) * t))
```

### 2.3 Inherited Prime Far-Lag Expansion

```lean
/-- The actual discrete centered prime packet inherits the exact far-lag kernel expansion. -/
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

---

## 3. Axiomatic Foundations and Verification

Verification performed via `lake env lean` in the proofs repository:
```bash
~/.elan/bin/lake env lean formalization/BuildingBlocks/ActualTerminalPrimeTraceFinite.lean
```
Axiom check output:
```
'BuildingBlocks.ActualTerminalPrimeTraceFinite.zero_charge_pair_kernel_expansion' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualTerminalPrimeTraceFinite.packetCoefficient_sum_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualTerminalPrimeTraceFinite.packetError_eq_primeErrorReal' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualTerminalPrimeTraceFinite.packet_heat_eq_discrete_terminal' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualTerminalPrimeTraceFinite.packet_pair_kernel_expansion' depends on axioms: [propext, Classical.choice, Quot.sound]
```
The proof is verified by Lean 4 with standard foundational axioms, zero custom axioms, and zero `sorry`.

---

## 4. Comparison with Formalized Literature

1. **Mathlib:** Mathlib contains no formalization of far-lag pair kernel expansions, multipole expansions of discrete charge distributions, or terminal compensation of Chebyshev prime-power sources.
2. **AFP / Coq:** No formal library contains asymptotic multipole cancellation for finite arithmetic charge configurations.
3. **Novelty:** Provisional priority claim: this may be an early machine-verified proof that the terminal compensation of the prime-power error $\psi(N) - N$ identically forces the $O(k^{-1})$ monopole term of the pair kernel $\sum \frac{c_i c_j}{k x_j + x_i}$ to vanish, yielding exact $O(k^{-2})$ dipole decay.
