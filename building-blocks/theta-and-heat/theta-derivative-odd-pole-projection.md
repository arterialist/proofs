# Theta derivative and the odd pole-removed Weil form

Status: a written exact orthogonalization and an RH-equivalent positivity statement. This does not prove positivity or advance an RH bound. The normalization and theta radical are those of [the existing theta Weil form](theta-weil-jump-form.md).

## Form, normalization, and cutoff domain

Let $Q_W$ be the classical Weil form, with Fourier convention $\widehat f(t)=\int f(x)e^{itx}\,dx$, and write $Q_W=Q_L+Q_P$, where
$$
Q_L(f)=\frac1{2\pi}\int_{\mathbb R}
\left[\Re\psi\!\left(\tfrac14+\tfrac{it}{2}\right)-\log\pi\right]
|\widehat f(t)|^2\,dt
-2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}\Re C_f(\log n),
\qquad C_f(t)=\int f(x+t)\overline{f(x)}\,dx.
$$
The pole kernel is $P(x,y)=2\cosh((x-y)/2)$. On odd functions, putting $s(x)=\sinh(x/2)$ and $m(f)=\int s(x)f(x)\,dx$, this becomes
$$
Q_P(f)=-2|m(f)|^2,\qquad Q_W(f)=Q_L(f)-2|m(f)|^2.
\tag{1}
$$

Use the real, even theta kernel with $\widehat\Phi(t)=\xi(1/2+it)$ and the normalization $\xi(0)=\xi(1)=1/2$. Put $h_0=-\Phi'$. Theta decay implies that every derivative of $h_0$ is integrable and bounded after multiplication by $e^{B|x|}$, for every $B>0$.

Here is a sufficient quantitative cutoff condition. Fix $\beta>1/2$ and define
$$
\|f\|_{\beta,2}=
\sum_{j=0}^{2}\left(
\|e^{\beta|x|}f^{(j)}\|_1+
\|e^{\beta|x|}f^{(j)}\|_\infty\right).
$$
The polarized forms $Q_L,Q_W$, and the moment $m$, are continuous in this norm on smooth functions for which it is finite. For the prime part,
$$
|C_{f,g}(t)|\le
e^{-\beta|t|}
\|e^{\beta|x|}f\|_\infty
\|e^{\beta|x|}g\|_1,
\quad
\sum_{n\ge2}\frac{\Lambda(n)}{n^{\beta+1/2}}<\infty.
$$
For the archimedean part, two integrations by parts give Fourier decay $O((1+|t|)^{-2})$, while the digamma multiplier is $O(\log(2+|t|))$. Pole moments follow from $\beta>1/2$.

Choose even smooth cutoffs $\chi_R$, equal to one on $[-R,R]$, supported in $[-R-1,R+1]$, with uniformly bounded derivatives of each fixed order. Then $h_R=\chi_Rh_0$ is odd and compactly supported, and $h_R\to h_0$ in every fixed norm above. The same applies to a compact test plus a fixed multiple of $h_0$. No positivity assumption is used in these limits.

## Exact projection

The polarized explicit formula gives
$$
Q_W(h_0,f)=0.
\tag{2}
$$
Indeed, $\widehat h_0(z)=iz\,\xi(1/2+iz)$ vanishes at every zero evaluation in that formula, independently of RH. The cutoff extension to theta derivatives is justified by their weighted decay and the unconditional zero count $N(T)=O(T\log T)$; see [the theta radical and its domain](theta-weil-jump-form.md).

Integration by parts and the pole moments give
$$
m(h_0)=\frac12\int\cosh(x/2)\Phi(x)\,dx=\frac14.
$$
With the Hermitian form linear in its first argument, (1) and (2) imply
$$
Q_L(f,h_0)=\frac12m(f),\qquad Q_L(h_0)=\frac18.
\tag{3}
$$
Equivalently, $Lh_0=s/2$ distributionally on odd tests.

For every odd compact smooth $f$, set
$$
g=f-4m(f)h_0.
$$
Then $m(g)=0$, and direct polarization of (3) yields the unconditional identities
$$
\boxed{Q_L(f)=Q_L(g)+2|m(f)|^2,\qquad Q_W(f)=Q_L(g).}
\tag{4}
$$
The vector $g$ need not be compact, but belongs to the cutoff domain just established.

## Why the remaining positivity is exactly RH

If $Q_L\ge0$ on odd compact smooth tests, its two-by-two Gram matrices with $h_R$ are positive semidefinite. Passing to the cutoff limit and applying Cauchy–Schwarz gives
$$
Q_L(f)\ge
\frac{|Q_L(f,h_0)|^2}{Q_L(h_0)}
=2|m(f)|^2.
$$
Thus $Q_W(f)\ge0$ on all odd compact tests. The odd-function Weil criterion implies RH. For the distinction between nonnegative and strictly positive formulations, unconditional nondegeneracy on compact tests and polarization promote nonnegativity to strict positivity: a null odd test would pair to zero with all odd tests, and parity makes its pairings with even tests zero as well.

Conversely, RH gives $Q_W(f)\ge0$, so (1) gives $Q_L(f)\ge0$. Therefore
$$
\boxed{\quad
Q_L(f)\ge0\ \text{for every odd }f\in C_c^\infty(\mathbb R)
\quad\Longleftrightarrow\quad {\rm RH}.
\quad}
$$

In particular, any negative odd Weil witness projects by (4) to a negative $L$-witness in the extended domain; sufficiently large compact cutoffs preserve strict negativity. Removing the pole term does not discard that obstruction. Pointwise positivity of $\Phi$ supplies the normalization and radical, but does not supply positivity of $L$, whose actual prime term still has an uncontrolled sign.

The external ingredients are the classical explicit formula and H. Yoshida's odd-test criterion and compact-test nondegeneracy, *On Hermitian forms attached to zeta functions*, Adv. Stud. Pure Math. 21 (1992), 281–325, Propositions 1–2. The odd-test criterion is quoted in [Suzuki 2026, introduction](https://arxiv.org/html/2606.09096v1#S1.SS1); compact-test nondegeneracy is explicitly attributed to Yoshida in [Suzuki 2023, Section 5.4](https://arxiv.org/html/2206.03682v4#S5.SS4). Equation (4) is the elementary rank-one projection in the stated normalization, not a new positivity theorem.
