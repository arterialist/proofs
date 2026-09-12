# Global zero-mode synthesis for regular complementary vectors

This is a written mathematical proof for the complete theta kernel and its actual weighted Hilbert space. It is not a Lean theorem or a positivity proof. The cited entire-function and functional-analysis tools are classical; no priority claim is made.

Use the full theta kernel and the exact Hilbert space
$$
d\nu(u)=M^{-1}\cosh(u/2)\Phi(u)\,du,\qquad M=1/2,
\qquad H=L^2(\nu).
$$
Let $H_e^0$ be the even subspace with original mean $\nu h=0$. All orthogonal complements below are relative to $H_e^0$, with the original $H$ inner product, linear in its first argument. Put
$$
Uh(z)=\int_{\mathbb R}\Phi(u)h(u)e^{izu}\,du,
\qquad G(z)=(z^2+1/4)\Xi(z),
$$
$$
S=\overline{\operatorname{span}\{\Phi^{(2j)}/\Phi-4^{-j}:j\ge1\}}^H.
$$
Let $B$ be the closed span in $H_e^0$ of
$\cos(\zeta u)/\cosh(u/2)$, for every actual xi zero $\zeta$, together with the parameter derivatives of orders below each zero's multiplicity. All off-real zeros are retained. The exact evaluation identities give
$$
Z:=B^\perp=\{k\in H_e^0:(Uk)/G\text{ is entire}\},\qquad S\subset Z.
\tag{1}
$$

Write $\theta(u)=\pi e^{2|u|}$ and, for $0<\epsilon<1$, define
$$
H_{\pm\epsilon}=L^2(e^{\pm\epsilon\theta}\,d\nu),
\qquad \|h\|_{\pm\epsilon}^2=\int|h|^2e^{\pm\epsilon\theta}\,d\nu.
\tag{2}
$$
These are auxiliary norms. They do not change the mean, the equality vectors, the zero modes, or the operator.

**Theorem.** For every $0<\epsilon<1$,
$$
\boxed{H_e^0\cap S^\perp\cap H_{\epsilon}\ \subseteq\ B.}
\tag{3}
$$
More precisely, every $k\in Z$ is a limit of finite original equality combinations in the weaker norm $H_{-\epsilon}$. Pairing this approximation with $h\in H_\epsilon$ proves (3). The theorem does not assume that $(Uh)/G$ is entire.

## The weaker space still has the required exact transforms

The full real theta bounds give
$\Phi(u)\asymp e^{9|u|/2-\theta(u)}$ in the tails. Therefore
$$
\int e^{\epsilon\theta}\,d\nu<\infty\qquad(0<\epsilon<1).
$$
Cauchy-Schwarz makes the original mean $k\mapsto\nu k$ continuous on $H_{-\epsilon}$. Its even mean-zero kernel is consequently a closed subspace of that weaker Hilbert space.

Every derivative evaluation of $U$ is also continuous there, since
$$
|(Uk)^{(j)}(z)|\le \sqrt M\,\|k\|_{-\epsilon}
\left[\int_{\mathbb R}\frac{\Phi(u)}{\cosh(u/2)}
 e^{\epsilon\theta(u)}|u|^{2j}e^{-2\operatorname{Im}(z)u}\,du\right]^{1/2}.
\tag{4}
$$
On compact sets of $z$, the last integrand is bounded by a constant times
$\exp\{-(1-\epsilon)\theta(u)+C|u|\}$. This also justifies holomorphy of $Uk$ on the entire plane. The same Cauchy-Schwarz estimate with absolute values proves $\Phi k\in L^1(du)$. Thus $U$ is injective on $H_{-\epsilon}$, by ordinary Fourier uniqueness on the real line.

## A larger translation domain absorbs the original closed indicator lens

The actual divisible-quotient theorem proved in
[theta quotient indicator lens](theta-quotient-indicator-lens.md) says that for each $k\in Z$, the entire even function $E=(Uk)/G$ has finite exponential type and conjugate indicator diagram contained in
$$
\overline K=\left\{a+ib: |a|\le\pi/6,\quad
|b|\le\tfrac12\log(2\cos2a)\right\}.
\tag{5}
$$
This input uses the original $H$ norm of $k$. It is not a claim that every vector in the weaker space has the same diagram bound.

Set $\Psi=-\Phi''+\Phi/4$, so that $\widehat\Psi=G$, and define
$$
T(w)(u)=\frac{\Psi(u+iw)+\Psi(u-iw)}{2\Phi(u)}.
\tag{6}
$$
In the principal theta strip, the weaker norm admits the larger open convex lens
$$
K_{-\epsilon}=\left\{a+ib:
|a|<\tfrac12\arccos\frac{1-\epsilon}{2},\quad
|b|<\tfrac12\log\frac{2\cos2a}{1-\epsilon}\right\}.
\tag{7}
$$
Indeed, the full complex theta estimates, including each fixed derivative, bound the integrand of $\|T(w)\|_{-\epsilon}^2$ by
$$
C\exp\left\{-\bigl[2e^{-2|\operatorname{Im}w|}
\cos(2\operatorname{Re}w)-(1-\epsilon)\bigr]\theta(u)+C|u|\right\}
\tag{8}
$$
locally uniformly on (7). The positive bracket gives Hilbert-valued holomorphy there. On the entire original closed lens (5), that bracket is at least $\epsilon$. Consequently
$$
\overline K\Subset K_{-\epsilon}.
\tag{9}
$$

For small purely imaginary $w$, real translation gives $UT(w)=G\cosh(wz)$. Equation (4) and analytic uniqueness extend this identity to (7). In particular $T(w)$ is even with original mean zero. Its Taylor coefficients at zero are finite original equality combinations, because
$$
T^{(2n)}(0)=(-1)^n\Psi^{(2n)}/\Phi,
\qquad \Psi^{(2n)}/\Phi=-e_{n+1}+e_n/4,
\quad e_0=0.
\tag{10}
$$
Let $V_{-\epsilon}$ denote the closure of these finite equality combinations in $H_{-\epsilon}$. The holomorphic map $T$ takes values in $V_{-\epsilon}$ near zero by its norm Taylor series. Its image in the Hilbert quotient by $V_{-\epsilon}$ is holomorphic and locally zero. Connectedness and analytic uniqueness therefore give $T(w)\in V_{-\epsilon}$ throughout (7). The finite Taylor-continuation construction in [theta interior borel synthesis](theta-interior-borel-synthesis.md) also gives explicit approximants.

Choose a Borel contour enclosing the diagram of $E$ and lying compactly inside (7), which is possible by (9). The Borel-Pólya representation and the same Bochner integral as in [theta interior borel synthesis](theta-interior-borel-synthesis.md) give
$$
k_* = \frac1{2\pi i}\oint_\Gamma \mathcal B_E(w)T(w)\,dw
\in V_{-\epsilon},\qquad Uk_*=GE=Uk.
\tag{11}
$$
All evaluations commute with the integral by (4). Injectivity of $U$ on $H_{-\epsilon}$ identifies $k_*=k$. Thus finite equality combinations $k_n$, each belonging to the original $H$, satisfy
$$
\|k-k_n\|_{-\epsilon}\longrightarrow0.
\tag{12}
$$

## The original pairing transfers the approximation

Let $h\in H_e^0\cap S^\perp\cap H_\epsilon$, and take arbitrary $k\in Z$. Each $k_n$ in (12) is an original equality combination, so $\langle h,k_n\rangle_H=0$. Exact weighted duality gives
$$
|\langle h,k-k_n\rangle_H|
\le\|h\|_\epsilon\|k-k_n\|_{-\epsilon}\longrightarrow0.
\tag{13}
$$
Hence $h\perp Z=B^\perp$ in $H_e^0$, proving $h\in B$. No regularity property of a projection onto a possible synthesis defect was used.

## Application to the actual subthreshold eigenspace

The actual jump-operator tail estimate in [section 13 of the eigenfunction chapter](theta-jump-eigenfunction-regularity.md) gives $h\in H_\epsilon$ for some $\epsilon>0$ whenever $Ah=\kappa h$, $0<\kappa<1/2$. Decrease $\epsilon$ below one if needed. Such an eigenvector is orthogonal to constants and to the equality eigenspace at $1/2$. Therefore its even part, if nonzero, satisfies every hypothesis of (3):
$$
\boxed{\text{Every even actual eigenvector with }0<\kappa<1/2
\text{ belongs to }B.}
\tag{14}
$$
This argument proves Hilbert-norm synthesis for regular vectors. The [stronger-weight theorem](theta-stronger-weight-synthesis.md) and the independent [weighted smoothing proof](theta-zero-mode-form-smoothing.md) establish the later form-norm refinement. The [odd chapter](theta-odd-zero-mode-synthesis.md) retains its separate equality space and pole constraint. Full synthesis for arbitrary vectors and positivity on the remaining zero-mode space are not proved.
