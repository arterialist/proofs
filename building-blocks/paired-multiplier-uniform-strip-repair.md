# Uniform paired multiplier bound and smaller full signed histories

Developed in the RH Agent3 branch, with independent mathematical review by RH Proof. The full analytic conclusions remain written proofs; compiled finite algebra is linked separately. No novelty or RH claim is made.

This written, independently audited calculation strengthens the large-history full signed
comparison. It uses exact finite coefficients of the actual local
scattering approximation. It neither assigns a sign to the Weil form
nor proves RH. The exact finite paired polynomial, exponential moment
and actual-parameter half-strip bound are now compiled in
[PairedScatteringDefect.lean](BuildingBlocks/PairedScatteringDefect.lean).
The measure construction, block transport and complete-zero estimates
remain written mathematics.

## Exact positive defect measure for one paired factor

Set (r=p^{-1/2}), (c=1-r^2), (L=\log p). The compact actual-factor
approximation has multiplier
\[
v_{p,M}(z)=-r e^{zL}+c\sum_{j=0}^{M-1}r^j e^{-zjL},
\qquad M\ge1.
\]
Multiplication of the two finite polynomials, or the exact coefficient
autocorrelation already derived in the local-factor note, gives
\[
A_{p,M}(z)=v_{p,M}(z)v_{p,M}(-z)
 =1-c r^{2M}-2c\sum_{j=1}^M r^{2M-j}\cosh(zjL).
\tag{1}
\]
The endpoint (j=M) is included. Define a finite positive symmetric
measure
\[
\mathcal D_{p,M}=c r^{2M}\delta_0
 +c\sum_{j=1}^M r^{2M-j}(\delta_{jL}+\delta_{-jL}).
\]
Then (1) says (A_{p,M}(z)=1-\int e^{zu}\mathcal D_{p,M}(du)).
For (|\Re z|\le1/2), symmetry and positivity show
\[
\left|\int e^{zu}\mathcal D_{p,M}(du)\right|
 \le c r^{2M}+2c\sum_{j=1}^M r^{2M-j}\cosh(jL/2)
 =1+[(M+1)c-1]r^{2M}\le2.
\tag{2}
\]
To verify the equality, use (e^{L/2}=r^{-1}) and sum
\(c\sum_{j=1}^M r^{2(M-j)}=1-r^{2M}\); the other (M) terms each
equal (c r^{2M}). For the inequality,
\([(M+1)c-1]r^{2M}\le(M+1)2^{-M}\le1\).
These are entire finite-polynomial identities, valid even at boundary
zeros of the rational actual-factor expression. Consequently
\[
\boxed{|A_{p,M}(z)|\le3\quad(|\Re z|\le1/2),}
\qquad
|A_B(z)|\le3^{\#\mathcal B_P}
 \le\exp(C_*P/\log P).
\tag{3}
\]
The constants in (3) are independent of (M). This improves the earlier
crude bound ((M+1)^{2\#\mathcal B_P}).

The ordinary defect mass is much smaller:
\[
\mathcal D_{p,M}(\mathbb R)
 =2(1+r)r^M-(1+r)^2r^{2M}.
\]
Its half-strip exponential moment in (2), however, approaches one as
(M\to\infty). Thus small ordinary mass alone does not control
off-critical translations. Positivity of this defect measure also
does not make the signed Weil distribution positive.

For a complete block the exact correlation transport measure is
\[
\mathcal K_B=\mathop{*}_{p\in\mathcal B_P}
 (\delta_0-\mathcal D_{p,M})
 =\delta_0+\sum_{\varnothing\ne S\subseteq\mathcal B_P}
 (-1)^{|S|}\mathop{*}_{p\in S}\mathcal D_{p,M},
\qquad C_{V_Bf}=\mathcal K_B*C_f.
\]
This finite inclusion-exclusion identity retains every joint history.
Even though each individual defect measure is positive, the block
correction alternates in sign. A positivity deduction would still
require control of the Weil functional on these shifted correlations.

## Full signed comparison with logarithmically smaller support

Fix (a,R>0), smooth compact pole-null packets (h,k), and (D>0).
Let (c_0>0) be the unconditional zero-free constant used in
`dyadic-full-weil-large-history-repair.md`. Choose fixed (K) with
\[
\alpha:=Kc_0/(2D)>R+2+a/2,
\qquad M(P)=\lceil KP/\log P\rceil,
\quad H(P)=DP/\log P.
\tag{4}
\]
Use the dyadic transport block (mathcal B_P=\{p:P<p\le2P\}),
the literal compact translation product (V_B), and packets
\(f_{U,w}=h+w\tau_Uk\), (0\le U\le a\log P), (|w|\le1).
The conclusion is
\[
\boxed{\sup_{U,w}|Q(V_Bf_{U,w})-Q(f_{U,w})|=O(P^{-R}).}
\tag{5}
\]

Here are the full zero-sum estimates. Split at height (e^{H(P)}).
Below it, the established unconditional region gives
\(\delta_\rho\ge c_0/(2H(P))\). For either sign of (z_\rho=\rho-1/2),
the exact rational relative defect is
\[
d_p(z)=\frac{c p^{-M(z+1/2)}}{1-p^{z-1/2}},\qquad
A_B(z)=\prod_p(1-d_p(z))(1-d_p(-z)).
\]
The boundary denominator inverse is (O(H/\log P)), and
\(M\delta_\rho\log p\ge\alpha\log P\). Hence
\[
\sup_{|\Im\rho|\le e^H}\sum_p(|d_p(z_\rho)|+|d_p(-z_\rho)|)
 \le C_D\frac{P^2}{\log^3P}P^{-\alpha}.
\tag{6}
\]
The moving-packet paired zero weights satisfy
\[
|\Phi_{f_{U,w}}(\sigma+i\gamma)|
 \le C_{h,k,q}P^{a/2}(1+|\gamma|)^{-q},
 \qquad |\sigma|\le1/2,
\]
for every fixed integer (q>0); the diagonal translation factors
cancel and the two cross factors are (e^{\pm zU}).
Thus (6) and the finite-product estimate give low-zero error
\(O(P^{2+a/2-\alpha}/\log^3P)=O(P^{-R})\).

For the high zeros use (3), rather than the old depth-dependent bound.
The unconditional zero count and fixed-packet integration by parts give
the high-zero comparison bound
\[
C_{h,k,q}P^{a/2}H
 \exp\big([C_*+D(1-q)]P/\log P\big).
\tag{7}
\]
Choose a fixed integer (q>1+C_*/D+1). The exponential in (7)
then beats every fixed negative power of (P). All actual zeros and
their multiplicities remain in the compact explicit formula; no
critical-line assumption is made. This proves (5).

Four-phase polarization gives the same (O(P^{-R})) error for the
full complex cross (C(V_Bh,V_B\tau_Uk)-C(h,\tau_Uk)), uniformly
on the displayed age interval. On the real Fourier axis the sum of
actual-factor compact tail errors is
\(O((P/\log P)P^{-M/2})=O((P/\log P)e^{-KP/2})\).
Actual factors are unitary there. Telescoping and the fixed integrable
digamma weight give exponentially small complete archimedean scalar
and cross errors, uniformly in (U,w). Literal pole terms vanish.
Subtracting the archimedean comparison therefore gives (5)'s error
for the complete signed arithmetic row and for its complex cross.
Both positive-axis correlation orientations after transport and every
observing prime power are retained.

The compact support diameter is now
\[
O_{h,k,a,K}(P^2/\log P),
\]
instead of (O(P^2)) in the previous logarithmic-age proof. A common
physical translation preserves all asserted quantities and can place
the finite supports in nonnegative age. This improves the quantitative
signed growing-prime comparison; it does not prove the original row's
required sign or upper bound, actual RH, or its complete Lean proof.
