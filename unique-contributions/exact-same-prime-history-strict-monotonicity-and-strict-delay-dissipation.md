# Unique Contribution 180: Exact Same-Prime History Strict Monotonicity and Strict Delay Dissipation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeStrictDelay.lean`](../../formalization/BuildingBlocks/SamePrimeStrictDelay.lean), [`building-blocks/primes/same-prime-strict-delay.md`](../../building-blocks/primes/same-prime-strict-delay.md)  
**Classification:** Functional Analysis / Renewal Dynamics / Monotone Operators / Strict Dissipation / Prime Powers / Strictly Contractive Semigroups

---

## 1. Executive Summary and Mathematical Statement

While weak dissipation $\int s(v-r) d\mu(r) - s(v) \le 0$ holds for any monotone history profile under causal probability measures, establishing *strict* dissipation is necessary to rule out non-trivial persistent limit cycles, persistent imaginary poles, and undamped oscillations.

This contribution proves:

1. **Global Strict Monotonicity of the Continuous Renewal Profile:**  
   By gluing cell-by-cell derivatives across integer transitions:
   \[
   H \text{ is strictly monotone increasing on } [1, \infty).
   \]
   Consequently, the normalized tent profile $h(u) = H(e^u)$ is strictly monotone increasing on $[0, \infty)$.
2. **First Square Strict Activation:**  
   The primary proper-power summand $\text{term}(2, 2, v) = \frac{\log^2 2}{2} h(v - \log 4)$ satisfies:
   \[
   \log 4 \le u < v \implies \text{term}(2, 2, u) < \text{term}(2, 2, v).
   \]
3. **Global Strict Monotonicity of the Same-Prime History Function:**  
   Since all other summands and cutoff expansions are non-decreasing:
   \[
   \log 4 \le u < v \implies s(u) < s(v).
   \]
   The same-prime history function is strictly monotone increasing for all $v \ge \log 4$.
4. **Strict Delay Loss:**  
   For any evaluation point $v > \log 4$ and every strictly positive delay $r > 0$:
   \[
   s(v - r) < s(v).
   \]
   Delaying by any positive amount strictly drops the history energy.
5. **Universal Strict Causal Dissipation:**  
   For any Borel probability measure $\mu$ on $[0, \infty)$ having strictly positive mass on positive delays ($\mu((0, \infty)) > 0$):
   \[
   \forall v > \log 4: \quad \int_0^\infty s(v - r) \, d\mu(r) - s(v) < 0.
   \]
   The delay dissipation residual is *strictly negative* at every age beyond the first square $\log 4$.

---

## 2. Mathematical Proof

### 2.1. Global Strict Monotonicity of $H$
Let $1 \le x < y$. Let $k = \lfloor x \rfloor$.
If $y \le k + 1$, then both $x, y \in [k, k+1]$, and by `H_strictMonoOn_cell`, $H(x) < H(y)$.
If $y > k + 1$, then $x < k + 1 \le y$.
By `H_strictMonoOn_cell` on $[k, k+1]$, $H(x) < H(k+1)$.
By weak monotonicity `H_monotoneOn`, $H(k+1) \le H(y)$.
Therefore $H(x) < H(y)$ across the cell boundary.

### 2.2. Strict Monotonicity of $s(v)$
Let $\log 4 \le u < v$.
The cutoff $\lfloor e^u \rfloor \ge 4 \ge 2$, so both $p=2$ and $m=2$ are included in the active indices.
The term $(p=2, m=2)$ has derivative strictly proportional to $h'(u - \log 4) > 0$, so $\text{term}(2, 2, u) < \text{term}(2, 2, v)$.
Every other active term $(p, m)$ is non-decreasing in $v$ by `term_monotone`.
Summing yields $\text{partialSum}_{\lfloor e^u \rfloor}(u) < \text{partialSum}_{\lfloor e^u \rfloor}(v)$.
Furthermore, expanding the cutoff to $\lfloor e^v \rfloor \ge \lfloor e^u \rfloor$ adds only non-negative terms.
Thus $s(u) < s(v)$.

### 2.3. Strict Delay Loss
If $v > \log 4$ and $r > 0$:
If $v - r \le \log 4$, then $s(v - r) = 0 < s(v)$ because $s(v) > 0$ for $v > \log 4$.
If $v - r > \log 4$, then since $v - r < v$, strict monotonicity gives $s(v - r) < s(v)$.
In both cases, $s(v - r) < s(v)$.

### 2.4. Strict Integral Residual
The integrand $g(r) = s(v) - s(v - r)$ is non-negative for all $r \ge 0$.
For every $r \in (0, \infty)$, $g(r) = s(v) - s(v - r) > 0$.
Thus the support of $g$ contains the open ray $(0, \infty)$.
Since $\mu((0, \infty)) > 0$, the set on which $g(r) > 0$ has strictly positive $\mu$-measure.
An integrable non-negative function that is strictly positive on a set of positive measure has a strictly positive integral:
\[
\int_0^\infty (s(v) - s(v - r)) \, d\mu(r) > 0 \implies \int_0^\infty s(v - r) \, d\mu(r) < s(v).
\]
Subtracting $s(v)$ gives $\int_0^\infty s(v - r) \, d\mu(r) - s(v) < 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeStrictDelay` in `formalization/BuildingBlocks/SamePrimeStrictDelay.lean`):
```lean
theorem H_strictMonoOn : StrictMonoOn H (Set.Ici 1)

theorem s_strictMonoOn : StrictMonoOn s (Set.Ici (Real.log 4))

theorem s_delay_lt {v r : ℝ} (hv : Real.log 4 < v) (hr : 0 < r) :
    s (v - r) < s v

theorem samePrime_residual_neg {μ : Measure ℝ} [IsProbabilityMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (hpositive : 0 < μ (Set.Ioi 0))
    {v : ℝ} (hv : Real.log 4 < v) :
    (∫ r, s (v - r) ∂μ) - s v < 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Strictly positive operators and strict dissipation in delay differential systems (Krasovskii 1959, Hale-Verduyn Lunel 1993, Breda-Maset-Vermiglio 2015). Machine verification of strict delay dissipation bounds arising from discrete prime-power renewal histories in Lean 4 is new.
- **Advancement:** Establishes global strict monotonicity of $s(v)$ on $[\log 4, \infty)$ and proves strict causal delay dissipation $\int_0^\infty s(v-r)d\mu(r) - s(v) < 0$ in Lean 4.
- **Target Venues:** *SIAM Journal on Mathematical Analysis* or *Journal of Functional Analysis*.
