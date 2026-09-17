# An analytic three-halves zero-moment bound under RH

Assume RH. The [canonical-product normalization](../successor-and-division/successor-feedback-RH-converse.md) gives the identity
$$
 S_2:=\sum_\rho\frac{m_\rho}{\gamma_\rho^2+1/4}
 =2+\gamma_E-\log(4\pi)<\frac{47}{1000},
 \qquad \rho=\frac12+i\gamma_\rho.
 \tag{1}
$$
Sums run over distinct nontrivial zeros, include both signs of the
ordinate, and include each multiplicity $m_\rho$ exactly once.
Then
$$
 \boxed{S_{3/2}:=\sum_\rho\frac{m_\rho}{|\gamma_\rho|^{3/2}}
 <\frac{509}{1000}<\frac{51}{100}.}
 \tag{2}
$$
This replaces the zero-counting input in the common-halfline
argument. It uses no numerical zero verification or simplicity
assumption.

## Resolvent and its normalization

The zero at ordinate zero is excluded by (1) itself. A conjugate
pair at height at most $13/2$ would contribute at least
$$
 \frac{2}{(13/2)^2+1/4}=\frac4{85}>\frac{47}{1000}.
 $$
Thus every $|\gamma_\rho|>13/2$.

Define for $t>0$
$$
 A(t)=\sum_\rho\frac{m_\rho}{\gamma_\rho^2+t^2}
 =\frac1t\,\frac{\xi'}{\xi}\left(\frac12+t\right).
 \tag{3}
$$
The equality follows by logarithmically differentiating the paired
canonical product
$$
 \frac{\xi(1/2+t)}{\xi(1/2)}
 =\prod_{\gamma>0}(1+t^2/\gamma^2)^{m_\gamma}.
 $$
The convergence of $\sum m_\rho/\gamma_\rho^2$ follows already
from (1) and the gap just proved, so differentiation is locally
uniform. Each positive ordinate contributes $2m_\gamma$ to (3);
there is no additional factor of two.

Positive Tonelli and a beta integral give, initially as an equality
of possibly infinite nonnegative quantities,
$$
 \boxed{S_{3/2}=\frac{\sqrt2}{\pi}
 \int_0^\infty t^{-1/2}A(t)\,dt.}
 \tag{4}
$$
Indeed substitution $t=|\gamma|u$ yields
$$
 \int_0^\infty\frac{t^{-1/2}}{\gamma^2+t^2}\,dt
 =\frac{\pi}{\sqrt2}|\gamma|^{-3/2}.
 $$
The estimates below prove finiteness, so it is not presumed.

## A direct digamma inequality

For $y>0$, let $U$ have density
$e^{-u}u^{y-1}/\Gamma(y)$ on $u>0$.
[Euler's gamma integral and the digamma definition](https://dlmf.nist.gov/5.2)
give
$$
 \frac{\Gamma'(y)}{\Gamma(y)}=\mathbb E\log U,\qquad
 \mathbb E U=\frac{\Gamma(y+1)}{\Gamma(y)}=y.
 $$
Differentiation under the integral is justified on a neighborhood
of each $y>0$ by integrable powers times $1+|\log u|$.
Strict Jensen for the logarithm consequently proves
$$
 \boxed{\psi_{\rm digamma}(y)<\log y\quad(y>0).}
 \tag{5}
$$
This proves the precise inequality needed here rather than
importing a numerical digamma bound.

## Three explicit integral regions

For $0<t\le1/2$, the gap implies
$$
 A(t)\le\sum_\rho\frac{m_\rho}{\gamma_\rho^2}
 \le\left(1+\frac1{169}\right)S_2.
 \tag{6}
$$
For $1/2\le t\le10$, termwise comparison gives $A(t)\le S_2$.
Thus the entire initial contribution is at most
$$
 \int_0^{10}t^{-1/2}A(t)\,dt
 \le2S_2\sqrt{10}+\frac{2S_2}{169\sqrt2}.
 \tag{7}
$$

For $t\ge10$ put $s=t+1/2>1$. The actual completed zeta
logarithmic derivative is
$$
 \frac{\xi'}{\xi}(s)
 =\frac1s+\frac1{s-1}-\frac12\log\pi
 +\frac12\psi_{\rm digamma}(s/2)+\frac{\zeta'}{\zeta}(s).
 \tag{8}
$$
The last term is negative, by its absolutely convergent actual
von Mangoldt series on $s>1$. Using (5) and retaining both
rational factors gives
$$
 \begin{aligned}
 A(t)
 &\le\frac1t\left[
 \frac1{t+1/2}+\frac1{t-1/2}
 +\frac12\log\frac{t+1/2}{2\pi}\right]\\
 &\le\frac{\log(t/(2\pi))}{2t}+\frac{175}{76t^2}.
 \end{aligned}
 \tag{9}
$$
Here $1/(t+1/2)\le1/t$,
$1/(t-1/2)\le20/(19t)$, and
$\frac12\log(1+1/(2t))\le1/(4t)$.
The coefficient is exactly $1+20/19+1/4=175/76$.
Integration gives
$$
 \int_{10}^\infty t^{-1/2}A(t)\,dt
 \le\frac{\log(10/(2\pi))+2}{\sqrt{10}}
 +\frac{175}{114\,10^{3/2}}.
 \tag{10}
$$

Combining (4), (7), and (10),
$$
 S_{3/2}<
 \frac{\sqrt2}{\pi}\left[
 \frac{47}{500}\sqrt{10}
 +\frac{47}{500\cdot169\sqrt2}
 +\frac{\log(10/(2\pi))+2}{\sqrt{10}}
 +\frac{175}{114\,10^{3/2}}\right].
 \tag{11}
$$
Every term is elementary. For a wholly rational final comparison,
use
$$
 \pi>\frac{157}{50},\quad
 \frac{79}{25}<\sqrt{10}<\frac{3163}{1000},\quad
 \frac75<\sqrt2<\frac{283}{200},\quad
 \log\frac{10}{2\pi}<\frac{47}{100}.
 \tag{12}
$$
The square-root inequalities follow by squaring. The last one
follows from $10/(2\pi)<250/157$ and the rational inequality
$\sum_{j=0}^4(47/100)^j/j!>250/157$.
These bounds put (11) strictly below
$$
 \frac{283}{628}\left[
 \frac{47}{500}\frac{3163}{1000}
 +\frac{47}{500}\frac5{1183}
 +\frac{247}{316}+\frac{875}{18012}\right]
 =\frac{850218424348087}{1672693386000000}
 <\frac{509}{1000}.
 \tag{13}
$$
This proves (2), with every zero and multiplicity retained.
The result is conditional on RH exactly as stated; the method
removes a finite zero-count verification dependency, not the RH
assumption of the common-halfline converse.

## Classical inputs and formal scope

The paired Hadamard product, positive Tonelli theorem, Euler beta integral and Jensen inequality are classical. The explicit integral estimates above give the stated conditional zero-moment bound and feed the [uniform resolvent converse](../successor-and-division/successor-resolvent-common-halfline-RH-converse.md). This is a written proof; the zero-moment bound and its resolvent application are not asserted to be Lean formalized.
