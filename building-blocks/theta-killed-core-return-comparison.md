# The full theta killed-core return operator and its excursion metric

This note constructs the full operator-valued return through the exterior of a compact interval. It uses the actual theta jump form, all prime powers, and the continuous infinite activity. The construction gives a positive return kernel, an exact nonlocal excursion metric, and an explicit positive correction for the two pole constraints. The sharp comparison on the full core remains unproved; section 7 gives a weaker explicit comparison with its loss. All results in this chapter are written proofs, not Lean formalizations.

The normalization and exterior bound are from [theta-weil-jump-form](theta-weil-jump-form.md), especially (11.1)–(11.4). The closed-form domain and local compactness are from that chapter and [theta-jump-eigenfunction-regularity](theta-jump-eigenfunction-regularity.md), (16.1). The established finite-time two-tail renewal laws in [theta-jump-tail-renewal](theta-jump-tail-renewal.md), (19.4)–(19.5), are not reproved or identified with a finite-dimensional return operator.

The general trace-process principle has a primary predecessor in [Chen–Fukushima–Ying, *Traces of symmetric Markov processes and their characterizations*, Theorems 2.7 and 2.11](https://arxiv.org/pdf/math/0606784). Their trace jump measure combines the original jumps restricted to the retained set with a Feller excursion measure. The direct block proof below supplies the actual theta realization, its shifted resolvent and excursion metric, and its boundary-domain justification; it makes no novelty claim for the general trace principle. That general principle alone gives no sharp spectral-gap comparison.

Write
$$
 \Lambda=\tfrac12,\quad b(u)=2\cosh(u/2),\quad
 m=b\Phi,\quad d\nu=m\,du,\quad
 \omega=\sqrt{\Phi/b},\quad w=\omega^2.
$$
The nonnegative generator is $L$, its form is $E$, and $\tau=\tanh(u/2)$. The directed displacement measure is
$$
 \eta(da)=r(|a|)\,da+
 \sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
 (\delta_{\log q}+\delta_{-\log q})(da),\qquad
 r(t)=\frac{e^{-t/2}}{1-e^{-2t}}.
\tag{1}
$$
The von Mangoldt function $\Lambda(q)$ in (1) is distinct from the fixed threshold $\Lambda=1/2$.

## 1. A hard spatial split is legitimate despite the infinite activity

Let $C=[-R,R]$, $O=\mathbb R\setminus C$, and let $P_C,P_O$ be the orthogonal multiplication projections in $L^2(\nu)$. Define the positive incoming operator from core to exterior by
$$
 (Bx)(u)=\frac1{b(u)}\int_{u+a\in C}\Phi(u+a)x(u+a)\,\eta(da),
 \qquad u\in O.
\tag{2}
$$
It is bounded; in particular (2) is not interpreted as a bounded total rate for all small jumps at every point.

Here is a direct bound that controls the boundary singularity. For $t>0$,
$$
 tr(t)\le\tfrac12(1+2t)e^{-t/2}\le2e^{-3/4}<1.
\tag{3}
$$
The first inequality follows from $1-e^{-2t}\ge 2t/(1+2t)$, and the middle expression has its maximum at $t=3/2$. Under the unitary map $h\mapsto\sqrt m\,h$, the archimedean part of (2) has cross-boundary kernel
$\omega(u)\omega(v)r(|u-v|)$. Each endpoint is bounded by a Carleman kernel $1/(x+y)$ on two half-lines. The weighted Schur test, using
$$
 \int_0^\infty\frac{y^{-1/2}}{x+y}\,dy=\pi x^{-1/2},
$$
gives norm at most $\pi$ for that kernel. Summing the two endpoints and using the full prime tail estimate yields
$$
 \|B\|\le b_R:=2\pi\|\omega\|_\infty
       \|1_O\omega\|_\infty+\Gamma_R.
\tag{4}
$$
Here $\Gamma_R$ bounds $K_{\rm p}-P_CK_{\rm p}P_C$, with every prime power retained. In particular $b_R\to0$ superexponentially. The same bound holds when only archimedean lengths below $\delta$ are omitted, and the resulting $B_\delta$ converge strongly to $B$. For the latter assertion first use functions supported away from the two boundary points, where ordinary dominated convergence applies, and then use their density and the uniform bound (4).

This bounded cross operator proves the form-domain split without assuming a Hardy inequality for discontinuous cutoffs. Let $E_\delta$ retain every prime power and only archimedean lengths at least $\delta$. These are bounded nonnegative forms increasing to $E$. For any $h\in D(E)$,
$$
 E_\delta(P_Ch)+E_\delta(P_Oh)
 =E_\delta(h)+2\operatorname{Re}\langle BP_Ch,P_Oh\rangle+o(1)
 \le E(h)+b_R\|h\|^2+o(1).
\tag{5}
$$
Before taking the limit, the exact cross term in (5) is $B_\delta$. Monotone convergence and the actual maximal-form identification imply $P_Ch,P_Oh\in D(E)$. Conversely their sum is in $D(E)$. Thus the killed restrictions give closed forms $E_C,E_O$, with selfadjoint operators $L_C,L_O$, and
$$
 L=\begin{pmatrix}L_C&-B^*\\-B&L_O\end{pmatrix},
 \qquad D(L)=D(L_C)\oplus D(L_O).
\tag{6}
$$
This operator-domain identity follows from the form identity by bounded selfadjoint perturbation. Killing retains the entire departure cost of jumps leaving the corresponding region.

## 2. Exact Schur elimination below the exterior threshold

Fix $z=\Lambda-\epsilon>0$, and choose $R$ so that $\delta_R<\epsilon$, where the established exterior estimate gives
$$
 L_O\ge\Lambda-\delta_R>z.
$$
Set
$$
 R_z=(L_O-z)^{-1},\quad
 \Sigma_z=B^*R_zB,\quad
 S_z=L_C-z-\Sigma_z.
\tag{7}
$$
The inverse and all products in (7) are justified on their actual Hilbert spaces. In particular
$$
 0\le\Sigma_z,\qquad
 \|\Sigma_z\|\le\frac{b_R^2}{\epsilon-\delta_R}.
\tag{8}
$$
For $x\in D(E_C)$, $y\in D(E_O)$, completing the exterior square gives
$$
 E(x\oplus y)-z(\|x\|^2+\|y\|^2)
 =s_z[x]+\|(L_O-z)^{1/2}(y-R_zBx)\|^2,
\tag{9}
$$
where $s_z$ is the closed form of $S_z$. Its harmonic lift is
$J_zx=x\oplus R_zBx$. The kernel correspondence is exact:
$$
 \ker(L-z)=J_z\ker S_z.
\tag{10}
$$
The same square completion identifies negative indices. The core has compact resolvent, since its form controls a logarithmic Fourier norm on a fixed compact interval. Hence the number of negative directions of $S_z$ is finite. No sign of its second eigenvalue is inferred.

## 3. The entire coherent return history

The killed exterior semigroup $P_t^O=e^{-tL_O}$ is positivity preserving and sub-Markov. Its Laplace transform gives
$$
 \boxed{\quad
 \Sigma_z=\int_0^\infty e^{zt}B^*P_t^OB\,dt.
 \quad}
\tag{11}
$$
The integral converges in operator norm, and the part with $t>T$ has norm at most
$$
 \frac{b_R^2}{\epsilon-\delta_R}
 e^{-(\epsilon-\delta_R)T}.
\tag{12}
$$
Formula (11) retains two core/exterior crossings and every possible intervening exterior jump, with its actual holding and killing factors. It is positive both as a quadratic form and as an order-preserving operator. It need not have a Lebesgue density: prime-only paths may retain singular components.

One precise path construction first fixes $T<\infty$, omits only archimedean lengths below $\delta$, and expands $P_t^{O,\delta}$ by the bounded-rate jump series. The series sums over every finite sequence of exterior destinations. At each step the measure is the sum of the continuous part and *all* prime-power atoms, so mixed paths and repeated prime powers are included before any absolute estimate. The standard integral expansion follows directly by iterating Duhamel's formula for the bounded holding-rate multiplication operator and the bounded incoming operator. Increasing-form convergence identifies its strong limit as $P_t^O$, uniformly in strong topology on bounded time intervals. Both $B_\delta\to B$ and $B_\delta^*\to B^*$ hold strongly: apply the boundary-away density argument from section 1 in each direction. Together with their uniform bounds, this gives the finite-time part of (11) strongly. Finally (12) removes $T$. No uniform infinite-time bound for the truncated jump processes, or interchange of an unproved infinite-time truncation limit, is used.

The two asymptotic scalar incoming laws $\mu_\pm$ do not replace any factor in (11).

## 4. Positive return paths create an exact excursion metric

At zero energy write $R_0=L_O^{-1}$ and $S_0=L_C-B^*R_0B$. The resolvent identity gives the additional structure
$$
 \boxed{\quad S_z=S_0-zM_z,\qquad
 M_z=I+B^*L_O^{-1}(L_O-z)^{-1}B\ge I.\quad}
\tag{13}
$$
Thus the return contributes a positive change of metric as well as a positive effective jump kernel. It is not legitimate to test only a spectral gap for $S_0$ in the unchanged core norm. The exact bounds and derivative are
$$
 \|M_z-I\|\le
 \frac{b_R^2}{(\Lambda-\delta_R)(\epsilon-\delta_R)},
 \qquad
 S_z'=-I-B^*(L_O-z)^{-2}B<0.
\tag{14}
$$

The constant-mode equation in (6) says
$L_O1_O=B1_C$, $L_C1_C=B^*1_O$. Consequently
$$
 S_01_C=0,\qquad
 R_zB1_C=1_O+zR_z1_O.
\tag{15}
$$
At $z=0$, the diagonal killing cost is exactly balanced by the return row mass: $B^*R_0B1_C=B^*1_O$. Therefore $S_0$ is the trace Dirichlet operator on the core. Its effective jump measure is the direct core jump measure plus the symmetric nonnegative return measure in (11) at $z=0$; diagonal return mass is immaterial to the jump difference. This statement also follows directly by minimizing the Markov form in (9) at $z=0$.

The full mean of the harmonic lift has a useful exact description:
$$
 \nu(J_zx)=\langle x,g_z\rangle_C,\qquad
 g_z=1_C+B^*R_z1_O=M_z1_C.
\tag{16}
$$
Hence a genuine mean-zero eigenfunction at energy $z$ gives a solution of
$S_0x=zM_zx$ orthogonal to $1_C$ in the $M_z$ metric. This identifies the precise global comparison needed for this route. It does not supply that comparison.

## 5. Both pole constraints give a positive finite-rank correction

The two constraints are linear moments, not a two-dimensional model of all return histories. Define maps from $\mathbb C^2$ by
$$
 U_C(c_0,c_1)=c_01_C+c_1\tau_C,\qquad
 U_O(c_0,c_1)=c_01_O+c_1\tau_O.
$$
Let
$$
 G_z=U_O^*R_zU_O,\qquad
 a_z(x)=U_C^*x+U_O^*R_zBx.
\tag{17}
$$
The matrix $G_z$ is strictly positive: $R_z>0$ and the functions $1_O,\tau_O$ are linearly independent. A vector $x\oplus y$ has both moments zero exactly when
$U_O^*(y-R_zBx)=-a_z(x)$. Minimizing the last term in (9) under these constraints gives
$$
 y_*(x)=R_zBx-R_zU_OG_z^{-1}a_z(x),
\tag{18}
$$
$$
 \boxed{\quad s_z^{\rm proj}[x]
 =s_z[x]+a_z(x)^*G_z^{-1}a_z(x).\quad}
\tag{19}
$$
The minimizer is in $D(L_O)$. For any other constrained $y=y_*(x)+v$, where $U_O^*v=0$, the exact additional cost is
$\|(L_O-z)^{1/2}v\|^2$. The cross term vanishes because $(L_O-z)(y_*-R_zBx)$ lies in the range of $U_O$.

Thus (19) is a concrete positive correction to the complete coherent Schur form, preserving both pole constraints. Positivity of (19) for all admissible cores at every $z<\Lambda$ remains unproved. Applying the original score map $\Pi h=h-\nu h+2\nu(\tau h)s$ places a test in this constrained space; it does not preserve an arbitrary eigen-equation. No such preservation is used.

## 6. Every threshold mode imposes an exact identity

Let $r\in D(L)$ satisfy $Lr=\Lambda r$, and write $x=r_C,y=r_O$. Every derivative mode
$$
 r_j=(\Phi^{(j+2)}-\tfrac14\Phi^{(j)})/\Phi
$$
has this property and both pole moments zero. The next equations apply equally to any further threshold mode; completeness of the derivative family is not assumed.

From the exterior equation,
$$
 R_zBx=y-\epsilon R_zy,
\qquad
 S_zx=\epsilon(x+B^*R_zy).
\tag{20}
$$
In particular the restrictions of threshold modes are not null vectors of $S_z$ at $z=\Lambda-\epsilon$. Their exact form calibration is
$$
 s_z[x]=\epsilon\|r\|^2-\epsilon^2\langle y,R_zy\rangle.
\tag{21}
$$
If both moments of $r$ vanish, then
$a_z(x)=-\epsilon U_O^*R_zy$. Combining (19)–(21), and writing $Q_z$ for the orthogonal projection onto the two-dimensional span of $R_z^{1/2}1_O,R_z^{1/2}\tau_O$, gives
$$
 \boxed{\quad
 s_z^{\rm proj}[r_C]
 =\epsilon\|r\|^2-
   \epsilon^2\|(I-Q_z)R_z^{1/2}r_O\|^2.
 \quad}
\tag{22}
$$
This is an explicit signed residual on the full constrained core. The two moment corrections remove precisely the indicated two components of the exterior resolvent mass; they do not remove the infinitely many threshold modes.

There is no justified fixed-core substitution $z=\Lambda$ into these formulas: the established exterior bound is only $L_O\ge\Lambda-\delta_R$. For an actual limit, choose $R=R(\epsilon)\to\infty$ with $\delta_R\le\theta\epsilon$, $0<\theta<1$. For every fixed threshold vector,
$$
 \|J_zr_C-r\|\le\frac{\|r_O\|}{1-\theta}\longrightarrow0,
 \qquad
 \frac{s_z^{\rm proj}[r_C]}\epsilon\longrightarrow\|r\|^2.
\tag{23}
$$
The second claim follows since the subtracted quantity divided by $\epsilon$ is at most $\|r_O\|^2/(1-\theta)$. These are fixed-vector limits, not uniform limits over the entire threshold eigenspace. Local compactness and its infinite dimension preclude treating all those modes as a fixed finite set of core coordinates.

## 7. Pairing the duration metric with the complete return jump measure

The metric correction has more structure than positivity as an operator. For $z>0$,
$$
 N_z:=M_z-I=\frac{\Sigma_z-\Sigma_0}{z}
 =\int_0^\infty\frac{e^{zt}-1}{z}B^*P_t^OB\,dt.
\tag{24}
$$
The integral converges in operator norm. Its weight is nonnegative, so $N_z$ is both positive as a quadratic form and order preserving. Write $\mathsf N_z(du,dv)$ for its finite symmetric nonnegative kernel measure relative to the core measure $\nu_C$. Its row measure is
$$
 \mathsf N_z(du,C)=(g_z(u)-1)\,d\nu_C(u),\qquad g_z\ge1.
$$
Finiteness follows from boundedness of $N_z$ and $1_C\in L^2(\nu_C)$; no Lebesgue density is required. For bounded $x\in D(E_C)$, all the following integrals are finite and
$$
 \|x\|_{L^2(g_z\nu_C)}^2-\langle M_zx,x\rangle_C
 =e_{N_z}[x]:=\frac12\iint|x(u)-x(v)|^2\,
                     \mathsf N_z(du,dv)\ge0.
\tag{25}
$$
Thus the exact paired form is
$$
 \boxed{\quad
 s_z[x]=e_z[x]-z\|x\|_{L^2(g_z\nu_C)}^2,\qquad
 e_z[x]=s_0[x]+z e_{N_z}[x].\quad}
\tag{26}
$$
Its positive jump measure is the direct core jump measure plus the full $\Sigma_z$ return measure: the return measure in $s_0$ is $\Sigma_0$, and $zN_z=\Sigma_z-\Sigma_0$. The full mean of the harmonic lift is exactly $\int_C g_z x\,d\nu_C$. This pairs excursion duration with the same return histories, rather than replacing those histories by a scalar asymptotic law.

The row $g_z$ is guaranteed to lie in $L^2(\nu_C)$, but it has not been proved bounded. Therefore (25)–(26) are first asserted on bounded form tests. More generally their separate positive terms are well-defined and finite on
$$
 \mathscr D_z=D(E_C)\cap L^2(g_z\nu_C).
$$
On this domain, the kernel identity extends by truncation: $N_z$ is bounded in the original core Hilbert space, while the row-weighted integrals converge. On arbitrary $D(E_C)$, only the original combined closed Schur form is asserted; a difference of two infinite positive terms in (26) is not a definition. In particular $L^2$-boundedness of $N_z$ alone must not be used to assert finiteness of its row-weighted potential on every form test.

For the sufficiently enlarged actual core constructed in [theta-return-clock-domain-bound](theta-return-clock-domain-bound.md), this extra domain condition has now been proved automatic. The full exterior-to-core killing rate satisfies $\kappa_O\ge\kappa_*>z$, using the complete prime return law and a uniform all-power theta-tail bound for arrivals remaining outside. Positivity of the actual killed semigroup then gives
$$
 R_z1_O\le(\kappa_*-z)^{-1},\qquad
 1\le g_z\le1+\frac{\kappa_C}{\kappa_*-z},\qquad
 \int_Cg_z|x|^2d\nu\le\|x\|^2+
             \frac{E_C[x]}{\kappa_*-z},
\tag{26a}
$$
for every $x\in D(E_C)$, where $\kappa_C=B^*1_O$ is the exact core killing rate. Hence $\mathscr D_z=D(E_C)$ for these cores. No boundedness of $g_z$ is required. Since $N_z\ge0$, (25) also gives
$$
 0\le e_{N_z}[x]\le(\kappa_*-z)^{-1}E_C[x].
\tag{26b}
$$
The form $e_z=s_0+ze_{N_z}$, considered in $L^2(g_z\nu_C)$, is therefore closed and Markov on $D(E_C)$. For closedness, its norm is equivalent to $E_C[x]+\|x\|_C^2$: the upper bound uses (26a)–(26b), while the lower bound uses $e_z\ge s_0$, $E_C=s_0+\langle\Sigma_0x,x\rangle$, boundedness of $\Sigma_0$, and $g_z\ge1$. Bounded compact tests are dense in the weighted Hilbert space; the positive jump representation gives the Markov property. Its generator is the full core return-jump generator divided by the positive clock density. Compact embedding into this changed Hilbert space does not follow from norm equivalence alone. The separate proof in [theta-return-clock-boundary-compactness](theta-return-clock-boundary-compactness.md) obtains it from actual exterior boundary decay $R_z1_O(R+y)=O(1/\sqrt{\log(1/y)})$. It gives $g_z(R-d)=O(\sqrt{\log(1/d)})$, which is lower order than the exact logarithmic core killing cost. Consequently the changed-clock generator has compact resolvent for the fixed $R,z$ under consideration. No uniform threshold limit or eigenvalue comparison is inferred.

There is an explicit weighted Poincare bound for this paired form. Set
$$
 d_R=\Lambda-\delta_R>z,\qquad
 \kappa_R=\frac{\nu(C)\,r(2R)}{4\cosh^2(R/2)},\qquad
 K_z=1+\frac{b_R^2}{d_R(d_R-z)}\ge\|M_z\|.
\tag{27}
$$
The continuous direct-core kernel gives
$$
 s_0[x]\ge\kappa_R
 \left\|x-\frac{\nu_C(x)}{\nu(C)}1_C\right\|_C^2.
\tag{28}
$$
Indeed $r$ is decreasing, $|u-v|\le2R$ on the core, and
$\Phi(u)\Phi(v)\,du\,dv=d\nu(u)d\nu(v)/(b(u)b(v))$, with
$b(u)b(v)\le4\cosh^2(R/2)$. The half-integral of the squared difference against $\nu_C\otimes\nu_C$ equals $\nu(C)$ times the squared mean-zero norm in (28). The nonnegative return jump form remains available and is simply bounded below by zero in this estimate.

Suppose now that $x\in\mathscr D_z$ satisfies the actual lifted mean constraint
$\int_C g_zx\,d\nu_C=0$. Write $x=y+a1_C$, where $\nu_Cy=0$. The metric orthogonality determines $a$, and completing its scalar square gives
$$
 \langle M_zx,x\rangle_C
 =\langle M_zy,y\rangle_C
  -\frac{|\langle M_zy,1_C\rangle_C|^2}
              {\langle M_z1_C,1_C\rangle_C}
 \le K_z\|y\|_C^2.
\tag{29}
$$
Combining (25), (28), and (29) proves the unconditional comparison
$$
 \boxed{\quad
 e_z[x]\ge
 \min\!\left(z,\frac{\kappa_R}{K_z}\right)
 \|x\|_{L^2(g_z\nu_C)}^2,
 \qquad \int_Cg_zx\,d\nu_C=0.\quad}
\tag{30}
$$
No upper bound on the row weight was needed: its extra mass is paid by the same positive clock jump energy in (25). In particular the desired $z$-comparison follows in the range $z\le\kappa_R/K_z$. The equivalent combined estimate
$s_z[x]\ge(\kappa_R/K_z-z)\langle M_zx,x\rangle_C$
holds directly for all form-domain $x$ with $\langle x,g_z\rangle_C=0$, using (28)–(29), without requiring the separate integrability in (26).

This bound does not reach the sharp threshold. As $R\to\infty$,
$\kappa_R\sim e^{-2R}$, since $\nu(C)\to1$, $r(2R)\sim e^{-R}$, and $4\cosh^2(R/2)\sim e^R$. Even when the return-metric error $K_z-1$ is made small, this direct-kernel minorization loses the required constant. A stronger use of the actual return measure, rather than this uniform minimum of the direct core kernel, is needed near $z=1/2$.

Equations (11), (13), (19), (22), and (24)–(30) give the complete return history, its excursion metric, the two-moment correction, threshold calibration, and a valid weighted comparison with an explicit loss. No uniform comparison proving the sharp theta gap has been obtained.
