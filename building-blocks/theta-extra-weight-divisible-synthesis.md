# Actual synthesis with an arbitrarily small extra theta weight

This is a written mathematical proof for the complete theta kernel and its actual weighted Hilbert space. It is not a Lean theorem or a positivity proof. The cited entire-function and functional-analysis tools are classical; no priority claim is made.

Use the even mean-zero subspace $H_e^0$ of $H=L^2(\nu)$, its Fourier map $U$,
$G(z)=(z^2+1/4)\Xi(z)$, and the closed equality space $S$ from the [equality-space chapter](theta-equality-space.md). The two dependencies proved here are
[theta quotient indicator lens](theta-quotient-indicator-lens.md) and
[theta interior borel synthesis](theta-interior-borel-synthesis.md).

For $0<\epsilon<1$, define the stronger norm

$$
\|h\|_\epsilon^2=
\int_{\mathbb R}|h(u)|^2
\exp\{\epsilon\pi e^{2|u|}\}\,d\nu(u).
\tag{1}
$$

**Theorem.** Suppose $h$ is even, $\nu(h)=0$, $(Uh)/G$ is entire, and (1) is finite
for some $\epsilon>0$. Then $h\in S$. In particular, every such
divisible $h$ satisfying $|h(u)|\le C e^{A|u|}$ almost everywhere belongs to $S$.
No assertion that every divisible vector has this additional integrability
is made.

Reduce $\epsilon$ to $(0,1)$ if necessary. Write $F=Uh$ and
$E=F/G$. Weighted Cauchy–Schwarz gives

$$
|F(x+iy)|\le\sqrt M\,\|h\|_\epsilon
\left[\int\frac{\Phi(u)}{\cosh(u/2)}
e^{-\epsilon\pi e^{2|u|}}e^{-2yu}du\right]^{1/2}.
\tag{2}
$$

The full theta bound $\Phi(u)/\cosh(u/2)\le C\exp(4|u|-\pi e^{2|u|})$
therefore yields, with $Y=|y|$ tending to infinity,

$$
\log|F(x+iy)|
\le\frac Y2\log\frac{Y}{\pi(1+\epsilon)}
-\frac Y2+O_h(\log(Y+2)).
\tag{3}
$$

The bound is uniform in $x$. The gamma denominator asymptotic, entire
division, and real-axis sector argument in the first dependency apply
without change. Hence $E$ has finite exponential type and, for
$0<\theta<\pi$, its upper and reflected lower angular bounds have coefficient

$$
b_\epsilon(\theta)=
\frac12\sin\theta\log\frac{2\sin\theta}{1+\epsilon}
+\frac12\cos\theta(\pi/2-\theta).
\tag{4}
$$

In the indicator half-plane calculation this simply subtracts
$\log(1+\epsilon)/2$ from every upper graph bound for $|\Im w|$. Thus the
conjugate indicator diagram of $E$ is contained in

$$
K_\epsilon=\left\{a+ib:
|a|\le\frac12\arccos\frac{1+\epsilon}{2},\quad
|b|\le\frac12\log\frac{2\cos(2a)}{1+\epsilon}\right\}.
\tag{5}
$$

For each fixed $0<\epsilon<1$, this is compactly contained in the open
translation lens $K$ of the second dependency. Its real intercept is
strictly less than $\pi/6$, its imaginary intercept is strictly less than
$\log(2)/2$, and at every point of (5) the original graph inequality has the
strict margin $\log(1+\epsilon)/2$. The Borel-contour construction consequently
supplies even polynomials $P_n$ with

$$
\|GP_n-F\|_{\mathcal H}\longrightarrow0.
\tag{6}
$$

This is convergence in the actual Hilbert norm, so $h\in S$.

If $|h(u)|\le Ce^{A|u|}$, the full theta decay makes (1) finite for every
$\epsilon<1$. Letting $\epsilon$ increase to one in (5) also shows that $E$ has
indicator diagram $\{0\}$, it is of zero exponential type. The strict-interior
synthesis theorem still applies, since $\{0\}$ lies inside $K$. This observation
does not assert that $E$ must be a polynomial.

Let $D=S^\perp\cap B^\perp$ be the possible synthesis defect in the
[equality-space notation](theta-equality-space.md). Membership in $B^\perp$ is precisely the entire
divisibility condition in the even mean-zero space. Therefore the theorem
has the exact consequence

$$
\boxed{D\cap\{h:\|h\|_\epsilon<\infty\}=\{0\}
\qquad(\epsilon>0).}
\tag{7}
$$

Any nonzero defect vector must fail every extra theta-weighted $L^2$ bound
of the form (1). In particular it cannot have merely exponential growth.
This is a proved restriction on a possible defect, not a proof that the
defect vanishes. Density of the stronger weighted classes in the ambient
space does not imply their density in the divisible subspace; arbitrary
physical cutoffs lose its exact zero conditions.

The whole boundary synthesis question remains open. The essential-spectrum
threshold also does not automatically provide (1), either for arbitrary
vectors or for their projections into $D$. A separate regularity or bounded
approximation argument would be needed before using (7) to eliminate a
spectral obstruction. No sharp-gap or RH conclusion is drawn.
