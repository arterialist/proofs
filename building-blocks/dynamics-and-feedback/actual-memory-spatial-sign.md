# Spatial means and logarithmic exceptional sets for the actual memory response

This written proof consumes the [compensated kernel](../successor-and-division/charge-compensated-successor-memory.md), its [zero-integral theorem](compensated-memory-integral-conservation.md), and the [arithmetic clock calibration](../factorial-and-renewal/successor-clock-arithmetic-calibration.md). It concerns the actual causal memory commutator. No anticausal, full bilinear, sampled-birth or Weil sign is proved, and no analytic theorem here is formalized in Lean.

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
$-4\kappa$ in logarithmic measure, with the stronger finite
exceptional-measure statement at each fixed tolerance. This is
not pointwise convergence or eventual pointwise negativity. It does
not give signs at sampled integer or prime births: a countable set
can be contained in the exceptional set.
