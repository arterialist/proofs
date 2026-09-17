# The equality space, its orthogonal complement, and the remaining jump form

This written proof recovers the exact equality span, its local convolution annihilator and its Fourier division ideal. The arbitrary-weight boundary synthesis question is kept separate from the later regular-vector theorems.

Use the exact form and normalization of [ground-state chapter](theta-weil-jump-form.md):
$$
d\nu=M^{-1}\cosh(u/2)\Phi(u)du,\quad M=1/2,
\quad\lambda=2M^2=1/2,
\quad\Xi(z)=\int\Phi(u)e^{izu}du.
$$
Write $H=L^2(\nu)$, let $H_e^0$ be its even mean-zero subspace, and put
$$
q_n=\Phi^{(n)}/\Phi,\qquad
e_j=q_{2j}-2^{-2j},\qquad
S=\overline{\operatorname{span}\{e_j:j\ge1\}}^{H}.
\tag{1}
$$
The inner product is linear in its first argument. No zero-location or positivity premise is made in this note.

## The orthogonal complement is an exact local convolution nullspace

For $h\in H$ define
$$
C_h(z)=\frac1M\int_{\mathbb R}
h(u)\cosh(u/2)\Phi(u+z)du.
\tag{2}
$$
This is a holomorphic function on the connected domain
$$
\mathcal D=\{z=x+iy: |y|<\pi/4,
\quad2e^{-2|x|}\cos(2y)>1\}.
\tag{3}
$$
In particular the domain contains $|x|<\log(2)/2$ on the real axis and $|y|<\pi/6$ on the imaginary axis. It is not being asserted that this convolution exists for every real shift and every $h\in H$.

Here is the needed domination. On each compact subset of D, the theta series and evenness give a polynomial-exponential prefactor times
$$
|\Phi(u+z)|\le C\exp\{-\pi e^{2|u|}
e^{-2|x|}\cos(2y)+C|u|\}.
$$
The actual positive real kernel has its first-term asymptotic with exponent -pi exp(2|u|). Thus
$$
\int\frac{\cosh(u/2)|\Phi(u+z)|^2}{\Phi(u)}du<\infty
$$
locally uniformly on D. The strict inequality in (3) supplies the remaining positive exponential margin. The same estimate with fixed derivative prefactors justifies holomorphy and differentiation under the integral. Cauchy-Schwarz now proves (2) for every h in H and gives
$$
C_h^{(n)}(0)=\langle h,q_n\rangle_H.
\tag{4}
$$

For even $h$, $C_h$ is even and $C_h(0)=\nu(h)$. Analytic uniqueness therefore gives the complete description
$$
\boxed{S^{\perp}\cap H_e^0
=\{h\in H_e^0:C_h(z)=0\text{ for every }z\in\mathcal D\}.}
\tag{5}
$$
For general h in H, the exact condition is
$$
\frac{C_h(z)+C_h(-z)}2=\nu(h)\cosh(z/2).
\tag{6}
$$
Consequently the full orthogonal complement is the orthogonal direct sum of constants, all odd functions, and the nullspace (5).

Equivalently, S is the closed span of the centered even translated kernels
$$
\frac{\Phi(u+z)+\Phi(u-z)}{2\Phi(u)}-\cosh(z/2),
\qquad z\in\mathcal D.
\tag{7}
$$
The Hilbert-valued holomorphic Taylor series proves one inclusion; difference quotients and analytic uniqueness prove the other. Small real z already suffice. Thus this is an actual closure characterization, not a formal expansion of shifted functions outside their weighted integrability domain.

## Every xi zero gives complementary modes, including off-line zeros

For any complex zeta with Xi(zeta)=0, put
$$
b_\zeta(u)=\frac{\cos(\zeta u)}{\cosh(u/2)}.
\tag{8}
$$
This is in H_e^0. Direct integration, initially for real shifts and then by analytic uniqueness on D, gives
$$
C_{b_\zeta}(z)=\frac{\Xi(\zeta)}M\cos(\zeta z)=0.
\tag{9}
$$
Thus b_zeta belongs to the complement (5), without requiring zeta to be real. If zeta is a zero of multiplicity m, all parameter derivatives of (8) of orders 0 through m-1 also belong to that complement. Differentiating (9) retains the relevant zero multiplicities exactly.

Thus $e^{i\gamma u}/\cosh(u/2)$ is orthogonal to every $q_n$ when $\Xi(\gamma)=0$. Its even part gives (8); its odd part is automatically orthogonal to the even equality space. The same calculation works for every off-line zero.

The complement is infinite dimensional. There are infinitely many xi zeros, and any finite set of the modes (8) with distinct zeta^2 is linearly independent by independence of exponential polynomials. No critical-line zero theorem is needed for this argument. For completeness, finiteness of all xi zeros would contradict its even entire order-at-most-one factorization: it would then be an exponential times a polynomial, evenness would remove the nonconstant exponential, and its real-axis decay would contradict a nonzero polynomial. The order bound follows directly from the full theta decay, giving log max |Xi|=O(R log(R+2)), and real-axis decay follows from Fourier integrability.

In particular, density of the equality modes in the even mean-zero Hilbert space is false. They have infinite codimension.

## The exact Fourier-space ideal and the possible synthesis defect

Define the injective Hilbert-space transform
$$
(Uh)(z)=\int_{\mathbb R}\Phi(u)h(u)e^{izu}du.
\tag{10}
$$
Give its image the norm transported from H. Each evaluation and each derivative evaluation is continuous, since Cauchy-Schwarz bounds it by a constant times
$$
\left[\int_{\mathbb R}
\frac{\Phi(u)}{\cosh(u/2)}|u|^{2k}e^{-2\Im(z)u}du\right]^{1/2}.
$$
This defines an actual reproducing-kernel Hilbert space of entire functions. The even mean-zero image Hcal_e^0 consists of the even transforms with F(i/2)=0. Its inherited norm, not an unweighted real-line norm, is essential here.

The equality modes transform exactly to
$$
Ue_j(z)=\Xi(z)[(-1)^jz^{2j}-2^{-2j}].
$$
Writing G(z)=(z^2+1/4)Xi(z), this proves
$$
\boxed{US=\overline{G(z)\mathbb C[z^2]}^{\mathcal H_e^0}.}
\tag{11}
$$
The factor z^2+1/4 retains the pole evaluations that enforce the mean-zero condition.

Let Zcal be the closed subspace of Hcal_e^0 consisting of transforms vanishing at every zero of Xi with its multiplicity. Equivalently, F/G extends to an entire even function. Let B be the closed span in H_e^0 of all modes (8) and their multiplicity derivatives. The evaluation identity
$$
(Uh)(\zeta)=M\langle h,b_{\bar\zeta}\rangle_H
$$
and its differentiated version show
$$
U^{-1}\mathcal Z=B^\perp,\qquad
S\subset B^\perp,
$$
and consequently
$$
\boxed{S^\perp\cap H_e^0=B\oplus D,
\qquad D=H_e^0\cap S^\perp\cap B^\perp.}
\tag{12}
$$
Here $D$, with both orthogonal complements restricted to $H_e^0$, has a precise meaning: it is the potential defect in approximating the entire-divisible subspace Zcal by G times even polynomials. Claiming that all complementary vectors are limits of zero modes is exactly the additional assertion D=0. No such spectral-synthesis theorem is proved here.

In particular one cannot import a translation-invariant spectral-synthesis theorem without checking this weight and topology. The convolution available for arbitrary h in H is only local in (3), and the Hilbert space has superexponential physical-space weight after multiplication by Phi. The exact descriptions (5), (11), and (12) do not need such an import.

## The equality span is a reducing eigenspace for the closed jump form

Take the closure of the nonnegative jump form E=E_arch+E_prime initially on compact smooth functions. Its closability follows directly from the positive jump measure: an L2-convergent, energy-Cauchy sequence has an almost-everywhere subsequence, including on each translated prime-jump graph because nu is equivalent to Lebesgue measure. Fatou then identifies the limiting differences. Let D(E) denote this closed form domain.

The weighted cutoff statement in the [ground-state chapter](theta-weil-jump-form.md) places every e_j in D(E). Polarizing the full radical identity, not just its diagonal equality, gives for every form-domain h
$$
E(e_j,h)=\lambda\langle e_j,h\rangle_H.
\tag{13}
$$
The pole rank-one term vanishes because e_j is even, and its mean vanishes. Extension from compact tests follows by form continuity. Thus each e_j is a genuine eigenvector of the self-adjoint jump operator at lambda.

For finite linear combinations s, E(s)=lambda ||s||^2. This identity makes the Hilbert closure S also its form closure; every s in S lies in D(E), and (13) holds with s in place of e_j. If P_S is the orthogonal projection onto S, then for every mean-zero h in D(E), both P_Sh and k=(I-P_S)h lie in D(E), and
$$
\boxed{E(h)-\lambda\|h\|^2
=E(k)-\lambda\|k\|^2.}
\tag{14}
$$
All cross terms cancel exactly. This is a quotient-form reduction with the positive form closed before any spectral-gap assertion is made.

On the even mean-zero subspace, the left side of (14) is precisely Q(Phi h). Hence the even part of the required sharp inequality lives entirely on the explicit complement (5), or equivalently (12). For the full inequality the odd subspace must also be handled. It is unaffected by projecting out S.

One may remove the additional odd equality directions
$$
q_{2j+1}-2^{-2j}q_1,\qquad j\ge1,
$$
by the same argument. Their means and tau moments vanish, and polarization again gives eigenvalue lambda. This does not eliminate the complementary zero modes or establish a lower bound there.

## The quotient retains the complete zero pairing

For every smooth insertion allowed in the original note, write F=Uh. The exact zero side is
$$
\boxed{Q(\Phi h)=\sum_\rho
F(z_\rho)\overline{F(\overline{z_\rho})},
\qquad z_\rho=(\rho-1/2)/i.}
\tag{15}
$$
The sum is over all nontrivial zeros with multiplicities. Each term is unchanged when a finite equality combination is subtracted, since its transform contains the factor Xi. The same evaluation invariance holds for subtraction of any s in S because individual evaluations are Hilbert-continuous. Equation (14) supplies the corresponding closed-form invariance.

A real zero gamma contributes a positive modulus square. A nonreal conjugate pair zeta, conjugate(zeta) contributes
$$
2m\Re\{F(\zeta)\overline{F(\bar\zeta)}\}
=m\left(\left|\frac{F(\zeta)+F(\bar\zeta)}{\sqrt2}\right|^2
-\left|\frac{F(\zeta)-F(\bar\zeta)}{\sqrt2}\right|^2\right).
\tag{16}
$$
Evenness duplicates the corresponding pair at opposite signs when those are distinct. There is no replacement by absolute squares at off-line zeros. Formula (16) displays the sign that remains unresolved in the quotient; arbitrary independent interpolation of all these coordinates is not presumed.

For a general projected form-domain vector, one must use the form limit in (14). The absolute spectral-series statement in the original note is available on its smooth domain. Passing that series term by term to every L2 or form limit would need additional summability estimates. Neither equality-mode closure nor continuity of each individual evaluation alone licenses this passage.

For an explicit family entirely inside the complementary smooth domain, set
$$
T(z)=\int_{\mathbb R}\frac{\Phi(u)}{\cosh(u/2)}e^{izu}du.
$$
Then for each zero mode b_zeta,
$$
Ub_\zeta(z)=\tfrac12[T(z+\zeta)+T(z-\zeta)].
\tag{17}
$$
Inserting (17) into (15) gives its exact quotient-form matrix, with every critical and off-line zero retained. Its Hilbert Gram matrix is separately
$$
\langle b_\zeta,b_\omega\rangle_H
=\frac{T(\zeta-\bar\omega)+T(\zeta+\bar\omega)}{2M}.
\tag{18}
$$
Positivity of the Gram matrix is Hilbert-space positivity and does not imply positivity of the Weil matrix (15). Even proving the latter on every finite set of zero modes would require a form-core theorem, not just L2 density, before extending to the whole complement.

Equations (5), (12) and (14) give the local convolution nullspace, the possible synthesis defect and the reducing-space formula. Radical identities remove a genuine eigenspace, but they leave an infinite-dimensional complement carrying all zero evaluations. No density argument based only on those identities can establish the sharp gap, and no RH conclusion is drawn here.

The [quotient-growth](theta-quotient-indicator-lens.md), [Borel synthesis](theta-interior-borel-synthesis.md), [weighted-duality](theta-regular-zero-mode-synthesis.md) and [smoothing](theta-zero-mode-form-smoothing.md) chapters prove further synthesis results for regular vectors. They leave the unrestricted boundary question explicit. The [isolator theorem](theta-jump-eigenfunction-regularity.md) also shows that repeated zeros can produce threshold eigenvectors outside $S$; $S$ is a reducing equality eigenspace, not an identification of the full threshold eigenspace.
