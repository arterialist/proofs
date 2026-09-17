# Pointwise tail and spatial means of the actual memory response

This written proof consumes the [compensated kernel](../successor-and-division/charge-compensated-successor-memory.md), its [zero-integral theorem](compensated-memory-integral-conservation.md), the [maximal seed-translation theorem](../successor-and-division/successor-seed-maximal-translation.md), and the [arithmetic clock calibration](../factorial-and-renewal/successor-clock-arithmetic-calibration.md). It concerns the actual causal memory commutator. The short-shift estimate below upgrades its signed tail from a logarithmic-measure statement to an eventual pointwise sign. No anticausal, full bilinear or Weil sign is proved, and no analytic theorem here is formalized in Lean.

We use the transported source norm $\|f\|_{\mathcal E^{\rm phys}}=\|x^{-1/2}f(\log x)\|_{\mathcal E}$. The output space and all integrals below are in physical age.

Let $a(v)=e^{-v/2}(\psi(e^v)-e^v)$, zero below zero. All prime
powers and the initial value $-1$ are retained. The actual relative
charge is $\delta(a)=\kappa>0$. Write
$$
 T=[C,K],\qquad q_0=Ka_0,\qquad d=\delta(Ka).
$$
The bounded kernel theorem and exact zero-integral conservation give
$$
 F:=[S,K]a=Ta+a_0d-\kappa q_0,\qquad
 Ta\in L^1,\qquad \int Ta=0.
 \tag{1}
$$
Equation (1) identifies the response locally. It does not assume separate original-space $L^2$ membership of $Ka$ or $KSa$. The proof below uses the compensated $L^1$ identity.

## The retained port's primitive and constant

The established actual seed expansion is
$$
 B(v)=2/v-4/v^2+O(v^{-3}),
$$
and its [calibrated constant](../factorial-and-renewal/successor-clock-arithmetic-calibration.md) gives the primitive
$$
 \int_0^R B(v)\,dv
 =2\log R+C_B+2\gamma+4/R+O(R^{-2}),
 \quad C_B=-2\log2-2(\gamma-B_1).
 \tag{2}
$$
Here $B_1$ is the prime Mertens constant. To derive the primitive from that calibration, put $\beta(v)=2/(1+v)$ for $v\ge0$. The exact sum rule is $\int(B-\beta)=C_B+2\gamma$. Since $B(v)-\beta(v)=-2/v^2+O(v^{-3})$, subtracting its tail integral from $\int_0^R\beta=2\log(1+R)$ yields (2), including the coefficient $4/R$.

Exponential convolution retains the first two terms accurately:
$$
 q_0(R)=\int_0^R e^{-u/2}B(R-u)\,du
       =4/R+O(R^{-3}).
 \tag{3}
$$
To prove this, split at $u=R/2$. On the first interval,
$$
 B(R-u)=2/R+(2u-4)/R^2+O((1+u)^2/R^3).
$$
The exponential's zeroth and first moments are $2$ and $4$,
so the coefficient of $R^{-2}$ is $2\cdot4-4\cdot2=0$.
The omitted tails of these exponential moments are exponentially
small. On the remaining interval use the boundedness of $B$
and $e^{-u/2}\le e^{-R/4}$.

Tonelli at every finite $R$ gives the exact identity
$$
 \int_0^R q_0(v)\,dv
 =2\int_0^R B(v)\,dv-2q_0(R).
 \tag{4}
$$
Equations (2)--(3) therefore imply
$$
 \int_0^R q_0(v)\,dv
 =4\log R+2C_B+4\gamma+O(R^{-2}).
 \tag{5}
$$
The $R^{-1}$ terms cancel. This uses the complete seed and its
calibrated constant, not a replacement $4/v$ over the initial ages.

Integrating (1), using $\int Ta=0$ and
$\int_0^R a_0=2(1-e^{-R/2})$, proves
$$
 \boxed{\int_0^R [S,K]a(v)\,dv
 =-4\kappa\log R+2\delta(Ka)
   -4\kappa(B_1-\log2)+o(1).}
 \tag{6}
$$
The uncontrolled rate in $o(1)$ is precisely the $L^1$ tail
of $Ta$. No rate is inferred from integrability alone.

## A sign outside a set of finite logarithmic measure

From (1), put $r=Ta+a_0d\in L^1$. Then
$$
 F(v)=-\kappa q_0(v)+r(v).
 \tag{7}
$$
By (3), $q_0(v)\ge c/v$ for all sufficiently large $v$.
On the measurable set where $F(v)\ge0$, (7) forces
$|r(v)|\ge\kappa q_0(v)$.
Consequently
$$
 \boxed{\int_{\{v\ge1:\,F(v)\ge0\}}\frac{dv}{v}<\infty.}
 \tag{8}
$$
Values are understood almost everywhere. Every compact initial
interval contributes a finite amount; the tail follows by comparison
with $\|r\|_1$.

More precisely, for every $\epsilon>0$, (3) and (7) give
$$
 \boxed{\int_{\{v\ge1:\,|vF(v)+4\kappa|\ge\epsilon\}}
        \frac{dv}{v}<\infty.}
 \tag{9}
$$
Choose $R_\epsilon$ so that
$|\kappa vq_0(v)-4\kappa|<\epsilon/2$ above it.
The remaining exceptional set has
$|r(v)|\ge\epsilon/(2v)$, and its logarithmic measure is at most
$2\|r\|_1/\epsilon$.

Thus the actual normalized causal memory response approaches
$-4\kappa$ in logarithmic measure, with finite exceptional measure
at each fixed tolerance. The next argument uses the actual unit-step
source and the full prime seed's global short-shift bound to give a
pointwise rate, including the sampled ages.

## Pointwise successor asymptotic

Put $h=Sa-a$, with the same causal convention as above. For $x=e^u\ge1$,
the exact successor formula gives
$$
 h(u)=x^{-1/2}\left[
       \frac{x}{x+1}\bigl(E(x+1)-E(x)\bigr)
       -\frac{E(x)}{x+1}\right].
 \tag{10}
$$
The interval $(x,x+1]$ contains at most one integer, including its
right endpoint, and its von Mangoldt weight is at most $\log(x+1)$.
Thus $|E(x+1)-E(x)|\le1+\log(x+1)$. Chebyshev's
$|E(x)|\le Cx$ now yields the **pointwise**, integrable estimate
$$
 |h(u)|\le C(1+u)e^{-u/2},\qquad
 \int_0^\infty(1+u)|h(u)|du<\infty.                 \tag{11}
$$
All prime powers, including a power at the right endpoint, are
included in this unit-step bound.

The mass of $h$ is exactly the established positive relative charge:
$$
 \boxed{\int_0^\infty h(u)du=2\delta(a)=2\kappa>0.}  \tag{12}
$$
This equality does not subtract two divergent absolute charges. To
verify it directly, for $R>\log2$ substitute $w=\sigma(u)$ in the
finite integral of $Sa$. With
$A(w)=(1-e^{-w})^{-1/2}$ and the exact relative-charge kernel $k$,
$$
 \int_0^R h(u)du
 =\int_0^R k(w)a(w)dw
  +\int_R^{\sigma(R)}A(w)a(w)dw.
$$
The last interval has length at most $e^{-R}$, while
$|a(w)|\le Ce^{w/2}$, so its integral is $O(e^{-R/2})$.
Both remaining integrals converge absolutely by (11) and the
exponential decay of $k$ above $\log2$. The exact arithmetic formula
for $\kappa>0$, retaining every $\Lambda(p^j)$, is in the
[successor charge proof](../successor-and-division/actual-successor-resonance-charge-cocycle.md).

For each finite $v$, the causal convolutions $Ka(v)$ and $KSa(v)$
exist. Since $Sa=a+h$, their literal commutator is
$$
 F(v)=(S-I)(Ka)(v)-(B*h)(v).                          \tag{13}
$$
The first term is exponentially small despite $a\notin L^1$.
Indeed $|a(u)|\le Ce^{u/2}$, $B(w)\le C/(1+w)$, and hence
$|Ka(w)|\le Ce^{w/2}\log(2+w)$. Let
$\epsilon_v=\sigma(v)-v=\log(1+e^{-v})$, so
$e^{-v}/2\le\epsilon_v\le e^{-v}$. The proved maximal
translation estimate implies
$$
 \int_{\mathbb R}|B(t+\epsilon_v)-B(t)|dt
 \le C\epsilon_v[1+\log\log(e/\epsilon_v)]
 \le Ce^{-v}\log(2+v).
$$
Apply this to the pointwise convolution difference, bounding
$|a(u)|$ only on $0\le u\le\sigma(v)$. Since
$|j(v)-1|\le Ce^{-v}$, it gives
$$
 |(S-I)(Ka)(v)|
 \le C e^{-v/2}\log(2+v).                            \tag{14}
$$
The causal extension of $B$ to negative ages makes this identity
valid even at a prime-power jump; no endpoint term was dropped.

The complete-seed asymptotic
$B(t)=2/t+O(t^{-2})$, together with the global bound on $B$ and
the exponential moment (11), gives the standard convolution tail
$$
 (B*h)(v)=\frac2v\int_0^\infty h(u)du+O(v^{-2})
          =\frac{4\kappa}{v}+O(v^{-2}).                 \tag{15}
$$
For clarity, split at $u=v/2$. On $u\le v/2$,
$B(v-u)=2/v+O((1+u)/v^2)$ uniformly. On $u>v/2$,
the boundedness of $B$ and (11) make the contribution exponentially
small; the same tail estimate permits replacing the truncated mass
of $h$ by its full mass. Combining (13)--(15) proves the new
unconditional, all-real-age signed bound
$$
 \boxed{[S,K]a(v)=-\frac{4\kappa}{v}+O(v^{-2})
        \quad(v\to\infty).}                            \tag{16}
$$
In particular $[S,K]a(v)<0$ for every sufficiently large real $v$,
including ages of integer and prime-power births. The assertion is
pointwise for the stated right-continuous arithmetic source, not only
almost everywhere. Equation (16) also improves the $o(1)$ remainder
in the spatial primitive (6) to $O(R^{-1})$.

The compensation identity (1) and $q_0(v)=4/v+O(v^{-3})$ from (3)
give the additional pointwise consequence for the locally identified
representative of the compensated response:
$$
 \boxed{Ta(v)=O(v^{-2}).}                              \tag{17}
$$
This is stronger than the earlier $L^1$ assertion for this particular
actual source. It does not assert such a rate on the whole source
energy unit ball.

The proof uses Chebyshev's $\psi(x)\ll x$, the exact unit-step bound,
the unconditional complete-seed tail and maximal translation
estimates, and $\kappa>0$; no RH-scale estimate for $E$ enters.
An off-line-zero-type fluctuation $x^\beta\cos(t\log x)$ with
$1/2<\beta<1$ still has size $O(x)$ and a unit-step increment
$O_{\beta,t}(x^{\beta-1})$. Thus those two size inputs alone cannot
exclude such a fluctuation. Equation (16) is a signed **causal**
response law, not a sign for the anticausal channel, the full Weil
quadratic form, or a proof of RH. The available unconditional
prime-error frontier remains the Vinogradov--Korobov-scale bound
recorded in the [pointwise cofactor proof](../goldbach/goldbach-cofactor-short-interval-vk-gain.md#inputs-and-a-uniform-interval-estimate),
which is far weaker than an RH-scale estimate. No literature-priority
claim is made for this causal specialization.
