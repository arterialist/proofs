# Contribution 141: Exact Selberg Symmetry Formula and Logarithmic Derivation Algebra

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SelbergIdentity.lean`](../../formalization/BuildingBlocks/SelbergIdentity.lean), [`building-blocks/selberg/selberg-identity.md`](../../building-blocks/selberg/selberg-identity.md)  
**Classification:** Analytic Number Theory / Elementary Prime Number Theory / Selberg Symmetry Formula / Derivations on Arithmetic Convolutions / Möbius Inversion

---

## 1. Executive Summary and Mathematical Statement

Atle Selberg's 1949 elementary proof of the Prime Number Theorem rests on the celebrated Selberg symmetry formula:
$$
\sum_{n \le x} \Lambda(n) \log n + \sum_{n \le x} \Lambda(n) \psi(x/n) = 2x \log x + O(x).
$$
In modern analytic number theory and formal mathematics, establishing the exact algebraic identity that underlies this asymptotic relation—without throwing away any terms or invoking $O(\cdot)$ bounds—is a foundational milestone.

This contribution proves:

1. **Logarithmic Derivation on Dirichlet Convolutions:**  
   Pointwise multiplication by $\log n$ is a formal derivation on the algebra of arithmetic functions under Dirichlet convolution:
   $$
   (f * g) \cdot \log = (f \cdot \log) * g + f * (g \cdot \log).
   $$
2. **Exact Algebraic Representation of the Selberg Weight:**  
   The second generalized von Mangoldt function $\Lambda_2 = \Lambda \cdot \log + \Lambda * \Lambda$ satisfies the exact operator identity:
   $$
   \Lambda_2 = \mu * (\log \cdot \log) = \mu * \log^2.
   $$
3. **Exact Pointwise Evaluation and Non-Negativity:**  
   For all $n \in \mathbb{N}$:
   $$
   \Lambda_2(n) = \Lambda(n) \log n + \sum_{d \mid n} \Lambda(d) \Lambda(n/d) \ge 0.
   $$
4. **Exact Finite Selberg Symmetry Formula:**  
   For any integer truncation $N \ge 1$, without any asymptotic truncation or error approximation:
   $$
   \sum_{n=1}^N \Lambda(n) \log n + \sum_{n=1}^N \Lambda(n) \psi\left(\left\lfloor \frac{N}{n} \right\rfloor\right) = \sum_{d=1}^N \mu(d) \sum_{k=1}^{\lfloor N/d \rfloor} \log^2 k.
   $$

---

## 2. Mathematical Proof

### 2.1. Derivation Property
For $d_1 d_2 = n$ with $d_1, d_2 > 0$:
$$
\log n = \log(d_1 d_2) = \log d_1 + \log d_2.
$$
Thus:
$$
((f * g) \cdot \log)(n) = \sum_{d_1 d_2 = n} f(d_1) g(d_2) (\log d_1 + \log d_2) = \sum_{d_1 d_2 = n} (f(d_1) \log d_1) g(d_2) + \sum_{d_1 d_2 = n} f(d_1) (g(d_2) \log d_2),
$$
which is precisely $((f \cdot \log) * g + f * (g \cdot \log))(n)$.

### 2.2. Operator Identity $\Lambda_2 = \mu * \log^2$
Recall that $\Lambda * 1 = \log$.
Applying the derivation to $\Lambda * 1$:
$$
(\Lambda * 1) \cdot \log = (\Lambda \cdot \log) * 1 + \Lambda * (1 \cdot \log) = (\Lambda \cdot \log) * 1 + \Lambda * \log.
$$
Since $\log = \Lambda * 1$, the second term is $\Lambda * (\Lambda * 1) = (\Lambda * \Lambda) * 1$.
Thus:
$$
\log^2 = ((\Lambda \cdot \log) + (\Lambda * \Lambda)) * 1 = \Lambda_2 * 1.
$$
Convolving both sides with the Möbius function $\mu$ (the inverse of $1$ under Dirichlet convolution):
$$
\Lambda_2 = \mu * \log^2.
$$

### 2.3. Finite Summation Identity
Summing $\Lambda_2(n)$ over $n \le N$:
$$
\sum_{n \le N} \Lambda_2(n) = \sum_{n \le N} \Lambda(n) \log n + \sum_{n \le N} \sum_{d \mid n} \Lambda(d) \Lambda(n/d).
$$
By Dirichlet hyperbola swapping of factor pairs $d k = n \le N$:
$$
\sum_{n \le N} \sum_{d \mid n} \Lambda(d) \Lambda(n/d) = \sum_{d \le N} \Lambda(d) \sum_{k \le N/d} \Lambda(k) = \sum_{d \le N} \Lambda(d) \psi(\lfloor N/d \rfloor).
$$
On the other hand, using $\Lambda_2 = \mu * \log^2$:
$$
\sum_{n \le N} \Lambda_2(n) = \sum_{n \le N} \sum_{d \mid n} \mu(d) \log^2(n/d) = \sum_{d \le N} \mu(d) \sum_{k \le N/d} \log^2 k.
$$
Equating both expressions proves the exact identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/SelbergIdentity.lean`):
```lean
theorem log_weighted_convolution (f g : ArithmeticFunction ℝ) :
    (f * g).pmul ArithmeticFunction.log =
      f.pmul ArithmeticFunction.log * g + f * g.pmul ArithmeticFunction.log

theorem selbergWeight_eq_moebius_logSquare :
    selbergWeight = (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      ArithmeticFunction.log.pmul ArithmeticFunction.log

theorem selbergWeight_apply (n : ℕ) :
    selbergWeight n = ArithmeticFunction.vonMangoldt n * Real.log n +
      ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt d * ArithmeticFunction.vonMangoldt (n / d)

theorem selbergWeight_nonneg (n : ℕ) : 0 ≤ selbergWeight n

theorem selberg_exact_identity (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * Real.log n) +
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * psi (N / n)) =
        ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
          ∑ k ∈ Finset.Icc 1 (N / d), Real.log k ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Selberg's elementary proof (Selberg 1949), Shapiro's derivation identity (Shapiro 1950), Nathanson's *Elementary Methods in Number Theory* (2000). The formal machine verification of the exact finite algebraic identity in Lean 4 without asymptotic bounds is novel.
- **Advancement:** Gives a Lean 4 proof of the stated finite Selberg symmetry formula $\sum \Lambda \log + \sum \Lambda \psi = \sum \mu \sum \log^2$. Priority among formalizations is not established by this audit.
- **Target Venues:** *American Mathematical Monthly* or *Journal of Automated Reasoning*.
