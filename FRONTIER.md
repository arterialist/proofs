# Current RH research status

Updated 20 September 2026. Counting by $n\mapsto n+1$ and multiplicative factorization motivate the arithmetic objects here. The remaining problem is a quantitative bound for their complete signed error. An identity describing that error is not such a bound.

## Checked results and their scope

- [Bounded-height zero exclusion](formalization/BuildingBlocks/RiemannZetaRatioSurplus.lean) proves in Lean that $\zeta(s)\ne0$ when $\operatorname{Re}(s)>1/2$ and $0<\operatorname{Im}(s)\le7.465$. This is formalization progress on a classically known zero-free range.
- The [completed-zeta decomposition](formalization/BuildingBlocks/RiemannZetaPoleDominanceTheorem.lean) and [reflection identities](formalization/BuildingBlocks/RiemannZetaDisplacementReflectionAntisymmetry.lean) are exact identities. They do not establish an additional high-frequency zero-free region.
- [RH criteria and consequences](formalization/BuildingBlocks/RiemannZetaMasterGrandUnification.lean) organize equivalent predicates and conditional implications. The high-frequency Fredholm/trace interfaces still require the decisive estimates as fields. No instance supplying those estimates has been established by these modules.

## Signed prime remainder

The [reciprocal-prime estimate](building-blocks/weil-and-spectral/actual-reciprocal-prime-high-cofactor-saving.md) bounds a small-prime prefix. The [cutoff transfer](building-blocks/weil-and-spectral/actual-proper-cofactor-dirichlet-dual-cancellation.md) controls the omitted cofactor tail and the combined prime row plus truncated proper-cofactor head by $O(T^{-(29-14\lambda)/60})$, for $2<\lambda<29/14$ and the specified cutoff.

For the separate prime row, the [three-dimensional Möbius-tail estimate](building-blocks/weil-and-spectral/actual-mobius-tail-three-dimensional-saving.md) applies Robert and Sargos' monomial exponential-sum theorem to the exact weighted Poisson expansion. Using the theorem in the dual factor orientation moves the controlled cutoff from
\[
H T^{(29-14\lambda)/116}
\quad\text{to}\quad
H T^{(7-3\lambda)/15}
\]
with a fixed power saving. More generally, for every fixed
\(0<\eta<(14-6\lambda)/15\), the cutoff may be taken as
\(HT^{(14-6\lambda)/15-\eta}\), with saving
\(T^{-\min\{(29-14\lambda)/60,\eta/4\}}\).
Equivalently, it writes the prime row as the Möbius tail beyond the larger
cutoff plus a power-decaying error. The farther tail remains uncontrolled.
The [Bourgain and dual-trilinear extension](building-blocks/weil-and-spectral/actual-mobius-tail-bourgain-dual-saving.md)
replaces the Type I third-derivative exponent by Bourgain's exponent pair while
retaining the dual Type II estimate. It moves the analytic endpoint from
\(d_\dagger=(9\lambda-1)/15\) to
\((126\lambda-13)/210\); a fixed-margin cutoff
\(K_B=T^{(84\lambda-9)/140}\) has a power-saving prefix estimate. The
[Bordellès trilinear extension](building-blocks/weil-and-spectral/actual-mobius-tail-bordelles-saving.md)
keeps that Bourgain Type I estimate and replaces Type II by Bordellès's
reciprocal three-variable bound, moving the endpoint to \(4\lambda/7\).
The [Cao--Zhai large-sieve extension](building-blocks/weil-and-spectral/actual-mobius-tail-cao-zhai-large-sieve-saving.md)
uses their stronger estimate on nearly balanced Type II rectangles and the
Bordellès estimate away from balance. This moves the endpoint to
\((3\lambda+1)/6\). The concrete cutoff
\(K_D=T^{(3\lambda+1)/6-1/420}\) has a power-saving prefix estimate, and
the [rectangle-wise Robert--Sargos--Bordellès hybrid](building-blocks/weil-and-spectral/actual-mobius-tail-robert-sargos-bordelles-saving.md)
extends it further. The dual Robert--Sargos estimate controls rectangles near
balance, while Bordellès controls the separated range after an explicit
switch. The [three-factor prefix extension](building-blocks/weil-and-spectral/actual-mobius-k3-bottom-slice-saving.md)
then works inside the same original uncollapsed Vaughan Type II term. For
every fixed \(0<\kappa<(\lambda-2)/5\), it combines an unequal-aspect K=3
expansion with the published free-factor pruning theorem and moves the
complete prefix cutoff to
\[
K_F=T^{3\lambda/5-\kappa}.
\]
The inherited Bourgain Type I estimate remains power saving. The remaining
tail beyond \(K_F\) is the current open term. On each fixed
free-factor slice, the coefficient is
\((\mu*\mu)(q)-2(a*\mu)(q)\), and the cross term is not Bourgain Type I.
The corrected
[balanced-shell recombination](building-blocks/weil-and-spectral/actual-mobius-tail-balanced-hard-shell.md)
instead sums the free factor first: for \(m>U\),
\((a*\mu*1)(m)=a(m)=0\). Only after this exact cancellation does it
repartition the identity \(\mu=(\mu*\mu)*1\) into shells with coefficient
\((\mu*\mu)(q)\). This creates a new complete partition. The square-factor
and truncated-divisor estimates control one balanced region of that new
partition; the complementary regions have not all been bounded, so these
component estimates cannot yet be combined with the old fixed-slice bounds
to move the complete endpoint.

The [long-free-factor reduction](building-blocks/weil-and-spectral/actual-mobius-global-long-free-factor-reduction.md)
controls a larger part of that global partition. At
\(d=2(\lambda+1)/5+\delta\), Robert--Sargos Theorem 3 gives fixed-power
saving whenever
\[
 w\ge 2(4-\lambda)/10+2\delta+\theta,
\]
subject to the explicit nonempty-range and saving margins in the note.
Equivalently, it controls
\(v\le(3\lambda-2)/5-\delta-\theta\). The proof inserts the packet by
bounded-variation partial summation in the unweighted free factor. The
short-free-factor balanced blocks remain open, so this does not move the
complete pointwise endpoint.

The unconditional
[free-factor pruning](building-blocks/weil-and-spectral/actual-mobius-tail-free-factor-pruning.md)
instead keeps the original sum
\(\sum_{r,s>U,t\ge1}\mu(r)\mu(s)L_{rst}(T)\). At
\(D=T^{d_*+\delta}\), its portion \(t\ge T^v\) saves a fixed power whenever
\(v>5\delta\), subject to the explicit hybrid margins, because one grouped
factor has exponent at least \((d+v)/2\). More sharply, a dyadic triple
\(r\asymp T^x,s\asymp T^y,t\asymp T^z\) is power-saving once
\(z+|x-y|>5\delta+8\eta\); the unresolved range is simultaneously close to
\(t=1\) and \(r=s\). In the residual small-\(t\) range,
the part with \((r,s)>T^\gamma\) is power-saving for
\(\gamma>(4-\lambda)/10+\delta\). The surviving block has small free factor,
small common divisor, and includes \(t=1\), \((r,s)=1\),
\(r,s\asymp D^{1/2}\). These reductions do not move the complete endpoint.
On the coprime primitive block, regrouping by \(n=rs\) gives the exact
coefficient \(\mu(n)d_{R,S}(n)\); every factorization in one product fiber
has the same sign, so cancellation must occur between distinct products.
The
[reciprocal short-shift reduction](building-blocks/weil-and-spectral/actual-mobius-reciprocal-short-shift-reduction.md)
expands the primitive \(t=1\) Poisson-mode mean square into its exact
two-point kernel. Its zero-resonance branch is coherent for
\(|h|\lesssim D/T\), while nonzero
integer resonance branches remain in the complete expansion. At the
endpoint, \(D/T=T^{(2\lambda-3)/5}\), the same exponent as the strict
off-diagonal gain threshold before the requested margin. After normalization,
the diagonal also requires \(\eta<(3\lambda-2)/10\). The finite
expansion, diagonal, reciprocal gap, coherence-scale identity, and exponent
rewrite are Lean-compiled; no power-saving correlation estimate is known.
For the exact swapped tail, the
[almost-all-center estimate](building-blocks/weil-and-spectral/actual-mobius-tail-almost-all-center-small-n.md)
uses the 2026 Matomäki--Radziwiłł--Shao--Tao--Teräväinen maximal
short-interval theorem without unioning its exceptional sets. Averaging the
packet center gives cancellation, on average with prefactor
\(T^{\lambda/2-1}\), for outer variables
\(n\le T^z\) when
\(z<\lambda-(2/3-\epsilon)^{-1}\). At \(\lambda=2\) this approaches
\(z<1/2\) and tends to zero outside a relative
\(O((\log T)^{-M})\) exceptional set of real centers. For fixed
\(\lambda>2\), the displayed prefactor grows, so this is only logarithmic
cancellation relative to the absolute bound, not an \(o(1)\) estimate.
The complementary larger-\(n\) range remains uncontrolled.
The [reciprocal center-average estimate](building-blocks/weil-and-spectral/actual-mobius-reciprocal-center-average-saving.md)
works before Vaughan decomposition, so its coefficient is the original
\(\mu(m)\). For a dyadic shell \(m\asymp D\), it proves
\[
 \left(X^{-1}\int_X^{2X}|S_D(N,T)|^2\,dN\right)^{1/2}
 \ll (\log T)^C\left(\sqrt{D/X}+D/\sqrt{TX}\right).
\]
At \(X=T^2\), dyadic summation controls every fixed prefix
\(D\le T^{3/2-\eta}\) for almost all real centers. This extends the
repository's center-averaged prefix beyond its pointwise \(T^{6/5}\)
cutoff, but the transition shell at \(T^{3/2}\), the remaining tail, and
the translation to the prescribed center remain open.
The [critical-window estimate](building-blocks/weil-and-spectral/actual-mobius-critical-window-log-saving.md)
now treats that exact transition shell. Using the maximal untwisted Möbius
estimate stated after MRSTT equation (1.7), it proves for every fixed
\(B>0\)
\[
 X^{-1}\int_X^{2X}|\mathcal S_{T^{3/2}}(N,T)|\,dN
 \ll_B(\log T)^{-B}.
\]
This includes the logarithmic cofactor weight and every prime power. It is
still an almost-all-real-centers result. The complementary shells and the
translation to the prescribed center remain open.
Independently, the
[Selberg mean-square estimate](building-blocks/weil-and-spectral/actual-prime-packet-selberg-almost-all-center.md)
controls the complete prime row, with every \(\Lambda(p^j)=\log p\), over
real packet centers:
\[
 \left(N_0^{-1}\int_{N_0}^{2N_0}|P_1(N,T)|^2\,dN\right)^{1/2}
 \ll \frac{\sqrt{N_0}}T
 \exp\!\left[-c\left(\frac{\log N_0}{\log\log N_0}\right)^{1/3}\right]
 +\frac{(\log N_0)^2}{T}.
\]
At \(N_0=T^2\) this tends to zero outside a stretched-exponentially
sparse set of real centers. For fixed \(\lambda>2\), the prefactor
\(T^{\lambda/2-1}\) grows. The elementary packet upper-bound scale for a
fixed zero with \(\beta<1\) is smaller than this envelope by the power gap
\(T^{\lambda(\beta-1)}\), so the envelope is weaker than RH scale. The
often-quoted stronger Saffari--Vaughan
variance of order \(hX\log^2(2X/h)\) is explicitly conditional on RH and is
not used.
The discarded approximate-functional-equation argument still does not bound
the complete signed zero sum.

The [dual exponent module](formalization/BuildingBlocks/DualDirichletOfflineDecay.lean) proves real-power algebra. A classical bound for one short dual Dirichlet polynomial is distinct from a uniform estimate for the complete arithmetic expression. The [power-model identity](formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean) $T^\varepsilon T^{-\varepsilon}=1$ does not establish exact cancellation of actual zeta scattering factors. A fixed positive power $T^\delta$ eventually exceeds $\log T$; it cannot be treated as a logarithmic error by choosing a small fixed $\delta$.

Earlier [microcluster](building-blocks/weil-and-spectral/actual-weil-offline-microcluster-mass.md) and [sampling](building-blocks/weil-and-spectral/actual-annulus-sobolev-zero-sampling.md) estimates constrain selected zero configurations or exceptional sets. They do not exclude an isolated off-line zero.

## Other unconditional bounds

The [full factorial clock](building-blocks/factorial-and-renewal/factorial-full-clock-pnt-subquadratic.md) satisfies $Q_N=o(N^2)$ and $|W_N|=o(N^2)$ by the classical PNT. Its RH consumer needs the much stronger one-sided $W_N\ll_\varepsilon N^{1+\varepsilon}$. The [coarse primitive envelope](building-blocks/prime-distribution/coarse-primitive-chebyshev-envelope-dyadic-falsifier.md) is $S_X\le(91/60)(4\log2-1)^2X^5$ by Chebyshev; the missing exponent is $4+\varepsilon$. These are written classical-input consequences, not new published zeta-frontier bounds.

## Displacement correction

With $s=\sigma+it$, $d=\sigma-1/2$, and $\Lambda(s)=\pi^{-s/2}\Gamma(s/2)\zeta(s)$,

$$
D_\sigma(t)=\frac{2d(1/4-d^2)}{|s(s-1)|^2}+2d\Re\Lambda(s)-t\Im\Lambda(s).
$$

For fixed $0<d<1/2$, its leading coefficient is positive: $t^4D_{1/2+d}(t)\to2d(1/4-d^2)$. The negative coefficient reported earlier resulted from using the wrong theta weight. Eventual positivity for a fixed real part is not positivity everywhere and does not exclude zeros.

Further progress requires an independently proved estimate for the actual signed expression. Conditional results should state their inputs directly in the result and its source file.
