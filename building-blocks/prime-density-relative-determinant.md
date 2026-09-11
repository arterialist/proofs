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
\inf_{U\ {
m unitary}}\|A_\sigma-U B_\sigma U^*\|_1
=\sum_j|p_j^{-\sigma}-q_j^{-\sigma}|.
```

This is an application of classical Hermitian spectral variation; see [Bhatia, equations (17)–(18)](https://www.isid.ac.in/~statmath/2007/isid200703.pdf). A short proof also fixes the infinite-dimensional scope. For finite Hermitian matrices $A,B$, write $D=A-B=D_+-D_-$ and $C=B+D_+=A+D_-$. Ordered eigenvalues obey $c_j\ge a_j,b_j$ by min-max. Therefore

```math
\sum_j|a_j-b_j|\le2\operatorname{Tr}C-\operatorname{Tr}A-\operatorname{Tr}B
=\operatorname{Tr}D_++\operatorname{Tr}D_-=\|A-B\|_1.
```

For positive compact operators and fixed $U$, the assertion is automatic if $A-UBU^*$ is not trace class. Otherwise compress onto finite-rank projections increasing strongly to identity. Compactness gives operator-norm convergence of the compressions and hence convergence of each fixed ordered eigenvalue. Their trace-norm differences are at most $\|A-UBU^*\|_1$. Apply the finite inequality, first let the rank tend to infinity with a fixed number of eigenvalues retained, then let that number increase. This proves the same lower bound for the complete ordered eigenvalue difference. The identity unitary attains it for the two already ordered diagonal spectra.

Thus changing the basis cannot bypass the weighted prime discrepancy in (3). A different reference spectrum, a nonunitary construction or a separately proved arithmetic estimate is outside this obstruction.
