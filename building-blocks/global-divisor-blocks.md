# Möbius–divisor blocks over the full range of divisor lengths

Let $\mu$ be the Möbius function, $d(n)$ the divisor function, $M(x)=\sum_{n\le x}\mu(n)$, and $\gamma$ Euler’s constant. Let $N,D$ be positive integers with $\sqrt N\le D\le N/2$. The proofs below give two unconditional estimates for the actual signed centered-divisor block: an elementary correlation bound $N^{1/4}D^{3/4}$ and the stronger bound $O_\delta(N^\delta(N^{1/4}D^{11/16}+D))$. Both retain arbitrary initial subintervals. The second keeps the Voronoï frequency inside the classical three-dimensional Robert–Sargos estimate.

These are written applications of established exponential-sum theorems. They extend the range of the [central-block proof](voronoi-mobius-central-block.md), which separately tracks a fixed logarithmic loss at $D=\sqrt N$. No new exponential-sum theorem, analytic Lean formalization or RH-scale global estimate is asserted.

## Exact floors and the elementary correlation estimate

Write

$$
H(q)=\log(q!)-\sum_{n\le q}d(n)+2\gamma q,\qquad
B(N,D)=\sum_{D<d\le2D}\mu(d)H(\lfloor N/d\rfloor),
\qquad Y=N/D.
$$

Here N,D are positive integers and $2D\le N$. The earlier central block is the special case $N=L^2,D=L$. The exact complete identity is

$$
\psi(N)-N+2\gamma=\sum_{d\le N}\mu(d)H(\lfloor N/d\rfloor).
\tag{1}
$$

The exact inverse is also used in the [finite Mertens transfer](README.md#finite-mertens-to-prime-transfer). Here the divisor lengths may be much larger than $\sqrt N$.

The existing checked floor-transfer inequality gives, term by term for $x=N/d\ge1$,

$$
|H(\lfloor x\rfloor)+\Delta(x)|
\le1+2\log x+2|\gamma|.
$$

Since $Y/2\le x<Y$ in this block, the total absolute floor correction is at most

$$
D(1+2\log Y+2|\gamma|).
\tag{2}
$$

This retains the corrected order of operations from the central-block proof: the floor is removed from the complete divisor error, before expanding it into phases. There is no return to the earlier artificial termwise floor loss.

For $Y$ large and $1\ll R\le Y/8$, the same classical truncated Voronoï formula gives

$$
B(N,D)=-\frac{V(N,D,R)}{\sqrt2\pi}
+O_\eta\!\left(DY^{1/2+\eta}R^{-1/2}+D\log(2Y)\right),
\tag{3}
$$
$$
V(N,D,R)=\sum_{k\le R}d(k)k^{-3/4}
\sum_{D<d\le2D}\mu(d)(N/d)^{1/4}
\cos(4\pi\sqrt{kN/d}-\pi/4).
$$

The input is [Ivić–Zhai, Lemma 3.1, equation (3.5)](https://arxiv.org/html/1209.0872#S3), which permits truncation length comparable to or smaller than its real argument. Its range was checked again for this application. Here every argument is at least $Y/2$, so a common $R\le Y/8$ is valid. The factor D in (3) counts summands; all error terms are summed absolutely. The implied constant is uniform in N,D,R in the stated range, with dependence on $\eta>0$.

Taking $R=\lfloor Y/8\rfloor$ when Y is sufficiently large makes the remainder in (3)

$$
O_\eta\!\left(DY^\eta+D\log(2Y)\right).
\tag{4}
$$

At $D=\sqrt N$, this fits $N^{1/2+\varepsilon}$ after choosing $\eta$ small enough. At $D=N^a$ with a fixed $a>1/2$, it does not provide that bound for arbitrarily small positive $\varepsilon$.

The restriction is visible even before logarithms or small positive powers are included. The bare truncation majorant is

$$
DY^{1/2}R^{-1/2}=\sqrt{ND/R}.
$$

Making this expression at most a fixed multiple of $N^{1/2+\varepsilon}$ requires $R\gg D N^{-2\varepsilon}$. The permitted range has $R\ll N/D$. Compatibility therefore requires

$$
D\ll N^{1/2+\varepsilon}.
\tag{5}
$$

Equation (5) is a restriction on this proof's error budget. It is **not** a lower bound for the signed truncation remainder: that remainder may cancel with its Möbius weights, with the floor correction, or with other divisor ranges. Nor does it exclude a different, longer transform with separately justified error terms. It says precisely that the present sourced formula plus absolute error summation does not extend its central-block accuracy to all D. Increasing R outside the formula's stated range is not an available inference.

The high-frequency estimate also changes with D. For $D\ge\sqrt N$, retain $R\le Y/8$, let $I=\{k:K<k\le\min(2K,R)\}$, and put

$$
a_k=d(k)k^{-3/4},\quad b_d=\mu(d)(d/D)^{-1/4},\quad
Z_K=\sum_{D<d\le2D}b_d\sum_{k\in I}a_k e(2\sqrt{Nk/d}),
\quad e(t)=e^{2\pi it}.
$$

The corresponding part of V has magnitude at most $Y^{1/4}|Z_K|$. Cauchy gives

$$
|Z_K|^2\le D\sum_{D<d\le2D}
\left|\sum_{k\in I}a_k e(2\sqrt{Nk/d})\right|^2.
$$

For distinct k,ℓ, the unweighted correlation phase is

$$
g_{k,\ell}(t)=2\sqrt N(\sqrt k-\sqrt\ell)t^{-1/2},\qquad
g'_{k,\ell}(t)=-\sqrt N(\sqrt k-\sqrt\ell)t^{-3/2}.
$$

Its derivative is monotone in magnitude, has fixed sign, and on $D\le t\le2D$ satisfies

$$
0<\frac{\sqrt N\,|\sqrt k-\sqrt\ell|}{(2D)^{3/2}}
\le |g'_{k,\ell}(t)|
\le\frac{\sqrt{NR}}{D^{3/2}}
\le\frac{N}{\sqrt8 D^2}\le\frac1{\sqrt8}<\frac12.
$$

Thus the same monotone-increment Kuzmin estimate used in the [central-block proof](voronoi-mobius-central-block.md) applies, after changing the sign of the phase if needed. Its proof is on page 1 of [Elkies's *Exponential sums II* notes](https://people.math.harvard.edu/~elkies/M229.09/kmv.pdf). It gives

$$
\left|\sum_{D<d\le2D}e(g_{k,\ell}(d))\right|
\ll\frac{D^{3/2}}{\sqrt N\,|\sqrt k-\sqrt\ell|}
\ll\frac{D^{3/2}\sqrt K}{\sqrt N\,|k-\ell|}.
$$

The derivative test is applied only to this unweighted sum. Harmonic row summation and $2|a_k a_\ell|\le |a_k|^2+|a_\ell|^2$ give

$$
\sum_{D<d\le2D}\left|\sum_{k\in I}a_ke(2\sqrt{Nk/d})\right|^2
\ll\left(D+\frac{D^{3/2}\sqrt K}{\sqrt N}\log(2K)\right)
\sum_{k\in I}|a_k|^2.
$$

Because $K\le Y/8$, the parenthesis is $O(D\log(2K))$. The same elementary divisor second moment as before supplies $\sum_{k\in I}|a_k|^2\ll K^{-1/2}\log^3(2K)$. Consequently

$$
\boxed{|Y^{1/4}Z_K|\ll N^{1/4}D^{3/4}K^{-1/4}\log^2(2K).}
\tag{6}
$$

This derivation is uniform over truncated frequency intervals. When $K\asymp Y$, (6) is $O(D\log^2(2Y))$, which is at RH scale in the central case but is too large as an upper bound when D is a larger fixed power of N. This is an upper bound, without an assertion that the actual band attains this size.

Bounding k=1 directly and summing (6) over dyadic K uses the convergent series $\sum_{j\ge0}2^{-j/4}(j+1)^2$. Thus $V\ll N^{1/4}D^{3/4}$. Set $\eta=1/4$ in (4) and use $\log(2Y)\ll Y^{1/4}$. This yields the written extension of the elementary correlation estimate:

$$
\boxed{B(N,D)\ll N^{1/4}D^{3/4}\qquad(\sqrt N\le D\le N/2).}
\tag{7}
$$

For bounded Y, where the asymptotic transform is not used, the checked estimate $|H(q)|\le13\sqrt q$ gives $|B(N,D)|\le13D\sqrt Y\ll D Y^{1/4}$; the constant can absorb the fixed bound on Y. This covers the remaining parameters in (7). The argument also works for an initial subinterval of $(D,2D]$, since the same derivative and length bounds apply. The complete N,D estimate is written mathematics, not a new Lean theorem or a novelty claim. At $D=\sqrt N$ it recovers the earlier $N^{5/8}$ estimate, rather than the later stronger Vaughan calculation.


## Keeping frequency inside the three-dimensional estimate

The signed transform can be estimated with its frequency variable still inside the Robert–Sargos sum. This extends the earlier central-block application to variable divisor lengths. It addresses the actual signed contribution B, with a bound uniform over initial subintervals of each divisor block. For every fixed $\delta>0$, the resulting written estimate is

$$
\boxed{\left|\sum_{D<n\le y}\mu(n)H(\lfloor N/n\rfloor)\right|
\ll_\delta N^\delta\left(N^{1/4}D^{11/16}+D\right),
\quad \sqrt N\le D\le N/2,\quad D\le y\le2D.}
\tag{8}
$$

Here N,D are positive integers and y is real. The implicit constant depends on $\delta$, not on N,D,y. This is an application of known estimates, with no novelty claim. The analytic argument below is not a Lean theorem. It uses the existing checked Vaughan identity and coefficient bounds; it adds no hypothesis about the Mertens function.

Set $Y=N/D\le D$, take $U=\lfloor D^{1/4}\rfloor$, and retain $R=\lfloor Y/8\rfloor$ from (3). We first work with Y and D above fixed absolute constants. For a frequency interval $I\subseteq(K,2K]\cap[1,R]$, with positive integer K, define

$$
\mathcal V_K(y)=Y^{1/4}\sum_{k\in I}d(k)k^{-3/4}
\sum_{D<n\le y}\mu(n)(n/D)^{-1/4}e(2\sqrt{Nk/n}).
$$

The corresponding band of V in (3) is $\operatorname{Re}(e(-1/8)\mathcal V_K(y))$. Apply the equal-cutoff Vaughan identity $\mu=2a-a*a*\mathbf1+b*b*\mathbf1$, where $a=\mu\mathbf1_{n\le U}$ and $b=\mu-a$, as proved in the [central-block chapter](voronoi-mobius-central-block.md). Its $2a(n)$ term vanishes since $n>D\ge U$. The Type II contribution has factor variables $p,q>U$ and coefficients bounded by d(p),d(q). Divide them into integer dyadic boxes. For any box meeting $D<pq\le y$, choose the variable names so that

$$
P\ge Q,\qquad D/4<PQ<2D,\qquad
P\gg D^{1/2},\qquad Q\gg D^{1/4}.
$$

The available source is [Robert–Sargos, Theorem 1, equation (1.3)](https://perso.univ-st-etienne.fr/rool6510/robert-2006-crelle.pdf). In its notation choose

$$
H_0=K,\quad N_0=P,\quad M_0=Q,\qquad
\beta=\tfrac12,\quad\gamma=\alpha=-\tfrac12,\qquad
F_0=2\sqrt{NK/(PQ)}.
$$

The phase is exactly correct, since

$$
F_0(k/K)^{1/2}(p/P)^{-1/2}(q/Q)^{-1/2}
=2\sqrt{Nk/(pq)}.
$$

Also $F_0\asymp\sqrt{YK}>1$ and
$\alpha(\alpha-1)\beta\gamma=-3/16\ne0$.
The frequency coefficient belongs to the allowed joint coefficient $a(k,p)$. Its restriction to I is allowed there as well. Normalize the divisor-bounded coefficients using $d(m)\ll_\rho m^\rho$. The factors $(k/K)^{-3/4}$, $(p/P)^{-1/4}$ and $(q/Q)^{-1/4}$ have modulus at most one. The extra amplitude factor $(D/(PQ))^{1/4}$ is bounded. Thus the arithmetic coefficients and the amplitude fit the source's coefficient hypotheses after a cost $O_\rho((KD)^\rho)$.

For $c,T>0$ and $b/m\ne1$, the scalar truncated Perron formula is
$$
\mathbf1_{m<b}=\frac1{2\pi}\int_{-T}^{T}
\frac{b^{c+it}m^{-c-it}}{c+it}\,dt
+O\!\left(\frac{(b/m)^c}{T|\log(b/m)|}\right).
$$
See [Harper, *Probabilistic Number Theory*, notes 2, Lemma 11.1](https://warwick.ac.uk/fac/sci/maths/people/staff/harper/probntnotes2.pdf). We use it only in finite sums, so it requires no convergence half-plane for a Dirichlet series.

Use boundaries $b_y=\lfloor y\rfloor+1/2$ and $b_0=D+1/2$, the vertical line $c=1/\log D$, and height $T_0=D^3$. Every product in the full rectangle lies in $(D/4,8D]$. Its distance from either half-integer boundary is at least $1/2$, so $|\log(b/(pq))|\gg D^{-1}$. The scalar error is $O(D/T_0)$ per pair. Including O(D) pairs, the frequency coefficients, and the amplitude, the weighted error for the band is

$$
O_\rho\!\left(Y^{1/4}K^{1/4+\rho}D^{-1+\rho}\right).
$$

Since $K\le Y\le D$, this is at most $O_\rho(D^{-1/2+2\rho})$. In the integral, the product twist separates as $p^{-c-it}q^{-c-it}$, with modulus at most one. The source bound is uniform in t. The integral costs $O(\log D)$, which is absorbed into a reserved positive power. This justifies the cutoff for the joint frequency sum, including an incomplete final band and arbitrary y. All sum–integral interchanges are finite.

After reinstating the prefactor $Y^{1/4}K^{-3/4}$, Robert–Sargos therefore bounds each Type II box by

$$
\ll_\delta N^\delta\left[
Y^{3/8}D^{3/4}Q^{-1/4}K^{1/8}
+Y^{1/4}DP^{-1/4}
+Y^{1/4}DQ^{-1/2}K^{1/4}+D
\right].
\tag{9}
$$

The negligible Perron error is absorbed by the displayed D term. The factor $N^\delta$ accommodates both the source's positive-power loss and coefficient normalization, since $KD\le YD=N$. We can also absorb the O(log² D) factor boxes by choosing those input powers smaller than the final $\delta$. This calculation keeps the k sum inside the sourced estimate. It does not require cancellation from a conjecture about $\mu$.

For completeness the Type I contribution needs its own bound. Write its small factor as $r=uv$, with $u,v\le U$, and its unweighted inner variable as w. On $D<rw\le y$, the phase $2\sqrt{Nk/(rw)}$ has second derivative of magnitude comparable to $F_k/(D/r)^2$, where $F_k=\sqrt{Yk}$. The same classical second-derivative test used in the central argument gives, uniformly in y,

$$
\left|\sum_{D/r<w\le y/r}e(2\sqrt{Nk/(rw)})\right|
\ll F_k^{1/2}+D/(rF_k^{1/2}).
$$

The endpoint term is absorbed because $F_k>1$. The amplitude $(rw/D)^{-1/4}$ has uniformly bounded supremum and variation on this interval, so partial summation preserves the estimate. Summing over u,v and then over the band gives

$$
|\mathcal V_{K,I}(y)|
\ll_\delta N^\delta\left(Y^{1/2}U^2K^{1/2}+D\right)
\le C_\delta N^\delta\left(Y^{1/2}D^{1/2}K^{1/2}+D\right).
$$

Here $\sum_{u,v\le U}(uv)^{-1}\ll\log^2(2U)$ and the elementary dyadic divisor bounds give $\sum_{k\in I}d(k)k^{-1/2}\ll K^{1/2}\log(2K)$ and $\sum_{k\in I}d(k)/k\ll\log(2K)$. These logarithms are included in the reserved positive power.

Now restrict to $K\le D^{1/4}$. The scale inequalities above reduce both types to

$$
\boxed{|\mathcal V_K(y)|
\ll_\delta N^\delta\left(Y^{1/4}D^{7/8}K^{1/4}+D\right).}
\tag{10}
$$

The comparisons can be checked term by term. Relative to the first term of (10), the first term of (9) is at most a constant times $Y^{1/8}D^{-3/16}K^{-1/8}\le D^{-1/16}$; its second term has ratio at most $K^{-1/4}\le1$; and its third term has ratio bounded by an absolute constant. The Type I term has ratio $Y^{1/4}D^{-3/8}K^{1/4}\le D^{-1/16}$. The frequency k=1, which lies outside the displayed intervals $(K,2K]$, obeys the same bound with K=1 by using the singleton source variable $h=2$, $H_0=1$, and replacing its normalized frequency by $F_0=2\sqrt{N/(2PQ)}$. The phase is then exactly $F_0\sqrt2(p/P)^{-1/2}(q/Q)^{-1/2}=2\sqrt{N/(pq)}$. It is included separately.

Let $K_* = \min(R,\lfloor D^{1/4}\rfloor)$. Summing (10) over dyadic bands up to $K_*$ costs only

$$
O_\delta\!\left(N^\delta
[Y^{1/4}D^{7/8}K_*^{1/4}+D]\right).
$$

The growing band terms form a geometric sum; the repeated D terms cost a logarithm absorbed in the reserved power. If $K_*<R$, the existing high-frequency bound (6) gives a remaining contribution

$$
O_\delta\!\left(N^\delta Y^{1/4}DK_*^{-1/4}\right).
$$

In this case $K_*\asymp D^{1/4}$, so both frequency ranges are bounded by $O_\delta(N^\delta[Y^{1/4}D^{15/16}+D])$. If $K_*=R$, then $Y<8(R+1)\ll D^{1/4}$, and the low-frequency estimate is bounded by $O_\delta(N^\delta D)$. There is no high-frequency range in that case.

Finally the transform error (3) is $O_\eta(DY^\eta+D\log(2Y))$ at this R, because $R\asymp Y$. Choose its $\eta$ and the other reserved powers small enough for the final $\delta$. This proves (8), using $Y^{1/4}D^{15/16}=N^{1/4}D^{11/16}$. If Y is below the fixed cutoff for the transform, the checked bound $|H(q)|\le13\sqrt q$ bounds the original block by a constant times D. The finite remaining small values of D are absorbed in the constant. Thus (8) covers its entire stated range.

This also controls a consecutive part of the signed inverse. For integers $\lceil\sqrt N\rceil\le D_0\le A\le N/2$, partition $(D_0,A]$ into intervals starting at $D_0,2D_0,4D_0,\ldots$, with an initial subinterval of the last block. Applying (8) and summing the positive geometric powers gives

$$
\left|\sum_{D_0<n\le A}\mu(n)H(\lfloor N/n\rfloor)\right|
\ll_\delta N^\delta\left(N^{1/4}A^{11/16}+A\right).
\tag{11}
$$

This estimates the actual signed terms within every block before summing their bounds. It uses triangle inequality between blocks. It does not establish cancellation between different divisor ranges.

For fixed $D\asymp N^a$, the exponent in (8), before the arbitrary $\delta$, is $\max(1/4+11a/16,a)$. The existing bound (7) remains available and can always be used when it is smaller.

| a | Earlier exponent from (7) | Exponent from (8), plus any positive loss |
|---|---|---|
| $1/2$ | $5/8$ | $19/32$ |
| $2/3$ | $3/4$ | $17/24$ |
| $3/4$ | $13/16$ | $49/64$ |
| $4/5$ | $17/20$ | $4/5$ |
| $9/10$ | $37/40$ | $9/10$ |

The change is a uniform extension of the existing central application, not an improvement to its $19/32$ exponent. For every fixed $1/2\le a<1$, it improves the earlier block power when the positive loss is chosen sufficiently small. At $D\asymp N$ the new estimate with its $N^\delta$ loss is weaker than the retained elementary O(N) bound. Summing all ranges does not improve the classical quantitative prime number theorem.

The required RH-scale estimate is still missing. Equation (8) has exponent at least $19/32$ on its range, and for $a>1/2$ its D term already exceeds $N^{1/2+\varepsilon}$ when $\varepsilon<a-1/2$. These statements compare available majorants, not lower bounds for B or the prime error. Retaining frequencies together in (9) does not repair the absolute transform remainder or control the terminal Mertens increment discussed below.


## The terminal block and the limitation of separate bounds

For $N/2<n\le N$, the quotient is exactly one. Since $H(1)=\kappa=2\gamma-1>0$,
$$
\sum_{\lfloor N/2\rfloor<n\le N}\mu(n)H(\lfloor N/n\rfloor)
=\kappa\,[M(N)-M(\lfloor N/2\rfloor)].              \tag{12}
$$
This is a finite identity, not a phase approximation. For any fixed $r>0$, a bound of order $N^r$ on (12) for all integer cutoffs is equivalent to $M(N)=O(N^r)$. Indeed, with $N_j=\lfloor N/2^j\rfloor$, the exact floor identity $\lfloor N_j/2\rfloor=N_{j+1}$ gives
$$
M(N)=\sum_{j:N_j\ge1}[M(N_j)-M(N_{j+1})].
$$
The assumed bound gives the geometric factor $1/(1-2^{-r})$; finitely many initial values can be absorbed into the constant. Conversely, a bound for $M$ immediately bounds the difference. Control only at powers of two would not justify this argument for arbitrary $N$.

This explains a limitation of estimating every divisor range separately. It does not require the terminal block to be estimated separately in a future proof: cancellations between the ranges remain possible. The [small-prime grouping theorem](small-prime-grouping.md) tests one such attempted regrouping, retaining its exact signed inner sums. The [hyperbola-product theorem](hyperbola-product.md) uses the different product variable $k=nm$ and controls products through $N^{5/8}$; it does not replace the divisor-block estimates here.

The finite identities and classical analytic estimates have separate status. The bounds in this chapter are written mathematics; the linked repository modules formalize the specified arithmetic identities without postulating these analytic estimates. No mathematical priority claim is made.
