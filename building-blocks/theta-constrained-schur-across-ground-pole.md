# Constrained exterior elimination across its ground-state pole

This written proof uses constrained quadratic minimization, a bordered operator inverse and the selfadjoint resolvent identity. Their classical operator algebra is derived on the actual domains below; no Lean or priority claim is made.

The two actual moment constraints allow exterior elimination on an interval strictly beyond the lowest exterior eigenvalue. The elimination there is a signed coherent operator. It is not the positive excursion-clock representation, whose raw Laplace history stops converging at the ground-state pole.

Use the full hard split from the [complete return construction](theta-killed-core-return-comparison.md):
$$
 L=\begin{pmatrix}L_C&-B^*\\-B&D\end{pmatrix},
 \qquad D=L_O,\quad C=[-R,R],\quad O=\mathbb R\setminus C.
 \tag{1}
$$
All operators act in their actual $L^2(\nu)$ spaces. All cross-boundary departures, infinite continuous activity, and prime powers remain in $D,B$.

Use the [ground-state and domain results](theta-killed-return-ground-pole.md). Let its lowest exterior eigenpair be
$$
 D\psi=\alpha\psi,\qquad \|\psi\|_O=1,\quad \psi>0,
$$
with $\alpha>0$ simple and
$$
 d=\inf(\sigma(D)\setminus\{\alpha\})-\alpha>0.
 \tag{2}
$$
Use $d$ for this spectral separation to avoid confusing it with the return clock. Set
$$
 M_O=\nu(O),\qquad \mu=\langle1_O,\psi\rangle_O>0,
$$
$$
 U(c_0,c_1)=c_01_O+c_1\tau_O,\quad
 U_C(c_0,c_1)=c_01_C+c_1\tau_C,\quad
 K=\ker U^*.
 \tag{3}
$$
Inner products are linear in the first argument. Coordinate formulas below use $U^*y=(\langle y,1_O\rangle,\langle y,\tau_O\rangle)$.

## Actual domains of the moment profiles

Both columns of $U$ belong to $D(D)$. Globally $1\in D(L)$ and $L1=0$. The score $\tau=\tanh(u/2)$ is bounded and Lipschitz, with $|\tau'|\le1/2$, and belongs to the actual form domain. Its weak generator expression is bounded: writing $\Phi_*=\sup\Phi$, the continuous part satisfies
$$
 |L_{\rm arch}\tau(u)|
 \le\frac{\Phi_*}{2}\int_0^\infty a\,r(a)\,da<\infty,
$$
and its complete prime part is bounded by $2\|b_{\rm p}\|_\infty$. These follow directly from both jump orientations and $\Phi(u\pm a)/(2\cosh(u/2))\le\Phi_*/2$.

Polarization on the compact form core identifies this bounded expression with $L\tau$, so $\tau\in D(L)$. The established hard-split operator-domain identity then gives $1_O,\tau_O\in D(D)$, and their core restrictions lie in $D(L_C)$. No boundary differentiation of an indicator is used.

The matrix $G_0=U^*U$ is invertible. On this symmetric exterior it is diagonal with positive entries $M_O$ and $\nu_O(\tau^2)$. Define
$$
 F=U G_0^{-1},\qquad P=I-FU^*.
 \tag{4}
$$
Then $U^*F=I$, $P$ is the orthogonal projection onto $K$, and $F$ has range in $D(D)$.

The restricted closed form on $D(D^{1/2})\cap K$ has associated operator $D_K$, with
$$
 D(D_K)=D(D)\cap K,\qquad D_Ky=PDy.
 \tag{5}
$$
To verify the possibly nontrivial inclusion, decompose any full form test $h$ as $Ph+FU^*h$. A restricted weak generator identity on $K$ then extends to all form tests by a bounded finite-dimensional functional, since the columns of $F$ are in $D(D)$. The full representation theorem puts $y$ in $D(D)$. This also proves density of the restricted form domain in $K$.

## A guaranteed coercivity interval beyond $\alpha$

For a vector $y$ with $\langle y,1_O\rangle=0$, write $y=c\psi+v$, $v\perp\psi$. The mean constraint and Cauchy give
$$
 |c|^2\mu^2
 \le(M_O-\mu^2)\|v\|_O^2,
 \qquad
 \|v\|_O^2\ge\frac{\mu^2}{M_O}\|y\|_O^2.
$$
The spectral separation (2) therefore implies
$$
 \langle y,Dy\rangle
 \ge\alpha\|y\|^2+d\|v\|^2
 \ge\gamma\|y\|^2,\qquad
 \boxed{\gamma=\alpha+d\mu^2/M_O>\alpha.}
 \tag{6}
$$
The same bound holds on the smaller two-moment kernel $K$, and in form sense. Hence $D_K\ge\gamma$.

Define the maximal positivity threshold
$$
 \zeta_R=\inf\sigma(D_K)\ge\gamma.
 \tag{7}
$$
All the constrained constructions below are valid for every real $z<\zeta_R$, with the explicit guaranteed subinterval $z<\gamma$. In particular they hold throughout $\alpha<z<\gamma$. No assertion $\zeta_R=1/2$ is assumed.

## The full affine exterior minimizer

For a core vector $x\in D(E_C)$, retain its complete moment forcing
$$
 c=U_C^*x,\qquad y_0=-Fc.
$$
Every exterior vector satisfying the two full-space constraints has the unique form $y=y_0+k$, $k\in K$. Let
$$
 b_x=P[Bx-(D-z)y_0],\qquad
 R_K(z)=(D_K-z)^{-1}.
$$
The unique constrained exterior minimizer is
$$
 \boxed{y_*(x)=y_0+R_K(z)b_x.}
 \tag{8}
$$
It belongs to $D(D)$, obeys $U^*y_*=-U_C^*x$, and satisfies the exact constrained Euler equation.

The resulting closed core form is
$$
\begin{split}
 \boxed{s_z^{\,c}[x]={}}&
 E_C[x]-z\|x\|_C^2
 +\langle y_0,(D-z)y_0\rangle
 -2\Re\langle Bx,y_0\rangle\\
 &-\langle b_x,R_K(z)b_x\rangle.
\end{split}
 \tag{9}
$$
Every term beyond $E_C$ is a bounded quadratic form on the core Hilbert space. This follows because $F,DF,U_C^*,B$ are bounded and $\|R_K(z)\|\le(\zeta_R-z)^{-1}$.

For any other admissible exterior $y=y_*+v$, with $v\in K$, the full identity is
$$
 E(x\oplus y)-z(\|x\|_C^2+\|y\|_O^2)
 =s_z^{\,c}[x]+\|(D_K-z)^{1/2}v\|_O^2.
 \tag{10}
$$
This is the actual constrained Schur elimination across the pole. It retains the core's two affine moment values and the entire exterior response.

## The bordered inverse is regular through the ground pole

The operator
$$
 \mathcal K(z)=
 \begin{pmatrix}D-z&U\\ U^*&0\end{pmatrix}
 :D(D)\oplus\mathbb C^2\longrightarrow L^2(\nu_O)\oplus\mathbb C^2
 \tag{11}
$$
is invertible for every $z<\zeta_R$. For general right side $(f,c)$, set $y_0=Fc$, then
$$
 y=y_0+R_K(z)P[f-(D-z)y_0],
$$
$$
 \ell=G_0^{-1}[U^*f-(DU)^*y+zc].
 \tag{12}
$$
These solve $(D-z)y+U\ell=f$, $U^*y=c$. The formulas are bounded into the graph norm of $D$, since $Dy=f-U\ell+zy$. They depend analytically on $z$ throughout $\operatorname{Re}z<\zeta_R$, through the restricted selfadjoint resolvent. Thus the ordinary pole at $z=\alpha$ is absent from the bordered inverse.

Whenever the ordinary $R_z=(D-z)^{-1}$ exists in this range, let
$$
 G_z=U^*R_zU,\qquad a_z=U_C^*x+U^*R_zBx.
$$
The matrix $G_z$ is invertible. If $G_z\ell=0$, then $y=R_zU\ell\in K$ has $\langle y,(D-z)y\rangle=0$, contradicting strict constrained coercivity unless $y=0$, hence $\ell=0$. Substitution gives
$$
 y_*=R_zBx-R_zU G_z^{-1}a_z,
$$
$$
 \boxed{s_z^{\,c}[x]
 =E_C[x]-z\|x\|^2-\langle Bx,R_zBx\rangle
                  +a_z^*G_z^{-1}a_z.}
 \tag{13}
$$
Below $\alpha$, $G_z$ is positive. Above $\alpha$, the finite-rank term in (13) is generally signed. Its positivity must not be carried across the pole, even though (10) remains a positive exterior minimization on the constrained affine space.

## Explicit cancellation of the simple pole, with parity retained

Reflection symmetry makes the simple positive ground state even. Thus $\langle\psi,\tau_O\rangle=0$, and $G_z$ is diagonal. Put
$$
 \delta=\alpha-z,\quad
 R_z=\delta^{-1}|\psi\rangle\langle\psi|+R_{\rm reg}(z),
$$
where $R_{\rm reg}$ is analytic for real $z<\alpha+d$. Define
$$
 V=\langle Bx,\psi\rangle,\qquad
 g(z)=\langle R_{\rm reg}(z)1_O,1_O\rangle,
$$
$$
 A_x(z)=\langle x,1_C+B^*R_{\rm reg}(z)1_O\rangle.
$$
Then $G_{00}=\mu^2/\delta+g(z)$ and $a_0=\mu V/\delta+A_x(z)$. The singular Schur term and its mean correction combine exactly as
$$
 -\frac{|V|^2}{\delta}
 +\frac{|\mu V/\delta+A_x|^2}{\mu^2/\delta+g}
 =
 \boxed{\frac{2\mu\Re(V\overline{A_x})-g|V|^2+\delta|A_x|^2}
               {\mu^2+\delta g}.}
 \tag{14}
$$
At $\delta=0$, the right side is finite. It is a signed correction of rank at most two on the core, not an erasure of the ground-state history.

The odd contribution is
$$
 \frac{|\langle x,\tau_C+B^*R_{\rm reg}(z)\tau_O\rangle|^2}
 {\langle R_{\rm reg}(z)\tau_O,\tau_O\rangle},
 \tag{15}
$$
whose denominator is positive near $\alpha$. There is no odd residue.

The explicit interval (6) also controls the denominator in (14). For $z=\alpha+t$, $0<t<d\mu^2/M_O$,
$$
 g(z)\le\frac{M_O-\mu^2}{d-t},\qquad
 \mu^2-tg(z)\ge\frac{\mu^2d-tM_O}{d-t}>0.
 \tag{16}
$$
Thus (14) is regular throughout the guaranteed interval beyond the pole. More generally regularity on the entire interval $z<\zeta_R$ follows from (8)--(12), even if additional ordinary exterior poles require their own cancellations.

## Maximal interval and the separate positive-clock domain

The actual two-sided exterior has essential spectral bottom $\lambda=1/2$. Because $U\subset D(D)$, the decomposition $K\oplus\operatorname{Ran}U$ writes $D$ as $D_K$ plus a finite-dimensional block and bounded finite-rank off-diagonal terms. Hence
$$
 \inf\sigma_{\rm ess}(D_K)=\lambda,\qquad
 \gamma\le\zeta_R\le\lambda.
 \tag{17}
$$
The [exact pole-constrained exterior index theorem](theta-exterior-threshold-index-transport.md#exact-index-after-imposing-the-actual-pole-constraints) identifies the number of negative directions of $D_K-\lambda$ as $N_{\rm off}$. Therefore
$$
 \zeta_R=\lambda\ \Longleftrightarrow\ N_{\rm off}=0.
 \tag{18}
$$
If $N_{\rm off}>0$, then $\zeta_R<\lambda$ is a discrete constrained eigenvalue, so the next constrained inverse has a genuine pole there. If $\zeta_R=\lambda$, the endpoint is an essential spectral threshold and is not asserted to be an isolated pole. Equality in (18) is not proved unconditionally.

The positive history
$$
 \int_0^\infty e^{zt}B^*e^{-tD}B\,dt
$$
and its positive clock density were justified only for $z<\alpha$. The nonzero ground-state residue causes this raw positive Laplace history to diverge at and above $\alpha$. The bordered construction cancels that residue coherently under the affine moments; it does not continue the positive path measure or its Markov-clock interpretation. The previous weighted clock-domain and boundary compactness results apply in their original range, where the chosen uniform killing rate is greater than $z$, hence $z<\alpha$.

Equations (8)--(10) are the resulting pole repair. The remaining task is a comparison of the constrained core form $s_z^{\,c}$, not merely analytic continuation of its coefficients.

## The actual orthogonal lift gives a coherent Gram comparison

The lift already chosen in (4), (8) is orthogonal to $K$. Define the bounded maps
$$
 Y_0=-U(U^*U)^{-1}U_C^*,\qquad
 \widetilde C=P(B-DY_0).
 \tag{19}
$$
Their domains are the full core Hilbert space. The map $DY_0$ is bounded because the two columns of $U$ belong to $D(D)$. Moreover $\operatorname{Ran}Y_0\subset K^\perp$, so $PY_0=0$. Consequently the right side in (8) simplifies exactly:
$$
 P[B-(D-z)Y_0]=P(B-DY_0)=\widetilde C.
$$
In particular this source is independent of $z$, despite the nonzero affine core moments.

Set
$$
 M_0=I+Y_0^*Y_0,\qquad
 A_{\rm eff}=L_C+Y_0^*DY_0-B^*Y_0-Y_0^*B.
 \tag{20}
$$
The correction to $L_C$ is bounded selfadjoint. Thus $A_{\rm eff}$ is selfadjoint on $D(L_C)$, and its associated form has domain $D(E_C)$. The constrained effective operator and full stationary extension are
$$
 \boxed{F_z=A_{\rm eff}-zM_0
             -\widetilde C^*R_K(z)\widetilde C,}
$$
$$
 \boxed{\mathcal E_zx=(x,Y_0x+R_K(z)\widetilde Cx).}
 \tag{21}
$$
The form of $F_z$ is precisely $s_z^{\,c}$ in (9); it is not an additional approximation to it. Every $F_z$ has the common operator domain $D(L_C)$ and common form domain $D(E_C)$, since its $z$-dependent terms are bounded.

For real $z<\zeta_R$, differentiation of the actual resolvent gives
$$
 \boxed{F_z'=-M_0-\widetilde C^*R_K(z)^2\widetilde C
                  =-\mathcal E_z^*\mathcal E_z,}
$$
$$
 \boxed{F_z''=-2\widetilde C^*R_K(z)^3\widetilde C\le0.}
 \tag{22}
$$
These derivatives hold in operator norm for the bounded differences $F_z-F_t$, hence as derivatives of every core form value. To verify the Gram equality, the two cross terms in the norm of the exterior lift vanish:
$$
 Y_0^*R_K(z)=0,\qquad R_K(z)Y_0=0
$$
when $R_K$ is extended by zero on $K^\perp$. The remaining squared norm is $Y_0^*Y_0+\widetilde C^*R_K(z)^2\widetilde C$. Omitting $Y_0$, or replacing the source by the bare crossing operator, would drop the core's affine moment contribution.

More generally, for real $t,z<\zeta_R$,
$$
 \boxed{
 F_z=F_t-(z-t)\left[
 M_0+\widetilde C^*R_K(z)R_K(t)\widetilde C\right]
 =F_t-(z-t)\mathcal E_z^*\mathcal E_t.
 }
 \tag{23}
$$
The two resolvents commute and are positive, so the bracket is a positive selfadjoint operator at least $M_0\ge I$. This is a coherent two-parameter Gram identity across the original exterior pole $\alpha$, even though the eliminated spatial kernel and the finite-rank correction in (13) can be signed. It is not a positive Markov-clock continuation.

The explicit coercivity lower bound $D_K\ge\gamma$ yields a quantitative form comparison. For $t<z<\gamma$, scalar functional calculus gives
$$
 R_K(t)^2\le R_K(z)R_K(t)
 \le\frac{\gamma-t}{\gamma-z}R_K(t)^2,
 \tag{24}
$$
because $(\sigma-t)/(\sigma-z)$ decreases as the spectral variable $\sigma\ge\gamma$ increases. Therefore
$$
 \boxed{
 F_z\ge F_t-(z-t)M_0
 -\frac{(z-t)(\gamma-t)}{\gamma-z}
       \widetilde C^*R_K(t)^2\widetilde C,
 }
 \tag{25}
$$
and also
$$
 F_z\le F_t-(z-t)
       [M_0+\widetilde C^*R_K(t)^2\widetilde C].
 \tag{26}
$$
These are inequalities of actual forms on $D(E_C)$. If a sharper lower bound for $D_K$ is available, it can replace $\gamma$; no such improvement is presumed.

For threshold calibration, let $r=(x,y)\in D(L)$ satisfy $Lr=\lambda r$. Both moment constraints follow for every such vector from selfadjointness, $L1=0$, and the actual score identity $Ls=\lambda s-(\lambda/2)\tau$. Put
$$
 y-Y_0x=k=P y\in K.
$$
The projected exterior equation implies
$$
 \widetilde Cx=(D_K-\lambda)k.
$$
Thus for every $z<\zeta_R$,
$$
 \mathcal E_zx=(x,y-(\lambda-z)R_K(z)k).
 \tag{27}
$$
Applying the exact constrained square completion (10) to this actual threshold vector gives
$$
 \boxed{
 \langle x,F_zx\rangle
 =(\lambda-z)\|r\|^2
  -(\lambda-z)^2\langle k,R_K(z)k\rangle.
 }
 \tag{28}
$$
This retains the entire constrained exterior component, not only two moments. In particular the Gram monotonicity and concavity in (22)--(26) are consistent with all threshold vectors; they do not make these calibrated values uniformly positive or eliminate the remaining comparison of $F_t$ with its actual Gram cost.

No fixed-core limit $z\to\lambda$ is taken here. All identities require $z<\zeta_R$, and need no inverse at $\lambda$. They remain valid at the ordinary exterior pole $z=\alpha$ because only the constrained resolvent appears.
