# Upper-prime plaquettes and the actual Möbius cone

Fix an integer $N\ge3$ and put $\rho=e^{-2/N}$. For real prefix vectors on
$\{1,\ldots,N\}$, use

$$
\langle f,g\rangle_N=(1-\rho)\sum_{m=1}^N\rho^m f(m)g(m),
\qquad Z_N(f)=\langle f,f\rangle_N.
$$

Extend every prefix by $f(0)=0$ and set

$$
(S_pf)(m)=f(\lfloor m/p\rfloor),\qquad A_p=I-S_p.
$$

If $B$ is a finite set of primes, let
$F_B(m)=\sum_{n\le m,\,\operatorname{PrimeFac}(n)\subseteq B}\mu(n)$,
where $1$ is included.
Then $F_\varnothing=\mathbf1$ and the exact prime admission rule is

$$
F_{B\cup\{p\}}=A_pF_B \quad(p\notin B).
\tag{1}
$$

The operators $S_p$ commute. Equation (1) is the finite Boolean-cube
version of the Euler product. It retains the real cutoff $m\le N$ and
every composite cofactor.

## The two-prime energy face

For distinct $p,q\notin B$, write $f=F_B$, $a=S_pf$, $b=S_qf$, and
$c=S_pS_qf$. The mixed second difference of energy around the prime
face is exactly

$$
\begin{aligned}
&Z_N(A_pA_qf)-Z_N(A_pf)-Z_N(A_qf)+Z_N(f)\\
&\qquad=2\langle a,b\rangle_N
 +2\langle f-a-b,c\rangle_N+Z_N(c).
\end{aligned}
\tag{2}
$$

This follows by expanding $A_pA_qf=f-a-b+c$ and cancelling the four
squares. In particular, an arithmetic face can be absent while its
energy interaction survives. If $pq>N$, then $c=0$ and (2) becomes
$2\langle S_pf,S_qf\rangle_N$.

There is an exact positive instance inside the Möbius source. Suppose
$N/2<p<q\le N$. Since $F_B(1)=1$ and $\lfloor m/p\rfloor$ is either
$0$ or $1$ for $m\le N$,

$$
S_pF_B=\mathbf1_{[p,N]},\qquad
S_qF_B=\mathbf1_{[q,N]},\qquad S_pS_qF_B=0.
$$

Consequently every such prime pair has the same strictly positive
plaquette, independent of the earlier admitted primes:

$$
\boxed{\displaystyle
Z_N(F_{B\cup\{p,q\}})-Z_N(F_{B\cup\{p\}})
-Z_N(F_{B\cup\{q\}})+Z_N(F_B)
=2\rho^q(1-\rho^{N-q+1})>0.}
\tag{3}
$$

The right side is twice the weighted overlap of the two future cones.
It is not a $pq$ coefficient: $pq>N$. Thus a boundary-of-boundary
identity for the arithmetic cube does not make its squared energy
curvature vanish or negative.

## The whole upper-prime shell

Let $\mathcal P_N=\{p\text{ prime}:N/2<p\le N\}$ and split the actual
Möbius prefix as $M=U_N+V_N$, where

$$
U_N(m)=-\sum_{p\in\mathcal P_N}\mathbf1_{m\ge p}
=-\bigl(\pi(m)-\pi(N/2)\bigr)_+.
\tag{4}
$$

Every member of this shell occurs only as the prime itself in the
horizon $m\le N$. If $y=(\log N)^2$, then $y<N/2$ eventually, so $U_N$
is a literal subcone of $M-F_y$.

The prime number theorem, uniformly for $t\in[1/2,1]$, gives
$\pi(tN)-\pi(N/2)=(t-1/2)N/\log N+o(N/\log N)$. A Riemann sum in (4)
therefore yields

$$
\boxed{\displaystyle
Z_N(U_N)\sim C\frac{N^2}{\log^2N},\qquad
C=2\int_{1/2}^1e^{-2t}(t-1/2)^2\,dt
=\frac{2e-5}{4e^2}>0.}
\tag{5}
$$

Equivalently,

$$
Z_N(U_N)=\sum_{p\in\mathcal P_N}Z_N(\mathbf1_{[p,N]})
+2\sum_{\substack{p,q\in\mathcal P_N\\p<q}}
\rho^q(1-\rho^{N-q+1}).
\tag{6}
$$

The diagonal sum in (6) is $O(N/\log N)$. Hence the positive pair
plaquettes account for the leading $N^2/\log^2N$ term.

There is a precise compensating covariance in the complete source.
The classical unconditional bound

$$
M(x)\ll x\exp\!\left[-c(\log x)^{3/5}
(\log\log x)^{-1/5}\right]
\tag{7}
$$

for some $c>0$ implies $\max_{m\le N}|M(m)|=o(N/\log N)$, by using
the trivial bound for $m\le\sqrt N$. Thus
$Z_N(M)=o(N^2/\log^2N)$. From $V_N=M-U_N$ and (5),

$$
Z_N(V_N)\sim Z_N(U_N),\qquad
\langle U_N,V_N\rangle_N=-Z_N(U_N)+o(Z_N(U_N)),
\tag{8}
$$

and their correlation tends to $-1$. This is unconditional cancellation
of the **upper-prime shell against all its complementary arithmetic
terms**. It does not isolate the correlation between $F_y$ and the
entire rough cone at $y=(\log N)^2$.

For comparison, if $R_y=M-F_y$ and $Z_N(F_y)>0$, set
$\varepsilon^2=Z_N(M)/Z_N(F_y)$. The same Hilbert-space calculation gives,
whenever $\varepsilon<1$,

$$
\frac{\langle F_y,R_y\rangle_N}
{\sqrt{Z_N(F_y)Z_N(R_y)}}
\le-\sqrt{1-\varepsilon^2}.
\tag{9}
$$

Indeed, write $x=\sqrt{Z_N(R_y)/Z_N(F_y)}$ and use
$(\varepsilon^2-1-x^2)/(2x)
=-[x+(1-\varepsilon^2)/x]/2\le-\sqrt{1-\varepsilon^2}$.
The [exact-horizon signed smooth-energy bound](signed-smooth-exact-horizon-energy.md)
would make (9) nearly perfect at $y=(\log N)^2$ if one already had
an RH-strength bound for $Z_N(M)$. Equation (9) measures the required
covariance; it does not supply it.

## A source-specific decreasing metric

Define the divisor-summation map

$$
(Df)(m)=\sum_{k\le m}f(\lfloor m/k\rfloor).
$$

It is lower triangular with diagonal entries $1$, so
$\langle f,g\rangle_{D,N}:=\langle Df,Dg\rangle_N$ is a positive-definite
metric. Möbius inversion gives an exact order law for the actual source:

$$
(DF_B)(m)
=\#\{r\le m:\text{no prime factor of }r\text{ belongs to }B\}.
\tag{10}
$$

To prove (10), reverse the two finite sums in $DF_B(m)$. The resulting
coefficient of an integer $r$ is
$\sum_{d\mid r,\,\operatorname{PrimeFac}(d)\subseteq B}\mu(d)
=\prod_{p\mid r,\,p\in B}(1-1)$, which is $1$ exactly when $r$ has
no factor in $B$. Thus $DF_B(m)$ decreases pointwise as $B$ grows.
In particular, $DM(m)=1$ for every $m\le N$, and
$\langle F_B,F_B\rangle_{D,N}$ decreases along the actual prime
admissions. This is source-specific monotonicity in a nonlocal metric.
It gives no bound for $Z_N(M)$: the inverse divisor map is precisely
the oscillating Möbius operation whose fixed-metric size is at issue.

## Why a fixed positive metric cannot contract prime admission

For $p\le N$, $S_p$ is nonzero and nilpotent:
$(S_p^kf)(m)=f(\lfloor m/p^k\rfloor)$ vanishes for large $k$.
Hence $A_p=I-S_p$ is a nonidentity unipotent matrix with determinant
$1$. There is no positive-definite matrix $G$ for which

$$
A_p^{\mathsf T}GA_p\preceq G.
\tag{11}
$$

If (11) held, every singular value of $A_p$ in the $G$ metric would
be at most $1$. Their product is $|\det A_p|=1$, so every singular
value would equal $1$. The operator would be a $G$ isometry, hence
diagonalizable over $\mathbb C$. A diagonalizable unipotent matrix is
the identity, a contradiction.

A changing metric can preserve every vector's norm by setting
$G_{\mathrm{new}}=A_p^{-\mathsf T}G_{\mathrm{old}}A_p^{-1}$.
This identity gives no inequality in the fixed energy $Z_N$. It also
forces cross-scale terms: if $G_{\mathrm{new}}$ is positive and diagonal,
then $A_p^{\mathsf T}G_{\mathrm{new}}A_p$ has a negative off-diagonal
entry between coordinates $m$ and $\lfloor m/p\rfloor$ for each
$p\le m\le N$. The extra covariance is part of any exact moving
geometry.

The shell cancellation (8) uses the actual Möbius coefficients and a
classical analytic bound. The plaquette (3) and the no-go theorem (11)
show why cube topology or metric positivity alone cannot force the
critical rough-smooth sign. No RH conclusion is drawn here.

The outside arithmetic input in (7) follows, after reducing $c$ to
absorb a factor of $\log x$, from
[Lee and Leong's explicit Mertens bounds](https://arxiv.org/abs/2208.06141).
