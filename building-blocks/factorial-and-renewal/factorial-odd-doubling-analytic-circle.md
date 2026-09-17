# Odd doubling on the analytic circle

Let

\[
F(z)=\sum_{n\ge1}\mu(n)z^n,
\qquad
O(z)=\sum_{m\ge1\atop m\ \text{odd}}\mu(m)z^m,
\qquad |z|<1.
\]

This note records the exact analytic effect of the prime two Euler factor
and tests whether circle orthogonality or radial dilation improves the
doubled-kernel estimate.

## The prime two Euler factor

Every squarefree even integer is uniquely \(2m\), with \(m\) odd and
\(\mu(2m)=-\mu(m)\). Multiples of four have zero Möbius coefficient.
Therefore

\[
\boxed{F(z)=O(z)-O(z^2).} \tag{1}
\]

This includes the endpoint pair \(z-z^2\) from \(m=1\). Iterating (1)
gives the locally uniformly convergent telescoping identity

\[
\boxed{O(z)=\sum_{j\ge0}F(z^{2^j}).} \tag{2}
\]

Odd projection also gives

\[
O(z)=\frac{F(z)-F(-z)}2, \tag{3}
\]

so

\[
F(z)+F(-z)+F(z^2)-F(-z^2)=0. \tag{4}
\]

The multiplicative Mellin analogue is the exact Euler-factor formula

\[
\sum_{m\ \text{odd}}\frac{\mu(m)}{m^s}
=\prod_{p\ne2}(1-p^{-s})
=\frac1{(1-2^{-s})\zeta(s)},
\qquad \Re s>1. \tag{5}
\]

Equivalently,

\[
\frac1{\zeta(s)}=(1-2^{-s})
\sum_{m\ \text{odd}}\frac{\mu(m)}{m^s}. \tag{6}
\]

Thus the additive dilation in (1) is precisely the prime two Euler factor,
not an approximate sieve.

## Full-circle Parseval

On \(z=re^{i\theta}\), the two terms in (1) occupy disjoint Fourier
frequencies: \(O(z)\) has odd frequencies and \(O(z^2)\) has frequencies
congruent to two modulo four. Hence their cross term integrates to zero:

\[
\boxed{
\frac1{2\pi}\int_{-\pi}^{\pi}|F(re^{i\theta})|^2d\theta
=\sum_{m\ \text{odd}}\mu(m)^2(r^{2m}+r^{4m}).}
\tag{7}
\]

At \(r=e^{-1/X}\), the right side is \(O(X)\). This is a genuine
unconditional linear circle bound. It is also just the squarefree
coefficient diagonal; full-circle orthogonality has removed every
two-point Möbius correlation.

The gain does not survive division by the successor factor. From (1),

\[
\frac{F(z)}{1-z}
=\sum_{m\ \text{odd}}\mu(m)
 \frac{z^m-z^{2m}}{1-z}
=\sum_{m\ \text{odd}}\mu(m)
 \sum_{N=m}^{2m-1}z^N. \tag{8}
\]

Since

\[
\frac{F(z)}{1-z}=\sum_{N\ge1}M(N)z^N,
\]

coefficient extraction yields the exact annular identity

\[
\boxed{
M(N)=\sum_{m\ \text{odd}\atop N/2<m\le N}\mu(m).}
\tag{9}
\]

The lower endpoint is strict because the negative term in (1) is present
when \(2m\le N\); the upper endpoint is closed. Formula (9) retains odd
squarefree composites and the endpoint \(m=1\).

Thus doubling replaces the prefix Mertens sum by an odd multiplicative
annulus of ratio two. It does not shorten the sum below scale \(N\).

## Exact annular Parseval identity

Define the interval polynomial

\[
I_m(z)=\frac{z^m-z^{2m}}{1-z}
=\sum_{N=m}^{2m-1}z^N. \tag{10}
\]

Full-circle Parseval applied to (8) gives

\[
\boxed{
\frac1{2\pi}\int_{-\pi}^{\pi}
 \left|\sum_{m\ \text{odd}}\mu(m)I_m(re^{i\theta})\right|^2d\theta
=\sum_{N\ge1}M(N)^2r^{2N}.}
\tag{11}
\]

Expanding the left side produces the positive overlap kernel

\[
\langle I_m,I_n\rangle_r
=\sum_{N\in[m,2m-1]\cap[n,2n-1]}r^{2N}. \tag{12}
\]

The doubled kernel is therefore a signed two-point Möbius correlation
against interval overlap. Its diagonal is nonnegative and has total size
\(O(X^2)\) at \(r=e^{-1/X}\): there are \(O(X)\) relevant odd indices,
and each interval polynomial has squared norm \(O(X)\). The off-diagonal
part is the missing cancellation.

Equation (12) also explains why ordinary Littlewood subordination does not
close the estimate. Composition \(z\mapsto z^2\) is contractive on the
raw Hardy space, and (7) is even orthogonal, but the map
\(F\mapsto F/(1-z)\) turns each coefficient into a length-\(m\) interval.
Those intervals overlap at full density.

## Relation to the centered doubled kernel

For the centered Poisson feature

\[
v_n(\theta)=r^ne^{in\theta}-r^{2n},
\]

the odd doubled feature is

\[
v_m(\theta)-v_{2m}(\theta). \tag{13}
\]

Its Gram kernel on the central arc is exactly

\[
K_X^{(2)}(m,n)=
\kappa_X(m,n)-\kappa_X(m,2n)
-\kappa_X(2m,n)+\kappa_X(2m,2n). \tag{14}
\]

On the full circle, division by \(|1-re^{i\theta}|^2\) turns (13) into a
centered version of the interval polynomial (10). The subtraction
\(r^{2m}-r^{4m}\) is precisely its Poisson mean. Thus the full-circle
doubled variance is the variance of the annular sums in (9). Restricting
to the central arc destroys the odd-even Fourier orthogonality used in
(7), leaving the sinc-weighted two-point correlation (14).

No annular dilation gain is hidden here. For \(m\asymp X\), both
\(r^m\) and \(r^{2m}\) are fixed constants, and \(I_m\) has length
comparable to \(X\). The prime two factor changes the shape of the kernel
but not its critical scale.

## RH-level equivalence of the full annular energy

Let

\[
\mathcal E_X^{\mu}
=\sum_{N\ge1}M(N)^2e^{-2N/X}. \tag{15}
\]

If RH holds, the classical Mertens criterion

\[
M(N)=O_\varepsilon(N^{1/2+\varepsilon})
\]

implies

\[
\mathcal E_X^{\mu}=O_\varepsilon(X^{2+\varepsilon}). \tag{16}
\]

Conversely, suppose (16) holds for every epsilon and every integer \(X\).
Cauchy-Schwarz at the smaller radius gives

\[
\begin{aligned}
|F(e^{-2/X})|
&=(1-e^{-2/X})
 \left|\sum_{N\ge1}M(N)e^{-2N/X}\right|\\
&\le (1-e^{-2/X})
 \left(\sum_{N\ge1}M(N)^2e^{-2N/X}\right)^{1/2}
 \left(\sum_{N\ge1}e^{-2N/X}\right)^{1/2}\\
&\ll X^{-1/2}(\mathcal E_X^{\mu})^{1/2}
\ll_\varepsilon X^{1/2+\varepsilon}.
\end{aligned}\tag{17}
\]

Here replacing epsilon by twice a desired final epsilon absorbs the
halving from the square root. The established Abel-Mertens criterion then
implies RH. Therefore

\[
\boxed{
\mathrm{RH}
\quad\Longleftrightarrow\quad
\mathcal E_X^{\mu}=O_\varepsilon(X^{2+\varepsilon})
\text{ for every }\varepsilon>0.}
\tag{18}
\]

This equivalence keeps the exponential endpoint weights in (15). A
dyadic version is equivalent by splitting the positive integers into
dyadic blocks and using the exponential tail.

The diagonal part of (11) is already \(O(X^2)\). Hence an
\(O_\varepsilon(X^{2+\varepsilon})\) upper bound for its signed
off-diagonal annular correlation, uniformly in \(X\), is precisely the
missing RH-strength input for the full-circle terminal problem.

## Sharp obstruction for the central arc

The central kernel (14) alone is a centered variance and omits the radial
mean. A bound for its signed off-diagonal part does not by itself imply
RH; the terminal value \(F(e^{-2/X})\) must also be paid. Once that radial
endpoint and the already bounded diagonal are included, the full annular
energy is (15), and (18) applies.

Thus Littlewood/Parseval gives one unconditional gain, the raw bound (7),
but that gain ends exactly at the successor division. The cumulative
annular energy needed for the doubled kernel is RH-equivalent after its
radial endpoint is retained. Any argument claiming an unconditional
\(X^{2+\varepsilon}\) bound must identify additional arithmetic
cancellation in the two-point overlap sum (12); dilation alone supplies
none.


[OddDoublingFiniteMobius.lean](../../formalization/BuildingBlocks/OddDoublingFiniteMobius.lean) formalizes the actual Möbius odd-doubling law, the exact finite Mertens annulus identity and both division-free geometric-block forms. The infinite Parseval and RH equivalence remain written analysis.
