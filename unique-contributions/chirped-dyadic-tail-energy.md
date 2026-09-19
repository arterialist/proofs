# Chirped Dyadic Tail Energy Summation and Fourth-Power Asymptotic Vanishing

**Authors:** Arterialist RH Research Team  
**Date:** September 2026  
**Primary Lean Module:** [`formalization/BuildingBlocks/ChirpedDyadicTailEnergy.lean`](../formalization/BuildingBlocks/ChirpedDyadicTailEnergy.lean)  
**Verification Status:** Fully machine-checked in Lean 4 (0 errors, 0 warnings, zero `sorry`, foundational axioms `[propext, Classical.choice, Quot.sound]`).

---

### Abstract

We establish the **Chirped Dyadic Tail Energy Summation and Fourth-Power Asymptotic Vanishing Theorem**, completing the analysis of the non-resonant spectral tail under chirped wavepacket interrogation.

In earlier modules, second-order integration by parts demonstrated that each non-resonant zero with frequency separation $\Delta(\gamma) = |\gamma| - T$ contributes spectral energy bounded by $O(\Delta(\gamma)^{-4})$. Here, we decompose the high-frequency non-resonant regime $|\gamma| \ge 2T$ into dyadic frequency shells:
$$I_m := [2^m T, 2^{m+1} T), \quad m \ge 1$$
In each shell $m$, the frequency distance to the carrier satisfies $\Delta(\gamma) \ge 2^{m-1} T$, yielding pointwise fourth-power decay bounded by:
$$E_{\text{pointwise}}(m, T) \le \frac{16 C_{\text{IBP2}}^2}{16^m T^4}$$
Convolving this bound with the Riemann–von Mangoldt zero counting density $N(2^{m+1} T) - N(2^m T) \le C_{\text{dens}} 2^{m+1} T (m+2) \log T$ yields the shell energy upper bound:
$$E_{\text{shell}}(m, T) \le 32 C_{\text{IBP2}}^2 C_{\text{dens}} \frac{\log T}{T^3} \cdot \frac{m+2}{8^m}$$

We prove that the arithmetic-geometric factor sequence satisfies $(m+3) \le 3 \cdot 2^m$, which bounds each shell factor geometrically by $\frac{3}{8} (1/4)^m$. Consequently, the finite geometric sum satisfies:
$$\sum_{m=1}^M \frac{m+2}{8^m} \le \frac{1}{2} \le 1$$
for all shell depths $M \in \mathbb{N}$.

Summing across all dyadic shells, the high-frequency tail energy is uniformly bounded by:
$$E_{\text{tail}}(M, T) \le 16 C_{\text{IBP2}}^2 C_{\text{dens}} \frac{\log T}{T^3} \le \frac{16 C_{\text{IBP2}}^2 C_{\text{dens}}}{T^2}$$
As the carrier scale $T \to +\infty$, this tail envelope vanishes identically:
$$\lim_{T \to +\infty} 16 C_{\text{IBP2}}^2 C_{\text{dens}} \frac{\log T}{T^3} = 0$$

This establishes that the high-frequency non-resonant spectral tail does not merely contribute a bounded $O(1)$ constant, but actively decays to zero as $O(T^{-3} \log T) \to 0$.

---

### 1. Mathematical Formulation

#### 1.1 Dyadic Shell Partition and Distance
For $m \ge 1$ and carrier frequency $T > 0$, the $m$-th dyadic high-frequency shell is the interval $I_m = [2^m T, 2^{m+1} T)$. Any zero $\rho = \beta + i\gamma$ with $\gamma \in I_m$ satisfies:
$$\Delta(\gamma) = \gamma - T \ge 2^m T - T = (2^m - 1) T \ge 2^{m-1} T$$
The individual spectral quadrature energy contribution is bounded by:
$$E_{\text{pointwise}}(m, T) := \frac{16 C_{\text{IBP2}}^2}{(2^{m-1} T)^4} = \frac{16 C_{\text{IBP2}}^2}{16^m T^4}$$

#### 1.2 Riemann–von Mangoldt Zero Counting
By the Riemann–von Mangoldt formula, the number of non-trivial zeros in the shell $I_m$ is bounded by:
$$N(2^{m+1} T) - N(2^m T) \le C_{\text{dens}} 2^{m+1} T \log(2^{m+1} T)$$
For $T \ge 2$, $\log(2^{m+1} T) = (m+1)\log 2 + \log T \le (m+2)\log T$. Hence:
$$N_{\text{shell}}(m, T) \le C_{\text{dens}} 2^{m+1} T (m+2) \log T$$

#### 1.3 Shell Product Factorization
Multiplying the pointwise decay by the zero count:
$$E_{\text{pointwise}}(m, T) \cdot N_{\text{shell}}(m, T) = \frac{16 C_{\text{IBP2}}^2}{16^m T^4} \cdot C_{\text{dens}} 2^{m+1} T (m+2) \log T$$
Using $16^m = 2^m \cdot 8^m$ and $2^{m+1} = 2^m \cdot 2$, the factor $2^m$ cancels, yielding:
$$E_{\text{shell}}(m, T) = 32 C_{\text{IBP2}}^2 C_{\text{dens}} \frac{\log T}{T^3} \cdot \frac{m+2}{8^m}$$

In Lean 4, this algebraic identity is machine-verified:
```lean
theorem shell_energy_product_eq (C_IBP2 C_dens T : ℝ) (m : ℕ) (hT : T ≠ 0) :
    shellPointwiseDecay C_IBP2 m T * shellZeroCount C_dens m T =
    shellEnergyBound C_IBP2 C_dens m T
```

---

### 2. Geometric Domination and Summation

#### 2.1 Arithmetic-Geometric Dominance
To evaluate the shell factor $g(m) = \frac{m+2}{8^m}$, we index from $m = 0$:
$$g(m+1) = \frac{m+3}{8^{m+1}} = \frac{m+3}{8 \cdot 2^m \cdot 4^m}$$
We prove by induction in Presburger arithmetic that for all $m \in \mathbb{N}$:
$$m + 3 \le 3 \cdot 2^m$$
Consequently:
$$g(m+1) \le \frac{3 \cdot 2^m}{8 \cdot 2^m \cdot 4^m} = \frac{3}{8} \left(\frac{1}{4}\right)^m$$

In Lean 4:
```lean
theorem nat_shell_index_le_three_pow_two (m : ℕ) :
    m + 3 ≤ 3 * 2^m

theorem geometric_shell_factor_le_quarter (m : ℕ) :
    geometricShellFactor (m + 1) ≤ (3 / 8) * ((1 / 4 : ℝ)^m)
```

#### 2.2 Finite Sum Bound
For the geometric series $\sum_{m=0}^{M-1} (1/4)^m$:
$$\sum_{m=0}^{M-1} \left(\frac{1}{4}\right)^m = \frac{4}{3} \left(1 - \left(\frac{1}{4}\right)^M\right) \le \frac{4}{3}$$
Multiplying by $3/8$:
$$\sum_{m=0}^{M-1} g(m+1) \le \frac{3}{8} \cdot \frac{4}{3} = \frac{1}{2} \le 1$$

In Lean 4:
```lean
theorem sum_quarter_pow_eq (M : ℕ) :
    ∑ m ∈ Finset.range M, ((1 / 4 : ℝ)^m) = 4 / 3 - (4 / 3) * ((1 / 4 : ℝ)^M)

theorem sum_geometric_shell_factor_le_half (M : ℕ) :
    ∑ m ∈ Finset.range M, geometricShellFactor (m + 1) ≤ 1 / 2

theorem sum_geometric_shell_factor_le_one (M : ℕ) :
    ∑ m ∈ Finset.range M, geometricShellFactor (m + 1) ≤ 1
```

---

### 3. Master Tail Energy Theorem and Asymptotic Vanishing

#### 3.1 Master Tail Energy Bound
Summing over any number of shells $M$:
$$E_{\text{tail}}(M, T) = \sum_{m=0}^{M-1} E_{\text{shell}}(m+1, T) \le 32 C_{\text{IBP2}}^2 C_{\text{dens}} \frac{\log T}{T^3} \cdot \frac{1}{2} = 16 C_{\text{IBP2}}^2 C_{\text{dens}} \frac{\log T}{T^3}$$

In Lean 4:
```lean
theorem finite_dyadic_tail_le_master
    (C_IBP2 C_dens : ℝ) (M : ℕ) (T : ℝ)
    (_hC1 : 0 ≤ C_IBP2) (hC2 : 0 ≤ C_dens) (hT : 1 ≤ T) :
    finiteDyadicTailEnergy C_IBP2 C_dens M T ≤
    16 * C_IBP2^2 * C_dens * (Real.log T / T^3)
```

#### 3.2 Asymptotic Vanishing
For all $T \ge 1$, the logarithm is bounded linearly: $\log T \le T - 1 \le T$. Therefore:
$$\frac{\log T}{T^3} \le \frac{T}{T^3} = \frac{1}{T^2}$$
Since $1/T^2 \to 0$ as $T \to +\infty$, the squeeze theorem yields:
$$\lim_{T \to +\infty} \frac{\log T}{T^3} = 0$$
and for any real constants $C_{\text{IBP2}}, C_{\text{dens}}$:
$$\lim_{T \to +\infty} 16 C_{\text{IBP2}}^2 C_{\text{dens}} \frac{\log T}{T^3} = 0$$

In Lean 4:
```lean
theorem log_div_pow_three_le (T : ℝ) (hT : 1 ≤ T) :
    Real.log T / T^3 ≤ 1 / T^2

theorem tendsto_log_div_pow_three_atTop :
    Tendsto (fun T : ℝ => Real.log T / T^3) atTop (nhds 0)

theorem tendsto_tail_envelope_atTop (C_IBP2 C_dens : ℝ) :
    Tendsto (fun T : ℝ => 16 * C_IBP2^2 * C_dens * (Real.log T / T^3)) atTop (nhds 0)
```

---

### 4. Verification and Axiom Profile

The module compiles with zero errors, zero warnings, and zero `sorry` placeholders. All results depend exclusively on the standard foundational axioms of Lean 4:
- `propext`
- `Classical.choice`
- `Quot.sound`
