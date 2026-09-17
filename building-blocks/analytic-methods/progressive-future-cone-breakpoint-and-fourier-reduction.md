# Ordered-breakpoint and Fourier reductions for progressive admission

This note concerns only the fixed-set Green profiles arising in the complete
tail variance.  It gives two exact descriptions of the special
inclusion--exclusion increment.  Neither description proves that every
sequential prime admission lowers the energy.  Together they show precisely
what such a proof must control, and why neither intervalwise signs nor a
frequencywise contraction can supply it.

For a finite prime set \(S\), write \(P=\prod_{r\in S}r\),
\(D(P)=\{d:d\mid P\}\), and

\[
 G_d(y)=\frac1{2d}\begin{cases}
 e^{y-2d},&0<y\le d,\\
 e^{-y},&y\ge d,
 \end{cases}
 \qquad
 F_S=\sum_{d\mid P}\mu(d)G_d,
 \qquad
 U_{p,S}=\sum_{d\mid P}\mu(d)G_{pd}.
 \tag{1}
\]

Here \(p\notin S\).  The admission increment is

\[
 \Delta_{p,S}=2\int_0^\infty(U_{p,S}^2-2F_SU_{p,S})\,dy.
 \tag{2}
\]

## 1. Exact ordered-breakpoint sum

Let

\[
 0=b_0<b_1<\cdots <b_M
\tag{3}
\]

be the increasing enumeration of
\(\{0\}\cup D(P)\cup pD(P)\), and put \(b_{M+1}=\infty\).
On \(I_r=(b_r,b_{r+1})\), define the four constants

\[
\begin{aligned}
 A_r&=\sum_{\substack{d\mid P\\d<b_{r+1}}}\frac{\mu(d)}d,
 &B_r&=\sum_{\substack{d\mid P\\d>b_r}}\frac{\mu(d)e^{-2d}}d,\\
 C_r&=\sum_{\substack{d\mid P\\pd<b_{r+1}}}\frac{\mu(d)}d,
 &D_r&=\sum_{\substack{d\mid P\\pd>b_r}}\frac{\mu(d)e^{-2pd}}d.
\end{aligned}
\tag{4}
\]

Equivalently, the inequalities in each column can be evaluated at any
interior point of \(I_r\).  Then, exactly on that interval,

\[
 F_S(y)=\frac12(A_re^{-y}+B_re^y),\qquad
 U_{p,S}(y)=\frac1{2p}(C_re^{-y}+D_re^y).
\tag{5}
\]

Put

\[
\begin{aligned}
 \alpha_r&=\frac{C_r^2}{4p^2}-\frac{A_rC_r}{2p},\\
 \beta_r&=\frac{C_rD_r}{2p^2}
       -\frac{A_rD_r+B_rC_r}{2p},\\
 \gamma_r&=\frac{D_r^2}{4p^2}-\frac{B_rD_r}{2p}.
\end{aligned}
\tag{6}
\]

With

\[
 E_-(a,b)=\frac{e^{-2a}-e^{-2b}}2,\qquad
 E_+(a,b)=\frac{e^{2b}-e^{2a}}2,
\tag{7}
\]

the complete interval contribution is

\[
 \Phi_r=\alpha_rE_-(b_r,b_{r+1})
       +\beta_r(b_{r+1}-b_r)
       +\gamma_rE_+(b_r,b_{r+1}).
\tag{8}
\]

For the last interval, \(B_M=D_M=0\), and (8) means
\(\Phi_M=\alpha_Me^{-2b_M}/2\).  Therefore

\[
 \boxed{\quad \frac12\Delta_{p,S}=\sum_{r=0}^M\Phi_r.\quad}
\tag{9}
\]

No endpoint is lost.  Formula (9) is a finite expression in rational
numbers and the exponentials of integer breakpoints.

The state update at a breakpoint \(b\) is also exact:

\[
\begin{aligned}
 A^+-A^-&={\bf1}_{b\mid P}\frac{\mu(b)}b,&
 B^+-B^-&=-{\bf1}_{b\mid P}\frac{\mu(b)e^{-2b}}b,\\
 C^+-C^-&={\bf1}_{b=pd,\ d\mid P}\frac{\mu(d)}d,&
 D^+-D^-&=-{\bf1}_{b=pd,\ d\mid P}
                    \frac{\mu(d)e^{-2pd}}d.
\end{aligned}
\tag{10}
\]

Thus a proposed induction can be stated without a hidden limiting step.  If
\(J_r=-\sum_{k<r}\Phi_k\) is the negative mass available before \(I_r\),
then the stronger prefix-decrement induction is exactly

\[
 J_r\ge0,\qquad \Phi_r\le J_r,
 \qquad J_{r+1}=J_r-\Phi_r.
\tag{11}
\]

The earlier empty-face decomposition
\(\Delta_{p,S}/2=-m_p+R_{p,S}\) consequently becomes

\[
 \boxed{\quad R_{p,S}=m_p+\sum_{r=0}^M\Phi_r,\qquad
 m_p=\frac{e^{-2p}}{8p^2}
 [2p(2p-e^{-2})-2+e^{-2p}].\quad}
\tag{12}
\]

Equations (9)--(12) are the requested exact ordered-divisor version of both
\(\Delta\) and the delayed-composite repair \(R\).

## 2. Intervalwise negativity is false

The recurrence cannot be closed by proving \(\Phi_r\le0\) one interval at a
time.  For the already relevant set \(S=\{2,3,5\}\), with \(p=7\), consider
the whole interval \((35,42)\).  There

\[
 A=\frac4{15},\qquad B=0,qquad C=-\frac1{30},
\tag{13}
\]

and

\[
 D=\frac{e^{-84}}6+\frac{e^{-140}}{10}
   +\frac{e^{-210}}{15}-\frac{e^{-420}}{30}>0.
\tag{14}
\]

In particular \(\alpha=113/176400>0\), while

\[
 |\beta|=\frac{19}{980}D,qquad \gamma=\frac{D^2}{196}.
\tag{15}
\]

Since \(D<(11/30)e^{-84}\), (8) gives

\[
 \Phi_{(35,42)}
 \ge \frac{113}{352800}(e^{-70}-e^{-84})
      -\frac{133}{980}\frac{11}{30}e^{-84}>0.
\tag{16}
\]

The last inequality follows already from \(e^{14}>157\).  This is an exact
integrated positive interval, not merely a pointwise failure.  Any proof of
the final sign must transport reserve from earlier breakpoints across this
interval.  The Boolean boundary alone does not specify such a pairing.

## 3. Green convolution and the exact cross-scale amplitude

There is a useful global form of the same calculation.  On the real line,

\[
 G_d(y)=\frac{e^{-d}}d\,\frac{e^{-|y-d|}}2
 \qquad(y>0).
\tag{17}
\]

Define

\[
 A_S(z)=\sum_{d\mid P}\frac{\mu(d)}d e^{-zd}.
\tag{18}
\]

The Fourier transform of the full-line Green convolution is
\(A_S(1+i\xi)/(1+\xi^2)\).  Its restriction to the negative half-line is
exactly \(\frac12e^yA_S(2)\).  Parseval therefore gives

\[
 \|F_S\|_{L^2(0,\infty)}^2
 =\frac1{2\pi}\int_{\mathbb R}
   \frac{|A_S(1+i\xi)|^2}{(1+\xi^2)^2}\,d\xi
   -\frac18A_S(2)^2.
\tag{19}
\]

Admission sends the amplitude by the exact cross-scale rule

\[
 A_S(z)\longmapsto A_S(z)-\frac1pA_S(pz).
\tag{20}
\]

Consequently (2) is identically

\[
\begin{split}
 \frac12\Delta_{p,S}
={}&\frac1{2\pi}\int_{\mathbb R}
 \frac{|A_S(1+i\xi)-p^{-1}A_S(p+ip\xi)|^2
       -|A_S(1+i\xi)|^2}{(1+\xi^2)^2}\,d\xi\\
 &-\frac18\left(
 [A_S(2)-p^{-1}A_S(2p)]^2-A_S(2)^2\right).
\end{split}
\tag{21}
\]

This keeps the negative-half-line reservoir which would be lost by using the
full-line Fourier norm alone.

The strongest possible pointwise cross-scale contraction is already false
for \(S=\varnothing\).  In that case the numerator change before applying
the positive Fourier weight is

\[
 \frac{e^{-2p}}{p^2}
 -\frac{2e^{-(p+1)}}p\cos((p-1)\xi),
\tag{22}
\]

which is positive at \(\xi=\pi/(p-1)\).  Thus the known negative one-prime
increment comes from the integrated Fourier weight together with the
boundary correction in (21), rather than a pointwise contraction.
Moreover, \(A_S\) is not an Euler product: the factor \(e^{-zd}\) depends
additively on the squarefree divisor \(d\), while adjoining primes multiplies
\(d\).  Hence (20) is a genuine cross-scale relation but does not factor the
special vector into local prime contractions.

Equations (9) and (21) leave the same precise theorem:

\[
 \sum_r\Phi_r\le0,
\tag{23}
\]

or equivalently the right side of (21) is nonpositive, for every finite
prime set \(S\) and new prime \(p\).  This theorem is stronger than the
known one-prime calculation and is not proved here.  General operator
contraction is irrelevant to (23), but the special inclusion--exclusion
structure alone has not yet supplied the cross-breakpoint reserve required
by (11).

## 4. Restriction to the enlarged paid-region complement

No estimate in this note is assigned to the enlarged paid region.  On a
central angular shell put

\[
 a=\max(|\theta|,X^{-1}),\qquad H\asymp a^{-1}.
\tag{24}
\]

The remaining work is restricted to

\[
 t>a^{1/2-\eta_\varepsilon}.
\tag{25}
\]

The short-ray parameters there are

\[
 Y\asymp Xt,qquad L\asymp Ht,qquad \frac LY\asymp\frac1{aX},
\tag{26}
\]

so (25) gives

\[
 Y\gg X a^{1/2-\eta_\varepsilon},
 \qquad L\gg a^{-1/2-\eta_\varepsilon}.
\tag{27}
\]

For \(X^{-1}\le a\le X^{-1/2}\), the outer endpoint has
\(Y\gg X^{3/4+\eta_\varepsilon/2}\) and
\(L\gg X^{1/4+\eta_\varepsilon/2}\); at the innermost endpoint both are at
least \(X^{1/2+\eta_\varepsilon}\).  These lower bounds improve the ray
lengths, but they do not make the fixed-divisor Green limit uniform.

Indeed the geometric quotient range still reaches

\[
 v\lesssim t^{-1}\lesssim a^{-1/2+\eta_\varepsilon}.
\tag{28}
\]

Even a single dilation index can therefore grow with \(X\), and products of
admitted indices grow farther.  To use (9) or (21) on every remaining shell
one needs the finite-horizon tail/profile approximation uniformly for all
such \(d,pd\), with the moving ceilings retained.  A perturbative sign proof
would in addition need error smaller than the relevant margins
\(e^{-2p}\), and for delayed faces often \(e^{-2pd}\).  At the upper range in
(28) these are exponentially smaller than the polynomial improvement in
the ray length (27).  The existing fixed-\(d\) convergence supplies no such
uniform estimate.

Thus the enlarged paid region changes the admissible ray scales exactly by
(27)--(28), but it does not justify interchanging the fixed-set Green limit
with the growing divisor complex.  The remaining unconditional objects are
the finite ordered sum (9) and its form-equivalent representation (21).
They retain every divisor, cross-face term, moving endpoint, and the
half-line reservoir.  No RH premise or conclusion is used.
