# Actual ground-state sign energy and its prime convolution

This is a written proof for the actual theta form, with no Lean claim. It uses the [complete ground covariance clock](theta-complete-ground-covariance-clock.md), its [weighted source domain](theta-groundstate-bounded-weighted-crossing.md), and the original [theta Weil form and score identities](theta-weil-jump-form.md). The method uses classical closed-form comparison, scalar optimization and the indicated exact theta/arithmetic identities; no priority claim is made.

Fix $R>0$, the actual even normalized exterior ground state $D_R\psi=\alpha\psi$, and $\lambda=1/2$. Set
$$
 g(u)=\Phi(u)\psi(u)1_{u>R},\qquad g^\vee(u)=g(-u),
 \qquad f=g+g^\vee=\Phi\psi1_O,\qquad d=\lambda-\alpha>0.
$$
The proved boundedness of $\psi$ gives $|g(u)|\le C_R\Phi(u)1_{u>R}$. Thus $g$ is in $L^1\cap L^2$, with every exponential moment, and is nonnegative. It belongs to the physical logarithmic form domain: $f$ does, and its two supports are separated by $2R$, so their separation introduces only a bounded cross form. No smoothness of $\psi$ is required below.

## The exact full sign energy

Write $\varepsilon(u)=\operatorname{sgn}(u)$ on $O$. Its transformed energy sees precisely jumps between the two exterior halves. Direct change of variables gives
$$
\boxed{\begin{aligned}
 E_\psi(\varepsilon)&=4(C_R+P_R),\\
 C_R&=\int_{2R}^\infty r(t)(g*g)(t)\,dt,\\
 P_R&=\sum_{n>e^{2R}}\frac{\Lambda(n)}{\sqrt n}(g*g)(\log n),
 \qquad r(t)=\frac{e^{-t/2}}{1-e^{-2t}}.
\end{aligned}}
\tag{1}
$$
Both orientations, the squared sign difference $4$, and the energy factor $1/2$ have been included. The discrete sum is over all integers with their von Mangoldt weights, and therefore includes every prime power. The equality case $\log n=2R$ contributes zero: the convolution of the two positive-half histories is zero there, regardless of representatives at the boundary.

The convolution is continuous. The series in (1) converges absolutely, since in each convolution pair at least one argument is at least $(\log n)/2$; the bounded ground state and the full theta tail then dominate the series over all integers. The same bounds justify the continuous integral and all positive expansions below.

For the actual charge and odd pole column,
$$
 a=2\int_R^\infty e^{-u/2}g(u)\,du,
 \qquad H=\langle\tau,\psi\varepsilon\rangle_\nu
       =4\int_R^\infty\sinh(u/2)g(u)\,du.
\tag{2}
$$
In particular $H/a=b_q\ge e^R-1$. Both quantities are positive.

## Entire Laplace transform and an absolute Dirichlet identity

Define the entire transform
$$
 G(z)=\int_R^\infty e^{-zu}g(u)\,du.
$$
Local uniform convergence on the whole complex plane follows from the theta envelope for $g$. The continuous term has the positive exact expansion
$$
 C_R=\sum_{j\ge0}G(2j+\tfrac12)^2,
 \qquad
 \frac{a^2}{4}\le C_R\le\frac{a^2}{4(1-e^{-4R})}.
\tag{3}
$$
Also $a=2G(1/2)$ and $H=2[G(-1/2)-G(1/2)]$.

For any fixed $c>1/2$, Fourier inversion of the convolution, followed by absolute Fubini, gives
$$
\boxed{\quad
 P_R=\frac1{2\pi}\int_{\mathbb R}
 \left[-\frac{\zeta'}{\zeta}(c+\tfrac12-i\xi)\right]
 G(-c+i\xi)^2\,d\xi.
 \quad}
\tag{4}
$$
Indeed $e^{cu}g(u)\in L^2$, so $G(-c+i\xi)^2\in L^1(d\xi)$. Its inverse Fourier transform is $e^{ct}(g*g)(t)$, continuously. The full Dirichlet series
$\sum\Lambda(n)n^{-c-1/2+i\xi}$ converges absolutely and is uniformly bounded on this line. This proves all interchanges in (4). No critical-strip Dirichlet convergence or contour displacement is used. The transform is squared, not replaced by its absolute square; all two-history phase cross terms remain.

## What the negative ground energy forces exactly

Let $A$ be the physical digamma Fourier multiplier and $S$ the complete physical prime translation operator. Write $K=A-S$ and use $K(h)=\langle h,(A-S)h\rangle$ for its quadratic form. The actual ground equation gives
$$
 K(f)=\alpha-\lambda=-d,
 \qquad \|\psi\|_{L^2(\nu_O)}=1.
$$
Since the two supports of $g$ and $g^\vee$ are disjoint, their physical cross pairing is
$$
 \langle g,(A-S)g^\vee\rangle=-C_R-P_R.
$$
The continuous sign is negative because off-diagonal arrivals enter $A$ with a minus sign; the prime term is also subtracted. Consequently
$$
\boxed{\quad
 E_\psi(\varepsilon)=4K(g)+2d,
 \qquad P_R=K(g)+d/2-C_R.
 \quad}
\tag{5}
$$
In particular, the same-side term cannot be discarded. In unitary Fourier normalization it is
$$
 K(g)=\int_{\mathbb R}\mathfrak a(\xi)|\widehat g(\xi)|^2d\xi
 -2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
       \int_R^\infty g(u)g(u+\log n)\,du,
\tag{6}
$$
where $\mathfrak a(\xi)=\operatorname{Re}\psi_{\rm digamma}(1/4+i\xi/2)-\log\pi$. Every same-side prime-power autocorrelation remains. Its series converges by the same theta envelope. Thus ground negativity is an exact relation among kinetic energy, same-side correlations, and opposite-side prime convolution; it is not a sign assumption on a prime Hankel operator.

## A quantitative physical-frequency restriction on the actual ground history

There is a further bound specific to this ground history. Let $\mathfrak a_0=\mathfrak a(0)<0$, $\omega=\sqrt{\Phi/b}$, and let the established complete-prime exterior norm bound be
$$
 \|K_{\rm p}-1_CK_{\rm p}1_C\|\le\Gamma_R,
 \qquad
 \delta_R=|\mathfrak a_0|\sup_O\omega^2+\Gamma_R.
$$
The prime operator here is conjugated to $L^2(du)$ by $\sqrt{b\Phi}$. Since $\psi$ has norm one and exterior support, the actual ground identity gives
$$
\begin{aligned}
 \int(\mathfrak a-\mathfrak a_0)|\widehat f|^2
 &=\langle f,Sf\rangle-\mathfrak a_0\|f\|_2^2-d\\
 &\le\Gamma_R+|\mathfrak a_0|\sup_O\omega^2
 =\delta_R.
\end{aligned}
\tag{7}
$$
Here the first term is bounded using the complete normalized prime operator, not an unsupported unweighted norm bound for $S$.

Splitting the nonnegative multiplier $A-\mathfrak a_0$ into the same two disjoint histories gives exactly
$$
 \int(\mathfrak a-\mathfrak a_0)|\widehat g|^2
 =\frac12\int(\mathfrak a-\mathfrak a_0)|\widehat f|^2+C_R.
$$
Combining (3) and (7) proves
$$
\boxed{\quad
 \int(\mathfrak a-\mathfrak a_0)|\widehat g|^2
 \le\frac{\delta_R}{2}
      +\frac{a^2}{4(1-e^{-4R})}
 \le\frac{\delta_R}{2}
      +\frac{\|\rho\|_{L^2(\nu_O)}^2}{4(1-e^{-4R})}
 =:\mathcal D_R.
 \quad}
\tag{8}
$$
The last inequality uses $a=\langle\rho,\psi\rangle$ and $\|\psi\|_2=1$. Thus the ground-state equation provides an explicit absolute logarithmic-frequency budget. The multiplier difference is positive and increasing in $|\xi|$, as follows from its convergent digamma series. For every $T>0$,
$$
 \int_{|\xi|\ge T}|\widehat g(\xi)|^2d\xi
 \le\frac{\mathcal D_R}{\mathfrak a(T)-\mathfrak a_0}.
\tag{9}
$$
This is a genuine restriction on the actual history, rather than a consequence of generic positivity of $g$. Its decay in the frequency threshold is only logarithmic. It does not supply a bound relative to $H^2$, and therefore does not by itself control the normalized prime sample in (1).

## The remaining arithmetic comparison

The sign-channel requirement $E_\psi(\varepsilon)/H^2\ge1/2$ would require
$$
 P_R\ge H^2/8-C_R.
\tag{10}
$$
By (3), the continuous contribution relative to $H^2$ is at most
$1/[4b_q^2(1-e^{-4R})]$, which is small for large cores. Neither (5) nor the absolute frequency estimate (8) proves (10): they retain the same-side prime correlations and lack a lower bound for the opposite-side convolution sample at the required pole normalization. Formula (4) supplies an exact absolutely convergent Mellin/Dirichlet version of that sample, and (8) is an additional ground-compatible constraint available to its analysis. No concentration assumption, uniform short-interval PNT quadrature, or deletion of the pole column has been used.

For clarity, the density comparison itself has an exact remainder. With the continuous test $h=g*g$,
$$
 P_R=G(-1/2)^2+\mathcal R_g,\qquad
 \mathcal R_g=\int_{(0,\infty)}e^{-t/2}h(t)
                     \,d[\psi_{\rm Ch}(e^t)-e^t].
\tag{11}
$$
This Stieltjes pairing exists absolutely as the difference of its prime and density integrals; it does not differentiate $g$. Its test vanishes on $[0,2R]$, so the origin and lower endpoint contribute zero. The theta tails control the infinite endpoint. In particular the density value alone has the exact ratio
$$
 \frac{G(-1/2)^2}{H^2}
 =\frac1{4[1-G(1/2)/G(-1/2)]^2}\ge\frac14.
$$
Since $G(1/2)/G(-1/2)\le e^{-R}$, this ratio tends to $1/4$ as the core grows, uniformly over nonzero positive histories with that support. Thus the density value is indeed about twice the necessary prime scale $H^2/8$. For example, the one-sided estimate $\mathcal R_g\ge-G(-1/2)^2/2$ would suffice for (10), even without using the positive continuous term. Such a uniform relative quadrature estimate for the actual ground history has not been established; ordinary PNT for fixed smooth tests cannot be substituted for it.
