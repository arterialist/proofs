# Finite-scale centered Goldbach energy survives the factorial cofactor

RH Proof research note, 16 September 2026. This uses the actual full-clock Binet cofactor from the [factorial cone](../factorial-and-renewal/full-factorial-clock-binet-residual-zero-detecting-cone.md). It gives an unconditional, quantitative comparison of the *centered additive heat energy* before and after all multiplicative cofactor histories are admitted. The estimate holds at every heat cutoff, not just in a limiting half-plane. It neither bounds that energy at the RH scale nor proves Goldbach existence.

Put $a(n)=\Lambda(n)-1$ for every $n\ge1$, including $a(1)=-1$, and

$$
 D(t)=\sum_{n\ge1}a(n)e^{-nt},\qquad t>0.
 \tag{1}
$$

This is the existing complete centered Goldbach heat source. The Binet residual is $r(m)<0$, and $v(m)=-r(m)>0$. Its previously proved written bounds are

$$
 \frac1{504}<v(1)<\frac1{360},\qquad
 \sum_{m\ge2}m v(m)<\frac{13}{7200},\qquad
 v(1)-\sum_{m\ge2}m v(m)>\frac1{5600}.
 \tag{2}
$$

Define the full-history centered source and its heat transform by

$$
 d_v(n)=\sum_{m\mid n}v(m)\bigl(\Lambda(n/m)-1\bigr)
       =(v*\Lambda)(n)-\sum_{m\mid n}v(m),
 \qquad D_v(t)=\sum_{n\ge1}d_v(n)e^{-nt}.
 \tag{3}
$$

The reference term in (3) is the **complete divisor sum** of the cofactor, not a single constant density atom. In particular, $d_v(1)=-v(1)$. Absolute convergence for each $t>0$ and divisor regrouping give the exact dilation law

$$
 \boxed{D_v(t)=\sum_{m\ge1}v(m)D(mt).} \tag{4}
$$

The signed ordered additive coefficient at total $k\ge2$ is

$$
 C_v(k)=\sum_{a+b=k}d_v(a)d_v(b)
 =\sum_{ma+nb=k}v(m)v(n)
      \bigl(\Lambda(a)-1\bigr)\bigl(\Lambda(b)-1\bigr),
 \tag{5}
$$

with all four indices positive. Every prime power, direct $m=n=1$ history, mixed dilation, and additive endpoint remains. The coefficients $C_v(k)$ need not be positive; the positivity is the full heat square

$$
D_v(t)^2=\sum_{k\ge2}C_v(k)e^{-kt}\ge0.
 \tag{6}
$$

The actual Binet-filtered coefficient at additive total $6$ is already **strictly negative**. Write $v_j=v(j)$ and $d_j=d_v(j)$. Exact divisor enumeration and $\Lambda(p^r)=\log p$ give

$$
\begin{aligned}
d_1&=-v_1,\\
d_2&=v_1(\log2-1)-v_2,\\
d_3&=v_1(\log3-1)-v_3,\\
d_4&=(v_1+v_2)(\log2-1)-v_4,\\
d_5&=v_1(\log5-1)-v_5,\\
C_v(6)&=2d_1d_5+2d_2d_4+d_3^2.
\end{aligned} \tag{6a}
$$

The pointwise Binet bounds in equation (9) of the linked
[full factorial-clock note](../factorial-and-renewal/full-factorial-clock-binet-residual-zero-detecting-cone.md)
give $0<v_j<1/(360j^3)$ for all $j$, and $v_1>1/504$. The
elementary enclosures $2/3<\log2<1$, $1<\log3<6/5$, and
$\log5>3/2$ imply, by rational arithmetic,

$$
 |d_2|<\frac{13}{10000},\qquad
 |d_3|<\frac7{10000},\qquad
 |d_4|<\frac{11}{10000},\qquad
 d_5>\frac9{10000}. \tag{6b}
$$

For example, $|d_2|<(1/360)(1/3)+1/2880=11/8640<13/10000$, $|d_4|<(1/320)(1/3)+1/23040=25/23040<11/10000$, and $d_5>(1/504)(1/2)-1/45000=611/630000>9/10000$. The $d_3$ bound follows from $v_3<1/9720$: $|d_3|<(1/360)(1/5)+1/9720<7/10000$. Substitution in (6a) gives the explicit strict sign

$$
 \boxed{C_v(6)
 < -\frac1{280000}
       +2\frac{13}{10000}\frac{11}{10000}
       +\left(\frac7{10000}\right)^2
 =-\frac{31}{140000000}<0.} \tag{6c}
$$

For completeness, $\log(1+x)>2x/(2+x)$ for $x>0$: its difference is zero at zero and has derivative $x^2/((1+x)(2+x)^2)>0$. At $x=1$ this gives $\log2>2/3$; the familiar strict $\log(1+x)<x$ gives $\log2<1$. The same lower bound at $x=2$ gives $\log3>1$. The positive exponential series gives $e^{6/5}\ge1+6/5+18/25+36/125=401/125>3$, hence $\log3<6/5$. Finally $\log5=2\log2+\log(5/4)>4/3+2/9=14/9>3/2$. This sign uses the **actual** factorial residual, not a fictitious weight concentrated at $m=1$. It rules out coefficientwise positivity of the Binet-centered Goldbach square while leaving the full positive heat energy and norm gap intact.

## A uniform energy gap at every heat horizon

For $\sigma\ge0$ and $\varepsilon>0$, write

$$
 \|F\|_{\sigma,\varepsilon}
 =\left(\int_\varepsilon^\infty
       t^{\sigma-1}|F(t)|^2\,dt\right)^{1/2}.
$$

The integral is finite for $F=D$ and $F=D_v$ at each positive cutoff. A dilation has the exact norm

$$
 \|D(m\cdot)\|_{\sigma,\varepsilon}
 =m^{-\sigma/2}\|D\|_{\sigma,m\varepsilon}
 \le m^{-\sigma/2}\|D\|_{\sigma,\varepsilon}.
 \tag{7}
$$

The triangle inequality applied to (4), then the reverse triangle inequality applied to its direct $m=1$ term, therefore give

$$
 \left(v(1)-\sum_{m\ge2}v(m)m^{-\sigma/2}\right)
 \|D\|_{\sigma,\varepsilon}
 \le\|D_v\|_{\sigma,\varepsilon}
 \le
 \left(v(1)+\sum_{m\ge2}v(m)m^{-\sigma/2}\right)
 \|D\|_{\sigma,\varepsilon}.
 \tag{8}
$$

The infinite triangle passage is legitimate: (2) makes the series of dilation norms summable, and the $L^2$ limit agrees with the pointwise absolutely convergent series (4). Since $m^{-\sigma/2}\le1\le m$, (2) yields the explicit **unconditional finite-scale coercivity**

$$
 \boxed{\frac1{5600}\|D\|_{\sigma,\varepsilon}
 \le\|D_v\|_{\sigma,\varepsilon}
 \le\frac{11}{2400}\|D\|_{\sigma,\varepsilon}}
 \qquad(\sigma\ge0,\ \varepsilon>0).
 \tag{9}
$$

The upper constant uses $1/360+13/7200=11/2400$. Thus the positive heat energy of the centered full-history source cannot hide an original centered Goldbach fluctuation, even at a finite horizon. This is a norm inequality, not a pointwise lower bound on $D_v(t)^2$ or a sign for any coefficient $C_v(k)$.

At $\sigma>2$, the bound $|d_v(n)|\le(1+\log n)\sum_m v(m)$ makes the ordered pair series absolutely convergent: at total $k$, its absolute numerator is $O(k\log^2 k)$. The gamma integral therefore justifies the original, uncontinued Mellin identity

$$
 \int_0^\infty t^{\sigma-1}D_v(t)^2dt
 =\Gamma(\sigma)\sum_{k\ge2}\frac{C_v(k)}{k^\sigma}.
 \tag{10}
$$

For $1<\sigma<2$, equation (10) is **not** being used as an absolutely convergent coefficient series. Letting $\varepsilon\downarrow0$ in (9) shows instead that the positive integral for $D_v$ is finite exactly when the existing centered heat integral for $D$ is finite. The latter is finite for every $\sigma>1$ if and only if RH: the [centered Goldbach heat criterion](centered-goldbach-heat-lyapunov.md) gives the zero-growth exponent at $\sigma=1$, and integration by parts converts zero growth into finiteness at every $\sigma>1$. Conversely, finiteness at every $\sigma>1$ bounds the critical energy by $O_\sigma(e^{(\sigma-1)T})$, forcing zero exponent. Equivalently, the critical logarithmic-time Lyapunov exponent is unchanged: at $\sigma=1$, the substitution $t=e^{-v}$ turns the truncated energy into $\int_0^T e^{-v}|D(e^{-v})|^2dv$, and (9) compares this with the cofactor version by constants independent of $T$.

The gap in (9) is an actual arithmetic constraint derived from the Binet cofactor's first-coefficient dominance. It transfers any future RH-strength *upper* estimate for $D_v$ back to the original centered Goldbach source, with an explicit constant. It does not supply that upper estimate. Equation (6c) rules out coefficientwise positivity for this actual cofactor; the simpler direct weight concentrated at $m=1$ already inherits the negative total-four coefficient in [the centered Goldbach obstruction](centered-goldbach-positive-transfer-obstruction.md).

[FactorialBinetCenteredGoldbachFinite.lean](../../formalization/BuildingBlocks/FactorialBinetCenteredGoldbachFinite.lean) compiles the exact divisor-reference subtraction in (3), the negative $n=1$ endpoint, the direct-versus-proper cofactor split, the full ordered four-index expansion in (5), the exact total-six formula (6a), and the strict negative sign conditional on the four rational component bounds in (6b), with only Lean's standard axioms. The actual Binet coefficient bounds, logarithm enclosures and their application to the sign (6c), infinite dilation interchange, norm inequality (9), and analytic statement (10) remain written proofs, not compiled Lean theorems.
