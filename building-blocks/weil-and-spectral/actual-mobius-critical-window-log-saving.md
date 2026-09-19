# Arbitrary logarithmic saving in the critical Möbius window

**Status:** unconditional written analytic estimate, 20 September 2026. This
is a deduction from equation (1.6) of Matomäki, Radziwiłł, Shao, Tao and
Teräväinen and the paragraph following their equation (1.7), which extends
(1.6) to the ordinary Möbius function. It is not a theorem stated separately
in that source. The finite logarithmic split, complete unlogged convolution,
and exponent identities are formalized and axiom-audited in
[`ActualMobiusCriticalWindowSaving.lean`](../../formalization/BuildingBlocks/ActualMobiusCriticalWindowSaving.lean).
The short-interval application, bounded-variation transfer, and integration
over packet centers are written mathematics, not Lean. The estimate controls
the exact logged critical dyadic shell for almost all real centers. It does
not complete the full tail, produce a fixed-center result, or prove the
Riemann hypothesis.

## The critical shell

Put

\[
 X=T^2,\qquad H_N=N/T,\qquad D=T^{3/2},
 \qquad X\leq N\leq2X,
\tag{1}
\]

and let \(I_D\) be any integer interval in \([D,2D]\). Retain the literal
pole-null packet

\[
 g_N(x)=N^{-1/2}G_T\!\left(\frac{x-N}{H_N}\right),
\tag{2}
\]

where the packet construction gives uniform Schwartz bounds for \(G_T\).
Its literal support is a \(T\)-dependent interval of length \(O(T)\), coming
from a fixed multiplicative support for \(g_N\); no fixed-support
approximation is made. Define the unlogged and logged dyadic cofactor shells

\[
 \mathcal C_D(N,T)=\frac1{\sqrt N}
 \sum_{n\geq1}\sum_{m\in I_D}\mu(m)
 G_T\!\left(\frac{mn-N}{H_N}\right),
\tag{3}
\]

\[
 \mathcal S_D(N,T)=\frac1{\sqrt N}
 \sum_{n\geq1}(\log n)\sum_{m\in I_D}\mu(m)
 G_T\!\left(\frac{mn-N}{H_N}\right).
\tag{4}
\]

Equation (4) is a complete dyadic piece of the exact identity
\(\log=\Lambda*1\); no prime power is deleted.

**Theorem.** For every fixed \(B>0\), as \(T\to\infty\),

\[
 \boxed{\frac1X\int_X^{2X}|\mathcal C_D(N,T)|\,dN
 \ll_B(\log T)^{-B},}
\tag{5}
\]

\[
 \boxed{\frac1X\int_X^{2X}|\mathcal S_D(N,T)|\,dN
 \ll_B(\log T)^{-B}.}
\tag{6}
\]

Consequently, for any fixed \(B,M>0\), outside a set of centers of relative
measure \(O_{B,M}((\log T)^{-M})\), both shells are
\(O_{B,M}((\log T)^{-B})\). This follows from (5)--(6) with source exponent
\(B+M\) and Markov's inequality.

## Published input

Equation (1.6) in [Matomäki--Radziwiłł--Shao--Tao--Teräväinen](https://doi.org/10.1007/s00222-026-01408-6)
gives arbitrary logarithmic saving in a maximal arithmetic-progression norm
for almost all intervals of length \(H\), throughout

\[
 H\geq Y^{1/6+\varepsilon}.
\tag{7}
\]

More precisely, for every fixed \(A>0\), its exceptional set has measure
\(O_A(Y(\log Y)^{-A})\), and away from that set the maximal norm is
\(O_A(H(\log Y)^{-A})\). The displayed equation is written for the source's
modified von Mangoldt weight. The paragraph following equation (1.7)
explicitly states that (1.6) also holds with that weight replaced by \(\mu\),
by a similar proof. We use this stated extension with modulus \(q=1\).

At the present scale \(Y\asymp D\), the core length is

\[
 h=Y/T\asymp D^{1/3}.
\tag{8}
\]

Thus (7) applies after choosing any fixed \(0<\varepsilon<1/6\). The result
below is a deduction from this published maximal estimate, including its
Möbius extension, rather than a restatement of a theorem numbered in the
source.

## Center pullback and dyadic shells

On the support of (3),

\[
 n\asymp R:=X/D=T^{1/2}.
\tag{9}
\]

Fix such an \(n\), set

\[
 x=N/n,\qquad Y=X/n\asymp D,\qquad dN=n\,dx,
\tag{10}
\]

and observe the exact normalized-variable identity

\[
 \frac{mn-N}{N/T}=T\left(\frac mx-1\right)
 =\frac{m-x}{x/T}.
\tag{11}
\]

Split \(v=(m-x)/(x/T)\) into its core and dyadic shells
\(V<|v|\leq2V\). On the dyadic source range \(x\asymp Y\), use the fixed
shell envelope

\[
 H_V=4VY/T.
\tag{12}
\]

The positive shell is contained in \((x,x+H_V]\). The negative shell is
contained in \((x-H_V,x]\); shifting its center to \(x-H_V\) puts it into a
forward interval of the same length. As \(x\) crosses the endpoint of its
dyadic source range, the shifted negative center is covered by two adjacent
dyadic ranges. Intersecting either interval with \(I_D\) again gives an
interval, hence an admissible \(q=1\) progression inside the maximal norm.

Uniform Schwartz bounds give \(O_M(V^{-M})\) for the shell weight and its
total variation. Abel summation therefore transfers the source estimate to
the weighted shell, with regular contribution

\[
 O_{A,M}\!\left(\frac{VY}{T}(\log Y)^{-A}V^{-M}\right).
\tag{13}
\]

Apply (1.6) while

\[
 H_V\leq(Y/2)^{1-\varepsilon}.
\tag{14}
\]

Together with (8), this covers all
\(V\ll Y^{2/3-\varepsilon}\), up to fixed constants. For larger \(V\), the
trivial count \(O(VY/T)\), multiplied by arbitrarily high Schwartz decay
\(V^{-M}\), gives an arbitrary power saving after increasing \(M\). This
also handles the ends of the literal \(T\)-dependent support.

The source exceptional set has \(x\)-measure
\(O_A(Y(\log Y)^{-A})\). Under (10) it has \(N\)-measure

\[
 O_A(nY(\log Y)^{-A})=O_A(X(\log T)^{-A}).
\tag{15}
\]

On it, use the trivial shell estimate and the same factor \(V^{-M}\). Both
the regular and exceptional shell sums converge after choosing \(M\) large.
Crucially, perform the \(N\)-integration for each fixed \(n\) before summing
over \(n\). No union bound over the \(R\) outer variables is taken.

After the factor \(N^{-1/2}\), the remaining normalization is

\[
 \frac{R(Y/T)}{\sqrt X}
 \asymp\frac{(X/D)(D/T)}{\sqrt X}
 =\frac{\sqrt X}{T}=1.
\tag{16}
\]

Choosing the source exponent \(A>B\), with enough room for the finitely many
dyadic and bounded-variation losses, proves (5).

## Restoring the logarithm

Define

\[
 \mathcal E_D(N,T)=\frac1{\sqrt N}
 \sum_{n\geq1}\log\!\left(\frac{nD}{N}\right)
 \sum_{m\in I_D}\mu(m)
 G_T\!\left(\frac{mn-N}{H_N}\right).
\tag{17}
\]

Under (10), the new weight is

\[
 \log(nD/N)=\log(D/x).
\tag{18}
\]

It is independent of \(m\), is uniformly bounded on each of the two dyadic
source ranges, and has bounded variation in the center. The preceding
argument therefore proves, for every fixed \(B>0\),

\[
 \frac1X\int_X^{2X}|\mathcal E_D(N,T)|\,dN
 \ll_B(\log T)^{-B}.
\tag{19}
\]

Term by term,

\[
 \log n=\log(N/D)+\log(nD/N),
\tag{20}
\]

so the exact pointwise split is

\[
 \mathcal S_D(N,T)=\log(N/D)\mathcal C_D(N,T)
 +\mathcal E_D(N,T).
\tag{21}
\]

Since \(X=T^2\), \(D=T^{3/2}\), and \(X\leq N\leq2X\),

\[
 \log(N/D)=\tfrac12\log T+O(1).
\tag{22}
\]

Apply (5) with exponent \(B+1\) to absorb this single logarithm, and combine
with (19). This proves (6).

## Exact complete cancellation and scope

For every integer \(r>1\),

\[
 \sum_{mn=r}\mu(m)=\sum_{m\mid r}\mu(m)=0.
\tag{23}
\]

Consequently the complete unlogged cofactor packet vanishes whenever the
support excludes \(r=1\):

\[
 \sum_{m,n\geq1}\mu(m)g_N(mn)=0.
\tag{24}
\]

The finite arithmetic-function form of (23) is Lean-checked. Inserting
\(\log n\), however, gives
\(\sum_{m\mid r}\mu(m)\log(r/m)=\Lambda(r)\), exactly restoring every von
Mangoldt prime-power weight.

The estimate removes the logarithmic-rate obstruction for this complete
critical dyadic shell. Completing the original tail still requires the
bookkeeping that combines all shells with compatible exceptional-set
quantifiers. An almost-all real-center estimate also does not by itself
yield the fixed-center statement required for a prescribed zero. These
remaining translations are not supplied here, and no RH conclusion is
claimed.
