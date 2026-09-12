# Two-order cancellation with the actual divisor remainder retained

Let $h=1-r$, $\ell=\log(1/h)$, and use the actual kernels
$$
 L(t)=\sum_{k\ge1}\mu(k)K(kt),\qquad
 J(t)=\sum_{k\ge1}\mu(k)E_1(kt).
 \tag{1}
$$
The [checked moment theorem](successor-division-kernel-moments.md)
proves $\int L=\int L\log t=0$, and the
[linear-exterior theorem](successor-feedback-linear-inverse-core.md)
provides a fixed $T$ beyond which the actual inverse coefficients
are positive for small $h$. We quantify the cancellation between
that exterior and its complementary actual core. The remaining
signed arithmetic term is displayed explicitly.

## 1. The endpoint kernel has the complementary logarithmic moment

The same weighted $L^1$ Abel-summation argument used for $L$
applies to $J$. Indeed $E_1(t)=O(1+|\log t|)$ at zero,
$E_1'(t)=-e^{-t}/t$, and both
$|E_1(t)|$ and $t|E_1'(t)|$ have every finite logarithmic moment.
The unconditional bound
$|M_\mu(x)|\ll x\exp(-c\sqrt{\log x})$ therefore proves convergence
of finite Möbius sums in all these weighted $L^1$ norms.

Since $\int E_1=1$, and using the boundary sums
$\sum\mu(k)/k=0$, $\sum\mu(k)\log k/k=-1$, it follows that
$$
 \boxed{\int_0^\infty J(t)\,dt=0,\qquad
 \int_0^\infty J(t)\log t\,dt=1.}
 \tag{2}
$$
Thus the actual correction $-hE_1$, after division inversion and
logarithmic readout, has a nonzero limiting contribution $-1$.
Its first moment is not annihilated along with those of $L$.

## 2. Exact discrete seed identities

For each fixed $h>0$, define
$$
 A_h=h\sum_{m\ge1}L(hm),\qquad
 B_h=h\sum_{m\ge1}L(hm)\log(hm).
 \tag{3}
$$
These sums converge absolutely, as do their divisor rearrangements:
for large $n$, $|K(hn)|\ll_h n^{-3/2}$, and the divisor and
logarithm factors remain summable against that power.
The full arithmetic identity $\sum_{k\mid n}\mu(k)=\mathbf1_{n=1}$
gives the particularly useful exact equality
$$
 \boxed{A_h=hK(h).}
 \tag{4}
$$
The density quadrature defect is therefore the retained seed,
not an arbitrary error that must be bounded by a Mertens estimate.
The second divisor identity gives
$$
 \begin{aligned}
 B_h+\ell A_h
 &=h\sum_{m\ge1}L(hm)\log m\\
 &=h\sum_{n\ge2}K(hn)
       \sum_{m\mid n}\mu(n/m)\log m\\
 &=h\sum_{n\ge2}\Lambda(n)K(hn).
 \end{aligned}
 \tag{5}
$$
No absolute-value bound replaces the signed cofactor combination.
Likewise
$$
 h\sum_{m\ge1}J(hm)\log m
 =h\sum_{n\ge2}\Lambda(n)E_1(hn)=I_h,
 \tag{6}
$$
where $I_h=1+o(1)$, with the quantitative PNT error proved in the
[scaling source](successor-feedback-kernel-scaling.md).

Combining (5)--(6) with that source's actual $\Lambda$-weighted
error estimate yields
$$
 \boxed{E(1-h)=h^{-1/2}[B_h+\ell hK(h)]-I_h+O(\sqrt h).}
 \tag{7}
$$
The error $O(\sqrt h)$ is obtained after the exact arithmetic
regrouping. It is not asserted for an unsigned double divisor sum.
Since
$K(h)=-h^{-1/2}+\pi^{3/2}/2+O(\sqrt h)$, this also reads
$$
 E(1-h)=h^{-1/2}B_h-\ell-I_h+O(\sqrt h(1+\ell)).
 \tag{8}
$$
Both the logarithmic seed term and the endpoint constant are retained.

## 3. Core and exterior at their two leading orders

Fix $T>0$, put $M_h=\lceil T/h\rceil$, and define finite constants
$$
 a_T=\int_T^\infty L(t)\,dt,\qquad
 b_T=\int_T^\infty L(t)\log t\,dt,
$$
$$
 c_T=\int_T^\infty J(t)\,dt,\qquad
 d_T=\int_T^\infty J(t)\log t\,dt.
 \tag{9}
$$
The uniform coefficient estimate, summed over all multiples of $m$,
gives on $hm\ge T$
$\varphi_{1-h}(m)=\sqrt hL(hm)-hJ(hm)+R_h(hm)$.
Its error has logarithm-weighted sum
$O_T(\sqrt h(1+\ell))$ over $m\ge M_h$.
The kernels and their derivatives are integrable on $[T,\infty)$,
also with a logarithm. Hence the ordinary rectangle rule, including
the strip between $T$ and $hM_h$, proves
$$
 \boxed{\mathcal L_{\rm ext}(h)
 =h^{-1/2}(\ell a_T+b_T)-\ell c_T-d_T
 +O_T(\sqrt h(1+\ell)).}
 \tag{10}
$$
For $T$ from the positive-exterior theorem, $a_T>0$.
In particular the $h^{-1/2}\ell$ coefficient here is an exact
integral of the actual inverted scaling kernel.

Using the exact total instead of an unjustified Riemann limit at
zero gives the complementary formula
$$
 \boxed{\begin{aligned}
 \mathcal L_{\rm core}(h)
 ={}&-h^{-1/2}(\ell a_T+b_T)+\ell c_T+d_T-I_h\\
 &+h^{-1/2}[B_h+\ell hK(h)]
 +O_T(\sqrt h(1+\ell)).
 \end{aligned}}
 \tag{11}
$$
In particular, ordinary PNT gives $E(1-h)=o(h^{-1/2})$, so
$$
 \mathcal L_{\rm core}(h)
 =-h^{-1/2}(\ell a_T+b_T)+o(h^{-1/2}).
 \tag{12}
$$
Thus both leading orders cancel between the actual core and exterior.
Formula (11), rather than only (12), records what survives below
those orders, including the complete endpoint kernel.

## 4. What an unconditional estimate does and does not control

The existing classical Mertens bound gives a quantitative estimate
on the unknown logarithmic quadrature defect. For some $c_1>0$,
$$
 |L(t)|+t|L'(t)|
 \le Ct^{-1}\exp(-c_1\sqrt{\log(1/t)})
 \quad(0<t\le e^{-2}).
 \tag{13}
$$
For completeness, Abel summation gives
$$
 L(t)=-\int_t^\infty M_\mu(u/t)K'(u)\,du.
 \tag{14}
$$
The differentiated expression replaces $K'$ by
$K'+uK''$ when bounding $tL'$.
Both $u|K'(u)|$ and
$u|K'(u)+uK''(u)|$ are integrable: at zero their order is
$u^{-1/2}$, and at infinity it is $u^{-3/2}$.
Split at $u=\sqrt t$. On the lower interval the elementary
bound $|M_\mu(x)|\le x$ gives $O(t^{-3/4})$.
On the upper interval the Mertens exponential is at most
$\exp(-c\sqrt{\log(1/t)/2})$. This proves (13), after reducing
the positive constant. The required differentiated estimates on $K$
follow directly from its Dawson expression, or from the differentiated
large-$t$ expansion.

Apply the rectangle rule to $L(t)\log t$, treating $(0,h)$
separately. Bound the omitted integral using
$\int_{\ell}^{\infty}v e^{-c_1\sqrt v}dv$.
For the derivative integral over $[h,1]$, split once more at
$\sqrt h$. The tail beyond one is harmless.
There are absolute constants $C,c_2>0$ such that
$$
 \boxed{|B_h|\le C(1+\ell)^2e^{-c_2\sqrt\ell}.}
 \tag{15}
$$
This is a genuine unconditional bound, sufficient for the leading
two-order cancellation. It is not small enough for a bounded final
sign margin in (8): after multiplication by $h^{-1/2}$, its
allowed size tends to infinity. It provides no one-sided comparison
between $B_h$ and the explicit scale
$\sqrt h(\ell+I_h)$.

The remaining term is thus a specified signed logarithmic
quadrature defect of the actual Möbius/cofactor kernel, with its
seed removed exactly in (7). No RH-strength estimate has been used,
and the available unconditional estimate does not control its
negative part below a fixed positive margin. This last statement
describes the scope of the proved bound; it does not rule out
a stronger arithmetic comparison.

The derivative estimate can be obtained without differentiating the step function $M_\mu$: differentiate $L(t)=-t\int_1^\infty M_\mu(x)K'(xt)\,dx$ under the absolutely convergent integral and then substitute $u=xt$. This yields the kernel $K'(u)+uK''(u)$ used in (13).

The Mertens input is the classical zero-free-region estimate, with a quantitative primary version in [Lee–Leong, Theorem 1.1](https://arxiv.org/abs/2208.06141), as used in the linked weighted-moment proof. The exact discrete identities and their retained endpoint are written proofs, not Lean formalizations. The [fixed-exponent curved comparison](successor-division-curved-log-comparison.md) provides a positive different readout without determining the sign in (8).

The [quadratic logarithmic endpoint](successor-division-quadratic-log-readout.md) has unconditional normalized limit $\pi^{3/2}$, using the classical full Selberg weight. The distinct [coherent lattice identity](actual-coherent-division-lattice-remainder.md), [mean-removal refinement](actual-coherent-successor-quadrature-refinement.md) and [dual cosine/centered ODE proof](actual-division-lattice-dual-cosine.md) retain the entire physical correction, fractional cell and periodic curvature. The signed first-logarithm comparison remains unproved.
