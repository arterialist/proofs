# The radius-two barrier does not supply the missing even constrained margin

This note tests whether the effective radius-two killed-ground barrier,
together with reflection parity, can prove positivity of the signed comparison
on the even joint-nullspace.  It cannot with the published inputs.  The reason
is spectral: the barrier controls the exterior killed ground and its pointwise
profile, while the required quantity is a lower Rayleigh bound for a family of
full-space constrained extensions, coupled to an upper bound for their
complete history gain.

No impossibility is claimed for a new source-specific argument.  No numerical
Galerkin value, sharp theta gap, or RH-strength premise is inserted.

## 1. Exact even-sector domain at radius two

Fix \(C=[-2,2]\), \(O=\mathbb R\setminus C\), and the complete hard split

\[
 L=\begin{pmatrix}L_C&-B^*\\-B&D\end{pmatrix}.
\]

Let \(D\psi_2=\alpha_2\psi_2\), with the normalized positive even killed
ground state.  All forms below use the complete continuous conductance and
both orientations of every prime power.

Let \(D(E_C)_{\rm ev}\) be the even core form domain and define

\[
 \mathcal K_{\rm ev}=
 \{x\in D(E_C)_{\rm ev}:
   \langle x,1_C\rangle=0,
   \langle x,a_c\rangle=0,
   Jx=0\}.
\tag{1}
\]

For even \(x\), the centered source \(Tx\) is even, while \(q=\tau_O\) and
\(\tau_C\) are odd.  Reflection invariance of \(Q\), \(\mathcal C\), and
\(D_{\rm all}\) gives

\[
 Q(Tx,q)=\mathcal C(Tx,q)=D_{\rm all}(Tx,q)=0,
 \qquad\langle x,\tau_C\rangle=0.
\tag{2}
\]

Thus \(\langle x,k_Q\rangle=0\) automatically, so (1) is precisely the even
part of the earlier joint nullspace.  The verified optimizer identity reduces
to

\[
 \boxed{H[x]=F_{\alpha_2}[x]-D_{\rm all}(Tx,Tx),
 \qquad x\in\mathcal K_{\rm ev}.}
\tag{3}
\]

No mixed odd-affine term remains.

Let \(y_\alpha(x)\) be the exact exterior minimizer in the ground-pole
formula and set

\[
 \mathcal E_\alpha x=x\oplus y_\alpha(x).
\]

The domain theorem places \(y_\alpha(x)\) in \(D(E_O)\), hence
\(\mathcal E_\alpha x\in D(E)\).  It is even and has full mean zero; its odd
score moment vanishes by parity.  The exact square completion gives

\[
 \boxed{F_{\alpha_2}[x]
 =E[\mathcal E_\alpha x]
  -\alpha_2\|\mathcal E_\alpha x\|^2.}
\tag{4}
\]

Equations (3)--(4) track the operator and form domains: no action of the
unbounded full operator on a generic form vector is required.

## 2. What the effective barrier actually proves

The compact triangular trial and effective barrier prove

\[
 10^{-2918}<d_2:=\frac12-\alpha_2<10^{-20},
\tag{5}
\]

and a finite, extremely large upper bound for \(\|\psi_2\|_\infty\).  The
barrier is a supersolution estimate for the killed exterior operator
\(D-\alpha_2\).  It yields neither

\[
 E[h]\ge\Gamma\|h\|^2
 \quad(h\text{ even},\ \nu h=0)
\tag{6}
\]

nor a restricted version of (6) on the extension range
\(\mathcal E_\alpha(\mathcal K_{\rm ev})\).

Parity changes the relevant subspace and removes the mixed term in (3).  It
does not turn an exterior supersolution into a full-space spectral lower
bound.  The pointwise constant \(\|\psi_2\|_\infty\) only enlarges available
upper bounds for weighted crossing sources and cannot provide the missing
lower Rayleigh estimate in (6).

## 3. Every global even margin is forced into the sharp window

The established unconditional even equality tower

\[
 f_j=\frac{\Phi^{(2j)}}{\Phi}-4^{-j},\qquad j\ge1,
\]

lies in the full even mean-zero form domain and satisfies

\[
 E[f_j]=\frac12\|f_j\|^2,qquad f_j\ne0.
\tag{7}
\]

Consequently every constant \(\Gamma\) satisfying the global even gap (6)
must obey

\[
 \Gamma\le\frac12.
\tag{8}
\]

Combining (5) and (8),

\[
 \boxed{\Gamma-\alpha_2<10^{-20}.}
\tag{9}

Thus even a usable global margin must prove a lower gap within \(10^{-20}\)
of the sharp endpoint.  The barrier's lower killed gap in (5) says that the
*possible* sharp margin \(1/2-\alpha_2\) is positive; it does not prove the
global lower bound \(\Gamma=1/2\).  That sharp lower bound is precisely the
unresolved theta positivity strength and cannot be inferred from the equality
modes, which provide only the opposite inequality (8).

The positive full-space gap constructed in
`theta-ground-pole-conditional-comparison.md` is deliberately nonsharp and
was used only on sufficiently small cores for which its fixed lower bound
exceeds the killed ground value.  No evaluated version of that construction
gives \(\Gamma>\alpha_2\) at radius two.  Reusing the exterior barrier
constant as \(\Gamma\) would reverse its role and compare spectra of different
operators.

## 4. Exact restricted theorem still needed

A global gap is stronger than necessary.  Define the restricted extension
Rayleigh floor and gain ceiling formally by

\[
 \Gamma_{\rm ev,K}:=
 \inf_{0\ne x\in\mathcal K_{\rm ev}}
 \frac{E[\mathcal E_\alpha x]}
      {\|\mathcal E_\alpha x\|^2},
\tag{10}
\]

\[
 \eta_{\rm ev,K}:=
 \sup_{0\ne x\in\mathcal K_{\rm ev}}
 \frac{D_{\rm all}(Tx,Tx)}
      {\|\mathcal E_\alpha x\|^2}.
\tag{11}

The quotients are understood only for nonzero extensions.  The core component
of \(\mathcal E_\alpha x\) is \(x\), so a nonzero \(x\) gives a nonzero
extension.

The precise sufficient theorem is:

> **Even radius-two range comparison.**  Prove finite constants
> \(\Gamma_{\rm ev,K}\) and \(\eta_{\rm ev,K}\) with
> \[
> \alpha_2<\Gamma_{\rm ev,K},\qquad
> \eta_{\rm ev,K}\le\Gamma_{\rm ev,K}-\alpha_2.
> \tag{12}
> \]
> Then \(H[x]\ge0\) for every \(x\in\mathcal K_{\rm ev}\).

Indeed (10)--(12) and (4) give

\[
 F_{\alpha_2}[x]\ge
 (\Gamma_{\rm ev,K}-\alpha_2)\|\mathcal E_\alpha x\|^2
 \ge D_{\rm all}(Tx,Tx),
\]

which closes (3).

An equivalent one-line theorem, avoiding separate extrema, is

\[
 \boxed{
 D_{\rm all}(Tx,Tx)\le
 E[\mathcal E_\alpha x]
 -\alpha_2\|\mathcal E_\alpha x\|^2
 \quad(x\in\mathcal K_{\rm ev}).}
\tag{13}

Equation (13) is the first missing spectral comparison.  It retains the
actual complete gain and the exact constrained extension.  It is not proved
by the weighted crossing norm, the pointwise ground barrier, observation
nullness, or parity.

## 5. Why the current constants cannot pay the gain

The functional-calculus estimate from the preceding note gives only

\[
 D_{\rm all}(Tx,Tx)\le a^{-1}\|S_{Tx}\|_\gamma^2.
\tag{14}

The effective barrier can turn the right side into a finite constant times
\(\|x\|^2\), but its coefficient uses the enormous pointwise ground bound.
It does not place that coefficient below the forced margin ceiling
\(10^{-20}\) in (9).  More basically, no positive lower value of
\(\Gamma_{\rm ev,K}-\alpha_2\) has been established at all.

The observation condition \(Jx=0\) cannot repair (14): \(J\) is a finite
lower readout of \(D_{\rm all}\), so its vanishing gives no reverse estimate
for the unobserved gain.

Accordingly, the published radius-two barrier plus parity yields no actual
constrained margin \(\Gamma>\alpha_2\) that pays \(D_{\rm all}\).  This is a
failure of the available implication, not a counterexample to (13).

## 6. Formalized finite algebra

[`EvenSectorMargin.lean`](BuildingBlocks/EvenSectorMargin.lean) formalizes:

* a Rayleigh margin paying a gain coefficient;
* the upper cap on a proposed gap supplied by a nonzero equality mode;
* the bound \(\Gamma-\alpha\le\delta\) obtained from
  \(\Gamma\le\lambda\) and \(\lambda-\delta\le\alpha\);
* the exact restricted-range implication (12);
* the logical fact that a positive killed gap and the cap
  \(\Gamma\le\lambda\) alone do not force \(\Gamma>\alpha\).

The extension identity, equality tower, barrier bounds, and gain estimate are
operator-analytic inputs and are not claimed by the finite Lean module.

