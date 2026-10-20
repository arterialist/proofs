# Arithmetic Support and Vanishing of Distinct-Prime Coefficients $c(n)$

Type: observation
Confidence: high
Source: Candidates 00, 05, 06, 07 (Level 0)
Relevant to: Arithmetic convolution structure in Frontier 1

## Statement
The centered distinct-prime convolution coefficient
$$c(n) = \sum_{ab=n} \Lambda(a)\Lambda(b) - \Lambda(n)(\log n - \Lambda(n))$$
satisfies the exact arithmetic support property:
1. $c(1) = 0$.
2. $c(p^k) = 0$ for all prime powers $p^k$ ($p$ prime, $k \ge 1$).
3. $c(n) = 0$ for all integers $n$ having 3 or more distinct prime factors ($\omega(n) \ge 3$).
4. $c(n) = 2 \log p \log q > 0$ if and only if $n = p^j q^k$ has exactly two distinct prime factors $p \ne q$ ($j, k \ge 1$).
In particular, $c(n) \ge 0$ for all integers $n \ge 1$, and $c(n) > 0$ strictly if and only if $\omega(n) = 2$.

## Evidence
- For prime powers $n = p^k$: the divisors $a \mid p^k$ with $\Lambda(a) \ne 0$ are $p^j$ ($1 \le j \le k-1$), each with $\Lambda(p^j)\Lambda(p^{k-j}) = (\log p)^2$. There are $k-1$ such pairs, summing to $(k-1)(\log p)^2$. Simultaneously, $\Lambda(p^k)(\log(p^k) - \Lambda(p^k)) = \log p (k\log p - \log p) = (k-1)(\log p)^2$. The difference vanishes identically.
- For $\omega(n) \ge 3$: any factorization $n = ab$ with $\Lambda(a)\Lambda(b) \ne 0$ requires $a = p^j$ and $b = q^k$, meaning $ab = p^j q^k$ can have at most 2 distinct prime factors. If $\omega(n) \ge 3$, no such factorization exists, and $\Lambda(n) = 0$, so $c(n) = 0$.
- For $\omega(n) = 2$ ($n = p^j q^k$): the only nonzero terms in $\sum_{ab=n}\Lambda(a)\Lambda(b)$ are $(a, b) = (p^j, q^k)$ and $(q^k, p^j)$, each contributing $\log p \log q$. Since $\Lambda(n) = 0$, $c(n) = 2\log p \log q > 0$.
- Computational verification in Candidate 05 verified $c(n)$ for $n \in [1, 40]$: $c(6) = 1.523$, $c(10) = 2.231$, $c(12) = 1.523$, $c(30) = 0$ (since $30 = 2 \cdot 3 \cdot 5$).

## Implications
1. The arithmetic kernel $V(x)$ completely eliminates all same-prime powers from its convolution sum $\sum (x-n)c(n)$, isolating pure distinct-prime pairwise interactions.
2. The discrete coefficients $c(n)$ are pointwise non-negative ($c(n) \ge 0$), but the full bracket $(x-n)c(n) - \Lambda(n)\frac{x^2-n^2}{n}$ contains negative prime-power terms $-\Lambda(n)(x^2-n^2)/n$, creating the competitive tension in $V(x)$.

## Caveats
While $c(n) \ge 0$ pointwise, the smoothed potential $V(x)$ and $W(x)$ are not positive-definite because of the negative baseline terms and prime-power subtractions.
