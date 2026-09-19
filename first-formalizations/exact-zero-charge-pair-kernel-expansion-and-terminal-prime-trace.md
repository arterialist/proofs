# First Formalization: Exact Zero-Charge Pair Kernel Expansion and Terminal Prime Trace

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualTerminalPrimeTraceFinite.lean`](../../formalization/BuildingBlocks/ActualTerminalPrimeTraceFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact zero-charge leading singularity cancellation in bilinear pair kernels, the identification of centered prefix charge with Chebyshev error $\psi(N) - N$, the terminal compensation identity, the discrete terminal heat transform, and the universal far-lag kernel expansion in Lean 4:

1. **Zero-Charge Kernel Cancellation:**
   Formal proof that the $k^{-1}$ term vanishes identically when $\sum a_i = 0$, giving an explicit $-k^{-2}$ leading dipole term and exact rational remainder (`zero_charge_pair_kernel_expansion`).
2. **Chebyshev Error Identity:**
   Formal derivation of $\sum_{n=1}^N (\Lambda(n) - 1) = \psi(N) - N$ (`packetError_eq_primeErrorReal`).
3. **Net Charge Cancellation of Terminal-Compensated Packet:**
   Formal proof that appending the terminal atom $-(\psi(N) - N)$ yields total charge zero (`packetCoefficient_sum_zero`).
4. **Discrete Terminal Heat Transform:**
   Formal evaluation of the Laplace transform of the terminal packet as the truncated heat transform minus the terminal error correction (`packet_heat_eq_discrete_terminal`).
5. **Universal Prime Packet Far-Lag Expansion:**
   Formal derivation of the complete far-lag pair kernel expansion for discrete prime packets (`packet_pair_kernel_expansion`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Zero-charge pair kernel expansion
theorem zero_charge_pair_kernel_expansion {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (a x : ι → ℝ) (k : ℝ)
    (hk : 0 < k) (hx : ∀ i ∈ s, 0 < x i)
    (hzero : ∑ i ∈ s, a i = 0) :
    (∑ i ∈ s, ∑ j ∈ s, a i * a j / (k * x j + x i)) =
      -((∑ i ∈ s, a i * x i) * (∑ j ∈ s, a j / x j ^ 2)) / k ^ 2 +
        ∑ i ∈ s, ∑ j ∈ s,
          a i * a j * x i ^ 2 /
            (k ^ 2 * x j ^ 2 * (k * x j + x i))

-- Centered prefix error equals Chebyshev error
theorem packetError_eq_primeErrorReal (N : ℕ) :
    packetError N = BuildingBlocks.CoarsePrimitive.primeErrorReal (N : ℝ)

-- Zero charge of terminal-compensated packet
theorem packetCoefficient_sum_zero (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 (N + 1), packetCoefficient N n) = 0

-- Terminal packet Laplace/heat transform
theorem packet_heat_eq_discrete_terminal (N : ℕ) (t : ℝ) :
    (∑ n ∈ Finset.Icc 1 (N + 1),
      packetCoefficient N n * Real.exp (-(packetPosition N n * t))) =
      BuildingBlocks.GoldbachHeat.finiteHeat
        BuildingBlocks.GoldbachHeat.centeredCoefficient N t -
        BuildingBlocks.CoarsePrimitive.primeErrorReal (N : ℝ) *
          Real.exp (-((N : ℝ) * t))

-- Full far-lag pair kernel expansion for terminal prime packets
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

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving exact zero-charge singularity cancellation in pair-interaction kernels and the discrete terminal compensation of Chebyshev prime-power fluctuations.
