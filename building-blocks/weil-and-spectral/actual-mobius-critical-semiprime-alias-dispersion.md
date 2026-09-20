# The critical all-unit alias-dispersion target

**Status.** This note gives an unconditional alias reduction for the
all-unit contact split, a written mean-square estimate for its
prime-restricted diagonal subcomponent, and a comparison with the analytic
estimates used below. The exponent identities are formalized in
[`ActualMobiusCriticalSemiprimeAliasDispersion.lean`](../../formalization/BuildingBlocks/ActualMobiusCriticalSemiprimeAliasDispersion.lean).
The continuous mean-value and sampling argument below is written
mathematics. No prefix extension or Riemann-hypothesis result is claimed.

## 1. Critical scales and the exact contact packet

At the endpoint \(d=3\lambda/5\), put

\[
 P=L=T^{1-2\lambda/5},\qquad Q=T^{\lambda/5},\qquad
 C=T^{4\lambda/5-1},\qquad D=T^{3\lambda/5}.
\tag{1}
\]

Here \(k\asymp L\) is the physical Poisson mode, \(p\asymp P\) and
\(q\asymp Q\) are the two unweighted integer factors in the surviving
all-unit split, and \(c\asymp C\) contains the untouched outer factor. The scale
relations are

\[
 CP=Q^2,\qquad D=CPQ=Q^3,\qquad N=Q^5.
\tag{2}
\]

After the usual packet and Mellin separations, the critical shell has the
form

\[
 \mathcal S=
 \frac1{P\sqrt N}
 \sum_{k\asymp P}\alpha_k
 \sum_{c\asymp C}a_c
 \sum_{p\asymp P}b_p
 \sum_{q\asymp Q}d_q
 e\!\left(-\frac{kN}{cpq}\right),
\tag{3}
\]

with bounded separated packet coefficients and the actual outer arithmetic
sign retained. The exact K=3 history gives coefficient \(1\) on each local
factor. Thus \(p,q\) range over integers and carry no independent Möbius
sign. Restricting both variables to primes gives a valid subcomponent, but
does not recover the full contact split.

The phase has size

\[
 \frac{PN}{CPQ}=T.
\tag{4}
\]

The unnormalized mass is \(PCPQ=PD\), of exponent \(1+\lambda/5\).
Since the prefactor in (3) is \((P\sqrt N)^{-1}\), a power-saving packet
bound is equivalent to

\[
 \left|\sum_{k,c,p,q}\cdots\right|
 \ll P\sqrt N\,T^{-\eta}
 =T^{1+\lambda/10-\eta}.
\tag{5}
\]

Thus a direct estimate must save \(T^{\lambda/10+\eta}\) from the raw
four-variable mass.

## 2. The two mean-square targets

Set

\[
 B_{k,c}=\sum_{p\asymp P}\sum_{q\asymp Q}
 b_p d_q e\!\left(-\frac{kN}{cpq}\right),
 \qquad
 Z_k=\sum_{c\asymp C}a_c B_{k,c}.
\tag{6}
\]

Either of the estimates

\[
 \boxed{\sum_{k\asymp P}|Z_k|^2
 \ll P Q^5 T^{-2\rho}}
\tag{B}
\]

or

\[
 \boxed{\sum_{k\asymp P}\sum_{c\asymp C}|B_{k,c}|^2
 \ll P^2Q^3T^{-2\rho}}
\tag{C}
\]

with some fixed \(\rho>0\), together with the corresponding coefficient
norms, gives the missing fixed gain in (5). Without \(T^{-2\rho}\), both
targets sit exactly at the normalization needed for (5).

## 3. Full Poisson alias equation

Expand the square in (B), and write

\[
 x=cpq,\qquad y=c'p'q'.
\]

Poisson summation in the smooth \(k\)-sum gives kernels centered on

\[
 \frac{N(y-x)}{xy}=-j,
 \qquad j\in\mathbb Z.
\tag{7}
\]

On the critical scales,

\[
 \frac{N}{D^2}=Q^{-1}.
\tag{8}
\]

Consequently the aliases satisfy

\[
 |j|\ll \frac DQ=Q^2.
\tag{9}
\]

The Fourier width is \(1/P\) in the left side of (7). Translated to the
integer product displacement \(h=y-x\), this is the window

\[
 \left|h+j\frac{xy}{N}\right|
 \ll \frac{D^2}{NP}=\frac QP.
\tag{10}
\]

Equations (7)--(10) are the full nonzero-alias geometry. Taking absolute
values alias by alias returns the already saturated double-large-sieve
count. Any improvement must preserve correlation across \(j\), or preserve
the signed \(a_c\overline{a_{c'}}\) correlation while reorganizing by
\(h=cpq-c'p'q'\).

## 4. Which diagonal saturates

The literal transformed diagonal \(j=0,x=y\) does **not** exhaust either
target. Its natural size, up to divisor powers, is

\[
 P\,D=P Q^3=T^{1+\lambda/5}.
\tag{11}

This is below (B) by \(Q^2\), and below (C) by \(P\).

The saturation in the direct double-large-sieve argument is the earlier
\(q=q'\) sector. Before using its remaining phase, its cardinality is

\[
 P\cdot Q\cdot (CP)^2=P Q^5,
\tag{12}

exactly the right side of (B) with \(\rho=0\). Retaining the phase and the
outer signs turns this sector into the concrete nonnegative mean square

\[
 \boxed{
 \sum_{k\asymp P}\sum_{q\asymp Q}
 \left|
   \sum_{r\asymp Q^2}R(r)
   e\!\left(-\frac{kN}{qr}\right)
 \right|^2,}
\tag{13}
\]

where

\[
 R(r)=\sum_{\substack{c\asymp C,\ p\asymp P\\cp=r}}a_c b_p.
\tag{14}
\]

Its trivial bound is precisely \(P Q^5\). Hence the next theorem really
needed is a fixed-power mean-square saving in (13), with the actual
convolution coefficient (14), or a full-alias dispersion theorem that also
controls the \(q\ne q'\) sectors. The exact product diagonal inside (13)
has size only \(P Q^3\); the missing mass is carried by the collective
nonzero aliases.

For (13), Poisson summation in \(k\) produces

\[
 \frac Nq\left(\frac1r-\frac1{r'}\right)=-j+O(P^{-1}),
 \qquad |j|\ll Q^2.
\tag{15}
\]

Because \(N/(Q(Q^2)^2)=1\), the alias index tracks the integer displacement
\(r'-r\) at unit scale. This exact resonance explains why a pointwise
spacing estimate is saturated and why cancellation across aliases, rather
than another count of each alias, is required.

## 5. Check against available primary estimates

Cao--Zhai's three-dimensional Theorem 6 in
[*Multiple exponential sums with monomials*](https://matwbn.icm.edu.pl/ksiazki/aa/aa92/aa9231.pdf)
can be applied for fixed \(c\) to \((p,k,q)\), with monomial exponents
\((-1,1,-1)\) and phase size \(T\). Its first displayed term, after the
outer \(c\)-sum is restored, has exponent

\[
 \frac{3\lambda+5}{8}
 =1+\frac\lambda{10}+\frac{11\lambda-15}{40}.
\tag{16}
\]

The excess is positive throughout \(2<\lambda<29/14\). Interchanging
\(p\) and \(q\) gives exponent \((9\lambda+35)/40\), whose excess over the
target is \((\lambda-1)/8>0\). Thus this genuine simultaneous
three-variable estimate does not prove (B) or (C).

Robert--Sargos' three-dimensional estimate controls the adjacent grouped
regions, but at this critical contact its corresponding exponent has no
strict margin. The 2024 result of Pliego concerns a special weighted domain
and explicitly does not transfer to general dyadic boxes with the present
arithmetic coefficients. Bettin--Chandee's
[*Trilinear forms with Kloosterman fractions*](https://arxiv.org/abs/1502.00769)
uses modular inverses and congruence reciprocity; (7) is a real reciprocal
phase with no modulus, so that theorem is not directly applicable. Even
when \(N\) is integral and \((q,r)=1\), additive reciprocity only gives

\[
 e\!\left(\frac{kN}{qr}\right)
 =e\!\left(\frac{kN\overline q}{r}
            +\frac{kN\overline r}{q}\right).
\tag{17}
\]

Bettin--Chandee controls one separated Kloosterman fraction, optionally
with a smooth real perturbation. The second modular-inverse factor in (17)
depends jointly on \(k,q,r\); it is neither a separated coefficient nor the
smooth perturbation allowed by their Remark 1. Thus reciprocity alone does
not put (13) under their theorem.

At this stage the remaining analytic task is sharply isolated: prove a
power saving in (13), or in the full signed alias form (7), without replacing
the nonzero aliases by their separate absolute spacing counts. The next
section resolves (13); the following section records what remains in (7).

## 6. A power saving for the prime-restricted residual

The particular residual (13) does admit a direct unconditional saving. The
argument uses the aliases collectively through continuous sampling rather
than bounding their spacing windows separately.

Let

\[
 R_0=CP\asymp Q^2,\qquad \mathcal Q=\frac{N}{R_0^2}\asymp Q,
\tag{18}
\]

and define

\[
 x_{k,q}=\frac{k\mathcal Q}{q},\qquad
 y_r=\frac{N}{\mathcal Qr}=\frac{R_0^2}{r},\qquad
 F(x)=\sum_{r\asymp R_0}R(r)e(-xy_r).
\tag{19}
\]

Then the phase is preserved exactly:

\[
 x_{k,q}y_r=\frac{kN}{qr}.
\tag{20}
\]

The frequencies \(y_r\) are separated by a fixed constant. Indeed, for
distinct integers \(r,r'\asymp R_0\),

\[
 |y_r-y_{r'}|
 =\frac{R_0^2|r-r'|}{rr'}\gg |r-r'|.
\tag{21}
\]

They also satisfy \(|y_r|\ll R_0\ll Q^2\). The continuous Hilbert
inequality, applied after expanding the square, therefore gives on every
interval \(I\) of length \(O(P)\)

\[
 \int_I|F(x)|^2\,dx\ll P\|R\|_2^2,
 \qquad
 \int_I|F'(x)|^2\,dx\ll P Q^4\|R\|_2^2.
\tag{22}
\]

For completeness, the first estimate follows because the diagonal of the
integral is \(|I|\|R\|_2^2\), while each endpoint contribution off the
diagonal is a Hilbert form with denominator \(y_r-y_{r'}\). The second is
the same argument with coefficients \(2\pi i y_rR(r)\).

Distinct values among the \(x_{k,q}\) are \(\gg Q^{-1}\)-separated:

\[
 \left|\frac{k\mathcal Q}{q}-
             \frac{k'\mathcal Q}{q'}\right|
 \gg \frac{Q}{qq'}\gg Q^{-1}.
\tag{23}
\]

They all lie in an interval of length \(O(P)\). Around the distinct values
choose disjoint intervals \(I_j\) of length \(\asymp Q^{-1}\). The
fundamental theorem of calculus applied to \(|F|^2\), followed by
Cauchy--Schwarz, gives

\[
\begin{aligned}
 \sum_j|F(x_j)|^2
 &\ll Q\int_I|F(x)|^2\,dx
     +\int_I|F(x)F'(x)|\,dx\\
 &\ll P Q^2\|R\|_2^2.
\end{aligned}
\tag{24}
\]

Restrict this subcomponent to prime \(q,q'\asymp Q\), with
\(k,k'\asymp P<Q\). Then \(\gcd(k,q)=\gcd(k',q')=1\), and equality
\(k/q=k'/q'\) forces
\(k=k'\) and \(q=q'\). There is no multiplicity loss. The packet weights
are harmless after the established Fourier--Mellin separation: each
component has bounded scalar \(k\)- and \(q\)-weights and one common
\(r\)-coefficient, and the separator has total \(L^1\)-mass
\(T^\varepsilon\). No arbitrary joint weight \(W_{k,q}(r)\) is admitted.
Hence

\[
 \sum_{k\asymp P}\sum_{q\asymp Q}
 \left|\sum_{r\asymp Q^2}R(r)e\!\left(-\frac{kN}{qr}\right)\right|^2
 \ll T^\varepsilon P Q^2\|R\|_2^2.
\tag{25}
\]

For the actual unrestricted integer \(q\)-sum, equal reduced fractions can
have multiplicity \(O(P)\); the corresponding weaker majorant is
\(T^\varepsilon P^2Q^2\|R\|_2^2\). This is the relevant scale for the full
all-unit contact split and does not give the saving below.

For (14), fixed divisor bounds and the standard fixed divisor-moment bound
give

\[
 \|R\|_2^2\ll T^\varepsilon CP=T^\varepsilon Q^2.
\tag{26}
\]

Combining (25) and (26),

\[
 \boxed{
 \sum_{k\asymp P}\sum_{q\asymp Q}
 \left|\sum_{r\asymp Q^2}R(r)e\!\left(-\frac{kN}{qr}\right)\right|^2
 \ll T^\varepsilon P Q^4.}
\tag{27}
\]

The requested unsaved target is \(PQ^5\), and

\[
 \frac{PQ^4}{PQ^5}=\frac1Q=T^{-\lambda/5}.
\tag{28}
\]

Thus (27) gives (B) on the previously saturated \(q=q'\) sector for every
fixed

\[
 0<2\rho<\frac{\lambda}{5}.
\tag{29}
\]

This theorem controls the prime-prime subcomponent of that residual. It
does not control the composite integer values present in the exact K=3
all-unit split, nor does it assert that all \(q\ne q'\) terms in (7) have
the same margin. The full integer contact sum therefore remains open.

The alternative fixed-\(q\) local-density argument gives the weaker but
compatible bound \(Q^5T^\varepsilon\). Indeed,

\[
 \frac{PQ^4}{Q^5}=\frac{P}{Q}
 =T^{-(3\lambda/5-1)}<1.
\tag{30}
\]

Thus there is no discrepancy between the two estimates in the present
range; (27) retains the stronger continuous-sampling output.

## 7. Why unsigned two-parameter Schur does not finish the splice

For \(q\ne q'\), expansion of the full square gives the phase

\[
 \frac{N(q'r'-qr)}{qq'rr'}.
\tag{31}
\]

Poisson summation in \(k\) again produces \(O(Q^2)\) aliases and a window
of width \(Q/P\) in the integer displacement

\[
 h=q'r'-qr.
\tag{32}
\]

An unsigned local-density or Schur count chooses \(q,q',r\), then counts
the admissible \(r'\). For each of the \(O(Q^2)\) aliases the permitted
interval in \(r'\) has length

\[
 \frac{Q/P}{q'}\asymp P^{-1}.
\tag{33}
\]

The fact that this length is below one is not by itself a lattice count.
Applying the standard one-dimensional reciprocal spacing estimate to the
whole monotone \(r'\)-sequence gives \(O(T^\varepsilon Q^2/P)\) admissible
\((j,r')\) pairs. Its volume term dominates the second-derivative error
because \(Q^2/P^3\gg1\), not merely because \(Q>P\). This is the same spacing input already used in the direct
double-large-sieve audit. Consequently the total local-density count has
size

\[
 Q\cdot Q\cdot Q^2\cdot\frac{Q^2}{P}
 =\frac{Q^6}{P}.
\tag{34}
\]

Restoring the leading \(P\) from Poisson summation gives \(Q^6\). This
misses target (B) by exactly

\[
 \frac{Q^6}{PQ^5}=\frac QP=T^{3\lambda/5-1}.
\tag{35}
\]

Thus the one-parameter sampling theorem genuinely removes the diagonal
residual, but its unsigned two-parameter analogue merely reproduces the
critical loss on the off-diagonal. Further progress must obtain a factor
beyond \(Q/P\) from the signed correlation across different aliases or from
the actual convolution coefficients; another absolute local-density bound
cannot prove the full splice.
