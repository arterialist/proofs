# Abel Divisor-Cube Stokes Identity and the LCM Escape Barrier

**Status:** Machine-checked result. Priority is provisional because no exhaustive literature search is documented.
**Corpus References:**
- [`building-blocks/geometry/abel-divisor-cube-stokes-obstruction.md`](../../building-blocks/geometry/abel-divisor-cube-stokes-obstruction.md)
- [`building-blocks/prime-distribution/mertens-prime-transfer.md`](../../building-blocks/prime-distribution/mertens-prime-transfer.md)
- [`building-blocks/successor-and-division/mobius-cube-boundary-stokes.md`](../../building-blocks/successor-and-division/mobius-cube-boundary-stokes.md)
- [`formalization/BuildingBlocks/MobiusStokesFiniteBoundary.lean`](../../formalization/BuildingBlocks/MobiusStokesFiniteBoundary.lean)

**Attribution:** Arterialist RH research team, September 2026.

---

## 1. Abstract

A natural geometric strategy for proving the Riemann Hypothesis via the Mertens bound $M(N) = O_\varepsilon(N^{1/2+\varepsilon})$ is to embed the quadratic Mertens sum $M(N)^2 = \sum_{d, e \le N} \mu(d)\mu(e)$ onto an oriented Boolean divisor cubical complex and apply homological boundary cancellation (Stokes' theorem).

This report proves an exact structural obstruction to this geometric program. We establish that:
1. Every interior LCM packet completes to the Möbius function:
   $$
    \sum_{[d, e] = \ell} \mu(d)\mu(e) = \mu(\ell) \qquad (\ell \text{ squarefree}).
   $$
2. The truncated divisor cube $[1, N]^2$ suffers an exact archimedean boundary escape across the hyperboloid $\{\max(d, e) \le N < [d, e]\}$ equal to:
   $$
    \boxed{\quad \mathcal{E}_N := \sum_{\substack{d, e \le N \\ [d, e] > N}} \mu(d)\mu(e) = M(N)^2 - M(N). \quad}
   $$
3. Under Abel summation at scale $X$ with discount factor $\rho = e^{-2/X}$, the geometric Stokes escape $\mathcal{E}_X = \frac{1}{1-\rho}\sum_{d, e \ge 1} \mu(d)\mu(e)(\rho^{\max(d, e)} - \rho^{[d, e]})$ differs from the full Abel Gram $D_X = \sum_{N \ge 1} \rho^N M(N)^2$ by an unconditional linear term bounded by $(1 + X/2)^2 = O(X^2)$:
   $$
    D_X - \left(1 + \frac{X}{2}\right)^2 \le \mathcal{E}_X \le D_X + \left(1 + \frac{X}{2}\right)^2.
   $$

Consequently, bounding the geometric Stokes escape $\mathcal{E}_X$ to $O_\varepsilon(X^{2+\varepsilon})$ is strictly equivalent to bounding the original quadratic Mertens Gram $D_X$. The Boolean divisor complex boundary does not absorb or soften the quadratic barrier: the full mass $M(N)^2$ escapes through the archimedean truncation boundary.

---

## 2. The Oriented Divisor Complex and Commutator

Let the squarefree integers be indexed by their ordered prime factors $n = p_1 \cdots p_k$ ($p_1 < \cdots < p_k$), forming oriented $k$-cells $e_n$ in the Boolean divisor complex with boundary operator:
$$
 \partial e_n = \sum_{j=1}^k (-1)^{j-1} e_{n/p_j}, \qquad \partial^2 = 0.
 \tag{1}
$$
The parity augmentation $\epsilon(e_n) = (-1)^k = \mu(n)$ satisfies $\epsilon(\partial e_n) = 0$ for $k \ge 2$, formalizing the Möbius cancellation on closed divisor cubes.

On the product complex $C_* \otimes C_*$ with boundary $B = \partial \otimes 1 + (-1)^{\deg} \otimes \partial$, introduce the archimedean maximum-weight operator with finite horizon $L$:
$$
 W_L e_{d, e} = k_L(d, e) e_{d, e}, \qquad k_L(d, e) = \mathbf{1}_{\max(d, e) \le L} \sum_{N = \max(d, e)}^L \rho^N.
 \tag{2}
$$
The weighted boundary commutator $[B, W_L]$ computes the exact boundary flux:
$$
 [B, W_L] e_{d, e} = \sum_{j=1}^{\omega(d)} (-1)^{j-1} [k_L(d, e) - k_L(d/p_j, e)] e_{d/p_j, e} + (-1)^{\omega(d)} \sum_{j=1}^{\omega(e)} (-1)^{j-1} [k_L(d, e) - k_L(d, e/q_j)] e_{d, e/q_j}.
 \tag{3}
$$
For $d, e \le L$, the step difference is purely the interior max-weight flux:
$$
 k_L(d, e) - k_L(d/p, e) = \begin{cases} 0, & d \le e, \\ -\sum_{N = \max(d/p, e)}^{d-1} \rho^N, & d > e. \end{cases}
 \tag{4}
$$
Taking $L \to \infty$ gives the smooth Abel Gram kernel $K_\rho(d, e) = \frac{\rho^{\max(d, e)}}{1-\rho}$.

---

## 3. Exact LCM Packet Completion

**Theorem 1 (LCM Packet Multiplicative Splitting).**
For any squarefree integer $\ell$:
$$
 \sum_{[d, e] = \ell} \mu(d)\mu(e) = \mu(\ell).
 \tag{5}
$$

*Proof.*
The condition $[d, e] = \ell$ means that for every prime factor $p \mid \ell$, $\max(\nu_p(d), \nu_p(e)) = 1$.
Since $d$ and $e$ are squarefree, the possible local exponent pairs $(\nu_p(d), \nu_p(e))$ are precisely:
$$
 (1, 0), \qquad (0, 1), \qquad (1, 1).
$$
Their respective Möbius weights $\mu(p^{\nu_p(d)}) \mu(p^{\nu_p(e)})$ are:
$$
 (-1) \cdot 1 = -1, \qquad 1 \cdot (-1) = -1, \qquad (-1) \cdot (-1) = +1.
$$
Summing over the three allowed states gives:
$$
 (-1) + (-1) + (+1) = -1 = \mu(p).
$$
By unique factorization, the sum factors completely over the prime divisors of $\ell$:
$$
 \sum_{[d, e] = \ell} \mu(d)\mu(e) = \prod_{p \mid \ell} (-1) = (-1)^{\omega(\ell)} = \mu(\ell). \qquad \blacksquare
$$

---

## 4. The Exact Boundary Escape Identity

Now consider the square prefix sum $M(N)^2 = \sum_{d, e \le N} \mu(d)\mu(e)$.
Grouping the pairs $(d, e)$ by their least common multiple $\ell = [d, e] \in [1, N^2]$:
$$
 M(N)^2 = \sum_{\ell \le N^2} \sum_{\substack{d, e \le N \\ [d, e] = \ell}} \mu(d)\mu(e).
 \tag{6}
$$
Split the sum into two ranges: $\ell \le N$ and $N < \ell \le N^2$.

1. **Range 1 ($\ell \le N$):**
   If $[d, e] = \ell \le N$, then automatically $d \le [d, e] \le N$ and $e \le [d, e] \le N$.
   Hence the restriction $d, e \le N$ is vacuous! Every divisor face of $\ell$ is present, so by Theorem 1:
   $$
    \sum_{\ell \le N} \sum_{\substack{d, e \le N \\ [d, e] = \ell}} \mu(d)\mu(e) = \sum_{\ell \le N} \sum_{[d, e] = \ell} \mu(d)\mu(e) = \sum_{\ell \le N} \mu(\ell) = M(N).
    \tag{7}
   $$

2. **Range 2 ($N < \ell \le N^2$):**
   In this range, $[d, e] = \ell > N$, but $d \le N$ and $e \le N$.
   These are precisely the incomplete LCM packets cut off by the square box. Define the escape flux:
   $$
    \mathcal{E}_N := \sum_{N < \ell \le N^2} \sum_{\substack{d, e \le N \\ [d, e] = \ell}} \mu(d)\mu(e) = \sum_{\substack{d, e \le N \\ [d, e] > N}} \mu(d)\mu(e).
    \tag{8}
   $$

**Theorem 2 (LCM Boundary Escape Identity).**
For every integer $N \ge 1$:
$$
 \boxed{\quad \mathcal{E}_N = M(N)^2 - M(N) = M(N)(M(N) - 1) \ge 0. \quad}
 \tag{9}
$$

*Proof.*
Immediate from (6), (7), and (8): $M(N)^2 = M(N) + \mathcal{E}_N$.
Since $M(N) \in \mathbb{Z}$, the product of any two consecutive integers $M(N)(M(N)-1)$ is non-negative. $\blacksquare$

---

## 5. Equivalence of Abel Stokes Flux and the Mertens Quadratic Target

Summing (9) against the geometric discount factor $\rho^N = e^{-2N/X}$ gives:
$$
 D_X := \sum_{N \ge 1} \rho^N M(N)^2 = \sum_{N \ge 1} \rho^N M(N) + \sum_{N \ge 1} \rho^N \mathcal{E}_N =: L_X + \mathcal{E}_X.
 \tag{10}
$$
The pairwise evaluation of $\mathcal{E}_X$ yields the exact Stokes kernel:
$$
 \boxed{\quad \mathcal{E}_X = \frac{1}{1-\rho} \sum_{d, e \ge 1} \mu(d)\mu(e) \left( \rho^{\max(d, e)} - \rho^{[d, e]} \right). \quad}
 \tag{11}
$$
The linear term $L_X$ is unconditionally bounded by:
$$
 |L_X| \le \sum_{N \ge 1} N \rho^N = \frac{\rho}{(1-\rho)^2} \le \left( 1 + \frac{X}{2} \right)^2 = \frac{X^2}{4} + X + 1.
 \tag{12}
$$
Therefore:
$$
 \boxed{\quad \left| \mathcal{E}_X - D_X \right| \le \left( 1 + \frac{X}{2} \right)^2. \quad}
 \tag{13}
$$

### Mathematical Consequence

The Riemann Hypothesis is equivalent to the Mertens bound $M(N) = O_\varepsilon(N^{1/2+\varepsilon})$, which is equivalent to $D_X = O_\varepsilon(X^{2+\varepsilon})$.
Because $\mathcal{E}_X$ differs from $D_X$ by at most $O(X^2)$, any attempt to bound the boundary Stokes escape $\mathcal{E}_X$ to order $O_\varepsilon(X^{2+\varepsilon})$ is mathematically identical to the original quadratic Mertens problem.

The homological cancellation of interior LCM cubes $\sum_{[d, e]=\ell} \mu(d)\mu(e) = \mu(\ell)$ only collapses the sub-horizon pairs to the linear mass $M(N) = O(N)$. It completely fails to reduce the super-horizon pairs, whose boundary escape carries the entire quadratic mass $M(N)^2 - M(N)$.
