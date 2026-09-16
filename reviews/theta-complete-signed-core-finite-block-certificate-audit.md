# Audit of the complete signed core finite-block certificate

This note audits `theta-complete-signed-core-finite-block-certificate.md`, with special attention to its equation (18).  The certificate is algebraically correct as a sufficient condition.  It is not presently an effective positivity certificate: two signed spectral inputs and the finite observation itself remain unevaluated, and the available scalar norm bounds cannot determine their signs.

## 1. The block inequality and equation (18)

Write

\[
 H=L_C+V,
 \qquad P=P_N,
 \qquad Q=I-P,
\]

where \(P_N\) is the spectral projection of \(L_C\) onto its first \(N\) eigenvectors.  Since \(P L_CQ=0\),

\[
 \|PHQ\|=\|PVQ\|\le\|V\|\le C_V.
\]

For \(x=x_0+x_1\), with \(x_0=Px\) and \(x_1=Qx\),

\[
 \begin{aligned}
 \langle Hx,x\rangle
 &\ge \lambda_{\min}(H_N)\|x_0\|^2
 +(\lambda_{N+1}-C_V)\|x_1\|^2
 -2C_V\|x_0\|\|x_1\|\\
 &\ge[\lambda_{\min}(H_N)-\varepsilon]\|x_0\|^2
 +\left[\lambda_{N+1}-C_V-\frac{C_V^2}{\varepsilon}\right]\|x_1\|^2.
 \end{aligned}
 \tag{1}
\]

Thus equation (17) of the source has the correct signs and the correct power \(C_V^2/\varepsilon\).  If \(h_N\) and \(\Lambda_{N+1}\) are rigorous lower enclosures for \(\lambda_{\min}(H_N)\) and \(\lambda_{N+1}\), while \(C_V\) is a rigorous upper enclosure, then

\[
 c_{\rm cert}:=\min\left\{
 h_N-\varepsilon,
 \Lambda_{N+1}-C_V-C_V^2/\varepsilon
 \right\}
 \tag{2}
\]

is a valid lower bound for \(H\).  This is the quantity called \(c_*\) in equation (18).  Renaming it \(c_{\rm cert}\) avoids confusion with unrelated theta-ratio constants.

For fixed enclosures, some \(\varepsilon>0\) makes both entries in (2) nonnegative exactly when

\[
 h_N>0,
 \qquad
 g_N:=\Lambda_{N+1}-C_V>0,
 \qquad
 h_Ng_N\ge C_V^2.
 \tag{3}
\]

Strict inequalities give \(c_{\rm cert}>0\).  Indeed the admissible interval is

\[
 \frac{C_V^2}{g_N}\le\varepsilon\le h_N.
 \tag{4}
\]

Equations (3)--(4) expose the two independent tasks hidden in (18): certify a positive signed low block, and push the complementary core eigenvalue far enough above the perturbation budget.

## 2. Audit of the finite matrix

With inner products linear in the first argument and

\[
 (u\otimes v)x=\langle x,v\rangle u,
\]

the matrix entries are

\[
 \begin{aligned}
 (H_N)_{ij}={}&(\lambda_j-\alpha)\delta_{ij}
 +m_j\overline{a_i}+a_j\overline{m_i}
 -a^{-1}\langle s_j,s_i\rangle_\gamma\\
 &+d_Q^{-1}k_j\overline{k_i}
 +\langle j_j,j_i\rangle_{\mathcal Z}.
 \end{aligned}
 \tag{5}
\]

The conjugations and all five signs in (5) are correct.  In particular:

- the two mean columns form the self-adjoint operator \(a_c\otimes1+1\otimes a_c\);
- the weighted square \(\mathcal S^*\mathcal S/a\) has the negative sign;
- minimizing the old affine odd quadratic contributes \(+k_Q\otimes k_Q/d_Q\);
- the retained finite prime observation contributes \(+J^*J\).

The definition

\[
 k_Q=\tau_C+a^{-1}\mathcal S^*q_\gamma
\]

also has the correct normalization, because

\[
 Q(Tx,q)=a^{-1}\langle\mathcal Sx,q_\gamma\rangle_\gamma.
\]

The observation must be applied after the same minimizing odd subtraction:

\[
 Jx=\mathcal O\left(Tx-\frac{\langle x,k_Q\rangle}{d_Q}q\right).
\]

Replacing this by an independently fitted coefficient would not certify the displayed signed form.

## 3. What each matrix entry requires

Every entry in (5) is in principle amenable to certified interval computation, but “finite matrix” does not mean “finite arithmetic input.”  The dependencies are as follows.

| Quantity | Required enclosure | Finite and infinite pieces |
|---|---|---|
| \(\lambda_j,e_j\) | Certified core eigenpairs and a lower bound for \(\lambda_{N+1}\) | \(L_C\) contains the singular continuous jump kernel and every prime-power shift. A Galerkin Ritz value alone is an upper eigenvalue bound; a complementary coercivity or verified spectral method is needed for the lower bounds used in (2). |
| \(m_j\) | Interval enclosure of \(\int_C e_j\,d\nu\) | Compact theta quadrature once \(e_j\) is certified. |
| \(a_j\) | Enclosure of \(\langle Be_j,\psi\rangle/\mu\) | Continuous core-to-exterior integral plus all prime-power crossing branches; the latter need a finite sum and a theta-decay tail. It also needs \(\psi\) and a positive lower bound for \(\mu\). |
| \(\langle s_j,s_i\rangle_\gamma\) | Weighted exterior Gram enclosure | Expand \(T e_j=Be_j-\langle e_j,a_c\rangle1\), integrate against \(\psi/\rho\), and bound the exterior theta tail. Signed cross terms require two-sided, not merely absolute upper, enclosures. |
| \(k_j\) | Enclosure of \(\langle e_j,\tau_C\rangle+a^{-1}\langle s_j,q_\gamma\rangle_\gamma\) | Compact first term; weighted exterior second term. It needs a positive lower bound for \(a\). |
| \(d_Q\) | Lower and, for entries, two-sided enclosure | The existing elementary lower bound \(d_Q\ge(e^R-1)^2\) pays norm denominators, but accurate matrix entries require the actual ratio \(\|q_\gamma\|_\gamma^2/a\). |
| \(j_j\) | Enclosure of finitely many observation coordinates | The chosen prime cutoff and output dimension are finite, but their measure contains \(\psi\) and the denominators \((a+\ell(u))(a+\ell(v))\). The rate \(\ell\) retains an infinite prime-power sum whose tail must be enclosed. |
| \(\alpha\) | Two-sided interval | The radius-two work gives \(1/2-10^{-20}\le\alpha<1/2-10^{-546}\), but a narrow interval may be needed to resolve the low-block sign. |

The continuous singularities are computable by subtracting the diagonal or by local Carleman coordinates.  The infinite prime sums are computable in principle by summing finitely many powers and applying the established super-polynomial theta envelope to the rest.  Those analytic tails are not the present conceptual obstruction.

## 4. What the perturbation constant requires

The scalar budget

\[
 C_V=\alpha+\frac{2b\sqrt{M_C}}\mu
 +\frac{M_S^2}{a}+\frac{M_k^2}{d_Q}+M_J^2
 \tag{6}
\]

is a valid upper bound.  Its dependency chain is

\[
 \begin{aligned}
 M_T&=b\sqrt{M_O}/\mu,\\
 M_S&=\sqrt{P_\infty}B_\rho+(b/\mu)Z_0,\\
 M_k&=\|\tau_C\|+M_SZ_q/a,\\
 M_J&=C_{\mathcal O}M_T+\|\mathcal Oq\|M_k/d_Q.
 \end{aligned}
 \tag{7}
\]

Here is the effective status of each scalar input.

- \(P_\infty\) now has a fully explicit, extremely large upper bound from the radius-two barrier.
- \(M_C,M_O,\|\tau_C\|,Z_0,Z_q\) have direct theta-integral upper enclosures once \(P_\infty\) is inserted.  Positive theta series and explicit tails make these ordinary interval quadratures.
- \(b\) and \(B_\rho\) can be bounded by local continuous-kernel estimates plus finite prime sums and explicit theta tails.  No sign information is needed for these norms.
- \(d_Q\ge(e^R-1)^2\) is already an explicit positive lower bound.
- Positive lower bounds for \(\mu\) and \(a\) follow symbolically from the finite-strip ground mass theorem, but still require evaluated hard-block constants \(d_S,b_S\).
- \(C_{\mathcal O}\) is explicit after a concrete observation cutoff is fixed.  The notation \(M\) in its bound \(C_{\mathcal O}^2\le2M(e^M+1)/a\) is the observation cutoff and should not be confused with the barrier height \(10^{500}\).

Thus (6) can become a number after hard-block and crossing quadratures.  Its enormous size is not a logical problem because \(\lambda_j\to\infty\), but it makes an effective lower bound for a very remote \(\lambda_{N+1}\) indispensable.

## 5. Two presently decisive missing constructions

### 5.1 The exterior ground profile

The barrier gives an upper bound for \(\|\psi\|_\infty\), not a certified approximation of \(\psi\).  The signed entries \(a_j,s_j,k_j,j_j\) require actual two-sided ground-profile integrals.  A residual estimate for a numerical exterior eigenfunction would normally divide by a spectral separation between \(\alpha\) and the rest of \(D\).  Simplicity and the gap from \(\alpha\) to the essential threshold \(1/2\) do not give an explicit separation from a possible second discrete exterior eigenvalue.  No such separation is currently evaluated.

The same issue enters the observation.  The existence proof for a finite \(\mathcal O_{M,J}\) uses compactness and a finite open cover; it does not output values of \(M,J\), the simple measurement functions, or a positive observation margin.  Moreover its truncation set is defined by inequalities involving \(\psi\) and the full rate \(\ell\).  Pointwise positivity of \(\psi\) supplies no rational lower enclosure on a selected interval.

Consequently there is not yet a concrete nonzero \(J\) whose entries in (5) can be evaluated.  Taking \(J=0\) is formally allowed as a lower observation, but it discards the only new positive arithmetic term and supplies no positivity mechanism.

### 5.2 Lower core spectral enclosures

Compact resolvent proves \(\lambda_{N+1}\to\infty\) qualitatively.  Equation (2) needs a certified lower enclosure at an explicitly selected, potentially enormous index.  Standard Rayleigh--Ritz computation gives upper enclosures.  A usable lower enclosure requires, for example, a verified complement estimate for the singular continuous operator plus all prime shifts, or a Lehmann--Goerisch type calculation with its hypotheses certified.  No such effective eigenvalue-counting bound is supplied.

The same computation must enclose \(\lambda_{\min}(H_N)\) from below.  This is the actual signed question: the negative weighted Gram matrix and the indefinite mean column must be combined with the positive odd and prime-observation matrices.  Separate norm bounds erase precisely that cancellation.

## 6. Positivity attempt and obstruction

The scalar estimates alone give only the Weyl bound

\[
 \lambda_{\min}(H_N)\ge\lambda_1-C_V.
 \tag{8}
\]

The currently available information is \(\lambda_1\ge0\) and an explicit positive upper bound for \(C_V\).  Therefore (8) is nonpositive and cannot pay the first entry of (2).  Increasing \(N\) does not improve this particular low-mode bound, because the first core direction remains in every compression.

This is a decisive obstruction to deriving \(c_{\rm cert}>0\) from the displayed norm ledger: operators with the same values of all those scalar upper bounds can have either sign on the first low mode.  The positive rank-one and observation terms cannot be credited through their operator norms; their actual matrix orientations are required.

Even if a lower bound for \(\lambda_{N+1}\) were supplied, condition (3) would still require \(h_N>0\).  Conversely, a positive finite matrix does not suffice until

\[
 h_N(\Lambda_{N+1}-C_V)>C_V^2
 \tag{9}
\]

is checked.  The presently written sources provide neither factor in (9) numerically.

Accordingly no rigorous positive value of equation (18) follows from the current inputs.  This does not refute the certificate or show that the complete signed form is negative.  It identifies the exact next data needed for an actual attempt:

1. a certified exterior ground approximation with enough spectral separation to enclose its signed integrals;
2. one explicitly specified finite observation and its full-rate denominators;
3. certified lower core eigenvalue bounds and interval enclosures of the signed matrix (5).

Once those are supplied, (3)--(4), rather than a search over arbitrary \(\varepsilon\), give the shortest rigorous positivity test.
