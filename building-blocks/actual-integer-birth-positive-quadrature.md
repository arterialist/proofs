# Positive quadrature from the actual integer birth cusps

Written proof. The complete arithmetic histories and endpoint conventions are part of each statement. No Lean formalization or unconditional feedback-sign conclusion is asserted here.

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
