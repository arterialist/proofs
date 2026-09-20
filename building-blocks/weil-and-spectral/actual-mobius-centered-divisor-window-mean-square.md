# Mean square of centered restricted-divisor windows

**Status:** unconditional written arithmetic theorem, 20 September 2026.
The exact residue-class defect, rational-frequency separation, and critical
exponent ledger are Lean-checked.
The divisor covariance expansion and finite-interval averaging remain written
mathematics. This gives a fixed-power estimate for the genuine high
product-resonance kernel at the prescribed reciprocal packet centers, as
well as the earlier averaged and almost-all-center estimates. It does not
control the separate endpoint and tail blocks or prove the Riemann
hypothesis.

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

and the second elementary bound

\[
 b(g-b)\le Hg
 \tag{8}
\]

retain the window length. Group the pairs \(n,m\) in (6) by their exact
gcd \(g\). There are at most

\[
 \left(\frac Qg+1\right)^2\le\frac{9Q^2}{g^2}
 \tag{9}
\]

ordered pairs in the dyadic interval with gcd \(g\). Since \(nm\ge Q^2\),
the contribution from \(g\le H\), using (7), is \(O(B^2H)\). If \(g>H\),
then \(H\bmod g=H\), and (8) gives \(O(B^2H/g)\). Summing the harmonic tail
yields

\[
 \boxed{
 \frac1L\sum_{C\bmod L}|B_H(C)|^2
 \ll B^2H\left(1+\log\frac{2Q}{H}\right).}
 \tag{10}
\]

Thus the root mean square is
\(O(B\sqrt{H\log(2Q)})\), rather than the cruder \(O(B\sqrt Q)\).

The full period \(L\) is not required. Group equal characters in the exact
finite Fourier expansion (9) from the preceding centering note. This writes

\[
 B_H(C)=\sum_{\alpha\in\mathscr A}c_\alpha e(\alpha C),
 \qquad
 \sum_{\alpha\in\mathscr A}|c_\alpha|^2
 =\frac1L\sum_{C\bmod L}|B_H(C)|^2.
 \tag{10a}
\]

Every \(\alpha\) is a nonzero reduced rational modulo one whose denominator
is at most \(2Q\). Distinct such frequencies have circular spacing at least
\(1/(4Q^2)\). The additive large-sieve inequality therefore gives, uniformly
over every \(X\) consecutive integer centers,

\[
 \frac1X\sum_{C=C_0}^{C_0+X-1}|B_H(C)|^2
 \ll B^2H\left(1+\log\frac{2Q}{H}\right)
 \left(1+\frac{Q^2}{X}\right).
 \tag{11}
\]

The implied constant is absolute and uniform in \(C_0\). This improves the
direct residue-boundary error \(O(B^2H^2Q^2/X)\) by a full factor \(H\).
At \(X\ge Q^2\), (11) is \(O(B^2H\log(2Q))\).

For two centered coefficient families with bounds \(B\) and \(B'\),
Cauchy's inequality in the same center variable therefore gives

\[
 \frac1X\sum_{C=C_0}^{C_0+X-1}
 |B_H(C)B'_H(C)|
 \ll BB'H\log(2Q)\left(1+\frac{Q^2}{X}\right).
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
of length \(O(H)\). Two-dimensional Abel summation writes the weighted tile
as boundary terms and derivative integrals of products of sharp partial
sums of \(E_\theta\) and \(E_{\theta'}\). Average those terms in \(C\)
before taking the derivative integrals. Equation (11a), uniformly for every
partial-window length \(O(H)\), bounds each averaged product by
\(O_K(BB'H\log(2Q)[1+Q^2/X])\). The normalized first derivatives cost
\(H^{-1}\), the mixed derivative costs \(H^{-2}\), and their integration
ranges have lengths \(O(H)\) and area \(O(H^2)\). Thus the Abel constants
remain uniform in \(H,V,Q,X\).

Applying (11a) tile by tile gives the uniform finite-interval form

\[
 \frac1X\int_{C_0}^{C_0+X}
 |\mathcal R_{H,V}(C)|\,dC
 \ll_K BB'V\log(2Q)\left(1+\frac{Q^2}{X}\right).
 \tag{11c0}
\]

In particular, for every interval of \(X\asymp Q^3\) consecutive centers,

\[
 \boxed{
 \frac1X\int_{C_0}^{C_0+X}
 |\mathcal R_{H,V}(C)|\,dC
 \ll_{K}BB'V\log(2Q).}
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
 \ll_\varepsilon T^\varepsilon\frac{Q^5}{F}.}
 \tag{11e}
\]

The factor \(T^\varepsilon\) absorbs the divisor-bounded separator weights,
the absolutely summable smooth separation, and dyadic truncation. The proof
uses no Möbius sign and no \(\Lambda(d)e(-kN/d)\) packet.

## Bandlimited reciprocal sampling

The smooth leading residual has additional structure in the center variable
that is absent from a sharp divisor window. Before the final Fourier
integration, its center phase is exactly \(e(-Cz)\), while the retained
difference cutoff has

\[
 |z|\ll \frac{F}{Q^3}=\frac1V.
 \tag{11f}
\]

Thus each smoothly separated component, as a function of \(C\), has Fourier
support in an interval of length \(O(1/V)\). The discarded smooth tails have
arbitrarily rapid decay and are absorbed in \(T^\varepsilon\). Modulating by
the midpoint of that interval moves it to the origin without changing
absolute values.

The \(L^1\) Plancherel--Pólya inequality says that if \(f\in L^1(\mathbb R)\)
has Fourier support of length \(O(\sigma)\), and
\(\mathcal X\subset\mathbb R\) is \(\Delta\)-separated, then

\[
 \sum_{x\in\mathcal X}|f(x)|
 \ll (\sigma+\Delta^{-1})\int_{\mathbb R}|f(C)|\,dC.
 \tag{11g}
\]

One may prove (11g) by reproducing \(f\) with a Schwartz kernel whose Fourier
transform is one on the support of \(\widehat f\), then summing its translates
over the separated set. Smooth dyadic localization in \(C\) produces rapidly
decreasing Fourier tails at scale \(Q^{-3}\). Decomposing those tails
dyadically and using the uniform local estimate (11c0) makes them summable;
the base scale \(Q^{-3}\) is dominated by (11f). Consequently (11c),
including its smooth tails, supplies the required localized \(L^1\) norm
\(O_\varepsilon(T^\varepsilon VQ^3)\).

For the distinct products \(s=qr\), equation (26) gives
\(\Delta\gg Q\). Equations (11f)--(11g), followed by the exact product
grouping (27) below, therefore give at every prescribed \(N\asymp Q^5\)

\[
 \boxed{
 |\mathcal R_F(N)|
 \ll_\varepsilon T^\varepsilon\frac{Q^5}{F}
 \left(1+\frac{F}{Q^2}\right).}
 \tag{11h}
\]

The product multiplicity costs only \(Q^\varepsilon\), by the divisor bound
proved below. This sampling step uses the exact compact \(z\)-support of the
smooth residual; it is not a claim that arbitrary sharp windows are
bandlimited.

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
root-mean-square saving, up to a logarithm,

\[
 \frac1{\sqrt H}
 \asymp\sqrt{\frac P Q}
 =T^{-(3\lambda-5)/10}.
 \tag{14}
\]

Equations (11c)--(11e) supply

\[
 \frac P Q=T^{1-3\lambda/5},
 \tag{15}
\]

which cancels the current normalized loss \(Q/P^2=T^{\lambda-2}\) and
leaves the additional factor

\[
 \frac1P=T^{-(1-2\lambda/5)}.
 \tag{16}
\]

Equivalently, multiplying (11e) by the Fourier-integral scale
\(M=P^2F/Q^2\) and dividing by the Gram target \(P^3Q^3\) gives the
normalized real-center average \(O_\varepsilon(T^\varepsilon/P)\).

The estimate also holds simultaneously across the high dyadic partition.
Let \(\mathfrak F_T\) be the dyadic values in
\(Q^2\le F\le T^{1-\kappa}\), so
\(|\mathfrak F_T|=O(\log T)\), and set

\[
 \mathcal A_F(N)=
 \frac{P^2F/Q^2}{P^3Q^3}\,|\mathcal R_F(N)|.
 \tag{17}
\]

Equation (11h) gives the prescribed-center estimate

\[
 \mathcal A_F(N)
 \ll_\varepsilon T^\varepsilon\frac1P
 \left(1+\frac{F}{Q^2}\right).
 \tag{17a}
\]

The retained high range has \(F\le T^{1-\kappa}=PQ^2T^{-\kappa}\).
Therefore

\[
 \boxed{
 \mathcal A_F(N)
 \ll_\varepsilon T^\varepsilon
 \left(P^{-1}+T^{-\kappa}\right).}
 \tag{17b}
\]

Both exponents are strictly negative because
\(P=T^{1-2\lambda/5}\), \(\lambda<5/2\), and \(\kappa>0\). Summing the
\(O(\log T)\) dyadic \(F\)-blocks only changes epsilon. This proves a fixed
power saving for the complete smooth leading high product-resonance block at
the actual prescribed packet center.

For every fixed \(\varepsilon>0\), apply (11e) with a smaller epsilon,
then use Markov's inequality and take the union over
\(F\in\mathfrak F_T\). Outside a set \(\mathcal E_T\) satisfying

\[
 \frac{\operatorname{meas}(\mathcal E_T)}{Q^5}
 \ll_\varepsilon T^\varepsilon P^{-1/2},
 \tag{18}
\]

one has, simultaneously for every \(F\in\mathfrak F_T\),

\[
 \mathcal A_F(N)\ll_\varepsilon T^\varepsilon P^{-1/2}.
 \tag{19}
\]

The logarithmic number of blocks is absorbed by epsilon renaming, so their
sum obeys the same bound. Since

\[
 P^{-1/2}=T^{-(1-2\lambda/5)/2},
 \tag{20}
\]

both the exceptional proportion and the simultaneous high-block bound save
a fixed power throughout \(2<\lambda<29/14\).

## Uniform local-center tradeoff

The boundary term in (11c0) also quantifies how densely the simultaneous
good centers occur. Let the original center \(N\) vary in any interval of
length \(Y\) contained in a fixed dyadic range \(N\asymp Q^5\). For fixed
\(q,r\asymp Q\), the corresponding \(C=N/(qr)\) interval has length
\(X\asymp Y/Q^2\). After summing \(q,r\) and applying the normalization in
(17), (11c0) gives, uniformly in the initial point,

\[
 \boxed{
 \frac1Y\int_{N_0}^{N_0+Y}\mathcal A_F(N)\,dN
 \ll_\varepsilon T^\varepsilon\left(
 \frac1P+\frac{Q^4}{PY}\right).}
 \tag{21}
\]

Fix \(0<\sigma\le1\) and take

\[
 Y=\frac{Q^4}{P^{1-\sigma}}.
 \tag{22}
\]

Then the right side of (21) is
\(O_\varepsilon(T^\varepsilon P^{-\sigma})\). Markov's inequality and the
same union over \(\mathfrak F_T\) show that, outside a subset of this
particular interval of relative measure

\[
 \ll_\varepsilon T^\varepsilon P^{-\sigma/2},
 \tag{23}
\]

all dyadic high blocks simultaneously satisfy

\[
 \mathcal A_F(N)
 \ll_\varepsilon T^\varepsilon P^{-\sigma/2}.
 \tag{24}
\]

For epsilon smaller than \(\sigma(1-2\lambda/5)/2\), the exceptional
proportion tends to zero. Thus every interval of the length (22) inside the
dyadic center range contains a positive-measure set of centers good for all
high scales. The limiting exponent identity behind (21)--(24) is

\[
 (4q-p)-\bigl(4q-(1-\sigma)p\bigr)=-\sigma p.
 \tag{25}
\]

This is a local density theorem, not a value at an independently prescribed
center. Letting \(\sigma\) tend to zero approaches intervals of length
\(Q^4/P\), but simultaneously removes the fixed-power saving.

## Reciprocal centers at the prescribed packet

The actual fixed packet center is sampled through reciprocal products rather
than through consecutive values of the center variable. If
\(1\le q,r,q',r'\le 2Q\), \(qr\ne q'r'\), and \(N>0\), then the exact identity

\[
 \left|\frac{N}{qr}-\frac{N}{q'r'}\right|
 =\frac{N|q'r'-qr|}{qrq'r'}
 \ge \frac{N}{16Q^4}
 \tag{26}
\]

shows that distinct product centers are separated by at least \(Q/16\) at
the critical scale \(N\ge Q^5\). This is much more separation than the unit
lattice, but it does not by itself prove a sampling inequality: an equally
spaced set can alias against the rational frequencies \(h/n\).

Let

\[
 \mathcal S_Q=\{qr:Q\le q,r\le2Q\},\qquad
 \nu_Q(s)=\#\{(q,r)\in[Q,2Q]^2:qr=s\}.
\]

Grouping by the product gives the exact finite identity

\[
 \sum_{q,r\asymp Q}
 \left|\sum_{\alpha\in\mathcal F}c_\alpha
 e\!\left(\frac{N\alpha}{qr}\right)\right|^2
 =\sum_{s\in\mathcal S_Q}\nu_Q(s)
 \left|\sum_{\alpha\in\mathcal F}c_\alpha
 e\!\left(\frac{N\alpha}{s}\right)\right|^2.
 \tag{27}
\]

The first coordinate injects the factor pairs counted by \(\nu_Q(s)\) into
the positive divisors of \(s\), so \(\nu_Q(s)\le\tau(s)\). Wigert's maximal
order theorem implies \(\tau(s)\ll_\varepsilon s^\varepsilon\); since
\(s\le4Q^2\), repeated products cost only \(Q^\varepsilon\). Thus it is
sufficient to prove the distinct-product, curvature-sensitive estimate

\[
 \sum_{s\in\mathcal S_Q}
 \left|\sum_{\alpha\in\mathcal F}c_\alpha
 e\!\left(\frac{N\alpha}{s}\right)\right|^2
 \ll_\varepsilon Q^{2+\varepsilon}
 \sum_{\alpha\in\mathcal F}|c_\alpha|^2,
 \qquad N\asymp Q^5,
 \tag{28}
\]

for the reduced frequencies arising from \(1\le h\le P\) and
\(Q\le n\le2Q\). Equation (28) is not proved here. The generic
double-large-sieve scale is \(PQ^2\), so proving (28), or any fixed-power improvement sufficient
for the exponent ledger, requires cancellation from the nonlinear reciprocal
product geometry. Equations (26)--(27) isolate its elementary spacing and
fiber inputs without treating either as that missing cancellation theorem.

The arbitrary coefficients in (28) are stronger than the actual arithmetic
problem requires. Define the finite Dirichlet kernel

\[
 D_H(x)=\sum_{0\le u<H}e(ux).
\]

For the finite Fourier interpolation used in (10a), summing (9) of the
centering note over the window gives the exact expansion

\[
 B_H(C)=\sum_{n\in\mathcal S}\frac{\theta_n}{n}
 \sum_{h=1}^{n-1}D_H(h/n)e(hC/n).
 \tag{29}
\]

If \(a/d\in(0,1)\) is reduced, all pairs with \(h/n=a/d\) are
\((h,n)=(ak,dk)\). Hence its grouped Fourier coefficient is

\[
 c_{a/d}=D_H(a/d)\,\beta_d,
 \qquad
 \beta_d=\sum_{\substack{k\ge1\\dk\in\mathcal S}}
 \frac{\theta_{dk}}{dk}.
 \tag{30}
\]

Thus the allowed coefficient vectors form the image of the at most
\(|\mathcal S|\le Q+1\) divisor weights \(\theta_n\), rather than an
arbitrary space of \(\asymp PQ\) rational-frequency coefficients. Write
\(\mathcal V_H(\theta)\) for the exact periodic variance on the right side
of (6). The coefficient-uniform statement actually needed here is only

\[
 \sum_{s\in\mathcal S_Q}|B_H(N/s)|^2
 \ll_\varepsilon Q^{2+\varepsilon}\mathcal V_H(\theta),
 \qquad N\asymp Q^5.
 \tag{31}
\]

Moreover, \(\mathcal S_Q\subset[Q^2,4Q^2]\), so the same estimate with the
left side completed to every integer \(Q^2\le s\le4Q^2\) would imply (31).
This one-variable sharp-window sampling inequality preserves all coefficient
relations in (29)--(30) and is strictly weaker than (28). It remains
unproved, but (11h) bypasses it for the smooth residual actually used in the
high block.

This identifies both the gain and its limit for the center-average method.
The product kernel occupies a
diagonal strip of difference width \(H\) and center width
\(V=Q^3/F\ge H\). Tiling it into \(H\)-scale boxes makes (10) the correct
one-window estimate. The theorem controls the simultaneous \(q,r\) sum in
mean over the real center and, by (18)--(19), at almost every center for all
dyadic high scales at once. The bandlimited sampling step (11f)--(11h)
supplies the prescribed-center translation for the smooth leading high
block. The separate endpoint and tail pieces outside this high block remain
open.

[ActualMobiusCenteredDivisorWindow.lean](../../formalization/BuildingBlocks/ActualMobiusCenteredDivisorWindow.lean)
checks (5), the bounds (7)--(8), the reciprocal separation (26), the exact
fiber grouping (27), its divisor-count bound, the containment
\(\mathcal S_Q\subset[Q^2,4Q^2]\), and the exponents (14)--(16) and (20). Its
[axiom audit](../../formalization/verification/ActualMobiusCenteredDivisorWindowAudit.lean)
finds only propext, Classical.choice, and Quot.sound. Lean does not
formalize the congruence averaging in (3), the gcd sum in (9), or the
large-sieve and smooth-kernel estimates (11)--(11e), Markov's inequality, or
the dyadic unions in (18)--(19) and (23)--(24). Lean checks the denominator
product and dyadic \(1/(4Q^2)\) frequency gaps used before (11), the local
length and gain identity (25), and the normalization inequality behind
(17a)--(17b). It does not formalize the Plancherel--Pólya sampling step,
(28), (31), the coefficient formulas (29)--(30), or the analytic bound
\(\tau(s)\ll_\varepsilon s^\varepsilon\).

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

The finite-interval step (11) uses the classical additive large sieve in the
sharp spaced-frequency form of Montgomery and Vaughan,
[*The large sieve*](https://doi.org/10.1112/S0025579300004708). Its only
specialized input here is the elementary denominator bound compiled in the
Lean companion.

The divisor-multiplicity reduction uses Wigert's classical maximal-order
theorem for \(\tau\); see Wigert, *Sur l'ordre de grandeur du nombre des
diviseurs d'un entier* (1907), and the later account in
[*Sur quelques fonctions arithmétiques*](https://archive.ymsc.tsinghua.edu.cn/pacm_download/117/5240-11511_2006_Article_BF02401831.pdf).

The unresolved estimate (28) belongs to the setting of multidimensional
monomial exponential sums. A relevant benchmark is Robert and Sargos,
[*Three-dimensional exponential sums with monomials*](https://doi.org/10.1515/CRELLE.2006.012).
No consequence of their theorem is asserted here; matching its hypotheses to
the coefficient-uniform operator norm in (28) remains open.

The prescribed-center step (11g) uses the classical \(L^1\)
Plancherel--Pólya inequality. A modern statement for separated real samples
and entire functions of exponential type is given by Pesenson,
[*Plancherel--Polya-type inequalities for entire functions of exponential
type in \(L^p(\mathbb R^d)\)*](https://doi.org/10.1016/j.jmaa.2006.08.032).
