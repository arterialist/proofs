# An explicit gap for the full continuous ground-state remainder

This written proof is an elementary conductance minorization followed by an exact two-cell spectral calculation. It applies to the [actual positive exterior ground state](theta-killed-return-ground-pole.md), without any extra regularity assumption or a Lean claim.

Fix $R>0$, $O_+=(R,\infty)$, $O_-=(-\infty,-R)$, write $O=O_+\cup O_-$, and let $\psi$ be the actual even positive exterior ground state. Put
$$
 d\gamma(u)=e^{-|u|/2}\psi(u)\Phi(u)\,du,
 \qquad a=\gamma(O)>0,\qquad A=a/2.
$$
The measure is finite: with $d\nu=2\cosh(u/2)\Phi(u)du$ and $\rho=e^{-|u|/2}/[2\cosh(u/2)]$, we have $d\gamma=\rho\psi\,d\nu$, and Cauchy–Schwarz applies to $\rho,\psi\in L^2(O,\nu)$. Its density is positive almost everywhere.

The continuous remainder after removing the complete-graph minorant is
$$
 \mathsf J_{\rm c}^{\rm rem}(du,dv)
 =\psi(u)\psi(v)\Phi(u)\Phi(v)
 \left[r(|u-v|)-e^{-(|u|+|v|)/2}\right]du\,dv,
$$
where $r(t)=e^{-t/2}/(1-e^{-2t})$. Denote its energy by
$$
 E_{\rm c}^{\rm rem}(F)
 =\frac12\iint|F(u)-F(v)|^2
                  \mathsf J_{\rm c}^{\rm rem}(du,dv).
\tag{1}
$$
The energy may initially take the value $+\infty$. All comparisons below hold for every $F\in L^2(\gamma)$. In particular they apply on the closed full remainder domain without additional regularity of $\psi$ or $F$.

## Two actual lower bounds for the kernel

For distinct $u,v$ on the same exterior half-line,
$$
 \frac{d\mathsf J_{\rm c}^{\rm rem}}{d(\gamma\otimes\gamma)}(u,v)
 =\frac{e^{\min(|u|,|v|)}}{1-e^{-2|u-v|}}-1
 \ge e^R-1=:h>0.
\tag{2}
$$
For opposite half-lines, with $t=|u|+|v|$, the ratio is exactly
$$
 \frac1{e^{2t}-1}>0.
\tag{3}
$$
Fix any width $\ell>0$, and let
$$
 I_+=(R,R+\ell),\qquad I_-=(-R-\ell,-R),\qquad
 b=\gamma(I_+)=\gamma(I_-),\qquad
 \beta=\frac1{e^{4(R+\ell)}-1}.
\tag{4}
$$
Positivity of the actual ground state and theta density gives $0<b<A$. Equations (2)–(3) imply the following finite positive measure minorant: its ratio to $\gamma\otimes\gamma$ is $h$ on each same-half-line square, $\beta$ on $I_+\times I_-$ and its transpose, and zero elsewhere. Write its energy as $E_*$. Explicitly,
$$
 E_*(F)=hA\sum_{\epsilon\in\{+,-\}}
       \int_{O_\epsilon}|F-\overline F_\epsilon|^2d\gamma
       +\beta\int_{I_+\times I_-}|F(u)-F(v)|^2
                    d\gamma(u)d\gamma(v),
\tag{5}
$$
where $\overline F_\epsilon=A^{-1}\int_{O_\epsilon}F\,d\gamma$. Thus $E_{\rm c}^{\rm rem}\ge E_*$. The factor in the bridge term already includes both directed rectangles and the factor $1/2$ in (1).

## Parity and the exact two-cell matrix

Reflection preserves $\gamma$ and the minorant. Its even and odd sectors are orthogonal for both the norm and the energy. Suppose $\gamma F=0$. For the even component, each half-line mean is zero. Equation (5) immediately gives
$$
 E_*(F_{\rm even})\ge hA\|F_{\rm even}\|_\gamma^2.
\tag{6}
$$
For an odd function write $f=F|_{O_+}$. Its norm is twice the positive-half norm. Dividing both energy and squared norm by two reduces (5) to
$$
 hA\int_{O_+}|f-\overline f|^2d\gamma
 +\beta b\int_{I_+}|f|^2d\gamma
 +\beta\left|\int_{I_+}f\,d\gamma\right|^2,
\tag{7}
$$
against $\|f\|_{L^2(O_+,\gamma)}^2$. This uses the exact identity
$\int_{I_+^2}|f(u)+f(v)|^2d\gamma^2
=2b\int_{I_+}|f|^2d\gamma+2|\int_{I_+}f\,d\gamma|^2$, valid also for complex functions.

Decompose the positive half-line into the two cells $I_+$ and $J_+=O_+\setminus I_+$, and split $f$ into its cell averages and its two zero-cell-mean fluctuations. These three parts are orthogonal for (7). The fluctuation coefficients are $hA+\beta b$ on $I_+$ and $hA$ on $J_+$. On the cell-constant subspace, use the orthonormal basis
$1_{I_+}/\sqrt b,1_{J_+}/\sqrt{A-b}$. The matrix of (7) is
$$
 M_*=
 \begin{pmatrix}
 h(A-b)+2\beta b&-h\sqrt{b(A-b)}\\
 -h\sqrt{b(A-b)}&hb
 \end{pmatrix}.
\tag{8}
$$
Its trace and determinant are
$$
 t_*=hA+2\beta b,\qquad d_*=2h\beta b^2.
$$
Both are strictly positive. Its smaller eigenvalue is
$$
 \eta=\frac{t_*-\sqrt{t_*^2-8h\beta b^2}}2>0.
\tag{9}
$$
It is at most the lower right diagonal entry $hb$, hence at most $hA$. Thus neither fluctuation sector nor the even sector reduces this lower bound. We obtain
$$
 \boxed{\quad
 E_{\rm c}^{\rm rem}(F)\ge
 hA\|F_{\rm even}\|_\gamma^2+
 \eta\|F_{\rm odd}\|_\gamma^2
 \ge\eta\|F\|_\gamma^2,
 \qquad \gamma F=0.
 \quad}
\tag{10}
$$
A simpler explicit constant, avoiding subtraction of two close numbers, is
$$
 \boxed{\quad
 \eta\ge\eta_0:=
 \frac{2h\beta b^2}{hA+2\beta b}>0.
 \quad}
\tag{11}
$$
Indeed the smaller eigenvalue equals the determinant divided by the larger eigenvalue, and the latter is at most the trace. One may fix $\ell=1$; the resulting bound depends only on $R,a$, and the actual strip mass $\gamma((R,R+1))$.

## Adding the complete internal prime remainder

Every internal prime-power edge has nonnegative conductance after multiplication by the positive ground-state factors. Adding all those edges to (1) therefore preserves (10), with no truncation. This conclusion concerns the full remainder, including its continuous part. It does not provide a positive gap for the prime edges taken alone.

For a $\gamma$-centered $H\in L^2(\gamma)$, the removed complete-graph energy is exactly

$$
\frac12\iint|H(u)-H(v)|^2d\gamma(u)d\gamma(v)
=a\|H\|_\gamma^2.
$$

Consequently the full transformed internal jump energy satisfies

$$
E_{\rm full}^{\psi}(H)
=a\|H\|_\gamma^2+E_{\rm rem}(H)
\ge(a+\eta)\|H\|_\gamma^2.
\tag{12}
$$

This also gives the energy-duality bound, for every centered $S\in L^2(\gamma)$,

$$
\sup_{\substack{H\in L^2(\gamma),\ \gamma H=0\\E_{\rm full}^{\psi}(H)<\infty}}
\left\{2\operatorname{Re}\langle S,H\rangle_\gamma-E_{\rm full}^{\psi}(H)\right\}
\le\frac{\|S\|_\gamma^2}{a+\eta}.
\tag{13}
$$

Indeed complete the square after Cauchy–Schwarz and (12). For an even source the denominator improves to $a+hA$; the even and odd sectors may also be bounded separately. The [complete covariance clock](theta-complete-ground-covariance-clock.md) proves the required maximal-domain equivalence and source mapping for the actual killed-resolvent covariance. Thus (13) applies to every actual centered core crossing source, with $S=f/\rho$. In its notation, $\mathcal C(f,f)\le\|f/\rho\|_\gamma^2/(a+\eta)$ and $D_{\rm all}(f)\ge\eta Q(f,f)/(a+\eta)$. The even-source improvement follows with the same domain justification.

The constant is strictly positive for every specified finite core and strip. No positive lower bound uniform as the core varies is asserted. Nor has this bound been shown to pay the full signed core deficit in the [constrained Schur comparison](theta-constrained-schur-across-ground-pole.md). The actual affine scalar term and both pole constraints remain part of that comparison.

The [actual radius-two comparison](theta-full-continuous-comparison-failure.md) proves that even the entire continuous-only covariance fails to pay the affine score deficit on that test. This is consistent with the strictly positive centered gap above; it does not sign the full prime-retained form.
