# Minimal source-normalized map on the optimizer span

This note fixes one named optimizer-specific map and evaluates its Suzuki matrix exactly. The map sends each theta source direction to the normalized constant vector on the already certified interval. It reproduces the two score-row pairings with minimum L² norm and adds no free mean-zero component.

For the actual optimizer vector, the affine coefficient identity makes its interval image exactly -e_0/2. Thus the available paid allowance is an explicit scalar. The remaining theta matrix N still has no numerical enclosure. This identifies the exact arithmetic quantity blocking a passing certificate.

The map is defined only on the two-dimensional comparison-source span. It is not claimed to intertwine the full theta form.

## Theta source data

Use

\[
g_y=M^{-1}S_y,
\qquad g_q=M^{-1}S_q,
\qquad X=\operatorname{span}\{g_y,g_q\}.
\tag{1}
\]

Let

\[
u=U(q,q)=\langle g_q,S_q\rangle_\gamma>0,
\qquad r_y=U(y,q)=\langle g_y,S_q\rangle_\gamma,
\]
\[
r=\binom{r_y}{u}.
\tag{2}
\]

These are the two required source-normalization rows. The actual residual optimizer direction is

\[
w=\delta g_y-t_{\rm score}g_q,
\qquad
t_{\rm score}=\frac{1/2+\delta r_y}{u}.
\tag{3}
\]

Hence its score row is fixed exactly:

\[
\langle w,S_q\rangle_\gamma
=\delta r_y-t_{\rm score}u=-\tfrac12.
\tag{4}
\]

The full comparison optimizer is v_U=φ-w. Since the conditional form annihilates φ,

\[
n[v_U]=n[w].
\tag{5}
\]

Define the theta residual Gram matrix

\[
N_{ij}=n[g_j,g_i],
\qquad(g_1,g_2)=(g_y,g_q).
\tag{6}
\]

Its entries are the complete actual edge quantities

\[
N_{ij}=\operatorname{Same}_c(Pg_j,Pg_i)
+m_c\operatorname{Cov}_{\pi_c}
(\Delta_\times Pg_j,\Delta_\times Pg_i)
\]
\[
\hspace{25mm}+
\operatorname{Same}_p(Pg_j,Pg_i)
+m_p\operatorname{Cov}_{\pi_p}
(\Delta_\times Pg_j,\Delta_\times Pg_i).
\tag{7}
\]

The same common projection P occurs in every entry. The prime same-half term is

\[
\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
\int_{\substack{z,z+\log n\in O\\\text{same half}}}
\psi(z)\psi(z+\log n)\Phi(z)\Phi(z+\log n)
\Delta_ng_j(z)\Delta_ng_i(z)\,dz,
\tag{8}
\]

and the crossing covariance uses the corresponding full sum over log n>2R with its own mean removed. Thus (6)-(8) retain every prime power, both orientations and both component means.

## Named interval map

Take ω=1, a=sqrt2 and

\[
I=[-\tfrac12\log2,\tfrac12\log2],
\qquad B=\log2.
\]

Let

\[
e_0(t)=B^{-1/2}.
\tag{9}
\]

Define U_0:X→L²(I) by

\[
U_0g_y=r_y e_0,
\qquad U_0g_q=u e_0.
\tag{10}
\]

With interval row s=e_0, equations (2) and (10) give exact source normalization:

\[
\langle U_0g_y,s\rangle=r_y,
\qquad
\langle U_0g_q,s\rangle=u.
\tag{11}
\]

Among images constrained to the score row (11), each vector in (10) has minimum L² norm. No mean-zero endpoint or gamma-response component is added.

The d=2 Euler arrival is retained. At a=sqrt2 it begins only at the measure-zero upper corner and its primitive vanishes there, so its quadratic contribution is zero rather than omitted.

## Exact Suzuki matrix

The constant-vector gamma entry is

\[
k_0=\langle H_1e_0,e_0\rangle
=\frac{2\pi}{3\log2}
\left(20-11\sqrt2-\log64\right)
\]
\[
=0.86044660770748929647\ldots.
\tag{12}
\]

The last decimal is only for scale; the preceding expression is exact. Put

\[
a_\sigma=1+\sigma k_0.
\tag{13}
\]

The paid Suzuki Gram matrix of U_0 is the rank-one matrix

\[
\boxed{\quad Q_0^{(\sigma)}=a_\sigma rr^T.\quad}
\tag{14}
\]

Elementary rational enclosures for π, log2 and sqrt2 give

\[
0.86044660770748<k_0<0.86044660770750,
\]
\[
1.86044660770748<a_+<1.86044660770750,
\]
\[
0.13955339229250<a_-<0.13955339229252.
\tag{15}
\]

Every endpoint is already included in the direct kernel integral producing (12).

## Actual optimizer-vector certificate

Let

\[
c=\binom{\delta}{-t_{\rm score}}.
\]

Equation (4) says r^Tc=-1/2. Therefore

\[
c^TQ_0^{(\sigma)}c=\frac{a_\sigma}{4}.
\tag{16}
\]

The named map pays the actual affine deficit if and only if

\[
\boxed{\quad n[v_U]=c^TNc\le\frac{a_\sigma}{4}.\quad}
\tag{17}
\]

The two exact allowances have rigorous enclosures

\[
0.46511165192687<\frac{a_+}{4}<0.46511165192688,
\]
\[
0.03488834807312<\frac{a_-}{4}<0.03488834807313.
\tag{18}
\]

Equation (17) is stronger and more concrete than an unspecified bounded-map constant. It keeps the actual affine coefficient and reduces the optimizer question to one complete conditional edge evaluation.

No present theorem gives an upper enclosure for c^TNc below either threshold in (18). Full-form membership proves finiteness only. Therefore this candidate has neither a passing certificate nor a failure witness on the actual optimizer vector.

## Full-span certificate and an exact failure direction

For the whole source span X, the condition is

\[
a_\sigma rr^T-N\succeq0.
\tag{19}
\]

Let

\[
d=\binom{u}{-r_y}.
\tag{20}
\]

Then r^Td=0, so

\[
d^TQ_0^{(\sigma)}d=0,
\qquad
d^T(Q_0^{(\sigma)}-N)d=-d^TNd.
\tag{21}
\]

Thus a single exact theta calculation decides full-span failure:

\[
\boxed{\quad d^TNd=n[ug_y-r_yg_q]>0
\quad\Longrightarrow\quad
Q_0^{(\sigma)}-N\not\succeq0
\text{ for both signs}.\quad}
\tag{22}
\]

This witness does not apply to the actual optimizer vector unless c is proportional to d. It preserves the requested distinction between full-span and optimizer-only certificates.

The nonnegative form N makes d^TNd≥0. The [exact common-score nullspace theorem](theta-affine-comparison-conditional-edge-energy.md#the-exact-common-score-nullspace) identifies that nullspace on odd potentials as $\operatorname{span}\{\varepsilon,\varphi\}$. The next theorem proves strict positivity for the actual theta sources.

### Strict full-span failure for the actual theta sources

**Theorem.** For every fixed $R>0$ for which the actual killed ground and score-matched comparison above are defined,
\[
\boxed{\quad n[ug_y-r_yg_q]>0.\quad}
\tag{23}
\]
Consequently the named minimum-norm map $U_0$ fails the full two-source certificate (19) for both Suzuki signs. The theorem makes no claim about the optimizer-only inequality (17).

To prove this, suppose instead that the odd potential $h=ug_y-r_yg_q$ belongs to the residual nullspace. Then $h=A\varepsilon+B\varphi$ almost everywhere for real constants $A,B$. The comparison action matches both known columns:
\[
M\varepsilon=K\varepsilon,
\qquad M\varphi=K\varphi=S_f+\delta S_y-\tfrac14S_q.
\]
Since $Mg_y=S_y$ and $Mg_q=S_q$, applying $M$ gives an equality of $L^2(\gamma)$ sources,
\[
uS_y-r_yS_q
=A K\varepsilon+B(S_f+\delta S_y-\tfrac14S_q).
\tag{24}
\]

The crossing source $S_f=(B\sigma_C)/\rho$ has a nonzero logarithmic singularity at the positive hard boundary. In the normalization $b(x)=2\cosh(x/2)$, $\rho(x)=(1+e^x)^{-1}$, $b(x)\rho(x)=e^{-x/2}$ for $x>0$, and $r(s)=e^{-s/2}/(1-e^{-2s})$, its continuous part at $x=R+t$, $t\downarrow0$, is
\[
S_{f,c}(R+t)
=\frac1{b(R+t)\rho(R+t)}
\int_{-R}^{R}r(R+t-v)\Phi'(v)\,dv
=\frac{e^{R/2}\Phi'(R)}2\log(1/t)+O_R(1).
\tag{25}
\]
Indeed $r(s)=1/(2s)+O(1)$ near zero, and the remaining integral after replacing $\Phi'(v)$ by $\Phi'(R)$ is bounded. The [strict theta derivative theorem](theta-derivative-kernel-logconcavity.md#definitions-and-theorem) gives $\Phi'(R)<0$. The prime part of $S_f$ is locally bounded at this boundary: when $R<x<R+1$, a prime shift from $x$ into $[-R,R]$ has $n\le e^{2R+1}$, so only finitely many bounded summands occur. The other sources $S_y=\sigma/\rho$, $S_q=\tau/\rho$, and $K\varepsilon=\varepsilon(T_c+T_p)$ are locally bounded there. For the last assertion, $T_c\le a(1+\kappa_R)$ and the complete prime departure estimate gives $T_p\le2P_\infty B_p/\rho$. Thus (24) forces $B=0$.

The remaining equality $uS_y-r_yS_q=A K\varepsilon$ fails at infinity. The first theta summand dominates $\Phi(x)$ as $x\to+\infty$, giving
\[
\sigma(x)=\frac{\Phi'(x)}{\Phi(x)}
=-2\pi e^{2x}+\tfrac92+O(e^{-2x}),
\qquad S_y(x)=-2\pi e^{3x}(1+o(1)).
\tag{26}
\]
Meanwhile $S_q(x)=O(e^x)$ and the same complete cross-rate bound gives $K\varepsilon(x)=O_R(e^x)$. Since $u=U(q,q)>0$, the $e^{3x}$ term cannot cancel. Equality (24), initially $\gamma$-almost everywhere, is impossible by these pointwise bounds on every sufficiently far tail because $\gamma$ is equivalent to Lebesgue measure on $O$. Hence $h\notin\operatorname{span}\{\varepsilon,\varphi\}$; the exact nullspace theorem proves (23), and (21) proves full-span failure.

Both arguments use the full actual theta source. The prime powers enter $S_f$ and $K\varepsilon$ and are controlled at the boundary and tail without replacing them by a continuous density. The result is strict but has no numerical lower bound for $n[h]$.

Equivalently, the complete two-by-two test for (19) is

\[
a_\sigma r_y^2-N_{11}\ge0,
\qquad a_\sigma u^2-N_{22}\ge0,
\]
\[
(a_\sigma r_y^2-N_{11})(a_\sigma u^2-N_{22})
-(a_\sigma r_yu-N_{12})^2\ge0.
\tag{27}
\]

The theorem shows that the conditions in (27) cannot all hold for this map. Their unevaluated terms are the actual edge integrals (7)-(8), not free covariance parameters.

## Allowing one mean-zero interval direction

The minimal map can be enlarged without changing source normalization. Let e_1=B^{-1/2}sgn(t), so ⟨e_1,e_0⟩=0, and choose a real vector λ=(λ_y,λ_q)^T. Define

\[
U_\lambda g_i=r_i e_0+\lambda_i e_1.
\tag{28}
\]

The exact interval gamma block in the basis (e_0,e_1) is

\[
K=\begin{pmatrix}
k_0&k_{01}\\k_{01}&k_1
\end{pmatrix},
\]

where

\[
k_{01}=\frac{2\pi}{3\log2}
\left(-20-11\sqrt2-4\,2^{1/4}+24\,2^{3/4}\right),
\]
\[
k_1=\frac{2\pi}{3\log2}
\left(-60-11\sqrt2-8\,2^{1/4}+\log64+48\,2^{3/4}\right).
\tag{29}
\]

and each entry has an elementary exponential expression from the first-cell kernel. Then

\[
Q_\lambda^{(\sigma)}
=a_\sigma rr^T
+\sigma k_{01}(r\lambda^T+\lambda r^T)
+(1+\sigma k_1)\lambda\lambda^T.
\tag{30}
\]

For the optimizer vector its allowance is

\[
c^TQ_\lambda^{(\sigma)}c
=\frac{a_\sigma}{4}
-\sigma k_{01}(c^T\lambda)
+(1+\sigma k_1)(c^T\lambda)^2.
\tag{31}
\]

Both coefficients 1+σk_1 are positive. Thus an arbitrary large λ can make (31) pay any finite scalar deficit, but this is not a meaningful arithmetic certificate unless λ is fixed by a stated endpoint or translation law and its construction cost is included. Formula (31) exposes why unrestricted finite-dimensional embedding would trivialize the optimizer question.

## Result

For the named minimum-norm source-normalized candidate U_0, the Suzuki matrix and both normalization rows are explicit. The actual optimizer criterion is the scalar edge bound (17), with allowances (18). The actual theta sources give strict full-span failure by (23), while the optimizer-only question remains open. The missing information for that question is an upper enclosure for $n[v_U]$.

The certified Suzuki interval data do not supply those theta edge estimates. Absent an intertwiner, interval positivity cannot replace them.

[ThetaMinimumMapConstant.lean](BuildingBlocks/ThetaMinimumMapConstant.lean) proves the exact interval constant satisfies $0<k_0<1$ and both paid allowances are positive. The matrix identities and theta edge estimates remain written analysis.
