# The adjacent Weil cross block has no uniform signed saving

Written research note, 17 September 2026. This tests a scalar scale-doubling argument for the full Weil form. The cross block can attain the negative absolute norm of its complete prime-power part on tests whose two pole moments vanish in each half-window. The archimedean cross tends to zero on those tests. This rules out a uniform signed saving for the cross block; it does not give a negative Weil test or exclude an estimate tied to the *diagonal energy*.

## Exact block formula

Use the Fourier convention $\widehat f(\xi)=\int e^{-i\xi u}f(u)\,du$, and write
$$
 d_n=\log n,\quad w_n=\frac{\Lambda(n)}{\sqrt n},\quad
 M_\pm(f)=\int e^{\pm u/2}f(u)\,du,\quad
 r(y)=\frac{e^{-y/2}}{1-e^{-2y}}\quad(y>0).
$$
The complete form is the one in the [three-window calculation](three-window-global-pole-null-weil-bound.md):
$$
 Q(f)=2\Re\!\left(M_+(f)\overline{M_-(f)}\right)
 +\frac1{2\pi}\int_{\mathbb R}
   \left(\Re\psi(1/4+i\xi/2)-\log\pi\right)|\widehat f(\xi)|^2d\xi
 -2\Re\sum_{n\ge2}w_n\int f(u+d_n)\overline{f(u)}\,du.
 \tag{1}
$$
For compact $f=f_-+f_+$, with $f_-$ supported in $I_-=(-a,0)$ and $f_+$ in $I_+=(0,a)$, put $\Delta_a(f_-,f_+)=Q(f)-Q(f_-)-Q(f_+)$. The off-origin inverse Fourier kernel of the gamma multiplier is $-r(|v-u|)$. Because every $d_n>0$, only the left-to-right prime orientation survives. Thus
$$
\boxed{\begin{aligned}
\Delta_a(f_-,f_+)=2\Re\Bigg[&
 M_+(f_-)\overline{M_-(f_+)}
 +M_+(f_+)\overline{M_-(f_-)}\\
 &-\int_{I_-}\int_{I_+}
       r(v-u)f_+(v)\overline{f_-(u)}\,dv\,du\\
 &-\sum_{\substack{n\ge2\\d_n<2a}}w_n
       \int_{I_-}f_+(u+d_n)\overline{f_-(u)}\,du
 \Bigg].
\end{aligned}}\tag{2}
$$
The sum includes every prime power with a geometric overlap. Formula (2) keeps both poles and the gamma term. Compact support inside the open halves gives a positive gap between the two test supports, so the displayed gamma integral is ordinary and finite.

Define the positive arithmetic operator $A_a:L^2(I_-)\to L^2(I_+)$ by
$$
 (A_ah)(v)=\sum_{\substack{n\ge2\\d_n<2a}}w_n h(v-d_n),
 \qquad \kappa_a=\|A_a\| .
 \tag{3}
$$
Zero extension of $h$ outside $I_-$ is understood. Since every $w_n>0$,
$$
 |\langle A_ah,k\rangle|
 \le\langle A_a|h|,|k|\rangle .
 \tag{4}
$$
Consequently nonnegative smooth interior packets approximate the operator norm $\kappa_a$. This is the optimal absolute-value norm of the arithmetic cross block, rather than a row-sum estimate.

## Pole-null packets attain that norm

Let $\eta_\pm\ge0$ be real, nonzero, smooth, and compactly supported inside $I_\pm$. For $T>0$ set
$$
 f_{\pm,T}(u)=-T^{-2}(\partial_u^2-\tfrac14)
                      \bigl(\eta_\pm(u)e^{iTu}\bigr).
 \tag{5}
$$
Twice integrating by parts proves $M_+(f_{\pm,T})=M_-(f_{\pm,T})=0$ **exactly**. Also
$$
 f_{\pm,T}(u)=e^{iTu}\bigl(\eta_\pm(u)+O_{\eta_\pm}(T^{-1})\bigr)
 \quad\text{in }L^2 .
 \tag{6}
$$
Only finitely many prime bases occur in (2) at fixed $a$. Their logarithms are linearly independent over $\mathbb Q$ by unique factorization. The continuous-time Kronecker argument therefore supplies $T_j\to\infty$ for which $e^{iT_j\log p}\to1$ for every eligible base prime. The phase of every eligible power $p^k$ tends to one as well.

For each fixed $n$ in (2), (6) gives
$$
 \int f_{+,T}(u+d_n)\overline{f_{-,T}(u)}\,du
 =e^{iTd_n}\int\eta_+(u+d_n)\eta_-(u)\,du+O(T^{-1}).
$$
The gamma cross in (2) tends to zero by the Riemann-Lebesgue lemma: its kernel is smooth on the separated test supports, and the leading integrand contains $e^{iT(v-u)}$. Both pole rows are already zero. Hence
$$
\boxed{\lim_{j\to\infty}\Delta_a(f_{-,T_j},f_{+,T_j})
       =-2\langle A_a\eta_-,\eta_+\rangle .}
 \tag{7}
$$
Approximate the nonnegative norm-maximizing pair in (4) by such smooth packets and normalize their $L^2$ norms. Equation (7) proves
$$
 \inf_{\substack{M_\pm(f_-)=M_\pm(f_+)=0\\
                  \|f_-\|_2=\|f_+\|_2=1}}
       \Delta_a(f_-,f_+)\ \le\ -2\kappa_a .
 \tag{8}
$$
In particular, any universal bound
$\Delta_a(f_-,f_+)\ge-2K_a\|f_-\|_2\|f_+\|_2$
on this local-pole-null subspace must have $K_a\ge\kappa_a$.
Local pole constraints, both global poles, and the gamma cross yield **no uniform reduction** of the arithmetic absolute norm.

## Size at the first doubling and at large support

The indicator envelopes of the two halves, approximated from inside by smooth nonnegative packets, have equal squared norm $a$. Their correlation at a shift $y>0$ is
$$
 C_a(y)=
 \begin{cases}
 y,&0<y\le a,\\
 2a-y,&a<y<2a,\\
 0,&y\ge2a.
 \end{cases}
$$
Thus
$$
 \kappa_a\ge\frac{S(a)}a,\qquad
 S(a)=\sum_{\substack{n\ge2\\\log n<2a}}
             \frac{\Lambda(n)}{\sqrt n}C_a(\log n).
 \tag{9}
$$
For this indicator calculation, first fix the smooth interior
approximation and take the high-frequency limit in (7). Then let its
boundary collars shrink. No singular gamma cross is inserted for
touching indicators.
[Zhu's certified theorem](https://arxiv.org/abs/2608.24827) gives
$Q(f)\ge8.9\cdot10^{-18}\|f\|_2^2$ on support
$[-0.8,0.8]$. Doubling that width would combine two translated
windows of length $a=1.6$. The complete list in (9) is
$$
 n=2,3,4,5,7,8,9,11,13,16,17,19,23.
$$
It includes the powers $4,8,9,16$. Direct evaluation gives
$$
 S(1.6)=5.7986307667\ldots,\qquad
 \kappa_{1.6}\ge S(1.6)/1.6
                 =3.6241442292\ldots .
 \tag{10}
$$
Zhu's certified scalar margin $8.9\cdot10^{-18}$ cannot pay even
this lower bound for the cross norm in a two-by-two scalar block test.
The later [Liu manuscript](https://github.com/luciferyu666/certified-weil-positivity/blob/b6cd2183c1e79c6c27a34267812a7b2d73ed1b59/frozen-source/publication/manuscript.tex)
claims $Q(f)\ge2^{-49162}\|f\|_2^2$ at half-width $17/16$.
Its [release notes](https://github.com/luciferyu666/certified-weil-positivity/releases/tag/v1.0-mcom-submission)
say external reproduction is incomplete. This note does not audit
that certificate. Doubling its claimed window would set $a=17/8$
in (9), where the complete arithmetic calculation gives
$S(17/8)/(17/8)=6.6232055002\ldots$, again far above the
reported scalar margin.
For the unnormalized indicator envelopes, the cross term in (7) tends to $-2S(1.6)=-11.597261532\ldots$. The actual smooth, exact-pole-null tests can approach that value and their two squared norms tend to $1.6$ each. This is a negative *cross* value, not a negative value of $Q(f_-+f_+)$. Their diagonal gamma energies grow like $\log T_j$.
Indeed the digamma multiplier in (1) is
$\log(|\xi|/(2\pi))+O(|\xi|^{-1})$ at large frequency, while the
diagonal prime sums have only finitely many shifts at fixed $a$.
Consequently $Q(f_{\pm,T})=\log T\,\|\eta_\pm\|_2^2+O_{\eta_\pm,a}(1)$.

The complete PNT gives the growth of the same obstruction. Replacing $d\psi(x)$ by $dx$ in (9) yields exactly
$$
 \int_1^{e^{2a}}x^{-1/2}C_a(\log x)\,dx
 =4(e^{a/2}-1)^2 .
$$
The classical stretched-exponential error for $\psi(x)-x$, integrated by parts and split at $e^a$, is $o(e^a)$. Therefore
$$
 S(a)=(4+o(1))e^a,\qquad
 \boxed{\kappa_a\ge(4+o(1))e^a/a.}
 \tag{11}
$$

Let $m(a)$ be the best lower Rayleigh bound for $Q$ on locally
pole-null tests in an interval of length $a$. Choose a nonzero
smooth $\eta$ supported in $(0,1)$ and put
$h_0=(\partial^2-\tfrac14)\eta$. This fixed packet is pole-null.
It can be translated into every interval of length $a>1$.
Translation preserves its gamma and prime form, while its pole form
stays zero. Therefore
$m(a)\le C_0:=Q(h_0)/\|h_0\|_2^2<\infty$.

A block estimate using only
$Q(f_\pm)\ge m(a)\|f_\pm\|_2^2$ and a uniform cross constant must use
$K_a\ge\kappa_a$. Applying $2xy\le x^2+y^2$ then gives only the
floor $m(a)-K_a$ for the doubled window. It becomes negative
by (11). This cross-only scalar estimate gains **nothing** over
the optimal arithmetic absolute norm and produces no larger
certified support.

An estimate that charges a large negative cross to the *actual diagonal energies* could still work. The packets proving (8) have diagonal energy of order $\log T_j$, which the scalar floor forgets. This note rules out the proposed scalar-floor and cross-constant induction, not a global Weil inequality.
