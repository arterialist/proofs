# A positive divisor-cone weight that keeps zeta-zero modes

The [finite divisor-cone theorem](../factorial-and-renewal/prime-cone-clock-variance-and-zero-annihilation.md) allows increasing weights on the cofactor. One such weight preserves every relevant zeta-zero pole. Its positive prime-power budget has an unconditional prime-number-theorem error, but the centered $O(X^{1/2+\epsilon})$ bound is still RH-equivalent and unproved. This is a counterexample to the claim that cone positivity must erase zeros.

Fix $0<\lambda<1/2$ and an integer $X\ge2$. Write
$$
k_\lambda(m)=1-\lambda^m,\qquad
\ell_X=\frac1X\log(X!),\qquad
K_{X,f,\lambda}(d)=\sum_{m\le X/d}k_\lambda(m)(f(dm)-\bar f_X),
\quad \bar f_X=\frac1X\sum_{n\le X}f(n). \tag{1}
$$
The sum is zero for $d>X$. If $f$ is increasing and concave on $[1,X]$, then
$$
\boxed{K_{X,f,\lambda}(d)\ge0\qquad(1\le d\le X).} \tag{2}
$$
Indeed, with $Q=\lfloor X/d\rfloor$, both $k_\lambda(m)$ and $f(dm)$ increase with $m$. Chebyshev's finite rearrangement inequality says that the $k_\lambda$-weighted mean of $f(d),\ldots,f(dQ)$ is at least its uniform mean. The uniform cone mean is at least $\bar f_X$ by the published increasing-concave cone theorem. Multiplying by $\sum_{m\le Q}k_\lambda(m)>0$ proves (2). The finite hard endpoint and every cofactor are retained.

There is an exact positivity **floor**, which limits what this order law can prove. For any nondecreasing cofactor weights $a(m)\ge0$ with $a(1)>0$, write $a(m)=a(1)+v(m)$, where $v$ is nonnegative and nondecreasing. Apply the same rearrangement argument to $v$ to obtain
$$
K_{X,f,a}(d)\ge a(1)K_{X,f,1}(d)\ge0. \tag{2a}
$$
For $k_\lambda$, $a(1)=1-\lambda$, so the positive prime-power budget below satisfies $P_\lambda(X)\ge(1-\lambda)X-O_\lambda(\log^2X)$. Positivity therefore gives an $X$-scale baseline, not the $\sqrt X$ accuracy in (9). Even the separate PNT asymptotic $P_\lambda(X)=X+o(X)$ allows an error such as $X/\log X$; a bound at the scale in (9) must use additional signed arithmetic information. If $a(1)$ is made very small in a different kernel, its Dirichlet-convolution inverse has coefficient $1/a(1)$ at the unit, so a uniform inverse cannot gain from that change alone.

Take $f(n)=\log n$ and abbreviate $K_{X,\lambda}=K_{X,\log,\lambda}$. The complete von Mangoldt source, including all proper powers, has a positive budget
$$
P_\lambda(X)=\sum_{d\le X}\Lambda(d)K_{X,\lambda}(d)\ge0,
\qquad P_\lambda(X)\ll_\lambda X,
\qquad P_\lambda(X)=X+O_\lambda\!\left(Xe^{-c_\lambda\sqrt{\log X}}\right)
\quad\text{for some }c_\lambda>0. \tag{3}
$$
To prove the upper bound, let $K_{X,1}(d)=\sum_{m\le X/d}(\log(dm)-\ell_X)$ denote the unweighted cone. Its exact variance identity gives $\sum_d\Lambda(d)K_{X,1}(d)=X+O(\log^2X)$. Since $k_\lambda=1-\lambda^m$,
$$
P_\lambda(X)=X+O(\log^2X)-\sum_{m\le X}\lambda^m T_m(X),
\quad T_m(X)=\sum_{d\le X/m}\Lambda(d)(\log(md)-\ell_X). \tag{4}
$$
With $Y=X/m$ and $b_X=\log X-\ell_X\in[0,1]$, Stieltjes partial summation is exact:
$$
T_m(X)=b_X\psi(Y)-\int_1^Y\frac{\psi(t)}t\,dt. \tag{5}
$$
The elementary Chebyshev bound $\psi(t)\ll t$ gives $|T_m(X)|\ll X/m$; summing $\lambda^m/m$ proves the $O(X)$ part of (3). For each fixed $m$, the PNT and $b_X\to1$ give $T_m(X)=o(X/m)$. The same uniform $O(X/m)$ bound and the summable weights $\lambda^m/m$ permit dominated convergence, proving $P_\lambda(X)=X+o_\lambda(X)$. The quantified remainder in (3) follows from the signed calculation (16)--(17) below. The original leading $X$-scale budget survives. Equation (3) does not bound a centered prime-minus-density score at square-root scale.

The matching **density** budget already has a square-root remainder without any prime hypothesis beyond the published cone theorem and the elementary divisor estimate:
$$
\mathcal D_\lambda(X):=\sum_{d\le X}K_{X,\lambda}(d)
=X+O_\lambda(\sqrt X). \tag{5a}
$$
For the unweighted cone, the exact variance and the divisor-hyperbola bound for $\sum_n(\log n-\tau(n))(\log n-\ell_X)$ give $\mathcal D_1(X)=X+O(\sqrt X)$. The deformation subtracts $\sum_{m\le X}\lambda^m U_m(X)$, where $U_m=\sum_{d\le X/m}(\log(md)-\ell_X)$. Put $N=\lfloor X/m\rfloor$ and $Y=X/m$. Stirling gives
$$
U_m=N(b_X-1)+N\log(N/Y)+O(\log(2N))=O(\log(2X)),
$$
uniformly in $m\le X$: $b_X-1=O(\log X/X)$ and $-1\le N\log(N/Y)\le0$. The exponential weights make their sum $O_\lambda(\log X)$, proving (5a). Thus the unknown square-root fluctuation of the positive prime-power budget is exactly the unknown centered score, up to an unconditional $O(\sqrt X)$ term.

Let $a(n)=\Lambda(n)-1$, including $a(1)=-1$, and let $c_\lambda=a*k_\lambda$ be Dirichlet convolution. The centered cone score is exactly
$$
E_\lambda(X):=\sum_{d\le X}a(d)K_{X,\lambda}(d)
=\sum_{n\le X}c_\lambda(n)(\log n-\ell_X). \tag{6}
$$
For $\Re s>1$, its coefficient Dirichlet series is
$$
F_\lambda(s)=\sum_{n\ge1}\frac{c_\lambda(n)}{n^s}
=\left(-\frac{\zeta'(s)}{\zeta(s)}-\zeta(s)\right)
  \left(\zeta(s)-\operatorname{Li}_s(\lambda)\right),
\quad \operatorname{Li}_s(\lambda)=\sum_{m\ge1}\frac{\lambda^m}{m^s}. \tag{7}
$$
At any zeta zero $\rho$ with $\Re\rho\ge1/2$, the second factor is $-\operatorname{Li}_\rho(\lambda)$ and is nonzero. In fact, uniformly on $\Re s\ge0$,
$$
|\operatorname{Li}_s(\lambda)|
\ge\lambda-\frac{\lambda^2}{1-\lambda}
=\frac{\lambda(1-2\lambda)}{1-\lambda}>0. \tag{8}
$$
Thus the positive cone weight (2) does **not** annihilate the prime-error poles. The crucial difference from the original all-cofactor kernel is the small increasing deformation $1-\lambda^m$.

Nevertheless its desired centered estimate is still an RH criterion:
$$
\boxed{\begin{aligned}
\mathrm{RH}
&\quad\Longleftrightarrow\quad
 E_\lambda(X)=O_{\lambda,\epsilon}(X^{1/2+\epsilon})
 \text{ for every }\epsilon>0\\
&\quad\Longleftrightarrow\quad
 P_\lambda(X)=X+O_{\lambda,\epsilon}(X^{1/2+\epsilon})
 \text{ for every }\epsilon>0.
\end{aligned}} \tag{9}
$$
For the converse implication, put $C_\lambda(x)=\sum_{n\le x}c_\lambda(n)$ and $J_\lambda(x)=\int_1^x C_\lambda(t)dt/t$. Finite partial summation gives, at every integer $X$,
$$
E_\lambda(X)=b_XC_\lambda(X)-J_\lambda(X),
\qquad b_X=1+O(\log X/X). \tag{10}
$$
The trivial $|a(n)|\le1+\log n$ and $0\le k_\lambda\le1$ give $C_\lambda(x)\ll x\log^2(2x)$ in absolute value. Hence (9)'s assumed bound makes $H_\lambda(x):=C_\lambda(x)-J_\lambda(x)=O_{\lambda,\epsilon}(x^{1/2+\epsilon})$ first at integers. Also $|c_\lambda(n)|\le(1+\log n)\tau(n)\ll_\epsilon n^\epsilon$, while $|J_\lambda(x+1)-J_\lambda(x)|\ll\log^2(2x)$. These bounds extend the estimate for $H_\lambda$ to every real $x\ge1$. Initially for $\Re s>1$,
$$
\int_1^\infty H_\lambda(x)x^{-s-1}dx
=\frac{s-1}{s^2}F_\lambda(s). \tag{11}
$$
The bound on $H_\lambda$ makes the left side analytic on $\Re s>1/2$. At a zeta zero $\rho$ in that half-plane, $-\zeta'/\zeta$ has a nonzero simple pole, the factor in (8) is nonzero, and $(\rho-1)/\rho^2\ne0$. Equation (11) excludes such a zero; the functional equation gives RH.

For the forward implication, the ordinary divisor hyperbola estimate gives
$\sum_{n\le x}(\log n-\tau(n))=-2\gamma x+O(\sqrt x+\log(2x))$, where $\gamma$ is Euler's constant. Since $k_\lambda(m)=1-\lambda^m$,
$$
C_\lambda(x)=\sum_{n\le x}(\log n-\tau(n))
-\sum_{m\le x}\lambda^m\bigl(\psi(x/m)-\lfloor x/m\rfloor\bigr).
$$
Under RH, the complete Chebyshev error is $O(\sqrt y\log^2(2y))$, so
$C_\lambda(x)=-2\gamma\lfloor x\rfloor+O_\lambda(\sqrt x\log^2(2x))$. The constant sequence $-2\gamma$ pairs to zero with $\log n-\ell_X$ by definition of $\ell_X$. Apply partial summation to the remaining cumulative error to obtain $E_\lambda(X)\ll_\lambda\sqrt X\log^2(2X)$, proving the forward direction. The unconditional positive budget (3) is only $O(X)$; it leaves the square-root improvement in (9) untouched.

The connection to the original factorial clock is limited and exact. The weight $1-\lambda^m$ is the **cumulative** geometric admission probability through age $m$. The original horizon field instead uses $1-\lambda^{\lfloor N/d\rfloor}=\sum_{m\le N/d}(1-\lambda)\lambda^{m-1}$ once per root $d$; its individual cofactor weights decrease in $m$. Equation (1) sums the cumulative probability again over all cofactors and pairs it with a log-clock covariance. The fixed-$\lambda$ form has neither the original weight $w(t)dt$ nor the central angular factor $|1-re^{i\theta}|^{-2}$. Replacing the decreasing original weights by (1) is not a bound for the RH-equivalent shrinking-arc energy. A transfer between these two exact forms remains unproved.

One can retain the **actual compensated factorial weight** on a fixed hard-clock interval without losing zero detection. Let $I=[\log4,\log4+1]$, $w(t)=t^{-2}-[t(e^t-1)]^{-1}>0$, and $W=\int_Iw(t)dt$. Define
$$
\mathcal K_{X,I}(d)=\int_Iw(t)K_{X,e^{-t}}(d)dt,
\qquad P_I(X)=\sum_{d\le X}\Lambda(d)\mathcal K_{X,I}(d).
$$
Every $\mathcal K_{X,I}(d)$ is nonnegative. Integrating (3) and (5a) gives $P_I(X)=WX+o(X)$ and $\sum_d\mathcal K_{X,I}(d)=WX+O(\sqrt X)$. The cofactor Dirichlet multiplier is
$$
W\zeta(s)-B_I(s),\qquad
B_I(s)=\int_Iw(t)\operatorname{Li}_s(e^{-t})dt.
$$
On $\Re s\ge0$, the $m=1$ term of $B_I$ has size $A_1=\int_Iw(t)e^{-t}dt$, while the rest has absolute value at most $A_1/3$ because $e^{-t}\le1/4$. Thus $|B_I(s)|\ge2A_1/3>0$. The proof of (9), with clock integration inside the finite coefficient sums, yields
$$
\boxed{\mathrm{RH}\quad\Longleftrightarrow\quad
P_I(X)=WX+O_\epsilon(X^{1/2+\epsilon})
\text{ for every }\epsilon>0.} \tag{12}
$$
Equation (12) uses the original $w(t)dt$ on $I$, but its cofactor sum remains the extra cumulative operation in (1). It is not the original all-clock, central-angular energy.

## The signed covariance left by the positive cone

Define the complete geometric prime-power shadow
$$
R_\lambda(n)=\sum_{d\mid n}\Lambda(d)\lambda^{n/d},
\qquad L_X(n)=\log n-\ell_X.
$$
The divisor identity $\sum_{d\mid n}\Lambda(d)=\log n$ gives the exact decomposition
$$
\boxed{P_\lambda(X)=\sum_{n\le X}L_X(n)^2
 -\sum_{n\le X}L_X(n)R_\lambda(n).} \tag{13}
$$
The first term is $X+O(\log^2X)$. Thus the positive-budget target in (9) is exactly the signed covariance target
$$
\sum_{n\le X}L_X(n)R_\lambda(n)
=O_{\lambda,\epsilon}(X^{1/2+\epsilon})
\quad\text{for every }\epsilon>0. \tag{14}
$$
Neither $L_X$ nor this covariance has a fixed sign. On a prime $p$, $R_\lambda(p)=\lambda\log p$. The ordinary-prime part of the top interval is already a coherent positive load:
$$
\sum_{X/2<p\le X}L_X(p)R_\lambda(p)
=\frac{\lambda\log2}{2}X+o_\lambda(X). \tag{15}
$$
This follows from the PNT and $\ell_X=\log X-1+o(1)$; proper prime powers remain in (13) and have $o(X)$ total contribution on this interval. The lower prime-power ranges and composite quotient histories must cancel the order-$X$ top load before the square-root remainder in (14) can appear.

There is a genuine, but insufficient, unconditional signed estimate here. Write $\Delta(y)=\psi(y)-y$ and $b_X=\log X-\ell_X$. Rearranging the exact formula (5) gives
$$
\begin{aligned}
\sum_{n\le X}L_X(n)R_\lambda(n)
={}&\sum_{m\le X}\lambda^m\left[b_X\Delta(X/m)
-\int_1^{X/m}\frac{\Delta(t)}t\,dt\right]\\
&+(b_X-1)X\sum_{m\le X}\frac{\lambda^m}{m}
+\sum_{m\le X}\lambda^m. \tag{16}
\end{aligned}
$$
The last line is $O_\lambda(\log X)$. The classical unconditional prime-number theorem error $\Delta(y)\ll y\exp(-c\sqrt{\log y})$ for some $c>0$ then gives, for some $c_\lambda>0$,
$$
\boxed{\sum_{n\le X}L_X(n)R_\lambda(n)
\ll_\lambda X\exp(-c_\lambda\sqrt{\log X}).} \tag{17}
$$
For $m\le\sqrt X$, apply the prime-number theorem error to $y=X/m\ge\sqrt X$; splitting the integral at $\sqrt y$ gives the same type of bound. For $m>\sqrt X$, the elementary $|T_m(X)|\ll X/m$ and the geometric factor make the tail $O_\lambda(X\lambda^{\sqrt X})$. An explicit source for the input estimate is [Fiori--Kadiri--Swidinsky, *Sharper bounds for the Chebyshev function*](https://arxiv.org/abs/2204.02588). This proves cancellation of the order-$X$ load in (15), but (17) is still much larger than the required $X^{1/2+\epsilon}$.

The main prime-quotient slice illustrates that cancellation directly. Since $L_X(p)$ changes sign near $p=X/e$, the PNT gives
$$
\lambda\sum_{p\le X/e}(\log p)L_X(p)
=-\frac{\lambda X}{e}+o_\lambda(X),\qquad
\lambda\sum_{X/e<p\le X}(\log p)L_X(p)
=\frac{\lambda X}{e}+o_\lambda(X). \tag{18}
$$
Both sides retain the true von Mangoldt weight on primes; the proper powers and all larger quotient slices remain in (16). This sign reversal comes from the centered log clock, whereas square-root control of their residual difference remains unproved.

A generic covariance Cauchy bound cannot pay (14). The mean of $R_\lambda(U_X)$ is $O_\lambda(1)$ by $\psi(y)\ll y$ and $\sum_m\lambda^m/m<\infty$. On the primes $p\in(X/2,X]$, $R_\lambda(p)=\lambda\log p$, so the PNT gives $\operatorname{Var}(R_\lambda(U_X))\gg_\lambda\log X$. Meanwhile $\operatorname{Var}(\log U_X)=1+o(1)$. The Cauchy right side $X\sqrt{\operatorname{Var}(\log U_X)\operatorname{Var}(R_\lambda(U_X))}$ is therefore at least of order $X\sqrt{\log X}$ as a numerical bound. A square-root upper bound must use the signed arithmetic structure in (13), not variance positivity alone.
