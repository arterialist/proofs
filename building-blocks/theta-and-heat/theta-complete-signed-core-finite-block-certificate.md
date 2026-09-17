# A finite-block sufficient certificate for the complete signed core comparison

The bounded weighted crossing theorem makes the full affine covariance comparison a bounded perturbation of the actual killed core operator. A finite core-eigenfunction block and an explicit complementary-spectrum bound therefore give a sufficient sign certificate. This differs from a certificate that the prime gain alone is positive: all negative weighted terms, the mean correction, the odd affine correction, and the finite prime observation occur in the same matrix.

No positive value of the certificate is asserted. In particular the one-jump observation may be too weak to make the resulting lower operator nonnegative.

## Actual domain upgrade and notation

Fix \(C=[-R,R]\), \(O=\mathbb R\setminus C\). Retain the complete hard split, exterior ground state, and source notation
\[
 L=\begin{pmatrix}L_C&-B^*\\-B&D\end{pmatrix},\quad
 D\psi=\alpha\psi,\quad \|\psi\|_O=1,\quad
 \mu=\langle1_O,\psi\rangle>0,
\]
\[
 Tx=Bx-\langle x,a_c\rangle1_O,\qquad
 a_c=B^*\psi/\mu,\qquad q=\tau_O.
 \tag{1}
\]
All inner products are linear in the first argument. Thus
\(\langle x,a_c\rangle=\langle Bx,\psi\rangle/\mu\).

The new source theta-groundstate-bounded-weighted-crossing.md proves
\[
 \|\psi\|_\infty<\infty,\qquad
 \rho^{-1/2}B:L^2(C,\nu)\longrightarrow L^2(O,\nu)
 \text{ bounded},
\]
where
\[
 \rho(u)=\frac{e^{-|u|/2}}{2\cosh(u/2)},\qquad
 d\gamma=\rho\psi\,d\nu,\qquad a=\gamma(O)>0.
\]
Consequently the centered map
\[
 \mathcal Sx=\frac{Tx}{\rho}:
 \mathcal H_C=L^2(C,\nu)\longrightarrow\mathcal H_\gamma=L^2(O,\gamma)
 \tag{2}
\]
is bounded on every core \(L^2\) input. The same is true of
\[
 q_\gamma=q/\rho,\qquad 1_O/\rho\in\mathcal H_\gamma.
\]
This removes the former extra weighted-source condition for unbounded core tests.

Let
\[
 Q(f,g)=\frac1a\int_O\frac{\psi}{\rho}f\overline g\,d\nu,\qquad
 d_Q=Q(q,q)=\frac{\|q_\gamma\|_\gamma^2}{a}>0.
\]
The Riesz vector for the complete affine odd numerator is
\[
 \boxed{\quad
 k_Q=\tau_C+\frac1a\mathcal S^*q_\gamma,\qquad
 \langle x,k_Q\rangle=\langle x,\tau_C\rangle+Q(Tx,q).
 \quad}
 \tag{3}
\]
In particular its exact minimizing coefficient is
\(c_Q(x)=\langle x,k_Q\rangle/d_Q\), not a freely chosen or fitted coefficient.

Choose one bounded finite prime observation
\(\mathcal O:L^2(O,\nu)\to\mathcal Z\) from
theta-prime-gain-finite-observations.md, so that
\[
 \|\mathcal O f\|_{\mathcal Z}^2\le\mathscr D(f).
 \tag{4}
\]
The observation may consist of finitely many scalar edge measurements. Its rate denominators and its sources retain the full prime process. Define the bounded core observation
\[
 \boxed{\quad
 Jx=\mathcal O\left(Tx-\frac{\langle x,k_Q\rangle}{d_Q}q\right).
 \quad}
 \tag{5}
\]
The dependence of the observed odd subtraction on the core input is part of this operator.

## The complete signed lower operator

For \(u,v\in\mathcal H_C\), use
\((u\otimes v)x=\langle x,v\rangle u\). Define
\[
 \begin{split}
 H={}&L_C-\alpha I+
       (a_c\otimes1_C+1_C\otimes a_c)
       -\frac1a\mathcal S^*\mathcal S\\
    &+\frac1{d_Q}k_Q\otimes k_Q+J^*J.
 \end{split}
 \tag{6}
\]
The notation \(\mathcal S^*\mathcal S\) avoids treating multiplication by
\(\psi/\rho\) as bounded on the exterior space; only its bounded composition with the actual crossing source is needed.

The full affine prime-gain inequality gives, for every \(x\in D(E_C)\),
\[
 \boxed{\qquad
 F_\alpha[x]\ge\langle Hx,x\rangle,
 \qquad}
 \tag{7}
\]
with the right side interpreted as a closed quadratic form when \(x\notin D(L_C)\).
Indeed it is exactly
\[
 E_C[x]-\alpha\|x\|^2+
 2\operatorname{Re}\!\left(
       \langle x,a_c\rangle\overline{\langle x,1_C\rangle}\right)
 -Q(Tx,Tx)+\frac{|\langle x,k_Q\rangle|^2}{d_Q}
 +\|Jx\|^2.
 \tag{8}
\]
Evaluate the prime-retained affine variational problem at \(c_Q(x)\), use (4), and retain the mean term to obtain (8). No passage from homogeneous variance to affine variance is being assumed.

Every term after \(L_C\) in (6) is a bounded self-adjoint operator. Thus \(H=L_C+V\) is self-adjoint on \(D(L_C)\), with form domain \(D(E_C)\). It is the full signed lower comparison, not the positive observation pencil alone.

## Finite norm ingredients from the actual kernel

Here are sufficient actual constants, none numerically evaluated in this note. Let
\[
 b\ge\|B\|,\qquad B_\rho\ge\|\rho^{-1/2}B\|,\qquad
 P_\infty\ge\|\psi\|_\infty,\qquad M_O=\nu(O),\quad M_C=\nu(C),
\]
and
\[
 Z_0=\left(\int_O\frac{\psi}{\rho}\,d\nu\right)^{1/2},
 \qquad Z_q=\|q_\gamma\|_\gamma.
\]
They are finite and satisfy
\[
 Z_q\le Z_0\le
 \sqrt{P_\infty}\left(\int_O\rho^{-1}d\nu\right)^{1/2},\quad
 \|a_c\|\le b/\mu.
 \tag{9}
\]
One may take
\[
 M_T=\frac{b\sqrt{M_O}}{\mu},\qquad
 M_S=\sqrt{P_\infty}B_\rho+\frac b\mu Z_0,\qquad
 M_k=\|\tau_C\|+\frac{M_SZ_q}{a}.
 \tag{10}
\]
Then \(\|T\|\le M_T\), \(\|\mathcal S\|\le M_S\), and
\(\|k_Q\|\le M_k\).

For the weighted crossing bound \(B_\rho\), the continuous kernel after conjugating to Lebesgue \(L^2\) is
\[
 r(|u-v|)
 \sqrt{\frac{e^{|u|/2}\Phi(u)\Phi(v)}{2\cosh(v/2)}},
 \qquad u\in O,\ v\in C.
 \tag{11}
\]
Two local Carleman bounds at the endpoints, each using the norm \(\pi\) of the kernel \(1/(s+t)\), and the Hilbert--Schmidt norm away from these endpoints give a finite continuous bound. The entire prime part is bounded by the convergent sum
\[
 \sum_{n\ge2}\sum_{\pm}\Lambda(n)
 \sup_{v\in C}
 \sqrt{\frac{e^{|v\pm\log n|/2}
             \Phi(v\pm\log n)\Phi(v)}
            {n\,2\cosh(v/2)}}.
 \tag{12}
\]
Discarding an exterior-indicator factor only enlarges this upper bound. Theta decay proves convergence with \(\Lambda(n)\le\log n\); all proper prime powers remain.

The bounded-barrier construction in theta-groundstate-bounded-weighted-crossing.md supplies
\[
 P_\infty\le M C_\epsilon/\delta
 \tag{13}
\]
for its chosen bounded barrier \(1\le w\le M\), positive coercivity
\(\delta=(1/2-\alpha)/8\), and continuous arrival estimate
\(\|K_\epsilon\|_{2\to\infty}\le C_\epsilon\).
These are fixed-core constants. There is no uniform assertion as \(\alpha\) approaches \(1/2\).

If \(C_{\mathcal O}\ge\|\mathcal O\|\), (5) gives
\[
 M_J=C_{\mathcal O}M_T+
       \frac{\|\mathcal Oq\|\,M_k}{d_Q}
 \ \ge\ \|J\|.
 \tag{14}
\]
The finite-filter source gives, for its filter parameter \(M\), the available bound
\(C_{\mathcal O}^2\le2M(e^M+1)/a\); a subsequent orthogonal projection onto finitely many scalar measurements cannot increase this norm. Also
\(\|\mathcal Oq\|\le C_{\mathcal O}\|q\|_\nu\).

A complete bounded-perturbation estimate is therefore
\[
 \boxed{\quad
 \|V\|\le C_V:=
 \alpha+\frac{2b\sqrt{M_C}}{\mu}
       +\frac{M_S^2}{a}+\frac{M_k^2}{d_Q}+M_J^2.
 \quad}
 \tag{15}
\]
In an evaluated certificate, \(a,\mu,d_Q\) require positive lower enclosures, and the other quantities require upper enclosures. Their positivity and finiteness alone are not numerical enclosures.

## Exact finite matrix coefficients

The killed core has compact resolvent. Choose an orthonormal eigenbasis
\[
 L_Ce_j=\lambda_je_j,\qquad
 0<\lambda_1\le\lambda_2\le\cdots,\qquad \lambda_j\to\infty,
\]
counting multiplicity. Set
\[
 m_j=\langle e_j,1_C\rangle,\quad
 a_j=\langle e_j,a_c\rangle,\quad
 k_j=\langle e_j,k_Q\rangle,\quad
 s_j=\mathcal S e_j,\quad j_j=Je_j.
\]
For the usual column-coordinate matrix, define
\((H_N)_{ij}=\langle H e_j,e_i\rangle\), \(1\le i,j\le N\).
Then
\[
 \boxed{\quad
 (H_N)_{ij}
 =(\lambda_j-\alpha)\delta_{ij}
  +m_j\overline{a_i}+a_j\overline{m_i}
  -\frac{\langle s_j,s_i\rangle_\gamma}{a}
  +\frac{k_j\overline{k_i}}{d_Q}
  +\langle j_j,j_i\rangle_{\mathcal Z}.
 \quad}
 \tag{16}
\]
With this convention \(\langle Hx,x\rangle=c^*H_Nc\) for
\(x=\sum_{j\le N}c_je_j\). In particular the two mean terms in (16) have the signs in the full pole formula.

The entries contain the complete arithmetic and theta operators through
\(B,\psi,\mathcal S\), the full affine odd column, and the full-rate prime observations. Finite dimensionality of (16) does not turn those entries into finite prime truncations. Bounds such as (12) can control an evaluated tail, but that tail cannot be omitted.

## Complementary-spectrum bound and sufficient sign test

Let \(P_N\) project onto the first \(N\) eigenvectors. For
\(x=x_{\rm low}+x_{\rm high}\), the off-diagonal block of \(H\) comes only from \(V\), so its norm is at most \(C_V\). The high block satisfies
\[
 \langle Hx_{\rm high},x_{\rm high}\rangle
 \ge(\lambda_{N+1}-C_V)\|x_{\rm high}\|^2.
\]
For every \(\epsilon>0\), Young's inequality gives the complete bound
\[
 \boxed{\quad
 \langle Hx,x\rangle\ge
 [\lambda_{\min}(H_N)-\epsilon]\|x_{\rm low}\|^2
 +\left[\lambda_{N+1}-C_V-\frac{C_V^2}{\epsilon}\right]
       \|x_{\rm high}\|^2.
 \quad}
 \tag{17}
\]
An improved certified off-diagonal norm may replace \(C_V\) only in the squared term.

Consequently, rigorous lower enclosures yield the sufficient certificate
\[
 \boxed{\quad
 c_*=\min\left\{
 \underline{\lambda_{\min}(H_N)}-\epsilon,\
 \underline{\lambda_{N+1}}-C_V-C_V^2/\epsilon
 \right\}\ge0
 \quad\Longrightarrow\quad F_\alpha\ge0.
 \quad}
 \tag{18}
\]
If \(c_*>0\), then \(F_\alpha[x]\ge c_*\|x\|^2\) on the full core form domain. Every mean and odd term in (18) is already present in the matrix, so no subsequent pole correction is being assumed favorable.

For a fixed observation, the lower operator \(H\) may have negative spectrum even if the exact \(F_\alpha\) is nonnegative. Thus no existence or termination claim follows merely from positive prime gain. If this particular \(H\) is independently known to have a strictly positive lower bound, its low compressions inherit that bound and \(\lambda_{N+1}\to\infty\), so some \(N,\epsilon\) make (18) pass. That conditional statement does not supply the missing sign of \(H\).

The result is a fixed-core sufficient certificate for the complete signed comparison. The matrix entries, core spectral bounds, and norm constants have not been evaluated here. A certificate at one removed ground pole also does not supply an uncontrolled continuation to the full threshold.
