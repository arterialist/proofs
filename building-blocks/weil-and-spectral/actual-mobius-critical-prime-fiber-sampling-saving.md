# Sampling saving on the critical prime fiber

**Status.** This note proves an unconditional written mean-square estimate
for a prime-restricted diagonal slice at the three-fifths Möbius endpoint. Lean
checks the complete exponent ledger in
[`ActualMobiusCriticalPrimeFiberSampling.lean`](../../formalization/BuildingBlocks/ActualMobiusCriticalPrimeFiberSampling.lean).
The continuous Hilbert inequality and sampling argument are written
analysis.  The exact K=3 history count shows that the live all-unit cross
has unrestricted integer factors, so this prime slice is not the complete
residual.  This result does not control that residual, extend the complete
Möbius prefix, or prove the Riemann hypothesis.

## Statement

Let

\[
 2<\lambda<\frac{29}{14},\qquad N=T^\lambda,
\]

and at the critical endpoint put

\[
 P=T^{1-2\lambda/5},\qquad Q=T^{\lambda/5},\qquad
 C=T^{4\lambda/5-1}.
\tag{1}
\]

Thus

\[
 CP=Q^2,\qquad CPQ=Q^3=T^{3\lambda/5},\qquad N=Q^5,
 \qquad P<Q.
\tag{2}
\]

Let \(a_c(\theta)\) and \(b_p(\theta)\) be separated packet coefficients
after restricting an ordered all-unit split in the critical K=3 fiber to a
prime `q`.  The history coefficient is positive; the notation does not
assign separate Möbius signs to `p` and `q`.  This restriction belongs to
the sampling theorem, not to the complete K=3 residual.  The
established Fourier--Mellin separator has total \(L^1\)-mass
\(T^\varepsilon\); within each component its \(k\)- and \(q\)-weights are
bounded scalars and the following \(r\)-coefficient is common to every
sample. No arbitrary joint weight \(W_{k,q}(r)\) is allowed. Uniformly in
the separator parameter \(\theta\), assume the established fixed divisor
bounds and set

\[
 R_\theta(r)=
 \sum_{\substack{c\asymp C,\ p\asymp P\\cp=r}}
 a_c(\theta)b_p(\theta).
\tag{3}
\]

For either sign of the physical Poisson modes, define the exact diagonal
prime-fiber energy

\[
 \mathcal E_{=}(\theta)=
 \sum_{k\asymp P}
 \sum_{\substack{q\asymp Q\\q\ {\rm prime}}}
 \left|
   \sum_{r\asymp Q^2}R_\theta(r)
   e\!\left(\mp\frac{kN}{qr}\right)
 \right|^2.
\tag{4}
\]

Then, for every fixed \(\varepsilon>0\),

\[
 \boxed{\mathcal E_{=}(\theta)
 \ll_\varepsilon T^\varepsilon P Q^4.}
\tag{5}
\]

The bound is uniform in the separated component. In particular, since the
unsaved target is \(PQ^5\), equation (5) supplies a full factor \(Q^{-1}\):

\[
 \mathcal E_{=}(\theta)
 \ll P Q^5 T^{-2\rho}
 \qquad\left(0<\rho<\frac{\lambda}{10}\right),
\tag{6}
\]

after absorbing the fixed \(T^\varepsilon\) loss.

Minkowski's inequality over the separator, followed by its
\(T^\varepsilon\) total \(L^1\)-mass bound, gives the same estimate for the
actual superposed \(q=q'\) residual, with one further \(T^\varepsilon\)
loss.

## Coefficient norm

The product cutoff in (3) is retained. Fixed divisor bounds imply

\[
 |R_\theta(r)|\ll \tau(r)^A
\]

for a fixed \(A\), uniformly in \(\theta\). The standard fixed
divisor-moment bound therefore gives

\[
 \boxed{\|R_\theta\|_2^2
 =\sum_{r\asymp Q^2}|R_\theta(r)|^2
 \ll_\varepsilon T^\varepsilon Q^2.}
\tag{7}
\]

Hard factor-product cutoffs and dyadic endpoints do not require an
extension of (7): partial summation or the existing finite Perron separator
places their bounded-variation factors into \(a_c(\theta),b_p(\theta)\), at
the already allowed \(T^\varepsilon\) cost. No character is inserted into
an unweighted variable after the collapse (3).

## Continuous sampling proof

Write \(R_0=CP\asymp Q^2\), and set

\[
 \mathcal Q=\frac{N}{R_0^2}\asymp Q,
 \qquad x_{k,q}=\frac{k\mathcal Q}{q},
 \qquad y_r=\frac{N}{\mathcal Qr}=\frac{R_0^2}{r}.
\tag{8}
\]

The rescaling preserves the phase exactly:

\[
 x_{k,q}y_r=\frac{kN}{qr}.
\tag{9}
\]

For distinct \(r,r'\asymp R_0\),

\[
 |y_r-y_{r'}|
 =\frac{R_0^2|r-r'|}{rr'}\gg |r-r'|,
 \qquad |y_r|\ll Q^2.
\tag{10}
\]

Put

\[
 F_\theta(x)=\sum_{r\asymp R_0}R_\theta(r)e(-xy_r).
\tag{11}
\]

Expanding the integral and applying the continuous form of the
Montgomery--Vaughan
[*Hilbert inequality*, Corollary 2](https://doi.org/10.1112/jlms/s2-8.1.73)
to the endpoint Hilbert forms gives, on every interval \(I\) of length
\(O(P)\),

\[
 \int_I|F_\theta(x)|^2dx\ll P\|R_\theta\|_2^2,
\qquad
 \int_I|F_\theta'(x)|^2dx
 \ll P Q^4\|R_\theta\|_2^2.
\tag{12}
\]

Distinct sample points are \(\gg Q^{-1}\)-separated. Indeed,

\[
 |x_{k,q}-x_{k',q'}|
 \gg Q\left|\frac{k}{q}-\frac{k'}{q'}\right|
 \geq \frac{Q}{qq'}\gg Q^{-1}.
\tag{13}
\]

There are no repeated reduced fractions: because \(q,q'\) are prime and
\(k,k'<Q\), equality \(k/q=k'/q'\) forces \(q=q'\) and \(k=k'\).
All sample points lie in an interval of length \(O(P)\).

Choose disjoint intervals \(I_j\), centered at the sample points, of
length \(\asymp Q^{-1}\). Averaging the fundamental-theorem-of-calculus
identity for \(|F_\theta|^2\) on each \(I_j\), summing, and using
Cauchy--Schwarz yields

\[
\begin{aligned}
 \sum_{k\asymp P}\sum_{q\asymp Q\atop q\ {\rm prime}}
 |F_\theta(x_{k,q})|^2
 &\ll Q\int_I|F_\theta(x)|^2dx
       +\int_I|F_\theta(x)F_\theta'(x)|dx\\
 &\ll P Q^2\|R_\theta\|_2^2.
\end{aligned}
\tag{14}
\]

Equations (7), (9), and (14) prove (5). Negative Poisson modes give the
complex-conjugate phase and the identical estimate. The exact zero mode is
absent from (4); in the parent Möbius packet it is removed by the established
pole-null moment identities before the nonzero shells are separated.

## Scope of the gain

This estimate controls the \(q=q'\) term after the square is expanded. If
one first applies Cauchy--Schwarz to the coherent \(q\)-sum in the full
shell, the extra factor \(Q\) changes (5) back into

\[
 Q\mathcal E_{=}\ll T^\varepsilon P Q^5,
\tag{15}
\]

which has \(\rho=0\). Thus (5) rigorously removes the formerly saturated
diagonal prime fiber, but it cannot be promoted to a full-shell saving by
that Cauchy step. The two-prime off-diagonal must retain both \(q\) variables
and obtain cancellation across its nonzero aliases.
