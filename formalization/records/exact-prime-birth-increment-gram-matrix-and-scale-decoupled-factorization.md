# Contribution 226: Exact Prime Birth Increment Gram Matrix and Scale-Decoupled Factorization

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenBirthGram.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthGram.lean), [`building-blocks/charge/charge-frozen-birth-gram.md`](../../building-blocks/charge/charge-frozen-birth-gram.md)  
**Classification:** Analytic Number Theory / Operator Theory / Gram Matrices / Prime Birth Processes / Scale Decoupling / Hilbert Space Inner Products

---

## 1. Executive Summary and Mathematical Statement

Understanding the orthogonality or cross-talk between different scales of the prime counting process is central to establishing energy bounds on arithmetic fluctuations. Let $\text{increment}(N, v) = \text{causalSource}(N+1, v) - \text{causalSource}(N, v)$ represent the infinitesimal prime birth increment in the continuous logarithmic coordinate $v \in (0, \infty)$.

This contribution proves:

1. **Exact Scale Decoupling and Support Separation:**  
   For any integer $N \ge 2$, on the interior range $0 < v \le \log N$, the increment vanishes identically:
   $$
   \text{increment}(N, v) = 0 \quad (\forall v \in (0, \log N]).
   $$
   Consequently, for any $2 \le m < N$, the earlier increment $\text{increment}(m, \cdot)$ and later increment $\text{increment}(N, \cdot)$ have completely disjoint non-trivial prefix supports on $(0, \log N]$.
2. **Transition Ramp and Tail Factorizations:**  
   - On the transition ramp $v \in (\log N, \log(N+1))$:
     $$
     \text{increment}(m, v) \cdot \text{increment}(N, v) = -(\Lambda(m+1) - 1) \cdot (1 - N e^{-v}).
     $$
   - On the terminal tail $v \in (\log(N+1), \infty)$:
     $$
     \text{increment}(m, v) \cdot \text{increment}(N, v) = (\Lambda(m+1) - 1) \cdot (\Lambda(N+1) - 1) \cdot e^{-v}.
     $$
3. **Exact Gram Matrix Closed Form:**  
   For all integers $2 \le m < N$, the off-diagonal Gram matrix entry in the physical Hilbert space $L^2((0, \infty))$ factors completely:
   $$
   \langle \text{increment}(m), \text{increment}(N) \rangle_{L^2} = \int_0^\infty \text{increment}(m, v) \text{increment}(N, v) \, dv = (\Lambda(m+1) - 1) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right).
   $$
   Notice the remarkable decoupling: the inner product depends on the earlier scale $m$ *only* through the scalar prime error factor $(\Lambda(m+1) - 1)$, while the entire $N$-dependence is encapsulated in the discrepancy between the normalized prime density $\frac{\Lambda(N+1)}{N+1}$ and the continuous scale measure $\log(1 + 1/N)$.

---

## 2. Mathematical Proof

### 2.1. Domain Decomposition
Let $a = \log N$ and $b = \log(N+1)$. The domain $(0, \infty)$ splits into $(0, a]$, $(a, b)$, and $(b, \infty)$.
On $(0, a]$, $\text{increment}(N, v) = 0$, so $\int_0^a \text{increment}(m, v) \text{increment}(N, v) dv = 0$.

### 2.2. Ramp Integral
On $(a, b)$, since $m < N$, $m+1 \le N \le e^v$, so the earlier increment is in its terminal regime:
$$
\text{increment}(m, v) = -(\Lambda(m+1) - 1) e^{-v/2}.
$$
The later increment is in its ramp regime:
$$
\text{increment}(N, v) = (e^v - N) e^{-v/2} = e^{v/2} - N e^{-v/2}.
$$
Multiplying gives $-(\Lambda(m+1) - 1)(1 - N e^{-v})$.
Integrating with respect to $v$ from $a$ to $b$:
$$
\int_a^b (1 - N e^{-v}) \, dv = (b - a) - N (e^{-a} - e^{-b}) = \log\left(1 + \frac{1}{N}\right) - N\left(\frac{1}{N} - \frac{1}{N+1}\right) = \log\left(1 + \frac{1}{N}\right) - \frac{1}{N+1}.
$$

### 2.3. Tail Integral
On $(b, \infty)$, both increments are in their terminal regimes:
$$
\text{increment}(m, v) \cdot \text{increment}(N, v) = (\Lambda(m+1) - 1)(\Lambda(N+1) - 1) e^{-v}.
$$
Integrating on $(b, \infty)$:
$$
\int_b^\infty e^{-v} \, dv = e^{-b} = \frac{1}{N+1}.
$$
Thus the tail contribution is $\frac{(\Lambda(m+1) - 1)(\Lambda(N+1) - 1)}{N+1}$.

### 2.4. Total Gram Inner Product
Summing the ramp and tail integrals:
$$
-(\Lambda(m+1) - 1) \left( \log\left(1 + \frac{1}{N}\right) - \frac{1}{N+1} \right) + (\Lambda(m+1) - 1) \frac{\Lambda(N+1) - 1}{N+1}
$$
Factoring out $(\Lambda(m+1) - 1)$:
$$
(\Lambda(m+1) - 1) \left( -\log\left(1 + \frac{1}{N}\right) + \frac{1}{N+1} + \frac{\Lambda(N+1)}{N+1} - \frac{1}{N+1} \right) = (\Lambda(m+1) - 1) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right).
$$
The intermediate term $\frac{1}{N+1}$ cancels identically.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenBirthGram` in `formalization/BuildingBlocks/ChargeFrozenBirthGram.lean`):
```lean
theorem birth_gram_integrable {m N : ℕ} (hm : 2 ≤ m) (hN : 2 ≤ N) :
    IntegrableOn (fun v => increment m v * increment N v) (Ioi (0 : ℝ))

theorem birth_gram_ramp {m N : ℕ} (_hm : 2 ≤ m) (hmN : m < N) (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log (N : ℝ) < v) (hv1 : v < Real.log ((N + 1 : ℕ) : ℝ)) :
    increment m v * increment N v =
      -(ArithmeticFunction.vonMangoldt (m + 1) - 1) * (1 - (N : ℝ) * Real.exp (-v))

theorem birth_gram_terminal {m N : ℕ} (_hm : 2 ≤ m) (hmN : m < N) (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log ((N + 1 : ℕ) : ℝ) < v) :
    increment m v * increment N v =
      (ArithmeticFunction.vonMangoldt (m + 1) - 1) * (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v)

theorem birth_gram_integral {m N : ℕ} (hm : 2 ≤ m) (hmN : m < N) (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), increment m v * increment N v) =
      (ArithmeticFunction.vonMangoldt (m + 1) - 1) * (ArithmeticFunction.vonMangoldt (N + 1) /
        ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ)))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Gram matrices of wavelet and multiresolution systems, quasi-orthogonal expansions in analytic number theory (Meyer 1990, Daubechies 1992, Montgomery-Vaughan 2007). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Proves that the non-diagonal inner product of prime increments in physical $L^2$ space factors into rank-one components with exact algebraic cancellation.
- **Target Venues:** *Linear Algebra and its Applications* or *Journal of Number Theory*.
