# The actual compensated-successor primitive

Let
$$
a(u)=e^{-u/2}[\psi(e^u)-e^u],\quad u\ge0,
 \qquad a(u)=0\quad(u<0).
$$
Every prime power is included in ψ. The exact initial history is $a(u)=-e^{u/2}$ for $0\le u<\ell=\log2$. Use the actual causal successor and compensation
$$
(Sa)(v)=\sqrt{\frac{e^v}{e^v+1}}\,a(\sigma(v)),
 \quad \sigma(v)=\log(e^v+1),\quad
 C=S-a_0\delta,
 \quad a_0(v)=e^{-v/2}1_{v\ge0}.
$$
The [established arithmetic relative charge](actual-successor-resonance-charge-cocycle.md) is $\delta(a)=\kappa>0$, with
$$
2\kappa=-\int_0^\ell a(u)du+
              \int_\ell^\infty k_+(u)a(u)du,
 \qquad k_+(u)=(1-e^{-u})^{-1/2}-1.
 \tag{1}
$$
The causal L¹ primitive convention in [the finite-transport theorem](compensated-successor-finite-transport.md) is
$$
J(v)=(\mathcal Ja)(v)=\int_0^v[(C-I)a](t)dt,
 \quad v\ge0,\qquad J(v)=0\quad(v<0).
 \tag{2}
$$
The general finite-transport theorem is not reproved here. The formulas below derive this actual primitive directly and prove its asymptotic and strict positivity at every positive age. The global sign uses a uniform published PNT bound and a rigorous finite check of 22 arithmetic cells; it is not inferred from numerical sampling.

## 1. Exact initial interval and cumulative identity

Changing variables u=σ(t) in the literal successor gives, for every v≥0,
$$
J(v)=\int_\ell^{\sigma(v)}(1+k_+(u))a(u)du
       -\int_0^v a(u)du-2\kappa(1-e^{-v/2}).
 \tag{3}
$$
This formula keeps the removed input interval [0,log 2) explicitly. All integrals except the relative-charge tail in (1) are over bounded intervals; that tail is absolutely convergent.

Use the elementary identity
$$
\int_\ell^{\sigma(v)}a-\int_0^v a
 =\int_v^{\sigma(v)}a-\int_0^\ell a
$$
and then (1). This yields
$$
\boxed{J(v)=2\kappa e^{-v/2}
       +\int_v^{\sigma(v)}a(u)du
       -\int_{\sigma(v)}^\infty k_+(u)a(u)du.}
 \tag{4}
$$
In fact (4) holds for all v≥0, not only v≥log 2. Its tail begins at σ(v)≥log 2, so it never uses the positive-branch expression for k on the removed initial interval. At v=0, equation (1) makes the right side exactly zero. Thus the endpoint and the integration constant agree with (2).

## 2. Bounded PNT tail and eventual strict positivity

Suppose the unconditional PNT estimate is written
$$
|a(u)|\le C_0e^{u/2-c\sqrt u}\quad(u\ge u_0).
 \tag{5}
$$
For v≥u_0, use $\sigma(v)-v\le e^{-v}$ and
$e^{\sigma(v)/2}\le\sqrt2e^{v/2}$. The short interval in (4) is bounded by
$$
\left|\int_v^{\sigma(v)}a\right|
 \le\sqrt2 C_0e^{-v/2-c\sqrt v}.
$$
For u≥log 2, rationalization gives
$$
0<k_+(u)\le2(\sqrt2-1)e^{-u}.
$$
The infinite tail in (4) is therefore bounded by
$$
\begin{aligned}
 \int_{\sigma(v)}^\infty k_+(u)|a(u)|du
 &\le2(\sqrt2-1)C_0
       \int_{\sigma(v)}^\infty e^{-u/2-c\sqrt u}du\\
 &\le4(\sqrt2-1)C_0e^{-v/2-c\sqrt v}.
 \end{aligned}
$$
Consequently the explicit error bound is
$$
\boxed{|J(v)-2\kappa e^{-v/2}|
 \le C_0(5\sqrt2-4)e^{-v/2-c\sqrt v}\quad(v\ge u_0).}
 \tag{6}
$$
In particular
$$
J(v)=2\kappa e^{-v/2}
       +O(e^{-v/2-c\sqrt v}),
$$
and J is strictly positive for all sufficiently large ages. Only the actual PNT remainder and the exact retained charge are used.

An explicit range follows from [Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689), which gives, for x≥23,
$$
|\psi(x)-x|\le x\sqrt{\frac8{17\pi}}\,z^{1/2}e^{-z},
 \qquad z=\sqrt{\frac{\log x}{6.455}}.
$$
Since $z^{1/2}e^{-z/2}\le e^{-1/2}$, (5) holds with
$$
u_0=\log23,\qquad
 C_0=\sqrt{\frac8{17\pi e}},\qquad
 c=\frac1{2\sqrt{6.455}}.
 \tag{7}
$$
The rigorous finite computation below gives $\kappa>2789/10000$ and verifies
$$
C_0(5\sqrt2-4)e^{-5c}<2789/10000.
$$
As a result,
$$
\boxed{J(v)\ge\kappa e^{-v/2}>0\qquad(v\ge25).}
 \tag{8}
$$
The PNT bound applies to all real x in its stated range; jumps of ψ at prime powers do not require any endpoint deletion.

## 3. Exact arithmetic cells for a bounded sign test

Put F(x)=J(log x) for x≥1. On each open interval n<x<n+1, direct substitution of ψ into the derivative of (3) gives
$$
\boxed{F'(x)=\frac{\psi(n+1)}{\sqrt x(x+1)}
              -\frac{\psi(n)+\kappa}{x^{3/2}}
 =\frac{x\Lambda(n+1)-\psi(n)-\kappa(x+1)}
        {x^{3/2}(x+1)}.}
 \tag{9}
$$
Thus its sign on a cell is decided by an affine function of x. F is continuous at the integer endpoints. For n≤a≤b≤n+1 the exact finite increment is
$$
\boxed{F(b)-F(a)
 =2\psi(n+1)(\arctan\sqrt b-\arctan\sqrt a)
  +2(\psi(n)+\kappa)(b^{-1/2}-a^{-1/2}).}
 \tag{10}
$$
Start from F(1)=0. These formulas retain both ends of every cell; in particular the n=3 cell uses the proper-power arrival $\Lambda(4)=\log2$, and the n=5 cell uses $\Lambda(6)=0$.

Here is the rigorous bounded test on the whole interval 1≤x≤23. The enclosure
$$
2789/10000<\kappa<279/1000
 \tag{11}
$$
first gives a transparent check through the proper power 4 and composite 6: the numerator in (9) is positive on (1,2), (2,3), and (4,5), and negative on (3,4) and (5,6). For example the increasing affine numerator on (3,4) has upper endpoint
$$
4\log2-\log6-5\kappa<0.
$$
The positive cells are checked at their left endpoints; their slopes are positive. On (5,6) both nonzero terms in the numerator are negative.

Formula (10), using the rational upper bound 279/1000 for κ, proves
$$
F(4)>1/10,\qquad F(6)>1/10.
$$
More generally, substitute the fixed rational upper bound $\bar\kappa=279/1000$ throughout (9)--(10), and call the resulting function $F_{\bar\kappa}$. For every real x>1,
$$
F(x)=F_{\kappa}(x)
 =F_{\bar\kappa}(x)+2(\bar\kappa-\kappa)(1-x^{-1/2})
 >F_{\bar\kappa}(x).
$$
Thus this is a pointwise lower function on every cell, not merely a substitution at sampled endpoints. In a cell with $\Lambda(n+1)=0$, its derivative is negative. Every other cell has an increasing affine derivative numerator, because $\Lambda(n+1)\ge\log2>\bar\kappa$. Its minimum is therefore at an endpoint or at the unique stationary point
$$
x_*=(\psi(n)+\bar\kappa)/(\Lambda(n+1)-\bar\kappa)
$$
when this point lies inside the cell. The accompanying script checks these alternatives for exactly n=1,...,22, using all prime powers up to 23. The only interior stationary minimum is in (8,9); its x-coordinate lies between 8.55575 and 8.55576 and its function value exceeds 0.14965. All cell minima for 2≤x≤23 exceed 1/25. The first cell increases strictly from zero. Consequently
$$
\boxed{J(0)=0,\qquad J(v)>0\quad(0<v\le\log23).}
 \tag{12}
$$

## 4. Rigorous numerical enclosure and its exact tail

The accompanying [actual-source-successor-primitive.py](certificates/actual-source-successor-primitive.py) uses python-flint's Arb balls at 192-bit precision. It is a bounded numerical certificate for the finite inequalities used here, not a Lean proof or a numerical sweep over unbounded ages.

The actual positive charge series is
$$
\kappa=\sum_{k\ge1}
 \frac{\binom{2k}{k}}{4^k(2k+1)}
       \left[-\frac{\zeta'}{\zeta}(k+1/2)\right].
$$
The script evaluates only k=1,...,12. Arb's first Taylor coefficient of ζ gives its derivative at these real arguments, all strictly greater than one. The omitted positive tail is bounded analytically, without a numerical prime cutoff. For s≥3/2, the decreasing function $\log x\,x^{-s}$ on x≥2 gives
$$
-\frac{\zeta'}{\zeta}(s)
 =\sum_n\frac{\Lambda(n)}{n^s}
 \le\sum_{n\ge2}\frac{\log n}{n^s}
 \le2^{-s}\left[\log2+\frac{2\log2}{s-1}
                         +\frac2{(s-1)^2}\right].
$$
For K=12, set
$$
C_K=\log2+\frac{2\log2}{K+1/2}+\frac2{(K+1/2)^2}.
$$
Since $\binom{2k}{k}/4^k\le1$, the full omitted charge satisfies
$$
0<\kappa-\kappa_K
 \le\frac{C_K\,2^{-K-1/2}}{2K+3}.
 \tag{13}
$$
The evaluated partial sum is between 0.2789338073892378 and 0.2789338073892379, and the rigorous tail bound is less than 0.000005223. The script checks (11) directly as ball inequalities. It then checks the finite logarithm/arctangent inequalities at all cell extrema through x=23, and the explicit PNT comparisons at v=25 and x=23. No floating-point value is substituted for an unbounded arithmetic tail.

## 5. Positive prime kernel and exact error-kernel mass

There is an exact finite prime-power kernel behind the cell calculation. Put
$$
A(z)=\arcsin(z^{-1/2})\quad(z\ge1),\qquad
 d(n)=A(n)-n^{-1/2},\qquad
 e(x)=x^{-1/2}-\arctan(x^{-1/2})>0.
$$
For n≥2 define
$$
W_x(n)=2[A(n)-A(x+1)]_+
       -2[n^{-1/2}-x^{-1/2}]_+.
$$
If n≤x, then $W_x(n)=2[d(n)+e(x)]>0$. If x<n≤x+1, only the first nonnegative term remains; if n>x+1 the kernel is zero. Integrating (9) before summing the arrivals therefore gives
$$
\boxed{F(x)=\sum_{2\le n\le x+1}\Lambda(n)W_x(n)
             -2\kappa(1-x^{-1/2}),\qquad W_x(n)\ge0.}
 \tag{14}
$$
All proper powers and the successor endpoint x+1 remain. Nonnegativity of this finite kernel alone does not compare the sum to the subtracted charge. Old weights need not increase with x, so no monotone-floor-sum conclusion is imposed.

The decisive uniform comparison comes from the exact positive error kernels in (4). Writing $E(y)=\psi(y)-y$ gives
$$
F(x)-\frac{2\kappa}{\sqrt x}
 =\int_x^{x+1}\frac{E(y)}{y^{3/2}}dy
 -\int_{x+1}^\infty E(y)
       \left[\frac1{y\sqrt{y-1}}-\frac1{y^{3/2}}\right]dy.
 \tag{15}
$$
Suppose $|E(y)|\le\epsilon y$ for all y≥x. The two absolute-value majorants have exactly equal integrals:
$$
\int_x^{x+1}y^{-1/2}dy
 =\int_{x+1}^\infty[(y-1)^{-1/2}-y^{-1/2}]dy
 =2(\sqrt{x+1}-\sqrt x).
$$
Consequently
$$
\boxed{\left|F(x)-\frac{2\kappa}{\sqrt x}\right|
 \le4\epsilon(\sqrt{x+1}-\sqrt x)
 <\frac{2\epsilon}{\sqrt x}.}
 \tag{16}
$$
This improves the coarse constants in (6) by integrating the actual kernels rather than estimating them separately by exponentials.

The explicit Trudgian relative bound is
$$
\epsilon_0(y)=\sqrt{\frac8{17\pi}}\,z_y^{1/2}e^{-z_y},
 \qquad z_y=\sqrt{\log y/6.455}.
$$
For y≥23, $z_y\ge z_{23}>1/2$, and $z^{1/2}e^{-z}$ is decreasing there. Thus the published theorem supplies the simultaneous bound
$$
|E(y)|\le\epsilon_0(23)y\quad\text{for every real }y\ge23.
$$
The rigorous calculation gives $\epsilon_0(23)<162/1000$ (its enclosed value is approximately 0.1609400853). Combining this with (11) and (16) proves
$$
\boxed{F(x)>\frac1{5\sqrt x}>0\qquad(x\ge23).}
 \tag{17}
$$
This is an all-real-x tail theorem, not a finite check or an asymptotic with an unspecified starting point. Equations (12) and (17) now cover every x>1:
$$
\boxed{\mathcal Ja(0)=0,\qquad \mathcal Ja(v)>0
       \quad\text{for every real }v>0.}
 \tag{18}
$$
The exponentially decaying asymptotic (6) is retained. The global primitive sign is a property of the actual compensated-successor transport and its fixed relative charge. It does not imply positivity of the original Weil form, its anticausal half, or an arbitrary quadratic readout.


The actual all-age sign uses classical explicit PNT estimates and finite interval arithmetic. It is a written computer-assisted theorem, distinct from the [formal relative-charge bound](actual-successor-resonance-charge-cocycle.md#formalized-relative-charge-at-finite-mixed-energy). The [W comparison](actual-W-positive-primitive-analysis.md) retains both its cumulative consequence and the pointwise oscillation of the resulting difference. No priority claim is made.
