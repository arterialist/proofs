# Prime-density matching and a relative determinant

An ordered prime spectrum has an exact trace-norm distance from a spectrum defined by the logarithmic integral. This identifies the arithmetic condition needed for a density-based relative determinant. The regularized determinant and its first-order restoration are kept separate. No continuation below the established arithmetic domain, RH bound, novelty or Lean formalization is claimed.

## The prime operator and the removed trace

On $\ell^2(\mathbb N)$, with $p_j$ the increasing ordinary primes, define

```math
A_s e_j=p_j^{-s}e_j,\qquad p_j^{-s}=e^{-s\log p_j}.
```

For $\sigma=\Re s>0$ this is compact, normal and bounded, with norm $2^{-\sigma}$. It belongs to the Schatten class $S_r$ exactly when $r\sigma>1$; in particular it is trace class for $\sigma>1$ and Hilbert–Schmidt for $\sigma>1/2$. These follow by summing its singular values and using the classical divergence of $\sum_p1/p$ at the endpoint.

On $\sigma>1/2$, its second regularized determinant is

```math
D_2(s)=\det{}_2(I-A_s)
=\exp\left[-\sum_p\sum_{k\ge2}\frac{p^{-ks}}k\right]. \tag{1}
```

The series converges absolutely and locally uniformly, so (1) is holomorphic and nonzero. This is the standard Hilbert–Carleman regularization; see [Simon, *Notes on infinite determinants of Hilbert space operators*](https://doi.org/10.1016/0001-8708(77)90057-3) and [Britz et al., *The product formula for regularized Fredholm determinants*](https://arxiv.org/abs/2007.12834). No general determinant theorem beyond the displayed convergent diagonal product is needed here.

For fixed $\sigma>1/2$,

```math
|\log D_2(\sigma+it)|\le
\frac{\sum_p p^{-2\sigma}}{2(1-2^{-\sigma})}=:C_\sigma,
\qquad e^{-C_\sigma}\le|D_2(\sigma+it)|\le e^{C_\sigma}.
```

The logarithm is the canonical power-series logarithm. It removes exactly the first-order prime trace $P(s)=\sum_pp^{-s}$, and

```math
\zeta(s)^{-1}=D_2(s)e^{-P(s)}\qquad(\Re s>1).         \tag{2}
```

Regularization changes the arithmetic coefficients unless that factor is restored: $(1-z)e^z=1-\sum_{k\ge2}(k-1)z^k/k!$, so $d_2(p)=0$, $d_2(p^2)=-1/2$, and $\sum_{n\le6}d_2(n)=1/2$, whereas $\sum_{n\le6}\mu(n)=-1$.

## A spectrum independent of the prime locations

Let

```math
\operatorname{Li}_2(x)=\int_2^x\frac{dt}{\log t},\qquad
\operatorname{Li}_2(q_j)=j\quad(j\ge1),\qquad
B_s e_j=q_j^{-s}e_j.
```

The reference counting function is $N_q(t)=\lfloor\operatorname{Li}_2(t)\rfloor$. For every real $\sigma>0$, including infinite values on either side,

```math
\boxed{\|A_\sigma-B_\sigma\|_1
=\sigma\int_2^\infty
|\pi(t)-\lfloor\operatorname{Li}_2(t)\rfloor|t^{-\sigma-1}dt.} \tag{3}
```

To prove this, write each $|p_j^{-\sigma}-q_j^{-\sigma}|$ as $\sigma$ times the integral of $t^{-\sigma-1}$ over the interval between $p_j$ and $q_j$. At each $t$, both sets of occupied indices are initial segments; their symmetric difference has size $|\pi(t)-N_q(t)|$. Tonelli proves (3). For complex $s$ the same argument and $|(t^{-s})'|=|s|t^{-\sigma-1}$ give

```math
\|A_s-B_s\|_1\le |s|\int_2^\infty|\pi(t)-N_q(t)|t^{-\sigma-1}dt. \tag{4}
```

This is the ordered one-dimensional transport/counting-function identity specialized to the decreasing function $t^{-\sigma}$; compare [Vallander's distribution-function formula](https://www.mathnet.ru/php/archive.phtml?wshow=paper&jrnid=tvp&paperid=4387&option_lang=eng). The proof above applies to these infinite counting measures without treating them as probability measures.

Since $|N_q(t)-\operatorname{Li}_2(t)|\le1$, finiteness in (3) is equivalent, for $\sigma>0$, to

```math
\int_2^\infty|\pi(t)-\operatorname{Li}_2(t)|t^{-\sigma-1}dt<\infty. \tag{5}
```

If this integral is finite at some $\delta>0$, (4), with its tail bound, gives local uniform trace-norm convergence and holomorphy of $A_s-B_s$ in $\Re s>\delta$. Its value is trace class on the real line $s=\delta$ too; holomorphy across that boundary is not implied.

## Continuing the reference, not the arithmetic discrepancy

For $\Re s>1$, put

```math
I(s)=\int_2^\infty\frac{t^{-s}}{\log t}\,dt,
\qquad I'(s)=-\frac{2^{1-s}}{s-1}.
```

Define the entire functions

```math
G(s)=\exp\left[-I(2)+\int_2^s\frac{2^{1-w}-1}{w-1}\,dw\right],
\qquad E(s)=(s-1)G(s).                               \tag{6}
```

The integrand has a removable singularity, so the integral is path independent. Differentiation and the value at $s=2$ show $E(s)=e^{-I(s)}$ on $\Re s>1$. Thus $E$ has exactly one zero, simple at $1$, without choosing a logarithm around that point.

The reference discrepancy is bounded, so

```math
C_q(s)=s\int_2^\infty[N_q(t)-\operatorname{Li}_2(t)]t^{-s-1}dt
```

is holomorphic for $\Re s>0$, with $|C_q(s)|\le |s|2^{-\sigma}/\sigma$. Stieltjes integration by parts shows that $C_q(s)=\sum_jq_j^{-s}-I(s)$ for $\Re s>1$. Also $B_s$ is Hilbert–Schmidt for $\Re s>1/2$. Consequently

```math
\mathcal D_q(s)=E(s)\det{}_2(I-B_s)e^{-C_q(s)}           \tag{7}
```

is holomorphic on that half-plane, with exactly one simple zero at $1$, and agrees with $\det(I-B_s)$ on $\Re s>1$.

Whenever $A_s-B_s$ is trace class, the inverse $I-B_s$ is bounded for $\Re s>0$, and the ordinary relative determinant

```math
R(s)=\det[(I-A_s)(I-B_s)^{-1}]
```

is defined. On a region where the trace-class difference is holomorphic, so is this nonzero relative determinant. On the original absolutely convergent region,

```math
\zeta(s)^{-1}=R(s)\mathcal D_q(s)\qquad(\Re s>1).       \tag{8}
```

For $\Re s>1/2$ with trace-class difference, the canonical logarithms give the exact restoration

```math
\log R(s)=\log\det{}_2(I-A_s)-\log\det{}_2(I-B_s)
-\operatorname{Tr}(A_s-B_s).                           \tag{9}
```

Equation (9) follows term by term from the finite diagonal products and then by absolute convergence. Omitting its last term would again remove the first-order arithmetic.

For comparison, at a common finite energy cutoff $Y\ge2$, with $R_\pi(t)=\pi(t)-\operatorname{Li}_2(t)$,

```math
\sum_{p\le Y}p^{-s}-\int_2^Y\frac{t^{-s}}{\log t}dt
=Y^{-s}R_\pi(Y)+s\int_2^Y R_\pi(t)t^{-s-1}dt.          \tag{10}
```

The prime at $2$ is included: $R_\pi(2)=1$, so (10) equals $2^{-s}$ at $Y=2$. Ordered-index matching in (8) is not assumed to agree with common-energy limits below absolute convergence.

The utility of (3)–(10) is the separation of an independently continued reference determinant from an exact norm of the actual prime discrepancy. For example, a premise $|R_\pi(t)|\le Kt^\alpha$ makes the integral tail above $Y$ at most $K Y^{\alpha-\sigma}/(\sigma-\alpha)$ for $\sigma>\alpha$. No such stronger arithmetic premise is proved here. The existence and nonvanishing of the regularized factors alone do not continue the restored Euler product or constrain its zeros.


## Unitary mixing cannot reduce this cost

For every real $\sigma>0$ the ordered identification minimizes the trace norm over every unitary, including infinite values:

```math
\inf_{U\ {\rm unitary}}\|A_\sigma-U B_\sigma U^*\|_1
=\sum_j|p_j^{-\sigma}-q_j^{-\sigma}|.
```

This is an application of classical Hermitian spectral variation; see [Bhatia, equations (17)–(18)](https://www.isid.ac.in/~statmath/2007/isid200703.pdf). A short proof also fixes the infinite-dimensional scope. For finite Hermitian matrices $A,B$, write $D=A-B=D_+-D_-$ and $C=B+D_+=A+D_-$. Ordered eigenvalues obey $c_j\ge a_j,b_j$ by min-max. Therefore

```math
\sum_j|a_j-b_j|\le2\operatorname{Tr}C-\operatorname{Tr}A-\operatorname{Tr}B
=\operatorname{Tr}D_++\operatorname{Tr}D_-=\|A-B\|_1.
```

For positive compact operators and fixed $U$, the assertion is automatic if $A-UBU^*$ is not trace class. Otherwise compress onto finite-rank projections increasing strongly to identity. Compactness gives operator-norm convergence of the compressions and hence convergence of each fixed ordered eigenvalue. Their trace-norm differences are at most $\|A-UBU^*\|_1$. Apply the finite inequality, first let the rank tend to infinity with a fixed number of eigenvalues retained, then let that number increase. This proves the same lower bound for the complete ordered eigenvalue difference. The identity unitary attains it for the two already ordered diagonal spectra.

Thus changing the basis cannot bypass the weighted prime discrepancy in (3). A different reference spectrum, a nonunitary construction or a separately proved arithmetic estimate is outside this obstruction.


## The centered trace at the line-one boundary

Let $C_Y=P_Y-I_Y$ be the finite difference in (10). Whenever the boundary term vanishes and the integral converges, its limit has the exact error

$$
C(s)-C_Y(s)
=s\int_Y^\infty R_\pi(t)t^{-s-1}\,dt-Y^{-s}R_\pi(Y),
\qquad
C(s)=s\int_2^\infty R_\pi(t)t^{-s-1}\,dt.
\tag{11}
$$

In particular, the premise $|R_\pi(t)|\le Kt^\alpha$ gives, for $\sigma>\alpha$,

$$
|C(s)-C_Y(s)|\le K Y^{\alpha-\sigma}
\left(1+\frac{|s|}{\sigma-\alpha}\right).
\tag{12}
$$

The extra $1$ comes from the cutoff boundary and cannot be omitted. For an unconditional endpoint statement, [Johnston–Yang, Theorem 1.4](https://arxiv.org/pdf/2204.01980v2) gives, for each fixed $0<c<0.1853$, a sufficiently large-range estimate of the form

$$
\psi(t)-t=O_c(te^{-c\mathscr L(t)}),\qquad
\mathscr L(t)=(\log t)^{3/5}(\log\log t)^{-1/5}.
$$

Removing proper prime powers and applying partial summation, with an arbitrarily small reduction of $c$, gives

$$
R_\pi(t)=O_c\left(\frac{t}{\log t}e^{-c\mathscr L(t)}\right).
\tag{13}
$$

To retain the lower endpoint explicitly, if $E_\vartheta(t)=\vartheta(t)-t$, that partial summation is

$$
R_\pi(t)=\frac2{\log2}+\frac{E_\vartheta(t)}{\log t}
+\int_2^t\frac{E_\vartheta(u)}{u\log^2u}\,du.
$$

The bound $\psi-\vartheta=O(\sqrt t\log^2t)$ preserves every proper power. Equation (13) makes (11) converge locally uniformly on the closed half-plane $\sigma\ge1$. On each bounded height range, its error is $O(e^{-c'\mathscr L(Y)})$ for $0<c'<c$. The same argument handles any fixed number of derivatives, by absorbing logarithmic factors into that loss. The limit is holomorphic for $\sigma>1$ and continuous at the boundary. Qualitative PNT alone would not justify this absolute-integral argument. The displayed majorant does not give an absolute integral for a fixed $\sigma<1$; this says nothing about divergence of the actual signed trace there.

## A prime-dependent local comparison that does converge

A different reference preserves the actual prime positions. On the same prime-indexed Hilbert space put

$$
B_s^{\rm loc}e_p=b_p(s)e_p,
\qquad b_p(s)=\int_p^{p+1}t^{-s}\,dt.
$$

For $\sigma>0$, the fundamental theorem of calculus gives

$$
|p^{-s}-b_p(s)|
\le |s|\int_p^{p+1}(t-p)p^{-\sigma-1}\,dt
=\frac{|s|}{2}p^{-\sigma-1}.
\tag{14}
$$

Hence $A_s-B_s^{\rm loc}$ is holomorphic in trace norm throughout $\sigma>0$. Both operators are holomorphic in operator norm there, and $|b_p(s)|\le p^{-\sigma}\le2^{-\sigma}<1$. The convergent relative product

$$
R_{\rm loc}(s)
=\det\big[(I-A_s)(I-B_s^{\rm loc})^{-1}\big]
=\prod_p\frac{1-p^{-s}}{1-b_p(s)}
\tag{15}
$$

is holomorphic and nonzero. Its canonical power-series logarithm satisfies

$$
|\log R_{\rm loc}(s)|
\le\frac{|s|}{2(1-2^{-\sigma})}\sum_p p^{-\sigma-1}.
\tag{16}
$$

Indeed, integrate the derivative of $\log(1-z)$ along the segment joining $b_p(s)$ to $p^{-s}$, which stays inside the disk of radius $2^{-\sigma}$, and sum (14). Local uniform tail bounds justify holomorphy and differentiation.

This is a valid relative-operator construction below $1/2$. On $\sigma>1$ its exact restoration is

$$
\zeta(s)^{-1}=R_{\rm loc}(s)\det(I-B_s^{\rm loc}),\qquad
\operatorname{Tr}B_s^{\rm loc}
=\int_2^\infty \rho_{\rm prime}(t)t^{-s}\,dt,
\quad
\rho_{\rm prime}=\sum_p\mathbf1_{[p,p+1)}.
$$

The reference contains the arithmetic that made the relative difference small. Since $b_p(s)=p^{-s}(1-s/(2p)+O_s(p^{-2}))$, its first trace has the same convergence threshold as the prime trace. Replacing $\rho_{\rm prime}$ by $1/\log t$ restores the discrepancy in (11). Thus (15) and the independent density comparison solve different operator problems.

## Higher regularization retains the first prime trace

For every integer $k\ge2$, the same diagonal proof gives

$$
D_k(s)=\det{}_k(I-A_s)
=\exp\left[-\sum_p\sum_{j\ge k}\frac{p^{-js}}j\right],
\qquad \Re s>1/k.
\tag{17}
$$

This is holomorphic and nonzero, and its exact restoration on $\Re s>1$ is

$$
\zeta(s)^{-1}=D_k(s)
\exp\left[-\sum_{j=1}^{k-1}\frac{P(js)}j\right].
\tag{18}
$$

For $\Re s>1/2$, all restored terms with $j\ge2$ already converge absolutely. Raising the regularization order does not supply the missing first-order continuation. For example, $D_2=D_3e^{-P(2s)/2}$ tends to zero as real $s\downarrow1/2$, while $D_3$ has a positive nonzero limit there. The higher-order factor has moved this singular contribution into its required restoration.

## Exact logarithmic-derivative transfer

On $\Re s>1$, differentiate $C=P-I$ and let $H_2=(\log D_2)'$. Then

$$
C'(s)=-\sum_p(\log p)p^{-s}+\frac{2^{1-s}}{s-1},
\qquad
H_2(s)=\sum_p\frac{(\log p)p^{-2s}}{1-p^{-s}}.
$$

Keeping every prime power gives

$$
-\frac{\zeta'}\zeta(s)-\frac1{s-1}
=-C'(s)+H_2(s)+\frac{2^{1-s}-1}{s-1}.
\tag{19}
$$

Here $H_2$ is holomorphic for $\Re s>1/2$, and for $\Re s\ge\delta>1/2$ its absolute value is bounded by

$$
\frac1{1-2^{-\delta}}\sum_{n\ge2}(\log n)n^{-2\delta}.
$$

The final correction is the entire function $-\int_1^2x^{-s}\,dx$, with value $-\log2$ at $s=1$. Thus the distinction between a signed prime form and the absolute density-trace cost is preserved, despite their common derivative. A cutoff on prime bases in $H_2$ retains arbitrarily high powers of those primes; it is not an additive cutoff of $\Lambda(n)$.

## Unconditional failure at the critical boundary

For the specified independent density spectrum, every real $0<\sigma\le1/2$ satisfies

$$
\int_2^\infty |\pi(x)-\operatorname{Li}_2(x)|x^{-\sigma-1}\,dx=\infty,
\qquad
A_\sigma-U B_\sigma U^*\notin S_1
\quad\text{for every unitary }U.
\tag{20}
$$

Here is a boundary-continuity proof that does not assume RH or simplicity of zeros. The classical facts needed are the existence of a nonreal critical-line zero and zero-freeness of the line $\Re s=1$; see [DLMF 25.10(i), with its primary references](https://dlmf.nist.gov/25.10.i). Fix such a zero $\rho=1/2+i\gamma$, $\gamma\ne0$.

First $D_2$ has a local holomorphic nonzero continuation near $\rho$, even though the original operator is no longer Hilbert–Schmidt there. Write

$$
\log D_2(s)=-\tfrac12 P(2s)-T_3(s),\qquad
T_3(s)=\sum_p\sum_{j\ge3}\frac{p^{-js}}j.
$$

The tail is holomorphic for $\Re s>1/3$. Near $u_0=2\rho=1+2i\gamma$, choose a small disk on which zeta is holomorphic and nonzero and $\Re u>1/2$. On this disk the already defined function $\log D_2(u)$ is holomorphic. The local choice

$$
P_{\rm loc}(u)=\log\zeta(u)+\log D_2(u)
$$

agrees with $P(u)$ on the right-hand part of the disk when the zeta logarithm is anchored to its Euler value. Substituting it into $-P_{\rm loc}(2s)/2-T_3(s)$ proves the claimed local continuation. This uses $D_2$ near the line $\Re u=1$, not an assumed determinant at its original boundary.

Suppose the first integral in (20) were finite at $\sigma=1/2$. Then

$$
C_*(s)=s\int_2^\infty R_\pi(x)x^{-s-1}\,dx
$$

would be holomorphic for $\Re s>1/2$ and continuous on its closed half-plane, by dominated convergence on compact sets. On $\Re s>1$, the restored identity is

$$
\zeta(s)E(s)D_2(s)e^{-C_*(s)}=1.
\tag{21}
$$

Its left side is holomorphic in the entire open half-plane $\Re s>1/2$: the simple zero of $E$ removes the pole of zeta at $1$. The identity theorem extends (21) to that half-plane without presuming any zero-free assertion there. Approaching $\rho$ from the right makes the left side tend to zero. Indeed, $E$ and the local continuation of $D_2$ have finite nonzero limits, and continuity of $C_*$ does the same for $e^{-C_*}$, while $\zeta(\rho)=0$. This contradicts (21). The contradiction uses continuity itself; a singular derivative alone would not suffice.

The bounded rounding error between $\operatorname{Li}_2$ and its floor is integrable against $x^{-3/2}$. Ordered optimality therefore gives the second statement of (20) at $1/2$. For smaller positive $\sigma$, comparison of the weights gives divergence too. The unitary may depend on $\sigma$.

Finite-rank corrections and finite-codimensional compressions do not change this conclusion. For a bounded operator $T$ and a finite-codimensional orthogonal projection $P$,

$$
T-PTP=(I-P)T+PT(I-P)
$$

is finite rank. Thus $PTP$ is trace class exactly when $T$ is. At $\sigma=0$, however, both original diagonal operators are the identity; (20) explicitly excludes that endpoint.

This is an unconditional obstruction for the specified independent density spectrum. It leaves the open half-plane $\sigma>1/2$, larger Schatten ideals, signed quadratic forms and prime-dependent references outside its scope. No numerical zero tests or Lean formalization are used.
