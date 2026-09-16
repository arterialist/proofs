# Conditional edge energy at the actual affine comparison optimizer

The exact optimizer identity in [score matched affine gap](theta-score-matched-affine-gap.md), equations (12)--(17), is valid. Its upper bound requires the additional full-form membership of the comparison optimizer. This note evaluates that upper bound using the complete continuous and prime edges, with both cross-edge means removed before estimating anything.

Write
$$
K=K_0+A_c+A_p,\qquad
M_0=K_{\rm cp},\qquad M=\widehat M,
$$
where $M$ is the bounded component comparison followed by the score-action match. Let $m_M$ be its form and $n=k-m_M$ on $V_k$. As before,
$$
f=B\sigma_C,\quad y=\sigma_O,\quad q=\tau_O,\quad
r=f+\delta y-\tfrac14q,\quad \varphi=y/\psi,\quad
m=\langle\sigma_C,\tau_C\rangle_\nu.
$$
Use the actual affine coefficient and potential
$$
t=\frac{U(f,q)+m}{U(q,q)},\qquad
v_U=M^{-1}(S_f-tS_q),\qquad U(g,h)=\langle M^{-1}S_g,S_h\rangle_\gamma.
\tag{1}
$$
The proof in [prime profile full form domain](theta-prime-profile-full-form-domain.md) establishes $w_p\in V_k$ and the required membership $v_U\in V_k$ for this actual bounded-model trial. Thus (7) below is applicable to the actual affine optimizer. The formulas hold for every $v\in V_k$, and require no lower bound on $\psi$.

## The two exact conditional edge forms

Let $J_p=J_p^\psi$ be the full directed prime conductance. Let
$$
J_c=J_{c}^{\psi}
-\gamma\otimes\gamma
-h\,1_{\{\text{same half}\}}\gamma\otimes\gamma,\qquad h=e^R-1.
$$
The actual continuous kernel minorants make $J_c$ nonnegative. These are precisely the conductances of $A_c,A_p$ in the component comparison. Put
$$
d_c=A_c[\varepsilon],\quad d_p=p=A_p[\varepsilon],
\qquad m_i=J_i(O_+,O_-)=d_i/4>0,\qquad
\pi_i=J_i|_{O_+\times O_-}/m_i .
$$
Here $\varepsilon=\operatorname{sgn}$, and the cross rectangle is counted in one orientation. For a potential $v$, define
$$
\Delta_\times v(u,w)=v(u)-v(w),\quad u>R,\ w<-R,
$$
$$
\operatorname{Same}_i[v]
=\tfrac12\int_{\text{same half}}|v(u)-v(w)|^2J_i(du,dw).
$$
Symmetry, followed by one scalar completion, gives
$$
A_i[v]=\operatorname{Same}_i[v]+m_i\,\mathbb E_{\pi_i}|\Delta_\times v|^2,
\qquad
A_i(v,\varepsilon)=2m_i\,\mathbb E_{\pi_i}\Delta_\times v,
$$
$$
\boxed{\quad
R_i[v]:=A_i[v]-\frac{|A_i(v,\varepsilon)|^2}{d_i}
=\operatorname{Same}_i[v]+m_i\operatorname{Var}_{\pi_i}(\Delta_\times v).
\quad}
\tag{2}
$$
The minimizer of $A_i[v-c_i\varepsilon]$ is
$c_i=\tfrac12\mathbb E_{\pi_i}\Delta_\times v$.
Thus the subtraction is the entire component's cross-edge mean. It neither deletes the same-half edges nor replaces their energy by an absolute-value bound.

For clarity, the actual prime cross measure in (2) is
$$
m_p=\sum_{\log n>2R}\frac{\Lambda(n)}{\sqrt n}
\int_R^{\log n-R}
 \psi(u)\psi(u-\log n)\Phi(u)\Phi(u-\log n)\,du,
\tag{3}
$$
and its expectations insert $\Delta_\times v(u,u-\log n)$ into this integral and divide by $m_p$. All prime powers are present. The prime same-half form is
$$
\operatorname{Same}_p[v]
=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
\int_{\substack{u,u+\log n\in O\\
                 u,\ u+\log n\text{ in the same half}}}
 \psi(u)\psi(u+\log n)\Phi(u)\Phi(u+\log n)
 |v(u+\log n)-v(u)|^2\,du .
\tag{4}
$$
There is no factor $1/2$ in (3) or (4), since the other orientation supplies the second half of the directed energy. The cross measures have finite mass; the continuous same-half measure can have infinite activity. Formula (2) is justified by finite energy, not finite continuous jump rate.

## Joint minimization and explicit coefficients

Let $R_0=R_c+R_p$, with its polarized form denoted by the same symbol, and put
$$
d_y=R_0[\varphi]\ge0,\qquad
v_{\rm act}=K\varphi-M_0\varphi=S_r-M_0\varphi\in L^2(\gamma).
$$
Since $M_0$ is bounded and $\varphi\in D(K)$,
$$
R_0(v,\varphi)=\langle v,v_{\rm act}\rangle_\gamma,
\qquad v\in V_k.
$$
The score-action match yields, for $d_y>0$,
$$
\boxed{\quad
n[v]=R_0[v]-\frac{|\langle v,v_{\rm act}\rangle|^2}{d_y}
=\min_s\{R_c[v-s\varphi]+R_p[v-s\varphi]\}.
\quad}
\tag{5}
$$
The minimizing coefficient and the two cross-mean coefficients are
$$
s_*=\frac{\langle v,v_{\rm act}\rangle}{d_y},\qquad
c_{i,*}=\frac{\langle v,w_i\rangle-s_*\langle\varphi,w_i\rangle}{d_i}
=\tfrac12\mathbb E_{\pi_i}\Delta_\times(v-s_*\varphi).
\tag{6}
$$
If $d_y=0$, residual-form Cauchy--Schwarz makes the numerator zero for every $v\in V_k$. Then $n=R_0$, and the coefficient $s$ has no effect.

Combining (2) and (5) gives the exact upper estimator at (1):
$$
\boxed{\quad
0\le F_{\rm true}-F_U\le n[v_U]
=\min_s\sum_{i=c,p}
 \left\{\operatorname{Same}_i[v_U-s\varphi]
 +m_i\operatorname{Var}_{\pi_i}
       (\Delta_\times v_U-s\Delta_\times\varphi)\right\}.
\quad}
\tag{7}
$$
Equations (1), (3), (4), and (6) specify its coefficient and its actual edge integrals. The common $s$ is optimized jointly across the two components; their $c_i$ are separate. Optimizing each component over a separate score coefficient instead would generally produce a smaller expression and would not be a valid replacement for (7).

For another direct evaluation, define
$$
b_0=A_c(v,\varphi)+A_p(v,\varphi)
 =\langle v,S_r-K_0\varphi\rangle,\qquad
b_i=\langle v,w_i\rangle,\qquad
g_i=\langle\varphi,w_i\rangle.
$$
Then the numerator in (5) is
$b_0-b_c\overline{g_c}/d_c-b_p\overline{g_p}/p$, and
$$
R_0[v]=A_c[v]+A_p[v]-|b_c|^2/d_c-|b_p|^2/p,
$$
$$
d_y=A_c[\varphi]+A_p[\varphi]-|g_c|^2/d_c-|g_p|^2/p.
\tag{8}
$$
This keeps all cancellations. The scalar pairings in (8) are ordinary $L^2(\gamma)$ pairings against known actions. The remaining quantities $A_i[v]$ are the actual edge integrals; no action of $K$ on $w_p$ is required.

## The score relation removes its full residual contribution

The known score match gives $M^{-1}S_r=\varphi$. Substituting the actual affine coefficient before estimation yields
$$
v_U=\varphi-M^{-1}(\delta S_y-t_{\rm score}S_q),
\qquad
t_{\rm score}=\tfrac14-t
=\frac{1/2+\delta U(y,q)}{U(q,q)}.
\tag{9}
$$
Since $n(\varphi,\cdot)=0$,
$$
n[v_U]=n\!\left[M^{-1}(\delta S_y-t_{\rm score}S_q)\right].
\tag{10}
$$
Thus the very small energy $k[\varphi]=\mathcal E_y$ makes no additional contribution to (7). In particular, its bound cannot be multiplied into the remaining conditional edge variance. Although $d_y\le\mathcal E_y$, the coefficient $s_*$ in (6) contains $d_y^{-1}$. Residual-form Cauchy--Schwarz gives only
$|\langle v,v_{\rm act}\rangle|^2/d_y\le R_0[v]$.

The available weighted crossing estimate controls
$\|\rho^{-1/2}B_2\|$ and an $L^2(\gamma)$ source norm. The comparison inverse is bounded on $L^2(\gamma)$, but $A_c+A_p$ is an unbounded energy form. Those estimates supply no upper bound on the same-half increments or the cross variances in (7). Full-form membership proves these integrals finite; it does not make them small. The stated numerical route
$U(f,f)<10^{-36}(P_\infty/a)$ at $R=2$ also has an unevaluated normalization cost which the existing bounds make larger than $8\cdot10^{11}$. That is a limitation of this particular upper ceiling, not a lower bound on the actual covariance or on (7).

A usable new estimate would bound the complete conditional expression in (7), evaluated at (1), or the corresponding joint energy entries in (8). The present inputs do not certify a small value at $R=2$ or a vanishing value as $R$ grows. They do provide the exact estimator with the actual affine constraint, both cross-mean cancellations, the matched score action, and every continuous and prime-power edge retained.

## The exact common-score nullspace

The residual has no additional invisible direction. For $u,v$ on opposite exterior halves, the continuous density of $J_c$ divided by $\psi(u)\psi(v)\Phi(u)\Phi(v)e^{-(|u|+|v|)/2}$ is
$$
\frac1{1-e^{-2(|u|+|v|)}}-1>0.
$$
For distinct $u,v$ on the same half, that ratio is
$$
\frac{e^{\min(|u|,|v|)}}{1-e^{-2|u-v|}}-e^R>0,
$$
because $\min(|u|,|v|)>R$. Thus $J_c$ is strictly positive almost everywhere off the diagonal on $O\times O$, with both half-lines connected. Since $\gamma$ is equivalent to Lebesgue measure on $O$, $A_c[F]=0$ for an admissible real potential forces $F$ to be constant almost everywhere.

The minimum over the common score coefficient in (5) is attained when $d_y>0$; when $d_y=0$, residual Cauchy--Schwarz makes its value independent of that coefficient. The separate sign minima in (2) are attained as well. Hence (7) and the strict continuous kernel give
$$
\boxed{\quad
n[v]=0\quad\Longleftrightarrow\quad
v=a+b\varepsilon+s\varphi\quad\gamma\text{-almost everywhere}
\quad(v\in V_k\text{ real}),
\quad}
\tag{11}
$$
for real scalars $a,b,s$. The reverse implication uses only that every $A_i$ kills constants and that the same $s$ and sign coefficient $b$ can be chosen in both component forms. On the odd centered sector the constant vanishes, so $\ker n=\operatorname{span}\{\varepsilon,\varphi\}$ there. This keeps the complete prime form in the residual; strictness needs only the continuous component.

For the [minimum-norm Suzuki map](theta-minimal-source-normalized-optimizer-map.md), write $u=U(q,q)$ and $r_y=U(y,q)$ as there. Its full-span witness has the exact test
$$
n[ug_y-r_yg_q]>0
\quad\Longleftrightarrow\quad
ug_y-r_yg_q\notin\operatorname{span}\{\varepsilon,\varphi\}.
\tag{12}
$$
The [actual-source boundary and tail proof](theta-minimal-source-normalized-optimizer-map.md#strict-full-span-failure-for-the-actual-theta-sources) decides this membership: the crossing source has a nonzero logarithmic boundary singularity, while the score source grows faster than the matched sign action at infinity. Thus (12) is strict for the actual sources. It excludes that rank-one full-span map but does not evaluate the distinguished affine optimizer or prove RH.

## Attribution and formal scope

The closed-form representation theorem, ground-state transform, Carleman bound, nonnegative-form Cauchy–Schwarz and affine variational identities used here are classical. The proofs retain the actual ground state and every continuous and prime-power edge. These are written mathematical results, with no Lean claim for the full-form comparison or the remaining arithmetic smallness.

The exact common-score square completion, zero-score-energy pairing, positive bilinear score remainder and separate-optimization disagreement penalty are now compiled in [ConditionalScoreQuadratic](BuildingBlocks/ConditionalScoreQuadratic.lean), with [their precise scope and actual form map](theta-common-score-separate-optimization-penalty.md). This certifies the general form algebra behind (5). Identification of the actual closed edge forms, their complete domains and the upper estimator remains written mathematics; the quantitative residual smallness remains unproved.
