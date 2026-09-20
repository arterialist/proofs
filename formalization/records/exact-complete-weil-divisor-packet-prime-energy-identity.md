# Contribution 115: Exact Complete Weil Divisor-Packet Prime Energy Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompactWeilDivisorEnergyFinite.lean`](../../formalization/BuildingBlocks/CompactWeilDivisorEnergyFinite.lean), [`building-blocks/weil-and-spectral/complete-divisor-packet-energy.md`](../../building-blocks/weil-and-spectral/complete-divisor-packet-energy.md)  
**Classification:** Analytic Number Theory / Weil Quadratic Forms / Divisor Graphs / Ground-State Transformations / Dirichlet Energy Identities

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of Weil's explicit formula on finite arithmetic graphs, let $g : \mathbb{N} \to \mathbb{R}$ be an arbitrary test vector, and consider the vertex norm:
$$
\|g\|_{\text{vertex}}^2 = \sum_{n=1}^N \frac{g(n)^2}{n},
$$
along with the symmetric Weil prime bilinear form:
$$
\mathcal{P}_N(g) = 2 \sum_{d=1}^N \sum_{n \le N/d} \frac{\Lambda(d)}{n d} g(n) g(n d),
$$
where $\Lambda(d)$ is the von Mangoldt function.

This contribution proves:

1. **Exact Incoming Prime Square Identity:**  
   Summing the shifted square energy over all divisor pairs $n d \le N$ with weight $\frac{\Lambda(d)}{nd}$ recovers the exact logarithmic vertex mass:
   $$
   \sum_{d=1}^N \sum_{n \le N/d} \frac{\Lambda(d)}{n d} g(n d)^2 = \sum_{m=1}^N \frac{\log m}{m} g(m)^2.
   $$
   This identity uses the complete arithmetic identity $\sum_{d \mid m} \Lambda(d) = \log m$ without any prime-power truncation or approximation.
2. **Exact Ground-State Energy Identity:**  
   The prime deficit $\log N \cdot \|g\|_{\text{vertex}}^2 - \mathcal{P}_N(g)$ decomposes identically as:
   $$
   \log N \sum_{n=1}^N \frac{g(n)^2}{n} - 2 \sum_{d=1}^N \sum_{n \le N/d} \frac{\Lambda(d)}{n d} g(n) g(n d) = \mathcal{E}_{\text{history}}(g) + \mathcal{E}_{\text{boundary}}(g),
   $$
   where the history energy is a manifestly non-negative Dirichlet quadratic form:
   $$
   \mathcal{E}_{\text{history}}(g) = \sum_{d=1}^N \sum_{n \le N/d} \frac{\Lambda(d)}{n d} (g(n) - g(n d))^2 \ge 0,
   $$
   and the boundary energy is given by:
   $$
   \mathcal{E}_{\text{boundary}}(g) = \sum_{n=1}^N \frac{g(n)^2}{n} \left( \log\left(\frac{N}{n}\right) - \sum_{d \le N/n} \frac{\Lambda(d)}{d} \right).
   $$
3. **Pointwise Mertens Boundary Representation:**  
   At each integer vertex $n \in [1, N]$, the local boundary defect:
   $$
   \operatorname{defect}(N, n) = \log\left(\frac{N}{n}\right) - \sum_{d \le N/n} \frac{\Lambda(d)}{d}
   $$
   is precisely the classical Mertens prime-logarithm difference at scale $x = N/n$, isolating the exact boundary obstacle to Weil positivity.
4. **Complex Hermitian Extension:**
   For arbitrary $g : \mathbb{N} \to \mathbb{C}$, the same identity holds with $g(n)^2$ replaced by $|g(n)|^2$ and each graph edge replaced by
   $$
   2\frac{\Lambda(d)}{nd}\operatorname{Re}\bigl(g(n)\overline{g(nd)}\bigr).
   $$
   Its history term is
   $$
   \sum_{d=1}^N\sum_{n\le N/d}\frac{\Lambda(d)}{nd}|g(n)-g(nd)|^2\ge 0.
   $$
   This extension retains all prime powers and permits phase-sensitive test vectors. It does not establish a sign for the boundary defect.

---

## 2. Mathematical Proof

### 2.1. Incoming Square Identity
Using the hyperbola factorization bijection $(n, d) \mapsto m = nd$:
$$
\sum_{d=1}^N \sum_{n \le N/d} \frac{\Lambda(d)}{nd} g(nd)^2 = \sum_{m=1}^N \frac{g(m)^2}{m} \sum_{d \mid m} \Lambda(d).
$$
By the classical identity $\sum_{d \mid m} \Lambda(d) = \log m$, this equals $\sum_{m=1}^N \frac{\log m}{m} g(m)^2$.

### 2.2. Ground-State Decomposition
Expanding the history difference square:
$$
(g(n) - g(nd))^2 = g(n)^2 - 2 g(n) g(nd) + g(nd)^2.
$$
Multiplying by $\frac{\Lambda(d)}{nd}$ and summing over $nd \le N$:
$$
\mathcal{E}_{\text{history}}(g) = \sum_{d=1}^N \sum_{n \le N/d} \frac{\Lambda(d)}{nd} g(n)^2 - \mathcal{P}_N(g) + \sum_{d=1}^N \sum_{n \le N/d} \frac{\Lambda(d)}{nd} g(nd)^2.
$$
Substituting the incoming square identity:
$$
\mathcal{E}_{\text{history}}(g) = \sum_{n=1}^N \frac{g(n)^2}{n} \sum_{d \le N/n} \frac{\Lambda(d)}{d} - \mathcal{P}_N(g) + \sum_{m=1}^N \frac{\log m}{m} g(m)^2.
$$
Now consider the total logarithmic energy:
$$
\log N \cdot \|g\|_{\text{vertex}}^2 = \sum_{n=1}^N \frac{\log N}{n} g(n)^2 = \sum_{n=1}^N \frac{\log n}{n} g(n)^2 + \sum_{n=1}^N \frac{\log(N/n)}{n} g(n)^2.
$$
Subtracting $\mathcal{P}_N(g)$:
$$
\log N \cdot \|g\|_{\text{vertex}}^2 - \mathcal{P}_N(g) = \mathcal{E}_{\text{history}}(g) + \sum_{n=1}^N \frac{g(n)^2}{n} \left( \log\left(\frac{N}{n}\right) - \sum_{d \le N/n} \frac{\Lambda(d)}{d} \right),
$$
which proves the identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompactWeilDivisorEnergyFinite`):
```lean
theorem incoming_square_eq_log (N : ℕ) (g : ℕ → ℝ) :
    (∑ d ∈ Finset.Icc 1 N,
      ∑ n ∈ Finset.Icc 1 (N / d),
        edgeWeight n d * g (n * d) ^ 2) =
      ∑ m ∈ Finset.Icc 1 N,
        Real.log (m : ℝ) * g m ^ 2 / (m : ℝ)

theorem historyEnergy_nonneg (N : ℕ) (g : ℕ → ℝ) :
    0 ≤ historyEnergy N g

theorem boundaryEnergy_eq_pointwise (N : ℕ) (g : ℕ → ℝ) :
    boundaryEnergy N g =
      ∑ n ∈ Finset.Icc 1 N,
        boundaryDefect N n * g n ^ 2 / (n : ℝ)

theorem prime_deficit_eq_history_add_boundary (N : ℕ) (g : ℕ → ℝ) :
    Real.log (N : ℝ) * vertexNorm N g - primeGraph N g =
      historyEnergy N g + boundaryEnergy N g

theorem prime_deficit_eq_history_add_pointwise (N : ℕ) (g : ℕ → ℝ) :
    Real.log (N : ℝ) * vertexNorm N g - primeGraph N g =
      historyEnergy N g +
        ∑ n ∈ Finset.Icc 1 N,
          boundaryDefect N n * g n ^ 2 / (n : ℝ)

theorem complexHistoryEnergy_nonneg (N : ℕ) (g : ℕ → ℂ) :
    0 ≤ complexHistoryEnergy N g

theorem complex_prime_deficit_eq_history_add_boundary
    (N : ℕ) (g : ℕ → ℂ) :
    Real.log (N : ℝ) * complexVertexNorm N g - complexPrimeGraph N g =
      complexHistoryEnergy N g + complexBoundaryEnergy N g

theorem complex_prime_deficit_eq_history_add_pointwise
    (N : ℕ) (g : ℕ → ℂ) :
    Real.log (N : ℝ) * complexVertexNorm N g - complexPrimeGraph N g =
      complexHistoryEnergy N g +
        ∑ n ∈ Finset.Icc 1 N,
          boundaryDefect N n * Complex.normSq (g n) / (n : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Weil explicit formula quadratic forms (Weil 1952, Bombieri 2000, Connes 1999). Divisor graph representations and Mertens boundary defect decompositions on finite hyperbola networks are novel.
- **Advancement:** Establishes machine-verified ground-state decomposition of the complete Weil prime form into a non-negative Dirichlet history square plus pointwise Mertens boundary defects.
- **Target Venues:** *Journal of the European Mathematical Society* or *Mathematische Annalen*.
