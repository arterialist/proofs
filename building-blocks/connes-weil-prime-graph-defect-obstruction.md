# The prime-history graph does not leave a positive Weil defect

The [complete prime-history Goldbach cut](goldbach-complete-prime-phase-cut-energy.md)
is a positive graph Dirichlet energy on prime-power vertices. This note
tests two direct ways to use that positivity in the **full** compact Weil
form. The literal additive graph introduces shifts at logarithms of
rational numbers. A second graph reproduces every Weil prime-power
shift exactly, but its remaining gamma-and-pole defect is negative on
a family of smooth functions whose support grows without bound and
whose Fourier mass concentrates at frequency zero. The latter
counterexample holds for every exponential vertex tilt, including a
tilt chosen separately at each window size. It does not decide the
sign of the full Weil form.

## The complete Weil form and the literal graph

Use logarithmic coordinates on the window $(-a,a)$ and extend $f$ by
zero. For real $f\in C_c^\infty(-a,a)$, set

\[
 C_f(s)=\int_{\mathbb R}f(x)f(x+s)\,dx,\qquad
 M_\pm(f)=\int_{-a}^a e^{\pm x/2}f(x)\,dx,
\]
and $F(t)=\int f(x)e^{itx}\,dx$. In the normalization of the
[complete Connes--Consani form, (2.11)--(2.12)](https://arxiv.org/html/2106.01715),

\[
 Q_a(f)=\frac1{2\pi}\int_{\mathbb R}m(t)|F(t)|^2\,dt
       +2M_+(f)M_-(f)
       -2\sum_{2\le n<e^{2a}}\frac{\Lambda(n)}{\sqrt n}
                         C_f(\log n),                       \tag{1}
\]
where $m(t)=\operatorname{Re}\psi(1/4+it/2)-\log\pi$ and $\psi$ in
this definition is the digamma function. Every $n=p^k$ appears in the
prime sum.

The literal Hilbert-space lift of the positive additive graph at
$X=e^{2a}$ is

\[
 \mathscr G_X(f)=\frac12\sum_{u+v\le X}\Lambda(u)\Lambda(v)
       \|\tau_{\log u}f-\tau_{\log v}f\|_2^2\ge0,            \tag{2}
\]
where pairs are ordered and $\tau_s f(x)=f(x+s)$. Its exact expansion is

\[
 \mathscr G_X(f)=P_X\|f\|_2^2
  -\sum_{u+v\le X}\Lambda(u)\Lambda(v)
               C_f(\log(v/u)),\quad
 P_X=\sum_{u+v\le X}\Lambda(u)\Lambda(v).                 \tag{3}
\]
Thus the defect $Q_a-\mathscr G_X$ contains, besides all terms of
(1), the negative diagonal $-P_X\|f\|_2^2$ and the rational shifts
in the second term of (3). For example, the edge $(u,v)=(4,3)$ has
weight $(\log2)(\log3)$ and shift $\log(4/3)$, which is not a Weil
prime-power shift.

Even the integer-ratio edges have incompatible coefficients. For a
fixed prime $p$ and $j\ge1$, the edges with ratio $p^j$ are exactly
$(p^{k+j},p^k)$, with $k\ge1$ and $p^k(p^j+1)\le X$. Their weight
per orientation is

\[
 (\log p)^2 K_{p,j}(X),\qquad
 K_{p,j}(X)=\max\!\left(0,
       \left\lfloor\log_p\frac{X}{p^j+1}\right\rfloor\right).
                                                               \tag{4}
\]
For fixed $j$, $K_{p,j}(X)\sim\log_p X$. Hence the graph weights at
$\log p$ and $\log p^2$ have ratio tending to $1$, whereas their
Weil coefficients $\log p/\sqrt p$ and $\log p/p$ have ratio
$\sqrt p$. One scalar normalization of (2) cannot match both.

The defect of the literal graph is also negative on smooth tests at
large windows. Let $b=\sqrt a$ and choose a normalized smooth
plateau $f_b$ supported in $(-b/2,b/2)$ as below. In (1), its prime
correlations vanish when $n>e^b$; the gamma term is $O(1)$, and the
pole and remaining prime terms are $O(be^{b/2})$. Thus
$Q_a(f_b)=O(be^{b/2})$. On the other hand, restrict (2) to
$u\le Xe^{-2b}$ and $X/2\le v\le3X/4$. For large $a$ these pairs
satisfy $u+v\le X$ and $\log(v/u)>b$, so the translated supports
are disjoint. The prime number theorem gives

\[
 \mathscr G_X(f_b)\ge
 2\psi(Xe^{-2b})
  \bigl[\psi(3X/4)-\psi(X/2)\bigr]
 \gg X^2e^{-2b}=e^{4a-2\sqrt a}.                         \tag{5}
\]
Here $\psi(y)=\sum_{n\le y}\Lambda(n)$ is Chebyshev's function.
Consequently $Q_a(f_b)-\mathscr G_X(f_b)<0$ for all large $a$.

## A graph that exactly matches the prime shifts

The coefficient mismatch in (4) can be removed by using an edge for
each admitted prime power $n$, joining $x$ to $x+\log n$ only when
both points lie in $(-a,a)$. An exponential tilt gives a family of
positive graph energies. For any real $\sigma$ (possibly depending on
$a$), put $d_n=\log n$ and

\[
 \mathcal E_{\sigma,a}(f)=
 \sum_{2\le n<e^{2a}}\Lambda(n)n^{-\sigma-1/2}
 \int_{-a}^{a-d_n}
 \left|e^{-\sigma x}f(x)
       -e^{\sigma(x+d_n)}f(x+d_n)\right|^2dx\ge0.       \tag{6}
\]
The mixed product in each square has coefficient
$\Lambda(n)n^{-\sigma-1/2}e^{\sigma d_n}
=\Lambda(n)/\sqrt n$. Hence its cross term is **exactly** the
last term of (1), without dropping a prime power. Expanding the
remaining diagonal gives

\[
 \begin{aligned}
 Q_a(f)&=\mathcal E_{\sigma,a}(f)+\mathcal R_{\sigma,a}(f),\\
 \mathcal R_{\sigma,a}(f)
 &=\frac1{2\pi}\int m(t)|F(t)|^2dt+2M_+(f)M_-(f)
       -\int_{-a}^a V_{\sigma,a}(x)|f(x)|^2dx,\\
 V_{\sigma,a}(x)
 &=e^{-2\sigma x}
      \sum_{2\le n<e^{a-x}}\Lambda(n)n^{-\sigma-1/2}
   +e^{2\sigma x}
      \sum_{2\le n<e^{a+x}}\Lambda(n)n^{-\sigma-1/2}.
 \end{aligned}                                                \tag{7}
\]
The endpoint convention in these sums does not affect the integrals.
Formula (7) is the exact defect kernel, with the gamma factor and both
poles retained.

## Uniformly negative defect on smooth low-frequency plateaus

Fix a smooth even cutoff $g_b$ equal to $1$ on
$|x|\le b/2-1$, supported in $|x|<b/2$, and between $0$ and $1$.
Choose it with transition derivatives bounded independently of $b$.
Set $f_b=c_b b^{-1/2}g_b$, where $c_b=1+O(b^{-1})$ normalizes
$\|f_b\|_2=1$. Take $a=b^2$. Then
$\|f_b'\|_2^2=O(b^{-1})$, so its Fourier mass outside every fixed
neighborhood of $t=0$ tends to zero. Its support width $b$ grows
without bound, yet remains inside the Weil window.

Let $J_b=[b/2-2,b/2-1]$. On this unit interval,
$|f_b(x)|^2=c_b^2/b$ and $e^x\ge e^{b/2-2}$. We claim that for all
sufficiently large $b$,

\[
 \inf_{\sigma\in\mathbb R}\ \inf_{x\in J_b}
             V_{\sigma,b^2}(x)\ge c,b e^{b/2},         \tag{8}
\]
with an absolute $c>0$. The needed arithmetic input is the
prime-number-theorem consequence

\[
 \sum_{e^A\le n\le e^B}\frac{\Lambda(n)}n
       =(B-A)+o(B)\quad
       \text{when }A,B\to\infty\text{ at fixed positive ratio}.
                                                               \tag{9}
\]

If $\sigma\ge1/2$, write $\delta=\sigma-1/2\ge0$ and retain in the
second sum of $V$ only $e^{b/4}\le n\le e^{b/2}$. For $x\in J_b$,
$2x\ge b-4\ge b/2\ge\log n$. Therefore
$e^{2\delta x}n^{-\delta}\ge1$, and (9) gives

\[
 V_{\sigma,a}(x)\ge
 e^x\sum_{e^{b/4}\le n\le e^{b/2}}\frac{\Lambda(n)}n
 \ge c_1b e^{b/2}.                                     \tag{10}
\]
If $\sigma<1/2$, put $\varepsilon=1/2-\sigma>0$ and retain instead
$e^{a/2}\le n\le e^a$. This band lies below the second sum's
cutoff $e^{a+x}$. Since $\log n\ge a/2\ge2x$ for large $b$,
$e^{-2\varepsilon x}n^\varepsilon\ge1$. Again (9) yields

\[
 V_{\sigma,a}(x)\ge
 e^x\sum_{e^{a/2}\le n\le e^a}\frac{\Lambda(n)}n
 \ge c_2a e^{b/2}\ge c_2b e^{b/2}.                    \tag{11}
\]
This proves (8) without fixing or bounding $\sigma$.

The negative potential in (7) therefore has size at least
$c' e^{b/2}$. Since $f_b$ is even,
$M_+(f_b)=M_-(f_b)$, and direct integration gives

\[
 2M_+(f_b)M_-(f_b)\le C\frac{e^{b/2}}b.             \tag{12}
\]
Finally $m(t)=O(\log(2+|t|))$ above and below by a constant, so
$m(t)\le C(1+t^2)$; Plancherel and
$\|f_b'\|_2^2=O(b^{-1})$ bound the gamma term above by $O(1)$.
Equations (7)--(12) prove

\[
 \boxed{\quad
 \mathcal R_{\sigma,b^2}(f_b)
 \le -c'e^{b/2}+O(e^{b/2}/b)+O(1)<0
 \quad\text{for all large }b,
 \text{ uniformly in }\sigma\in\mathbb R.\quad}         \tag{13}
\]

The graph energy (6) is genuinely positive and reproduces the
complete Weil prime term, but its exact defect is not nonnegative on
these hard low-frequency modes at arbitrarily large windows. This is
a counterexample to this graph factorization, not to all possible
factorizations and not to Weil positivity itself. No RH or new
positive window is obtained.
