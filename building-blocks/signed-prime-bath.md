# A signed prime-form estimate with a certified local bath

This fixed-support theorem proves coercivity on an infinite-dimensional orthogonal complement, using exact prime translations and an all-frequency estimate. Its scalar constants have a rational certificate. The retained finite-matrix values below are separate, uncertified numerical diagnostics. The result is written mathematics, with no Lean or priority claim.

At support $B=1$, take 256 equal cells, each of length $\delta=1/128$, and the local space
$V=\bigoplus_I\mathbf1_I\operatorname{span}\{1,e^{x/2},e^{-x/2}\}$.
Both pole moments are retained. With logistic parameter $\kappa=64$, the actual unrepresented space $\mathcal H=\mathcal D_1\cap V^\perp$ satisfies
$$
 A[r]\ge3.2422204802\|r\|^2,\qquad
 K[r]\le0.0656852442\|r\|^2,                                      \tag{S1}
$$
$$
 D_{64}[r]\le0.95(A+K)[r]-0.0655151165\|r\|^2,                    \tag{S2}
$$
$$
 q_1[r]=A[r]-J_1[r]\ge0.3152204802\|r\|^2.                     \tag{S3}
$$
The displayed decimal constants are rounded conservatively below where used as lower bounds, and above where used as upper bounds; exact rational expressions appear below and in the script. For a simpler statement, (S1)–(S3) hold with (3.2422, 0.065686, 0.06551, 0.3152), respectively.

This certifies the entire orthogonal complement on a mesh with retained dimension 766. The mechanism combines a support-aware prime bound with third-order low-frequency leakage. It does not establish a horizon-uniform dimension bound.

The retained calculation is diagnostic: it suggests a negative minimum for $A+K$ and a positive maximum for $D_{64}-0.95(A+K)$. These signs are not certified. The exact mixed term that must be controlled to extend the high-space estimate is retained below.

## S4. Exact forms and all arithmetic terms

Use zero extension from $[-1,1]$, the Fourier convention
$\widehat f(t)=\int f(x)e^{-itx}dx$, and
$C_f(v)=\int f(x+v)\overline{f(x)}dx$. The supported form domain consists of $f\in L^2([-1,1])$, extended by zero, with
$$
\int_{\mathbb R}\log(2+|t|)|\widehat f(t)|^2\,dt<\infty.
$$
Put $h(t)=\Re\operatorname{digamma}(1/4+it/2)-\log\pi$ and $A[f]=(2\pi)^{-1}\int h(t)|\widehat f(t)|^2\,dt$. Denote by $\mathcal D_1$ the part of this domain satisfying both conditions
$$
\int f(x)e^{x/2}dx=\int f(x)e^{-x/2}dx=0.
$$
The space $V$ has dimension $768$. Its two global pole vectors $e^{x/2}$ and $e^{-x/2}$ are linearly independent and belong to $V$. Thus $L=V\cap\mathcal D_1$ has dimension $766$, and every admissible $f$ decomposes as $f=\ell+r$, with $\ell\in L$ and $r\in\mathcal H=\mathcal D_1\cap V^\perp$. Stepwise exponential functions belong to the form domain because their Fourier transforms decay as $O(1/|t|)$.

All primes and prime powers that can contribute at this support are exactly
$$
 n\in\{2,3,4,5,7\},\qquad
 a_n=\Lambda(n)n^{-1/2},\qquad \Lambda(4)=\log2.
$$
Terms with $n>e^2$ have zero correlation. Put
$$
 w_n=\frac1{1+(n/e^2)^{64}},\qquad w(v)=\frac1{1+e^{64(v-2)}}.
$$
Write $J_1[f]=2\sum_n a_n\Re C_f(\log n)$ for the unregulated prime form and $J_{\rm cont}[f]=2\int_0^2 e^{v/2}\Re C_f(v)\,dv$. Here the subscript $1$ on $J_1$ refers to the support horizon. The regulated finite-prime and continuum forms are
$$
 J_{64}[f]=2\sum_{n\in\{2,3,4,5,7\}}a_nw_n\Re C_f(\log n),
$$
$$
 J_{{\rm cont},64}[f]=2\int_0^2e^{v/2}w(v)\Re C_f(v)\,dv,
\qquad D_{64}=J_{64}-J_{{\rm cont},64}.                       \tag{S4}
$$
The two pole conditions imply exactly $J_{\rm cont}=-K$, where
$$
 K[f]=\frac1{2\pi}\int\frac{|\widehat f(t)|^2}{t^2+1/4}\,dt.
$$
For the signed continuum loss
$$
 T[f]=2\int_0^2e^{v/2}(1-w(v))\Re C_f(v)\,dv
$$
we therefore have
$$
 D_{64}=J_{64}+K+T,\qquad
 E_{64}=(J_1-J_{64})-T,\qquad
 q_1=A+K-D_{64}-E_{64}=A-J_1.                              \tag{S5}
$$
No positivity of $T$ is asserted. The bound used below is only
$$
 |T[f]|\le\rho\|f\|^2,\qquad
 \rho\le\frac{2e}{64+1/2}<\frac{2(2719/1000)}{129/2}
 =0.0843100775194\ldots.                                   \tag{S6}
$$
Indeed $1-w(v)\le e^{64(v-2)}$, and integrate the positive majorant. Formula (S3) uses the exact cancellation in (S5); it neither discards $E_{64}$ nor presumes regulator convergence. This calculation does not move the regulator horizon.

The archimedean form has the exact useful translation representation
$$
 A[f]=h_0\|f\|^2+
 \int_0^\infty k(v)(\|f\|^2-\Re C_f(v))\,dv,
$$
$$
 h_0=\operatorname{digamma}(1/4)-\log\pi=-H,\qquad
 k(v)=\frac{2e^{-v/2}}{1-e^{-2v}}.                          \tag{S7}
$$
This follows from the convergent digamma difference integral. Near zero its integrand is interpreted as the displayed difference; separating the divergent $k(v)\|f\|^2$ integral at zero is invalid. Beyond $v=2$, $C_f(v)=0$, but the diagonal archimedean tail is still present.

## S5. Support-aware prime estimate

Let $J_1$ be the compressed sum of the actual translations. The absolute row mass at $x$ is
$$
 R(x)=\sum_n a_n\big(1_{x+\log n\le1}+1_{x-\log n\ge-1}\big).
$$
Its exact supremum is
$$
 S=\sum_{n\in\{2,3,4,5,7\}}a_n
  =2.9262341821764\ldots<2.927.                            \tag{S8}
$$
To check the boundary geometry, every $n\ge3$ has at most one allowable sign. Outside the interval where both $n=2$ shifts fit, $n=2$ also has at most one. Inside that interval, no $n\ge4$ shift fits, so the row sum is at most $2a_2+a_3<S$. Near an endpoint all five one-sided shifts fit, attaining $S$. Equalities at a boundary are immaterial to the operator norm.

The symmetric Schur bound gives $\|J_1\|\le S$. The logistic kernel is dominated in absolute value by this same positive translation kernel, so $\|J_{64}\|\le S$ as well. This does not assert that $J_1$ or $D_{64}$ is positive. The earlier total-mass bound is $2S$. We use the actual finite-support geometry to halve that sufficient bound.

## S6. Third-order leakage from local exponential orthogonality

Let $r\perp V$. On a cell centered at $c$, write $y=x-c$. For real $t$, the function
$$
 g_t(y)=1+2it\sinh(y/2)-4t^2(\cosh(y/2)-1)
$$
belongs to the local three-dimensional space and matches the first three Taylor coefficients of $e^{ity}$. Taylor's integral remainder gives, for $|y|\le\delta/2$,
$$
 |e^{ity}-g_t(y)|\le |y|^3
 \left(\frac{|t|^3}{6}+\frac{|t|\cosh(\delta/4)}{24}
                  +\frac{t^2\delta\cosh(\delta/4)}{192}\right). \tag{S9}
$$
The complex phase $e^{itc}$ preserves this estimate. Projection is the best $L^2$ approximation, and
$\sum_I\int_I|x-c_I|^6dx=2\delta^6/448$. Consequently the whole-line band projection $P_T$ obeys
$$
 \|P_Tr\|^2\le\varepsilon(T,\delta)\|r\|^2,
$$
$$
 \varepsilon(T,\delta)\le\frac{2\delta^6}{448\pi}
 \int_0^T(at^3+ct^2+bt)^2dt,\quad
 a=\tfrac16,\ b=\tfrac{1001}{24000},\ c=\tfrac{1001\delta}{192000}. \tag{S10}
$$
Here $\cosh(\delta/4)<1001/1000$. This is a Hilbert–Schmidt estimate on the Fourier restriction map after projection away from $V$; it controls every unrepresented function, with no frequency truncation of $r$.

At $T=200, \delta=1/128$, replacing $\pi$ below by $3141/1000$ gives the exact rational upper bound
$$
 \varepsilon_*=
 \frac{157289603731413872114125}{9582029776036901406375936}
 =0.016415061047375328\ldots.                              \tag{S11}
$$
The elementary antiderivative used here is
$$
 a^2T^7/7+2acT^6/6+(c^2+2ab)T^5/5+2bcT^4/4+b^2T^3/3.
$$
The cruder first-order leakage $(\delta T/\pi)^2$ is about $0.2474$ on the same mesh and does not give the positive bath margin below.

## S7. Certified archimedean tail and the signed estimate

Here $\psi$ denotes the digamma function. For $\Re z>0$, the usual Laplace integral for $\psi(z)-\log z$ has kernel
$1/(1-e^{-u})-1/u$, lying between zero and one. Hence
$|\psi(z)-\log z|\le1/\Re z$. Apply this after shifting $z=1/4+it/2$ by 16 and use the exact recurrence for $\psi$. For $t\ge200$,
$$
 h(t)\ge\log\frac{t}{2\pi}-\frac4{65}-\frac{124}{(t/2)^2}
 \ge\log\frac{700}{22}-\frac4{65}-\frac{124}{10000}>3.386.    \tag{S12}
$$
The first bound is increasing for positive $t$, and $h$ is even. Globally $h\ge-H$, with $H<5.373$. Splitting the Fourier integral at 200 and using (S11) proves
$$
 A[r]\ge\alpha\|r\|^2,\qquad
 \alpha=\frac{3386}{1000}-\frac{8759}{1000}\varepsilon_*
 =3.2422204802860\ldots.                                  \tag{S13}
$$
Similarly
$$
 K[r]\le k_*\|r\|^2,\qquad k_*=4\varepsilon_*+1/40000.
$$
Combine $D_{64}=J_{64}+K+T$ with these inequalities, taking $\theta=19/20$:
$$
 (D_{64}-\theta(A+K))[r]
 \le\big[2.927+\rho_*+(1-\theta)k_*-\theta\alpha\big]\|r\|^2,
$$
$$
 \rho_*=\frac{2(2719/1000)}{129/2},\qquad
 2.927+\rho_*+\tfrac1{20}k_*-\tfrac{19}{20}\alpha
 =-0.0655151165428\ldots.                                 \tag{S14}
$$
This proves the signed relative estimate (S2) on the complete high space. Independently, $q_1=A-J_1\ge(\alpha-2.927)I$ proves (S3). One may state the bath lower bound $0.3152I$ without any logistic parameter at all; the parameter is used to test the requested signed $D_\kappa$ mechanism.

All scalar constants in this proof have exact rational certificates in [the rational checker](certificates/signed_prime_bath_constants.py). It encloses logarithms by a positive atanh series and its geometric tail, square roots by squared rational bounds, and $\pi$ by Machin's alternating arctangent formula. For $H$, it uses
$\gamma\le H_{1000}-\log1000-1/(2\cdot1001)$: the last term follows by summing
$\log(1+1/k)-1/(k+1)\ge1/[2(k+1)^2]$ and comparing the remaining sum with an integral. This script passes using exact fractions; the bath certificate does not depend on the floating eigensolver.

## S8. Exact retained matrices, the discriminator, and the surviving term

Choose any real orthonormal basis $(u_{I,a})_{a=1}^3$ of the constants and the two exponentials on each cell, using exact Gram–Schmidt orthogonalization. Let $U$ be any exact real isometry whose columns span the coefficient nullspace of the two pole rows. Thus $U$ has 768 rows and 766 columns. For the full cell basis define
$$
 C(v)_{ij}=\int u_i(x+v)u_j(x)\,dx,
\qquad C(-v)=C(v)^*.
$$
Each nonzero entry is an integral of products of constants and exponentials over the exact intersection of two cells. Therefore it has an elementary endpoint formula; these formulas, rather than mesh sampling of the prime locations, define the matrices. Exact compression gives
$$
 J_L=U^*\sum_na_nw_n(C(\log n)+C(\log n)^*)U,
$$
$$
 K_L=U^*\int_0^2e^{-v/2}(C(v)+C(v)^*)\,dv\,U,
$$
$$
 (D_{64})_L=J_L-U^*\int_0^2e^{v/2}w(v)(C(v)+C(v)^*)\,dv\,U,
$$
$$
 A_L=h_0I+U^*\int_0^2 k(v)\left(I-\frac{C(v)+C(v)^*}{2}\right)dv\,U
             +I\int_2^\infty k(v)dv.                     \tag{S15}
$$
The full diagonal tail and zero-extension boundaries are included. [The numerical implementation](certificates/signed_prime_bath_diagnostic.py) assembles the translation blocks on their exact overlap intervals. It integrates smooth entries on each cell-difference interval, with 10-node inner Gaussian overlap quadrature and 12- or 20-node outer quadrature. These are floating diagnostics, not certified enclosures of (S15).

At $B=1, \delta=1/128, \kappa=64$, the two outer orders agree at the shown useful digits:

| Diagnostic on the retained 766-dimensional space | Value |
|---|---:|
| Minimum eigenvalue of $F_L=(A+K)_L$ | (-0.4370055288410) |
| Minimum / maximum eigenvalue of $(D_{64})_L$ | (-1.7087687404701, 1.8802721451397) |
| Maximum eigenvalue of $(D_{64})_L-0.95F_L$ | (0.0724102121359) |
| Maximum generalized eigenvalue of the pair $((D_{64})_L,F_L+6I)$ | (0.2119292648338) |
| Maximum eigenvalue of $K_L$ | (0.1035979318000) |
| Minimum eigenvalue of the actual unregulated $q_L=A_L-(J_1)_L$ | about $9.7\times10^{-13}$ |

The two pole residuals together have norm about $1.7\times10^{-14}$ in this floating coordinate construction. The negative numerical $(F_L)$ minimum gives no certificate that $(F_L)$ is a positive generalized-eigenvalue denominator. The reported shifted ratio has the explicitly changed denominator $F_L+6I$. The tiny positive last entry is not a positivity certificate and is too close to numerical error for an inference about its sign.

For the operator products below, the ambient Hilbert space is the supported space $L^2([-1,1])$ with zero extension. The archimedean operator is the compression of the Fourier multiplier h to that interval, and D64 and K are compressed to the same space. Thus $G\ell$ denotes the supported L2 vector before projection onto $V^\perp$. The resulting form is then restricted to the admissible domain.

Here is a concrete repaired bound that retains precisely the missing high-space interaction. Put $F=A+K$ and $G=D_{64}-\theta F$, let $c_0=0.06551$, and write an actual admissible $f=\ell+r$, with $\ell\in L$, $r\in\mathcal H$. Equation (S14) gives
$$
 G[f]\le G[\ell]+2\Re\langle P_{V^\perp}G\ell,r\rangle-c_0\|r\|^2. \tag{S16}
$$
The finite columns $G\ell$ are genuine $L^2$ functions: the cell basis has Fourier decay $O(1/|t|)$, so multiplication by $h(t)=O(\log(2+|t|))$ remains in $L^2$. Let
$$
 W=P_{V^\perp}G|_L.
$$
Then the valid full-domain relative inequality is
$$
 D_{64}[f]\le\theta F[f]
 +\langle\ell,(G_L+2c_0^{-1}W^*W)\ell\rangle
 -\tfrac{c_0}{2}\|r\|^2.                                 \tag{S17}
$$
This is Young's inequality applied to (S16), with no inversion assumption. Every entry of the surviving Gram matrix is exactly
$$
 (W^*W)_{ij}=\langle Gu_j,Gu_i\rangle
 -\sum_{a=1}^{768}\langle Gu_j,v_a\rangle\langle v_a,Gu_i\rangle, \tag{S18}
$$
for an orthonormal full cell basis $v_a$ and retained basis $u_j$, with the inner-product convention linear in the first variable. This term includes all frequencies; replacing it by overlaps with finitely many further modes would only produce a lower bound and would not certify (S17) numerically. The analogous actual-$q$ mixed term is likewise required to combine the certified bath with the retained block.

Equations (S16)–(S18) are the precise residual obligation. The finite computation has not enclosed this Gram matrix or certified the retained near-zero directions. Neither a positive bath nor a finite positive-looking matrix settles their interaction. No claim is made that the high-space relative estimate alone proves positivity of $q_1$, much less of the forms at every support horizon.



## Sources and verification scope

The archimedean identities use the classical digamma integral and recurrence; see [DLMF 5.9.13](https://dlmf.nist.gov/5.9.E13) and [DLMF 5.15.5](https://dlmf.nist.gov/5.15.E5). The remaining methods are the Schur test, Taylor's remainder, Plancherel, orthogonal projection and Young's inequality. The finite-rank-plus-complement decomposition is a Hilbert-space construction; no spectral positivity follows without the mixed Gram estimate.

Run `python3 certificates/signed_prime_bath_constants.py` from this directory to check all rational scalar enclosures and their final margins using only the Python standard library. The positive logarithm series, alternating Machin series, rational square-root bounds and the explicit digamma tail are included in the proof and certificate.

The separate `signed_prime_bath_diagnostic.py` requires NumPy, SciPy and mpmath. It reproduces the finite quadrature calculations; it does not certify their errors or the retained near-zero directions. Its numerical table is retained as a tested lead, not a proof of a sign. The infinite-complement coercivity and the full-domain inequality with the unevaluated Gram term are proved. The complete retained-plus-complement positivity question and its growing-support bounds remain open in this construction. See the [theta jump form](theta-weil-jump-form.md) for the broader actual Weil normalization and domains.
