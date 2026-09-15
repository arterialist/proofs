# Exact cost of separate score optimization

Written and formalized by RH Agent2, independently reviewed against the
actual conditional-edge consumer by RH Proof on 16 September 2026. The
additional common-domain bilinear sum identity was formalized by RH Proof.
These are exact form-algebra prerequisites, not an arithmetic smallness estimate.

This supplements [the actual conditional-edge estimator](theta-affine-comparison-conditional-edge-energy.md), equations (2), (5), and (7). Work on the real odd potential space with the actual nonnegative conditional forms \(R_c,R_p\). Each retains its continuous or complete prime-power same-half energy and its own cross-edge variance. The affine potential remains \(v=v_U\), with the coefficient fixed by the full affine constraint.

Define, for \(i=c,p\),
\[
e_i=R_i[v],\qquad b_i=R_i(v,\varphi),\qquad d_i=R_i[\varphi].
\]
These are finite by the established full form-domain results. Polarization gives
\[
R_i[v-s\varphi]=e_i-2sb_i+s^2d_i.
\]
For \(d=d_c+d_p>0\), the actual residual is therefore
\[
n[v]=e_c+e_p-\frac{(b_c+b_p)^2}{d},\qquad
s_*=(b_c+b_p)/d.
\tag{1}
\]
This follows by completing the square in the shared coefficient, with remainder \(d(s-s_*)^2\). It neither changes the two separately centered cross measures nor permits separate score coefficients.

If both \(d_c,d_p>0\), define the separately optimized value
\[
L_{\rm sep}=e_c-b_c^2/d_c+e_p-b_p^2/d_p.
\]
The discrepancy is exactly
\[
\boxed{\quad
n[v]-L_{\rm sep}
=\frac{d_cd_p}{d_c+d_p}
\left(\frac{b_c}{d_c}-\frac{b_p}{d_p}\right)^2\ge0.
\quad}
\tag{2}
\]
Thus separate optimization loses the disagreement between the continuous and prime preferred score coefficients. Equation (2) is an identity, not an upper bound on that loss. A small separately optimized value alone does not certify a small actual residual.

The zero-energy cases need no undefined coefficient. If \(d_i=0\), positivity of \(R_i[v-s\varphi]\) for every real \(s\) forces \(b_i=0\): otherwise \(s=(e_i+1)/(2b_i)\) makes the quadratic equal \(-1\). That component contributes the constant \(e_i\). If both \(d_i=0\), both pairings vanish and the score has no effect. If exactly one is positive, (1) uses that component's coefficient and the other's constant contribution.

The scalar square completion, minimum, attained optimizer, separate penalty and its inequality, and zero-energy implication are proved in
[ConditionalScoreQuadratic](BuildingBlocks/ConditionalScoreQuadratic.lean).

The file also constructs the bilinear score-rank remainder for any real bilinear form \(B\) on a real vector space:
\[
B_\varphi(x,y)=B(x,y)-\frac{B(x,\varphi)B(\varphi,y)}{B(\varphi,\varphi)}.
\tag{3}
\]
For symmetric nonnegative \(B\) with \(B(\varphi,\varphi)>0\), Lean proves \(B_\varphi(v,v)\ge0\) and \(B_\varphi(\varphi,v)=0\). The proof evaluates the nonnegative form at \(v-[B(v,\varphi)/B(\varphi,\varphi)]\varphi\), using the proved displacement and attained-square identities. If the score energy is zero, Lean instead proves \(B(v,\varphi)=0\) from form positivity. These results apply on a vector space such as a form domain; no bounded operator is required.

For the actual covariance chain, take \(B=R_c+R_p\) on its common full form domain. Equation (3) is then the score-matched residual \(n\), by the existing actual score-action identity. This identification with the actual closed forms and their complete prime-power integrals remains written mathematics. No analytic operator, arithmetic bound, or RH conclusion is assumed or formalized by these general algebraic declarations. All sixteen printed declarations, including the bilinear construction and common-domain sum identity, compile with only `propext`, `Classical.choice`, and `Quot.sound`.

The unresolved estimate is still a quantitative bound on (1), or on the complete conditional edge expression at the actual affine optimizer. Equation (2) specifies an additional cost that any separate-component approach must pay. It does not establish smallness at radius two or as the core grows.

The common-domain sum identity `joint_form_penalty` additionally proves (2) directly for symmetric bilinear forms Bc and Bp: the score remainder of Bc+Bp is the sum of their separate score remainders plus the displayed disagreement penalty. It retains the individual and joint nonzero-denominator hypotheses. Under positive individual score energies, the scalar nonnegativity theorem applies. This is a direct form-algebra statement, with no analytic edge-identification premise hidden in its proof.
