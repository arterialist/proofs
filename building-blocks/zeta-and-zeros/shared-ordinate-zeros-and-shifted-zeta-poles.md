# A common set of zeta zeros surviving every small horizontal shift

The published lower bound for simple critical-line zeros gives a single set of zero ordinates that survives every real shift \(0<a<1/2\). The set occupies more than half of the total zero count in every sufficiently high dyadic interval. Its definition and population threshold are independent of the shift and of any finite coprimality restriction. This is a corollary of an existing proportion theorem and a finite counting argument; no priority claim is made.

## The common set and its exact count

For a positive-height interval \(I=(T_1,T_2]\), let \(Z(I)\) be the distinct actual nontrivial zeta zeros in that interval, let \(m(\rho)\) be analytic multiplicity, and put
\[
 N(I)=\sum_{\rho\in Z(I)}m(\rho),\qquad
 S(I)=\{\rho\in Z(I):\Re\rho=1/2,\ m(\rho)=1\}.
\]
Define
\[
 B(I)=\{\rho\in S(I):\exists\sigma\in Z(I),\
             \Re\sigma<1/2,\ \Im\sigma=\Im\rho\},\qquad
 Q(I)=S(I)\setminus B(I).
\]
All members of \(Z(I)\) lie in the open critical strip. The set \(Q(I)\) depends only on the actual zero configuration and the interval.

The exact finite inequality is
\[
 \boxed{\quad 3|S(I)|\le N(I)+2|Q(I)|.\quad}             \tag{1}
\]
Choose one left zero \(\sigma_\rho\) at each ordinate belonging to \(B(I)\). Its functional-equation reflection \(1-\overline{\sigma_\rho}\) is a right zero at the same ordinate. Distinct critical-line points have distinct ordinates. Thus the selected left zeros and their right reflections give two injections from \(B(I)\), with images disjoint from each other and from \(S(I)\). Every selected point has multiplicity at least one. Consequently
\[
 N(I)\ge |S(I)|+2|B(I)|,
 \qquad |Q(I)|=|S(I)|-|B(I)|,
\]
which proves (1). Extra zeros and extra multiplicities only increase \(N(I)\). Reflection preserves both height endpoints.

Every \(\rho\in Q(I)\) is the unique nontrivial zero point at its ordinate: a right zero would reflect to an excluded left zero, and a second critical-line point at the same ordinate would be the same complex point. Therefore
\[
 \forall\rho\in Q(I),\quad
 \forall a\in(0,1/2),\qquad \zeta(\rho-a)\ne0.          \tag{2}
\]
This counts the union of all bad ordinates directly. Separate lower bounds on the survivor set for each fixed shift would not establish one common set.

## The actual dyadic population

Claude's [Theorem A and Montgomery–Taylor refinement](https://www-cdn.anthropic.com/95c246936988e43127bc6b2ceb7077c1dad2d68e.pdf) give, unconditionally, for every \(\delta>0\) and all sufficiently large real \(T\),
\[
 |S(T,2T)|\ge(\kappa-\delta)N(T,2T),\qquad
 \kappa=\frac32-\frac1{\sqrt2}\cot\frac1{\sqrt2}.
\]
Apply (1) with \(\delta=2\varepsilon/3\). For every \(\varepsilon>0\), there is \(T_0>0\) such that for every real \(T\ge T_0\),
\[
 \boxed{\quad |Q(T,2T)|\ge(q_*-\varepsilon)N(T,2T),\quad}
 \qquad
 q_*=\frac{3\kappa-1}{2}
     =\frac74-\frac3{2\sqrt2}\cot\frac1{\sqrt2}
     =0.508751055519117\ldots.                          \tag{3}
\]
The same intrinsically defined set \(Q(T,2T)\) satisfies (2) for all shifts. The onset \(T_0\) depends on \(\varepsilon\), and has no dependence on \(a\). The exact expression, rather than a rounded-up decimal, is the coefficient in (3). The flat two-thirds source theorem gives the simpler coefficient \(1/2\). The Riemann–von Mangoldt formula makes \(N(T,2T)\) positive for large \(T\), so \(Q(T,2T)\) is eventually nonempty.

The arithmetic input here is the proved actual-prime moment theorem behind the simple-critical proportion. Reflection and independent multiplicative generators alone do not give that population bound. The finite argument also applies to other symmetric zero configurations with the same population input. A configuration with one left/right pair at each of \(b\) out of \(s\) simple central ordinates has \(N=s+2b\) and equality in (1); this tests the counting step, without asserting sharpness for actual zeta.

## Simultaneous simple poles and finite Euler deletions

For \(0<a<1/2\), put
\[
 R_a(s)=\frac{\zeta(s-a)}{\zeta(s)}-1.
\]
Every \(\rho\in Q(I)\) is simple, so \(\zeta'(\rho)\ne0\). Equation (2) shows that \(R_a\) has a simple pole there, with residue
\[
 \operatorname{Res}_{s=\rho}R_a(s)
        =\frac{\zeta(\rho-a)}{\zeta'(\rho)}\ne0.         \tag{4}
\]
The same poles survive every finite coprimality restriction. For an integer \(m\ge1\), define the ordinary real-order Jordan function
\[
 J_a(n)=(\mu*\operatorname{id}^a)(n),\qquad J_a(1)=1.
\]
Its complete restricted Dirichlet series is, initially for \(\Re s>1+a\),
\[
 D_{a,m}(s)=\sum_{(n,m)=1}\frac{J_a(n)}{n^s}
 =\frac{\zeta(s-a)}{\zeta(s)}H_{a,m}(s),\qquad
 H_{a,m}(s)=\prod_{p\mid m}\frac{1-p^{a-s}}{1-p^{-s}}. \tag{5}
\]
Here \(p^z=\exp(z\log p)\). At a critical-line point \(\rho\),
\[
 |p^{a-\rho}|=p^{a-1/2}<1,
 \qquad |p^{-\rho}|=p^{-1/2}<1.
\]
Every local numerator and denominator in (5) is nonzero. The finite product is holomorphic and nonzero near \(\rho\). Thus the same \(Q(T,2T)\) supplies simple poles of every \(D_{a,m}\), simultaneously for all real \(0<a<1/2\) and all integers \(m\ge1\). Its residue is
\[
 \frac{\zeta(\rho-a)H_{a,m}(\rho)}{\zeta'(\rho)}\ne0.  \tag{6}
\]
The local argument uses the unit coefficient in each ordinary-zeta Euler factor. An arbitrary generator weight \(c_p\) would replace the first modulus by \(|c_p|p^{a-1/2}\), which need not be below one. Such a model therefore does not inherit this proof from multiplicativity alone. The actual population bound and these literal local factors are separate inputs.

The pole-count threshold also has no dependence on \(m\). This remains a count statement even if the shift or modulus varies with \(T\). It supplies no uniform lower bound on residues, function values, or oscillation amplitudes. At \(a=0\), after removable cancellation, the un-depleted ratio is identically one and \(R_0=0\); the open shift range is necessary.

## Verification and limits

The [external Lean companion](../../formalization/verification/anthropic-shared-ordinate/README.md) checks the actual finite count, uniqueness, all-shifts noncancellation, derivative nonvanishing, local meromorphic order \(-1\), finite Euler-factor nonvanishing and analyticity, and the optimized density-to-pole composition. The final declaration `uniform_common_optimized_all_poles` supplies the source density theorem internally, without a density hypothesis from its caller. The native constant identity `Zeta23.ThmD.HD_one` is also checked. All eight companion modules passed a fresh root audit with 25 printed axiom audits, each using only `propext`, `Classical.choice`, `Quot.sound`.

The runtime is Lean 4.33.0-rc2, with upstream `anthropics/formal-math` at `fbdc36bbf17d20af3fd0447c6d1a8a02773c9844` and Mathlib at `51e6992efd06126df61a496bebf8f49482a4e129`. The targeted source replay uses a disclosed import-only variant: six Mathlib umbrella imports were replaced by explicit imports, while all mathematical declarations and proof scripts were preserved. Its 140-module source cone reuses 59 verified unchanged cached modules and compiles the other 81; seven missing Mathlib modules were compiled locally. This is a targeted kernel check through that variant, rather than an unchanged-source full build or upstream comparator replay. The companion is separate from this repository's Lean 4.24.0 library.

The infinite identification with the Jordan Dirichlet series, interpretation through an integer coprimality modulus, explicit residues, and the summatory-error analysis remain independently reviewed written mathematics. The displayed decimal is supported by the companion's exact rational Taylor certificate; it is not a Lean numerical theorem. The [summatory-error audit](../prime-distribution/real-order-jordan-summatory-error-audit.md) gives the fixed-parameter consequence. These results are compatible with RH and provide no stronger upper bound on the complete signed prime error or Weil form. The order parameter is an arithmetic deformation parameter; no physical arrow of time or phase transition is established.
