# Prime-clique cutoffs and their failure in the real critical strip

This note proves exact birth and limit laws for a particular finite prime-commutation graph. These are applications of finite Euler expansion and trace-monoid combinatorics. No publication-priority claim is made, and the results are written proofs, not Lean formalizations.

Let $\Gamma_N$ have vertices the primes at most $N$, with an edge between distinct primes $p,q$ when $pq\le N$. Define

```math
C_N(\mathbf z)=\sum_{F\text{ a clique}}(-1)^{|F|}\prod_{p\in F}z_p,
\qquad P_y(s)=\prod_{p\le y}(1-p^{-s}).
```

The empty clique contributes 1. The specialization $z_p=p^{-s}$ uses the real logarithm of $p$.

## Exact births

For $N\ge2$,

```math
C_N-C_{N-1}=
\begin{cases}
-z_N,&N\text{ prime},\\
z_pz_q\prod_{\ell<p}(1-z_\ell),&N=pq,\ p<q\text{ distinct primes},\\
0,&\text{otherwise}.
\end{cases}
```

At a prime birth the new vertex is isolated. A new edge can appear only at a product $pq$ of two distinct primes. A new clique must contain both endpoints. Its remaining vertices are exactly an arbitrary subset of primes below $p$: adjacency to $q$ forces this restriction, and every subset satisfying it is a clique. This proves the formula, including all higher cliques.

Grouping the finite Euler product by its two largest factors gives

```math
P_N(s)-C_N(s)=\sum_{\substack{p<q\le N\\pq>N}}
(pq)^{-s}\prod_{\ell<p}(1-\ell^{-s}).
```

Equivalently, grouping cliques by their largest vertex gives

```math
C_N(s)=P_{\sqrt N}(s)-\sum_{\sqrt N<p\le N}p^{-s}P_{N/p}(s).
```

All indices in prime sums and products are prime. These are identities of finite polynomials; their validity does not require analytic continuation.

## Two different limiting regimes

Every squarefree integer at most $N$ occurs in $C_N$ with its ordinary Möbius coefficient. Every omitted squarefree monomial has product greater than $N$. Therefore, for $\sigma=\Re s>1$,

```math
|C_N(s)-1/\zeta(s)|\le\sum_{n>N}n^{-\sigma}
\le \frac{N^{1-\sigma}}{\sigma-1}.
```

In contrast, for every real $0<\sigma<1$,

```math
C_N(\sigma)\longrightarrow-\infty,
\qquad C_N(\sigma)^{-1}\longrightarrow0.
```

Here is a short proof using the prime number theorem. Retain only the missing pairs $(2,q)$ with $N/2<q\le N$. The finite comparison above has positive summands for real $\sigma>0$, so

```math
C_N(\sigma)\le1-2^{-\sigma}N^{-\sigma}
\bigl(\pi(N)-\pi(N/2)\bigr).
```

The prime number theorem gives $\pi(N)-\pi(N/2)\sim N/(2\log N)$. This proves divergence, uniformly on each compact subinterval of $(0,1)$. A Chebyshev bound in a larger fixed-ratio interval also suffices.

Since $\zeta(\sigma)<0$ throughout $(0,1)$, the reciprocal cutoffs do not converge there to actual zeta. The sign follows directly from the alternating-series representation: its numerator is positive and $1-2^{1-\sigma}<0$.

For all sufficiently large $N$, the greatest positive real zero $\rho_N$ of $C_N$ exists and satisfies $\rho_N\to1$. Indeed, $C_N(1-\varepsilon)<0$ eventually, whereas the preceding uniform approximation and

```math
|1/\zeta(s)|\ge1/\zeta(1+\varepsilon)
\quad(\Re s\ge1+\varepsilon)
```

exclude every zero in that right half-plane for large $N$ and give positivity on its real axis. Continuity supplies a zero between $1-\varepsilon$ and $1+\varepsilon$. Each fixed entire Dirichlet polynomial tends to 1 on the positive real axis at infinity, so its real zero set has a greatest positive element once nonempty. This proves the limit without asserting simplicity or monotonicity.

## Relation to integer histories and topology

Start with vertices $1,\ldots,N$, successor edges $n\to n+1$, and upward divisor edges $n\to mn$. Attach every division-composition triangle and every affine relation $S_nU_{m,n+1}=U_{m,n}S_{mn}\cdots S_{m(n+1)-1}$ whose vertices stay inside the cutoff. Collapsing the successor tree identifies all edges of a fixed multiplier $m$ with a generator $g_m$. The remaining relations are $g_bg_a=g_{ab}$ for $ab\le N$.

Factoring each $m$ into primes reduces this presentation to

```math
\langle g_p:p\le N\mid [g_p,g_q]=1\text{ if }pq\le N\rangle.
```

To check the converse, all prime divisors of any $m\le N$ commute pairwise, and their exponent product defines $g_m$ consistently. Thus this is precisely a right-angled Artin group on $\Gamma_N$, with abelianization $\mathbb Z^{\pi(N)}$.

The corresponding positive trace monoid has formal generating function $1/C_N$, by Cartier–Foata inversion. This counts equivalence classes of prime words; it is not the generating function of literal integer paths with their successor clocks. At integer product $r\le N$ every prime divisor commutes with every other, so there is one class. Beyond the cutoff, extra order classes occur, for example two at product 10 when $N=6$.

The ordinary clique complex has no positive-dimensional homology: its nonisolated part is a cone on vertex 2, and its other vertices are isolated. A component born at a prime $p>2$ merges at cutoff $2p$. This ordinary homology does not determine the weighted clique polynomial. In particular, arbitrary monomial cell weights do not commute with the simplicial boundary.

## Attribution and scope

The group and monoid constructions use the established theory described by [Charney](https://arxiv.org/abs/math/0610668) and [Cartier–Foata](https://www.mat.univie.ac.at/~slc/books/cartfoa.html). The analytic comparison uses the classical [Euler product](https://dlmf.nist.gov/25.2.E11), [alternating-series continuation](https://dlmf.nist.gov/25.2.E3), and prime number theorem. The deductions specific to this cutoff are the displayed birth law and limiting mismatch. They rule out direct continuation by these unmodified reciprocals; they give no zero-location theorem for actual zeta.
