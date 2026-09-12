# The actual theta heat flow at a collision

Written mathematics with a passing FLINT/Arb certificate and exact symbolic checks. The finite statements below have been independently reviewed. No Lean or all-degree zero-reality theorem is asserted.

The tested hypothesis was that modular self-duality supplies a sign or coercive constraint at a possible collision that generic positivity of the Fourier kernel misses. The construction does supply an exact boundary identity and a useful exponential-moment bound. They make a rigorous finite collision certificate possible. They do not reverse the collision's local heat direction. A first pointwise sign ansatz fails; a modular primitive repair leaves a specific oscillatory fourth moment, and following the moving critical point leaves a signed Schur complement. A positive-time estimate for those actual quantities remains open.

## 1. Constructing the arithmetic kernel and fixing time

Let

$$
\Theta(y)=\sum_{n\in\mathbb Z}e^{-\pi n^2y},\qquad
\Theta(y)=y^{-1/2}\Theta(1/y),\qquad y>0.
$$

The second equality is the Gaussian Poisson-summation identity. Put

$$
F(u)=e^u\Theta(e^{4u}),\qquad
\Phi(u)=\frac{F''(u)-F(u)}{16}.
\tag{T1}
$$

Modularity gives $F(-u)=F(u)$. Direct differentiation, with $r=\pi n^2e^{4u}$, gives the actual arithmetic series

$$
\Phi(u)=\sum_{n=1}^\infty
 \bigl(2\pi^2n^4e^{9u}-3\pi n^2e^{5u}\bigr)e^{-\pi n^2e^{4u}}
=\sum_{n=1}^\infty e^{u-r}(2r^2-3r).
\tag{T2}
$$

Thus $\Phi$ is even. For $u\ge0$, every summand is positive since $r\ge\pi>3/2$. Hence $\Phi(u)>0$ everywhere, and modularity transfers its superexponential decay at positive infinity to negative infinity. This is the lattice theta kernel, with all integers retained.

Use the convention

$$
H_t(z)=\int_0^\infty e^{tu^2}\Phi(u)\cos(zu)\,du,
\qquad \partial_tH_t=-\partial_z^2H_t.
\tag{T3}
$$

Increasing $t$ is the backward heat direction. The integral is entire jointly in complex $t,z$, by domination on compact parameter sets. Differentiation and all integrations below are therefore legitimate when their stated endpoint conditions hold.

For the actual Riemann xi function

$$
\xi(s)=\tfrac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s),
\qquad
H_0(z)=\tfrac18\xi\left(\tfrac12+\tfrac{iz}{2}\right).
\tag{T4}
$$

One obtains T4 by the Mellin change of variables $y=e^{4u}$:
$\xi(s)=4\int_{\mathbb R}\Phi(u)e^{(2s-1)u}\,du$, followed by evenness and analytic continuation. The normalization, explicit series, and heat sign agree with the authors' derivation in [Rodgers–Tao's announcement, equations 1–2 and the heat-flow definition](https://terrytao.wordpress.com/2018/01/19/the-de-bruijn-newman-constant-is-non-negativ/), and with the defining integral of [their paper](https://arxiv.org/abs/1801.05914). No location of a zeta zero is assumed.

## 2. What exact modular pairing adds

On the positive half-line define the rapidly decreasing function

$$
k(u)=F(u)-e^u
=2e^u\sum_{n=1}^\infty e^{-\pi n^2e^{4u}}.
$$

It is positive and superexponentially decreasing. Modularity supplies the exact endpoint derivative

$$
k'(0)=F'(0)-1=-1,\qquad 16\Phi=k''-k.
\tag{T5}
$$

Define $J_t(z)=\int_0^\infty k(u)e^{tu^2}\cos(zu)\,du$. Transfer the two derivatives in T5 to $g(u)=e^{tu^2}\cos(zu)$. The boundary term is
$[k'g-kg']_0^\infty=1$, not zero. Since

$$
g''-g=e^{tu^2}
\{(2t+4t^2u^2-z^2-1)\cos(zu)-4tzu\sin(zu)\},
$$

the exact modular identity is

$$
16H_t(z)=1+(2t-1-z^2)J_t(z)
-4t^2J_t''(z)+4tzJ_t'(z).
\tag{T6}
$$

It holds for all real $t$ and complex $z$. The endpoint constant is a genuine constraint from the arithmetic modular relation. It is lost if one informally regards the half-line series as an even rapidly decreasing primitive.

Taking $g(u)=\cosh u$ in the same integration by parts, so that $g''-g=0$, gives

$$
\int_0^\infty\Phi(u)\cosh u\,du=\frac1{16},
\qquad
\int_{\mathbb R}e^u\Phi(u)\,du=\frac18.
\tag{T7}
$$

This agrees with T4 at $z=i$ since $\xi(0)=1/2$. Positivity then gives, for every integer $j\ge0$ and every $t\le0$,

$$
\int_0^\infty u^je^{tu^2}\Phi(u)\,du
\le\frac{j!}{8}.
\tag{T8}
$$

Here $u^j\le j!e^u$. T8 is a useful nontrivial consequence: it controls derivatives uniformly on an entire negative-time parameter box. It is used in the certificate below rather than inferred from pointwise quadrature. It does not hold with the same constant for arbitrary positive $t$.

## 3. Exact collision identities in the actual moments

For real $t,x$, write

$$
M_{2j,c}=\int_0^\infty u^{2j}e^{tu^2}\Phi(u)\cos(xu)\,du,
\quad
M_{2j+1,s}=\int_0^\infty u^{2j+1}e^{tu^2}\Phi(u)\sin(xu)\,du.
$$

At a potential ordinary double zero $(t_*,x_*)$,

$$
M_{0,c}=M_{1,s}=0,\qquad
B:=H_{xx}=-M_{2,c}\ne0,\qquad
C:=H_{xxx}=M_{3,s},\qquad D:=H_{xxxx}=M_{4,c}.
\tag{T9}
$$

In particular $H_t=M_{2,c}=-B$. Neither sign of $B$ can protect a double zero against decreasing time: that sign cancels from the local root equation.

For $\tau=t-t_*$ and $y=x-x_*$, the heat equation gives the weighted Taylor expansion

$$
H=B(y^2/2-\tau)
+C(y^3/6-\tau y)
+D(y^4/24-\tau y^2/2+\tau^2/2)+\cdots.
\tag{T10}
$$

Solving the two branches gives

$$
y_\pm=\pm\sqrt{2\tau}+\frac{2C}{3B}\tau
\pm\frac1{\sqrt2}\left(\frac D{3B}-\frac{2C^2}{9B^2}\right)\tau^{3/2}
+O(\tau^2),
$$

and their squared separation is

$$
(x_+(t)-x_-(t))^2
=8\tau+
\left(\frac{8D}{3B}-\frac{16C^2}{9B^2}\right)\tau^2
+O(\tau^3).
\tag{T11}
$$

The analytic discriminant supplied by Weierstrass preparation justifies interpreting this across $\tau=0$. The two nearby zeros are real for sufficiently small positive $\tau$ and nonreal conjugates for sufficiently small negative $\tau$. Other zeros need not be real. The linked symbolic certificate checks the substitution through every displayed order.

The coefficient 8 is not an adjustable arithmetic term. Multiplying $H$ by a nonvanishing analytic factor or translating the spatial coordinate by a smooth function of time does not change it. A useful modular mechanism would have to rule out the collision conditions, or control their approach globally, rather than choose a favorable sign of the curvature at a collision.

A second useful check is the first Laguerre expression

$$
\mathcal L_t(x)=H_x^2-HH_{xx}.
$$

Differentiation using T3 gives

$$
\partial_t\mathcal L
=H_{xx}^2-2H_xH_{xxx}+HH_{xxxx},
\qquad
\partial_t\mathcal L(t_*,x_*)=B^2>0.
\tag{T12}
$$

Thus the heat direction at the collision is fixed even when expressed as a second-variation inequality.

## 4. Testing the first sign ansatz and two repairs

The first ansatz was to use the two collision constraints to turn $M_{2,c}$ into an integral with one sign. For any real coefficients $a,b$, those constraints allow the exact rewrite

$$
M_{2,c}=\int_0^\infty e^{tu^2}\Phi(u)
\{(u^2-a)\cos(xu)-bu\sin(xu)\}\,du.
\tag{T13}
$$

For every $x>0$, the braced residual has both signs: at $u=j\pi/x$ it equals $((j\pi/x)^2-a)(-1)^j$, which alternates for large $j$. The actual theta weight is strictly positive on neighborhoods of all these points. Modular pairing $u\leftrightarrow-u$ doubles the same signs, because this residual is even. Also $H_t(0)>0$, so a collision cannot occur at $x=0$.

This rigorously excludes the tested pointwise sign certificate from linear combinations of the two constraints. It does not exclude a signed integral estimate that uses the actual sizes of the theta terms.

### Repair A: a positive modular primitive

There is a natural even positive primitive,

$$
K(u)=2\cosh u-F(u),\qquad (1-D_u^2)K=16\Phi.
\tag{T14}
$$

For $u\ge0$, $K=e^{-u}-k(u)>0$. To check the sign, set $y=e^{4u}\ge1$. Each $\sqrt y e^{-\pi n^2y}$ decreases with $y$, and

$$
e^u k(u)=2\sqrt y\sum_{n\ge1}e^{-\pi n^2y}
\le2\sum_{n\ge1}e^{-\pi n^2}
\le\frac2{e^\pi-1}<1.
$$

Evenness gives the other half-line. Equivalently,
$K=8e^{-|\cdot|}*\Phi$, the positive Green-function solution of T14. This retains the actual kernel rather than replacing it with an auxiliary one.

But $K(u)\sim e^{-|u|}$. For $t>0$, the proposed integral
$\int e^{tu^2}K(u)\cos(xu)\,du$ does not converge. Transferring derivatives onto the heat factor using this positive primitive produces growing endpoint terms that cannot be discarded.

Returning to the superexponentially decreasing half-line primitive $k$ repairs convergence and gives T6, including its boundary constant. At a collision, T6 and its first derivative give the two exact constraints

$$
\begin{split}
0={}&1+(2t-1-x^2)J+4txJ'-4t^2J'',\\
0={}&-2xJ+(6t-1-x^2)J'+4txJ''-4t^2J'''.
\end{split}
\tag{T15}
$$

The curvature is

$$
16B=-2J-4xJ'+(10t-1-x^2)J''+4txJ'''-4t^2J''''.
\tag{T16}
$$

For $t\ne0$, eliminating $J'''$ by T15 leaves

$$
16B=-2(1+x^2/t)J
+\frac{x}{t}(2t-1-x^2)J'
+(10t-1+3x^2)J''-4t^2J''''.
\tag{T17}
$$

The exact surviving term is
$-4t^2J''''=-4t^2\int_0^\infty u^4k(u)e^{tu^2}\cos(xu)\,du$.
Positivity of $k$ and modular reflection give no pointwise sign for it. All four quantities in T17 are transforms of the actual arithmetic half-line series.

At $t=0$, the separate formulas avoid division by time. A double zero would require

$$
J=\frac1{1+x^2},\qquad J'=-\frac{2x}{(1+x^2)^2},
\qquad
16B=\frac{6x^2-2}{(1+x^2)^2}-(1+x^2)J''.
\tag{T18}
$$

The signed second moment $J''$ remains. No bound obtained here makes T15 or T18 inconsistent at nonnegative time.

### Repair B: constrain the variation to a moving critical point

Because $B\ne0$, there is a local real analytic curve $c(t)$ with $H_x(t,c(t))=0$. Set $E(t)=H(t,c(t))$. At the collision,

$$
c'(t_*)=\frac CB,\qquad E'(t_*)=-B,
\qquad
E''(t_*)=D-\frac{C^2}{B}
=M_{4,c}+\frac{M_{3,s}^2}{M_{2,c}}.
\tag{T19}
$$

This is the relevant constrained second variation. The square in its numerator does not make the expression positive: its denominator is the signed moment $M_{2,c}$, and $M_{4,c}$ is also signed. More decisively, its sign cannot cancel the nonzero linear crossing $E'=-B$.

These repairs identify arithmetic quantities that could be estimated, but they do not furnish a collision barrier. The next calculation tests them on a certified collision of the actual modular kernel.

## 5. A certified actual collision, with a strictly negative time box

The following certificate starts from an exact rational candidate and proves a whole-box statement. The certificate uses `python-flint` 0.9.0, FLINT/Arb ball integration at 75 decimal digits, or 252 bits. The [documented `acb.integral` method](https://python-flint.readthedocs.io/en/latest/acb.html#flint.acb.integral) encloses the finite integrals. Its integrands here are entire functions of the integration variable, so ignoring the callback's analytic flag is legitimate.

Let the exact rational center be

$$
t_0=-\frac{1249451312964394680640550665475526188154132031167097937}{10^{53}},
\qquad
x_0=\frac{5464245539060258447805111731866518235252412475529268007}{10^{53}}.
$$

Take $r=10^{-14}$ and the closed box $\mathcal B=[t_0-r,t_0+r]\times[x_0-r,x_0+r]$. Its exact terminating-decimal endpoints are

```text
t lower = -12.49451312964395680640550665475526188154132031167097937
t upper = -12.49451312964393680640550665475526188154132031167097937
x lower =  54.64245539060257447805111731866518235252412475529268007
x upper =  54.64245539060259447805111731866518235252412475529268007
```

The certificate establishes a unique solution of
$H_t(x)=H_x(t,x)=0$ in $\mathcal B$, with $H_{xx}<0$ throughout the box. Thus the zero has order exactly two. This is not a claim that it is the first collision or that any other zeros are real.

### Full arithmetic and integration tails

Only the finite computation truncates T2, retaining $1\le n\le8$ and integrating $0\le u\le U=3/2$. For all real $x$, $t\le0$, and $0\le j\le4$, the omitted tails of the integrals defining $\partial_x^jH_t(x)$ are bounded as follows.

For $u\ge0$,

$$
0<\Phi_n(u)\le2\pi^2n^4e^{9u-\pi n^2e^{4u}}
\le2\pi^2n^4e^{-\pi n^2}e^{-(4\pi n^2-9)u}.
$$

The final inequality uses $e^{4u}\ge1+4u$. Dropping $e^{tu^2}\le1$ and bounding the sine or cosine by 1 gives

$$
\int_0^\infty u^je^{tu^2}\Phi_n(u)\,du
\le\frac{2\pi^2n^4e^{-\pi n^2}j!}{(4\pi n^2-9)^{j+1}}.
\tag{T20}
$$

For $n\ge9$, the denominator is at least 1 and $j!\le24$. Consecutive terms $n^4e^{-\pi n^2}$ have ratio at most
$(10/9)^4e^{-19\pi}<1/2$. Therefore the entire omitted arithmetic tail is at most

$$
96\pi^2\,9^4 e^{-81\pi}<1.902\times10^{-104}.
\tag{T21}
$$

For the integration tail of a retained term, write $u=U+v$, and use
$e^{4u}\ge e^6(1+4v)$. Expanding $(U+v)^j$ and integrating each monomial gives

$$
\begin{split}
\int_U^\infty u^je^{tu^2}\Phi_n(u)\,du
\le{}&2\pi^2n^4e^{9U-\pi n^2e^{4U}}\\
&\times\sum_{\ell=0}^j\binom j\ell
\frac{U^{j-\ell}\ell!}{(4\pi n^2e^{4U}-9)^{\ell+1}}.
\end{split}
\tag{T22}
$$

Summing T22 for $1\le n\le8$ is less than $10^{-530}$, for each $j\le4$. The actual computed upper bounds are all below $5.371\times10^{-547}$. The script checks the tail bounds with balls. It adds a symmetric error ball of radius $10^{-100}$ to every finite integral, covering both infinite tails with margin.

The finite integral is evaluated on twelve subintervals of length $1/8$, with requested absolute tolerance $10^{-60}$ and relative tolerance $10^{-55}$. The tolerances are goals, not assumed error bounds: the resulting returned balls, enlarged by the tail ball, are used in all subsequent calculations.

### A self-map and derivative bound on the entire box

Write $\mathcal F(t,x)=(H_t(x),H_x(t,x))$. The Jacobian is

$$
\mathcal F'(t,x)=
\begin{pmatrix}-H_{xx}&H_x\\-H_{xxx}&H_{xx}\end{pmatrix}.
\tag{T23}
$$

At the exact rational center, the certified balls include

$$
\begin{split}
|H|&<2.14\times10^{-61},& |H_x|&<1.12\times10^{-60},\\
B&=-6.125332841309690755\ldots\times10^{-9},\\
C&=\phantom{-}6.446277070140566855\ldots\times10^{-9},\\
D&=-3.907350823761648143\ldots\times10^{-9}.
\end{split}
$$

The displayed digits of the last three values are abbreviated; the certificate computes the full enclosing balls.

Since the whole box has $t<0$, T8 bounds every Jacobian derivative throughout it. The mean-value theorem gives the entrywise variation bound

$$
|\mathcal F'(t,x)-\mathcal F'(t_0,x_0)|
\le r\begin{pmatrix}15/4&1\\18&15/4\end{pmatrix},
\qquad (t,x)\in\mathcal B.
\tag{T24}
$$

For example, the derivatives of $-H_{xxx}$ are $H_{xxxxx}$ and $-H_{xxxx}$, bounded in absolute value by $5!/8=15$ and $4!/8=3$. The other entries use $2!/8=1/4$, $3!/8=3/4$, and $4!/8=3$. This establishes a bound on the whole box rather than just the center.

The script encloses the inverse of the center Jacobian, then takes each entry's exact dyadic midpoint to obtain a fixed real matrix $Y$. Its exact dyadic entries are computed from those midpoint balls. Define the real map

$$
\mathcal N(v)=v-Y\mathcal F(v).
$$

Using T24 and the center balls, the computation encloses every entry of $I-Y\mathcal F'(v)$ on $\mathcal B$. Summing the absolute values of all four entries gives a conservative bound on its infinity operator norm. The saved certificate gives

$$
\sup_{v\in\mathcal B}\|I-Y\mathcal F'(v)\|_\infty<5.15\times10^{-5},
\qquad
\|Y\mathcal F(t_0,x_0)\|_\infty<2.55\times10^{-52}.
\tag{T25}
$$

Consequently,

$$
\|\mathcal N(v)-(t_0,x_0)\|_\infty
<2.55\times10^{-52}+(5.15\times10^{-5})10^{-14}
<5.16\times10^{-19}<r.
\tag{T26}
$$

The map sends the box strictly into itself and is a contraction. Banach's theorem gives its unique fixed point. Since $Y$ is invertible, this fixed point is the required common zero. Invertibility also follows from the displayed small bound for $I-Y\mathcal F'$; a rank-deficient $Y$ could not satisfy that bound below 1. The box enclosure of $H_{xx}$ is strictly negative, with the saved display $[-6.1253\times10^{-9}\;\pm\;7.04\times10^{-14}]$.

This is a numerical certificate with explicit analytic inputs and a reproducible contraction check. It relies on the correctness of FLINT/Arb and the stated handwritten tail and derivative arguments. It has not been translated into Lean. The independent review reproduced all whole-box assertions.

### The constrained variation and a discriminating sign check

The same moment bound gives variations of at most $(15/4)r$, $18r$, and $105r$ for $B,C,D$, respectively. The last uses moments of orders 5 and 6, bounded by 15 and 90. On the entire box the certificate yields

$$
D-C^2/B\in[2.88\times10^{-9}\;\pm\;4.79\times10^{-12}]>0,
$$

$$
\frac{8D}{3B}-\frac{16C^2}{9B^2}
\in[-0.268\;\pm\;0.000713]<0.
\tag{T27}
$$

Thus the repaired constrained second variation can be positive at an actual collision; its sign does not prevent the linear crossing in T19. The next correction to the squared gap is negative here, while the leading coefficient remains 8.

At the exact rational points $(t_0-1/100,x_0)$ and $(t_0+1/100,x_0)$, not at unverified moving zero locations, the full-tail ball calculation gives

| Point | Certified sign of $\mathcal L=H_x^2-HH_{xx}$ |
|---|---|
| $t=t_0-1/100,\ x=x_0$ | $-3.746305533438928868\ldots\times10^{-19}<0$ |
| $t=t_0+1/100,\ x=x_0$ | $\phantom{-}3.757613048135371096\ldots\times10^{-19}>0$ |

The radii of these sign enclosures are below $4\times10^{-69}$. Both times are negative. This refutes a time-independent claim that the exact modular theta identities force this Laguerre inequality to be nonnegative. It is not evidence of a failure at nonnegative time and supplies no global zero count.

## Reproduction

The [complete arithmetic certificate](certificates/theta_heat_collision.py) runs with `python-flint==0.9.0`. The [exact algebra checks](certificates/theta_heat_collision_symbolic.py) run with `sympy==1.14.0`. Both pass. The certificates derive the full-tail enclosures and retain every strict assertion; they require no saved numerical data or private dependency directory. Their analytic inputs are proved above. This is computer-assisted written mathematics using FLINT/Arb.

## Decision and remaining obligation

The modular construction survives the construction stage. It gives T6's exact boundary constraint and T7–T8's moment control, which were strong enough to certify one collision. The pointwise sign ansatz T13 fails, the positive primitive has a genuine positive-time convergence obstruction, and the convergent repair leaves T17's actual oscillatory fourth moment. The constrained variation T19 leaves a signed Schur complement and cannot alter the nonzero linear crossing.

The negative-time certificate proves that exact arithmetic modular self-duality does not forbid ordinary collisions for all times. It does not refute a barrier whose proof specifically uses $t\ge0$. No such barrier has been derived.

A concrete remaining task for this mechanism would be to prove that, for the actual series defining $J_t$, the two equations in T15 cannot hold at any $t>0$ and real $x$, including higher-order degeneracies, or to obtain a quantitative lower bound preventing all real-zero gaps from closing while descending from a known real-zero time. Such an estimate must use more than positivity and reflection to control the signed term in T17. A passage to all heights must also control possible loss through infinity; a bounded numerical collision search would not provide it. If real-zero preservation were established for every $t>0$, local uniform convergence and Hurwitz would then pass it to $t=0$. That preservation remains unproved here.
