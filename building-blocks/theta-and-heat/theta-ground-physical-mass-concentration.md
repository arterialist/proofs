# From normalized ground concentration to physical mass and mode survival

This note proves physical mass concentration for the actual normalized exterior ground, and consequently eventual survival of every fixed off-critical mode in the unmodulated mixed-ground family. It consumes the proved shrinking negative trial and sharp internal crossing estimates. The linked proofs retain the prime-number-theorem input and all prime-power tails. The result is written analysis; it does not assume the Riemann hypothesis or prove a sign for the resulting mixed row.

Write $G_R=\Phi\psi_R1_{|u|>R}$, where $\|\psi_R\|_\nu=1$, $\nu=b\Phi\,du$, and put
$$
\omega=\sqrt{\Phi/b},\quad
d\mu_R=\psi_R^2d\nu,\quad m_R=\int G_R\,du.
$$
The ground is positive and even. The physical form is $\mathscr K=A-S$, and its ground identity is
$$
\mathscr K[G_R]=-\delta_R<0.
\tag{1}
$$
Here $\delta_R=1/2-\alpha_R$ denotes the actual spectral distance, not an upper error in an exterior estimate.

## The proved normalized input

Let
$$
w_R=e^{-\sqrt R/8},\qquad T_R=R+6w_R.
$$
The actual input, for all sufficiently large $R$, is
$$
r_R:=\mu_R\{|u|>T_R\}^{1/2}
\le \exp[-c e^{2R}w_R],
\tag{2}
$$
One can take $c=\pi$. Indeed [theta shrinking even negative trial](theta-shrinking-even-negative-trial.md) (14) proves
$$
\delta_R\ge(5/24)e^Rw_R\omega(R+2w_R)^2,
$$
and [theta internal exterior crossing sharp bound](theta-internal-exterior-crossing-sharp-bound.md) (17) proves (2), retaining its sharper explicit inverse-width prefactor before the final simplification. The shrinking trial uses the full unconditional PNT error in Trudgian's Theorem 1, rather than an RH-sized error or an assumption on the unknown ground profile. The two companion prime bounds needed below, proved in that same sharp-crossing source (1) and (10), are
$$
\|1_{O_U}K_p1_{O_R\setminus O_U}\|
\le C e^{2R+3U}\exp[-\tfrac\pi2(e^{2R}+e^{2U})],
\tag{3}
$$
$$
\|1_{O_U}K_p1_{O_U}\|\le C e^{5U}e^{-\pi e^{2U}}.
\tag{4}
$$
These are bounds for the prime operator in the original theta Hilbert space. They do not assert boundedness of the unweighted translation sum $S$ on $L^2(du)$.

The actual theta series gives, for all sufficiently large $u$,
$$
c_\theta e^{4u}e^{-\pi e^{2u}}
\le\omega(u)^2\le C_\theta e^{4u}e^{-\pi e^{2u}},
\tag{5}
$$
and $\omega$ decreases there. Constants in this note are independent of the normalized ground and $R$; a subscript $B$ permits dependence on a fixed exponential weight.

## Relative physical logarithmic energy

Since (2) gives $\mu_R\{R<|u|\le T_R\}\ge1/2$ eventually,
$$
\|G_R\|_2^2=\int\omega^2\,d\mu_R
\ge\tfrac12\omega(T_R)^2.
\tag{6}
$$
Take $U=R+1>T_R$, and split $G_R=G_c+G_e$ at $|u|=U$. The compact part is supported in $[-U,U]$. Thus its complete prime form has only shifts $\log n\le2U$, and Chebyshev gives
$$
|\langle S G_c,G_c\rangle|
\le2\sum_{n\le e^{2U}}\frac{\Lambda(n)}{\sqrt n}\|G_c\|_2^2
\le16e^U\|G_R\|_2^2.
\tag{7}
$$
The two cross terms and the exterior term are bounded in the original normalized Hilbert space by (3) and (4), respectively. No decay estimate for $\psi_R$ is required for those terms beyond its unit norm:
$$
|\langle S G_R,G_R\rangle-\langle S G_c,G_c\rangle|
\le2C e^{2R+3U}e^{-\pi(e^{2R}+e^{2U})/2}
 +C e^{5U}e^{-\pi e^{2U}}.
\tag{8}
$$
Divide by (6) and use (5). Since
$(1+e^2)/2>1$ and $T_R-R\to0$, both ratios in (8) are at most $Ce^R$ for all sufficiently large $R$. Therefore
$$
\langle S G_R,G_R\rangle\le C e^R\|G_R\|_2^2.
$$
Equation (1) implies $A[G_R]\le\langle S G_R,G_R\rangle$. Equivalence of the positive logarithmic form with $L^2+A-a_0L^2$ yields the relative estimate
$$
\boxed{\qquad
\|G_R\|_{\mathcal H}^2\le C e^R\|G_R\|_2^2.
\qquad}
\tag{9}
$$
The subtraction of the spectral distance has the useful sign here. An absolute form bound alone would not imply (9).

## A physical $L^1$ lower bound with a controlled loss

Use the unitary Fourier convention. Since $G_R\ge0$,
$|\widehat G_R(\xi)|\le(2\pi)^{-1/2}m_R$. For every $L>1$,
$$
\|G_R\|_2^2
\le \frac{L}{\pi}m_R^2
 +\frac{\|G_R\|_{\mathcal H}^2}{\log(2+L)}.
$$
Choose $\log(2+L)=2Ce^R$, with the constant in (9). Absorbing the last term proves
$$
\boxed{\qquad
m_R\ge c\exp[-Ce^R]\|G_R\|_2
\ge c\exp[-Ce^R]\omega(T_R).
\qquad}
\tag{10}
$$
This is weaker than a direct concentration statement; its loss will be paid by the stronger normalized tail in (2).

## Weighted physical tail and shrinking support

For a fixed $B\ge0$, Cauchy--Schwarz in the original normalized variable gives
$$
\int_{|u|>T_R}e^{B(|u|-R)}G_R(u)\,du
\le r_R
\left(\int_{|u|>T_R}e^{2B(|u|-R)}\omega(u)^2du\right)^{1/2}.
\tag{11}
$$
The theta bound (5), followed by $x=e^{2u}$, gives
$$
\left(\int_{|u|>T}e^{2B(|u|-R)}\omega(u)^2du\right)^{1/2}
\le C_B e^{(B+1)T-BR}e^{-\pi e^{2T}/2}
\quad(T\text{ sufficiently large}).
\tag{12}
$$
Dividing (11) by (10) and using the lower bound in (5) at $T_R$ proves
$$
\frac{\int_{|u|>T_R}e^{B(|u|-R)}G_R(u)\,du}{m_R}
\le C_B\exp[-ce^{2R}w_R+Ce^R-R+(B-1)6w_R]
\longrightarrow0.
\tag{13}
$$
Indeed $e^Rw_R\to\infty$. This proves concentration of the physical probability $G_R\,du/m_R$ within a distance $6w_R$ of the two exterior endpoints, together with every fixed exponential tail weight.

## Every fixed off-critical mode survives the symmetric family

For a complex $s$, let
$$
M_R(s)=\int G_R(u)
[e^{s|u|}+e^{-s|u|}]\,du.
$$
On $R<|u|\le T_R$, both $e^{\pm s(|u|-R)}=1+O_s(w_R)$. Equation (13), with $B=|s|$, controls the complement. If $\Re s\ne0$, then
$$
|e^{sR}+e^{-sR}|\ge e^{|\Re s|R}-e^{-|\Re s|R}.
$$
Consequently
$$
\boxed{\qquad
\frac{M_R(s)}{2m_R\cosh(sR)}\longrightarrow1
\quad(R\to\infty),\qquad \Re s\ne0.
\qquad}
\tag{14}
$$
In particular $M_R(s)\ne0$ for all sufficiently large $R$, for each fixed such $s$. No assertion is made for a moving $s$ or for imaginary-axis values at which the denominator can vanish.

Thus no fixed off-critical exponential mode is annihilated by every member of the actual unmodulated mixed-ground family. This discharges the mode-survival prerequisite for a family-level scalar consumer. The arithmetic sign or magnitude bound on that family remains unproved. Concentration, positivity of $G_R$, and nonzero multipliers do not supply such a bound by themselves.

## Attribution and formal scope

This is written mathematics, with no Lean formalization of the displayed domain, transport or sampling estimates. The linked ground-state, theta-form and classical boundary estimates supply the stated domains. All arithmetic arrival terms and normalization costs are retained. No RH conclusion or passing full affine comparison is asserted.
