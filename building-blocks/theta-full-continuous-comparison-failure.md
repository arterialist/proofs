# The entire continuous covariance comparison fails on the actual score

This is a written proof for the actual theta form, with no Lean claim. It uses the [complete ground covariance clock](theta-complete-ground-covariance-clock.md), its [weighted source domain](theta-groundstate-bounded-weighted-crossing.md), and the original [theta Weil form and score identities](theta-weil-jump-form.md). The method uses classical closed-form comparison, scalar optimization and the indicated exact theta/arithmetic identities; no priority claim is made.

The failed lower comparison is a sufficient test, not the exact constrained form. The [true affine score calibration](theta-true-affine-odd-score-calibration.md) retains the complete Green covariances. The [full continuous-only failure](theta-full-continuous-comparison-failure.md) is stronger than failure of a same-half-line minorant.

Retaining the complete continuous residual, including all its cross-halfline edges, does not repair the failing two-halfline lower comparison. At the actual core $[-2,2]$, its full affine lower bound is still less than $-1/10$ on the actual odd score. The proof preserves the full arithmetic source, ground state, and sign commutator. Only the comparison conductance omits the primes. No negative value of the exact constrained form is inferred.

Use $\lambda=1/2$, $C_R=[-R,R]$, $O_R=\mathbb R\setminus C_R$, and the actual full killed ground state $D_R\psi_R=\alpha_R\psi_R$. Put
$$
\rho=e^{-|u|/2}/[2\cosh(u/2)],\quad
\gamma=\rho\psi_R\nu,\quad a=\gamma(O_R),\quad
\varepsilon=\operatorname{sgn}(u).
$$
The ground state and $\gamma$ are even. Each exterior halfline has mass $a/2$. The original source and score remain
$$
\sigma=\Phi'/\Phi,\quad x_R=\sigma1_{C_R},\quad
f_R=B_Rx_R,\quad q_R=\tau1_{O_R},\quad
m_R=\langle x_R,\tau\rangle_\nu<0,
$$
$$
\mathcal B_R=E_{C_R}[x_R]-\alpha_R\|x_R\|_\nu^2,
\quad S=f_R/\rho,\quad Q=q_R/\rho.
\tag{1}
$$
Both sources are centered under $\gamma$; the ground overlap of $B_Rx_R$ vanishes by oddness. All pairings in the following score calculation are real.

## 1. The full continuous comparison and its maximal domain

Let $J_c^\psi$ be the entire continuous ground-state conductance. Its density is
$$
\psi_R(u)\psi_R(v)\Phi(u)\Phi(v)
 \frac{e^{-|u-v|/2}}{1-e^{-2|u-v|}}\,du\,dv.
$$
It dominates $\gamma\otimes\gamma$. Set
$$
J_{c,{\rm rem}}=J_c^\psi-\gamma\otimes\gamma\ge0,
\quad E_{c,{\rm rem}}(H)=\tfrac12\int|\Delta H|^2J_{c,{\rm rem}},
$$
$$
V_c=\{H\in L^2(\gamma):E_{c,{\rm rem}}(H)<\infty\}.
\tag{2}
$$
This is a closed densely defined maximal Markov form. The proof is the same direct closed-difference argument as for the complete residual clock: the edge measure is sigma-finite off the diagonal and does not charge either coordinate over a $\gamma$-null set. Smooth compact functions have finite energy because $\psi_R$ is bounded and the squared increment removes the diagonal singularity; they are dense in $L^2(\gamma)$. Constants have zero energy. Let $A_c\ge0$ be its generator.

The potential form for the resolvent $(a+A_c)^{-1}$ is
$$
\mathcal K_c(H)=a\|H\|_\gamma^2+E_{c,{\rm rem}}(H).
\tag{3}
$$
On centered potentials it equals the full continuous ground-state energy $E_c^\psi(H)$, since the removed rank energy is exactly $a\|H\|_\gamma^2$. It is not the energy of the original full ground-state process, whose prime conductance remains additional and nonnegative.

The exact complete-domain covariance identity and form order give
$$
\mathcal C(f,f)\le U_c(f,f):=
 \langle(a+A_c)^{-1}(f/\rho),f/\rho\rangle_\gamma.
\tag{4}
$$
The actual sources in (1) satisfy the weighted condition by the bounded weighted crossing theorem. No source or ground-state equation has been replaced by its continuous-only counterpart.

Define the exact affine comparison cost
$$
\operatorname{Cost}_{U_c}(f,m)
=\min_{c\in\mathbb R}
 \{U_c(f-cq,f-cq)-2cm\}.
\tag{5}
$$
Its constrained-potential variational form is
$$
\operatorname{Cost}_{U_c}(f,m)
=\sup_{\substack{H\in V_c,\ \gamma H=0\\
                         \langle H,q/\rho\rangle_\gamma=-m}}
       \{2\langle f/\rho,H\rangle_\gamma-\mathcal K_c(H)\}.
\tag{6}
$$
For completeness, the optimizer of (5) is
$c_*=(U_c(f,q)+m)/U_c(q,q)$. Its potential
$H_*=(a+A_c)^{-1}[(f-c_*q)/\rho]$ is centered and satisfies the displayed constraint. For any other feasible $H$, completion of the $\mathcal K_c$ square about $H_*$ proves (6). Thus there is no unjustified interchange of an infimum and supremum. Complex sources have the same formula with real parts and the constraint $\langle H,q/\rho\rangle=-m$ when pairings are linear in the first variable.

## 2. The sign potential pays only a bounded continuous energy

Write
$$
b_q=a^{-1}\langle q_R,\psi_R\varepsilon\rangle_\nu>0,
\quad l_f=a^{-1}\langle f_R,\psi_R\varepsilon\rangle_\nu,
\quad r_R=l_f/b_q.
\tag{7}
$$
The exact identity $q_R/\rho=\varepsilon(e^{|u|}-1)$ gives $b_q>e^R-1$.

For opposite halfline endpoints, the ratio of the full continuous measure to the product measure is
$$
\frac{J_c^\psi(du,dv)}{d\gamma(u)d\gamma(v)}
=\frac1{1-e^{-2(|u|+|v|)}}
\le\frac1{1-e^{-4R}}.
$$
With the directed-edge convention, the sign energy is exactly
$$
\boxed{\quad
E_c^\psi(\varepsilon)=4J_c^\psi(O_+,O_-)
 \le\frac{a^2}{1-e^{-4R}}.
\quad}
\tag{8}
$$
Indeed the difference is squared to four on both orientations, and the energy has its factor $1/2$. Both halfline masses are $a/2$. This also proves directly that $\varepsilon\in V_c$; its residual energy is the finite value $E_c^\psi(\varepsilon)-a^2$.

The centered potential
$$
H=-\frac{m_R}{ab_q}\varepsilon
$$
satisfies $\langle H,Q\rangle_\gamma=-m_R$. Inserting it into (6), using (3) and (8), proves
$$
\boxed{\quad
\operatorname{Cost}_{U_c}(f_R,m_R)
 \ge-2m_Rr_R-
     \frac{m_R^2}{b_q^2(1-e^{-4R})}.
\quad}
\tag{9}
$$
The factor $a$ cancels exactly. Even the entire continuous residual cannot give this particular affine sign potential energy larger than the last displayed scale.

## 3. The full arithmetic commutator and the explicit radius two

The inputs below were proved with complete theta and prime-power bounds in [theta-two-halfline-odd-score-failure.md](theta-two-halfline-odd-score-failure.md) and [theta-two-halfline-failure-at-radius-two.md](theta-two-halfline-failure-at-radius-two.md). In particular, the ratio $r_R$ comes from the FULL exterior equation
$$
B_Rx_R=(D_R-\lambda)(\sigma1_{O_R})+\frac\lambda2q_R
$$
and the full opposite-half arrival operator $K_\times$, including every prime power:
$$
r_R=\frac\lambda2+
 (\lambda-\alpha_R)
 \frac{\langle|\sigma|,\psi_R\rangle}
      {\langle|q_R|,\psi_R\rangle}
 -2\frac{\langle K_\times(|\sigma|1_{O_R}),\psi_R\rangle}
          {\langle|q_R|,\psi_R\rangle}.
\tag{10}
$$
Its middle term is nonnegative. The complete theta-derivative tail and elementary full Chebyshev bound control the last term uniformly, without an assumption about ground-state concentration.

At $R=2$, those analytic estimates give
$$
\mathcal B_2<\frac18+2\cdot10^{-14},\qquad
-\frac12\le m_2\le-\frac12+10^{-40},
$$
$$
r_2\ge\frac14-4\cdot10^{-40},\qquad
b_q>6,\qquad (1-e^{-8})^{-1}<2.
\tag{11}
$$
These are the already proved elementary tail bounds, not numerical values inferred for $\psi_2$. Combining (9)–(11) gives
$$
\begin{split}
\mathcal B_2-\operatorname{Cost}_{U_c}(f_2,m_2)
&\le\mathcal B_2+2m_2r_2+
                   \frac{m_2^2}{b_q^2(1-e^{-8})}\\
&<-\frac18+\frac1{72}+3\cdot10^{-14}
 =-\frac19+3\cdot10^{-14}<-\frac1{10}.
\end{split}
$$
Thus
$$
\boxed{\quad
\mathcal B_2-\operatorname{Cost}_{U_c}(f_2,m_2)<-1/10.
\quad}
\tag{12}
$$
The comparison has kept all same-halfline and cross-halfline continuous conductance. It fails on the actual nonconstant odd score, with its actual nonzero affine constraint. This is a stronger failure than that of the two-halfline minorant, and still does not assert negativity of $F_{\alpha_2}[x_2]$.

## 4. Necessary sign-energy scale for a successful retained-conductance comparison

More generally let a comparison use a nonnegative residual conductance minorant of the full $J_{\rm rem}$, with generator $A_*$, and potential form
$$
\mathcal K_*(H)=a\|H\|_\gamma^2+E_*(H).
$$
Suppose its sign energy is $\mathcal K_*(\varepsilon)=a^2J_R$. Every retained-conductance minorant considered here has finite sign energy. The same feasible potential proves
$$
\operatorname{Cost}_{U_*}(f_R,m_R)
 \ge-2m_Rr_R-J_Rm_R^2/b_q^2.
$$
Therefore passing this lower comparison on the actual score, meaning
$\mathcal B_R-\operatorname{Cost}_{U_*}(f_R,m_R)\ge0$, requires
$$
\boxed{\quad
J_R\frac{m_R^2}{b_q^2}
 \ge 2(-m_R)r_R-\mathcal B_R.
\quad}
\tag{13}
$$
This is necessary, not sufficient. The established large-core facts are
$m_R\to-1/2$, $\liminf r_R\ge1/4$, and
$\limsup\mathcal B_R\le1/8$. Consequently any sequence of successful comparisons with $R\to\infty$ must satisfy
$$
\boxed{\quad
\liminf\frac{J_R}{b_q^2}\ge\frac12,
\qquad b_q>e^R-1.
\quad}
\tag{14}
$$
At radius two, (11) already requires
$J_2/b_q^2\ge1/2-10^{-12}$. The continuous-only value is at most two and cannot meet this requirement, since $b_q^2>36$.

For a comparison retaining a continuous submeasure of the full continuous residual and some actual prime conductance $J_{p,*}^{\psi}$, its sign energy has the upper bound
$$
J_R\le(1-e^{-4R})^{-1}
       +\frac4{a^2}J_{p,*}^{\psi}(O_+,O_-).
$$
Thus (14) forces the retained prime crossings to supply the asymptotic scale
$$
\boxed{\quad
\liminf_{R\to\infty}
 \frac{4J_{p,*}^{\psi}(O_+,O_-)}{a^2b_q^2}\ge\frac12
\quad}
\tag{15}
$$
along any such successful sequence. Same-halfline prime edges do not contribute to the sign energy. Formula (15) identifies a necessary aggregate cross-halfline prime response; it does not say each individual prime is indispensable, or prove that the complete prime response is sufficient to make the signed core form positive.

The positive centered gap obtainable from the continuous residual is consistent with this failure. A positive gap alone does not guarantee enough energy at the actual affine sign potential. The unresolved comparison must consume the retained arithmetic crossing response rather than infer the desired full sign from continuous coercivity alone.
