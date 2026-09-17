# Centered Goldbach square versus the Abel-Mertens transform

This independently reviewed written note tests whether the exact additive Goldbach source controls the
terminal transform

\[
F(t)=\sum_{n\ge1}\mu(n)e^{-nt}.
\]

The answer has two parts. A square-root-scale bound for the complete
centered Goldbach square does transfer to \(F\), but it already implies RH.
The presently available successor leakage estimate does not supply that
bound because it compares uncentered pair counts and leaves the centered
prime error untouched.

## Exact centered additive square

Retain every von Mangoldt coefficient, including every prime power, and set

\[
D(t)=\sum_{n\ge1}(\Lambda(n)-1)e^{-nt}. \tag{1}
\]

Here \(\Lambda(1)=0\), so the endpoint coefficient at one is \(-1\). If
\(z=e^{-t}\), the exact additive generating square is

\[
D(t)^2=sum_{N\ge2}c_Nz^N, \tag{2}
\]

where

\[
\boxed{
c_N=\sum_{m=1}^{N-1}\Lambda(m)\Lambda(N-m)
 -2\psi(N-1)+(N-1).}
\tag{3}
\]

The first term in (3) includes all ordered prime-power pairs. The second
term includes both orientations and the exact upper endpoint \(N-1\). The
last term is the full discrete continuum square. Nothing is removed at
\(m=1\) or \(m=N-1\).

Although the individual \(c_N\) have no fixed sign, the complete Abel sum
in (2) is nonnegative for every real \(0<z<1\). This positivity is lost if
one truncates the coefficient sum before evaluating it.

The centered heat used in the Goldbach notes is

\[
C(t)=\sum_{n\ge1}\Lambda(n)e^{-nt}-(1+t^{-1})e^{-t}. \tag{4}
\]

The exact endpoint correction is

\[
D(t)=C(t)-E_0(t),
\qquad
E_0(t)=\frac1{e^t-1}-(1+t^{-1})e^{-t}. \tag{5}
\]

The function \(E_0\) is bounded at zero and decays exponentially at
infinity. Thus it does not change a square-root heat exponent, but it must
be retained in an exact identity.

## A rigorous transfer theorem

Consider the following centered Goldbach estimate:

\[
0\le D(t)^2\le C_\varepsilon t^{-1-\varepsilon},
\qquad0<t\le1, \tag{6}
\]

for every \(\varepsilon>0\). Since (2) is the square of the real quantity
\(D(t)\), (6) gives

\[
|D(t)|\le C_\varepsilon^{1/2}t^{-1/2-\varepsilon/2}. \tag{7}
\]

For \(\Re s>1\), absolute termwise Mellin integration gives

\[
\int_0^\infty D(t)t^{s-1}dt
=\Gamma(s)\left(-\frac{\zeta'(s)}{\zeta(s)}-\zeta(s)\right). \tag{8}
\]

The two poles at \(s=1\) cancel: \(-\zeta'/\zeta\) and \(\zeta\) both
have residue one there. Estimate (7), together with exponential decay at
infinity, makes the left side of (8) holomorphic in every half-plane

\[
\Re s>\frac12+\eta,
\]

after choosing the epsilon in (6) smaller than \(2\eta\). Hence the
right side continues holomorphically there. Since \(\zeta(s)\) itself is
meromorphic with only its pole at one, any zero of \(\zeta\) in this
half-plane would produce a pole in \(-\zeta'/\zeta\) that the term
\(-\zeta(s)\) cannot cancel. Thus there are no zeros with
\(\Re s>1/2\). The functional equation then gives RH.

The established Abel-Mertens criterion consequently yields

\[
F(t)=O_\delta(t^{-1/2-\delta})
\qquad(t\downarrow0) \tag{9}
\]

for every \(\delta>0\), and in particular

\[
F(2/X)=O_\delta(X^{1/2+\delta}). \tag{10}
\]

This is a concrete transfer from the exact centered Goldbach square to the
central-arc terminal source. It proceeds through the zero-free criterion;
there is no direct positive convolution from the additive coefficients in
(3) to the multiplicative Möbius coefficients.

Conversely, RH gives

\[
\psi(x)-x=O(x^{1/2}\log^2x). \tag{11}
\]

The exact Stieltjes identity from the Goldbach heat note is

\[
C(t)=t\int_1^\infty[\psi(x)-x]e^{-tx}dx. \tag{12}
\]

Equations (5), (11), and (12) imply

\[
D(t)=O(t^{-1/2}\log^2(2/t)), \tag{13}
\]

and therefore

\[
D(t)^2=O(t^{-1}\log^4(2/t)). \tag{14}
\]

Thus the all-epsilon form of (6) is equivalent to RH. A fixed exact bound
\(D(t)^2=O(t^{-1})\) would be stronger and is not asserted to follow from
RH.

## What the available Goldbach transport proves

The literal successor transport proves

\[
0\le \mathcal G(X+2)-\mathcal G_S(X)\le C(X+2), \tag{15}
\]

where

\[
\mathcal G(X)=\sum_{m+n\le X}\Lambda(m)\Lambda(n)
\]

and \(\mathcal G_S\) is the complete transported pair count. The exact
escape probability keeps its atom, continuous tail, and both ordered
cofactors. Equation (15) is a valid linear comparison, but it does not
bound the centered coefficients (3).

Indeed, summing (3) through \(N\le X\) requires the linked cancellation

\[
\sum_{m+n\le X}\Lambda(m)\Lambda(n)
-2\sum_{N\le X}\psi(N-1)
+\frac{(X-1)X}{2}. \tag{16}
\]

Each displayed component is naturally quadratic. The transport estimate
(15) compares the first component with a shifted version of itself. It
does not compare that component with the two endpoint/main terms in (16)
at square-root accuracy. The compensated transport also contains the full
rank-one charge

\[
-2\kappa\frac{X-1}{X}\psi(X)+\kappa^2,
\]

which is only a linear correction and does not create the missing centered
cancellation.

Taking absolute values in (16) gives a quadratic allowance. PNT gives an
asymptotic cancellation at the leading scale, but not the
\(X^{1+\varepsilon}\)-type centered pair control whose Abel transform
would imply (6). The \(O(X)\) successor leakage cannot be inserted as that
missing estimate because its two sides both retain the unknown centered
Goldbach fluctuation.

## The exact analytic mismatch

The two real heat transforms encode different operations on zeta:

\[
\begin{aligned}
\int_0^\infty D(t)t^{s-1}dt
 &=\Gamma(s)\left(-\zeta'/\zeta-\zeta\right)(s),\\
\int_0^\infty F(t)t^{s-1}dt
 &=\Gamma(s)/\zeta(s).
\end{aligned}\tag{17}
\]

Passing from the first line to the second solves the logarithmic-derivative
equation for \(1/\zeta\). It is a multiplicative analytic operation, not
the additive convolution represented by the Goldbach square. The centered
square determines only \(|D(t)|\) on the positive real heat axis and does
not furnish a form-preserving kernel from \(D\) to \(F\).

This does not obstruct the RH-strength transfer above, because a magnitude
bound on \(D\) already makes its Mellin transform holomorphic and excludes
zeros. It does obstruct an attempt to use the unconditional transport
comparison (15) as though it directly bounded the Möbius transform.

## Bounded conclusion

The exact useful theorem is

\[
\boxed{
D(t)^2=O_\varepsilon(t^{-1-\varepsilon})
\text{ for every }\varepsilon>0
\quad\Longleftrightarrow\quad \mathrm{RH}
\quad\Longrightarrow\quad
F(2/X)=O_\delta(X^{1/2+\delta}).}
\tag{18}
\]

The reverse implication from RH to the first condition follows with the
explicit \(\log^4(2/t)\) allowance in (14), so the all-epsilon statements
are equivalent.

The currently proved Goldbach successor facts retain every prime power,
endpoint, continuous transport tail, and compensation charge, but they do
not prove the premise of (18). A new estimate must control the centered
combination (16), or equivalently the nonnegative complete Abel square in
(2), at RH scale. No such Goldbach error has been assumed here.

No Lean formalization of this analytic transfer is asserted.
