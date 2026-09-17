# Abel-smoothed Mertens bounds and the RH criterion

This independently reviewed written proof determines what follows from the terminal quantity in the
central-arc obstruction. Put

\[
F(t)=\sum_{n\ge1}\mu(n)e^{-nt},\qquad t>0.
\]

The value in the obstruction is

\[
F(2/X)=P(e^{-2/X}).
\]

The result is clean. Square-root bounds with every epsilon, uniformly at
all integer scales \(X\), are equivalent to the usual Mertens formulation
of RH. No direct unsmoothing inequality at one scale is available. The
transfer uses all scales and analytic continuation.

## From Mertens to Abel smoothing

Let

\[
M(x)=\sum_{n\le x}\mu(n).
\]

Abel summation gives the exact identity

\[
F(t)=(1-e^{-t})\sum_{N\ge1}M(N)e^{-Nt}. \tag{1}
\]

Suppose that, for every \(\varepsilon>0\),

\[
M(N)=O_\varepsilon(N^{1/2+\varepsilon}). \tag{2}
\]

For \(0<t\le1\), comparison with the gamma integral gives

\[
\sum_{N\ge1}N^{1/2+\varepsilon}e^{-Nt}
 \ll_\varepsilon t^{-3/2-\varepsilon}.
\]

Since \(1-e^{-t}\le t\), (1) yields

\[
F(t)=O_\varepsilon(t^{-1/2-\varepsilon}). \tag{3}
\]

In particular,

\[
F(2/X)=O_\varepsilon(X^{1/2+\varepsilon}). \tag{4}
\]

This direction loses no extra logarithm.

## Integer scales suffice

Assume conversely that for every \(\varepsilon>0\),

\[
|F(2/X)|\le C_\varepsilon X^{1/2+\varepsilon}
\qquad(X=1,2,3,\ldots). \tag{5}
\]

This discrete set is dense enough near zero. Termwise differentiation is
absolute and

\[
|F'(t)|
\le\sum_{n\ge1}ne^{-nt}
=\frac{e^{-t}}{(1-e^{-t})^2}
\ll t^{-2},\qquad0<t\le2. \tag{6}
\]

For any sufficiently small \(t\), choose \(X\) with

\[
\frac2{X+1}<t\le\frac2X.
\]

The interval length is

\[
\frac2X-\frac2{X+1}=\frac2{X(X+1)}\asymp t^2. \tag{7}
\]

The mean value theorem and (6) show that replacing \(t\) by \(2/X\)
costs only an absolute constant. Hence (5) extends to

\[
F(t)=O_\varepsilon(t^{-1/2-\varepsilon}),
\qquad t\downarrow0. \tag{8}
\]

The endpoints \(X=1\) and bounded positive \(t\) cause no problem. For
\(t\ge1\), absolute convergence gives

\[
|F(t)|\le\frac{e^{-t}}{1-e^{-t}}. \tag{9}
\]

Thus estimates at every positive integer \(X\), rather than at every real
\(X\), suffice for the analytic argument.

## Mellin continuation and zero-free half-planes

For \(\Re s>1\), absolute termwise integration gives

\[
\int_0^\infty F(t)t^{s-1}dt
=\Gamma(s)\sum_{n\ge1}\frac{\mu(n)}{n^s}
=\frac{\Gamma(s)}{\zeta(s)}. \tag{10}
\]

Fix \(\eta>0\). Applying (8) with an epsilon smaller than \(\eta\), the
integral on the left of (10) converges locally uniformly and defines a
holomorphic function on

\[
\Re s>\frac12+\eta. \tag{11}
\]

It agrees with \(\Gamma(s)/\zeta(s)\) on \(\Re s>1\), so it supplies its
analytic continuation to (11). More explicitly, if this integral is
\(G(s)\), both `(s-1) zeta(s) G(s)` and `(s-1) Gamma(s)` are holomorphic
on (11) and agree for \(\Re s>1\). The identity theorem makes them equal
throughout (11). At any nontrivial zero \(\rho\) in that region, the left
side would vanish while `(rho-1) Gamma(rho)` would not. Therefore
\(\zeta(s)\) has no zero in (11).

Since \(\eta>0\) is arbitrary, there are no zeta zeros with
\(\Re s>1/2\). The functional equation reflects every nontrivial zero
across \(\Re s=1/2\), so every nontrivial zero lies on that line. Thus (5)
implies RH.

Conversely, the classical Littlewood criterion says that RH implies (2)
for every epsilon. Together with (1), RH implies (5). We obtain the
equivalence

\[
\boxed{
\mathrm{RH}
\quad\Longleftrightarrow\quad
F(2/X)=O_\varepsilon(X^{1/2+\varepsilon})
\text{ for every }\varepsilon>0
\text{ and every integer }X\ge1.}
\tag{12}
\]

The quantifiers matter. The implied constant may depend on epsilon but not
on \(X\).

## Transfer to established sharp criteria

The standard Mertens and Chebyshev formulations now give

\[
\begin{aligned}
\mathrm{RH}
&\Longleftrightarrow
M(x)=O_\varepsilon(x^{1/2+\varepsilon})
\quad\text{for every }\varepsilon>0,\\
&\Longleftrightarrow
\psi(x)=x+O(x^{1/2}\log^2x),
\end{aligned}\tag{13}
\]

where the last statement is understood for \(x\ge2\). Hence the uniform
Abel estimate in (12) transfers to both established RH criteria. The
\(\log^2x\) in the \(\psi\) bound is the standard endpoint loss from the
explicit formula; it is not produced by the Abel smoothing in (1).

An exact estimate \(F(2/X)=O(\sqrt X)\) is stronger than needed for the
continuation argument and is not asserted to follow from RH. The stable
equivalence is the family of estimates with every epsilon.

## Consequence for the central arc

The terminal obstruction proved

\[
A_X\ge
 \frac{\kappa X}{4T_X}
 \left(|F(2/X)|-\frac{\pi e}{2}\sqrt X\right)_+^2
 -O\left(\frac1{XT_X^2}\right),
\qquad T_X=2\log(2X). \tag{14}
\]

If

\[
A_X=O_\varepsilon(X^{2+\varepsilon})
\quad\text{for every }\varepsilon>0, \tag{15}
\]

then (14) yields

\[
F(2/X)
=O_\varepsilon\left(
 \sqrt X+X^{1/2+\varepsilon/2}\sqrt{\log(2X)}
 \right). \tag{16}
\]

Given any \(\delta>0\), apply (15) with a sufficiently small epsilon and
absorb \(\sqrt{\log(2X)}\) into \(X^\delta\). This proves

\[
F(2/X)=O_\delta(X^{1/2+\delta})
\]

for every delta. By (12), the uniform central-arc target (15) implies RH.
This is a rigorous converse from the source-specific obstruction, with all
smoothing and logarithmic losses retained.

It does not prove that RH alone bounds \(A_X\). Formula (14) is a lower
bound and detects only the hard-clock terminal component of the central
arc. The remaining clocks and angular variance need a separate upper
estimate.

## Why sparse or one-point bounds are insufficient

At a single scale, \(F(2/X)\) is one signed Laplace moment and does not
determine \(M(X)\). Direct comparison of a sharp cutoff with the exponential
kernel loses \(O(X)\) under the sole coefficient bound \(|\mu(n)|\le1\).
The successful converse above uses the estimate at all integer scales and
then uses analytic continuation.

Even dyadic scales alone do not support the interpolation step. Consecutive
dyadic parameters have gaps of order \(t\), and (6) then allows variation
of order \(t^{-1}\), which is larger than the desired
\(t^{-1/2-\varepsilon}\). Additional regularity or arithmetic information
would be required. Thus a bound along a sparse sequence, or at one chosen
\(X\), is not an established RH criterion.

The useful conclusion is (12): uniform integer-scale Abel bounds with all
epsilon losses are exactly strong enough. The central-arc target supplies
such bounds if proved uniformly, but no pointwise desmoothing shortcut has
been assumed.

This is a written analytic criterion and transfer, not a Lean formalization or a proof of its unproved central-arc premise.
