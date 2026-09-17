# Explicit order bounds for the actual-window phase Sobolev theorem

Use the complete phase, with every proper power retained,
$$
\Phi_X(t)=-2\sum_{p\le X}\sum_{k\ge1}p^{-k/2}\sin(kt\log p)/k,
\quad A=\log X,\quad X\ge2.
$$
Set $g(a;t)=\Phi_X(t+a/A)-\Phi_X(t)$, $w(a;t)=e^{ig(a;t)}$, and $f(a;t)=(w(a;t)-1)/a$, with its smooth value at zero. Let $I=[T,T+H]$, $H>0$, and let $\mathbb E_I$ denote normalized integration in $t$.

There are absolute constants $C\ge2$ and $C_{\rm MV}$ such that for every integer $m\ge0$, every $X\ge2$, $H>0$, and every real center $T$,
$$
\boxed{
\mathbb E_I\|\partial_a^m f\|_2^2
\le C^{2m+2}(m!)^2\left(1+C_{\rm MV}\frac{X^{m+1}}H\right).
}
\tag{1}
$$
In particular the $[C(m+1)]^{2m+2}$ order bound holds. There is also the more informative alternative, with $n=m+1$,
$$
\boxed{
\mathbb E_I\|\partial_a^m f\|_2^2
\le\left[\frac{C n(1+n/A)}{\log(n+1)}\right]^{2n}
\left(1+C_{\rm MV}\frac{X^n}H\right).
}
\tag{2}
$$
The constants in both estimates are independent of the order and all parameters. Taking their minimum gives the valid single bound with base
$Cn\min\{1,(1+n/A)/\log(n+1)\}$ and exponent $2n$.

These written estimates improve the direct frequency-separation proof retained below. No Lean formalization or priority claim is made. Their only prime-counting input is an absolute Chebyshev bound, used to obtain $\sum_{p\le X}\log p/p\le C_0 A$. The analytic input is Montgomery and Vaughan, [*Hilbert's Inequality* (1974), Corollary 3, equation (1.11)](https://personal.science.psu.edu/rcv4/personal/Publications/s2-8-1-73.pdf): a Dirichlet polynomial with integer frequencies obeys
$$
\mathbb E_I\left|\sum_n b_n n^{it}\right|^2
\le\sum_n|b_n|^2+\frac{C_{\rm MV}}H\sum_n n|b_n|^2.
$$
The bound is uniform in the center. No Haar moment is substituted for an actual window moment.

## Complete geometric derivatives with visible order/A dependence

Put $P_j=A^{-j}\Phi_X^{(j)}$. Its first-prime term is twice a real or imaginary part of
$$
D_j(t)=\sum_{p\le X}\frac{(\log p/A)^j}{\sqrt p}p^{it}.
$$
Write $R_j$ for the complete remainder $k\ge2$. For $j\ge2$ and $0<\tau\le A/4$,
$$
\boxed{
\|R_j\|_\infty\le C_0'(j-1)!\tau^{1-j}e^{2\tau}.
}
\tag{3}
$$
Indeed, with $v_p=\log p/A$, apply
$(kv_p)^{j-1}\le(j-1)!\tau^{1-j}e^{\tau kv_p}$ to the exact positive majorant
$2\sum_p v_p\sum_{k\ge2}(kv_p)^{j-1}p^{-k/2}$.
The remaining geometric series is
$$
\frac2A\sum_{p\le X}\frac{\log p\ p^{-1+2\tau/A}}
{1-p^{-1/2+\tau/A}}
\le\frac{2C_0}{1-2^{-1/4}}e^{2\tau}.
$$
This proves (3), and $\|R_1\|_\infty\le C_0'$ follows directly by taking no derivative. All primes, including two, and every depth are included.

For $j\ge2$, take $\tau=(j-1)/[2(1+2(j-1)/A)]$. It lies below $A/4$, and gives
$$
\|R_j\|_\infty
\le C_0'[2e(1+2(j-1)/A)]^{j-1}.
\tag{4}
$$
Alternatively, the fixed choice $\tau=(\log2)/4$ proves
$$
\|R_j\|_\infty\le C_R^j j!\quad(j\ge1)
\tag{5}
$$
with an absolute $C_R\ge1$. Formula (4), not just (5), records the high-order dependence on the normalized analytic width $A$.

## The improved actual-window moment bound

Let $B_j=\sum_{p\le X}(\log p/A)^{2j}/p\le C_0$. Apply Montgomery–Vaughan to the polynomial $D_j^r$, whose integer support lies below $X^r$. Unique factorization gives
$$
\sum_n|[n^{-it}]D_j^r|^2\le r!B_j^r.
$$
The notation denotes its ordinary Dirichlet coefficients, with either sign convention for $t$. Thus, for every integer $r\ge1$,
$$
\boxed{
\mathbb E_I|D_j|^{2r}
\le(1+C_{\rm MV}X^r/H)\,r!B_j^r.
}
\tag{6}
$$
The exponent is $r$, not $2r$. Repeated prime factors remain in the coefficient grouping; the permutation count is bounded by $r!$.

## Bell polynomials keep a single window factor

For a monomial of the $k$-th derivative of $w$, write its powers as $\ell_j$, where $\sum j\ell_j=k$ and $\ell=\sum\ell_j\le k$. Hölder with exponents $\ell/\ell_j$, followed by (6), yields
$$
\left\|\prod_jP_j^{\ell_j}\right\|_{L^2(I)}
\le\left(1+C_{\rm MV}X^k/H\right)^{1/2}
\prod_j(2\sqrt{kB_j}+\|R_j\|_\infty)^{\ell_j}.
\tag{7}
$$
All norms in $t$ are normalized. A translate $t+a/A$ has the same estimate. The exponents of the common window factor sum to one half; no extra factor is paid separately for each derivative.

Let $M_{j,k}=2\sqrt{kB_j}+\|R_j\|_\infty$. The exact Bell coefficients and the triangle inequality give the explicit reusable majorant
$$
\sup_a\|\partial_a^k w(a;\cdot)\|_{L^2(I)}
\le k!(1+C_{\rm MV}X^k/H)^{1/2}
\inf_{r>0}r^{-k}\exp\!\left(\sum_{j=1}^kM_{j,k}r^j/j!\right).
\tag{8}
$$
With (5), choose $r=(2C_R)^{-1}$. The exponent is at most $1+C_1\sqrt k$. Hence
$$
\sup_a\|\partial_a^k w\|_{L^2(I)}
\le k!(2C_R)^k e^{1+C_1\sqrt k}
(1+C_{\rm MV}X^k/H)^{1/2}
\le k!C_2^k(1+C_{\rm MV}X^k/H)^{1/2}.
\tag{9}
$$
Here $C_2$ is absolute, uniformly for every $k\ge1$.

For the refined bound, (4) implies $\|R_j\|_\infty\le G_k^j$ for all $j\le k$, where $G_k=C_3(1+k/A)\ge1$. Choose
$r=\log(k+1)/(2G_k)$. Then
$$
\sum_{j=1}^kM_{j,k}r^j/j!
\le C_4\sqrt k(e^r-1)+(e^{G_kr}-1)\le C_5k.
$$
Consequently
$$
\sup_a\|\partial_a^k w\|_{L^2(I)}
\le\left[\frac{C_6k(1+k/A)}{\log(k+1)}\right]^k
(1+C_{\rm MV}X^k/H)^{1/2}.
\tag{10}
$$

## The removable point and both physical tails

The exact identity
$$
\partial_a^m f(a;t)=\int_0^1s^m\partial_a^{m+1}w(sa;t)\,ds
$$
shows that the joint $L^2$ norm over $|a|\le1$ is at most
$\sqrt2\,\sup_a\|w^{(m+1)}\|_{L^2(I)}/(m+1)$.
Using (9) gives an upper bound $C^{m+1}m!(1+C_{\rm MV}X^{m+1}/H)^{1/2}$.
On $|a|\ge1$, Leibniz has coefficient $m!/k!$ multiplying
$a^{-(m-k+1)}\partial_a^k(w-1)$. For $k=0$ use $|w-1|\le2$; for $k\ge1$ use (9). The two-tail $L^2$ norm of each denominator is at most $\sqrt2$. The factorial $k!$ from (9) cancels $1/k!$, and the finite geometric sum in $C_2^k$ is absorbed into $C^{m+1}$. This proves (1).

To prove (2) without losing its logarithmic gain in the tails, use a different split. Put $n=m+1$, $G=C_3(1+n/A)$, and $R=\log(n+1)/(2G)$. The argument for (8), at this one radius, gives simultaneously for $1\le k\le n$
$$
\sup_a\|w^{(k)}\|_{L^2(I)}
\le k!R^{-k}e^{C_7n}(1+C_{\rm MV}X^n/H)^{1/2}.
$$
Split the $a$ integral at $|a|=R$. The central FTC estimate and the full tail Leibniz estimate now give
$$
\|f^{(m)}\|_{L^2(I\times\mathbb R)}
\le C n m! R^{-m-1/2}e^{C_7n}
(1+C_{\rm MV}X^n/H)^{1/2}.
$$
Since $nm!=n!\le n^n$ and $R\le\tfrac12\log(n+1)$, absorb $\sqrt R$ and the exponential into an absolute constant to obtain (2). This proof is valid even when $R<1$; the FTC estimate holds on every finite central interval, and the tail denominators are integrated beginning at the positive radius $R$.

## The complete coherent profile and its exact normalization

For the phase $g=g(\cdot;t)$ above, use the unitary Fourier transform
$\widehat f(y)=(2\pi)^{-1/2}\int e^{-iay}f(a)\,da$ and put

$$
J_g(v)=\frac{i}{\sqrt{2\pi}}\widehat f(-v),\qquad
F_g(v)=1_{v<0}+J_g(v).
\tag{P1}
$$

The divided difference belongs to $L^2$: it is smooth at zero and at most $2/|a|$ off zero. At each finite prime cutoff the complete Fourier expansion

$$
e^{ig(a;t)}=\sum_\lambda b_\lambda(t)e^{i\lambda a/A},
\quad b_\lambda(t)=\overline{U_X(t)}c_\lambda e^{it\lambda},
\quad\sum_\lambda b_\lambda(t)=1
$$

has geometric decay in all prime-power depths. In particular its absolute coefficient sum with any polynomial frequency weight is finite. The identity
$(e^{i\eta a}-1)/a=i\int_0^\eta e^{iya}\,dy$, including the oriented interval for negative $\eta$, gives

$$
F_g(v)=\sum_{\lambda<-Av}b_\lambda(t)\quad\text{for almost every }v.
\tag{P2}
$$

The literal coefficient cutoff is strict. Atoms on its countable threshold set do not change the $L^2$ identity. Every admitted prime power remains present. Plancherel gives

$$
\int_{\mathbb R}v^{2m}|F_g(v)-1_{v<0}|^2\,dv
=\frac1{2\pi}\|f^{(m)}\|_2^2.
\tag{P3}
$$

Define the actual signed clipping term, for $c\ge0$, by

$$
\mathcal B_X(t,c)=\frac1\pi\Re\left[
\overline{U_X(t)}\sum_{\lambda<-c}c_\lambda(-\lambda-c)e^{it\lambda}\right].
\tag{P4}
$$

Integrating (P2), justified by the weighted absolute sum, yields

$$
\frac{\mathcal B_X(t,A\alpha)}A
=\frac1\pi\Re\int_\alpha^\infty F_g(v)\,dv.
\tag{P5}
$$

For $\alpha>0$, use Cauchy–Schwarz with $v^m$ and $v^{-m}$ in (P5), followed by (P3). This proves (11) below pointwise before averaging. It also explains why no smoothness assumption on a moving threshold is needed.

## A finite-parameter moving-gamma consequence

The weighted Fourier-profile identity proved below gives, for any measurable threshold $\alpha(t)\ge a_0>0$ and $m\ge1$,
$$
\left\|\frac{\mathcal B_X(t,A\alpha(t))}A\right\|_{L^2(I)}
\le\frac{a_0^{1/2-m}}{\sqrt{2\pi^3(2m-1)}}
\left(\mathbb E_I\|f^{(m)}\|_2^2\right)^{1/2}.
\tag{11}
$$
This preserves arbitrary moving thresholds; no derivative of $\alpha$ is used.

Let $q=\log H/A$, assume $T\ge H$, and take the actual quarter-gamma slope $\alpha(t)=c_t/A$, where $c_t=\Re\psi(1/4+it/2)-\log\pi$ and $\psi=\Gamma'/\Gamma$. Once $q$ exceeds an absolute $q_0$, $T\ge H\ge2^{q_0}$ ensures
$a_0\ge c_0\log T/A\ge c_0q$ with an absolute $c_0>0$.
Choose $m=\lfloor\delta q\rfloor$, where a sufficiently small absolute $\delta>0$ depends only on the constants above. Increase $q_0$ so $1\le m$ and $m+1\le q$. The window factor is then at most $1+C_{\rm MV}$. Equation (1), with $m!\le m^m$, inserted in (11) yields
$$
\boxed{
\|\mathcal B_X(t,c_t)/A\|_{L^2(I)}\le C e^{-c q},
\qquad X\ge2,\quad q\ge q_0,\quad T\ge H.
}
\tag{12}
$$
Indeed the exponential factor is $(Cm/(c_0q))^m$, while the remaining square-root powers of $q$ are absorbed by reducing the positive exponential constant. The estimate is uniform even when $T$ is arbitrarily larger than $H$, because $a_0^{1/2-m}$ decreases with $a_0$.

There is a stronger genuine regime. If also $q\le A$, choose $m=\lfloor q/2\rfloor$. Then $n=m+1\le q$, $1+n/A\le2$, and (2) makes the exponential factor at most $(C/\log q)^m$. For a sufficiently large absolute $q_0$ this gives
$$
\boxed{
\|\mathcal B_X(t,c_t)/A\|_{L^2(I)}
\le C e^{-c q\log\log q},
\qquad q_0\le q\le A,\quad T\ge H.
}
\tag{13}
$$
This improvement comes from retaining the order/A dependence of the complete geometric derivatives and choosing the physical split radius accordingly.

For the actual canonical remainder, with all its multipliers and densities defined below,
$\mathscr R_X=(d^{(2)}_{u_X}-d^{(2)}_{g_\infty}-d^{(1)}_{U_X})/A$,
the gamma and counterphase comparison proved below adds only
$$
C\varepsilon_{X,T},\quad
\varepsilon_{X,T}=\frac1{A\sqrt T}
+\frac{\sqrt{X(\log T+\sqrt X)}}{T A^{3/2}}
+\frac{X}{T^2A^2}.
$$
Thus (12) and (13) hold with this explicit additive error for the canonical remainder. It can also be absorbed into $Ce^{-cq}$ in (12), uniformly for $X\ge2,T\ge H=X^q,q\ge q_0$. In the additional range $q\le A$, it is absorbed into the bound in (13), since $H=e^{Aq}$ with $A\ge q$. These are finite-parameter actual-window estimates, not just a statement for each fixed derivative order. They make no fixed-observation or RH assertion.


## Canonical gamma and counterphase comparison

Use the density normalization in the [full-product freezing theorem](uniform-full-product-arch-freezing.md):

$$
d_w^{(2)}(t)=\frac1{4\pi^2}\int\frac{|w(t+h)-w(t)|^2}{h^2}\,dh,
\qquad d_{U_X}^{(1)}=\frac{\Phi_X'}{2\pi}.
$$

Put

$$
u_\infty(t)=\pi^{-it}\frac{\Gamma(1/4+it/2)}{\Gamma(1/4-it/2)},
\quad r(t)=\frac{1+2it}{1-2it},\quad g_\infty=u_\infty r,
$$
$$
V_X(t)=r(t)\exp\left(2i\int_0^A e^{a/2}\frac{\sin(at)}a\,da\right),
\qquad u_X=u_\infty U_XV_X.
\tag{C1}
$$

Gamma recurrence makes $g_\infty$ exactly the gamma ratio with $5/4$ in place of $1/4$. The published freezing theorem proves

$$
d^{(2)}_{u_\infty U_X}-d^{(2)}_{u_\infty}-d^{(1)}_{U_X}
=\mathcal B_X(t,c_t)+O(T^{-1/2})\quad(T\le t\le2T),
\tag{C2}
$$

uniformly in every finite prime set. Its gamma series also gives $c_t=\log(t/(2\pi))+O(T^{-2})$ and $d_{u_\infty}^{(2)}(t)\ll\log T$.

Here is a direct bound for the entire continuum correction, including distant jumps through the origin. Integration by parts in

$$
2\int_0^A e^{a/2}\frac{\sin(at)}a\,da
=2\operatorname{Si}(At)+2\int_0^A\frac{e^{a/2}-1}{a}\sin(at)\,da
$$

uses the increasing function $(e^{a/2}-1)/a$ and the classical sine-integral tail. Since $r(t)$ tends to $-1$ and $e^{2i\operatorname{Si}(At)}$ tends to $-1$ on each end of the line, their leading factors cancel. Differentiating the integral gives exactly
$2\Re[(e^{(1/2+it)A}-1)/(1/2+it)]$. Consequently

$$
|V_X(t)-1|\le C\min\{1,B/(1+|t|)\},\quad
|V_X'(t)|\le CD/(1+|t|),\quad \|V_X-1\|_2^2\le CB,
$$

where $B=1+\sqrt X/A$ and $D=\sqrt X$. For $t\in[T,2T]$, split the squared divided-difference integral at $|h|=T/2$. On the near part use
$|V_X(t+h)-V_X(t)|\le C\min(D|h|/T,B/T)$.
On the far part use $2|V_X(t+h)-1|^2+2|V_X(t)-1|^2$. Integrating gives

$$
d_{V_X}^{(2)}(t)\le C\left(\frac{DB+B}{T^2}+\frac{B^2}{T^3}\right)
\le\frac{CX}{T^2A},\qquad X,T\ge2.
\tag{C3}
$$

The complete derivative satisfies
$\|U_X'\|_\infty\le2\sum_{p\le X}\log p/(\sqrt p-1)\ll\sqrt X$ by Chebyshev partial summation. Hence $d_{U_X}^{(2)}\ll\sqrt X$, and the product inequality gives $d_{u_\infty U_X}^{(2)}\ll\log T+\sqrt X$. For arbitrary unitary $w,v$, that inequality is the elementary divided-difference Cauchy estimate

$$
|d_{wv}^{(2)}-d_w^{(2)}|
\le2\sqrt{d_w^{(2)}d_v^{(2)}}+d_v^{(2)}.
\tag{C4}
$$

Equations (C3)–(C4) produce the last two terms of $A\varepsilon_{X,T}$. Direct evaluation gives $d_r^{(2)}(t)=1/[2\pi(t^2+1/4)]$, so replacing $u_\infty$ by $g_\infty$ costs $O(\sqrt{\log T}/T)$, absorbed in $A\varepsilon_{X,T}$. Combining with (C2) proves the stated canonical comparison without restricting $X$ before the final regime is imposed.

## A separate direct frequency-separation proof

For each fixed order, a weaker window exponent follows without the mean-value theorem. In $|D_j|^{2r}$, the two integer products are at most $X^r$. Unequal products have logarithms separated by at least $X^{-r}$, while the total absolute coefficient sum is at most $(2\sqrt X)^{2r}$. Integrating each nonzero frequency over a window of length $H$ bounds the total off-diagonal part by $C_rX^{2r}/H$. The diagonal is at most $r!B_j^r$. Adding the full proper-power remainder, applying Hölder to the finitely many derivative monomials, and using the same central FTC and two-tail calculation proves

$$
\mathbb E_I\|f^{(m)}\|_2^2\le C_m(1+X^{2m+2}/H).
\tag{D1}
$$

This elementary method preserves signed frequencies before estimating them, but does not keep an order-uniform $C_m$. The Montgomery–Vaughan and Bell-polynomial proof above supplies both the improved window exponent and explicit order control. The pointwise clipping comparison does not depend on a Gaussian or Haar limit, and gives no fixed-observation RH bound.
