# Actual heat response on the first logarithmic cells

This note tests the arithmetic heat response against the cell geometry in
[the Euler-discrepancy audit](causal-renewal-euler-discrepancy-audit.md).
The results use no zero-free hypothesis.

Put $t=e^{-v}$, and use the definitions in
[the renewal note](prime-division-renewal-lyapunov.md):

\[
b(v)=\sqrt t\left\{\sum_{k\ge2}\Lambda(k)e^{-kt}
 -(1+t^{-1})e^{-t}\right\},\qquad
B=-\frac{1+\gamma}{2},\qquad h(v)=b(v)-B\quad(v\ge0).
\tag{1}
\]

The function $b$ is smooth. On $v>0$, $h'=b'$, and direct
differentiation gives the exact, absolutely convergent formula

\[
b'(v)=\sqrt t\left\{
 \sum_{k\ge2}\Lambda(k)(tk-\tfrac12)e^{-kt}
 -e^{-t}\left(t+\tfrac12+\frac1{2t}\right)
\right\}.
\tag{2}
\]

Finite-sum rational enclosures, including all prime powers $k\le100$,
give

\[
\begin{array}{c|c}
v&b'(v)=h'(v)\\ \hline
\log2&(-0.060112,-0.060111)\\
\log3&(0.070492,0.070494).
\end{array}
\tag{3}
\]

Thus $h$ has an interior minimum in the cell
$[\log2,\log3]$. Neither $b$ nor $h$ is monotone on every integer
logarithmic cell. On this cell the Euler kernel $H=J'$ starts
positive and ends negative, while the response derivative has the
opposite signs at the two ends. This excludes same-sign alignment
throughout the cell. Anti-alignment also fails: at the interior point
$v=\log(5/2)$, so $t=2/5$, the same rational-interval method gives

\[
0.018173<h'(v)=b'(v)<0.018175,\qquad
0.00518<H(v)<0.00519.
\tag{3a}
\]

For the $H$ enclosure, use audit Eq. (4) at $n=20$ to bound
$\zeta(1/2)$ and the exact second-cell formula
$H(v)=1+2^{-1/2}-\zeta(1/2)-2(5/2)^{1/2}$.
The response and Euler kernel therefore have no fixed relative sign
throughout this cell.

The [rational-interval checker](verification/actual_heat_cell_interval.py)
reproduces (3), (3a), and (6). For $r=2,3$, truncate
(2) at $k=100$, take $t=1/r$, and use
$\Lambda(k)\le\log k\le k$. With $q=e^{-1/r}$, the omitted sum is
positive and is at most

\[
\frac1r\sum_{k=101}^{\infty}k^2q^k
=\frac{q^{101}}r\left\{
\frac{101^2}{1-q}+\frac{202q}{(1-q)^2}
+\frac{q(1+q)}{(1-q)^3}\right\}.
\tag{4}
\]

After multiplication by $1/\sqrt r$, (4) is less than
$1.11\cdot10^{-18}$ for $r=2$ and
$1.75\cdot10^{-11}$ for $r=3$. The finite sum can be enclosed using
only rational arithmetic: reduce each prime logarithm to
$\log p=m\log2+\log(p/2^m)$, with $1\le p/2^m<2$, and use 24
terms of

\[
\log y=2\sum_{j=0}^{23}\frac{x^{2j+1}}{2j+1}+\epsilon,
\qquad x=\frac{y-1}{y+1},\qquad
0\le\epsilon\le\frac{2x^{49}}{49(1-x^2)}.
\tag{5}
\]

The same formula with $x=1/3$ encloses $\log2$. Bound
$e^{-1/r}$ with the odd and even truncations through degree 60 of
its alternating Taylor series, then raise that interval to the $k$th
power. Direct integer-square comparisons enclose $1/\sqrt r$.
These rational operations give intervals contained in (3). No
assumption that $\Lambda$ vanishes away from primes is made: the
finite sum includes each prime power.

The initial trace also differs from the condition in Eq. (18) of the
Euler-discrepancy audit. The same $k\le100$ calculation in (1) gives
$b(0)\in(-0.561527,-0.561526)$. Using
$0.57721<\gamma<0.57722$ yields

\[
0.22707<h(0+)=b(0)-B<0.22709,
\qquad h'(0+)\in(-0.350147,-0.350145).
\tag{6}
\]

For clarity, set $h_0=h(0+)$, $h_1=h'(0+)$, and interpret every
derivative of $h\mathbf1_{[0,\infty)}$ causally. Then
$Dh=h_0\delta_0+h'_{\rm cl}$ and
$D^2h=h_0\delta_0'+h_1\delta_0+h''_{\rm cl}$. With the linked
decomposition $J=Q+R$, the regular-function part of Eq. (16) in the
Euler-discrepancy audit is exactly

\[
\boxed{
\bigl(\ell Dh+\widetilde J*D^2h\bigr)_{\rm reg}
=\sum_{n\ge1}q_nT_{a_n}h'_{\rm cl}
 +R*h''_{\rm cl}+h_1R+h_0H,
\qquad a_n=\log(n+1).
}
\tag{7}
\]

The apparent $h_0q_n\delta_{a_n}$ atoms from translating $Dh$
cancel the opposite atoms in $h_0DR$; (7) has no interior atom.
Consequently the direct weighted Cauchy-Schwarz estimate for the actual
response adds the trace cost

\[
-|h_0|\left(\int_0^T e^{-2xu}|H(u)|^2\,du\right)^{1/2}
\|h'_{\rm cl}\|_{x,T}
\tag{8}
\]

to the right side of audit Eq. (18). Its other terms and coefficients
remain as written there. The negative-time history correction in audit
Eq. (12) is also required when (7) is inserted into the causal renewal
equation for this actual $h$.

That history has a large, explicit leading term. Put $X=e^v$, and
write $C(t)=P(t)-(1+t^{-1})e^{-t}$ as in the renewal note. For
$m>X$, the shifted argument $v-\log m$ is negative, so the causal
step is absent and $h(v-\log m)=b(v-\log m)$. Consequently

\[
\mathcal H_{\rm hist}(v)
:=\sum_{m>X}m^{-1/2}h(v-\log m)
=X^{-1/2}\sum_{m>X}C(m/X).
\tag{9}
\]

The function $C$ is continuous and exponentially integrable on
$[1,\infty)$. Riemann-sum convergence therefore gives

\[
\mathcal H_{\rm hist}(v)
=I e^{v/2}+o(e^{v/2}),\qquad
I=\int_1^\infty C(t)\,dt
=\sum_{n\ge2}\frac{\Lambda(n)e^{-n}}n
 -e^{-1}-E_1(1),
\tag{10}
\]

where $E_1(1)=\int_1^\infty e^{-t}t^{-1}\,dt$. The coefficient is
strictly negative without numerical evaluation: since
$0\le\Lambda(n)/n\le1$ and $q=e^{-1}<1/2$,

\[
\sum_{n\ge2}\frac{\Lambda(n)e^{-n}}n
\le\sum_{n\ge2}q^n=\frac{q^2}{1-q}<q=e^{-1}.
\tag{11}
\]

Thus the history-corrected causal forcing
$g_{\rm causal}=g-\mathcal H_{\rm hist}$ has positive exponential
growth $(-I)e^{v/2}+o(e^{v/2})$, although the full-history forcing
$g$ is bounded. A finite-horizon estimate on the causal half-line
must retain this term before drawing a bounded-input conclusion.

There is an unconditional way to change the baseline and remove both
the history and the trace costs. Choose a smooth cutoff $\chi$ on
$[0,\infty)$ that equals one near zero and zero for $v\ge2$.
Choose a nonnegative, nonzero $\phi\in C_c^\infty(1,2)$.
Define the all-time function $\beta$ by

\[
\beta(v)=
\begin{cases}
b(v),&v<0,\\
\chi(v)b(v)+\lambda\phi(v),&v\ge0,
\end{cases}
\qquad
\lambda=
\frac{-(1+\gamma)
 -\int_{-\infty}^0e^{-u/2}b(u)\,du
 -\int_0^\infty e^{-u/2}\chi(u)b(u)\,du}
 {\int_0^\infty e^{-u/2}\phi(u)\,du}.
\tag{12}
\]

The denominator is positive. The construction uses the exact heat
response only on the known negative history and a bounded positive
interval. It does not assume RH. The function $\beta$ is smooth,
bounded, equals $b$ for $v<0$, vanishes for $v\ge2$, and has moment

\[
M:=\int_{\mathbb R}e^{-u/2}\beta(u)\,du=-(1+\gamma).
\tag{13}
\]

Now set $h_\beta=b-\beta$. It vanishes on the negative half-line and
near zero, so its causal traces $h_\beta(0+)$ and $h_\beta'(0+)$
are both zero. To estimate its exact forcing, put
$G(t)=t^{-1/2}\beta(-\log t)$. This function is zero near $t=0$,
equals $C(t)$ for $t>1$, and satisfies $G,G'\in L^1(0,\infty)$.
For $X=e^v$,

\[
\mathcal Z\beta(v)
=X^{-1/2}\sum_{m\ge1}G(m/X)
=M X^{1/2}+O\!\left(X^{-1/2}\|G'\|_1\right).
\tag{14}
\]

Indeed, compare $G(m/X)$ with $G(t)$ on each interval
$[(m-1)/X,m/X]$; the sum of all rectangle errors is at most
$\|G'\|_1/X$. The [finite rectangle theorem](BuildingBlocks/ActualHeatRenewalRectangle.lean)
formalizes this estimate on any finite grid for a $C^1$ function.
Passage to the infinite grid and the special heat profile remains written
analysis. By the renewal note's Eq. (17),

\[
\mathcal Z h_\beta=f-\mathcal Z\beta
=O\!\left((1+v)e^{-v/2}\right)\qquad(v\ge0).
\tag{15}
\]

This places the actual response, after the new all-time baseline,
within the zero-trace and bounded-forcing scope of audit Eq. (18).
The original causal step baseline $B\mathbf1_{[0,\infty)}$ does not
have these properties. Since $\beta$ vanishes for $v\ge2$,
$h_\beta(v)=b(v)$ there. The change does not alter any late-time
boundedness or energy-growth target.

More precisely, Eq. (24) of the renewal note gives

\[
\mathrm{RH}\quad\Longleftrightarrow\quad
\sup_{v\ge0}|h_\beta(v)|<\infty
\quad\Longleftrightarrow\quad
\limsup_{T\to\infty}\frac1T
\log\left(1+\int_0^T|h_\beta(v)|^2\,dv\right)=0.
\tag{15a}
\]

The last equivalence also uses the centered-heat Lyapunov criterion
there: changing $b$ on a fixed compact interval does not change its
large-horizon exponent. The equation $\mathcal Zh_\beta=g_\beta$ is
genuinely causal with zero initial traces. Its causal solution is
unique among locally bounded responses. Indeed, the $m=1$ term is
$h_\beta(v)$; on $[0,\log2)$ every other shift is negative, so any
homogeneous causal solution is zero. If it is zero before $k\log2$,
then every shift with $m\ge2$ vanishes on
$[k\log2,(k+1)\log2)$, proving the claim by induction. The
bounded-response implication for this explicit decaying source
remains open; uniqueness alone gives no horizon-uniform bound.

The baseline also leaves every zero resonance intact. Its bilateral
Laplace transform
$\widehat\beta(z)=\int_{\mathbb R}e^{-zv}\beta(v)\,dv$ is entire:
the positive support is compact, while on the negative half-line
$\beta(v)=b(v)=O(e^{-v/2}e^{-e^{-v}})$ as $v\to-\infty$.
For $\Re s>1$, absolute Mellin summation of the original forcing gives

\[
\widehat g_\beta(s-\tfrac12)
=\Gamma(s)\left[-\zeta'(s)-\frac{s\zeta(s)}{s-1}\right]
 -\zeta(s)\widehat\beta(s-\tfrac12).
\tag{16}
\]

Here $g_\beta=f-\mathcal Z\beta=\mathcal Zh_\beta$. It vanishes for
$v<0$ and satisfies (15) for $v\ge0$, so its Laplace integral is
holomorphic for $\Re(s-\tfrac12)>-\tfrac12$; (16) continues to that
domain with the removable singularity at $s=1$ interpreted by
cancellation. If $\rho$ is a nontrivial zeta zero of multiplicity $m$,
the right side of (16) has a zero of order exactly $m-1$ at $\rho$:
the leading term is $-\Gamma(\rho)\zeta'(s)$, while both terms
containing $\zeta(s)$ have order at least $m$. Thus division by
$\zeta(s)$ still produces a simple pole at $\rho$, with residue
$-m\Gamma(\rho)$. The smoother baseline fixes the causal bookkeeping
without removing the RH-level spectral obstruction.

These calculations rule out a monotone-response or simple derivative
alignment proof based only on the positive increments and arches of
$J$. They do not rule out a more involved phase inequality that uses
the full arithmetic source. The new baseline makes the existing
finite-horizon inequality applicable to that source. It does not
strengthen Eq. (18): $A_{0,T}\uparrow\ell$, and the arch term still
costs one derivative.
