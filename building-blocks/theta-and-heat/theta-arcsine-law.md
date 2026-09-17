# The actual theta kernel as an arcsine scale mixture

The positive density underlying the Riemann xi function has a unique positive arcsine scale mixture. Its mixing law can be recovered explicitly and has a double-exponential tail. This identifies the only possible Bernstein exponent in the associated van Dantzig construction; it does not prove that the candidate is a Bernstein function.

Use the normalization

```math
\Phi(u)=\sum_{n\ge1}
(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2})e^{-\pi n^2e^{2u}},
\qquad \Xi(z)=\int_{\mathbb R}\Phi(u)e^{izu}\,du,
```

```math
Z=\int_{\mathbb R}\Phi(u)\,du,
\qquad M(q)=2\int_0^\infty u^q\Phi(u)\,du\quad(\Re q>-1).
```

The classical theta identities make $\Phi$ even, strictly positive, and strictly decreasing for $u>0$, with $\Phi'(0)=0$ and superexponential decay. Our normalization is twice the kernel of Csordas evaluated at half the argument: $\Phi_C(v)=\Phi(2v)/2$; see [Csordas, *Convexity and the Riemann xi-function*, equation (1.2)](https://web.math.pmf.unizg.hr/glasnik/33.1/33105.pdf).

## The positive mixing law

Let $U$ have density $\Phi/Z$. There is exactly one law of $I\ge0$ such that

```math
U\overset d=2\sqrt I\,\varepsilon\sqrt B,
\qquad B\sim\operatorname{Beta}(1/2,1/2),
```

where $I,B$, and the symmetric sign $\varepsilon$ are independent. It has no atom at zero and has density and survival function

```math
f_I(t)=-\frac4Z\int_{2\sqrt t}^{\infty}
\frac{\Phi'(u)}{\sqrt{u^2-4t}}\,du>0,
```

```math
\mathbb P(I>t)=\frac2Z\int_{2\sqrt t}^{\infty}
\frac{u\Phi(u)}{\sqrt{u^2-4t}}\,du,
\qquad t\ge0.
```

To prove this, condition on $I=t$. The conditional density of $U$ is
$1_{|u|<2\sqrt t}/(\pi\sqrt{4t-u^2})$.
Writing $g(v)=\Phi(2\sqrt v)/Z$, the desired equation becomes

```math
g(v)=\frac1{2\pi}\int_v^\infty\frac{f_I(t)}{\sqrt{t-v}}\,dt.
```

Apply the right Abel integral again. Tonelli's theorem and
$\int_t^w((v-t)(w-v))^{-1/2}\,dv=\pi$ give

```math
\mathbb P(I>t)=2\int_t^\infty\frac{g(v)}{\sqrt{v-t}}\,dv.
```

The last expression equals the displayed survival function and is one at zero. Differentiating after replacing $v$ by $t+w$ gives the density formula. Its positivity, integrability and vanishing survival at infinity follow from the stated kernel properties. Applying the Abel operator twice also proves uniqueness, including among general positive mixing measures; an atom at zero would create an atom of $U$.

The construction is classical Abel inversion applied to this density, not a new inversion theorem. The arcsine factor is the $\theta=0$ case of [Konstantopoulos–Patie–Sarkar, Lemma 5.8](https://www.numdam.org/item/10.5802/aif.3600.pdf).

## Mellin recurrence and the uniquely forced candidate

For real $s>-1$, Tonelli and a beta integral give

```math
H(s):=\mathbb E I^s
=-\frac{4^{-s}}Z B(s+1,1/2)
\int_0^\infty u^{2s+1}\Phi'(u)\,du.
```

In particular $f_I(0)=-4Z^{-1}\int_0^\infty\Phi'(u)/u\,du>0$, so the negative-moment endpoint is exactly $s=-1$. Integration by parts yields, for $\Re s>-1/2$,

```math
H(s)=\frac{\sqrt\pi\Gamma(s+1)M(2s)}{4^s\Gamma(s+1/2)Z}.
```

Define the positive real-analytic function

```math
\phi_{\rm nat}(s)=
-4\frac{\int_0^\infty u^{2s-1}\Phi'(u)\,du}{M(2s)},
\qquad s>-1/2.
```

Then $H(s)/H(s-1)=s/\phi_{\rm nat}(s)$ for every real $s>0$. At positive integers, the necessary exponent values for the normalized xi coefficients are therefore

```math
\Psi(n)=n\phi_{\rm nat}(n)
=(2n)(2n-1)\frac{M(2n-2)}{M(2n)}.
```

These integer conditions have the following exact strengthening. In the notation of Konstantopoulos–Patie–Sarkar,

```math
\frac{\Xi}{Z}=\mathcal J_\Psi\text{ for some }\Psi\in N_D
\quad\Longleftrightarrow\quad \phi_{\rm nat}\in B_J.
```

If such an exponent exists, it is uniquely $\Psi(s)=s\phi_{\rm nat}(s)$, its killing is zero, and its largest nonnegative root is zero. Here $B_J$ means the Bernstein functions with nonnegative nonincreasing Lévy density, not all Bernstein functions.

Indeed, write the factorization in that paper as $\Psi(s)=(s-\theta)\phi(s)$, $0\le\theta\le1/2$. Its characteristic law is
$\sqrt{I_\phi}J_\theta$, where

```math
\mathbb E|J_\theta|^{2s}
=\frac{4^s\Gamma(s+1/2)\Gamma(1-\theta)}
{\sqrt\pi\Gamma(s+1-\theta)}.
```

At $\theta=1/2$, this is interpreted as the law supported at $\{-2,2\}$. The subordinator exponential functional satisfies
$\mathbb E I_\phi^s=s\mathbb E I_\phi^{s-1}/\phi(s)$ for $s>0$. For completeness, write its remaining integral after time $t$ as $A_t$ and use the pathwise identity $I^s=s\int e^{-Z_t}A_t^{s-1}\,dt$. The independent remaining process and Tonelli give the formula. Finite integer moments imply the needed positive moments; the same identity then gives the negative moment in the denominator. This is the standard exponential-functional recurrence; see [Patie–Savov](https://arxiv.org/abs/1604.05960).

The even moments of $\sqrt{I_\phi}J_\theta$ are $(2n)!/\prod_{j=1}^n\Psi(j)$. The actual theta law is moment determinate, since it has every exponential moment. Equality of coefficients therefore identifies the two laws. Taking their fractional moment ratios for $s>1/2$ gives $\Psi(s)=s\phi_{\rm nat}(s)$. Cross-multiplication by $M(2s)$ makes this a holomorphic identity on $\Re s>0$, without assuming that $M$ has no complex zeros. On the positive real axis it holds everywhere, and its limit at zero gives zero killing and $\Psi'(0)=\phi_{\rm nat}(0)>0$. Positivity for $s>0$ forces $\theta=0$. Proposition 5.2 of Konstantopoulos–Patie–Sarkar now identifies the factor class as $B_J$. Conversely, if $\phi_{\rm nat}\in B_J$, that proposition gives $s\phi_{\rm nat}\in N_D$, and the integer recurrence identifies all entire-series coefficients.

This equivalence leaves the membership assertion unproved. In particular, ordinary Bernstein membership alone cannot replace $B_J$: for $\phi(s)=1-e^{-s}$, the second derivative of $s\phi(s)$ equals $(2-s)e^{-s}$ and becomes negative.

## Exact tail and an exclusion of additive infinite divisibility

As $t\to\infty$,

```math
f_I(t)\sim\frac{8\sqrt2\pi^3}{Z}t^{-1/4}
\exp\!\left(11\sqrt t-\pi e^{4\sqrt t}\right),
```

```math
\mathbb P(I>t)\sim\frac{4\sqrt2\pi^2}{Z}t^{1/4}
\exp\!\left(7\sqrt t-\pi e^{4\sqrt t}\right).
```

Here are the endpoint estimates fixing the constants. Put $a=2\sqrt t$ and $\lambda=2\pi e^{2a}$. The full theta series gives, uniformly for $u\ge a$,

```math
\Phi(u)=4\pi^2e^{9u/2-\pi e^{2u}}(1+O(e^{-2u})),
\qquad
-\Phi'(u)=8\pi^3e^{13u/2-\pi e^{2u}}(1+O(e^{-2u})).
```

Terms with $n\ge2$ are exponentially smaller than the first term. Substitute $u=a+v/\lambda$ in the two Abel integrals. The normalized kernel ratio tends to $e^{-v}$, and the square-root denominator contributes $\sqrt{2av/\lambda}$. The ratios are dominated by $Ce^{-v/2}v^{-1/2}$, with an additional harmless factor $1+v$ in the survival integral: use $e^{2v/\lambda}-1\ge2v/\lambda$ to dominate the exponential. Dominated convergence and $\Gamma(1/2)=\sqrt\pi$ give

```math
f_I(t)\sim\frac{4\sqrt\pi\Phi(a)\sqrt\lambda}{Z\sqrt{2a}},
\qquad
\mathbb P(I>t)\sim\frac{\sqrt{2\pi a}\Phi(a)}{Z\sqrt\lambda},
```

which simplify to the constants above.

The mixing law is not additively infinitely divisible. A nondegenerate infinitely divisible law supported on $[0,\infty)$ has a nonzero Lévy measure. For some $\delta>0$, the jumps of size at least $\delta$ have finite positive intensity $m$; their contribution stochastically dominates $\delta P$, with $P$ Poisson of mean $m$. Consequently, for $k=\lfloor t/\delta\rfloor+1$,

```math
\mathbb P(I>t)\ge e^{-m}\frac{m^k}{k!}
\ge e^{-m}(m/k)^k.
```

Its negative logarithm is $O(t\log t)$, contrary to the proved tail. A zero Lévy measure would make the law a point mass, contrary to its positive density. This standard Poisson-jump argument excludes additive infinite divisibility of $I$ only; it does not exclude an exponential-functional representation or infinite divisibility of $\log I$.

The same tail determines the leading moment scale:

```math
H(s)^{1/s}\sim\frac{(\log s)^2}{16},\qquad
\frac{H(s)}{H(s-1)}\sim\frac{(\log s)^2}{16},
\qquad
\phi_{\rm nat}(s)\sim\frac{16s}{(\log s)^2}.
```

For the first limit, the lower bound uses $I\ge(1-\epsilon)^2(\log s)^2/16$, whose survival logarithm is $-O(s^{1-\epsilon})=o(s)$. For the upper bound, split the moment integral at $b=(1+\epsilon)^2(\log s)^2/16$. Beyond $b$ use $\mathbb P(I>t)\le C\exp[-c e^{4\sqrt t}]$ and the tangent bound for the eventually convex function $e^{4\sqrt t}$. The resulting integral is at most
$Cs b^{s-1}e^{-c e^{4\sqrt b}}/(c(e^{4\sqrt t})'|_{t=b}-(s-1)/b)$, hence negligible compared with $b^s$. Let $\epsilon\downarrow0$. For the ratio, convexity of $h(s)=\log H(s)$ bounds $h'(s)$ between its secants on $[s/2,s]$ and $[s,2s]$. The first limit gives both secants as $\log((\log s)^2/16)+o(1)$. Integrating $h'$ over $[s-1,s]$ proves the ratio.

These are applications of Abel inversion, exponential-functional recurrences, and Laplace asymptotics to the actual theta law. The leading coefficient growth has classical xi-coefficient asymptotic predecessors, including [Romik, §5](https://www.math.ucdavis.edu/~romik/data/uploads/papers/riemannxi-final.pdf). No priority claim, Bernstein-membership conclusion, or RH proof follows from this note.
