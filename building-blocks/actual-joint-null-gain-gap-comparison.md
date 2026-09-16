# Actual radius-two joint-null gain versus the constrained gap

This note continues the verified optimizer identity on the actual radius-two
theta split.  It derives a source-specific sufficient comparison and records
why the current data do not evaluate it.  No numerical Galerkin sign is
claimed: the existing Galerkin note specifies a validation format but supplies
no validated eigenpair, spectral separation, signed Gram enclosure, or
concrete finite observation matrix.

## 1. Actual radius-two objects

Fix

\[
 C=[-2,2],\qquad O=\mathbb R\setminus C.
\]

Let \(D=L_O\) be the actual killed exterior theta operator, including the
complete continuous kernel, both prime orientations, and every proper prime
power.  Let

\[
 D\psi=\alpha\psi,\qquad \|\psi\|_{L^2(O,\nu)}=1,
\]

be its positive even ground state.  Retain

\[
 \rho(u)=\frac{e^{-|u|/2}}{2\cosh(u/2)},\qquad
 d\gamma=\rho\psi\,d\nu,\qquad a=\gamma(O)>0,
\]

and the complete residual generator \(A=A_{\rm rem}\ge0\) on
\(L^2(O,\gamma)\).  For an exterior centered source \(r\), write

\[
 S_r=r/\rho.
\]

The exact covariance identities are

\[
 \mathcal C(r,s)=\langle(a+A)^{-1}S_r,S_s\rangle_\gamma,
\tag{1}
\]

\[
 Q(r,s)=a^{-1}\langle S_r,S_s\rangle_\gamma,
\qquad D_{\rm all}=Q-\mathcal C,
\tag{2}
\]

and hence, by functional calculus,

\[
 \boxed{
 D_{\rm all}(r,s)=a^{-1}
 \langle A(a+A)^{-1}S_r,S_s\rangle_\gamma.}
\tag{3}
\]

Thus \(D_{\rm all}\) is a nonnegative Hermitian form.  Equation (3) retains
the continuous residual conductance and the complete prime conductance; it is
not a first-jump truncation.

Let \(q=\tau_O\), and for a core input \(x\) use the actual centered crossing
source

\[
 f=Tx=Bx-\langle x,a_c\rangle1_O.
\]

On the joint nullspace

\[
 \mathcal K=\ker J\cap1_C^\perp\cap a_c^\perp\cap k_Q^\perp,
\tag{4}
\]

the verified optimizer identity is

\[
 \boxed{
 H[x]=F_\alpha[x]-D_{\rm all}(f,f)
 -\frac{|D_{\rm all}(f,q)|^2}{\mathcal C(q,q)}.}
\tag{5}
\]

The denominator is positive because \(q\ne0\), \(q\perp\psi\), and the
centered Green operator is positive and injective.

## 2. A rigorous complete-gain comparison

Cauchy--Schwarz in the nonnegative form \(D_{\rm all}\) gives

\[
 |D_{\rm all}(f,q)|^2
 \le D_{\rm all}(f,f)D_{\rm all}(q,q).
\tag{6}
\]

Since \(D_{\rm all}(q,q)=Q(q,q)-\mathcal C(q,q)\), define the finite scalar

\[
 \kappa_q=\frac{Q(q,q)}{\mathcal C(q,q)}\ge1.
\tag{7}
\]

Equations (5)--(7) give the actual source-specific lower bound

\[
 \boxed{
 H[x]\ge F_\alpha[x]-\kappa_qD_{\rm all}(f,f),
 \qquad x\in\mathcal K.}
\tag{8}
\]

The spectral multiplier in (3) satisfies

\[
 0\le\frac{\lambda}{a(a+\lambda)}\le\frac1a,
\]

so

\[
 D_{\rm all}(f,f)\le Q(f,f)=a^{-1}\|S_f\|_\gamma^2,
\tag{9}
\]

where here \(\mathcal Sf=S_f=f/\rho\).  Consequently a sufficient condition
on the actual joint nullspace is

\[
 \boxed{
 F_\alpha[x]\ge
 \frac{\kappa_q}{a}\|S_{Tx}\|_\gamma^2
 \quad(x\in\mathcal K).}
\tag{10}
\]

This is stronger than the desired conclusion and is not asserted to hold.  It
is usable in the sense that every constant and source in it is fixed by the
actual radius-two operators.

There is a sharper conditional estimate when the actual source belongs to the
form domain of \(A\).  Since

\[
 \frac{\lambda}{a(a+\lambda)}\le\frac{\lambda}{a^2},
\]

functional calculus gives

\[
 D_{\rm all}(f,f)\le a^{-2}\|A^{1/2}S_f\|_\gamma^2.
\tag{11}
\]

The accepted weighted crossing theorem proves only \(S_f\in L^2(\gamma)\)
for arbitrary core \(L^2\) input.  It does not prove
\(S_f\in D(A^{1/2})\), so (11) must not be applied on all of \(\mathcal K\)
without a new source-regularity theorem.

## 3. An actual variational upper bound for \(\kappa_q\)

The factor \(\kappa_q\) contains a denominator that should not be replaced by
mere positivity.  The odd score itself gives a rigorous lower trial bound.
Put

\[
 e_q=\langle q,(D-\alpha)q\rangle_\nu>0.
\]

The score belongs to the actual killed operator domain, and it is orthogonal
to the even ground state.  Cauchy--Schwarz for
\((D-\alpha)^{\pm1/2}\), equivalently the one-dimensional Ritz trial in the
Green variational formula, yields

\[
 \boxed{
 \mathcal C(q,q)\ge\frac{\|q\|_\nu^4}{e_q}.}
\tag{12}
\]

Therefore

\[
 \boxed{
 \kappa_q\le
 K_q:=\frac{Q(q,q)e_q}{\|q\|_\nu^4}.}
\tag{13}

\]

Every term in \(K_q\) is an actual radius-two scalar.  The value
\(Q(q,q)=a^{-1}\|q/\rho\|_\gamma^2\) still depends on the normalized killed
ground profile.  Existing radius-two work supplies neither a rigorous upper
enclosure for this ratio nor validated ground quadrature tight enough to use
(13) numerically.  Equation (13) is nevertheless preferable to an unspecified
positive lower bound for \(\mathcal C(q,q)\).

Combining (8) and (13) gives

\[
 H[x]\ge F_\alpha[x]-K_qD_{\rm all}(Tx,Tx).
\tag{14}
\]

## 4. Parity removes the mixed loss on one actual sector

All operators in (1)--(3) commute with reflection.  The score \(q\) is odd.
If \(x\in\mathcal K\) is even, then \(Tx\) and \(S_{Tx}\) are even, so

\[
 D_{\rm all}(Tx,q)=0.
\tag{15}
\]

The exact identity improves to

\[
 \boxed{H[x]=F_\alpha[x]-D_{\rm all}(Tx,Tx)
 \qquad(x\in\mathcal K\text{ even}).}
\tag{16}
\]

Thus the factor \(\kappa_q\) is needed only for the odd or mixed-parity
sector.  Equation (16) still requires a comparison of the complete gain with
the true constrained margin; parity alone does not provide it.

## 5. Comparison with the known constrained full-space gap

Let \(y_C(x)\) be the exact exterior minimizer defining \(F_\alpha[x]\).
If one has a proved full-space two-moment gap

\[
 E(h)\ge\Gamma\|h\|^2
 \quad(h\perp1,\tau)
\]

with \(\Gamma>\alpha\), the exact extension identity gives

\[
 F_\alpha[x]\ge(\Gamma-\alpha)
 \bigl(\|x\|^2+\|y_C(x)\|^2\bigr).
\tag{17}
\]

Together with (14), a sufficient joint-nullspace estimate would be

\[
 K_qD_{\rm all}(Tx,Tx)\le(\Gamma-\alpha)
 \bigl(\|x\|^2+\|y_C(x)\|^2\bigr).
\tag{18}
\]

The published unconditional gap construction proves (17) only on its
small-core range where its explicit \(\Gamma\) exceeds that core's killed
ground value.  No proved radius-two bound has \(\Gamma>\alpha_2\).  Inserting
a lower bound \(\Gamma\le\alpha_2\) into (17) gives no positive margin and
cannot be used in (18).  Replacing \(\Gamma\) by the sharp value \(1/2\)
would assume the unresolved theta positivity strength and is not done here.

## 6. Why observation-nullness does not give an upper bound

The finite observation is an orthogonal projection of a restricted one-jump
edge readout.  Its proved relation is

\[
 \|\mathcal Or\|^2\le D_{\rm all}(r,r).
\]

Thus \(\mathcal Or=0\) deletes a known lower contribution to the gain.  It
does not upper-bound the unobserved continuous histories, longer prime
histories, unselected prime powers, or the orthogonal complement of the
finite output projection.  No reverse frame bound has been proved.  The
nullspace condition therefore cannot improve (9) with the present inputs.

## 7. Status of a finite counterexample search

A rigorous finite test would require interval enclosures for the core
eigenvectors, \(\psi\), \(\alpha\), all weighted crossing Gram entries, the
full-rate observation denominators, and a lower spectral separation for the
Galerkin complement.  The existing
`validated-killed-ground-galerkin-certificate.md` proves error propagation
conditional on those data but explicitly supplies no validated eigenpair or
numerical intervals.  The finite observation in the signed-core source is
also not fixed by cutoff and output coordinates.  Consequently there is no
rigorous matrix from which to compute an actual nullspace or a negative
Rayleigh witness.

The strongest proved radius-two conclusion is therefore (8), with the
variational refinement (13) and the even-sector identity (16).  The first
missing source-level estimate is (18), or directly

\[
 D_{\rm all}(Tx,Tx)+
 \frac{|D_{\rm all}(Tx,q)|^2}{\mathcal C(q,q)}le F_\alpha[x]
 \quad(x\in\mathcal K).
\]

No current theorem proves this inequality or its failure.
