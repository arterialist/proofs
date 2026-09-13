# The actual feedback tail and its Abel–Mellin poles

Use the completed actual source and the all-parameter resolvent from [the boundary criterion](actual-successor-resolvent-boundary-criterion.md). Write
$$
g(x)=\psi(x)/x-1,\quad a(v)=e^{v/2}g(e^v),\quad
\kappa_j=\kappa(C^ja),\quad e_j=\kappa(S^ja),
$$
$$
E(r)=\sum_{j\ge0}e_jr^j,\quad
Q(r)=\sum_{j\ge0}q_jr^j,\quad c_r=E(r)/Q(r),
\quad \overline P_r=I(\overline a_r-a).
$$
Here $q_0=1$ and $q_j=\arctan\sqrt j/\sqrt j$ for $j>0$. All sources are causal, all charges are relative charges, and all prime powers remain in $\psi$. We prove two statements:
$$
\boxed{\overline P_r(v)=\frac{2r c_r}{1-r}e^{-v/2}
+o_r(e^{-v/2})\quad(v\to\infty),\quad 0<r<1,}
\tag{1}
$$
and a literal Abel–Mellin formula preserving every off-critical source pole. In particular, eventual nonnegativity of $E(r)$ on a whole interval $r_0<r<1$ would imply RH. That sign is not proved here. Nonnegativity only along a sequence approaching one is not sufficient for the scalar Landau argument below.

## 1. The exact fixed-parameter tail

Put $d_j=C^ja-C^{j-1}a$ and $P_j=Id_j$. The all-r construction proves
$$
\|d_j\|_1\ll\log(j+2),\quad |\kappa_j|\ll\log(j+2),\quad
\overline P_r=\sum_{j\ge1}r^jP_j,
\quad \sum_{j\ge0}\kappa_jr^j=\frac{E(r)}{(1-r)Q(r)}.
\tag{2}
$$
Each $d_j$ has integral zero. Consequently $P_j(v)=-\int_v^\infty d_j$; this retains its terminal integration constant.

For the ordinary shifted part, set $x=e^v$ and $j\ge0$. The exact tail is
$$
T_j(x)=\int_x^\infty[g(y+j+1)-g(y+j)]\frac{dy}{\sqrt y}.
$$
Changing variables at a finite upper endpoint and then passing to its limit gives a signed difference of two kernels. The omitted upper strip tends to zero since $g$ is bounded. The negative and positive kernel masses are each $2(\sqrt{x+1}-\sqrt x)$, so
$$
\boxed{\sqrt x|T_j(x)|\le2\sup_{y\ge x}|g(y)|\longrightarrow0,}
\tag{3}
$$
uniformly over all $j\ge0$. This uses the actual unconditional PNT only to make the final supremum tend to zero. It does not differentiate a PNT remainder.

Subtracting the exact source iterates gives
$$
d_j=(S-I)S^{j-1}a
-\sum_{i=0}^{j-2}\kappa_i(S-I)S^{j-2-i}a_0
-\kappa_{j-1}a_0.
\tag{4}
$$
The tail of $a_0$ is $2x^{-1/2}$. For every fixed $l\ge0$,
$$
\int_v^\infty[S^la_0-S^{l+1}a_0](u)du
=\int_x^\infty\frac{dy}{\sqrt y(y+l)(y+l+1)}
\le\frac{2}{3x^{3/2}}.
$$
Therefore (3)–(4) prove
$$
\sqrt xP_j(\log x)\longrightarrow2\kappa_{j-1}
\quad\text{for each fixed }j.
\tag{5}
$$
A summable domination is also available: the same formulas give
$$
\sup_{x\ge1}\sqrt x|P_j(\log x)|
\le2\|g\|_\infty+2|\kappa_{j-1}|
+\frac23\sum_{i=0}^{j-2}|\kappa_i|
\ll j\log(j+2).
\tag{6}
$$
For every fixed $r<1$ this is summable against $r^j$. Dominated summation in (2) and (5) proves (1). If $c_r\ne0$, (1) is the corresponding asymptotic equivalent; if $c_r=0$, its valid assertion is the stated little-o formula.

Since $Q(r)>0$, global or eventual nonnegativity of $\overline P_r$ at a fixed parameter necessarily implies $E(r)\ge0$. If $E(r)<0$, that actual primitive is strictly negative at all sufficiently large ages. The converse is not supplied: a positive tail coefficient does not control intermediate ages or the mixed W terms.

## 2. A discrete driver transform with an explicit arithmetic remainder

Let
$$
D_e(z)=\sum_{j\ge0}\frac{e_j}{(j+1)^z}.
$$
The elementary actual bound $|e_j|\ll\log(j+2)/\sqrt{j+1}$ gives absolute convergence for $\Re z>1/2$. On $1/2<\Re z<1$ define
$$
K_z(y)=\int_0^{y-1}(\lfloor t\rfloor+1)^{-z}(y-t)^{-1/2}dt,
\qquad y\ge1.
\tag{7}
$$
The completed physical source has the literal Stieltjes derivative
$$
dg(y)=\sum_{n\ge2}\frac{\Lambda(n)}n\delta_n
-\frac{\psi(y)}{y^2}dy\quad(y>1).
\tag{8}
$$
In particular the negative continuous term is retained. The causal initial source value is $g(1)=-1$; $K_z(1)=0$ eliminates its boundary product, rather than changing that value.

For each $j$, the exact ordinary successor difference is
$$
e_j=\frac12\int_1^\infty\frac{g(x+j+1)-g(x+j)}{\sqrt x}dx.
$$
Writing its difference through $dg$ and partitioning $t\ge0$ into the actual unit cells gives
$$
\boxed{D_e(z)=\frac12\int_1^\infty K_z(y)\,dg(y)
=-\frac12\int_1^\infty g(y)K_z'(y)dy.}
\tag{9}
$$
These are initially absolute exchanges for $1/2<\Re z<1$. Indeed $K_z(y)=O_z(y^{1/2-\Re z})$, up to smaller integrable endpoint terms, and (8), $\Lambda(n)\le\log n$, and $\psi(y)\le y\log y$ give convergence against $|dg|$ in this strip. At infinity $gK_z\to0$ because $g$ is bounded and $\Re z>1/2$. The locally absolutely continuous kernel is continuous at integer $y$; its a.e. derivative has no artificial atomic term there.

We now separate the exact scale term with a holomorphic, integrable error. Uniformly for $z$ in a compact subset of $0<\Re z<1$,
$$
\boxed{K_z'(y)=\left(\frac12-z\right)
\mathrm B(1-z,1/2)y^{-z-1/2}
+O_K(y^{-3/2}+y^{-\Re z-1}),\quad y\ge2.}
\tag{10}
$$
Here is a proof controlling both endpoints and the integer steps. Write
$$
w_z(t)=(\lfloor t\rfloor+1)^{-z},\qquad
\delta_z(t)=w_z(t)-(t+1)^{-z}.
$$
The mean-value formula gives $|\delta_z(t)|\le C_K(t+1)^{-\Re z-1}$. If $K_z^c$ uses $(t+1)^{-z}$ in (7), then, a.e.,
$$
(K_z-K_z^c)'(y)=\delta_z(y-1)
-\frac12\int_0^{y-1}\delta_z(t)(y-t)^{-3/2}dt.
$$
Splitting the integral at $t=y/2$ proves the error in (10): the first part uses the finite integral of $|\delta_z|$, and the second uses its $O(y^{-\Re z-1})$ bound and the lower separation $y-t\ge1$.

For the continuous comparison,
$$
K_z^c(y)=\int_1^y u^{-z}(y+1-u)^{-1/2}du.
$$
Complete this to the beta integral on $0<u<y+1$. Its value is $\mathrm B(1-z,1/2)(y+1)^{1/2-z}$. The derivative of the omitted interval $0<u<1$ is $O_K(y^{-3/2})$. In the other omitted interval put $v=y+1-u\in(0,1)$; its derivative is $O_K(y^{-\Re z-1})$. Finally replacing $y+1$ by $y$ in the derivative of the beta term contributes only a smaller error. This proves (10) throughout the indicated strip with locally uniform constants.

Let the actual source transform be
$$
A(z)=\int_0^\infty e^{-zv}a(v)dv
=\frac{-\zeta'(z+1/2)}{(z+1/2)\zeta(z+1/2)}-\frac1{z-1/2}
\quad(\Re z>1/2).
$$
Since $A(z)=\int_1^\infty g(y)y^{-z-1/2}dy$, equations (9)–(10) prove the meromorphic continuation identity
$$
\boxed{D_e(z)=\frac{z-1/2}{2}\mathrm B(1-z,1/2)A(z)+R(z),
\qquad0<\Re z<1,}
\tag{11}
$$
where the exact remainder is
$$
R(z)=-\frac12\int_1^\infty g(y)
\left[K_z'(y)-(1/2-z)\mathrm B(1-z,1/2)y^{-z-1/2}\right]dy.
\tag{12}
$$
This remainder is holomorphic on the entire strip: $g$ is bounded, (10) is integrable there uniformly on compact subsets, and the integrands are holomorphic in $z$ for a.e. $y$. This is an explicit actual signed remainder, not an unspecified arithmetic hypothesis. No sign has been imposed on the small-$n$ driver coefficients.

## 3. The literal boundary clock preserves the source poles

For $h\ge0$ put
$$
H(h)=E(1-e^{-h}).
$$
Its Laplace transform, initially for $\Re z>1/2$, is the literal Abel–Mellin integral
$$
\mathfrak E(z)=\int_0^\infty e^{-zh}H(h)dh
=\int_0^1t^{z-1}E(1-t)dt.
\tag{13}
$$
One has
$$
\boxed{\mathfrak E(z)=M(z)A(z)+\mathcal R(z),\quad
M(z)=\frac{\Gamma(z)(z-1/2)}2\mathrm B(1-z,1/2),
\quad0<\Re z<1,}
\tag{14}
$$
where $\mathcal R$ is holomorphic on the strip.

To verify every infinite-integral conversion, first use $E(e^{-t})$. Absolute summation for $\Re z>1/2$ gives
$$
\int_0^\infty t^{z-1}[E(e^{-t})-e_0]dt
=\Gamma(z)\sum_{j\ge1}e_jj^{-z}.
$$
The index correction
$$
D_e(z)-\sum_{j\ge1}e_jj^{-z}
=e_0+\sum_{j\ge1}e_j[(j+1)^{-z}-j^{-z}]
$$
is holomorphic for $\Re z>-1/2$. The integral over $t\ge1$ is entire because $E(e^{-t})-e_0$ decays exponentially. Restoring the constant on $(0,1)$ adds exactly $e_0/z$, holomorphic for $\Re z>0$. Hence $\int_0^1t^{z-1}E(e^{-t})dt=\Gamma(z)D_e(z)$ plus a holomorphic function on $\Re z>0$.

Finally, the actual driver bound implies
$$
|E'(r)|\ll(1-r)^{-3/2}\log\frac2{1-r}\quad(1/2\le r<1).
$$
Since $e^{-t}-(1-t)=O(t^2)$, it follows that
$$
|E(e^{-t})-E(1-t)|\ll t^{1/2}\log(2/t)\quad(t\downarrow0).
$$
The Mellin transform of this difference is holomorphic for $\Re z>-1/2$. Thus replacing $e^{-t}$ by the requested literal $1-t$ adds no pole in the strip of (14). Combining this with (11) proves (14).

For an actual nontrivial zeta zero $\rho$ with $\Re\rho>1/2$ and multiplicity $m_\rho$, let $z_\rho=\rho-1/2$. The residue of $A$ there is $-m_\rho/\rho$. The multiplier $M$ is finite and nonzero at $z_\rho$: gamma has no zeros or poles in this strip, the beta factor has no zeros or poles there, and $z_\rho\ne1/2$ because $\rho\ne1$. These analytic facts follow from [the gamma function's zero and pole structure](https://dlmf.nist.gov/5.2) and [the beta–gamma identity](https://dlmf.nist.gov/5.12.E1). Consequently
$$
\boxed{\operatorname{Res}_{z=z_\rho}\mathfrak E(z)
=-\frac{m_\rho}{\rho}\,
\frac{\Gamma(z_\rho)(z_\rho-1/2)}2
\mathrm B(1-z_\rho,1/2)\ne0.}
\tag{15}
$$
The holomorphic remainder cannot cancel this pole. Every actual multiplicity remains visible through its nonzero factor $m_\rho$.

## 4. What the scalar sign would imply

The bound on $e_j$ shows $H(h)=O((1+h)e^{h/2})$, so its Laplace convergence set contains $\Re z>1/2$. The right side of (14) is holomorphic near every real $z\in(0,1)$: the actual source has its filled removable point at $z=1/2$, and zeta has no real zero at $z+1/2>1/2$. The beta and gamma factors in (14) introduce no singularity inside this real interval.

Suppose
$$
\boxed{E(r)\ge0\quad\text{for every }r_0<r<1}
\tag{16}
$$
for some fixed $r_0<1$. Then $H$ is nonnegative on a final half-line. Its finite initial segment has an entire transform. The positive-Laplace abscissa theorem used in the accepted boundary criterion forces the actual Laplace integral to be holomorphic on $\Re z>0$: a positive convergence abscissa, necessarily at most $1/2$, would require a real singularity, contradicting (14). Equation (15) therefore excludes every zero with $\Re\rho>1/2$; the functional equation gives RH. The same argument applies to eventual nonpositivity by replacing $H$ with $-H$.

This is a proved scalar sufficient condition, not a proof of (16). The [conditional converse](successor-feedback-RH-converse.md) proves that RH implies $E(r)>5/3$ throughout a final interval. Thus eventual nonnegativity of the literal feedback is RH-equivalent. The unconditional near-one sign remains open. The known positive-primitive interval implies $E(r)>0$ for $0<r\le1/32$, but does not approach the required boundary: its lower envelope and (1) give $c_r\ge19(1-r)/2200>0$ there. A sequence of positive values $E(r_j)$ with $r_j\uparrow1$ does not supply the eventual sign needed here. In contrast, a common-halfline primitive sign along such a sequence has the stronger locally uniform source-limit implication in the separate boundary theorem.

The fixed-parameter tail and the Abel transform clarify two distinct pieces of the full W problem. The scalar feedback is a necessary tail budget for a globally positive resolvent primitive, and a whole boundary interval of one scalar sign would already exclude off-critical source poles. Neither statement controls finite-age mixed products solely from the scalar sign. The literal same-prime subtraction, density, charge, and both source-product cross terms of the W criterion remain unchanged; no scalar tail coefficient is substituted for their full readout.

## Classical input and formal scope

The positive-Laplace abscissa principle is classical. [Suzuki, Proposition 1, Section 2.4](https://link.springer.com/article/10.1007/s11139-025-01238-9) states its Mellin form and cites Widder, *The Laplace Transform*, Chapter II, Theorem 5b. The self-contained positive-moment proof is linked above. The actual-source kernel, remainder and sign implications here are written proofs; no new priority claim is made. The repository already formalizes the general finite-abscissa obstruction in [LandauSingularity.lean](BuildingBlocks/LandauSingularity.lean) and the local extension step in [LocalLandauExtension.lean](BuildingBlocks/LocalLandauExtension.lean). Those modules do not formalize this particular arithmetic transform or its unproved sign premise.

This chapter preserves a written mathematical proof. The actual resolvent, its arithmetic sign or profile consumer, and its stated limiting quantifiers are not asserted to be Lean formalized.

The [continuous-shift proof](actual-Abel-feedback-Mellin-kernel.md) derives the same pole multiplier through complete integer quadrature and a bounded collective lower-boundary correction. The [factorial-division expansion](actual-Abel-factorial-division-positivity.md) supplies a separate constructive positive region and locates the returned histories that can contribute negative logarithmic mass.

## Formalized actual source and ordinary increments

[SuccessorFeedbackSource.lean](BuildingBlocks/SuccessorFeedbackSource.lean) defines the literal causal source with $a(0)=-1$ and the actual $\psi(\lfloor e^v\rfloor)$ cutoff. In namespace `BuildingBlocks.SuccessorFeedback`, `source_iterate` identifies every ordinary iterate on $v\ge0$ with $e^{v/2}g(e^v+j)$. `driver_integrable` and `driver_physical_integral` prove that the relative-kernel charge is absolutely defined and equals
$$\frac12\int_{x>1}k(\log x)g(x+j)\,\frac{dx}{\sqrt x}.$$
The exact initial-cell part of $k$ is retained. `driver_abs_le` gives $|e_j|\le2(4\log2+1)$ using the already formal unconditional Chebyshev bound, and `driver_series_summable` gives absolute convergence for $|r|<1$. No integrability of the unweighted source is assumed.

[SuccessorFeedbackDifference.lean](BuildingBlocks/SuccessorFeedbackDifference.lean) proves `physicalDifference_eq`, retaining the exact new birth and continuous density:
$$
g(x+j+1)-g(x+j)
=\frac{\Lambda(\lfloor x\rfloor+j+1)}{x+j+1}
-\frac{\psi(\lfloor x\rfloor+j)}{(x+j)(x+j+1)}\quad(x>0).
$$
`physicalDifference_abs_le` bounds its modulus by $[\log(x+j+1)+4\log2]/(x+j+1)$. `physicalDifference_power_bound` provides an explicit $x^{-5/4}$ majorant after multiplication by $x^{-1/2}$ on $x\ge1$. `innovation_integrable` and `innovation_integral` prove the actual ordinary increment lies in causal $L^1$ and give its physical integral.

These two modules do not yet identify the kernel-defined charge with half the integral of that increment; the separate boundary module below now supplies the vanishing terminal-strip step. They also do not prove the sharper large-$j$ decay, analytic floor-kernel remainder, Abel pole identity or RH sign criterion above. Their affected target builds and main axiom checks passed with only `propext`, `Classical.choice` and `Quot.sound`.

### The retained terminal strip

[SuccessorFeedbackBoundary.lean](BuildingBlocks/SuccessorFeedbackBoundary.lean) closes that exact charge conversion. For a measurable bounded physical profile $H$, `profile_finite_charge_identity` retains the full strip $R<u\le\sigma(R)$ in the difference between the truncated successor integral and its kernel charge. `terminal_strip_bound` bounds this strip by $4M e^{-R/2}$ when $|H|\le M$, uniformly in the ordinary successor index. `profile_relative_charge` passes to the infinite interval using only the integrable difference and kernel product.

For the literal arithmetic source, `driver_eq_innovation_integral` and `driver_eq_difference_integral` now prove
$$e_j=\frac12\int_{v>0}(S^{j+1}a-S^ja)(v)\,dv=\frac12\int_{x>1}[g(x+j+1)-g(x+j)]\frac{dx}{\sqrt x}.$$
The initial cell is already in the exact kernel; both unweighted source integrals remain unseparated. The module build and main axiom checks passed with the normal three axioms. The sharper coefficient decay and analytic Abel remainder are still outside this source-to-driver chain.

[SuccessorFeedbackDecay.lean](BuildingBlocks/SuccessorFeedbackDecay.lean), `driver_decay_bound`, now proves the explicit unconditional estimate
$$|e_j|\le3[\log(j+1)+4\log2+4](j+1)^{-1/2}\qquad(j\ge0).$$
It uses the exact retained-boundary charge identity, the full $\Lambda/\psi$ increment and Chebyshev's bound. [SuccessorFeedbackDirichlet.lean](BuildingBlocks/SuccessorFeedbackDirichlet.lean), `driver_LSeriesSummable`, `dirichletTransform_analyticOnNhd` and `dirichletTransform_eq_series`, derives absolute convergence and holomorphy of $\sum_{j\ge0}e_j/(j+1)^z$ for $\Re z>1/2$ through mathlib's classical Dirichlet-series theory. The exact series retains $e_0/1^z$. Its strip continuation, Abel-clock remainder and eventual-sign implication remain written mathematics. Both modules compile with only the standard `propext`, `Classical.choice` and `Quot.sound` axioms in the checked main targets.


## Formal floor, index and clock corrections

The literal discretization and initial driver are retained in three further modules, in namespace `BuildingBlocks.SuccessorFeedback`.

[SuccessorFeedbackPowerDifference](BuildingBlocks/SuccessorFeedbackPowerDifference.lean) proves the complex mean-value estimate and the actual floor discrepancy
$$
\delta_z(t)=(\lfloor t\rfloor+1)^{-z}-(t+1)^{-z},\qquad
|\delta_z(t)|\le\|z\|2^{\Re z+1}(t+1)^{-\Re z-1}
$$
for $t\ge0$ and $\Re z\ge-1$. Theorems `floorWeightError_integrable` and `floorWeightError_uniform_bound` give integrability on the positive half-line and a common integrable majorant on bounded parameter sets with real part bounded below by a positive constant.

[SuccessorFeedbackIndexCorrection](BuildingBlocks/SuccessorFeedbackIndexCorrection.lean) defines
$$
I(z)=e_0+\sum_{j\ge1}e_j\big[(j+1)^{-z}-j^{-z}\big].
$$
`indexCorrection_analyticOnNhd` proves holomorphy on $\Re z>-1/2$, using the actual driver decay. `indexCorrection_eq_difference` identifies it with the difference of the two absolutely convergent Dirichlet series on $\Re z>1/2$. The initial constant $e_0$ is included.

[SuccessorFeedbackClock](BuildingBlocks/SuccessorFeedbackClock.lean) gives a distinct bounded-error proof for the two literal clocks:
$$
|E(e^{-t})-E(1-t)|\le2(4\log2+1),\qquad0<t\le1.
$$
The theorem is `clockError_bound`. The exact signed integral
$$
\int_0^1 t^{s-1}\big[E(e^{-t})-E(1-t)\big]\,dt
$$
is absolutely convergent and holomorphic for $\Re s>0$, as proved by `clockMellinError_convergent`, `clockMellinError_analyticOnNhd` and `clockMellinError_eq_integral`. The open endpoints match the literal integral.

These modules use the existing arithmetic source and Chebyshev bound. Their target builds and main axiom checks pass with only `propext`, `Classical.choice` and `Quot.sound`. The sharper written clock error, the remaining floor-kernel analytic continuation and the eventual-sign RH consumer are not asserted by these modules.


## Formal Gamma conversion and complete Abel-clock remainder

[SuccessorFeedbackGamma](BuildingBlocks/SuccessorFeedbackGamma.lean) proves the actual whole-axis identity
$$
\int_0^\infty t^{z-1}[E(e^{-t})-e_0]\,dt
=\Gamma(z)\sum_{j\ge1}\frac{e_j}{j^z}
=\Gamma(z)[D_e(z)-I(z)],\qquad\Re z>1/2.
$$
Theorems `gammaDriver_integrable`, `gammaDriver_integral` and `gammaDriver_integral_eq_shifted` derive absolute convergence and the signed interchange from the integrals of coefficient norms. The initial driver is subtracted before integration at infinity. This uses the classical Gamma integral already in mathlib.

[SuccessorFeedbackMellinTail](BuildingBlocks/SuccessorFeedbackMellinTail.lean) proves the explicit exponential estimate for $E(e^{-t})-e_0$ on $t\ge1$. Its exact tail
$$
T_\infty(z)=\int_1^\infty t^{z-1}[E(e^{-t})-e_0]\,dt
$$
is absolutely convergent for every complex $z$ and entire, as formalized by `exponentialMellinTail_convergent` and `exponentialMellinTail_differentiable`.

[SuccessorFeedbackAbelClock](BuildingBlocks/SuccessorFeedbackAbelClock.lean) then proves
$$
\mathcal E(z)=\int_0^1t^{z-1}E(1-t)\,dt
=\Gamma(z)D_e(z)+R_{\rm clock}(z),\qquad\Re z>1/2,
$$
where the literal remainder is
$$
R_{\rm clock}(z)=-\Gamma(z)I(z)-T_\infty(z)+\frac{e_0}{z}
-\int_0^1t^{z-1}[E(e^{-t})-E(1-t)]\,dt.
$$
`abelTransform_integrable` proves absolute convergence in the stated half-plane; `abelTransform_eq_dirichlet` proves the identity; `abelClockRemainder_analyticOnNhd` proves the remainder holomorphic on $\Re z>0$. Every endpoint, index shift and signed driver is retained. The interval is represented as $(0,1]$ in Lean, with the endpoint difference explicitly harmless for the earlier open-interval clock integral.

The frozen target builds and primary axiom checks pass with only `propext`, `Classical.choice` and `Quot.sound`. This closes the Gamma/index/clock conversion. The arithmetic floor-kernel continuation and the zeta-pole/sign implication remain separate written results.


## Formal positive-age Laplace profile

[SuccessorFeedbackAbelLaplace](BuildingBlocks/SuccessorFeedbackAbelLaplace.lean) defines the literal profile $H(h)=E(1-e^{-h})$ and proves $H(0)=e_0$. The exponential change of variables retains the Jacobian and the exact image $(0,1)$ of positive ages. `abelProfile_laplace_integrable` and `abelProfile_laplace_eq_dirichlet` give
$$
\int_0^\infty e^{-sh}H(h)\,dh
=\mathcal E(s)=\Gamma(s)D_e(s)+R_{\rm clock}(s),\qquad\Re s>1/2,
$$
with absolute convergence derived from the preceding Abel integral. The change-of-variables equality is `abelTransform_eq_laplace`. The frozen target build and primary axiom checks pass with the three standard axioms. The eventual-sign and zeta-pole conclusions remain separate from this coordinate identity.

## Formal literal floor kernel

[SuccessorFeedbackFloorKernel.lean](BuildingBlocks/SuccessorFeedbackFloorKernel.lean) defines, for $y\ge1$,
$$
K_z(y)=\int_0^{y-1}(\lfloor t\rfloor+1)^{-z}(y-t)^{-1/2}dt.
$$
`floorAbelIntegrand_integrable` proves absolute finite-interval integrability for $\Re z\ge0$; the literal upper endpoint keeps $y-t\ge1$. `floorAbelKernel_initial` gives $K_z(1)=0$, and `floorAbelKernel_analyticOnNhd` proves parameter analyticity for $\Re z>0$. The proof derives a local derivative majorant on the complete interval.

`floorAbelKernel_sub_smooth` identifies the exact difference from the continuous $(t+1)^{-z}$ kernel as the integral of the previously formalized floor-weight error. No spatial derivative, arithmetic integration or zeta continuation is assumed by these statements. The affected target compiled, and its main axiom checks use only `propext`, `Classical.choice` and `Quot.sound`.


## Formal spatial derivative and its complete zero-mass error

[SuccessorFeedbackClippedKernel.lean](BuildingBlocks/SuccessorFeedbackClippedKernel.lean) separates the moving endpoint using the bounded Lipschitz function $k(x)=(\max(1,x))^{-1/2}-1$. For every $L^1$ input its convolution is differentiable, with derivative obtained by the complete kernel $k'(x)=-\tfrac12x^{-3/2}\mathbf1_{x>1}$. The proof does not differentiate the floor function.

[SuccessorFeedbackFloorAgeDerivative.lean](BuildingBlocks/SuccessorFeedbackFloorAgeDerivative.lean), theorem `floorAbelError_hasDerivAt`, proves for $\Re z>0$, $y>1$ and $y-1$ nonintegral,
$$
(K_z-K_{z,\rm cont})'(y)
=\delta_z(y-1)-\frac12\int_0^{y-1}\delta_z(t)(y-t)^{-3/2}dt,
\qquad
\delta_z(t)=(\lfloor t\rfloor+1)^{-z}-(t+1)^{-z}.
$$
The full endpoint value is retained. `floorAbelError_hasDerivAt_ae` proves the corresponding almost-everywhere statement on $y>1$.

[SuccessorFeedbackFloorL1.lean](BuildingBlocks/SuccessorFeedbackFloorL1.lean) extends $\delta_z$ by zero to negative ages and defines the literal whole-line error $R_z(y)=\delta_z(y-1)+(\delta_z*k')(y)$. `floorAgeError_integrable`, `floorAgeError_integral` and `floorAgeError_norm_bound` prove
$$
R_z\in L^1(\mathbb R),\qquad
\int_{\mathbb R}R_z=0,\qquad
\|R_z\|_1\le2\|\delta_z\|_{L^1(0,\infty)}.
$$
The cancellation uses the proved kernel mass $\int k'=-1$ and $\|k'\|_1=1$. The module identifies $R_z$ with the actual derivative almost everywhere. These are unconditional analytic identities, derived from the literal discretization error. The arithmetic pairing and zeta continuation remain outside this batch. The affected targets and main axiom checks passed with only `propext`, `Classical.choice` and `Quot.sound`.

## Formal arithmetic pairing, holomorphic floor remainder and age endpoints

[SuccessorFeedbackFloorPairing](BuildingBlocks/SuccessorFeedbackFloorPairing.lean) transposes the complete integrable age derivative against any bounded measurable complex source $g$:
$$
\int_{\mathbb R}g(y)R_z(y)\,dy
=\int_0^\infty\delta_z(t)
\left[g(t+1)-\frac12\int_1^\infty\frac{g(t+x)}{x^{3/2}}\,dx\right]dt,
\qquad \Re z>0.
$$
Here $R_z$ is the whole-line floor-error derivative defined in the preceding section. The bracket keeps the endpoint and the entire tail together, with norm at most $2\|g\|_\infty$. `actual_floorAgeError_pairing` specializes this identity to the literal $g(x)=\psi(\lfloor x\rfloor)/x-1$, using its existing definition at zero and below the causal threshold. The global bound $|g|\le4\log2+1$ and both absolute integrability claims are proved from the existing Chebyshev dependency.

[SuccessorFeedbackFloorHolomorphic](BuildingBlocks/SuccessorFeedbackFloorHolomorphic.lean) proves `actualFloorRemainder_analyticOnNhd`: this actual integral is holomorphic on $\Re z>0$. It uses the classical Cauchy estimate on a local parameter disk to turn the already proved uniform $L^1$ floor discrepancy into an integrable parameter-derivative bound. This is a complete alternate proof of the remainder's holomorphy; the arithmetic source is unchanged.

[SuccessorFeedbackFloorBoundary](BuildingBlocks/SuccessorFeedbackFloorBoundary.lean) proves that $K_z(1)-K_z^{\rm cont}(1)=0$ and
$$
K_z(y)-K_z^{\rm cont}(y)\longrightarrow0,
\qquad
g(y)\bigl[K_z(y)-K_z^{\rm cont}(y)\bigr]\longrightarrow0
\quad(y\to\infty),\qquad \Re z>0.
$$
The proof applies dominated convergence to the literal finite-cell indicator; it assumes no limit for $g$ itself. The complete driver-to-zeta transform, continuous beta kernel and eventual-sign RH consumer remain outside these modules. The three modules compile against the repository pin; their principal theorem axiom reports contain only `propext`, `Classical.choice` and `Quot.sound`.

## Formal causal root translation

[SuccessorFeedbackRootTranslation](BuildingBlocks/SuccessorFeedbackRootTranslation.lean) proves the exact translation cancellation for the literal causal kernel $c(x)=\mathbf1_{x>1}/\sqrt x$. Although $c$ is not integrable, for every $t\ge0$ its difference is integrable and
$$
\int_{\mathbb R}\bigl[c(x)-c(x-t)\bigr]dx=0,
\qquad
\int_{\mathbb R}|c(x)-c(x-t)|dx=4\bigl(\sqrt{t+1}-1\bigr).
$$
The proof retains the positive initial strip $(1,t+1]$ and the complete negative tail $(t+1,\infty)$, each of mass $2(\sqrt{t+1}-1)$. This elementary translation identity is a prerequisite for the continuous-kernel cancellation; it does not by itself assert the analytic continuation across $z=1$ or the complete zeta transform. Its target and aggregate compile, and the principal axiom reports contain only `propext`, `Classical.choice` and `Quot.sound`.
