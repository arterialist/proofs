# Compact lower barrier for the actual killed theta ground

*Research and initial proof: RH Agent3. Independent mathematical audit and publication: RH Proof.*

This closes the ground-regularity premise in [the complete sieve packet](complete-sieve-theta-same-half-prime-bilinear-dyadic-visibility.md). It uses the established full killed generator and its rank-one continuous-kernel minorant, with every prime power retained. The result is an essential lower bound on any compact exterior strip. It does not assert continuity, a moving-radius uniform bound, comparison with the original Abel/clock metric, or RH.

## The exact positive-resolvent barrier

Fix \(R>0\), \(O=\mathbb R\setminus[-R,R]\), \(d\nu=b\Phi\,du\), \(b=2\cosh(u/2)\), and
\[
\rho(u)=\frac{e^{-|u|/2}}{b(u)}>0.
\tag{1}
\]
The full killed theta operator \(D=L_O\) has the normalized ground from [the killed-ground theorem](theta-killed-return-ground-pole.md):
\[
D\psi=\alpha\psi,
\quad 0<\alpha<1/2,
\quad\|\psi\|_{L^2(\nu_O)}=1,
\quad\psi>0\ \nu\text{-a.e.}
\tag{2}
\]
Its complete generator contains the archimedean compensated kernel, all \(\Lambda(p^k)/p^{k/2}\) jumps in both orientations, and core killing. The same theorem proves the bounded positive rank-one decomposition
\[
D=A_0-J_\rho,
\qquad J_\rho f=\langle f,\rho\rangle_\nu\rho,
\tag{3}
\]
where \(A_0\ge0\) is a Dirichlet generator with additional nonnegative killing, so \(R_0=(A_0+1)^{-1}\) preserves nonnegative functions. The domain of \(A_0\) equals the domain of \(D\), because \(J_\rho\) is bounded.

**Theorem.** For every compact \(K\Subset O\), the actual ground has a positive essential lower bound
\[
\boxed{\displaystyle
\operatorname*{ess\,inf}_{u\in K}\psi(u)
\ge \frac{\langle\psi,\rho\rangle_\nu}{C_K}>0,}
\tag{4}
\]
where the following entirely finite, source-specific constant is admissible. Choose \(h\in C_c^\infty(O)\), \(h\ge0\), \(h=1\) on \(K\), and put
\[
c_h=\langle h,\rho\rangle_\nu,
\qquad
C_K=c_h+
\sup_{u\in\operatorname{supp}h}
\frac{[(D+1)h(u)]_+}{\rho(u)}.
\tag{5}
\]
An essential supremum can replace the displayed supremum if a chosen representative of \(Dh\) is not continuous. Either is finite for the smooth compact cutoff supported a positive distance from the hard boundary.

**Proof.** The full killed jump representation gives \(Dh(u)\le0\) at almost every \(u\in O\setminus\operatorname{supp}h\). There \(h(u)=0\), core killing is zero, and every continuous or prime-power arrival of nonnegative \(h\) enters with a minus sign. On \(\operatorname{supp}h\), \((D+1)h\) has a finite upper bound. The support stays away from the hard boundary, so core killing is bounded there.

The operator-domain claim needs a global bound. Extend \(h\) by zero across the core. Its continuous compensated generator is bounded by a constant times \(\|h'\|_\infty\sup\Phi\int_0^\infty a r(a)\,da\), finite despite \(r(a)\sim1/(2a)\). The full prime-power generator is bounded by \(2\|h\|_\infty\) times the published uniform prime departure rate. The weak symmetric jump identity identifies this bounded pointwise generator with \(Dh\). Since \(\nu(O)<\infty\), it lies in \(L^2(\nu_O)\). Thus \(h\in D(D)=D(A_0)\), with every prime power retained. Since \(A_0=D+J_\rho\), one has pointwise almost everywhere
\[
(A_0+1)h=(D+1)h+c_h\rho\le C_K\rho.
\tag{6}
\]
Apply the positive resolvent \(R_0\) to obtain \(h\le C_KR_0\rho\). Meanwhile (2)--(3) give
\[
(A_0+1)\psi=(\alpha+1)\psi
+\langle\psi,\rho\rangle_\nu\rho,
\]
and hence
\[
\psi=(\alpha+1)R_0\psi
+\langle\psi,\rho\rangle_\nu R_0\rho
\ge\langle\psi,\rho\rangle_\nu R_0\rho.
\tag{7}
\]
The scalar \(\langle\psi,\rho\rangle_\nu\) is strictly positive by (2) and \(\rho>0\). On \(K\), \(h=1\), so (6)--(7) imply (4). The argument uses only positivity of the full resolvent; it neither assumes a Harnack theorem nor differentiability of \(\psi\).

The constant is computable in principle from the actual \(h\), full generator, and ground overlap. No uniformity as \(R\to\infty\) or \(K\) approaches the hard boundary is asserted. The estimate is insensitive to the sign of any theta signed response; it is a ground-state regularity fact.

## Unconditional dyadic cone mass

Use the full finite square-root sieve packet and smooth cell embedding in [the preceding same-half note](complete-sieve-theta-same-half-prime-bilinear-dyadic-visibility.md). In particular, \(z=\lfloor\sqrt N\rfloor\), \(c_n=\mu(n)1_{\{\exists p>z:p\mid n\}}1_{n\le B_N}\), \(B_N=\lfloor Ne^{-R}\rfloor\), and the common normalized bump cells \(I_n=(\log(n/N)-1/(4N),\log(n/N))\) satisfy \(I_n+\log2=I_{2n}\).

Fix \(0<a<b<e^{-R}/2\). For every sufficiently large \(N\) and prime \(p\in[aN,bN]\), both cells \(I_p,I_{2p}\) lie in the negative exterior and within the finite horizon. The *complete* cone has \(c_p=-1\), \(c_{2p}=+1\), so the \(q=2\) same-half increment is exactly \(2f_p\) on \(I_p\). All other prime and proper-prime-power terms in the full same-half energy are nonnegative squares. Choose the fixed compact exterior strip
\[
K=[\log a-1,\log(2b)]\Subset(-\infty,-R),
\quad m_{\Phi,K}=\min_{u\in K}\Phi(u)>0,
\quad m_{\psi,K}=\langle\psi,\rho\rangle_\nu/C_K>0.
\tag{8}
\]
The exact two-orientation normalization from the full prime form then gives
\[
\begin{aligned}
\operatorname{Same}_p(F_c)
&\ge \frac{4\log2}{\sqrt2}
\sum_{\substack{aN\le p\le bN\\p\text{ prime}}}
\int_{I_p}\psi(u)\psi(u+\log2)
\Phi(u)\Phi(u+\log2)|f_p(u)|^2du\\
&\ge\frac{4\log2}{\sqrt2}
m_{\psi,K}^2m_{\Phi,K}^2
\bigl(\pi(bN)-\pi(aN)+O(1)\bigr).
\end{aligned}
\tag{9}
\]
By the ordinary prime number theorem in a fixed proportional interval, the last count is \((b-a+o(1))N/\log N\). Thus, with an explicit positive constant determined by (5) and (8),
\[
\boxed{\displaystyle
\operatorname{Same}_p(F_c)
\ge\mathcal D_{2,N}\gg_{R,a,b}\frac{N}{\log N}.}
\tag{10}
\]
This improves the preceding note's conditional dyadic statement to an unconditional fixed-core theorem. It preserves all prime powers and both orientations: their other contributions remain in the full nonnegative same-half sum and are not subtracted. Equation (10) is an absolute theta-form lower bound for the specified complete arithmetic packet embedded by normalized cells. It is not an \(N^{2+\varepsilon}\) upper bound for the original Lambert/Fejér metric, nor a signed estimate for the full constrained theta response.

The original Suzuki arrival-defect identity is unaffected:
\[
\langle\mathcal C_\omega(I+\sigma G_\omega)x,y\rangle
-\langle(T_\omega-I)x,y\rangle
=\langle x,y\rangle+\sigma\langle H_\omega x,y\rangle.
\tag{11}
\]
It pays its defect in the interval metric for any eventual interval image of the sieve packet. No source-preserving map from the theta cell form (9) to that interval form or to the original Abel/clock Gram has been proved; (10) does not authorize dropping the defect or changing the metric.
