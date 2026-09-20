# Mean square of centered restricted-divisor windows

**Status:** unconditional written arithmetic theorem, 20 September 2026.
The exact residue-class defect and critical exponent ledger are Lean-checked.
The divisor covariance expansion and finite-interval averaging remain written
mathematics. This is an averaged one-dimensional constraint on the genuine
centered coefficient from the fourfold product kernel, together with its
real-center smooth-kernel consequence. It does not prove the required
prescribed-center power-saving estimate or the Riemann hypothesis.

## Centered restricted-divisor coefficient

Let \(Q\ge2\), let \(\mathcal S\) be a set of integers in \([Q,2Q]\), and
let real weights satisfy \(|\theta_n|\le B\). Put

\[
 d_\theta(A)=\sum_{\substack{n\in\mathcal S\\n\mid A}}\theta_n,
 \qquad
 c_\theta=\sum_{n\in\mathcal S}\frac{\theta_n}{n},
 \qquad
 E_\theta(A)=d_\theta(A)-c_\theta.
 \tag{1}
\]

Choose a common multiple \(L\) of every \(n\in\mathcal S\). For a window
length \(H\ge1\), define

\[
 B_H(C)=\sum_{0\le u<H}E_\theta(C+u).
 \tag{2}
\]

These are the one-dimensional centered windows occurring after the
[exact product-divisor centering](actual-mobius-product-divisor-centering.md).

## Exact shifted covariance

For \(n,m\in\mathcal S\), put \(g=(n,m)\). The simultaneous congruences

\[
 C\equiv-u\pmod n,\qquad C\equiv-v\pmod m
\]

have a solution precisely when \(g\mid u-v\), and then occupy one residue
class modulo \(\operatorname{lcm}(n,m)=nm/g\). Therefore

\[
 \frac1L\sum_{C\bmod L}E_\theta(C+u)E_\theta(C+v)
 =
 \sum_{n,m\in\mathcal S}\frac{\theta_n\theta_m}{nm}
 \left(g\,\mathbf 1_{g\mid u-v}-1\right).
 \tag{3}
\]

In particular, coprime labels contribute exactly zero. Summing (3) over
\(0\le u,v<H\) gives a closed formula. Write

\[
 H=ag+b,\qquad 0\le b<g.
 \tag{4}
\]

Among the \(g\) residue classes modulo \(g\), exactly \(b\) contain
\(a+1\) elements of the window and \(g-b\) contain \(a\). Hence

\[
 g\,\#\{(u,v):0\le u,v<H,\ g\mid u-v\}-H^2
 =b(g-b).
 \tag{5}
\]

Combining (3)--(5) yields the exact periodic window variance

\[
 \boxed{
 \frac1L\sum_{C\bmod L}B_H(C)^2
 =
 \sum_{n,m\in\mathcal S}
 \frac{\theta_n\theta_m}{nm}\,
 b_{n,m}\bigl((n,m)-b_{n,m}\bigr),}
 \tag{6}
\]

where \(b_{n,m}=H\bmod(n,m)\). Formula (6) includes signed cross terms;
its left side guarantees that their total is nonnegative.

## Uniform square-root bound

The elementary inequality

\[
 0\le b(g-b)\le\frac{g^2}{4}
 \tag{7}
\]

and \(|\theta_n|\le B\) give

\[
 \frac1L\sum_{C\bmod L}B_H(C)^2
 \le\frac{B^2}{4}
 \sum_{n,m\in\mathcal S}\frac{(n,m)^2}{nm}.
 \tag{8}
\]

For \(n,m\in[Q,2Q]\),

\[
 (n,m)^2\le\sum_{d\mid n,\ d\mid m}d^2.
\]

There are at most \(Q/d+1\le3Q/d\) multiples of \(d\) in this interval.
Consequently

\[
 \sum_{n,m\in\mathcal S}\frac{(n,m)^2}{nm}
 \le 18Q,
 \tag{9}
\]

and

\[
 \boxed{
 \left(\frac1L\sum_{C\bmod L}|B_H(C)|^2\right)^{1/2}
 \le\frac3{\sqrt2}B\sqrt Q.}
 \tag{10}
\]

The bound is independent of \(H\). It is useful once \(H\) exceeds
\(\sqrt Q\).

The full period \(L\) is not required. Over any \(X\) consecutive centers,
counting one residue class in an interval differs from its exact density by
at most one. Expanding (1)--(2) and applying this to the joint and two
marginal congruences gives

\[
 \frac1X\sum_{C=C_0}^{C_0+X-1}|B_H(C)|^2
 \ll B^2\left(Q+\frac{H^2Q^2}{X}\right).
 \tag{11}
\]

The implied constant is absolute and uniform in \(C_0\). At
\(X\asymp Q^3\) and \(H\le Q\), (11) is \(O(B^2Q)\).

For two centered coefficient families with bounds \(B\) and \(B'\),
Cauchy's inequality in the same center variable therefore gives

\[
 \frac1X\sum_{C=C_0}^{C_0+X-1}
 |B_H(C)B'_H(C)|
 \ll BB'\left(Q+\frac{H^2Q^2}{X}\right).
 \tag{11a}
\]

Thus two sharp centered windows can be combined under the center average
without an independence assumption.

## Smooth two-window kernels

The sharp-window estimate transfers to the actual normalized shape of one
separated fourfold component. Let \(K\) be a fixed smooth compactly
supported function on \(\mathbb R^2\), with fixed derivative bounds, and
put

\[
 \mathcal R_{H,V}(C)=
 \sum_{A,A'\in\mathbb Z}E_\theta(A)E_{\theta'}(A')
 K\!\left(\frac{A-A'}H,
          \frac{(A+A')/2-C}{V}\right),
 \qquad \sqrt Q\le H\le V\le Q.
 \tag{11b}
\]

Partition the second normalized coordinate into \(O(V/H)\) intervals of
physical length \(H\). On each tile, both \(A\) and \(A'\) lie in intervals
of length \(O(H)\). Two-dimensional Abel summation bounds the weighted tile
by a fixed constant times the supremum of products of sharp partial sums
of \(E_\theta\) and \(E_{\theta'}\). The normalized first derivatives cost
\(H^{-1}\), the mixed derivative costs \(H^{-2}\), and integration over an
\(H\)-square cancels these factors. Thus the Abel constant is uniform in
\(H,V,Q\).

Applying (11a) tile by tile gives, for every interval of \(X\asymp Q^3\)
consecutive centers,

\[
 \boxed{
 \frac1X\int_{C_0}^{C_0+X}
 |\mathcal R_{H,V}(C)|\,dC
 \ll_{K}BB'\frac{QV}{H}.}
 \tag{11c}
\]

Replacing the integral by a sum over integer centers gives the same bound.
For the integral, split at integer values of the translated tile endpoints;
each unit interval is controlled by the same sharp partial sums. Schwartz
kernels follow by truncation, with an arbitrarily small tail after fixing
enough seminorms.

Now take

\[
 H=\frac QP,\qquad V=\frac{Q^3}{F}.
 \tag{11d}
\]

For fixed \(q,r\asymp Q\), varying the original real packet center \(N\)
over a dyadic interval of length \(\asymp Q^5\) makes
\(C=N/(qr)\) traverse length \(\asymp Q^3\), with a bounded Jacobian after
normalization. Summing (11c) by the triangle inequality over the
\(O(Q^2)\) pairs \(q,r\) gives the centered normalized resonance sum
\(\mathcal R_F(N)\) from the preceding note the averaged bound

\[
 \boxed{
 \frac1{Q^5}\int_{N_0}^{N_0+Q^5}
 |\mathcal R_F(N)|\,dN
 \ll_\varepsilon T^\varepsilon\frac{P Q^5}{F}.}
 \tag{11e}
\]

The factor \(T^\varepsilon\) absorbs the divisor-bounded separator weights,
the absolutely summable smooth separation, and dyadic truncation. The proof
uses no Möbius sign and no \(\Lambda(d)e(-kN/d)\) packet.

## Critical scale and exact remaining gap

In the high fourfold block,

\[
 P=T^{1-2\lambda/5},\qquad Q=T^{\lambda/5},
 \qquad 2<\lambda<29/14,
 \tag{12}
\]

and the difference window has length

\[
 H\asymp\frac QP.
 \tag{13}
\]

The moving center \(N/(qr)\) traverses an interval of length
\(\asymp Q^3\) when \(N\) traverses a length-\(Q^5\) interval with
\(q,r\asymp Q\) fixed. Equations (11)--(13) therefore give the normalized
root-mean-square saving

\[
 \frac{\sqrt Q}{H}
 \asymp\frac P{\sqrt Q}
 =T^{-(\lambda-2)/2}.
 \tag{14}
\]

Equations (11c)--(11e) supply

\[
 \frac{P^2}{Q}=T^{-(\lambda-2)},
 \tag{15}
\]

exactly the factor needed to cancel the current normalized loss
\(Q/P^2=T^{\lambda-2}\) after averaging the actual separated smooth kernel
over real packet centers.

This identifies both the gain and its limit. The product kernel occupies a
diagonal strip of difference width \(H\) and center width
\(V=Q^3/F\ge H\). Tiling it into \(H\)-scale boxes makes (10) the correct
one-window estimate. The theorem controls the simultaneous \(q,r\) sum only
after a real-center average. It does not give the bound at a prescribed
\(N\), does not supply a simultaneous statement for all scales, and gives
no additional \(T^{-\delta}\) beyond the critical factor (15). Those are
the remaining steps.

[ActualMobiusCenteredDivisorWindow.lean](../../formalization/BuildingBlocks/ActualMobiusCenteredDivisorWindow.lean)
checks (5), the sharp bound (7), and the exponents (14)--(15). Its
[axiom audit](../../formalization/verification/ActualMobiusCenteredDivisorWindowAudit.lean)
finds only propext, Classical.choice, and Quot.sound. Lean does not
formalize the congruence averaging in (3), the gcd sum in (9), or the
finite-interval and smooth-kernel estimates (11)--(11e).

## Literature boundary

Broader correlation and short-interval variance questions for divisor and
sieve functions are studied by Coppola and Laporta,
[*On the Correlations, Selberg Integral and Symmetry of Sieve Functions in
Short Intervals, III*](https://arxiv.org/abs/1003.0302), and by Lester,
[*On the variance of sums of divisor functions in short
intervals*](https://arxiv.org/abs/1502.01170). Their results concern wider
asymptotic regimes and, in part, deeper analytic inputs. Equations (3)--(11e)
are a direct finite Chinese-remainder calculation for the particular
restricted coefficient and moving kernel here. No literature-priority claim
is made, and none of those broader theorems is used.
