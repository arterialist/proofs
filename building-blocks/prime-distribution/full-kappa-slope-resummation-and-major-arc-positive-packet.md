# Full slope resummation and the surviving major-arc packet

This note resums the complete pair of affine slopes before estimating the
finite-\(X\) bulk form.  The clock coefficient \(\kappa_{a+b-2}\) is an exact
discrete difference, and its rectangular slope sum has a closed
factorial-logarithm formula.  The resulting boundary kernel is strictly
positive.  Thus the full clock sum does not cancel the zero-frequency
Type II component.  An actual prime packet remains positive at quadratic
scale, including after its diagonal is removed.

## 1. The clock coefficient is an exact slope difference

Let

\[
 g_m=m\log\frac{m}{m+1},\qquad g_0=0.
 \tag{1}
\]

The exact coefficient from the original clock is

\[
 \kappa_m
 =m\log m-(2m+1)\log(m+1)+(m+1)\log(m+2).
 \tag{2}
\]

Direct subtraction gives

\[
 \boxed{\kappa_m=g_m-g_{m+1}>0.}
 \tag{3}
\]

If

\[
 F(q)=\sum_{m\ge0}\kappa_mq^m,
 \qquad 0<q<1,
 \tag{4}
\]

then the full two-slope generating function is

\[
\boxed{
 \sum_{a,b\ge1}\kappa_{a+b-2}x^ay^b
 =xy\frac{xF(x)-yF(y)}{x-y},}
 \tag{5}
\]

with the diagonal value obtained by continuity.  The clock integral gives

\[
 F(q)=\int_0^\infty
 w(t)\frac{(1-e^{-t})^2}{1-qe^{-t}}dt.
 \tag{6}
\]

Equations (5)--(6) retain the pole, gamma/proper-power clock correction,
and every slope.  For \(x,y\in(0,1)\), every coefficient in (5) is
positive; the generating function contains no internal zero.

## 2. Closed rectangular slope boundary

For integers \(A,B\ge1\), put

\[
 K(A,B)=\sum_{a=1}^A\sum_{b=1}^B\kappa_{a+b-2}.
 \tag{7}
\]

Define

\[
 H(n)=\sum_{m=1}^ng_m
 =\log\frac{n!}{(n+1)^n},
 \qquad H(0)=0.
 \tag{8}
\]

Writing \(r=\min(A,B)\), \(s=\max(A,B)\), summation by parts in
\(m=a+b-2\) gives the exact boundary formula

\[
\boxed{
 K(A,B)=H(r-1)+H(s-1)-H(r+s-1).}
 \tag{9}
\]

Indeed, the multiplicity of \(m\) rises with slope \(+1\), is constant,
and then falls with slope \(-1\); (3) leaves precisely the three endpoints
in (9).  Formula (7) also shows

\[
 K(A,B)>0,
 \qquad K(A+1,B)>K(A,B),
 \qquad K(A,B+1)>K(A,B).
 \tag{10}
\]

Thus discrete integration by parts does act on the slope sum, but its
output is the positive boundary (9), not a vanishing boundary.

## 3. Exact full-\(\kappa\) Möbius--Stokes form

Recall

\[
 \mathcal G_X(d,e)=
 \sum_{a,b\ge1}\kappa_{a+b-2}e^{-2\max(ad,be)/X}.
 \tag{11}
\]

The tail-indicator identity

\[
 e^{-2\max(A,B)/X}
 =2\int_{\max(A/X,B/X)}^\infty e^{-2v}dv
 \tag{12}
\]

allows the entire slope pair to be summed first.  With the convention
\(K(0,B)=K(A,0)=0\), one obtains

\[
\boxed{
 \mathcal G_X(d,e)
 =2\int_0^\infty e^{-2v}
 K\!\left(\left\lfloor\frac{Xv}{d}\right\rfloor,
          \left\lfloor\frac{Xv}{e}\right\rfloor\right)dv.}
 \tag{13}
\]

This is an exact closed resummation, not a truncation to \(a=b=1\).
Substitution of (9) leaves only the three explicit \(H\)-boundaries at
each pair of moving floors.

Let

\[
 D_X=\lceil\sqrt X\rceil,
 \qquad T_X=\lceil X\log X\rceil,
 \qquad
 M_X(u)=\sum_{D_X<d<T_X}\mu(d)1_{d\le u}.
 \tag{14}
\]

The exact affine bulk becomes

\[
\boxed{\begin{aligned}
 \mathfrak A_X^{\rm bulk}
 =2\int_0^\infty e^{-2v}
 \sum_{\substack{D_X<d<T_X\\D_X<e<T_X}}
 \mu(d)\mu(e)
 K\!\left(\left\lfloor\frac{Xv}{d}\right\rfloor,
          \left\lfloor\frac{Xv}{e}\right\rfloor\right)dv.
\end{aligned}}
 \tag{15}
\]

Equivalently, before the rectangular resummation, define the strict
dilated prefixes

\[
 M_{X,a}(v)=
 \sum_{D_X<d<\min(T_X,Xv/a)}\mu(d).
 \tag{16}
\]

Then

\[
\boxed{
 \mathfrak A_X^{\rm bulk}
 =2\int_0^\infty e^{-2v}
 \sum_{a,b\ge1}\kappa_{a+b-2}
 M_{X,a}(v)M_{X,b}(v)dv.}
 \tag{17}
\]

Equations (15) and (17) are the requested weighted Möbius--Stokes
boundary.  The commutator with the strict bulk projection occurs at

\[
 d=D_X,\qquad d=T_X,\qquad d=Xv/a;
 \tag{18}
\]

these are exactly the endpoints in (16).  The full-\(\kappa\) slope
summation replaces the interior clock modes by (9), but it neither deletes
these arithmetic endpoints nor imposes a zero on their Möbius values.

## 4. No zero-frequency Type II cancellation across slopes

For a bilinear arithmetic packet \(c_d\), its fully slope-summed
zero-frequency form is

\[
 \mathcal Q_X(c)=
 2\int_0^\infty e^{-2v}
 \sum_{d,e}c_dc_e
 K\!\left(\left\lfloor\frac{Xv}{d}\right\rfloor,
          \left\lfloor\frac{Xv}{e}\right\rfloor\right)dv.
 \tag{19}
\]

The proposed slope cancellation would require a zero boundary after (3)
is summed.  Formula (9) gives the opposite conclusion: for every active
pair \(d,e\), the resummed boundary is strictly positive.  Any cancellation
in (15) must therefore come from the products \(\mu(d)\mu(e)\), across
different arithmetic packets.  It does not come from the slope pair.

This can be seen without isolating a single clock mode.  Define the
strictly positive full-slope constant

\[
\begin{aligned}
 c_\kappa
 &:={2}\int_0^\infty e^{-2v}K(\lfloor v\rfloor,\lfloor v\rfloor)dv\\
 &=(1-e^{-2})\sum_{n\ge1}e^{-2n}
 \{2H(n-1)-H(2n-1)\}>0.
\end{aligned}
 \tag{20}
\]

This constant contains every pair \((a,b)\); it is exactly
\(\mathcal G_X(X,X)\).  By monotonicity in (10),

\[
 \mathcal G_X(d,e)\ge c_\kappa
 \qquad(X/2<d,e\le X).
 \tag{21}
\]

Let

\[
 P_X=-\sum_{X/2<p\le X}\Phi_{X,p}.
 \tag{22}
\]

For large \(X\), every index in (22) lies strictly inside the bulk and has
its actual coefficient \(\mu(p)=-1\).  Therefore

\[
\boxed{
 \|P_X\|^2
 =\sum_{X/2<p,q\le X}\mathcal G_X(p,q)
 \ge c_\kappa\{\pi(X)-\pi(X/2)\}^2
 \gg\frac{X^2}{\log^2X}.}
 \tag{23}
\]

Even after deleting the diagonal, the off-diagonal row is

\[
 2\sum_{X/2<p<q\le X}\mathcal G_X(p,q)
 \ge c_\kappa N_X(N_X-1)
 \gg\frac{X^2}{\log^2X},
 \tag{24}
\]

where \(N_X=\pi(X)-\pi(X/2)\).  Equations (20)--(24) use the complete
slope-resummed kernel, rather than the \(a=b=1\) subkernel.

There is also a finite complete-packet example with no omitted cofactor.
For \(X=4\), the strict bulk is \(\{3,4,5\}\), and the two nonzero
largest-prime packets are

\[
 U_3=-\Phi_{4,3},
 \qquad U_5=-\Phi_{4,5}.
 \tag{25}
\]

Their fully resummed major-arc row is

\[
\boxed{
 2\langle U_3,U_5\rangle
 =4\int_0^\infty e^{-2v}
 K\!\left(\left\lfloor\frac{4v}{3}\right\rfloor,
          \left\lfloor\frac{4v}{5}\right\rfloor\right)dv>0.}
 \tag{26}
\]

This retains the exact moving cofactor endpoints: both admissible cofactor
sets are \(\{1\}\).  It is an actual Möbius-packet counterexample to a
universal slope-summed nonpositive Type II row.

## 5. Consequence for the bulk bound and the far remainder

The full-circle, full-clock identity is

\[
 \mathcal E_X=\frac{\mathfrak A_X}{1-e^{-2/X}},
 \tag{27}
\]

and the paid corner and tail reduce the desired estimate to

\[
 \mathfrak A_X^{\rm bulk}\ll_\varepsilon X^{1+\varepsilon}
 \quad\Longrightarrow\quad
 R_X^\varepsilon\ll_\varepsilon X^{2+\varepsilon}.
 \tag{28}
\]

The prime packet (23) is larger than the allowance in (28) for every fixed
\(\varepsilon<1\).  Hence its positive full-slope row and off-diagonal
part must be canceled by prime--composite and composite--composite terms in
(15).  The exact sufficient inequality is

\[
\boxed{
 2\langle P_X,F_X^{\rm bulk}-P_X\rangle
 +\|F_X^{\rm bulk}-P_X\|^2
 \le-\|P_X\|^2+O_\varepsilon(X^{1+\varepsilon}).}
 \tag{29}
\]

The resummation (9) supplies no extra negative term toward (29).  It gives
an explicit positive boundary kernel multiplying the same affine Möbius
correlations.

## 6. No additional adelic or KMS compensation

The conclusion here is tied to the exact observable, rather than to a
generic positivity claim.  In the affine Toeplitz representation,
\(V_mS=S^mV_m\) produces the histories \(a,b\), and the original clock
state evaluates their covariance as \(\kappa_{a+b-2}\).  Resumming that
literal covariance gives (9) and (13).  A Bost--Connes/KMS observable that
reproduces the required finite-\(X\) form must therefore evaluate the
packet (22) as the same positive number (23).  Its partition function or
KMS positivity adds no term to (15).

Likewise, the archimedean pole/gamma/proper-power compensation is already
the coefficient (2), equivalently the clock integral (6).  A product-formula
reorganization of finite places can rewrite the Möbius coefficients, but
it cannot alter the positive boundary \(K(A,B)\) without changing the
observable away from \(\mathfrak A_X^{\rm bulk}\).  Thus neither framework
provides an independent archimedean cancellation of (23); the missing
work remains the signed arithmetic cross (29).

The result is a structural obstruction, not an RH assertion.  Strict
division, both bulk endpoints, every slope, and the original weight are
retained throughout.
