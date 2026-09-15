# A ground-shape closure for the opposite-half prime quadrature

The exact sign channel in [theta ground sign prime convolution](theta-ground-sign-prime-convolution.md) requires
$P_R\ge H_R^2/8-C_R$, where
$$
 P_R=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}(g_R*g_R)(\log n),
 \qquad H_R=2(G_{-,R}-G_{+,R}),
 \qquad G_{\mp,R}=\int_R^\infty e^{\pm u/2}g_R(u)\,du.
$$
Every prime power remains in this formula. This note gives a quantitative
sufficient shape estimate for the actual ground, then checks why the proved
logarithmic energy and the available boundary theorem do not establish it.
It does not prove the sign channel or RH.

## A compact positive-history lemma

Let $0<L\le1/4$, and let $g\ge0$ be an $L^2$ history supported in
$[R,R+L]$. Write
$$
 J_g=\left(\int e^{u/2}g(u)\,du\right)^2>0,
 \qquad P(g)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}(g*g)(\log n).
$$
The convolution is continuous and compactly supported, so the sum is finite.
Put
$$
 \epsilon_R=\sup_{x\ge e^{2R}}\frac{|\psi_{\rm Ch}(x)-x|}{x}.
$$
Fix a nonnegative smooth mollifier $\kappa$ supported in $(0,1)$, of
integral one. For $0<\Delta\le L$, put
$\kappa_\Delta(u)=\Delta^{-1}\kappa(u/\Delta)$ and
$g_\Delta=g*\kappa_\Delta$. Define the relative translation error
$$
 \rho(g,\Delta)=\frac{\|g-g_\Delta\|_2}{\|g\|_2}.
$$
If the anti-spikiness estimate
$$
 J_g\ge a e^R L\|g\|_2^2                         \tag{1}
$$
holds with $a>0$, then
$$
 \boxed{\quad
 \left|\frac{P(g)}{J_g}-1\right|
 \le C_\kappa\left[
 a^{-1}(1+\epsilon_R/L)\rho(g,\Delta)
 +\epsilon_R/\Delta+\Delta\right].\quad}          \tag{2}
$$
The constant is independent of $R,L,g$. Equation (1) prevents the positive
mass from concentrating on a much narrower interval than $L$; it is an
additional hypothesis, not a consequence of positivity.

To prove (2), all prime indices in the two compact quadratic forms have
$2R\le\log n\le2R+2(L+\Delta)$. Stieltjes partial summation with
$|\psi_{\rm Ch}(x)-x|\le\epsilon_Rx$ gives
$$
 \sum_{e^{2R}< n\le e^{2R+2(L+\Delta)}}
           \frac{\Lambda(n)}{\sqrt n}
 \le C e^R(L+\epsilon_R).
$$
The lower endpoint convolution is zero, so its atom contributes zero under
either convention. Expanding the difference of the two convolution
squares and applying Cauchy--Schwarz at each reflected translation gives
$$
 |P(g)-P(g_\Delta)|
 \le C e^R(L+\epsilon_R)\|g\|_2\|g-g_\Delta\|_2. \tag{3}
$$
Here $\|g_\Delta\|_2\le\|g\|_2$; no pointwise estimate for the rough
history is used.

For the smooth history put
$F(x)=x^{-1/2}(g_\Delta*g_\Delta)(\log x)$. Its endpoint values vanish.
The exact density value is $\int F(x)dx=J_{g_\Delta}$, and integration by
parts against $E(x)=\psi_{\rm Ch}(x)-x$ yields
$$
 |P(g_\Delta)-J_{g_\Delta}|
 \le\epsilon_R\int e^{v/2}
       (|(g_\Delta*g_\Delta)'(v)|+\tfrac12(g_\Delta*g_\Delta)(v))dv
 \le C_\kappa\epsilon_R\Delta^{-1}J_g.           \tag{4}
$$
The final estimate follows from the weighted convolution inequality and
$\int e^{u/2}|\kappa_\Delta'(u)|du\le C_\kappa/\Delta$.
Also
$$
 J_{g_\Delta}=J_g\left(\int e^{u/2}\kappa_\Delta(u)du\right)^2
             =J_g(1+O_\kappa(\Delta)).           \tag{5}
$$
Equations (1), (3)--(5) prove (2). All the discrete and continuous terms are
compared before taking a limit.

## What this would give for the actual ground

Take $L_R=6w_R$, $w_R=e^{-\sqrt R/8}$, and
$g_R^c=g_R1_{[R,R+L_R]}$. The physical concentration theorem, with its
fixed exponential weight $B=1/2$, proves
$$
 \int e^{u/2}g_R^c(u)du/G_{-,R}\longrightarrow1. \tag{6}
$$
Because $g_R\ge0$, the complete prime convolution has the favorable
lower bound $P(g_R)\ge P(g_R^c)$. Thus if, for this specified compact
ground history, (1) holds with a fixed $a>0$ and there are scales
$\Delta_R\le L_R$ such that
$$
 \rho(g_R^c,\Delta_R)\to0,
 \qquad \epsilon_R/\Delta_R\to0,                 \tag{7}
$$
then (2) and (6) prove
$$
 P_R\ge(1-o(1))G_{-,R}^2.                        \tag{8}
$$
The unconditional PNT input used for the shrinking trial has
$\epsilon_R=o(w_R)$, so it does leave scales between its discrepancy and
the concentration width. Since
$H_R^2/8=(G_{-,R}-G_{+,R})^2/2\le G_{-,R}^2/2$, (8) would pass the
sign-channel inequality for all sufficiently large cores, with a strict
margin. This is a closure of that particular channel, not a claim that its
passage alone completes the full common-score covariance comparison.

## Why the established inputs do not prove the shape hypotheses

For any logarithmic-form history, Fourier splitting gives the valid modulus
estimate
$$
 \rho(g,\Delta)^2
 \le C_\kappa\left[
 \Delta+\frac{\|g\|_{\mathcal H}^2}
 {\|g\|_2^2\log(2+\Delta^{-1/2})}\right].        \tag{9}
$$
Use the convolution multiplier $m_\kappa(\eta)=\int\kappa(u)e^{-i\eta u}du$
and $|1-m_\kappa(\Delta\xi)|\le C\Delta|\xi|$ below
$|\xi|=\Delta^{-1/2}$, and bound its square by a constant above that
threshold. The actual relative budget available here is only
$\|G_R\|_{\mathcal H}^2/\|G_R\|_2^2\le Ce^R$. Even granting the
analogous compact-history budget, (9) would require
$\log(1/\Delta_R)\gg e^R$ to force its upper bound to vanish. There is
an actual arithmetic lower bound
$$
 \epsilon_R\ge(\log2)/(4e^{2R}).                 \tag{9a}
$$
Choose the first power $q=2^j$ strictly above $e^{2R}$, so
$q\le2e^{2R}$. The left and right discrepancy limits at $q$ differ
by $\Lambda(q)=\log2$; both limits belong to the range defining
$\epsilon_R$, and one has magnitude at least $(\log2)/2$. This
proves (9a), including when the core endpoint is itself a prime power.
Consequently $\epsilon_R/\Delta_R\to0$ forbids
$\log(1/\Delta_R)\gg e^R$. Thus the scales forced by the available
modulus bound and the prime-compatible scales have no overlap. This is a
failure of that sufficient bound, not a lower bound for the true modulus.
The physical mass lower bound
$\|G_R\|_1\ge c e^{-Ce^R}\|G_R\|_2$ likewise does not imply (1).

The cited logarithmic-Laplacian boundary theorem supplies a fixed-core
upper trace estimate and continuity. Its Hopf theorem requires a nonnegative
weak supersolution. For the actual physical ground $G_R$, the exact
distributional equation on the exterior is
$$
 L_\Delta G_R
 =2S G_R-2\delta_RJ G_R+2\log(2\pi)G_R-2k*G_R, \tag{10}
$$
where $J=b/\Phi$ and $k$ is the bounded correction kernel from
[theta return clock boundary compactness](theta-return-clock-boundary-compactness.md). Positivity of $SG_R$ does
not establish the sign of the complete right side. Moreover a qualitative
fixed-core Hopf constant would not give the uniform moment-normalized
anti-spikiness and modulus required in (1), (7). The primary theorem is
[Hernández-Santamaría--López Ríos--Saldaña, Theorems 1.1 and 1.4](https://arxiv.org/html/2401.18033v2).

The sharp grid counterprofiles in
[theta lost retained prime sampling obstruction](theta-lost-retained-prime-sampling-obstruction.md) confirm that concentration
and logarithmic energy alone cannot replace these missing ground-shape
estimates. Equations (2), (6)--(8) identify a concrete additional obligation:
obtain uniform anti-spikiness and a PNT-compatible translation modulus from
the actual minimizing ground equation, preserving its signed correction
and every prime arrival.

## Attribution and formal scope

This is written mathematics, with no Lean formalization of the displayed domain, transport or sampling estimates. Weighted mollification, partial summation and Fourier splitting are classical. The uniform anti-spikiness and translation-modulus assumptions remain unproved for the actual ground. No RH conclusion or passing full affine comparison is asserted.
