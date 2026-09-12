# A positive finite-activity process from the complete successor seed

The process and domain-qualified response in (26)–(28) are written proofs. The complete single-clock mass identities are formalized in Lean as described below. This consumes the exact seed and fixed-Cauchy covariance in [fixed-Cauchy covariance theorem](fixed-cauchy-prime-covariance-seed.md). It constructs a positive process from the actual complete prime profiles. It does not identify that process with the natural theta exponent or assert a sign for the Weil readout. The Bernstein and compound Poisson framework is classical; see Schilling, Song and Vondraček, [*Bernstein Functions: Theory and Applications*, second edition, chapters 3, 5 and 13](https://motapa.de/bernstein_functions/index.shtml). The Hardy, Poisson and Blaschke tools below are also classical; the full arithmetic seed and its response are the stated specialization.

For every prime p let

$$
 B_p(v)=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}1_{v\ge\log p},
 \quad B_P=\sum_{p\le P}B_p,\quad B=\sum_pB_p.
$$

The [covariance theorem](fixed-cauchy-prime-covariance-seed.md) proves $B(v)\le C/(1+v)$, $B=0$ below $\log2$, $B_P\uparrow B$, and $\|B-B_P\|_2^2=O(1/\log P)$. Each profile has exactly $\int B_p(v)\,dv=2/p$. This last identity follows by integrating its geometric intervals:

$$
 \sum_{k\ge1}p^{-k-1}\int_{k\log p}^{(k+1)\log p}e^{v/2}dv
 =\frac{2(\sqrt p-1)}p\sum_{k\ge1}p^{-k/2}=2/p.          \tag{1}
$$

## The positive measure and an exact complete-history law

Define finite positive measures

$$
 \nu_P(dv)=\frac{B_P(v)}v\,dv,\qquad
 \nu(dv)=\frac{B(v)}v\,dv.                              \tag{2}
$$

Their total masses are finite because the support stays away from zero and $B(v)/v=O(v^{-2})$ at infinity. Moreover,

$$
 0\le(\nu-\nu_P)((0,\infty))
 \le\int_{\log P}^\infty\frac{C\,dv}{v(1+v)}
 =O(1/\log P).                                          \tag{3}
$$

For process time $u\ge0$ the probability measure

$$
 \mathsf P_u=e^{-u\nu((0,\infty))}
       \sum_{n=0}^\infty\frac{u^n}{n!}\nu^{*n},
 \qquad \nu^{*0}=\delta_0,                              \tag{4}
$$

is a positive convolution semigroup. This follows directly from the exponential series and the binomial convolution identity. Each term is a fully retained n-jump history. Its finite-prime counterpart $\mathsf P_{P,u}$ is obtained by replacing $\nu$ with $\nu_P$; no proper-power interval inside an admitted $B_p$ is omitted.

The decomposition $\nu=\nu_P+(\nu-\nu_P)$ gives an explicit coupling: add an independent compound Poisson process with the omitted positive measure. Therefore

$$
 \sup_A|\mathsf P_u(A)-\mathsf P_{P,u}(A)|
 \le1-e^{-u(\nu-\nu_P)((0,\infty))}
 \le C u/\log P.                                        \tag{5}
$$

The estimate is uniform for u in a fixed compact interval. Under the total-variation norm convention twice $\sup_A$, multiply the displayed bound by 2. The frequency characteristic functions converge uniformly as an immediate consequence. This is a global probability-law completion, not a finite-band approximation.

## The exact Bernstein exponent and its response

The Laplace exponent is

$$
 \Phi_P(s)=\int_0^\infty(1-e^{-sv})\frac{B_P(v)}v\,dv,
 \qquad
 \Phi(s)=\int_0^\infty(1-e^{-sv})\frac{B(v)}v\,dv,
 \quad \Re s\ge0.                                      \tag{6}
$$

The integrals are absolutely convergent and continuous on the closed half-plane, holomorphic in its interior. On the nonnegative real axis $\Phi$ is a bounded Bernstein function: $\Phi\ge0$ and

$$
 \Phi'(s)=\int_0^\infty e^{-sv}B(v)dv,
 \qquad (-1)^n\Phi^{(n+1)}(s)=\int_0^\infty v^n e^{-sv}B(v)dv\ge0
 \quad(s>0).                                           \tag{7}
$$

The same assertions hold at finite P. The probability law (4) has Laplace transform $e^{-u\Phi(s)}$. Formula (3) yields $\sup_{\Re s\ge0}|\Phi(s)-\Phi_P(s)|=O(1/\log P)$, including the whole imaginary axis.

The derivative is exactly the seed Laplace transform. It has an $L^2$ boundary value because B belongs to $L^2$. More explicitly,

$$
 H_P(t)=\int_0^\infty e^{itv}B_P(v)dv
       =\Phi_P'(-it)
 \longrightarrow H(t)\quad\hbox{in }L^2(\mathbb R,dt),   \tag{8}
$$

where H is understood as the Fourier-Plancherel transform of the causal B, and the squared error is $2\pi\|B-B_P\|_2^2$. It is also the $L^2$ boundary limit of $\Phi'(\sigma-it)$ as $\sigma$ decreases to zero. The ordinary improper integral in (8) need not be used to define H.

The centered original prime generator is recovered by a fixed response operator:

$$
 \boxed{Z_P(t):=\sum_{p\le P}\big(\ell_p(t)-2/p\big)
       =-\Re\big[(1+2it)\Phi_P'(-it)\big].}              \tag{9}
$$

To check (9), let $\mu_p$ be the complete positive-displacement signed coefficient measure of $\ell_p$. The tail identity is $b_p(v)=e^{v/2}\int_{[v,\infty)}e^{-a/2}\mu_p(da)=-B_p(v)$. In distributions, $\mu_p=(b_p/2)\,dv-db_p$. Substitution in the centered even Fourier series, followed by integration by parts, gives

$$
 Z_P(t)=\int_0^\infty[2t\sin(tv)-\cos(tv)]B_P(v)dv,
$$

which is (9). All integrals are absolute at fixed P since $\int B_P=2\sum_{p\le P}1/p$. For infinite P, (9) holds with H in place of $\Phi_P'(-it)$ in fixed Cauchy $L^2$, hence locally in ordinary $L^2$. Indeed multiplication by $(1+2it)$ is bounded from ordinary $L^2$ into this Cauchy-weighted $L^2$, and the covariance theorem supplies the same Z limit.

Thus the positive law and the original centered heat generator are linked by an explicit boundary derivative. Convergence of the positive laws does not by itself control this derivative on arbitrary inputs, nor does it prove exponential integrability of Z.

## The retained infinite mean and its low-frequency scale

The law has finite jump rate but infinite mean jump age:

$$
 \nu((0,\infty))<\infty,\qquad
 \int_0^\infty v\nu(dv)=\int_0^\infty B(v)dv
 =2\sum_p1/p=\infty.                                   \tag{10}
$$

There is no explosion of the number of jumps in finite process time; the divergence is in their expected lengths. The positive measure retains long histories instead of discarding them in a finite-depth approximation.

The sharper actual-seed asymptotic in [long-memory theorem](collective-successor-seed-long-memory.md) gives $B(v)=2/v+O(v^{-2})$. Using that proved asymptotic, which is stronger than the Chebyshev input needed for (1)–(10),

$$
 \nu([R,\infty))=2/R+O(R^{-2}),\qquad
 \Re\Phi(-it)=\pi|t|+o(|t|)\quad(t\to0).                \tag{11}
$$

For the second assertion substitute $w=|t|v$ in the leading tail $2/v^2$ and use $\int_0^\infty(1-\cos w)\,dw/w^2=\pi/2$. The $O(v^{-3})$ remainder contributes $o(|t|)$, by splitting at $v=1/|t|$; the fixed compact part is $O(t^2)$. The same seed asymptotic gives the previously recorded logarithmic response $\Phi'(s)=-2\log s+C_B+o(1)$ on the positive real axis, and hence

$$
 \Phi(s)=-2s\log s+(C_B+2)s+o(s),\quad s\downarrow0.     \tag{12}
$$

The positive process therefore has a Cauchy-order real characteristic exponent near zero, with an infinite-mean asymmetric age component. The fixed-observation normalized heat transition is a property of the derivative response (9), which retains the logarithmic resonance. It is not a failure of probability-law convergence in (5).

This construction uses only the elementary compound Poisson exponential and the positive actual successor profiles. Those general probability tools are classical; no novelty is claimed for them. The object differs from both the prime-square discrete Markov reference and the unproved natural theta Bernstein candidate. Any transfer to the full arithmetic signed readout must keep the response (9), the original ground subtraction, and the source normalization.

## A common causal inner factor gives the exact prime response

The interval sum for each seed can be evaluated before summing primes. For $\Re s>0$, with the apparent $s=1/2$ singularity removed,

$$
 \widehat B_p(s)=\int_0^\infty e^{-sv}B_p(v)dv
 =\frac{p^{1/2-s}-1}{p(1/2-s)(p^{1/2+s}-1)}.            \tag{13}
$$

Indeed integration on $k\log p\le v<(k+1)\log p$ leaves a geometric series with ratio $p^{-1/2-s}$, and summing it yields (13). At $s=1/2$ the value is $\log p/[p(p-1)]$.

Put $r=p^{-1/2}$, $w=p^{-s}$, and

$$
 R_p(s)=w\frac{w-r}{1-rw},\qquad
 V(s)=\frac{1/2-s}{1/2+s}.                               \tag{14}
$$

Both are bounded analytic inner functions on the right half-plane: the boundary values have modulus one almost everywhere, and the interior moduli are at most one. The first is a delay followed by a disk Blaschke factor. It satisfies $R_p(1/2)=0$. The second is the same single-pole causal isometry V as in [section 8 of the covariance note](fixed-cauchy-prime-covariance-seed.md#8-a-fixed-causal-isometry-reconstructs-the-missing-interior). Removing this common zero gives a further inner function

$$
 W_p(s)=R_p(s)/V(s),\qquad
 \widehat B_p(s)=\frac1p\frac{W_p(s)}{s+1/2}.             \tag{15}
$$

Boundedness of $W_p$ follows from the Schwarz lemma in the half-plane applied at the zero 1/2; the zero is removable, and its boundary modulus is one. Thus in causal Hardy space

$$
 B_p=\frac1p W_p(D)a_0.                                 \tag{16}
$$

The formula retains the entire prime clock, including all the other regularly spaced zeros of $R_p$. The positivity of $B_p$ is the actual interval calculation, not a property of an arbitrary inner factor acting on $a_0$.

At $s=-it$, $w=e^{it\log p}$. Direct algebra gives the exact causal innovation factorization

$$
 \boxed{\ell_p(t)=\frac1p|1-R_p(-it)|^2,
 \qquad \ell_p(t)-2/p=-\frac2p\Re R_p(-it).}             \tag{17}
$$

Indeed $1-R_p=(1-w^2)/(1-rw)$. This is the same modulus as the original bilateral innovation U_p-1, with its full denominator. The phase relation is also explicit:

$$
 U_p(t)-1=r\,w^{-1}U_p(t)\,[1-R_p(-it)].                \tag{18}
$$

The prefactor in (18) has modulus r. Replacing the original innovation by the causal one inside a bilinear readout must retain that unitary phase, not merely its norm. Summing (13)--(17) gives the analytic response

$$
 A_P(s):=\sum_{p\le P}\frac{R_p(s)}p
       =(1/2-s)\Phi_P'(s),\qquad Z_P(t)=-2\Re A_P(-it). \tag{19}
$$

This gives an exact common-factor constraint on every admitted prime.

There is a precise fixed-observation phase consequence. C is harmonic measure at $s=1/2$ on the imaginary boundary of the right half-plane. Hence for every finite nonzero family of nonnegative integers (n_p),

$$
 \mathbb E_{\mathsf C}\prod_p R_p(-it)^{n_p}
 =\prod_pR_p(1/2)^{n_p}=0.                              \tag{20}
$$

This follows from the classical Poisson formula for bounded analytic functions. For each p, or any nonempty product of its admitted factors, the boundary phase therefore has exactly uniform circle distribution under C. In particular, at every complex heat time z,

$$
 \mathbb E_{\mathsf C}e^{-z\ell_p}
 =e^{-2z/p}\frac1{2\pi}\int_0^{2\pi}e^{(2z/p)\cos\theta}d\theta.
                                                               \tag{21}
$$

Equation (20) is not independence: mixed moments involving conjugates generally do not vanish. They include the strictly positive distinct-prime covariance in the seed identity. Those mixed moments retain the coherent prime coupling. The Cauchy/Poisson formula, Blaschke factor removal, and uniform image measure are classical; the displayed identities specify their actual complete-prime specialization and normalization.

## A bounded all-prime orbit in the actual mixed source space

This positive process also has a direct operator completion in the [mixed source space](actual-source-mixed-dirichlet-completion.md) $E$, with the [prime metric defect](prime-transport-in-mixed-completion.md) retained. Recall that its additive Fourier multiplier satisfies

$$
 c\min(|\xi|,1)\le m(\xi)\le C\min(|\xi|,1).
$$

For the critical additive dilation $D_a f(x)=\sqrt a f(ax)$,

$$
 \|D_a f\|_E^2=\int m(a\xi)|\widehat f(\xi)|^2d\xi.
$$

Consequently there is an absolute constant C_E such that

$$
 \sup_{0<a\le1}\|D_a\|_{E\to E}\le C_E.                \tag{22}
$$

The causal physical log-delay $R_v a(t)=a(t-v)$, $v\ge0$, corresponds to $D_{e^{-v}}$ under the critical additive change of coordinates. Define

$$
 \mathcal T_u f=\int_0^\infty D_{e^{-v}}f\,\mathsf P_u(dv),
 \quad
 \mathcal G f=\int_0^\infty(I-D_{e^{-v}})f\,\nu(dv).    \tag{23}
$$

These are Bochner integrals on the completed Hilbert space E. Strong continuity of the dilations follows first on compact smooth functions and then by (22) and density. The measure $\nu$ is finite, so $\mathcal G$ is bounded. The convolution law in (4) yields $\mathcal T_u=e^{-u\mathcal G}$, and for real $u\ge0$,

$$
 \sup_{u\ge0}\|\mathcal T_u\|_{E\to E}\le C_E.          \tag{24}
$$

No assertion of norm-one contraction is made. Positivity is the probability-kernel positivity on representatives; boundedness in E follows from the actual multiplier comparison, not from old critical unitarity.

The finite-prime versions satisfy, for real $u\ge0$,

$$
 \|\mathcal T_u-\mathcal T_{P,u}\|_{E\to E}
 \le 2C_E\,[1-e^{-u(\nu-\nu_P)((0,\infty))}]
 \le C u/\log P.                                        \tag{25}
$$

This uses the total variation norm of the coupled probability measures. Also $\|\mathcal G-\mathcal G_P\|=O(1/\log P)$, so bounded-generator exponentials converge locally uniformly at all complex process times. In particular the actual arithmetic $g(x)=1_{x\ge1}(\psi(x)/x-1)$ and its cutoff approximants have an all-prime orbit in E, with the two limits interchangeable at each fixed process time. This is a different semigroup from $e^{-u L_P}$; its response is recorded next rather than silently identifying the two.

## The original generator is a domain-qualified clock response

In the original physical v coordinate, use causal delays R_a and write $\mathcal G_P=\Phi_P(\partial_v)$. With the Fourier convention $e^{-itv}$, $\partial_v$ has symbol it. Let X be multiplication by v. At finite P, on smooth compactly supported functions,

$$
 [X,R_a]=aR_a,\qquad
 [X,\mathcal G_P]=-\int_0^\infty R_a B_P(a)da=-\Phi_P'(\partial_v).
                                                               \tag{26}
$$

The finite first moment $\int B_P=2\sum_{p\le P}1/p$ justifies this as a bounded commutator expression on that core and its $L^2$ extension. Put $A_P(s)=(1/2-s)\Phi_P'(s)$, as in (19). Its boundary value is bounded at finite P, and the complete centered generator has exactly

$$
 Z_P(D)=-(A_P(\partial_v)+A_P(\partial_v)^*)
       =(1/2-\partial_v)[X,\mathcal G_P]
         +\big((1/2-\partial_v)[X,\mathcal G_P]\big)^*.            \tag{27}
$$

The adjoint in (27) is the original physical $L^2$ adjoint, not the E adjoint. The derivative initially acts on the smooth core; its combined multiplier extends boundedly at finite P because $A_P=\sum_{p\le P}R_p/p$.

For the infinite positive generator $\mathcal G$, the first moment B is not integrable, so (26) is not asserted as a bounded operator commutator on all $L^2$. It does hold on compact smooth inputs as an $L^2$ identity: $B*f$ belongs to $L^2$ by Young's inequality because B belongs to $L^2$ and f belongs to $L^1$. Distributional identity (26), together with $\mathcal G(Xf)$ in $L^2$, shows that $X\mathcal Gf$ is in $L^2$ and hence the literal commutator is defined on that core.

There is a useful quantitative core extension. For f in $L^1$ with finite distributional variation, convolution with $df$ is well-defined in $L^2$, and (27) gives

$$
 \|(Z_P(D)-Z_Q(D))f\|_2
 \le \|B_P-B_Q\|_2\,[\|f\|_1+2\,\mathrm{TV}(f)]
 \quad(P,Q<\infty).                                    \tag{28}
$$

The two orientations in (27) have the same $L^2$ kernel bound. Thus the original centered response has a genuine completed $L^2$ action on this $L^1$/BV class, with tail $O((\log P)^{-1/2})$ times the displayed source norm. This response extension is not automatically the literal unbounded X commutator: that identification additionally requires $Xf$ and $X\mathcal Gf$ to be defined in $L^2$, as proved above on the compact smooth core. The estimate does not control a growing arithmetic cutoff for which its source norm is large. The fixed-Cauchy theorem gives the compatible ground-profile completion; extending it to the full actual arithmetic source requires its signed arrival or successor-flux estimates.

The positive history evolution is uniformly bounded in the actual source space. The original response differentiates its age memory through a first-moment clock commutator that is not bounded on all of $L^2$. Probability-law positivity and (24) do not provide a cancellation estimate for that response.


## Formalized single-clock dependencies

For every real $p>1$, the Lean definition `BuildingBlocks.PrimeSeedMass.seed (Real.log p)` is exactly

$$
B_p(v)=\begin{cases}
 e^{v/2}/p^{\lfloor v/\log p\rfloor+1},&v\ge\log p,\\
 0,&v<\log p.
\end{cases}
$$

On the nonzero branch the quotient is positive, so the natural-number floor used in Lean agrees with the ordinary floor in this formula. `seed_log_eq` proves the literal exponential/power identification, including the threshold. The modules prove integrability, not merely equalities of totalized integrals. They partition the entire support into the half-open cells $[(j+1)\log p,(j+2)\log p)$ and sum every cell by a convergent geometric series. Primality is unnecessary for these individual-clock identities.

All names in the table have namespace `BuildingBlocks.PrimeSeedMass`.

| Exact theorem | Lean declaration and source |
| --- | --- |
| $B_p\ge0$ and $B_p=0$ below $\log p$ | `seed_nonneg`, `seed_eq_zero` in [PrimeSeedMass.lean](BuildingBlocks/PrimeSeedMass.lean) |
| $B_p\in L^1$ and $\int_{\mathbb R}B_p(v)\,dv=2/p$ | `integrable_seed_and_integral`, `integral_prime_seed` in [PrimeSeedMass.lean](BuildingBlocks/PrimeSeedMass.lean) |
| $e^{-v/2}B_p\in L^1$ and $\int_{\mathbb R}e^{-v/2}B_p(v)\,dv=\log p/[p(p-1)]$ | `integrable_weighted_seed_and_integral`, `integral_prime_weighted_seed` in [PrimeSeedMass.lean](BuildingBlocks/PrimeSeedMass.lean) |
| $B_p^2\in L^1$ and $\int_{\mathbb R}B_p(v)^2\,dv=p^{-2}$ | `integrable_seed_square_and_integral`, `integral_prime_seed_square` in [PrimeSeedSquare.lean](BuildingBlocks/PrimeSeedSquare.lean) |

The integrability declarations are stated for every real clock length $L>0$; their displayed prime formulas specialize to $L=\log p$. `integral_of_clock_cells` is the reusable nonnegative countable-partition lemma underlying the three whole-line integrals. The proof uses mathlib's Lebesgue integration, elementary exponential integrals and geometric-series theorems. Both modules compile with Lean 4.24.0 and the repository's pinned mathlib; the checked prime integral targets and `seed_log_eq` depend only on `propext`, `Classical.choice`, and `Quot.sound`.

These modules do not formalize collective prime-sum convergence with its cross terms, the finite measure $B(v)\,dv/v$, probability semigroup, bounded mixed-space evolution, Hardy factors or response-domain assertions above. Those remain written mathematical dependencies. The square-mass identity also supplies the individual-profile normalization in the [fixed-Cauchy covariance theorem](fixed-cauchy-prime-covariance-seed.md).


## Formalized delay history and prime-sum distinctions

For $L>0$, let $b_L(v)=\operatorname{seed}(L,v)$ and

$$
i_L(v)=e^{v/2-2L}\mathbf1_{[L,2L)}(v),\qquad r=e^{-L/2}.
$$

[PrimeSeedDelay.lean](BuildingBlocks/PrimeSeedDelay.lean) proves the literal delay equation

$$
b_L(v)=i_L(v)+r b_L(v-L).
$$

Its `seed_delay_equation` includes the nonzero first interval and its half-open endpoints. The general `iterate_delay` theorem gives, for every integer $N\ge0$,

$$
f(v)=\sum_{j=0}^{N-1}r^j g(v-jL)+r^N f(v-NL)
$$

from the sole hypothesis $f(v)=g(v)+rf(v-L)$. The terminal history vanishes for the actual seed only under the stated condition $v<(N+1)L$ in `seed_finite_history`. Finally, `seed_unique` proves uniqueness from causality below $L$ and the delay equation, without an integrability or boundedness hypothesis. These are the elementary causal-recursion dependencies of the complete prime response.

[PrimeSeedPrimeSums.lean](BuildingBlocks/PrimeSeedPrimeSums.lean) then uses the proved masses and mathlib's classical Euler divergence theorem. Its exact distinctions are:

| Statement | Declaration in `BuildingBlocks.PrimeSeedMass` |
| --- | --- |
| $\sum_p\int B_p$ is not summable | `not_summable_prime_seed_integrals` |
| $\sum_p\int B_p^2$ is summable | `summable_prime_seed_square_integrals` |
| $\int\sum_{p\in S}B_p=\sum_{p\in S}2/p$ for every finite prime set $S$ | `integral_finset_prime_seed` |
| No integrable real function pointwise dominates every finite aggregate $\sum_{p\in S}B_p$ | `no_integrable_majorant_prime_seeds` |

The second statement concerns component squares; it does not replace the mixed terms in the square of the collective seed. The no-majorant theorem is stated for pointwise domination and does not silently change that quantifier to an almost-everywhere condition depending on $S$. Both modules compile with the pinned Lean/mathlib versions. The checked delay, uniqueness, component-square and no-majorant targets use only `propext`, `Classical.choice` and `Quot.sound`. No claim of priority is attached to these elementary recursion or classical summability results.
