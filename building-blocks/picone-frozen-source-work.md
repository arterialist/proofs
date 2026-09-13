# Picone's identity on the literal frozen source and its signed birth work

The local algebra is the classical ground-state transformation. A primary reference allowing measure potentials is [Lenz, Stollmann and Veselić, Theorem 2.3](https://arxiv.org/abs/0811.2135). The proof below establishes the actual arithmetic identity and its endpoint extension directly; it does not borrow a global-domain conclusion from that compactly supported theorem.

All functions and norms here are in the original physical space
$L^2((1,\infty),dx)$. No mixed increment energy or changed source
metric is substituted. Let
$$
 F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
 \qquad x\ge1,
$$
with every prime power admitted at its right endpoint. Then $F(1)=0$,
$F(x)>0$ for $x>1$, $F$ is continuous and locally absolutely
continuous, and
$$
 x^2F'(x)=x-\psi(x),\qquad
 (x^2F')'=dx-\sum_{n\ge2}\Lambda(n)\delta_n
 \tag{1}
$$
in distributions on $(1,\infty)$.
The derivative in the first identity is taken almost everywhere.

For integer $N\ge1$, retain the literal frozen source
$$
 g_N(x)=\frac{E(\min(x,N))}{x},\qquad E(x)=\psi(x)-x,
$$
and set
$$
 Hf(x)=\frac1x\int_1^x f(y)\,dy,\qquad h_N=Hg_N.
 \tag{2}
$$
In particular $g_1=-1/x$, not the zero source.
Define
$$
 b(x)=\frac{xF'(x)}{F(x)},\qquad
 \mathcal R_Ff=f-Hf-bHf.
$$
The whole-halfline source identity is
$$
 \boxed{
 \|g_N\|_2^2+
 \int_1^\infty\frac{|h_N(x)|^2}{F(x)}\,dx
 -\sum_{m\ge2}\frac{\Lambda(m)|h_N(m)|^2}{F(m)}
       =\|\mathcal R_Fg_N\|_2^2.
 }
 \tag{3}
$$
Every term in (3) is finite separately, including the infinite prime
tail beyond $N$. The operator on the right uses the full actual
$F$, not a truncated $F_N$.

## 1. Domain and boundary checks

For $1<x<2$, $F(x)=\log x\ge(x-1)/2$.
For $x\ge2$, writing $m=\lfloor x\rfloor$, the exact factorial
identity and $x/n-1\le\lfloor x/n\rfloor$ give
$$
 F(x)\ge\log x-\frac{\log(m!)}x.
$$
Since $m!\le m^m2^{-\lfloor m/2\rfloor}$,
$$
 \boxed{F(x)\ge\frac{\log2}{4}\quad(x\ge2).}
 \tag{4}
$$
Indeed the nonnegative term $\log x-(m/x)\log m$ can be dropped,
and $\lfloor m/2\rfloor/(m+1)\ge1/4$.
These bounds are unconditional.

For $N\ge2$, the first actual density cell gives
$$
 g_N(x)=-1,\qquad h_N(x)=-(x-1)/x\quad(1<x<2).
$$
For the seed,
$$
 h_1(x)=-\log x/x.
$$
Thus in every case $h_N=O(x-1)$ near one,
$h_N/F=O(1)$, and the singular initial potential is integrable.

Put
$$
 C_N=\int_1^N g_N(y)\,dy,\qquad e_N=E(N).
$$
The complete frozen tail is exactly
$$
 \boxed{
 h_N(x)=\frac{C_N+e_N\log(x/N)}x,\qquad x\ge N.
 }
 \tag{5}
$$
It follows that $h_N,xh_N'=O_N((1+\log x)/x)$ at infinity.
Chebyshev's bound $\psi(x)=O(x)$, (1), and (4) give
$b(x)=O(1)$ for $x\ge2$.
Consequently
$$
 xh_N'-bh_N=\mathcal R_Fg_N\in L^2(1,\infty).
$$
Near one both $xh_N'$ and $bh_N$ are bounded.
The two boundary expressions needed below satisfy
$$
 [x|h_N|^2]_{1+}^{\infty}=0,\qquad
 \left[\frac{x^2F'}F|h_N|^2\right]_{1+}^{\infty}=0.
 \tag{6}
$$
The second is $O(x-1)$ initially and
$O_N((1+\log x)^2/x)$ at infinity.

The density potential in (3) is finite by these local bounds.
The prime potential is also finite:
$$
 \sum_{m>N}\frac{\Lambda(m)|h_N(m)|^2}{F(m)}
 =\sum_{m>N}
 \frac{\Lambda(m)[C_N+e_N\log(m/N)]^2}{m^2F(m)}<\infty.
 \tag{7}
$$
For example $\Lambda(m)\le\log m$ and (4) suffice for convergence.
Formula (7) retains every prime power beyond the frozen cutoff.
There is no justification for replacing this sum by $m\le N$.

## 2. The full identity, including its finite-interval boundary

On an interval $[a,R]\subset(1,\infty)$ whose endpoints are not
integers, expand the square and integrate the cross derivative.
Because $F$ is continuous, while
$\Delta F'(m)=-\Lambda(m)/m^2$, the exact result is
$$
 \begin{aligned}
 &\int_a^R x^2|h'(x)|^2\,dx
    +\int_a^R\frac{|h(x)|^2}{F(x)}\,dx
    -\sum_{a<m<R}\frac{\Lambda(m)|h(m)|^2}{F(m)}\\
 &\quad=\int_a^R
       \left|xh'(x)-\frac{xF'(x)}{F(x)}h(x)\right|^2dx
       +\left[\frac{x^2F'}F|h|^2\right]_a^R .
 \end{aligned}
 \tag{8}
$$
This is the distributional identity
$$
 \left(\frac{x^2F'}F\right)'
          +x^2\left(\frac{F'}F\right)^2
 =\frac{dx-\sum_m\Lambda(m)\delta_m}{F}.
$$
All atomic coefficients are therefore the actual $\Lambda(m)$;
no smooth replacement is involved.

For $h=Hg_N$, the exact relation $xh'=g_N-h$ holds almost
everywhere. Also
$$
 \|g_N\|_2^2-\|g_N-h\|_2^2
 =\int_1^\infty (x|h|^2)'\,dx=0
 \tag{9}
$$
by (6). Thus the common-inner Hardy identity is an isometry on
this actual source, rather than just a norm inequality.
Letting $a\downarrow1$ and $R\to\infty$ through nonintegers in
(8), all terms converge by the separate integrability already
proved. Equations (6) and (9) give (3).

The same reasoning applies to every finite linear combination of
the sources $g_N$, and hence to every actual finite birth
increment. Such combinations still vanish linearly after applying
$H$ at one and have a logarithmic-over-$x$ tail.
This justifies polarization without an unproved domain extension.

## 3. The original norm controls both new positive components

For $g$ in that finite-source span, Cauchy--Schwarz gives
$$
 |Hg(x)|^2\le\frac{x-1}{x^2}\int_1^x|g(y)|^2\,dy.
$$
Using (4), the initial lower bound for $F$, and
$\|Hg\|_2\le2\|g\|_2$, which also follows from (9), yields
$$
 \mathcal C_F(Hg):=\int_1^\infty\frac{|Hg|^2}{F}
 \le C_0\|g\|_2^2,\qquad C_0=2+\frac{16}{\log2}.
$$
Since both the prime sum and the right side of (3) are nonnegative,
$$
 \boxed{
 \mathcal P_F(Hg):=\sum_{m\ge2}\frac{\Lambda(m)|Hg(m)|^2}{F(m)}
       \le(1+C_0)\|g\|_2^2,\qquad
 \|\mathcal R_Fg\|_2^2\le(1+C_0)\|g\|_2^2.
 }
 \tag{10}
$$
These are uniform bounds on the two components in terms of the
original norm. They do not bound that norm as the cutoff grows,
and do not assert invertibility of $\mathcal R_F$.

Before the frozen endpoint there is a useful exact expression.
Write $\overline F(x)=x^{-1}\int_1^xF(y)\,dy$. On $1<x<N$,
$g_N=-xF'$, so integration by parts gives
$$
 h_N=\overline F-F,\qquad
 \mathcal R_Fg_N
       =xF(x)\left(\frac{\overline F(x)}{F(x)}\right)'.
 \tag{11}
$$
The ratio is positive, but its derivative is not assigned a sign.
After $N$, the correct formula instead is
$$
 \mathcal R_Fg_N(x)
 =\frac{e_N-[1+b(x)][C_N+e_N\log(x/N)]}{x}.
 \tag{12}
$$
In particular full later arithmetic remains in $b(x)$.
Equation (11) is not silently used on the frozen tail.

## 4. Exact birth and ramp polarization

To distinguish a physical birth from its Hardy image, put
$$
 \beta_t(x)=\frac{\mathbf1_{x\ge t}}x,\qquad
 \ell_t(x)=H\beta_t(x)
          =\frac{\mathbf1_{x\ge t}\log(x/t)}x,\quad t\ge1.
$$
For the actual $n$-th innovation,
$$
 v_n=g_n-g_{n-1}
    =\Lambda(n)\beta_n-\int_{n-1}^n\beta_t\,dt
    =(\Lambda(n)-1)\beta_n-b_n,
$$
$$
 b_n(x)=\frac{x-n+1}{x}\mathbf1_{n-1\le x<n}.
$$
Its Hardy image is exactly
$$
 w_n=Hv_n=\Lambda(n)\ell_n-\int_{n-1}^n\ell_t\,dt,
 \qquad h_n=h_{n-1}+w_n.
 \tag{13}
$$
All these integrals are literal source-cell integrals.
In particular the continuum ramp is not replaced by a point mass.

Use the sesquilinear versions of $\mathcal C_F,\mathcal P_F$,
with the same measures as in (10). Polarizing (3) and (9) gives
$$
 \boxed{\begin{aligned}
 \langle g_{n-1},v_n\rangle
 ={}&\langle\mathcal R_Fg_{n-1},\mathcal R_Fv_n\rangle\\
    &-\mathcal C_F(h_{n-1},w_n)
     +\mathcal P_F(h_{n-1},w_n),\\
 \|v_n\|_2^2
 ={}&\|\mathcal R_Fv_n\|_2^2-\mathcal C_F(w_n)+\mathcal P_F(w_n).
 \end{aligned}}
 \tag{14}
$$
The series in each prime cross term converges absolutely by weighted
Cauchy--Schwarz and (10). Its index runs over every $m\ge2$,
not only over the births already present in $g_{n-1}$ or $v_n$.

For completeness define the untimed accumulated works
$$
 \mathcal W_N^0=\sum_{n=2}^N\Re\langle g_{n-1},v_n\rangle,\quad
 \mathcal W_N^R=\sum_{n=2}^N
       \Re\langle\mathcal R_Fg_{n-1},\mathcal R_Fv_n\rangle,
$$
and $\mathcal W_N^C,\mathcal W_N^P$ by the corresponding potential
cross terms. Then
$$
 \boxed{\mathcal W_N^0=\mathcal W_N^R-\mathcal W_N^C+\mathcal W_N^P.}
 \tag{15}
$$
Each of the three works has its own exact seeded telescope:
$$
 \begin{aligned}
 2\mathcal W_N^R
 &=\|\mathcal R_Fg_N\|^2-\|\mathcal R_Fg_1\|^2
                      -\sum_{n=2}^N\|\mathcal R_Fv_n\|^2,\\
 2\mathcal W_N^C
 &=\mathcal C_F(h_N)-\mathcal C_F(h_1)
                      -\sum_{n=2}^N\mathcal C_F(w_n),\\
 2\mathcal W_N^P
 &=\mathcal P_F(h_N)-\mathcal P_F(h_1)
                      -\sum_{n=2}^N\mathcal P_F(w_n).
 \end{aligned}
 \tag{16}
$$
The initial norm is $\|g_1\|^2=1$, and the actual initial Hardy
profile is $h_1=-\log x/x$. Equations (3) and (16) recover exactly
$2\mathcal W_N^0=\|g_N\|^2-1-\sum_{n=2}^N\|v_n\|^2$.
No initial potential or ground-gradient term is deleted.

## 5. The prime and density cross terms are signed on actual births

A concrete actual example prevents interpreting the positive
potential forms as positive birth work. The old profile $h_2$
is strictly negative everywhere on $x>1$: it equals
$-(x-1)/x$ below two and
$[-1+(\log2-2)\log(x/2)]/x$ thereafter.

For the third innovation, $w_3<0$ on $2<x\le3$, while for
$x\ge3$ formula (13) gives
$$
 w_3(x)=\frac{(\log3-1)\log(x/3)
                       -[1-2\log(3/2)]}{x}.
 \tag{17}
$$
Both $\log3-1$ and $1-2\log(3/2)$ are positive.
Thus $w_3$ changes sign exactly once on $x>3$.
The product $h_2w_3$ is positive before that crossing and negative
after it. The density cross integrand has both signs, as do the
actual prime-power samples: the sample at $m=3$ is positive,
and every sufficiently large prime-power sample is negative.
The beyond-cutoff tail is therefore relevant even to the sign
pattern of one actual birth pairing.

The conclusion is the exact original-norm decomposition
(3), (14), and (15), with uniform component bounds (10).
It exposes ground-gradient work, density work, and the complete
prime-power work without deciding their total cancellation.
It supplies neither an unconditional source-growth bound nor an
RH conclusion. No commutation of $\mathcal R_F$ with the prime
process, and no identification with process-weighted clock work,
is assumed.

## Domain extension and formal scope

The [maximal-domain theorem](factorial-ground-state-original-l2-domain.md) extends this finite-source proof to the full original $L^2$ space after Hardy pullback, with an explicit bounded inverse. The [growing-clock consumer](factorial-source-clock-loading.md) retains the complete birth, density and clock work. These are written proofs. The Picone identity, closed-domain extension and work decomposition are not formalized in Lean here.
