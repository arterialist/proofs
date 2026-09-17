# The full cusp-profile asymptotic of the actual quadrature correction

Written proof using classical fractional-endpoint quadrature, Bernoulli Fourier series and harmonic Mangoldt estimates. The uniform per-birth estimates below retain the actual arithmetic source. No priority or Lean claim is made.

Use exactly $\epsilon(t)$, $q_n$, $p_t$, and $P_t$ from
[the coherent quadrature refinement](actual-coherent-successor-quadrature-refinement.md).
Here $t=-\log r>0$ is the geometric successor parameter. Then
$$
 \boxed{\epsilon(t)=\frac{\zeta(3/2)}{4\pi}\,
 t\log(1/t)+O(t)\qquad(t\downarrow0).}
 \tag{1}
$$
The coefficient comes from all distance cells behind every integer
birth, not only its immediately preceding unit cell. All estimates
below are uniform in the actual integer $n\ge2$ before summation
against $\Lambda(n)$, so every prime power remains.

## 1. The exact periodic primitive and punctured integration

For $0\le v\le1$, write
$$
 w_t(v)=-P_t(v)/t
 =\frac{v(e^t-1)-(e^{tv}-1)}{t^2},\qquad
 w(v)=\frac{v(1-v)}2,
 \tag{2}
$$
and extend both periodically. Comparison of the second derivative
of $e^{tv}$ with $t^2$ and $e^tt^2$, retaining its linear
interpolant between zero and one, gives
$$
 \boxed{w(v)\le w_t(v)\le e^t w(v)\qquad(0\le v\le1).}
 \tag{3}
$$
This relative bound holds at the endpoints as well; both functions
vanish there. In particular $P_t$ vanishes linearly at every integer.

The complete kernel is
$$
 q_n(u)=
 \begin{cases}
 u^{-1/2}\arcsin\sqrt{u/n},&0<u<n,\\
 \pi/(2\sqrt u),&u\ge n,
 \end{cases}
 \qquad q_n(0)=n^{-1/2}.
 \tag{4}
$$
On $u<n$ its power series has nonnegative coefficients, so
$q_n'\ge0$ and $q_n''\ge0$. On $u>n$,
$q_n''=3\pi/(8u^{5/2})>0$, although $q_n'<0$.
Its left cusp has
$$
 q_n'(n-\delta)=O(n^{-1}\delta^{-1/2}+n^{-3/2})
 \quad(0<\delta<n/2).
 \tag{5}
$$
Consequently $P_t(n-\delta)q_n'(n-\delta)\to0$.
At $n+$, $P_t=0$ and the right derivative is finite.
The origin contributes zero because $P_t(0)=0$, and the
exponential boundary at infinity vanishes.

Integrate separately on $[0,n-\delta]$ and $[n,\infty)$,
then let $\delta\downarrow0$. This proves the exact identity
$$
 \epsilon(t)=t\sum_{n\ge2}\Lambda(n)
 \int_0^\infty w_t(u)e^{-tu}
 [q_n''(u)-tq_n'(u)]\,du.
 \tag{6}
$$
The second derivative in (6) is the ordinary derivative on the
two open intervals. No distributional second derivative through
the infinite left contact is asserted.
The bounds below justify the limiting integrals and the complete
sum absolutely.

The proved variation estimate
$$
 \sum_{n\ge2}\Lambda(n)\int_0^\infty
 e^{-tu}|q_n'(u)|\,du\ll t^{-1/2}
 \quad(0<t\le1)
 \tag{7}
$$
shows that the $tq_n'$ contribution in (6) is $O(t^{3/2})$.

## 2. A uniform estimate for each complete cusp

Put
$$
 I_n(t)=\int_0^\infty w(u)e^{-tu}q_n''(u)\,du,\qquad
 C_{\rm cusp}=\frac14\int_0^\infty w(\delta)\delta^{-3/2}\,d\delta.
 \tag{8}
$$
The latter integral is finite: $w(\delta)=O(\delta)$ at zero
and $w$ is bounded at infinity. We prove the uniform estimate
$$
 \boxed{
 I_n(t)=C_{\rm cusp}\frac{e^{-tn}}n
 +O\!\left(n^{-3/2}
 +t n^{-1/2}e^{-tn/2}\right),
 \quad n\ge2,\quad0<t\le1.}
 \tag{9}
$$

On $0<u\le n/2$, the convergent arcsine series and its derivatives
give $|q_n''(u)|\ll n^{-5/2}$. Its integral contributes
$O(n^{-3/2})$. The entire right branch $u>n$ also contributes
$O(n^{-3/2})$, directly from (4).

On the remaining interval put $\delta=n-u$, $0<\delta<n/2$.
Direct differentiation gives
$$
 q_n''(u)=\frac{3\arcsin\sqrt{u/n}}{4u^{5/2}}
 -\frac{3}{4u^2\sqrt{n-u}}
 +\frac{1}{4u(n-u)^{3/2}}.
 \tag{10}
$$
Since $u\ge n/2$,
$$
 \left|q_n''(n-\delta)-\frac1{4n\delta^{3/2}}\right|
 \le C\left(n^{-5/2}+n^{-2}\delta^{-1/2}\right).
 \tag{11}
$$
The first part of the last term is controlled using
$|1/(n-\delta)-1/n|\le2\delta/n^2$.
Both errors in (11) have integral $O(n^{-3/2})$.

The integer history now matters exactly:
$w(n-\delta)=w(\delta)$, including all distance cells.
Thus
$$
 I_n(t)=\frac1{4n}\int_0^{n/2}
 w(\delta)\delta^{-3/2}e^{-t(n-\delta)}\,d\delta
 +O(n^{-3/2}).
 \tag{12}
$$
No restriction to $0<\delta<1$ has been made.
Replace the exponential by $e^{-tn}$. The resulting error is at most
$$
 \frac{Ct e^{-tn/2}}n\int_0^{n/2}\delta^{-1/2}\,d\delta
 \le Ct n^{-1/2}e^{-tn/2},
 \tag{13}
$$
using $e^{t\delta}-1\le t\delta e^{t\delta}$.
Finally, extending the distance integral from $n/2$ to infinity
costs $O(n^{-3/2})$, since $w$ is bounded. This proves (9)
uniformly, including $n=2$.

## 3. Summation before the limit

Chebyshev's bound yields
$$
 \sum_{n\ge2}\Lambda(n)n^{-3/2}<\infty,\qquad
 t\sum_{n\ge2}\Lambda(n)n^{-1/2}e^{-tn/2}=O(\sqrt t).
 \tag{14}
$$
The second estimate follows by ordinary partial summation against
the decreasing positive kernel. Thus (9) gives
$$
 \sum_{n\ge2}\Lambda(n)I_n(t)
 =C_{\rm cusp}\sum_{n\ge2}\frac{\Lambda(n)}n e^{-tn}+O(1).
 \tag{15}
$$
This is the required uniform all-prime/all-power control.
In particular the nonnegative left side is $O(\log(2/t))$.
Positivity of $q_n''$ and (3) allow replacement of $w_t$ by
$w$ in (6), with total error $O(t^2\log(2/t))$.
Together with (7), we therefore have the stronger intermediate formula
$$
 \boxed{
 \epsilon(t)=C_{\rm cusp}\,t
 \sum_{n\ge2}\frac{\Lambda(n)}n e^{-tn}+O(t).}
 \tag{16}
$$
This proof also establishes the absolute summability required for
the punctured integration in (6).

Only an elementary harmonic prime-power estimate is needed:
$$
 \sum_{n\le x}\frac{\Lambda(n)}n
 =\log x+O(1).
 \tag{17}
$$
For an integer $N\ge2$, the exact factorial identity gives
$$
0\le N\sum_{n\le N}\frac{\Lambda(n)}n-\log(N!)
=\sum_{n\le N}\Lambda(n)\{N/n\}\le\psi(N)\ll N.
$$
Integral comparison gives $\log(N!)=N\log N-N+O(\log N)$,
which proves (17), also for real $x$ by taking its integer part.
If $A(x)=\sum_{n\le x}\Lambda(n)/n$, positive partial summation
now gives
$$
\sum_{n\ge2}\frac{\Lambda(n)}n e^{-tn}
=t\int_1^\infty e^{-tx}A(x)\,dx
=\log(1/t)+O(1).
$$
The last step uses the substitution $u=tx$ and integrability
of $e^{-u}|\log u|$. Thus no PNT estimate is required for (1).

## 4. Evaluation of the complete profile constant

The classical [Bernoulli Fourier identity](https://dlmf.nist.gov/24.8.E1), in an absolutely convergent form, is
$$
 \{\delta\}(1-\{\delta\})
 =\frac1{\pi^2}\sum_{k\ge1}
 \frac{1-\cos(2\pi k\delta)}{k^2}.
 \tag{18}
$$
Its summands are nonnegative, so positive Tonelli applies after
multiplication by $\delta^{-3/2}$. For $a>0$,
$$
 \int_0^\infty(1-\cos(a\delta))\delta^{-3/2}\,d\delta
 =\sqrt{2\pi a}.
 \tag{19}
$$
For a nonconditional evaluation, insert
$\delta^{-3/2}=\Gamma(3/2)^{-1}
\int_0^\infty s^{1/2}e^{-s\delta}\,ds$.
The inner integral is $a^2/[s(s^2+a^2)]$, and the remaining
positive [Euler beta integral](https://dlmf.nist.gov/5.12.E3) gives (19).
Consequently
$$
 C_{\rm cusp}
 =\frac18\int_0^\infty
 \{\delta\}(1-\{\delta\})\delta^{-3/2}\,d\delta
 =\frac1{8\pi^2}\sum_{k\ge1}\frac{2\pi\sqrt k}{k^2}
 =\boxed{\frac{\zeta(3/2)}{4\pi}}.
 \tag{20}
$$
Equations (16)--(20) prove (1).

In particular the actual correction is positive for all sufficiently
small $t$. This sharpens its asymptotic magnitude and coefficient;
it does not establish the sign of the coherent main readout $Q(t)$.
The exact relation
$$
 E(e^{-t})+C(t)=\frac{e^t-1}{t}Q(t)+\epsilon(t)
 $$
still retains the initial return correction $C(t)$, the density,
and the unresolved signed $Q(t)$.

The positive interpolation defect $D(t)$ in
[the integer-birth interpolation theorem](actual-integer-birth-positive-quadrature.md)
has the same leading term. Indeed its exact normalization gives
$$
D(t)=\epsilon(t)+\left[\frac{e^t-1}{t}
-\frac{t}{1-e^{-t}}\right]Q(t),
$$
and the bracket is $O(t^2)$, while Chebyshev gives
$Q(t)=O(t^{-1/2})$. Therefore
$$
\boxed{D(t)=\frac{\zeta(3/2)}{4\pi}\,t\log(1/t)+O(t).}
$$
This completes the correction's asymptotic. The remaining arithmetic
task is the constant-scale signed finite-core comparison.
