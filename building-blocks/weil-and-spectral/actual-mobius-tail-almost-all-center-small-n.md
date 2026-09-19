# Almost-all-center cancellation in the small outer-variable Möbius tail

**Status:** unconditional written analytic estimate, 20 September 2026. It
uses Theorem 1.1(i) of Matomäki, Radziwiłł, Shao, Tao and Teräväinen. The
short-interval theorem, partial summation, and averaging in the packet center
are written mathematics, not Lean. The exponent range is formalized and
axiom-audited in
[`ActualMobiusAlmostAllCenter.lean`](../../formalization/BuildingBlocks/ActualMobiusAlmostAllCenter.lean).
This estimate controls only a small-outer-variable slice for almost all
packet centers. It does not control the complementary tail or prove the
Riemann hypothesis.

Use the exact swapped form of the remaining Möbius tail from the
[Robert--Sargos--Bordellès hybrid](actual-mobius-tail-robert-sargos-bordelles-saving.md):

\[
 \frac1{\sqrt N}
 \sum_{n<e^wY_E}(\log n)
 \sum_{m>K_E}\mu(m)
 G_T\!\left(\frac{mn-N}{H_N}\right),
 \qquad H_N=\frac NT.
\tag{1}
\]

The packet profile \(G_T\) is uniformly Schwartz, with uniform
bounded-variation norm. The coefficient in the inner sum is the actual
Möbius function. The hard restriction \(m>K_E\) is retained.
Equation (1) came from the exact identity \(\log=\Lambda*1\), so the
parent prime row still contains \(\Lambda(p^j)=\log p\) for every prime
power; this argument does not replace \(\Lambda\) by prime-only support.

Fix

\[
 N_0=T^\lambda,
 \qquad
 0<\epsilon<\frac23,
 \qquad
 \epsilon\lambda<1,
\tag{2}
\]

and let

\[
 z<
 z_{\rm aa}(\lambda,\epsilon)
 :=
 \lambda-\frac1{2/3-\epsilon},
 \qquad Z=T^z.
\tag{3}
\]

Assume also \(Z<e^wN_0/K_E\), so this slice lies inside the exact remaining
tail (1) for every \(N\in[N_0,2N_0]\).

For \(N\in[N_0,2N_0]\), define the literal small-\(n\) slice

\[
 \mathcal R_Z(N,T)
 =
 \frac1{\sqrt N}
 \sum_{n\le Z}(\log n)
 \sum_{m>K_E}\mu(m)
 G_T\!\left(\frac{mn-N}{N/T}\right).
\tag{4}
\]

Then for every fixed \(B>0\),

\[
\boxed{
 \frac1{N_0}\int_{N_0}^{2N_0}
 |\mathcal R_Z(N,T)|\,dN
 \ll_{B,\lambda,\epsilon,G}
 T^{\lambda/2-1}(\log T)^{-B}.}
\tag{5}
\]

In particular, at least one center \(N\in[N_0,2N_0]\) obeys the same
bound. More precisely, for every fixed \(B,M>0\), Markov's inequality
applied to (5) with exponent \(B+M\) shows that

\[
 |\mathcal R_Z(N,T)|
 \ll T^{\lambda/2-1}(\log T)^{-B}
\tag{5a}
\]

outside a subset of \([N_0,2N_0]\) of relative Lebesgue measure
\(O((\log T)^{-M})\). These quantifiers concern each fixed \(T\) and its
dyadic interval of real packet centers; they do not assert a simultaneous
statement for all \(T\) or for integer centers.

## Proof

Fix \(n\le Z\). Uniform Schwartz decay permits truncation to
\(|(mn-N)/(N/T)|\le Q\), where \(Q=(\log T)^C\), for any prescribed fixed
\(C>0\), with
an error smaller than \((H_n+1)(\log T)^{-A}\) after choosing the decay
order in terms of \(A,C\). On this truncated support,

\[
 m\asymp X_n:=\frac Nn,
 \qquad
 |m-X_n|\le QH_n,
 \qquad H_n:=\frac{N}{Tn}=\frac{X_n}{T}.
\tag{6}
\]

If \(n=T^a\), the exponents of \(X_n\) and \(H_n\) are
\(\lambda-a\) and \(\lambda-1-a\). Condition (3) is exactly

\[
 (1/3+\epsilon)(\lambda-a)
 <
 \lambda-1-a
 \qquad(0\le a\le z).
\tag{7}
\]

The upper length condition follows from
\(\epsilon\lambda<1\):

\[
 \lambda-1-a
 <
 (1-\epsilon)(\lambda-a).
\tag{8}
\]

The boundary identity behind (7), its strict form below the boundary, and a
weak sufficient form of (8) are the Lean theorems
`threshold_balance`, `lower_shortInterval_margin`, and
`upper_shortInterval_margin`.

The extra polylogarithmic factor in the interval length does not change
(7)--(8), whose margins are strict. Put

\[
 X_{0,n}=\frac{N_0}{n},\qquad
 h_{0,n}=\frac{X_{0,n}}T,\qquad
 L_n=6Qh_{0,n},\qquad
 x_n(N)=\frac Nn-3Qh_{0,n}.
\tag{8a}
\]

Because \(N\le2N_0\), the support in (6) lies in the fixed-length translated
interval \((x_n(N),x_n(N)+L_n]\). For sufficiently large \(T\), the possible
left endpoints \(x_n(N)\) are covered by two dyadic \(x\)-ranges of scale
\(X_{0,n}\). Thus the cited theorem is applied twice with the fixed length
\(L_n\), while its maximal norm controls the shorter interval remaining
after the cutoff \(m>K_E\).

Apply Matomäki--Radziwiłł--Shao--Tao--Teräväinen,
[*Higher uniformity of arithmetic functions in short intervals II. Almost
all intervals*](https://doi.org/10.1007/s00222-026-01408-6), Theorem
1.1(i), with the point nilmanifold and constant test function. Its maximal
norm is a supremum over arithmetic progressions inside the interval. Taking
progressions of common difference one handles the hard cutoff \(m>K_E\);
Abel summation then inserts the uniformly bounded-variation weight
\(G_T\). The source estimate has size \(L_n(\log T)^{-D}\), rather than
\(H_n(\log T)^{-D}\). Fix an effective exponent \(A\), and choose the
arbitrary source exponent \(D>A+C\); this absorbs the factor
\(Q=(\log T)^C\). The two dyadic applications give, for each fixed \(n\),

\[
 \left|
 \sum_{m>K_E}\mu(m)
 G_T\!\left(\frac{mn-N}{N/T}\right)
 \right|
 \ll_A \frac{H_n}{(\log T)^A}
\tag{9}
\]

outside an exceptional set of \(N\)-measure

\[
 \ll_A \frac{N_0}{(\log T)^A}.
\tag{10}
\]

Indeed, on either dyadic range the source exceptional set has inner-center
measure \(O_D(X_{0,n}(\log X_{0,n})^{-D})\). The exact change of variables
is \(dN=n\,dx_n\), so its pullback has \(N\)-measure
\(O_D(N_0(\log T)^{-D})\). The two-range cover changes only the constant.
Using the trivial bound \(O(QH_n+1)\) on this set costs at most the same
polylogarithmic factor \(Q\); the choice \(D>A+C\) therefore yields (10)
with effective exponent \(A\), uniformly in \(n\). No union bound over
\(n\) is taken.

Integrate the triangle inequality for (4) first, and then sum the exceptional
measure separately for each \(n\). On the exceptional set use the trivial
bound \(O(QH_n+1)\). Since

\[
 \sum_{n\le Z}\frac{\log n}{n}\ll(\log T)^2
\tag{11}
\]

and \(z<\lambda-1\), both the regular and exceptional contributions give

\[
 \frac{N_0^{1/2}}T(\log T)^{2-A}.
\tag{12}
\]

Choose the effective exponent \(A>B+2\), and then choose the source exponent
\(D>A+C\). This proves (5). The argument averages the absolute value after
retaining the exact Möbius coefficient; it does not infer simultaneous
pointwise bounds by unioning exceptional sets.

## Scope at the critical geometry

The limiting threshold is

\[
 z_{\rm aa}(\lambda,0)=\lambda-\frac32.
\tag{13}
\]

Thus for the slice (4) at \(\lambda=2\), every fixed \(z<1/2\) is
admissible after
choosing a sufficiently small positive \(\epsilon\), and (5) becomes an
absolute quantity tending to zero for almost all real centers, in the
quantified sense of (5a). The limiting identities
\(z_{\rm aa}(\lambda,0)=\lambda-3/2\) and
\(z_{\rm aa}(2,0)=1/2\) are Lean-checked.

The existing Robert--Sargos--Bordellès prefix theorem assumes the strict
range \(\lambda>2\), so this \(\lambda=2\) slice estimate cannot simply
be appended to that prefix by taking an endpoint limit.

For a fixed \(\lambda>2\), the prefactor
\(T^{\lambda/2-1}\) is a positive power, so arbitrary logarithmic
cancellation gives only a logarithmic improvement relative to the absolute
bound; (5) itself grows and is not \(o(1)\). Even at
\(\lambda=2\), the range \(n>T^{1/2-o(1)}\) in (1) remains. At
\(\lambda=2\) this controls a genuine range for favorable centers, but it
does not close the complete signed tail.
