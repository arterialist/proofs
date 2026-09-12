# Strict concavity of the natural theta coefficient exponent

The natural coefficient exponent associated with the complete theta kernel has a positive, real analytic continuation to $s>-3/2$. On this entire real interval its first derivative is strictly positive and its second derivative is strictly negative. The proof combines a certified inequality for the score $k=-g'/g$ of the derivative kernel with a two-crossing moment comparison.

## The actual functions and the result

Use the complete kernel and normalization

$$
\Phi(u)=\sum_{n=1}^{\infty}
\left(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2}\right)
e^{-\pi n^2e^{2u}},\qquad
Z=2\int_0^\infty\Phi(u)\,du>0.
$$

Set

$$
f(v)=\Phi(\sqrt v),\qquad
g(v)=-f'(v),\qquad k(v)=-\frac{g'(v)}{g(v)}.
\tag{1}
$$

The [derivative-kernel note](theta-derivative-kernel-logconcavity.md) establishes $g>0$ and $(\log g)''<0$ on $[0,\infty)$. The same note gives $g'(0)<0$. Since $k'=-(\log g)''>0$, it follows that $k>0$ and $k'>0$ on $[0,\infty)$. Evenness of $\Phi$ makes these functions smooth at zero, and $g(0)>0$. The real derivatives of $g$ decay faster than every power at infinity.

Define

$$
M(2s)=2\int_0^\infty u^{2s}\Phi(u)\,du,
\qquad
F(s+1)=L(s)=\frac{\sqrt\pi\,4^{-s}M(2s)}{Z\Gamma(s+1/2)}
\quad(\Re s>-1/2).
\tag{2}
$$

The [theta Mellin obstruction note](theta-mellin-bernstein-obstruction.md) establishes the entire continuations of $F$ and $L$. Initially, for real $s>-1/2$, the natural exponent is

$$
\phi_{\rm nat}(s)=
-\frac{4\int_0^\infty u^{2s-1}\Phi'(u)\,du}{M(2s)}.
\tag{3}
$$

**Theorem.** The complete kernel satisfies

$$
2k'(v)^2-k(v)k''(v)>0\qquad(v\ge0).
\tag{4}
$$

The function in (3) extends along the real axis to $s>-3/2$, where

$$
\phi_{\rm nat}(s)=\frac{F(s)}{F(s+1)}>0,
\qquad \phi_{\rm nat}'(s)>0,\qquad \phi_{\rm nat}''(s)<0.
\tag{5}
$$

The derivatives of $k$ in (4) are with respect to $v$. The compact part of (4) is certified by [theta_reciprocal_score_convexity.py](certificates/theta_reciprocal_score_convexity.py). The infinite tail and the implication (4)$\Rightarrow$(5) are proved below.

## Complete-kernel certification on $0\le v\le4$

For the jets $G_j=g^{(j)}$, direct algebra gives

$$
2k'^2-kk''=
\frac{2G_0G_2^2-G_1^2G_2-G_0G_1G_3}{G_0^3}.
\tag{6}
$$

The certificate uses 192-bit Arb arithmetic and accepts an interval only when the enclosing balls prove that its denominator base and numerator in (6) are strictly positive.

Near zero, write $\Phi(u)=\sum_{m\ge0}a_mu^{2m}$. The disk estimates from the derivative-kernel note are

$$
|\Phi(u)|<10000\quad(|u|\le1/2),\qquad
\left|\sum_{n\ge25}\Phi_n(u)\right|\le
D:=952\,25^4e^{-625/2}.
\tag{7}
$$

The first 24 theta summands supply the even coefficients through degree 80 in $u$, or degree $M=40$ in $v$. Each coefficient $a_m$ receives an error radius $D4^m$. The finite theta sum is not assumed even; evenness is used only for the complete kernel. Differentiating this coefficient polynomial gives enclosures of $g,g',g'',g'''$ on $0\le v\le1/16$.

Cauchy's bound $|a_m|\le10000\,4^m$ bounds the omitted part of $g^{(j)}$, for $0\le j\le3$, by

$$
E_j=10000\,4^{j+1}(M+1)^{j+1}
\frac{t^{M-j}}{1-2t},\qquad t=\frac14.
\tag{8}
$$

Indeed, bound the coefficient falling factorial by $m^{j+1}$ and use $4v\le t$. Starting at $m=M+1$, the successive majorant ratio is less than $2t$. Horner evaluation with these added error radii and adaptive rational bisection proves (6) positive on the full interval.

For $1/4\le u\le2$, put $y=\pi e^{2u}$ and define polynomials by

$$
q_0(y)=4y^2-6y,\qquad
q_{j+1}(y)=(1/2-2y)q_j(y)+2yq_j'(y).
$$

With $J=e^{u/2-y}$, write

$$
\Phi^{(j)}(u)=JS_j,
\qquad S_j=\sum_{n\ge1}q_j(n^2y)e^{-(n^2-1)y}.
\tag{9}
$$

For $j\le4$, the degrees are at most six. Let $C$ be the largest coefficient absolute sum among these polynomials. Since $y\ge3$, the omitted terms $n\ge9$ have common bound

$$
E_{\theta}=2C\,3^6\,9^{12}e^{-240}<10^{-80}.
\tag{10}
$$

To see this, use $|q_j(n^2y)|\le Cn^{12}y^6$, monotonicity of $y^6e^{-(n^2-1)y}$ for $y\ge3$, and a successive-$n$ ratio less than $1/2$. Thus evaluating the first eight terms and adding (10) encloses the complete normalized jets.

Define

$$
\begin{aligned}
A&=-S_1,& B&=S_1-uS_2,\\
C_1&=-3S_1+3uS_2-u^2S_3,&
D_1&=15S_1-15uS_2+6u^2S_3-u^3S_4.
\end{aligned}
$$

Then the exact derivative identities are

$$
g=\frac{JA}{2u},\quad g'=\frac{JB}{4u^3},\quad
g''=\frac{JC_1}{8u^5},\quad g'''=\frac{JD_1}{16u^7},
$$

and hence

$$
2k'^2-kk''=
\frac{2AC_1^2-B^2C_1-ABD_1}{16u^8A^3}.
\tag{11}
$$

The certificate proves $A>0$ and positivity of the numerator in (11) on a covering by closed rational intervals. Midpoints and radii are outwardly enclosed. An unresolved interval is bisected, and a width guard stops the calculation instead of accepting an unresolved sign.

The completed calculation used 22 intervals near zero and 780148 intervals for the normalized jets. Its common normalized theta-tail radius was below $4.578\cdot10^{-86}$. The two certified ranges join at $v=1/16$ and together cover $[0,4]$, including both endpoints. The proof rests on full interval enclosures and explicit infinite tails, not on sampled signs.

## The analytic tail $v\ge4$

Write $u=\sqrt v\ge2$, $y=\pi e^{2u}>160$, and

$$
P(y)=(y-a)(y-b),\qquad
a=\frac{15-\sqrt{105}}8,\quad
b=\frac{15+\sqrt{105}}8.
$$

Thus $0<a<b<4$ and $a+b=15/4$. Differentiating the theta series gives

$$
g(u^2)=\frac{4\pi}{u}e^{5u/2}
\sum_{n\ge1}n^2P(n^2y)e^{-n^2y}.
\tag{12}
$$

Let $g_1$ be the first summand and $k_1=-d\log g_1/dv$. Set

$$
K=\frac yu,\qquad r=\frac a{y-a}+\frac b{y-b}.
$$

Direct differentiation yields

$$
k_1=K-\frac{13}{4u}+\frac1{2u^2}-\frac ru.
\tag{13}
$$

Derivatives marked by a subscript $u$ in the following estimates are with respect to $u$. From $a+b=15/4$, $a,b<4$, and $y\ge160$,

$$
|r|\le\frac5y,\qquad
|r_u|\le\frac9y,\qquad
|r_{uu}|\le\frac{20}y.
\tag{14}
$$

For example, the exact summands of $r_u,r_{uu}$ are
$-2cy/(y-c)^2$ and $4cy(y+c)/(y-c)^3$. Also

$$
\frac uy\le\frac1{80},\qquad
\frac{u^2}y\le\frac1{40},\qquad \frac1y\le\frac1{160}.
\tag{15}
$$

These follow by evaluating at $u=2$ and observing that $ue^{-2u}$ and $u^2e^{-2u}$ decrease thereafter. Equations (13)–(15), using $d/dv=(2u)^{-1}d/du$, imply

$$
|k_1-K|\le\frac4u,\qquad
|k_1'-K'|\le\frac2{u^3},\qquad
|k_1''-K''|\le\frac3{u^5}.
\tag{16}
$$

For the last estimate, the exact difference is

$$
k_1''-K''=-\frac{39}{16u^5}+\frac1{u^6}
-\frac{r_{uu}}{4u^3}+\frac{3r_u}{4u^4}-\frac{3r}{4u^5}.
$$

The first two terms together have absolute value at most $39/(16u^5)$. The remaining terms, after multiplying by $u^5$, have total at most
$5/40+(27/4)/80+(15/4)/160$, so the bound $3/u^5$ follows. The same calculation for one derivative gives the bound $2/u^3$.

To bound the complete correction, write $g=g_1(1+\varepsilon)$. Its summands are

$$
\varepsilon=\sum_{n\ge2}n^6e^{-(n^2-1)y}
\prod_{c\in\{a,b\}}h_c,
\qquad h_c=\frac{y-c/n^2}{y-c}=1+\frac d{y-c},
\quad d=c(1-n^{-2}).
\tag{17}
$$

Since $0\le d<c<4$, direct differentiation gives

$$
|h_c|\le2,\quad |(h_c)_u|\le\frac9y,\quad
|(h_c)_{uu}|\le\frac{18}y,\quad
|(h_c)_{uuu}|\le\frac{40}y.
\tag{18}
$$

The third derivative here is
$-8dy(y^2+4cy+c^2)/(y-c)^4$. The product in (17) and its first three $u$-derivatives have absolute values at most 10. For $z=(n^2-1)y\ge480$, the derivatives of $e^{-z}$ through order three have absolute values at most $(2z)^j e^{-z}$. Leibniz's rule consequently gives

$$
|\partial_u^j\varepsilon|
\le270y^3\sum_{n\ge2}n^{12}e^{-(n^2-1)y}
\quad(0\le j\le3).
$$

Use $n^{12}\le e^{4(n^2-1)}$ and
$n^2-1\ge3+5(n-2)$ to obtain

$$
\sum_{n\ge2}n^{12}e^{-(n^2-1)y}
\le2e^{-3y+12}.
$$

For $y\ge160$, $y^3\le e^{y/2}$ and $540e^{12}\le e^{y/2}$. Therefore

$$
|\partial_u^j\varepsilon|\le e^{-2y}\quad(0\le j\le3).
\tag{19}
$$

The differentiated series converge uniformly on each compact subinterval of $u\ge2$. Indeed, the preceding summand estimates there are dominated by a constant times $n^{12}e^{-160(n^2-1)}$. This justifies all termwise derivatives used in (19).

Put $Q=\log(1+\varepsilon)$. Since $\varepsilon\ge0$, the formulas for the first three logarithmic derivatives and (19) give

$$
|\partial_u^jQ|\le6e^{-2y}\le u^{-2}
\qquad(1\le j\le3).
\tag{20}
$$

The final inequality follows, for instance, from $u^2\le y/40$ and $y\ge160$. Now $k-k_1=-Q_u/(2u)$, so (16) and (20) imply

$$
|k-K|\le\frac5u,\qquad
|k'-K'|\le\frac3{u^3},\qquad
|k''-K''|\le\frac4{u^5}.
\tag{21}
$$

The reference function satisfies

$$
K'=\frac y{u^2}\left(1-\frac1{2u}\right),\qquad
K''=\frac y{u^3}\left(1-\frac3{2u}+\frac3{4u^2}\right),
$$

$$
2K'^2-KK''=
\frac{y^2}{u^4}\left(1-\frac1{2u}-\frac1{4u^2}\right)
\ge\frac{11}{16}\frac{y^2}{u^4}.
\tag{22}
$$

Expand $2k'^2-kk''$ about $K$. Drop the nonnegative square of the first-derivative error, use (21), and note that $0<K'\le y/u^2$ and $0<K''\le y/u^3$. The total possible loss from (22) is at most

$$
\frac{y^2}{u^4}
\left(\frac{12}{uy}+\frac4{u^2y}+\frac5y+
\frac{20}{u^2y^2}\right)
\le\frac{77}{1024}\frac{y^2}{u^4}.
$$

Consequently,

$$
2k'^2-kk''\ge\frac{627}{1024}\frac{y^2}{u^4}>0
\qquad(u\ge2).
\tag{23}
$$

This proves (4) on the whole remaining half-line. The certified and analytic ranges both include $v=4$.

## Continuation of the exponent

For $\Re q>0$, define the holomorphic Mellin integrals

$$
B(q)=\int_0^\infty v^{q-1}g(v)\,dv,\qquad
C(q)=\int_0^\infty v^{q-1}(-g'(v))\,dv.
\tag{24}
$$

Boundedness of $g,g'$ near zero and their rapid decay at infinity justify arbitrary fixed powers of $\log v$ in these integrals, locally uniformly in $q$. In particular, the integrals can be differentiated with respect to $q$.

For real $q>0$, both $B(q)$ and $C(q)$ are positive. Write

$$
d\mu_q(v)=\frac{v^{q-1}g(v)}{B(q)}\,dv.
$$

Then $C(q)/B(q)=\mathbb E_q k$. For $q>1$, integration by parts gives

$$
C(q)=(q-1)B(q-1).
\tag{25}
$$

Also, if $A(p)=\int_0^\infty v^{p-1}f(v)\,dv$ for $\Re p>0$, then $B(p+1)=pA(p)$. Substituting $v=u^2$ into (3), and setting $q=s+3/2$, therefore gives

$$
\phi_{\rm nat}(s)=4\frac{C(q)}{B(q)}
=4\mathbb E_q k\qquad(s>-1/2).
\tag{26}
$$

The shifted Mellin formula in the derivative-kernel note is

$$
F(s+1)=L(s)=\frac{\sqrt\pi\,4^{-s}}{Z}
\frac{B(s+3/2)}{\Gamma(s+3/2)}
\qquad(\Re s>-3/2).
\tag{27}
$$

Equations (25) and (27), initially in their common domain, identify $4C(q)/B(q)$ with $F(s)/F(s+1)$. They then agree meromorphically for $\Re q>0$. This is a meromorphic continuation in a complex half-plane; no absence of complex zeros of $B$ is asserted. Because $B(q)>0$ for every real $q>0$, the quotient is real analytic and has no pole on the real interval $s>-3/2$.

For $0<q\le1$, formula (24), not an unregularized integral for $B(q-1)$, defines the numerator. At $q=1$ the apparent factor $q-1$ in (25) cancels the pole of the continued $B(q-1)$, and $C(1)=g(0)$. Thus $s=-1/2$ is included without an exception, with $\phi_{\rm nat}(-1/2)=4g(0)/B(1)$.

## The strict two-crossing implication

Put $W(v)=vk(v)$. Since $k,k'>0$ for $v>0$, $W'=k+vk'>0$. Moreover, $W(v)\to0$ at zero and $W(v)\to\infty$ at infinity. The function $K_*(w)=k(W^{-1}(w))$ is strictly concave, because

$$
K_*''(W(v))=
\frac{k(v)k''(v)-2k'(v)^2}{(k(v)+vk'(v))^3}<0.
\tag{28}
$$

Fix any real $q>0$. Integration of $(v^qg(v))'$ gives the exact Stein identity

$$
\mathbb E_q W=q.
\tag{29}
$$

There is no boundary contribution at zero, since $v^qg(v)\to0$ for every $q>0$, including $q\le1$. The contribution at infinity vanishes by rapid decay.

Let $X=\log v$, $m=\mathbb E_qX$, $d^2=\operatorname{Var}_q(X)$, and

$$
H(v)=(\log v-m)^2-d^2.
$$

The measure has positive density on $(0,\infty)$, so $d>0$. For any of the fixed functions $a(v)=1,W(v),k(v)$, differentiating the normalized expectation twice gives

$$
\frac{d^2}{dq^2}\mathbb E_q a=\mathbb E_q[aH].
\tag{30}
$$

All terms here are integrable. For $a=k$, the factor $kg=-g'$ removes the quotient in (1); for $a=W$, the corresponding factor is $Wg=-vg'$. Thus boundedness at zero and rapid decay of $g,g'$, with additional logarithmic factors, justify (30) on every compact subinterval of $q>0$.

Using $a=1$ and then (29) gives the two exact moment identities

$$
\mathbb E_qH=0,\qquad \mathbb E_q[WH]=0.
\tag{31}
$$

The two roots of $H$ are $v_-=e^{m-d}$ and $v_+=e^{m+d}$. Its signs are positive, negative, positive on the three intervals they determine. Let $\ell(w)$ be the affine function through the two points
$(W(v_-),k(v_-))$ and $(W(v_+),k(v_+))$.
Strict concavity in (28) implies that $k(v)-\ell(W(v))$ is strictly positive between these roots and strictly negative outside them. Consequently

$$
[k(v)-\ell(W(v))]H(v)<0
\qquad(v\ne v_-,v_+).
$$

The product is integrable, and the measure has positive density on every open interval. Its integral is therefore strictly negative. The affine term integrates to zero by (31), so

$$
\frac{d^2}{dq^2}\mathbb E_q k
=\mathbb E_q[kH]<0.
$$

Finally $q=s+3/2$ has derivative one. Equation (26), continued as above, proves $\phi_{\rm nat}''(s)<0$ for every real $s>-3/2$.

Differentiating once also gives

$$
\phi_{\rm nat}'(s)=4\operatorname{Cov}_q(k(V),\log V)>0.
$$

For independent $V,V'$ with law $\mu_q$, twice this covariance equals the expectation of $(k(V)-k(V'))(\log V-\log V')$. Both functions strictly increase, so the integrand is positive whenever $V\ne V'$. The law has a density and the preceding domination proves integrability, giving strict positivity.

## Verification scope

The generic two-crossing comparison is classical. See Karlin and Novikoff, [*Generalized convex inequalities*](https://msp.org/pjm/1963/13-4/pjm-v13-n4-p18-s.pdf), *Pacific Journal of Mathematics* 13, 1963, pp. 1251–1279, §1, Lemma b on printed p. 1253. Their signed zero-mass and zero-first-moment comparison for convex functions gives the inequality used here after reversing its sign for concave functions.

The secant comparison can be stated independently: if a signed weight has zero mass and zero first moment, and its sign is opposite to the deviation of a function from an affine secant, the weighted integral is nonpositive. [TwoCrossingMoment.lean](BuildingBlocks/TwoCrossingMoment.lean) proves that generic nonpositive-integral conclusion from explicit sign, integrability, and zero-moment hypotheses. It does not establish the theta-kernel hypotheses, the Stein identity, the continuation, or the strict inequality in this note. Those steps are supplied by the written proof and the Arb certificate above.

The certificate requires Python 3 and python-flint. From the repository root, run it without Python's `-O` option, because its checks use assertions.

```sh
python3 building-blocks/certificates/theta_reciprocal_score_convexity.py
```

This is a computer-assisted mathematical result about the actual theta coefficient exponent. No publication-priority claim is made. Positivity and strict concavity alone establish neither a Bernstein-function representation nor membership in $B_J$, and no Riemann-hypothesis conclusion is drawn.
