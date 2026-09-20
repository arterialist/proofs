# Contribution 145: Exact Selberg-Riesz Area Continuous Reflection Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SelbergReflection.lean`](../../formalization/BuildingBlocks/SelbergReflection.lean), [`building-blocks/selberg/selberg-reflection.md`](../../building-blocks/selberg/selberg-reflection.md)  
**Classification:** Analytic Number Theory / Continuous Reflection Formulas / Selberg Auto-Convolutions / First Riesz Mean / Prime Error Primitives

---

## 1. Executive Summary and Mathematical Statement

In the theory of arithmetic convolutions, expressing discrete second-order prime sums—such as the double Dirichlet convolution $\sum_{ab \le x} (x - ab)\Lambda(a)\Lambda(b)$—in terms of continuous integrals of the first-order prime error $E(x) = \psi(x) - x$ is an essential bridge between multiplicative arithmetic and spectral analysis.

This contribution proves:

1. **Modified Error Deficit Identity:**  
   For all real $y \ge 1$:
   $$
   E(y) - \frac{\psi_1(y)}{y} = \frac{M_1(y)}{y} - \frac{y}{2} - \frac{1}{2y},
   $$
   where $M_1(y) = \sum_{n \le \lfloor y \rfloor} n \Lambda(n)$ is the first prime birth moment and $\psi_1(y) = \int_1^y E(t) dt$ is the prime primitive area.
2. **Reflected Prime-Birth Moment Integration:**  
   For any integer truncation $N \ge 1$:
   $$
   \int_1^N E(a) M_1\left(\frac{N}{a}\right) da = \sum_{n=1}^N n \Lambda(n) \psi_1\left(\frac{N}{n}\right).
   $$
3. **Double Hyperbola Primal Representation:**  
   The reflected primitive sum decomposes into the exact discrete double hyperbola sum and harmonic/moment corrections:
   $$
   \sum_{n=1}^N n \Lambda(n) \psi_1\left(\frac{N}{n}\right) = \sum_{a=1}^N \sum_{b=1}^{\lfloor N/a \rfloor} (N - ab)\Lambda(a)\Lambda(b) - \frac{N^2}{2} \sum_{n=1}^N \frac{\Lambda(n)}{n} + \frac{1}{2} \sum_{n=1}^N n \Lambda(n).
   $$
4. **Exact Selberg Continuous Reflection Identity:**  
   For every integer $N \ge 1$:
   $$
   S(N) = N \int_1^N \frac{E(a)}{a} \left( E\left(\frac{N}{a}\right) - \frac{\psi_1(N/a)}{N/a} \right) da,
   $$
   where $S(N)$ is the centered Selberg auto-convolution area primitive.

---

## 2. Mathematical Proof

### 2.1. Modified Error Identity
For $y \ge 1$:
$$
\psi_1(y) = \int_1^y (\psi(t) - t) dt = \sum_{n \le \lfloor y \rfloor} (y - n)\Lambda(n) - \frac{y^2 - 1}{2}.
$$
Dividing by $y$:
$$
\frac{\psi_1(y)}{y} = \psi(y) - \frac{1}{y} \sum_{n \le \lfloor y \rfloor} n \Lambda(n) - \frac{y}{2} + \frac{1}{2y} = \psi(y) - \frac{M_1(y)}{y} - \frac{y}{2} + \frac{1}{2y}.
$$
Subtracting this from $E(y) = \psi(y) - y$:
$$
E(y) - \frac{\psi_1(y)}{y} = -y + \frac{M_1(y)}{y} + \frac{y}{2} - \frac{1}{2y} = \frac{M_1(y)}{y} - \frac{y}{2} - \frac{1}{2y}.
$$

### 2.2. Continuous Reflection Duality
Using $M_1(N/a) = \sum_{n \le N} \mathbf{1}_{a \le N/n} n \Lambda(n)$, we integrate $E(a)$ against $M_1(N/a)$:
$$
\int_1^N E(a) M_1(N/a) da = \sum_{n \le N} n \Lambda(n) \int_1^{N/n} E(a) da = \sum_{n \le N} n \Lambda(n) \psi_1(N/n).
$$
Substituting the expansion of $\psi_1(N/n)$:
$$
\psi_1(N/n) = \sum_{b \le N/n} \left(\frac{N}{n} - b\right) \Lambda(b) - \frac{(N/n)^2 - 1}{2}.
$$
Multiplying by $n \Lambda(n)$:
$$
n \Lambda(n) \psi_1(N/n) = \sum_{b \le N/n} (N - nb) \Lambda(n) \Lambda(b) - \frac{N^2}{2} \frac{\Lambda(n)}{n} + \frac{1}{2} n \Lambda(n).
$$
Summing over $n \le N$ yields the double hyperbola representation.

### 2.3. Integration of Residual Terms and Reflection Identity
Integrating $E(a)$ against the remaining components $-N^2/(2a^2) - E(a)/(2a)$ of the quotient formula:
$$
-\frac{N^2}{2} \int_1^N \frac{E(a)}{a^2} da = -\frac{N^2}{2} \left( \sum_{n \le N} \frac{\Lambda(n)}{n} - \log N - 1 + \frac{1}{N} \right),
$$
and
$$
-\frac{1}{2} \int_1^N E(a) da = -\frac{1}{2} \psi_1(N).
$$
Combining these with the reflected moment integral yields the exact arithmetic definition of the centered Selberg area $S(N)$, with all remainder constants canceling precisely:
$$
S(N) = N \int_1^N \frac{E(a)}{a} \left( E\left(\frac{N}{a}\right) - \frac{\psi_1(N/a)}{N/a} \right) da.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/SelbergReflection.lean`):
```lean
theorem primeError_sub_primitive_quotient {y : ℝ} (hy : 1 ≤ y) :
    primeErrorReal y - coarsePrefix 1 y / y =
      primeBirthMoment y / y - y / 2 - 1 / (2*y)

theorem integral_primeError_reflected_birthMoment {N : ℕ} (hN : 1 ≤ N) :
    (∫ a in (1 : ℝ)..(N : ℝ), primeErrorReal a * primeBirthMoment ((N : ℝ) / a)) =
      ∑ n ∈ Finset.Icc 1 N,
        (n : ℝ) * ArithmeticFunction.vonMangoldt n * coarsePrefix 1 ((N : ℝ) / n)

theorem reflected_primePrimitive_sum {N : ℕ} :
    (∑ n ∈ Finset.Icc 1 N,
      (n : ℝ) * ArithmeticFunction.vonMangoldt n * coarsePrefix 1 ((N : ℝ) / n)) =
    (∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
      ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt a *
        ArithmeticFunction.vonMangoldt b) -
    (N : ℝ)^2 / 2 * (∑ n ∈ Finset.Icc 1 N,
      ArithmeticFunction.vonMangoldt n / (n : ℝ)) +
    (∑ n ∈ Finset.Icc 1 N, (n : ℝ) * ArithmeticFunction.vonMangoldt n) / 2

theorem selbergCenteredArea_reflection {N : ℕ} (hN : 1 ≤ N) :
    selbergCenteredArea N = (N : ℝ) *
      ∫ a in (1 : ℝ)..(N : ℝ),
        primeErrorReal a *
          (primeErrorReal ((N : ℝ) / a) -
            coarsePrefix 1 ((N : ℝ) / a) / ((N : ℝ) / a)) / a
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Selberg's symmetry formula integral analogues (Selberg 1949, Bombieri 1976). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Gives a Lean 4 proof of the stated continuous reflection identity connecting discrete Selberg area primitives to continuous integral pairings of the prime error. Priority among formalizations is not established by this audit.
- **Target Venues:** *Mathematische Zeitschrift* or *Journal of Number Theory*.
