# Cancellation-aware truncation of the coherent prime continuous edge

This note treats the first unevaluated scalar

\[
 \mathcal C_P=\int_{O_2}\Gamma_c(P)(u)\,\psi(u)^2d\nu(u).     \tag{1}
\]

It gives an exact finite prime-power head and an explicit form of the tail
certificate.  The two contributions to the coherent source remain combined
inside each translated column.  No numerical value is claimed because the
published form-domain theorem does not evaluate the two tail constants
appearing below.

## 1. One coherent column per prime power

Put

\[
 H(v)=(1-k)\Phi'(v)1_{[-2,2]}(v)
       -2\eta_p\Phi(v)\psi(v)1_{\{v<-2\}},                   \tag{2}
\]

and, for every integer \(n\ge2\),

\[
 a_n=\frac{\Lambda(n)}{\sqrt n},\qquad
 X_n(u)=e^{u/2}H(u-\log n).                                  \tag{3}
\]

Then on the positive exterior half-line

\[
 P_+(u)=\sum_{n\ge2}a_nX_n(u),                               \tag{4}
\]

and the negative half is its prescribed odd reflection.  Formula (3) is
the key grouping: the compact \(\Phi'\) source and the exterior ground
profile are added before translation, differencing, or squaring.  Expanding
them separately would delete their mixed term.

Let \(\mathscr E_c(F,G)\) be the polarized normalized continuous row form,
using the same residual conductance that defines \(\Gamma_c\):

\[
 \mathscr E_c(F,G)=
 \frac12\int_{O_2}\psi(u)^2\Phi(u)
 \int_{O_2}\Phi(v)r(|u-v|)
 \Delta F(u,v)\overline{\Delta G(u,v)}\,dv\,du,              \tag{5}
\]

The display writes the corresponding full conductance for readability; using
it in place of the residual conductance only enlarges the upper bound.  With
the residual conductance one has

\[
                         \mathcal C_P=\mathscr E_c(P,P).       \tag{6}
\]

## 2. Exact finite head

For an integer cutoff \(N\ge2\), define

\[
 P_N=\sum_{2\le n\le N}a_nX_n,
 \qquad R_N=P-P_N.                                            \tag{7}
\]

The head energy is the finite Gram expression

\[
\boxed{
 \mathcal C_{P,N}:=\mathscr E_c(P_N,P_N)
 =\sum_{2\le n,m\le N}a_na_m\mathscr E_c(X_n,X_m).}          \tag{8}
\]

Because \(a_n=0\) away from prime powers, (8) is literally a finite
prime-power sum.  Each entry \(\mathscr E_c(X_n,X_m)\) contains all four
pairings between the two summands of (2), including their signs.  It also
contains both exterior halves and the actual normalized ground density.

Minkowski in the continuous edge Hilbert space gives the rigorous
cancellation-aware split

\[
 \boxed{
 \sqrt{\mathcal C_P}
 \le\sqrt{\mathcal C_{P,N}}+\sqrt{\mathscr E_c(R_N,R_N)}.}    \tag{9}
\]

Only the separation between the finite head and infinite tail loses their
mutual cross term.  No cancellation inside the head or inside a coherent
column is lost.

## 3. Explicit arithmetic tail once two analytic constants are known

The existing complete-prime form-domain proof implies constants
\(C_H<\infty\), \(c_H>0\), and \(N_H\) such that

\[
 \|X_n\|_{\mathscr E_c}\le C_He^{-c_Hn},
 \qquad n\ge N_H.                                             \tag{10}
\]

This is the same guarded theta estimate used for the prime profile, now
applied to the already combined \(H\) in (2).  It retains every proper
power because no arithmetic index is removed.

For \(N\ge\max(N_H,1/c_H)\), \(\Lambda(n)\le\log n\le n\) and
\(\sqrt{N+1+j}\le\sqrt{N+1}e^{c_Hj/2}\) for \(j\ge0\) give

\[
\begin{aligned}
 \sqrt{\mathscr E_c(R_N,R_N)}
 &\le C_H\sum_{n>N}\frac{\Lambda(n)}{\sqrt n}e^{-c_Hn}\\
 &\le
 \frac{C_H\sqrt{N+1}\,e^{-c_H(N+1)}}{1-e^{-c_H/2}}.          \tag{11}
\end{aligned}
\]

Combining (9) and (11) gives the auditable certificate

\[
\boxed{
 \mathcal C_P\le
 \left[
 \sqrt{\mathcal C_{P,N}}+
 \frac{C_H\sqrt{N+1}\,e^{-c_H(N+1)}}{1-e^{-c_H/2}}
 \right]^2.}                                                  \tag{12}
\]

The arithmetic part of the tail is now completely explicit.  The first
missing data are the numerical values of \(C_H,c_H,N_H\).  The published
proof establishes their existence but gives no enclosures.

## 4. Making the finite head a bounded-rectangle computation

Even (8) integrates over the whole exterior because the second summand of
\(H\) contains the ground tail.  Introduce a spatial cutoff \(L>2\) and let
\(\mathcal C_{P,N,L}\) be (8) restricted to
\(|u|,|v|\le L\), with the diagonal split into

\[
 |u-v|\le h,\qquad |u-v|>h.                                 \tag{13}
\]

On the first region the exact differences cancel
\(r(t)\sim1/(2t)\); interval bounds for the piecewise derivatives of the
finite coherent sum \(P_N\) give a majorant proportional to
\(t^2r(t)\).  On the second region ordinary interval quadrature applies.
Prime-power coincidence points and the endpoints \(\pm2\) are splitting
points, not deleted atoms.

The omitted spatial tail can be bounded from the established envelopes

\[
 |\Phi(t)|\le128e^{9|t|/2}e^{-3e^{2|t|}},qquad
 |\Phi'(t)|\le2560e^{13|t|/2}e^{-3e^{2|t|}},                 \tag{14}
\]

and \(\psi\le P_*\), where the corrected barrier gives an explicit
\(P_*\).  Consequently one obtains an elementary expression

\[
 |\mathcal C_{P,N}-\mathcal C_{P,N,L}|\le D_{N,L},            \tag{15}
\]

where \(D_{N,L}\) is a finite sum of incomplete gamma tails with
coefficients depending only on

\[
 N,\quad |1-k|,\quad |\eta_p|,\quad P_*,\quad
 \max_{n\le N}\log n.                                       \tag{16}
\]

No prime asymptotic is used in (15), because the head is finite.  A replay
certificate must print the rational interval for each finite theta integral
and the explicit incomplete-gamma upper bounds used in \(D_{N,L}\).

Thus the complete finite certificate has the form

\[
\boxed{
 \mathcal C_P\le
 \left[
 \sqrt{\mathcal C_{P,N,L}+D_{N,L}}+
 \frac{C_H\sqrt{N+1}\,e^{-c_H(N+1)}}{1-e^{-c_H/2}}
 \right]^2.}                                                  \tag{17}
\]

## 5. Why no structural finite identity is available

The compact part of (2) alone would make each \(X_n\) compactly supported,
but the second part contains
\(\Phi\psi1_{(-\infty,-2)}\).  The killed ground \(\psi\) is an
eigenfunction of the full continuous-plus-prime generator; it is not a
finite theta combination.  Substituting its weak equation into (5) moves
the unknown ground factor to arrival and killing terms and reproduces the
same infinite prime profile.  It does not terminate the prime-power sum.

Therefore no proved identity reduces (1) to finitely many theta-only sums.
A finite result must use a tail estimate such as (10), or a certified
finite-dimensional enclosure of the killed ground resolvent.

## 6. Exact remaining computation

To turn (17) into a passing optimizer certificate one needs:

1. certified intervals for the actual coefficients \(k,\eta_p\);
2. one explicit triple \((C_H,c_H,N_H)\) proving (10) for the combined
   source (2);
3. choices \(N,L,h\), the finite prime-power list through \(N\), and
   interval enclosures of the Gram entries in (8) on the split rectangle;
4. the printed spatial-tail value \(D_{N,L}\);
5. the analogous complete-prime row scalar \(\mathcal P_z\), followed by
   substitution in the exact allowance budget from the preceding note.

At present item 2 is the first precise missing tail datum.  Item 3 is the
first finite computation.  Neither has a published numerical certificate,
so no passing bound for \(\mathcal C_P\) or the Suzuki allowance is claimed.
This is a limitation of the current quantitative inputs, not a negative
statement about the actual residual and not an RH assertion.
