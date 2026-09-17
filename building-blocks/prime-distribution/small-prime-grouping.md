# Small-prime grouping and its centered arithmetic source

RH remains unproved. This note tests a specific proposed cancellation mechanism for the full combined error: first sum exactly over all small prime factors, then estimate the remaining groups by absolute values. The grouped absolute majorant exceeds every fixed power below one when the small-prime cutoff is at most $N/2$. This conclusion concerns that majorant, not the signed prime error or every possible use of multiplicative grouping. The subsequent centering calculation below retains signs between groups, but leaves the original prime error in the centered quantity and supplies no improved bound.

The motivation is the actual relation $\mu(pn)=-\mu(n)$ when $p$ is prime and does not divide $n$. Grouping over all primes up to a growing cutoff retains these exact cancellations. Unlike a separate estimate for the sawtooth part, the test below uses the complete kernel

$$
H(q)=\log(q!)-\sum_{j\le q}d(j)+2\gamma q,
\qquad \kappa=H(1)=2\gamma-1>0.
$$

Here d counts positive divisors, gamma is Euler's constant, and mu is the Möbius function.

The established finite identity is

$$
\mathcal E(N):=\psi(N)-N+2\gamma
=\sum_{n\le N}\mu(n)H(\lfloor N/n\rfloor).
$$

The [actual Möbius inverse](finite-prime-mobius-consumer.md) fixes this normalization. It preserves the interaction of the floor, boundary and sawtooth terms within each H value.

Let N be a positive integer and z a nonnegative integer. For positive n, define its part supported on primes greater than z by

$$
r_z(n)=\prod_{p>z}p^{v_p(n)}.
$$

The exponent v_p(n) records how many times p occurs in the prime factorization of n.

Write n=a b, where b=r_z(n). All prime factors of a are at most z, all prime factors of b are greater than z, and gcd(a,b)=1. The factorization is unique. Both parts may equal 1. Consequently mu(n)=mu(a)mu(b), including the case when a or b has a repeated prime factor.

For an integer q>=0, put

$$
F_z(q)=\sum_{\substack{1\le a\le q\\p\mid a\Rightarrow p\le z\ \text{for prime }p}}
\mu(a)H(\lfloor q/a\rfloor).
$$

The condition on prime divisors is vacuous for a=1. Grouping the finite inverse by b gives exactly

$$
\mathcal E(N)=\sum_{\substack{1\le b\le N\\r_z(b)=b}}
\mu(b)F_z(\lfloor N/b\rfloor).
\tag{G1}
$$

Indeed, each n<=N occurs in precisely one pair (a,b), and the inner cutoff is a<=floor(N/b). The nested quotient agrees with floor(N/(ab)). This is ordinary smooth and rough factorization. It organizes the full inverse without changing its coefficients.

The proposed estimate would use

$$
\mathcal A_z(N)=\sum_{\substack{1\le b\le N\\r_z(b)=b}}
\left|\mu(b)F_z(\lfloor N/b\rfloor)\right|,
\qquad |\mathcal E(N)|\le\mathcal A_z(N).
\tag{G2}
$$

Every cancellation within a fixed small-prime group has already taken place before the absolute value in G2. The following finite lower bound nevertheless survives:

$$
\boxed{\mathcal A_z(N)\ge
\kappa\,\#\{p\text{ prime}:\max(z,N/2)<p\le N\}.}
\tag{G3}
$$

To prove it, take any prime in the displayed interval. Since p>z, r_z(p)=p. Since N/2<p<=N, floor(N/p)=1. The only positive a<=1 is 1, so F_z(1)=H(1)=kappa. The corresponding signed group is therefore mu(p)F_z(1)=-kappa, and its absolute value is kappa. Distinct primes give distinct groups. All other summands of G2 are nonnegative, proving G3. Equivalently, the entire class r_z(n)=p inside 1<=n<=N is the singleton {p}: p divides n and N<2p.

For example, at N=6 and z=2, the groups are {1,2,4}, {3,6}, and {5}. Their signed sums are H(6)-H(3), -H(2)+kappa, and -kappa, since mu(4)=0. The two kappa terms cancel across the last two groups. This finite example illustrates the information still present in G1 and separated by G2.

In particular, for every z<=floor(N/2),

$$
\mathcal A_z(N)\ge
\kappa[\pi(N)-\pi(\lfloor N/2\rfloor)].
\tag{G4}
$$

There is no assumption that z is fixed. It may depend on N and approach N/2. The same argument applies to any finer grouping that only splits these classes, because the prime singletons remain singletons.

The unconditional prime number theorem makes the obstruction quantitative. It gives

$$
\psi(N)-\psi(\lfloor N/2\rfloor)=N/2+o(N).
$$

The contribution of proper prime powers p^j<=N, j>=2, is o(N). For example, p<=sqrt(N), j<=log(N)/log(2), and log(p)<=log(N) give the elementary upper bound sqrt(N)(log(N))^2/log(2). Subtracting these proper powers therefore gives

$$
\sum_{N/2<p\le N}\log p=N/2+o(N).
$$

Each log(p) is at most log(N). Thus, for all sufficiently large N, the number of these primes is at least N/[4 log(N)]. Combining this with G4 yields a single threshold independent of z:

$$
\boxed{\mathcal A_z(N)\ge
\frac{\kappa N}{4\log N}
\quad\text{for every }0\le z\le\lfloor N/2\rfloor.}
\tag{G5}
$$

For every r<1, N^(1-r)/log(N) tends to infinity. Hence no choice of such a growing cutoff can give an eventual bound A_z(N)<=C N^r. In particular it cannot give the RH scale for any fixed 0<epsilon<1/2. This is a lower bound for the actual grouped absolute total. It is not a lower bound for |psi(N)-N| and does not exclude an estimate preserving the signs between the b groups.

The classical [Johnston–Yang bound](https://arxiv.org/pdf/2204.01980v2) is already $o(N/\log N)$, so even that known precision requires cancellation between groups in G1. Taking absolute values in G2 loses information that is known to matter unconditionally. The bound is an unconditional input, not a new prime-distribution estimate.

Increasing z past N/2 does not by itself produce an estimate. For N>=2 and integer N/2<=z<=N, the only b<=N with all prime factors greater than z are 1 and the primes p>z. A composite would contain two prime factors, with multiplicity, each greater than z, and would exceed N. Every such prime has quotient 1. Therefore

$$
\begin{aligned}
\mathcal E(N)&=F_z(N)-\kappa[\pi(N)-\pi(z)],\\
\mathcal A_z(N)&=|F_z(N)|+\kappa[\pi(N)-\pi(z)].
\end{aligned}
\tag{G6}
$$

G6 does not rule out every choice above N/2. It specifies the signed quantity that would then require a new estimate. At z=N it reduces to F_N(N)=E(N), so all cancellation is inside the one group and the original problem remains. The lower bound G5 is not extended to this range.

The classical comparison was checked before proposing further formalization. Kevin Ford's [*Sieve methods lecture notes*, section 1.2, printed page 2](https://ford126.web.illinois.edu/sieve2023.pdf) identifies the integers surviving the square-root sieve as 1 and the primes above sqrt(N). Section 1.7.1, printed page 5, uses the prime number theorem to compare their count with the naive Euler-product approximation. Our factorization and surviving-prime argument are elementary applications to the existing H kernel. No originality claim is made. Tao's [sieve notes, section 5](https://terrytao.wordpress.com/2015/01/21/254a-notes-4-some-sieve-theory/) discuss the broader parity problem with explicit qualifications. That discussion is context, not a hypothesis or proof of G3-G5. This note does not claim a general impossibility theorem for sieve methods or RH.

## Exact centering and its retained error

Subtracting a logarithmic-integral approximation for the surviving primes avoids the majorant G2. It does not, however, supply an independently bounded source. The precise calculation is as follows.

Let N>=4 be an integer and q=floor(N/2), so q>=2. Define

$$
D(t)=\psi(t)-t,\qquad
L_N=\int_q^N\frac{dt}{\log t},\qquad
G(N)=F_q(N)-\kappa L_N-2\gamma.
$$

Here psi(t)=sum_{p^j<=t}log(p), with the usual inclusive cutoff for every real t. The integral stays above 1 and needs no principal-value convention. The smooth and rough grouping at z=q still has only b=1 and prime b>q, also when N is odd. Indeed, a prime factor p>q satisfies p>=q+1>N/2, so a composite divisible by p would exceed N. Hence

$$
G(N)=D(N)+\kappa[\pi(N)-\pi(q)-L_N].
$$

Retain the proper prime powers explicitly through

$$
Z_N=\sum_{\substack{q<p^j\le N\\j\ge2}}\frac1j,
\qquad
\mathcal T_N[D]=\frac{D(N)}{\log N}-\frac{D(q)}{\log q}
+\int_q^N\frac{D(t)}{t(\log t)^2}\,dt.
$$

Finite summation by parts gives the exact relation

$$
\boxed{G(N)=D(N)+\kappa\mathcal T_N[D]-\kappa Z_N.}
\tag{G7}
$$

For the endpoint check, use 1/log(n)=1/log(N)+integral from n to N of 1/[t(log t)^2], multiply by Lambda(n), and sum over q<n<=N. The sum of Lambda(n)/log(n) is pi(N)-pi(q)+Z_N. Interchanging only a finite sum and an integral gives

$$
\pi(N)-\pi(q)+Z_N
=\frac{\psi(N)}{\log N}-\frac{\psi(q)}{\log q}
+\int_q^N\frac{\psi(t)}{t(\log t)^2}\,dt.
$$

Substitute psi(t)=t+D(t). The terms containing t equal L_N, since the derivative of t/log(t) is 1/log(t)-1/(log(t))^2. This proves G7 with the stated signs. The value at q is subtracted, including any prime or prime-power jump there, while the upper endpoint N remains included.

The logarithmic correction is small relative to a local supremum of the same unknown error:

$$
\boxed{|\mathcal T_N[D]|\le
\frac{2}{\log q}\sup_{q\le t\le N}|D(t)|.}
\tag{G8}
$$

The coefficient is the exact sum of the absolute endpoint weights and the integral of the positive kernel:

$$
\frac1{\log N}+\frac1{\log q}
+\int_q^N\frac{dt}{t(\log t)^2}
=\frac2{\log q}.
$$

Also 0<=Z_N<=sqrt(N)log(N)/[2 log(2)]. To see this, a proper prime power has p<=sqrt(N), its exponent is at most log(N)/log(2), and its weight 1/j is at most 1/2. Counting all such pairs overestimates those in the interval. Thus

$$
\boxed{|G(N)-D(N)|\le
\frac{2\kappa}{\log q}\sup_{q\le t\le N}|D(t)|
+\frac{\kappa\sqrt N\log N}{2\log2}.}
\tag{G9}
$$

G8 is a supremum estimate, not a pointwise relative error statement such as G(N)/D(N)->1. D(N) can be much smaller than its values elsewhere in the interval. The proper-power term in G9 is at the RH scale after any positive power loss. The other term still depends on the unknown D.

The exact equation can be arranged as

$$
\left(1+\frac\kappa{\log N}\right)D(N)
=G(N)+\frac\kappa{\log q}D(q)
-\kappa\int_q^N\frac{D(t)}{t(\log t)^2}\,dt+\kappa Z_N.
$$

A separately proved uniform bound on G could therefore be useful. For example, at a fixed power r>1/2, G8 would let one absorb the history term in a global weighted supremum once 2 kappa/log(q)<1/2. Between consecutive integers D(t) differs from D(floor(t)) by less than one, so passing to that supremum causes only a bounded correction. This explains stability of the relation; it does not give the required estimate for G. Bounding G through G7 using only an existing bound on D leaves the leading D(N) term at the same power. Feeding that estimate back into the equation does not improve the input power.

The use of the logarithmic integral and partial summation is classical. The comparison was checked against [Tao's elementary notes, proof of Theorem 15](https://terrytao.wordpress.com/2014/11/23/254a-notes-1-elementary-multiplicative-number-theory/) and [his complex-analytic notes, Exercise 40](https://terrytao.wordpress.com/2014/12/09/254a-notes-2-complex-analytic-multiplicative-number-theory/). G7-G9 were derived above for this particular finite interval and actual error. No sharper prime-counting theorem from those sources is used, and the adopted global baseline is unchanged.

This test has not found a new estimate for the combined error. Centering cancels the predictable prime-count term, but G remains an unknown arithmetic quantity containing D with coefficient one and the explicit correction G7. An independent square-root-scale bound for G has not been established. No new RH criterion, Lean wrapper, numerical diagnostic or formal theorem has been added for it. Further grouping or centering variants should be set aside unless they come with an independently justified estimate that changes the remaining bound. The original RH goal remains active.

## A precise same-power consumer

For each fixed $r>1/2$, the centered source satisfies $G(N)=O(N^r)$ for all integer cutoffs if and only if $\psi(x)-x=O(x^r)$ for real $x\ge1$. This is a consequence of (G7)–(G9), not a proved bound for either source.

For the forward implication from the prime-error bound, the local supremum in (G9) is $O(N^r)$, and $\sqrt N\log N=O_r(N^r)$. For the converse, let $M_N=\max_{1\le n\le N}|D(n)|/n^r$. Between consecutive integers, $|D(t)-D(\lfloor t\rfloor)|<1$, so the local supremum is at most $N^rM_N+1$. Choose a fixed threshold beyond which $2\kappa/\log\lfloor N/2\rfloor\le1/2$. Then (G9) and the assumed bound on $G$ give $|D(N)|/N^r\le C+M_N/2$ beyond that threshold. Taking the maximum, if it is attained beyond the threshold it is at most $2C$; otherwise it is bounded by the fixed initial segment. Thus $M_N$ is uniformly bounded. Real cutoffs follow from the same unit-interval relation.

The grouping lower bound, centering identities and same-power implication are written proofs based on finite factorization, partial summation and classical PNT. They make no Lean or priority claim. The [prime-division graph obstruction](../successor-and-division/prime-division-unmatched.md) treats a different matching-based majorant, while the [finite-prime Möbius consumer](finite-prime-mobius-consumer.md) keeps the full signed smooth/rough cutoff identity.
