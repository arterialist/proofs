# The actual excursion clock on the full killed core form domain

Use the operators and normalization in the [complete return construction](theta-killed-core-return-comparison.md). Let $C=[-R,R]$, $O=\mathbb R\setminus C$, $A(u)=2\cosh(u/2)$, $d\nu=A\Phi\,du$, and $\lambda=1/2$. Fix $0<z<\lambda$. Every prime power and the complete continuous jump measure are retained.

Write
$$
 \kappa_O=B1_C,\qquad \kappa_C=B^*1_O.
 \tag{1}
$$
This is a written actual-source domain theorem. Its semigroup comparison is the standard nonnegative-killing argument for Dirichlet forms; the proof retains the complete theta and prime departure rates. It has no Lean formalization or sharp-gap conclusion.

These are the actual departure rates from the exterior into the core and from the core into the exterior. They are finite at every point off the two boundary points. Infinite activity within a region is not included as a finite total rate.

## A uniform lower bound for the actual exterior killing rate

The complete prime departure rate is
$$
 b_{\rm p}(u)=\frac1{A(u)}
 \sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
       [\Phi(u+\log q)+\Phi(u-\log q)].
 \tag{2}
$$
The established unconditional actual return law in section 7 of the [actual jump-form chapter](theta-weil-jump-form.md) gives
$$
 d_R^{\rm ret}:=\sup_{|u|>R}|b_{\rm p}(u)-\lambda|
 \longrightarrow0.
 \tag{3}
$$
This is the ordinary arithmetic return law, not the spectral sharp-gap premise.

Here is a separate bound for the prime arrivals that remain outside the core. Choose a Chebyshev constant $C_\psi$ with $\psi(y)\le C_\psi y$, $y\ge1$, and define
$$
 T_R=\sum_{j\in\mathbb Z}
 \sup_{v\in[j,j+1]\cap O}
       e^{|v|/2}\Phi(v),
 \tag{4}
$$
with the supremum of the empty set defined as zero. The complete theta decay implies $T_R\to0$. Indeed the sum without restriction to $O$ is finite, and each fixed summand eventually vanishes.

On a logarithmic unit interval,
$$
 \sum_{k\le\log q<k+1}\frac{\Lambda(q)}{\sqrt q}
 \le C_\psi e\,e^{k/2}\qquad(k\ge0).
 \tag{5}
$$
For a destination $v=u-a$, $e^{a/2}/A(u)\le e^{-v/2}$; for $v=u+a$, it is at most $e^{v/2}$. The sum of suprema over a translated unit partition is bounded by twice that over the integer partition. Applying (5) to both orientations therefore proves, uniformly for all real $u$,
$$
\begin{split}
 i_R(u):={}&\frac1{A(u)}
 \sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
 \bigl[
 1_O(u+\log q)\Phi(u+\log q)
 +1_O(u-\log q)\Phi(u-\log q)\bigr]\\
 &\le4eC_\psi T_R.
\end{split}
 \tag{6}
$$
All weights are positive, and no power has been omitted.

The continuous jumps into the core only increase the killing rate. Thus for $u\in O$,
$$
 \kappa_O(u)\ge b_{\rm p}(u)-i_R(u)
 \ge\lambda-d_R^{\rm ret}-4eC_\psi T_R.
 \tag{7}
$$
Choose $R$ sufficiently large that
$$
 d_R^{\rm ret}+4eC_\psi T_R
 \le\frac{\lambda-z}{2}.
$$
Then
$$
 \boxed{\kappa_O(u)\ge\kappa_*:=(\lambda+z)/2>z}
 \quad\text{for almost every }u\in O.
 \tag{8}
$$
One may enlarge a core already chosen for the spectral exterior bound. This new choice uses the pointwise return law as well as theta tails; it is not claimed for every radius satisfying only a spectral bound.

## The complete killed resolvent is bounded on the constant source

The killed exterior form is the internal exterior jump energy plus
$$
 \int_O\kappa_O(u)|y(u)|^2\,d\nu(u).
$$
Subtracting the bounded constant $\kappa_*\|y\|_\nu^2$ leaves a closed Dirichlet form with nonnegative killing potential. Its semigroup is sub-Markov. Consequently the actual killed semigroup, with its full infinite small-jump activity, satisfies
$$
 0\le e^{-tL_O}1_O\le e^{-\kappa_*t}1_O.
 \tag{9}
$$
No bounded-rate jump expansion is needed for this step.

The positive resolvent source $u_z=(L_O-z)^{-1}1_O$ therefore satisfies
$$
 \boxed{0\le u_z\le\frac1{\kappa_*-z}
       \le\frac2{\lambda-z}.}
 \tag{10}
$$
The semigroup integral converges both in $L^\infty$ and $L^2(\nu_O)$, and agrees with the actual Hilbert-space resolvent. Thus there is no separate inverse or extension being substituted.

## The clock weight is controlled by the exact core killing energy

The lifted clock density is
$$
 g_z=1_C+B^*u_z.
 \tag{11}
$$
Positivity of the complete crossing operator and (10) give the pointwise estimate
$$
 \boxed{1\le g_z\le1+\frac{\kappa_C}{\kappa_*-z}.}
 \tag{12}
$$
The killed core form retains all cross-boundary departure costs, so
$$
 E_C[x]\ge\int_C\kappa_C|x|^2\,d\nu.
 \tag{13}
$$
It follows for every $x\in D(E_C)$, without a boundedness assumption on $x$, that
$$
 \boxed{
 \int_Cg_z|x|^2\,d\nu
 \le\|x\|_\nu^2+\frac{E_C[x]}{\kappa_*-z}
 \le\|x\|_\nu^2+\frac{2E_C[x]}{\lambda-z}.
 }
 \tag{14}
$$
The estimate first follows directly from the nonnegative measurable integrands in (12)--(13), so no passage through an unproved $L^\infty$ core approximation is required. In particular the embedding of $D(E_C)$, with its form norm, into $L^2(g_z\nu)$ is continuous.

This removes the additional clock-integrability restriction from the paired jump and potential identity in section 7 of the [complete return construction](theta-killed-core-return-comparison.md). Its positive jump piece and positive clock-potential piece can both be defined separately on the full killed core form domain. It does not estimate their difference with a sign sufficient for the threshold $\lambda$.

## The boundary upper bound has the actual logarithmic coefficient

Only the continuous crossing kernel is singular at the boundary. For $v=R-d$, $d\downarrow0$, write the right exterior point as $R+y$. The local part of $\kappa_C(v)$ is
$$
 \frac1{A(R-d)}\int_0^\eta
     \Phi(R+y)r(d+y)\,dy.
$$
Since $r(t)=1/(2t)+O(1)$ and $\Phi,A$ are smooth and positive there,
$$
 \boxed{\kappa_C(R-d)
  =\frac{\Phi(R)}{2A(R)}\log(1/d)+O_R(1).}
 \tag{15}
$$
The change in the smooth numerator is $O_R(d+y)$, which cancels the denominator singularity in its error integral. All remaining continuous lengths have an integrable kernel, and the prime crossing rate is bounded by the complete bounded departure rate (2). Thus neither adds another boundary singularity. Evenness gives the same coefficient at $-R+d$.

Combining (12) and (15) yields
$$
 g_z(R-d)\le
 \frac{\Phi(R)}{2A(R)(\kappa_*-z)}\log(1/d)+O_{R,z}(1),
 \tag{16}
$$
and the analogous upper bound at the left boundary. The asymptotic equality (15) is for the killing rate $\kappa_C$. No boundary trace of $u_z$, and no matching asymptotic or $L^\infty$ assertion for $g_z$, is assumed in deriving (14)--(16).
