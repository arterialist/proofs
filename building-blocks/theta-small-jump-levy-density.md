# A local Lévy density for the natural theta exponent

A direct inverse-Laplace construction gives a unique candidate Lévy density for the natural theta exponent. This density is positive and strictly decreasing for all sufficiently small jumps. The result applies to the complete theta kernel; it does not establish a positive Lévy representation on the whole half-line and has no Lean formalization.

Use the normalization of the [natural-exponent note](theta-natural-exponent-concavity.md):

$$
\Phi(u)=\sum_{n\ge1}(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2})
e^{-\pi n^2e^{2u}},\qquad
g(v)=-\frac d{dv}\Phi(\sqrt v),\qquad k=-g'/g,
$$

$$
B(q)=\int_0^\infty v^{q-1}g(v)\,dv,\qquad
C(q)=\int_0^\infty v^{q-1}k(v)g(v)\,dv,\qquad
\phi(s)=\frac{F(s)}{F(s+1)}=4\frac{C(s+3/2)}{B(s+3/2)}.
\tag{1}
$$

Here $F$ is the entire normalized coefficient interpolation already defined there. Explicitly, with $Z=2\int_0^\infty\Phi(u)du$,

$$
F(s+1)=L(s)=\frac{\sqrt\pi\,4^{-s}B(s+3/2)}{Z\Gamma(s+3/2)}.
$$

This follows initially by integration by parts from $B(s+3/2)=(s+1/2)M(2s)$ and then by continuation. The integrals for $B,C$ converge for $\Re q>0$. The [derivative-kernel theorem](theta-derivative-kernel-logconcavity.md) gives $g,k,k'>0$, smoothness at zero and rapid decay at infinity. Put

$$
f(s)=-\phi''(s),\qquad j(s)=3f(s)+sf'(s).
\tag{2}
$$

**Theorem.** There is $\sigma_*>0$ such that $f,j$ are holomorphic on $\Re s>\sigma_*$. Their Bromwich inverses $h,w$ are real, continuous, supported in $[0,\infty)$ and of exponential order. On $r>0$, $h$ is continuously differentiable and

$$
w(r)=2h(r)-rh'(r),\qquad
\pi(r):=\frac{h(r)}{r^2},\qquad \pi'(r)=-\frac{w(r)}{r^3}.
\tag{3}
$$

As $r\downarrow0$,

$$
\pi(r)\sim\frac{32}{r^2\log^3(1/r)},\qquad
-\pi'(r)\sim\frac{64}{r^3\log^3(1/r)}.
\tag{4}
$$

Consequently, for some $r_0>0$, $\pi$ is positive and strictly decreasing on $(0,r_0)$, with

$$
\int_0^{r_0}r\pi(r)\,dr<\infty,\qquad
\int_0^{r_0}\pi(r)\,dr=\infty.
\tag{5}
$$

Thus $\pi(r)\mathbf1_{(0,r_0)}(r)$ is a genuine Lévy density of infinite activity and finite first moment. Its extension by zero is nonincreasing.

## A uniform complex saddle for the complete kernel

Set $p=q-1$, $R=|p|$, $y=\pi e^{2u}$, and

$$
A(y)=1-\frac{15}{4y}+\frac{15}{8y^2},\qquad
S_p(u)=2p\log u+\frac{13}{2}u-\pi e^{2u}.
$$

Exact differentiation gives

$$
B(q)=-\int_0^\infty u^{2q-2}\Phi'(u)\,du,
\qquad
-u^{2q-2}\Phi'(u)=8\pi^3e^{S_p(u)}
\sum_{n\ge1}n^6A(n^2y)e^{-(n^2-1)y}.
\tag{6}
$$

For a sufficiently small fixed $\eta>0$, work in
$\Re p\ge-\eta R/\log R$, $R$ large. The analytic saddle satisfies

$$
\pi u_*e^{2u_*}=p+\frac{13}{4}u_*,\qquad
u_*=\frac12W_0(2p/\pi)+O(\log R/R).
\tag{7}
$$

Indeed, on a circle of radius $K\log R/R$ about $\tfrac12W_0(2p/\pi)$, the linear part of $\pi ue^{2u}-p$ dominates its quadratic remainder and the perturbation $13u/4$. Rouché's theorem gives a unique simple root there. The resulting local analytic choices agree. The principal Lambert branch gives, for $u_*=a+ib$ and $y_* =\pi e^{2u_*}$,

$$
a=\tfrac12(\log R-\log\log R+O(1)),\quad
|b|<\pi/4-c/\log R,\quad
\Re y_*\ge cR/\log^2R,\quad |y_*|\asymp R/\log R.
\tag{8}
$$

To check the strip gap near the upper imaginary direction, write $W_0=A_0+iB_0$ and use $B_0+\arg(A_0+iB_0)=\arg p$. Here $A_0=\log R-\log\log R+O(1)$; the second term leaves a gap of order $1/\log R$ when $\eta$ is small. Conjugation gives the lower half-plane.

Deform the integral to the ray from zero to $1+ib$, followed by $u=x+ib$, $x\ge1$. The complete kernel is holomorphic in $|\Im u|<\pi/4$. For $\Re q>0$, its identity $\Phi'(u)=O(u)$ justifies the endpoint deformation. For the widened parameter region, write $g(u^2)=\sum_{m\ge0}a_mu^{2m}$ in a fixed disk and replace the initial segment ending at $z_0=\delta e^{i\arg(1+ib)}$ by its exact continuation

$$
\sum_{m\ge0}\frac{a_m z_0^{2(q+m)}}{q+m}.
\tag{9}
$$

This normally convergent series retains the cancellation at zero in the full theta sum. Its possible poles are $q=-m$, outside the large parameter region in use. In the near-vertical sector, the factor $e^{-2\arg(1+ib)\Im q}$ bounds both initial pieces by $e^{-cR+O(R/\log R)}$. Their theta factors cost at most a power of $\log R$. The saddle has logarithmic modulus bounded below by $-O(R\log\log R/\log R)$ there. In any fixed right sector, the initial pieces are $e^{O(R)}$, whereas the saddle's positive term $2\Re p\log|u_*|$ has order $R\log\log R$. Hence the initial pieces are negligible uniformly.

The horizontal contour admits a global bound. For $p=\sigma+i\tau$ in the upper half-plane, set

$$
E(x)=\Re\frac p{x+ib}=\frac{\sigma x+\tau b}{x^2+b^2},\qquad
H(x)=\Re S_p(x+ib).
$$

On $x\ge1$, $E$ decreases while positive. When $\sigma<0$, the small choice of $\eta$ ensures $E(a)>0$; after any zero, $E$ stays negative. Thus $E(x)\ge E(a)$ for $x\le a$ and $E(x)\le E(a)$ for $x\ge a$. The saddle identity then yields

$$
H(a+t)-H(a)\le-\Re y_*\bigl(e^{2t}-1-2t\bigr),\qquad a+t\ge1.
\tag{10}
$$

All theta terms are retained in the estimate

$$
\sum_{n\ge1}n^6\left|\frac{A(n^2y)}{A(y)}\right|
e^{-(n^2-1)\Re y}
\le C\bigl(1+(\Re y)^{-7/2}\bigr)\le C\log^{7/2}R.
\tag{11}
$$

Here the index $n$ runs over every positive integer. The bound follows from the Gaussian sum $\sum n^6e^{-n^2Y}$ and $|y|\ge\pi e^2$ on the horizontal contour. In a neighborhood of the saddle, (8) makes the $n\ge2$ contribution exponentially small.

Take $|u-u_*|\le\log^2R/\sqrt R$ along the horizontal line. The cubic error in $S_p$ is $O(\log^5R/\sqrt R)$. With $D=-S_p''(u_*)$, one has
$\Re D\ge cR/\log^2R$, $|D|\asymp R/\log R$. The ratio of the absolute Gaussian integral to the modulus of its complex integral is $O(\sqrt{\log R})$. Equations (10) and (11) control the complement. This proves the uniform formula

$$
B(p+1)=8\pi^3e^{S_p(u_*)}A(y_*)
\sqrt{\frac{2\pi}{D}}\,(1+\mathcal E(p)),\qquad
\mathcal E(p)=O(\log^6R/\sqrt R).
\tag{12}
$$

All factors and the remainder are analytic on a narrower widened region. The Gaussian branch is fixed by $\Re D>0$. Large points of the closed right half-plane admit Cauchy disks of radius $cR/\log R$ inside the outer region. In particular, (12) proves that $B(p+1)$ is nonzero throughout a sufficiently far-right half-plane.

## Differentiating the actual ratio

Absorb $A(y_*)=1+O(\log R/R)$ into the analytic remainder in (12). Implicit differentiation of (7) gives

$$
u_*'=\frac{u_*}{p(1+2u_*)+(13/2)u_*^2}=O(R^{-1}),
\qquad D'/D=O(R^{-1}).
$$

The phase derivative at the saddle is $2\log u_*$. Cauchy's estimate for the remainder therefore gives
$B(p)/B(p+1)=u_*(p)^{-2}(1+O(R^{-1}))$.
Integration by parts in (1), initially for $\Re p>0$, gives the exact identity

$$
\phi(s)=4p\frac{B(p)}{B(p+1)},\qquad p=s+\tfrac12.
$$

Writing $\ell=W_0(2p/\pi)$, it follows that

$$
\phi(s)=\frac{16p}{\ell^2}+\mathcal R(p),\qquad
\mathcal R=O(\log^{-2}R).
\tag{13}
$$

On the Cauchy disks just described,

$$
\mathcal R''=O(R^{-2}),\quad
\mathcal R'''=O(\log R/R^3),\quad
\mathcal R''''=O(\log^2R/R^4).
$$

For $P(p)=16p/\ell^2$, exact differentiation gives

$$
-P''(p)=\frac{32}{p}Q(\ell),\qquad
Q(\ell)=\frac{\ell^2-\ell-1}{\ell^2(1+\ell)^3},\qquad
\ell'=\frac{\ell}{p(1+\ell)}.
$$

Since $Q(\ell)=\ell^{-3}(1+O(\ell^{-1}))$, two further derivatives, together with the displayed bounds for $\mathcal R$, prove uniformly in a sufficiently far-right closed half-plane

$$
f(s)\sim\frac{32}{s(\log s)^3},\quad
f'(s)\sim-\frac{32}{s^2(\log s)^3},\quad
f''(s)\sim\frac{64}{s^3(\log s)^3},
$$

$$
j(s)\sim\frac{64}{s(\log s)^3},\qquad
j'(s)\sim-\frac{64}{s^2(\log s)^3}.
\tag{14}
$$

The symbol $\sim$ here denotes a uniform complex ratio limit. In particular the derivatives of both $f$ and $j$ have absolute bound $C/(|s|^2|\log s|^3)$. The same computation gives the real limits $\phi'(x)\sim16/\log^2x$ and $\phi'(\infty)=0$.

## Bromwich inversion and the small-jump limit

The following elementary inversion argument applies to either $F_*=f$ or $F_*=j$. Suppose its leading constant in (14) is $c$. For any sufficiently large fixed $\sigma$, define

$$
H_*(r)=\frac1{2\pi}\int_{\mathbb R}e^{(\sigma+it)r}F_*(\sigma+it)\,dt.
\tag{15}
$$

The integral is absolute because $1/(|t|\log^3|t|)$ is integrable at infinity. Contour rectangles prove line independence. Also
$\int_{\mathbb R}|F_*(\sigma+it)|dt=O(\log^{-2}\sigma)$ as $\sigma\to\infty$, so moving the line right proves $H_*(r)=0$ for $r\le0$. Fixed-line inversion gives continuity, exponential order and reality by conjugation symmetry. Cauchy's formula and Fubini give $\mathcal L H_*=F_*$ to the right of the chosen line. Fourier uniqueness supplies uniqueness in this class.

For $r>0$, move the line to $\sigma=1/r$, put $L=\log(1/r)$ and $t=y/r$, and set

$$
A_r(y)=\frac{L^3}{r}F_*\left(\frac{1+iy}{r}\right).
$$

On compact $y$ intervals, $A_r(y)\to c/(1+iy)$. Uniformly for small $r$,
$|A_r(y)|\le C/|1+iy|$ and $|A_r'(y)|\le C/|1+iy|^2$.
Integration by parts bounds each oscillatory tail beyond $|y|=Y$ by $C/Y$. Hence

$$
L^3H_*(r)=\frac e{2\pi}\int_{\mathbb R}e^{iy}A_r(y)\,dy
\longrightarrow c,
\tag{16}
$$

using $\int_{\mathbb R}e^{iy}/(1+iy)\,dy=2\pi/e$ in its oscillatory sense. Applying this to $f,j$ gives $h(r)\sim32/L^3$ and $w(r)\sim64/L^3$. The derivative bounds in (14) justify this passage; a real-axis asymptotic alone would not.

Extend $h,w$ by zero to the negative half-line. Laplace uniqueness for distributions applied to (2) gives
$w=3h-D(rh)$. Thus $D(rh)=3h-w$ is continuous, so $rh$ is continuously differentiable and

$$
rh(r)=\int_0^r(3h(t)-w(t))\,dt.
$$

This proves (3). Formula (16) now proves (4) and (5). The argument fixes $h$ by inversion; it does not introduce an undetermined term proportional to $r^2$.

## An exact shifted representation with a signed tail

For every sufficiently large $\sigma$ and $\Re s\ge0$, the same density satisfies

$$
\phi(\sigma+s)=\phi(\sigma)+
\int_0^\infty(1-e^{-sr})e^{-\sigma r}\pi(r)\,dr.
\tag{17}
$$

Indeed, integrate $f=\mathcal Lh$ once using $\phi'(\infty)=0$, and then integrate between $\sigma$ and $\sigma+s$. Near zero the required bound is (5); at infinity a sufficiently large exponential tilt ensures absolute convergence. The killing term is the exact positive number $\phi(\sigma)$, and the drift is zero.

The density $e^{-\sigma r}\pi(r)\mathbf1_{(0,r_0)}$ is positive and decreasing. The remaining signed measure $\eta_\sigma(dr)=e^{-\sigma r}\pi(r)\mathbf1_{[r_0,\infty)}dr$ has finite total variation. If $|h(r)|\le Me^{br}$, then for $\sigma>b$,

$$
\|\eta_\sigma\|_{\rm TV}
\le\frac{M e^{-(\sigma-b)r_0}}{(\sigma-b)r_0^2}.
\tag{18}
$$

This bounds its contribution to (17) by $\|\eta_\sigma\|_{\rm TV}$ for real $s\ge0$, and by twice that bound for $\Re s\ge0$. A positive tilt preserves every sign of $\pi$; a small bound on the signed remainder does not prove its positivity.

The [positive-mixture criterion](theta-positive-jump-mixture.md) identifies a single global sign that would complete the actual nonincreasing Lévy representation. That sign remains open.

## Classical context

Lambert-$W$ saddle asymptotics for theta coefficient integrals occur in Dan Romik's [*Orthogonal polynomial expansions for the Riemann xi function*](https://www.math.ucdavis.edu/~romik/data/uploads/papers/riemannxi-final.pdf), including Sections 2.4 and 5. The argument above supplies the complex widening and derivative estimates needed for this particular inverse transform. Bromwich inversion, contour deformation and Laplace uniqueness are classical. The Lévy representation and subordinator interpretation use the conventions of Schilling, Song and Vondraček, [*Bernstein Functions: Theory and Applications*](https://motapa.de/bernstein_functions/index.shtml), Chapters 3 and 5. The underlying theta-kernel attributions remain those recorded in the linked derivative-kernel and natural-exponent notes. No priority or formalization claim is made here.
