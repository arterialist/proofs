# Critical-zero oscillation in the positive cofactor cone

Research note, 16 September 2026. This is an unconditional written theorem about the **actual, complete** von Mangoldt source. It proves that a signed covariance inside a positive divisor-cone budget has fluctuations of both signs at least at square-root scale. It supplies no square-root upper bound and does not prove RH. The analytic theorem is not yet formalized in Lean.

Fix $0<\lambda<1/2$. For each integer $X\ge2$, put

\[
\ell_X=\frac{\log(X!)}{X},\qquad L_X(n)=\log n-\ell_X,
\qquad R_\lambda(n)=\sum_{dm=n}\Lambda(d)\lambda^m,
\qquad C_\lambda(X)=\sum_{n\le X}L_X(n)R_\lambda(n). \tag{1}
\]

The sum includes ordinary primes, every proper prime power, and every multiplicative cofactor $m$. Let $\rho=1/2+i\gamma$ be any critical-line zero of $\zeta$, with multiplicity $m_\rho$, and define

\[
d_{\lambda,\rho}
=m_\rho\left|\frac{\rho-1}{\rho^2}\operatorname{Li}_\rho(\lambda)\right|
=\frac{m_\rho|\operatorname{Li}_\rho(\lambda)|}{|\rho|}>0,
\qquad \operatorname{Li}_s(\lambda)=\sum_{m\ge1}\frac{\lambda^m}{m^s}. \tag{2}
\]

**Theorem.** Every such zero gives

\[
\boxed{\displaystyle
\limsup_{X\to\infty}\frac{C_\lambda(X)}{\sqrt X}\ge d_{\lambda,\rho},
\qquad
\liminf_{X\to\infty}\frac{C_\lambda(X)}{\sqrt X}\le-d_{\lambda,\rho}.} \tag{3}
\]

The limits run through integer horizons. Hardy's critical-line theorem makes (3) unconditional. The elementary first-term estimate

\[
|\operatorname{Li}_s(\lambda)|
\ge\lambda-\frac{\lambda^2}{1-\lambda}
=\frac{\lambda(1-2\lambda)}{1-\lambda}>0
\quad(\Re s\ge0) \tag{4}
\]

shows explicitly that the cofactor weight cannot erase the zero pole.

## Exact transform and integer centering

Write $b_\lambda(n)=R_\lambda(n)\ge0$, $B_\lambda(x)=\sum_{n\le x}b_\lambda(n)$, and introduce the continuous-endpoint centered score

\[
H_\lambda(x)=\sum_{n\le x}b_\lambda(n)
  (\log n-\log x+1),\qquad x\ge1. \tag{5}
\]

Chebyshev's elementary bound $\psi(y)\ll y$ gives

\[
B_\lambda(x)=\sum_{m\le x}\lambda^m\psi(x/m)
\ll_\lambda x. \tag{6}
\]

Thus $H_\lambda(x)=O_\lambda(x\log(2x))$. Its Mellin transform converges absolutely for $\Re s>1$. Termwise integration, including the exact hard endpoint $x=n$, gives

\[
\begin{aligned}
\int_1^\infty H_\lambda(x)x^{-s-1}\,dx
&=\sum_{n\ge1}b_\lambda(n)n^{-s}
   \left(\frac1s-\frac1{s^2}\right)\\
&=\frac{s-1}{s^2}
  \left(-\frac{\zeta'(s)}{\zeta(s)}\right)
  \operatorname{Li}_s(\lambda)
 =:M_\lambda(s). \tag{7}
\end{aligned}
\]

The factor $s-1$ cancels the real prime pole at $s=1$. There is no zeta zero on the positive real axis, so $M_\lambda$ is holomorphic at every real $s>0$. At a nontrivial zero $\rho$ of multiplicity $m_\rho$, the logarithmic derivative has a simple pole of residue $-m_\rho$, whence

\[
\operatorname*{Res}_{s=\rho}M_\lambda(s)
=-m_\rho\frac{\rho-1}{\rho^2}
  \operatorname{Li}_\rho(\lambda). \tag{8}
\]

Equation (4) makes this residue nonzero at every zero with $\Re\rho\ge0$.

Stirling's formula gives

\[
\log X-1-\ell_X=O\!\left(\frac{\log X}{X}\right).
\]

Consequently the integer endpoint in (1) differs from (5) only by

\[
C_\lambda(X)-H_\lambda(X)
=(\log X-1-\ell_X)B_\lambda(X)=O_\lambda(\log X). \tag{9}
\]

For $X\le x<X+1$, no new arithmetic atom appears and

\[
H_\lambda(x)-H_\lambda(X)
=-B_\lambda(X)\log(x/X)=O_\lambda(1). \tag{10}
\]

These two errors are $o(\sqrt X)$; no prime-power endpoint is discarded.

## Positive-Mellin proof of the two signs

Suppose the first inequality in (3) fails. Choose $0<c_0<c<d_{\lambda,\rho}$ such that $C_\lambda(X)\le c_0\sqrt X$ for every sufficiently large integer $X$. Equations (9)--(10) then imply $H_\lambda(x)\le c\sqrt x$ for all sufficiently large real $x$. For a fixed sufficiently large $x_0$, the function

\[
g(x)=\mathbf1_{[x_0,\infty)}(x)
  \bigl(c\sqrt x-H_\lambda(x)\bigr)
\]

is nonnegative. In $\Re s>1$, its Mellin transform is

\[
G(s)=\frac{c x_0^{1/2-s}}{s-1/2}
      -M_\lambda(s)+\int_1^{x_0}H_\lambda(x)x^{-s-1}\,dx. \tag{11}
\]

The last term is entire. The defining integral has a finite convergence abscissa $\alpha$, since $g(x)=O_\lambda(x\log(2x))$. The nonreal pole (8) forces $\alpha\ge1/2$. If $\alpha>1/2$, the positive-Mellin theorem forces a singularity of $G$ at the **real** point $s=\alpha$; (11) is holomorphic there. Hence $\alpha=1/2$, and the integral for $G$ converges throughout $\Re s>1/2$.

For $\varepsilon>0$, nonnegativity gives

\[
|G(1/2+\varepsilon+i\gamma)|\le G(1/2+\varepsilon). \tag{12}
\]

After multiplication by $\varepsilon$ and passage to $\varepsilon\downarrow0$, the left side tends to $d_{\lambda,\rho}$ by (8), while the right side tends to $c$ because $M_\lambda$ is regular at the real point $1/2$. This contradicts $c<d_{\lambda,\rho}$. Applying the same argument to $H_\lambda(x)+c\sqrt x$ proves the lower inequality in (3). No simplicity or independence assumption on the zero ordinates is used.

## Consequences for the positive budget

The increasing cofactor weight $1-\lambda^m$ gives the finite positive cone budget

\[
P_\lambda(X)
=\sum_{d\le X}\Lambda(d)
  \sum_{m\le X/d}(1-\lambda^m)L_X(dm)\ge0.
\]

The exact divisor identity $\sum_{d\mid n}\Lambda(d)=\log n$ yields

\[
P_\lambda(X)=V_X-C_\lambda(X),
\qquad V_X=\sum_{n\le X}L_X(n)^2=X+O(\log^2X). \tag{13}
\]

Thus (3) is also a two-sided square-root fluctuation theorem for the positive quantity $P_\lambda(X)-X$:

\[
\limsup_{X\to\infty}\frac{P_\lambda(X)-X}{\sqrt X}\ge d_{\lambda,\rho},
\qquad
\liminf_{X\to\infty}\frac{P_\lambda(X)-X}{\sqrt X}\le-d_{\lambda,\rho}. \tag{14}
\]

In particular, neither $C_\lambda(X)$ nor $P_\lambda(X)-X$ is eventually one-signed or $o(\sqrt X)$. This is consistent with the unproved RH-equivalent upper bound $P_\lambda(X)-X=O_{\lambda,\varepsilon}(X^{1/2+\varepsilon})$: (14) calibrates its smallest possible exponent but does not establish that upper bound.

There is also no uniform monotonicity in the damping parameter. Put

\[
C^{(1)}_\lambda(X)=\frac{d}{d\lambda}C_\lambda(X)
=\sum_{dm\le X}\Lambda(d)m\lambda^{m-1}L_X(dm),
\qquad P_\lambda'(X)=-C^{(1)}_\lambda(X). \tag{15}
\]

For $0<\lambda<1-1/\sqrt2$, the cofactor Dirichlet factor

\[
J_\lambda(s)=\sum_{m\ge1}m\lambda^{m-1}m^{-s}
\]

has first term $1$ and a tail of modulus at most $(1-\lambda)^{-2}-1<1$ on $\Re s\ge0$. Repeating the proof of (3) with $J_\lambda$ in place of $\operatorname{Li}_s(\lambda)$ gives, for every critical zero $\rho$,

\[
\limsup_{X\to\infty}\frac{P_\lambda'(X)}{\sqrt X}
\ge\frac{m_\rho|J_\lambda(\rho)|}{|\rho|}>0,
\qquad
\liminf_{X\to\infty}\frac{P_\lambda'(X)}{\sqrt X}
\le-\frac{m_\rho|J_\lambda(\rho)|}{|\rho|}<0. \tag{16}
\]

The same Chebyshev bound, centering estimate and between-integer interpolation apply because $\sum_m m\lambda^{m-1}/m=(1-\lambda)^{-1}$. Finite-horizon numerical monotonicity in $\lambda$ therefore cannot persist at all large horizons.

The result also survives integration against the **actual compensated factorial clock weight** on the fixed interval used in the companion cone theorem. Let

\[
I=[\log4,\log4+1],\qquad
w(t)=\frac1{t^2}-\frac1{t(e^t-1)}>0,\qquad
W=\int_Iw(t)\,dt,\qquad
A_m=\int_Iw(t)e^{-mt}\,dt .
\]

Define $P_I(X)=\int_Iw(t)P_{e^{-t}}(X)\,dt$ and $B_I(s)=\sum_{m\ge1}A_m m^{-s}$. Since $e^{-t}\le1/4$ on $I$, we have $A_m\le4^{-(m-1)}A_1$ and therefore

\[
|B_I(s)|\ge A_1-\sum_{m\ge2}A_m
\ge\frac23A_1>0\qquad(\Re s\ge0).
\]

The exact identity $P_I(X)=WV_X-\sum_{dm\le X}\Lambda(d)A_m L_X(dm)$ and the proof above, with $A_m$ in place of $\lambda^m$, now give

\[
\limsup_{X\to\infty}\frac{P_I(X)-WX}{\sqrt X}
\ge \frac{m_\rho|B_I(\rho)|}{|\rho|}>0,
\qquad
\liminf_{X\to\infty}\frac{P_I(X)-WX}{\sqrt X}
\le-\frac{m_\rho|B_I(\rho)|}{|\rho|}<0. \tag{17}
\]

This keeps the original weight on $I$, but the cofactor sum remains the additional cumulative operation of the positive cone; it is not the original factorial quadratic/angular energy.

## Scope and sources

The finite cone positivity follows by Chebyshev rearrangement from the [full increasing-concave cone theorem](prime-cone-clock-variance-and-zero-annihilation.md); the corresponding positive zero-detecting budget, signed covariance identity and fixed compensated-clock interval are developed in the [companion cofactor-cone note](monotone-cofactor-positive-zero-detecting-cone.md). The [finite budget-shadow identity](BuildingBlocks/MonotoneCofactorCovarianceFinite.lean) is compiled in Lean with the actual von Mangoldt function and standard axioms. The new written assertion here is the quantitative, unconditional two-sided oscillation of that **actual** covariance, its parameter derivative, and its fixed-clock integral. It is an application of the classical positive-Mellin argument, not a new theorem about the location of zeros. For the positive-Mellin principle see [Suzuki, Proposition 1, §2.4](https://arxiv.org/html/2411.07436#S2.SS4); for critical-line zero existence and zeta's real-axis zero facts see [DLMF §25.10(i)](https://dlmf.nist.gov/25.10.i). The same residue-comparison method is used in this repository's [actual coherent-core fluctuation theorem](coherent-core-critical-zero-fluctuation.md).
