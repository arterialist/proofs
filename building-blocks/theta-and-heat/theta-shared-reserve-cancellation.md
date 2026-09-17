# Three exact interpretations of the radius-two boundary reserve

The killed exterior is coercive, but the even joint-null comparison subtracts
the same exterior response twice: once in the constrained extension and once
inside the complete history gain.  This note tests boundary-Weyl,
observability, and electrical-network readings of that fact.  All three give
the same exact cancellation.  None turns the published radius-two barrier
into the missing sign.

Fix the actual radius-two split \(C=[-2,2]\),
\(O=\mathbb R\setminus C\), the normalized even killed ground
\(D\psi_2=\alpha_2\psi_2\), and the even joint-null form domain
\(\mathcal K_{\rm ev}\) from the preceding note.  For
\(x\in\mathcal K_{\rm ev}\), put

\[
 f=Tx=Bx,
 \qquad
 A_C[x]=E_C[x]-\alpha_2\|x\|^2.
\tag{1}
\]

The equality \(Tx=Bx\) uses \(\langle x,a_c\rangle=0\).  Reflection removes
the odd affine channel.  All sources lie in the weighted space required by the
accepted crossing theorem.

## 1. Boundary-triple and Dirichlet-to-Neumann reading

At the exterior ground pole, impose the full mean constraint before taking an
inverse.  On the even sector the score constraint is automatic.  Let
\(G_{\rm ev}\) denote the resulting positive constrained Green operator on
the admissible even exterior source space.  It is the even restriction of the
bordered inverse, not the divergent uncentered resolvent at \(\alpha_2\).

The exact Dirichlet-to-Neumann Schur form is

\[
 \boxed{
 F_{\alpha_2}[x]=A_C[x]-\mathcal C(f,f),
 \qquad
 \mathcal C(f,f)=\langle G_{\rm ev}f,f\rangle.}
\tag{2}
\]

The complete residual-history identity is

\[
 D_{\rm all}(f,f)=Q(f,f)-\mathcal C(f,f).
\tag{3}
\]

Subtracting (3) from (2) gives

\[
 \boxed{
 H[x]=F_{\alpha_2}[x]-D_{\rm all}(f,f)
 =A_C[x]-Q(f,f).}
\tag{4}
\]

Thus every Weyl-function estimate on \(G_{\rm ev}\) cancels from the final
signed quantity.  Exterior coercivity bounds \(G_{\rm ev}\) above, which
lowers the covariance \(\mathcal C\); by (3), that makes the complementary
gain larger.  It cannot by itself prove (4) nonnegative.

The boundary-triple interpretation survives only as the exact statement

\[
 \boxed{Q(Tx,Tx)\le E_C[x]-\alpha_2\|x\|^2,
 \qquad x\in\mathcal K_{\rm ev}.}
\tag{5}
\]

Any proposed Weyl estimate that ends at (5) without a new comparison between
the two sides has only renamed the missing inequality.

## 2. Control-theoretic observability reading

Let \(A_{\rm rem}\ge0\) be the actual residual generator in
\(L^2(O,\gamma)\), and \(S_f=f/\rho\).  Functional calculus factors the
complete gain as an observability Gramian:

\[
 D_{\rm all}(f,f)=\|\mathscr O S_f\|^2,
 \qquad
 \mathscr O=\left[a^{-1}A_{\rm rem}(a+A_{\rm rem})^{-1}\right]^{1/2}.
\tag{6}
\]

This is also the stationary exponential-time increment observation.  Let
\(\mathscr T x=S_{Tx}\).  Then the desired estimate is

\[
 \|\mathscr O\mathscr T x\|^2
 \le F_{\alpha_2}[x].
\tag{7}
\]

As an abstract control inequality, (7) is the Schur positivity of

\[
 \begin{pmatrix}
 F_{\alpha_2}&(\mathscr O\mathscr T)^*\\
 \mathscr O\mathscr T&I
 \end{pmatrix}
\quad\text{on }\mathcal K_{\rm ev}.
\tag{8}
\]

But inserting (2)--(3) reduces (7) exactly to (5).  A bounded-real or KYP
certificate would therefore have to provide a genuinely new storage
inequality for the core supply \(A_C\) against the complete port Gram \(Q\).
Taking \(F_{\alpha_2}\) itself as the storage merely restates (7).

A usable coefficient version would require

\[
 A_C[x]\ge c_C\|x\|^2,
 \qquad
 Q(Tx,Tx)\le c_Q\|x\|^2,
 \qquad c_Q\le c_C.
\tag{9}
\]

No such ordered pair \((c_C,c_Q)\) is presently certified at radius two.

## 3. Electrical effective-resistance reading

View the full theta form as a network with core terminals and an exterior
network.  Eliminating the exterior by the Dirichlet principle subtracts the
effective conductance \(\mathcal C(f,f)\) from the raw core supply, giving
(2).  In the residual ground network, the exponential-time dissipation is the
complement of the same effective conductance inside the complete-graph
majorant:

\[
 D_{\rm all}(f,f)=Q(f,f)-\mathcal C(f,f).
\]

Hence the network balance is again

\[
 (\text{core supply}-\text{effective conductance})
 -(\text{port majorant}-\text{effective conductance})
 =\text{core supply}-\text{port majorant}.
\tag{10}
\]

Rayleigh monotonicity inside the eliminated exterior changes both appearances
of \(\mathcal C\) equally and leaves (10) invariant.  An effective-resistance
bound for the exterior alone therefore cannot decide the sign.  A successful
network proof needs a cut or flow comparison that couples the core energy
directly to \(Q(Tx,Tx)\), namely (5).

## 4. Adversarial test of the published barrier constants

On \(\mathcal K_{\rm ev}\),

\[
 Q(Tx,Tx)
 =\frac1a\int_O\frac{\psi_2}{\rho}|Bx|^2\,d\nu
 \le\frac{P_\infty B_\rho^2}{a}\|x\|^2,
\tag{11}
\]

where \(P_\infty\ge\|\psi_2\|_\infty\) and
\(B_\rho\ge\|\rho^{-1/2}B\|\).  No rank-one centering term appears because
\(\langle x,a_c\rangle=0\).

Let the restricted core floor be

\[
 \lambda_{C,\mathcal K}:=
 \inf_{0\ne x\in\mathcal K_{\rm ev}}
 \frac{E_C[x]}{\|x\|^2}.
\tag{12}

The direct scalar certificate supplied by (9), (11), and (12) is

\[
 \boxed{
 \frac{P_\infty B_\rho^2}{a}
 \le\lambda_{C,\mathcal K}-\alpha_2.}
\tag{13}

The effective barrier gives an enormous upper bound for \(P_\infty\), not a
small one.  The current sources do not give a numerical upper bound for
\(B_\rho\), a numerical positive lower bound for \(a\) tight enough for
(13), or a validated lower enclosure for \(\lambda_{C,\mathcal K}\).
Consequently (13) cannot be checked.  Making the pointwise barrier looser only
increases its left side.

This does not prove that the actual ratio in (5) fails.  It proves that the
published barrier ledger cannot certify it.  The exact integrated quantity
\(Q(Tx,Tx)\), with its centered source and common support, would need a direct
comparison that avoids the worst-case factor \(P_\infty/a\).

There is also a monotonicity warning.  If exterior coercivity supplies only an
upper bound \(\mathcal C(f,f)\le U(f,f)\), then (3) gives

\[
 D_{\rm all}(f,f)\ge Q(f,f)-U(f,f),
\tag{14}
\]

a lower bound for the loss.  The needed upper bound on the loss would require
a lower covariance estimate, and even that lower estimate cancels if used
symmetrically in (2)--(3).

## 5. Surviving exact theorem

The three interpretations therefore leave one source-level theorem:

> **Even core-to-port comparison at radius two.**  For every
> \(x\in\mathcal K_{\rm ev}\), prove
> \[
> \frac1a\int_O\frac{\psi_2}{\rho}|Bx|^2\,d\nu
> \le E_C[x]-\alpha_2\|x\|^2.
> \tag{15}
> \]

This is equivalent to \(H\ge0\) on the even joint-nullspace.  It is not an
exterior-gap theorem: it compares the actual weighted boundary observation
directly with the core form.  No present barrier, Weyl, observability, or
network estimate proves (15), and no counterexample to it has been obtained.

## 6. Formalized finite algebra

`lean/SharedReserveCancellation.lean` formalizes:

* the exact shared-reserve cancellation (4);
* equivalence of its sign with \(Q\le A_C\);
* invariance under any common change of the exterior reserve;
* the wrong monotonicity direction in (14);
* the coefficient certificate (9).

The boundary resolvent, observability factorization, network interpretation,
and radius-two norm constants remain analytic inputs.  The module introduces
no operator assumptions or RH-strength statement.
