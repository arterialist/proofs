# Actual Xi: Bessel heat and compact Hankel constructions

Let $Z=\Xi(0)$, and retain the complete positive even theta kernel $\Phi$. Its unique positive arcsine mixing law is
```math
f_I(t)=-\frac4Z\int_{2\sqrt t}^{\infty}
\frac{\Phi'(u)}{\sqrt{u^2-4t}}\,du,
\qquad \mathbb E e^{aI}<\infty\quad(a>0).
```
The kernel is
```math
\Phi(u)=\sum_{k\ge1}(4\pi^2k^4e^{9u/2}-6\pi k^2e^{5u/2})e^{-\pi k^2e^{2u}},
\qquad Z=\int_{\mathbb R}\Phi(u)\,du.
```
Its normalization follows [Romik, equations (1.8) and (1.11)](https://math.ucdavis.edu/~romik/data/uploads/papers/riemannxi.pdf). Positivity and strict decrease for $u>0$ are [Csordas, Theorem 2.1](https://web.math.pmf.unizg.hr/glasnik/33.1/33105.pdf), after rescaling. The density above is nonnegative. In the variable $r=2\sqrt t$, Tonelli and $\int_0^u r/\sqrt{u^2-r^2}\,dr=u$ give mass $-2Z^{-1}\int_0^\infty u\Phi'(u)\,du=1$. More generally, the beta integral followed by integration by parts gives
```math
\mathbb E I^n=\frac{(n!)^2}{(2n)!}\frac{2\int_0^\infty u^{2n}\Phi(u)\,du}{Z}.
```
For $a>0$, the same Tonelli calculation bounds $\mathbb E e^{aI}$ by $-2Z^{-1}\int_0^\infty u\Phi'(u)e^{au^2/4}\,du<\infty$. The evenness of $\Phi$ gives $\Phi'(u)=O(u)$ at zero, so $f_I(0)=-4Z^{-1}\int_0^\infty\Phi'(u)/u\,du$ is finite and positive.
Define the diagonal operator and its exponential symbol by
```math
T_I[x^n]=\frac{\mathbb E I^n}{n!}x^n,
\qquad S(z)=\mathbb E I_0(2\sqrt{Iz})=\frac{\Xi(i\sqrt z)}Z.
```
Square roots in these expressions are interpreted through the even entire Bessel or Xi series. The Pólya–Schur classification is imported, not reproved; see [Borcea–Brändén, Theorem 1](https://arxiv.org/pdf/math/0607416). The conclusions below exclude specific sufficient constructions. They do not decide whether $T_I$ preserves real zeros and do not prove RH.

## Exact Abel operator identities

For $p(x)=\sum a_nx^n$, put $B_\beta p(y)=\sum a_ny^n/(\beta)_n$. The exact moments and $(1/2)_n=(2n)!/(4^nn!)$ give
```math
T_Ip(x)=\frac2Z\int_0^{\infty}\Phi(u)B_{1/2}p(u^2x/4)\,du.
```
Since $B_{1/2}=(2x\partial_x+1)B_{3/2}$, the integrand can be integrated by parts:
```math
\boxed{T_Ip(x)=-\frac2Z\int_0^{\infty}u\Phi'(u)
B_{3/2}p(u^2x/4)\,du.}
```
The boundary term is $[u\Phi(u)B_{3/2}p(u^2x/4)]_0^\infty=0$. Smoothness at zero and the full theta decay justify both endpoints for every polynomial. The measure $-2u\Phi'(u)du/Z$ is positive and has total mass one. Each fixed-scale Bessel multiplier preserves real zeros, by the [Bessel product](https://dlmf.nist.gov/10.21.E15) and Pólya–Schur. Preservation by this actual positive average is the unresolved step.

## A concrete Bessel heat factor and its obstruction

For $r\ge0$ and $s>0$, the squared-radius heat transition density is
```math
H_s(r,t)=s^{-1}e^{-(r+t)/s}I_0(2\sqrt{rt}/s),\qquad t\ge0.
```
It has mass one. Expanding the Bessel series and integrating the nonnegative terms, or using the planar Gaussian transition, gives
```math
\int_0^{\infty}H_s(r,t)I_0(2\sqrt{tz})\,dt
=e^{sz}I_0(2\sqrt{rz}).
```
The identity extends to complex $z$ by locally dominated entire series. Its diagonal action on every polynomial is exactly
```math
\boxed{\mathcal T_{r,s}p(x)=
\sum_{k=0}^{\deg p}\frac{r^kx^k}{(k!)^2}p^{(k)}(sx).}
```
Indeed the multiplier at degree $n$ is
$n!\sum_{k=0}^n s^{n-k}r^k/((n-k)!(k!)^2)$.
The exponential symbol $e^{sz}I_0(2\sqrt{rz})$ has only nonpositive real zeros and is in the required Laguerre–Pólya class. Thus every deterministic $r,s\ge0$ gives a real-root preserver; at $s=0$, the transition means $\delta_r$.

The actual theta law cannot be a positive mixture of such transitions with any positive heat time. For real $r,t\ge0$,
```math
H_s(r,t)\ge s^{-1}e^{-r/s}e^{-t/s}.
```
Its exponential moment at every $a\ge1/s$ is infinite. If a probability measure $\eta(dr,ds)$ represented the actual law through these transitions, Tonelli applied to $e^{m t}$ would force $\eta\{s\ge1/m\}=0$ for each positive integer $m$. Hence $s=0$ almost surely. The remaining mixture is exactly the original scaling mixture and supplies no new preservation result.

There is also an operator-level statement independent of a residual transition law. For $z\ge0$ and $\varepsilon>0$,
```math
1\le S(z)\le e^{\varepsilon z}\mathbb E e^{I/\varepsilon},
```
using $I_0(v)\le e^v$ and $2\sqrt{Iz}\le\varepsilon z+I/\varepsilon$. Thus $\log S(z)=o(z)$. It follows that $S$ cannot factor as $e^{sz}R(z)$ with $s>0$ and a normalized entire function $R$ having nonnegative coefficients, since $R(z)\ge1$ on the positive axis.

## A primary Hankel criterion fails on large actual truncations

Set $R=2\sqrt I$,
```math
q(r)=\frac r2 f_I(r^2/4),\quad
M_2=\int_0^\infty r^2q(r)\,dr=4\mathbb E I,
\quad H_A(z)=\int_0^A q(r)J_0(zr/A)\,dr.
```
The truncated multiplier symbol is
```math
Q_A(z)=H_A(iA\sqrt z)=\int_0^Aq(r)I_0(r\sqrt z)\,dr.
```
For order zero, [Cho–Chung–Park, Theorem 6.1](https://link.springer.com/article/10.1007/s00365-026-09737-8) gives a genuine sufficient condition: $q(r)/\sqrt r$ must increase on $(0,A)$. This follows by inserting $f_A(t)=Aq(At)/\sqrt t$ in their normalized Hankel transform. Its integrability at zero follows from the finite positive value $f_I(0)$. Under that sufficient condition $H_A$ is Laguerre–Pólya, so $Q_A$ has negative real zeros and the corresponding diagonal operator preserves real roots.

This condition cannot hold along unbounded actual cutoffs: if $q(r)/\sqrt r$ increased globally, positivity at one point would imply $q(r)\ge c\sqrt r$ eventually, contradicting $\int q=1$.

The stronger alternating-sample hypothesis of their Theorem 4.1 also fails on all sufficiently large actual cutoffs. The integral representation of $J_0$ and $\cos v\ge1-v^2/2$ imply $J_0(v)\ge1-v^2/4$ for real $v$. Markov's inequality then gives
```math
H_A(j)\ge1-\frac{(1+j^2/4)M_2}{A^2}.
```
Both $H_A(j_{0,1})$ and $H_A(j_{0,2})$ are therefore strictly positive whenever
```math
A^2>(1+j_{0,2}^2/4)M_2.
```
Their required sequence $(-1)^{m+1}H_A(j_{0,m})$ consequently cannot have constant strict sign. This rules out taking the natural radial truncations through that sufficient theorem. It does not assert that those truncated transforms, or the full transform, have a nonreal zero.

These arguments retain the complete theta law and use no finite Jensen or root census. The classical ingredients are cited above; no novelty claim is made.
