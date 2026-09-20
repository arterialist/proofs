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
