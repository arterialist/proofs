# Upper bounding the actual optimizer residual: the remaining prime-profile norm

The minimum source-normalized Suzuki map pays the actual optimizer residual if

\[
n[v_U]\le0.46511165192687\ldots
\tag{1+}
\]

for the plus sign, or

\[
n[v_U]\le0.03488834807312\ldots
\tag{1-}
\]

for the minus sign. This note assembles the strongest direct analytic upper bound supplied by the existing full-form-domain proof. It preserves the exact affine coefficient, the common score subtraction, every prime-power edge and both crossing covariances.

The resulting ceiling is finite but not numerical. One form norm, the complete prime cross-profile energy, is proved finite only through an absolutely convergent series with unspecified ground-tail constants. Neither threshold can currently be certified.

## Exact residual before estimation

Write

\[
w=\delta g_y-t_{\rm score}g_q,
\qquad g_y=M^{-1}S_y,\qquad g_q=M^{-1}S_q,
\]
\[
t_{\rm score}=\frac{1/2+\delta U(y,q)}{U(q,q)}.
\tag{2}
\]

The score match gives n[v_U]=n[w]. With the common score projection P,

\[
\boxed{\quad
n[w]=R_c[Pw]+R_p[Pw].
\quad}
\tag{3}
\]

Expanded without dropping any term,

\[
R_i[Pw]=\operatorname{Same}_i[Pw]
+m_i\operatorname{Var}_{\pi_i}(\Delta_\times Pw),
\qquad i=c,p.
\tag{4}
\]

The prime same-half part is

\[
\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
\int_{\substack{u,u+\log n\in O\\\text{same half}}}
\psi(u)\psi(u+\log n)\Phi(u)\Phi(u+\log n)
|\Delta_nPw(u)|^2du.
\tag{5}
\]

The prime crossing variance uses the full measure

\[
\sum_{\log n>2R}\frac{\Lambda(n)}{\sqrt n}
\int_R^{\log n-R}
\psi(u)\psi(u-\log n)\Phi(u)\Phi(u-\log n)
\left|\Delta_\times Pw-\mathbb E_{\pi_p}\Delta_\times Pw\right|^2du.
\tag{6}
\]

Equations (3)-(6) are the exact quantity to compare with (1+)-(1-).

## First rigorous upper relaxation

Since centering decreases a second moment and P minimizes the common residual,

\[
n[w]\le R_c[w]+R_p[w]\le A_c[w]+A_p[w]\le k[w].
\tag{7}
\]

This does not delete any prime power. The final k-energy contains the full continuous and prime conductance. It does lose the favorable separate crossing means and the common score square, so it is only an upper bound.

Thus either Suzuki threshold would follow from

\[
k[M^{-1}(\delta S_y-t_{\rm score}S_q)]
\le \frac{1+\sigma k_0}{4}.
\tag{8}
\]

The exact coefficient t_score must be inserted before evaluating the energy.

## Finite Woodbury reduction

The comparison operator has the form

\[
M=K_0+WD^{-1}W^*,
\tag{9}
\]

where the columns of W are the actual finite profiles w_c,w_p,v_* and any zero-score column is omitted. D is the diagonal matrix of their actual normalizing denominators. Put

\[
Z=K_0^{-1}W,
\qquad C=D+W^*K_0^{-1}W.
\tag{10}
\]

The Woodbury identity gives, for

\[
s=\delta S_y-t_{\rm score}S_q,
\qquad z_s=K_0^{-1}s,
\qquad b_s=W^*z_s,
\]

\[
w=z_s-ZC^{-1}b_s.
\tag{11}
\]

Every vector in (11) belongs to the full k-form domain by the established regularity theorem. Define the complete k-energy Gram data

\[
E_{00}=k[z_s],
\qquad E_{0\alpha}=k(z_s,Z_\alpha),
\qquad E_{\alpha\beta}=k(Z_\beta,Z_\alpha).
\tag{12}
\]

Then the upper ceiling in (7) is the explicit finite quadratic expression

\[
\boxed{\quad
k[w]=E_{00}-2\operatorname{Re}
\left(b_s^*C^{-*}E_0\right)
+b_s^*C^{-*}E C^{-1}b_s.
\quad}
\tag{13}
\]

Formula (13) retains all mixed terms. Applying absolute values before assembling it would discard the only possible cancellation in the finite-rank inverse.

The optimizer certificate is now a finite statement: evaluate (13), or the sharper edge expression (3), and compare it with (1+)-(1-).

## What the full-form proof actually bounds

The proof of full-form membership controls the prime profile through

\[
\Phi w_p1_{u>R}
=2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
1_{u>R}m(u)g_-(u-\log n),
\tag{14}
\]

where m(u)=Φ(u)e^{u/2} and g_-=Φψ1_{u<-R}. For large n it proves

\[
\|1_{u>R}m(u)g_-(u-\log n)\|_{\mathcal H}
\le C_{R,\psi}e^{-c_3n}.
\tag{15}
\]

Consequently

\[
\|\Phi w_p\|_{\mathcal H}
\le 2\sum_{n<N_0}\frac{\Lambda(n)}{\sqrt n}L_n
+2C_{R,\psi}\sum_{n\ge N_0}\frac{\Lambda(n)}{\sqrt n}e^{-c_3n},
\tag{16}
\]

where

\[
L_n=\|1_{u>R}m(u)g_-(u-\log n)\|_{\mathcal H}.
\]

The physical form equivalence then gives

\[
E(w_p)\le C'_\theta
\left(\|\Phi w_p\|_{\mathcal H}^2+|w_p\|_\nu^2\right),
\tag{17}
\]

with

\[
\|w_p\|_\nu^2
\le4P_\infty^2B_p^2\int_O\rho^{-2}d\nu.
\tag{18}
\]

Equations (16)-(18) are rigorous symbolic bounds. They retain every prime power through the finite head and exponential tail. They are not numerical because the proof supplies no evaluated upper bounds for C'_θ, C_{R,ψ}, c_3, N_0 or the finite list L_n.

Those quantities enter the profile column Z_p and therefore several entries of E in (13), including E_pp and its mixed rows. The prime part of the compact score-crossing source S_f is controlled by a second guarded arrival series of the same kind. Its constants are also unevaluated, but it enters later through the matched profile v_*; it does not remove the direct w_p obstruction.

## The single blocking term

The first unevaluated form quantity in the chain is

\[
\boxed{\quad E(w_p),\quad\text{equivalently the right side of (16)-(18).}\quad}
\tag{19}
\]

It is the single blocking term in the following precise sense. All other steps in (7), (11), and (13) are finite algebra once the k-Gram entries of the listed source/profile vectors are supplied. The direct prime column is the first column whose form membership is obtained by the infinite arrival series (14). Its proof gives convergence but no explicit numerical ceiling. The prime part of S_f creates another unevaluated series in the matched column, so evaluating (19) is necessary but may not be sufficient. Therefore the present estimates cannot produce a numerical value for (13), much less compare it with 0.4652 or 0.0349.

This does not prove that the prime term is the largest actual contribution. No numerical ordering of the continuous same-half energy, prime same-half energy and two variances has been established. It says that E(w_p) is the first and largest unresolved item in the available upper-bound bookkeeping: its current stated ceiling is unevaluated.

The strengthening needed is an evaluated version of

\[
2\sum_{n<N_0}\frac{\Lambda(n)}{\sqrt n}L_n
+2C_{R,\psi}\sum_{n\ge N_0}\frac{\Lambda(n)}{\sqrt n}e^{-c_3n}
\le B_{p,\mathcal H}
\tag{20}
\]

with explicit C'_θ and L² term, propagated through the exact Gram expression (13). For the plus candidate the final propagated bound must be below 0.46511165192687.... For the minus candidate it must be below 0.03488834807312.... Bounding E(w_p) alone below these numbers is sufficient only if all remaining Gram contributions and inverse coefficients are included; it cannot be compared in isolation.

## Why the small coherent source estimate does not close the bound

The known estimate involving

\[
U(f,f)<10^{-36}(P_\infty/a)
\]

belongs to a covariance/source ceiling. The route also carries an unevaluated normalization factor whose available lower estimate exceeds 8·10^11. A lower estimate on a cost is not an upper estimate on the product, so it cannot certify either threshold in (1+)-(1-). Treating 8·10^11 as the cost itself would reverse the logical direction.

Likewise the small score energy cannot multiply (3). The exact score relation removes φ from n; it does not make the remaining w energy small. The coefficient t_score contains the actual denominator U(q,q), which must stay in (2).

## Comparison with the thresholds

The current rigorous conclusion is

\[
0\le n[v_U]\le k[w]<\infty.
\tag{21}
\]

There is no numerical upper endpoint in (21). Therefore neither

\[
n[v_U]\le0.46511165192688
\]

nor

\[
n[v_U]\le0.03488834807313
\]

follows from the present full-form estimates.

A passing calculation should evaluate the sharper expression (3)-(6), not merely (13), because the common score square and both crossing means can materially reduce the energy. The minimum acceptable new input is an explicit complete-prime profile bound (20). The decisive calculation would evaluate all four centered edge terms at the exact w in (2), preserving their cancellation before comparison with the Suzuki allowance.

No theta-to-Suzuki intertwiner is inferred here. This note only compares the actual theta residual with the allowance of the named optimizer-span map.


This is written analysis. The Woodbury energy Gram and the complete prime-profile norm remain Lean formalization obligations.
