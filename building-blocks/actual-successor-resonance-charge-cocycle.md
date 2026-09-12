# Actual successor creates a finite positive resonance port

These are written proofs for the [exact causal successor](fixed-observation-prime-heat.md#10-the-exact-successor-does-not-preserve-the-improved-heat-domain), with the initial removed interval and every prime-power birth retained. The [positive seed process](positive-successor-seed-jump-process.md) gives a compatible comparison evolution. The integrable half-line charge and compensation identities are formalized below. The finite mixed-energy relative-charge bound is also formalized. Actual-source membership, arithmetic positivity and memory assertions remain written proofs; they imply no sign for the full Weil readout.

## 1. The literal charge and its change at every birth

Write a(v)=e^(v/2)H(e^v), with H zero on x<1. For finite integrable physical profiles define

$$
 Q(a)=\frac12\int_{\mathbb R}a(v)dv
     =\frac12\int_1^\infty H(x)x^{-1/2}dx.
$$

The causal successor is exactly (SH)(x)=1_(x>=1)H(x+1). For the birth h_t(x)=x^(-1)1_(x>=t), t>=1,

$$
 Q(h_t)=t^{-1/2},\qquad
 Q(Sh_t)=\arctan\frac1{\sqrt{\max(1,t-1)}}.
$$

Here and below Q(H) means Q applied after the critical change of coordinates. Define

$$
 d(t)=Q(Sh_t)-Q(h_t)
 =\begin{cases}
 \pi/4-t^{-1/2},&1\le t\le2,\\
 \arcsin(t^{-1/2})-t^{-1/2},&t\ge2.
 \end{cases}                                            \tag{1}
$$

The two formulas agree at 2. In particular d(1)=pi/4-1, and d(t)>0 for t>=2, with d(t)=1/(6t^(3/2))+O(t^(-5/2)). Direct integration gives

$$
 \boxed{\int_1^\infty d(t)dt=1-\pi/4=-d(1).}            \tag{2}
$$

For t>=2 an antiderivative is t asin(t^(-1/2))+sqrt(t-1)-2sqrt t, tending to zero at infinity. Its value at 2, together with the integral over [1,2], proves (2). Thus the causal initial birth exactly balances the full continuous density contribution to this charge difference; it is not an omitted endpoint.

## 2. The actual arithmetic port is strictly positive and converges

Use the natural actual cutoff

$$
 g_N=-h_1+\sum_{2\le n\le N}\Lambda(n)h_n-\int_1^N h_tdt
     =\frac{\psi(\min(x,N))-\min(x,N)}x\,1_{x\ge1},
 \quad N\ge2.
$$

All birth integrals are finite at fixed N, so the charge difference is exactly

$$
 \delta_N:=Q(Sg_N)-Q(g_N)
 =-d(1)+\sum_{2\le n\le N}\Lambda(n)d(n)-\int_1^N d(t)dt.
$$

Using the initial/density identity (2),

$$
 \boxed{\delta_N=\sum_{2\le n\le N}\Lambda(n)d(n)
                  +\int_N^\infty d(t)dt>0.}             \tag{3}
$$

Every prime power in Lambda remains. The arithmetic series is absolutely convergent by Chebyshev's estimate psi(x)=O(x) and d(x)=O(x^(-3/2)). Therefore

$$
 \delta_N\longrightarrow\kappa
 :=\sum_{n\ge2}\Lambda(n)\big[\arcsin(n^{-1/2})-n^{-1/2}\big]>0,
 \qquad |\delta_N-\kappa|\le C N^{-1/2}.                 \tag{4}
$$

There is also an exact half-plane-safe Dirichlet expression. For $k\ge1$ let $c_k=\binom{2k}{k}/[4^k(2k+1)]$. The classical positive [arcsine series, DLMF (4.24.1)](https://dlmf.nist.gov/4.24.E1), the [von Mangoldt Dirichlet identity, DLMF (27.4.12)](https://dlmf.nist.gov/27.4.E12), and Tonelli give

$$
 \boxed{\kappa=\sum_{k\ge1}c_k
       \left[-\frac{\zeta'}{\zeta}(k+1/2)\right].}       \tag{5}
$$

All arguments k+1/2 are at least 3/2, so this uses the absolutely convergent ordinary von Mangoldt Dirichlet series and has no zero-free or RH premise.

The exact endpoint remainder can be retained more sharply. With E(x)=psi(x)-x, Stieltjes integration on (N,infinity) gives

$$
 \delta_N-\kappa=d(N)E(N)+\int_N^\infty E(t)d'(t)dt.     \tag{6}
$$

The right-continuous value psi(N) includes the birth at N. Formula (6) follows by subtracting the density tail from the prime-power tail; d(t)E(t) tends to zero. Chebyshev recovers (4), and an available PNT remainder can be inserted in (6) without changing the port normalization. Neither positivity of (3) nor the existence of its limit implies that the individual successor arrival increments have a single sign.

## 3. The relative charge is continuous in the actual mixed source space

The absolute charge Q need not extend to the completed arithmetic source. Its difference has a better kernel. Changing variables in the literal successor integral gives

$$
 \delta(H):=Q(SH)-Q(H)=\int_{\mathbb R}H(x)\varphi(x)dx,
\quad
 \varphi(x)=\frac12\left[
 \frac{1_{x\ge2}}{\sqrt{x-1}}-\frac{1_{x\ge1}}{\sqrt x}\right].
                                                               \tag{7}
$$

The expression on the right defines the extension; the two charges on the left are asserted individually only when they exist. This kernel has exact zero integral, belongs to L^1 intersection L^2, and is O(x^(-3/2)) at infinity. For example, integrating to R>2 yields sqrt(R-1)-sqrt R, tending to zero.

Since its mean is zero,

$$
 |\widehat\varphi(\xi)|
 \le C\int\min(|\xi x|,2)|\varphi(x)|dx
 \le C\sqrt{|\xi|}\quad(0<|\xi|\le1).                  \tag{8}
$$

Split the integral at x=1/|xi| to obtain the last bound. Let $E$ be the [additive mixed Hilbert completion](actual-source-mixed-dirichlet-completion.md), with

$$
 \|H\|_E^2=\int_0^1\|H(\cdot+h)-H\|_2^2\,dh
 +\int_1^\infty\|H(\cdot+h)-H\|_2^2\frac{dh}{h^2}.
$$

Its Fourier multiplier satisfies $m(\xi)\asymp\min(|\xi|,1)$. Equations (8) and $\varphi\in L^2$ imply

$$
 \int\frac{|\widehat\varphi(\xi)|^2}{m(\xi)}d\xi<\infty,
 \qquad |\delta(H)|\le C_\delta\|H\|_E.                 \tag{9}
$$

Thus delta is a bounded functional on E, even though Q itself is not thereby bounded. The proved [natural-cutoff convergence](natural-arrival-cutoff-completion.md) $g_N\to g$ in $E$ proves that its canonical completed port is delta(g)=kappa, agreeing with the explicit arithmetic limit (4).

## 4. The compensated successor is a bounded operator on the causal completion

Let E_c be the E closure of finite-energy functions supported on [1,infinity). Local L^2 on [1,2] is controlled by the E norm: in its defining translation integral, take h in [1,2] and x in [1,2]. Then x-h<1 almost everywhere, so the causal zero value gives

$$
 \|H\|_E^2\ge\frac12\|H\|_{L^2([1,2])}^2.             \tag{10}
$$

The same argument gives local L^2 control on each fixed bounded interval, with an interval-dependent constant, so the causal support condition survives completion. Here tau_1 H(x)=H(x+1) is the left translation. Whole-line additive translation is isometric in E, and E(f)<=8||f||_2^2 for f in L^2. The exact compression is

$$
 SH=\tau_1H-1_{[0,1]}(x)H(x+1).
$$

Its removed strip has E norm at most 4||H||_E by (10). Consequently

$$
 \|SH\|_E\le5\|H\|_E\quad(H\in E_c).                 \tag{11}
$$

This is only a boundedness statement; no coisometry in E or universal energy decrement is asserted. Since h_1 belongs to E_c and Q(h_1)=1, the operator

$$
 \mathcal C H=SH-\delta(H)h_1                            \tag{12}
$$

is bounded on E_c. On inputs of finite charge, Q(C H)=Q(H). The subtracted scalar is retained as an explicit port: SH=C H+delta(H)h_1. In particular the actual cutoff remainders Cg_N converge in E to Cg, and their port values converge to the positive kappa. This is an invariant completed source space for the compensated remainder; it is not yet a boundedness theorem in the stronger unbounded centered-heat graph norm.

## 5. A memory lift, rather than deleting the resonance

For finite-charge states the relative update can be represented exactly by

$$
 \widehat S(H,c)=(SH,c+\delta(H)),\qquad c=Q(H).
                                                               \tag{13}
$$

Equation (9) and (11) extend this to a bounded linear map on E_c direct-sum C. This extension treats c as a retained memory coordinate. It does not manufacture an absolute charge for the full arithmetic source: Q(g_N) may fail to converge, and its control is a separate question. The relative increment delta(g)=kappa is nevertheless well-defined and positive.

If a decomposition with zero-charge remainder is desired, put H=H_0+c h_1, Q(H_0)=0. Then Q(Sh_1)=pi/4 and the exact block update is

$$
 \begin{aligned}
 c'&=\delta(H_0)+(\pi/4)c,\\
 H_0'&=SH_0-\delta(H_0)h_1
          +c\,[Sh_1-(\pi/4)h_1].
 \end{aligned}                                          \tag{14}
$$

Every displayed operator and functional is bounded in E, and the state reconstructs SH=H_0'+c'h_1. The zero-charge constraint is a compatibility condition where Q exists, not a newly claimed closed subspace of E. The charge feeds back into the remainder through the explicit initial-strip profile in brackets; iteration cannot simply add scalars while ignoring that profile.

The [positive seed semigroup](positive-successor-seed-jump-process.md) $T_u$ is causal and bounded on E_c. It preserves the physical integral, hence Q, whenever that integral exists, because its delay measure is a probability. It therefore has the compatible memory lift (H,c)->(T_u H,c). On the original physical L^2 space it is a multiplier of modulus at most one, so it also preserves every [centered-heat operator domain](centered-prime-mellin-domain.md) $D_s$ and is contractive in the corresponding heat graph norm. This statement is specific to T_u, not to S or C.

For finite sums of the original birth profiles, the compensated remainder CH with Q(H)=0 has an analytic Fourier transform with a zero at frequency zero and a BV high-frequency tail. The checked limiting centered-prime symbol then places CH in D_s for 0<s<3/4, even when SH itself only belongs for s<1/4. This restores the first cancellation on that finite-source class, while keeping the newly created charge outside the remainder. It does not prove boundedness of C on all D_s, nor authorize dropping the charge from a physical observable.

A complete readout must retain its square and mixed contributions: at finite prime cutoff, heat applied to H_0+c h_1 is the heat of H_0 plus c times the known universal charged wavepacket. Any signed W or boundary identity needs both terms and their interference. The positive finite forcing (3), the bounded relative port (9), and the exact feedback block (14) are actual successor constraints available for that test; a sign for the resulting full readout is not assumed.

## 6. This specific port removes the mean of the late prime-return profile

Let P denote the causal projection 1_(x>=1), and extend the birth parameter to y>0. Then Ph_y=h_max(1,y), so the actual port response is

$$
 \widetilde d(y):=\delta(Ph_y)=d(\max(1,y)).
$$

The initial identity (2) now gives an exact cancellation over the complete positive scale:

$$
 \boxed{\int_0^\infty\widetilde d(y)dy=0.}              \tag{15}
$$

The function is continuous, constant d(1) below 1, and O(y^(-3/2)) at infinity. For a fixed prime $p$, put $L=\log p$. The complete local operator is the one in the [centered-kernel theorem](centered-infinite-prime-birth-kernel.md):

$$
 L_p=\frac2pI+p^{-3/2}(D_p+D_{1/p})
 -(1-p^{-1})\sum_{j\ge2}p^{-j/2}(D_{p^j}+D_{p^{-j}}),
 \qquad D_aH(x)=\sqrt a\,H(ax).
$$

Define

$$
 F_p(\theta)=-(1-1/p)\sum_{j\in\mathbb Z}
     e^{\theta-jL}\widetilde d(e^{\theta-jL}).            \tag{16}
$$

Both tails converge absolutely and uniformly on a period: y dtilde(y)=O(y) as y decreases to zero, and O(y^(-1/2)) at infinity. Thus F_p is continuous and L-periodic. Unfolding the sum and using (15) proves

$$
 \boxed{\frac1L\int_0^L F_p(\theta)d\theta=0.}          \tag{17}
$$

This is the leading return profile of the complete actual generator observed through delta. Indeed D_a h_n=a^(-1/2)h_(n/a). The complete coefficient expansion of L_p gives its advancing proper-power contribution exactly as

$$
 -(1-1/p)\sum_{j\ge2}p^{-j}\widetilde d(n/p^j).
$$

Its remaining pieces are the diagonal (2/p)d(n), the first advances p^(-2)d(n/p), the first delays p^(-1)d(np), and the delayed proper powers -(1-1/p)sum_{j>=2}d(np^j). All are O_p(n^(-3/2)). Extending the advancing sum from j>=2 to all integers adds only O_p(n^(-3/2)), since y dtilde(y)=O(y^(-1/2)) in that removed large-y tail. Consequently

$$
 \boxed{\delta(P L_p h_n)=\frac{F_p(\log n)}n
                      +O_p(n^{-3/2})\quad(n\to\infty).} \tag{18}
$$

The same leading formula holds for L_p-2/p. Projection cannot be omitted from a literal arbitrary-input successor statement; here it is also enforced by the support of phi in (7).

The zero mean is a specific successor constraint. It does not assert F_p is identically zero, or that its remaining log-clock modes cancel against the actual prime-power arrivals. Those modes have the exact Mellin description

$$
 \int_0^\infty\widetilde d(y)y^{s-1}dy
 =\frac1s\int_1^\infty\varphi(x)x^{s-1}dx,
 \qquad 0<\Re s<3/2.                                  \tag{19}
$$

To verify it, use dtilde(y)=integral_(max(1,y))^infinity phi(x)dx/x and interchange absolutely. The value at s=1 vanishes by the exact zero integral of phi. Formula (19) retains the nonzero Fourier modes of (16), rather than replacing the periodic profile by its mean. It is an explicit changed observation for the signed anticausal return channel, not a proof that the complete W response loses that channel.

The collective channel tests a different Mellin value. Direct integration gives

$$
 \int_1^\infty\varphi(x)x^{-1/2}dx
 =\log2-\log(1+\sqrt2)\ne0.                            \tag{20}
$$

The first term uses the primitive 2 log(sqrt x+sqrt(x-1)); the logarithmic upper limits cancel against the second term. The [collective square-response theorem](collective-successor-charge-square-response.md) consequently gives a nonzero collective leading term, despite (17). Its coefficient is 2 log((1+sqrt2)/2)/(sqrt t log t) at birth scale t. Its proof passes the complete kernel asymptotic through the observation, with a separate bound for the unbounded tail. The per-prime zero mean at s=1 must not be substituted for cancellation at the collective s=1/2 singularity.


## Formalized integrable successor charge

[SuccessorCharge.lean](BuildingBlocks/SuccessorCharge.lean) uses the literal physical-coordinate formulas
$$
\sigma(v)=\log(1+e^v),\qquad j(v)=\frac{e^v}{1+e^v},
\qquad Sf(v)=\sqrt{j(v)}f(\sigma(v)),
$$
$$
k(u)=\begin{cases}-1,&u<\log2,\\
(1-e^{-u})^{-1/2}-1,&u\ge\log2.
\end{cases}
$$
For a real $f\in L^1(0,\infty)$, it proves integrability of $Sf$ and the exact identity
$$
\int_0^\infty Sf(v)\,dv-\int_0^\infty f(u)\,du
=\int_0^\infty k(u)f(u)\,du.
$$
Thus $\delta(f)=\tfrac12\int kf$ equals $Q(Sf)-Q(f)$. The nonzero initial interval is included in $k$. The reference $a_0(v)=e^{-v/2}$ on this half-line has integral $2$, and the module proves that $Cf=Sf-a_0\delta(f)$ is integrable and satisfies $Q(Cf)=Q(f)$.

All theorem names below are in `BuildingBlocks.SuccessorCharge`.

| Exact statement | Formal theorem |
| --- | --- |
| Successor Jacobian and image $(\log2,\infty)$ | `sigma_hasDerivAt`, `sigma_image_positive` |
| Change of variables and retained initial-interval defect | `integral_successor`, `integral_successor_sub` |
| $Sf\in L^1(0,\infty)$ | `integrable_successor` |
| $\delta(f)=Q(Sf)-Q(f)$ | `defect_eq_charge_difference` |
| Reference integrability and mass $2$ | `reference_integrable`, `reference_integral` |
| $Cf\in L^1$ and exact charge conservation | `integrable_compensated`, `integral_compensated`, `charge_compensated` |

The module and changed aggregate compile with Lean 4.24.0; the checked primary targets use only `propext`, `Classical.choice` and `Quot.sound`. These operators are used on the positive half-line. No distributional derivative at the origin is asserted. The finite mixed-energy bound is formalized next. Actual-source membership, completion of the source space and the positive arithmetic limit require the separate written arguments above.


## Formalized relative charge at finite mixed energy

[SuccessorChargeEnergy.lean](BuildingBlocks/SuccessorChargeEnergy.lean) proves the actual kernel estimate
$$
|k(u)|\le2e^{-u},\qquad
\int_0^\infty |e^{u/2}k(u)|^2du\le4.
$$
For every real $f$ with $e^{-u/2}f(u)\in L^2(0,\infty)$, the theorem `defect_bound_weighted` in `BuildingBlocks.SuccessorCharge` proves $kf\in L^1$ and
$$
|\delta(f)|\le
\left(\int_0^\infty |e^{-u/2}f(u)|^2du\right)^{1/2}.
$$
Combining this with the [formal causal anchor](actual-source-mixed-dirichlet-completion.md#formalized-causal-energy-anchor), `defect_bound_causal_energy` proves, for measurable real $H$ vanishing almost everywhere below $1$ and satisfying $\mathcal E(H)<\infty$,
$$
k(u)e^{u/2}H(e^u)\in L^1(0,\infty),\qquad
\left|\delta\bigl(e^{u/2}H(e^u)\bigr)\right|
\le\sqrt{\mathcal E(H)}.
$$
The kernel formula defines this relative charge directly. Neither theorem assumes $f\in L^1$ or concludes that the absolute charge $Q(f)$ exists. `causal_source_square` provides the intermediate finite weighted square integral. The other primary targets are `kernel_abs_le_exp` and `weightedKernel_square_integral_le`.

The module and changed aggregate compile with Lean 4.24.0, and the checked primary targets use only `propext`, `Classical.choice` and `Quot.sound`. The actual prime-error source satisfies the finite-energy premise by the separately proved PNT input; that membership theorem and the strict arithmetic sign of its relative charge remain written mathematics.
