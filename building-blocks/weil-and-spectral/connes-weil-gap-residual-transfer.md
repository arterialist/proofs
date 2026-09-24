# Gap and residual criteria for Connes's compact Weil candidate

[Connes, sections 6.1--6.6](https://arxiv.org/html/2602.04022)
proposes the finite-window function $k_\lambda$ of equation (20) as an
approximation to the lowest eigenvector of the Weil operator
$A_\lambda$ of equation (19). Fact 6.4 proves convergence of the
**unnormalized** transform $\widehat{k}_\lambda$ to Riemann's $\Xi$.
The inequalities below state what a separate approximation of the
**normalized** lowest eigenvector must supply. They are conditional
spectral estimates, not a bound on the actual Weil gap or residual.

## Spectral location and angle

Work in $H_\lambda=L^2([\lambda^{-1},\lambda],du/u)$. Suppose the
lowest eigenvalue $E_0(\lambda)$ of $A_\lambda$ is simple, with
normalized eigenvector $\eta_\lambda$, and write $E_1(\lambda)>E_0$
for the next eigenvalue and $\Delta_\lambda=E_1-E_0$. Let

\[
\kappa_\lambda=\|k_\lambda\|_2>0,\qquad
v_\lambda=k_\lambda/\kappa_\lambda,\qquad
R_\lambda=q_\lambda(v_\lambda,v_\lambda).
\tag{1}
\]

The first estimate needs only $v_\lambda$ in the **form domain**.
Choose the phase of $\eta_\lambda$ so that
$\langle\eta_\lambda,v_\lambda\rangle\ge0$ and put
$s_\lambda^2=1-|\langle\eta_\lambda,v_\lambda\rangle|^2$.
The spectral theorem gives

\[
R_\lambda-E_0
=\int_{(E_0,\infty)}(t-E_0)\,d\mu_{v_\lambda}(t)
\ge\Delta_\lambda s_\lambda^2,
\qquad
\|v_\lambda-\eta_\lambda\|_2\le\sqrt2\,s_\lambda.
\tag{2}
\]

If $v_\lambda$ also belongs to the **operator domain**, define its
Weil residual $r_\lambda=\|(A_\lambda-R_\lambda)v_\lambda\|_2$.
Provided $R_\lambda<E_1$, the part of the residual orthogonal to
$\eta_\lambda$ gives

\[
s_\lambda\le\frac{r_\lambda}{E_1-R_\lambda},
\qquad
E_0\ge R_\lambda-
\frac{r_\lambda^2}{E_1-R_\lambda}.
\tag{3}
\]

The second inequality is Temple's bound. To see it directly, expand
$r_\lambda^2$ spectrally and use
$r_\lambda^2=\langle(A_\lambda-E_0)(A_\lambda-R_\lambda)
v_\lambda,v_\lambda\rangle\ge
(E_1-R_\lambda)(R_\lambda-E_0)$.
Thus a residual without a certified location $R_\lambda<E_1$ does
not identify the ground state. All quantities in (2)--(3) refer to
the Weil operator, rather than to the prolate concentration operator.

## Uniform Fourier transfer and normalization

In logarithmic coordinates $u=\log x$, both $v_\lambda$ and
$\eta_\lambda$ have support in $[-\log\lambda,\log\lambda]$.
For $\sigma\ge0$, Cauchy--Schwarz gives, uniformly for
$|\Im z|\le\sigma$,

\[
\left|\widehat v_\lambda(z)-\widehat\eta_\lambda(z)\right|
\le D_\lambda(\sigma)
\|v_\lambda-\eta_\lambda\|_2,
\quad
D_\lambda(\sigma)=
\begin{cases}
\displaystyle\left(\frac{\lambda^{2\sigma}-1}{\sigma}\right)^{1/2},
 &\sigma>0,\\[2mm]
\sqrt{2\log\lambda},&\sigma=0.
\end{cases}
\tag{4}
\]

Since Connes's convergence concerns $k_\lambda$, the comparison
actually needed for its transform is

\[
\sup_{|\Im z|\le\sigma}
\left|\widehat{k}_\lambda(z)
 -\kappa_\lambda\widehat\eta_\lambda(z)\right|
\le\sqrt2\,\kappa_\lambda D_\lambda(\sigma)
\sqrt{\frac{R_\lambda-E_0}{\Delta_\lambda}}.
\tag{5}
\]

When the residual assumptions of (3) hold, the square-root factor in
(5) may be replaced by $r_\lambda/(E_1-R_\lambda)$. If the resulting
right side tends to zero
for every fixed $0\le\sigma<1/2$, then Connes's Fact 6.4 transfers
the $\Xi$ limit to $\kappa_\lambda\widehat\eta_\lambda$ on every
closed substrip. Multiplication by the nonzero scalar
$\kappa_\lambda$ does not change the zeros of
$\widehat\eta_\lambda$; no unproved limit for
$\kappa_\lambda$ is needed. Invoking Theorem 6.1 would additionally
require the simple lowest eigenvector to be even.

For a bounded $\kappa_\lambda$, a sufficient condition through (5),
for each fixed $0<\sigma<1/2$, is either

\[
\frac{R_\lambda-E_0}{\Delta_\lambda}
=o(\lambda^{-2\sigma})
\quad\text{or}\quad
\frac{r_\lambda}{E_1-R_\lambda}
=o(\lambda^{-\sigma}).
\tag{6}
\]

The real-axis factor in (4) is $\sqrt{2\log\lambda}$ and must be
paid separately. For example, a norm-angle bound
$O(\lambda^{-1/2})$ matches the order of Fact 6.4's
$O(\lambda^{-1/2+\sigma})$ error on any fixed strip of positive
width $\sigma$, but incurs an extra $\sqrt{\log\lambda}$ on the
real line. The bound (4) matches Fact 6.4's real-line rate itself
when the angle is $O(\lambda^{-1/2}/\sqrt{\log\lambda})$.

## What the prolate estimate does not control

[Connes, Fact 6.3 and section 6.4](https://arxiv.org/html/2602.04022)
give simple prolate concentration eigenvalues and the asymptotic
$1-\chi_2(\lambda)\sim C\lambda^9e^{-4\pi\lambda^2}$.
This is a concentration-operator estimate. The paper reports a
numerical similarity to the bottom Weil eigenvalue and proposes
$k_\lambda$ from prolate and Hermite data. The cited estimates do
not supply $\Delta_\lambda$, $E_1>R_\lambda$, or a bound on the Weil
residual $r_\lambda$ in (3)--(6). A small Rayleigh value alone is
insufficient: the abstract operator
$\operatorname{diag}(-1,p_\lambda,1)$ has a candidate at Rayleigh
value $p_\lambda\to0$ with zero residual, yet its ground eigenvalue
is $-1$. The condition $R_\lambda<E_1$ fails in that example.

There is a precise RH-scale consequence. The compact-window forms
are restrictions of one global form by zero extension
([Connes--Consani, equation (2.11) and Proposition 2.1](https://arxiv.org/html/2106.01715)),
so $E_0(\lambda)$ is nonincreasing as $\lambda$ grows. If along any
cofinal sequence $\lambda_j\to\infty$ one proved
$E_0(\lambda_j)\ge-o(1)$, then for every fixed $\lambda_0$,

\[
E_0(\lambda_0)\ge E_0(\lambda_j)\ge-o(1)
\quad(\lambda_j\ge\lambda_0),
\]

and hence $E_0(\lambda_0)\ge0$. Weil's criterion then gives RH.
Accordingly, if $R_\lambda\to0$ and
$r_\lambda^2/(E_1-R_\lambda)\to0$ along a cofinal sequence, the
Temple bound (3) already establishes RH. In particular, a
Rayleigh-only argument replacing $R_\lambda-E_0$ in (2) by
$R_\lambda$ for **all** windows assumes $E_0\ge0$, the very
all-window Weil positivity at issue.

The [raw-vector analysis](connes-raw-prolate-residual-gap-obstruction.md)
subsequently rules out the particular $r_\lambda/(E_1-R_\lambda)$
transfer in (3)--(6) for Connes's unsmoothed two-mode vector along a
cofinal sequence. The Temple condition and other trial vectors remain
logically open. This diagnostic proves no simplicity, evenness, Weil
positivity, or RH statement. The inequalities are written spectral
mathematics, not Lean formalizations.
