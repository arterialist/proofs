# Differences before successor division

Let

\[
(Tf)(z)=\frac{f(z)}{1-z},
\qquad
(C_2f)(z)=f(z^2),
\qquad
\Delta_2=I-C_2.
\]

For the odd Möbius series

\[
O(z)=\sum_{m\ \text{odd}}\mu(m)z^m,
\]

the full Möbius series is \(F=\Delta_2O\). The raw circle norm of
\(F\) is \(O(X)\) at radius \(e^{-1/X}\). This note tests whether applying
\(\Delta_2\) before \(T\) preserves that gain while controlling the
central successor consumer.

## Exact radial-dilation commutator

A direct calculation gives

\[
\begin{aligned}
T\Delta_2f
&=\frac{f(z)-f(z^2)}{1-z},\\
\Delta_2Tf
&=\frac{f(z)}{1-z}-\frac{f(z^2)}{1-z^2}.
\end{aligned}
\]

Therefore

\[
\boxed{
T\Delta_2f
=\Delta_2Tf-\frac{z f(z^2)}{1-z^2}.}
\tag{1}
\]

The last term is the exact commutator boundary. It cannot be dropped. For
\(f=O\), (1) reads

\[
\frac{F(z)}{1-z}
=\frac{O(z)}{1-z}-\frac{O(z^2)}{1-z^2}
-\frac{zO(z^2)}{1-z^2}. \tag{2}
\]

The last two terms combine to \(-(1+z)O(z^2)/(1-z^2)
=-O(z^2)/(1-z)\), recovering the identity but showing where the lower
scale is stored.

At the coefficient level, put

\[
A_{\mathrm{odd}}(N)=\sum_{m\le N\atop m\ \text{odd}}\mu(m).
\]

Then

\[
[z^N]TO=A_{\mathrm{odd}}(N), \tag{3}
\]

while the boundary in (1) has coefficients

\[
\left[z^N\right]\frac{zO(z^2)}{1-z^2}
=1_{N\ \text{odd}}
 A_{\mathrm{odd}}\!\left(\frac{N-1}{2}\right). \tag{4}
\]

Keeping (4) and the \(C_2Tf\) term gives exactly

\[
[z^N]\frac{F(z)}{1-z}
=M(N)=A_{\mathrm{odd}}(N)-A_{\mathrm{odd}}(\lfloor N/2\rfloor). \tag{5}
\]

Thus the commutator boundary is an actual lower-scale odd Mertens prefix,
not a smooth error.

## Angular-difference commutator

For \(|\omega|=1\), let

\[
(R_\omega f)(z)=f(\omega z),
\qquad \Delta_\omega=I-R_\omega.
\]

Then

\[
\boxed{
T\Delta_\omega f
=\Delta_\omega Tf
+\frac{z(\omega-1)f(\omega z)}
 {(1-z)(1-\omega z)}.}
\tag{6}
\]

The sign follows by subtracting the two denominators directly. The final
term has both successor poles. If \(|1-\omega|\) is chosen at the central
angular scale, it is not uniformly smaller near \(z=1\); the small
numerator is canceled by one of the two small denominators. Angular
differencing therefore moves the endpoint into a two-pole boundary term.

## Exact Poisson boundary

Let \(r=e^{-1/X}\), \(\rho=r^2\), and consider the successor function

\[
G(z)=\frac{F(z)}{1-z}.
\]

The Poisson mean on \(|z|=r\) is

\[
G(\rho)=\frac{F(\rho)}{1-\rho}. \tag{7}
\]

For any central arc, the exact mean-variance decomposition retains

\[
W_X|F(\rho)|^2
\]

when written in the birth normalization used by the central-arc notes, or
equivalently \(W_X|G(\rho)|^2(1-\rho)^2\) in successor normalization.
Here \(W_X\asymp X\). Thus a central estimate at scale
\(X^{2+\varepsilon}\) requires

\[
|F(e^{-2/X})|\ll_\varepsilon X^{1/2+\varepsilon}. \tag{8}
\]

This is exactly the Abel-Mertens terminal criterion. Applying a difference
before division does not remove (7); it reappears as the commutator
boundary in (1) or (6).

## A boundary-free Hardy estimate is false

The failure is already visible for bounded coherent coefficients. For an
integer \(X\), define

\[
O_X(z)=\sum_{X\le m<2X\atop m\ \text{odd}}z^m,
\qquad F_X(z)=O_X(z)-O_X(z^2). \tag{9}
\]

Odd and twice-odd frequencies are disjoint, so at
\(r=e^{-1/X}\),

\[
\frac1{2\pi}\int|F_X(re^{i\theta})|^2d\theta\asymp X. \tag{10}
\]

But

\[
\frac{F_X(z)}{1-z}
=\sum_{X\le m<2X\atop m\ \text{odd}}
 \sum_{N=m}^{2m-1}z^N. \tag{11}
\]

For a fixed positive proportion of integers \(N\) between \(3X/2\) and
\(2X\), the coefficient in (11) is \(\gg X\). There are \(\gg X\) such
integers, and their radial weights are bounded below by a constant.
Consequently

\[
\frac1{2\pi}\int
 \left|\frac{F_X(re^{i\theta})}{1-re^{i\theta}}\right|^2d\theta
\gg X^3. \tag{12}
\]

Thus no functional inequality of the form

\[
\|T\Delta_2 f\|_{H^2(r)}^2
\le C X\|\Delta_2f\|_{H^2(r)}^2 \tag{13}
\]

holds uniformly for bounded coefficients. The right side of (13) is
\(O(X^2)\) on (9), while the left side is \(\gg X^3\). A boundary or
arithmetic cancellation term is mandatory.

This counterexample has the same interval-overlap geometry as the exact
odd Möbius factorization. It does not claim that Möbius coefficients are
coherent; it proves that difference structure and Hardy theory alone
cannot provide the needed gain.

## What Poincare pays

Each individual doubled block vanishes at \(z=1\):

\[
z^m-z^{2m}=(1-z)I_m(z),
\qquad I_m(z)=\sum_{N=m}^{2m-1}z^N. \tag{14}
\]

A Hardy or Poincare estimate pays the length of this interval. For one
block,

\[
\|I_m\|_{H^2}^2=m. \tag{15}
\]

For many blocks, the interval Gram matrix has entries

\[
\langle I_m,I_n\rangle
=|[m,2m-1]\cap[n,2n-1]|. \tag{16}
\]

On a dyad this matrix has row sums of order \(X^2\), not \(X\), because
there are order \(X\) overlapping intervals, each of length order \(X\).
Poincare therefore reproduces the cubic coherent allowance. Reducing it to
\(X^{2+\varepsilon}\) requires cancellation in the signs
\(\mu(m)\mu(n)\).

The angular Poincare route has the same cost. Centering at the radial mean
controls

\[
G(re^{i\theta})-G(\rho)
\]

by an angular derivative, but the full derivative energy has an actual
prime lower bound of order \(X^3/\log X\). Restriction to the central arc
does not follow from the raw difference norm and remains a source-specific
correlation problem.

## RH-equivalent endpoint

If one proves both the centered doubled variance bound and the radial
boundary estimate (8), then the complete annular energy is

\[
\sum_{N\ge1}M(N)^2e^{-2N/X}
=O_\varepsilon(X^{2+\varepsilon}). \tag{17}
\]

As shown by the exact annular Parseval identity, (17) is equivalent to RH
when required for every epsilon and every integer \(X\). Conversely RH
pays (17), the boundary (8), and hence the associated mean-variance split.

The endpoint cannot be paid below RH scale by a generic commutator
estimate. It is literally \(F(e^{-2/X})\), whose uniform
\(X^{1/2+\varepsilon}\) bound is the Abel-Mertens RH criterion.

The bounded conclusion is negative but precise. Applying radial or angular
differences before successor division preserves the raw \(O(X)\) Parseval
norm, but the commutator introduces an exact accumulated boundary. Hardy
and Poincare estimates pay interval overlap of cubic coherent scale. For
the actual source, improving that payment is the same signed two-point
Möbius cancellation already isolated in the doubled kernel, with the
Abel-Mertens terminal value retained.

This is written analysis. The finite commutator and coefficient identities remain Lean formalization obligations.
