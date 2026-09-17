# Signed divisor packets and their boundary covariance

Let $\gamma$ be Euler's constant, $h(r)=\log r-\tau(r)+2\gamma$ for positive integers $r$, and

```math
H(q)=\sum_{r\le q}h(r),\qquad H(0)=0,\qquad
\mathcal A(y)=\int_0^yH(\lfloor s\rfloor)\,ds\quad(y\ge0).
```

This note groups the actual Möbius signs into complete divisor cubes before taking norms. It proves an unconditional saving for a growing family of signed boundary packets, stronger than its positive packet majorant. The remaining all-epsilon covariance bound is equivalent to the existing coarse RH criterion and is not proved here. The methods are Möbius inversion, integrated Voronoï theory and the classical unconditional Mertens estimate; no mathematical priority or Lean-formalization claim is made.

## Exact cubes and a disjoint arithmetic partition

For a nonempty squarefree integer $P$, define

```math
Q_P(y)=\sum_{d\mid P}\mu(d)H(\lfloor y/d\rfloor),\qquad
\mathcal A_P(y)=\sum_{d\mid P}\mu(d)d\mathcal A(y/d).
```

Writing $(D_pf)(y)=f(y/p)$ gives

```math
Q_P=\prod_{p\mid P}(1-D_p)H_{\rm step},\qquad
\mathcal A_P=\prod_{p\mid P}(1-pD_p)\mathcal A,
\qquad \mathcal A_P(y)=\int_0^yQ_P(s)\,ds.
```

The factor $p$ in the integrated identity is essential. For integer $X\ge1$ and $X\le t\le2X$, set

```math
v_n(t)=\int_X^tH(\lfloor x/n\rfloor)\,dx,\qquad
u_n(t)=\int_t^{2X}H(\lfloor x/n\rfloor)\,dx.
```

The packet at a squarefree core $a$ coprime to $P$ is the vector

```math
Z_a(t)=\sum_{d\mid P}\mu(d)(v_{ad}(t),u_{ad}(t))
=\bigl(a[\mathcal A_P(t/a)-\mathcal A_P(X/a)],
 a[\mathcal A_P(2X/a)-\mathcal A_P(t/a)]\bigr).
```

Every squarefree label $n\le2X-1$ has the unique decomposition $n=ad$ with $d=\gcd(n,P)$ and $(a,P)=1$. Its sign is $\mu(n)=\mu(a)\mu(d)$. Completing a cube introduces no nonzero extra terms: if $ad\ge2X$, both integrals vanish. Thus the packets partition the actual integrated sum exactly, without an overlap correction.

This construction is an incidence identity, not an independent cancellation theorem. For example, put $J(y)=0$ for $0\le y<1$ and $J(y)=\psi(\lfloor y\rfloor)-\lfloor y\rfloor+2\gamma$ for $y\ge1$. Since $h=\mathbf1*(\Lambda-\mathbf1+2\gamma\delta_1)$, finite rearrangement gives

```math
Q_P(y)=\sum_{\substack{b\le y\\(b,P)=1}}J(y/b).
```

Taking every prime through the full cutoff simply places the unknown signed sum in one packet.

## Full coarse energy, including its mean correction

Let $e(x)=\psi(\lfloor x\rfloor)-x$. Ordinary Möbius inversion gives

```math
\sum_{n\le x}\mu(n)H(\lfloor x/n\rfloor)
=e(x)+2\gamma+\{x\}\qquad(x\ge1).
```

Define $d_X(t)=\int_X^t(2\gamma+\{x\})dx$, $D_X=d_X(2X)$, and $\Delta(t)=(d_X(t),D_X-d_X(t))$. In $\mathcal H_X=L^2([X,2X];\mathbb R^2)$ the genuine energy is

```math
S_X=\int_X^{2X}\left[\left(\int_X^t e(x)dx\right)^2+
\left(\int_t^{2X}e(x)dx\right)^2\right]dt
=\left\|\sum_a\mu(a)Z_a-\Delta\right\|^2.
```

All sums over $a$ below mean squarefree cores at most $2X-1$ coprime to $P$. In particular neither the endpoint mean nor the suffix has been removed.

Choose $P$ to be the largest primorial at most $\sqrt X$ and set $Y=X/P$. Statements below are asymptotic as $X\to\infty$, so $P>1$. Split

```math
I=\sum_{a\le Y}\mu(a)Z_a,\qquad B=\sum_{a>Y}\mu(a)Z_a.
```

The exact expansion is

```math
S_X=\|B\|^2+\|I\|^2+2\langle B,I\rangle
-2\langle B+I,\Delta\rangle+\|\Delta\|^2.
```

The signed packet Gram kernel is

```math
K_P(a,b)=\sum_{d,e\mid P}\mu(d)\mu(e)
\int_X^{2X}[v_{ad}(t)v_{be}(t)+u_{ad}(t)u_{be}(t)]dt,
```

and

```math
\|B\|^2=\mathfrak D_X+\mathfrak O_X,
\quad\mathfrak D_X=\sum_{a>Y}K_P(a,a),
\quad\mathfrak O_X=\sum_{\substack{a,b>Y\\a\ne b}}\mu(a)\mu(b)K_P(a,b).
```

Positive semidefiniteness of $K_P$ does not determine the sign of $\mathfrak O_X$.

## Interior and diagonal bounds

The [integrated divisor identity](../prime-history/integrated-divisor-history.md), using [Ivić's integrated Voronoï formula (1.4)](https://arxiv.org/pdf/math/0510114), gives

```math
\mathcal A(y)=\kappa y+O(y^{3/4}),\qquad
\kappa=\tfrac12\log(2\pi)-\gamma-\tfrac14\quad(y\ge1).
```

For $aP\le X$, all arguments in the complete packet are at least one. The linear terms cancel because $\sum_{d\mid P}\mu(d)=0$. Consequently each component is bounded by

```math
C X^{3/4}a^{1/4}\sum_{d\mid P}d^{1/4}
=C X^{3/4}a^{1/4}P^{1/4}\prod_{p\mid P}(1+p^{-1/4}).
```

Summing $a^{1/4}$ up to $Y$ and squaring over an interval of length $X$ proves

```math
\|I\|^2\ll\frac{X^5}{P^2}\prod_{p\mid P}(1+p^{-1/4})^2.
```

If $z$ is the largest prime in $P$, the prime number theorem and the definition of the last included prime give $z\asymp\log X$, $\sqrt X/\log X\ll P\le\sqrt X$ and $\tau(P)=X^{o(1)}$. The displayed product is also $X^{o(1)}$. Therefore $\|I\|^2\le X^{4+o(1)}$ up to an absolute constant, and directly $\|\Delta\|^2\ll X^3$.

Uniformly in actual labels $n\le2X-1$, $|v_n(t)|+|u_n(t)|\ll X$. For $n\le X$ this follows from the same primitive bound; for $n>X$ it follows from the exact terminal ramp $H(1)(t-n)_+$. Cauchy–Schwarz within a packet and unique label coverage now give

```math
\mathfrak D_X\le\tau(P)\sum_{\substack{n\le2X-1\\\mu(n)\ne0}}
\int_X^{2X}(v_n^2+u_n^2)dt
\ll X^4\tau(P)=X^{4+o(1)}.
```

Thus $S_X\ll_\varepsilon X^{4+\varepsilon}$ for every $\varepsilon>0$ along dyadic $X$ is equivalent to the one-sided estimate $\mathfrak O_X\le C_\varepsilon X^{4+\varepsilon}$. Indeed $I-\Delta$ already has that norm scale, and $\|B\|^2=\mathfrak D_X+\mathfrak O_X$. The reverse inequality $\mathfrak O_X\ge-\mathfrak D_X$ is automatic. By the [coarse primitive RH criterion](coarse-energy-rh-criterion.md), this all-epsilon upper estimate is RH-equivalent, not a proved input to what follows.

## A proved cancellation saving for the entire boundary

Put

```math
M_P(y)=\sum_{\substack{a\le y\\(a,P)=1}}\mu(a),\qquad
c_P(r)=\sum_{\substack{d\mid r\\d\mid P}}\mu(d)h(r/d).
```

Interchanging finite sums gives the exact boundary source

```math
\mathcal B(x)=\sum_{a>Y}\mu(a)Q_P(x/a)
=\sum_{r\le x/Y}c_P(r)[M_P(x/r)-M_P(Y)]\quad(X\le x<2X),
```

and $B(t)=(\int_X^t\mathcal B(x)dx,\int_t^{2X}\mathcal B(x)dx)$. The term $M_P(Y)$ is retained and all real arguments mean the inclusive step functions.

Let $\omega(X)=(\log X)^{3/5}(\log\log X)^{-1/5}$. The classical unconditional estimate is $|M(y)|\ll y\exp[-c\omega(y)]$ for sufficiently large $y$. An explicit primary version is [Lee–Leong, Theorem 1.1, equation (11), version 5](https://arxiv.org/pdf/2208.06141v5): its stated $y\log y$ prefactor is absorbed by reducing $c$, and its explicit initial range is not used at small arguments.

We need a uniform transfer as $P$ grows. Convolution, not a fixed-modulus assertion, gives

```math
M_P(y)=\sum_{\substack{d\le y\\p\mid d\Rightarrow p\mid P}}M(y/d).
```

For $d\le\sqrt y$, the Mertens bound costs at most $Cy e^{-c\omega(y)}\prod_{p\le z}(1-p^{-1})^{-1}\ll y e^{-c\omega(y)}\log z$. For $d>\sqrt y$, use $|M(y/d)|\le y/d$ and Rankin's inequality with $\delta=1/(2\log z)$:

```math
\sum_{\substack{d>\sqrt y\\d\ P\text{-smooth}}}d^{-1}
\le y^{-\delta/2}\prod_{p\le z}(1-p^{-1+\delta})^{-1}
\ll e^{-\log y/(4\log z)}(\log z)^C.
```

The last Euler-product estimate follows from $p^\delta\le e^{1/2}$ and $\sum_{p\le z}1/p=O(\log\log z)$; its finitely many small-prime factors are uniformly bounded for sufficiently large $z$. Since $Y\ge\sqrt X$ and $z\asymp\log X$, this tail is smaller than the preceding stretched-exponential bound uniformly for $Y\le y\le2X$. Hence

```math
|M_P(y)|\ll y e^{-c\omega(X)}\qquad(Y\le y\le2X).
```

The remaining coefficient norm costs only logarithms:

```math
\sum_{r\le2P}\frac{|c_P(r)|}{r}
\le\prod_{p\mid P}(1+p^{-1})\sum_{m\le2P}\frac{|h(m)|}{m}
\ll (\log z)\log^2(2P).
```

Here $\sum_{m\le T}\tau(m)/m\ll\log^2(2T)$ follows by expanding the divisors. Because $r\le x/Y$ implies $Y\le x/r$, the exact source formula proves, after absorbing these logarithms,

```math
|\mathcal B(x)|\ll X e^{-c\omega(X)},\qquad
\boxed{\|B\|^2\ll X^5 e^{-c'\omega(X)}}.
```

This is an unconditional signed bound on the full boundary family. Its exponent is still $5-o(1)$, so it does not prove the required upper covariance estimate.

## Why packetwise absolute values lose this saving

Squarefree cores $a\in[7X/4,15X/8]$ coprime to $P$ have singleton packets: every other divisor $d\mid P$ has $ad>2X$. For $t\in[X,5X/4]$, their suffix equals $H(1)(2X-a)\ge(2\gamma-1)X/8$.

There are $\asymp X\phi(P)/P\asymp X/\log z$ such cores. To verify the count without signed cancellation, expand $\mu^2$ and impose coprimality by inclusion-exclusion. On a fixed proportional interval the density is

```math
\frac{\phi(P)}P\prod_{p>z}(1-p^{-2}),
```

with error $O(2^{\omega(P)}\sqrt X)=X^{1/2+o(1)}$. It is smaller than the main term. Therefore

```math
\int_X^{2X}\left(\sum_{a>Y}|(Z_a(t))_2|\right)^2dt
\gg \frac{X^5}{(\log\log X)^2}.
```

The signed bound is strictly smaller than this positive majorant. Signs between packets thus remove a real obstruction to that majorant, but the proof still uses absolute values in the quotient sum for $\mathcal B$. It does not control its complete coefficient-weighted covariance at the RH scale. All prime powers, the density drift, both integration anchors and the interior cross term remain in the exact identity for $S_X$.
