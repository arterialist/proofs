# Low additive modes of the coarse prime primitive

**Status:** unconditional written Fourier reduction, 20 September 2026.
The finite identities retain every von Mangoldt prime power and both dyadic
endpoints. The bounded-variation estimate gives an unconditional
high-frequency tail. The terminal, centered zero-mode, and low prime-twist
bounds isolated below are not proved, so this note does not establish
`CoarsePrimitiveBound` or the Riemann hypothesis. No Lean formalization of
the Fourier and bounded-variation steps is claimed.

## Exact spectral decomposition

Let \(X\ge1\) be an integer, write

\[
 E(x)=\psi(\lfloor x\rfloor)-x,
 \qquad
 P(u)=\int_X^{X+u}E(x)\,dx\quad(0\le u\le X),
 \]

and put

\[
 M=P(X),\qquad
 \mu=\frac1X\int_0^X P(u)\,du,
 \qquad
 \widehat P(j)=\frac1X\int_0^X P(u)e(-ju/X)\,du.
 \tag{1}
\]

The suffix primitive is \(M-P(u)\). Parseval on \([0,X]\) therefore gives
the exact identity

\[
 \boxed{
 S_X=X\left\{
 \frac{M^2}{2}+2\left|\mu-\frac M2\right|^2
 +2\sum_{j\ne0}|\widehat P(j)|^2
 \right\}.}
 \tag{2}
\]

Indeed, the two zero Fourier coefficients are \(\mu\) and \(M-\mu\),
while every nonzero coefficient occurs with opposite sign in the two
primitives. Thus
\(|\mu|^2+|M-\mu|^2=M^2/2+2|\mu-M/2|^2\). Formula (2) separates the exact
terminal mass, the centered zero mode, and all oscillatory modes without
discarding a cross term.

The terminal and centered zero modes are themselves the finite weighted
prime-error moments

\[
 M=\int_X^{2X}E(x)\,dx,
 \qquad
 Z:=\mu-\frac M2
 =\frac1X\int_0^X\left(\frac X2-u\right)E(X+u)\,du.
 \tag{3}
\]

The existing exact terminal formula may be used for \(M\):

\[
 M=X\psi(X)+\sum_{X<n\le2X}(2X-n)\Lambda(n)-\frac32X^2.
 \tag{4}
\]

The coefficient of \(n=2X\) in (4) is literally zero.

The centered mode has an equally finite arithmetic form:

\[
 \boxed{
 Z=\frac{X^2}{12}
 +\frac1{2X}\sum_{X<n\le2X}
 (n-X)(n-2X)\Lambda(n).}
 \tag{4a}
\]

Here the constant \(\psi(X)\) disappears because its centered weight has
integral zero. The coefficient at \(n=2X\) again vanishes literally, and
every proper prime power in the block remains in the sum.

## Finite Vaughan audit of the centered mode

Put

\[
 K_X(n)=\frac{(n-X)(n-2X)}{2X}\,1_{X<n\le2X}.
 \tag{4b}
\]

Then (4a) is \(Z=X^2/12+\sum_n\Lambda(n)K_X(n)\). If
\(R(t)=\psi(t)-t\), Stieltjes summation with the two literal endpoint zeros
of \(K_X\) gives the exact identity

\[
 \boxed{
 Z=-\int_X^{2X}R(t)\left(\frac tX-\frac32\right)\,dt.}
 \tag{4c}
\]

Thus this centered quantity is already a signed, once-smoothed PNT error;
the quadratic prime weight does not create a new nonzero additive
frequency.

For

\[
 \Phi(X)=\frac{(\log X)^{3/5}}{(\log\log X)^{1/5}},\qquad
 d=\left(\frac{5^6}{2^2 3^4(48.0718)^3}\right)^{1/5}
 =0.212579202\ldots,
\]

the unconditional Vinogradov--Korobov transfer gives, for each fixed
\(\delta>0\),

\[
 R(t)\ll_\delta t\exp[-(d-\delta)\Phi(t)].
\]

Consequently (4c) gives the strongest presently justified direct bound
used here:

\[
 \boxed{
 Z\ll_\delta X^2\exp[-(d-\delta)\Phi(X)].}
 \tag{4d}
\]

The constant \(d\) comes from Bellotti's independent
[Vinogradov--Korobov zero-free region](https://arxiv.org/abs/2306.10680)
through Johnston's
[PNT transfer theorem](https://arxiv.org/abs/2411.13791). Polynomial
logarithmic factors in that transfer are absorbed by \(\delta\Phi(X)\).
This statement does not use the later disputed sharp density-to-PNT
claim. Passing from (4c) to (4d) loses the sign change at \(t=3X/2\), a
factor \(X\) from the integration length, and an arbitrarily small amount
\(\delta\) in the Vinogradov--Korobov exponent. It loses no prime powers or
endpoint terms.

The finite Vaughan identity shows exactly where a direct attempt to
recover that sign cancellation stops. For \(U,V<X\), let
\(\mu_{\le V}=\mu1_{[1,V]}\) and
\(\Lambda_{\le U}=\Lambda1_{[1,U]}\). Substitution of

\[
 \Lambda=\mu_{\le V}*\log+\Lambda_{\le U}
 -\Lambda_{\le U}*\mu_{\le V}*1
 +\mu_{>V}*\Lambda_{>U}*1
\]

into (4a) gives the exact finite decomposition

\[
\begin{aligned}
 Z={}&\frac{X^2}{12}
 +\sum_{r\le V}\mu(r)\sum_\ell(\log\ell)K_X(r\ell)\\
 &-\sum_{\substack{r\le V\\s\le U}}
   \mu(r)\Lambda(s)\sum_\ell K_X(rs\ell)
 +\sum_{\substack{r>V\\s>U}}
   \mu(r)\Lambda(s)\sum_\ell K_X(rs\ell).
 \tag{4e}
\end{aligned}
\]

The missing \(\Lambda_{\le U}\) term is literally zero because \(K_X\)
is supported above \(X>U\). The last line is the balanced Type II term.
The same principal term survives in a Heath--Brown identity, split among
more factors.

The polynomial is useful in each inner progression:

\[
 \sum_\ell K_X(q\ell)=-\frac{X^2}{12q}+O(X),
 \tag{4f}
\]

uniformly in \(q\), by bounded variation. The corresponding logarithmic
inner sum has an \(O(X\log X)\) discretization error. The principal terms
of all lines of (4e) recombine with \(X^2/12\); estimating the lines
separately destroys that cancellation. With \(U=V=X^{1/3}\), absolute
summation of the Type II discretization errors already costs
\(O(X^2\log X)\), while the original Chebyshev bound is only \(O(X^2)\).
Cauchy--Schwarz does not repair this because the phase is exactly zero.

If the \(r\)-variable in the principal Type II term is summed first, the
remaining object is a weighted partial sum of \(\mu(r)\). The known
zero-free-region Mertens estimate reproduces the subexponential scale in
(4d). Replacing it by

\[
 \sum_{r\le y}\mu(r)\ll_\varepsilon y^{1/2+\varepsilon}
\]

would supply the required square-root scale for that exposed factor, but
that uniform Mertens estimate is equivalent to RH; the other decomposed
terms would still have to be recombined without absolute-value losses.
Keeping \(r\) and \(s\) coupled would require a new principal-arc Type II
cancellation of the same strength; no classical Vaughan or Heath--Brown
estimate supplies it. This is the stopping point, not a new input to
assume.

There are two immediate falsifiers for a claimed closure. First, for every
fixed \(\varepsilon<1/2\),

\[
 \frac{X^2e^{-(d-\delta)\Phi(X)}}{X^{3/2+\varepsilon}}
 =X^{1/2-\varepsilon}e^{-(d-\delta)\Phi(X)}\longrightarrow\infty.
\]

Thus a Vinogradov--Korobov or Mertens subexponential saving does not reach
(12). Second, if

\[
 W(u)=\tfrac12(u-1)(u-2)1_{[1,2]}(u),
\]

then a zeta zero \(\rho\) enters the explicit formula for \(Z\) with the
scale \(X^{\rho+1}\widetilde W(\rho)\), where

\[
 \widetilde W(s)=\frac12\left(
 \frac{2^{s+2}-1}{s+2}
 -3\frac{2^{s+1}-1}{s+1}
 +2\frac{2^s-1}{s}\right).
 \tag{4g}
\]

The endpoint zeros give \(\widetilde W(\sigma+i\tau)=O_\sigma(|\tau|^{-2})\),
but they do not change the power \(X^{\Re\rho+1}\). A proposed
\(X^{3/2+\varepsilon}\) proof that treats this zero-frequency term only by
absolute zero-free-region or Möbius estimates has therefore hidden the
required square-root cancellation.

## Selberg self-coupling audit of the terminal mode

For real \(x\ge1\), define the exact first Riesz error

\[
 D(x)=\sum_{n\le x}(x-n)\Lambda(n)-\frac{x^2}{2}
 =\int_0^x(\psi(t)-t)\,dt.
 \tag{4h}
\]

For real \(y\ge1\), write \(M(y)=D(2y)-D(y)\). At integral \(X\), this is
literally the terminal mass:

\[
 M(X)=D(2X)-D(X).
 \tag{4i}
\]

Use Selberg's pointwise convolution identity

\[
 \Lambda(n)\log n+(\Lambda*\Lambda)(n)
 =(\mu*\log^2)(n).
 \tag{4j}
\]

Put \(G=\mu*\log^2\), and retain the complete Riesz increment

\[
 U_X=X\sum_{n\le X}G(n)
 +\sum_{X<n\le2X}(2X-n)G(n).
 \tag{4k}
\]

Summing (4j) with this increment gives the exact boundary identity

\[
\begin{aligned}
 U_X={}&X\sum_{n\le X}\Lambda(n)\log n
 +\sum_{X<n\le2X}(2X-n)\Lambda(n)\log n\\
 &+X\sum_{ab\le X}\Lambda(a)\Lambda(b)
 +\sum_{X<ab\le2X}(2X-ab)\Lambda(a)\Lambda(b).
 \tag{4l}
\end{aligned}
\]

Every equality sign in (4l) is finite. The terms \(n=X,2X\) and
\(ab=X,2X\) carry their displayed literal coefficients, and every proper
prime power remains.

The convolution increment in the second line has a useful exact form:

\[
\begin{aligned}
 &X\sum_{ab\le X}\Lambda(a)\Lambda(b)
 +\sum_{X<ab\le2X}(2X-ab)\Lambda(a)\Lambda(b)\\
 &\qquad=\sum_{a\le X}a\Lambda(a)M(X/a)
 +\frac32X^2\sum_{a\le X}\frac{\Lambda(a)}a.
 \tag{4m}
\end{aligned}
\]

To see the boundary cancellation, first write the Riesz convolution at
\(x\) as

\[
 \sum_{a\le x}a\Lambda(a)D(x/a)
 +\frac{x^2}{2}\sum_{a\le x}\frac{\Lambda(a)}a.
\]

For \(X<a\le2X\), one has \(1\le2X/a<2\), so
\(D(2X/a)=-(2X/a)^2/2\). These terms cancel the corresponding part of the
density sum exactly, leaving (4m).

Finally set

\[
 B_X^{\log}=X\sum_{n\le X}\Lambda(n)\log(n/X)
 +\sum_{X<n\le2X}(2X-n)\Lambda(n)\log(n/X).
\]

The first line of (4l) is
\((\log X)(M(X)+3X^2/2)+B_X^{\log}\). Therefore Selberg's identity gives
the exact self-coupling equation

\[
\boxed{\begin{aligned}
 (\log X)M(X)+\sum_{a\le X}a\Lambda(a)M(X/a)
 ={}&U_X-B_X^{\log}\\
 &-\frac32X^2\left(\log X+
 \sum_{a\le X}\frac{\Lambda(a)}a\right).
\end{aligned}}
 \tag{4n}
\]

This identity does not yield a contractive absolute-value estimate. With
\(m(y)=M(y)/y^2\), division by \(X^2\log X\) makes its self-coupling
operator

\[
 (T_Xm)(X)=\frac1{\log X}
 \sum_{a\le X}\frac{\Lambda(a)}a\,m(X/a).
 \tag{4o}
\]

Its positive \(L^\infty\)-operator mass is

\[
 \frac1{\log X}\sum_{a\le X}\frac{\Lambda(a)}a=1+o(1).
 \tag{4p}
\]

by the ordinary PNT. Thus taking absolute values in (4n) gives contraction
constant one, not a fixed \(\kappa<1\). Taking the three large terms on the
right separately is worse: each has scale \(X^2\log X\), and their density
main terms must cancel before the prime error is visible. Recovering a
fixed contraction would require a new signed correlation between
\(M(X/a)\) and the positive weights \(\Lambda(a)/a\); the Selberg identity
itself supplies no such sign.

The linearized explicit-formula mode is a direct falsifier. Up to an
irrelevant nonzero scalar, take \(R_\rho(x)=x^\rho\), with
\(1/2<\Re\rho<1\). Its Riesz increment is

\[
 M_\rho(X)=\frac{2^{\rho+1}-1}{\rho+1}X^{\rho+1}.
 \tag{4q}
\]

The coefficient is nonzero. After normalization by \(X^2\), this mode
tends to zero like \(X^{\Re\rho-1}\), so the qualitative contraction used
in Selberg's elementary PNT is fully compatible with it. At the required
normalization \(X^{3/2}\), however, it grows like
\(X^{\Re\rho-1/2}\). Hence a contraction at the latter scale would already
exclude the off-line mode rather than follow from Selberg self-coupling.

The same obstruction is visible before summation. If
\(L(s)=-\zeta'(s)/\zeta(s)\), the Dirichlet-series form of (4j) is the
tautology

\[
 -L'(s)+L(s)^2=\frac{\zeta''(s)}{\zeta(s)}.
 \tag{4r}
\]

Near a simple zero \(\rho\), one has
\(L(s)=-(s-\rho)^{-1}+O(1)\). The double poles in \(-L'\) and \(L^2\)
have coefficients \(-1\) and \(+1\), so they cancel with exact constant
one; the remaining simple pole agrees with \(\zeta''/\zeta\). The identity
is therefore algebraically compatible with a zero anywhere in
\(1/2<\Re\rho<1\) and cannot by itself improve its location.

The current unconditional estimate remains

\[
 |M(X)|\ll_\delta X^2\exp[-(d-\delta)\Phi(X)],
 \tag{4s}
\]

obtained directly from (4h) and the Vinogradov--Korobov PNT error. The
finite Selberg expansion preserves more algebra, but without an additional
signed estimate it gives no smaller exponent or fixed-power saving. This
is the precise stopping point; no contractive inequality is asserted.

## Exact prime twist in every nonzero mode

For \(j\in\mathbb Z\setminus\{0\}\), define

\[
 A_j(X)=\sum_{X<n\le2X}\Lambda(n)e(-jn/X),
 \qquad
 B_j(X)=A_j(X)-A_0(X)+X.
 \tag{5}
\]

Every sum in (5) includes proper prime powers. Since the constant
\(\psi(X)\) has zero \(j\)-th integral and the upper endpoint contributes
zero to \(e(-jn/X)-1\), exact cell integration gives

\[
 \int_X^{2X}E(x)e(-jx/X)\,dx
 =\frac{X}{2\pi i j}B_j(X).
 \tag{6}
\]

Integration by parts in \(P\), retaining \(P(X)=M\), now yields

\[
 \boxed{
 \widehat P(j)=
 \frac{1}{2\pi i j}
 \left(\frac{X}{2\pi i j}B_j(X)-M\right).}
 \tag{7}
\]

This is the required connection between coarse primitive energy and actual
additive prime twists. Omitting \(-M\) in (7) would lose the terminal mass.

## Uniform bounded-variation tail

Chebyshev's estimate gives
\(A_0(X)\ll X\). On \([X,2X]\), the total variation of \(E\), including
all positive jumps \(\Lambda(n)\) and the continuous slope \(-1\), is
\(O(X)\); its endpoint values are also \(O(X)\). Stieltjes integration by
parts in (6) consequently gives

\[
 \left|\int_X^{2X}E(x)e(-jx/X)\,dx\right|
 \ll \frac{X^2}{|j|}.
 \tag{8}
\]

Combining (7)--(8), for every \(J\ge1\),

\[
 \sum_{|j|>J}|\widehat P(j)|^2
 \ll \frac{X^4}{J^3}+\frac{M^2}{J}.
 \tag{9}
\]

Thus the contribution of the high modes to (2) is

\[
 \ll \frac{X^5}{J^3}+\frac{XM^2}{J}.
 \tag{10}
\]

The natural unconditional cutoff is

\[
 J_X=\lceil X^{1/3}\rceil.
 \tag{11}
\]

At this cutoff, the first term in (10) is \(O(X^4)\). If the terminal
condition \(M^2\ll_\varepsilon X^{3+\varepsilon}\) holds, the second term is
also \(O_\varepsilon(X^{4+\varepsilon})\).

## Exact low-mode input sufficient for the RH consumer

Equations (2), (7), and (9) give a phase-sensitive low-mode condition with
no triangle inequality inside a Fourier coefficient. The
`CoarsePrimitiveBound` follows from the following two uniform estimates on
dyadic integers \(X=2^k\): for every \(\varepsilon>0\),

\[
 \boxed{
 M^2+|Z|^2\ll_\varepsilon X^{3+\varepsilon},}
 \tag{12}
\]

and

\[
\boxed{
\sum_{1\le j\le J_X}
 \frac1{j^2}\left|
 \frac{X}{2\pi i j}B_j(X)-M
 \right|^2
 \ll_\varepsilon X^{3+\varepsilon}.}
\tag{13}
\]

Indeed, the exact contribution of the positive modes \(j\le J_X\) to
\(S_X\), after including their negative conjugates and both primitives, is

\[
 \frac X{\pi^2}\sum_{1\le j\le J_X}
 \frac1{j^2}\left|
 \frac{X}{2\pi i j}B_j(X)-M
 \right|^2.
 \tag{14}
\]

### Joint dispersion audit

Write

\[
 \mathcal L_J(X)=\sum_{1\le j\le J}\frac{|C_j(X)|^2}{j^2},
 \qquad
 C_j(X)=\frac{X}{2\pi i j}B_j(X)-M.
 \tag{14a}
\]

There is no need to separate the empirically unstable \(M\) cross term.
Equations (6)--(7) give the exact identities

\[
 C_j(X)=\int_X^{2X}E(x)\bigl(e(-jx/X)-1\bigr)\,dx
 =2\pi i j\widehat P(j),
 \tag{14b}
\]

and hence

\[
 \boxed{
 \mathcal L_J(X)=4\pi^2\sum_{1\le j\le J}|\widehat P(j)|^2.}
 \tag{14c}
\]

Equivalently, this is the positive dispersion form

\[
 \mathcal L_J(X)=
 \int_X^{2X}\!\int_X^{2X}E(x)E(y)
 \sum_{j=1}^{J}\frac{
 (e(-jx/X)-1)(e(jy/X)-1)}{j^2}\,dx\,dy.
 \tag{14d}
\]

For the full spectrum, Parseval gives

\[
 \mathcal L_\infty(X)=2\pi^2\left\{
 \frac1X\int_0^X|P(u)|^2\,du-|\mu|^2\right\}.
 \tag{14e}
\]

Thus the joint sum is literally the low-frequency part of the primitive
variance. In particular,

\[
 S_X=X\left\{\frac{M^2}{2}+2|Z|^2
 +\frac1{\pi^2}\mathcal L_\infty(X)\right\}.
 \tag{14f}
\]

This proves the precise relationship to `CoarsePrimitiveBound`: the full
joint estimate together with the two zero modes is exactly that bound,
not an independent large-sieve mechanism. The truncated sum remains a
proper positive part, with (9) controlling its complement.

A safe unconditional estimate obtained from the cited PNT error is, for
every fixed \(\delta>0\),

\[
 \boxed{
 \mathcal L_{J_X}(X)
 \ll_\delta X^4\exp[-2(d-\delta)\Phi(X)].}
 \tag{14g}
\]

Indeed, the same pointwise PNT estimate used to prove (4d) gives
\(|M|\ll_\delta X^2e^{-(d-\delta)\Phi(X)}\); applied in (14b), it gives
the identical bound for each \(|C_j|\). Since \(\sum j^{-2}<\infty\),
summing through \(J_X\) costs no power of \(J_X\). This argument loses the
cancellation inside each \(C_j\), then loses all correlation between
different \(j\). It retains all prime powers and both endpoints.

The ordinary large sieve does not improve the exponent. To see the exact
loss, put \(D=A_0(X)-X\). Complete discrete Fourier orthogonality on the
\(X\) integers \(X<n\le2X\) gives

\[
\begin{aligned}
 \sum_{j=1}^{X-1}|B_j(X)|^2
 ={}&X\sum_{X<n\le2X}\Lambda(n)^2-A_0(X)^2
 +(X-1)D^2\\
 &-2D\bigl(X\Lambda(2X)-A_0(X)\bigr).
 \tag{14h}
\end{aligned}
\]

Chebyshev's bound and \(\Lambda(n)\le\log(2X)\) therefore give

\[
 \sum_{j=1}^{X-1}|B_j(X)|^2
 \ll X^2\log X+XD^2+X|D|\log X.
 \tag{14i}
\]

This is also the scale delivered by the large sieve: the frequency
spacing is \(1/X\), so its constant is the interval length plus the inverse
spacing, \(X+X\), with no factor \(J/X\) for retaining only the first
\(J\) frequencies. Moreover, expanding (14a) exactly gives

\[
\begin{aligned}
 \mathcal L_J(X)={}&
 \frac{X^2}{4\pi^2}\sum_{j\le J}\frac{|B_j(X)|^2}{j^4}
 +M^2\sum_{j\le J}\frac1{j^2}\\
 &-\frac{XM}{\pi}\sum_{j\le J}\frac{\operatorname{Im}B_j(X)}{j^3}.
 \tag{14j}
\end{aligned}
\]

The last line is the observed cross term. Cauchy--Schwarz reduces (14j)
to the separated estimate and discards precisely the possible
cancellation. Fourier orthogonality controls the first square in (14j),
but gives no sign or asymptotic for the last line. After a split at
\(K<J_X\), (14i) improves only the range \(j>K\); the positive range
\(j\le K\), beginning with \(j=1\), retains (14g).

This first mode is a fast falsifier for any claimed averaging gain. Since

\[
 \frac{|C_1(X)|^2}{1^2}\le\mathcal L_{J_X}(X),
 \tag{14k}
\]

an estimate \(\mathcal L_{J_X}(X)\ll X^{4-\eta}\) would already prove
\(|C_1(X)|\ll X^{2-\eta/2}\). No averaging over the remaining modes can
prove that inequality. In the explicit formula a zero \(\rho\) enters
\(C_j\) at the scale

\[
 -\frac{X^{\rho+1}}{\rho}H_j(\rho),\qquad
 H_j(s)=\int_1^2u^s\bigl(e(-ju)-1\bigr)\,du.
 \tag{14l}
\]

The kernel vanishes at both endpoints but does not change the power
\(X^{\Re\rho+1}\). If \(\Re s>0\) and every \(H_j(s)\) vanished, all
positive Fourier coefficients of \(u^s\) on \([1,2]\) would equal its
nonzero mean. This contradicts the Riemann--Lebesgue lemma, so some fixed
\(j\) has \(H_j(s)\ne0\). A uniform fixed strip
\(\Re\rho\le1-\theta\), with \(0<\theta<1/2\), would give the genuinely
weaker-than-RH benchmark

\[
 \mathcal L_{J_X}(X)\ll_\varepsilon X^{4-2\theta+\varepsilon}.
 \tag{14m}
\]

No such fixed strip is known. The target exponent \(X^{3+\varepsilon}\)
corresponds to \(\theta=1/2\), the RH boundary. A joint
large-sieve/dispersion calculation therefore supplies no unconditional
fixed exponent improvement over (14g): at the principal arc it either
returns the primitive variance (14e), discards the crucial cross term in
(14j), or asks for a fixed zero-free strip or square-root prime-error
input.

Thus (13) is the exact phase-sensitive low-frequency input at this cutoff.
A simpler phase-free sufficient condition is

\[
 \boxed{
 \sum_{1\le j\le J_X}
 \frac{|B_j(X)|^2}{j^4}
 \ll_\varepsilon X^{1+\varepsilon}.}
 \tag{15}
\]

To verify the latter scale, (7) and
\(|a+b|^2\le2|a|^2+2|b|^2\) give

\[
 X\sum_{1\le |j|\le J_X}|\widehat P(j)|^2
 \ll
 X^3\sum_{1\le j\le J_X}\frac{|B_j(X)|^2}{j^4}
 +XM^2.
 \tag{16}
\]

Equations (12), (15)--(16), and the tail (10) imply
\(S_X\ll_\varepsilon X^{4+\varepsilon}\), exactly the hypothesis consumed
by the formal theorem `target_of_coarsePrimitiveBound`.

A convenient stronger pointwise input for (15) is

\[
 |B_j(X)|\ll_\varepsilon jX^{1/2+\varepsilon}
 \qquad(1\le j\le J_X),
 \tag{17}
\]

because \(\sum j^{-2}<\infty\), after replacing \(\varepsilon\) there by
\(\varepsilon/2\) for a requested exponent. The aggregate inequality (13)
is the weaker phase-sensitive input, while (15) is the phase-free sufficient
estimate.

## Fast falsifier for a fixed-mode argument

Numerical concentration in the first few modes does not control the tail
uniformly. If one fixes \(J=8\), the unconditional first term in (10) is
\(O(X^5)\), one full power above the required \(X^{4+\varepsilon}\) scale.
Any proof using only bounded variation beyond a fixed number of modes must
therefore fail. It must either prove cancellation through at least
\(J\asymp X^{1/3-o(1)}\), improve the high-frequency decay beyond (8), or
use another exact structure of the prime coefficients.

The observed dominance of eight modes is useful evidence for (13), but it
is not a substitute for a uniform bound.

## Relation to the smooth high product block

The smooth high-block theorem controls reciprocal product phases of the
form \(e(-Cz)\) with \(C=N/(qr)\) and
\(|z|\ll F/Q^3\). Equations (5)--(7) instead require the direct additive
prime twists \(e(-jn/X)\) for every
\(1\le j\le X^{1/3+o(1)}\), together with the two zero-mode moments in
(12). The variables, normalization, and coefficient families are different.
The existing smooth high-block estimate therefore supplies none of the
inputs (12), (13), or (15). Its Plancherel--Pólya step is a sampling theorem
after a center average; it is not an estimate for the prime twists
\(A_j(X)\).

## Verification boundary

The definitions of \(S_X\), the terminal mass, and its use in the
conditional RH theorem are Lean-checked in the existing coarse-primitive
modules. Equations (1)--(17), including Parseval, exact cell integration,
and the bounded-variation tail, are written mathematics in this note. No
claim is made that Lean currently connects these Fourier formulas to
`coarsePrimitiveSquare`.
