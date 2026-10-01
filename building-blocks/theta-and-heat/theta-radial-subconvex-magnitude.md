# A subconvex magnitude bound for the complete theta radial sum

The complete signed radial sum admits a stronger magnitude estimate than
the elementary bound obtained by taking absolute values of its divisor
coefficients. This is an application of Bourgain's zeta bound to the actual
theta source. It supplies no sign inequality, prime-error power saving or
proof of RH.

## Exact object and range

Use the normalization
\[
 \xi(s)=\tfrac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s),
 \qquad \Xi(z)=\xi(\tfrac12+iz).
\]
For the complete positive radial weights in the
[Abel/Bessel formula](theta-radial-positivity.md), put
\[
 D_k(x)=\sum_{d\mid k}e^{ix\log(d^2/k)},\qquad
 \mathcal K_y(x)=\sum_{k\ge1}D_k(x)W_y(k,x)
               =\partial_y|\Xi(x+iy)|^2.
\]
The sum is absolutely convergent for every real \(x\) and \(y>0\).
Every divisor and prime power is retained; the frequency remains coupled
to the radial weights. Define
\[
 V_1(x)=\left.\partial_yW_y(1,x)\right|_{y=0}>0,
 \qquad
 \mathcal A_y(x)=
 \begin{cases}
  \mathcal K_y(x)/W_y(1,x),&y>0,\\
  \left.\partial_y\mathcal K_y(x)\right|_{y=0}/V_1(x),&y=0.
 \end{cases}
\]
The second line is the continuous extension at zero. It does not divide
\(\mathcal K_0=W_0=0\).

**Theorem.** For every \(\varepsilon>0\), there is a constant
\(C_\varepsilon>0\) such that, for every real \(x\) and every
\(0\le y\le1/2\),
\[
 \boxed{
  |\mathcal A_y(x)|\le
  C_\varepsilon(2+|x|)^{\frac{13}{21}(\frac12-y)+\varepsilon}.}
 \tag{1}
\]
The constant is uniform in \(x,y\). No explicit numerical value is supplied.
The statement includes the critical boundary
\(|\mathcal A_0(x)|\ll_\varepsilon(2+|x|)^{13/42+\varepsilon}\)
and, at large heights, every shrinking layer
\(0\le y\le B/\log|x|\), for fixed \(B\).
It also includes the right endpoint \(y=1/2\).

The previous elementary bounds from the
[cutoff transfers (3) and (4)](theta-radial-cutoff-asymptotics.md) are
\(O(|x|^{1/2-y})\), uniformly on compact positive \(y\)-intervals, and
\(O_B(\sqrt{|x|}/\log|x|)\) in the shrinking layer, including \(y=0\).
Equation (1) improves these powers by retaining cancellation in the
complete arithmetic sum. It makes no new claim about the best exponent
for zeta itself.

The input is for the literal zeta function, with unit integer coefficients
and phases \(x\log n\). Arbitrary independent prime-torus phases or changed
Euler coefficients do not inherit that input. The frequency \(x\) in the
radial weights is the same frequency in \(D_k(x)\); no frozen-weight
averaging is used.

## Proof

Write \(X=|x|\), \(L=\log(X/(2\pi))\),
\(s=1/2+y+ix\), \(\sigma=\operatorname{Re}s\), and
\(P(s)=s(s-1)\pi^{-s/2}\Gamma(s/2)/2\).
We first take \(X\) sufficiently large in terms of \(\varepsilon\).

[Bourgain, Theorem 5](https://arxiv.org/pdf/1408.5794v2), proves
\(|\zeta(1/2+it)|\ll_\eta |t|^{13/84+\eta}\) for every \(\eta>0\).
Phragmén–Lindelöf between the critical line and a fixed line \(1+\delta\)
gives, with the interpolation loss absorbed into \(\eta\),
\[
 |\zeta(\sigma+ix)|\ll_\eta
 X^{\frac{13}{42}(1-\sigma)+\eta}.
 \tag{2}
\]
This is uniform for \(1/2\le\sigma\le1\), rather than a collection
of bounds with unspecified dependence on \(\sigma\).
One may remove the real pole during interpolation by multiplying zeta
by \((s-1)/(s+1)\); that multiplier and its inverse are bounded at large
imaginary height. Take \(\delta\) small enough in terms of \(\eta\), with
a remaining right-hand strip margin for Cauchy's disks.
Cauchy's estimate on disks of radius \(1/(2L)\) gives the same bound for
\(\zeta^{(j)}(s)/L^j\), \(j=1,2\), when the disks remain to the right
of the critical line. If a disk crosses that line by \(O(1/L)\), use
the zeta functional equation on its left portion. The extra factor
\(X^{1/2-\sigma}\) is bounded there. In particular,
\[
 |\zeta^{(j)}(\sigma+ix)|\ll_{B,\eta}
 L^jX^{13/84+\eta},\qquad
 |\sigma-1/2|\le B/L,\quad j=0,1,2.
 \tag{3}
\]
The disk displacement costs only a bounded factor.

Stirling's formula and its differentiated forms yield
\[
 |P(s)|^2\sim C_\sigma X^{\sigma+3}e^{-\pi X/2},
 \quad C_\sigma=\pi(2\pi)^{-\sigma},
 \quad |P'(s)/P(s)|\ll L,
 \quad |P''(s)/P(s)|\ll L^2.
 \tag{4}
\]
These estimates are uniform in the indicated real strips. They retain
both polynomial pole-cancelling factors and the complete gamma factor.

Reflection and conjugation make
\(h(t)=|\xi(1/2+t+ix)|^2\) even. Hence
\(h'(0)=0\) exactly and \(\mathcal K_y(x)=h'(y)\). Differentiating
\(\xi=P\zeta\) gives
\[
 \mathcal K_y(x)=2|P(s)|^2
 \left[\operatorname{Re}(P'(s)/P(s))|\zeta(s)|^2
       +\operatorname{Re}(\zeta'(s)\overline{\zeta(s)})\right].
 \tag{5}
\]
There is no division by \(\zeta\), so its zeros require no exclusion.

In the regime \(yL\ge1\), retain both complete Mellin orders in the
radial formula (5) of the cutoff note. Uniform Stirling and the incomplete
Mellin remainder estimates give
\[
 W_y(1,x)=|P(s)|^2L(1-e^{-2yL})(1+o(1)),
 \qquad 1/L\le y\le1/2.
 \tag{6}
\]
The relative error is uniform: the Mellin orders remain in the positive
interval \([2,3]\), and \(1-e^{-2yL}\ge1-e^{-2}\). Thus
\(W_y(1,x)\ge c|P(s)|^2L\). Equations (2), (4) and (5), with
the small exponent losses combined, give
\[
 |\mathcal K_y(x)|\ll_\varepsilon|P(s)|^2L
 X^{\frac{13}{21}(\frac12-y)+\varepsilon}.
\]
Division proves (1) in this regime.

For \(0<yL\le1\), put
\(B_0=C_{1/2}X^{7/2}e^{-\pi X/2}\). The paired Mellin formula,
with its order-derivative remainders, gives uniformly
\[
 W_y(1,x)=2B_0L\sinh(yL)(1+o(1)),\qquad
 V_1(x)=2B_0L^2(1+o(1)).
 \tag{7}
\]
Its remainder retains a factor \(y\) before normalization; an absolute
remainder without that factor cannot be divided by \(y\) to obtain this
statement.
Equations (3) and (4), after twice differentiating \(P\zeta\), give
\[
 \sup_{0\le t\le y}|h''(t)|
 \ll_\varepsilon B_0L^2X^{13/42+\varepsilon}.
\]
The identity \(h'(y)=\int_0^yh''(t)\,dt\) supplies the same factor
\(y\) in the numerator. Divide by
\(W_y(1,x)\ge cB_0yL^2\), or by \(V_1(x)\) at zero, to get
\(O(X^{13/42+\varepsilon})\). Since \(yL\le1\),
\(X^{(13/21)y}\) is bounded, proving the stated exponent uniformly
in this regime too.

Finally, differentiating the convergent radial integral shows that
\(W_y(1,x)/y\) extends jointly continuously to \(V_1(x)>0\) at zero.
The same holds for \(\mathcal K_y(x)/y\). Thus \(\mathcal A_y(x)\)
is bounded on every compact set of \((x,y)\in\mathbb R\times[0,1/2]\).
Enlarging the constant and using \(2+|x|\) proves (1) for every real \(x\).

## Verification and limit

The complete written argument, including both endpoints and the shrinking
layer, has an independent mathematical check. The accompanying
[Lean module](../../formalization/BuildingBlocks/ThetaRadialMagnitudeAlgebra.lean)
checks only the finite complex product-derivative bounds and positive
quotient reductions. Its first- and second-derivative bounds have constants
\(4\) and \(16\), with explicit norm hypotheses; its small-layer lemma
also takes the odd-integral estimate as an explicit hypothesis.

All six audited declarations use only `propext`, `Classical.choice` and
`Quot.sound`. The module contains no placeholders or custom axioms. Run
`lake build BuildingBlocks.ThetaRadialMagnitudeAlgebra` from the repository
root to check it.

Bourgain's theorem, strip interpolation, Cauchy and
Stirling estimates, the actual radial identity, its paired denominator
asymptotics, and the real integral/compact-continuity steps remain written
analysis. The actual analytic inequality (1) has not been formalized in Lean.

Equation (1) controls absolute size. It neither makes \(\mathcal K_y\)
nonnegative nor excludes an individual off-line zero. There is no proved
transfer from this magnitude bound to the full critical-sign numerator or
coarse primitive energy. Those premises, and RH, remain open.
