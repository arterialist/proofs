# Abstract Hermitian optimizer mismatch and the joint-nullspace sign

This note proves the quadratic identity used in equations (13)--(14) of
[the signed-core Gram contraction](../theta-and-heat/theta-exact-signed-core-gram-contraction.md).  It is abstract finite
algebra.  Applying it to the theta source still requires the established
operator-domain and covariance theorems; it supplies no new domination
estimate and no claim about RH.

## 1. Hypotheses and convention

Let \(V\) be a complex vector space.  Inner products and sesquilinear forms
are linear in the first variable.  Let \(Q,C:V\times V\to\mathbb C\) be
Hermitian forms:

\[
 B(u,v)=\overline{B(v,u)},\qquad B\in\{Q,C\}.
\tag{1}
\]

Assume:

1. \(Q\) and \(C\) are nonnegative on the source domain;
2. \(D:=Q-C\) is nonnegative there;
3. the common affine direction \(q\) satisfies
   \(d_Q:=Q(q,q)>0\) and \(d_C:=C(q,q)>0\);
4. the observation \(\mathcal O\) is defined on the residuals below and
   obeys
   \[
   \|\mathcal Or\|^2\le D(r,r);
   \tag{2}
   \]
5. all displayed mixed pairings are finite.

Hermitian symmetry makes every diagonal value real and gives
\(B(q,f)=\overline{B(f,q)}\).  Positivity of \(Q\) and \(C\) is stronger than
what the algebraic identity needs; the identity itself only requires nonzero
denominators.  Positivity is needed for minimization and for the final sign.

Fix \(f\in V\), an affine scalar \(m\in\mathbb C\), and a real baseline
\(L\).  Put

\[
 z_B=B(f,q),\qquad
 c_B=\frac{z_B+m}{d_B}.
\tag{3}
\]

The affine quadratic and the corresponding optimized comparison value are

\[
 \mathcal A_B(c)=B(f-cq,f-cq)-2\Re(c\bar m),
\qquad
 F_B=L-\min_c\mathcal A_B(c).
\tag{4}
\]

## 2. Completion of the square

Using (1),

\[
\begin{aligned}
 \mathcal A_B(c)
 &=B(f,f)+d_B|c|^2-2\Re(\bar c(z_B+m))\\
 &=B(f,f)-\frac{|z_B+m|^2}{d_B}
   +d_B|c-c_B|^2.
\end{aligned}
\tag{5}
\]

Since \(d_B>0\), the optimizer is uniquely \(c_B\), and

\[
 F_B=L-B(f,f)+\frac{|z_B+m|^2}{d_B}.
\tag{6}
\]

This checks the conjugation convention: the optimizer is
\((B(f,q)+m)/B(q,q)\).  Replacing it by its complex conjugate would be wrong
under the first-variable-linear convention.

## 3. The exact mismatch identity

Set

\[
 r_Q=f-c_Qq.
\]

Evaluate the \(C\)-quadratic first at \(c_Q\), then complete its square at
\(c_C\).  Since \(D=Q-C\), subtraction of the two evaluations gives

\[
 \boxed{
 F_C-F_Q=D(r_Q,r_Q)+d_C|c_Q-c_C|^2.}
\tag{7}
\]

This may also be checked by expanding the right side:

\[
 D(r_Q,r_Q)=D(f,f)-2\Re(\bar c_QD(f,q))
             +(d_Q-d_C)|c_Q|^2.
\tag{8}
\]

Define the observed lower comparison

\[
 H=F_Q+\|\mathcal O r_Q\|^2.
\]

Equation (7) yields the exact identity

\[
 \boxed{
 H=F_C-\left(
 D(r_Q,r_Q)-\|\mathcal O r_Q\|^2
 +d_C|c_Q-c_C|^2\right).}
\tag{9}
\]

Every sign in (9) is determined by algebra.  Hypotheses (2)--(3) show that
the entire parenthesis is nonnegative.  Thus a finite observation recovers
only its measured part of the complete gain; the optimizer mismatch is an
additional nonnegative loss.

## 4. Joint-nullspace specialization

Assume now

\[
 z_Q+m=0,\qquad \mathcal Of=0.
\tag{10}
\]

Then \(c_Q=0\) and \(r_Q=f\).  Moreover

\[
 c_C=\frac{z_C+m}{d_C}
 =\frac{z_C-z_Q}{d_C}
 =-\frac{D(f,q)}{d_C}.
\tag{11}
\]

Substitution in (9) gives

\[
 \boxed{
 H=F_C-D(f,f)-\frac{|D(f,q)|^2}{d_C}.}
\tag{12}
\]

The minus sign in front of the final mixed term is **correct**.  The optimizer
itself has the negative sign in (11), but its mismatch contribution is
\(d_C|c_C|^2=|D(f,q)|^2/d_C\ge0\), and (9) subtracts that contribution from
\(F_C\).  A plus sign in (12) would contradict the completion of the square.

For the theta application, take \(Q\) to be the rank-one comparison
covariance, \(C=\mathcal C\) the true centered Green covariance,
\(D=D_{\rm all}\), and \(f=Tx\).  The joint null condition is
\(\langle x,k_Q\rangle=Q(Tx,q)+m_\tau=0\), while \(Jx=0\) gives
\(\mathcal OTx=0\).  Equation (12) is therefore exactly

\[
 h[x]=F_\alpha[x]-D_{\rm all}(Tx,Tx)
 -\frac{|D_{\rm all}(Tx,q)|^2}{\mathcal C(q,q)}.
\tag{13}
\]

No estimate currently proves that the positive part of \(F_\alpha\) dominates
the two subtracted terms on the actual radius-two common kernel.

## 5. Lean verification

[`OptimizerMismatch.lean`](../../formalization/BuildingBlocks/OptimizerMismatch.lean) formalizes:

* the complex completion (5), its minimum and uniqueness;
* the exact identity (7) in Hermitian scalar data;
* the observed identity (9) and its nonnegative bracket under (2);
* \(c_Q=0\), the negative optimizer formula (11), and the joint-nullspace
  identity (12).

The Lean scalar data are precisely the consequences of Hermitian symmetry:
real diagonal values and complex mixed values.  Operator symmetry, source
membership, and observation domination remain explicit analytic inputs.  The
module compiles with Lean 4.24, contains no `sorry` or new axiom, and uses only
the standard Mathlib logical axioms recorded in its adjacent axiom report.

