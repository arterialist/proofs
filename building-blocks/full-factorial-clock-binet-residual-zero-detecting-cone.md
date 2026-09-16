# A full-clock Binet remainder that keeps every zeta-zero mode

RH Proof research note, 16 September 2026. The calculation starts with the **entire original compensated factorial clock**, including its singular endpoint compensation. It produces a bounded increasing cofactor weight with an explicit zero-free Dirichlet remainder and a positive finite divisor-cone budget for the complete von Mangoldt source. The resulting square-root upper bound is still RH-equivalent and unproved. The Binet and analytic arguments below are written mathematics, not Lean-formalized; the existing finite cofactor identities are linked at the end.

## The exact cumulative clock

For $t>0$ let

\[
 w(t)=\frac1{t^2}-\frac1{t(e^t-1)}>0,
 \qquad k(0)=0,\qquad
 k(m)=\int_0^\infty w(t)(1-e^{-mt})\,dt\quad(m\ge1). \tag{1}
\]

The integral converges: $w(t)=O(t^{-1})$ at zero and $w(t)=O(t^{-2})$ at infinity. Its one-step admissions are the coefficients already evaluated in the [exact quotient renewal calculation](factorial-mobius-quotient-renewal.md):

\[
 k(1)=c_1=1,\qquad
 k(j)-k(j-1)=c_j=1-(j-1)\log\frac j{j-1}\quad(j\ge2). \tag{2}
\]

Summing (2), including its $j=1$ endpoint, telescopes exactly:

\[
 \boxed{k(m)=m-m\log m+\log(m!)\qquad(m\ge1).} \tag{3}
\]

Thus the full-clock cumulative admission is the Stirling entropy deficit, rather than an independently chosen geometric cofactor. The increments in (2) are strictly positive and decrease, so $k$ increases and is discretely concave. In particular, the original clock gives a positive cofactor order law before any asymptotic approximation.

[FactorialClockCofactorFinite.lean](BuildingBlocks/FactorialClockCofactorFinite.lean) compiles (3) from the exact displayed admissions and proves their one-step factorial/logarithm recurrence, including $m=0,1$. Its connection to the improper integral (1) still rests on the written evaluation (2).

## Removing the deterministic Stirling modes

Define, for integers $m\ge1$,

\[
 r(m)=k(m)-\frac12\log(2\pi m)-\frac1{12m}.
 \tag{4}
\]

[Binet's exact integral formula, DLMF 5.9.10](https://dlmf.nist.gov/5.9.E10), applied to $\Gamma(m)$ and then multiplied by $m$, gives

\[
 \boxed{r(m)=2\int_0^\infty
 \frac{\arctan(t/m)-t/m}{e^{2\pi t}-1}\,dt.} \tag{5}
\]

The subtraction is exact because
$2\int_0^\infty t/(e^{2\pi t}-1)\,dt=1/12$.
Put $h(x)=\arctan x-x$. It is strictly negative and strictly decreasing for $x>0$. Since $t/m$ decreases with $m$, (5) proves

\[
 r(1)<r(2)<\cdots<0,\qquad r(m)\longrightarrow0. \tag{6}
\]

The elementary inequalities, valid for every $x\ge0$,

\[
 \frac{x^3}{3}-\frac{x^5}{5}
 \le x-\arctan x\le\frac{x^3}{3}, \tag{7}
\]

follow by integrating $x^2-x^4\le x^2/(1+x^2)\le x^2$. The two moments needed in (5) are

\[
 \int_0^\infty\frac{t^3}{e^{2\pi t}-1}\,dt=\frac1{240},
 \qquad
 \int_0^\infty\frac{t^5}{e^{2\pi t}-1}\,dt=\frac1{504}. \tag{8}
\]

They follow by expanding the denominator into positive exponentials and using $\Gamma(4)\zeta(4)/(2\pi)^4$ and $\Gamma(6)\zeta(6)/(2\pi)^6$. Equations (5)--(8) give the explicit separation

\[
 0<-r(m)<\frac1{360m^3},\qquad
 -r(1)>2\left(\frac1{720}-\frac1{2520}\right)=\frac1{504}.
 \tag{9}
\]

Consequently the Dirichlet series

\[
 R(s)=\sum_{m\ge1}\frac{r(m)}{m^s} \tag{10}
\]

is holomorphic for $\Re s>-2$. Its first coefficient dominates **uniformly on the closed right half-plane**. For $\Re s\ge0$,

\[
 \begin{aligned}
 |R(s)|
 &\ge -r(1)-\sum_{m\ge2}|r(m)|m^{-\Re s}\\
 &>\frac1{504}-\frac1{360}
 \left(\frac18+\int_2^\infty x^{-3}\,dx\right)
 =\boxed{\frac{13}{10080}}>0. \tag{11}
 \end{aligned}
\]

No assertion about zeros of $\zeta$ is used in (11). This is an explicit nonannihilation bound for any zeta zero in the critical strip.

## A positive full-source cofactor cone

Fix $\epsilon>0$ so that even the direct $m=1$ prime arrivals are retained, and set

\[
 a_\epsilon(m)=\epsilon+r(m)-r(1),\qquad
 c_\epsilon=\epsilon-r(1)>0.
 \tag{12}
\]

Equation (6) says $a_\epsilon$ is strictly increasing, with $a_\epsilon(1)=\epsilon$ and $\epsilon\le a_\epsilon(m)<c_\epsilon$. More explicitly, (5) writes its nonconstant part as an integral of the positive admission

\[
 a_\epsilon(m)-\epsilon
 =2\int_0^\infty
 \frac{(t-\arctan t)-(t/m-\arctan(t/m))}
 {e^{2\pi t}-1}\,dt\ge0. \tag{13}
\]

For an integer horizon $X\ge2$, let $\ell_X=X^{-1}\log(X!)$ and $L_X(n)=\log n-\ell_X$. The [increasing-cofactor finite cone theorem](prime-cone-clock-variance-and-zero-annihilation.md) applies to $a_\epsilon$ and the increasing concave test $\log$, so every inner row

\[
 K_{X,\epsilon}(d)
 =\sum_{m\le X/d}a_\epsilon(m)L_X(dm)\ge0
 \qquad(1\le d\le X). \tag{14}
\]

In particular the **actual complete** prime-power budget is nonnegative:

\[
 P_\epsilon(X)=\sum_{d\le X}\Lambda(d)K_{X,\epsilon}(d)\ge0. \tag{15}
\]

The source in (15) includes every ordinary prime, every proper prime power, and every multiplicative cofactor. No $m=1$ term is dropped. The corresponding Dirichlet cofactor multiplier, initially for $\Re s>1$, is

\[
 A_\epsilon(s)=\sum_{m\ge1}\frac{a_\epsilon(m)}{m^s}
 =c_\epsilon\zeta(s)+R(s). \tag{16}
\]

At any nontrivial zeta zero $\rho$, analytic continuation gives
$A_\epsilon(\rho)=R(\rho)$; hence (11) shows

\[
 |A_\epsilon(\rho)|>\frac{13}{10080}. \tag{17}
\]

This uniform separation makes the cone zero-detecting even though every finite row is nonnegative. The added $\epsilon$ preserves the latest direct births and changes only the $\zeta$ summand, which vanishes at every zeta zero.

## The exact signed consumer and its scale

The divisor identity $\Lambda*1=\log$ gives the finite, centered decomposition

\[
 \begin{aligned}
 P_\epsilon(X)&=c_\epsilon V_X+C_r(X),\\
 V_X&=\sum_{n\le X}L_X(n)^2=X+O(\log^2X),\\
 C_r(X)&=\sum_{dm\le X}\Lambda(d)r(m)L_X(dm).
 \end{aligned} \tag{18}
\]

The sign of $C_r$ is not fixed. Elementary Chebyshev estimates give $C_r(X)=O(X)$, and the prime number theorem with the summable $r(m)/m$ yields $C_r(X)=o(X)$. Thus $P_\epsilon(X)\sim c_\epsilon X$, despite the positive order law. As in the [geometric cofactor criterion](monotone-cofactor-positive-zero-detecting-cone.md), the desired improvement is precisely

\[
 \boxed{\mathrm{RH}\ \Longleftrightarrow\
 P_\epsilon(X)-c_\epsilon X
 =O_{\epsilon,\delta}(X^{1/2+\delta})
 \text{ for every }\delta>0.} \tag{19}
\]

Here is the analytic reduction, to fix the exact consumer rather than assume it. For real $x\ge1$ put

\[
 H_r(x)=\sum_{dm\le x}\Lambda(d)r(m)
   (\log(dm)-\log x+1). \tag{20}
\]

The bound $\sum_m|r(m)|/m<\infty$ and Chebyshev's $\psi(y)\ll y$ justify the Mellin transform for $\Re s>1$:

\[
 \int_1^\infty H_r(x)x^{-s-1}\,dx
 =\frac{s-1}{s^2}
 \left(-\frac{\zeta'(s)}{\zeta(s)}\right)R(s). \tag{21}
\]

The integer centering difference $C_r(X)-H_r(X)$ is $O(\log X)$ because the coefficient prefix is $O(X)$; between integers the change in $H_r$ is $O(1)$. Therefore the bound in (19) makes (21) holomorphic on $\Re s>1/2$. At any zero $\rho$ with $\Re\rho>1/2$, its right side has a genuine pole by (11), so no such zero exists. The functional equation then gives RH.

Conversely, on RH, write $\Delta(y)=\psi(y)-y=O(\sqrt y\log^2(2y))$. Exact partial summation for $Y=X/m$ gives

\[
 \sum_{d\le Y}\Lambda(d)L_X(dm)
 =(b_X-1)Y+1+b_X\Delta(Y)
   -\int_1^Y\frac{\Delta(t)}t\,dt,
 \qquad b_X=\log X-\ell_X=1+O(\log X/X). \tag{22}
\]

Multiplying (22) by $r(m)$ and summing $m\le X$ proves
$C_r(X)=O(\sqrt X\log^2(2X))$ because
$\sum_m|r(m)|m^{-1/2}<\infty$. Equation (18) proves the forward direction of (19). No part of this argument establishes the upper bound unconditionally.

The nonzero critical-line residue also yields a quantitative **unconditional lower-scale calibration**. For every zero $\rho=1/2+i\gamma$ of multiplicity $m_\rho$, the positive-Mellin residue comparison in the [critical-zero oscillation proof](monotone-cofactor-covariance-critical-oscillation.md), now with $R$ replacing the geometric factor, gives

\[
 \limsup_{X\to\infty}\frac{P_\epsilon(X)-c_\epsilon X}{\sqrt X}
 \ge\frac{m_\rho|R(\rho)|}{|\rho|}
 >\frac{13m_\rho}{10080|\rho|},\qquad
 \liminf_{X\to\infty}\frac{P_\epsilon(X)-c_\epsilon X}{\sqrt X}
 \le-\frac{m_\rho|R(\rho)|}{|\rho|}. \tag{23}
\]

The $O(\log^2 X)$ variance error does not affect these limits. Hardy's critical-line zero theorem makes (23) unconditional. It is a lower oscillation result, not an upper estimate or a proof of RH.

The full-clock identity (3), Binet's correction (5), and the zero-free bound (11) are the specific mechanism here. The finite telescoping in (3) is compiled in the new module. The finite covariance identity is an instance of [MonotoneCofactorCovarianceFinite.lean](BuildingBlocks/MonotoneCofactorCovarianceFinite.lean), whose geometric version is compiled; the improper-integral identification (2), Binet bound, analytic criterion, and oscillation (23) are not formalized. The cofactor covariance is an additional observable built from the original clock. It has not been identified with, or bounded by, the original factorial quadratic/angular energy or the Goldbach additive-pair norm.
