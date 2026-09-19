# Unique Contribution 322: Exact Odd-Möbius Factorization and 2-Adic Collar Splitting of von Mangoldt

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorCollarOddMobius.lean`](../../formalization/BuildingBlocks/SuccessorCollarOddMobius.lean), [`building-blocks/successor-collar/odd-mobius.md`](../../building-blocks/successor-collar/odd-mobius.md)  
**Classification:** Analytic Number Theory / Arithmetic Functions / Dirichlet Convolutions / Möbius Inversion / 2-Adic Splitting / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In Dirichlet convolution theory, the classical relation $\Lambda = \mu * \log$ intertwines prime-power counts across all divisors. In successor-collar expansions and Goldbach parity arguments, isolating the contribution of the unique even prime $p = 2$ from odd prime scales is essential.

This contribution proves:

1. **Exact 2-Adic Factorization of the Möbius Function:**  
   The arithmetic Möbius function factors unconditionally into its odd projection and a two-point 2-adic difference operator:
   \[
   \mu = \mu_{\text{odd}} * (\delta_1 - \delta_2),
   \]
   where $\mu_{\text{odd}}(n) = \mu(n)$ if $n$ is odd, and $0$ if $n$ is even.
2. **Universal Logarithmic Collapse on Even Cofactors:**  
   The dual bracket arithmetic function $L_{\text{odd}} = (\delta_1 - \delta_2) * \log$ evaluates for every integer $n$ to:
   \[
   L_{\text{odd}}(n) = \begin{cases}
   0 & \text{if } n = 0, \\
   \log 2 & \text{if } n \text{ is even, } n > 0, \\
   \log n & \text{if } n \text{ is odd.}
   \end{cases}
   \]
   Every even cofactor, regardless of its 2-adic valuation $v_2(n)$ or composite complexity, has its logarithmic contribution collapsed to the universal constant $\log 2$.
3. **Exact Odd-Möbius Factorization of the von Mangoldt Function:**  
   The von Mangoldt function factors as:
   \[
   \Lambda = \mu_{\text{odd}} * L_{\text{odd}}.
   \]
4. **Explicit Divisor and Hyperbola Summation Formulas:**  
   Pointwise at each integer $n$:
   \[
   \Lambda(n) = \sum_{d \mid n, d \text{ odd}} \mu(d) \left( \mathbf{1}_{2 \mid (n/d)} \log 2 + \mathbf{1}_{2 \nmid (n/d)} \log(n/d) \right).
   \]
   For any test weight $w$ over the interval $[1, N]$:
   \[
   \sum_{n=1}^N \Lambda(n) w(n) = \sum_{a=1, a \text{ odd}}^N \mu(a) \sum_{b=1}^{\lfloor N/a \rfloor} \left( \mathbf{1}_{2 \mid b} \log 2 + \mathbf{1}_{2 \nmid b} \log b \right) w(ab).
   \]

---

## 2. Mathematical Proof

### 2.1. Möbius Factorization
Let $(\delta_1 - \delta_2)(1) = 1, (\delta_1 - \delta_2)(2) = -1$, and $0$ otherwise.
Then for any $n$:
\[
(\mu_{\text{odd}} * (\delta_1 - \delta_2))(n) = \mu_{\text{odd}}(n) - \mathbf{1}_{2 \mid n} \mu_{\text{odd}}(n/2).
\]
- If $n$ is odd: $2 \nmid n$, so the second term vanishes and the first term is $\mu(n)$.
- If $n$ is even: write $n = 2m$. Then $\mu_{\text{odd}}(2m) = 0$. The second term is $-\mu_{\text{odd}}(m)$.
  - If $m$ is odd: $\mu(2m) = \mu(2)\mu(m) = -\mu(m) = -\mu_{\text{odd}}(m)$.
  - If $m$ is even: $4 \mid n$, so $\mu(n) = 0$. Also $m$ is even, so $\mu_{\text{odd}}(m) = 0$.
In all cases, the identity holds.

### 2.2. Dual Logarithmic Bracket
By definition, $L_{\text{odd}}(n) = \log n - \mathbf{1}_{2 \mid n} \log(n/2)$.
- If $n$ is odd: $L_{\text{odd}}(n) = \log n$.
- If $n = 2m > 0$ is even:
  \[
  L_{\text{odd}}(2m) = \log(2m) - \log(m) = \log 2 + \log m - \log m = \log 2.
  \]

### 2.3. von Mangoldt Convolution
By associativity of Dirichlet convolution:
\[
\Lambda = \mu * \log = (\mu_{\text{odd}} * (\delta_1 - \delta_2)) * \log = \mu_{\text{odd}} * ((\delta_1 - \delta_2) * \log) = \mu_{\text{odd}} * L_{\text{odd}}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorCollarOddMobius` in `formalization/BuildingBlocks/SuccessorCollarOddMobius.lean`):
```lean
theorem moebius_eq_odd_factor :
    (ArithmeticFunction.moebius : ArithmeticFunction ℝ) =
      oddMoebius * (1 - atTwo)

theorem oddLogBracket_apply (n : ℕ) :
    oddLogBracket n =
      if n = 0 then 0 else if Even n then Real.log 2 else Real.log n

theorem vonMangoldt_eq_odd_convolution :
    ArithmeticFunction.vonMangoldt = oddMoebius * oddLogBracket

theorem vonMangoldt_odd_divisor_formula_expanded (n : ℕ) :
    ArithmeticFunction.vonMangoldt n =
      ∑ d ∈ n.divisors,
        (if Odd d then (ArithmeticFunction.moebius d : ℝ) else 0) *
          (if n / d = 0 then 0 else if Even (n / d) then Real.log 2
            else Real.log (n / d : ℕ))

theorem weighted_vonMangoldt_odd_factor_pairs
    (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * w n) =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
        (if Odd a then (ArithmeticFunction.moebius a : ℝ) else 0) *
          (if Even b then Real.log 2 else Real.log b) * w (a * b)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet (1849) *Über die Bestimmung der mittleren Werthe in der Zahlentheorie*; Mertens (1874) *Über einige asymptotische Gesetze der Zahlentheorie*; Apostol (1976) *Introduction to Analytic Number Theory*. Machine verification of exact odd-Möbius factorizations and 2-adic logarithmic collapse in Lean 4 is new.
- **Advancement:** Isolates the 2-adic component into an exact difference operator, proving that the dual logarithmic factor on all even cofactors identically equals $\log 2$.
- **Target Venues:** *American Mathematical Monthly* or *Integers*.
