# The integrated matching primitive: a usable theorem and its limits

The additive-time primitive is a first Riesz mean of an explicit divisor-error source. Its common linear term cancels on every matched pair. Classical integrated Voronoï theory therefore proves a uniform saving for edges whose labels are $o(X)$, without assuming Möbius cancellation or a favorable matching. It does not supply a saving on the terminal labels $n\asymp X$: there the actual observables are ramps, and valid three-prime edges can have differences of order $X$.

Two consequences are useful for matching estimates. Leaving all labels $n\le\sqrt X$ unmatched already costs only the allowed order $X^4$ in the unnormalized integrated-square target. The remaining work lies in the larger labels and their actual weighted matching neighborhoods. Also, the fixed edge $6\leftrightarrow5$ retains mean-square size $X^{5/2}$; the $3/4$ exponent furnished by the primitive theorem cannot uniformly be improved even on this valid edge.

This is a written application of integrated divisor theory, with exact priority unresolved and no Lean formalization.

## 1. Exact primitive, including all fractional endpoints

Keep the actual source and set $H(0)=0$:

```math
H(q)=\log(q!)-\sum_{d\le q}\lfloor q/d\rfloor+2\gamma q.
```

Write $\tau(r)=\sum_{d\mid r}1$. Then

```math
H(q)=\sum_{r\le q}b(r),\qquad
b(r)=\log r-\tau(r)+2\gamma. \tag{1}
```

For $y\ge0$, let $Q=\lfloor y\rfloor$, $\theta=\{y\}$, and

```math
A(y)=\int_0^yH(\lfloor u\rfloor)\,du.
```

The exact formulas are

```math
\boxed{A(y)=\sum_{q=1}^{Q}H(q)-(1-\theta)H(Q)
       =\sum_{r\le y}(y-r)b(r).} \tag{2}
```

The empty-sum convention handles $Q=0$. At an integer $y=Q$, the last value $H(Q)$ contributes zero length. The second equality follows by integrating the step function $\sum_{r\le u}b(r)$; it is an unnormalized Riesz mean of order one.

Consequently, without any endpoint approximation,

```math
\boxed{v_n(t)=n[A(t/n)-A(X/n)],\quad
u_n(t)=n[A(2X/n)-A(t/n)].} \tag{3}
```

This preserves both integer division histories and the exact additive-time cutoff.

For later analysis it is useful to separate the elementary and divisor parts. Let

```math
D(y)=\sum_{r\le y}\tau(r),\qquad
\Delta(y)=D(y)-y\log y-(2\gamma-1)y,
```

with the continuous extension of $y\log y$ at zero, and define

```math
R(y)=\int_0^y\Delta(u)\,du-\frac y4.
```

Use $G_B$ for the Barnes $G$-function, to avoid confusing it with the earlier observable $G=KH$. From its finite product,

```math
L(y):=\sum_{r\le y}(y-r)\log r
=\log G_B(Q+1)+\theta\log\Gamma(Q+1). \tag{4}
```

Also

```math
\sum_{r\le y}(y-r)=\frac{y^2-y+\theta(1-\theta)}2,
```

and

```math
\int_0^yD(u)\,du
=\frac{y^2}{2}\log y+
 \left(\gamma-\frac34\right)y^2+\frac y4+R(y).
```

Thus an exact alternative to (2), for $y>0$, is

```math
A(y)=L(y)-\frac{y^2}{2}\log y+\frac34y^2
 -\left(\gamma+\frac14\right)y+\gamma\theta(1-\theta)-R(y). \tag{5}
```

No discrete-to-continuous correction has been dropped.

## 2. The applicable primary theorem and the common drift

Ivić, *On the integral of the error term in the Dirichlet divisor problem*, equation (1.4), gives an absolutely convergent integrated Voronoï expansion. His $\Delta$ includes the subtraction of $\zeta(0)^2=1/4$, and half-weights at integer arguments. Integer half-weights do not affect integrals; the $1/4$ does. Translated into the definition above, the result yields

```math
R(y)=\frac{y^{3/4}}{2\sqrt2\pi^2}
 \sum_{r=1}^{\infty}\frac{\tau(r)}{r^{5/4}}
 \sin(4\pi\sqrt{ry}-\pi/4)+O(y^{1/4}),\qquad y\ge1. \tag{6}
```

The paper explicitly supplies a second, absolutely convergent term of size $y^{1/4}$, followed by a constant and $O(y^{-1/4})$. An $O(1)$ remainder after retaining only the leading series would be incorrect. The same page records the sharp mean-square order $Y^{5/2}$ of the centered primitive. This is an unconditional theorem, with no short-interval restriction. [Primary PDF, pp. 1–2, definition (1.2) and formula (1.4)](https://arxiv.org/pdf/math/0510114).

The series in (6) converges absolutely since $\sum\tau(r)r^{-5/4}=\zeta(5/4)^2<\infty$. In particular $R(y)=O(y^{3/4})$. The result is more useful here than a pointwise estimate for $\Delta(y)$: it controls cancellation during the integration itself.

For the elementary term, the Barnes expansion and Stirling's expansion, uniformly for $0\le\theta<1$, give

```math
L(y)=\frac{y^2}{2}\log y-\frac34y^2+
 \frac{\log(2\pi)}2y-\frac12B_2(\theta)\log y
 +\zeta'(-1)+O(y^{-1}), \tag{7}
```

where $B_2(\theta)=\theta^2-\theta+1/6$. This follows by putting $y=Q+\theta$ into (4) and expanding at $Q$. The finite product, Barnes expansion, its constant $\log A_{\rm Glaisher}=1/12-\zeta'(-1)$, and Stirling expansion give these uniform expansions. [DLMF 5.17.2, 5.17.5 and 5.17.7](https://dlmf.nist.gov/5.17), [DLMF 5.11.1](https://dlmf.nist.gov/5.11).

Combining (5)–(7) gives

```math
\boxed{A(y)=a y-R(y)-\frac12B_2(\{y\})\log y+
 \zeta'(-1)+\gamma\{y\}(1-\{y\})+O(y^{-1}),} \tag{8}
```

```math
a=\frac12\log(2\pi)-\gamma-\frac14
 =0.09172286830313988\ldots.
```

In particular

```math
A(y)=a y+O(y^{3/4})\quad(y\ge1). \tag{9}
```

The quarter-term and the fractional endpoint terms matter. Omitting the former would change the drift; treating the discrete sum as a continuous integral without (4) would leave a spurious logarithmic main term.

## 3. What the theorem actually saves on a paired difference

For $X\le t\le2X$ and $1\le n\le X$, equations (3) and (9) imply

```math
v_n(t)=a(t-X)+O(X^{3/4}n^{1/4}),
\qquad
u_n(t)=a(2X-t)+O(X^{3/4}n^{1/4}). \tag{10}
```

The constants are absolute and the estimates are uniform in $t,n,X$. Therefore every valid edge with endpoints $n,m\le X$ satisfies

```math
\boxed{|v_n(t)-v_m(t)|+
       |u_n(t)-u_m(t)|
       \ll X^{3/4}(n^{1/4}+m^{1/4}).} \tag{11}
```

This is a genuine cancellation before absolute values: the entire common linear drift disappears. It is independent of the Möbius signs and does not require a choice of matching. In particular, if $n,m\le X^{1-\delta}$, the pair cost is $O(X^{1-\delta/4})=o(X)$ for every fixed $\delta>0$.

For an arbitrary *specified* matching confined to labels $n\le Y\le X$, with $U$ unmatched labels, (10)–(11) give the uniform bound

```math
C_{\le Y}(t)\ll XU+X^{3/4}Y^{5/4}, \tag{12}
```

and the same bound for suffix costs. This is a bound for each supplied matching, not a theorem that a matching with small $U$ exists. If $U\ll X^{1/2}$ and $Y\ll X^{3/5}$, its contribution meets the desired $O(X^4)$ unnormalized integrated-square scale. The unmatched-count condition cannot be inferred from the primitive theorem.

There is also an unconditional deduction that needs no matching at all. By (10), $|v_n|+|u_n|\ll X$ for $n\le X$. Leave every label $n\le Y$ unmatched. Its cost is $O(XY)$, so

```math
\int_X^{2X}\left[
\left(\sum_{n\le Y,\ \mu(n)\ne0}|v_n(t)|\right)^2+
\left(\sum_{n\le Y,\ \mu(n)\ne0}|u_n(t)|\right)^2\right]dt
\ll X^3Y^2. \tag{13}
```

Taking $Y=\lfloor\sqrt X\rfloor$ proves that these small labels already fit the $X^4$ target. One may therefore seek a matching only on the remaining induced graph, with this known small-label contribution added by the square inequality. This is a valid sufficient strategy; forcing the split can lose useful edges crossing it.

The known terms $d_X(t)=\int_X^t(2\gamma+\{x\})dx$ and its suffix are $O(X)$. Their own unnormalized squared integral is $O(X^3)$. They remain in the certificate and can be absorbed by the same square inequality. Nothing here removes unmatched costs or the arithmetic profile $C^0$.

## 4. Sharpness even on the fixed actual edge $6\leftrightarrow5$

A stronger uniform power saving for every fixed valid edge is false. The following consequence of (6) tests the paired remainder directly.

**Proposition.** For the actual edge $6=2\cdot3\leftrightarrow5$, there exists $c>0$ such that, for all sufficiently large $X$,

```math
\int_X^{2X}|v_6(t)-v_5(t)|^2dt\ge cX^{5/2}. \tag{14}
```

Thus one cannot replace $X^{3/4}$ in the fixed-label pointwise bound by $X^{3/4-\eta}$, uniformly in $t\in[X,2X]$, for any $\eta>0$.

To prove this, set

```math
T(t)=6R(t/6)-5R(t/5),\qquad c_V=(2\sqrt2\pi^2)^{-1}.
```

Equations (6) and (8) give

```math
v_6(t)-v_5(t)=-T(t)+T(X)+O(\log X),
```

```math
T(t)=c_Vt^{3/4}\left[
6^{1/4}\sum_{r\ge1}\tau(r)r^{-5/4}
 \sin(4\pi\sqrt{r/6}\sqrt t-\pi/4)
-5^{1/4}\sum_{r\ge1}\tau(r)r^{-5/4}
 \sin(4\pi\sqrt{r/5}\sqrt t-\pi/4)\right]+O(t^{1/4}). \tag{15}
```

Group equal frequencies. The frequency with squared value $1/6$ occurs only in the first series, with coefficient $6^{1/4}$. It cannot occur in the second, since that would require $r=5/6$. The coefficients are absolutely summable. Expanding finite truncations, integrating, and then passing to the absolutely convergent limit proves

```math
\int_X^{2X}T(t)^2dt=\kappa X^{5/2}+o(X^{5/2}),
```

where

```math
\kappa=\frac{2^{5/2}-1}{40\pi^4}
 \sum_{\lambda}c_\lambda^2
\ge\frac{(2^{5/2}-1)\sqrt6}{40\pi^4}>0. \tag{16}
```

Here $c_\lambda$ are the grouped coefficients inside the brackets in (15), with $\lambda=r/6$ or $r/5$. Distinct frequencies have vanishing normalized cross integrals; each diagonal contributes one half. Absolute convergence justifies this limit without a conjectured decorrelation theorem.

Termwise integration of (15) also gives $\int_X^{2X}T(t)dt=O(X^{5/4})$. Together with $T(X)=O(X^{3/4})$, this shows

```math
\int_X^{2X}[T(t)-T(X)]^2dt
=\kappa X^{5/2}+X T(X)^2+o(X^{5/2}).
```

The anchoring term is nonnegative, and its cross term is only $O(X^2)$. The $O(\log X)$ correction does not affect the leading lower bound. This proves (14), including the actual lower endpoint subtraction.

The proposition does not obstruct the global $X^4$ target: one edge contributes far less than that. It rules out a stronger per-edge lemma that would incorrectly assume all Voronoï oscillations cancel on a prime substitution. The primitive theorem's fixed-edge $3/4$ scale is already sharp.

## 5. The terminal range has an exact non-oscillatory obstruction

For $X\le n<2X$, every division quotient in the integration window is 0 or 1. Let $h_1=H(1)=2\gamma-1>0$. Then

```math
\boxed{v_n(t)=h_1(t-n)_+,\qquad
u_n(t)=h_1[(2X-n)-(t-n)_+].} \tag{17}
```

For two terminal labels $m<n$ and $t\ge n$,

```math
v_m(t)-v_n(t)=h_1(n-m).
```

There is no oscillatory time cancellation in this portion. The factor-of-two edge condition alone does not make the difference small.

For a parametric family of **actual valid edges**, take squarefree $a$, coprime to 30, in

```math
X/5\le a\le X/4.
```

The endpoints $5a,6a$ lie in $[X,3X/2]$, have opposite Möbius signs, and are connected by the permitted substitution $2\cdot3\leftrightarrow5$ with common factor $a$. For all $t\in[3X/2,2X]$,

```math
|v_{6a}(t)-v_{5a}(t)|=h_1a\ge h_1X/5,
```

so

```math
\boxed{\int_X^{2X}|v_{6a}(t)-v_{5a}(t)|^2dt
\ge \frac{h_1^2}{50}X^3.} \tag{18}
```

Such $a$ exist for every sufficiently large dyadic $X$. The elementary squarefree count with $(a,30)=1$ is
$\frac{5}{2\pi^2}Y+O(\sqrt Y)$ up to $Y$; subtracting endpoints proves existence in this fixed-proportion interval. This count follows from $\mu^2(n)=\sum_{d^2\mid n}\mu(d)$ with an absolute-value error estimate, and requires no cancellation estimate for $\mu$.

Equation (18) disproves a uniform $o(X)$ bound on all permitted terminal edge differences. It does **not** show that an optimized matching must use these expensive edges. A successful matching theorem must select cheaper observable neighbors and bound the resulting unmatched or Hall deficit.

For example, if terminal labels are matched only to terminal labels, then after both are active an edge of cost at most $L$ must satisfy $|n-m|\le L/h_1$. The graph's ratio condition guarantees nothing like this additive proximity. Head-to-tail edges may provide other cheap observable neighbors and must be included when testing the full graph.

There is a second exact diagnostic if one proposes separating the terminal block. For its complete-bipartite relaxation alone, all nonzero prefix observables in (17) are positive, and the level-set formula becomes

```math
C_{\mathrm{terminal}}^0(t)
=h_1\int_X^t
\left|\sum_{X\le n\le y}\mu(n)\right|dy. \tag{19}
```

The convention at a single integer $y$ is immaterial. Thus this restricted block still contains an integrated absolute interval-Möbius imbalance. The divisor primitive theorem does not estimate it. Crucially, (19) is **not** a lower bound for the complete relaxation of the full vertex set: outside vertices may pair with terminal vertices. It identifies an obligation for a strategy that separates this block, not a counterexample to the full method.


The prime-switch graph connects squarefree labels $apr$ and $aq$ for three distinct primes, with $a$ coprime to $prq$ and endpoint ratio in $[1/2,2]$. The later [bounded-factor matching theorem](bounded-factor-matching.md) shows that the positive matching-cost strategy on that graph, even after its three-step enlargement, cannot meet the all-epsilon target. The primitive formulas and small-label bound remain valid; the signed aggregate is outside that obstruction.
