# The actual killed return is compact and has infinite rank

This written proof, not formalized in Lean, proves two properties of the complete return constructed in [theta-killed-core-return-comparison](theta-killed-core-return-comparison.md). Its form-domain split, bounded crossing operator, and exterior spectral bound are used with their stated normalization. The local compactness and full prime-tail bound are those of [theta-weil-jump-form](theta-weil-jump-form.md), §8. No localized prime weighted shift is assumed compact.

Fix $C=[-R,R]$, $O=\mathbb R\setminus C$, with $R>0$, and set
$$
\lambda=\tfrac12,\qquad z=\lambda-\epsilon>0,\qquad
\delta_R<\epsilon,\qquad \gamma=\epsilon-\delta_R>0.
$$
The actual killed operator satisfies $L_O\ge\lambda-\delta_R=z+\gamma$. Its resolvent and return are
$$
R_z=(L_O-z)^{-1},\qquad \Sigma_z=B^*R_zB,
\tag{1}
$$
where $B:L^2(C,\nu)\to L^2(O,\nu)$ includes the continuous archimedean crossings and every prime-power crossing.

We prove
$$
\boxed{\quad \Sigma_z\text{ is positive, compact, and of infinite rank.}\quad}
\tag{2}
$$
In fact $B$ itself is not compact. The resolvent factor is essential to the compactness proof.

## 1. Localizing the resolvent square root: the operator order

Put $A=R_z^{1/2}$, a bounded, positive, injective operator on the exterior space. Spectral calculus gives
$$
\|A\|\le\gamma^{-1/2},\qquad
\|(L_O+1)^{1/2}A\|^2
\le1+\frac{z+1}{\gamma}.
\tag{3}
$$
Thus $A$ maps a bounded exterior $L^2$ set into a bounded set of the killed form domain. Extension by zero identifies this domain with the full theta form domain restricted to functions supported in $O$; the legitimacy of this hard split was proved in the source construction.

For $M>R$, let $P_M$ be multiplication by $1_{O\cap[-M,M]}$ in the exterior space. The actual local compactness theorem therefore implies
$$
P_MA\quad\hbox{is compact.}
\tag{4}
$$
For example, extend a form-bounded sequence by zero, multiply by a smooth cutoff equal to one on $[-M,M]$, use the local logarithmic Fourier bound and compact local $L^2$ embedding, and then restrict to $O\cap[-M,M]$. The hard boundary at $\pm R$ introduces no new premise at this step.

The required factor in the return is $AB$, not $BA$. Taking adjoints in (4) shows that $AP_M$ is compact. Hence $AP_MB$ is compact. It remains to control
$$
AB-AP_MB=A(1-P_M)B.
\tag{5}
$$
This is where the actual crossing tail is used; compactness of $P_MA$ alone would not justify the conclusion without the adjoint and this tail estimate.

## 2. The complete distant-exterior crossing tail

Under the unitary map $h\mapsto\sqrt m\,h$, write
$$
\omega=\sqrt{\Phi/(2\cosh(u/2))},\qquad w=\omega^2.
$$
The archimedean crossing kernel in Lebesgue measure is
$$
\omega(u)\omega(v)r(|u-v|),\quad u\in O,\ v\in C,
\qquad r(t)=\frac{e^{-t/2}}{1-e^{-2t}}.
$$
For $M>R$, the separated tail $|u|>M$, $|v|\le R$, is Hilbert–Schmidt. Since $r$ decreases,
$$
\|(1-P_M)B_{\rm arch}\|
\le r(M-R)
 \left[\left(\int_{|u|>M}w(u)du\right)
       \left(\int_Cw(v)dv\right)\right]^{1/2}.
\tag{6}
$$
The full prime part is a restricted part of the off-diagonal operator $K_{\rm p}$. With $Q_M=1_{[-M,M]}$ on the full Lebesgue space,
$$
\|(1-P_M)B_{\rm prime}\|
\le\|K_{\rm p}-Q_MK_{\rm p}Q_M\|\le\Gamma_M.
\tag{7}
$$
This uses the complete prime-power shift series and its established tail norm; it does not declare $Q_MK_{\rm p}Q_M$ compact. Therefore
$$
\|(1-P_M)B\|\le t_{R,M}:=
 r(M-R)\left[\int_{|u|>M}w\int_Cw\right]^{1/2}+\Gamma_M
 \longrightarrow0.
\tag{8}
$$
For fixed $R$, theta decay makes this bound superexponentially small in $M$, after increasing $M$ beyond $R+1$.

Combining (3), (5), and (8),
$$
\|AB-AP_MB\|\le\gamma^{-1/2}t_{R,M}\to0.
\tag{9}
$$
Thus $AB$ is a norm limit of compact operators. The exact factorization
$$
\Sigma_z=(AB)^*(AB)
\tag{10}
$$
proves compactness and positivity. Neither $R_z$ on the entire exterior nor $B$ is required to be compact.

## 3. Actual archimedean columns give infinite rank

Choose $0<a<b$ so that $b<2R$ and $2b<\log2$. Restrict the source and target to the nonempty intervals
$$
I=(R-b,R-a)\subset C,\qquad J=(R+a,R+b)\subset O.
$$
For $u\in J,v\in I$, the displacement satisfies $0<u-v<2b<\log2$. Consequently no prime-power atom connects these intervals. The restricted crossing operator is exactly the integral operator
$$
(Tf)(u)=\int_I\omega(u)\omega(v)r(u-v)f(v)dv,
\qquad u\in J.
\tag{11}
$$
The theta factors are bounded above and away from zero on the closures of these intervals. Multiplying by them does not change finite versus infinite rank. It therefore suffices to prove that the kernel $r(u-v)$ has infinite rank.

For $t>0$, the convergent expansion is
$$
r(t)=\sum_{n\ge0}e^{-(2n+1/2)t}.
\tag{12}
$$
Choose any distinct $v_1,\ldots,v_m\in I$. If
$\sum_{j=1}^mc_jr(u-v_j)=0$ on $J$, real analyticity extends this identity to every $u>\max_jv_j$. Set $x=e^{-2u}$. After dividing by $e^{-u/2}$, (12) is a power series near $x=0$, whose coefficients must all vanish:
$$
\sum_{j=1}^mc_je^{v_j/2}(e^{2v_j})^n=0\qquad(n\ge0).
\tag{13}
$$
The first $m$ equations form a Vandermonde system with distinct nodes $e^{2v_j}$. Therefore all $c_j=0$. There are arbitrarily many linearly independent columns.

To pass from columns to the rank of the $L^2$ operator, approximate a point mass at any interior $v_j$ by normalized-integral bumps in $L^2(I)$. The separated smooth kernel makes the corresponding outputs converge in $L^2(J)$ to that column. If the operator had finite rank, its finite-dimensional range would be closed and would contain every such column, contradicting (13). Thus $T$, and hence the full $B$, has infinite rank.

Since $A$ is injective, $AB$ has the same finite/infinite rank as $B$. Also
$$
\ker\Sigma_z=\ker(AB)=\ker B,
\tag{14}
$$
because $\langle x,\Sigma_zx\rangle=\|ABx\|^2$. A positive finite-rank operator has finite-dimensional orthogonal complement to its kernel. Equation (14) would then make $B$ finite rank. Therefore $\Sigma_z$ has infinite rank, completing (2). There is no assumption that the positive resolvent is bounded below by a positive constant; its injectivity is sufficient.

## 4. Why the crossing operator itself is not compact

The distinction can be tested directly at the same actual boundary. Choose a nonnegative, nonzero $\chi\in C_c^\infty((1,2))$ with $\|\chi\|_2=1$, and in the Lebesgue core coordinate let
$$
x_\varepsilon(v)=\varepsilon^{-1/2}\chi((R-v)/\varepsilon).
$$
For small $\varepsilon$, these are unit vectors in the core and converge weakly to zero. Look only at output points $u=R+\varepsilon s$, $1<s<2$. If $4\varepsilon<\log2$, no prime atom contributes between these input and output intervals. Since $t r(t)\to1/2$,
$$
\varepsilon^{1/2}(Bx_\varepsilon)(R+\varepsilon s)
\longrightarrow
\frac{\omega(R)^2}{2}\int_1^2\frac{\chi(t)}{s+t}\,dt
\quad\hbox{in }L^2((1,2),ds).
\tag{15}
$$
The limit is nonzero. Dominated convergence follows from the bounded theta factors and the uniform bound for $t r(t)$ already used in the source's Carleman estimate. Thus $\liminf\|Bx_\varepsilon\|>0$, contradicting the image property of a compact operator on weakly null sequences. This proves noncompactness of $B$ without a claim about compactness of any prime shift.

## 5. What the result permits and what it does not

A positive compact infinite-rank operator has infinitely many positive eigenvalues, counted with multiplicity, tending to zero. Hence $\Sigma_z$ admits positive finite-rank spectral approximations in operator norm. It cannot equal an operator with finitely many channels. The proof does not give a channel count for a prescribed accuracy, a Schatten-class estimate, or a sign for the resulting Schur form.

Two related actual operators share the conclusion:
$$
M_z-I=B^*L_O^{-1}(L_O-z)^{-1}B,
\qquad B^*(L_O-z)^{-2}B.
\tag{16}
$$
Their square-root factorizations are obtained from the compact operator $AB$ by the bounded injective exterior factors $L_O^{-1/2}$ and $R_z^{1/2}$, respectively. Thus both are positive, compact, and of infinite rank. This retains the excursion metric as well as the derivative of the Schur form.

Finally, imposing finitely many core moment constraints does not make the return finite rank. If $P_V$ projects onto a finite-codimension core subspace, then
$\Sigma_z-P_V\Sigma_zP_V$ has finite rank. Finite rank of the compression would therefore contradict (2). Likewise adding or subtracting the two-moment finite-rank correction from the source construction cannot erase the infinite-dimensional return correction. This assertion concerns channel dimension, not positivity of the fully corrected Schur operator.

All claims are at the fixed admissible $R,z$. Uniform finite-rank approximation as $z\uparrow1/2$ with $R$ changing is not asserted. The core spectrum and the exterior resolvent bounds needed for such a uniform statement remain separate obligations.

## 6. The exterior threshold inverse is impossible for every fixed core

The full theta operator has an infinite-dimensional threshold eigenspace $\Theta$, containing the independent even derivative modes. Choose an orthonormal sequence $r_n\in\Theta$. Then
$$
Lr_n=\lambda r_n,\qquad \|r_n\|=1,\qquad E(r_n)=\lambda,
\qquad r_n\rightharpoonup0.
$$
Local compactness of the full form domain gives, for every fixed $R>0$,
$$
\|r_{n,C}\|\longrightarrow0.
\tag{17}
$$
Indeed restriction to a bounded interval is compact on a form-bounded set, and any locally strong subsequential limit must be zero by weak convergence. The entire sequence therefore has vanishing local norm.

The exact hard-split operator domain from the source implies $r_{n,O}\in D(L_O)$, and the exterior component of the full eigen-equation reads
$$
(L_O-\lambda)r_{n,O}=Br_{n,C}\longrightarrow0.
\tag{18}
$$
Moreover $\|r_{n,O}\|\to1$ and $r_{n,O}\rightharpoonup0$ in the exterior Hilbert space. After normalization these are a singular Weyl sequence. Thus
$$
\boxed{\quad \tfrac12\in\sigma_{\rm ess}(L_O)
\quad\text{for every fixed core }[-R,R].\quad}
\tag{19}
$$
This uses the actual threshold eigenspace, rather than a hypothetical negative vector or a finite approximation of its modes. In particular $(L_O-1/2)^{-1}$ does not exist as a bounded everywhere-defined operator. The obstruction is stronger than failure of the available $\delta_R$ estimate to justify that inverse.

For any $z\in\rho(L_O)$, self-adjointness and (19) imply
$$
\|(L_O-z)^{-1}\|\ge\frac1{|1/2-z|}.
\tag{20}
$$
The inverse norm therefore diverges along every resolvent sequence approaching the threshold. A real approach must avoid any intervening exterior eigenvalues; the positive-resolvent construction (1) only used energies strictly below the proved exterior lower bound.

There is no corresponding inference that $\|\Sigma_z\|$ diverges. Both factors $B$ may suppress precisely the escaping directions in (18). In the source's moving-core regime $R=R(\epsilon)$, the exact estimate remains
$$
\|\Sigma_{1/2-\epsilon}\|
\le\frac{b_{R(\epsilon)}^2}{\epsilon-\delta_{R(\epsilon)}},
$$
while the inverse itself has norm at least $1/\epsilon$. Thus fixed-parameter compact infinite-rank return, failure of the fixed-core threshold inverse, and possible smallness of the observed return correction are distinct statements. No substitution of $z=1/2$ in the Schur formulas is licensed by compactness.

The [exterior-index proof](theta-exterior-threshold-index-transport.md) also shows that every fixed exterior has a discrete eigenvalue $0<\alpha_R<1/2$, using a compact physical translate of a negative uncentered threshold test. Its complete pole contribution remains explicit there. Together with (19), this gives $\inf\sigma_{\rm ess}(L_O)=1/2$ and rules out a positive exterior inverse throughout the entire strict subthreshold interval for any fixed core. The localization lower bound gives $1/2-\delta_R\le\alpha_R<1/2$, hence $\alpha_R\to1/2$ as $R\to\infty$. The [ground-state proof](theta-killed-return-ground-pole.md) establishes simplicity and the nonzero observed residue.
