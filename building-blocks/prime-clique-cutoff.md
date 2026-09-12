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


## The full two-complex and its metric

Fix an integer N>=2. The vertices of X_N are 1,...,N. There are successor edges S_n from n to n+1 for n<N, and one edge for every strict division mn to n, with m>=2 and mn<=N. For writing cellular boundaries orient the latter edge in reverse, as U_(m,n) from n to mn. This geometric reversal permits an attaching loop to traverse an edge backwards; it does not change the allowed directed history moves, which remain successor and strict division.

Attach the following cells whenever the displayed maximum endpoint is at most N:

$$
 T_{a,b,n}:\quad U_{b,n}\,U_{a,bn}=U_{ab,n},
       \qquad a,b\ge2,\quad abn\le N, \tag{A1}
$$
$$
 F_{m,n}:\quad S_n\,U_{m,n+1}
       =U_{m,n}\,S_{mn}S_{mn+1}\cdots S_{m(n+1)-1},
       \quad m\ge2,\quad m(n+1)\le N. \tag{A2}
$$

Products in A1-A2 are paths read from left to right. A1 is the triangle for composition of divisions, reversed geometrically. A2 says first succeed and then dilate equals first dilate and then succeed m times. Every intermediate endpoint on either boundary lies in the cutoff. There is one triangle for each ordered triple (a,b,n), including the distinct orderings when a and b differ. No higher cells are attached in X_N.

The triangle construction is the two-dimensional part of the usual nerve/incidence treatment of a divisibility category. It is not a new Möbius inversion principle. The affine cells are added to that actual finite history graph. They are not relations saying that any two paths with the same endpoints must agree.

The group calculation above applies to this complete set of cells. It also determines the cellular ranks.

In particular H_1(X_N;Z) is free of rank pi(N). Define

$$
 c_N=\sum_{n\le N}(\tau(n)-1),\quad
 t_N=\sum_{m=4}^N\lfloor N/m\rfloor(\tau(m)-2).
$$

There are c_N division edges, c_N-(N-1) affine cells and t_N composition triangles. After the successor tree is collapsed, the cellular boundary matrix has rank c_N-pi(N), since the abelianization of the prime-generator presentation above is free on the prime generators. No 3-cells exist, so its kernel is free and

$$
 \boxed{\operatorname{rank}H_2(X_N;\mathbb Z)
       =t_N-(N-1)+\pi(N).} \tag{A5}
$$

This keeps all redundant triangles and affine cells. At N=8, for example, H_2(X_N) has rank 3, while the Salvetti group model has one commuting-pair 2-cell and H_2 of rank 1. The original cellular complex therefore must not be replaced by a clique Euler characteristic without specifying a different construction.

The exact checker builds both boundary matrices and verifies partial_1 partial_2=0. Smith normal form of the collapsed boundary matrix has only unit nonzero diagonal entries at the checked cutoffs, confirming the absence of H_1 torsion. Some resulting data are:

| N | Division edges | Triangles | Affine cells | rank H1 | rank H2 |
|---:|---:|---:|---:|---:|---:|
| 4 | 4 | 1 | 1 | 2 | 0 |
| 6 | 8 | 3 | 3 | 3 | 1 |
| 8 | 12 | 6 | 5 | 4 | 3 |
| 12 | 23 | 16 | 12 | 5 | 10 |
| 15 | 30 | 20 | 16 | 6 | 12 |
| 30 | 81 | 84 | 52 | 10 | 65 |

There is a positive operator intrinsic to this actual chain complex. With unit Euclidean metrics on its finite cellular chains,

$$
 \Delta_1=\partial_1^*\partial_1+\partial_2\partial_2^*\ge0,
 \qquad \dim\ker\Delta_1=\pi(N). \tag{A6}
$$

Its quadratic form is the sum of two squared norms. Prime-period cocycles take value 0 on successors and nu_p(m) on U_(m,n). Their periods on the loop formed by succeeding from 1 to q and dividing back are -delta_(p,q). Thus these nonzero prime classes cannot be exact gradients. A6 is finite cellular positivity; it is not the signed arithmetic form.

## 3. Scalar flatness retains characters, while the old weights have curvature

Assign arbitrary nonzero scalar edge transports and require equality of transport along both sides of every cell. A vertex gauge makes all successor transports equal to 1, because they form a spanning tree. A2 then makes the dilation transport independent of the basepoint, say c_m. A1 becomes

$$
 c_{ab}=c_a c_b\quad(ab\le N).
$$

Every choice of nonzero prime values c_p extends by factorization and satisfies these conditions. Flatness therefore leaves arbitrary prime characters. It does not gauge arithmetic away. Gauging every transport to 1 would require trivial holonomy on all these surviving loops, an additional condition not present in A1-A2.

The weights of the previous renewal experiment illustrate the distinction. Give every successor weight x and each original downward division by m weight y m^(-s), with x,y nonzero. Geometric reverse transport on U_(m,n) is y^(-1)m^s. The holonomy around the oriented cells is

$$
 \operatorname{Hol}(T_{a,b,n})=y^{-1},\qquad
 \operatorname{Hol}(F_{m,n})=x^{1-m}. \tag{A7}
$$

Reversing the first boundary gives y instead. At N>=4 the cells with a=b=m=2,n=1 already force y=1 and x=1 for this uniform family to be flat. The old signed division choice y=-1 and its clock damping 0<x<1 therefore do not descend to a scalar local system on X_N. Their nonzero face curvature is retained in A7. Using them as if they defined a flat twisted cellular chain complex would give a boundary-square defect rather than partial²=0.

For x=y=1 the surviving character from the arithmetic quotient cost is c_m=m^s. It is generally nontrivial. In contrast, weighting every edge by a common endpoint potential, including successors by ((n+1)/n)^s, would be a pure gauge and would erase all loop holonomy. That is a different choice. No thin-endpoint identification or endpoint-potential assumption is imposed here.

The clique observable above uses the positive arithmetic character and counts homotopy classes of actual directed loops. It does not claim to preserve the earlier signed determinant. Its signs arise from intrinsic monoid inversion.


## Counting classes and the finite positive trace

The distinguished return state remains 1. Consider the image in pi_1(X_N,1) of based paths that use only the original allowed directions, successor and downward strict division. After collapsing the successor tree, each division contributes a negative word in the prime generators. Conversely the elementary loop

$$
 a_p=(1\to2\to\cdots\to p\to1)
$$

represents g_p^(-1), so arbitrary concatenations of these loops realize every such negative prime word. The image is precisely the positive trace monoid on letters a_p with commuting pairs pq<=N, using the standard embedding of a positive graph monoid in its right-angled Artin group. Denote it by M_N.

This image is an intrinsic quotient of actual based directed loops. It is not the set of first-return representatives, and it need not retain their number of successor steps. The distinguished basepoint and all original edges remain in its definition. The prime generators emerge from the prime-generator presentation above; they were not used to remove edges before attaching cells.

For a nonempty trace, the possible terminal letters form a nonempty commuting set. The sum of $(-1)^{|F|}$ over its clique suffixes is zero; it is one for the empty trace. This proves $C_NH_N=1$ by the classical Cartier–Foata inversion used above. The clique terms belong to the monoid identity, not to the Euler characteristic of the redundant two-complex.

Counting classes gives an independent positive realization. On l²(M_N) define the diagonal operator

$$
 E_N\delta_w=\log r(w)\,\delta_w,\qquad
 \mathcal D(E_N)=\{f:\sum_w(\log r(w))^2|f(w)|^2<\infty\}.
$$

It is nonnegative and self-adjoint. The positive heat operator exp(-sigma E_N) is trace class wherever the defining positive series converges, with trace H_N(sigma). A sufficient condition is sum_(p<=N) p^(-sigma)<1, by domination by all free words. In particular sigma>=2 suffices uniformly in N, since sum_(p) p^(-2)<sum_(n>=2)1/(n(n-1))=1. Complex s in that convergence half-plane gives the usual analytic trace and the clique-inversion identity becomes an analytic equality.

This is positive thermal counting on a countable class space. It is not positivity of the signed Weil form, and analytic continuation of 1/C_N outside the convergence region need not be a positive trace. The distinction has an exact finite test. At N=30,

$$
 C_{30}(1)=-\frac{175602331}{3234846615}<0,
$$
$$
 C_{30}(2)=\frac{4230679694542079651}{6976155081717972150}>\frac35. \tag{A12}
$$

Continuity gives a real zero of C_30 in (1,2), hence a pole of its reciprocal. Its numerator is 1, so the pole cannot cancel. The positive counting series cannot represent that reciprocal throughout Re s>1. This rules out an all-cutoff holomorphic zeta identification on that half-plane. It does not rule out the common farther-right convergence region or the controlled large-N limit below.

The finite Laplacian A6 and the heat operator here are both positive for direct reasons. Neither has an independently established identification with the actual signed prime/archimedean form. Their positivity therefore meets the finite construction test while leaving the RH mechanism missing.

If a positive-series interpretation is desired for the eventual approximants at any fixed sigma>1, it also follows directly. The small-prime letters p<=sqrt N commute completely; their series is P_sqrtN(sigma)^(-1)<=zeta(sigma). Treat the remaining letters as separators between such commuting blocks, which overcounts trace classes. With b_N=sum_(p>sqrtN,p<=N) p^(-sigma), this bounds

$$
 H_N(\sigma)\le
 \frac{P_{\sqrt N}(\sigma)^{-1}}
 {1-b_N P_{\sqrt N}(\sigma)^{-1}}
$$

whenever the denominator is positive. For fixed sigma>1, b_N tends to zero, so this holds eventually and proves convergence of the positive class series itself. The complex extension uses absolute convergence on compact right half-planes. This does not remove the finite pole in A12; it explains why fixed-cutoff defects can coexist with the right-half-plane limit above.


## The minimum successor clock in each directed class

Fix an integer N >= 2 and the original directed graph on 1,...,N. Its edges are unit successors and all strict divisions md -> m. Use the affine and division-composition cells from the cell construction above, and let w be any element of the resulting positive trace monoid of based-loop classes. Write r(w) for the product of its prime letters, counted with multiplicity. The empty class has r=1. Let ell(w) be the minimum number of successor edges among actual directed based loops representing w.

Then

$$
 \ell(w)=\sum_{p\le N}v_p(r(w))(p-1). \tag{M1}
$$

Indeed, a loop starts and ends at 1, so its number A of successor steps equals the sum of all downward displacements:

$$
 A=\sum_{\text{division }md\to m}m(d-1).
$$

For integers a,b >= 2,

$$
 ab-1=(a-1)+(b-1)+(a-1)(b-1).
$$

Induction through the prime factors of d gives d-1 >= sum_p v_p(d)(p-1), strictly if d is composite. Every m is at least 1. The division labels multiply to r(w), since the prime-period cocycles are invariant under the attached cells. Summing these inequalities proves the lower bound in M1 for every representative.

For the upper bound, choose a prime word representing w and concatenate its elementary loops 1 -> 2 -> ... -> p -> 1. Each stays within the cutoff and uses p-1 successor edges. The resulting loop represents that exact trace class, even when other orders of its prime letters belong to different classes. It attains M1.

There is also an exact equality classification. A nonempty loop attains M1 only if every division has target 1 and prime quotient. Otherwise one of the preceding inequalities is strict. Thus every minimum-clock representative is a concatenation of elementary prime loops. This argument concerns actual directed representatives and does not replace a division edge by a succession of subtraction edges.

The minimum clock is consequently additive under class concatenation and does not detect which distinct prime letters commute. For formal prime variables, or numerical parameters inside a domain of absolute convergence, the clock-weighted class series is obtained from the same Cartier-Foata identity by the substitution

$$
 z_p=x^{p-1}p^{-s},\qquad
 H_N(x,s)=\left(\sum_{F\text{ a prime clique}}
 (-1)^{|F|}x^{\sum_{p\in F}(p-1)}\prod_{p\in F}p^{-s}\right)^{-1}.
 \tag{M2}
$$

For numerical x the convention here is x>0; formal x also makes sense. No convergence region beyond the applicable series domain is asserted. M2 is an intrinsic minimum-cost construction, but its result is a multiplicative letter weight. It recovers no additional ordering information or curvature from the original signed and clocked renewal determinant. The complete-commutation specialization is the usual damped Euler product. It supplies no new comparison with the actual signed RH form.


The [cellular and trace checker](certificates/integer-affine-cells.py) verifies the finite boundary matrices, Smith ranks, complete heap counts, clique shell and pole signs. The [minimum-clock checker](certificates/integer-affine-minimum-clock.py) checks integer shortest paths for $2\le N\le10$ and products at most $60$. It merges classes with the same product; the argument above proves the statement for each separate class. Both exact checks pass. No Lean formalization is claimed. The affine compatibility is classical, as in [Cuntz, section 2](https://arxiv.org/html/math/0611541); the finite two-complex here retains state $1$ and its boundary instead of imposing the extra operator-algebra quotient relations.
