# A continuum counterphase for the actual signed cocycle

Use the Hardy projection and trace convention of [semilocal weighted scattering](semilocal-weighted-scattering.md). Write $U_X=M_{u_X}$ for the actual archimedean factor times all local factors at primes $p\le X$, including every power in their logarithmic derivatives. Set $\Delta(U)=P-U^*PU$. The physical test stays fixed throughout this construction. This is a written proof. The theta kernel $\Phi$ has the normalization in the [derivative-kernel note](theta-derivative-kernel-logconcavity.md); the theta image used below has norm $\|h\|_H^2=\int 2\cosh(u/2)\Phi(u)|h(u)|^2du$.

## 1. An exact unitary counterfactor

For $A>0$, put
$$
\kappa(a)=2\cosh(a/2),\qquad
\Theta_A(t)=2\int_0^A\kappa(a)\frac{\sin(at)}a\,da,
\qquad v_A(t)=e^{i\Theta_A(t)},\quad V_A=M_{v_A}.
\tag{1}
$$
The apparent singularity at $a=0$ is removable. The function $\Theta_A$ is entire and odd, and is real on the real line. Thus $V_A$ is unitary on the semilocal Mellin space. Define
$$
\widetilde U_{X,A}=U_XV_A.
$$
The cocycle identities, with both valid orderings retained, are
$$
\begin{aligned}
\Delta(\widetilde U_{X,A})
 &=\Delta(V_A)+V_A^*\Delta(U_X)V_A\\
 &=\Delta(U_X)+U_X^*\Delta(V_A)U_X.
\end{aligned}
\tag{2}
$$
The second equality uses commutativity of scalar multipliers. It does not remove a conjugation.

For $Y>X$ and $B>A$, define the actual relative multiplier
$$
R_{YX,BA}=(U_X^*U_Y)(V_A^*V_B).
$$
Then
$$
\Delta(\widetilde U_{Y,B})
 =\Delta(R_{YX,BA})+
 R_{YX,BA}^*\Delta(\widetilde U_{X,A})R_{YX,BA}.
\tag{3}
$$
Its continuum phase is the integral in (1) restricted to $[A,B]$. Its prime factor contains precisely the new primes and their full local factors.

Writing the blocks of $U_X$ and $V_A$ relative to $(1-P)\mathcal K\oplus P\mathcal K$ as $A_X,B_X,C_X,D_X$ and $A_V,B_V,C_V,D_V$, the actual lower corner is
$$
C_{X,A}=C_XA_V+D_XC_V.
\tag{4}
$$
In particular its square contains the conjugated cross term
$$
\begin{aligned}
C_{X,A}^*C_{X,A}
={}&A_V^*C_X^*C_XA_V+C_V^*D_X^*D_XC_V\\
&+A_V^*C_X^*D_XC_V+C_V^*D_X^*C_XA_V.
\end{aligned}
\tag{5}
$$
No comparison below replaces this expression by the sum of its first two terms.

## 2. Compactness, winding and a quantitative relative bound

The sine-integral limit and integration by parts give
$$
\Theta_A(t)\longrightarrow 2\pi\operatorname{sgn}(t),
\qquad
\left|\Theta_A(t)-2\pi\operatorname{sgn}(t)\right|
\le\frac{4\kappa(A)}{A|t|}.
\tag{6}
$$
For the bound, write $\Theta_A=4\operatorname{Si}(At)+2\int_0^A q(a)\sin(at)da$, where $q(a)=(\kappa(a)-2)/a$. Here $q(0)=0$ and $q'\ge0$. The standard integration-by-parts estimate for the sine-integral tail is $2/(A|t|)$, and the second integral is bounded by $4q(A)/|t|$. Their sum is (6).

Consequently $v_A-1\in C_0(\mathbb R)$. The symbol extends continuously to the one-point compactification of $\mathbb R$, and has winding number $2$, since its lifted argument changes by $4\pi$.

Here is a direct compactness argument. Put $r(t)=(t-i)/(t+i)$. Laurent polynomials in $r$ approximate every continuous symbol on the compactified line uniformly. The Hardy commutators of these Laurent polynomials have finite rank. Since
$$
\|[P,M_b]-[P,M_c]\|\le2\|b-c\|_\infty,
$$
$[P,V_A]$ is compact. In particular $C_V$ is compact. Equation (4) proves that $\widetilde U_{X,A}$ remains quasi-inner whenever the actual $U_X$ is quasi-inner.

The index sign can be checked without choosing a different Hardy convention. The kernel in the source note gives
$$
\Delta(M_r)(t,s)=\frac1{\pi(t-i)(s+i)},
$$
a positive rank-one projection. Thus the compression $PM_rP$ has index $+1$ in this convention. Homotopy of the nonvanishing symbol $v_A$ to $r^2$ gives
$$
\operatorname{ind}(PV_AP|_{P\mathcal K})=2.
\tag{7}
$$
This is a Fredholm index, not an assertion that the unweighted operator $\Delta(V_A)$ is trace class or positive.

There is also a quantitative Schatten estimate. Let $g_A=v_A-1$. Equation (6) and $|v_A|=1$ imply
$$
\|g_A\|_2^2\le\frac{32\kappa(A)}A.
$$
Plancherel applied to $\Theta_A'=2\int_0^A\kappa(a)\cos(at)da$ gives
$$
\|v_A'\|_2^2=4\pi\int_0^A\kappa(a)^2da
 =8\pi(A+\sinh A).
$$
The divided-difference kernel therefore yields
$$
\begin{aligned}
\|\Delta(V_A)\|_{\mathcal S_2}^2
 &=\frac1{4\pi^2}\iint
   \frac{|v_A(t)-v_A(s)|^2}{(t-s)^2}\,dt\,ds\\
 &\le\frac1{2\pi}\|g_A\|_2\|g_A'\|_2\\
 &\le\frac8{\sqrt\pi}
 \sqrt{\frac{\kappa(A)(A+\sinh A)}A}.
\end{aligned}
\tag{8}
$$
The middle inequality is the Fourier identity for the homogeneous $H^{1/2}$ seminorm followed by Cauchy-Schwarz. In particular, (2) proves the exact, cutoff-independent identity
$$
\|\Delta(\widetilde U_{X,A})-\Delta(U_X)\|_{\mathcal S_2}
 =\|\Delta(V_A)\|_{\mathcal S_2}.
\tag{9}
$$
For every fixed Schwartz multiplier $\chi$, the trace-class proof in section 3 of [the semilocal note](semilocal-weighted-scattering.md) applies to $V_A$ and to $U_XV_A$: all fixed derivatives of their symbols have polynomial growth on the real axis. Commuting $M_\chi$ through $U_X$ in (2) gives the stronger weighted identity
$$
\boxed{
\|M_\chi[\Delta(\widetilde U_{X,A})-\Delta(U_X)]\|_{\mathcal S_1}
 =\|M_\chi\Delta(V_A)\|_{\mathcal S_1}.}
\tag{10}
$$
Thus a fixed continuum counterfactor changes the weighted defect by a quantitatively controlled trace-class operator, uniformly in the prime cutoff. The bound grows with $A$; (10) alone asserts no convergence when $A$ grows with $X$.

## 3. Exact readout on the original test

Let $f\in C_c^\infty(\mathbb R)$, $F(t)=\int f(u)e^{itu}du$, and
$$
C_f(a)=\int f(u+a)\overline{f(u)}du,
\qquad M_\pm(f)=\int e^{\pm u/2}f(u)du.
$$
For $\chi=|F|^2$, the ordinary weighted diagonal trace formula gives
$$
\operatorname{Tr}\{M_\chi[\Delta(\widetilde U_{X,A})-\Delta(U_X)]\}
 =2\int_0^A\kappa(a)\Re C_f(a)\,da.
\tag{11}
$$
Indeed $-i\overline v_Av_A'=\Theta_A'$ and
$(2\pi)^{-1}\int|F(t)|^2\cos(at)dt=\Re C_f(a)$.

If $L$ is the diameter of the support of $f$ and $A\ge L$, then
$$
\int_0^A\kappa(a)\Re C_f(a)da
 =\Re\{M_+(f)\overline{M_-(f)}\}.
$$
Thus the exact correction is the actual pole form
$$
B(f)=2\Re\{M_+(f)\overline{M_-(f)}\}.
\tag{12}
$$
For an actual compact pole-null theta test $f=\Phi h$, both moments vanish, so the correction is zero. In particular, for $X\ge e^L$ and $A\ge L$,
$$
\boxed{
\operatorname{Tr}(M_{|F|^2}\Delta(\widetilde U_{X,A}))
 =Q(f).}
\tag{13}
$$
The physical test and its theta Hilbert/form norm have not changed. For general compact tests the original finite-place trace is $Q(f)-B(f)$, so (12) restores precisely the pole contribution when both support cutoffs are large enough.

The winding in (7) is consistent with restoring the two pole locations, but (12) is the precise weighted statement. It does not identify $\Delta(V_A)$ with a rank-two pole operator. For instance an odd real compact test has $B(f)=-2|M_+(f)|^2$, so this weighted readout can be negative.

## 4. Canceling the principal prime density before taking a norm

Now set $A=\log X$, where $X>1$, and let $\vartheta(x)=\sum_{p\le x}\log p$, $E(x)=\vartheta(x)-x$. The combined phase derivative, retaining all powers, is
$$
\boxed{
\begin{aligned}
\widetilde a_X(t)
={}&a_\infty(t)
 -2\int_{(1,X]}x^{-1/2}\cos(t\log x)\,dE(x)\\
 &+2\int_1^Xx^{-3/2}\cos(t\log x)\,dx\\
 &-2\sum_{p\le X}\sum_{k\ge2}
   (\log p)p^{-k/2}\cos(tk\log p).
\end{aligned}}
\tag{14}
$$
Here $a_\infty(t)=\Re\psi(1/4+it/2)-\log\pi$. The first-power continuum term $2\int_1^Xx^{-1/2}\cos(t\log x)dx$ has canceled exactly inside the combined symbol. No bound or critical-line Euler product has been used. The decaying continuum term in the second line and all proper powers in the third remain.

In particular, with $w_t(x)=x^{-1/2}\cos(t\log x)$, the first line's discrepancy has the exact endpoint expansion
$$
\int_{(1,X]}w_t\,dE
 =E(X)w_t(X)+1-\int_1^XE(x)w_t'(x)dx,
\tag{15}
$$
because $E(1)=-1$. For every $T\ge0$,
$$
\sup_{|t|\le T}\left|\int_{(1,X]}w_t\,dE\right|
\le\frac{|E(X)|}{\sqrt X}+1+
 (T+\tfrac12)\int_1^X\frac{|E(x)|}{x^{3/2}}dx.
\tag{16}
$$
Also the second line of (14) has absolute value at most $4$, and the proper-power sum before its factor $-2$ is bounded by
$$
\sum_{p\le X}\frac{\log p}{p(1-p^{-1/2})}=O(\log X)
\tag{17}
$$
using the elementary Chebyshev upper bound, as already established in the source note. Equations (14)–(17) supply a signed discrepancy formula and a quantitative bound for the renormalized derivative, without assuming that the discrepancy is small enough to give operator convergence or positivity.

One may pair the same identity directly with a fixed test. Put $R_f=\Re C_f$ and $w_f(x)=x^{-1/2}R_f(\log x)$. The discrepancy term is $-2\int w_f\,dE$, and the exact integration-by-parts formula is (15) with $w_t$ replaced by $w_f$, with the lower endpoint $+\|f\|_2^2$. Its remainder is bounded using
$$
|w_f'(x)|\le x^{-3/2}\|f\|_2
 (\|f'\|_2+\tfrac12\|f\|_2).
\tag{18}
$$
The proper powers are still paired at their actual arguments $k\log p$. For a compact test the entire signed expression stabilizes by support as asserted in (13).

A relative norm estimate must now act on the combined symbol in (14), or its full conjugated corner (5). A triangle estimate applied separately to $U_X$ and $V_{\log X}$ loses the principal-density cancellation. No estimate here yet controls the sign of (13). The arithmetic one-measure formulation using all of $\psi-x$, developed separately, can replace the split into the first and proper powers without changing this operator construction.

## 5. What need not be transported

The semilocal counterfactor does not preserve the actual theta image. This places a restriction on one possible use of (2), but does not invalidate the fixed-test construction (11)–(14).

For $Y\to+\infty$, endpoint Laplace asymptotics give
$$
\log|v_A(-iY)|
 =2\int_0^A\kappa(a)\frac{\sinh(aY)}a da
 \sim\frac{\kappa(A)}{AY}e^{AY}.
\tag{19}
$$
Every actual theta transform $F=\widehat{\Phi h}$, $h\in L^2(2\cosh(u/2)\Phi(u)du)$, satisfies by Cauchy-Schwarz and the full theta tail
$$
\log|F(-iY)|\le\tfrac12Y\log Y+O(Y)+\log\|h\|_H.
\tag{20}
$$
Indeed the squared evaluation norm is $\int\Phi(u)[2\cosh(u/2)]^{-1}e^{2Yu}du$, bounded by a constant times a gamma integral of order $Y+O(1)$.

Choose nonzero even $\eta\ge0$ in $C_c^\infty$, and set $f=-\eta''+\eta/4$. This is an actual compact even pole-null test. Its transform is $F(z)=(z^2+1/4)\widehat\eta(z)$, and
$$
|F(-iY)|\ge(Y^2-1/4)\int\eta(u)du\qquad(Y>1/2).
$$
Equations (19)–(20) show that $v_AF$ is outside the theta image for every $A>0$, even though its two algebraic pole zeros remain. Therefore one cannot transfer theta form coercivity by treating $V_A$ as a unitary of that Hilbert space. The construction instead keeps $M_{|F|^2}$ fixed and modifies only the semilocal defect, where (10)–(14) apply exactly.

The construction gives a quasi-inner relative operator with the same actual pole-null readout and the principal prime-density phase removed before comparison. The unresolved quantitative step concerns its signed corner or its combined weighted norm, including the prime discrepancy and all conjugated cross terms. Neither positivity modulo compact operators nor preservation of the readout supplies that step.

## 6. A stable rational factor and the shifted gamma baseline

There is a cleaner matched counterfactor that gives the same fixed-test readout. Split $V_A=V_A^+V_A^-$ using the two densities $e^{a/2}$ and $e^{-a/2}$ in (1). The decaying factor converges pointwise to
$$
R(t)=\exp\left(2i\int_0^\infty e^{-a/2}\frac{\sin(at)}a da\right)
 =\frac{1+2it}{1-2it}.
\tag{21}
$$
The integral equals $\arctan(2t)$, by differentiating in $t$ and using its value at zero. Each finite factor $V_A^\pm$ has winding $+1$ and tends to $-1$ at both real infinities. The factor $R$ has the same winding and endpoint value. Thus $R V_A^+$ still has winding $+2$, continuous symbol with endpoint value $1$, and compact Hardy off-diagonals.

Set $\widehat U_X=U_X R V_{\log X}^+$. For every compact test of support diameter at most $\log X$, its exact correction is still (12), because the difference between the finite and infinite decaying densities pairs with a zero correlation tail. In particular (13) holds with $\widehat U_X$.

Gamma recurrence gives the exact multiplier identity
$$
\rho_\infty(t)R(t)
 =\pi^{-it}\frac{\Gamma(5/4+it/2)}{\Gamma(5/4-it/2)}.
\tag{22}
$$
Its logarithmic phase derivative is $\Re\psi(5/4+it/2)-\log\pi$. Consequently (14) becomes
$$
\widehat a_X(t)=\Re\psi(5/4+it/2)-\log\pi
 -2\int_{(1,X]}x^{-1/2}\cos(t\log x)dE(x)
 -2\sum_{p\le X,k\ge2}(\log p)p^{-k/2}\cos(tk\log p).
\tag{23}
$$
The decaying continuum term has been absorbed exactly into a fixed gamma factor.

More precisely, $R=-(t-i/2)/(t+i/2)$, so
$$
\Delta(R)(t,s)=\frac1{2\pi(t-i/2)(s+i/2)}
\tag{24}
$$
is a positive rank-one projection. Its weighted trace is
$$
\frac1{2\pi}\int\frac{|F(t)|^2}{t^2+1/4}dt.
$$
For a nonzero pole-null compact test with diameter at most $A$, the contribution of $V_A^+$ alone is the negative of this strictly positive quantity. Thus it is essential to keep the rational factor when claiming the unchanged readout. Equations (21)–(24) identify it exactly; they assert no positivity of the remaining growing-density comparison.
