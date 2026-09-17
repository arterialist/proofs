# The first-window base average that yields pure ground entropy

Written calculation, 2026-09-17. This extends the [zero-to-zero covariance](full-f-zero-to-zero-reciprocal-ground-entropy-covariance.md) and identifies a support cost for using it on the unrestricted score. It retains the actual $F$, $E=\psi-x$, all von Mangoldt powers, and half-open first windows. It gives no RH-scale bound or Lean formalization.

Let $1<a<b$ be continuous zeros of $E$ on both sides, so $E(a^-)=E(a)=E(b^-)=E(b)=0$. Put
\[
w_Y^0(x)=p_s^2\frac{Y\log^2(x/Y)}{x^2}\mathbf1_{[Y,2Y)}(x),
\qquad B_s^{[a,b)}(Y)=\int_{[a,b)}\frac{w_Y^0(x)}{F(x)}\,dE(x),
\quad L=\log2.
\]
For every real $\theta$, finite-variation Fubini and $t=\log(x/Y)$ give the exact power-weighted base identity
\[
\int_0^\infty Y^\theta B_s^{[a,b)}(Y)dY
=p_s^2J_\theta\int_{[a,b)}\frac{x^\theta}{F(x)}dE(x),
\quad J_\theta=\int_0^L t^2e^{-(\theta+2)t}dt>0.
\tag{1}
\]
Since $F'=-E/x^2$ almost everywhere and $F$ is continuous at the source atoms, Stieltjes integration by parts has no boundary term and yields
\[
\boxed{\quad
\int_0^\infty Y^\theta B_s^{[a,b)}(Y)dY
=-p_s^2J_\theta\left[
\theta\int_a^b\frac{x^{\theta-1}E(x)}{F(x)}dx
+\int_a^b\frac{x^{\theta-2}E(x)^2}{F(x)^2}dx
\right].\quad}
\tag{2}
\]
The ordinary base measure $dY$ ($\theta=0$) is the unique power weight for which the signed linear term vanishes identically, leaving the strictly negative actual-source energy of the published note. For $\theta\ne0$, the algebra alone supplies no fixed sign: in the class of smooth source-ground pairs satisfying $F'=-E/x^2$, replace $E$ by $\epsilon\varphi$ with $\varphi\in C_c^\infty(a,b)$ and choose either sign of $\epsilon$. A positive $F$ exists for small $|\epsilon|$. The linear integral in (2) is first order in $\epsilon$ and can be nonzero, whereas the square is second order. This last countermodel is not the von Mangoldt source; it establishes only the absence of a source-uniform algebraic sign for other powers.

There is a separate support obstruction for positive base averages of the **unrestricted** score $B_s(Y)=\int_{[Y,2Y)}w_Y^0(x)F(x)^{-1}dE(x)$. If $q(Y)\ge0$ is locally integrable, its induced source kernel is
\[
K_q(x)=\int_{x/2}^{x}q(Y)w_Y^0(x)dY.
\tag{3}
\]
For $Y<x<2Y$, the factor $w_Y^0(x)$ is strictly positive. If $K_q=0$ almost everywhere outside $[a,b]$, Tonelli gives
\[
0=\int_0^\infty q(Y)
\left(\int_{(0,\infty)\setminus[a,b]}w_Y^0(x)dx\right)dY.
\]
The inner integral is positive unless $(Y,2Y)\subset[a,b]$, so almost every $Y$ with $q(Y)>0$ must satisfy $a\le Y$ and $2Y\le b$. If $b\le2a$, this is impossible for any nonzero positive $q$ (at equality it allows only the measure-zero point $Y=a$). Hence no positive ordinary base mixture can isolate a zero-to-zero source interval of multiplicative width at most two.

Even signed base weights cannot evade this by a **compactly supported** inversion. Put $u=\log x$, $Q(v)=q(e^v)$, and $k(t)=t^2e^{-2t}\mathbf1_{[0,L)}(t)$. Then (3) is exactly $K_q(e^u)=p_s^2(k*Q)(u)$. If $Q\in L^1$ is nonzero and compactly supported with essential support endpoints $\alpha<\beta$, the convolution has support endpoints $\alpha$ and $\beta+L$. This is the classical [Titchmarsh convolution support theorem](https://arxiv.org/abs/2011.05420) applied to the exact first-window kernel; the following Volterra calculation also proves these endpoints directly for this kernel. Near $\alpha$, before the upper cutoff of $k$ enters,
\[
\frac{d^3}{du^3}\bigl(e^{2u}K_q(e^u)\bigr)
=2p_s^2e^{2u}Q(u)
\quad\text{a.e.}
\]
so the convolution cannot vanish throughout a right neighborhood of $\alpha$. Near the other endpoint, write $u=\beta+L-s$ and $Q_*(z)=Q(\beta-z)$. For small $s>0$,
\[
p_s^{-2}K_q(e^{\beta+L-s})
=\int_0^s Q_*(z)k(L-s+z)dz.
\]
If this vanished throughout a left neighborhood of $\beta+L$, differentiation and $k(L^-)>0$ would give $|Q_*(s)|\le C\int_0^s|Q_*(z)|dz$; Gronwall would force $Q$ to vanish near $\beta$, a contradiction. Thus the logarithmic support width of $K_q$ is $(\beta-\alpha)+L>L$. A nonzero compactly supported signed $L^1$ base weight cannot isolate $[a,b]$ when $b/a\le2$ either. An exact signed inversion would need noncompact base tails or distributional weights. This is a support obstruction only; it does not bound the actual unrestricted prime-power score or prove RH.
