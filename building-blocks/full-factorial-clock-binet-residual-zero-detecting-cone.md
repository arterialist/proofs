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

There is also a direct boundary interpretation in the **original two-body factorial kernel**

\[
 B(m,N)=(m+N)\log(m+N)-m\log m-N\log N
       -\log\binom{m+N}{m}
       =\int_0^\infty w(t)(1-e^{-mt})(1-e^{-Nt})\,dt.
 \tag{3a}
\]

The exact **two-body coboundary** is

\[
 \boxed{B(m,n)=k(m)+k(n)-k(m+n)\qquad(m,n\ge0).} \tag{3b}
\]

It follows directly from $(1-e^{-mt})(1-e^{-nt})=(1-e^{-mt})+(1-e^{-nt})-(1-e^{-(m+n)t})$. The new [finite cofactor module](BuildingBlocks/FactorialClockCofactorFinite.lean) now also proves (3b) for the existing, literal kernel in `FactorialKernelDictionary`, using its factorial and binomial formula; it does not redefine that kernel. Consequently the original actual Möbius quotient energy has the exact terminal-retaining identity

\[
 Q_N=2M(N)\sum_{j\le N}\mu(j)k(\lfloor N/j\rfloor)
       -\sum_{j,l\le N}\mu(j)\mu(l)
           k(\lfloor N/j\rfloor+\lfloor N/l\rfloor). \tag{3c}
\]

At a horizon with $M(N)=0$, only the second term remains. The theorem `actual_moebius_energy_coboundary` in [FactorialClockCofactorFinite.lean](BuildingBlocks/FactorialClockCofactorFinite.lean) proves (3c) for the literal integrated Möbius response. It uses a generic finite quadratic coboundary, and its axiom report lists only Lean's three standard axioms. Equation (3c) supplies no upper bound on the coherent energy. The signed terminal loading remains at general horizons.

For each fixed $m\ge1$, the positive integrand increases with $N$ and monotone convergence gives $B(m,N)\uparrow k(m)$. The same limit follows from
$\binom{m+N}{m}=m!^{-1}\prod_{j=1}^m(N+j)$ and
$(m+N)\log(1+m/N)\to m$. Thus $k$ is an infinite-size boundary column of the compiled [factorial kernel dictionary](BuildingBlocks/FactorialKernelDictionary.lean), not a separate clock choice. The boundary column is not a finite-energy vector: Stirling gives

\[
 B(N,N)=2N\log2-\log\binom{2N}{N}
        =\tfrac12\log(\pi N)+o(1)\longrightarrow\infty.
 \tag{3d}
\]

Consequently Cauchy--Schwarz against that column does not directly bound the original finite Möbius quadratic energy. The boundary and diagonal limits in (3a), (3d) are written analysis; the finite kernel identity in (3a) itself is compiled in the linked dictionary.

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
\Re R(s)
&\le r(1)+\sum_{m\ge2}|r(m)|m^{-\Re s}\\
&<-\frac1{504}+\frac1{360}
\left(\frac18+\int_2^\infty x^{-3}\,dx\right)
=\boxed{-\frac{13}{10080}}<0,\\
|R(s)|&>\frac{13}{10080}. \tag{11}
\end{aligned}
\]

No assertion about zeros of $\zeta$ is used in (11). The stronger real-part inequality pins every multiplier $R(\rho)$ at a zeta zero $\rho$ in the open left half-plane. It does not sign the resulting oscillatory zero contribution on the real $X$ axis.

The Binet remainder has a stronger **positive-clock representation**. For $u>0$ define the twice-corrected original density

\[
 \omega_B(u)=w(u)-\frac1{2u}+\frac1{12}
 =\frac1{12}+\frac1{u^2}-\frac{\coth(u/2)}{2u}
 =2\sum_{j\ge1}
 \frac{u^2}{(2\pi j)^2((2\pi j)^2+u^2)}.
 \tag{11a}
\]

The last equality is the classical [partial fraction for $\coth$, DLMF 4.36.3](https://dlmf.nist.gov/4.36.E3). It proves $0<\omega_B(u)<1/12$ pointwise, with $\omega_B(u)\sim u^2/720$ at zero and $\omega_B(u)\to1/12$ at infinity. The strict positivity of the **explicit corrected original density**, independently of the partial-fraction theorem, is compiled in [FactorialBinetResidualDensityPositive.lean](BuildingBlocks/FactorialBinetResidualDensityPositive.lean): after multiplying by $12u^2(e^u-1)>0$, its numerator $H(u)=(u^2-6u+12)(e^u-1)-12u$ has $H(0)=H'(0)=H''(0)=0$ and $H'''(u)=u^2e^u>0$ for $u>0$. The exact Laplace identity is

\[
 \boxed{-r(m)=\int_0^\infty e^{-mu}\omega_B(u)\,du\qquad(m\ge1).}
 \tag{11b}
\]

To check it from (5), use
$t/m-\arctan(t/m)=\int_0^\infty e^{-mu}[t-\sin(tu)/u]du$;
the bracket is nonnegative, so Tonelli applies. Expand
$(e^{2\pi t}-1)^{-1}=\sum_{j\ge1}e^{-2\pi jt}$ and integrate $t$ to obtain the positive partial-fraction series in (11a). Equation (11b) immediately yields the positive admission law

\[
 a_\epsilon(m)=\epsilon+
 \int_0^\infty\omega_B(u)(e^{-u}-e^{-mu})du.
 \tag{11c}
\]

It also gives a positive Hankel kernel on the literal integer quotient sizes:

\[
 \sum_{j,k}v_jv_k[-r(q_j+q_k)]
 =\int_0^\infty\omega_B(u)
       \left(\sum_jv_je^{-q_ju}\right)^2du\ge0
 \quad(q_j\ge1). \tag{11d}
\]

For $q_j=\lfloor N/j\rfloor$ and $v_j=\mu(j)$, the integrand is the squared **terminal-compensated** literal factorial response $M(N)-g_N(u)$. This retains every Möbius quotient history and the terminal value. It is an exact additional positive quadratic form, not an estimate for the original $\int w(u)g_N(u)^2du$; its needed RH-scale upper bound has not been proved. The pointwise positivity of $\omega_B$ is Lean-formalized; the partial fraction, Laplace, and Hankel identities remain written analysis.

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

## Stable inversion on the exact divisor lattice

The first-coefficient separation also holds in a weighted convolution algebra. For an arithmetic sequence $v$ set $\|v\|_{1,w}=\sum_{m\ge1}m|v(m)|$. Dirichlet convolution satisfies $\|v*z\|_{1,w}\le\|v\|_{1,w}\|z\|_{1,w}$. The strict convexity of $x^{-2}$ gives
$\sum_{m\ge3}m^{-2}<\int_{5/2}^\infty x^{-2}dx=2/5$ by applying the midpoint integral bound to each unit cell. Hence (9) yields

\[
 S_1:=\sum_{m\ge2}m|r(m)|
 <\frac1{360}\left(\frac14+\frac25\right)
 =\frac{13}{7200},\qquad
 |r(1)|-S_1>\frac1{504}-\frac{13}{7200}
 =\frac1{5600}. \tag{22a}
\]

Let $h=r-r(1)\delta_1$. The Neumann series in this weighted algebra defines an **actual divisor inverse**

\[
 b=\frac1{r(1)}\sum_{k\ge0}\left(-\frac h{r(1)}\right)^{*k},
 \qquad b*r=\delta_1,
 \qquad\boxed{\sum_{m\ge1}m|b(m)|<5600}. \tag{22b}
\]

For each fixed integer $m$, this series has only finitely many nonzero terms, since $h$ is supported on integers at least $2$. Thus (22b) is both a convergent norm identity and a finite divisor-history formula for each coefficient. It strengthens (11): for $\Re s\ge-1$, absolute convergence and (22a) give

\[
 \Re R(s)<-\frac1{5600},\qquad
 \frac1{R(s)}=\sum_{m\ge1}\frac{b(m)}{m^s}
 \quad\text{absolutely}. \tag{22c}
\]

This inverse gives a real-arithmetic version of the RH criterion. Define the complete signed source and its prefix by

\[
 u_r(n)=(r*\Lambda)(n)
 =\sum_{dm=n}\Lambda(d)r(m),\qquad
 B_r(x)=\sum_{n\le x}u_r(n)
 =\sum_{m\le x}r(m)\psi(x/m). \tag{22d}
\]

Since every $r(m)<0$ and $\Lambda(d)\ge0$, the count $-B_r(x)$ is nondecreasing and retains all prime powers. Its $m=1$ row is $-r(1)\psi(x)$, so direct prime births have positive weight.

Write $R(1)=\sum_m r(m)/m<0$. The prime number theorem and the summability in (22a) give $B_r(x)/x\to R(1)$. More quantitatively,

\[
 \boxed{\mathrm{RH}\ \Longleftrightarrow\
 B_r(x)-R(1)x=O_\delta(x^{1/2+\delta})
 \text{ for every }\delta>0.} \tag{22e}
\]

On RH, insert $\psi(y)=y+O_\delta(y^{1/2+\delta})$ into (22d); the omitted $m>x$ part of $R(1)x$ is $O(x^{-2})$. In the other direction, $b*r=\delta_1$ gives the **exact** identity $\psi(x)=\sum_{m\le x}b(m)B_r(x/m)$. Since $R(1)\sum_m b(m)/m=1$, the error in (22e) contributes at most $O_\delta(x^{1/2+\delta})\sum_m|b(m)|m^{-1/2-\delta}$, and the missing main-term tail is at most $|R(1)|\|b\|_{1,w}/x$. No analytic continuation or zero-residue argument enters this transfer.

The centered consumer in (20) is linked to this raw prefix by the exact real-variable identity

\[
 H_r(x)=B_r(x)-\int_1^x\frac{B_r(t)}t\,dt,
 \qquad
 B_r(x)=H_r(x)+x\int_1^x\frac{H_r(t)}{t^2}\,dt. \tag{22f}
\]

If $H_r(x)=O_\delta(x^{1/2+\delta})$ with $0<\delta<1/2$, the integral in the second formula converges at infinity. The already known limit $B_r(x)/x\to R(1)$ identifies its value as $R(1)$, and its tail is $O_\delta(x^{1/2+\delta})$. Thus (22f) proves (22e) from the centered bound. Conversely, (22e) inserted in the first formula bounds $H_r$ at the same scale. Together with $C_r(X)-H_r(X)=O(\log X)$ and $V_X-X=O(\log^2X)$, this is a second, entirely real-arithmetic proof of (19). It exposes a stable inverse on the original exact-division histories; it does not provide the missing square-root estimate for $B_r$ or $P_\epsilon$.

## Additive pairs from the invertible complete source

The same source has an exact Goldbach interface. Put $v(m)=-r(m)>0$, $U=v*\Lambda=-u_r\ge0$, and $c=v^{-1}=-b$, so $\sum_m m|c(m)|<5600$. Let $P_\Lambda(z)=\sum_{d\ge1}\Lambda(d)z^d$ and $P_U(z)=\sum_{n\ge1}U(n)z^n$. Since $\Lambda(d)\le\log d$, one has $U(n)\le(\sum_m v(m))\log n$; the series below therefore converge absolutely for $|z|<1$. Divisor regrouping gives

\[
 \boxed{P_U(z)=\sum_{m\ge1}v(m)P_\Lambda(z^m),\qquad
 P_\Lambda(z)=\sum_{m\ge1}c(m)P_U(z^m).} \tag{22g}
\]

Thus the positive source remembers ordinary additive pairs as well as every multiplicative cofactor. If $\mathcal G_\Lambda(k)=\sum_{d+e=k}\Lambda(d)\Lambda(e)$ and $\mathcal G_U(k)=\sum_{a+b=k}U(a)U(b)$ are ordered additive coefficients, squaring (22g) and comparing the coefficient of $z^k$ gives the finite identities

\[
 \begin{aligned}
 \mathcal G_U(k)
 &=\sum_{md+ne=k}v(m)v(n)\Lambda(d)\Lambda(e)
 \ge v(1)^2\mathcal G_\Lambda(k),\\
 \mathcal G_\Lambda(k)
 &=\sum_{ma+nb=k}c(m)c(n)U(a)U(b).
 \end{aligned} \tag{22h}
\]

Every sum in (22h) has positive integer indices and is finite for fixed $k$. The first line is positive and retains the undilated $m=n=1$ Goldbach pair alongside all dilated prime-power histories. The second line recovers the original pair coefficient but has signed mixed-dilation terms. Positivity of $\mathcal G_U(k)$ does not prove a Goldbach representation at an even $k$ or bound those signed terms. No Goldbach existence theorem or RH-scale pair estimate follows from (22g)--(22h).

[FactorialBinetGoldbachFinite.lean](BuildingBlocks/FactorialBinetGoldbachFinite.lean) compiles the complete finite cofactor source, its prime prefix, the full ordered additive/divisor expansion, source positivity, and the inequality $\mathcal G_U(k)\ge v(1)^2\mathcal G_\Lambda(k)$ for any nonnegative weight $v$. The analytic fact that the particular Binet weight $v=-r$ satisfies that hypothesis is still a written proof. The generating-function inversion and signed second line of (22h) are also not formalized.

The same complete source gives a sharp **prime-state wall**. By (6) and (11b), $v(m)$ is strictly positive and decreases with $m$. In the divisor identity $\sum_{d\mid n}\Lambda(d)=\log n$, the term $d=n$ carries $v(1)\Lambda(n)$; every other term has cofactor at least $2$ and weight at most $v(2)$. Therefore, for $n\ge2$,

\[
 v(1)\Lambda(n)\le U(n)
 \le v(2)\log n+\bigl(v(1)-v(2)\bigr)\Lambda(n). \tag{22i}
\]

At a prime $p$, the two sides equal $v(1)\log p$. At a composite $n$, $\Lambda(n)\le\tfrac12\log n$: it is zero unless $n=p^j$ with $j\ge2$, when it is $\log p=(\log n)/j$. Thus the normalized full-history state $F_v(n)=U(n)/(v(1)\log n)$ obeys

\[
 F_v(p)=1\quad(p\text{ prime}),\qquad
 0\le F_v(n)\le c_v:=\frac{v(1)+v(2)}{2v(1)}
 <\frac{47}{80}\quad(n\text{ composite}). \tag{22j}
\]

The rational bound follows from $v(1)>1/504$ and $v(2)<1/2880$ in (9), which give $v(2)/v(1)<7/40$. The exact composite threshold $c_v$ is attained at $n=4$, where the $d=2,4$ histories contribute $v(2)\log2$ and $v(1)\log2$.

The abstract pointwise wall is compiled in [FactorialBinetGoldbachFinite.lean](BuildingBlocks/FactorialBinetGoldbachFinite.lean): it proves (22i) under the cofactor bound $v(m)\le v(2)$ for $m\ge2$, proves $\Lambda(n)\le\tfrac12\log n$ for composites, and gives the rational composite bound under $40v(2)\le7v(1)$. It also proves the exact $n=4$ equality. The Binet-specific inequalities (9), which discharge those abstract hypotheses for $v=-r$, remain written analysis.

For each fixed $N$, raising these states to a power isolates ordinary primes with an explicit finite error:

\[
 0\le\sum_{n=2}^N F_v(n)^h-\pi(N)
 \le(N-1)(47/80)^h. \tag{22k}
\]

Likewise, for every $k\ge4$, the positive ordered additive packet obeys

\[
 0\le
 \sum_{\substack{a+b=k\\a,b\ge2}}F_v(a)^hF_v(b)^h
 -\#\{(p,q):p+q=k,\ p,q\text{ prime}\}
 \le(k-3)(47/80)^h. \tag{22l}
\]

These are finite prime and Goldbach filters built from the actual factorial residual and all its divisor histories. They give a numerical certificate for a *fixed* even $k$ if the left packet exceeds its error bound, but supply no such inequality for every even $k$ and no bound on $\psi(x)-x$. The earlier [square-root divisor hard wall](prime-state-hard-wall.md) is a different exact prime classifier; neither classifier controls prime distribution by itself.

[FactorialBinetGoldbachFilter.lean](BuildingBlocks/FactorialBinetGoldbachFilter.lean) now compiles (22k) and (22l) for every nonnegative cofactor sequence satisfying the explicit first-versus-second cofactor hypotheses of the pointwise wall. Its `goldbach_certificate` proves that a strict packet surplus over $(k-3)(47/80)^h$ yields actual primes $p+q=k$. The proof counts exactly $N-1$ candidate prime states and $k-3$ ordered additive candidates; it retains both endpoints. The analytic Binet inequalities that instantiate these hypotheses for $v=-r$ remain written, not Lean-formalized. Neither the compiled finite bound nor its certificate establishes a surplus for all even $k$.

The nonzero critical-line residue also yields a quantitative **unconditional lower-scale calibration**. For every zero $\rho=1/2+i\gamma$ of multiplicity $m_\rho$, the positive-Mellin residue comparison in the [critical-zero oscillation proof](monotone-cofactor-covariance-critical-oscillation.md), now with $R$ replacing the geometric factor, gives

\[
 \limsup_{X\to\infty}\frac{P_\epsilon(X)-c_\epsilon X}{\sqrt X}
 \ge\frac{m_\rho|R(\rho)|}{|\rho|}
 >\frac{13m_\rho}{10080|\rho|},\qquad
 \liminf_{X\to\infty}\frac{P_\epsilon(X)-c_\epsilon X}{\sqrt X}
 \le-\frac{m_\rho|R(\rho)|}{|\rho|}. \tag{23}
\]

The $O(\log^2 X)$ variance error does not affect these limits. Hardy's critical-line zero theorem makes (23) unconditional. It is a lower oscillation result, not an upper estimate or a proof of RH.

The full-clock identity (3), exact two-body coboundary (3b), Binet's correction (5), positive residual density (11a), and weighted divisor inverse (22b) are the mechanism here. [FactorialClockCofactorFinite.lean](BuildingBlocks/FactorialClockCofactorFinite.lean) compiles the finite telescoping, literal kernel coboundary, terminal-retaining Möbius energy, and complete-source regrouping for every coefficient sequence. [FactorialBinetResidualDensityPositive.lean](BuildingBlocks/FactorialBinetResidualDensityPositive.lean) proves pointwise density positivity. [FactorialBinetGoldbachFinite.lean](BuildingBlocks/FactorialBinetGoldbachFinite.lean) and [FactorialBinetGoldbachFilter.lean](BuildingBlocks/FactorialBinetGoldbachFilter.lean) compile the complete pair algebra, pointwise wall, finite prime and Goldbach filters, and fixed-total certificate under their stated cofactor hypotheses. The finite covariance identity is an instance of [MonotoneCofactorCovarianceFinite.lean](BuildingBlocks/MonotoneCofactorCovarianceFinite.lean), whose geometric version is compiled. The improper-integral identification (2), Binet/Laplace formulas, Binet-specific coefficient inequalities, weighted inverse, analytic criterion, and oscillation (23) are not Lean-formalized. Equation (3c) connects the cumulative cofactor exactly to the original quadratic kernel, but no bound transfers the positive cone's centered score to the original factorial quadratic energy or Goldbach additive-pair norm.
