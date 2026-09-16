# Integer-carry heat work and its missing energy weight

The exact counting-cell carry gives an unconditional polynomial bound for a signed observable of the actual centered heat source. Its kinetic observable has an extra factor $e^{-v}$ and does not bound the original RH energy. An explicit growing-mode calculation below shows that even simultaneous, normalized bounds for every integer carry scale cannot alone close that gap.

## Exact primitive and linked scales

For integers $m\ge2$, use right-continuous fractional parts and define
$$
\xi_m(x)=\lfloor m\{x\}\rfloor-\frac{m-1}{2}
=m(\{x\}-1/2)-(\{mx\}-1/2).
$$
The floor law gives, including subcell endpoints,
$$
\xi_{mn}(x)=n\xi_m(x)+\xi_n(mx).
\tag{1}
$$
Write $r=\{x\}$ and $s=\{mx\}$. The continuous primitive which vanishes at every integer is
$$
\Xi_m(x)=-\frac m2r(1-r)+\frac1{2m}s(1-s).
\tag{2}
$$
On each open subcell its derivative is $mr-s-(m-1)/2=\xi_m(x)$. At a subcell boundary the second product vanishes from both sides, so (2) is continuous. At integers both products vanish. Thus (2) is exactly the integral of $\xi_m$ from the preceding integer, rather than a choice of an unrelated memory primitive.

At $x=N+j/m$, its value is $j(j-m)/(2m)$. It is linear between these endpoints, and consequently
$$
-m/8\le\Xi_m(x)\le0.
\tag{3}
$$
Integrating (1), with the constants fixed at integers, gives the linked primitive identity
$$
\Xi_{mn}(x)=n\Xi_m(x)+m^{-1}\Xi_n(mx).
\tag{4}
$$
In particular the normalized nonnegative primitives satisfy the uniform estimate
$$
0\le\frac12\{x\}(1-\{x\})-\frac{-\Xi_m(x)}m
=\frac{\{mx\}(1-\{mx\})}{2m^2}\le\frac1{8m^2}.
\tag{5}
$$
The complete family therefore has a common normalized limit; its scales are not independent positive kernels.

## Actual complete heat response and finite work

Use precisely the source in the [critical heat criterion](critical-heat-lyapunov-exponent.md):
$$
P(t)=\sum_{n\ge1}\Lambda(n)e^{-nt},\quad
P_0(t)=(1+t^{-1})e^{-t},\quad
b(v)=e^{-v/2}[P(e^{-v})-P_0(e^{-v})].
$$
All prime powers, the baseline atom and the continuum density remain. For $T\ge0$ set
$$
I_m(T)=\int_1^{e^T}\xi_m(x)|b(\log x)|^2\frac{dx}{x},\qquad
S_m(T)=\int_0^T[-\Xi_m(e^v)]e^{-v}|b'(v)|^2\,dv.
$$
The continuous, piecewise linear primitive gives ordinary integration by parts across every subcell:
$$
I_m(T)=\Xi_m(e^T)e^{-T}|b(T)|^2
-\int_0^T\Xi_m(e^v)e^{-v}
[2\operatorname{Re}(b(v)\overline{b'(v)})-|b(v)|^2]\,dv.
\tag{6}
$$
The initial boundary is zero since $\Xi_m(1)=0$. Internal endpoints cancel by continuity. The displayed terminal term remains at fractional $e^T$; it vanishes when $e^T$ is an integer. No sign of the actual cross term has been assumed.

## Elementary global bounds without PNT

Put $t=e^{-v}$, $v\ge0$. The actual coefficient inequality $0\le\Lambda(n)\le\log n$, together with $\log(nt)\le nt$, gives $\Lambda(n)\le v+nt$. The positive exponential sums obey
$$
\sum_{n\ge1}e^{-nt}\le t^{-1},\quad
\sum_{n\ge1}ne^{-nt}\le t^{-2},\quad
\sum_{n\ge1}n^2e^{-nt}\le5t^{-3}\qquad(0<t\le1).
$$
The first follows from $e^t-1\ge t$. The second is $[4\sinh^2(t/2)]^{-1}\le t^{-2}$. For the third, on $[n-1,n]$ the function $(x+1)^2e^{-tx}$ is at least $n^2e^{-nt}$ pointwise. Summation and integration give $2t^{-3}+2t^{-2}+t^{-1}\le5t^{-3}$.

Positive summation now yields
$$
P(t)\le(v+1)/t,\qquad -P'(t)\le(v+5)/t^2.
$$
For any compact interval with $t\ge a>0$, every differentiated summand is bounded by $n^{j+1}e^{-an}$ for the appropriate derivative order $j$, using $\Lambda(n)\le n$. The polynomial-geometric majorants are summable, so normal convergence justifies the derivative. Also $P_0(t)\le2/t$ and $|P_0'(t)|\le3/t^2$. For the latter, the exact derivative magnitude is $e^{-t}(1+t^{-1}+t^{-2})$. The chain rule gives
$$
b'(v)=-\tfrac12\sqrt t[P(t)-P_0(t)]
-\sqrt t\,t[P'(t)-P_0'(t)],
$$
and hence
$$
|b(v)|\le(v+3)e^{v/2},\qquad |b'(v)|\le2(v+5)e^{v/2}.
\tag{7}
$$
These are coarse source estimates, with no RH premise. Using (3), (6) and (7), for every $T\ge0$ and $m\ge2$,
$$
0\le S_m(T)\le\frac m6[(T+5)^3-125],
\tag{8}
$$
$$
|I_m(T)|\le\frac m8[(T+3)^2+\tfrac53T^3+19T^2+69T].
\tag{9}
$$
Indeed the kinetic integrand is at most $(m/8)4(v+5)^2$. The absolute cross-term integrand is at most $(m/8)[4(v+3)(v+5)+(v+3)^2]=(m/8)(5v^2+38v+69)$. Integrate and retain the terminal bound $(m/8)(T+3)^2$. At integer $e^T$ this last term can be removed.

Thus exact successor-cell resets improve a direct absolute carry-work estimate, which would cost a multiple of the coarse exponentially growing heat energy. They do so for a signed, weighted observable, rather than proving the unknown original energy bound.

## Growing modes pass all these carry tests

This paragraph tests the observables, not the actual arithmetic renewal equation. Take
$$
b_z(v)=e^{(\alpha+i\gamma)v},\qquad 0<\alpha<1/2,\quad \gamma\in\mathbb R,
\quad k=1-2\alpha>0.
$$
Its full unweighted energy grows exponentially:
$$
\mathscr A_z(T)=1+\frac{e^{2\alpha T}-1}{2\alpha}.
\tag{10}
$$
Nevertheless (6) is valid for this smooth test and reduces exactly to
$$
I_{m,z}(T)=\Xi_m(e^T)e^{-kT}
+k\int_0^T\Xi_m(e^v)e^{-kv}\,dv.
$$
Both terms are nonpositive, and (3) gives, for every horizon and every integer scale,
$$
-m/8\le I_{m,z}(T)\le0,\qquad
0\le S_{m,z}(T)\le\frac{m(\alpha^2+\gamma^2)}{8k}.
\tag{11}
$$
The first bound uses $e^{-kT}+k\int_0^T e^{-kv}dv=1$. The second uses $|b_z'|^2=(\alpha^2+\gamma^2)e^{2\alpha v}$. These bounds are uniform in $T$, and after division by $m$ also uniform in every carry scale. The work has a finite nonpositive limit. Even its sufficient monotonic-density condition holds: $|b_z(\log x)|^2/x=x^{-k}$ decreases.

For a potential zero with $1/2<\beta<1$, the corresponding growth exponent $\alpha=\beta-1/2$ lies exactly in this range. This does not insert that mode as a homogeneous solution of the causal renewal system: finite partial division sums, earlier-time forcing and initial traces still matter, as the [Euler-discrepancy audit](prime-division-euler-discrepancy.md#7-resonances-are-not-literal-exponential-eigenfunctions-of-the-causal-operator) explains. It proves only that the carry observables and their bounds alone cannot force zero growth for arbitrary smooth profiles. No counterexample to an actual arithmetic estimate or RH is asserted.

The missing step must use the actual simultaneous renewal/source relation to recover unweighted energy or another RH-strength consumer. A positive sum of the individual carry costs is not such a proof. Nor can uniform normalized carry bounds alone supply that recovery, since (10)--(11) already satisfy them with positive exponential growth.

## Attribution and formal status

The floor identities, unit-cell primitives and exponential sums are classical. RH Agent2 supplied the actual heat polynomial work estimate; the root review checks the source, constants, signs and endpoints and adds (2), (4), (5) and the explicit growing-mode limitation (10)--(11). These are reviewed written proofs, not compiled Lean theorems. The carry/fractional-part geometry, full heat differentiation, integration by parts and energy inequalities remain formalization obligations. No novelty claim or unconditional RH conclusion is made.

[Formal integer-carry phase algebra](BuildingBlocks/IntegerCarryPhase.lean) proves seven unconditional theorems for the literal fractional-part functions. It identifies the natural-number phase with the actual floor carry, proves the phase and closed-form multiplication laws, the unit polynomial bounds, zero values of the closed formula at integer counting endpoints, and the uniform normalized error bound 1/(8r²) for every positive real scale. The integral identification and analytic properties are proved in the companion modules. The complete heat-work and compensation estimates remain further Lean obligations. These standard algebraic identities supply no RH sign bound.

[Formal carry primitive analysis](BuildingBlocks/IntegerCarryPrimitiveAnalytic.lean) proves five unconditional theorems: global continuity of the literal unit fractional-part polynomial and of the closed carry formula, derivative one for fractional parts away from integers, the unit polynomial derivative B₁, and the closed formula derivative equal to the literal phase away from integer and dilated-integer corners. The continuity proof retains the corner limits through equal polynomial values at 0 and 1. The complete heat-work estimates remain separate Lean obligations; no RH bound follows.

[Formal carry primitive integration](BuildingBlocks/IntegerCarryPrimitiveIntegral.lean) proves seven unconditional theorems. It establishes bounded interval integrability of the complete phase, right derivatives of the fractional part and unit polynomial at every real point, and the right derivative of the carry formula at every point for positive real scale. The fundamental theorem of calculus then gives the full oriented interval identity with both endpoints, crossing every corner. For a positive integer scale, the integral from 1 equals the closed formula because its initial value is proved zero. The real-scale initial trace is retained; full heat-work and compensation estimates remain further Lean obligations. No RH bound follows.

[Formal integer carry primitive bounds](BuildingBlocks/IntegerCarryPrimitiveBounds.lean) proves six unconditional theorems. The actual integer subcell products give nonpositivity at every real counting endpoint and the bound -m/8≤Ξ_m≤0 for every positive integer scale, including fractional terminal cells. The bound is also proved for the actual phase integral from 1. A positive-real lower bound and the exact formula value Ξ_(3/2)(1)=1/12 distinguish the continuum phase extension: it does not inherit integer zero initial trace or formula nonpositivity. The full heat-work and compensated arithmetic energy estimates remain further Lean obligations, and no RH bound follows.

[Formal weighted carry integration](BuildingBlocks/IntegerCarryIntegrationByParts.lean) proves five theorems for the literal carry phase. The local integration-by-parts theorem assumes continuity of the weight and its derivative on the closed observation interval and the stated derivative on its interior; it proves the exact weighted integral through every corner with both endpoint terms. A C¹ specialization and the initial formula value give the real-dilation trace +U(r)g(1)/r and its proved vanishing for positive integer scales. These explicit weight-regularity hypotheses have not yet been established in Lean for the actual heat-energy weight. Its source derivative, global polynomial work bound and full compensated energy estimates remain obligations; no RH bound follows.

[Formal complete prime heat derivative](BuildingBlocks/GoldbachHeatDerivative.lean) proves five unconditional theorems: each actual von Mangoldt heat summand has the stated derivative, the complete derivative terms have a summable quadratic-exponential bound, their series converges at every positive time and is continuous on every positive lower-cutoff interval, and the derivative of the existing primeHeat is exactly that complete series. Every prime power remains. The mixed atom-and-density source and logarithmic-profile derivative chain, heat-weight regularity, global polynomial carry-work bound and RH energy estimate remain further obligations.

[Formal centered heat and profile derivatives](BuildingBlocks/GoldbachHeatProfileDerivative.lean) connects the complete prime-power derivative to the existing mixed atom-and-density centered source and its literal logarithmic-time profile. Two additional theorems in [the heat derivative module](BuildingBlocks/GoldbachHeatDerivative.lean) prove the exact centered derivative, retaining the baseline correction, and its continuity on positive cutoff intervals. Three profile theorems prove the exact derivative at every real logarithmic time, continuity of the profile there, and global continuity of its derivative. These are regularity prerequisites for the actual weighted carry integral; the polynomial work estimates and RH energy bound remain unproved in Lean.
