# Contribution 135: Exact Compact Prime-Error Heat Flow and Laplace Endpoint Duality

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCompactHeatEndpoint.lean`](../../formalization/BuildingBlocks/ActualCompactHeatEndpoint.lean), [`building-blocks/heat-flow/actual-compact-heat-endpoint.md`](../../building-blocks/heat-flow/actual-compact-heat-endpoint.md)  
**Classification:** Analytic Number Theory / Chebyshev Prime Error / Heat Kernel Flow / Laplace Transform / Endpoint Regularization / Zero Net Charge

---

## 1. Executive Summary and Mathematical Statement

In the diffusion and heat kernel approach to the distribution of prime numbers, the discrete heat packet of von Mangoldt arrivals exhibits an asymptotic drift and non-vanishing charge at $t = 0$. By incorporating the continuous density background $\int_1^N e^{-xt} dx$, the initial density boundary atom $e^{-t}$, and a frozen terminal compensation atom $(\psi(N) - N) e^{-Nt}$, one forms the compact prime-error heat source:
$$
H_N(t) = \sum_{n=2}^N \Lambda(n) e^{-n t} - \int_1^N e^{-x t} dx - e^{-t} - (\psi(N) - N) e^{-N t}.
$$

This contribution proves:

1. **Exact Duality with Chebyshev Error Laplace Transform:**  
   For any integer truncation $N \ge 1$ and all real $t \in \mathbb{R}$:
   $$
   H_N(t) = t \int_1^N (\psi(x) - x) e^{-x t} dx.
   $$
2. **Universal Zero Total Net Charge:**  
   At zero temperature / zero diffusion frequency ($t = 0$), the total charge vanishes identically:
   $$
   H_N(0) = 0 \quad \text{for all } N \ge 1.
   $$
3. **Exact Comparison with Discrete Goldbach Packet:**  
   $$
   H_N(t) = \mathcal{H}_{\text{Goldbach}}(N, t) + \Delta_{\text{density}}(N, t) - (\psi(N) - N) e^{-N t},
   $$
   where $\Delta_{\text{density}}(N, t) = \sum_{n=2}^N e^{-nt} - \int_1^N e^{-xt} dx$ is the exact Riemann sum discretization error of the continuous density.
4. **Source Minus Terminal Decomposition:**  
   $$
   H_N(t) = S_N(t) - (\psi(N) - N) e^{-N t},
   $$
   establishing that the compact packet is the exact difference between the unbounded finite heat source and the terminal boundary compensation.

---

## 2. Mathematical Proof

### 2.1. Integration by Parts Identity
Let $E(x) = \psi(x) - x$ be the Chebyshev error function on $[1, N]$.
The derivative of the heat kernel factor is $\frac{d}{dx} e^{-xt} = -t e^{-xt}$.
By the Riemann-Stieltjes / Lebesgue integration by parts theorem for jump functions:
$$
\int_1^N E(x) (-t e^{-xt}) dx = \left[ E(x) e^{-xt} \right]_1^N - \int_1^N e^{-xt} dE(x).
$$
Evaluating the boundary terms:
$$
E(N) e^{-Nt} - E(1) e^{-t} = (\psi(N) - N) e^{-Nt} - (\psi(1) - 1) e^{-t} = (\psi(N) - N) e^{-Nt} - (0 - 1) e^{-t} = (\psi(N) - N) e^{-Nt} + e^{-t}.
$$
Evaluating the jump measure: $dE(x) = d\psi(x) - dx = \sum_{n=2}^N \Lambda(n) \delta_n(x) - dx$.
Thus:
$$
\int_1^N e^{-xt} dE(x) = \sum_{n=2}^N \Lambda(n) e^{-nt} - \int_1^N e^{-xt} dx.
$$
Rearranging:
$$
-t \int_1^N E(x) e^{-xt} dx = (\psi(N) - N) e^{-Nt} + e^{-t} - \left( \sum_{n=2}^N \Lambda(n) e^{-nt} - \int_1^N e^{-xt} dx \right) = -H_N(t).
$$
Multiplying by $-1$ gives $H_N(t) = t \int_1^N (\psi(x) - x) e^{-xt} dx$.

### 2.2. Zero Total Net Charge
Setting $t = 0$ in the integral formula:
$$
H_N(0) = 0 \cdot \int_1^N (\psi(x) - x) \cdot 1 \, dx = 0.
$$
This proves that the net charge of the compact packet vanishes identically, without requiring any asymptotic hypothesis or limit $N \to \infty$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCompactHeatEndpoint`):
```lean
theorem compactHeat_eq_goldbach_packet (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    compactHeat N t =
      GoldbachHeat.finiteHeat GoldbachHeat.centeredCoefficient N t +
        densityCellCorrection N t -
          BuildingBlocks.CoarsePrimitive.primeErrorReal N * exp (-(N : ℝ) * t)

theorem compactHeat_eq_source_sub_terminal (N : ℕ) (t : ℝ) :
    compactHeat N t =
      ActualFiniteHeatSource.source N t -
        BuildingBlocks.CoarsePrimitive.primeErrorReal N * exp (-(N : ℝ) * t)

theorem compactHeat_eq_error_integral (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    compactHeat N t =
      t * (∫ x in (1 : ℝ)..(N : ℝ),
        BuildingBlocks.CoarsePrimitive.primeErrorReal x * exp (-x * t))

theorem compactHeat_at_zero (N : ℕ) (hN : 1 ≤ N) : compactHeat N 0 = 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Heat kernel methods in spectral geometry and prime distribution (Chavel 1984, Berry-Keating 1999). The exact machine formalization of the continuous Laplace-dual identity $H_N(t) = t \int_1^N (\psi(x)-x) e^{-xt} dx$ with discrete terminal compensation and identical zero-charge vanishing in Lean 4 is novel.
- **Advancement:** Establishes machine-verified Laplace-endpoint duality and exact zero charge $H_N(0) = 0$ for terminal-compensated prime heat flows.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Number Theory*.
