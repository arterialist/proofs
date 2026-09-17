# Exact Gram contraction test for the complete signed core coefficient

This note addresses equation (18) of
`theta-complete-signed-core-finite-block-certificate.md`.  It does not prove
that its coefficient is nonnegative.  Instead it gives an exact finite
criterion for the unresolved low-block sign, retaining the mean correction,
the odd affine correction, the complete weighted crossing covariance, and the
chosen finite prime observation in one identity.  It also isolates an actual
infinite-dimensional source subspace on which all positive finite rows vanish.

Throughout, inner products are linear in the first variable.  Write

\[
 m(x)=\langle x,1_C\rangle,\qquad
 b(x)=\langle x,a_c\rangle,\qquad
 k(x)=\langle x,k_Q\rangle .
\]

The signed comparison form is

\[
\begin{aligned}
 h[x]={}&E_C[x]-\alpha\|x\|^2
 +2\operatorname {Re}\bigl(b(x)\overline {m(x)}\bigr)
 -a^{-1}\|\mathcal Sx\|_\gamma^2\\
 &+d_Q^{-1}|k(x)|^2+\|Jx\|_{\mathcal Z}^2 .
\end{aligned}
\tag{1}
\]

Here \(\mathcal Sx=(Bx-b(x)1_O)/\rho\), and

\[
 Jx=\mathcal O\left(Bx-b(x)1_O-
       \frac{k(x)}{d_Q}q\right).
\tag{2}
\]

Thus (1) keeps the common affine coefficient inside the prime observation.
The denominators defining \(\mathcal O\) retain the full prime rate, including
all proper prime powers and both orientations, even if the output projection
of \(\mathcal O\) is finite dimensional.

## 1. One positive Gram and one negative Gram

The elementary identity

\[
 2\operatorname {Re}(b\bar m)
 =\frac12|m+b|^2-\frac12|m-b|^2
\tag{3}
\]

preserves the cancellation in the mean term.  Define the two row operators

\[
 Ux=\left(\frac{m(x)+b(x)}{\sqrt2},
           \frac{k(x)}{\sqrt{d_Q}},Jx\right),
 \qquad
 Wx=\left(\frac{m(x)-b(x)}{\sqrt2},
           \frac{\mathcal Sx}{\sqrt a}\right).
\tag{4}
\]

Then, exactly as forms,

\[
 \boxed{\quad H=(L_C-\alpha I)+U^*U-W^*W.\quad}
\tag{5}
\]

This is sharper than bounding the five perturbations separately.  In
particular, neither mean row has been discarded or assigned a favorable sign.
The complete covariance occurs in the same negative Gram operator as the
negative half of the mean correction.

For the first \(N\) killed-core eigenvectors, let

\[
 D_N=\operatorname {diag}(\lambda_1-\alpha,\ldots,
                           \lambda_N-\alpha)
\]

and let \(U_N,W_N\) be the restrictions of (4) to their span.  Equation (16)
of the source becomes

\[
 \boxed{\quad H_N=A_N-W_N^*W_N,\qquad
 A_N=D_N+U_N^*U_N.\quad}
\tag{6}
\]

Expanding (6) recovers

\[
 D_N+mb^*+bm^*-a^{-1}G_S+d_Q^{-1}kk^*+G_J,
\]

so (6) is an identity, not a relaxation.

## 2. Exact finite sign criterion

The following standard Schur-complement criterion is the shortest exact
low-block certificate:

\[
 \boxed{
 H_N\succeq0\iff
 \begin{cases}
 A_N\succeq0,\\
 \ker A_N\subseteq\ker W_N,\\
 \|W_NA_N^{\dagger/2}\|\le1.
 \end{cases}}
\tag{7}
\]

The pseudoinverse is taken on \((\ker A_N)^\perp\).  To verify (7), if
\(H_N\succeq0\), then \(A_N=H_N+W_N^*W_N\succeq0\); a vector in
\(\ker A_N\) has zero quadratic form for both summands and hence lies in
\(\ker W_N\).  On the orthogonal complement, conjugation by
\(A_N^{-1/2}\) reduces the assertion to
\(I-(W_NA_N^{-1/2})^*(W_NA_N^{-1/2})\succeq0\).
The converse follows by reversing these steps.

If \(A_N\succ0\), define the single unresolved finite scalar

\[
 \sigma_N^2=\lambda_{\max}
 \left(A_N^{-1/2}W_N^*W_NA_N^{-1/2}\right).
\tag{8}
\]

Then \(H_N\succeq0\) exactly when \(\sigma_N\le1\).  If
\(\sigma_N>1\), a unit top eigenvector \(v\) gives the explicit finite
witness \(c=A_N^{-1/2}v\) and

\[
 c^*H_Nc=1-\sigma_N^2<0.
\tag{9}
\]

If interval data show that \(A_N\) has a negative direction, that direction
already obstructs positivity because \(H_N\preceq A_N\).  Thus (7)--(9)
cover both possible finite failure mechanisms without replacing any signed
entry by its norm.

## 3. The actual invisible-source obstruction

Because the selected observation has finite-dimensional range, the subspace

\[
 \mathcal K=\ker J\cap1_C^\perp\cap a_c^\perp\cap k_Q^\perp
\tag{10}
\]

is closed, finite-codimensional, and infinite-dimensional.  Its intersection
with the core form domain is infinite-dimensional.  For every such \(x\),
the mean, odd-affine, and observed-prime terms vanish exactly, while the full
weighted crossing source remains:

\[
 \boxed{\quad
 h[x]=E_C[x]-\alpha\|x\|^2-a^{-1}\|\mathcal Sx\|_\gamma^2,
 \qquad x\in D(E_C)\cap\mathcal K.
 \quad}
\tag{11}
\]

The established arithmetic injectivity
\(Tx-cq=0\Rightarrow x=c=0\) implies that \(\mathcal Sx\ne0\) for every
nonzero \(x\in\mathcal K\).  Consequently:

* if one finds nonzero \(x\in\mathcal K\) with
  \(E_C[x]\le\alpha\|x\|^2\), then (11) is a strict counterexample;
* if the numerator is positive on \(\mathcal K\), positivity still requires

\[
 \boxed{\quad
 \sup_{0\ne x\in D(E_C)\cap\mathcal K}
 \frac{\|\mathcal Sx\|_\gamma^2/a}
      {E_C[x]-\alpha\|x\|^2}\le1.
 \quad}
\tag{12}
\]

Equation (12) is an actual theta crossing comparison, not a generic
finite-rank objection.  The boundedness estimate for \(\mathcal S\) supplies
only an upper bound for its numerator and does not prove (12).  A finite
observation's nonvanishing on a compact energy shell also does not prove it:
nonvanishing gives no lower constant large enough to dominate the complete
negative Gram row.

There is a sharper source-specific explanation.  Let \(\mathcal C\) be the
actual centered exterior Green covariance and let

\[
 D_{\rm all}(r,s)=Q(r,s)-\mathcal C(r,s)
\]

be the complete history gain, polarized from the nonnegative diagonal form.
For general \(x\), put

\[
 c_Q=\frac{k(x)}{d_Q},\qquad r_Q=Tx-c_Qq,
\]

and let \(c_C\) be the exact Green-covariance affine optimizer.  The exact
complete-ground identity and the definition of \(J\) give

\[
 \boxed{
 h[x]=F_\alpha[x]-
 \left(D_{\rm all}(r_Q,r_Q)-\|\mathcal O r_Q\|^2
 +\mathcal C(q,q)|c_Q-c_C|^2\right).}
\tag{13}
\]

Both terms in parentheses are nonnegative: the observation is a lower readout
of the complete gain, and the second term is the optimizer-mismatch square.
Thus the signed lower operator fails precisely by the gain left invisible to
the finite observation together with the use of the old \(Q\)-optimizer.

On \(\mathcal K\), one has \(c_Q=0\), \(\mathcal OTx=0\), and
\(m_\tau=-Q(Tx,q)\).  Hence

\[
 c_C=\frac{\mathcal C(Tx,q)+m_\tau}{\mathcal C(q,q)}
 =-\frac{D_{\rm all}(Tx,q)}{\mathcal C(q,q)},
\]

so (13) specializes to the fully source-normalized identity

\[
 \boxed{
 h[x]=F_\alpha[x]-D_{\rm all}(Tx,Tx)
 -\frac{|D_{\rm all}(Tx,q)|^2}{\mathcal C(q,q)},
 \qquad x\in\mathcal K.}
\tag{14}
\]

This identifies the exact strengthening that would prove (12).  A known lower
bound for the true constrained form \(F_\alpha\) must pay the complete
unobserved history gain and its mixed odd-affine mismatch in (14).  The
published small-core full-space gap does lower-bound \(F_\alpha\), but no
proved estimate compares that margin with the two terms subtracted in (14),
and its small-radius condition is not a radius-two certificate.  Therefore it
does not currently settle the ratio on \(\mathcal K\).

For a finite trial space, (10)--(12) have a completely algebraic replay.
Let \(Z_N\) have columns spanning the joint nullspace of the rows
\(m,b,k,J_N\).  A negative eigenvalue of

\[
 Z_N^*\left(D_N-a^{-1}G_{S,N}\right)Z_N
\tag{15}
\]

is an exact finite counterexample for the chosen observation.  A positive
matrix in (15) is only a certificate on that nullspace; the remaining
directions must still be checked by (7).

## 4. The complementary-spectrum loss in equation (18)

Even after the low block is certified, equation (18) includes the Young
loss.  Put

\[
 h=\underline{\lambda_{\min}(H_N)},\qquad
 g=\underline{\lambda_{N+1}}-C_V,\qquad C=C_V.
\]

Optimizing its displayed parameter \(\epsilon>0\) gives

\[
 \epsilon_{\rm opt}
 =\frac{h-g+\sqrt{(h-g)^2+4C^2}}2,
\qquad
 c_{\rm opt}
 =\frac{h+g-\sqrt{(h-g)^2+4C^2}}2.
\tag{16}
\]

Hence some \(\epsilon\) makes the source's coefficient nonnegative exactly
when

\[
 \boxed{\quad h\ge0,\qquad g\ge0,\qquad hg\ge C_V^2.\quad}
\tag{17}
\]

For strict positivity all three boundary equalities must be avoided.  This
separates the true signed low-block question, which is (7), from the coarse
complementary-spectrum budget.

## 5. Auditable status

Equation (18) does not currently define one numerical \(c_*\): the source
does not specify \(\mathcal O\), \(N\), \(\epsilon\), or validated entries
of \(H_N\).  No existing theorem supplies (12), and no validated finite data
currently evaluate (8) or (15).  Therefore neither \(c_*\ge0\) nor an actual
negative theta witness is proved here.

The first precise unevaluated signed quantity is \(\sigma_N\) in (8) after a
concrete observation and a validated core/ground Galerkin block are fixed.
It combines all requested cancellations.  If the computation is aimed first
at an obstruction, (15) is smaller: it requires only the common-nullspace
restriction and returns an explicit coefficient vector if it fails.

The finite algebra is formalized in
[`SignedCoreGramContraction.lean`](../../formalization/BuildingBlocks/SignedCoreGramContraction.lean).  Lean 4.24 checks the complex mean
split, the Gram-difference and kernel implications, the contraction and
abstract pseudoinverse-on-range criteria, and the optimized Young formula and
product criterion.  The square-root factor, Moore--Penrose properties, and all
theta operator estimates remain explicit hypotheses.  The module contains no
`sorry` or project axiom; its axiom report lists only `propext`,
`Classical.choice`, and `Quot.sound`.
