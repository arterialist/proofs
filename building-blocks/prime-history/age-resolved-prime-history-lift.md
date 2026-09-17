# An age-resolved lift of the actual prime-error history

Let $L=\log 3$, let $\psi(x)=\sum_{n\le x}\Lambda(n)$ use the inclusive endpoint, and put

$$
\beta(v)=e^{-v}\psi(e^v)-1\quad(v\ge0),\qquad
\beta(v)=0\quad(v<0).
$$

Thus $\beta(0)=-1$. The critical history is $a(v)=e^{v/2}\beta(v)$. We keep the full cell profile and its nonnegative integer age,

$$
\beta_j(\theta)=\beta(\theta+jL),\qquad
F_z(\theta)=\sum_{j\ge0}z^j\beta_j(\theta),
\qquad 0\le\theta<L.
\tag{1}
$$

Chebyshev's estimate makes (1) an analytic power series with values in $L^\infty[0,L)$ for $|z|<1$. Its coefficients have canonical right-continuous representatives. The classical quantitative PNT remainder $\beta(v)=O(e^{-c\sqrt v})$ gives convergence of every age-moment series on $|z|\le1$, uniformly in the cell coordinate. This does not give an analytic neighborhood outside that disk. Compact cutoffs of the actual history give polynomials in $z$ and retain every endpoint in the formulas below.

## Exact shifts and their finite initial-age terms

For $h>0$, write

$$
\theta+h=\theta_++\kappa L,\qquad
\theta-h=\theta_- -mL,
\qquad \theta_\pm\in[0,L),\quad \kappa,m\in\mathbb N_0.
$$

For causal delay $R_hb(v)=1_{v\ge h}b(v-h)$ and advance $E_hb(v)=b(v+h)$, direct reindexing gives

$$
\mathcal F_z(R_h\beta)(\theta)=z^mF_z(\theta_-),
\tag{2}
$$

$$
\mathcal F_z(E_h\beta)(\theta)
=z^{-\kappa}\left[F_z(\theta_+)
-\sum_{\ell=0}^{\kappa-1}z^\ell\beta_\ell(\theta_+)\right].
\tag{3}
$$

The apparent singularity at $z=0$ is removable. The finite subtraction in (3) contains only arguments in $[0,h)$; it is the initial-age boundary term. The delay operators in (2) commute, compose by addition of their shifts, and satisfy $R_L(z)=zI$. An inverse weighted rotation without the subtraction in (3) is not the causal advance.

Choose a logarithm branch $q=L^{-1}\operatorname{Log}z$ and define the cell section $G_q(\theta)=e^{q\theta}F_z(\theta)$. Let $T_h$ denote translation by $h$ on the circle of length $L$. Equations (2)--(3) become

$$
\mathcal G_q(R_h\beta)=e^{qh}T_{-h}G_q,
\qquad
\mathcal G_q(E_h\beta)=e^{-qh}T_hG_q-J_h(q),
\tag{4}
$$

where the exact entire, finite boundary term is

$$
J_h(q;\theta)=e^{-qh}
\sum_{\ell<\kappa}e^{q(\theta_++\ell L)}
\beta(\theta_++\ell L).
\tag{5}
$$

Circle translations are unitary on $L^2[0,L)$. These identities hold there without imposing matching values at the cell seam.

For a prime $p$, take $h=\log p$ and $r_p=p^{-1/2}$. Conjugating the actual critical filters by $a=e^{v/2}\beta$ gives

$$
(I-r_pR_h)a=e^{v/2}(I-p^{-1}R_h)\beta,
\qquad
(I-r_pE_h)a=e^{v/2}(I-E_h)\beta.
$$

Consequently their circle factors are

$$
D_p(q)=I-p^{q-1}T_{-\log p},\qquad
A_p(q)=I-p^{-q}T_{\log p}.
\tag{6}
$$

The advance includes the additional term $+J_{\log p}(q)$. For every fixed prime, both factors have geometric inverses throughout $0<\Re q<1$, with

$$
\|D_p(q)^{-1}\|\le\frac1{1-p^{\Re q-1}},\qquad
\|A_p(q)^{-1}\|\le\frac1{1-p^{-\Re q}}.
\tag{7}
$$

They are holomorphic operator families on that strip. At $q=1/2$ they are the actual critical prime factors. At $q=0$, the advance factor becomes $I-T_{\log p}$, the rotation difference operator of the real-line-one flow problem. The operator bounds (7) do not analytically continue the source $G_q$ from $\Re q<0$.

## Successor as an operator retaining age

For $x=e^v\ge1$, the interval $(x,x+1]$ contains exactly the integer $\lfloor x\rfloor+1$. Therefore, with $\sigma(v)=\log(e^v+1)$,

$$
\beta(\sigma(v))=
\frac{x}{x+1}\beta(v)
+\frac{\Lambda(\lfloor x\rfloor+1)-1}{x+1}.
\tag{8}
$$

Equivalently,

$$
a(\sigma(v))=
\sqrt{\frac{x}{x+1}}a(v)
+\frac{\Lambda(\lfloor x\rfloor+1)-1}{\sqrt{x+1}}.
\tag{9}
$$

For $v=\theta+jL$, define

$$
\kappa_j(\theta)=1_{\theta\ge\log(3-3^{-j})},\qquad
\theta'_j=\log(e^\theta+3^{-j})-\kappa_jL.
$$

Then $\sigma(v)=\theta'_j+(j+\kappa_j)L$. The inclusive inequality is essential at an exact wrap. In particular, successor is an age-dependent map of the cell, not a fixed circle rotation.

Let $C$ be the diagonal operator $(Cb)_j=3^{-j}b_j$ on age sequences. In generating functions it is $(CF)(z)=F(z/3)$. Multiplication by $x/(x+1)$ in (8) is exactly the bounded diagonal resolvent $(I+e^{-\theta}C)^{-1}$. Thus

$$
\sum_{j\ge0}z^j\beta_{j+\kappa_j}(\theta'_j)
=(I+e^{-\theta}C)^{-1}F_z(\theta)+\mathcal B_z(\theta),
\tag{10}
$$

$$
\mathcal B_z(\theta)=
\sum_{j\ge0}z^j
\frac{\Lambda(\lfloor3^je^\theta\rfloor+1)-1}{3^je^\theta+1}.
\tag{11}
$$

The coefficients in (11) are uniformly $O((j+1)3^{-j})$, so this birth source is analytic for $|z|<3$. The corresponding multiplier for (9) is $(I+e^{-\theta}C)^{-1/2}$. Equations (10)--(11) retain the initial seed, the arrival at every integer, and the exact wrap count. They do not replace the source by its prime-only part.

## Critical parameter and the seam

The generating series for $a$ satisfies

$$
\sum_{j\ge0}\zeta^j a(\theta+jL)
=e^{\theta/2}F_{\sqrt3\,\zeta}(\theta).
\tag{12}
$$

Thus unweighted periodization of the critical history would require $z=\sqrt3$. Equation (12) alone does not justify this boundary sum.

The seam keeps all prime powers of three. Since $\Delta\beta(jL)=L3^{-j}$ for $j\ge1$,

$$
G_q(0+)-G_q(L-)
=-1+\sum_{j\ge1}z^j\frac L{3^j}
=-1+\frac{Lz}{3-z}.
\tag{13}
$$

This follows in the convergence disk; its right side continues as an explicit boundary term. Away from the seam, an arrival $n$ at $\log n=\theta+jL$ contributes a jump $\Lambda(n)n^{q-1}$ to $G_q$. These jump identities do not establish continuation of the complete cell function.

## Exact modes, zeta poles, and reflected radii

Put $\omega_k=2\pi k/L$ and normalize cell Fourier coefficients by $1/L$. For $\Re q<0$, absolute convergence gives

$$
\widehat G_q(k)
=\frac1L\int_0^\infty\beta(v)e^{qv-i\omega_kv}\,dv
=\frac1L\left[-\frac{\zeta'(s)}{s\zeta(s)}-\frac1{s-1}\right],
\qquad s=1-q+i\omega_k.
\tag{14}
$$

To prove the last equality, integrate each term of $\psi$ on $[\log n,\infty)$ and use the absolutely convergent Euler logarithmic derivative $-\zeta'(s)/\zeta(s)=\sum_n\Lambda(n)n^{-s}$ for $\Re s>1$. The subtraction integrates the $-1$ in $\beta$. At $s=1$ the poles cancel. Since $\zeta(s)=(s-1)^{-1}+\gamma+O(s-1)$, the bracket has value $-1-\gamma$ there. In particular $\widehat G_0(0)=-(1+\gamma)/L$.

Let $\rho$ be a nontrivial zeta zero of multiplicity $m_\rho$. Each relevant mode has a simple pole at

$$
q_{\rho,k}=1-\rho+i\omega_k,
\qquad
\operatorname*{Res}_{q=q_{\rho,k}}\widehat G_q(k)
=\frac{m_\rho}{L\rho}.
\tag{15}
$$

Multiplicity appears in the residue, not the pole order. On a local logarithm chart in $z$ this becomes

$$
z_\rho=3^{1-\rho},\qquad
\operatorname*{Res}_{z=z_\rho}\widehat G_{\operatorname{Log}z/L}(k)
=\frac{m_\rho z_\rho}{\rho},
\tag{16}
$$

where $k$ is chosen so the chart value at $z_\rho$ equals $q_{\rho,k}$. Changing the logarithm branch by $2\pi i\ell$ multiplies the cell section by $e^{i\omega_\ell\theta}$ and relabels its Fourier modes by $k\mapsto k-\ell$. Different zero heights can map to the same $z$; their cell modes distinguish them. No assumption about absence of such coincidences is needed.

For an isolated coefficient pole, the corresponding possible residue profile of the ungauged cell function is

$$
\frac{m_\rho z_\rho}{\rho}e^{(\rho-1)\theta}.
\tag{17}
$$

This describes the mode forced by (15), without asserting that an infinite sum of residue profiles defines a Banach-valued meromorphic function.

The functional reflection $\rho\mapsto1-\rho$ gives $z\mapsto3/z$, with paired product $3$. The reflection $\rho\mapsto1-\bar\rho$ gives $z\mapsto3/\bar z$. The critical line corresponds exactly to $|z|=\sqrt3$. A zero with $\Re\rho>1/2$ gives $1<|z_\rho|<\sqrt3$. Its nonzero mode residue cannot be canceled by adding the exterior reflected pole while preserving the original analytic germ. Keeping the cell profile prevents scalar aliasing from hiding this distinction.

Equation (14) proves modewise meromorphic continuation. It does not by itself give an $L^2$- or $L^\infty$-valued continuation of the cell profile, or a Hardy boundary value on the critical circle.

A precise statement of the needed age estimate is available. The actual $L^\infty$-valued power series (1) is holomorphic throughout $|z|<\sqrt3$ if and only if RH holds. Under RH, the classical bound $\psi(x)-x=O(\sqrt x\log^2x)$ gives

$$
\|\beta_j\|_\infty=O((j+1)^2 3^{-j/2}),
\tag{18}
$$

which proves one direction. Conversely, analyticity of that Banach-valued germ on the disk gives, for every $1<r<\sqrt3$, the Cauchy bound $\|\beta_j\|_\infty\le C_r r^{-j}$. This gives $\psi(x)-x=O_\varepsilon(x^{1/2+\varepsilon})$, or directly excludes every pole in (15) with $0<\Re q<1/2$. Functional reflection then gives RH. This is the classical error criterion written with age retained; no new bound for (18) is proved here. Neither direction asserts ordinary convergence on the critical circle.

## Consumption of the two-history boundary identities

Use a compact cutoff $f=\chi_Ta$ and the complete two-prime construction in the source note listed below. Denote its unilateral transforms by $F_T(\lambda),P_+(\lambda),Q_+(\lambda)$ and its compact boundary transforms by $H_{23}(\lambda),B_{23}(\lambda)$. The symbol $B_{23}$ is unrelated to the prime-error history $\beta$ in (1). Its exact identities are

$$
P_+=\frac A D F_T-H_{23},\qquad
A Q_+=D F_T-B_{23},
\tag{19}
$$

$$
F_T^2-P_+Q_+=\frac{B_{23}}D F_T+H_{23}Q_+,
\tag{20}
$$

where

$$
A(\lambda)=\prod_{p=2,3}(1-p^{-1/2}e^{\lambda\log p}),
\qquad
D(\lambda)=\prod_{p=2,3}(1-p^{-1/2}e^{-\lambda\log p}).
$$

The exact age substitution is

$$
\lambda=\frac12-q+i\omega_k,\qquad
F_T(\lambda)=L\widehat G_{q,T}(k).
\tag{21}
$$

Under this substitution the scalar factors are exactly the Fourier symbols of (6). In particular neither $A$ nor $D$ vanishes for $0<\Re q<1$. Equations (19)--(21) retain both boundary terms and the upper cutoff, and hold as meromorphic finite-cutoff identities wherever the displayed quotients are defined. The source note proves the cancellations at the apparent advance resonances. One must not interpret either product on the right of (20) separately as a unilateral boundary integral; their negative-time parts cancel only in the complete sum.

The source note also proves convergence of the compact boundary terms from the quantitative PNT remainder. This does not supply critical age bounds for $F_T$. Thus the retained-age formulation can directly use the existing boundary constraints, while locating the additional arithmetic requirement in the full age-weighted source. Bounds for the centered section at $q=0$, even with increasing prime generators, are not bounds for that source at $q=1/2$.

## Sources and scope

The two-history identities and their exact boundary definitions are in [Two-prime unilateral transport and the common resonance](../prime-distribution/two-prime-unilateral-boundary.md), equations (2)--(8) and (16). The Euler logarithmic derivative, Laurent expansion and functional reflection are classical; the latter two are recorded in [DLMF 25.2.4](https://dlmf.nist.gov/25.2.E4) and [DLMF 25.4](https://dlmf.nist.gov/25.4). The quantitative PNT input is [Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689), with its polynomial prefactor absorbed by decreasing the exponential constant. The only global error estimates used here are the classical quantitative PNT remainder for the initial disk boundary and the classical RH error estimate in the explicitly conditional statement (18).

The construction in this note is the exact bookkeeping of nonnegative age, successor wraps, finite advance terms and the common substitution (21). It proves no new RH-scale bound and makes no Lean claim.
