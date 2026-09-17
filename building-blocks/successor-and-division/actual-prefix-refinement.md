# Exact carry refinement on the diagonal integer orbit

This note proves exact finite identities for the actual integer prefix, its residue refinements and the empirical change of measure. It gives a counterexample to transferring Haar cancellation to the conditioned integer orbit. The [Möbius division companion](../prime-distribution/finite-prime-mobius-consumer.md) preserves a different exact arithmetic construction. All proofs are written; no RH bound or Lean formalization is claimed.

## The orbit and the proposed mechanism

Embed the positive integers by

$$
\iota(n)=(n,(n)_p)\in\mathbb R\times\prod_p\mathbb Z_p,
\qquad n=1,2,\ldots.
$$

Successor adds the same integer one in every coordinate. The state 1 is the distinguished beginning and the endpoint of strict integral division. For a divisor d of n, division takes the entire diagonal state to $\iota(n/d)$. The zero residue modulo m is represented below by a=m, so the counting interval remains $1\le n\le N$ and never silently changes to $0\le n<N$.

Fix integers $N\ge1$ and $m\ge1$. Let $\mathcal F_m$ be the residue partition modulo m. If a prime p does not divide m, the refinement $m\to mp$ reveals its first residue coordinate. If $p\mid m$, it reveals a further p-adic digit. The formulas also hold for any integral refinement factor p at least two. A chronological choice is $m_y=\operatorname{lcm}(1,\ldots,\lfloor y\rfloor)$, which changes precisely at prime powers. The full embedding has all coordinates already; "revealing" a prime is a filtration operation, not a claim that a new mathematical coordinate is created.

The hypothesis tested here is that Haar cancellation between successive carry refinements might survive conditioning on the actual real interval, leaving a useful signed martingale. The exact law below permits testing that hypothesis without independent random residues.

## The exact refinement law

For $1\le a\le m$, define

$$
C_m(N,a)=\#\{1\le n\le N:n\equiv a\pmod m\},
\qquad D_m(N,a)=C_m(N,a)-N/m.
$$

The ordered children of a are $a+mj$, $0\le j<p$. Define their contrast

$$
\eta_{m,p}^N(a,j)
=D_{mp}(N,a+mj)-\frac1pD_m(N,a)
=C_{mp}(N,a+mj)-\frac1p C_m(N,a).
\tag{1}
$$

Write $C_m(N,a)=pq_a+t_a$, $0\le t_a<p$. The occurrences in this parent are exactly
$a,a+m,\ldots,a+[C_m(N,a)-1]m$. Their successive child labels are $0,1,\ldots,p-1,0,\ldots$. Consequently

$$
\boxed{\eta_{m,p}^N(a,j)=\mathbf1_{j<t_a}-t_a/p.}
\tag{2}
$$

Thus

$$
\sum_j\eta(a,j)=0,
\qquad \sum_j\eta(a,j)^2=\frac{t_a(p-t_a)}p.
\tag{3}
$$

This derives the Archimedean cutoff defect under each new prime or prime power, including its phase. For $(m,p)=1$, the child with p-adic residue b is the unique j satisfying $a+mj\equiv b\pmod p$. Replacing that phase by an independent uniform label changes the object.

There is an exact successor law. Put $a_*=1+(N\bmod m)$ and $j_*=\lfloor N/m\rfloor\bmod p$. Then

$$
\eta_{m,p}^{N+1}(a,j)-\eta_{m,p}^{N}(a,j)
=\mathbf1_{a=a_*}(\mathbf1_{j=j_*}-1/p).
\tag{4}
$$

One actual successor step moves one signed child contrast. This retains chronological addition; no limit or equidistribution is used.

## A joint constraint imposed by the same real endpoint

Write $N=mQ+R$, $0\le R<m$, and $s=Q\bmod p$. Set

$$
h_s(j)=\mathbf1_{j<s}-s/p,
\qquad g_s(j)=\mathbf1_{j=s}-1/p.
$$

Because $C_m(N,a)=Q+\mathbf1_{a\le R}$, equation (2) gives

$$
\boxed{\eta_{m,p}^N(a,j)=h_s(j)+\mathbf1_{a\le R}g_s(j).}
\tag{5}
$$

It remains valid for $s=p-1$, since $h_{p-1}+g_{p-1}=0$. The entire m by p array has only two possible rows and rank at most two. Distinct parent rows differ by one common endpoint contrast. CRT compatibility and uniform child measure alone do not enforce this law: it comes from the contiguous real interval and its specified starting state. For comparison, the ordered prefix $\{1,2\}$ and the set $\{1,4\}$ have the same parent counts modulo 2, but occupy different children modulo 4.

For any weights w(a), let $W(u)=\sum_{a\le u}w(a)$. The signed joint contrast is therefore exactly

$$
\boxed{\sum_{a=1}^m w(a)\eta(a,j)=W(m)h_s(j)+W(R)g_s(j).}
\tag{6}
$$

This is a proved deterministic coupling across all parents. It supplies no bound for either signed prefix. With $w(a)=\mu(a)$, the quantities on the right are the actual Mertens sums $M(m),M(R)$. These are weights on the chosen parent representatives: generally $\mu(a)\ne\mu(a+mk)$, so this formula must not be mistaken for a sum with the Möbius value of every visited integer. Their squared child norm is

$$
\frac{s(p-s)M(m)^2-2sM(m)M(R)+(p-1)M(R)^2}{p}.
\tag{7}
$$

Taking Q divisible by p makes the whole contrast $M(R)g_0$. A proposed uniform square-root estimate for this specialization already contains the corresponding Mertens estimate. The formula exposes that missing cancellation instead of supplying it.

The p-divisible child has a parent-dependent phase. No fixed sign survives that selection. For m=2, p=3 and weights $\mu(1)=1,\mu(2)=-1$, summing (1) only at children divisible by 3 gives $2/3$ at N=3 and $-1/3$ at N=7. These are actual-prefix counterexamples to a fixed-sign assertion, not counterexamples to RH.

## The empirical conditioning obstruction

Let $\nu_N$ be the uniform probability measure on the actual N states. Conditional on an occupied parent a, its child probabilities are $C_{mp}(N,a+mj)/C_m(N,a)$. Equations (1) and (3) give

$$
\boxed{\mathbb E_{\nu_N}[\eta(a,J)\mid a]
=\frac{t_a(p-t_a)}{pC_m(N,a)}.}
\tag{8}
$$

Indeed, substitute $C_{mp}=C_m/p+\eta$; the linear sum vanishes and the square sum remains. Averaging over occupied parents yields

$$
\boxed{\mathbb E_{\nu_N}\eta
=\frac1{Np}\sum_{a=1}^m t_a(p-t_a)\ge0.}
\tag{9}
$$

Equality holds if and only if $mp\mid N$. If $0<R<m$, the parent lengths Q and Q+1 cannot both be divisible by p. If R=0, equality requires $p\mid Q$. Thus every incomplete refined period has strictly positive empirical mean for its Haar-centered carry contrast. It is not an empirical martingale difference.

The size of the mismatch is exact. On the uniform residue space modulo m, the density of the empirical residue law is

$$
\rho_m^N(a)=m C_m(N,a)/N.
$$

With uniform averages as Haar integrals,

$$
\|\rho_m^N-1\|_{L^2(H)}^2=\frac{R(m-R)}{N^2},
\tag{10}
$$

and the lift of $\rho_m^N$ to modulus mp satisfies

$$
\boxed{\|\rho_{mp}^N-\rho_m^N\|_{L^2(H)}^2
=\frac m{N^2}\sum_a t_a(p-t_a).}
\tag{11}
$$

The proof of (10) uses $C_m=Q+\mathbf1_{a\le R}$. For (11), the density difference at a child is $(mp/N)\eta(a,j)$; square and average over mp cells. The usual Haar Pythagoras identity is valid. The error is transferring that spatial identity to empirical conditional expectations without the change of measure.

For $m\ge N$, residues identify every actual integer in the interval, so $\mathcal F_m$ on $\nu_N$ is already the full sigma-field. Every later empirical conditional expectation of a fixed observable is unchanged. Nevertheless

$$
\|\rho_m^N-1\|_{L^2(H)}^2=m/N-1,
\quad
\|\rho_{mp}^N-\rho_m^N\|_{L^2(H)}^2=(p-1)m/N,
\quad
\mathbb E_{\nu_N}\eta=(p-1)/p.
\tag{12}
$$

At N=m=2 and p=3, the empirical refinement supplies zero new information, but the Haar squared innovation is 2 and the empirical mean of the contrast is 2/3. This disproves the proposed identification.

For the chronological prime-power filtration, saturation happens much earlier than the real horizon. Let $L_k=\operatorname{lcm}(1,\ldots,k)$. For $0\le j<k$, the integer $k\binom{k-1}{j}$ divides $L_k$: for each prime p its valuation is

$$
\sum_{a\ge1}\left[\lfloor k/p^a\rfloor-\lfloor j/p^a\rfloor-\lfloor(k-1-j)/p^a\rfloor\right],
$$

with each summand zero or one, and at most $\lfloor\log_p k\rfloor$ possible nonzero summands. Therefore

$$
L_k\ge k\max_j\binom{k-1}{j}\ge2^{k-1}.
$$

The last inequality takes the maximum of k binomial coefficients whose sum is $2^{k-1}$. This is a standard lcm bound, also proved by [Farhi, Corollary 3](https://arxiv.org/pdf/0906.2295). Choose $k=\lceil\log_2N\rceil+1$; then $L_k\ge N$. Thus observing prime-power residues only through this logarithmic k already distinguishes every integer in $1,\ldots,N$. Later primes introduce multiplicative generators, but their residue observables on this fixed finite interval are already functions of the earlier full residue state. This is an information statement with the real interval given, not an algorithmic claim or a prime-distribution estimate.

For fixed N along any unbounded divisibility chain of moduli, the density martingale has mean one, its L2 norm diverges, and it converges to zero Haar-almost everywhere. It is not uniformly integrable. A direct proof notes that the occupied cylinder sets decrease and have Haar measures N/m once m>=N, so their intersection has measure zero. On the full profinite integers that intersection is the union of $n+K$, $1\le n\le N$, where $K=\bigcap_m m\widehat{\mathbb Z}$ for the selected chain. It consists of exactly the N embedded integers only when K=0, as for a divisibility-cofinal chain such as the chronological lcm filtration. For the chain $2^k$, the odd-adic coordinates remain unconstrained. This distinction does not affect the norm or almost-everywhere conclusions.

The two-row law and the positive empirical bias are nontrivial consequences of the ordered real cutoff. They do not generate signed prime cancellation. Thus Haar mean zero does not imply empirical conditional mean zero in this construction.

## Classical context and a quantitative distinction

The nested residue tower is an odometer. [Ferenczi, Kułaga-Przymus, Lemańczyk and Mauduit, *Substitutions and Möbius disjointness*, §3.1 and Remark 5.5](https://arxiv.org/pdf/1507.01123), describe the cyclic inverse-limit setting and establish Möbius disjointness for each fixed continuous odometer observable. It is a qualitative $o(N)$ statement, without a square-root bound uniform over observables whose resolution grows with $N$. Ordered successor carries are also treated in [Berthé, Frougny, Rigo and Sakarovitch, *The carry propagation of the successor function*, §5](https://arxiv.org/html/1907.01464v2).

The finite contrasts belong to the classical Haar construction. For a fixed parent, its $p$ child contrasts sum to zero and span a space of dimension $p-1$; they are not an orthogonal list. An orthogonal basis can be chosen in that space. [Kozyrev](https://arxiv.org/abs/math-ph/0012019) gives the nearby p-adic Haar theory, and [Khrennikov, Kosyak and Shelkovich](https://arxiv.org/abs/1107.1700) develop adelic multiresolution. Product Haar measure is distinct from the counting measure of the diagonal interval. Kozyrev's digit-reversal correspondence also differs from sending the p-adic integer $n$ to the real number $n$.

The exact calculations above locate the change-of-measure term explicitly. A general conditional-expectation representation, such as [Rota's averaging-operator theorem](https://www.numdam.org/article/RSMUP_1960__30__52_0.pdf), does not remove it. No priority claim is made for the finite refinement identities, the binomial lcm estimate, or the martingale facts.

## Exact checks

The [standard-library checker](../../certificates/actual_prefix_refinement.py) enumerates actual integer prefixes independently of the floor formulas. It checks the child law, two-row law, empirical bias, density energies, equality condition and fixed opposite-sign examples with rational arithmetic. It also checks binomial divisibility and the logarithmic saturation threshold using integers. Run it with `--quick` for a shorter finite convention check, or without that option for the original full residue ranges. Its finite assertions support the transcription; the all-parameter proofs are given above.
