# An exact complete-ground covariance in the rank-one-subtracted clock

This is a written proof for the actual full theta jump form. No theorem in this chapter is formalized in Lean. The killed-ground-state and constrained-domain inputs are established in the [ground-pole theorem](theta-killed-return-ground-pole.md) and [constrained Schur construction](theta-constrained-schur-across-ground-pole.md).

Ground-state transformation, resolvent covariance, monotone form convergence and Dirichlet energy duality are classical. The full maximal-domain equivalence and the actual source and affine-optimizer formulas are proved below. The [signed-flow chapter](theta-groundstate-covariance-comparison-literature.md) gives primary attribution and explains the finite-rate path theorem limitation.

The full exterior covariance can be represented exactly after changing the reference measure and retaining the entire conductance left after the proved rank-one minorant. The domain equivalence is essential: without it the same variational calculation gives only an upper bound. This construction keeps the continuous infinite activity, every prime power, and the ground-state constant. It does not continue the uncentered exterior resolvent through its ground pole.

Fix a core $C=[-R,R]$, its exterior $O$, and the full killed operator $D=L_O$. Use the established normalized positive ground state and centered gap
$$
D\psi=\alpha\psi,\quad\|\psi\|_\nu=1,\quad\psi>0\text{ a.e.},
\quad d=\inf(\sigma(D)\setminus\{\alpha\})-\alpha>0.
$$
The source [theta-groundstate-bounded-weighted-crossing.md](theta-groundstate-bounded-weighted-crossing.md) proves $\psi\in L^\infty$ and boundedness of the actual weighted crossing map on all core $L^2$ inputs. The exact maximal ground-state form and its centered covariance are from [theta-groundstate-green-covariance.md](theta-groundstate-green-covariance.md).

Put
$$
b(u)=2\cosh(u/2),\quad d\nu=b\Phi\,du,\quad
\rho(u)=e^{-|u|/2}/b(u),\quad
 d\mu=\psi^2d\nu,\quad d\gamma=\rho\psi d\nu,\quad a=\gamma(O)>0.
\tag{1}
$$
Here $\mu$ is a probability measure, while $\gamma$ has mass $a$. They are equivalent measures but are not identified. Write $\mu F=\int Fd\mu$ and $\overline F_\gamma=a^{-1}\int Fd\gamma$.

## 1. The complete residual conductance

The directed full ground-state conductance is $J_\psi=\psi(u)\psi(v)J_O$. Its continuous density is
$$
\psi(u)\psi(v)\Phi(u)\Phi(v)r(|u-v|)\,du\,dv,
\qquad r(t)=\frac{e^{-t/2}}{1-e^{-2t}},
$$
and its prime part consists of every directed displacement $v=u\pm\log q$, $q\ge2$, with coefficient
$\Lambda(q)\psi(u)\psi(v)\Phi(u)\Phi(v)/\sqrt q$, restricted to both endpoints in $O$.

The rank-one minorant is subtracted only from the continuous part:
$$
\boxed{\quad J_{\rm rem}=J_\psi-\gamma\otimes\gamma\ge0.\quad}
\tag{2}
$$
Its remaining continuous density is exactly
$$
\psi(u)\psi(v)\Phi(u)\Phi(v)
\left[r(|u-v|)-e^{-(|u|+|v|)/2}\right]du\,dv.
\tag{3}
$$
This density is strictly positive almost everywhere off the diagonal, since
$r(|u-v|)>e^{-|u-v|/2}\ge e^{-(|u|+|v|)/2}$.
Every prime-power conductance is unchanged.

On $L^2(\gamma)$, define the maximal residual form
$$
E_{\rm rem}(F)=\tfrac12\int|\Delta F|^2J_{\rm rem},\qquad
V_{\rm rem}=\{F\in L^2(\gamma):E_{\rm rem}(F)<\infty\}.
\tag{4}
$$
This is a densely defined closed Markov form. The edge measure is sigma-finite off the diagonal, and both marginals send $\gamma$-null sets to zero. For the continuous part this follows from absolute continuity; for prime edges it follows from translation invariance of Lebesgue null sets and equivalence of $\gamma$ to Lebesgue measure. The difference map into $L^2(J_{\rm rem}/2)$ is therefore closed by an almost-everywhere subsequence argument.

Density follows from smooth compact tests. Their continuous energy is finite because $\psi$ is bounded, the theta factors are integrable, and $r(t)\min(1,t^2)$ is integrable near zero and at infinity. Their prime energy is finite because the complete directed ground-state prime conductance has finite mass. Smooth compact tests are dense in $L^2(\gamma)$; form density of these tests is not needed for this maximal-domain assertion. Normal contractions decrease the edge energy.

Let $A_{\rm rem}\ge0$ be its self-adjoint generator. Constants have zero energy and belong to the form domain, hence
$$
1\in D(A_{\rm rem}),\qquad A_{\rm rem}1=0.
\tag{5}
$$
The strict positive continuous density in (3) shows that the kernel consists exactly of constants. A separate [continuous remainder theorem](theta-continuous-remainder-explicit-gap.md) gives a quantitative centered gap for this generator. The domain and covariance identities below do not require that sharper bound.

## 2. The two maximal potential domains are exactly the same

Let
$$
\mathsf E(F)=\tfrac12\int|\Delta F|^2J_\psi,
\qquad
\mathsf V=\{F\in L^2(\mu):\mathsf E(F)<\infty\}.
$$
The established ground-state transform identifies this with
$E_O(\psi F)-\alpha\|\psi F\|_\nu^2$, and gives
$$
\mathsf E(F)\ge d\|F-\mu F\|_\mu^2.
\tag{6}
$$
Introduce finite constants
$$
c_\mu^2=\int_O\frac{\psi^3}{\rho}\,d\nu<\infty,
\qquad c_\gamma^2=\int_O\rho^2d\nu<\infty.
\tag{7}
$$
The first uses $\psi\in L^\infty$ and theta decay. They are the squared $L^2$ norms of $d\mu/d\gamma$ and $d\gamma/d\mu$, respectively, in their corresponding reference measures.

Suppose first that $F\in V_{\rm rem}$. Its complete edge energy is finite because the omitted rank energy is at most $a\|F\|_\gamma^2$. For the bounded radial truncations $F_n$, one has
$|F_n|\le|F|$ and $|\Delta F_n|\le|\Delta F|$. Since $\mu$ is finite, each $F_n$ lies in the original maximal domain $\mathsf V$. By (6), Cauchy--Schwarz in $\gamma$, and (7),
$$
\|F_n\|_\mu^2
\le d^{-1}\mathsf E(F_n)+|\mu F_n|^2
\le d^{-1}\mathsf E(F)+c_\mu^2\|F\|_\gamma^2.
$$
Fatou gives $F\in L^2(\mu)$, and the maximal-domain identity puts $F$ in $\mathsf V$. Thus
$$
\|F\|_\mu^2\le d^{-1}\mathsf E(F)+c_\mu^2\|F\|_\gamma^2.
\tag{8}
$$
For complex functions, radial truncation is a contraction of the Euclidean plane, so the same argument applies without a factor loss.

Conversely, let $F\in\mathsf V$. Since $J_\psi\ge\gamma\otimes\gamma$, finite rank energy and Fubini first show $F\in L^2(\gamma)$: choose an endpoint with finite value for which the integral of its squared differences is finite, and then add that constant. The exact rank-variance identity and the other Cauchy--Schwarz estimate give
$$
a\|F\|_\gamma^2-|\gamma F|^2\le\mathsf E(F),
\qquad |\gamma F|\le c_\gamma\|F\|_\mu,
$$
so
$$
\|F\|_\gamma^2\le a^{-1}\mathsf E(F)
 +a^{-1}c_\gamma^2\|F\|_\mu^2.
\tag{9}
$$
Also $E_{\rm rem}(F)\le\mathsf E(F)$. Consequently, as sets of measurable functions modulo the common null sets,
$$
\boxed{\quad
V_{\rm rem}=\mathsf V,\qquad
\mathsf E(F)=E_{\rm rem}(F)
 +a\|F-\overline F_\gamma\|_\gamma^2.
\quad}
\tag{10}
$$
Equations (8)–(9) give equivalence of their form norms. This is not a claim that all of $L^2(\mu)$ equals all of $L^2(\gamma)$.

The generator of the complete form in the $\gamma$ clock is
$A_{\rm rem}+a(I-P_\gamma)$, where $P_\gamma F=\overline F_\gamma$.
The original ground-state generator acts in $L^2(\mu)$. Their form potentials agree by (10), while their operator domains and clocks need not agree without the corresponding source integrability.

## 3. A conservative residual semigroup with continuous infinite activity

The form (4) generates a symmetric positive Markov semigroup
$T_t^{\rm rem}=e^{-tA_{\rm rem}}$. Equation (5) gives
$T_t^{\rm rem}1=1$, so $\gamma/a$ is stationary and the process is conservative in this normalization.

Its rate measure, understood through compensated differences, is
$$
q_{\rm rem}^{\gamma}(u,dv)
 =\frac{\psi(v)}{\rho(u)}q_O(u,dv)-\gamma(dv),
\tag{11}
$$
where the subtraction concerns the continuous part only and is nonnegative by (3). All prime atoms retain their rates $\psi(v)q_{{\rm p},O}(u,dv)/\rho(u)$. The continuous total rate is infinite at almost every interior Lebesgue point with $\psi(u)>0$: the original $1/|u-v|$ singularity survives, and the subtracted measure has finite total mass $a$. There is no exponential holding-time construction at the full rate.

There is nevertheless a direct positive history approximation. Restrict both endpoints to $|u|,|v|\le n$, omit continuous displacements smaller than $1/n$, and keep prime powers $q\le n$. These symmetric residual measures increase to (2). Their rates relative to $\gamma$ are uniformly finite for each fixed $n$: $\rho^{-1}$ is bounded on the endpoint region, $\psi$ is bounded, the continuous singularity is truncated, and only finitely many prime shifts remain. Each defines a genuine conservative finite-rate jump process on the same measure space, with the identity process outside its active region.

Their bounded forms increase to the maximal form (4). The resolvents converge strongly: the variational minimizers of $a\|v\|_\gamma^2+E_n(v)-2\operatorname{Re}\langle S,v\rangle$ have bounded norm and energies; every weak limit has the full limit energy by testing each fixed truncation, and uniqueness plus uniform convexity gives strong convergence. Functional calculus then gives strong convergence of the semigroups. Thus the complete history law is the Markov-semigroup limit of these positive finite-activity laws, retaining every continuous and prime displacement in the limit.

On the standard Borel exterior, the Markov transition operators admit stationary transition kernels. This supplies the two-time laws below, or a stationary realization via its consistent finite-dimensional distributions. No additional Feller, smooth-boundary, or cadlag-path assertion is needed. In particular no finite-rate theorem is being applied directly to the infinite-activity generator (11).

## 4. Exact covariance and the retained ground-state constant

For $f\in L^2(O,\nu)$, $f\perp\psi$, assume initially
$$
S=f/\rho\in L^2(\gamma),\qquad \gamma S=0.
$$
The weighted hypothesis holds for every actual centered crossing source from core $L^2$, and for its odd modifications, by the bounded weighted crossing theorem.

For every common-domain potential $F$,
$$
\langle f,\psi F\rangle_\nu=\langle S,F\rangle_\gamma.
$$
Constants cancel on both sides. Using the exact same potential domain in (10), rather than enlarging it, proves
$$
\boxed{\quad
\mathcal C(f,f)=\langle(D-\alpha)^{-1}_{\psi^\perp}f,f\rangle_\nu
 =\left\langle(a+A_{\rm rem})^{-1}S,S\right\rangle_\gamma.
\quad}
\tag{12}
$$
Polarization gives the corresponding mixed covariance. There is no comparison loss in (12).

Let $v=(a+A_{\rm rem})^{-1}S$. It is $\gamma$-centered, lies in $D(A_{\rm rem})$, and its common-domain weak equation is the original ground-state Poisson equation. Therefore its relation to the original centered solution is exactly
$$
\boxed{\quad
\frac{Gf}{\psi}=v-\mu v,
\qquad G=(D-\alpha)^{-1}_{\psi^\perp}.
\quad}
\tag{13}
$$
This retains the constant needed to enforce the original ground-state orthogonality. No inverse of the uncentered $D-\alpha$ is used.

Functional calculus gives the convergent complete-history integral
$$
\mathcal C(f,q)=\int_0^\infty e^{-at}
 \left\langle T_t^{\rm rem}(f/\rho),q/\rho\right\rangle_\gamma\,dt.
\tag{14}
$$
Its absolute value is bounded by $a^{-1}\|f/\rho\|_\gamma\|q/\rho\|_\gamma$; on the diagonal the integrand is nonnegative. The factor $e^{-at}$ is genuine killing at an independent clock, whereas the residual process itself is conservative.

## 5. The complete gain and exactly recovered continuous loss

Write
$$
Q(f,q)=a^{-1}\langle f/\rho,q/\rho\rangle_\gamma,
\qquad D_{\rm all}(f)=Q(f,f)-\mathcal C(f,f).
$$
If $Y_t$ is stationary under $\gamma/a$ for the residual process and $\mathcal T\sim\operatorname{Exp}(a)$ is independent, then
$$
\mathcal C(f,q)=\mathbb E[(f/\rho)(Y_{\mathcal T})
                   \overline{(q/\rho)(Y_0)}],
$$
$$
\boxed{\quad
D_{\rm all}(f)=\frac12\mathbb E
 \left|(f/\rho)(Y_{\mathcal T})-(f/\rho)(Y_0)\right|^2.
\quad}
\tag{15}
$$
The rate $a$ and the stationary mass normalization cancel exactly. In operator form, with $v$ from (13),
$$
D_{\rm all}(f)=a^{-1}\langle A_{\rm rem}(a+A_{\rm rem})^{-1}S,S\rangle
 =E_{\rm rem}(v)+a^{-1}\|A_{\rm rem}v\|^2.
\tag{16}
$$
It is strictly positive for every nonzero centered $f$ in the stated source class.

Let $E_p$ be the maximal form on $L^2(\gamma)$ obtained by retaining only the complete internal prime-power conductance of $J_\psi$, and let $A_p$ be its nonnegative generator. The same closed-difference and density argument as in §1 applies. Define $\mathcal U_p(f,q)=\langle(a+A_p)^{-1}(f/\rho),q/\rho\rangle_\gamma$ and $D_p(f)=Q(f,f)-\mathcal U_p(f,f)$.

Since $E_{\rm rem}\ge E_{\rm p}$, the resolvent order gives
$$
\boxed{\quad D_{\rm all}(f)\ge D_{\rm p}(f).\quad}
\tag{17}
$$
There is an exact description of the recovered loss. Let
$v_p=(a+A_p)^{-1}S$, and let $E_c^{\rm rem}$ be the continuous form with density (3). Variational completion at $v$ gives
$$
\boxed{\quad
\mathcal U_p(f,f)-\mathcal C(f,f)
 =E_c^{\rm rem}(v)+a\|v-v_p\|_\gamma^2+E_p(v-v_p).
\quad}
\tag{18}
$$
Every term is finite: $v$ is in the full common domain and $v_p$ is in the prime form domain. The strictly positive continuous density implies $E_c^{\rm rem}(v)>0$ for nonzero centered $S$, so (17) is then strict. This is an exact accounting for the continuous part previously discarded, not a claimed uniform fractional improvement.

## 6. The full affine core identity, with its actual optimizer

For a core input $x$, put
$$
f=Bx-\frac{V}{\mu_1}1_O,\quad
V=\langle Bx,\psi\rangle,\quad\mu_1=\langle1_O,\psi\rangle>0,
\quad m_1=\langle x,1_C\rangle,\quad m=\langle x,\tau_C\rangle,
\quad q=\tau_O.
$$
All these weighted source expressions are finite for every core $L^2$ input. On the core form domain define the literal baseline
$$
\mathcal B(x)=E_C[x]-\alpha\|x\|^2
 +\frac{2\operatorname{Re}(V\overline{m_1})}{\mu_1}.
$$
The exact full affine form is
$$
F_\alpha[x]=\mathcal B(x)
 -\min_{c\in\mathbb C}
   \{\mathcal C(f-cq,f-cq)-2\operatorname{Re}(c\overline m)\}.
\tag{19}
$$
With pairings linear in the first argument, its optimizer and the old rank-one optimizer are respectively
$$
c_C=\frac{\mathcal C(f,q)+m}{\mathcal C(q,q)},
\qquad c_Q=\frac{Q(f,q)+m}{Q(q,q)}.
\tag{20}
$$
Both denominators are positive. At the actual optimizer, the exact complete-gain readout is
$$
\boxed{\quad
F_\alpha[x]=\mathcal B(x)
 -\{Q(f-c_Cq,f-c_Cq)-2\operatorname{Re}(c_C\overline m)\}
 +D_{\rm all}(f-c_Cq).
\quad}
\tag{21}
$$
If the rank-one baseline is already optimized, write
$$
F_{\rm rank}[x]=\mathcal B(x)-Q(f,f)
                    +\frac{|Q(f,q)+m|^2}{Q(q,q)}.
$$
The useful alternative with only nonnegative corrections is
$$
\boxed{\quad
F_\alpha[x]=F_{\rm rank}[x]
 +D_{\rm all}(f-c_Qq)
 +\mathcal C(q,q)|c_Q-c_C|^2.
\quad}
\tag{22}
$$
Indeed evaluating the $\mathcal C$-affine quadratic at $c_Q$ differs from its minimum by exactly the last square. Equivalently, at $c_C$, one has
$$
F_\alpha[x]=F_{\rm rank}[x]
 +D_{\rm all}(f-c_Cq)-Q(q,q)|c_C-c_Q|^2.
\tag{23}
$$
The optimizer correction must not be omitted or assigned the wrong sign. The mean source, the odd source, the ground-state normalization, and the complete conductance all remain in (19)–(23).

Equations (12) and (22) close the loss caused by discarding the continuous remainder in the prime-only comparison. They do not show that the positive complete gain pays the possible negative value of $F_{\rm rank}$. The resulting signed core comparison, and hence the actual theta sharp gap and RH objective, remain unproved.
