# Critical cofactor memory after coherent phase cancellation

This is an actual arithmetic second-moment theorem. It extends the
critical constant in `actual-divisor-low-band-covariance.md` without
transferring its fixed-test reference to the critical line. The prime
number theorem is used. No RH bound, Lean formalization, or novelty claim
is made. Author proof, independent review pending.

Let n be uniform on {1,...,N}, L=log N, and define the complete divisor row

$$
 Z_{N,H}(n)=\sum_{d\mid n}\Lambda(d)\sqrt d\,
                   H(\log(N/d)).
$$

The state 1 and every prime power are retained. For continuous complex
H,G of polynomial growth, the following limit holds:

$$
 \frac{\operatorname{Cov}(Z_{N,H},Z_{N,G})}{NL}
 \longrightarrow \int_0^\infty H(y)\overline{G(y)}\,dM(y),
 \qquad dM(y)=e^{-2y}\lfloor e^y\rfloor\,dy.                 \tag{1}
$$

Covariance is linear in its first argument. The same conclusion holds
for N-dependent profiles which converge locally uniformly and share a
fixed polynomial envelope. Thus the surviving critical covariance
records the entire integer cofactor, rather than just its total mass.

## Proof with actual cofactors and complete powers

First restrict to prime divisors. Its diagonal second moment is exactly

$$
 D_N(H,G)=\frac1N\sum_{k\le N/2}\sum_{p\le N/k}
 p(\log p)^2 H(\log(N/p))\overline{G(\log(N/p))}.          \tag{2}
$$

For each fixed k, the prime number theorem and partial summation, with
small p removed first, give the corresponding contribution to D_N/(NL)
as

$$
 \int_0^{1/k}tH(\log(1/t))\overline{G(\log(1/t))}\,dt.
$$

If |H(y)G(y)| is at most C(1+y)^r, Chebyshev and dyadic subdivision of
p<=N/k bound that contribution by

$$
 C_r k^{-2}(1+\log k)^r
$$

uniformly in N. Indeed subdivision p in (x/2^{j+1},x/2^j], x=N/k,
costs at most C x^2 log(2x)4^{-j}(1+log k+j)^r before division by N^2L.
This summable bound justifies the cofactor limit and its infinite tail.
Putting t=e^{-y} and summing k gives the floor measure in (1).

For distinct primes the absolute second-moment contribution, using a
polynomial envelope separately on H and G, is at most

$$
 C L^{r_H+r_G}\sum_{pq\le N}\frac{\log p\log q}{\sqrt{pq}}
 \ll \sqrt N L^{r_H+r_G+1}=o(NL).                         \tag{3}
$$

The prime mean is O_H(sqrt N). To see this with its correct strength,
bound it by sum_{p<=N}(log p)/sqrt p |H(log(N/p))| and subdivide p in
(N/2^{j+1},N/2^j]. Chebyshev bounds this by
C_H sqrt N sum_j 2^{-j/2}(1+j)^{r_H}. Hence the product of means is O(N)
and disappears after division by NL. A loose log-power estimate for the
mean would not suffice here.

For proper powers, let R_N be the absolute remainder with H=1. The
complete-power calculation in the predecessor note proves

$$
 \mathbb E R_N^2\ll\sqrt N L+L^2.
$$

A polynomial profile multiplies its absolute value by at most C L^r.
Its squared norm is therefore o(NL), for every fixed r. Cauchy--Schwarz
with the O(NL) prime diagonal restores all mixed prime/power terms.
This proves (1). Local-uniform convergence with a common polynomial
envelope follows by the same summable cofactor bound and dyadic tails.

## An explicit memory transform

For Re q>-1, Tonelli or absolute integration gives

$$
 \int_0^\infty e^{-qy}\,dM(y)
 =\sum_{k\ge1}\int_{\log k}^\infty e^{-(2+q)y}\,dy
 =\frac{\zeta(2+q)}{2+q}.                                \tag{4}
$$

This is a right-half-plane cofactor transform, with no critical
continuation assertion. In particular write M_j=int y^j dM. Then

$$
 M_0=\zeta(2)/2=\pi^2/12,\qquad
 M_1=\zeta(2)/4-\zeta'(2)/2,
$$
$$
 M_2=\zeta''(2)/2-\zeta'(2)/2+\zeta(2)/4.                 \tag{5}
$$

The original critical correction is exactly M_0. Its higher moments
are forced by the integer cofactors which that correction retained.

## Coherent logarithmic phase differences lose two powers of L

For fixed real z define

$$
 Y_{N,z}=\sum_{d\mid n}\Lambda(d)\sqrt d\,
                  e^{-iz\log d/L}.
$$

Equation (1) first gives the joint rank-one limit

$$
 \frac{\operatorname{Cov}(Y_{N,z},Y_{N,w})}{NL}
 \longrightarrow M_0e^{-i(z-w)}.                          \tag{6}
$$

Remove that phase coherently before taking a norm. Put

$$
 A_{N,z}=e^{iz}Y_{N,z}-Y_{N,0}.
$$

Its multiplied profile L(exp(izy/L)-1) converges locally uniformly to
izy and is bounded by |z|y. The N-dependent version of (1) therefore
proves

$$
 \frac{L}{N}\operatorname{Cov}(A_{N,z},A_{N,w})
 \longrightarrow zw M_2.                                \tag{7}
$$

For the normalized divisor row X=Y/L this is a variance of order N/L^3,
while the uncorrected critical row has variance of order N/L. This is
an actual cancellation from coherent logarithmic histories, not a
termwise variance upper bound.

Removing its best first-order covariance projection gives a further
precise source restriction. Define

$$
 B_{N,z}=A_{N,z}-\frac{izM_1}{LM_0}Y_{N,0}.
$$

Then

$$
 \frac{L}{N}\operatorname{Cov}(B_{N,z},B_{N,w})
 \longrightarrow zw\left(M_2-\frac{M_1^2}{M_0}\right).    \tag{8}
$$

The constant is strictly positive, since the absolutely continuous
measure M is not supported at a single y. Thus even the corrected row
has genuine cofactor-memory fluctuations. Replacing the critical row by
one scalar phase would discard them.

## Exact scope of a next use

These results constrain the actual joint critical divisor family and
show that coherent phase cancellation can beat an unsigned estimate
by two logarithmic powers. They do not bound the signed mean,
psi(N)-N, the centered critical heat datum, or growing frequencies.
The covariance is dominated by its same-prime diagonal. A usable
successor/score bridge must preserve the endpoint and density and show
that its particular signed readout annihilates the leading constant
profile in (6). That annihilation has not been proved. Equations (7)
and (8) give the exact surviving consumer if it can be proved.

## Additive succession makes distinct fixed states orthogonal at this scale

There is also a direct successor constraint. For a fixed integer h>=1,
take n uniform on {1,...,N-h}. Use the same profiles and the same N in
both cofactor coordinates. Then

$$
 \frac{\operatorname{Cov}(Z_{N,H}(n),Z_{N,G}(n+h))}{NL}
 \longrightarrow0.                                      \tag{9}
$$

This uses a classical dimension-two upper bound sieve in addition to
PNT. The needed sieve input follows from Theorem 32 of
[Tao's sieve notes](https://terrytao.wordpress.com/2015/01/21/254a-notes-4-some-sieve-theory/).
For two fixed integer affine forms with positive leading coefficients
and nonzero determinant, the number of simultaneous prime values in
an interval of length O(N), with both values at least delta N, is
O(N/log^2 N). The constant depends on the forms and delta. Outside the
finitely many primes dividing their leading coefficients or determinant,
their product has exactly two distinct roots modulo each prime.
Theorem 32 applies to those root classes. A local obstruction gives no
large simultaneous prime values and is handled separately. This input
requires no prime-pair asymptotic or existence theorem.

Here is the full arithmetic passage. Restrict both prime-divisor rows
to p>=delta N for fixed delta>0. Write n=kp and n+h=lq. There are only
finitely many pairs k,l<=1/delta. Each pair requires

$$
 lq-kp=h.                                                 \tag{10}
$$

Put g=gcd(k,l). If g does not divide h there are no solutions. Otherwise
all solutions have p=p0+(l/g)t and q=q0+(k/g)t. Their determinant is
h/g, which is nonzero. The cited sieve bound gives O_{k,l,h,delta}(N/L^2)
simultaneous primes. Each summand of the product of the restricted rows
has absolute value O_{H,G,delta}(NL^2). Division by the sample size
therefore bounds the restricted mixed second moment by O(N)=o(NL).
This includes k=l. A same-prime solution p=q would force p|h and cannot
occur with p>=delta N once N is large.

The discarded prime row p<delta N has, by the diagonal proof and the
nonnegative off-diagonal estimate (3),

$$
 \limsup_N\frac{\|Z_{N,H}^{<\delta}\|_2^2}{NL}
 \le\int_{\log(1/\delta)}^\infty |H(y)|^2\,dM(y).         \tag{11}
$$

Here the norm is the probability-space norm. The right side tends to
zero as delta decreases to zero. Cauchy--Schwarz with the O(NL) full
row norm controls every term containing one discarded row. Complete
powers are restored by their already-proved o(NL) squared norm.
Both full means are O(sqrt N), so centering costs only O(N).

Removing the h endpoint states does not alter any diagonal limit.
The exact divisor identity gives

$$
 |Z_{N,H}(m)|\le C_H L^{r_H}\sqrt m\log m\qquad(m\le N),
$$

so finitely many deleted squared values contribute only a fixed power
of L to the probability second moment, hence o(NL). These facts prove
(9) with the actual successor endpoint and full histories retained.

More generally, finitely many distinct additive shifts have limiting
joint covariance equal to the cofactor Gram in (1) tensored with the
identity matrix on shifts. This is second-moment orthogonality, without
a claim of probabilistic independence. It is a specified metric in
which actual successive arithmetic states become orthogonal.

The coherent rows A and B in (7) and (8) inherit the same fixed-shift
orthogonality after their stated normalization, since their multiplied
profiles share polynomial envelopes. The unresolved growth question is
uniformity when h, the number of successive states, or the cofactor
cutoff grows with N. No such uniform estimate follows from taking
delta fixed first. That is the additive coupling needed for a useful
growing-block consumer, and it is more precise than assuming generic
prime independence.
