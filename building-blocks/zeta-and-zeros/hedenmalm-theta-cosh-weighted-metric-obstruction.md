# A singular theta target metric fails pair symmetry at high real zeta zeros

**Status: method obstruction, no RH progress.** This note tests one positive target metric for Hedenmalm's theta pencil. It proves that the metric fails the pair-symmetry condition even on pairs of known real zeros of $\Xi$. It does not locate any off-line zero, and it does not rule out other, more singular or nonlocal metrics.

## Source and statement

Set

$$
K(x)=\Theta_{00}(i e^{2x}),\qquad
\Xi(\alpha)=\int_{\mathbb R}K(x)e^{i\alpha x}\,dx,\qquad
p(x)=-\frac{K'(x)}{K(x)}.
$$

These are Hedenmalm's exact Jacobi-theta kernel and Mellin normalization after $t=e^x$; see [Hedenmalm, *Spectral interpretation of Riemann zeta zeros*, (1.2.3), (2.2.1)](https://arxiv.org/html/2606.17494). Jacobi inversion makes $K$ positive and even. In logarithmic coordinates his operators are

$$
D=-i\partial_x,\qquad A=-i(\partial_x+p)
  =-iK\,\partial_x(\,\cdot\,/K).
$$

For each real zero $\alpha$ of $\Xi$, the source eigenfunction is

$$
u_\alpha(x)=e^{-i\alpha x}\int_{-\infty}^{x}e^{i\alpha y}K(y)\,dy,
\qquad
(D+\alpha)u_\alpha=-iK,\qquad
ADu_\alpha=-\alpha Au_\alpha.
\tag{1}
$$

This is the logarithmic-coordinate form of [Hedenmalm, Theorem 3.3.1 and (3.3.2)–(3.3.3)](https://arxiv.org/html/2606.17494). His [Definition 4.2.1](https://arxiv.org/html/2606.17494) asks for pair symmetry on the finite span of these eigenfunctions.

Consider the positive, spatially singular target form

$$
\langle v,w\rangle_c
  =\int_{\mathbb R}\frac{\cosh(2x)}{K(x)^2}v(x)\overline{w(x)}\,dx,
\qquad
q_c(u,v)=\langle Au,Av\rangle_c.
\tag{2}
$$

The first slot is linear. Hedenmalm does not propose this particular weight; it is one concrete unbounded target-metric candidate.

**Theorem.** Let $\alpha$ tend to $+\infty$ through real zeros of $\Xi$. Then $Au_\alpha$ and $ADu_\alpha$ belong to the domain of (2), and

$$
q_c(u_\alpha,u_{-\alpha})
  =-\frac{37}{30\pi\,\alpha^2}+O(\alpha^{-3}).
\tag{3}
$$

In particular, (2) fails Hedenmalm's pair-symmetry condition on the actual finite real-zero span. Hardy's theorem supplies an unbounded sequence of such real zeros, so this is an all-height analytic obstruction rather than a finite-height computation.

## Domain and reflection

Write $h_\alpha=u_\alpha/K$. Because $\Xi(\alpha)=0$, (1) has the upper-tail form

$$
h_\alpha(x)
 =-\int_0^\infty e^{i\alpha s}F_x(s)\,ds,\qquad
F_x(s)=\frac{K(x+s)}{K(x)}.
$$

Differentiating the ratio gives the exact identity

$$
h_\alpha'(x)
 =\int_0^\infty e^{i\alpha s}
   [p(x+s)-p(x)]F_x(s)\,ds.
\tag{4}
$$

Jacobi evenness and the zero condition give

$$
h_\alpha(-x)=-\overline{h_\alpha(x)},\qquad
h_{-\alpha}(x)=\overline{h_\alpha(x)},\qquad
h_\alpha'(-x)=\overline{h_\alpha'(x)}
\tag{5}
$$

for real $\alpha$. Since $Au_\alpha=-iK h_\alpha'$, (2) and (5) yield

$$
q_c(u_\alpha,u_{-\alpha})
 =\int_{\mathbb R}\cosh(2x)\,[h_\alpha'(x)]^2\,dx
 =2\operatorname{Re}\int_0^\infty
   \cosh(2x)\,[h_\alpha'(x)]^2\,dx.
\tag{6}
$$

The square in (6) is a complex square, not a modulus square. A negative off-diagonal value is compatible with positivity of $q_c(u,u)$.

Here and below set

$$
M(x)=2\pi e^{2x},\qquad a=\frac92.
$$

The $n=1$ term of the complete theta series is a positive constant times
$e^{9x/2}e^{-M(x)/2}(1-3/M(x))$; all $n\ge2$ terms and their fixed derivatives are exponentially smaller. Hence, as $x\to+\infty$,

$$
p(x)=M(x)-a+O(M(x)^{-1}),\qquad
p^{(j)}(x)=2^jM(x)+O_j(M(x)^{-1})
\quad(1\le j\le4).
\tag{7}
$$

Choose a fixed $x_0>0$ sufficiently large that, for $x\ge x_0$, $M(x)\ge40$, $p(x)\ge3M(x)/4$, $p'(x)>0$, and
$|p^{(j)}(x+s)|\le C_jM(x)e^{2s}$ for $0\le j\le4$, $s\ge0$. Put $P=p(x)$ and $\Delta_x(s)=p(x+s)-P$. Then

$$
0\le\Delta_x(s)\le CM(x)s e^{2s},
\qquad
F_x(s)=\exp\!\left(-\int_0^s p(x+v)\,dv\right)\le e^{-Ps}.
\tag{8}
$$

Taking absolute values in (4) and integrating $(e^{2s}-1)e^{-Ps}$ gives
$|h_\alpha'(x)|\le C/M(x)$, uniformly in real $\alpha$ and $x\ge x_0$.
Likewise $|h_\alpha(x)|\le1/P$. Reflection gives the same $O(e^{-2|x|})$ bounds at the left endpoint. Therefore

$$
\cosh(2x)|h_\alpha'(x)|^2=O(e^{-2|x|})
$$

at both ends, and the target form in (2) is finite on each real-zero eigenfunction. Equation (1) gives $ADu_\alpha=-\alpha Au_\alpha$, so $ADu_\alpha$ has the same target-domain property.

## Uniform two-term expansion

We need a uniform expansion through order $\alpha^{-2}$; a pointwise expansion near $M\asymp\alpha$ would not justify integrating (6).
For $x\ge x_0$, put

$$
z=P-i\alpha,\qquad
B_x(s)=\exp\!\left(-\int_0^s\Delta_x(v)\,dv\right),\qquad
b_x(s)=\Delta_x(s)B_x(s).
$$

Then (4) becomes
$h_\alpha'(x)=\int_0^\infty e^{-zs}b_x(s)\,ds$.
At $s=0$,

$$
b_x(0)=0,\quad
b_x'(0)=p'(x),\quad
b_x''(0)=p''(x),\quad
b_x'''(0)=p'''(x)-3p'(x)^2.
$$

Four integrations by parts give the exact formula

$$
h_\alpha'(x)
 =\frac{p'}{z^2}+\frac{p''}{z^3}
  +\frac{p'''-3(p')^2}{z^4}
  +\frac1{z^4}\int_0^\infty e^{-zs}b_x^{(4)}(s)\,ds.
\tag{9}
$$

All coefficients $p^{(j)}$ in (9) are evaluated at $x$.
The upper boundary terms vanish by the exponential theta tail. To bound the remainder uniformly, abbreviate $\Delta=\Delta_x$ and $B=B_x$. Direct differentiation gives

$$
\begin{aligned}
B'&=-\Delta B,\\
B''&=(\Delta^2-\Delta')B,\\
B'''&=(-\Delta^3+3\Delta\Delta'-\Delta'')B,\\
B^{(4)}
 &=\bigl(\Delta^4-6\Delta^2\Delta'
       +3(\Delta')^2+4\Delta\Delta''-\Delta'''\bigr)B,\\
b_x^{(4)}
 &=\Delta^{(4)}B+4\Delta'''B'
   +6\Delta''B''+4\Delta'B'''+\Delta B^{(4)}.
\end{aligned}
\tag{10}
$$

Set $y=M(x)s$. From (7)–(8),

$$
|\Delta|\le Cy e^{2y/M},\qquad
|\Delta^{(j)}|\le C_jM e^{2y/M}\quad(1\le j\le4),\qquad B\le1.
$$

Every term in (10) is therefore bounded by
$CM^2(1+y)^5e^{10y/M}$. Since $P/M\ge3/4$ and $M\ge40$,

$$
\int_0^\infty e^{-Ps}|b_x^{(4)}(s)|\,ds
\le CM\int_0^\infty (1+y)^5e^{-y/2}\,dy
\le C'M.
\tag{11}
$$

The same estimates justify each integration by parts. Since
$|z|\asymp\alpha+M$, equations (7), (9), and (11) yield, uniformly for $x\ge x_0$,

$$
h_\alpha'(x)
 =\frac{p'}{z^2}+\frac{p''}{z^3}
  -\frac{3(p')^2}{z^4}
  +O\!\left(\frac{M}{(\alpha+M)^4}\right).
\tag{12}
$$

Now let $t=M/\alpha$, $z_0=M-i\alpha=\alpha(t-i)$. In (12), use
$z=z_0-a+O(M^{-1})$,
$p'=2M+O(M^{-1})$, and $p''=4M+O(M^{-1})$.
Taylor expansion of the rational terms is uniform because $|z_0|\asymp\alpha+M\ge\alpha$. It gives

$$
h_\alpha'(x)
 =\alpha^{-1}F_0(t)+\alpha^{-2}F_1(t)+E_\alpha(t),
\tag{13}
$$

where

$$
F_0(t)=\frac{2t}{(t-i)^2},\qquad
F_1(t)=\frac{4(1+a)t}{(t-i)^3}
       -\frac{12t^2}{(t-i)^4},
\tag{14}
$$

and, for $t\ge t_0:=M(x_0)/\alpha$,

$$
|E_\alpha(t)|\le C\alpha^{-3}R(t),\qquad
R(t)=\frac1{t(1+t)^2}+\frac1{(1+t)^3}
     +\frac{t}{(1+t)^4}+\frac{t^2}{(1+t)^5}.
\tag{15}
$$

For completeness, the potentially singular first term of $R$ comes from
$O(M^{-1})$ in $p'/z^2$. The remaining terms bound the $O(M^{-1})$ shift of $z$, the second and third rational terms, and the remainder of (12). In particular,
$\int_0^\infty |F_0|R\,dt<\infty$,
$\int_0^\infty |F_1|R\,dt<\infty$, and
$\int_{t_0}^\infty R^2dt=O(\alpha)$.
Thus the $1/t$ in (15) causes no lost order at the moving lower endpoint.

On the fixed compact interval $0\le x\le x_0$, two integrations by parts in (4) give
$h_\alpha'(x)=O_{x_0}(\alpha^{-2})$ uniformly.
Indeed $\Delta_x(s)F_x(s)$ vanishes at $s=0$, and its second $s$ derivative has a uniformly bounded $L^1(0,\infty)$ norm there, by positivity of $K$ on the compact $x$ interval and its double-exponential right tail. This interval contributes $O(\alpha^{-4})$ to (6).

## Evaluation of the cross term

For $x\ge x_0$, the substitution $t=M(x)/\alpha$ gives

$$
dx=\frac{dt}{2t},\qquad
\cosh(2x)\,dx
 =\left(\frac{\alpha}{8\pi}
       +\frac{\pi}{2\alpha t^2}\right)dt.
\tag{16}
$$

The second term of (16) contributes $O(\alpha^{-3})$ to (6).
To see this without using (13) near $t=0$, the uniform formula (12) gives

$$
|h_\alpha'(x)|
 \le C\min\!\left(\frac{M}{\alpha^2},\frac1M\right)
 =C\alpha^{-1}\min(t,t^{-1}).
$$

Hence its absolute contribution is bounded by a constant times
$\alpha^{-3}\int_0^\infty t^{-2}\min(t^2,t^{-2})dt$.

For the first term of (16), insert (13). The $F_0E_\alpha$ contribution is
$O(\alpha^{-3})$ by $\int|F_0|R<\infty$; the $E_\alpha^2$ contribution is
$O(\alpha^{-4})$ because $\int_{t_0}^\infty R^2=O(\alpha)$.
All remaining omitted terms are $O(\alpha^{-3})$ or smaller.
Since $F_0(t),F_1(t)=O(t)$ at zero, extending the lower limit $t_0$ to zero changes the final expression by $O(\alpha^{-4})$. Together with the compact region, (6) becomes

$$
q_c(u_\alpha,u_{-\alpha})
 =\frac1{4\pi\alpha}\operatorname{Re}
    \int_0^\infty F_0(t)^2\,dt
  +\frac1{2\pi\alpha^2}\operatorname{Re}
    \int_0^\infty F_0(t)F_1(t)\,dt
  +O(\alpha^{-3}).
\tag{17}
$$

The first real part vanishes exactly:

$$
\int_0^\infty F_0(t)^2dt
 =4\int_0^\infty\frac{t^2}{(t-i)^4}dt
 =\frac{4i}{3}.
$$

For the second, elementary beta integrals give

$$
\int_0^\infty\frac{t^2}{(t-i)^5}dt=-\frac1{12},
\qquad
\int_0^\infty\frac{t^3}{(t-i)^6}dt=-\frac1{20},
$$

so

$$
\operatorname{Re}\int_0^\infty F_0F_1\,dt
 =-\frac23(1+a)+\frac65
 =\frac8{15}-\frac{2a}{3}
 =-\frac{37}{15}.
\tag{18}
$$

Equations (17)–(18) prove (3).

Finally, pair symmetry for $u_\alpha$ and $u_{-\alpha}$ would require

$$
q_c(Du_\alpha,u_{-\alpha})
 =q_c(u_\alpha,Du_{-\alpha}).
$$

By (1), the difference between the two sides is
$-2\alpha\,q_c(u_\alpha,u_{-\alpha})$, which is nonzero for every sufficiently high positive real zero by (3). This excludes precisely the candidate metric (2). It supplies no estimate for a hypothetical off-line zero and no proof of RH.
