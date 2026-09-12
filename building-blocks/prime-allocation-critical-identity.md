# Prime allocation and the complete critical arithmetic identity

This written proof constructs the full cutoff law from independent negative-binomial Euler factors, then derives the complete signed second-moment identity. Independence is used before weighting and for allocations conditional on the whole product; it is not asserted for total prime exponents after weighting. No Lean formalization or priority claim is made.

All identities below hold for every real $x>1$. Every measure pairing is
restricted by the kernel $K_x(a,b)=(x-ab)_+$, so only finitely many atoms
and bounded continuous intervals contribute. Integer endpoints cause no
ambiguity: a term with product exactly $x$ has zero kernel weight.

## The actual measures and the critical scale sum

Write

$$
\lambda_p=(\log p)\sum_{j\ge1}\delta_{p^j},\qquad
\lambda=\sum_p\lambda_p=d\psi,\qquad
\sigma=\lambda-\delta_1-dt,
$$

where $dt$ is Lebesgue measure on $[1,\infty)$. Thus the cumulative
function of $\sigma$ is $\psi(t)-t$, including its value $-1$ at $t=1$.
For measures $\alpha,\beta$, use the notation

$$
\langle\alpha,K_x\beta\rangle
=\iint (x-ab)_+\,\alpha(da)\beta(db).
$$

The literal same-prime term is

$$
S_{\rm same}(y)
=\sum_p\langle\lambda_p,K_y\lambda_p\rangle
=\sum_{p^j\le y}(y-p^j)(j-1)(\log p)^2.
$$

Set

$$
V(y)=\langle\sigma,K_y\sigma\rangle-S_{\rm same}(y),\qquad
W(x)=\sum_{d\le x}\sqrt d\,V(x/d).
\tag{1}
$$

These definitions retain proper prime powers, ordered distinct-prime
pairs, the endpoint atom, and both density terms.

This is the $W$ of the [formal eventual-sign criterion](actual-critical-sign-criterion.md). To compare the definitions directly, put

$$
c(n)=\sum_{ab=n}\Lambda(a)\Lambda(b)-\Lambda(n)(\log n-\Lambda(n)).
$$

Expanding the measures gives

$$
V(y)=\sum_{n\le y}\left[(y-n)c(n)-\Lambda(n)\frac{y^2-n^2}{n}\right]
+\frac{y^2}{2}\log y+\frac{y^2}{4}-\frac14.
$$

The same-prime term at $n=p^j$ is $(j-1)(\log p)^2=\Lambda(n)(\log n-\Lambda(n))$. The endpoint and density expansion is also verified below in (16)–(21).


Let $a_j=\binom{2j}{j}/4^j$, and define the multiplicative arithmetic
function

$$
b(p^j)=a_jp^{-j/2},\qquad b(1)=1.
$$

The identity

$$
\left(\sum_{j\ge0}a_jz^j\right)^2=(1-z)^{-1}
$$

gives

$$
(b*b)(n)=n^{-1/2}.
\tag{2}
$$

Here the convolution in (2) is Dirichlet convolution. Let

$$
\mathfrak b=\sum_{m\ge1}b(m)\delta_m
$$

and use $*_\times$ for multiplicative convolution of measures, the
pushforward of their product under multiplication. Define

$$
\eta_p=\mathfrak b *_\times\lambda_p,\quad
\rho_0=\mathfrak b,\quad
\rho_c=\mathfrak b *_\times dt,\quad
\theta=\sum_p\eta_p-\rho_0,\quad
\eta=\theta-\rho_c=\mathfrak b *_\times\sigma.
$$

For any two measures in these formulas, expansion and (2) give

$$
\begin{aligned}
\langle\mathfrak b *_\times\alpha,
 K_x(\mathfrak b *_\times\beta)\rangle
&=\sum_{d\le x}d^{-1/2}
  \iint(x-dab)_+\,\alpha(da)\beta(db)\\
&=\sum_{d\le x}\sqrt d\,
  \langle\alpha,K_{x/d}\beta\rangle.
\end{aligned}
\tag{3}
$$

Consequently the exact colored formula is

$$
\boxed{
W(x)=\langle\theta,K_x\theta\rangle
-\sum_p\langle\eta_p,K_x\eta_p\rangle
-2\langle\theta,K_x\rho_c\rangle
+\langle\rho_c,K_x\rho_c\rangle.}
\tag{4}
$$

No positivity or negative-association assertion is used in (3) or (4).

## Independent Euler factors before conditioning

Take the finite set of primes $p\le x$. For each history $i=1,2$, let
its prime exponents $H_{i,p}$ be independent, with

$$
\mathbb P(H_{i,p}=j)
=(1-p^{-1/2})^{1/2}a_jp^{-j/2},\qquad j\ge0.
\tag{5}
$$

These are negative-binomial laws of shape $1/2$. Put
$M_i=\prod_{p\le x}p^{H_{i,p}}$. Their unnormalized masses are $b(m)$.
The normalizing product is finite because only finitely many primes occur.

Weight the pair law by $K_x(M_1,M_2)$ and normalize. The resulting
probability on ordered pairs is exactly

$$
\mathbb P_x(M_1=m_1,M_2=m_2)
=\frac{b(m_1)b(m_2)(x-m_1m_2)_+}{Z_x},
$$

where

$$
Z_x=\sum_{n<x}\frac{x-n}{\sqrt n}>0.
$$

Indeed, the independent-prior normalizers cancel, and (2) evaluates the
remaining total mass. Therefore the physical product $n=M_1M_2$ has law

$$
\boxed{\mathbb P_x(n)=\frac{x-n}{\sqrt n\,Z_x},\qquad 1\le n<x.}
\tag{6}
$$

Equivalently, first sum the two exponents at each prime. Their sum is
geometric with parameter $p^{-1/2}$. Then weight the product of these
independent geometric factors by $(x-n)_+$. Independence of the total
prime exponents is not asserted after this weighting.

Conditional on the whole product $n$, however, the allocations to the
two histories remain independent across primes. If $v_p(n)=j$, then

$$
\boxed{\mathbb P_x(H_{1,p}=h,H_{2,p}=j-h\mid n)
=a_h a_{j-h},\qquad 0\le h\le j.}
\tag{7}
$$

The probabilities sum to one by the coefficient identity for

$(1-z)^{-1/2}(1-z)^{-1/2}$. The cutoff weight depends only on $n$, so
it does not alter (7).

## Actual color scores and the literal diagonal

For $h\ge0$, define

$$
L_p(h)=\log p\sum_{\ell=1}^h
\frac{b(p^{h-\ell})}{b(p^h)},\qquad L_p(0)=0.
\tag{8}
$$

The coefficient of the actual color measure at an integer $m$ is

$$
\eta_p(\{m\})=b(m)L_p(v_p(m)).
\tag{9}
$$

Thus the score in (8) incorporates every allowed prime-power arrival;
it is not an arbitrary mark attached to the Euler law.

Conditional expectation under (7) gives

$$
\begin{aligned}
\mathbb E_x[L_p(H_{1,p})\mid n]
&=\log p\sum_{\ell=1}^j p^{\ell/2}
  \sum_{h=\ell}^j a_{h-\ell}a_{j-h}\\
&=\log p\sum_{\ell=1}^j p^{\ell/2}
=:m_p(n).
\end{aligned}
\tag{10}
$$

The second history has the same conditional mean. For distinct primes,
conditional independence gives

$$
\mathbb E_x[L_p(H_{1,p})L_q(H_{2,q})\mid n]
=m_p(n)m_q(n),\qquad p\ne q.
\tag{11}
$$

For the same prime, the corresponding calculation is instead

$$
\begin{aligned}
\mathbb E_x[L_p(H_{1,p})L_p(H_{2,p})\mid n]
&=(\log p)^2
\sum_{\substack{\ell,r\ge1\\\ell+r\le j}}
p^{(\ell+r)/2}\\
&=:t_p(j).
\end{aligned}
\tag{12}
$$

In particular,

$$
t_p(j)-m_p(n)^2
=-(\log p)^2
\sum_{\substack{1\le\ell,r\le j\\\ell+r>j}}
p^{(\ell+r)/2}\le0.
\tag{13}
$$

This negative covariance concerns allocation between the two histories at
one fixed prime, conditional on the total product. It is not a claim of
negative association for distinct primes under (6).

Combining (9) and (12), the literal diagonal in (4) is

$$
\boxed{
\sum_p\langle\eta_p,K_x\eta_p\rangle
=Z_x\,\mathbb E_x\sum_p t_p(v_p(n)).}
\tag{14}
$$

It is not $Z_x\mathbb E_x\sum_p m_p(n)^2$. The latter expression enters
only after subtraction of the literal diagonal and algebraic regrouping.

Set

$$
S(n)=\sum_p m_p(n)=\sum_{a\mid n}\sqrt a\,\Lambda(a).
$$

Equations (9)--(12) show that the atomic part of (4), after its literal
diagonal subtraction, is

$$
\boxed{
\langle\theta,K_x\theta\rangle
-\sum_p\langle\eta_p,K_x\eta_p\rangle
=Z_x\mathbb E_x\left[(S-1)^2-\sum_p m_p^2\right].}
\tag{15}
$$

The $-1$ in (15) comes from the actual endpoint measure $\rho_0$.

## Absorbing both continuous density terms

For $n<x$, direct integration gives

$$
\int_1^\infty(x-nt)_+dt=\frac{(x-n)^2}{2n}.
\tag{16}
$$

Using (2), expand the cross term as

$$
2\langle\theta,K_x\rho_c\rangle
=2\sum_{d\ge1}d^{-1/2}\sum_{a\ge1}
(\Lambda(a)-\mathbf1_{a=1})
\int_1^\infty(x-dat)_+dt.
$$

When $n=da$, its arithmetic coefficient is

$$
\sum_{a\mid n}(n/a)^{-1/2}
(\Lambda(a)-\mathbf1_{a=1})
=n^{-1/2}[S(n)-1].
$$

Put $z(n)=x/n-1>0$. Equations (6) and (16) therefore give

$$
\boxed{2\langle\theta,K_x\rho_c\rangle
=Z_x\mathbb E_x[z(S-1)].}
\tag{17}
$$

For the density-density term, the change of variables to the product of
two variables in $[1,\infty)$ gives

$$
\begin{aligned}
I_n&:=\int_1^\infty\int_1^\infty(x-nab)_+\,da\,db\\
&=\int_1^{x/n}(x-nt)\log t\,dt\\
&=\frac{x^2}{2n}\log(x/n)-\frac{3x^2}{4n}+x-\frac n4.
\end{aligned}
\tag{18}
$$

Define, for $z>0$,

$$
R(z)=\frac{(1+z)^2}{2z}\log(1+z)-\frac12-\frac34z
=\frac1z\int_0^z(z-u)\log(1+u)\,du.
\tag{19}
$$

Then $I_n=(x-n)R(z(n))$, and (2) yields

$$
\boxed{\langle\rho_c,K_x\rho_c\rangle
=\sum_{n<x}n^{-1/2}I_n
=Z_x\mathbb E_x R(z).}
\tag{20}
$$

All three reference terms, including their endpoint contributions, recover
the original baseline exactly. If

$$
B(y)=\frac{y^2}2\log y+\frac{y^2}4-\frac14,
$$

then

$$
\sum_{n<x}\frac{x-n}{\sqrt n}[1+z(n)+R(z(n))]
=\sum_{n\le x}\sqrt n\,B(x/n).
\tag{21}
$$

## The signed second moment and covariance identity

Substitute (15), (17), and (20) into (4):

$$
\boxed{
\frac{W(x)}{Z_x}
=\mathbb E_x\left[(S-1)^2-\sum_p m_p^2-z(S-1)+R(z)\right].}
\tag{22}
$$

This is an exact identity for the original $W$, not a change of its
diagonal or density normalization.

Write

$$
\mu_p=\mathbb E_x m_p,\qquad \mu=\sum_p\mu_p.
$$

Expanding the finite second moments in (22) gives

$$
\boxed{
\begin{aligned}
\frac{W(x)}{Z_x}
={}&(\mu-1)^2-\sum_p\mu_p^2
-\mathbb E_x[z](\mu-1)+\mathbb E_xR(z)\\
&+2\sum_{p<q}\operatorname{Cov}_x(m_p,m_q)
-\operatorname{Cov}_x(z,S).
\end{aligned}}
\tag{23}
$$

The independent Euler law thus leads to a specific joint covariance
obligation after conditioning. Both the prime covariance sum and the
density covariance occur. No sign for either is assumed in this derivation.

One can also complete the square without discarding a term:

$$
\boxed{
\frac{W(x)}{Z_x}
=\mathbb E_x\left[(S-1-z/2)^2-\sum_p m_p^2-Q(z)\right],
\quad Q(z)=z^2/4-R(z).}
\tag{24}
$$

Since $\log(1+u)\le u$, (19) implies

$$
0<R(z)\le z^2/6,\qquad Q(z)\ge z^2/12.
\tag{25}
$$

This square cannot be estimated separately from its subtraction without
losing essential cancellation. At the state $n=1$, its unnormalized
contribution is

$$
\frac{(x-1)(x+1)^2}{4}\sim x^3/4.
$$

Subtracting the corresponding $(x-1)Q(x-1)$ leaves exactly

$$
B(x)=\frac{x^2}2\log x+\frac{x^2}4-\frac14.
\tag{26}
$$

For $x=2$, (6) is supported only at $n=1$. Every covariance in (23)
then vanishes, while

$$
W(2)=2\log2+3/4>0.
$$

Thus independence, or even vanishing conditional covariances at one
cutoff, does not supply the desired centering. Equations (22)--(24)
retain the exact signed obligation; they do not prove an RH-scale bound
or an eventual sign for $W$.

## Dependencies and the remaining comparison

The generalized binomial identity in (2) is classical; see [DLMF §4.6(ii), equation 4.6.7](https://dlmf.nist.gov/4.6.E7). Its use here specifies the exact Euler factors, color scores, endpoint atom and continuous densities.

[Prime-score negative covariance](prime-score-negative-covariance.md) and [density-prime covariance](density-prime-covariance.md) give opposite signed contributions to (23). [Combined covariance and density centering](combined-prime-density-covariance.md) evaluates their sum and its leading compensation. [Conditioned prime dependence](conditional-prime-dependence.md) explains why a prime-revelation proof must also retain positive regression costs on some branches. The full eventual sign remains unproved.
