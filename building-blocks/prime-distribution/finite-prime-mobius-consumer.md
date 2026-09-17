# Exact Möbius consumer for finite-place endpoint defects

This note proves an exact Möbius division identity with a finite prime cutoff. Its remaining estimate is RH-equivalent. None of the identities proves cancellation.

Fix an integer N ≥ 1 and a finite real prime cutoff y ≥ 1. Write C_d(q) = floor(q/d), E_d(q) = C_d(q) − q/d, and q_n = floor(N/n). All q below are integers satisfying 0 ≤ q ≤ N. Let P⁺(1) = 1, and let Ψ(x,y) count positive integers at most x whose prime factors are at most y. Define

$$
\psi_y(N)=\sum_{p\le y}\log p\sum_{a\ge1}\mathbf1_{p^a\le N}.
$$

The residue n mod d determines whether d divides n. Along the integer diagonal its cutoff count is C_d(q). Therefore E_d(q) is the exact endpoint discrepancy of the zero residue class relative to density 1/d. The cutoff q_n comes from the divisor quotient, not from an independent residue sample.

## The elementary transform

For every positive integer d,

$$
\boxed{\sum_{n\le N}\mu(n)C_d(q_n)=\mathbf1_{d\le N},\qquad
\sum_{n\le N}\mu(n)E_d(q_n)=\mathbf1_{d\le N}-\frac1d.}\tag{1}
$$

Indeed, C_d(q_n) = floor(N/(nd)). Interchanging the two finite sums gives

$$
\sum_{n\le N/d}\mu(n)\left\lfloor\frac{N/d}{n}\right\rfloor
=\sum_{r\le N/d}\sum_{n\mid r}\mu(n)=\mathbf1_{N/d\ge1}.
$$

The second identity also uses the first at d = 1. This exposes an obstruction immediately. A signed consumer applied separately to one fixed-modulus endpoint defect becomes a deterministic threshold. There is no unproved cancellation within that calculation.

For example, a single p-adic refinement has

$$
\sum_{n\le N}\mu(n)\left[C_{p^k}(q_n)-p^{-1}C_{p^{k-1}}(q_n)\right]
=\mathbf1_{p^k\le N}-p^{-1}\mathbf1_{p^{k-1}\le N}.
$$

## Finite-prime bridge

Define

$$
H_y(q)=\sum_{p\le y}\log p\sum_{a\ge1}C_{p^a}(q)
-\sum_{\substack{d\le q\\P^+(d)\le y}}C_d(q)+2\gamma q.
\tag{2}
$$

Every sum is finite. Equivalently, H_y is the cumulative sum over m ≤ q of

$$
\sum_{p\le y}v_p(m)\log p
-\prod_{p\le y}[v_p(m)+1]+2\gamma.
$$

For m ≤ N these observables use only residues modulo

$$
Q_y(N)=\prod_{p\le\min(y,N)}p^{\lfloor\log_pN\rfloor}.
$$

The product in the divisor term counts the y-smooth divisors of m. Its multiplicative structure is essential. Arbitrary cylinder functions on the same residue space would not give the next identity.

Applying (1) to (2) proves

$$
\boxed{S_y(N):=\sum_{n\le N}\mu(n)H_y(q_n)
=\psi_y(N)-\Psi(N,y)+2\gamma.}\tag{3}
$$

At y ≥ N, the first term in (2) is log(q!), the divisor term is Σ_{d≤q} floor(q/d), and (3) becomes the complete division identity

$$
\sum_{n\le N}\mu(n)H(q_n)=\psi(N)-N+2\gamma.
$$

This provides an exact arithmetic consumer of the finite-prime refinement. The negative output is a smooth-number counting function, so refinement carries a specific multiplicative boundary term.

## A centered endpoint version

For a fixed global N, put

$$
B_{y,N}=\sum_{\substack{p\le y,a\ge1\\p^a\le N}}\frac{\log p}{p^a}
-\sum_{\substack{d\le N\\P^+(d)\le y}}\frac1d,
$$

$$
D_{y,N}(q)=\sum_{\substack{p\le y,a\ge1\\p^a\le N}}\log p\,E_{p^a}(q)
-\sum_{\substack{d\le N\\P^+(d)\le y}}E_d(q).
$$

Terms with d > q have C_d(q) = 0. Their discrepancy and linear term cancel exactly. Thus

$$
H_y(q)=(B_{y,N}+2\gamma)q+D_{y,N}(q),
$$

and

$$
\boxed{B_{y,N}+\sum_{n\le N}\mu(n)D_{y,N}(q_n)
=\psi_y(N)-\Psi(N,y).}\tag{4}
$$

In particular,

$$
\boxed{B_{N,N}+\sum_{n\le N}\mu(n)D_{N,N}(q_n)=\psi(N)-N.}\tag{5}
$$

The linear correction B must be retained. Centering each residue count and silently discarding this correction would break the bridge.

For completeness, B_{N,N} = Σ_{d≤N}(Λ(d)−1)/d. This equality identifies the correction; it is not a bound on it.

## What adding one prime does

Let p⁻ mean that only primes strictly smaller than p are admitted. Define the shell count

$$
A_p(N)=\#\{d\le N:P^+(d)=p\}
=\sum_{\substack{a\ge1\\p^a\le N}}\Psi(N/p^a,p^-).
\tag{6}
$$

The second equality follows from the unique factorization d = p^a r, with a ≥ 1 and P⁺(r) < p. The exact increment in (3) is

$$
\boxed{S_p(N)-S_{p^-}(N)
=\log p\,\lfloor\log_pN\rfloor-A_p(N).}\tag{7}
$$

The corresponding centered finite-place refinement defect is

$$
R_{p,N}(q)=\log p\sum_{\substack{a\ge1\\p^a\le N}}E_{p^a}(q)
-\sum_{\substack{d\le N\\P^+(d)=p}}E_d(q),
$$

with correction

$$
\beta_{p,N}=\log p\sum_{\substack{a\ge1\\p^a\le N}}p^{-a}
-\sum_{\substack{d\le N\\P^+(d)=p}}d^{-1}.
$$

Equation (1) proves

$$
\boxed{\beta_{p,N}+\sum_{n\le N}\mu(n)R_{p,N}(q_n)
=\log p\,\lfloor\log_pN\rfloor-A_p(N).}\tag{8}
$$

At y = 1, B = −1 and D = 0. Therefore the full endpoint error is the sum of these prime refinements, including that base term,

$$
\boxed{\psi(N)-N=-1+\sum_{p\le N}\left[\beta_{p,N}
+\sum_{n\le N}\mu(n)R_{p,N}(q_n)\right].}\tag{9}
$$

The prime refinement creates all newly admissible smooth divisors; Möbius convolution removes the outer divisor count and retains their exact endpoint count. It remains an identity, not a gain over the prime number theorem error.

## The boundary left by a finite prime cutoff

The exact remainder between the full consumer and a cutoff y is

$$
T_y(N)=\psi_{>y}(N)-[N-\Psi(N,y)]
=\sum_{y<p\le N}\left[\log p\,\lfloor\log_pN\rfloor-A_p(N)\right].
\tag{10}
$$

Consequently,

$$
\psi(N)-N=B_{y,N}+\sum_{n\le N}\mu(n)D_{y,N}(q_n)+T_y(N).
\tag{11}
$$

When y ≥ √N, every integer with largest prime factor p > y has the form pm with m < p, and no second factor p occurs. Hence

$$
\boxed{T_y(N)=\sum_{y<p\le N}\left[\log p-\left\lfloor\frac Np\right\rfloor\right],\qquad y\ge\sqrt N.}\tag{12}
$$

Equation (12) is a particularly concrete missing boundary estimate. Its summands can have either sign, depending on N and p. The identity supplies no reason to replace their signed sum by a square-root bound.

A fixed y cannot solve the problem through its local contribution alone. The elementary estimates

$$
\psi_y(N)\le\pi(y)\log N,\quad
\Psi(N,y)\le\prod_{p\le y}[1+\lfloor\log_pN\rfloor]
$$

show that S_y(N) grows at most as a polynomial in log N for fixed y. Almost the entire unsolved error then sits in T_y(N). A moving prime cutoff and a uniform cancellation argument are required.

## The exact remaining estimate

One precise sufficient obligation is to prove, without assuming RH or a Mertens estimate equivalent to it,

$$
\left|-1+\sum_{p\le N}\left[\beta_{p,N}
+\sum_{n\le N}\mu(n)R_{p,N}(\lfloor N/n\rfloor)\right]\right|
\ll_\varepsilon N^{1/2+\varepsilon}
\quad\text{for every }\varepsilon>0.
\tag{13}
$$

By (9), this is exactly the usual RH-equivalent bound for ψ(N)−N. Integer endpoints suffice because ψ(x) is constant between consecutive integers. The standard equivalence is recorded in [NIST DLMF, equation 25.16.4](https://dlmf.nist.gov/25.16.E4). No literature claim is needed for identities (1) through (12); their proofs are above.

For a truncated strategy, the obligation is the same bound on the entire right side of (11), including T_y. Bounding a Haar energy or the unweighted magnitude of each E_d does not establish (13). The shared quotient q_n correlates the endpoints, while the μ(n) signs and the multiplicative shell terms must remain in the estimate.

The stronger familiar target O(√N log²N) also suffices. The original primary-source paper for explicit RH-conditional Chebyshev error estimates is [Lowell Schoenfeld, *Sharper bounds for the Chebyshev functions θ(x) and ψ(x). II*, 1976](https://www.ams.org/mcom/1976-30-134/S0025-5718-1976-0457374-X/). This note does not rely on that stronger formulation or an explicit constant.


Let $J_p(N)=S_p(N)-S_{p^-}(N)=\lfloor\log_p N\rfloor\log p-A_p(N)$. The next estimates preserve the actual shell count.

## Prime increments have both signs

Both signs occur at the same real cutoff already at N = 3:

$$
J_2(3)=\log2-1<0,\qquad J_3(3)=\log3-1>0.
$$

The inequalities follow from 2 < e < 3. For every N ≥ 2,

$$
J_2(N)=\lfloor\log_2N\rfloor(\log2-1)<0,
$$

because the entire largest-prime shell at 2 consists of powers of 2. Consequently, the shared cutoff does not force nonnegativity of prime refinements.

The raw triangle expression is

$$
\sum_{p\le N}\left[\lfloor\log_pN\rfloor\log p+A_p(N)\right]
=\psi(N)+N-1\ge N-1.
$$

This observation does not discard any shell term. A stronger result follows.

## Absolute prime increments have linear total cost

For every integer N ≥ e⁶⁴,

$$
\boxed{\sum_{p\le N}|J_p(N)|\ge\frac{\log2}{8}N.}\tag{14}
$$

Here is an elementary proof with deliberately loose constants. Put t = log N and y = 4N/t. For t ≥ 64, y > √N and log y ≥ t/2. If p > y, then p² > N. An integer at most N with largest prime factor p is uniquely pm with m < p. Hence its exact shell count is

$$
A_p(N)=\left\lfloor\frac Np\right\rfloor<\frac t4,
$$

and

$$
J_p(N)=\log p-\left\lfloor\frac Np\right\rfloor
\ge\tfrac12\log p>0.
\tag{15}
$$

It remains to bound the prime log sum on this interval. Denote the elementary prime sum by

$$
P(x)=\sum_{p\le x}\log p.
$$

The central binomial coefficient gives, for each positive integer m,

$$
\psi(2m)\ge\log\binom{2m}{m}
\ge2m\log2-\log(2m+1).
$$

For the first inequality, each summand in

$$
v_p\binom{2m}{m}
=\sum_{a\ge1}\left[\left\lfloor\frac{2m}{p^a}\right\rfloor
-2\left\lfloor\frac m{p^a}\right\rfloor\right]
$$

is either zero or one. Therefore the binomial coefficient divides lcm(1,…,2m). The second inequality follows because the central coefficient is the largest of the 2m + 1 coefficients whose sum is 2²ᵐ.

Taking m = floor(N/2) and bounding the contribution of higher prime powers by √N log N yields

$$
P(N)\ge(N-1)\log2-\log(N+1)-\sqrt N\log N
\ge\tfrac12(\log2)N\qquad(N\ge e^{64}).
\tag{16}
$$

The final numerical threshold follows directly by dividing by N. The error is at most

$$
(t+2\log2)e^{-t}+te^{-t/2}<\tfrac12\log2\qquad(t\ge64).
$$

For an upper bound, every prime in (m,2m] divides the central binomial coefficient, so

$$
P(2m)-P(m)\le2m\log2.
$$

Summing this inequality at powers of two gives, for real x ≥ 1,

$$
P(x)\le4(\log2)x.
\tag{17}
$$

In particular,

$$
P(y)\le\frac{16\log2}{t}N\le\tfrac14(\log2)N.
$$

Combining (15), (16), and (17) proves

$$
\sum_{p\le N}|J_p(N)|
\ge\sum_{y<p\le N}J_p(N)
\ge\tfrac12[P(N)-P(y)]
\ge\tfrac18(\log2)N.
$$

This proof uses the actual cutoff shell A_p(N) = floor(N/p) on the selected prime interval. It does not replace the shell weights by free variables or independent residue samples. The estimate is a lower bound on the cost of discarding signs, not an upper bound on the signed error.

## Attribution and exact verification

These identities use classical Möbius inversion and the largest-prime decomposition of smooth numbers. The lower bound uses the classical central-binomial proof of Chebyshev estimates. They preserve a different mechanism from the failed empirical martingale in [actual-prefix refinement](../successor-and-division/actual-prefix-refinement.md).

[Friedlander and Iwaniec, *Asymptotic sieve for primes*, hypothesis B and pages 1043–1045](https://arxiv.org/pdf/math/9811186), make a related methodological distinction: sieve remainder control and a signed bilinear hypothesis are separate inputs. That result is not an impossibility theorem for the actual sum here. The exact linear lower bound (14) only excludes discarding the signs of the complete prime increments; it does not exclude cancellation between them.

The [exact checker](../../certificates/finite_prime_mobius_consumer.py) treats each $\log p$ and $\gamma$ as an independent formal symbol. Its 13,130 formal-coefficient and rational endpoint assertions through $N=100$ pass, including cutoff terms with $d>N$ and the largest-prime shell identity. No numerical logarithm is used in those checks. The all-cutoff identities and the linear lower bound follow from the written proofs. No new mathematical priority or Lean formalization is claimed.
