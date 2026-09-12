# A successor-clock second-increment criterion for localized trace norm

Let $P$ be the negative-frequency Hardy projection on $L^2(\mathbb R)$, let $u$ be a measurable unit-modulus multiplier, and fix a real Schwartz observation $\chi$. Set

$$
N_\chi(u)=\|M_\chi(P-M_u^*PM_u)\|_1,
\qquad h_n=\log\left(1+\frac1{2n}\right),\quad n\ge1.
$$

For $v\in L^1(\mathbb R)$ define the literal point-sampled quantity

$$
\mathcal S(v)=\sum_{n\ge1}
\|v(\,\cdot+2h_n)-2v(\,\cdot+h_n)+v\|_1.
\tag{1}
$$

There are constants depending only on $\chi$ such that

$$
N_\chi(u)\le C\mathcal S(\chi u)+C_\chi,
\qquad
\mathcal S(\chi u)\le C N_\chi(u)+C_\chi.
\tag{2}
$$

In particular $M_\chi\Delta(u)$ is trace class if and only if (1) is finite for $v=\chi u$. The constants are uniform over the unitary multiplier. This is an $L^1$ second-increment criterion, distinct from the [$L^2$ first-increment energy](successor-clock-scattering-energy.md) that controls Hilbert–Schmidt norm. This is a written proof using Peller's classical theorem and an explicit sampling argument, not a Lean formalization.

## The primary trace-class theorem and localization

Peller's real-line theorem states that the commutator of the Hilbert transform with multiplication by a BMO function $v$ belongs to $\mathcal S_p$ if and only if $v\in B^{1/p}_{p,p}(\mathbb R)$. The case $p=1$ is the homogeneous $B^1_{1,1}$ criterion used here. The Hardy projection differs from the Hilbert transform by a fixed scalar and the identity, so its commutator has the same criterion. [V. V. Peller, *Besov spaces in operator theory*, Theorem 5.7, printed p. 17; the finite-difference description is in section 2.2, printed p. 6](https://arxiv.org/pdf/2402.09853).

The survey traces the trace-class Hankel theorem to [Peller, *Hankel operators of class $\mathfrak S_p$ and their applications*, 1980; English translation 1982](https://www.mathnet.ru/php/archive.phtml?jrnid=sm&option_lang=eng&paperid=2817&wshow=paper). We use the real-line formulation above, including both Hankel blocks of the commutator.

For $v\in L^1$, there is no polynomial ambiguity in the homogeneous space. Its inhomogeneous norm is equivalent to

$$
\|v\|_1+\int_0^\infty\frac{\|\Delta_h^2v\|_1}{h^2}\,dh,
\qquad \Delta_hv=v(\,\cdot+h)-v.
\tag{3}
$$

The part $h\ge1$ is at most $4\|v\|_1$. Quantitatively, Peller's criterion gives

$$
\|v\|_1+\|[P,M_v]\|_1\asymp \|v\|_{B^1_{1,1},\mathrm{inhom}}.
\tag{4}
$$

One can also obtain the norm equivalence from the membership theorem by the closed graph theorem. Both the $L^1$ plus Besov norm and the $L^1$ plus commutator trace norm are complete on their common space. Closedness of the latter follows by pairing the commutator with smooth test vectors: its distributional pairing is continuous under $L^1$ convergence of $v$. Boundedness of this commutator characterizes BMO modulo constants, so the membership theorem applies to its entire domain. Both norms control $L^1$, and hence the identity between the two Banach spaces has closed graph.

For the actual localization there is an exact identity

$$
M_\chi[P,M_u]=[P,M_{\chi u}]-[P,M_\chi]M_u.
\tag{5}
$$

Also $\Delta(u)=-M_u^*[P,M_u]$, and $M_u$ commutes with $M_\chi$. Thus

$$
\left|N_\chi(u)-\|[P,M_{\chi u}]\|_1\right|
\le\|[P,M_\chi]\|_1<\infty.
\tag{6}
$$

These identities remain valid as statements of simultaneous finiteness. Moreover $\|\chi u\|_1=\|\chi\|_1$ is fixed. It remains to prove that the irregular successor samples recover (3).

## Why these point samples suffice

For every $v\in L^1(\mathbb R)$,

$$
\|v\|_1+\mathcal S(v)
\asymp\|v\|_{B^1_{1,1},\mathrm{inhom}}
\asymp\|v\|_1+\int_0^\infty\frac{\|\Delta_h^2v\|_1}{h^2}\,dh.
\tag{7}
$$

Here is a proof that addresses sampling directly. Choose a smooth dyadic Fourier decomposition $v=v_{\mathrm{low}}+\sum_{j\ge0}v_j$, with $v_j$ supported in frequency on

$$
2^{j-1}\le|\xi|\le2^{j+1},
\qquad
\|v\|_{B^1_{1,1},\mathrm{inhom}}
\asymp\|v\|_1+\sum_{j\ge0}2^j\|v_j\|_1.
$$

First, frequency localization and the integral second-difference formula imply

$$
\|\Delta_h^2v_j\|_1
\le C\min\{1,(h2^j)^2\}\|v_j\|_1.
\tag{8}
$$

The low-frequency term has bound $C h^2\|v\|_1$ for $0<h\le h_1$. Since $h_n\le1/(2n)$,

$$
\sum_{n\ge1}\min\{1,(h_n2^j)^2\}\le C2^j,
\qquad \sum_{n\ge1}h_n^2<\infty.
$$

Summing (8) proves the upper bound for $\mathcal S(v)$ in (7).

For the reverse bound, use all $n$ in the block $2^j\le n<2^{j+1}$. The elementary inequalities

$$
\frac1{2n+1}\le h_n\le\frac1{2n}
$$

give $1/4\le 2^jh_n\le1/2$. Write $v_j=\varphi(2^{-j}D)v$, where $\varphi$ is supported on $1/2\le|\eta|\le2$. For every $b\in[1/4,1/2]$, the function

$$
q_b(\eta)=\frac{\varphi(\eta)}{(e^{ib\eta}-1)^2}
$$

is smooth and compactly supported, with uniformly bounded derivatives. Indeed $1/8\le|b\eta|\le1$ on this support, so the denominator is uniformly separated from zero. Its inverse Fourier transform consequently has uniformly bounded $L^1$ norm. Scaling therefore gives

$$
v_j=q_{2^jh_n}(2^{-j}D)\Delta_{h_n}^2v,
\qquad \|v_j\|_1\le C\|\Delta_{h_n}^2v\|_1.
$$

There are $2^j$ indices in the block. Summing this inequality in that block and then in $j$ proves

$$
\sum_{j\ge0}2^j\|v_j\|_1\le C\mathcal S(v).
$$

This argument also proves membership when the right side is finite. Thus no passage from isolated samples to unobserved steps has been assumed. The frequency bands and the number of successor samples in each block supply the required coverage. The last equivalence in (7) is the usual finite-difference description; it also follows from the same proof, integrating over $2^{-j-2}\le h\le2^{-j-1}$ instead of summing over the block. Equations (4), (6), and (7) prove (2).

The fixed $L^1$ term in (7) matters. The bounded steps alone do not measure the homogeneous low-frequency norm with the same scaling. For example $v_R(t)=v(t/R)$ has a fixed nonzero homogeneous $B^1_{1,1}$ seminorm, while $\mathcal S(v_R)\le C R^{-1}\|v''\|_1$ for smooth integrable $v$ with integrable second derivative. In the scattering application the missing term is already fixed by $\|\chi u\|_1=\|\chi\|_1$.

## The actual arithmetic increment to estimate

Retain the actual renormalized multiplier

$$
u_X(t)=\pi^{-it}\frac{\Gamma(5/4+it/2)}{\Gamma(5/4-it/2)}e^{i\theta_X(t)},
$$

where, with $A=\log X$,

$$
\theta_X(t)=2\int_0^A e^{a/2}\frac{\sin(at)}a\,da
-2\sum_{p\le X}\sum_{k\ge1}\frac{p^{-k/2}}k\sin(kt\log p).
\tag{9}
$$

This is the fixed rationally shifted normalization of [the signed collective phase](signed-scattering-tail-energy.md). Every power of each admitted prime is present, including $p^k>X$.

Choose a continuous real argument $\Theta_X$ of $u_X$. For $h=h_n$, set

$$
a_X(t,h)=\Theta_X(t+h)-\Theta_X(t),\qquad
b_X(t,h)=\Theta_X(t+2h)-\Theta_X(t+h).
$$

The exact integrand in (1), after dividing by $u_X(t)$, is

$$
\chi(t+2h)e^{i(a_X+b_X)}-2\chi(t+h)e^{ia_X}+\chi(t).
\tag{10}
$$

Thus a sufficient and, up to fixed constants, necessary scalar estimate for a proposed bound $N_\chi(u_X)=O(G(X))$, with $G(X)\ge1$, is

$$
\sum_{n\ge1}\int_{\mathbb R}
\left|\chi(t+2h_n)e^{i(a_X+b_X)}
-2\chi(t+h_n)e^{ia_X}+\chi(t)\right|dt
=O(G(X)).
\tag{11}
$$

All signed arithmetic terms in (9) enter the phase increments before the modulus in (11). The gamma increment is retained too. No estimate in $X$ is supplied by the sampling theorem itself.

For interpretation, the unweighted second increment has the exact factorization

$$
u_X(t)^{-1}\Delta_h^2u_X(t)
=(e^{ia_X}-1)^2+e^{ia_X}(e^{ib_X}-e^{ia_X}).
$$

Consequently

$$
|\Delta_h^2u_X(t)|
\le4\sin^2(a_X/2)+2\left|\sin\bigl((b_X-a_X)/2\bigr)\right|.
$$

This separates a saturated first-increment contribution from a saturated phase-curvature contribution. Their possible cancellation remains in (10), which is the primary criterion. An $\mathcal S_2$ first-increment bound alone does not establish (11).

For a fixed everywhere-positive Schwartz observation, the [single-observation theorem](single-observation-scattering-criterion.md) therefore makes a subpower bound for (11) sufficient for RH. Conversely, RH implies that bound through the [discrepancy-to-norm theorem](prime-discrepancy-scattering-norm.md) and (2). This reformulation does not establish the bound. The [explicit compact observation](compact-positive-scattering-observation.md) can be used throughout.
