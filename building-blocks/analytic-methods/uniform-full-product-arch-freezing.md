# Uniform full-product clipping by freezing the archimedean phase

The freezing error in Sections 1–4 is independent of the finite prime set. It gives a direct physical-kernel estimate at the exact gamma phase derivative, without an absolute coefficient-mass cost. Section 5 then controls replacement by the logarithmic threshold, with only logarithmic dependence on the place cutoff.

Use $D=-i\partial_t$ and the source diagonal conventions
$$
d_w^{(2)}(t)=\frac1{4\pi^2}\int_{\mathbb R}
 \frac{|w(t)-w(t+h)|^2}{h^2}dh,
\qquad
d_w^{(1)}(t)=\frac1{2\pi}\Re(\overline w Dw)(t)
\tag{1}
$$
for smooth unitary multipliers $w$. Let $P_X$ be the actual complete finite-prime unitary product, and let
$$
u(t)=u_\infty(t)=\pi^{-it}
 \frac{\Gamma(1/4+it/2)}{\Gamma(1/4-it/2)}=e^{i\phi(t)}.
$$
Choose the continuous real phase with $\phi(0)=0$. Its exact derivative is
$$
c_t=\phi'(t)=\Re\psi(1/4+it/2)-\log\pi.
\tag{2}
$$

## 1. A physical-kernel freezing lemma

Fix $t$. Suppose $u=e^{i\phi}$ has a real twice continuously differentiable phase on $[t-R,t+R]$, and $|\phi''|\le M$ there. For any globally smooth unitary multiplier $P$, define $c=\phi'(t)$ and
$$
\mathfrak F_c(P;t)=\frac1{2\pi^2}\Re\operatorname{PV}
 \int_{\mathbb R}\frac{e^{-ich}[1-P(t)\overline{P(t+h)}]}{h^2}dh.
\tag{3}
$$
Then
$$
\boxed{
|d_{uP}^{(2)}(t)-d_u^{(2)}(t)-\mathfrak F_c(P;t)|
 \le\frac4{\pi^2}\left(\sqrt M+\frac1R\right).}
\tag{4}
$$
The constant is independent of $P$, its derivatives, and its frequency content.

The exact kernel difference before freezing is
$$
d_{uP}^{(2)}(t)-d_u^{(2)}(t)
=\frac1{2\pi^2}\Re\operatorname{PV}\int
 \frac{u(t)\overline{u(t+h)}[1-P(t)\overline{P(t+h)}]}{h^2}dh.
\tag{5}
$$
Both real-part integrals in (3) and (5) are absolutely convergent. To check the origin, write the local phase derivative of $P$ as $b$. Then $1-P(t)\overline{P(t+h)}=ibh+O(h^2)$; its linear term is purely imaginary. Multiplication by either archimedean factor preserves this property. The complex integrals have a symmetric principal value, and the real-part formulation gives the same value. At infinity the numerator is bounded and $h^{-2}$ is integrable.

Taylor's theorem and $|e^{ix}-e^{iy}|\le\min(2,|x-y|)$ give
$$
|u(t)\overline{u(t+h)}-e^{-ich}|
 \le\min(2,Mh^2/2),\qquad |h|\le R.
$$
Since $|1-P(t)\overline{P(t+h)}|\le2$, the difference of (3) and (5) is itself an absolutely convergent complex integral. On the near interval its absolute contribution is at most
$$
\frac1{\pi^2}\int_{|h|\le R}\min(2/h^2,M/2)dh
 \le\frac{4\sqrt M}{\pi^2}.
$$
On $|h|>R$, bounding the two unitary-factor differences by two gives at most
$2\pi^{-2}\int_{|h|>R}h^{-2}dh=4/(\pi^2R)$.
This proves (4). The large derivatives of an admitted prime product never enter this estimate.

## 2. The exact gamma curvature bound

The trigamma series, [DLMF 5.15.1](https://dlmf.nist.gov/5.15.E1), gives for $b=|v|/2>0$
$$
|\phi''(v)|=b\sum_{n=0}^\infty
 \frac{n+1/4}{((n+1/4)^2+b^2)^2}.
\tag{6}
$$
For positive $v$, all the terms have positive sign; the second derivative is odd. This follows by differentiating (2):
$\phi''(v)=-\tfrac12\Im\psi'(1/4+iv/2)$.

The positive function $f_b(x)=x/(x^2+b^2)^2$, $x\ge0$, is unimodal, with
$$
\int_0^\infty f_b(x)dx=\frac1{2b^2},\qquad
\max f_b=\frac9{16\sqrt3\,b^3}.
$$
Comparing its values at the shifted integer lattice with the integral and bounding the comparison error by total variation yields
$$
\sum_{n=0}^\infty f_b(n+1/4)
 \le\int_0^\infty f_b(x)dx+2\max f_b.
$$
For example, on each unit interval the discrepancy is bounded by the integral of $|f_b'|$; summing gives the asserted total-variation bound. Consequently
$$
|\phi''(v)|\le\frac1{|v|}+\frac9{2\sqrt3\,|v|^2}
 \le\frac4{|v|}\qquad(|v|\ge1).
\tag{7}
$$
For $\tau=|t|\ge2$ and $|v-t|\le\tau/2$, this implies
$\left|\phi''(v)\right|\le8/\tau$.
Use $R=\tau/2$ and $M=8/\tau$ in (4). The result is
$$
\boxed{
|d_{u_\infty P}^{(2)}(t)-d_{u_\infty}^{(2)}(t)
 -\mathfrak F_{c_t}(P;t)|
\le\frac{8\sqrt2}{\pi^2\sqrt\tau}+\frac8{\pi^2\tau}
 <\frac2{\sqrt\tau},\quad \tau\ge2.}
\tag{8}
$$
This holds for every smooth unitary $P$, in particular every actual finite-prime product, with the same constant.

## 3. The frozen carrier gives the exact full-product boundary

First treat $c$ as a constant parameter. The multiplier $s\mapsto e^{ics}P_X(s)$ is unitary, and its squared density minus that of the constant carrier is exactly (3). Thus
$$
\mathfrak F_c(P_X;t)
 =\frac1{2\pi}\Re\left[
 \overline{P_X(t)}\bigl((|D+c|-|c|)P_X\bigr)(t)\right].
\tag{9}
$$
Only after establishing this fixed-parameter identity do we evaluate it at $c=c_t$. In particular one does not differentiate the variable function $e^{itc_t}$, which would be a different multiplier.

Use the exact full coefficient expansion
$$
P_X(t)=\sum_\lambda c_\lambda e^{i\lambda t},\qquad
\sum_\lambda(1+|\lambda|)|c_\lambda|<\infty,
$$
obtained by multiplying the complete one-prime series $U_p(t)=-r_pe^{it\log p}+(1-r_p^2)\sum_{j\ge0}r_p^je^{-ijt\log p}$. Each series has finite absolute moments of every fixed order; a finite product preserves this property. Every frequency is the net prime history $\lambda=\sum_{p\le X}k_p\log p$, with $k_p\in\{1,0,-1,-2,\ldots\}$, and every proper power is present. Equation (9) is therefore the absolutely convergent identity
$$
\mathfrak F_c(P_X;t)
=\frac1{2\pi}\Re\left[
 \overline{P_X(t)}\sum_\lambda
 c_\lambda(|\lambda+c|-|c|)e^{i\lambda t}\right].
\tag{10}
$$
No Fourier-series triangle bound was used in the error (8). Summability is used here only to identify the exact frozen term.

For $c_t\ge0$, the identity
$|\lambda+c_t|-c_t=\lambda+2(-\lambda-c_t)_+$
gives the desired uniform full-product theorem:
$$
\boxed{
\begin{aligned}
d_{u_\infty P_X}^{(2)}(t)-d_{u_\infty}^{(2)}(t)
={}&d_{P_X}^{(1)}(t)+\mathcal B_X(t,c_t)+\mathcal R_X(t),\\
\mathcal B_X(t,c_t)
={}&\frac1\pi\Re\left[
 \overline{P_X(t)}\sum_{\lambda<-c_t}
 c_\lambda(-\lambda-c_t)e^{i\lambda t}\right],\\
|\mathcal R_X(t)|<&\frac2{\sqrt{|t|}}.
\end{aligned}}
\tag{11}
$$
The error is uniform in $X$, and $|t|\ge2$ is understood. At frequencies with $\lambda=-c_t$ the boundary coefficient is zero. Expanding $\overline{P_X}$ in (11) retains every off-diagonal coefficient correlation:
$$
\mathcal B_X(t,c_t)=\frac1\pi\Re
\sum_{\lambda<-c_t}\sum_{\mu\in\operatorname{spec}P_X}
 \overline{c_\mu}c_\lambda(-\lambda-c_t)e^{i(\lambda-\mu)t}.
\tag{12}
$$
This includes all off-diagonal correlations. Neither the boundary nor its individual coefficient pairs are asserted to have a pointwise sign.

The exact threshold $c_t$ tends to infinity as $|t|\to\infty$, by the gamma asymptotic [DLMF 5.11.2](https://dlmf.nist.gov/5.11.E2); hence $c_t\ge0$ for all sufficiently large $|t|$. Formula (10), together with the same error (8), is valid for every $|t|\ge2$, even where $c_t<0$. This avoids an unnecessary numerical threshold or a change of the clipping point.

## 4. Uniform observations and the remaining arithmetic term

For any integrable real observation $\chi$ supported in a region $|t|\ge T\ge2$ where $c_t\ge0$, (11) gives
$$
\left|\int\chi(t)
 [d_{u_\infty P_X}^{(2)}-d_{u_\infty}^{(2)}
  -d_{P_X}^{(1)}-\mathcal B_X(t,c_t)]dt\right|
 \le\frac2{\sqrt T}\|\chi\|_1,
\tag{13}
$$
uniformly over the complete finite place set. At lower frequencies the exact kernel or the general frozen expression (10) remains available. No low-frequency part of an actual test is silently removed.

The exponential coefficient cost in the older clipped-sum error has disappeared from (8), (11), and (13). This is because the archimedean factor was frozen while the entire prime product remained unitary, before any coefficient decomposition. The same improvement applies to arbitrarily growing finite $X$ at this exact gamma threshold.

The full arithmetic boundary (12) remains. Its sign and size have not been bounded uniformly in the place cutoff, and the local signed-norm/RH comparison does not follow from an auxiliary squared-defect error estimate. The change from $c_t$ to $\log(|t|/(2\pi))$ is controlled separately below. A scalar approximation of the threshold alone would not suffice without that full-product estimate.


## 5. Replacing the gamma slope without a coefficient-mass loss

Let $P$ be a smooth unitary multiplier with $M=\|P'\|_\infty<\infty$, and let $c,d\in\mathbb R$. Put $\delta=|c-d|$. The difference of the frozen functionals (3) is an absolutely convergent complex integral before its real part is taken. Indeed,
$$
|e^{-ich}-e^{-idh}|\le\min(2,\delta|h|),\qquad
|1-P(t)\overline{P(t+h)}|\le\min(2,M|h|).
$$
The product is $O(h^2)$ at zero and bounded at infinity. Therefore
$$
|\mathfrak F_c(P;t)-\mathfrak F_d(P;t)|
\le\frac1{2\pi^2}\int_{\mathbb R}
 \frac{\min(2,\delta|h|)\min(2,M|h|)}{h^2}\,dh.
\tag{14}
$$
If $\delta=0$, the two functionals agree. If $M=0$, $P$ is constant and both are zero. For positive $\delta,M$, set $a=\min(\delta,M)$, $b=\max(\delta,M)$. On the positive half-line split the integral at $2/b$ and $2/a$. The three integrals are respectively $2a$, $2a\log(b/a)$, and $2a$. Thus the exact value of the majorant is
$$
\boxed{
|\mathfrak F_c-\mathfrak F_d|
\le\frac{2a}{\pi^2}\left(2+\log\frac ba\right)
\le\frac4{\pi^2}\delta
 \left[1+\log_+\frac M\delta\right].}
\tag{15}
$$
Here the right side is defined as zero when $\delta=0$, and the zero case $M=0$ was handled separately. For $\delta\le M$, the second inequality is immediate. For $\delta\ge M$, use $2+\log x\le2x$ for $x\ge1$.

For fixed $M>0$, the function
$$
q_M(v)=v[1+\log_+(M/v)],\quad v>0,\qquad q_M(0)=0
$$
is continuous and nondecreasing: its derivative is $\log(M/v)$ below $M$, and one above $M$. Consequently an upper bound on $\delta$ can be substituted in (15), even when the actual $\delta$ is arbitrarily small. There is no uncontrolled $\log(1/\delta)$ loss.

### An explicit uniform gamma remainder

Take $z=1/4+it/2$ and $\tau=|t|>0$. The complex remainder bound for the digamma expansion in [DLMF 5.11.2 and Section 5.11(ii)](https://dlmf.nist.gov/5.11), with the sum stopped before its first Bernoulli term, gives
$$
\psi(z)=\log z-\frac1{2z}+R_1(z),\qquad
|R_1(z)|\le\frac{\sec^3(\arg z/2)}{12|z|^2}
\le\frac{2\sqrt2}{3\tau^2}.
\tag{16}
$$
This uses $|\arg z|<\pi/2$ and $|z|\ge\tau/2$, and applies to either sign of $t$. Also
$$
0\le\log|z|-\log(\tau/2)
=\frac12\log\left(1+\frac1{4\tau^2}\right)
\le\frac1{8\tau^2},\qquad
\left|\Re\frac1{2z}\right|=\frac1{8|z|^2}
\le\frac1{2\tau^2}.
$$
It follows that, with $d_t=\log(\tau/(2\pi))$,
$$
\boxed{\delta_t=|c_t-d_t|
\le\left(\frac58+\frac{2\sqrt2}{3}\right)\tau^{-2}
<2\tau^{-2}.}
\tag{17}
$$
In particular this is a uniform remainder estimate, rather than a formal asymptotic substitution.

### The derivative norm of the actual complete prime product

For $X\ge2$, retain the full local factors
$$
P_X(t)=\prod_{p\le X}
\frac{1-p^{-1/2}e^{it\log p}}{1-p^{-1/2}e^{-it\log p}}.
$$
Their absolutely convergent logarithmic series give the real phase derivative
$$
-i\overline{P_X(t)}P_X'(t)
=-2\sum_{p\le X}\sum_{k\ge1}(\log p)p^{-k/2}
 \cos(kt\log p).
$$
At $t=0$, all cosines equal one. Since $|P_X|=1$, this proves the exact identity
$$
\boxed{M_X=\|P_X'\|_\infty
=2\sum_{p\le X}\sum_{k\ge1}(\log p)p^{-k/2}
=2\sum_{p\le X}\frac{\log p}{\sqrt p-1}.}
\tag{18}
$$
Every proper power is included. The elementary Chebyshev estimate $\vartheta(y)\le C_\vartheta y$, followed by Stieltjes partial summation, yields
$$
\sum_{p\le X}\frac{\log p}{\sqrt p}
=\frac{\vartheta(X)}{\sqrt X}
 +\frac12\int_2^X\frac{\vartheta(y)}{y^{3/2}}\,dy
\le2C_\vartheta\sqrt X.
$$
Here the lower boundary is $\vartheta(2-)=0$, so the atom at two is retained. Since $(1-p^{-1/2})^{-1}\le(1-2^{-1/2})^{-1}$,
$$
M_X\le\frac{4C_\vartheta}{1-2^{-1/2}}\sqrt X.
\tag{19}
$$
For completeness, the Chebyshev estimate used here follows by observing that the primes $n<p\le2n$ divide $\binom{2n}{n}$, so $\vartheta(2n)-\vartheta(n)\le2n\log2$; summing dyadic intervals gives $\vartheta(y)=O(y)$. If $X<2$, the product is empty and both its derivative and the threshold-change error vanish.

Combining (15), monotonicity of $q_{M_X}$, and (17), we obtain the coefficient-free estimate
$$
\boxed{
|\mathfrak F_{c_t}(P_X;t)-\mathfrak F_{d_t}(P_X;t)|
\le\frac8{\pi^2\tau^2}
 \left[1+\log_+\left(\frac{M_X\tau^2}{2}\right)\right].}
\tag{20}
$$
For $X\ge2$, $\tau\ge2$, this is
$O(\tau^{-2}[1+\log(2+X)+\log\tau])$, with an absolute implied constant.

### The logarithmic-threshold full-product formula

For $\tau\ge2\pi$, the logarithmic threshold $d_t$ is nonnegative. Apply the general frozen identity (10) at $d_t$, and use (8) and (20). This gives
$$
\boxed{
\begin{aligned}
d_{u_\infty P_X}^{(2)}(t)-d_{u_\infty}^{(2)}(t)
={}&d_{P_X}^{(1)}(t)+\mathcal B_X(t,d_t)
 +\widetilde{\mathcal R}_X(t),\\
\mathcal B_X(t,d_t)
={}&\frac1\pi\Re\left[
\overline{P_X(t)}\sum_{\lambda<-d_t}
 c_\lambda(-\lambda-d_t)e^{i\lambda t}\right],\\
|\widetilde{\mathcal R}_X(t)|
\le{}&\frac2{\sqrt\tau}
 +\frac8{\pi^2\tau^2}
 \left[1+\log_+\left(\frac{M_X\tau^2}{2}\right)\right].
\end{aligned}}
\tag{21}
$$
The condition here is $d_t\ge0$; no additional sign condition on the exact $c_t$ is needed. The boundary still contains every full net frequency, proper power, and off-diagonal coefficient correlation as in (12). Its sign is not asserted.

For any fixed $K>0$, uniformly over $2\le X\le\tau^K$, the added threshold-change error is $O_K(\tau^{-2}\log\tau)=o(\tau^{-1/2})$. Thus the physical-kernel method recovers the logarithmic boundary used in the earlier clipped formula while avoiding exponential coefficient-mass costs for growing prime sets. This is a quantitative archimedean–product approximation; it does not by itself control the retained signed arithmetic boundary or prove the RH comparison.

These are written proofs using the classical gamma expansions cited above. They assert no sign or cutoff-uniform bound for the retained arithmetic boundary and make no Lean claim.
