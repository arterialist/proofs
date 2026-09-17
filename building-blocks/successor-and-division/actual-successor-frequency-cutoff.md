# Actual successor jumps and a finite-frequency critical readout

Let
$$
e(x)=\psi(x)-x,\qquad J(x)=\int_1^x e(u)\,du,
\qquad a(s)=e^{-s/2}e(e^s)\quad(s\ge0).
$$
Thus $a(0)=-1$ and $J(1)=0$. All occurrences of $\Lambda$ below include every proper prime power. Fix an elementary Chebyshev constant $B$ such that $\psi(y)\le By$ for $y\ge1$. No RH or mean-square assumption is used in this note. This is a written proof using integer counts, Fourier inversion and Kronecker approximation. It is not a Lean formalization. The residual $W$ has the normalization of the [actual critical sign criterion](../zeta-and-zeros/actual-critical-sign-criterion.md).

## 1. The actual distributional generator

On the open half-line the exact equation is
$$
da+\tfrac12a\,ds
=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}\delta_{\log n}
-e^{s/2}\,ds.
\tag{1}
$$
If $a$ is extended by zero to negative arguments, its distributional derivative also contains the initial atom $-\delta_0$. This is the same initial value $e(1)=-1$, rather than an additional arithmetic convention.

Fix $t\ge1$, put $M=e^{t+1}$, and use the continuous cutoff
$$
\chi_t(s)=
\begin{cases}
1,&0\le s\le t,\\
t+1-s,&t<s<t+1,\\
0,&s\ge t+1.
\end{cases}
$$
Define $f_t(s)=\chi_t(s)a(s)$ for $s\ge0$, and zero otherwise. In distributions on the whole real line,
$$
f_t' =\sum_{n\ge1}c_n\delta_{\log n}+w_t(s)\,ds,
\tag{2}
$$
where
$$
c_1=-1,\qquad
c_n=\chi_t(\log n)\frac{\Lambda(n)}{\sqrt n}\ (n\ge2),
\quad
w_t=\chi_t'a-\chi_t(a/2+e^{s/2})
$$
on $(0,t+1)$, with $w_t=0$ elsewhere. The cutoff is continuous at both joins, so neither join creates an extra atom. A prime-power arrival exactly at $t$ keeps its full coefficient; an arrival at $t+1$ has coefficient zero because the cutoff vanishes there.

Write
$$
Q=\sum_n|c_n|^2,\qquad R=\sum_n n|c_n|^2,
\qquad \mathcal W=\|w_t\|_2^2.
$$
With $C_a=B+1$, elementary bounds give
$$
\begin{split}
Q&\le1+B(t+1)(t+2),\\
R&\le1+B(t+1)M,\\
\mathcal W&\le(3C_a/2+1)^2M.
\end{split}
\tag{3}
$$
Indeed, $|a(s)|\le C_a e^{s/2}$, $\Lambda(n)^2\le(\log n)\Lambda(n)$, and partial summation gives
$$
\sum_{n\le M}\frac{\Lambda(n)}n
=\frac{\psi(M)}M+\int_1^M\frac{\psi(u)}{u^2}\,du
\le B(1+\log M).
$$
These estimates also imply $f_t\in L^1\cap L^2$, compact support, and finite variation. In particular its total variation is $O_B(e^{t/2})$.

## 2. Integer locations improve the clustered-jump estimate

For $h>0$, let
$$
A_h(s)=\sum_{s<\log n\le s+h}c_n.
$$
The number of integers whose logarithms lie in this interval is at most
$1+e^s(e^h-1)$. Cauchy--Schwarz and then finite-sum integration therefore give the exact useful bound
$$
\begin{split}
\int_{\mathbb R}|A_h(s)|^2\,ds
&\le\sum_n|c_n|^2
\int_{\log n-h}^{\log n}[1+e^s(e^h-1)]\,ds\\
&=hQ+2(\cosh h-1)R.
\end{split}
\tag{4}
$$
The initial atom is included as the integer $n=1$; negative values of $s$ cause no exception to the counting argument. Signs of the coefficients do not affect (4).

For $0<h\le1$, $2(\cosh h-1)\le2h^2$. Equation (2), Young's convolution inequality, and $|u+v|^2\le2|u|^2+2|v|^2$ now give
$$
\|f_t(\cdot+h)-f_t\|_2^2
\le2hQ+(4R+2\mathcal W)h^2.
\tag{5}
$$
This retains clustered prime-power jumps. It does not require $h$ to be smaller than the minimum logarithmic spacing.

For comparison, minimum spacing alone is at least $e^{-t-1}$. That argument gives, for all $h>0$, the weaker clustered bound $h(1+he^{t+1})Q$ for the atomic translation energy. The improvement in (4) replaces the common largest spacing cost by the actual integer-weighted quantity $R$.

## 3. An unconditional Fourier tail

Use $\widehat f(\xi)=\int_{\mathbb R}f(s)e^{-i\xi s}\,ds$. For $\Omega\ge2$, average (5) over $0<h<H=2/\Omega$. Parseval's identity gives the multiplier
$$
\frac1H\int_0^H|e^{i\xi h}-1|^2\,dh
=2\left(1-\frac{\sin(\xi H)}{\xi H}\right)\ge1
\quad(|\xi|\ge\Omega).
$$
Consequently
$$
E_{t,\Omega}:=\frac1{2\pi}\int_{|\xi|>\Omega}
|\widehat f_t(\xi)|^2\,d\xi
\le\frac{2Q}{\Omega}
+\frac{16R+8\mathcal W}{3\Omega^2}.
\tag{6}
$$
In particular
$$
E_{t,\Omega}\ll_B
\frac{(1+t)^2}{\Omega}
+\frac{e^t(1+t)}{\Omega^2}.
\tag{7}
$$

## 4. The actual harmonic convolution, with its signed square

Let $g=a*a$ denote causal convolution and put
$$
D_s(\xi)=\sum_{d\le e^s}d^{-1-i\xi},\qquad
(\mathcal Hg)(s)=\sum_{d\le e^s}\frac{g(s-\log d)}d.
$$
For every $0\le s\le t$, $(f_t*f_t)(s)=g(s)$. Fourier inversion of the convolution is valid because $\widehat f_t^2\in L^1$. Thus the exact full-frequency identity is
$$
(\mathcal Hg)(s)=\frac1{2\pi}\int_{\mathbb R}
\widehat f_t(\xi)^2 e^{i\xi s}D_s(\xi)\,d\xi.
\tag{8}
$$
The square is literally $\widehat f_t^2$, not $|\widehat f_t|^2$. This retains every signed cross interaction.

Restrict the integral in (8) to $|\xi|\le\Omega$, calling the result $L_{t,\Omega}(s)$. Since $|D_s(\xi)|\le1+s$,
$$
\sup_{0\le s\le t}|(\mathcal Hg)(s)-L_{t,\Omega}(s)|
\le(1+t)E_{t,\Omega}.
\tag{9}
$$
Equivalently, disjoint Fourier bands have zero convolution cross terms: if $f_t=p+h$ is the orthogonal low/high frequency split, then $f_t*f_t-p*p=h*h$, whose supremum is at most $\|h\|_2^2$.

Combining (7)--(9) gives
$$
\text{error}\ll_B
\frac{(1+t)^3}{\Omega}
+\frac{e^t(1+t)^2}{\Omega^2}.
\tag{10}
$$
For $x=e^t$, the choice $\Omega=\sqrt x(1+\log x)$ gives an $O_B(1)$ error. The choice $\Omega=\sqrt x(1+\log x)^2$ gives $O_B((1+\log x)^{-2})$. These are actual successor-based frequency cutoffs, not RH-dependent periodogram assumptions.

## 5. The full filter and the literal same-prime subtraction

Let
$$
\sigma=d\psi-dy-\delta_1,\qquad
N(y)=\iint(y-ab)_+\,d\sigma(a)d\sigma(b).
$$
The [actual reflection identity](../analytic-methods/harmonic-convolution.md), with $J(1)=0$, says
$$
N(e^s)e^{-3s/2}=g(s)-(k*g)(s),\qquad k(s)=e^{-3s/2}\mathbf1_{s\ge0}.
\tag{11}
$$
For $\widetilde N(x)=\sum_{d\le x}\sqrt d\,N(x/d)$, finite-sum Fubini yields
$$
e^{-3t/2}\widetilde N(e^t)
=(\mathcal Hg)(t)-\int_0^t e^{-3(t-s)/2}(\mathcal Hg)(s)\,ds.
\tag{12}
$$
The same fixed cutoff $f_t$ is used throughout the integral. Its error in (12) is at most $(5/3)(1+t)E_{t,\Omega}$, since the filter has total mass $2/3$.

Evaluating that finite causal integral explicitly gives
$$
\mathcal M_t(\xi)=
\frac{1/2+i\xi}{3/2+i\xi}e^{i\xi t}D_t(\xi)
+\frac{e^{-3t/2}}{3/2+i\xi}\sum_{d\le e^t}\sqrt d.
\tag{13}
$$
The second term is the retained endpoint term. For example, each scale with $s=t-\log d$ uses exactly
$$
e^{i\xi s}-\int_0^s e^{-3(s-u)/2}e^{i\xi u}\,du
=\frac{1/2+i\xi}{3/2+i\xi}e^{i\xi s}
+\frac{e^{-3s/2}}{3/2+i\xi}.
$$

Define the literal critical same-prime cost
$$
S_{\rm crit}(x)=\sum_{d\le x}\sqrt d
\sum_{p^j\le x/d}(x/d-p^j)(j-1)(\log p)^2.
$$
For the actual residual $W(x)=\widetilde N(x)-S_{\rm crit}(x)$, the finite-band expression is
$$
\boxed{
\frac{W(e^t)}{e^{3t/2}}
=\frac1{2\pi}\int_{|\xi|\le\Omega}
\widehat f_t(\xi)^2\mathcal M_t(\xi)\,d\xi
-\frac{S_{\rm crit}(e^t)}{e^{3t/2}}
+\mathcal E_{t,\Omega},
\quad
|\mathcal E_{t,\Omega}|\le\frac53(1+t)E_{t,\Omega}.
}
\tag{14}
$$
In (11)--(14), the initial error, continuous density, prime powers, both causal endpoints, and all harmonic scale phases are retained. A low-pass approximation need not itself vanish at $s=0$; that discrepancy is included in (9), rather than silently discarded. The actual value is $g(0)=N(1)=0$.

## 6. A bounded actual obstruction to a pointwise frequency sign

Formula (13) does not give a nonnegative multiplier. More strongly, its product with the actual Fourier square has both signs. This can be shown at the single actual cutoff $t=\log3>1$, with the cutoff above; no frequency grid is needed.

The support ends at $3e<9$, so the only nonzero prime-power atoms are $2,3,4,5,7,8$, besides the initial atom. Write their positive coefficients as $c_n$. By (2) and the Riemann--Lebesgue lemma,
$$
i\xi\widehat f_t(\xi)
=-1+\sum_{n\in\{2,3,4,5,7,8\}}c_ne^{-i\xi\log n}+o(1).
\tag{15}
$$
The logarithms of $2,3,5,7$ are rationally independent, by unique prime factorization. The continuous Kronecker approximation theorem therefore supplies unbounded positive frequency sequences on which all four prime phases tend either to zero or to $\pi$.

Along the zero-phase sequence, (13) tends to $11/6$, and the right side of (15) tends to
$$
A_+=-1+c_2+c_3+c_4+c_5+c_7+c_8>0.
$$
For the strict inequality it suffices that
$c_2=\log2/\sqrt2>4/9$ and
$c_3=\log3/\sqrt3>4/7$: use $\log2>2/3$, $\log3>1$, $\sqrt2<3/2$, and $\sqrt3<7/4$.

Along the all-prime-phase-$\pi$ sequence, the three harmonic scale phases for $d=1,2,3$ tend respectively to $-1,1,1$, so (13) tends to $-1/6$. The right side of (15) tends to
$$
A_-=-1-c_2-c_3+c_4-c_5-c_7-c_8<0,
$$
because $c_4<\log2/2<1/2$. It follows that the two sequences satisfy respectively
$$
\xi^2\Re[\mathcal M_t(\xi)\widehat f_t(\xi)^2]
\longrightarrow-\tfrac{11}{6}A_+^2<0,
\qquad
\xi^2\Re[\mathcal M_t(\xi)\widehat f_t(\xi)^2]
\longrightarrow\tfrac16A_-^2>0.
\tag{16}
$$
Thus even the actual filtered Fourier-square integrand lacks a pointwise sign. This does not determine the sign of its integral or rule out a collective inequality. Equations (6)--(14) instead quantify why recurrences at sufficiently high frequencies have little total mass. The remaining finite band still contains the unresolved arithmetic cancellation; this construction supplies no unconditional RH-scale bound for that band.

## 7. Two-history support lowers the cutoff to $x^{3/8}$

There is a further improvement from the support of the two histories. Suppose $t\ge2$, put $T=t/2$, and use the same cutoff family to define
$$
\ell=\chi_T a,\qquad h=f_t-\ell.
$$
Both functions are extended by zero to the negative half-line. Since $T+1\le t$, this is also $\ell=\chi_T f_t$. The function $h$ vanishes on $( -\infty,T]$, including an arrival exactly at $T$. It follows that
$$
h*h(s)=0\quad(s\le t),\qquad
g(s)=\ell*\ell(s)+2\ell*h(s)\quad(0\le s\le t).
\tag{17}
$$
At $s=t=2T$, two arguments strictly greater than $T$ still cannot sum to $s$. No boundary contribution is present in this ordinary convolution.

The initial atom $-\delta_0$ is retained in $\ell'$ and cancels completely in $h'$. Their other atomic coefficients are respectively
$$
\chi_T(\log n)\Lambda(n)/\sqrt n,
\qquad [\chi_t(\log n)-\chi_T(\log n)]\Lambda(n)/\sqrt n.
$$
Both cutoff factors are continuous, so the joins $T,T+1,t,t+1$ create no atoms. With $C_w=3(B+1)/2+1$, valid explicit budgets are
$$
\begin{array}{lll}
Q_\ell\le1+B(T+1)(T+2),&
R_\ell\le1+B(T+1)e^{T+1},&
\mathcal W_\ell\le C_w^2e^{T+1},\\
Q_h\le B(t+1)(t+2),&
R_h\le B(t+1)e^{t+1},&
\mathcal W_h\le C_w^2e^{t+1}.
\end{array}
\tag{18}
$$
For the final density bound, the derivative supports of $\chi_t$ and $\chi_T$ are disjoint up to endpoints; hence $|\chi_t'-\chi_T'|\le1$ almost everywhere, while $0\le\chi_t-\chi_T\le1$.

Let $E_\ell,E_h$ denote their squared Fourier tails with the Parseval normalization of (6). The same integer-counting proof gives, for each $j\in\{\ell,h\}$,
$$
E_j\le\frac{2Q_j}{\Omega}
+\frac{16R_j+8\mathcal W_j}{3\Omega^2},\qquad \Omega\ge2.
\tag{19}
$$
Writing $L=1+t$, in particular
$$
E_\ell\ll_B L^2/\Omega+e^{t/2}L/\Omega^2,
\qquad E_h\ll_B L^2/\Omega+e^tL/\Omega^2.
\tag{20}
$$

Equation (17) replaces the Fourier square in the exact readout by the signed expression
$$
\mathcal A_t(\xi)=\widehat\ell(\xi)^2
+2\widehat\ell(\xi)\widehat h(\xi).
$$
There is no $\widehat h^2$ term: its full inverse transform vanishes on every time used by the readout. Cauchy--Schwarz bounds the omitted high-frequency integral of $\mathcal A_t$ by $E_\ell+2\sqrt{E_\ell E_h}$. The resulting full formula is
$$
\frac{W(e^t)}{e^{3t/2}}
=\frac1{2\pi}\int_{|\xi|\le\Omega}
\mathcal A_t(\xi)\mathcal M_t(\xi)\,d\xi
-\frac{S_{\rm crit}(e^t)}{e^{3t/2}}+\mathcal E^{(2)}_{t,\Omega},
$$
$$
|\mathcal E^{(2)}_{t,\Omega}|
\le\frac53L\bigl(E_\ell+2\sqrt{E_\ell E_h}\bigr)
\ll_B\frac{L^3}{\Omega}
+\frac{e^{t/2}L^{5/2}}{\Omega^{3/2}}
+\frac{e^{3t/4}L^2}{\Omega^2}.
\tag{21}
$$
The multiplier $\mathcal M_t$ is exactly (13), with its causal endpoint term and every harmonic phase unchanged. To check the last estimate, put $A=L^2/\Omega$, $B_0=e^{t/2}L/\Omega^2$, $C_0=e^tL/\Omega^2$. Since $B_0\le C_0$,
$\sqrt{(A+B_0)(A+C_0)}\le A+2\sqrt{AC_0}+\sqrt{B_0C_0}$, and $B_0\le\sqrt{B_0C_0}$.

Choosing $\Omega=e^{3t/8}L=x^{3/8}(1+\log x)$ makes (21) $O_B(1)$: its three displayed terms are respectively $L^2e^{-3t/8}$, $Le^{-t/16}$, and $1$. Multiplying this cutoff by $L^\varepsilon$, for any fixed $\varepsilon>0$, makes the error $O_{B,\varepsilon}(L^{-2\varepsilon})$. This support refinement improves the approximation scale; it does not assert a bound or a sign for the retained signed finite-band integral.
