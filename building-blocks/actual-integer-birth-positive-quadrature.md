# Positive quadrature from the actual integer birth cusps

Written proof, with the exact formalized subset described below. The complete arithmetic histories and endpoint conventions are part of each statement. The original integer-birth feedback correspondence is formalized; the unconditional near-one feedback sign remains unproved.

Convex interpolation and exponential hat-function integration are classical tools; the actual integer-cusp alignment and retained arithmetic endpoint are their specialization here. This is a source-specific refinement of `actual-coherent-successor-quadrature-refinement.md`. It uses the fact that every birth location is an integer, including every prime power. It does not prove the remaining coherent core lower bound.

Throughout t=-log r>0 is the geometric successor parameter. It is not the positive prime-process time from earlier work. For n>=2 define

$$
q_n(u)=\begin{cases}
u^{-1/2}\arcsin\sqrt{u/n},&0<u<n,\\
\pi/(2\sqrt u),&u\ge n,
\end{cases}\qquad q_n(0)=n^{-1/2},\qquad U_n(u)=q_n(u)-n^{-1/2}.
\tag{1}
$$

Use the actual complete von Mangoldt weights, the readout

$$
Q(t)=t\sum_{n\ge2}\Lambda(n)\int_0^\infty e^{-tu}U_n(u)du,
\tag{2}
$$

and the literal causal correction

$$
C(t)=(e^t-1)\sum_{j\ge2}e^{-tj}
\frac{\arctan(j^{-1/2})}{\sqrt j}\psi(j).
\tag{3}
$$

The established exact source identity before quadrature is

$$
E(e^{-t})+C(t)=(e^t-1)\sum_{n\ge2}\Lambda(n)
\sum_{j\ge0}e^{-tj}U_n(j).
\tag{4}
$$

All sums and integrals here converge absolutely at each t>0. For example, Chebyshev and the arcsine expansion give
sum_n Lambda(n)|U_n(u)|<=C sqrt(u), and its integer version bounds the geometric sum. The subtraction inside U_n occurs before any infinite sum. In particular U_n(0)=0; it must not be replaced by the unsubtracted q_n.

## The actual birth kernel is convex on every clock cell

For 0<=u<n,

$$
q_n(u)=n^{-1/2}\sum_{l\ge0}
\frac{\binom{2l}{l}}{4^l(2l+1)}(u/n)^l.
\tag{5}
$$

All coefficients are positive. Twice differentiating on compact subintervals proves strict convexity in (0,n). Continuity extends convexity to any closed cell whose right endpoint is n, even though its left derivative there is infinite. For u>=n, q_n(u)=pi/(2sqrt u) is strictly convex as well.

The downward change of slope occurs exactly at the integer n. Therefore it lies between cells, not inside any interval [j,j+1]. It follows that U_n is convex on EVERY such cell. No global convexity across the birth is asserted.

Let I U_n denote the continuous piecewise-linear interpolant of its integer values. Then

$$
I U_n(u)-U_n(u)\ge0\quad(u\ge0).
\tag{6}
$$

This fact depends on the literal integer birth location. There is no corresponding assertion here for arbitrary noninteger birth locations.

## Exact exponential integral of the interpolant

Put r=e^(-t). On a unit cell, write u=j+v. With

$$
A_t=\int_0^1e^{-tv}(1-v)dv=\frac{t-1+r}{t^2},\qquad
B_t=\int_0^1e^{-tv}v\,dv=\frac{1-(1+t)r}{t^2},
$$

absolute summation gives

$$
\begin{aligned}
\int_0^\infty e^{-tu}I U_n(u)du
&=\sum_{j\ge0}r^j[A_tU_n(j)+B_tU_n(j+1)]\\
&=a_t\sum_{j\ge0}r^jU_n(j),\qquad
a_t=A_t+B_t/r=\frac{(1-r)^2}{rt^2}.
\end{aligned}
\tag{7}
$$

The only possible initial term is -(B_t/r)U_n(0), which vanishes exactly. This is why the initial density subtraction in (1) is part of the theorem.

The interpolated source is absolutely integrable after summation in n: use the two nonnegative interpolation coefficients and the established bound on the absolute integer source values. Thus (6)--(7) can be summed with every nonnegative Lambda(n), including all prime powers, without a conditional interchange.

Define

$$
b_t=\frac{t}{1-e^{-t}},\qquad
D(t)=b_t t\sum_{n\ge2}\Lambda(n)
\int_0^\infty e^{-tu}[I U_n(u)-U_n(u)]du.
\tag{8}
$$

Combining (4) and (7), and using (e^t-1)/a_t=b_t t, proves

$$
\boxed{E(e^{-t})+C(t)=b_t Q(t)+D(t),\qquad D(t)>0.}
\tag{9}
$$

Strictness follows already from the n=2 contribution on the interior of the first cell, where q_2 is strictly convex and Lambda(2)>0. The integral in (8) is finite, so this is a genuine positive correction, not a difference of divergent positive terms.

It does not say that the earlier quadrature error R is positive. In fact

$$
R(t)=(b_t-1)Q(t)+D(t),
\tag{10}
$$

and a negative Q contribution can make R negative even for one birth. Formula (9) combines that normalization term with the source before making a sign statement.

## Size and the remaining core comparison

The preceding mean-zero cell proof gives

$$
E(e^{-t})+C(t)=a_t^{\rm mean}Q(t)+\epsilon(t),\quad
 a_t^{\rm mean}=\frac{e^t-1}{t},\quad
 |\epsilon(t)|\le C_1t\log(2/t),\quad 0<t\le1.
\tag{11}
$$

Here a_t^{mean} is distinct from the interpolation coefficient a_t in (7). The source estimate gives |Q(t)|<=C t^(-1/2), and
|a_t^{mean}-b_t|<=C t^2 on 0<t<=1. Hence (9)--(11) prove

$$
\boxed{0<D(t)\le C_2t\log(2/t).}
\tag{12}
$$

Only the quantitative bound (12) consumes the preceding refinement; positivity and exact identity (9) follow directly from the interpolation proof.

A sufficient unproved sign target is therefore

$$
Q(t)\ge\frac{1-e^{-t}}t C(t)
\tag{13}
$$

on an entire interval 0<t<t0. It needs no extra unsigned quadrature margin. The source-specific positive interpolation correction has resolved that margin's sign, not the constant-scale lower bound (13).

The independently checked exterior theorem in the [finite lattice-port cancellation](finite-division-lattice-port-cancellation.md) gives, at its admissible cutoff K, Q(t)=D_K(t)+Gamma_K(t), where

$$
D_K(t)=\sqrt t\sum_{m=1}^{K-1}
\left[\log m L(tm)-\int_m^{m+1}\log x L(tx)dx\right]
-\sqrt t\int_0^1\log x L(tx)dx,
$$

$$
\Gamma_K(t)=\sqrt t\left[\sum_{m\ge K}\log m L(tm)
-\int_K^\infty\log x L(tx)dx\right]\ge0.
\tag{14}
$$

Its positivity uses the actual large-argument inverse-kernel estimates; it is not inferred from the interpolation proof. Combining the two results gives

$$
\boxed{E(e^{-t})=b_tD_K(t)-C(t)
+b_t\Gamma_K(t)+D(t),\qquad b_t\Gamma_K(t)\ge0,\ D(t)>0.}
\tag{15}
$$

Thus D_K(t)>=(1-e^(-t))C(t)/t would suffice. The finite core includes the entire fractional cell (0,1), and its signed cofactor contributions remain uncontrolled. The theorem neither discards this core nor transfers positivity from the known quadratic-log calibration to the first logarithmic readout.

## Bounded sharpening: the positive defect has logarithmic size

This lower bound uses the same actual integer-cusp mechanism; it does not address the remaining finite-core sign.

For n>=4 and u=n-d with 1/4<=d<=1/2, direct differentiation gives

$$
q_n''(u)=\frac{3\arcsin\sqrt{u/n}}{4u^{5/2}}
+\frac1{4u d^{3/2}}\left(1-\frac{3d}{u}\right)
\ge\frac1{4n}.
\tag{16}
$$

Indeed 3d/u<=3/7<1/2, and the remaining term is at least
1/[8n(1/2)^(3/2)]>1/(4n). On the unit cell [n-1,n], the interpolation error is the Dirichlet Green potential of q_n''. The formula follows first on interior cutoffs and then by monotone integration; the Green factor's linear zero at the right endpoint makes the square-root derivative cusp integrable. Equivalently the usual Green formula holds directly for this continuous convex function with its locally finite positive second derivative measure.

On J_n=[n-1/2,n-1/4], the Green kernel is at least 1/8 for both arguments in J_n. Thus

$$
I U_n(u)-U_n(u)\ge\frac1{128n}\quad(u\in J_n),
\qquad
\int_0^\infty e^{-tu}(I U_n-U_n)du
\ge\frac{e^{-tn}}{512n}.
\tag{17}
$$

It follows that

$$
D(t)\ge\frac{b_t t}{512}\sum_{n\ge4}\frac{\Lambda(n)}n e^{-tn}.
\tag{18}
$$

For integers N>=4 the literal factorial identity, retaining every prime power, gives

$$
\sum_{n\le N}\frac{\Lambda(n)}n
\ge\frac{\log(N!)}N\ge\log N-1.
$$

The last inequality follows from integrating log x over [1,N]. Take N=floor(1/t), use e^(-tn)>=e^(-1) for n<=N, and remove only the fixed n=2,3 terms. Since b_t>=1, one may take $C_3=1+\log2+(\log2)/2+(\log3)/3$, giving

$$
\boxed{D(t)\ge\frac{t}{512e}\big[\log(1/t)-C_3\big].}
\tag{19}
$$

For all sufficiently small positive t, (12) and (19) therefore prove

$$
D(t)\asymp t\log(1/t).
\tag{20}
$$

This uses only Chebyshev for the upper estimate and the exact factorial identity for the lower estimate. It quantifies the positive complete-birth interpolation defect. Its vanishing size cannot supply the unproved constant-scale lower bound on the coherent finite core.

The [complete cusp asymptotic](successor-quadrature-cusp-asymptotic.md) sharpens the correction to $D(t)=\zeta(3/2)t\log(1/t)/(4\pi)+O(t)$ and gives the same leading term for the mean-removed error $\epsilon(t)$. The proof controls every distance cell behind each integer birth uniformly before summing all prime powers. Chebyshev and the factorial identity suffice; the finite-core sign remains open.

The [factorial-potential interpolation](factorial-potential-integer-interpolation.md) is a separate exact decomposition with a negative nonvanishing correction. The [positive common-inner observation](coherent-core-positive-observation-inner-history.md) and its [signed original-source cutoff port](positive-history-observation-original-cutoff-port.md) retain the complete scalar core question.

## Formal complete birth interpolation and exponential hats

The formal chain starts with the literal arcsine birth kernel $q_n$ and its centered value $U_n=q_n-n^{-1/2}$. [IntegerBirthKernel.lean](BuildingBlocks/IntegerBirthKernel.lean) proves the positive integral representation through the birth endpoint, convexity on every integer cell, $U_n(0)=0$, and the nonnegative ordinary interpolation defect. The cusp lies on a cell boundary; global convexity across it is not assumed.

[IntegerBirthSourceBound.lean](BuildingBlocks/IntegerBirthSourceBound.lean) proves
$$
|U_n(u)|,\ |IU_n(u)|\le(\pi+1)\frac{u}{n\sqrt n}
\qquad(n\ge2,\ u\ge0).
$$
It derives convergence of the literal $\Lambda(n)/(n\sqrt n)$ sum from mathlib's Mangoldt Dirichlet-series theorem, then proves absolute complete birth/clock sums. The internal index $n+2$ includes every integer birth from $2$ onward and all proper prime powers.

[IntegerBirthLaplaceOrder.lean](BuildingBlocks/IntegerBirthLaplaceOrder.lean) derives both countable sum/integral exchanges, the full $\Lambda$-weighted Laplace interpolation inequality and its nonnegative defect for every $t>0$. [IntegerBirthExponentialHats.lean](BuildingBlocks/IntegerBirthExponentialHats.lean), theorem `actual_all_birth_hat_identity`, evaluates the half-open cell partition exactly:
$$
\sum_{n\ge2}\Lambda(n)\int_0^\infty e^{-tu}IU_n(u)du
=\frac{(1-e^{-t})^2}{e^{-t}t^2}
\sum_{n\ge2}\Lambda(n)\sum_{j\ge0}e^{-tj}U_n(j).
$$
The initial node vanishes by the proved $U_n(0)=0$. `actual_all_birth_defect_identity` retains the full integral of $IU_n-U_n$; `actual_discrete_laplace_order` proves its nonnegative sign.

These modules formalize the classical convex-interpolation mechanism on the actual birth kernel, including every required convergence step. The adapted target and main axiom checks passed with only `propext`, `Classical.choice` and `Quot.sound`. The original discrete feedback correspondence is now formalized below. The continuous Laplace identification, strict positivity and sharp cusp asymptotic remain separate written results.

## Formal discrete return and complete geometric correction

[IntegerBirthDiscreteCorrection](BuildingBlocks/IntegerBirthDiscreteCorrection.lean) retains the literal physical lower endpoint in the integer-age birth mass
$$
d_{n,0}=n^{-1/2},\qquad
d_{n,j}=\frac1{\sqrt j}\arctan\sqrt{\frac{j}{\max(1,n-j)}}\quad(j>0).
$$
For every integer $n\ge2$ and $j\ge0$, it proves
$$
d_{n,j}=q_n(j)-\mathbf1_{n\le j}\frac{\arctan(1/\sqrt j)}{\sqrt j}.
$$
The formal endpoint at $j=0$ is zero. With $b_j=\arctan(1/\sqrt j)/\sqrt j$, `actual_fixed_age_identity` gives the absolutely convergent full-power identity
$$
\sum_{n\ge2}\Lambda(n)\bigl[d_{n,j}-n^{-1/2}\bigr]+b_j\psi(j)
=\sum_{n\ge2}\Lambda(n)U_n(j).
$$
The $\psi$ here is the existing central `CoarsePrimitive.psi`, including the integer endpoint, rather than a new arithmetic definition.

[IntegerBirthDiscreteAbel](BuildingBlocks/IntegerBirthDiscreteAbel.lean) proves absolute convergence over both birth and clock indices for $0\le r<1$. Its `geometric_actual_source_identity` multiplies the last identity by $r^j$, sums every $j\ge0$, and justifies exchanging the full prime-power and clock sums. The correction remains $\sum_j r^jb_j\psi(j)$. These modules formalize the complete discrete endpoint correction and its Abel sum; the original feedback identification is supplied by the next formal dependency. Strict positivity of the interpolation defect and the sharp cusp asymptotic remain written. The adapted targets and aggregate compile, with only the three standard axioms in the principal theorem reports.


## Formal identification with the original feedback

[IntegerBirthHalfDensity.lean](BuildingBlocks/IntegerBirthHalfDensity.lean) proves absolute integrability and the exact clipped arctangent evaluation
$$
\int_1^\infty\frac{\mathbf1_{n\le x+j}}{2(x+j)\sqrt x}\,dx=d_{n,j}
\qquad(n\ge2,\ j\ge0).
$$
Both the zero clock and the physical endpoint $\max(1,n-j)$ are retained. [IntegerBirthDifferenceL1.lean](BuildingBlocks/IntegerBirthDifferenceL1.lean) bounds the absolute difference by its entering strip and common tail, then proves summability after multiplying by the full $\Lambda(n)$. Its countable Fubini theorem does not assume cancellation of divergent integrals.

[IntegerBirthOriginalDriver.lean](BuildingBlocks/IntegerBirthOriginalDriver.lean) identifies this series with the existing `SuccessorFeedback.driver`:
$$
e_j=\sum_{n\ge2}\Lambda(n)(d_{n,j+1}-d_{n,j}).
$$
For the already defined $E(r)=\sum_j e_jr^j$, `original_feedback_complete_return_identity` proves
$$
rE(r)+(1-r)\sum_{j\ge0}r^j b_j\psi(j)
=(1-r)\sum_{n\ge2}\sum_{j\ge0}r^j\Lambda(n)U_n(j),
\qquad 0<r<1.
$$
The definition of $E$ is unchanged, and $b_0=0$. The proof uses the original relative-charge integral, the literal $\psi$ prefix, absolute birth-difference integrability and Abel summation. These are classical integral and summation methods applied to the actual arithmetic source. The adapted modules and aggregate compile; the principal theorem axiom reports contain only `propext`, `Classical.choice` and `Quot.sound`. This certifies the arithmetic correspondence, not an RH-strength positivity bound.
