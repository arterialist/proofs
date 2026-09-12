# Decay and the exact constant for the actual seed renewal

This is a written proof. The literal operator and signed arithmetic driver come from the [compensated successor representation](literal-compensated-successor-iterates.md); no theorem here is formalized in Lean.

Use precisely the scalar renewal from [literal-compensated-successor-iterates.md](literal-compensated-successor-iterates.md):
$$
 q_0=1,\qquad q_n=\frac{\arctan\sqrt n}{\sqrt n}\quad(n\ge1),
 \qquad f_m=q_{m-1}-q_m,
$$
$$
 r_0=1,\qquad r_n=\sum_{m=1}^nf_mr_{n-m}.
\tag{1}
$$
Then
$$
 \boxed{r_{n+1}<r_n,\qquad
 0<r_n\le(n+1)^{-1/2},\qquad
 r_n\sim\frac{2}{\pi^2\sqrt n}.}
\tag{2}
$$
In particular $r_n\to0$. The sharp asymptotic follows from an applicable primary theorem at the boundary index $1/2$. A separate proof below obtains it from the exact moment representation and elementary positive-measure convergence. No generic strong-renewal assertion for an arbitrary regularly varying tail is used.

## 1. Exact interarrival law and boundary-theorem hypotheses

For real $y\ge0$,
$$
 q(y)=\int_0^1\frac{dx}{1+yx^2}.
\tag{3}
$$
It decreases strictly from one to zero. Therefore every $f_m>0$, $\sum_{m\ge1}f_m=1$, and the distribution with mass $f_m$ at $m$ has lattice span one. Its tail is exactly
$$
 \mathbb P(X>n)=q_n,\qquad
 \mathbb P(X>x)=q_{\lfloor x\rfloor}\quad(x\ge0).
\tag{4}
$$
The expansion of the actual function in (3) gives
$$
 q(y)=\frac{\pi}{2\sqrt y}-\frac1y+O(y^{-2}),\qquad
 -q'(y)=\frac{\pi}{4y^{3/2}}-\frac1{y^2}+O(y^{-3}).
$$
Integrating the second formula over $[m-1,m]$ yields
$$
 f_m=\frac{\pi}{4m^{3/2}}+O(m^{-2}).
\tag{5}
$$
These computations keep the exceptional $q_0=1$; no continuous formula is evaluated by division at zero.

The applicable primary source is Caravenna and Doney, *Local large deviations and the strong renewal theorem*, [Theorem 1.5, PDF page 4](https://arxiv.org/pdf/1612.07635). For a positive-increment law with tail asymptotic to $1/A(x)$, $A\in RV(1/2)$, it proves the strong renewal theorem under
$$
 \sup_{1\le s\le x}\frac{A(s)}{\sqrt s}
                 =O\!\left(\frac{A(x)}{\sqrt x}\right).
\tag{6}
$$
For this exact law choose $A(x)=(2/\pi)\sqrt x$ on $x\ge1$. Equation (4) verifies the tail assumption and both sides of (6) are the same constant. Their normalization on PDF page 3 gives, for lattice span one,
$$
 U((n-1,n])\sim\frac{\sin(\pi/2)}{\pi}\frac{A(n)}n
                  =\frac2{\pi^2\sqrt n}.
\tag{7}
$$
Here $U=\sum_{j\ge0}\operatorname{Law}(X)^{*j}$, and $U((n-1,n])=r_n$. The zero-step atom is at zero and causes no shift for $n\ge1$. This verifies the boundary hypothesis explicitly, rather than inferring (7) from regular variation alone.

## 2. A direct monotonicity and all-index bound

The exact integral (3) is a Hausdorff moment representation:
$$
 q_n=\int_0^1\int_0^\infty
                 e^{-t}(e^{-x^2t})^n\,dt\,dx.
\tag{8}
$$
Its representing probability measure is not concentrated at one point. Cauchy--Schwarz therefore proves strict log-convexity,
$$
 q_n^2<q_{n-1}q_{n+1}\qquad(n\ge1).
\tag{9}
$$
Thus the ratios $a_n=q_n/q_{n-1}$ strictly increase.

The reciprocal-coefficient argument is the classical Kaluza sign mechanism, here with strict inequalities. See [Kaluza’s 1928 paper, bibliographic record](https://eudml.org/doc/168016) and [Baricz, Vesti and Vuorinen, Theorem 1.3](https://journals.umcs.pl/a/article/download/3944/2853). We give the actual coefficient proof in full. Set $c_1=q_1$ and recursively
$$
 c_n=q_n-\sum_{j=1}^{n-1}c_jq_{n-j},\qquad n\ge2.
\tag{10}
$$
Assume that $c_1,\ldots,c_{n-1}>0$. The preceding coefficient identity gives
$q_{n-1}=\sum_{j=1}^{n-1}c_jq_{n-1-j}$, where $q_0=1$. Hence
$$
 c_n=\sum_{j=1}^{n-1}c_jq_{n-1-j}(a_n-a_{n-j})>0.
\tag{11}
$$
This proves positivity by induction. Equivalently, for formal series
$Q(z)=\sum q_nz^n$, the nonconstant coefficients of $1/Q(z)$ are $-c_n<0$.

Let $R(z)=\sum r_nz^n$. The actual renewal equation gives
$$
 \sum_{m\ge1}f_mz^m=1-(1-z)Q(z),\qquad
 R(z)=\frac1{(1-z)Q(z)}.
\tag{12}
$$
These identities hold formally and absolutely for $|z|<1$; positivity and the recurrence give $r_n\le1$. Thus
$$
 (1-z)R(z)=1/Q(z)
 \quad\Longrightarrow\quad r_n-r_{n-1}=-c_n<0.
\tag{13}
$$
The renewal recurrence also gives $r_n>0$.

Taking coefficients in (12) yields the exact convolution
$$
 \sum_{j=0}^nq_jr_{n-j}=1.
\tag{14}
$$
Since $r$ decreases, $r_n\sum_{j=0}^nq_j\le1$. The elementary inequality
$\arctan x\ge x/\sqrt{1+x^2}$, whose derivative difference is nonnegative, gives
$$
 q_j\ge(j+1)^{-1/2},\qquad
 \sum_{j=0}^nq_j\ge\sqrt{n+1}.
$$
Consequently
$$
 \boxed{r_n\le\frac1{\sum_{j=0}^nq_j}\le\frac1{\sqrt{n+1}}.}
\tag{15}
$$
This already proves decay independently of a renewal theorem and supplies a uniform bound for reference-profile limits.

## 3. An independent proof of the sharp asymptotic

The following argument can replace the primary-theorem application in Section 1. From the explicit $q_n$ asymptotic,
$$
 Q(e^{-h})\sim\frac{\pi^{3/2}}2h^{-1/2},\qquad h\downarrow0.
\tag{16}
$$
Indeed $h^{1/2}\sum_{n\ge1}n^{-1/2}e^{-hn}\to\sqrt\pi$ by an improper Riemann sum. The part $hn\le\delta$ is bounded by $2\sqrt\delta+o(1)$; the tail is controlled exponentially. The $O(n^{-1})$ coefficient error contributes only $O(\log(1/h))$, and $q_0$ is harmless. By (12),
$$
 R(e^{-h})\sim C_0h^{-1/2},\qquad C_0=2/\pi^{3/2}.
\tag{17}
$$

For clarity, the positive-coefficient Tauberian step can be proved without assuming any pointwise conclusion about $r_n$. Define locally finite positive measures
$$
 \sigma_h=h^{1/2}\sum_{n\ge0}r_n\delta_{hn},\qquad
 B_h=\int e^{-x}\sigma_h(dx)=h^{1/2}R(e^{-h})\to C_0.
$$
The probability measure $\nu_h=B_h^{-1}e^{-x}\sigma_h$ has, for every integer $k\ge0$,
$$
 \int e^{-kx}\nu_h(dx)
 =\frac{h^{1/2}R(e^{-(k+1)h})}{B_h}
                         \longrightarrow(k+1)^{-1/2}.
\tag{18}
$$
Push these probabilities to $[0,1]$ by $y=e^{-x}$. Polynomial approximation on this compact interval shows weak convergence, since (18) gives every monomial moment. The limiting probability is the pushforward of
$$
 \frac1{\sqrt\pi}e^{-x}x^{-1/2}\mathbf1_{x>0}\,dx,
$$
which has exactly those moments. No mass is added at $y=0$; the displayed probability already has total mass one and determines the compact-interval moment sequence uniquely.

For fixed $b>0$, the bounded test $y^{-1}\mathbf1_{y\ge e^{-b}}$ has just one discontinuity, at a point where the limit has no atom. Thus
$$
 \sigma_h([0,b])\longrightarrow
 \frac{C_0}{\sqrt\pi}\int_0^b x^{-1/2}dx
                         =\frac4{\pi^2}\sqrt b.
\tag{19}
$$
With $h=1/n$, $b=1$, this proves
$$
 U_n:=\sum_{j=0}^nr_j\sim\frac4{\pi^2}\sqrt n.
\tag{20}
$$

Finally monotonicity in (13) converts partial sums to individual terms. For fixed $\ell>1$, forward and backward difference quotients imply
$$
 \liminf_{n\to\infty}\sqrt n\,r_n
 \ge\frac{4/\pi^2}{\sqrt\ell+1},\qquad
 \limsup_{n\to\infty}\sqrt n\,r_n
 \le\frac{(4/\pi^2)\sqrt\ell}{\sqrt\ell+1}.
$$
Integer rounding changes neither limit. Letting $\ell\downarrow1$ proves
$$
 r_n\sim2/(\pi^2\sqrt n),
$$
independently of Section 1. The extra structure that permits this elementary proof is the exact log-convex tail and resulting monotone renewal sequence.

## 4. What the successor consumer can use

The identities here concern the exact scalar feedback already derived from the literal compensated successor. They give $r_n\to0$, fixed-lag ratios $r_{n-j}/r_n\to1$, the sharp constant, and the all-index majorant (15). They do not replace the signed arithmetic driver or discard its frozen tail.

In particular, the source consumer may use these bounds in its existing identities
$$
 V_k=C^kh_1=\sum_{j=0}^kr_jS^{k-j}h_1,\qquad
 C^kg_N=S^kg_N-\sum_{i<k}e_iV_{k-1-i}.
$$
The physical profile and the convergence of $C^kg_N-M_NV_k$ are proved separately in the [signed-source stabilization theorem](signed-source-successor-stabilization.md). No positivity of arbitrary $C$-iterates or short-time RH target follows merely from (2).
