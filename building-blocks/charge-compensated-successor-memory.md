# The charge-compensated successor memory maps the actual source space to L¹

This written proof constructs the full compensated response on the actual mixed source completion. It preserves both initial-strip terms and every prime power. The maximal-shift input is proved in the [seed translation theorem](successor-seed-maximal-translation.md); the completed-source estimates remain written proofs. The finite-prime $L^2$ column identity and its original-reference correction have the formal scope recorded below.

Let $\mathcal H_+=L^2([0,\infty),du)$, let $\mathcal Wf(x)=x^{-1/2}f(\log x)$, and use the actual causal successor
$$
(Sf)(v)=j(v)f(\sigma(v)),\quad
j(v)=\sqrt{\frac{e^v}{1+e^v}},\quad
\sigma(v)=\log(1+e^v),\quad v\ge0.
$$
Write $\ell_0=\log2$, and define the exact relative-charge kernel
$$
k(u)=
\begin{cases}
-1,&0\le u<\ell_0,\\
(1-e^{-u})^{-1/2}-1,&u\ge\ell_0.
\end{cases}
\qquad
\delta(f)=\frac12\int_0^\infty k(u)f(u)\,du.
\tag{1}
$$
For integrable causal $f$, this is $Q(Sf)-Q(f)$, where $Q(f)=\frac12\int f$. Let
$$
a_0(v)=e^{-v/2}1_{\{v\ge0\}},\qquad C=S-a_0\delta.
\tag{2}
$$
Thus $C$ preserves the finite source charge exactly.

Use the complete actual prime profiles $B=\sum_pB_p$ and $B_P=\sum_{p\le P}B_p$, with
$$
B_p(v)=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}1_{\{v\ge\log p\}}.
$$
For $F=B$ or $B_P$, put $K_Ff=F*f$ and
$$
q_F=K_Fa_0.
\tag{3}
$$
Here $q_F$ denotes the convolution with $a_0$, not the different remainder $B-b_*$ used in the reference-tail decomposition.

The source space $\mathcal E_c$ is the causal additive completion with norm
$$
\|H\|_{\mathcal E}^2
=\int_0^1\|\tau_hH-H\|_2^2dh
+\int_1^\infty\|\tau_hH-H\|_2^2\frac{dh}{h^2}.
$$
The output space in this note is ordinary physical $L^1(dv)$.

**Theorem.** The literal core commutators
$[C,K_F]\mathcal W^{-1}$ extend to bounded maps
$$
\mathcal T_F:\mathcal E_c\longrightarrow L^1([0,\infty),dv),
$$
uniformly in $P$, including $F=B$. Moreover
$$
\boxed{\displaystyle
\|\mathcal T_B-\mathcal T_{B_P}\|_{\mathcal E_c\to L^1}
\le C\,\frac{\log(2+\log\log P)}{\sqrt{\log P}}
\quad(P\ \text{sufficiently large}).}
\tag{4}
$$
The proof retains the charge correction and the initial interval. It uses maximal translation bounds for the actual $B_P$, not a fixed-shift estimate applied to an arbitrary variable shift.

## The precise completed-profile inputs

The complete and partial profiles satisfy, uniformly in $P$,
$$
F=0\text{ below }\ell_0,\qquad 0\le F(v)\le B(v)\le C/(1+v).
\tag{5}
$$
The [maximal-translation theorem](successor-seed-maximal-translation.md), sections 1–5, supplies the global maximal bounds for these actual profiles:
$$
\int_{\mathbb R}\sup_{0\le r\le h}|F(v+r)-F(v)|\,dv
\le Ch[1+\log\log(1/h)]\quad(0<h\le e^{-1}),
\tag{6}
$$
with a uniform finite bound for $h\le1$, and
$$
\|R_LF-F\|_1\le C\log(2+L)\quad(L\ge0).
\tag{7}
$$
For $D_P=B-B_P$, it also gives
$$
D_P=0\text{ below }\log P,\quad
\|D_P\|_\infty\le C/\log P,\quad
\int_{\mathbb R}\sup_{0\le r\le1}
|D_P(v+r)-D_P(v)|\,dv\le C/\log P.
\tag{8}
$$
All functions here are extended causally by zero, and $R_LF(v)=F(v-L)$.

These inputs include the cutoff endpoint strip $[\log P-1,\log P]$. Their finite-$P$ mechanism is the truncated smooth first-sector model
$$
b_P(v)=e^{v/2}
\int_{e^{v/2}}^{\min(e^v,P)}
\frac{dx}{x^2\log x},
$$
defined as zero when the upper endpoint is at most the lower endpoint. This model is nonnegative, decreasing on $v>0$, and $b_P(v)\le C/(1+v)$. For example the untruncated model satisfies
$$
b'(v)=\tfrac12b(v)+(e^{-v/2}-1)/v\le0,
\qquad b(v)\le2(1-e^{-v/2})/v;
$$
on the middle truncated interval its derivative is $b_P(v)/2-1/v\le0$.
The cited proof uses an equivalent smooth initial-age cutoff, which changes only uniformly bounded compact-age terms. Quantitative PNT, including the cutoff endpoint, gives
$|B_P-b_P|\le Ce^{-c\sqrt v}$ for $v\ge3$, uniformly in $P$; all higher floor sectors are exponentially small on this scale. Local variation through age $V$ is $O(\log(2+V))$, by the exact identity
$\operatorname{TV}(B_p)=2/p+2/p^{3/2}$.
Splitting at $V\asymp\log^2(1/h)$ proves (6). Monotonicity of the model gives (7). For (8), the difference of the two smooth models vanishes below $\log P$ and has tail variation $O(1/\log P)$; its remaining error has integral
$O((1+\sqrt{\log P})e^{-c\sqrt{\log P}})$.
This explains why (6)--(8) hold for every finite partial prime cutoff, as required here.

The same maximal bounds hold for backward shifts, up to an absolute factor. Indeed, after a change of variable, a backward maximal difference of length $h$ is bounded by twice the forward maximal difference of length $h$.

## Exponential smoothing and the rank-one charge term

By (3),
$$
\frac{q_F}{2}-F
=\frac12\int_0^\infty e^{-w/2}(R_wF-F)\,dw
\quad\text{in }L^1.
\tag{9}
$$
Equation (7) proves absolute convergence and a bound uniform in $P$.
For $D=D_P$, telescoping unit shifts in (8) gives the sharper estimate
$$
\left\|\frac{D*a_0}{2}-D\right\|_1\le C/\log P.
\tag{10}
$$
No integrability of $B$ or $D$ itself is used.

For a compact causal input, Fubini in the relative charge gives
$$
\delta(K_Ff)=\int_0^\infty d_F(u)f(u)\,du,\qquad
d_F(u)=\frac12\int_0^\infty k(u+w)F(w)\,dw.
\tag{11}
$$
Since $F$ vanishes below $\ell_0$, only the nonnegative part of $k$ is sampled in this integral, even when $u<\ell_0$. Therefore
$$
0\le d_F(u)\le Ce^{-u},\qquad
0\le d_{D_P}(u)\le Ce^{-u}/\log P.
\tag{12}
$$
These are genuine absolutely convergent integrals. In particular, the rank-one term $-a_0\delta K_F$ has physical $L^1$ column norm $2d_F(u)$.

## The exact corrected kernel, including the initial interval

Changing variables in the second convolution gives the exact literal successor kernel
$$
\mathcal K_F(v,u)=
j(v)F(\sigma(v)-u)
-1_{\{u\ge\ell_0\}}A(u)F(v-\ell(u)),
$$
$$
\ell(u)=\log(e^u-1),\qquad A(u)=(1-e^{-u})^{-1/2}.
$$
The exact algebra
$$
[C,K_F]=[S,K_F]-a_0\delta K_F+q_F\delta
$$
therefore gives the full kernel
$$
\boxed{\displaystyle
\mathcal T_F(v,u)=
\mathcal K_F(v,u)+\frac12q_F(v)k(u)-a_0(v)d_F(u).}
\tag{13}
$$
On smooth compact causal inputs every term is well defined in physical $L^2$. For the full $B$, use $B\in L^2$, the $L^1$ input, and the bounded $L^2$ charge functional. The estimates below prove that their sum is in $L^1$.

For $u\ge\ell_0$, the first two terms of (13), before the rank-one term, split exactly as
$$
\begin{aligned}
&(j(v)-1)F(\sigma(v)-u)\\
&+[F(\sigma(v)-u)-F(v-\ell(u))]\\
&+(A(u)-1)[q_F(v)/2-F(v-\ell(u))].
\end{aligned}
\tag{14}
$$
The first line has $L^1_v$ norm $O(e^{-u})$, since its nonzero support requires $v\ge u$, $|j(v)-1|\le Ce^{-v}$, and $F$ is uniformly bounded.

The difference in the second line also vanishes for $v<u$. On its support, set
$$
\eta=u-\ell(u)=-\log(1-e^{-u}),\qquad
\epsilon(v)=\sigma(v)-v.
$$
Then $0\le\epsilon(v)\le e^{-u}\le\eta\le2e^{-u}$, and the two arguments differ by the backward displacement $\eta-\epsilon(v)$. The maximal bound (6), with the bounded-shift version on the remaining compact $u$-interval, gives
$$
\int_0^\infty|F(\sigma(v)-u)-F(v-\ell(u))|dv
\le Ce^{-u}\log(2+u).
\tag{15}
$$
For the third line use (9), (7), $\ell(u)\le u$, and $A(u)-1\le Ce^{-u}$. Its norm has the same bound.

For $0\le u<\ell_0$, the first two terms of (13) are instead
$$
j(v)F(\sigma(v)-u)-q_F(v)/2.
\tag{16}
$$
To estimate this initial column, add and subtract $F(v-u)$ and $F(v)$. The resulting terms are
$$
(j(v)-1)F(\sigma(v)-u),\quad
F(\sigma(v)-u)-F(v-u),\quad
F(v-u)-F(v),\quad F(v)-q_F(v)/2.
$$
The first is integrable by the exponential scalar weight. The next two are bounded by the fixed maximal shift bound of length at most $\ell_0$, and the last is bounded by (9). Their $L^1$ norms are uniform for this entire initial interval. In particular, the term $-q_F/2$ in (16) cannot be discarded.

Finally include (12). Increasing the constant to cover $u<\ell_0$, the complete kernel satisfies
$$
\boxed{\displaystyle
\|\mathcal T_F(\,\cdot,u)\|_{L^1_v}
\le Ce^{-u}\log(2+u)\quad(u\ge0),}
\tag{17}
$$
uniformly for $B$ and all $B_P$.

## Weighted coercivity and the bounded extension

For causal additive $H$, the portion $x<1$ of a translation difference gives
$$
\|\tau_hH-H\|_2^2\ge\int_1^{1+h}|H(y)|^2dy.
$$
Integrating over $h\ge1$ with weight $h^{-2}$ and using Tonelli proves
$$
\int_1^\infty\frac{|H(x)|^2}{x}\,dx\le\|H\|_{\mathcal E}^2.
\tag{18}
$$
Indeed the exact weight furnished by this integration is $1/\max(1,x-1)$, which is at least $1/x$. An energy-Cauchy sequence is therefore Cauchy in $L^2(dx/x)$ and has a unique local $L^2$ function limit. Its translation differences converge in the product $L^2$ space defining the energy, and agree locally with the differences of that function limit. Thus the causal completion has the same anchored representative and the bound extends to it, without an unidentified constant mode. Equivalently, for the physical representative $f=\mathcal W^{-1}H$,
$$
\|e^{-u/2}f(u)\|_2\le\|H\|_{\mathcal E}.
$$
Thus (17) and Cauchy--Schwarz give an absolutely convergent $L^1_v$-valued source integral and the bound
$$
\left\|\int_0^\infty\mathcal T_F(\,\cdot,u)f(u)du\right\|_1
\le
\left(\int_0^\infty e^u
\|\mathcal T_F(\,\cdot,u)\|_1^2du\right)^{1/2}
\|H\|_{\mathcal E}
\le C\|H\|_{\mathcal E}.
\tag{19}
$$
This proves the bounded extension. It is a source-column integral, not a formal interchange with the divergent first age moment $\int B$.

## Prime-cutoff convergence in operator norm

The kernel is linear in $F$. Apply the decompositions (14) and (16) to $D=D_P$.
By (8), every bounded variable shift has $L^1$ error at most $C/\log P$.
For the possibly large fixed shift $\ell(u)$, unit-shift telescoping gives
$$
\|R_{\ell(u)}D-D\|_1\le C(1+u)/\log P.
$$
Its factor $A(u)-1\le Ce^{-u}$ makes this uniformly $O(1/\log P)$.
The scalar term uses $\|D\|_\infty\le C/\log P$, the smoothed term uses (10), and the rank-one term uses (12). Therefore
$$
\|\mathcal T_B(\,\cdot,u)-\mathcal T_{B_P}(\,\cdot,u)\|_1
\le C/\log P\quad\text{for every }u\ge0.
\tag{20}
$$
It also satisfies twice the exterior bound (17).
Writing $M=\log P$, split the weighted column integral in (19) at $R=\log M$. Equations (17) and (20) bound its square by
$$
C\frac{e^R}{M^2}
+C\int_R^\infty e^{-u}\log^2(2+u)\,du
\le \frac C M\,[1+\log^2(2+\log M)].
$$
Taking square roots proves (4). This controls actual prime cutoffs including every proper power, uniformly on the whole source unit ball.

## Joint natural-source and prime limits

Let
$$
g(x)=1_{\{x\ge1\}}\frac{\psi(x)-x}{x},\qquad
a(u)=e^{-u/2}[\psi(e^u)-e^u],
$$
and use the actual natural cutoff
$$
g_N(x)=1_{\{x\ge1\}}
\frac{\psi(\min(x,N))-\min(x,N)}x,\qquad a_N=\mathcal W^{-1}g_N.
$$
The [natural-cutoff theorem](natural-arrival-cutoff-completion.md) gives
$\sup_N\|g_N\|_{\mathcal E}<\infty$ and $g_N\to g$ in $\mathcal E_c$.
For the full kernel a stronger source-tail rate follows directly. Put $T=\log N$. The sources agree through age $T$, while
$$
|a(u)|\le Ce^{u/2-c\sqrt u},\qquad
|a_N(u)|\le Ce^{T-u/2-c\sqrt T}\quad(u\ge T)
$$
by the unconditional quantitative PNT. Multiplying these by (17) and integrating proves
$$
\|\mathcal T_Bg_N-\mathcal T_Bg\|_1
\le C N^{-1/2}\log(2+\log N)e^{-c\sqrt{\log N}}.
\tag{21}
$$
Combining (4) with the uniform source norm yields
$$
\boxed{\displaystyle
\|\mathcal T_{B_P}g_N-\mathcal T_Bg\|_1
\le
C\frac{\log(2+\log\log P)}{\sqrt{\log P}}
+C N^{-1/2}\log(2+\log N)e^{-c\sqrt{\log N}}.}
\tag{22}
$$
This is a joint prime/source-cutoff limit with no order restriction.

The [finite-source conservation proof](compensated-memory-integral-conservation.md) shows that the integral of the full compensated commutator is exactly zero on the core. The bounded extension (19) therefore preserves that zero integral on every $\mathcal E_c$ source, including $g$; integration is continuous on the physical $L^1$ output. This transfers the already proved conservation identity rather than assuming it from passivity.

The theorem does not differentiate $B$, estimate the original anticausal response, or produce a sign for a Weil form. It proves a bounded charge-compensated successor response on the actual completed source space, retaining the initial correction and the full memory.


## Formalized finite-prime memory domains

[SuccessorMemoryKernel](BuildingBlocks/SuccessorMemoryKernel.lean) defines the literal causal memory

$$
K_Ff(v)=\int_0^\infty F(v-u)f(u)du
$$

and the column

$$
M_F(v,u)=j(v)F(\sigma(v)-u)
-\mathbf1_{u>\log2}(1-e^{-u})^{-1/2}
 F\bigl(v-\log(e^u-1)\bigr).
$$

For measurable real $F\in L^2(\mathbb R)$ and real $f\in L^2(0,\infty)$, `successor_memory_commutator` proves pointwise

$$
SK_Ff(v)-K_FSf(v)=\int_0^\infty M_F(v,u)f(u)du.
$$

Both column pairings are proved absolutely integrable. The predecessor term is zero on the complete initial interval $u\le\log2$; no delay of $F$ is cut off.

[PrimeSeedMemory](BuildingBlocks/PrimeSeedMemory.lean) proves `finitePrimeSeed_memLp_two` from the existing exact integral $\int B_p^2=p^{-2}$. The theorem `finitePrimeSeed_memory_commutator` therefore applies to the actual $F=\sum_{p\in S}B_p$ for every finite set of primes, retaining all powers of each prime. No analytic assumption on this finite seed is left as a premise. There is no uniform-in-$S$ norm estimate in this module.

[SuccessorCompensatedL2](BuildingBlocks/SuccessorCompensatedL2.lean) proves $a_0,k\in L^2(0,\infty)$, absolute existence of $\delta(f)$ for $L^2$ inputs, and preservation of measurable half-line $L^2$ by $C$. Its `compensated_adjoint` identifies the literal adjoint

$$
C^*f=P f-\frac12\left(\int_0^\infty a_0(v)f(v)dv\right)k,
$$

where $P$ is the predecessor with its zero initial interval. The original exponential reference is retained; no distributional endpoint derivative is asserted here.

[CompensatedMemoryKernel](BuildingBlocks/CompensatedMemoryKernel.lean) proves

$$
|K_Ff(v)|\le\|F\|_2\|f\|_{L^2(0,\infty)}
$$

and absolute integrability of $k(v)K_Ff(v)$ for measurable such inputs. Thus the last relative charge in the exact formula

$$
[C,K_F]f=[S,K_F]f+(K_Fa_0)\delta(f)-a_0\delta(K_Ff)
$$

exists without assuming that $K_Ff$ has a finite total integral. The theorem `finitePrimeSeed_compensated_memory_commutator` specializes this identity to every finite set of complete prime profiles. Both rank corrections remain present.

All four module targets built successfully. Their checked primary theorems depend only on `propext`, `Classical.choice` and `Quot.sound`. The later sections formalize the transposed charge column and all-prime $L^2$ kernel. The mixed-source-to-$L^1$ extension and its quantitative joint limit remain written. In particular, the formal $L^2$ input domain does not assert that the uncut actual critical source lies in unweighted $L^2$.


## Formalized transposed charge and complete corrected kernel

[MemoryChargeFubini](BuildingBlocks/MemoryChargeFubini.lean) proves absolute product integrability before interchanging the actual charge and memory integrals. For measurable real $F\in L^2(\mathbb R)$ and $f\in L^2(0,\infty)$, `defect_causalMemory` gives

$$
d_F(u)=\frac12\int_0^\infty k(v)F(v-u)dv,
\qquad
\delta(K_Ff)=\int_0^\infty d_F(u)f(u)du.
$$

The product on the right is proved integrable. If $F$ is zero almost everywhere on negative ages, `memoryDefectKernel_causal` proves, for every $u\ge0$,

$$
d_F(u)=\frac12\int_0^\infty k(u+w)F(w)dw.
$$

The theorem `corrected_memory_kernel_identity` retains the complete column

$$
\widetilde M_F(v,u)
=M_F(v,u)+\frac{(K_Fa_0)(v)}2k(u)-a_0(v)d_F(u),
\qquad
[C,K_F]f(v)=\int_0^\infty\widetilde M_F(v,u)f(u)du.
$$

Its actual specialization `finitePrimeSeed_corrected_kernel_identity` assumes only a finite prime set, measurable real $f$, and its half-line $L^2$ membership. The complete prime profiles satisfy every kernel premise by the already formal exact square integrals. The original exponential reference, predecessor initial interval and both rank terms remain in the formula.

The affected target and aggregate build passed. The checked primary theorems use only `propext`, `Classical.choice` and `Quot.sound`. The following all-prime specialization extends this $L^2$ Fubini theorem; the quantitative mixed-source completion above remains a separate written result.

## Formalized all-prime memory and cutoff convergence

The [all-prime square bound](positive-successor-seed-jump-process.md#formalized-all-prime-square-integrability) proves $B\in L^2(\mathbb R)$ from unconditional Chebyshev bounds and actual finite activity. [AllPrimeMemoryKernel](BuildingBlocks/AllPrimeMemoryKernel.lean) then substitutes the literal complete seed in the earlier absolute Fubini and corrected-column theorem. For measurable real $f\in L^2(0,\infty)$ it proves absolute existence of $\delta(K_Bf)$, the transposed identity and the full pointwise formula

$$
\delta(K_Bf)=\int_0^\infty d_B(u)f(u)du,
\qquad
d_B(u)=\frac12\int_0^\infty k(u+w)B(w)dw\quad(u\ge0),
$$
$$
[C,K_B]f(v)=\int_0^\infty\left[M_B(v,u)
+\frac{(K_Ba_0)(v)}2k(u)-a_0(v)d_B(u)\right]f(u)du.
$$

The declarations are `allPrimeSeed_memory_defect_integrable`, `allPrimeSeed_defect_causalMemory`, `allPrimeSeed_defectKernel_causal` and `allPrimeSeed_corrected_kernel_identity`, in namespace `BuildingBlocks.PrimeSeedMass`. No analytic premise on $B$ is assumed. The original exponential reference, initial predecessor interval and both rank corrections remain.

[PrimeSeedSquareConvergence](BuildingBlocks/PrimeSeedSquareConvergence.lean) uses the strict cutoff $B_{<P}=\sum_{p<P}B_p$. At each age this equals $B$ for every sufficiently large cutoff. Positivity gives $(B-B_{<P})^2\le B^2$, so dominated convergence proves `cutoff_seed_square_error_tendsto`:

$$
\int_{\mathbb R}(B-B_{<P})^2\longrightarrow0.
$$

For every half-line $L^2$ input, the same module proves

$$
\sup_{v\in\mathbb R}|K_Bf(v)-K_{B_{<P}}f(v)|
\le\|B-B_{<P}\|_2\|f\|_{L^2(0,\infty)}.
$$

The theorem `cutoff_memory_uniform_unit_ball` has the full uniform quantifiers over every output age and every input in that unit ball. It gives qualitative convergence, without an asserted numerical rate. This is convergence of the original memory output, not a theorem about the stronger mixed-energy input domain or the derivative distribution.

The module targets and changed aggregate compile with the pinned versions. The checked primary targets use only `propext`, `Classical.choice` and `Quot.sound`. The $\mathcal E_c\to L^1$ extension, its arithmetic source membership and joint quantitative estimate (22) remain written proofs.

## Formalized decaying charge on the finite-energy domain

[PrimeMemoryChargeDecay](BuildingBlocks/PrimeMemoryChargeDecay.lean) proves that the actual seed vanishes below $\log2$, where the relative-charge kernel can be negative. Since $k(u+w)\ge0$ for $u\ge0$ and $w\ge\log2$, the transposed charge is nonnegative. Its exponential estimate is

$$
0\le d_B(u)\le e^{-u}J_B\quad(u\ge0),\qquad
J_B=\int_0^\infty e^{-w}B(w)dw<\infty.
$$

The declaration `allPrimeSeed_defectKernel_nonneg_decay` uses the literal activation threshold and $|k(v)|\le2e^{-v}$, with the factor $1/2$ in $d_B$ retained. The finite constant follows from $B\in L^2$ and the exponential weight.

[MemoryChargeEnergy](BuildingBlocks/MemoryChargeEnergy.lean) proves directly that the product $d_Bf$ is integrable whenever $f$ is measurable and $e^{-u/2}f(u)\in L^2(0,\infty)$, with

$$
\left|\int_0^\infty d_B(u)f(u)du\right|
\le J_B\left(\int_0^\infty e^{-u}|f(u)|^2du\right)^{1/2}.
$$

For measurable real $H$ vanishing almost everywhere below $1$, put $f(u)=e^{u/2}H(e^u)$. If $\mathcal E(H)<\infty$, the formal [causal energy anchor](actual-source-mixed-dirichlet-completion.md#formalized-causal-energy-anchor) supplies the weighted integral. Thus `allPrimeSeed_memory_charge_bound_energy` and `allPrimeSeed_memory_charge_rank_bound` give

$$
\left|\int_0^\infty d_B(u)f(u)du\right|\le J_B\sqrt{\mathcal E(H)},
\qquad
\left\|a_0\int_0^\infty d_Bf\right\|_{L^1(0,\infty)}
\le2J_B\sqrt{\mathcal E(H)}.
$$

These are direct relative-kernel functionals. They do not assume $f\in L^1$ or unweighted $L^2$, or identify an undefined absolute source charge. The earlier equality with $\delta(K_Bf)$ retains its separate $L^2$ hypotheses. The theorem formalizes this full-prime rank-one part of the energy-to-$L^1$ response; the complete commutator extension and endpoint derivative remain outside these modules.

Both targets and the changed aggregate compile with the pinned versions. Their checked primary declarations use only `propext`, `Classical.choice` and `Quot.sound`.

## Formalized quantitative cutoff for the rank charge

[MemoryChargeCutoff](BuildingBlocks/MemoryChargeCutoff.lean) retains the literal remainder $R_P=B-B_{<P}\ge0$, with $B_{<P}=\sum_{p<P}B_p$. It vanishes for $v<\log P$. For natural $P\ge8$, the earlier Chebyshev bound $vB(v)\le C_0:=64\log2+30$ therefore gives

$$
\int_0^\infty e^{-w}R_P(w)dw\le\frac{C_0}{P\log P},
\qquad
0\le d_B(u)-d_{B_{<P}}(u)\le\frac{C_0e^{-u}}{P\log P}
\quad(u\ge0).
$$

These are `exponential_remainder_mass_bound` and `remainder_defectKernel_bound`, together with the proved linearity `remainder_defectKernel_identity`. The age endpoint $\log P$ is omitted only as a Lebesgue-null singleton in an integral; every power of every admitted prime remains.

For measurable causal $H$ of finite mixed energy, let $f(u)=e^{u/2}H(e^u)$. The direct difference functional is absolutely convergent, and `cutoff_memory_charge_rank_error` proves

$$
\left\|a_0\int_0^\infty[d_B(u)-d_{B_{<P}}(u)]f(u)du\right\|_{L^1(0,\infty)}
\le\frac{2C_0}{P\log P}\sqrt{\mathcal E(H)}.
$$

The module and changed aggregate compile; the checked primary targets use only `propext`, `Classical.choice` and `Quot.sound`. This quantitative rate concerns the rank charge term. It uses no PNT or RH assumption, and does not give the same rate for the complete compensated commutator.
