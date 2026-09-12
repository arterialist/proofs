# The actual successor feedback: factorial budget and a moving coefficient cutoff

For the completed source $g(y)=\psi(y)/y-1$, retain
$$
 E(r)=\sum_{j\ge0}\kappa(S^ja)r^j
 =\frac1{2r}\int_1^\infty g(y)w_r(y)\,dy,\qquad 0<r<1,
$$
$$
 H_j(y)=\mathbf1_{y\ge j+1}(y-j)^{-1/2},\qquad
 w_r=(1-r)\sum_{j\ge0}r^j(H_j-H_0).
 \tag{1}
$$
These are the literal kernels of
[the completed resolvent](actual-successor-resolvent-boundary-criterion.md).
The results below do not establish the unproved eventual sign of $E$.
They identify its signed arithmetic budget and prove that every possible
negative von Mangoldt coefficient lies below an explicit moving cutoff.

## 1. The factorial potential with its complete cell data

Use the already established tilted cumulative
$$
 F(y)=-\int_1^y g(t)\frac{dt}{t}
 =\log y-\sum_{n\le y}\frac{\Lambda(n)}n+\frac{\psi(y)}y.
 \tag{2}
$$
It is continuous, $F(1)=0$, and $F(y)>0$ for $y>1$.
The actual divisor identity, including all proper powers, gives
$$
 yF(y)=y\log y-\log(\lfloor y\rfloor!)
 +\sum_{n\le y}\Lambda(n)\left(1-\left\{\frac yn\right\}\right).
 \tag{3}
$$
This is the proof of positivity in
[the factorial cumulative note](actual-W-positive-primitive-analysis.md).
At a divisor endpoint the fractional-part factor in (3) is one.
There is no omitted initial source: $F(y)=\log y$ for $1\le y\le2$.
On each cell $n\le y\le n+1$,
$$
 F(y)=F(n)+\log(y/n)+\psi(n)(1/y-1/n).
 \tag{4}
$$
At the right endpoint the newly admitted prime-power term has zero
weight in (2), so (4) remains valid by continuity.

## 2. Exact signed adjoint measure

Set $k_r(y)=y w_r(y)$. For $n<y<n+1$,
$$
 k_r'(y)=\frac{1-r}{2}\sum_{j=0}^{n-1}
 r^j\frac{y-2j}{(y-j)^{3/2}}-\frac1{2\sqrt y}<0.
 \tag{5}
$$
Indeed, for $0\le t<1$,
$$
 \frac{1-2t}{(1-t)^{3/2}}\le1.
 \tag{6}
$$
The derivative of the left side is
$-(1/2+t)(1-t)^{-5/2}<0$. The weights in (5) sum to
$1-r^n<1$, giving the explicit upper bound
$k_r'(y)\le-r^n/(2\sqrt y)$.
At every integer $n\ge2$, there is instead an upward birth
$$
 k_r(n)-k_r(n-)=n(1-r)r^{n-1}.
 \tag{7}
$$
Write $V_r=-k_r'>0$ on the open cells. The endpoint values and masses are
$$
 k_r(1)=-r,\quad k_r(\infty)=0,\quad
 \sum_{n\ge2}n(1-r)r^{n-1}=\frac{r(2-r)}{1-r},\quad
 \int_1^\infty V_r(y)\,dy=\frac r{1-r}.
 \tag{8}
$$
One direct justification of finite variation is to use
$k_j=y(H_j-H_0)$, $j\ge1$. It decreases continuously, has just one
upward jump $j+1$ at $j+1$, starts at $-1$, and ends at zero.
Its continuous decreasing variation is $j$, and total variation is
$2j+1$. Summing these bounds against $(1-r)r^j$ proves (8)
and all measure exchanges.

Integration by parts now gives the exact budget
$$
 \boxed{2rE(r)=
 \sum_{n\ge2}n(1-r)r^{n-1}F(n)
 -\int_1^\infty V_r(y)F(y)\,dy.}
 \tag{9}
$$
The initial boundary term is zero because $F(1)=0$.
For fixed $r$, splitting the geometric sum at $j=y/2$ gives
$k_r(y)=O_r(y^{-1/2})$, so the upper boundary term vanishes even
using the elementary bound $F(y)=O(\log(2y))$.
The same split controls the integrals in (9) absolutely.

There is a normalized fixed-history version. Let
$$
 v_j(y)=
 \begin{cases}
 1/(2\sqrt y),&1<y<j+1,\\
 1/(2\sqrt y)-(y-2j)/(2(y-j)^{3/2}),&y>j+1.
 \end{cases}
$$
Then $v_j>0$, $\int v_j=j$, and
$$
 2rE(r)=(1-r)\sum_{j\ge1}r^j
 \left[(j+1)F(j+1)-j\int F\,d\mu_j\right],
 \qquad d\mu_j=v_j(y)\,dy/j.
 \tag{10}
$$
Thus the missing comparison concerns actual endpoint values versus
these explicit averages, with the exact cell evolution (4).

The positive atomic term itself has a factorial generating formula:
$$
 \boxed{\sum_{n\ge2}n(1-r)r^{n-1}F(n)
 =(1-r)\sum_{n\ge1}n r^{n-1}\log n
 -\frac1{1-r}\sum_{d\ge2}\frac{\Lambda(d)}d r^d.}
 \tag{11}
$$
To verify it, expand (2) and use
$$
 \sum_{n\ge d}r^{n-1}(n/d-1)
 =\frac{r^d}{d(1-r)^2}.
$$
Also
$$
 \sum_{n\ge1}n r^{n-1}\log n
 =\frac{d}{dr}\left[(1-r)\sum_{n\ge1}\log(n!)r^n\right].
 \tag{12}
$$
Equations (3), (4), and (9)--(12) are a literal divisor/factorial
representation, not a replacement by an arbitrary positive source.

The previously proved assertion $F\ge0$ alone cannot sign (9):
its adjoint measure has both the positive atoms (7) and strictly
negative density (5). For example, a nonzero nonnegative smooth
function supported strictly inside $(1,2)$ has a strictly negative
pairing with this measure. This is only a test of the proposed
cumulative-order implication. Such a function does not satisfy the
actual initial identity $F(y)=\log y$ or (4), and is not an
arithmetic counterexample.

## 3. Exact signed prime-power coefficients

There is an absolutely convergent actual arithmetic expansion
$$
 \boxed{E(r)=\sum_{n\ge2}\Lambda(n)W_r(n),\qquad
 W_r(n)=\frac1{2r}\int_n^\infty\frac{w_r(y)}y\,dy.}
 \tag{13}
$$
The density term $-1$ in $g$ cancels exactly because
$\int w_r=0$; it has not been discarded. Absolute Fubini follows
from
$\int |w_r(y)|\psi(y)/y\,dy<\infty$, using Chebyshev's bound
$\psi(y)\ll y$ and $w_r\in L^1$.

Define
$$
 \phi_0(n)=n^{-1/2},\qquad
 \phi_j(n)=\frac1{\sqrt j}
 \arctan\sqrt{\frac{j}{\max(n,j+1)-j}}\quad(j\ge1).
 \tag{14}
$$
Substitution $y=j+t^2$ evaluates each integral exactly:
$$
 \boxed{W_r(n)=\frac1r
 \left[(1-r)\sum_{j\ge0}r^j\phi_j(n)-n^{-1/2}\right].}
 \tag{15}
$$
For $1\le j\le n-1$,
$\phi_j(n)=j^{-1/2}\arcsin\sqrt{j/n}$.
For $j\ge n-1$ it is
$\arctan\sqrt j/\sqrt j$; both expressions agree at $j=n-1$.
These formulas keep every negative small-prime coefficient and every
proper-power history.

Using $\arcsin t\ge t+t^3/6$ on $[0,1]$, and merely
$\phi_j(n)\ge0$ for $j\ge n$, gives
$$
 \begin{aligned}
 W_r(n)&\ge
 \frac{1-r}{6r n^{3/2}}\sum_{j=1}^{n-1}jr^j
 -\frac{r^{n-1}}{\sqrt n}\\
 &=\frac{1-r^{n-1}\,[r+7n(1-r)]}
 {6(1-r)n^{3/2}}.
 \end{aligned}
 \tag{16}
$$
In particular, put $t=n(1-r)$. For $t\ge5$,
$$
 r^{n-1}[r+7n(1-r)]
 \le e^{1-t}(1+7t)\le36e^{-4}<1.
 \tag{17}
$$
The second inequality follows by differentiating
$(1+7t)e^{-t}$. Hence
$$
 \boxed{n\ge\frac5{1-r}\quad\Longrightarrow\quad
 W_r(n)\ge
 \frac{1-36e^{-4}}{6(1-r)n^{3/2}}>0.}
 \tag{18}
$$
This is uniform in the whole parameter interval $0<r<1$.
It requires no prime cancellation estimate or asymptotic onset.
With $N_r=\lceil5/(1-r)\rceil$, it yields the rigorous sign budget
$$
 E(r)\ge\sum_{2\le n<N_r}\Lambda(n)W_r(n)
 +\frac{1-36e^{-4}}{6(1-r)}
 \sum_{n\ge N_r}\frac{\Lambda(n)}{n^{3/2}}.
 \tag{19}
$$
The latter series is positive and absolutely convergent. All possible
negative coefficients are retained in the finite first term.

The movement of this cutoff is essential. For every fixed $n$,
$\phi_j(n)\to0$ as $j\to\infty$; elementary Abel averaging in
(15) gives
$$
 \boxed{\lim_{r\uparrow1}W_r(n)=-n^{-1/2}.}
 \tag{20}
$$
Thus every fixed actual prime-power coefficient eventually becomes
negative. Positivity, if established near the resolvent boundary,
must use arithmetic contributions at moving, unbounded integers
together with the retained finite negative terms. Neither (18) nor
the positive factorial potential supplies that collective estimate.

The construction therefore gives two usable exact constraints:
the endpoint-versus-cell budget (9), and the moving finite-negative
region (18). The eventual sign of the actual $E(r)$, and hence
the remaining RH consumer, is still unproved.

The notation $W_r(n)$ in this chapter is the birth coefficient $d_r(n)$ of [the factorial-division expansion](actual-Abel-factorial-division-positivity.md); it is not the quadratic W readout. The potential $F$ and the signed adjoint measure provide a separate endpoint-versus-cell formulation of the same feedback.

This chapter contains written proofs and applications of the stated classical inputs. No Lean formalization of its scaling, moment or signed-core conclusion is asserted, and no unconditional boundary sign for the actual feedback is claimed.

The [factorial-potential interpolation](factorial-potential-integer-interpolation.md) is a separate exact decomposition with a negative nonvanishing correction. The [positive common-inner observation](coherent-core-positive-observation-inner-history.md) and its [signed original-source cutoff port](positive-history-observation-original-cutoff-port.md) retain the complete scalar core question.
