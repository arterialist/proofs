# Uniform negative dyadic divisor average

**Status:** complete written proof; factorial and harmonic recurrences verified, September 2026.
Attribution: Arterialist RH research team, September 2026.
To the best of our knowledge, the exact finite division identity and uniform negative margin
for the complete dyadic divisor average have not appeared as an explicit theorem in the literature.

## Statement

Let $\psi(x) = \sum_{n \le x} \Lambda(n)$ include every prime power. For each integer $N \ge 1$,
consider the discrete dyadic divisor sum
\[
 S(N) := \sum_{d=1}^N \left[ \psi(2N/d) - \psi(N/d) - \frac{N}{d} \right].
\]
Let $\delta = \frac{3}{2} - \log 4 \approx 0.1137056 > 0$.

**Theorem.** For every integer $N \ge 1$:
\[
 \boxed{\quad
 S(N) = \log\left( \frac{(2N)!}{N!} \right) - N H_N < - N \delta < - 0.1137 N,
 \quad}
\]
where $H_N = \sum_{j=1}^N \frac{1}{j}$ is the $N$-th harmonic number. In particular, the normalized
dyadic divisor average satisfies the uniform negative bound:
\[
 \boxed{\quad
 \frac{1}{N} \sum_{d=1}^N \left[ \psi(2N/d) - \psi(N/d) - \frac{N}{d} \right] < - \left(\frac{3}{2} - \log 4\right) < - 0.1137
 \quad\text{for every } N \ge 1.
 \quad}
\]

## Mathematical mechanism

1. **Division identity:** Applying Dirichlet's hyperbola / division identity
   $\sum_{d \le x} \psi(x/d) = \log(\lfloor x \rfloor!)$ at $x = 2N$ and $x = N$ yields:
   \[
    \sum_{d \le N} \psi(2N/d) - \psi(N/d) = \log((2N)!) - \log(N!) = \log\left(\frac{(2N)!}{N!}\right).
   \]
   Subtracting $\sum_{d \le N} N/d = N H_N$ gives the exact discrete difference $S(N) = -A_N$,
   where $A_N = N H_N - \log((2N)!/N!)$.
2. **Strict inductive growth:** Factorial and harmonic recurrences give
   \[
    A_{N+1} - A_N = H_N + 1 - \log(4N+2).
   \]
   By the convexity of $1/t$, $H_N \ge \log N + \frac{1}{2} + \frac{1}{2N}$.
   Using $\log(1+u) \le u$ forces $A_{N+1} - A_N \ge \frac{3}{2} - \log 4 = \delta$.
   Since $A_1 = 1 - \log 2 > \delta$, induction establishes $A_N > N\delta$ for all $N \ge 1$.
3. **Asymptotics:** As $N \to \infty$, Stirling's approximation gives
   $\frac{1}{N} S(N) \to \log 4 - 1 - \gamma \approx - 0.19092$.
   The theorem establishes that the discrete sum is strictly negative with uniform margin $\delta$
   starting from the very first integer $N=1$.

Full proof: [building-blocks/factorial-and-renewal/division-renewal-dyadic-average.md](../building-blocks/factorial-and-renewal/division-renewal-dyadic-average.md).
