# Exterior theta threshold: exact local spectral-mass bound for crossing sources

This written fixed-core theorem consumes the maximal-domain equality in
[the complete covariance clock](theta-complete-ground-covariance-clock.md),
the actual weighted crossing domain in
[the bounded weighted-crossing theorem](theta-groundstate-bounded-weighted-crossing.md),
and the centered residual gap in
[the continuous-remainder theorem](theta-continuous-remainder-explicit-gap.md).
The transformed source is exactly $f/\rho$.  Without the common-domain
theorem the same rank-one minorant would give only an upper comparison, not
the covariance identity below.  No moving-core uniformity or RH conclusion
is asserted.

## Result

Fix $C_R=[-R,R]$, $O_R=\mathbb R\setminus C_R$, and let

\[
 D_R=L_{O_R},\qquad D_R\psi_R=\alpha_R\psi_R,
 \qquad 0<\alpha_R<\lambda=\tfrac12,
 \qquad \|\psi_R\|_{L^2(\nu)}=1.                 \tag{1}
\]

The complete operator is a nonlocal jump operator.  Its conductance has
the singular continuous theta kernel and atoms at both
$\pm\log p^k$, for every prime power.  A Sturm--Liouville square-root
threshold law therefore does not follow from the established construction.
In fact the full operator has an infinite-dimensional exact threshold
space, and its restrictions produce exterior Weyl sequences.  The usual
one-dimensional nondegenerate-dispersion heuristic is inapplicable.

There is nevertheless an exact source-specific threshold estimate.  Put

\[
 \rho(u)=\frac{e^{-|u|/2}}{2\cosh(u/2)}
        =\frac1{e^{|u|}+1},\qquad
 d\gamma_R=\rho\psi_R\,d\nu,\qquad
 a_R=\gamma_R(O_R)>0,                              \tag{2}
\]

and, for $f\perp\psi_R$,

\[
 J_R(f)=\int_{O_R}\frac{\psi_R}{\rho}|f|^2d\nu.
                                                               \tag{3}
\]

Every actual centered crossing source has finite $J_R$.  The exact
rank-one-subtracted clock gives a nonnegative self-adjoint residual
generator $A_{{\rm rem},R}$ in $L^2(\gamma_R)$, retaining the continuous
remainder and every prime-power edge, such that

\[
 \boxed{
 \langle (D_R-\alpha_R)^{-1}_{\psi_R^\perp}f,f\rangle_\nu
 =\left\langle(a_R+A_{{\rm rem},R})^{-1}\frac f\rho,
                       \frac f\rho\right\rangle_{\gamma_R}.}
                                                               \tag{4}
\]

If $\eta_R\ge0$ is any proved centered gap of $A_{{\rm rem},R}$, then

\[
 \boxed{\quad
 \mathcal C_R(f,f)\le \frac{J_R(f)}{a_R+\eta_R}.
 \quad}                                                        \tag{5}
\]

This immediately controls the local spectral measure of the original
exterior operator.  If $E_R$ is its spectral resolution and $I$ is a
bounded Borel subset of $\sigma(D_R)\setminus\{\alpha_R\}$, then

\[
 \boxed{\quad
 \|E_R(I)f\|_\nu^2
 \le \sup_{s\in I}(s-\alpha_R)\,
       \frac{J_R(f)}{a_R+\eta_R}.
 \quad}                                                        \tag{6}
\]

For a discrete excited eigenmode $e_{j,R}$, (6) reads

\[
 |\langle f,e_{j,R}\rangle|^2
 \le (\alpha_{j,R}-\alpha_R)
       \frac{J_R(f)}{a_R+\eta_R}.                              \tag{7}
\]

Thus the residue of every small excited denominator is suppressed by that
same denominator on the actual weighted source class.  Likewise, for the
essential band $I=[\lambda,\lambda+h]$,

\[
 \|E_R(I)f\|^2
 \le(\Delta_R+h)\frac{J_R(f)}{a_R+\eta_R},
 \qquad \Delta_R=\lambda-\alpha_R.                             \tag{8}
\]

Equations (5)--(8), rather than $\|G_R\|=1/g_R$, are the applicable
limiting-absorption substitute.  They show that a shrinking exterior
spectral gap alone cannot amplify the arithmetic crossing source.  All
possible amplification has moved into the weighted ratio
$J_R(f)/(a_R+\eta_R)$.

For $R_X=\beta\log X$, no established moving-radius estimate controls
that ratio at the scale required by the Lambert metric.  Consequently the
present result removes the bare $1/\Delta_R$ loophole, but it does not
exclude compensation through degeneration of $a_R+\eta_R$ together with
growth of the weighted source norm.  Proving

\[
 \frac{J_{R_X}(f_X)}{a_{R_X}+\eta_{R_X}}=o(X)                  \tag{9}
\]

for the actual single-prime, two-prime, and squarefree crossing sources is
the exact remaining spectral theorem.  It is a source-weighted covariance
bound, not an ordinary density-of-states assertion.

## 1. Exact centering and the source domain

Let $B_R:L^2(C_R,\nu)\to L^2(O_R,\nu)$ be the complete hard-crossing
operator.  It includes the continuous crossings and both orientations of
every prime-power crossing.  Put

\[
 \mu_R=\langle1_{O_R},\psi_R\rangle,
 \qquad
 f_x=B_Rx-\frac{\langle B_Rx,\psi_R\rangle}{\mu_R}1_{O_R}.
                                                               \tag{10}
\]

Then $f_x\perp\psi_R$ exactly.  On the live observation-null condition

\[
 x\perp a_{c,R},\qquad
 a_{c,R}=B_R^*\psi_R/\mu_R,                                   \tag{11}
\]

one has $f_x=B_Rx$; hence no estimate of the possibly small $\mu_R$ is
introduced.  The proved weighted crossing theorem gives

\[
 J_R(f_x)<\infty\qquad(x\in L^2(C_R,\nu)),                    \tag{12}
\]

and the same conclusion after subtraction of the odd column
$c\tau_{O_R}$.  This is a fixed-$R$ bounded map.  Its theorem does not
assert a uniform moving-radius norm.

Since

\[
 \int_{O_R}\frac{f_x}{\rho}\,d\gamma_R
 =\int_{O_R}f_x\psi_Rd\nu=0,                                 \tag{13}
\]

the transformed source $S_x=f_x/\rho$ is centered in
$L^2(\gamma_R)$, exactly as required in (4).

## 2. Derivation of the spectral-mass estimate

The ground-state transform replaces $D_R-\alpha_R$ by the conservative
complete jump form with conductance

\[
 J_{\psi,R}(du,dv)=\psi_R(u)\psi_R(v)J_{O_R}(du,dv).           \tag{14}
\]

Its continuous part has the rank-one minorant
$\gamma_R\otimes\gamma_R$.  Subtracting only this minorant leaves a
nonnegative residual conductance $J_{{\rm rem},R}$; every prime-power
atom is unchanged.  The two maximal form domains agree, and the exact
form identity is

\[
 \mathsf E_R(F)=E_{{\rm rem},R}(F)
       +a_R\|F-\overline F_{\gamma_R}\|_{L^2(\gamma_R)}^2.
                                                               \tag{15}
\]

Solving the centered Poisson equation in this common domain proves (4).
If

\[
 A_{{\rm rem},R}\ge\eta_R
 \quad\hbox{on }1^\perp\subset L^2(\gamma_R),                 \tag{16}
\]

functional calculus gives (5).

On the other hand, the spectral theorem for $D_R$ gives

\[
 \mathcal C_R(f,f)
 =\int_{\sigma(D_R)\setminus\{\alpha_R\}}
       \frac{d\|E_R(s)f\|^2}{s-\alpha_R}.                    \tag{17}
\]

For any spectral set $I$, its contribution to (17) is at least

\[
 \frac{\|E_R(I)f\|^2}{\sup_{s\in I}(s-\alpha_R)}.             \tag{18}
\]

Combining (5) and (18) proves (6), including (7)--(8).  No regularity of a
generalized eigenfunction, absolute continuity of the essential spectrum,
or density-of-states formula is assumed.

## 3. Parity, observations, and squarefree incidence

Reflection commutes with $D_R$, $B_R$, the ground projection, and
$A_{{\rm rem},R}$.  Therefore (4)--(8) hold separately in the even and
odd sectors.  The constant centering column is even.  The optimized
$\tau_{O_R}$ column is odd.  Keeping both path orientations forms the
symmetric and antisymmetric arithmetic sources and sends them to the even
and odd inequalities respectively; it does not duplicate one residue.

For an excited eigenmode, the exact core alignment vector remains

\[
 A_{e,R}=B_R^*e-\frac{\langle1_{O_R},e\rangle}{\mu_R}B_R^*\psi_R.
                                                               \tag{19}
\]

If $K_R$ denotes the finite observation-null subspace, then

\[
 \sup_{x\in K_R,\ \|x\|=1}|\langle f_x,e\rangle|
 =\|P_{K_R}A_{e,R}\|.                                        \tag{20}
\]

Inequality (7) is the additional source-domain upper bound on this exact
alignment coefficient.  Finite observations only replace the alignment
vector by $P_{K_R}A_{e,R}$; they do not alter the proof.

A two-prime cell retains the incidence difference $f_p-f_r$.  A general
squarefree path $d=p_1\cdots p_k$ retains coefficients
$(-1)^{k+j-1}$ before (3), (4), or (17) is evaluated.  Repeated primes
have zero terminal Möbius coefficient, while all proper prime powers remain
in $D_R$, $B_R$, and $A_{{\rm rem},R}$.  Hence (5)--(8) apply to the
complete signed sum, without estimating its path components separately.

## 4. What the endpoint estimate does and does not give

For the normalized balanced arithmetic path sources from the finite-window
analysis, with $\beta<1/2$, the unweighted endpoint estimate is

\[
 \|f_X\|_\nu\le E_X=X^Ae^{-\kappa X}.                         \tag{21}
\]

If a localized piece is supported in $|u|\le U_X+L$, then the elementary
bound $\rho(u)^{-1}\le e^{U_X+L}+1$ gives

\[
 J_{R_X}(f_X)
 \le \|\psi_{R_X}\|_\infty
       (e^{U_X+L}+1)E_X^2.                                    \tag{22}
\]

For balanced endpoints $U_X=\tfrac12\log X+O(1)$, this costs only an
extra $X^{1/2+o(1)}$ apart from the moving ground-state factor.  The
weighted tails outside the localization window must be bounded in the same
metric; an unweighted tail estimate cannot simply replace them.

Combining (5) and (22) shows that exponential endpoint suppression defeats
threshold amplification provided

\[
 \frac{\|\psi_{R_X}\|_\infty}
      {a_{R_X}+\eta_{R_X}}
 =e^{o(X)}.                                                    \tag{23}
\]

No such moving-radius estimate is currently proved.  The available
positive lower bounds for $a_R$ and $\eta_R$ use a finite strip, an
$L^\infty$ ground-state barrier, and bridge masses; they are explicitly
fixed-core and become nonuniform when $R=\beta\log X$.  Conversely, the
upper bound

\[
 a_R\le\rho(R)\sqrt{\nu(O_R)}                                 \tag{24}
\]

does not furnish the lower denominator needed in (5).

Thus no polynomial or square-root divergence law is justified at present.
What is proved is more structural: the gap denominator cancels against the
local spectral residue, and the entire covariance is bounded by the
weighted clock ratio in (5).  Determining the moving asymptotics of that
ratio is the remaining source-specific problem.

## 5. Why a scalar scattering law is unavailable

Three established facts prevent importing a standard half-line
Sturm--Liouville conclusion.

1. $D_R$ contains nonlocal continuous jumps and all translations
   $\pm\log p^k$.  It is not a local second-order operator.
2. The full theta operator has infinitely many independent exact
   threshold vectors.  Their exterior restrictions give a singular Weyl
   sequence at $1/2$ for every fixed core.  The threshold is therefore
   not known to be a simple two-channel quadratic band edge.
3. The exterior subthreshold index is $1+N_{\rm off}$, with the exact
   zero-count convention of the theta index theorem.  Controlling all
   discrete excited modes by asserting their absence would insert the
   unresolved zero-location statement.  Inequality (7) avoids that step by
   controlling their residues source by source.

A conventional limiting-absorption theorem with a square-root density may
still hold on a specially identified scattering subspace, but neither that
subspace nor the required uniform generalized-eigenfunction estimates have
been constructed for the complete prime-power operator.  Such a theorem
would also have to imply (9) for the actual moving crossing family to affect
the Lambert comparison.

## Classification

For each fixed radius and centered source in the actual weighted domain,
equations (6)--(8) show that every small spectral denominator carries a
proportionally small source residue, with proportionality constant
(J_R(f)/(a_R+\eta_R)).  This fixed-radius theorem retains centering,
parity, finite observations, both orientations, and all prime powers.  It
does not bound that proportionality constant uniformly over a moving source
family.

The moving-core central-arc application remains open because the proved
weighted crossing norm, $a_R$, and the residual gap $\eta_R$ have no
uniform estimates at $R=\beta\log X$.  The precise missing assertion is
(9), or the sufficient subexponential condition (23) together with the
weighted tail version of (22).  Establishing it would be a genuine
source-specific covariance theorem; it cannot be replaced by
$\|G_R\|$, a scalar square-root threshold heuristic, or an assumption
that there are no excited subthreshold modes.
