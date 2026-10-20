# High-Density Positivity of Composite Divisor Brackets in W(x)

Type: observation
Confidence: high
Source: Strategy Node 22 falser audit (Level 0)
Relevant to: Proof attempts trying to establish $W(x) \le 0$ via termwise nonpositivity or cone preservation in discrete divisor expansions.

## Statement
In the discrete expansion of $W(x)$ given by:
$$W(x) = B_*(x) + \sum_{n \le x} \frac{x-n}{\sqrt{n}} \left[ L(n)^2 - Q(n) - \left(1 + \frac{x}{n}\right) L(n) \right]$$
where $L(n) = \sum_{p|n} (\log p) A_p(n)$ and $Q(n) = \sum_{p|n} (\log p)^2 A_p(n)^2$, the bracket:
$$\mathcal{B}(n, x) := L(n)^2 - Q(n) - \left(1 + \frac{x}{n}\right) L(n)$$
fails to be nonpositive on a massive fraction of integers. Specifically, at $x = 200$:
- Exactly 88 out of 199 integers $n \in [2, 200]$ (44.2%) yield strictly positive brackets $\mathcal{B}(n, 200) > 0$.
- Large positive values occur regularly across integers with multiple distinct prime factors:
  - $n = 65$: $\mathcal{B}(65, 200) = +14.188$
  - $n = 63$: $\mathcal{B}(63, 200) = +10.335$
  - $n = 36$: $\mathcal{B}(36, 72) = +1.9102$

## Evidence
Exact integer prime-factorization computation across all $n \in [2, 200]$ executed via sympy in Python in the Node 22 falser audit.

## Implications
Termwise nonpositivity, localized cone invariance, and pointwise sign domination are completely impossible. Eventual nonpositivity of $W(x)$ is a strictly collective, multi-scale phenomenon that cannot be decoupled from global multiplicative prime cancellation.

## Caveats
None; this is an exact discrete counterexample to any termwise sign bounding strategy.
