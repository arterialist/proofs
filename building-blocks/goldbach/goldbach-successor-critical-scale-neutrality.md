# Successor transport is neutral at the critical Goldbach scale

The literal successor gives a strong unconditional comparison of positive
Goldbach pair measures.  This note records its exact transform consequence.
The comparison preserves the critical obstruction rather than resolving it:
the escaped mass has size exactly (t^{-1}) in additive heat time, and its
Mellin correction is holomorphic only in the half-plane where an $O(X)$
cumulative error permits absolute integration.  All prime powers, endpoints,
and compensation terms are retained.

## 1. Three cumulative pair measures

Use the notation of
[the literal successor transport](goldbach-literal-successor-counting-transport.md).
For $X\geq0$, put

$$
M_0(X)=\mathcal G(X+2),\qquad
M_S(X)=\mathcal G_S(X),\qquad
M_C(X)=\mathcal G_C(X).
$$

The shift by two is literal: (K_m*K_n) starts at (m+n-2).  Since
$\Lambda(1)=0$, all three cumulative functions vanish at zero. The exact
identities are

$$
D_S(X):=M_S(X)-M_0(X)=-\mathcal R(X),                         \tag{1}
$$

and, for $X\geq2$,

$$
D_C(X):=M_C(X)-M_0(X)
=-\mathcal R(X)-2\kappa\frac{X-1}{X}\psi(X)+\kappa^2.       \tag{2}
$$

Here

$$
\kappa=\sum_{n\geq2}\Lambda(n)
 [\arcsin(n^{-1/2})-n^{-1/2}]>0.
$$

Equation (2) keeps both rank-one cross terms and the rank-one square.  From
Chebyshev and the exact escape formula,

$$
D_S(X)=O(X),\qquad D_C(X)=O(X).                              \tag{3}
$$

The PNT calibration in the source theorem gives, with no hypothesis on
Goldbach representations,

$$
\boxed{
D_S(X)=-2X+o(X),\qquad
D_C(X)=-2(1+\kappa)X+o(X).
}                                                            \tag{4}
$$

The endpoint square $\kappa^2\delta_2$ contributes only $O(1)$ to the
cumulative function, but it is present in equation (2).

## 2. Exact additive heat identities

Let $dM_j$ be the locally finite Stieltjes measure of $M_j$, and define

$$
L_j(t)=\int_{[0,\infty)}e^{-tX}\,dM_j(X),\qquad t>0.
$$

Then

$$
\boxed{
L_0(t)=e^{2t}\left(\sum_{n\geq2}\Lambda(n)e^{-tn}\right)^2,
}                                                            \tag{5}
$$

while positivity and convolution give

$$
L_S(t)=\left(\int e^{-tx}\,d\mu_S(x)\right)^2,
$$

$$
\boxed{
L_C(t)=\left(\int e^{-tx}\,d\mu_S(x)-\kappa e^{-t}\right)^2.
}                                                            \tag{6}
$$

Thus the initial transported atom, every continuous tail, the compensating
atom at one, and its square at two are all visible.

Stieltjes integration by parts, using $D_j(0)=0$, gives the exact transfer

$$
\boxed{
L_j(t)-L_0(t)=t\int_0^\infty e^{-tX}D_j(X)\,dX
\quad(j=S,C).
}                                                            \tag{7}
$$

The boundary at infinity vanishes by (3).  Applying the elementary Abelian
lemma

$$
D(X)=aX+o(X)
\quad\Longrightarrow\quad
t\int_0^\infty e^{-tX}D(X)\,dX=\frac a t+o(t^{-1})
$$

to (4) proves the unconditional asymptotics

$$
\boxed{
L_S(t)-L_0(t)=-\frac2t+o(t^{-1}),
\qquad
L_C(t)-L_0(t)=-\frac{2(1+\kappa)}t+o(t^{-1})
\quad(t\downarrow0).
}                                                            \tag{8}
$$

This is the exact scale diagnosis.  The successor error is smaller than the
uncentered main pair heat $\asymp t^{-2}$, but it lies at the same
$t^{-1}$ power as the critical centered Goldbach energy. It therefore
cannot be discarded in an RH-scale estimate.  Compensation does not remove
that term; it changes its leading coefficient by the explicit positive port
$2\kappa$.

## 3. Mellin transfer and its sharp half-plane

For complex $s$ with $\Re s>1$, define the difference transform directly
from the cumulative error:

$$
\Delta_j(s)=s\int_2^\infty D_j(X)X^{-s-1}\,dX.             \tag{9}
$$

Equation (3) makes this integral locally normally convergent, so
$\Delta_j$ is holomorphic on $\Re s>1$. On $\Re s>2$, where the
individual pair transforms converge absolutely, integration by parts gives

$$
\boxed{
\int X^{-s}\,dM_j(X)-\int X^{-s}\,dM_0(X)
=\Delta_j(s)+E_j(s),
}                                                            \tag{10}
$$

where $E_j$ is the entire finite-interval contribution on $[0,2]$.
Consequently, if either pair transform has a meromorphic continuation into a
region contained in $\Re s>1$, then the other has exactly the same
nonholomorphic singularities there.  The successor comparison transfers a
continuation already obtained by another argument; it does not construct the
continuation.

The boundary $\Re s=1$ is sharp for this information. The leading terms
in (4) give

$$
\Delta_S(s)\sim-\frac{2s}{s-1},\qquad
\Delta_C(s)\sim-\frac{2(1+\kappa)s}{s-1}
$$

at the real boundary, modulo terms whose finer continuation is not supplied
by an $o(X)$ remainder. Thus the $O(X)$ transport theorem cannot by
itself reach a line on or left of $\Re s=1$.

## 4. Relation to the multiplicative spectral bridge

For $a_n=\Lambda(n)-1$, the beta identity gives in its defining range

$$
\sum_{m,n}\frac{a_ma_n}{(m+n)^\sigma}
=\frac1{2\pi\Gamma(\sigma)}\int_{\mathbb R}
 |\Gamma(\sigma/2+it)|^2
 \left|-\frac{\zeta'}\zeta(\sigma/2+it)-\zeta(\sigma/2+it)\right|^2dt.
\tag{11}
$$

Finiteness of the right side for every $1<\sigma<2$ is equivalent to RH:
an off-critical zero on the sampled line produces a nonintegrable squared
pole.  Equations (8)--(10) do not weaken this requirement.  They concern the
positive uncentered transported pair measure, and their error is already of
critical centered size.  Passing from the signed centered convolution to
the nonnegative norm in (11) below absolute convergence is precisely the
missing RH-strength step.

The actual arithmetic clock reaches the same conclusion: zero exponential
growth of the positive centered heat energy is RH-equivalent.  The full
(W)-criterion reaches it through a different transform: eventual
nonpositivity forces holomorphic continuation past every possible
off-critical double pole.  Finally, the exact screw readout pairs the screw
increment with a sign-changing weight; it is not a positive functional on
the screw cone.  The successor leakage, clock energy, screw observation and
(W)-sign criterion therefore agree on the location of the obstruction, but
none supplies an unconditional signed additive-to-multiplicative transfer.

## 5. Formalized algebraic constants

[GoldbachSuccessorTransfer.lean](../../formalization/BuildingBlocks/GoldbachSuccessorTransfer.lean)
formalizes the contact escape identity, its bounds for $m,n\geq1$, the
rank-one compensation square, and the exact normalized form of (2).  These
are the algebraic parts of the argument where endpoint or compensation
constants are easiest to lose.  The Stieltjes and Abelian steps above remain
written analysis.
