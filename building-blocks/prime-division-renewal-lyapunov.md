# Prime division as a causal renewal equation at the RH boundary

This note connects the exact divisor-state recurrence to the centered heat
Lyapunov criterion.  The resulting renewal operator has zeta itself as its
spectral symbol, so an off-critical zero is an unstable scale resonance.

## 1. Exact sequential extraction of the von Mangoldt state

The classical divisor identity is

$$
\log n=\sum_{d\mid n}\Lambda(d).
\tag{1}
$$

It gives the triangular recurrence

$$
\boxed{
\Lambda(n)=\log n-
\sum_{\substack{d\mid n\\d<n}}\Lambda(d),
\qquad n\ge2.
}
\tag{2}
$$

Thus the next von Mangoldt state is determined exactly by the earlier
division states.  A prime has empty proper logarithmic state and produces
$\log n$; a number with at least two distinct prime factors cancels to
zero; a prime power leaves the logarithm of its base prime.  Equation (2)
is an exact linear-progression update, although estimating the stability
of many such updates is a separate problem.

## 2. Heat renewal law

Put

$$
P(t)=\sum_{n\ge1}\Lambda(n)e^{-nt},\qquad
Q(t)=\sum_{n\ge1}(\log n)e^{-nt}.
\tag{3}
$$

Multiplying (1) by $e^{-nt}$, summing absolutely and writing $n=dm$
gives

$$
\boxed{\sum_{m\ge1}P(mt)=Q(t).}
\tag{4}
$$

Use the exact centered baseline

$$
P_0(t)=(1+t^{-1})e^{-t},\qquad C(t)=P(t)-P_0(t).
$$

Since

$$
\sum_{m\ge1}P_0(mt)
=\frac1{e^t-1}-\frac1t\log(1-e^{-t}),
$$

equation (4) becomes

$$
\boxed{
\sum_{m\ge1}C(mt)=F(t),
\quad
F(t)=Q(t)-\frac1{e^t-1}+\frac1t\log(1-e^{-t}).
}
\tag{5}
$$

All series converge absolutely for every fixed $t>0$.

## 3. Logarithmic causal form

For $v\in\mathbb R$, define

$$
b(v)=e^{-v/2}C(e^{-v}),\qquad
f(v)=e^{-v/2}F(e^{-v}).
\tag{6}
$$

Then (5) is precisely

$$
\boxed{
(\mathcal Zb)(v):=
\sum_{m\ge1}m^{-1/2}b(v-\log m)=f(v).
}
\tag{7}
$$

At each fixed $v$, the far negative-time tail is absolutely convergent
because $C(t)$ decays exponentially as $t\to\infty$.  Apart from this
known negative-time boundary history, (7) is causal: every $m\ge2$ uses
an earlier logarithmic time.

The bilateral Laplace transform of $b$ is

$$
\mathcal Lb(z)
=\int_{-\infty}^{\infty}e^{-zv}b(v)\,dv
=\Gamma(z+1/2)
\left[-\frac{\zeta'(z+1/2)}{\zeta(z+1/2)}
-\frac{z+1/2}{z-1/2}\right]
\tag{8}
$$

in its initial absolute half-plane.  Translation in (7) gives

$$
\boxed{
\mathcal L(\mathcal Zb)(z)=\zeta(z+1/2)\mathcal Lb(z).
}
\tag{9}
$$

Thus the spectral symbol of the complete division-history operator is
$\zeta(z+1/2)$.  Its formal inverse is the Möbius history

$$
\mathcal Z^{-1}
=\sum_{m\ge1}\frac{\mu(m)}{\sqrt m}\,T_{\log m},
\tag{10}
$$

where $T_a b(v)=b(v-a)$.  Absolute-value estimation of (10) costs
$\sum_{m\le e^T}m^{-1/2}\asymp e^{T/2}$ and therefore loses exactly the
critical scale.  The required improvement must come from coherent signed
division histories, not from the total variation of the inverse.

## 4. Zeros are unstable scale resonances

If $\rho=\beta+i\gamma$ is a zeta zero, then

$$
z_\rho=\rho-1/2
$$

is a zero of the renewal symbol (9).  A zero with $\beta>1/2$ lies in the
positive-growth half-plane $\Re z>0$.  The inverse response (8) has a pole
there, producing an exponentially growing logarithmic-time mode with
energy exponent at least

$$
2\Re z_\rho=2\beta-1.
\tag{11}
$$

This agrees exactly with the centered-heat Lyapunov lower bound.

## 5. The finite-horizon stability theorem that proves RH

Let

$$
\mathscr A(T)=1+\int_0^T|b(v)|^2\,dv.
\tag{12}
$$

The centered-heat Lyapunov theorem proves the equivalence

$$
\boxed{
\mathrm{RH}\quad\Longleftrightarrow\quad
\exists C,K,T_0>0\ \forall T\ge T_0:
1+\|b\|_{L^2(0,2T)}^2
\le CT^K[1+\|b\|_{L^2(0,T)}^2].
}
\tag{13}
$$

In the renewal language, (13) says that solving the actual triangular
division equation (7) across one scale doubling has at most polynomial
condition growth on its distinguished arithmetic forcing $f$.  It does
not require bounded inversion on arbitrary inputs; counterexamples for
the unrestricted Möbius inverse therefore do not decide (13).

The distinction is important.  A universal operator-norm estimate for
(10) is much stronger and is false at the required scale by elementary
total-variation growth.  The RH proof needs only **source-specific
stability** for the single forcing (5), with its exact endpoint and
continuous-density compensation.  Establishing that source-specific
polynomial doubling bound completes the proof through (13).

## 6. Removing the growing equilibrium mode

The forcing in (7) looks exponentially large, but its growing part is the
renewal image of a constant causal state.  Euler summation gives

$$
Q(t)=\frac{\log(1/t)-\gamma}{t}+O(\log(2/t))
\qquad(t\downarrow0),
\tag{14}
$$

while elementary Taylor expansion gives

$$
\frac1{e^t-1}-\frac1t\log(1-e^{-t})
=\frac{\log(1/t)+1}{t}+O(1).
\tag{15}
$$

Consequently

$$
F(t)=-\frac{1+\gamma}{t}+O(\log(2/t))
\tag{16}
$$

and therefore

$$
f(v)=-(1+\gamma)e^{v/2}+O((1+v)e^{-v/2}).
\tag{17}
$$

Put

$$
B=-\frac{1+\gamma}{2},\qquad
b_0(v)=B\mathbf1_{[0,\infty)}(v),\qquad h=b-b_0.
\tag{18}
$$

For $v\ge0$, the exact renewal image of this causal constant is

$$
(\mathcal Zb_0)(v)=B\sum_{m\le e^v}m^{-1/2}.
\tag{19}
$$

The Euler summation formula

$$
\sum_{m\le X}m^{-1/2}
=2\sqrt X+\zeta(1/2)+O(X^{-1/2})
\tag{20}
$$

uses the usual endpoint convention; changing the convention at an integer
changes (19) only by its explicit final summand and does not affect the
following boundedness statement.  Equations (17)--(20) prove that

$$
\boxed{
\mathcal Zh=g,
\qquad
g(v):=f(v)-B\sum_{m\le e^v}m^{-1/2}=O(1)\qquad(v\ge0),
}
\tag{21}
$$

and, away from the harmless cutoff jumps,

$$
\boxed{
g(v)\longrightarrow -B\zeta(1/2)
=\frac{1+\gamma}{2}\zeta(1/2).
}
\tag{22}
$$

Since $b-h$ is bounded, the two accumulated energies have the same
exponential growth exponent.  More explicitly,

$$
\|b\|_{L^2(0,T)}^2
\le2\|h\|_{L^2(0,T)}^2+2B^2T,
$$

and the reverse inequality follows by exchanging $b$ and $h$.  Hence

$$
\boxed{
\mathrm{RH}\quad\Longleftrightarrow\quad
\limsup_{T\to\infty}\frac1T
\log\left(1+\int_0^T|h(v)|^2dv\right)=0.
}
\tag{23}
$$

The source-specific stability problem is therefore a bounded-input
problem.  After removal of the explicit equilibrium mode, every positive
exponential growth rate in the response $h$ is an internal resonance of
$\mathcal Z$, and (9) locates those resonances exactly at
$z=\rho-1/2$.  A polynomial finite-horizon bound for the response to the
bounded forcing (21) proves RH.

## 7. Bounded response is already equivalent to RH

The exponential heat smoothing makes the source-specific target stronger
than the energy criterion suggests:

$$
\boxed{
\mathrm{RH}\quad\Longleftrightarrow\quad
\sup_{v\ge0}|b(v)|<\infty
\quad\Longleftrightarrow\quad
\sup_{v\ge0}|h(v)|<\infty.
}
\tag{24}
$$

For the reverse implication, bounded $b$ means
$C(t)=O(t^{-1/2})$ on $0<t\le1$.  Hence
$\int_0^1C(t)t^{s-1}dt$ converges locally normally for
$\Re s>1/2$.  Equation (2) then continues the compensated logarithmic
derivative holomorphically to that half-plane, excluding all zeta zeros
there and proving RH by reflection.

For the forward implication, shift the inverse Mellin contour for
$\Gamma(s)G(s)$.  The nontrivial-zero residues are

$$
-m_\rho\Gamma(\rho)t^{-\rho}.
$$

Under RH, multiplication by $t^{1/2}$ turns these into the bounded modes

$$
-m_\rho\Gamma(1/2+i\gamma)e^{i\gamma v}.
$$

Stirling's estimate and the classical zero-counting bound give

$$
\sum_\rho m_\rho|\Gamma(1/2+i\gamma)|<\infty,
$$

so the zero series converges absolutely and uniformly in $v$.  The pole
at one has already been removed by $P_0$; the gamma-pole and trivial-zero
terms become $O((1+v)e^{-v/2})$.  Thus $b$ is bounded.  Since $b-h=b_0$
is bounded, the last equivalence in (24) follows.

Accordingly, the final renewal target may be stated as a distinguished
bounded-input/bounded-response assertion:

$$
\boxed{\mathcal Zh=g,\quad g\in L^\infty(0,\infty)
\text{ as in (21)}\quad\Longrightarrow\quad
h\in L^\infty(0,\infty).}
\tag{25}
$$

Only this particular solution is asserted in (25), not bounded
invertibility of $\mathcal Z$ on all bounded inputs.

## 8. Removing the continuous volume before inversion

The exponentially large total variation of $\mathcal Z$ comes from the
continuous density of integer labels.  Define its continuous counterpart

$$
(\mathcal Kh)(v)=\int_0^\infty e^{u/2}h(v-u)\,du.
\tag{26}
$$

On its natural causal domain,

$$
\left(\frac d{dv}-\frac12\right)\mathcal K=I.
\tag{27}
$$

Write $\mathcal Z=\mathcal K+\mathcal R$, where $\mathcal R$ is the exact
integer-minus-continuum quadrature operator.  Applying the continuous
inverse to $\mathcal Zh=g$ gives the preconditioned equation

$$
\boxed{
\left[I+\left(\frac d{dv}-\frac12\right)\mathcal R\right]h
=\left(\frac d{dv}-\frac12\right)g
}
\tag{28}
$$

in the distributional sense; the jumps of $g$ are retained as finite
atomic terms.

In spectral variables, the original symbol is $\zeta(z+1/2)$ and the
continuous symbol is $(z-1/2)^{-1}$.  Therefore the preconditioned symbol
is

$$
\boxed{
(z-1/2)\zeta(z+1/2)=(s-1)\zeta(s),
\qquad s=z+1/2.
}
\tag{29}
$$

This removes both the pole at $s=1$ and the exponential label-volume
growth.  The residual quadrature symbol is simply

$$
(s-1)\zeta(s)-1.
\tag{30}
$$

All unstable resonances are preserved: (29) vanishes exactly where zeta
does, away from the removed pole.  The advantage is that the remaining
operator is an integer-versus-continuum discrepancy rather than the full
positive divisor volume.  A source-specific $L^\infty$ estimate for the
preconditioned equation (28), with its atomic jumps kept, proves (25) and
hence RH.

## 9. The quadrature remainder has an integrable primitive

The remainder in Section 8 admits an exact representation that replaces
its infinite total variation by one derivative and an $L^1$ kernel.  On
the shift half-line put

$$
d\nu(u)=\sum_{m\ge1}m^{-1/2}\,\delta_{\log m}(u),
\qquad
d\kappa(u)=e^{u/2}\,du,
\tag{31}
$$

so that $\mathcal R$ is convolution by $d\nu-d\kappa$.  Define the
cumulative Euler discrepancy

$$
E(u)=\sum_{m\le e^u}m^{-1/2}-2(e^{u/2}-1),
\qquad u\ge0,
\tag{32}
$$

and the limiting constant

$$
c=2+\zeta(1/2).
\tag{33}
$$

Euler summation, uniformly between consecutive logarithmic jump points,
gives

$$
E(u)=c+O(e^{-u/2}).
\tag{34}
$$

Extend

$$
H(u)=\mathbf 1_{[0,\infty)}(u)(E(u)-c)
\tag{35}
$$

by zero to the negative half-line.  Equation (34) proves
$H\in L^1(\mathbb R)\cap L^2(\mathbb R)$.  Taking distributional
derivatives in (32), including the atom at the origin, yields the exact
measure identity

$$
\boxed{
d\nu-d\kappa=c\,\delta_0+dH.
}
\tag{36}
$$

Consequently, for every causal locally absolutely continuous response
for which the convolutions exist,

$$
\boxed{
\mathcal Rh=c h+H*h'.
}
\tag{37}
$$

This is stronger than merely subtracting the continuous volume: all of
the remaining infinitely many integer jumps have been compressed into
an integrable Euler kernel acting on one derivative.  Young's inequality
now gives the rigorous graph-norm estimates

$$
\|\mathcal Rh-c h\|_{L^\infty}
\le \|H\|_{L^1}\|h'\|_{L^\infty},
\tag{38}
$$

and

$$
\|\mathcal Rh-c h\|_{L^2}
\le \|H\|_{L^1}\|h'\|_{L^2}.
\tag{39}
$$

The bounded-forcing renewal equation (21) therefore has the exact
integro-differential form

$$
\boxed{
\mathcal Kh+c h+H*h'=g.
}
\tag{40}
$$

In Laplace variables, (36) is the identity

$$
\zeta(z+1/2)-\frac1{z-1/2}
=c+z\widehat H(z),
\tag{41}
$$

initially in a common right half-plane and then by continuation wherever
both sides are defined.  Thus no zero has been discarded: the full
spectral obstruction is now encoded in the transform of a decaying,
explicit sawtooth kernel.

The remaining closure problem is correspondingly sharp.  It is enough
to prove, for the distinguished solution of (40), a horizon-uniform
estimate of the form

$$
\|h'\|_{L^\infty(0,T)}
\le A\|h\|_{L^\infty(0,T)}+B
\tag{42}
$$

together with a coercive estimate for $\mathcal K+cI$ against the
$H*h'$ term whose net coefficient is strictly below one.  Equivalently,
one may establish the analogous $L^2$ estimate with subexponential
constants.  Equations (36)--(41) show exactly why that estimate is the
RH-level step: failure is equivalent to an exponentially growing mode
$e^{(\rho-1/2)v}$, while its proof rules out every zero with
$\Re\rho>1/2$.

## 10. Stable factorization and the exact feedback boundary

The non-derivative part of (40) is explicitly stable.  The alternating
series for $\eta(1/2)=(1-\sqrt2)\zeta(1/2)$ gives elementary upper and
lower bounds implying

$$
0<c=2+\zeta(1/2)<1.
\tag{43}
$$

Indeed, the alternating-series brackets at five and eight terms give

$$
\sqrt2-1
<
\sum_{n=1}^{8}\frac{(-1)^{n-1}}{\sqrt n}
<
\eta(1/2)
<
\sum_{n=1}^{5}\frac{(-1)^{n-1}}{\sqrt n}
<
2(\sqrt2-1),
$$

where only the two exterior inequalities require direct elementary
arithmetic.  Dividing by $\sqrt2-1$ proves (43).

For completeness, solve

$$
(\mathcal K+cI)q=\phi.
\tag{44}
$$

If $y=\mathcal Kq$, then $y'=q+y/2$ and $q=(\phi-y)/c$.
Writing $a=c^{-1}-1/2>0$ gives

$$
y(v)=\frac1c\int_0^v e^{-a(v-u)}\phi(u)\,du
$$

and therefore

$$
\boxed{
(\mathcal K+cI)^{-1}\phi(v)
=\frac1c\phi(v)-\frac1{c^2}
\int_0^v e^{-a(v-u)}\phi(u)\,du.
}
\tag{45}
$$

Thus $\mathcal K+cI$ has a causal BIBO-stable inverse.  Equation (40)
can be factored without approximation as

$$
(I+\mathcal T)h=(\mathcal K+cI)^{-1}g,
\qquad
\mathcal T=(\mathcal K+cI)^{-1}H*D.
\tag{46}
$$

Its transfer function is

$$
\boxed{
T(z)=\frac{z\widehat H(z)}{c+(z-1/2)^{-1}},
\qquad
1+T(z)=
\frac{\zeta(z+1/2)}{c+(z-1/2)^{-1}}.
}
\tag{47}
$$

The harmless zero of the denominator in (47), if encountered under
continuation, is a pole of the chosen factor rather than a zero of the
original renewal symbol and must be treated by the unfactored equation.
Every zero of $1+T$ in $\Re z>0$ is otherwise exactly a zero of zeta to
the right of the critical line.  Hence the missing theorem has the
following precise feedback form:

$$
\boxed{
T(z)\ne-1\quad\text{for every }\Re z>0.
}
\tag{48}
$$

A strict global small-gain proof cannot establish (48).  Indeed, at each
known critical-line zero $\rho=1/2+i\gamma$, the boundary value satisfies
$T(i\gamma)=-1$.  Any successful estimate must therefore permit neutral
boundary contact while excluding penetration into the open right
half-plane.  This rules out the tempting but false target
$\|\mathcal T\|<1$ and identifies a dissipativity, phase, or winding
estimate for the distinguished Euler kernel as the correct kind of
closure theorem.

## 11. A positive primitive hidden inside the Euler sawtooth

The first primitive of $H$ has a sign that is not visible from $H$
itself.  Put

$$
J(u)=\int_0^u H(r)\,dr.
\tag{49}
$$

Then

$$
\boxed{J(u)\ge0\quad(u\ge0),}
\tag{50}
$$

with strict inequality for $u>0$.  Here is an elementary proof.  Write
$S_n=\sum_{m\le n}m^{-1/2}$, $a=\sqrt n$, $b=\sqrt{n+1}$, and

$$
A_n=S_n-\zeta(1/2).
$$

On $[\log n,\log(n+1))$ one has

$$
H(u)=A_n-2e^{u/2}.
\tag{51}
$$

The sequences $S_n-2\sqrt n$ and $S_n-2\sqrt{n+1}$ are respectively
decreasing and increasing to $\zeta(1/2)$.  Therefore

$$
2a<A_n<2b.
\tag{52}
$$

Thus $H$ decreases through zero exactly once on every such interval.
Its integral over the interval is

$$
J(\log(n+1))-J(\log n)
=2\log(b/a)\left(A_n-2L(a,b)\right),
\tag{53}
$$

where $L(a,b)=(b-a)/(\log b-\log a)$ is the logarithmic mean.  A
one-remainder Euler--Maclaurin estimate and the elementary logarithmic
mean bound give

$$
A_n>
2\sqrt n+\frac1{2\sqrt n}-\frac1{24n^{3/2}},
\tag{54}
$$

and

$$
2L(\sqrt n,\sqrt{n+1})
<
2\sqrt n+\frac1{2\sqrt n}
-\frac1{8(n+1)^{3/2}}.
\tag{55}
$$

Finally,

$$
\frac1{8(n+1)^{3/2}}>\frac1{24n^{3/2}}
\qquad(n\ge1),
\tag{56}
$$

so every increment in (53) is positive.  Since $J(0)=0$, its values at
all logarithmic endpoints are positive and increasing.  Between two
endpoints, (52) says that $J$ first increases and then decreases, so its
minimum is attained at an endpoint.  This proves (50).

For reference, (54) follows by retaining the $B_2$ term in the
Euler--Maclaurin expansion of the Hurwitz tail; the next signed
remainder is positive after solving for $A_n$.  Inequality (55) follows
on writing $b/a=e^t$ and bounding $(e^t-1)/t$ by its Taylor expansion
with positive remainder, followed by $e^{2t}=1+1/n$.  Both estimates are
strict for finite $n$.

The total mass of $H$ is also exact.  Differentiating (41) at $z=0$
gives

$$
\boxed{
\int_0^\infty H(u)\,du=4+\zeta'(1/2)>0.
}
\tag{57}
$$

The positivity follows independently from (50) and the strictly
positive endpoint increments.  Since $J$ is bounded and nonnegative,
integration by parts gives, for $\Re z>0$,

$$
\boxed{
\widehat H(z)=z\widehat J(z),
\qquad
z\widehat H(z)=z^2\widehat J(z),
\qquad J\ge0.
}
\tag{58}
$$

Consequently the feedback characteristic function has the more rigid
representation

$$
1+T(z)
=
\frac{c+(z-1/2)^{-1}+z^2\widehat J(z)}
     {c+(z-1/2)^{-1}}.
\tag{59}
$$

This reduces the open-half-plane exclusion (48) to a phase theorem for
the Laplace transform of one explicit nonnegative kernel.  Positivity
alone does not control the complex phase of $\widehat J$; the remaining
target is to show that the curve

$$
z^2\widehat J(z)
$$

cannot meet $-c-(z-1/2)^{-1}$ for $\Re z>0$.  Unlike a generic
zero-free reformulation, (50) supplies genuine one-sided time-domain
structure that can be used in a dissipativity or winding argument.

## 12. Functional symmetry forces paired hyperbolic moments

The one-sided feedback equation can be strengthened by imposing the
functional equation at the same time.  Because $H(u)=O(e^{-u/2})$, its
Laplace transform is represented by the defining integral throughout

$$
\Re z>-1/2.
\tag{60}
$$

Suppose $0<\Re z<1/2$ and $\zeta(1/2+z)=0$.  The zeta functional
equation then also gives $\zeta(1/2-z)=0$.  Applying (41) first at $z$
and then at $-z$ gives

$$
c+\frac1{z-1/2}+z\widehat H(z)=0,
\tag{61}
$$

and

$$
c-\frac1{z+1/2}-z\widehat H(-z)=0.
\tag{62}
$$

Adding and subtracting these equations, and using

$$
\widehat H(z)+\widehat H(-z)
=2\int_0^\infty H(u)\cosh(zu)\,du,
$$

$$
\widehat H(z)-\widehat H(-z)
=-2\int_0^\infty H(u)\sinh(zu)\,du,
$$

yields the paired necessary conditions

$$
\boxed{
\int_0^\infty H(u)\cosh(zu)\,du
=\frac1{1/4-z^2},
}
\tag{63}
$$

and

$$
\boxed{
\int_0^\infty H(u)\sinh(zu)\,du
=\frac c z+\frac1{2z(z^2-1/4)}.
}
\tag{64}
$$

Conversely, (63) and (64) imply (61) and (62), so—away from the
displayed removable exceptional points—the pair is equivalent to the
simultaneous resonances at $z$ and $-z$.

This matters because an off-critical zero is no longer represented by
an arbitrary complex cancellation in one Laplace transform.  It must
make both the even and odd hyperbolic moments of the same real
sawtooth attain the rigid rational values (63)--(64).  Writing
$z=x+iy$, a candidate off-line zero must in particular satisfy

$$
\left|\frac1{1/4-z^2}\right|
\le
V(x),
\qquad
\left|\frac c z+\frac1{2z(z^2-1/4)}\right|
\le
V(x),
\tag{65}
$$

where the completely explicit weighted variation

$$
V(x)=\int_0^\infty |H(u)|\cosh(xu)\,du
\tag{66}
$$

is finite for $0\le x<1/2$.  The inequalities in (65) are only
necessary and are not by themselves sufficient for RH, but they turn
the next proof obligation into a concrete incompatibility problem:
prove that the exact phase information in (63) and (64), together with
the one-crossing property (51), cannot hold for any $x>0$.

At $x=0$ the identities allow the neutral critical-line resonances.
Thus this paired formulation has the correct geometry: it preserves
all boundary zeros while isolating precisely the forbidden transverse
displacement.

## 13. Positivity alone is insufficient; the arithmetic kernel has more

It is important not to mistake (50) for a generic positive-kernel proof
of (48).  Let

$$
J_{A,k}(u)=A(1-e^{-ku}),\qquad A,k>0.
\tag{67}
$$

This kernel is bounded, nonnegative, and vanishes at the origin, but

$$
z^2\widehat J_{A,k}(z)=\frac{Akz}{z+k}.
$$

For any prescribed real $z_0\in(0,1/2)$, choosing

$$
A=
\left(\frac1{1/2-z_0}-c\right)\frac{z_0+k}{kz_0}>0
\tag{68}
$$

makes

$$
c+\frac1{z_0-1/2}+z_0^2\widehat J_{A,k}(z_0)=0.
$$

Hence boundedness and positivity of the primitive, without its exact
integer geometry, permit a forbidden right-half-plane resonance.

The actual $J$ has a stronger decomposition.  Set

$$
j_n=J(\log n),\qquad q_n=j_{n+1}-j_n.
\tag{69}
$$

Equation (53) and its proof give

$$
\boxed{
q_n=
2\log\!\left(\frac{\sqrt{n+1}}{\sqrt n}\right)
\left(A_n-2L(\sqrt n,\sqrt{n+1})\right)>0.
}
\tag{70}
$$

Moreover, $j_1=0$, $j_n$ increases, and

$$
\sum_{n\ge1}q_n
=\lim_{n\to\infty}j_n
=4+\zeta'(1/2)=:\ell.
\tag{71}
$$

Define the monotone step part

$$
Q(u)=j_n\qquad
(\log n\le u<\log(n+1))
\tag{72}
$$

and the within-cell arch

$$
R(u)=J(u)-Q(u).
\tag{73}
$$

On writing $u=\log n+t$, $0\le t<\log(1+1/n)$, formula (51) gives

$$
R(u)=A_nt-4\sqrt n\,(e^{t/2}-1).
\tag{74}
$$

The one-crossing property of $H=J'$ says that $J$ first increases and
then decreases on the cell.  Since its right endpoint is
$j_{n+1}=j_n+q_n>j_n$, it never falls below its left endpoint.
Consequently

$$
\boxed{
J=Q+R,\qquad Q\ \hbox{nondecreasing},\qquad R\ge0.
}
\tag{75}
$$

Both pieces have explicit positive representations.  For $\Re z>0$,

$$
\widehat Q(z)
=\frac1z\sum_{n\ge1}q_n(n+1)^{-z},
\qquad
\widehat R(z)=\int_0^\infty R(u)e^{-zu}\,du.
\tag{76}
$$

Substitution into (59) yields the positive Dirichlet--arch
characteristic equation

$$
\boxed{
\zeta(1/2+z)
=
c+\frac1{z-1/2}
+z\sum_{n\ge1}q_n(n+1)^{-z}
+z^2\widehat R(z),
}
\tag{77}
$$

where every $q_n$ is strictly positive and $R(u)$ is nonnegative.
Unlike bare primitive positivity, (77) retains the exact logarithmic
integer cells and separates their positive net increments from their
positive intracoset excursions.

Thus the remaining phase theorem can be attacked in two controlled
pieces: a Dirichlet series with summable positive coefficients
$q_n$, and a Laplace transform of localized nonnegative arches.
Any proof of (48) from (77) must use their linked formulas (70) and
(74); treating the two positive terms as arbitrary again admits the
counterexample (67)--(68).

## 14. Cell cancellation gains a full strip of analyticity

The decomposition (75) has substantially faster convergence than the
pointwise bound on $H$ suggests.  Euler--Maclaurin and the expansion of
the logarithmic mean give

$$
A_n
=2\sqrt n+\frac1{2\sqrt n}
-\frac1{24n^{3/2}}+O(n^{-7/2}),
\tag{78}
$$

and

$$
2L(\sqrt n,\sqrt{n+1})
=2\sqrt n+\frac1{2\sqrt n}
-\frac1{6n^{3/2}}+O(n^{-5/2}).
\tag{79}
$$

Substitution in (70) therefore yields the positive asymptotic

$$
\boxed{
q_n=\frac1{8n^{5/2}}+O(n^{-7/2}).
}
\tag{80}
$$

In particular,

$$
\ell-j_n=\sum_{m\ge n}q_m
=\frac1{12n^{3/2}}+O(n^{-5/2}).
\tag{81}
$$

On the $n$th logarithmic cell, (74), (78), and
$0\le t\le\log(1+1/n)$ also give

$$
0\le R(\log n+t)\ll n^{-3/2}.
\tag{82}
$$

Combining (72), (75), (81), and (82) proves the stronger centered
decay

$$
\boxed{
\widetilde J(u):=J(u)-\ell=O(e^{-3u/2}).
}
\tag{83}
$$

Thus $\widehat{\widetilde J}(z)$ is represented by its Laplace integral
throughout the enlarged half-plane

$$
\Re z>-3/2,
\tag{84}
$$

and (58) becomes

$$
\widehat H(z)=\ell+z\widehat{\widetilde J}(z).
\tag{85}
$$

The renewal symbol consequently has the second-order renormalization

$$
\boxed{
\zeta(1/2+z)
=c+\frac1{z-1/2}+\ell z
+z^2\widehat{\widetilde J}(z),
\qquad \Re z>-3/2.
}
\tag{86}
$$

The original remainder $H$ only exposed the strip $\Re z>-1/2$.
Exact cancellation between the positive cell increments and positive
arches exposes an additional full unit.  In particular, both members of
an off-critical pair $z,-z$ now lie well inside one common
Laplace-transform domain, with the pole, constant, and linear response
removed explicitly.  The unresolved phase is confined to the transform
of the exponentially smaller arithmetic remainder
$\widetilde J$.

## 15. A damped second-order renewal equation

The second-order renormalization also has an exact time-domain form.
Extend $\widetilde J=(J-\ell)\mathbf 1_{[0,\infty)}$ causally.  Since
$J(0)=0$, its distributional derivative includes the initial jump
$-\ell\delta_0$, and therefore

$$
H\,du=\ell\delta_0+d\widetilde J.
\tag{87}
$$

Substituting (87) into (40) gives

$$
\boxed{
\ell h'+c h+\mathcal Kh+\widetilde J*h''=g.
}
\tag{88}
$$

All derivatives and initial atoms in (88) are understood causally; with
that convention its Laplace symbol is exactly (86).  The coefficient

$$
\ell=4+\zeta'(1/2)>0
\tag{89}
$$

is a genuine local damping term, while the nonlocal second-derivative
memory has kernel $O(e^{-3u/2})$.

For an exponential homogeneous mode $h(v)=e^{zv}$, (88) becomes

$$
\ell z+c+\frac1{z-1/2}
+z^2\widehat{\widetilde J}(z)=0.
\tag{90}
$$

Thus a zero with $x=\Re z>0$ must make the memory term supply exactly
the negative transverse damping

$$
\boxed{
\Re\!\left(z^2\widehat{\widetilde J}(z)\right)
=-\ell x-c-\Re\frac1{z-1/2}.
}
\tag{91}
$$

Equation (91) isolates a concrete coercivity target.  It is enough to
prove, throughout $0<x<1/2$, that

$$
\Re\!\left(z^2\widehat{\widetilde J}(z)\right)
>
-\ell x-c-\Re\frac1{z-1/2}
\tag{92}
$$

whenever the corresponding imaginary equation in (90) holds.  The
qualification is essential: a uniform modulus or real-part estimate
without the imaginary phase constraint is false, as the generic
counterexample in Section 13 shows.

There is an equivalent finite-horizon route.  Pair (88) with $h'$ in
the exponentially weighted inner product

$$
\langle f_1,f_2\rangle_{x,T}
=\int_0^T e^{-2xv}f_1(v)\overline{f_2(v)}\,dv.
\tag{93}
$$

The local term contributes

$$
\ell\|h'\|_{x,T}^2,
\tag{94}
$$

whereas a mode with $\Re z=x$ has constant weighted amplitude and hence
energy proportional to $T$.
Consequently, a coercive estimate for the combined memory expression

$$
\Re\langle \mathcal Kh+\widetilde J*h'',h'\rangle_{x,T}
\tag{95}
$$

which is strictly greater than the negative of (94), after inclusion
of the explicit $c h$ boundary contribution and subject to the
imaginary balance in (90), excludes every $x>0$.  Allowing the
coercivity margin to tend to zero as $x\downarrow0$ preserves the known
critical-line resonances.

This is the precise Lyapunov version of the phase theorem: prove that
the exponentially decaying arithmetic memory cannot cancel the positive
local damping in both quadratures simultaneously.  It is stronger than
estimating $\widetilde J$ by absolute value and uses exactly the
real/imaginary coupling imposed by (90).
