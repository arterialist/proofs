# Independent audit of the effective radius-two compact barrier

This note audits the two companion calculations

- `theta-radius-two-effective-strip-lower-bound.md`, and
- `theta-compact-strip-rational-rate-and-schur.md`

in the shared `rh-coarse-energy-lean-bridge/work/arithmetic-coupling`
directory.  It also uses the separately audited outer-return calculation
there.  The normalization throughout is

\[
 b(u)=2\cosh(u/2),\qquad d\nu=b\Phi\,du,\qquad
 \int_{\mathbb R}b\Phi=1,
\]

\[
 d_0=10^{-546},\quad M=10^{500},\quad U=25,820,006,
 \quad
 w=1+(M-1)\chi(|u|-5)
\]

on \(O_2=\mathbb R\setminus[-2,2]\), with zero extension to the killed
core.  Every occurrence of a prime sum below includes every prime power.

## 1. Generator signs and the hard boundary

The positive killed generator has

\[
 D_{\rm c}w(u)=\frac1{b(u)}\int_{\mathbb R}
 \Phi(v)r(|u-v|)[w(u)-w(v)]\,dv
\]

and

\[
 D_{\rm p}w(u)=\frac1{b(u)}\sum_{n\ge2}
 \frac{\Lambda(n)}{\sqrt n}
 \sum_{\sigma=\pm1}\Phi(u+\sigma\log n)
 [w(u)-w(u+\sigma\log n)].
\]

Thus a jump into the zero-valued core has the favorable sign in both
parts.  The strip proof discards those favorable terms; it does not
replace the killed trace by the exterior trace.  At the two hard endpoints
the pointwise formula is required only almost everywhere.  The previously
proved hard-indicator domain theorem plus the compactly supported smooth
transition puts this \(w\) in \(D(D)\).  Hence the a.e. barrier is the
right statement for the semigroup comparison.  Prime powers landing
exactly at an endpoint form only a countable exceptional set and do not
alter it.

## 2. Continuous lower bound

For all \(t>0\),

\[
 tr(t)=\frac{te^{-t/2}}{1-e^{-2t}}\le1.
\]

For \(0<t\le1\), use
\(1-e^{-2t}\ge2t/(1+2t)\) and
\(2/(1+2t)\ge e^{-t/2}\).  For \(t\ge1\), use
\(te^{-t/2}\le2/e<1-e^{-2}\).  If a continuous destination has
\(w(v)>w(u)\), both points are exterior and radial monotonicity gives

\[
 0<w(v)-w(u)\le2M\,||v|-|u||\le2M|v-u|.
\]

Because \(b\ge2\) and
\(\int\Phi\le\frac12\int b\Phi=1/2\), this proves

\[
 \boxed{D_{\rm c}w(u)\ge-M/2.}
\]

The estimate remains valid arbitrarily close to the hard boundary because
the omitted core killing is nonnegative.  No finite total continuous jump
rate is being asserted; the factor \(|u-v|\) cancels the diagonal
singularity.

## 3. Full-prime departure audit

Let

\[
 \beta_{\rm p}(u)=\frac1{b(u)}\sum_{n\ge2}
 \frac{\Lambda(n)}{\sqrt n}
 [\Phi(u-\log n)+\Phi(u+\log n)].
\]

The elementary Chebyshev inequality
\(\psi(x)\le4(\log2)x<3x\) implies, for every integer \(j\ge0\),

\[
 \sum_{e^j\le n<e^{j+1}}\frac{\Lambda(n)}{\sqrt n}
 \le3e\,e^{j/2}.
\]

This is a Stieltjes shell bound for the full \(\psi\), so proper powers
are present.  For \(u\ge2\), division by
\(b(u)\ge e^{u/2}\) sends either destination shell to a translated
unit interval of

\[
 G(v)=e^{|v|/2}\Phi(v).
\]

Each translated unit interval meets at most two integer unit intervals.
The factor is therefore two for each orientation, four in total:

\[
 \beta_{\rm p}(u)\le12eT,
 \qquad
 T=\sum_{k\in\mathbb Z}\sup_{[k,k+1]}G.
\]

The complete-theta envelope

\[
 G(t)\le128e^{5t-3e^{2t}}\quad(t\ge0)
\]

is decreasing.  Its value at zero is below \(7\), its value at one is
below \(1/64\), and the subsequent ratio is below \(1/2\).  Evenness
then gives \(T<16\), and hence

\[
 \boxed{\beta_{\rm p}(u)<576\quad(|u|\ge2).}
\]

There is no missing orientation or prime-power shell in this count.
Since \(w(u)-w(v)\ge-M\),

\[
 D_{\rm p}w(u)>-576M.
\]

Combining the two generator pieces with
\(0<1/2-d_0<1/2\) gives the audited rational enclosure

\[
 \boxed{
 (D-(1/2-d_0))w>-577M>-10^{503}
 }
\]

almost everywhere on the whole exterior.  Since
\(\alpha_2<1/2-d_0\), multiplication by \(w\ge0\) gives the same
lower bound for \((D-\alpha_2)w\).  In particular it applies on
\(2<|u|\le U\).  No subdivision of that large interval is needed.

## 4. Rational outward rate and the barrier

For \(2<|u|\le U\), take the outward ray
\(v=u+\operatorname{sgn}(u)t\), \(0\le t\le1/2\).  Positivity of the
first theta summand, together with only
\(3<\pi<4\) and \(2<e<3\), gives

\[
 \frac{\Phi(v)}{b(u)}>c_*:=9\,3^{-H},
\]

where

\[
 Y=4\,3^{51,640,013},\qquad
 H=Y+12,910,003.
\]

The exponent \(51,640,013=2U+1\) is correct for
\(|v|\le U+1/2\), and \(12,910,003=U/2\).  This is a uniform
rational estimate and uses no unstated monotonicity of \(\Phi/b\).

For \(0<\varepsilon<1/2\),
\(r(t)>1/(4t)\) on this ray.  Therefore

\[
 q_\varepsilon(u)>
 \frac{c_*}{4}\log\frac{1/2}{\varepsilon}.
\]

With

\[
 B_*=5\cdot10^{503}3^{H-2},
 \qquad
 \boxed{\varepsilon_*=(2\,3^{B_*})^{-1}},
\]

the identities \(c_*^{-1}=3^{H-2}\) and \(\log3>1\) give

\[
 q_{\varepsilon_*}>
 10^{503}+\frac1{8\cdot10^{46}}.
\]

Because \(K_{\varepsilon_*}w\ge q_{\varepsilon_*}\), this pays the
compact defect and proves

\[
 (A_{\varepsilon_*}-\alpha_2)w
 \ge\delta_*w,
 \qquad
 \delta_*:=\frac{d_0}{8},
\]

on the compact strip.  The audited outer-return theorem gives
\((D-\alpha_2)w\ge dM/4>2\delta_*M\) beyond \(U\), so the same
barrier holds globally.  Using \(\delta_*\), rather than the symbolic
\(d/8\), is legitimate and is exactly what makes the final resolvent
constant rational.

## 5. Schur and resolvent constants

Since \(r\) decreases and \(d\nu=b\Phi\,dv\),

\[
 \int_{O_2}\frac{\Phi}{b}\,dv
 =\int_{O_2}b^{-2}\,d\nu\le\frac14.
\]

Thus the stated pointwise Schur estimate gives

\[
 C_\varepsilon\le\frac{r(\varepsilon)}4
 \le\frac1{4\varepsilon}
 \quad(0<\varepsilon\le1/2).
\]

Consequently

\[
 \boxed{C_{\varepsilon_*}\le\frac{3^{B_*}}2},
 \qquad
 \boxed{\|\psi_2\|_\infty
 \le4\cdot10^{1046}3^{B_*}}.
\]

The last implication is the established positive-semigroup resolvent
argument for \(A_{\varepsilon_*}=D+K_{\varepsilon_*}\).  It is not an
inverse of \(D-\alpha_2\) at its ground pole.

## 6. Scope and exact remaining theorem

The two calculations pass this audit.  Their inputs are unconditional:
the rational radius-two Rayleigh gap, elementary Chebyshev, complete theta
envelopes and normalization, and the effective full-Chebyshev outer
return.  No zero-location statement, RH-equivalent cancellation, finite
prime truncation, or hidden selfadjoint spectral premise enters.

They close the previously non-effective compact-barrier datum and give an
explicit \(P_\infty\) for later theta ground-tail and crossing estimates.
If a downstream ground-tail numerical formula is used, its separate
constant \(C_\theta\) and its displayed theta integrals must still be
enclosed; those are not part of this Schur calculation.

For the live central-arc argument, this result supplies only an explicit
theta-side bounded-ground constant.  It does not provide the missing
form-preserving map from the original Lambert/Moebius central-arc field to
the theta form, and it does not control the surviving affine
\((1,2)\) correlation.  The exact remaining arithmetic theorem is still

\[
 \boxed{\mathcal R_X^\varepsilon\ll_\varepsilon X^{2+\varepsilon}}
\]

for the full uncentered central-above-curve remainder with the radial and
truncated-orthogonality reserves retained (equivalently, the required
one-sided bound for its signed off-diagonal covariance after the paid
diagonal).  Existing terminal reductions show that treating this estimate
as automatic would import the unresolved RH-level input.  The explicit
barrier constants do not change that status.
