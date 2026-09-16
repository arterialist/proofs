# The odd weak theta-ground row detects actual zeta poles

The [sign-weighted weak ground identity](theta-odd-sign-ground-exponential-weak-row.md)
admits an odd coherent scaling test, but its first estimate is at the
prime-number-theorem scale. Here the full row is split into two shifts
of the actual arithmetic scaling sum plus **bounded** archimedean,
pole, and reflection terms. Its clock transform therefore retains
each off-critical zeta pole seen by the odd ground moment. This is a
new scalar detector, not an unconditional bound on that row or on the
remaining affine covariance residual.

Fix \(R>0\), the positive even normalized killed ground \(\psi_R\),
and write
\[
 G_R(v)=\Phi(v)\psi_R(v)1_{|v|>R},\qquad
 g_R(u)=G_R(u)1_{u>R},\qquad
 F_R(v)=\operatorname{sgn}(v)G_R(v).
 \tag{1}
\]
The physical theta envelope and boundedness of \(\psi_R\) give all
fixed exponential moments of \(g_R\). Let \(K\) be the complete
[successor scaling kernel](successor-feedback-kernel-scaling.md), put
\(f(x)=-\sqrt xK(x)\), and define
\[
 z_V^-(v)=\operatorname{sgn}(v)f(e^{|v|-V}),\qquad
 \mathcal T_R^-(V)=Q_{\rm W}(F_R,z_V^-),\qquad V\ge0.
 \tag{2}
\]
The [odd weak-domain theorem](theta-odd-sign-ground-exponential-weak-row.md)
places this discontinuous test in the physical logarithmic form
domain and makes the complete mixed Weil row literal. Set
\[
 q(V)=Q_{\rm core}(e^{-V}),\qquad
 Q_{\rm core}(t)=\sqrt t\sum_{n\ge2}\Lambda(n)K(tn),\qquad
 \Delta_R=\int_R^\infty (e^{u/2}-e^{-u/2})g_R(u)\,du.
 \tag{3}
\]
Every sum here retains all prime powers.

**Odd clock theorem.** With the complete archimedean form \(A\),
the exact full-row decomposition is
\[
 \boxed{\begin{aligned}
 \mathcal T_R^-(V)={}&A(F_R,z_V^-)
   -2\Delta_R B(e^{-V})
   +2\int_R^\infty g_R(u)[q(V-u)-q(V+u)]\,du\\
   &-\mathcal E_R(e^{-V}),
 \end{aligned}}                                                \tag{4}
\]
where
\[
 B(t)=\int_0^\infty(e^{u/2}-e^{-u/2})f(te^u)\,du,
 \tag{5}
\]
and the **finite reflected-prime correction** is
\[
 \mathcal E_R(t)=2\int_R^\infty g_R(u)
 \sum_{\log n<u}\frac{\Lambda(n)}{\sqrt n}
 \left[f(te^{u-\log n})+f(te^{\log n-u})\right]du.
 \tag{6}
\]
The correction includes every integer \(n\ge2\) with its actual
von Mangoldt weight. The strict inequality at \(\log n=u\) changes
only a null set in the \(u\)-integral. For fixed \(R\),
\[
 \sup_{V\ge0}\bigl(|A(F_R,z_V^-)|+|B(e^{-V})|
                    +|\mathcal E_R(e^{-V})|\bigr)<\infty.
 \tag{7}
\]

To verify (4), pair both prime orientations with \(F_R\), reflect
the negative exterior half, and write \(\ell=\log n\). The bracket
at a positive source point \(u>R\) is twice
\(f(te^{u+\ell})+\operatorname{sgn}(u-\ell)
f(te^{|u-\ell|})\), where \(t=e^{-V}\). For \(\ell>u\) this is twice
\(f(tne^u)-f(tne^{-u})\). For \(\ell<u\), subtracting that
unreflected expression leaves the two terms in (6). Since
\(\sum_n\Lambda(n)n^{-1/2}f(tne^{\pm u})
=-Q_{\rm core}(te^{\pm u})\), subtracting the prime form gives the
two shifted \(q\)'s in (4). The full pole pairing is
\(-2\Delta_R B(t)\): the odd moments of \(F_R\) are
\((\Delta_R,-\Delta_R)\), and those of \(z_V^-\) are
\((B(t),-B(t))\). No pole or reflected prime term is dropped.

Here is a direct proof of (7). The scaling bounds give
\(\|f\|_\infty+\sup_{x>0}|xf'(x)|<\infty\). Complete Chebyshev
gives \(\sum_{n<e^u}\Lambda(n)/\sqrt n\ll e^{u/2}\), hence
\[
 |\mathcal E_R(t)|\ll\|f\|_\infty
             \int_R^\infty g_R(u)e^{u/2}\,du.
 \tag{8}
\]
For the pole, split \(B=I_1-I_2\) according to the two exponentials.
The zero moment \(\int_0^\infty K(x)dx=0\) gives, for \(0<t\le1\),
\[
 I_1(t)=-t^{-1/2}\int_t^\infty K(x)dx
       =t^{-1/2}\int_0^t K(x)dx=O(1),
 \qquad |I_2(t)|\le2\|f\|_\infty.                    \tag{9}
\]
Finally the polarized archimedean jump formula has a fixed scalar
\(L^2\) term and an increment integral with kernel
\(r(a)=e^{-a/2}/(1-e^{-2a})\). The tests \(z_V^-\) are uniformly
bounded and uniformly Lipschitz **on each half-line**. For
\(0<a<R\), if an interval \([v,v+a]\) crosses zero, both endpoints
lie in \((-R,R)\), where \(F_R=0\). Thus, wherever
\(F_R(v+a)-F_R(v)\ne0\), the test increment is \(O(a)\). For
\(a\ge R\) it is \(O(1)\). Since
\(\int_0^R ar(a)da+\int_R^\infty r(a)da<\infty\), the increment
pairing is bounded by a constant times \(\|F_R\|_1\), uniformly in
\(V\). This proves the archimedean part of (7), including the jump
at zero without differentiating through it.

## Mellin pole and the actual odd ground moment

The complete Chebyshev bound and the kernel endpoints imply
\[
 |q(V)|\ll
 \begin{cases}e^{V/2},&V\ge0,\\e^V,&V<0.
 \end{cases}                                                   \tag{10}
\]
For \(1/2<\operatorname{Re}z<1\), absolute Fubini in the full
\(V\)-line and the complete von Mangoldt Dirichlet series give
\[
 \int_{-\infty}^{\infty}e^{-zV}q(V)dV
 =M_K(z+1/2)
       \left(-\frac{\zeta'}\zeta\right)(z+1/2),
 \qquad M_K(s)=\int_0^\infty x^{s-1}K(x)dx.
 \tag{11}
\]
The [kernel Mellin calculation](actual-Abel-feedback-Mellin-kernel.md)
gives \(\mathfrak m(z):=-M_K(z+1/2)
=\sqrt\pi\Gamma(z+1/2)\cot(\pi z)/(2z+1)\). It is nonzero
through \(0<\operatorname{Re}z<1/2\).

Define the entire signed ground moment
\[
 N_R(z)=\int_R^\infty g_R(u)(e^{-zu}-e^{zu})du.
 \tag{12}
\]
Splitting the full \(V\)-line in (11) at zero gives a meromorphic
continuation of the literal one-sided transform of \(\mathcal T_R^-\)
to \(0<\operatorname{Re}z<1\). In that strip its only possible
singularities are those of the product
\[
 2N_R(z)M_K(z+1/2)
       \left(-\frac{\zeta'}\zeta\right)(z+1/2).
 \tag{13}
\]
Indeed the \(V<0\) correction to the shifted \(q\) convolution
is holomorphic for \(\operatorname{Re}z<1\): (10) bounds it on
compact vertical strips by a constant times
\(g_R(u)(1+u)(e^{u/2}+e^{\sigma u})\), with
\(\sigma<1\), which is integrable. The three bounded corrections
in (7) have one-sided transforms holomorphic for
\(\operatorname{Re}z>0\). At \(z=1/2\), the simple zero of
\(M_K(z+1/2)\) cancels the zeta pole. Since zeta has no real
zeros for \(s>1/2\), this continuation is regular at every
positive real \(z\in(0,1)\).

If \(\rho=\beta+i\gamma\) is a nontrivial zeta zero of
multiplicity \(m_\rho\) with \(\beta>1/2\), then
\(z_\rho=\rho-1/2\) lies in this strip and
\[
 \boxed{\quad
 \operatorname*{Res}_{z=z_\rho}
       \widehat{\mathcal T_R^-}(z)
 =2m_\rho\mathfrak m(z_\rho)N_R(z_\rho).
 \quad}                                                        \tag{14}
\]
The [actual physical-mass concentration theorem](theta-ground-physical-mass-concentration.md)
gives, for each fixed \(z\) with \(\operatorname{Re}z>0\),
\[
 N_R(z)=m_R^+\left[e^{-zR}(1+o_z(1))
                    -e^{zR}(1+o_z(1))\right]
       \sim-m_R^+e^{zR},\qquad
 m_R^+=\int_R^\infty g_R(u)du>0.                \tag{15}
\]
Thus every fixed off-critical zero produces a genuine nonreal pole
in (14) for **all sufficiently large cores**. The multiplier
\(\mathfrak m(z_\rho)\) is nonzero there.

Under RH, the [successor-feedback converse](successor-feedback-RH-converse.md)
gives a global bound on \(q\). Equations (4) and (7) therefore make
\(\mathcal T_R^-\) bounded for every fixed \(R\). Conversely, if
this full odd row is bounded on \(V\ge0\) for every \(R\) in any
unbounded set, an off-critical zero would be detected by one of
those cores and contradict holomorphy of its bounded-row Laplace
transform in \(\operatorname{Re}z>0\). Hence
\[
 \boxed{\quad
 \mathrm{RH}\quad\Longleftrightarrow\quad
 \sup_{V\ge0}|\mathcal T_R^-(V)|<\infty
 \text{ for every }R\text{ in some unbounded set}.
 \quad}                                                        \tag{16}
\]
More sharply, if RH is false, the same nonreal pole and positive-
Laplace Landau argument used for the
[even row](theta-coherent-kernel-ground-pole-detection.md) shows
\(\limsup_{V\to\infty}\mathcal T_R^-(V)=+\infty\) and
\(\liminf_{V\to\infty}\mathcal T_R^-(V)=-\infty\) for every
sufficiently large core detecting a fixed off-critical zero. The
convergence abscissa is at most \(1/2\) by (10) and (7); the
continuation has no positive-real singularity in that range, as
needed for Landau's theorem.

This odd detector does not bound the common-score residual: the
ground sign action is already matched in the positive covariance
comparison. No unconditional row bound, affine sign, or RH proof is
claimed. [OddWeakGroundPrimeReflectionFinite.lean](BuildingBlocks/OddWeakGroundPrimeReflectionFinite.lean)
compiles the odd parity, reflected-bracket, and finite actual
von Mangoldt weighted identity behind (6), away from the null
equality set \(u=\log n\). Its axioms are the standard
`propext`, `Classical.choice`, and `Quot.sound`. The weak-domain,
measure-zero passage, infinite prime summation, and Mellin
continuation remain written mathematics, not Lean formalizations.
