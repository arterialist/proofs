# A single sign criterion and a positive theta jump mixture

The [small-jump theorem](theta-small-jump-levy-density.md) constructs the actual inverse transforms associated with the natural theta exponent and proves their positivity near zero. Their extension to a nonincreasing Lévy density on the whole half-line is equivalent to one global sign. It is also equivalent to a positive integral equation involving only the complete theta kernel. Both global conditions remain open. These are written analytic results, with no Lean formalization; neither ordinary Bernstein membership nor the stronger class considered here supplies an implication to RH.

Retain the complete $\Phi$, the entire interpolation $F$, and the notation

$$
g(v)=-\frac d{dv}\Phi(\sqrt v),\quad k=-g'/g,\quad
B(q)=\int_0^\infty v^{q-1}g(v)\,dv,\quad
C(q)=\int_0^\infty v^{q-1}k(v)g(v)\,dv,
$$

$$
a=\frac32,\qquad
\phi(s)=\frac{F(s)}{F(s+1)}=4\frac{C(s+a)}{B(s+a)},\qquad
f=-\phi'',\quad j=3f+sf'.
\tag{1}
$$

Here $g,k,k'>0$, and $B,C$ converge for $\Re q>0$. Let $h,w$ be the unique continuous real causal inverse transforms constructed in the small-jump theorem. Thus

$$
\mathcal Lh=f,\quad\mathcal Lw=j
\quad\text{in a sufficiently far-right half-plane},
$$

$$
w=2h-rh',\qquad
h(r)\sim\frac{32}{\log^3(1/r)},\qquad
w(r)\sim\frac{64}{\log^3(1/r)}
\quad(r\downarrow0).
\tag{2}
$$

Write $B_J$ for Bernstein functions whose Lévy measures have nonincreasing densities. This is the convention used by Patie and Vaidyanathan in [*The log-Lévy moment problem via Berg–Urbanik semigroups*](https://arxiv.org/pdf/1806.02644), Section 2. Complete Bernstein functions impose the stronger condition of a completely monotone density.

## The global sign theorem

**Theorem.** For the actual functions in (1),

$$
\phi\in B_J
\quad\Longleftrightarrow\quad
w(r)\ge0\quad\text{for every }r>0.
\tag{3}
$$

If these conditions hold, the Lévy density is uniquely determined by

$$
\pi(r)=\frac{h(r)}{r^2}
=\int_r^\infty\frac{w(t)}{t^3}\,dt,
\qquad
\phi(s)=\phi(0)+\int_0^\infty(1-e^{-sr})\pi(r)\,dr
\quad(s\ge0).
\tag{4}
$$

The killing rate is $\phi(0)>0$, the drift is zero, and $\int_0^\infty r\pi(r)dr<\infty$. Positivity of $h$ and integrability without an exponential tilt are consequences of the single sign in (3).

We first record the real continuation needed in the proof. The ratio in (1) is holomorphic near every real $s>-a$ because $B(q)>0$ for real $q>0$. At $q=0$, smoothness at zero and rapid decay give

$$
B(q)=\frac{g(0)}q+b(q),\qquad
C(q)=\frac{k(0)g(0)}q+c(q),
\tag{5}
$$

with $b,c$ holomorphic near zero. Thus $C/B$ is holomorphic there, and

$$
\phi(-a)=4k(0).
\tag{6}
$$

There is therefore some $\delta>0$ such that $\phi,f,j$ are holomorphic near every real point of $(-a-\delta,\infty)$. This assertion concerns neighborhoods of the real axis; it does not assume a zero-free complex half-plane.

We use the classical positive-Laplace continuation lemma. If a nonnegative measure has a Laplace transform convergent sufficiently far right, then any finite abscissa of convergence is a real singularity. Consequently, if its transform continues holomorphically near every real point of $(b,\infty)$, the defining positive integral converges for every real $s>b$. For completeness, suppose the abscissa $\beta>b$ were regular in a disk of radius $\epsilon$. Center a Taylor series at $x=\beta+\epsilon/4$ and take the leftward step $\epsilon/2$. Its coefficients, after the alternating signs cancel, are the positive moments
$\int t^n e^{-xt}\mu(dt)/n!$. Tonelli sums the series to $\int e^{-(x-\epsilon/2)t}\mu(dt)$, making it finite below $\beta$, a contradiction. Differentiation of the transform at $x$ is justified by exponential domination to the right of $\beta$.

Assume $w\ge0$. Apply this lemma to $j=\mathcal Lw$ and the continuation above. In particular, $w$ has an exponential moment at some rate strictly greater than $a$. The differential identity

$$
(s^3f(s))'=s^2j(s)
$$

and analyticity at zero give, for $s>0$,

$$
f(s)=\int_0^1u^2j(us)\,du.
\tag{7}
$$

Insert the positive Laplace integral, apply Tonelli and set $r=ut$. Then

$$
f(s)=\int_0^\infty e^{-sr}r^2
\left(\int_r^\infty\frac{w(t)}{t^3}\,dt\right)dr.
$$

Laplace uniqueness identifies its density with $h$, proving the first identity in (4). An additive constant in $\pi$ would contribute $2A/s^3$ to $f$; analyticity at zero excludes it. The small-$r$ limits in (2) alone would not exclude this constant.

The density in (4) is nonnegative and nonincreasing. Moreover,

$$
\int_0^\infty r\pi(r)\,dr
=\frac12\int_0^\infty\frac{w(t)}t\,dt<\infty.
\tag{8}
$$

The integral at zero converges by (2), and its tail converges by the exponential moment. Integrating $f=-\phi''$ from infinity uses the actual limit $\phi'(\infty)=0$ proved in the small-jump note. A second integration gives (4), including its exact killing rate.

Conversely, suppose the actual $\phi$ has a $B_J$ representation. Its drift is $\lim_{s\to\infty}\phi'(s)=0$. Twice differentiating the Lévy representation and using uniqueness gives $h(r)=r^2\pi(r)$ almost everywhere. The continuously differentiable representative $h/r^2$ from (2) agrees almost everywhere with the nonincreasing density, so it is itself nonincreasing. Consequently $w=-r^3\pi'\ge0$ everywhere on $(0,\infty)$. This proves (3).

## An equivalent positive integral equation

Define the actual positive target and positive kernel

$$
A(v)=g(v)[k(v)-k(0)],\qquad
K(v,t)=\frac1{4t^3}\int_0^t e^{ar}
[g(v)-g(e^rv)]\,dr,
\quad v,t>0.
\tag{9}
$$

Their strict positivity follows from $k'>0$ and $g'=-kg<0$.

**Mixture theorem.** Condition (3) is equivalent to the existence of a nonnegative Borel measure $U$ on $(0,\infty)$ satisfying

$$
A(v)=\int_{(0,\infty)}K(v,t)\,U(dt)
\qquad\text{for every }v>0.
\tag{10}
$$

Such a measure is unique and equals $w(t)dt$. Its existence constructs the actual density as

$$
\pi(r)=\int_{(r,\infty)}t^{-3}U(dt).
\tag{11}
$$

To prove sufficiency directly, take the Mellin transform of (10) at any real $q>0$. Every integrand is nonnegative, so Tonelli applies before integrability is known. Exact dilation gives

$$
\int_0^\infty v^{q-1}[g(v)-g(e^rv)]\,dv
=(1-e^{-qr})B(q),
$$

and therefore

$$
C(q)-k(0)B(q)=\frac{B(q)}4
\int\frac{U(dt)}{t^3}\int_0^t e^{ar}(1-e^{-qr})\,dr.
\tag{12}
$$

The left side is finite. For fixed $q>0$, the inner integral divided by $t^3$ is comparable to $t^{-1}$ near zero and to $e^{at}t^{-3}$ at infinity. Hence (10) itself forces

$$
\int_{(0,1)}\frac{U(dt)}t<\infty,\qquad
\int_{[1,\infty)}\frac{e^{at}}{t^3}\,U(dt)<\infty.
\tag{13}
$$

Equations (11) and (12) now imply

$$
\phi(q-a)=4k(0)+
\int_0^\infty e^{ar}(1-e^{-qr})\pi(r)\,dr,
\qquad q>0.
\tag{14}
$$

All these integrals converge by (13). Subtract the value at $q=a$ and put $q=a+s$ to obtain exactly (4). The density in (11) is nonincreasing and satisfies Lévy integrability. Thus (10) constructs the actual $B_J$ exponent on an interval, including its normalization; it is not merely an interpolation at integer arguments.

For necessity, start from the actual $B_J$ representation. Choose its right-continuous nonincreasing density and put
$U(dt)=-t^3d\pi(t)$. Its limit at infinity is zero by Lévy integrability, so the Stieltjes tail identity gives (11). Apply the positive-Laplace lemma to
$\phi'(s)=\int_0^\infty r e^{-sr}\pi(r)dr$ and the continuation through $-a$. This supplies an exponential moment with rate greater than $a$, which justifies (14) by continuation and (6). Mellin uniqueness then gives the pointwise identity

$$
g(v)[k(v)-k(0)]
=\frac14\int_0^\infty e^{ar}
[g(v)-g(e^rv)]\pi(r)\,dr.
\tag{15}
$$

For clarity, both sides have finite Mellin integrals at every $q>0$, and (14) says these transforms agree. They are continuous in $v>0$: on compact $v$ intervals the difference in (15) is $O(r)$ at zero and bounded at infinity, where the exponential moment applies. Mellin uniqueness first gives almost-everywhere equality, then continuity gives equality everywhere. Substituting (11) into (15) and using Tonelli proves (10).

Lévy uniqueness determines $\pi$ from $\phi$, and the Stieltjes relation determines $U$. The regularity already proved in the small-jump note gives $U(dt)=w(t)dt$.

## The resulting jump construction and the open condition

A positive solution $U$ has a direct probabilistic realization. For each $t>0$, take uniform jumps in $(0,t)$ with intensity measure $t^{-2}U(dt)$ on the parameter $t$. The resulting jump density is (11). Its contribution to the Laplace exponent is

$$
\frac{U(dt)}{t^3}
\left[t-\frac{1-e^{-st}}s\right],
\tag{16}
$$

with the continuous value at $s=0$. Restricting to $t\ge\epsilon>0$ gives finite activity. The first-moment bound from (13) permits the increasing sum of nonnegative jumps as $\epsilon\downarrow0$. Independent killing at rate $\phi(0)$ gives the exponent (4). This is the classical uniform-mixture representation of a decreasing Lévy density; see Bridaa, Fourati and Jedidi, [*Some New Classes and Techniques in the Theory of Bernstein Functions*, Theorem 1.1(1)](https://faculty.ksu.edu.sa/sites/default/files/Bridaa2021_Chapter_SomeNewClassesAndTechniquesInT.pdf). Here its intensity and target are fixed by the actual theta kernel.

The open step is to produce a positive solution of (10), or equivalently to prove $w(r)\ge0$ at every jump size. Positivity of both $A$ and $K$ does not show that $A$ belongs to the cone of positive mixtures of $K(\cdot,t)$. Nor does the known sign near zero propagate by a Volterra argument: $K(v,t)>0$ for every $v,t>0$, so every tail contribution affects every equation. Even a global representation would require a further real-zero argument: the van Dantzig class constructed by [Konstantopoulos, Patie and Sarkar](https://arxiv.org/abs/2211.16680) includes functions outside the Laguerre–Pólya class. No positive mixture on the whole half-line, and no RH conclusion, is asserted.

The real-singularity argument used above is classical Landau theory for positive Laplace transforms. Suzuki's [*On variants of Chebyshev's conjecture*](https://arxiv.org/pdf/2411.07436), Proposition 1 on printed page 11, states its Mellin form and cites Widder's *The Laplace Transform*, 1941, Chapter II, Theorem 5b, and Montgomery–Vaughan, Lemma 15.1. The Bernstein representation, its uniqueness and the subordinator construction are standard; see Schilling, Song and Vondraček, [*Bernstein Functions: Theory and Applications*](https://motapa.de/bernstein_functions/index.shtml), Chapters 3 and 5. These classical ingredients and the theta attributions in the preceding notes are retained without a novelty or formalization claim.
