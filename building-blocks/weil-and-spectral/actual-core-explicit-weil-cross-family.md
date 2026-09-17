# An explicit two-source Weil family for the actual coherent core

The actual coherent core admits an explicit signed two-source factorization with computable pole data. The cross term need not be positive. The [theta-domain and correlated-cutoff theorem](../theta-and-heat/coherent-core-theta-domain-and-cutoff.md) proves that the uncut source quotients have infinite theta norm and supplies the renormalized paired identity instead.

Let $t=-\log r>0$ and use the complete [actual scaling kernel](../successor-and-division/successor-feedback-kernel-scaling.md) $K$. Put

$$
h_t(v)=-\sqrt{te^{|v|}}\,K(te^{|v|}),\qquad v\in\mathbb R.
\tag{1}
$$

This is real, even and continuous. It is smooth away from zero, with a finite first-derivative jump at zero, and decays like $e^{-|v|}$ at either infinity. The prime contribution in the standard even Weil functional is exactly

$$
-2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}h_t(\log n)
=2\sqrt t\sum_{n\ge2}\Lambda(n)K(tn)=2Q(t).
\tag{2}
$$

Every prime power is included, and the series converges absolutely for each fixed $t$. The archimedean and pole terms are not included in Q and must be added according to the full Weil formula. The even cusp at zero has not been smoothed away.

## A positive convolution square is not the correct factorization

Let $V_t=\log(1/t)$, for $t<1$. The actual small- and large-argument bounds on K show

$$
h_t(V_t y)\longrightarrow\mathbf1_{|y|<1}
\quad\text{in }L^1(\mathbb R,dy).
\tag{3}
$$

Indeed the convergence holds pointwise away from the two boundary points. On $|y|\le1$ the functions are uniformly bounded. On $|y|>1$ the large-argument bound is at most $Ce^{-V_t(|y|-1)}$, which has vanishing integral for $V_t$ tending to infinity. With the Fourier convention $\widehat f(\xi)=\int e^{-i\xi v}f(v)dv$, (3) gives

$$
\frac1{V_t}\widehat h_t(\xi/V_t)
\longrightarrow\frac{2\sin\xi}{\xi}.
\tag{4}
$$

At $\xi=3\pi/2$ this limit is negative. Therefore $h_t$ is not positive definite for all sufficiently small $t$, and cannot be the autocorrelation of a single $L^2$ source. No zero computation or truncation of prime powers is used in this test.

## A fixed reference and an explicit variable cross-source

Fix $\beta\in(1/2,1)$, and define

$$
u(v)=\sqrt{2\beta}\,e^{-\beta v}\mathbf1_{v\ge0},\qquad
z_t(v)=\frac{(\beta-\partial_v)h_t(v)}{\sqrt{2\beta}}.
\tag{5}
$$

The derivative in (5) is the weak first derivative; h_t is continuous, so it has no delta mass there. Both $u$ and $z_t$ are in $L^2$ and have finite absolute exponential moments for $|s|\le1/2$. They are locally BV with finitely many derivative contacts and exponential tails. Their Fourier transforms have $O((1+|\xi|)^{-1})$ decay, sufficient for finite logarithmic Fourier form energy.

Direct Fourier calculation gives

$$
\widehat u(\xi)=\frac{\sqrt{2\beta}}{\beta+i\xi},\qquad
\widehat z_t(\xi)=\frac{\beta-i\xi}{\sqrt{2\beta}}\widehat h_t(\xi),
$$

and hence, for reflection $\widetilde z(v)=\overline{z(-v)}$,

$$
\boxed{u*\widetilde z_t=h_t.}
\tag{6}
$$

The reverse cross term equals h_t as well, since h_t is real and even. Consequently

$$
\boxed{h_t=g_{+,t}*\widetilde g_{+,t}
-g_{-,t}*\widetilde g_{-,t},\qquad
 g_{\pm,t}=(u\pm z_t)/2.}
\tag{7}
$$

This retains an explicit two-source Gram representation. It does not turn the difference of its two diagonal form values into a positive quantity. The fixed reference has norm one; the variable source has squared norm $O_\beta(1+\log(1/t))$, while its weak derivative construction and the full cancellation in (7) stay exact.

The Weil formula can be defined on these kernels through their absolutely convergent prime and archimedean terms and their finite exponential pole integrals. Alternatively, truncate and smooth the sources, retaining the pole integrals and contacts in the limit. The exponential margin $\beta>1/2$ permits the prime tails to pass in this fixed-t approximation. This does not assert boundedness in an additional theta-weighted Hilbert norm; the uncut quotients have infinite theta norm, as proved in the linked domain theorem.

## Pole products and the actual moment cancellation

For $M_s(f)=\int e^{sv}f(v)dv$, integration by parts gives

$$
M_s(u)=\frac{\sqrt{2\beta}}{\beta-s},\qquad
M_s(z_t)=\frac{\beta+s}{\sqrt{2\beta}}M_s(h_t)
\quad(|s|\le1/2).
\tag{8}
$$

Thus $M_s(u)M_{-s}(z_t)=M_s(h_t)$, using evenness of $h_t$. These are the actual pole cross products, not zero constraints.

There is nevertheless a useful cancellation specific to K. At $s=1/2$,

$$
H_t:=M_{1/2}(h_t)=M_{-1/2}(h_t)
=-t^{-1/2}\int_t^\infty K(u)du
-\sqrt t\int_t^\infty\frac{K(u)}u du.
\tag{9}
$$

Let $c_0=\pi^{3/2}/2$. The zero moment and the local expansion $K(u)=-u^{-1/2}+c_0+O(\sqrt u)$ imply

$$
\int_t^\infty K(u)du=2\sqrt t-c_0t+O(t^{3/2}),
$$

$$
\int_t^\infty K(u)\frac{du}u
=-2t^{-1/2}+c_0\log(1/t)+O(1).
$$

The constants -2 and +2 in (9) cancel exactly. Therefore

$$
\boxed{H_t=-\frac{\pi^{3/2}}2\sqrt t\log(1/t)+O(\sqrt t).}
\tag{10}
$$

The variable source z_t consequently has both pole values of size $O(\sqrt t\log(1/t))$. They can be removed by two fixed compact smooth counterprofiles with an invertible exponential-moment matrix, at that same source coefficient cost. The fixed reference u retains its nonzero pole coordinates.

This small value does not mean that every pole-related cross correction is small. The first spectral derivative is large. Differentiating the two exact integrals defining M_s(h_t), and using the checked logarithmic K moment, gives

$$
\partial_s M_s(h_t)|_{s=1/2}
=-\frac{\pi^{3/2}}{2\sqrt t}+O(1+\sqrt t\log^2(1/t)).
\tag{11}
$$

The coarse error written here suffices to distinguish its scale. Thus projecting BOTH sources onto the two-pole-null subspace must retain the fixed-reference/variable-source cross terms explicitly. Smallness of (10) does not justify discarding those terms or asserting the double pole-zero conditions of a pole-null autocorrelation.

## The original arithmetic identity and the missing comparison

Let $W(h)$ denote the full Weil functional and $A_{\rm pole,arch}(h)$ its pole plus archimedean terms, so $W(h_t)=A_{\rm pole,arch}(h_t)+2Q(t)$. Their complete integral expression is retained in the [correlated-cutoff theorem](../theta-and-heat/coherent-core-theta-domain-and-cutoff.md).

The [integer-birth interpolation identity](../successor-and-division/actual-integer-birth-positive-quadrature.md) then yields

$$
\boxed{E(e^{-t})=
\frac{b_t}{2}W(h_t)
-\frac{b_t}{2}A_{\rm pole,arch}(h_t)-C(t)+D(t),
\quad b_t=\frac{t}{1-e^{-t}},\ D(t)>0.}
\tag{12}
$$

Both source diagonals in (7), their pole products, the full archimedean term, the physical return C(t), and the positive interpolation defect D(t) remain present. At a finite source cutoff, the [original physical cutoff port](../prime-history/positive-history-observation-original-cutoff-port.md) is signed and must also be retained; it is not the positive division exterior Gamma_K.

The [correlated ground identity](../theta-and-heat/coherent-core-theta-domain-and-cutoff.md) acts on compact cutoffs of the row (5), retaining both derivative ports and the divergent cross counterterm. The uncut quotients cannot be inserted as finite-theta-norm sources. Single-square positivity is excluded by (4), and the two-source identity alone supplies no lower bound for the cross row in (12). The missing constant-scale coherent-core comparison is unchanged by this representation.

## Attribution and formal scope

Fourier correlation factorization and polarization are classical. The source-specific zero and logarithmic moments used here are proved in the [complete kernel moment theorem](../successor-and-division/successor-division-kernel-moments.md). The full archimedean and pole normalization is the [actual theta Weil form](../theta-and-heat/theta-weil-jump-form.md). This chapter preserves a written construction and its exact obstruction to a single positive square; it makes no Lean or arithmetic sign claim.

The [exact radical projection](actual-core-Weil-arch-row-radical-projection.md) removes both source pole moments while preserving the full physical Weil pairing. Its prime-port constant is exactly compensated by the archimedean row. This supplies a pole-null pair but does not remove the theta-domain obstruction or prove its cross-row sign.
