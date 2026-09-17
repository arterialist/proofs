# Audit of the complete signed finite-block constant

This note audits equation (18) of
`theta-complete-signed-core-finite-block-certificate.md`.  The finite-block
inequality itself is correct.  The current inputs do not, however, give a
nonnegative value of its constant.  The obstruction is an exact
infinite-dimensional core subspace on which the mean, odd affine, and finite
prime-observation corrections all vanish while the signed covariance term
remains.

## 1. The exact signed decomposition

Retain the notation of the source note.  In particular

\[
 H=L_C-\alpha I+(a_c\otimes1_C+1_C\otimes a_c)
 -\frac1a\mathcal S^*\mathcal S
 +\frac1{d_Q}k_Q\otimes k_Q+J^*J.
\tag{1}
\]

For every \(x\in D(E_C)\), this is exactly

\[
\begin{aligned}
 \langle Hx,x\rangle={}&E_C[x]-\alpha\|x\|^2
 +2\operatorname {Re}\bigl(
 \langle x,a_c\rangle\overline{\langle x,1_C\rangle}\bigr)\\
&-\frac1a\|\mathcal Sx\|_\gamma^2
+\frac1{d_Q}|\langle x,k_Q\rangle|^2+\|Jx\|_{\mathcal Z}^2.
\end{aligned}
\tag{2}
\]

Thus the mean term has no fixed sign, the weighted covariance has a negative
sign, and the odd-affine and observed-prime terms are positive.  No term in
(2) may be dropped when certifying a low matrix.

For the first \(N\) core eigenfunctions, put

\[
 D_N=\operatorname {diag}(\lambda_1-\alpha,\ldots,
 \lambda_N-\alpha),
\]

let \(m,a_0,k\in\mathbb C^N\) have entries \(m_j,a_j,k_j\), and define
the Gram matrices

\[
 (G_S)_{ij}=\langle s_j,s_i\rangle_\gamma,qquad
 (G_J)_{ij}=\langle j_j,j_i\rangle_{\mathcal Z}.
\]

Then the matrix in equation (16) of the source is precisely

\[
 \boxed{
 H_N=D_N+m a_0^*+a_0m^*-\frac1aG_S
       +\frac1{d_Q}kk^*+G_J.}
\tag{3}
\]

This form displays the unresolved term: \(G_S\) is a complete weighted
crossing Gram matrix, whereas \(G_J\) contains only the chosen finite
prime observations.  The inequality \(G_J\ge a^{-1}G_S\), even after the
other three columns are included, is not among the proved inputs.

## 2. An exact common-kernel obstruction

Because \(J\) has finite-dimensional range, define the closed finite
codimensional subspace

\[
 \mathcal K_J=ker J\cap1_C^\perp\cap a_c^\perp\cap k_Q^\perp.
\tag{4}
\]

The core Hilbert space is infinite-dimensional, so \(\mathcal K_J\) is
infinite-dimensional.  Its intersection with the core form domain is also
infinite-dimensional: the form domain is dense and invariant under imposing
finitely many bounded linear constraints.

For every \(x\in D(E_C)\cap\mathcal K_J\), all three corrections requested
in the certificate vanish exactly:

* the mean term vanishes because both mean columns vanish;
* the odd affine term vanishes because \(\langle x,k_Q\rangle=0\);
* the retained prime-observation term vanishes because \(Jx=0\).

Equation (2) consequently reduces to the actual signed residual

\[
 \boxed{
 \langle Hx,x\rangle
 =E_C[x]-\alpha\|x\|^2-\frac1a\|\mathcal Sx\|_\gamma^2,
 \qquad x\in D(E_C)\cap\mathcal K_J.}
\tag{5}
\]

Therefore a necessary condition for any nonnegative certificate in (18) is

\[
 \boxed{
 E_C[x]-\alpha\|x\|^2
 \geq\frac1a\|\mathcal Sx\|_\gamma^2
 \quad(x\in D(E_C)\cap\mathcal K_J).}
\tag{6}
\]

No result cited by the finite-block note proves (6).  This is not a generic
matrix objection: \(\mathcal S=T/\rho\) is the actual centered theta
crossing source and \(J\) is the actual chosen finite-prime observation.
The missing quantity is the complete weighted covariance of actual sources
that are invisible to those finitely many prime-edge measurements and to
the three scalar columns.

The available boundedness statement only gives

\[
 \frac1a\|\mathcal Sx\|_\gamma^2
 \leq\frac{M_S^2}{a}\|x\|^2.
\tag{7}
\]

Combining (7) with the bottom core eigenvalue yields at best

\[
 \langle Hx,x\rangle
 \geq(\lambda_1-\alpha-M_S^2/a)\|x\|^2
 \quad(x\in\mathcal K_J),
\tag{8}
\]

and none of the established constants gives
\(\lambda_1-\alpha\ge M_S^2/a\).  Enlarging upper bounds for the barrier or
crossing norm only worsens (8).

## 3. Why finite detection does not supply the missing comparison

The finite-observation theorem proves a different statement.  Given an
energy ceiling \(K\), it constructs some observation \(\mathcal O_{M,J}\)
for which

\[
 \inf_{\|x\|=1,\ E_C[x]\le K,\ c\in\mathbb C}
 \|\mathcal O_{M,J}(Tx-cq)\|>0.
\tag{9}
\]

The observation in the signed-core note is introduced only as “choose one
bounded finite prime observation”; no ceiling \(K\), finite parameters
\((M,J)\), or positive lower value in (9) is fixed.  More importantly,
(9) is a nonvanishing statement.  To dominate the negative covariance in
(2), one would need a quantitative comparison on the relevant low-energy
set, for example

\[
 \|Jx\|^2+\frac{|\langle x,k_Q\rangle|^2}{d_Q}
 +2\operatorname {Re}(\langle x,a_c\rangle
 \overline{\langle x,1_C\rangle})
 \geq \frac1a\|\mathcal Sx\|_\gamma^2
       -E_C[x]+\alpha\|x\|^2.
\tag{10}
\]

Neither (9) nor the domination \(\|\mathcal Of\|^2\le\mathscr D(f)\)
implies (10).  The full prime gain dominates the finite observation, but
the complete covariance in (10) is a separate negative quantity.

## 4. Status of equation (18)

Write \(V=H-L_C\).  The derivation of

\[
\begin{aligned}
 \langle Hx,x\rangle\ge{}&
 [\lambda_{\min}(H_N)-\epsilon]\|P_Nx\|^2\\
 &+[\lambda_{N+1}-C_V-C_V^2/\epsilon]
   \|(I-P_N)x\|^2
\end{aligned}
\tag{11}
\]

is valid: the off-diagonal quadratic term is at most
\(2C_V\|P_Nx\|\|(I-P_N)x\|\), and Young's inequality gives the displayed
loss.  Thus equation (18) is a correct sufficient test once all its data
are fixed and enclosed.

It is not presently an evaluable nonnegative certificate.  The following
data remain unspecified or unenclosed:

\[
 \mathcal O_{M,J},\quad N,\quad\epsilon,\quad
 \lambda_{N+1},\quad a,\mu,d_Q,\quad
 m_j,a_j,k_j,\quad G_S,\quad G_J.
\tag{12}
\]

In particular the phrase “choose one observation” does not define a
numerical \(H_N\) or a numerical \(c_*\).  Even after fixing these choices,
the decisive low-block task is a rigorous lower enclosure for the signed
matrix (3), with the negative complete covariance Gram matrix retained.

Accordingly, the strongest rigorous conclusion from the current inputs is
the obstruction (6), not \(c_*\ge0\).  A successful continuation must either
certify (3) directly for specified data or prove a quantitative actual
comparison such as (10).  Positivity or mere nonvanishing of a finite prime
observation does not supply that missing signed estimate.
