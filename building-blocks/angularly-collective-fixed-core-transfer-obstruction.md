# Angularly collective transfer still has no fixed-core right inverse

This note tests the angularly collective route left open by the complete-core range obstruction.  Angular mixing
can remove the literal compactness of the infinite tensor product
\(I\otimes\mathcal S\), but it cannot produce a lower singular bound.  For
every fixed \(X\), any transfer through finitely many copies of the actual
fixed-core crossing map either loses a positive actual Lambert direction
or has no bounded right inverse.

The result applies to tensor/local transfers and to arbitrary bounded
finite-channel angular analysis followed by the fixed-core crossing map.
It does not exclude an abstract Hilbert-space isometry unrelated to the
crossing source equation, or a new nonlinear/global arithmetic estimate.

## 1. Joint source space and the literal late-clock sequence

Let

\[
 \Theta_X=(-X^{-1/2},X^{-1/2}),\qquad
 d\omega_X(\theta)=|1-re^{i\theta}|^{-2}\frac{d\theta}{2\pi},
\]

and retain the exact bulk field

\[
 F_X(\theta,t)=(1-e^{-t})
 \sum_{d\in\mathcal B_X}\mu(d)
 \frac{r^de^{id\theta}}{1-e^{-t}r^de^{id\theta}}.
\tag{1}
\]

The joint positive source space is

\[
 \mathscr K_X=L^2(\Theta_X\times(0,\infty),
 d\omega_X(\theta)w(t)dt).
\tag{2}
\]

Its moving far-domain projection is multiplication by
\(1_{t>b_\varepsilon(\theta)}\).  Put

\[
 P_X(\theta)=\sum_{d\in\mathcal B_X}
 \mu(d)r^de^{id\theta}.
\tag{3}
\]

For sufficiently large \(X\), the bulk contains a prime, so \(P_X\) is a
nonzero finite trigonometric polynomial.  Moreover

\[
 F_X(\theta,t)=P_X(\theta)+O_X(e^{-t})
\tag{4}
\]

uniformly on \(\Theta_X\).  Choose disjoint dyadic intervals
\(I_j=[T_j,2T_j]\) above every moving lower endpoint and define

\[
 g_j=\frac{1_{I_j}(t)F_X(\theta,t)}
 {\|1_{I_j}F_X\|_{\mathscr K_X}}.
\tag{5}
\]

Because the clock supports are disjoint, \(\{g_j\}\) is exactly
orthonormal.  Since \(w(t)\asymp t^{-2}\),

\[
 \|1_{I_j}F_X\|_{\mathscr K_X}^2
 \sim \frac1{2T_j}
 \int_{\Theta_X}|P_X(\theta)|^2d\omega_X(\theta)>0.
\tag{6}
\]

Thus this is a sequence inside the actual finite-\(X\) uncentered bulk
family, obtained only by decomposing its positive clock integral.

## 2. Exact joint density matching

Let \(d\gamma=\rho\psi\,d\nu\), and let

\[
 (U^\gamma f)(\theta,u)=
 \left[\frac{e^uw(e^u)}
 {\rho(u)\psi(u)b(u)\Phi(u)}\right]^{1/2}
 f(\theta,e^u).
\tag{7}
\]

Then

\[
 \|U^\gamma f\|_{L^2(\Theta_X,d\omega_X;L^2(\gamma))}
 =\|f\|_{\mathscr K_X}.
\tag{8}
\]

Consequently \(U^\gamma g_j\) remains orthonormal.  The exact
\(P_\infty\) bound is sufficient to evaluate upper norms in the core
certificate, but (8) shows that it supplies no compression of these
sources and no lower bound for the crossing map.

## 3. Finite angular mixing before crossing

Let

\[
 \mathcal S:D(E_C)\longrightarrow L^2(\gamma),\qquad
 \mathcal Sx=\rho^{-1}
 (Bx-\langle x,a_c\rangle1),
\tag{9}
\]

be the actual compact fixed-core source map.  Suppose angular processing
produces \(N<\infty\) channels.  Write

\[
 A_X:\mathscr K_X\longrightarrow L^2(\gamma)^N
\tag{10}
\]

for the combined density matching and angular analysis, and

\[
 \mathcal S_N=\mathcal S\oplus\cdots\oplus\mathcal S:
 D(E_C)^N\longrightarrow L^2(\gamma)^N.
\tag{11}
\]

The finite direct sum \(\mathcal S_N\) is compact.

A form-preserving angular analysis on the actual shell space must have a
positive lower frame bound

\[
 \|A_Xf\|\ge c_X\|f\|_{\mathscr K_X}
 \quad(f\in\overline{\operatorname {span}}\{g_j\}),
 \qquad c_X>0.
\tag{12}
\]

Otherwise it has already lost a positive part of the original joint
quadratic form.  Assume there were a bounded linear right inverse through
the core,

\[
 R_X:\overline{\operatorname {span}}\{g_j\}
 \longrightarrow D(E_C)^N,
 \qquad
 \mathcal S_NR_X=A_X.
\tag{13}
\]

The sequence \(R_Xg_j\) is bounded.  Compactness of \(\mathcal S_N\)
would make \(A_Xg_j\) precompact.  But (12) gives, for \(j\ne k\),

\[
 \|A_Xg_j-A_Xg_k\|
 \ge c_X\|g_j-g_k\|=c_X\sqrt2.
\tag{14}
\]

It has no Cauchy subsequence, a contradiction.  Therefore

\[
 \boxed{\text{no bounded finite-channel angularly collective right
 inverse through the fixed-core crossing map exists on the actual
 shell-stable bulk source space.}}
\tag{15}
\]

This includes integrating \(\theta\) first and then applying one copy of
\(\mathcal S\).  If the angular functional pairs nontrivially with
\(P_X\), the separated clock sequence survives and (15) applies.  If it
annihilates \(P_X\), it deletes the radial mean responsible for the
positive limit in (6), so it is not form preserving.

## 4. Infinitely many local angular channels

The pointwise tensor map

\[
 I_{L^2(\Theta_X)}\otimes\mathcal S
\tag{16}
\]

need not be compact; compactness is not stable under tensoring with an
infinite-dimensional identity.  This is the one place where angular
integration changes the earlier argument.

It still has zero lower singular value.  Indeed, fix any normalized
angular profile and tensor it with a normalized sequence on which
\(\mathcal S\) tends to zero.  Equivalently,

\[
 \inf\sigma_{\rm sing}(I\otimes\mathcal S)
 =\inf\sigma_{\rm sing}(\mathcal S)=0.
\tag{17}
\]

Equation (17) by itself rules out only a bounded inverse on the whole
tensor product.  It does not by itself rule out an inverse on the actual
Lambert shell span.  That stronger conclusion follows from the fixed
angular asymptotic as follows.

Put

\[
 h_X=\frac{P_X}{\|P_X\|_{L^2(d\omega_X)}},\qquad
 W_j=\int_{I_j}w(t)dt,
\tag{18}
\]

and let \(k_j\in L^2(\gamma)\) be the exact density-matched image of
\(1_{I_j}/\sqrt{W_j}\).  The \(k_j\) are orthonormal because their
\(u=\log t\) supports are disjoint.  Uniformly in \(\theta\), (4) gives

\[
 \|1_{I_j}(F_X-P_X)\|_{\mathscr K_X}
 \le C_Xe^{-T_j}\sqrt{W_j},
\tag{19}
\]

while

\[
 \|1_{I_j}F_X\|_{\mathscr K_X}
 =\|P_X\|_{L^2(d\omega_X)}\sqrt{W_j}
 (1+O_X(e^{-T_j})).
\tag{20}
\]

The isometry (8) therefore gives the quantitative tensor approximation

\[
 U^\gamma g_j=h_X\otimes k_j+e_j,
 \qquad \|e_j\|\le C_Xe^{-T_j}.
\tag{21}
\]

Suppose a bounded local right inverse existed on the actual shell span:

\[
 R_X:\overline{\operatorname {span}}\{g_j\}
 \longrightarrow L^2(\Theta_X,d\omega_X;D(E_C)),
 \qquad
 (I\otimes\mathcal S)R_Xg_j=U^\gamma g_j.
\tag{22}
\]

Write \(x_j=R_Xg_j\).  These joint core vectors are bounded.  Apply the
bounded angular projection

\[
 \Pi_{h_X}x=\int_{\Theta_X}
 \overline{h_X(\theta)}x(\theta)d\omega_X(\theta),
 \qquad z_j=\Pi_{h_X}x_j.
\tag{23}
\]

Then \(z_j\) is bounded in \(D(E_C)\), and bounded Bochner integration
commutes with the crossing map:

\[
 \mathcal Sz_j
 =\Pi_{h_X}(I\otimes\mathcal S)x_j
 =k_j+\eta_j,
 \qquad \|\eta_j\|\le C_Xe^{-T_j}.
\tag{24}
\]

For \(j\ne k\), orthogonality of the disjoint clock shells yields

\[
 \|\mathcal Sz_j-\mathcal Sz_k\|
 \ge\sqrt2-C_X(e^{-T_j}+e^{-T_k}).
\tag{25}
\]

After discarding finitely many indices, the right side is bounded below by
one.  Thus \(\{\mathcal Sz_j\}\) has no Cauchy subsequence, contradicting
compactness of \(\mathcal S:D(E_C)\to L^2(\gamma)\).  This proves on the
actual shell span, rather than merely on the ambient tensor product,

\[
 \boxed{I\otimes\mathcal S\text{ has no bounded right inverse satisfying
 the exact source equation (22).}}
\tag{26}
\]

The generic zero lower singular value (17) remains useful background, but
the actual-source conclusion is (19)--(26).

## 5. Radial, truncation, and the \((1,2)\) row

The construction uses the uncentered field (1), so its leading angular
profile (3) is exactly the radial mean.  The central angular interval and
the moving clock boundary are unchanged.  Restricting to \(I_j\) is a
partition of the already truncated positive integral and introduces no
full-circle orthogonality.

Before any angular analysis, (1) has the complete expansion

\[
 F_X=\sum_{a\ge1}p_a(t)S_{X/a}^{\rm bulk}(a\theta).
\tag{27}
\]

The ordered pairs \((1,2)\) and \((2,1)\) therefore remain, with exact
positive shell coefficient

\[
 2\int_{I_j}(1-e^{-t})^2e^{-t}w(t)dt>0
\tag{28}
\]

and the unchanged affine Möbius row

\[
 I_{1,2}(h;\theta)=
 \sum_e\mu(e)\mu(2e+h)
 \frac{\operatorname {Re}
 [A_{2e+h}(\theta)\overline{A_{2e}(\theta)}]}
 {|1-re^{i\theta}|^2}.
\tag{29}
\]

A finite angular analysis may put (29) in its kernel only by discarding
that source direction.  Such a map cannot be called form preserving for
the complete signed field.

## 6. Precise scope

Equations (15) and (26) rule out:

1. pointwise/tensor application of the fixed-core crossing map;
2. integrating angle into any fixed finite number of channels before
   applying the crossing map;
3. any bounded linear angular analysis with a lower frame bound on the
   actual clock-shell span, followed by a bounded right inverse through
   finitely many fixed-core copies.

They do **not** rule out every bounded linear map between the two abstract
Hilbert spaces.  Infinite-dimensional separable Hilbert spaces admit
artificial isometries, but such an isometry need not satisfy the crossing
source equation (9), preserve the arithmetic dilation action, or connect
the Lambert form to the signed core operator \(H\).  Nor does the argument
exclude a map defined only on the single unsplit vector \(F_X\); that would
not transfer the quadratic form on its source span or justify shellwise
estimates.

The only route left is a genuinely nonlocal arithmetic theorem that pays
the clock shells collectively without a bounded crossing right inverse.
In current notation it is precisely

\[
 \mathfrak A_X^{\rm bulk}\ll_\varepsilon X^{1+\varepsilon},
\tag{30}
\]

equivalently the required
\(\mathcal R_X^\varepsilon\ll_\varepsilon X^{2+\varepsilon}\), with the
radial, truncation, and affine rows retained.  The complete signed core
certificate and the explicit ground bound do not prove (21).
