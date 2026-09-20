# Reciprocal mean square as an actual short-shift Möbius correlation

**Status:** exact finite reduction, absolute zero-resonance bound, and
literature boundary, 20 September 2026. The finite mean-square expansion,
its diagonal, the exact reciprocal phase gap, the coherence scale, and the
zero-resonance endpoint exponent identities are
formalized and axiom-audited in
[`ActualMobiusReciprocalCorrelation.lean`](../../formalization/BuildingBlocks/ActualMobiusReciprocalCorrelation.lean).
No estimate for the off-diagonal correlation is proved here. In particular,
this note does not enlarge the Möbius cutoff or prove the Riemann hypothesis.

This note continues the
[free-factor pruning](actual-mobius-tail-free-factor-pruning.md). In the
primitive balanced residual, regrouping coprime pairs by their product gives

\[
 A_{R,S}(n)=\mu(n)d_{R,S}(n),
 \qquad
 d_{R,S}(n)=
 \#\{r\mid n:r\asymp R,\ n/r\asymp S,\ (r,n/r)=1\}.
\tag{1}
\]

In the globally recombined partition, the corresponding coefficient is

\[
 c(n)=(\mu*\mu)(n).
\tag{2}
\]

The kernel calculation below is specialized throughout to the primitive
free-factor block \(t=1\), so \(n=rs\asymp D\). For a generic fixed free
factor, the total product is \(m=tn\asymp D\), the \(n\)-scale is
\(D/t\), and the mode length must be rewritten consistently before
applying the same algebra. No generic-\(t\) scale claim is made here.

The two coefficients belong to different complete partitions. They are not
interchanged below. The same finite mean-square algebra applies to either
one after its own complementary ranges have been retained.

## Exact kernel identity

Let \(\mathcal K\) be a finite interval of Poisson modes, let
\(\mathcal Q\subset[D,2D]\), and put

\[
 \chi_k(n)=e\!\left(-\frac{kN}{n}\right).
\tag{3}
\]

For any complex coefficient \(A(n)\),

\[
\boxed{
 \sum_{k\in\mathcal K}
 \left|\sum_{n\in\mathcal Q}A(n)\chi_k(n)\right|^2
 =
 \sum_{n_1,n_2\in\mathcal Q}
 A(n_1)\overline{A(n_2)}
 \sum_{k\in\mathcal K}
 e\!\left(
 -kN\left(\frac1{n_1}-\frac1{n_2}\right)
 \right).}
\tag{4}
\]

This is `finiteMeanSquareExpansion` in the Lean module. Since every
\(\chi_k(n)\) has modulus one, the diagonal \(n_1=n_2\) is exactly

\[
 |\mathcal K|\sum_{n\in\mathcal Q}|A(n)|^2.
\tag{5}
\]

This is `finiteMeanSquareDiagonal`. All arithmetic cancellation required
beyond (5) lies in the signed off-diagonal.

Write \(n_2=n+h\). The phase difference is exactly

\[
 N\left(\frac1n-\frac1{n+h}\right)
 =\frac{Nh}{n(n+h)}.
\tag{6}
\]

No Taylor approximation is needed. If the mode interval has the physical
length

\[
 L=\frac{DT}{N},
\tag{7}
\]

then

\[
 L\frac{Nh}{D^2}=\frac{Th}{D}.
\tag{8}
\]

Equations (6) and (8) are the Lean theorems `primitiveReciprocalGap` and
`reciprocalCoherenceScale`. Thus the zero-resonance branch of the
geometric kernel in (4) is coherent on the short-shift range

\[
 |h|\lesssim \frac DT.
\tag{9}
\]

The elementary geometric-sum estimate is

\[
 \left|\sum_{k\in\mathcal K}e(-k\theta)\right|
 \ll \min\{L,\|\theta\|^{-1}\}.
\tag{9a}
\]

Consequently, shifts outside (9) can resonate again when the phase gap is
close to a nonzero integer. Equation (9) isolates the unavoidable
zero-resonance branch; it does not exhaust the off-diagonal.

Define the exact finite kernel

\[
 K_{\mathcal K}(\theta)=\sum_{k\in\mathcal K}e(-k\theta).
\tag{9b}
\]

After inserting a cutoff to the zero-resonance branch, its literal
off-diagonal contribution is an actual weighted correlation problem of the
form

\[
 \sum_{0<|h|\lesssim D/T}
 \sum_{\substack{n\in\mathcal Q\\n+h\in\mathcal Q}}
 A(n)\overline{A(n+h)}
 K_{\mathcal K}\!\left(\frac{Nh}{n(n+h)}\right),
\tag{10}
\]

The complete expansion (4) also contains the diagonal \(h=0\) and the
nonzero-resonance branches just noted. For the original primitive partition,
(10) retains the exact coefficient
\(A(n)=\mu(n)d_{R,S}(n)\). For the separate globally recombined partition,
it retains \(A(n)=c(n)W(n/D)\), together with every complementary region
of that partition.

## Required power

The existing reciprocal second-moment target is

\[
 \sum_{k\asymp L}
 \left|\sum_{n\asymp D}A(n)e(-kN/n)\right|^2
 \ll_\varepsilon
 T^\varepsilon\left(LD+D^2T^{-\rho}\right).
\tag{11}
\]

The shell before the mean-square estimate has normalization
\((L\sqrt N)^{-1}\), and Cauchy's inequality in the \(L\) modes costs
\(\sqrt L\). Therefore (11) gives, term by term,

\[
 \frac{1}{L\sqrt N}\sqrt L
 \sqrt{LD+D^2T^{-\rho}}
 \leq
 \sqrt{\frac DN}
 +\sqrt{\frac DT}\,T^{-\rho/2}.
\tag{12}
\]

Here \(L=DT/N\), and \(\sqrt{x+y}\leq\sqrt x+\sqrt y\) was used.
If \(D=T^d\), the diagonal term saves \(T^{-\eta}\) when

\[
 \eta<\frac{\lambda-d}{2},
\tag{12a}
\]

while the off-diagonal term saves \(T^{-\eta}\), after the
\(T^\varepsilon\) losses, only with the strict margin

\[
 \rho>d-1+2\eta.
\tag{12b}
\]

The weak inequality \(\rho\ge d-1+2\eta\) records only the bare exponent
comparison before those losses; it is not the final analytic condition.

At the present endpoint

\[
 d_*=\frac{2(\lambda+1)}5,
\tag{13}
\]

this becomes

\[
 \rho>
 \frac{2\lambda-3}{5}+2\eta.
\tag{14}
\]

The equality \(d_*-1=(2\lambda-3)/5\) and the margin rewrite are Lean
theorems `endpointCorrelationThreshold` and
`endpointCorrelationMargin`. The diagonal condition at this endpoint is

\[
 \eta<\frac{3\lambda-2}{10},
\tag{14a}
\]

formalized as `endpointDiagonalThreshold`. Notice that the off-diagonal
threshold exponent is also the length of the coherent shift interval:

\[
 \frac DT=T^{d_*-1}
 =T^{(2\lambda-3)/5}.
\tag{15}
\]

The coherence scale alone does not make this branch an obstruction.  The
geometric kernel is at most (L), there are (O(H)) shifts with
(H=D/T), and for both coefficients in (1)--(2) the divisor bound gives
(|A(n)|\ll_\varepsilon T^\varepsilon).  Therefore absolute summation of
the entire zero-resonance branch gives

\[
 \boxed{
 \mathcal E_{0}
 \ll_\varepsilon T^\varepsilon LHD
 =T^\varepsilon\frac{D^3}{N}.}
 \tag{15a}
\]

This includes hard interval endpoints: they can only shorten the (n)- or
(h)-ranges.  To place (15a) under the second term of (11), it suffices
that

\[
 \rho<\lambda-d.
 \tag{15b}
\]

At (d=d_*), choose

\[
 \rho_0=\frac{\lambda-1}{2}.
 \tag{15c}
\]

The two available margins are exactly equal:

\[
 \rho_0-(d_*-1)
 = (\lambda-d_*)-\rho_0
 =\frac{\lambda+1}{10}>0.
 \tag{15d}
\]

Thus, for example, every fixed
(0<\eta<(\lambda+1)/20) satisfies the strict requirement
(\rho_0>d_*-1+2\eta), after leaving the usual (T^\varepsilon) room.
No signed Möbius correlation estimate is needed for the zero-resonance
branch.  The unresolved terms are the nonzero integer-resonance branches
of the complete kernel.

## Published inputs and their boundary

Basak, Robles and Zaharescu,
[*Exponential sums over Möbius convolutions with applications to
partitions*](https://arxiv.org/abs/2312.17435), Corollary 7.1, prove a
fixed-power estimate for the global **linear additive twist**

\[
 \sum_{n\le X}(\mu*\mu)(n)e(n\alpha).
\tag{16}
\]

Their displayed bound is

\[
 \ll_\varepsilon
 X^{16/17+\varepsilon}
 +X(\log X)^3q^{-1/6}
 +X^{7/8}q^{1/8}(\log X)^3
\tag{17}
\]

when \((a,q)=1\) and
\(|\alpha-a/q|\leq q^{-2}\). Its \(q\)-dependent right side gives a
fixed-power saving only in suitable approximation ranges, not uniformly for
every \(q\). Equation (17) is a global prefix estimate. Differencing it
does not give a fixed-power estimate relative to an interval of length
\(D/T\), and the reciprocal phase in (3) produces the short-shift kernel
(10), rather than a single linear additive twist.

Matomäki, Radziwiłł, Shao, Tao and Teräväinen,
[*Higher uniformity of arithmetic functions in short intervals II. Almost
all intervals*](https://doi.org/10.1007/s00222-026-01408-6), record
unconditional cancellation of \(\mu\) in almost all intervals as short as
\(X^\varepsilon\), with logarithmic savings and a logarithmically sparse
exceptional set in the quantitative statement quoted there. That theorem
does not give the uniform fixed power in (11), and it does not directly
cover the product-dependent weight \(d_{R,S}(n)\).

Mangerel,
[*Divisor-bounded multiplicative functions in short
intervals*](https://doi.org/10.1007/s40687-023-00376-0), extends typical
short-interval estimates to broad divisor-bounded multiplicative classes.
The balanced-divisor coefficient in (1) depends on the chosen rectangle and
is not itself a fixed multiplicative function. More decisively, the
conclusion is a typical-interval saving tending to zero, not the power
\(T^{-\rho}\) required by (11).

Therefore none of these results proves (11).  Equation (15a) already
controls the complete zero-resonance branch without cancellation.  The
remaining sufficient input is a power-saving estimate for the nonzero
integer-resonance branches, or an estimate which cancels the complete
off-diagonal at once.  No two-point Chowla input is required for the branch
isolated in (10).
