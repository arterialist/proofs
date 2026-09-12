# The two-halfline lower comparison fails on the actual odd score at large cores

This is a written proof for the actual theta form, with no Lean claim. It uses the [complete ground covariance clock](theta-complete-ground-covariance-clock.md), its [weighted source domain](theta-groundstate-bounded-weighted-crossing.md), and the original [theta Weil form and score identities](theta-weil-jump-form.md). The method uses classical closed-form comparison, scalar optimization and the indicated exact theta/arithmetic identities; no priority claim is made.

The failed lower comparison is a sufficient test, not the exact constrained form. The [true affine score calibration](theta-true-affine-odd-score-calibration.md) retains the complete Green covariances. The [full continuous-only failure](theta-full-continuous-comparison-failure.md) is stronger than failure of a same-half-line minorant.

Let $\lambda=1/2$, $C_R=[-R,R]$, $O_R=\mathbb R\setminus C_R$, and
$$
 \sigma=\Phi'/\Phi,\qquad x_R=\sigma1_{C_R},\qquad
 y_R=\sigma1_{O_R},\qquad q_R=\tau1_{O_R}.
$$
The actual score is odd and negative on the positive half-line. We use the already established identities
$$
 L\sigma=\lambda\sigma-\frac\lambda2\tau,
 \qquad \langle\sigma,\tau\rangle_\nu=-\frac12,
 \qquad E(\sigma)-\lambda\|\sigma\|_\nu^2=\frac\lambda4.
\tag{1}
$$
The full score belongs to the operator domain; the hard-core decomposition preserves that domain for each finite $R$. All inner products in this note are real.

Let $D_R\psi_R=\alpha_R\psi_R$ be the positive, even, normalized exterior ground state. Write $B_R$ for the core-to-exterior crossing operator. The actual exterior equation for (1) gives exactly
$$
 f_R:=B_Rx_R=(D_R-\lambda)y_R+\frac\lambda2q_R.
\tag{2}
$$
Its ground overlap vanishes by oddness. Thus the affine score and baseline of the two-halfline comparison are
$$
 m_R=\langle x_R,\tau\rangle_\nu<0,
 \qquad \mathcal B_R=E_{C_R}[x_R]-\alpha_R\|x_R\|_\nu^2.
\tag{3}
$$
The exact constrained form satisfies
$F_{\alpha_R}[x_R]\ge\mathcal B_R-\operatorname{Cost}_{U_h}(f_R,m_R)$,
where $U_h$ is the [explicit two-halfline majorant](theta-two-halfline-affine-covariance.md), not the exact covariance. We prove
$$
 \boxed{\quad
 \limsup_{R\to\infty}
 \left[\mathcal B_R-\operatorname{Cost}_{U_h}(f_R,m_R)\right]
 \le-\frac\lambda4=-\frac18.
 \quad}
\tag{4}
$$
In particular this sufficient lower comparison is negative for every sufficiently large core on this actual arithmetic/theta input. Formula (4) does not assert that $F_{\alpha_R}[x_R]$ is negative.

## A lower bound for the affine majorant using its surviving sign channel

Use $d\gamma=\rho\psi_Rd\nu$, $a=\gamma(O_R)$, and $\varepsilon(u)=\operatorname{sgn}(u)$. To avoid conflict with the crossing operator, denote the scalar odd-column coefficient by
$$
 b_q=a^{-1}\langle q_R,\psi_R\varepsilon\rangle_\nu,
 \qquad l_f=a^{-1}\langle f_R,\psi_R\varepsilon\rangle_\nu,
 \qquad r_R=l_f/b_q.
\tag{5}
$$
The identity $q_R/\rho=\varepsilon(e^{|u|}-1)$ implies
$b_q\ge e^R-1$. All these weighted source values are finite by the bounded weighted-crossing theorem.

In the two-halfline potential form $a\|H\|_\gamma^2+E_h(H)$, the sign function has $E_h(\varepsilon)=0$. Take the particular potential
$$
 H=-\frac{m_R}{a b_q}\varepsilon.
$$
It is centered and satisfies the exact affine constraint
$\langle q_R/\rho,H\rangle_\gamma=-m_R$. Testing the variational formula at this potential gives
$$
 \boxed{\quad
 \operatorname{Cost}_{U_h}(f_R,m_R)
 \ge-2m_Rr_R-\frac{m_R^2}{b_q^2}.
 \quad}
\tag{6}
$$
Equivalently, the exact two-halfline formula and Cauchy give $U_h(v,v)\ge|\ell(v)|^2$. Therefore the affine infimum is bounded below by $\min_c|l_f-cb_q|^2-2cm_R=-2m_Rr_R-m_R^2/b_q^2$. This is the same sign-potential calculation in one scalar square. It retains the affine moment rather than replacing it by homogeneous regression.

## The exact sign commutator removes the ground-concentration uncertainty

Let $K_\times$ be the positive arrival operator consisting of all jumps between $O_+$ and $O_-$, with the original theta rates. It includes the continuous part and every prime-power jump crossing the two halves. These halves are separated by $2R>0$, so this is a bounded symmetric operator. Multiplication by $\varepsilon$ preserves $D(D_R)$, and its exact commutator is
$$
 D_R(\psi_R\varepsilon)
 =\alpha_R\psi_R\varepsilon+2\varepsilon K_\times\psi_R.
\tag{7}
$$
Original core killing is a multiplication operator and causes no extra term in (7). This identity follows first with truncated jumps, and then from the bounded opposite-half operator; there is no singular small-jump limit in this commutator.

Since $y_R\varepsilon=-|\sigma|1_{O_R}$, pairing (2) with $\psi_R\varepsilon$, using self-adjointness and (7), gives
$$
\boxed{\begin{aligned}
 r_R={}&\frac\lambda2
 +(\lambda-\alpha_R)
       \frac{\langle|\sigma|,\psi_R\rangle_{O_R}}
            {\langle|q_R|,\psi_R\rangle_{O_R}}\\
 &-2\frac{\langle K_\times(|\sigma|1_{O_R}),\psi_R\rangle_{O_R}}
            {\langle|q_R|,\psi_R\rangle_{O_R}}.
\end{aligned}}
\tag{8}
$$
The middle term is nonnegative. It need not tend to zero, and no concentration or asymptotic profile of $\psi_R$ is needed. If
$$
 \epsilon_R=\|K_\times(|\sigma|1_{O_R})\|_\infty,
$$
then $|q_R|\ge\tanh(R/2)$ gives
$$
 r_R\ge\frac\lambda2-\frac{2\epsilon_R}{\tanh(R/2)}.
\tag{9}
$$

## Uniform actual cross-half score bound

We prove $\epsilon_R\to0$ directly, using $\Phi|\sigma|=|\Phi'|$. By reflection it suffices to consider $u>R$, and it is enough to take $R\ge1$. The continuous opposite-half contribution is bounded by
$$
 \frac1{b(u)}\int_R^\infty r(u+w)|\Phi'(w)|\,dw
 \le\frac{e^{-R}}{1-e^{-4R}}
              \int_R^\infty e^{-w/2}|\Phi'(w)|\,dw.
\tag{10}
$$
For the prime contribution the only possible indices satisfy
$\log n>u+R$. In a unit bin $j\le\log n-u<j+1$, Chebyshev's unconditional bound $\psi_{\rm Ch}(X)\le C_\psi X$ yields
$$
 \sum_{e^{u+j}\le n<e^{u+j+1}}\frac{\Lambda(n)}{\sqrt n}
 \le C_\psi e\,e^{(u+j)/2}.
$$
Since $b(u)\ge e^{u/2}$, the prime contribution is at most
$$
 C_\psi e\sum_{j\ge\lfloor R\rfloor}
 e^{j/2}\sup_{j\le w\le j+1}|\Phi'(w)|.
\tag{11}
$$
The partial first bin is safely included in the full bin. Every prime power remains, and this argument uses the elementary full Chebyshev bound, not a PNT error estimate. The full theta derivative has superexponential decay, so the tail series tends to zero. The sum of the right sides of (10) and (11) is an explicit admissible $\epsilon_R\to0$. Combining with (9) proves
$$
 \liminf_{R\to\infty}r_R\ge\lambda/2.
\tag{12}
$$
This is a statement about the actual source averaged against its actual ground state, rather than a pointwise assertion for arbitrary $L^2$ inputs.

## The core baseline and the negative limit

The known exterior form estimate gives $\alpha_R\to\lambda$. Also $\|y_R\|_\nu\to0$, $m_R\to-1/2$, and $\|x_R\|_\nu\to\|\sigma\|_\nu$. The hard-core energy splitting is
$$
 E(\sigma)=E_{C_R}(x_R)+E_{O_R}(y_R)
                        -2\langle B_Rx_R,y_R\rangle.
$$
Since the exterior form is nonnegative,
$$
 \mathcal B_R\le E(\sigma)-\alpha_R\|x_R\|^2
                  +2\|B_R\|\|x_R\|\|y_R\|.
\tag{13}
$$
The established crossing bound is bounded as $R\to\infty$ (in fact it tends to zero). Equations (1) and (13) therefore imply
$\limsup\mathcal B_R\le\lambda/4$. Only this upper limit is required; no unproved convergence of the exterior score energy is used.

Because $m_R<0$, (6) and (9) give the finite-core estimate
$$
\boxed{\begin{aligned}
 \mathcal B_R-\operatorname{Cost}_{U_h}(f_R,m_R)
 \le{}&E(\sigma)-\alpha_R\|x_R\|^2
       +2\|B_R\|\|x_R\|\|y_R\|\\
 &+2m_R\left(\frac\lambda2
                    -\frac{2\epsilon_R}{\tanh(R/2)}\right)
       +\frac{m_R^2}{(e^R-1)^2}.
\end{aligned}}
\tag{14}
$$
Its right side tends to $\lambda/4-\lambda/2=-\lambda/4$. This proves (4). All quantities in this bound are actual score, theta-tail, crossing, or exterior spectral quantities. The moment also has the exact elementary boundary formula
$$
 m_R=4\sinh(R/2)\Phi(R)-\tfrac12\nu(C_R).
\tag{15}
$$
If desired, the established lower bound $\alpha_R\ge\lambda-\delta_R$, $\delta_R\to0$, removes the ground eigenvalue from (14): its first two terms are at most
$\lambda/4+\lambda\|y_R\|^2+\delta_R\|x_R\|^2$. Thus (14) also supplies a purely tail-controlled sufficient condition for a particular large core to fail, without numerical ground-state data.

The failure comes from the sign potential that the two-halfline minorant leaves with no residual energy. It concerns this lower comparison on the actual odd score, not an arbitrary source or a generic norm example. Cross-halfline edges of the complete residual process are absent from that minorant, and no failure of the full covariance, the constrained theta form, or RH is inferred.
