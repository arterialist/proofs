# Closed Euler-discrepancy lemmas and the unresolved renewal stability step

The [prime-division renewal equation](../factorial-and-renewal/prime-division-renewal-lyapunov.md) has an exact Euler discrepancy. This proof establishes its positive cell masses and improved decay, with the origin atoms and causal trace terms retained. It distinguishes the specified arithmetic heat response from stability for arbitrary bounded inputs.

## 1. Endpoint-exact discrepancy and transforms

Let
$$
 S_n=\sum_{m=1}^n m^{-1/2},\quad
 \nu=\sum_{m\ge1}m^{-1/2}\delta_{\log m},\quad
 \kappa=1_{u\ge0}e^{u/2}du,
$$
$$
 E(u)=S_{\lfloor e^u\rfloor}-2(e^{u/2}-1),\quad u\ge0,
 \qquad c=2+\zeta(1/2).
$$
The right-continuous endpoint convention includes m=1 at u=0, so E(0)=1. Extend
$$
 H(u)=1_{u\ge0}(E(u)-c)
$$
by zero on the negative half-line. On each cell [log n,log(n+1)),
$$
 H(u)=A_n-2e^{u/2},\qquad A_n=S_n-\zeta(1/2).
 \tag{1}
$$
The Euler discrepancy bound gives H(u)=O(e^(−u/2)), uniformly including right endpoints. Thus H∈L¹∩L².

As locally finite measures, or equivalently as distributions on the full line,
$$
 \boxed{\quad \nu-\kappa=c\delta_0+DH.\quad}
 \tag{2}
$$
Indeed DH has origin atom H(0+)=1−c, interior atoms m^(−1/2) at log m for m≥2, and continuous density −e^(u/2) on u>0. Adding cδ₀ supplies exactly the missing unit origin atom. These measures need not have finite total variation globally.

For Re z>1/2, absolutely convergent Laplace transforms give
$$
 \zeta(z+1/2)-\frac1{z-1/2}=c+z\widehat H(z).
 \tag{3}
$$
The defining integral for Hhat is holomorphic for Re z>−1/2. Thus (3) continues the discrepancy to this larger half-plane; the displayed pole is retained. At z=0 the singularity of the quotient defining Hhat is removable, and differentiation yields
$$
 \ell:=\int_0^\infty H(u)du=4+\zeta'(1/2).
 \tag{4}
$$
This is differentiation of (3), not an interchange with the original divergent Dirichlet series.

For a causal function h, the exact convolution statement is
$$
 (\nu-\kappa)*h=ch+H*Dh,
 \tag{5}
$$
where Dh means the distributional derivative of the zero extension. If h is locally absolutely continuous only on [0,∞), with right trace h₀, then its classical-derivative version is instead
$$
 (\nu-\kappa)*h=ch+H*h'_{\rm cl}+h_0H.
 \tag{6}
$$
Consequently the source's equations (37)–(39) need either the distributional convention, a zero trace, or the explicit final term in (6). For example the corrected L∞ estimate is
$$
 \|(\nu-\kappa)*h-ch\|_\infty
 \le\|H\|_1\|h'_{\rm cl}\|_\infty+|h_0|\|H\|_\infty,
$$
and the analogous L² estimate uses |h₀|||H||₂. The zero-trace estimates are exactly those stated in the source.

## 2. A signed Euler remainder with an explicit bound

The following exact tail formula gives the required signs:
$$
 A_n=2\sqrt n+\frac1{2\sqrt n}-I_n,
\quad
 I_n=\frac1{\sqrt\pi}\int_0^\infty t^{-1/2}e^{-nt}
 \left[\frac12\coth(t/2)-\frac1t\right]dt.
 \tag{7}
$$
One derivation starts with the positive trapezoid error for f(x)=x^(−1/2):
$$
 I_n=\sum_{k=n}^\infty
 \left[\frac{f(k)+f(k+1)}2-\int_k^{k+1}f(x)dx\right].
$$
The finite partial sums telescope; their limit is precisely the difference in (7), using S_N−2√N→ζ(1/2). Inserting the elementary Laplace integral for f and summing the geometric series gives (7). All error terms are nonnegative, so Tonelli is legitimate.

The partial fraction identity
$$
 \frac12\coth(t/2)-\frac1t
 =2t\sum_{k\ge1}\frac1{t²+4\pi²k²}
$$
follows by logarithmically differentiating the convergent Euler product for sinh(t/2)/(t/2). It gives the strict inequalities
$$
 0<\frac t{12}-\left[\frac12\coth(t/2)-\frac1t\right]
 <\frac{t³}{720},\qquad t>0.
$$
Here the two sums used are Σk^(−2)=π²/6 and Σk^(−4)=π⁴/90. Integrating proves
$$
 \boxed{\quad
 A_n=2\sqrt n+\frac1{2\sqrt n}
                  -\frac1{24n^{3/2}}+r_n,
 \qquad0<r_n<\frac1{384n^{7/2}}.
 \quad}
 \tag{8}
$$
This supplies both source (54) and its later expansion (78), including the sign of the omitted remainder.

## 3. Every cell has positive net mass

The sequence S_n−2√n decreases strictly, because its next increment is
$$
 \frac1{\sqrt{n+1}}-\frac2{\sqrt{n+1}+\sqrt n}<0.
$$
The sequence S_n−2√(n+1) increases strictly by the corresponding reversed inequality. Both tend to ζ(1/2). Therefore
$$
 2\sqrt n<A_n<2\sqrt{n+1}.
 \tag{9}
$$
Equation (1) consequently has exactly one zero inside each cell, with H positive first and negative last.

Let J(u)=∫₀ᵘH(r)dr for u≥0 and extend J by zero to the left. Let j_n=J(log n), and put q_n=j_(n+1)−j_n. With a=√n,b=√(n+1), direct integration gives
$$
 q_n=2\log(b/a)\,[A_n-2L(a,b)],
 \qquad L(a,b)=\frac{b-a}{\log b-\log a}.
 \tag{10}
$$
The source's logarithmic-mean bound has a short elementary proof. Weighted arithmetic-geometric mean gives
$L(a,b)=\int_0^1a^{1-t}b^t dt<(a+b)/2$.
Taylor's integral remainder for √x gives
$$
 b<a+\frac1{2a}-\frac1{8b³}.
$$
Thus
$$
 2L(a,b)<2a+\frac1{2a}-\frac1{8b³}.
$$
Since b³/a³≤2√2<3, one has 1/(8b³)>1/(24a³). Together with (8), this proves
$$
 \boxed{\quad q_n>0\quad(n\ge1).\quad}
 \tag{11}
$$
In particular j₁=0 and j_n>0 for n≥2. Within each cell J first increases and then decreases, so its minimum is at an endpoint. It follows that
$$
 \boxed{\quad J(u)>0\quad(u>0).\quad}
 \tag{12}
$$
Since H∈L¹, J is bounded, j_n increases to ℓ, and Σq_n=ℓ. Equation (11) also proves ℓ>0 independently of a numerical evaluation of ζ′(1/2). J itself is not monotone inside the cells.

## 4. Positive step and arch decomposition, with exact decay

For log n≤u<log(n+1), define
$$
 Q(u)=j_n,\qquad R(u)=J(u)-j_n.
$$
Writing u=log n+t, 0≤t<log(1+1/n), gives exactly
$$
 R(u)=A_nt-4\sqrt n(e^{t/2}-1).
 \tag{13}
$$
The preceding one-crossing argument and q_n>0 show R≥0. Thus J=Q+R, where Q is nondecreasing and R is a nonnegative arch on each half-open cell. At log(n+1), Q jumps by q_n and R resets from its left limit q_n to zero; their sum J remains continuous. In particular these artificial opposite jumps must not be counted as new jumps of J.

For Re z>0, Tonelli or absolute convergence yields
$$
 \widehat Q(z)=\frac1z\sum_{n\ge1}q_n(n+1)^{-z},
 \qquad \widehat H(z)=z\widehat J(z).
 \tag{14}
$$
Taylor's theorem, with bounded remainders for x=1/n∈[0,1], gives
$$
 2L(\sqrt n,\sqrt{n+1})
 =2\sqrt n+\frac1{2\sqrt n}
                   -\frac1{6n^{3/2}}+O(n^{-5/2}).
$$
Combining with (8) and log(1+1/n)=n^(−1)+O(n^(−2)) proves
$$
 q_n=\frac1{8n^{5/2}}+O(n^{-7/2}),\qquad
 \ell-j_n=\frac1{12n^{3/2}}+O(n^{-5/2}).
 \tag{15}
$$
On the nth cell, (9) bounds |H| by 2(b−a)≤n^(−1/2). Its length is at most 1/n, so 0≤R≤n^(−3/2). Therefore
$$
 \boxed{\quad J(u)-\ell=O(e^{-3u/2}).\quad}
 \tag{16}
$$
This estimate is uniform through the logarithmic endpoints. It is an actual arithmetic cancellation gain, not a positivity estimate for the centered remainder.

In fact the centered remainder changes sign inside every sufficiently large cell. For any fixed 0≤θ<1, expansion of (13) at t=θ/n gives
$$
 n^{3/2}[J(\log n+\theta/n)-\ell]
 \longrightarrow-\frac1{12}+\frac\theta2-\frac{\theta²}2.
 \tag{17}
$$
The limit is −1/12 at θ=0 and +1/24 at θ=1/2. Thus it is invalid to infer one-sided damping from the sign of J−ℓ.

## 5. The second-order identity and its origin atoms

Extend $\widetilde J=(J-\ell)1_{u\ge0}$ causally. Its trace is −ℓ, whereas J(0)=0. Consequently
$$
 DJ=H\,du,\qquad
 D\widetilde J=H\,du-\ell\delta_0,
$$
$$
 \boxed{\quad \nu-\kappa=c\delta_0+\ell\delta_0'
                                      +D²\widetilde J.\quad}
 \tag{18}
$$
As a check, D²tildeJ contains the opposite −ℓδ₀′; they cancel in the original measure. Its surviving origin atom is H(0+)=1−c, which combines with cδ₀ to give 1.

The defining integral for tildeJhat converges normally for Re z>−3/2. First for Re z>−1/2 and then by analytic continuation,
$$
 \widehat H(z)=\ell+z\widehat{\widetilde J}(z),
$$
$$
 \boxed{\quad
 \zeta(z+1/2)=c+\frac1{z-1/2}+\ell z
                           +z²\widehat{\widetilde J}(z),
 \quad \Re z>-3/2.
 \quad}
 \tag{19}
$$
The pole at z=1/2 remains a pole; equality there means equality of meromorphic germs. This continues a transform representation, not the original positive Dirichlet series.

The causal time-domain identity is correspondingly
$$
 \nu*h=\kappa*h+ch+\ell Dh+\widetilde J*D²h.
 \tag{20}
$$
All derivatives here are of the zero extension. If classical derivatives are used and h₀,h₁ are the right initial traces, then
$$
 Dh=h'_{\rm cl}+h_0\delta_0,
 \quad D²h=h''_{\rm cl}+h_1\delta_0+h_0\delta_0'.
$$
These are precisely the initial terms needed in source (88). The declared distributional convention in that section is correct.

## 6. Stable continuous factor versus unrestricted BIBO inversion

The elementary alternating-series brackets prove 0<c<1. For causal convolution
$\mathcal Kh(v)=\int_0^v e^{u/2}h(v-u)du$, set a=c^(−1)−1/2>0. Direct differentiation with zero initial state proves
$$
 (\mathcal K+cI)^{-1}
 =c^{-1}I-c^{-2}e^{-av}1_{v\ge0}*.
 \tag{21}
$$
Its impulse response is a finite signed measure and hence this factor genuinely has a bounded causal L∞ input-output map.

The feedback transfer, initially for Re z>1/2 and then meromorphically, is
$$
 1+T(z)=\frac{\zeta(z+1/2)}{c+(z-1/2)^{-1}}.
 \tag{22}
$$
At z=1/2 the ratio is removable and equals 1. The denominator's zero is z=1/2−1/c<0, so it introduces no right-half-plane zero. Consequently
$$
 T(z)\ne-1\ (\Re z>0)
 \quad\Longleftrightarrow\quad
 \zeta(s)\ne0\ (\Re s>1/2)
 \quad\Longleftrightarrow\quad\mathrm{RH}.
 \tag{23}
$$
The final equivalence uses the classical functional symmetry and exclusion of zeros for Re s≥1. Equation (23) is an exact criterion, not its proof.

It is not equivalent to unrestricted causal BIBO stability. Such stability for the division inverse is already false: its unique locally finite causal impulse inverse is
$$
 \sum_{n\ge1}\frac{\mu(n)}{\sqrt n}\delta_{\log n},
$$
whose total variation is infinite. This follows from the elementary positive density of squarefree integers, or directly from its prime subseries. At any finite horizon one can choose a bounded measurable input with disjoint small neighborhoods of the finitely many shifted sample points, and signs matching these coefficients, so that the output reaches the corresponding partial variation. Hence no horizon-uniform L∞ operator norm exists. Independently, known critical-line zeta zeros give boundary poles of the inverse transfer. Absence of zeros in the *open* right half-plane does not remove those poles. The differentiated feedback factor H*D is itself not asserted bounded on L∞ by the L¹ norm of H.

The source's distinguished heat solution is different. With P(t)=ΣΛ(n)e^(−nt), P₀(t)=(1+t^(−1))e^(−t), and b(v)=e^(−v/2)[P(e^(−v))−P₀(e^(−v))], its Mellin transform initially satisfies
$$
 \int_0^\infty[P(t)-P_0(t)]t^{s-1}dt
 =\Gamma(s)\left[-\frac{\zeta'(s)}{\zeta(s)}-\frac{s}{s-1}\right],
 \quad\Re s>1.
 \tag{24}
$$
If b is bounded on v≥0, the left integral is holomorphic for Re s>1/2; a zeta zero there would give a nonremovable pole on the right, excluding such zeros. Conversely RH and the standard shifted Mellin explicit formula give bounded b: the nontrivial-zero series after critical normalization has coefficients −mρΓ(1/2+iγ), absolutely summable by Stirling and the ordinary zero count, and the remaining terms are bounded. Thus boundedness of this *specified arithmetic response* is indeed equivalent to RH. It is not a general BIBO theorem inferred from (23). The reference to equation (2) in the source's reverse proof of (24) should point to its Mellin formula (8).

The actual h=b−B1_[0,∞), B=−(1+γ_E)/2, also has a known nonzero negative-time history. For v≥0 a purely causal formulation must move
$\sum_{\log m>v}m^{-1/2}b(v-\log m)$
to the forcing and retain the initial jump of h. The global distributional convolution identities remain valid with this history where their tails converge. It is not legitimate to silently set that history to zero when applying (21).

## 7. Resonances are not literal exponential eigenfunctions of the causal operator

For a causal exponential h(v)=e^(zv)1_(v≥0), the exact continuous action is
$$
 (\mathcal Kh)(v)=\frac{e^{zv}-e^{v/2}}{z-1/2},
 \quad z\ne1/2.
 \tag{25}
$$
Thus replacing it by e^(zv)/(z−1/2) loses a boundary/volume term. Similarly the causal prime renewal evaluates a finite partial Dirichlet sum, not ζ(z+1/2)e^(zv). On the bilateral exponential, the defining positive division sum and continuous integral converge only for Re z>1/2. A hypothetical resonance with 0<Re z<1/2 is outside that original convergence domain.

Accordingly the source's (90) is valid as the analytically continued characteristic equation for a pole of the inverse response. It is not obtained by inserting a bare causal exponential as a literal homogeneous solution of (88). Its real/imaginary equations remain necessary spectral conditions after this distinction; a finite-horizon energy test must still retain the actual initial and memory boundary terms.

For example the local c term paired with h′ at exponential weight x has the exact real part
$$
 c\operatorname{Re}\int_0^T e^{-2xv}h\overline{h'}dv
 =\frac c2[e^{-2xT}|h(T)|²-|h(0+)|²]
   +cx\int_0^T e^{-2xv}|h|²dv.
$$
One cannot replace the finite causal memory expressions by their continued full Laplace symbols without proving the relevant boundary limit.

## 8. What is proved, and the first missing closure

The arithmetic identities (2), (8)–(19), positivity of J and of every cell increment, the positive step/arch decomposition, and the full extra strip from J−ℓ are valid closed lemmas. The first literal endpoint correction is the trace term in (6). The first substantive unproved inference toward an unconditional resonance exclusion is the source-specific coercive/contraction estimate requested after source (42), or equivalently its zero-exclusion target (48). Later formulas (77), (86), and (92) retain or re-express that missing phase condition; they do not prove it.

Positivity of a primitive is insufficient even before examining the actual oscillatory centered remainder. For any fixed 0<z₀<1/2 and k>0, the positive bounded function J_A(u)=A(1−e^(−ku)), with
$$
 A=\left[\frac1{1/2-z_0}-c\right]\frac{z_0+k}{kz_0}>0,
$$
satisfies c+(z₀−1/2)^(−1)+z₀²Jhat_A(z₀)=0. This is a counterexample only to the generic positivity implication, not to the exact arithmetic cell geometry. The actual additional constraint (17) also shows why centered-memory sign cannot supply the missing coercivity.

The closed lemmas supply genuine arithmetic structure for a further argument. No step above proves the unconditional right-half-plane exclusion, and no failure of a proposed sufficient estimate is equated with the existence of an unstable zero.

## Attribution and formal scope

The signed remainder proof uses the classical [hyperbolic cotangent partial-fraction formula](https://dlmf.nist.gov/4.36#E3), equivalently the sinh product, and the Laplace integral of a power. Mellin continuation and the RH heat criterion use the classical zeta explicit formula with its complete zero divisor. The present formulas retain the integer-cell endpoints and the actual renewal forcing. [PrimeStateAndRenewalArch.lean](../../formalization/BuildingBlocks/PrimeStateAndRenewalArch.lean) formalizes the elementary arch maximizer. The Euler remainder, positive net cell masses, decay strip, distributional identity and BIBO counterexample remain written mathematics.
