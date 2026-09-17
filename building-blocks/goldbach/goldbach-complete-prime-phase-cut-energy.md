# A complete prime-history phase twist on the additive Goldbach triangle

Written mathematical result, 17 September 2026. A multiplicative
phase on every prime generator gives an exact positive cut energy
when observed through the *additive*, ordered Goldbach triangle.
Flipping the generators through \(c\sqrt X\) changes the complete
weighted pair count by \((4c+o(1))X^{3/2}\). The result retains every
prime power and the endpoint \(a+b=X\). It neither proves a Goldbach
representation for any even integer nor bounds the centered
Goldbach error needed for RH.

## Exact finite identity

For a real horizon \(X\ge4\), fix a prime cutoff \(z=z(X)\) and
define the completely multiplicative character
\[
 \chi_z(p)=
 \begin{cases}-1,&p\le z,\\+1,&p>z,\end{cases}
 \qquad
 \chi_z(n)=\prod_p\chi_z(p)^{v_p(n)}.
 \tag{1}
\]
Thus for every prime power,
\(\Lambda(p^j)\chi_z(p^j)=(-1)^j\log p\) if \(p\le z\);
even powers are unchanged and odd powers reverse sign. Let
\[
 G(X)=\sum_{a+b\le X}\Lambda(a)\Lambda(b),\qquad
 G_{\chi_z}(X)=\sum_{a+b\le X}
       \Lambda(a)\chi_z(a)\Lambda(b)\chi_z(b),
 \tag{2}
\]
where \(a,b\) are positive integers and pairs are ordered. The
complete flipped prime-power set is
\(\mathcal F_z=\{p^{2j+1}:p\le z,\ j\ge0\}\), and put
\(W_z(t)=\sum_{n\le t,\ n\in\mathcal F_z}\Lambda(n)\).
All sums in this note include equality at their terminal boundary.

Because \(\chi_z(a),\chi_z(b)\in\{-1,1\}\), the difference has the
exact additive-graph Dirichlet form
\[
 \boxed{\quad
 \begin{aligned}
 D_z(X):=G(X)-G_{\chi_z}(X)
 &=\frac12\sum_{a+b\le X}
     \Lambda(a)\Lambda(b)
        [\chi_z(a)-\chi_z(b)]^2\\
 &=4\sum_{\substack{a\le X\\a\in\mathcal F_z}}
       \Lambda(a)\,[\psi(X-a)-W_z(X-a)]
 \ge0.
 \end{aligned}\quad}                                    \tag{3}
\]
The last expression counts each cross edge between a flipped and
unflipped prime-power coordinate in both orientations. Formula (3)
uses the complete von Mangoldt support, not a prime-only or
pointwise Goldbach-existence assertion.

For a *fixed* finite set \(S\) of flipped generators, the flipped
mass satisfies \(W_S(X)=O_S(\log X)\), since each odd-power ladder
has \(O(\log X/\log p)\) members of weight \(\log p\).
Chebyshev's bound \(\psi(X)\ll X\) then gives
\[
 0\le D_S(X)\le4\psi(X)W_S(X)=O_S(X\log X).
 \tag{4}
\]
An individual fixed finite-prime phase therefore cannot change
this cumulative observable at order \(X^{3/2}\).

## The moving square-root cutoff

Fix \(c>0\) and take \(z=c\sqrt X\). The prime-power mass beyond
the exponent-one packet obeys
\[
 R_z(X):=
 \sum_{\substack{p^{2j+1}\le X\\p\le z,\ j\ge1}}\log p
 \ll X^{1/3}\log(2X)=o(\sqrt X).
 \tag{5}
\]
Indeed \(p\le X^{1/(2j+1)}\), and Chebyshev bounds the sum over
the \(O(\log X)\) possible odd exponents. Hence
\[
 W_z(X)=\theta(z)+R_z(X)
       =(c+o(1))\sqrt X
 \tag{6}
\]
by the prime number theorem. Separating the \(a=p\le z\) terms
of (3), with \(E(t)=\psi(t)-t\), gives the quantitative reduction
\[
 D_z(X)=4X\theta(z)
  +O\!\left(
       z\theta(z)
      +\theta(z)\sup_{X-z\le t\le X}|E(t)|
      +W_z(X)^2+XR_z(X)\right).
 \tag{7}
\]
The \(\theta(z)E(X-p)\) term is the actual translated prime error;
it has not been replaced by a signed assumption. The PNT makes
its displayed supremum \(o(X)\) uniformly on this interval,
while the other errors are \(o(X^{3/2})\). Thus
\[
 \boxed{\quad
 G_{\chi_z}(X)-G(X)
   =-(4c+o(1))X^{3/2},
 \qquad z=c\sqrt X.
 \quad}                                                   \tag{8}
\]
In particular the exact positive energy (3) is of critical
Goldbach size. Its deterministic leading term is not a bound on
\(G(X)-X^2/2\).

The parity-restricted cumulative triangle has the same leading
phase cost. Let \(D_z^{\mathrm{even}}(X)\) restrict (3) to
\(a+b\) even. Its summands remain nonnegative. An odd sum with
both von Mangoldt weights nonzero has one even prime-power
coordinate, necessarily \(2^j\); its total weight through \(X\)
is \(O(\log X)\). Hence
\[
 0\le D_z(X)-D_z^{\mathrm{even}}(X)
 \le 2\sum_{\substack{a+b\le X\\a+b\ {\rm odd}}}
           \Lambda(a)\Lambda(b)
 \ll X\log(2X),
 \qquad
 D_z^{\mathrm{even}}(X)
    =(4c+o(1))X^{3/2}.
 \tag{9}
\]
This is an averaged weighted statement, not the assertion that
each even integer has two prime summands.

## What the sign does and does not buy

The positive cut energy gives \(G_{\chi_z}\le G\) for every finite
\(X,z\), without RH. The phase-twisted coefficient
\(\Lambda(n)\chi_z(n)\) is signed. Subtracting the deterministic
\(4X\theta(z)\) from (3) leaves the translated
\(\sum_{p\le z}(\log p)E(X-p)\) and proper-power terms in (7), with
no favorable sign from the cut identity. Thus (3) supplies no
unconditional square-root bound for \(E\) or the centered Goldbach
observable.

The difference from deleting the small-prime and proper-power
coordinates is concrete. The [high-prime cutoff theorem](high-prime-goldbach-cutoff-phase-transition.md)
proves that for the positive ordinary-prime channel \(L\) above
\(z=c\sqrt X\),
\[
 G(X)-S_{LL}(X)=(2c+4/3+o(1))X^{3/2}.
 \tag{10}
\]
Combining it with (8) gives
\[
 G_{\chi_z}(X)-S_{LL}(X)
   =(4/3-2c+o(1))X^{3/2}.                              \tag{11}
\]
For fixed \(c<2/3\) the twisted channel is eventually larger,
and for fixed \(c>2/3\) it is eventually smaller; (11) leaves
the equality case undecided. Flipping odd powers doubles the leading
small-prime cross cost, while even prime squares remain in the twisted
channel. Neither channel comparison signs the original centered
Goldbach error. The relation to the fixed-prime Weil phase space
in the [mixed character kernel](../weil-and-spectral/compact-weil-critical-mixed-character-kernel.md)
is limited: that theorem fixes a finite prime set before taking its
packet limit, while (8) grows the set through \(c\sqrt X\).

The finite cut identity is an elementary exact-algebra result and
the asymptotic uses the PNT and Chebyshev's bound. These are
written proofs, not Lean formalizations or an RH advance.
