# Positive third derivative of the natural theta exponent

This is a computer-assisted mathematical proof for the complete theta kernel.
It does not prove Bernstein membership or RH. The compact interval certificate is
[theta_natural_exponent_third_derivative.py](certificates/theta_natural_exponent_third_derivative.py).
Its completed calculation covers both compact regions. The analytic tail and nonlocal argument are given below.
The actual application has not been formalized in Lean.

## Statement, notation, and endpoints

Use the normalization and previously proved facts in the
[natural-exponent concavity theorem](theta-natural-exponent-concavity.md):

$$
\Phi(u)=\sum_{n\ge1}(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2})
e^{-\pi n^2e^{2u}},\qquad
h(v)=\Phi(\sqrt v),\quad g=-h',\quad k=-g'/g.
$$

We already have, on the whole closed half-line,

$$
g>0,\qquad k>0,\qquad k'>0,\qquad
T:=2(k')^2-kk''>0.
\tag{1}
$$

Primes on functions of $v$ throughout this note mean $v$-derivatives.
Let $L(z)=F(z+1)$ be the actual normalized Mellin interpolant, and put

$$
B(q)=\int_0^\infty v^{q-1}g(v)\,dv,\qquad
C(q)=\int_0^\infty v^{q-1}(-g'(v))\,dv.
$$

The derivative Mellin continuations already proved give, for every real
$s>-3/2$, with $q=s+3/2>0$,

$$
\varphi_{\rm nat}(s)=\frac{L(s-1)}{L(s)}
=4\frac{C(q)}{B(q)}=4\mathbb E_q k(V),\qquad
d\mu_q(v)=\frac{v^{q-1}g(v)}{B(q)}\,dv.
\tag{2}
$$

In particular, (2) for $q\le1$ uses Mellin continuation, not integration
by parts with the generally nonvanishing endpoint $v^{q-1}g(v)$.
The complex quotient is meromorphic; the conclusion here concerns real
$s>-3/2$.

We prove

$$
\boxed{\varphi_{\rm nat}'''(s)>0\qquad(s>-3/2).}
\tag{3}
$$

All fixed kernel and score jets are bounded at zero. At infinity the full
theta kernel decays on the scale $e^{-\pi e^{2\sqrt v}}$, which dominates
every fixed product of score derivatives and logarithmic factors. Uniformly
for $q$ on compact subintervals of $(0,\infty)$, this proves the
differentiations and integrations used below. In particular, with $W=vk$,

$$
\mathbb E_q[(1+k+W^2+|vW'|)(1+|\log V|^3)]<\infty,
\quad
v^qg(v)(1+|\log v|^3)(1+W(v))\longrightarrow0
\tag{4}
$$

at both endpoints. At zero this follows from $q>0$, bounded jets, and
$W=O(v)$; at infinity it follows from the theta estimate just stated.

## Two pointwise inequalities

Define

$$
Q_2=W^2-vW',\quad A=W',\ B_*=W'',\ C_*=W''',\ H_*=W'''',
$$
$$
N=Q_2''W'-Q_2'W''
=2A^3-AB_*+v(B_*^2-AC_*),
\tag{5}
$$
$$
N'=6A^2B_*-2AC_*+v(B_*C_*-AH_*),\quad
T'=3k'k''-kk''',\quad \mathcal D=TN'-T'N.
\tag{6}
$$

We establish

$$
N(v)>0,\qquad \mathcal D(v)>0\qquad(v\ge0).
\tag{7}
$$

### Compact interval, including zero

The 192-bit Arb certificate obtained:

```
CERTIFIED N>0 and T*N-prime-T-prime*N>0 on 0<=v<=1/16 with 167 intervals
CERTIFIED N>0 and T*N-prime-T-prime*N>0 on 1/4<=u<=3 with 5376 intervals
Normalized theta-tail disk bound: [6.87987706939139800146441774094246593888403737135203391058e-132 +/- 4.17e-189]
Conclusion: BOTH order-three signs hold for EVERY 0<=v<=9.
```

Here $u=\sqrt v$. The two closed regions meet at $v=1/16$.
These are covering interval enclosures, not sampled sign evaluations.

Near zero, the even Taylor expansion of $\Phi$ through degree $u^{80}$
uses the full-kernel disk bound $|\Phi(u)|<10000$ for $|u|\le1/2$.
The omitted theta terms $n\ge25$ on this disk have bound
$952\,25^4e^{-625/2}$, hence coefficient errors bounded by this
quantity times $4^m$ for the coefficient of $u^{2m}$.
For $0\le v\le1/16$, the omitted $j$-th derivative of $g$ has bound

$$
10000\,4^{j+1}41^{j+1}(1/4)^{40-j}/(1-1/2),
\qquad 0\le j\le5.
\tag{8}
$$

These jets give the first five coefficients of the formal quotient
$-g'/g$, and therefore all the score jets needed in (5)–(6).

For $1/4\le u\le3$, put $y=\pi e^{2u}$ and
$P_8(y)=8y^2-30y+15$. The exact normalized formula is

$$
\log g(u^2)=\tfrac52u-y+\log P_8(y)-\log u
+\log(1+R(u))+\text{constant},
$$
$$
R(u)=\sum_{n\ge2}n^2\frac{P_8(n^2y)}{P_8(y)}e^{-(n^2-1)y}.
\tag{9}
$$

The source retains terms $2\le n\le8$, with the entire remaining sum
enclosed on each complex disk $|z-u|\le1/16$. There
$\Re(\pi e^{2z})>4$ and $|\pi e^{2z}|<2\Re(\pi e^{2z})$.
The two roots of $P_8$ lie in $(0,1)$ and $(0,13/4)$. Thus,
writing $Y=\pi e^{2z}$,

$$
|P_8(Y)|>\tfrac98(\Re Y)^2,
\qquad |P_8(n^2Y)|\le68n^4(\Re Y)^2.
$$

The omitted normalized sum is consequently bounded by

$$
61\sum_{n\ge9}n^6e^{-4(n^2-1)}
\le122\,9^6e^{-320}.
\tag{10}
$$

Cauchy's estimate multiplies (10) by $16^j$ for its $j$-th Taylor
coefficient, $0\le j\le5$. A formal series of length six in (9),
followed by $k=-\partial_u\log g/(2u)$ and four applications of
$(2u)^{-1}\partial_u$, gives the required interval jets. This proves
(7) on $[0,9]$ with the full infinite theta sum retained.

### Analytic tail: full score jets

Let $u\ge3$, $y=\pi e^{2u}>1200$, $K=y/u$, and
$a,b=(15\mp\sqrt{105})/8$. Exactly,

$$
k=K-\frac{13}{4u}+\frac1{2u^2}-\frac{r}{u}-\frac{q_u}{2u},
\quad r=\frac a{y-a}+\frac b{y-b},\quad q=\log(1+\epsilon),
$$
$$
\epsilon=\sum_{n\ge2}n^6e^{-(n^2-1)y}
\prod_{c=a,b}\frac{y-c/n^2}{y-c}\ge0.
\tag{11}
$$

For a function $f(u)$, write

$$
\partial_v^j(f/u)=\sum_{\ell=0}^j c_{j\ell}
\frac{\partial_u^\ell f}{u^{2j+1-\ell}}.
$$

The coefficient rows, in increasing $\ell$, are

$$
\begin{array}{c|rrrrr}
0&1\\
1&-1/2&1/2\\
2&3/4&-3/4&1/4\\
3&-15/8&15/8&-3/4&1/8\\
4&105/16&-105/16&45/16&-5/8&1/16.
\end{array}
\tag{12}
$$

The geometric expansion of $r$ gives
$|\partial_u^j r|\le2^{j+3}/y$ for $0\le j\le5$: use
$a+b<4$, $a,b<4$, and
$\sum_{\ell\ge1}\ell^j(4/y)^{\ell-1}
\le\sum_{\ell\ge1}(32/300)^{\ell-1}<2$.
The functions $u^\ell/y$ decrease for $u\ge3$ and $\ell\le4$.
Thus (12) gives normalized bounds for $\partial_v^j(r/u)$:

$$
u^{2j+1}|\partial_v^j(r/u)|
\le (1/150,\ 7/300,\ 19/200,\ 179/400,\ 1937/800)_j.
\tag{13}
$$

Each ratio factor in (11) has absolute value at most two and its first five
$u$-derivatives have absolute values at most $2^{j+3}/y<1$.
The derivatives of the product of two factors are therefore bounded by 128.
For $z=(n^2-1)y\ge3600$, direct differentiation through order five gives
$|\partial_u^j e^{-z}|\le(4z)^je^{-z}$.
Leibniz's rule now proves

$$
|\partial_u^j\epsilon|
\le400000y^5\sum_{n\ge2}n^{16}e^{-(n^2-1)y}
\le800000y^5e^{-3y+18}\le e^{-2y},\quad 0\le j\le5.
\tag{14}
$$

For the sum use $n^{16}\le e^{6(n^2-1)}$ and
$n^2-1\ge3+5(n-2)$. For the last inequality use
$y^5\le e^{y/2}$, $800000<e^{14}$, and $y/2\ge600$.
The bounds also justify differentiating the infinite sum. The logarithmic
derivative formulas through order five, whose absolute coefficient sums
are at most 150, imply

$$
|\partial_u^j q|\le150e^{-2y}\le y^{-2},\quad 1\le j\le5.
$$

Using (12) and the decrease of $u^\ell/y^2$,

$$
u^{2j+1}\left|\partial_v^j\frac{q_u}{2u}\right|
\le\frac12\sum_{\ell=0}^j|c_{j\ell}|\frac{u^\ell}{y^2}
\le\frac{147}{4\cdot1200^2}<1.
\tag{15}
$$

Direct differentiation of the elementary correction in (11) gives the
normalized bounds

$$
u^{2j+1}\left|\partial_v^j
\left(-\frac{13}{4u}+\frac1{2u^2}\right)\right|
\le(41/12,\ 43/24,\ 133/48,\ 227/32,\ 1621/64)_j.
$$

Adding these bounds to (13) and (15) proves

$$
|(k-K)^{(j)}|\le M_j/u^{2j+1},
\quad M=(5,3,4,10,32),\quad 0\le j\le4.
\tag{16}
$$

### Analytic tail: the two signs

Put $h_*=1/u$, $W_0=uy$, and let $A_0,B_0,C_0,H_0$ be
its first four $v$-derivatives. Exactly,

$$
\begin{aligned}
A_0&=y(1+h_*/2),\\
B_0&=(y/u)(1+h_*/2-h_*^2/4),\\
C_0&=(y/u^2)(1-3h_*^2/4+3h_*^3/8),\\
H_0&=(y/u^3)(1-h_*-3h_*^2/4+15h_*^3/8-15h_*^4/16).
\end{aligned}
$$

Equation (16) yields errors $(8/u,10/u^3,22/u^5,72/u^7)$
for these four derivatives. Each actual or main derivative has absolute
value at most $(6/5)y/u^{j-1}$, for derivative order $1\le j\le4$.

Let $N_0=2A_0^3$. This approximation deliberately excludes the lower
terms in (5), which must be bounded. Write
$\mathcal L=-AB_*+u^2(B_*^2-AC_*)$. Its main counterpart satisfies

$$
\mathcal L_0=-y^2(h_*/2+h_*^2/2+h_*^3/4),\quad
\mathcal L_0'=(y^2/u)(-h_*-3h_*^2/4+3h_*^4/8).
$$

Hence $|\mathcal L_0|\le y^2/u$ and
$|\mathcal L_0'|\le(5/4)y^2/u^2$.
Expanding one factor difference at a time gives

$$
\begin{array}{ll}
|AB_*-A_0B_0|\le14y/u^2,&
u^2|B_*^2-B_0^2|\le24y/u^2,\\
u^2|AC_*-A_0C_0|\le13y/u,&
2|AC_*-A_0C_0|\le26y/u^3,\\
u^2|B_*C_*-B_0C_0|\le21y/u^3,&
u^2|AH_*-A_0H_0|\le13y/u^2.
\end{array}
$$

Consequently $|\mathcal L-\mathcal L_0|\le26y/u$ and
$|\mathcal L'-\mathcal L_0'|\le29y/u^2$. Also

$$
|2A^3-2A_0^3|\le(1728/25)y^2/u<70y^2/u,
$$
$$
|6A^2B_*-6A_0^2B_0|
\le(3456/25+2160/(25u))y^2/u^2<168y^2/u^2.
$$

Using $y>1200$ gives

$$
|N-N_0|<72y^2/u,\qquad |N'-N_0'|<172y^2/u^2.
\tag{17}
$$

Let $T_0=2(K')^2-KK''$. For $0\le j\le3$,
$|K^{(j)}|\le y/u^{j+1}$. Expanding with (16) gives

$$
|T-T_0|\le\frac y{u^4}
\left(5+\frac{12}u+\frac4{u^2}+\frac{38}{u^2y}\right)<10y/u^4,
$$
$$
|T'-T_0'|\le\frac y{u^5}
\left(5+\frac9u+\frac{12}{u^2}+\frac{10}{u^3}
+\frac{86}{u^3y}\right)<10y/u^5.
\tag{18}
$$

Exact multiplication now gives

$$
\mathcal D_0:=T_0N_0'-T_0'N_0=\frac{2y^5}{u^5}P(h_*),
$$
$$
P(h_*)=1+3h_*+\tfrac34h_*^2-\tfrac{17}8h_*^3
-\tfrac{27}{16}h_*^4-\tfrac{15}{32}h_*^5-\tfrac3{64}h_*^6.
$$

For $0\le h_*\le1/3$, the negative terms have total absolute
value at most $1579/15552<1/8$. Therefore
$\mathcal D_0>(7/4)y^5/u^5$.
The bounds $N_0<4y^3$, $N_0'<10y^3/u$,
$|T|<(11/10)y^2/u^4$, and $|T'|<(21/10)y^2/u^5$, together
with (17)–(18), give

$$
\begin{aligned}
|\mathcal D-\mathcal D_0|
&\le |T-T_0|N_0'+|T||N'-N_0'|
+|T'-T_0'|N_0+|T'||N-N_0|\\
&\le\frac{y^4}{u^5}\left(140+\frac{1702}{5u}\right)
<254y^4/u^5.
\end{aligned}
$$

Thus on the entire infinite tail,

$$
\boxed{\mathcal D>\tfrac32y^5/u^5>0,
\qquad N\ge(99/50)y^3>(19/10)y^3>0.}
\tag{19}
$$

Together with the compact certificate, this proves (7).

## The nonlocal three-crossing argument

Fix $q>0$. Set $X=\log V-\mathbb E_q\log V$,
$\sigma^2=\mathbb E_qX^2>0$, $\kappa_3=\mathbb E_qX^3$, and

$$
P_3(X)=X^3-3\sigma^2X-\kappa_3.
$$

Differentiating (2) three times gives
$\varphi_{\rm nat}'''(s)=4\mathbb E_q[kP_3]$.
The endpoint bounds (4) justify the Stein identity

$$
\mathbb E_q[(W-q)H]=\mathbb E_q[vH'].
\tag{20}
$$

For $H=P_3$, the right side is
$3\mathbb E_q(X^2-\sigma^2)=0$. A second use of (20), with
$WH$, shows
$\mathbb E_q[Q_2H]=q\mathbb E_q[WH]+\mathbb E_q[WvH']$.
Here $vP_3'=3(X^2-\sigma^2)$, and
$\mathbb E_q[W(X^2-\sigma^2)]=2\mathbb E_qX=0$, again by (20).
Consequently

$$
\mathbb E_qP_3=\mathbb E_q[WP_3]=\mathbb E_q[Q_2P_3]=0.
\tag{21}
$$

The first two identities force the cubic to have three distinct real roots.
Otherwise it has just one sign-changing root $c$, and strict increase of
$W$ would give
$(W(v)-W(e^{\mathbb E_q\log V+c}))P_3(X)>0$ except at finitely many
points. Its expectation would be positive, contradicting (21).

Use the increasing coordinate $w=W(v)$. By (1), it maps $(0,\infty)$
onto $(0,\infty)$. Set $\mathcal H(w)=Q_2(v)$ and
$\mathcal K(w)=k(v)$. Equations (1), (5), and (7) give

$$
\mathcal H''=N/(W')^3>0,\qquad
\mathcal K''=-T/(W')^3,\qquad
\frac{\mathcal K''}{\mathcal H''}=-T/N,
$$
$$
\frac d{dv}(-T/N)=\mathcal D/N^2>0.
\tag{22}
$$

Let $w_1<w_2<w_3$ be the three crossing locations of $P_3$.
Strict convexity of $\mathcal H$ gives a unique interpolant
$I(w)=a+bw+c\mathcal H(w)$ agreeing with $\mathcal K$ at those
three points. For the error $E=\mathcal K-I$, (22) says

$$
E''=\mathcal H''\left(\frac{\mathcal K''}{\mathcal H''}-c\right).
$$

The parenthesized factor is strictly increasing. Rolle's theorem supplies
two zeros $\eta_1\in(w_1,w_2)$, $\eta_2\in(w_2,w_3)$ of $E'$,
and a zero $\xi\in(\eta_1,\eta_2)$ of $E''$. The strictly increasing
factor in (22) makes this the unique zero of $E''$, whose signs are
negative then positive. Thus $E'$ strictly decreases before $\xi$ and
strictly increases afterward. Its only zeros are $\eta_1,\eta_2$, and
its signs are $+,-,+$. Using the three prescribed zeros of $E$, its
signs are therefore $-,+,-,+$ throughout the four complementary
intervals, agreeing with the monic cubic $P_3$.
The product $EP_3$ is strictly positive away from the three crossings.
It is integrable by (4), and the measure has full support. Finally (21)
removes the interpolant:

$$
\mathbb E_q[kP_3]=\mathbb E_q[(k-I(W))P_3]>0.
$$

This proves (3). This comparison uses the classical generalized convexity
and sign-crossing method of Karlin–Novikoff, *Pacific Journal of Mathematics*
13 (1963), §§1 and 3:
https://msp.org/pjm/1963/13-4/pjm-v13-n4-p18-s.pdf.
No novelty claim is made for that method.

## Scope and use

Together with the preceding concavity theorem, this proves

$$
\varphi_{\rm nat}>0,\qquad
\varphi_{\rm nat}'>0,\qquad
\varphi_{\rm nat}''<0,\qquad
\varphi_{\rm nat}'''>0
\quad\text{on }(-3/2,\infty).
$$

Thus the positive, decreasing function $\varphi_{\rm nat}'$ is strictly convex, and the positive curvature magnitude $-\varphi_{\rm nat}''$ is strictly decreasing. These are necessary sign properties for a Bernstein representation of the actual coefficient exponent. They supply no assertion about every derivative order or positivity of an inverse Lévy measure. Bernstein membership, $B_J$ membership, and RH remain unproved.

The generalized convexity comparison is classical. Related earlier theta results include Csordas and Varga, [*Moment inequalities and the Riemann hypothesis*](https://www.math.kent.edu/~varga/pub/paper_161.pdf), *Constructive Approximation* 4 (1988), 175–198, and Newman, [*The GHS inequality and the Riemann hypothesis*](https://doi.org/10.1007/BF01888165), *Constructive Approximation* 7 (1991), 389–399. The former proves logarithmic concavity of a rescaled square-root theta kernel; the latter proves convexity of the derivative of its logarithmic potential. These are related kernel inequalities, rather than the third derivative of the normalized Mellin ratio proved here. No publication-priority claim is made for the present specialization.

The result uses a written analytic proof and Arb interval arithmetic. It is not a Lean formalization. The standalone certificate requires Python 3 and python-flint. Run from the repository root without Python's `-O` option, since a width guard uses an assertion:

```sh
python3 building-blocks/certificates/theta_natural_exponent_third_derivative.py
```
