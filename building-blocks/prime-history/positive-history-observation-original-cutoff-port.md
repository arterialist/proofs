# The positive history observation and the original frozen source

This proof uses the [positive common-inner observation](coherent-core-positive-observation-inner-history.md). It identifies that observation on the literal finite source in the original physical $L^2$ metric. Its finite-cutoff remainder is an actual prime-minus-density tail. It is different from the positive division-lattice quadrature remainder.

Write
$$
0<t\le1,\qquad
Q(t)=\sqrt t\sum_{n\ge2}\Lambda(n)K(tn).
\tag{1}
$$
The geometric parameter is t=-log r. It is not a prime-process time. The actual scaling kernel satisfies
$$
\int_0^\infty K(u)\,du=0,\quad
K(u)=\frac1{6u^{3/2}}+O(u^{-5/2}),\quad
K'(u)=-\frac1{4u^{5/2}}+O(u^{-7/2}).
\tag{2}
$$
All assertions below keep every prime power.

## 1. The original source and the positive observation

For an integer $N\ge2$ set $A=\log N$ and
$$
a_N(v)=
\begin{cases}
e^{-v/2}[\psi(e^v)-e^v],&0\le v\le A,\\
e^{-v/2}[\psi(N)-N],&v>A,
\end{cases}
\qquad a_N(v)=0\quad(v<0).
\tag{3}
$$
This is the original finite source, including its frozen terminal tail. In particular its original squared norm contains exactly
$$
\int_A^\infty |a_N(v)|^2\,dv
=\frac{|\psi(N)-N|^2}{N}.
\tag{4}
$$
No mixed-energy norm replaces this expression.

Let $a_0(v)=e^{-v/2}$ on $v\ge0$ and zero otherwise. On causal $L^2$ define
$$
\mathcal V=-I+a_0*.
$$
Its Fourier multiplier is
$$
-1+\frac1{1/2+i\xi}=\frac{1/2-i\xi}{1/2+i\xi},
$$
so it is an isometry in the original $L^2$ norm. This is the common inner factor from the existing source construction.

Use the positive function V and seed from the cited history theorem:
$$
V(u)=-\int_0^u w(z)\,dz>0,\qquad
w(u)=u(uK'(u))',
$$
$$
k_t(v)=\frac{V(te^v)}{\sqrt{te^v}},\qquad
F_{\rm seed}(t)=\sqrt t\int_t^\infty\frac{V(u)}{u^2}\,du.
\tag{5}
$$
The full history identity is
$$
Q(t)=F_{\rm seed}(t)
+\int_0^\infty k_t(v)[a(v)-(a_0*a)(v)]\,dv.
\tag{6}
$$
It was proved using causal convolution and scalar absolute convergence; it does not assume that the full actual a is in global $L^2$.

For the finite source (3), both entries of the pairing are in original $L^2$. Indeed
$$
\|k_t\|_2^2=\int_t^\infty\frac{V(u)^2}{u^2}\,du
=\frac14\log(1/t)+O(1),
\tag{7}
$$
because $V(u)=\sqrt u/2+O(u^{3/2})$ at zero and $V(u)=3/(4\sqrt u)+O(u^{-3/2})$ at infinity. Consequently
$$
\left|\int_0^\infty k_t(v)(-\mathcal V a_N)(v)\,dv\right|
\le\|k_t\|_2\|a_N\|_2.
\tag{8}
$$
This is a metric-valid bound, not an unconditional estimate of the source norm.

## 2. Apply the adjoint before identifying the cutoff

The adjoint convolution may be taken inside the finite $L^2$ pairing. Directly,
$$
\begin{aligned}
[(I-a_0*)^*k_t](v)
&=k_t(v)-\int_v^\infty e^{-(s-v)/2}k_t(s)\,ds\\
&=\frac{V(z)}{\sqrt z}
-\sqrt z\int_z^\infty\frac{V(u)}{u^2}\,du,
\qquad z=te^v.
\end{aligned}
\tag{9}
$$
Since V'=-w and w(u)/u=(uK'(u))', integration by parts gives
$$
\int_z^\infty\frac{V(u)}{u^2}\,du
=\frac{V(z)}z+zK'(z).
\tag{10}
$$
The upper boundaries vanish by the actual large-u estimates. Thus the adjoint observation has the exact form
$$
\boxed{[(I-a_0*)^*k_t](v)=-(te^v)^{3/2}K'(te^v).}
\tag{11}
$$
It is signed; positivity of k_t is not positivity of this adjoint.

For a concise Stieltjes calculation define the finite signed measure
$$
\nu_N=\sum_{2\le n\le N}\Lambda(n)\delta_n
-\mathbf1_{[1,N]}(x)\,dx-\delta_1.
\tag{12}
$$
Then
$$
a_N(\log x)=x^{-1/2}\nu_N([1,x])\qquad(x\ge1).
$$
The atom $-\delta_1$ is the literal initial source value $a_N(0)=-1$. It is not a new subtraction.

Using (11), the change of variable x=exp v, and Stieltjes integration by parts,
$$
\begin{aligned}
I_N(t)
&:=\int_0^\infty k_t(v)(-\mathcal V a_N)(v)\,dv\\
&=-t^{3/2}\int_1^\infty K'(tx)\nu_N([1,x])\,dx\\
&=\sqrt t\int_{[1,N]}K(tx)\,d\nu_N(x)\\
&=\sqrt t\left[
\sum_{2\le n\le N}\Lambda(n)K(tn)
-\int_1^N K(tx)\,dx-K(t)\right].
\end{aligned}
\tag{13}
$$
One may verify the integration step by interchanging the finite measure with the integral of K'; the inner integral from x=y to infinity equals -K(ty)/t. Thus no convention at x=1 loses the initial atom. The frozen value $\nu_N([1,x])$ for $x>N$ remains throughout.

Integrating $w=u(uK')'$ also gives $V(t)=tK(t)-\int_0^t K(u)du-t^2K'(t)$, with zero lower boundary terms. Substituting this identity into (10) proves
$$
F_{\rm seed}(t)
=\sqrt t\left[K(t)-\frac1t\int_0^t K(u)\,du\right].
\tag{14}
$$
Combining (13)--(14) now gives the exact finite-source readout
$$
\boxed{
F_{\rm seed}(t)+I_N(t)
=\sqrt t\sum_{2\le n\le N}\Lambda(n)K(tn)
+t^{-1/2}\int_{tN}^\infty K(u)\,du.}
\tag{15}
$$
The second term in (15) is the complete continuous exterior contributed by the frozen source and its seed. It is not set to zero by the cutoff.

## 3. The remaining port is a signed prime-minus-density exterior

Subtracting (15) from (1) yields
$$
\boxed{
Q(t)-F_{\rm seed}(t)-I_N(t)=\mathcal P(t,N),}
$$
$$
\boxed{
\mathcal P(t,N)=\sqrt t\left[
\sum_{n>N}\Lambda(n)K(tn)-\int_N^\infty K(tx)\,dx\right].}
\tag{16}
$$
The product $n=N$ belongs to the finite core, so the discrete exterior is strict.

Let $e(x)=\psi(x)-x$, with right-continuous $\psi$. The full Stieltjes endpoint form is
$$
\boxed{
\mathcal P(t,N)
=-\sqrt t\,e(N)K(tN)
-t^{3/2}\int_N^\infty e(x)K'(tx)\,dx.}
\tag{17}
$$
The lower value is $e(N)$, including an arrival at N. At infinity the boundary is zero by Chebyshev and (2). Formula (17) displays the frozen source's arithmetic endpoint explicitly. Even when K is positive and K' negative on this exterior, the two occurrences of e are signed.

In contrast, the [division-lattice remainder](../geometry/finite-division-lattice-port-cancellation.md) is
$$
\Gamma_K(t)=\sqrt t\left[
\sum_{m\ge K}\log m\,L(tm)
-\int_K^\infty\log x\,L(tx)\,dx\right]\ge0
$$
on its proved tail range. Equations (16)--(17) do not identify $\mathcal P(t,N)$ with that quantity. Both are exact readouts of the actual arithmetic, with different finite-cutoff boundaries.

## 4. Valid moving-source approximations

For $tN\ge1$, the actual derivative estimates and Chebyshev give
$$
\boxed{|\mathcal P(t,N)|\le\frac{C}{t\sqrt N}.}
\tag{18}
$$
Indeed the boundary in (17) is at most $C\sqrt tN(tN)^{-3/2}$, and the integral is at most
$$
Ct^{3/2}\int_N^\infty x(tx)^{-5/2}dx
\le\frac{C}{t\sqrt N}.
$$
This proves convergence of the finite-source observation to (6) for each fixed t.

If one additionally consumes the classical actual PNT estimate
$|e(x)|\le Cx\exp(-c\sqrt{\log x})$, the identical argument gives
$$
|\mathcal P(t,N)|
\le\frac{C}{t\sqrt N}\exp[-c\sqrt{\log N}]
\tag{19}
$$
for sufficiently large $N$ and $tN\ge1$. No RH premise enters (18) or this established PNT consequence.

Thus a fully unconditional moving approximation follows from Chebyshev alone whenever $N=N(t)$ is an integer and $t\sqrt{N(t)}$ tends to infinity. For example
$$
N(t)=\left\lceil t^{-2}\log^2(2/t)\right\rceil
\quad\Longrightarrow\quad
\mathcal P(t,N(t))=O(1/\log(2/t)).
\tag{20}
$$
Using the stated PNT input, $N(t)=\lceil t^{-2}\rceil$ already gives $\mathcal P(t,N(t))\to0$.

At a linear cutoff $N=\lceil T/t\rceil$, fixed $T\ge1$, (18) instead has size $O_T(t^{-1/2})$. The stronger bound (19) does not tend to zero there either. This is a limitation of these proved bounds, not a lower bound or a divergence claim for the actual signed port. A smaller approximation error at that scale would require an additional arithmetic estimate.

Combining the [positive integer-birth interpolation](../successor-and-division/actual-integer-birth-positive-quadrature.md) with (16), the original-metric finite-source identity is finally
$$
\boxed{
E(e^{-t})=
b_t[F_{\rm seed}(t)+I_N(t)]-C(t)
+b_t\mathcal P(t,N)+D_{\rm int}(t),
\qquad b_t=\frac{t}{1-e^{-t}}.}
\tag{21}
$$
The last interpolation term is positive. The prime-minus-density port P is retained with its sign. The actual original norm in (8), the required arithmetic lower bound for I_N, and any sharper linear-cutoff estimate of P remain open inputs. Neither the inner isometry nor the positive observation proves them.

## Inputs and formal scope

The kernel and centered forcing come from the [scaling proof](../successor-and-division/successor-feedback-kernel-scaling.md) and [centered ODE](../geometry/actual-division-lattice-dual-cosine.md). Stieltjes integration by parts and the causal inner isometry are classical. The optional sharper remainder uses the established classical PNT bound; the Chebyshev-only estimate (18) is independent of it. This is a written proof in the original physical $L^2$ metric. The observation, signed port and moving-cutoff bounds are not asserted to be Lean formalized.
