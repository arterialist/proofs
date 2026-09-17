# An odd weak ground row with complete cross arrivals and pole balance

The even physical killed ground has zero mixed Weil pairing with every
odd test. This note supplies its sign-weighted odd companion on the
same exponential weak domain. The identity keeps both cross-half
arrivals, the signed core arrival and the two pole products. Its far
tail has an exact leading cancellation, but it does not estimate the
remaining affine covariance residual.

Fix the actual symmetric core $C=[-R,R]$ and exterior $O$, and use
the positive even normalized killed ground $\psi_R$ with
$\delta_R=1/2-\alpha_R>0$. Write
\[
G(v)=\Phi(v)\psi_R(v)1_O(v),\quad
g(v)=G(v)1_{v>R},\quad
\varepsilon(v)=\operatorname{sgn}(v)1_O(v),\quad
F(v)=\varepsilon(v)G(v),\quad b(v)=2\cosh(v/2).
\tag{1}
\]
The [actual sign-energy theorem](theta-ground-sign-prime-convolution.md)
puts $F$ in the physical logarithmic form domain. Its positive-half
moments are
\[
G_-:=\int_R^\infty e^{v/2}g(v)dv,\qquad
G_+:=\int_R^\infty e^{-v/2}g(v)dv,
\qquad \mu_R=2(G_-+G_+),\qquad \Delta_G:=G_--G_+>0.
\tag{2}
\]
The theta envelope makes all these integrals finite.

Let $\mathscr K=A-S$ be the complete physical non-pole form. On the
positive exterior define the physical arrival from the **opposite**
exterior half by
\[
\begin{split}
\mathcal B_\times(v)={}&
\int_R^\infty r(v+w)g(w)dw\\
&+\sum_{\log n>v+R}\frac{\Lambda(n)}{\sqrt n}
       g(\log n-v),\qquad v>R,
\end{split}
\quad r(s)=\frac{e^{-s/2}}{1-e^{-2s}},
\tag{3}
\]
and extend it evenly to $O_-$. Every prime power remains in the sum.
On the core define the **signed** arrival
\[
\begin{split}
\mathcal B_\varepsilon(v)={}&
\int_O r(|v-w|)F(w)dw\\
&+\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [F(v+\log n)+F(v-\log n)],\qquad v\in C.
\end{split}
\tag{4}
\]
This core function is odd and belongs to $L^2(C)$: it is the actual
bounded crossing operator applied to $\varepsilon\psi_R$, followed
by equivalence of the smooth positive core weights. The continuous
integral in (4) has the same boundary interpretation as in the
[even weak row](theta-ground-exponential-weak-cross-row.md); no
uniform pointwise boundary rate is asserted.

**Odd weak-row identity.** Let $z$ be a real locally bounded member
of the physical logarithmic form space and suppose
$|z(v)|\le C_z e^{-\beta|v|}$ for some $\beta>1/2$ outside a compact
set. Then the full prime pairing with $F$ is absolutely convergent,
and
\[
\boxed{\quad
\mathscr K(F,z)
=\int_O\varepsilon(v)
 [-\delta_R b(v)\psi_R(v)+2\mathcal B_\times(v)]z(v)dv
 -\int_C\mathcal B_\varepsilon(v)z(v)dv.
\quad}
\tag{5}
\]
Indeed $|F|=G$ permits the same complete prime-tail majorant as the
even weak-row theorem. Multiplication by $\varepsilon$ on $O$ is the
difference of its two bounded hard projections, so $\varepsilon z$
is an admissible weak test. The even ground equation gives
$\mathscr K(G,\varepsilon z)
=-\delta_R\int_O\varepsilon b\psi_Rz$.
Subtract the two physical forms. The multiplier and all same-half
edges commute with $\varepsilon$. Each cross-half edge changes its
endpoint sign by two, yielding $2\varepsilon\mathcal B_\times$.
On $C$, $\varepsilon z=0$ but $F$ has the signed arrival (4), giving
its negative term. Compact hard tests justify this subtraction first;
the exponential prime majorant, logarithmic form convergence and core
$L^2$ bound pass to the stated weak test. No pointwise derivative of
$\psi_R$ is used.

For the full physical Weil form $Q_W$, the two pole moments of $F$
are $M_{1/2}(F)=\Delta_G$ and $M_{-1/2}(F)=-\Delta_G$. Thus (5) becomes the
single signed-density row
\[
\boxed{\quad
Q_W(F,z)=\int_{\mathbb R}q_R^{\rm odd}(v)z(v)dv,
\quad
q_R^{\rm odd}(v)=
1_O\varepsilon[-\delta_Rb\psi_R+2\mathcal B_\times]
-1_C\mathcal B_\varepsilon-2\Delta_G\sinh(v/2).
\quad}
\tag{6}
\]
The three displayed pieces are odd. In particular, parity does not
force (6) to vanish on odd exponential tests, whereas the even ground
row vanishes on every such test. All three pieces must remain in an
estimate of this row.

There is an exact leading far-tail cancellation. The
[fixed-core ground flat-tail theorem](theta-killed-ground-flat-tail-and-pole-balance.md)
gives $\psi_R(v)\to c_R=\mu_R/(2\delta_R)$.
The [complete normalized cross-arrival limit](theta-ground-normalized-cross-arrival.md)
gives $\mathcal B_\times(v)/b(v)\to G_-$ as $v\to+\infty$.
Since $2\sinh(v/2)/b(v)\to1$, equations (2) and (6) yield
\[
\boxed{\quad
\lim_{v\to+\infty}\frac{q_R^{\rm odd}(v)}{b(v)}
=-(G_-+G_+)+2G_--(G_--G_+)=0.
\quad}
\tag{7}
\]
Odd reflection gives the corresponding limit at $-\infty$.
This cancellation uses the **complete** prime-density arrival inside
$\mathcal B_\times$ and the odd pole difference $\Delta_G$; neither can
be replaced by the even ground's pole mass $\mu_R/2$.

The actual coherent scaling kernel supplies a concrete odd weak test.
Let $f(x)=-\sqrt xK_{\rm sc}(x)$ as in the
[coherent-kernel source](theta-coherent-kernel-ground-pole-detection.md),
and for $t>0$ put
\[
z_t^{\rm odd}(v)=\operatorname{sgn}(v)f(te^{|v|}).
\tag{8}
\]
This has a single finite jump at zero and finite total variation:
the published bounds $|f(x)|+|xf'(x)|\le C\min(1,x^{-1})$ control
its derivative away from zero and its tails. This test is also in
$L^1\cap L^2$; integration by parts for its BV derivative gives
Fourier decay $O_t(|\xi|^{-1})$, whose square is integrable against the
physical logarithmic multiplier. Thus $z_t^{\rm odd}\in\mathcal H$;
for each fixed $t$ it also satisfies the exponential condition with
any $1/2<\beta<1$. Equation (6) therefore gives a literal odd
coherent-kernel row, including its contact jump through the form
domain rather than deleting it.

The leading cancellation (7) has the qualitative consequence
\[
\boxed{\quad
\sqrt t\,Q_W(F,z_t^{\rm odd})\longrightarrow0
\qquad(t\downarrow0).
\quad}
\tag{9}
\]
To see this, the pairing on each fixed compact set is $O_R(\sqrt t)$.
Given $\epsilon>0$, choose $A$ so that $|q_R^{\rm odd}(v)|\le
\epsilon b(v)$ for $|v|\ge A$. On the positive tail put $x=te^v$;
then $\sqrt t\,b(v)=\sqrt x+t/\sqrt x$ and
\[
\sqrt t\int_A^\infty b(v)|f(te^v)|dv
\le\int_{te^A}^\infty
 \bigl(x^{-1/2}+t x^{-3/2}\bigr)|f(x)|dx
\le C+o_A(1).
\]
The first integral is finite by the small- and large-$x$ bounds on
$f$; the second is $O(\sqrt t e^{-A/2})+O(t)$.
The negative tail is identical by parity. Let $t\downarrow0$ and
then $\epsilon\downarrow0$ to obtain (9). The factor $\sqrt t$
still permits the growth of an off-critical zero with real part below
one; (9) is not an RH-scale estimate.

This row repairs the parity blindness of the even weak test, but $F$
is precisely the physical sign mode whose action is already matched
by the positive comparison operator. Thus (6)--(7) supply no new
upper bound on the common-score conditional energy
$n[v_U]=R_c[Pv_U]+R_p[Pv_U]$. A source-specific signed estimate for
that full residual, with same-half increments and separate cross
variances, is still required. The weak-domain and far-tail identities
are written analysis; they are not Lean formalizations of the actual
killed ground or the theta affine bound.

## A quantitative actual-prime bound for the odd row

The qualitative limit (9) admits the same unconditional PNT-scale
improvement as the [even weak row](theta-weak-ground-pnt-density-cancellation.md),
despite the jump of $z_t^{\rm odd}$ at zero.

**Theorem.** For every fixed core $R>0$ there are an absolute $c>0$
and a finite $C_{R,\psi}$ such that, for all sufficiently small $t>0$,
\[
 \boxed{\quad
 \sqrt t\,|Q_W(F,z_t^{\rm odd})|
 \le C_{R,\psi}\exp[-c\sqrt{\log(1/t)}].
 \quad} \tag{10}
\]
The estimate retains the complete Mangoldt source, the continuous
density subtraction from $x=1$, the gamma multiplier, and both pole
moments. It gives no sign or RH-scale bound.

Here is a proof that keeps the jump rather than differentiating through
it. The theta envelope gives $F\in L^1(e^{|u|/2}du)$, and for each
fixed $t$ the scaling tail gives
$z_t^{\rm odd}\in L^1(e^{|v|/2}dv)$; the complete prime pairing is
absolutely convergent by the weak-row domain theorem above. Thus the
following density and pole manipulations are legitimate. For any pair
with this absolute convergence, the density
translation and the two pole products satisfy the exact identity
\[
 P_{\rm pole}(F,z)-S_{\rm den}(F,z)
 =\iint F(u)z(v)e^{-|u-v|/2}\,du\,dv.
 \tag{11}
\]
Put $E(x)=\psi(x)-x$ for $x\ge1$, with $\psi$ the complete
Chebyshev function, and let $\mathcal D(F,z)$ be the signed Stieltjes
remainder defined in the linked even-row theorem. Thus
\[
 Q_W(F,z)=A(F,z)+
 \iint F(u)z(v)e^{-|u-v|/2}\,du\,dv-\mathcal D(F,z).
 \tag{12}
\]
The difference measure $dE=d\psi-dx$ includes the density interval
$(1,2)$ and every prime power. Its convention $E(1)=-1$ retains the
lower endpoint in integration by parts.

Write $V=\log(1/t)$ and $X=e^{V/2}$. The scaling bounds
$|f(x)|+|xf'(x)|\le C\min(1,x^{-1})$ give
$\|h_t\|_{H^1}^2\le C(1+V)$ for
$h_t(v)=f(te^{|v|})$. Multiplication by $\operatorname{sgn}$ is the
difference of two bounded hard half-line projections on the physical
logarithmic form space. Therefore
$\|z_t^{\rm odd}\|_{\mathcal H}\le C\sqrt{1+V}$, with its contact
jump included, and $|A(F,z_t^{\rm odd})|\le C_{R,\psi}\sqrt{1+V}$.
The second term in (12) is $O_{R,\psi}(1)$ because
$\|z_t^{\rm odd}\|_\infty$ is uniformly bounded and $F\in L^1$.

For $|u|\le V/4$, the entire range $1<x\le X$ of the Stieltjes
integral is bounded without integration by parts. Positivity of
$d\psi$, the density $dx$, and the complete Chebyshev estimate give
\[
 \left|\int_{(1,X]}x^{-1/2}
 [z_t^{\rm odd}(u+\log x)+z_t^{\rm odd}(u-\log x)]\,dE(x)\right|
 \le C\sqrt X=C e^{V/4}.                         \tag{13}
\]
This range includes every sign crossing $x=e^{|u|}$ and its jump,
because $e^{|u|}<X$. It also includes the atom at $X$ when $X$ is
an integer prime power.

For $x>X$ and $|u|\le V/4$, the two shifted arguments have fixed
signs. With $\tau_+=te^u$, $\tau_-=te^{-u}$,
\[
z_t^{\rm odd}(u+\log x)=f(\tau_+x),\qquad
z_t^{\rm odd}(u-\log x)=-f(\tau_-x).
 \tag{14}
\]
Their transition points $Y_\pm=\tau_\pm^{-1}$ exceed
$e^{3V/4}>X$. The derivative bound
\[
 \left|\frac d{dx}\{x^{-1/2}f(\tau_\pm x)\}\right|
 \le Cx^{-3/2}\min(1,Y_\pm/x)
 \tag{15}
\]
now applies with no jump. The unconditional full-prime estimate
$|E(x)|\le Cx\exp[-a\sqrt{\log x}]$, available for example from
[Fiori--Kadiri--Swidinsky](https://arxiv.org/abs/2204.02588),
follows after absorbing its logarithmic prefactor into a smaller
$a>0$. Stieltjes integration by parts on $(X,\infty)$ retains
$-E(X)X^{-1/2}f(\tau_\pm X)$ and gives
\[
 \left|\int_{(X,\infty)}x^{-1/2}f(\tau_\pm x)\,dE(x)\right|
 \le C\sqrt{Y_\pm}\,e^{-a\sqrt{V/2}}
 \le Ct^{-1/2}e^{|u|/2}e^{-a\sqrt{V/2}}.
 \tag{16}
\]

On $|u|>V/4$, use $|z_t^{\rm odd}|=|h_t|$ and the elementary
Chebyshev bound directly, exactly as in the even-row proof. It yields
$Ct^{-1/2}e^{|u|/2}$ for the inner prime-and-density variation.
Since $|F|\le P_\infty\Phi$, its integral over this $u$-tail is
$O_{R,\psi}(t^{-1/2}e^{-c_0e^{V/2}})$. Integrating (13) and (16)
against $|F(u)|$ therefore gives
\[
 |\mathcal D(F,z_t^{\rm odd})|
 \le C_{R,\psi}t^{-1/2}e^{-c_1\sqrt V}.
 \tag{17}
\]
The low-range term $e^{V/4}$ and the gamma and kernel terms
$O_{R,\psi}(\sqrt{1+V})$ are absorbed after multiplication by
$\sqrt t=e^{-V/2}$. Equations (12) and (17) prove (10).

The sign-weighted ground $F$ is an odd physical mode; no
multiplicative prime phase or successor-cell conjugation is used, so
the [nondivisor carry defect](../successor-and-division/successor-cell-finite-euler-transfer.md)
does not enter this estimate. The bound improves the particular odd
weak row, while the common-score residual still requires its own
same-half and cross-variance estimate.
