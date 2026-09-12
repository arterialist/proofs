# A common final interval for the actual successor resolvent under RH

Assume RH. For the literal completed source and compensated ordinary successor defined below, there is an $r_0<1$ such that
$$
\boxed{\overline P_r(\log x)\ge\frac1{100}
\min\left(1,\sqrt{\frac{(1-r)^{-1}}x}\right)>0
\quad(x\ge10000,\ r_0<r<1).}
\tag{1}
$$
The same final age interval works for every such $r$. The proof retains every critical zero with its actual multiplicity, every prime power in $\psi$, and the density and charge terms. In particular, it does not use a fixed-$r$ tail expansion uniformly as $r\uparrow1$.

Together with the forward implication in [the completed resolvent boundary theorem](actual-successor-resolvent-boundary-criterion.md), this proves that RH is equivalent to positivity of this actual difference primitive on a common final age interval for all $r$ sufficiently close to one. Even a sequence approaching one on a common final interval suffices for the forward implication. The arithmetic sign in (1) remains conditional on RH.

## 1. Exact arithmetic identity and its positive charge term

Write $x=e^v\ge1$ and
$$
g(x)=\frac{\psi(x)}x-1,\qquad a(v)=\sqrt x\,g(x),\qquad
a_0(v)=e^{-v/2}.
$$
All age functions are zero-extended to negative ages. For $v\ge0$ use the literal successor
$$
Sf(v)=\sqrt{\frac{x}{x+1}}f(\log(x+1)),\qquad
Cf=Sf-\kappa(f)a_0,\qquad
\kappa(f)=\frac12\int_0^\infty(Sf-f)(v)\,dv.
$$
Only relative charges are used. The completed source is not asserted to belong to $L^1$.

Let $e_j=\kappa(S^ja)$, $E(r)=\sum_{j\ge0}e_jr^j$, and
$$
q_j(x)=\frac12\int_x^\infty\frac{dy}{\sqrt y(y+j)}
=\begin{cases}x^{-1/2},&j=0,\\
j^{-1/2}\arctan\sqrt{j/x},&j>0,
\end{cases}
\qquad Q(r)=\sum_{j\ge0}r^jq_j(1).
$$
The all-$r$ construction gives, with $c_r=E(r)/Q(r)$,
$$
\overline g_r(x)=(1-r)\sum_{k\ge0}r^kg(x+k)
-r c_r\sum_{j\ge0}\frac{r^j}{x+j},
\qquad \overline a_r(v)=\sqrt x\,\overline g_r(x).
\tag{2}
$$
The correction $\overline a_r-a$ belongs to causal $L^1$ and has integral zero. Define
$$
\overline P_r(v)=\int_0^v(\overline a_r-a)(u)\,du.
$$
Set $n=(1-r)^{-1}$ and let $J$ have the geometric distribution
$\Pr(J=k)=(1-r)r^k$, $k\ge0$. Taking the tail of the zero-integral correction in (2) gives exactly
$$
\boxed{\overline P_r(\log x)=U_r(x)+2rE(r)B_r(x),}
\tag{3}
$$
$$
U_r(x)=\mathbb E T_J(x),\quad
T_k(x)=\int_x^\infty\frac{g(y)-g(y+k)}{\sqrt y}\,dy,
\quad B_r(x)=\frac{\sum_{j\ge0}r^jq_j(x)}{Q(r)}>0.
\tag{4}
$$
All sums and integrals here are literal. The elementary unit-shift bound
$|g(y+1)-g(y)|\le2\log(y+1)/(y+1)$ gives absolute integrability for each fixed $k$, and a polynomial bound in $k$ permits averaging with the geometric weights. Thus (3) does not split a conditionally convergent charge into separately divergent integrals.

The previous [conditional feedback theorem](successor-feedback-RH-converse.md) proves under RH that $E(r)>5/3$ for every sufficiently large $r<1$. The elementary geometric Riemann sums also give
$$
\frac{Q(r)}{\sqrt n}\longrightarrow\frac{\pi^{3/2}}2<2.8,
\qquad
\frac{\mathbb E\sqrt J}{\sqrt n}\longrightarrow\frac{\sqrt\pi}2<.89.
\tag{5}
$$
For the first limit use $q_j(1)\sim\pi/(2\sqrt j)$; for the second use $J/n\Rightarrow\operatorname{Exp}(1)$ and its uniformly exponentially bounded tails. Hence, throughout a sufficiently small interval below one,
$$
2rE(r)>3.3,\qquad Q(r)<2.8\sqrt n,
\qquad \mathbb E\sqrt J<.89\sqrt n.
\tag{6}
$$

For $z\ge0$,
$$
\arctan z\ge\frac{3z}{3+z^2};
$$
the derivative of the difference is $4z^4/[(1+z^2)(3+z^2)^2]\ge0$ and the difference vanishes at zero. Thus
$$
q_j(x)\ge\frac{x^{-1/2}}{1+j/(3x)}.
$$
Jensen's inequality and $\mathbb EJ=n-1$ yield
$$
B_r(x)\ge\frac{n}{Q(r)\sqrt x}
\frac1{1+(n-1)/(3x)}.
$$
Since $B_r$ decreases in $x$, (6) implies the useful uniform lower bound
$$
\boxed{2rE(r)B_r(x)>
\frac{99}{112}\min(1,\sqrt{n/x})
>.8839\min(1,\sqrt{n/x}).}
\tag{7}
$$
For $x\ge n$ use $1+(n-1)/(3x)\le4/3$; for $x\le n$ use the resulting bound at $x=n$.

## 2. Zero sums and the actual density remainder

All sums over $\rho=1/2+i\gamma$ below run over distinct nontrivial zeros and include both signs of $\gamma$. The multiplicity $m_\rho$ appears exactly once. Under RH the functional equation and canonical product give
$$
S_2:=\sum_\rho\frac{m_\rho}{1/4+\gamma^2}
=2+\gamma_E-\log(4\pi)<.047.
\tag{8}
$$
Since conjugate zeros occur in pairs, (8) implies $|\gamma|>6.5>2\pi$: a pair at height at most $6.5$ would contribute at least $2/42.5>.047$.

The [analytic three-halves moment theorem](zero-three-halves-moment-analytic-bound.md)
uses the paired canonical product to express
$$
S_{3/2}:=\sum_\rho\frac{m_\rho}{|\gamma|^{3/2}}
=\frac{\sqrt2}{\pi}\int_0^\infty t^{-1/2}
\frac1t\,\frac{\xi'}{\xi}(1/2+t)\,dt.
\tag{9}
$$
Positive Tonelli first permits infinite values; the proof bounds the
integral using (8) below $t=10$ and the actual logarithmic derivative
of $\xi$ above it. Euler's gamma integral and Jensen's inequality give
$\psi_{\mathrm{digamma}}(y)<\log y$, while the complete Mangoldt series
gives $\zeta'/\zeta(s)<0$ for real $s>1$. Retaining both rational
factors in $\xi'/\xi$ then yields
$$
\boxed{S_{3/2}<.509<.6.}
\tag{10}
$$
The deliberately coarser bound $.6$ suffices for the margins below.
No finite zero verification is required. A separate published
zero-counting proof of this coarse bound is retained in the appendix.

The classical explicit formula gives, as a distribution on $y>1$ and with half-values at prime powers,
$$
g(y)=-\sum_\rho\frac{m_\rho}{\rho}y^{i\gamma-1/2}
+g_{\mathrm{det}}(y),\qquad
g_{\mathrm{det}}(y)=-\frac{\log(2\pi)}y
-\frac{\log(1-y^{-2})}{2y}.
\tag{11}
$$
See [Suzuki, *On variants of Chebyshev's conjecture*, equation (36)](https://link.springer.com/article/10.1007/s11139-025-01238-9#Equ36), specialized to its parameter $s=0$. Changes at the countable prime-power endpoints do not change any integral in (3)–(4).

For $y\ge2$,
$$
|g_{\mathrm{det}}(y)|\le\frac2y,
\qquad
|U_r^{\mathrm{det}}(x)|\le\frac8{\sqrt x}\quad(x\ge2).
\tag{12}
$$
Indeed $\log(2\pi)-\frac12\log(3/4)<2$, and each of the two shifted integrals is bounded by $\int_x^\infty2y^{-3/2}dy$. This retains the explicit density, initial constant, and trivial-zero contribution.

We use (11) through its integrated form. The zero part of a primitive of $g(y)/\sqrt y$ is
$$
-\sum_\rho\frac{m_\rho}{\rho i\gamma}y^{i\gamma},
\tag{13}
$$
which converges absolutely and uniformly under RH. This fact justifies the integrations below without assuming that the unintegrated zero series is absolutely convergent. More explicitly,
$$
T_k(x)=\int_x^{x+k}\frac{g(y)}{\sqrt y}dy
+\int_{x+k}^\infty\frac{g(y)}{\sqrt y}
\left(1-\sqrt{\frac y{y-k}}\right)dy.
\tag{14}
$$
The piecewise weight on the right has finite total variation, tends to zero at infinity, and has its literal jump at $x+k$. Integrating by parts against (13) permits termwise evaluation, first at fixed $x,k$. The mode bounds proved next permit averaging over $J$ and the full zero sum. No prime-power term has been deleted.

## 3. Two bounds for one exact shifted zero mode

For real $\gamma\ne0$, $k\ge0$, and $x>0$, define
$$
I_\gamma(k,x)=\int_x^\infty
\left[y^{i\gamma-1/2}-(y+k)^{i\gamma-1/2}\right]\frac{dy}{\sqrt y}.
\tag{15}
$$
The difference is absolutely integrable at infinity. For $k=0$ it is zero. Put $L=k/x$ and $y_\gamma=|\gamma|$. We prove
$$
\boxed{|I_\gamma(k,x)|\le
\min\left(L,\frac{2\sqrt{1+L}}{y_\gamma}\right)
\le\frac85\sqrt{\frac{L}{y_\gamma}}\quad(y_\gamma\ge6),}
\tag{16}
$$
and
$$
\boxed{|I_\gamma(k,x)|\le\frac8{\sqrt{y_\gamma}}\quad(y_\gamma\ge6).}
\tag{17}
$$

For the second entry in the minimum, put $J_k(w)=\sqrt{(w+k)/w}$. Integration by parts gives
$$
I_\gamma(k,x)=\frac1{i\gamma}
\left[J_k(x)(x+k)^{i\gamma}-x^{i\gamma}
+\int_x^\infty J_k'(w)(w+k)^{i\gamma}dw\right].
$$
Since $J_k'\le0$ and $J_k(\infty)=1$, its absolute value is at most $2J_k(x)/y_\gamma$.

For the first entry, differentiate (15) in $k$ and set $z=w+k$. With $W_k(z)=\sqrt{z/(z-k)}$,
$$
\partial_k I_\gamma(k,x)
=-(i\gamma-1/2)\int_{x+k}^\infty W_k(z)z^{i\gamma-2}dz.
$$
Integrating once by parts and using $W_k'\le0$ gives
$$
|\partial_k I_\gamma(k,x)|\le
\frac{|i\gamma-1/2|}{|i\gamma-1|}
\left[\frac{2W_k(x+k)}{x+k}
-\int_{x+k}^\infty W_k(z)z^{-2}dz\right]
\le\frac{2}{x(1+\sqrt{1+k/x})}\le\frac1x.
$$
The displayed integral is elementary; the bracket equals the next displayed expression. Integrating from $k=0$ proves $|I|\le L$. To prove the last inequality of (16), put $t=y_\gamma L$. When $t\le64/25$, use $|I|\le L$. Otherwise the square of the ratio of $2\sqrt{1+L}/y_\gamma$ to $\sqrt{L/y_\gamma}$ is
$4/t+4/y_\gamma\le25/16+2/3<64/25$.

For (17), $L\le1$ is already covered by (16). For $L\ge1$ use the exact incomplete-beta identity
$$
I_\gamma(k,x)=-\frac{x^{i\gamma}}{i\gamma}
-k^{i\gamma}\mathrm B(1/2,-i\gamma)
+\int_0^x w^{-1/2}(w+k)^{i\gamma-1/2}dw.
\tag{18}
$$
It follows first by completing the beta integral in the strip where the separate integrals converge, then by analytic continuation to $i\gamma\ne0$; the difference integral in (15) is holomorphic throughout the intervening strip. Equivalently, one may differentiate both sides in $x$ and determine the constant by that beta identity.

By conjugation it suffices to take $\gamma>0$. Set $a=\sqrt{x/k}\le1$. The last integral in (18) is
$$
2k^{i\gamma}\int_0^a(1+w^2)^{-1/2}
e^{i\gamma\log(1+w^2)}dw.
$$
Split at $b=\gamma^{-1/2}$. The piece below $b$ has absolute value at most $2/\sqrt\gamma$. Above $b$, the amplitude divided by the phase derivative is $\sqrt{1+w^2}/(2w)$, positive and decreasing. One integration by parts therefore bounds that piece, including the outside factor two, by
$2\sqrt{1+b^2}/(\gamma b)\le2\sqrt{7/6}/\sqrt\gamma$.
Gamma reflection gives
$$
|\mathrm B(1/2,-i\gamma)|^2=\frac{\pi\coth(\pi\gamma)}\gamma
\le\frac{2\pi}\gamma<\frac7\gamma.
$$
Together with $1/\gamma\le1/(\sqrt6\sqrt\gamma)$ these estimates prove (17).

Equations (13)–(17) now justify the exact, absolutely convergent expression
$$
\boxed{U_r(x)=-\sum_\rho\frac{m_\rho}{\rho}
\mathbb E I_\gamma(J,x)+U_r^{\mathrm{det}}(x).}
\tag{19}
$$
The bound (17) and (10) provide a summable majorant independent of both $x$ and $r$ for its zero part.

## 4. Uniform control above the averaging scale

For $x\ge n$, (16), (6), and (10) give directly
$$
\begin{aligned}
|U_r^{\mathrm{zero}}(x)|
&\le\frac85\frac{\mathbb E\sqrt J}{\sqrt x}
\sum_\rho\frac{m_\rho}{|\rho|\sqrt{|\gamma|}}\\
&<\frac85\cdot.89\cdot.6\sqrt{n/x}
=.8544\sqrt{n/x}.
\end{aligned}
\tag{20}
$$
This controls the entire range $x/n\ge1$, including arbitrarily large $x/n$. It is not obtained by taking an $x\to\infty$ asymptotic at fixed $r$.

## 5. Uniform averaging down to $x/n=0$

For $u>0$, define the continuum mode
$$
\mathcal I_\gamma(u)=\int_0^\infty e^{-t}I_\gamma(t,u)dt.
\tag{21}
$$
For each fixed $\gamma\ne0$, the geometric Riemann sums satisfy
$$
\sup_{0<u\le1}
\left|\mathbb E I_\gamma(J/n,u)-\mathcal I_\gamma(u)\right|
\longrightarrow0.
\tag{22}
$$
Here is the endpoint argument. In (18), subtract the common term $-u^{i\gamma}/(i\gamma)$. For every $t>0$, the remaining function extends continuously to $u=0$, with value
$-t^{i\gamma}\mathrm B(1/2,-i\gamma)$. It is uniformly continuous on $t\in[\epsilon,M]$, $u\in[0,1]$. Ordinary geometric Riemann sums therefore converge uniformly there. By (17), the remaining function is bounded by $8/\sqrt{|\gamma|}+1/|\gamma|$. The masses of $t<\epsilon$ are at most $O(\epsilon)+O(1/n)$ and the masses of $t>M$ are exponentially small, uniformly in $n$. The atom $J=0$ has mass $1/n$ and causes no problem. Sending first $n\to\infty$, then $\epsilon\downarrow0$ and $M\to\infty$ proves (22). Both measures have total mass one, so the subtracted oscillatory term cancels exactly.

Homogeneity gives $I_\gamma(J,nu)=n^{i\gamma}I_\gamma(J/n,u)$. Truncate the zero sum, use (22) on the finitely many retained ordinates, and use (17), (10) for its tail. This proves
$$
\sup_{0<u\le1}\left|
U_r^{\mathrm{zero}}(nu)+
\sum_\rho\frac{m_\rho}{\rho}n^{i\gamma}\mathcal I_\gamma(u)
\right|\longrightarrow0.
\tag{23}
$$
No rate uniform in the zero height is required; summability supplies the last passage.

The full continuum zero contribution is small. Average (18) over $t$ and use
$$
\mathrm B(1/2,-i\gamma)\Gamma(1+i\gamma)=2M(i\gamma),
$$
where $M$ is the exact multiplier in the preceding feedback proof. This gives
$$
\mathcal I_\gamma(u)=-\frac{u^{i\gamma}}{i\gamma}
-2M(i\gamma)+\int_0^u y^{-1/2}
\int_0^\infty e^{-t}(y+t)^{i\gamma-1/2}dt\,dy.
\tag{24}
$$
One integration by parts in $t$ gives
$$
\int_0^\infty e^{-t}(y+t)^{i\gamma-1/2}dt
=\frac{-y^{i\gamma+1/2}
+\int_0^\infty e^{-t}(y+t)^{i\gamma+1/2}dt}{i\gamma+1/2}.
$$
Using $\sqrt{y+t}\le\sqrt y+\sqrt t$ then integrating in $y$ shows that the last term of (24) has absolute value at most
$$
\frac{2u+\sqrt\pi\sqrt u}{|\rho|}.
\tag{25}
$$
The preceding feedback theorem proved $\sum_\rho m_\rho|M(i\gamma)|/|\rho|<.001$. Also $|\rho|/|\gamma|<1.01$ for $|\gamma|>6$. Consequently, uniformly for $0<u\le1$,
$$
\begin{aligned}
\sum_\rho\frac{m_\rho}{|\rho|}|\mathcal I_\gamma(u)|
&\le1.01S_2+.002+(2+\sqrt\pi)S_2\\
&<(1.01+3.78)\cdot.05+.002<.25.
\end{aligned}
\tag{26}
$$
Combining (23) and (26), for all sufficiently large $n$,
$$
\boxed{|U_r^{\mathrm{zero}}(x)|<.26\qquad(0<x\le n).}
\tag{27}
$$
Only the mathematical zero modes are evaluated below $x=1$ in this auxiliary estimate. The actual source is used in (19) only on its domain $x\ge2$.

## 6. Common final interval and the joint profile

Increase the single threshold for $n$ so that (6), (27), and $8/\sqrt n<.01$ all hold. If $10000\le x\le n$, equations (7), (12), and (27) give
$$
\overline P_r(\log x)>.8839-.26-.08>.54.
$$
If $x\ge n$, equations (7), (12), and (20) give
$$
\overline P_r(\log x)>
(.8839-.8544-.01)\sqrt{n/x}>.019\sqrt{n/x}.
$$
These estimates imply (1), after increasing the same threshold to have $n\ge10000$. They use no restriction on how fast $x$ may grow relative to $n$.

There is also an exact joint-scale description of the cancellation. For $u>0$ set
$$
\mathcal B(u)=\frac2{\pi^{3/2}}
\int_0^\infty e^{-t}\frac{\arctan\sqrt{t/u}}{\sqrt t}dt.
$$
Then $B_r(nu)\to\mathcal B(u)$ locally uniformly on $u>0$. From the conditional feedback expansion, with
$b_\rho=-m_\rho M(i\gamma)/\rho$ and
$C_*=\zeta'(1/2)/\zeta(1/2)-1$, one obtains
$$
\boxed{\begin{aligned}
\overline P_r(\log(nu))
={}&2C_*\mathcal B(u)\\
&-\sum_\rho\frac{m_\rho}{\rho}n^{i\gamma}
\left[\mathcal I_\gamma(u)+2M(i\gamma)\mathcal B(u)\right]+o(1).
\end{aligned}}
\tag{28}
$$
The error is uniform on compact subsets of $u>0$. To replace $(-\log r)^{-i\gamma}$ by $n^{i\gamma}$ in the feedback expansion, use $n(-\log r)=1+O(1/n)$ and the proved convergence of $\sum|\gamma b_\rho|$. The deterministic term in (12) tends uniformly to zero on such compact sets. The series in (28) is absolutely convergent. It includes the interference between the shifted actual source and its charge feedback.

Formula (28) alone would not control either $u\downarrow0$ or $u\to\infty$. The bounds in Sections 4–5 supply precisely those two uniform endpoints. Thus the positive common-final-interval conclusion is stronger than positive scalar feedback or separate fixed-parameter tails. It remains a conditional calibration of this actual successor family, and supplies no unconditional RH sign.

The [all-positive-age continuation](successor-resolvent-all-ages-RH-converse.md)
fills the bounded initial interval, including a bound normalized at
$v=0$. Under RH, the primitive is positive for every $v>0$ once $r$
is sufficiently close to one.

## Appendix: the alternate published zero-counting bound

An independent route to the coarse bound $S_{3/2}<.6$ uses
[Brent–Platt–Trudgian, *The mean square of the error term in the prime number theorem*, Corollary 1](https://arxiv.org/pdf/2008.06140):
$$
N(T)\le\frac T{2\pi}\left(\log\frac T{2\pi}-1\right)
+\frac78+.28\log T\qquad(T>2\pi).
\tag{A1}
$$
Their proof combines an analytic bound at large height with prior
interval-arithmetic verification below $1.03\cdot10^8$. This is a
published bound; no new zero computation is made here. It is not
needed by the analytic proof in (9)–(10).

Put $T_0=2\pi$. Since (8) gives $N(T_0)=0$, integration by parts
against (A1), counting all multiplicities, gives
$$
S_{3/2}=3\int_{T_0}^\infty N(t)t^{-5/2}dt
\le\frac3{\pi\sqrt{T_0}}+
T_0^{-3/2}\left[\frac74+
\frac{21}{25}\left(\frac23\log T_0+\frac49\right)\right]
<.6.
\tag{A2}
$$
The elementary inequalities $\pi>3.14$, $\sqrt{T_0}>2.5$, and
$\log T_0<1.84$ bound the displayed expression by $.584$.

## Proof and formal scope

This is a written proof for the literal completed arithmetic source. The [formal feedback source and clock chain](successor-feedback-tail-Abel-poles.md#formal-positive-age-laplace-profile) proves its stated source, relative-charge and initial transform identities. It does not formalize this critical-zero expansion, its uniform resolvent estimates or the RH equivalence.
