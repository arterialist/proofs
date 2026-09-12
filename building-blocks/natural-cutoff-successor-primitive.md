# Positive successor primitives at every natural cutoff

For every integer N≥2, the actual natural source
$$
a_N(u)=e^{-u/2}E_N(e^u),\qquad
 E_N(x)=\psi(\min(x,N))-\min(x,N),\quad u\ge0,
$$
retains its frozen tail $(\psi(N)-N)e^{-u/2}$ beyond log N. Let
$C=S-a_0\delta$, $a_0(u)=e^{-u/2}1_{u\ge0}$, and write
$$
J_N(v)=\int_0^v(C-I)a_N(u)\,du,\qquad \delta_N=\delta(a_N).
$$
Then
$$
\boxed{J_N(0)=0,\qquad J_N(v)>0\quad(N\ge2,\ v>0).}
$$
The proof uses the [full-source finite estimate](actual-source-successor-primitive.md), one published unconditional PNT bound, and a finite Arb interval certificate for N=2,…,22. It is not a Lean formalization. All prime powers and both parts of the natural source are retained.

## Exact identities

Put $\ell=\log2$, $\sigma(v)=\log(e^v+1)$, and
$k_+(u)=(1-e^{-u})^{-1/2}-1$. Since $a_N=-e^{u/2}$ on the initial strip $[0,\ell)$, the same cumulative change of variables as for the full source gives, for every v≥0,
$$
J_N(v)=2\delta_Ne^{-v/2}
 +\int_v^{\sigma(v)}a_N(u)\,du
 -\int_{\sigma(v)}^\infty k_+(u)a_N(u)\,du. \tag{1}
$$
The identity at v=0 uses the full initial-strip contribution to δ_N; it is not a positive-branch replacement of that charge.

Define
$$
d(x)=\arcsin(x^{-1/2})-x^{-1/2},\quad
 T(x)=\int_x^\infty d(y)dy
 =2\sqrt x-\sqrt{x-1}-x\arcsin(x^{-1/2}),\quad x\ge2.
$$
The exact charge is
$$
\delta_N=\sum_{2\le n\le N}\Lambda(n)d(n)+T(N). \tag{2}
$$
For $F_N(x)=J_N(\log x)$, equation (1) becomes
$$
F_N(x)-\frac{2\delta_N}{\sqrt x}
 =\int_x^{x+1}E_N(y)y^{-3/2}dy
 -\int_{x+1}^\infty E_N(y)
 \left(\frac1{y\sqrt{y-1}}-y^{-3/2}\right)dy. \tag{3}
$$
Consequently, if $|E_N(y)|\le\epsilon y$ for every y≥x,
$$
\left|F_N(x)-\frac{2\delta_N}{\sqrt x}\right|
 \le4\epsilon(\sqrt{x+1}-\sqrt x)
 <\frac{2\epsilon}{\sqrt x}. \tag{4}
$$
The two positive majorant integrals each equal
$2(\sqrt{x+1}-\sqrt x)$.

Beyond the natural cutoff, (3) has the exact elementary form
$$
\boxed{F_N(x)=\frac{2\delta_N}{\sqrt x}
 +2(\psi(N)-N)\left[x^{-1/2}-\arctan(x^{-1/2})\right],\quad x\ge N.} \tag{5}
$$
In particular the tail tends to zero, and no artificial hard truncation occurs.

## All N≥23

The published input is [Trudgian, *Updating the error term in the prime number theorem*, Theorem 1](https://arxiv.org/pdf/1401.2689). It gives
$$
|\psi(y)-y|\le y\epsilon_0(y),\quad y\ge23,
\quad \epsilon_0(y)=\sqrt{\frac8{17\pi}}z^{1/2}e^{-z},\quad
 z=\sqrt{\frac{\log y}{6.455}}.
$$
This error function decreases for y≥23. Write ε=ε_0(23), so ε<0.162.

Let κ be the full-source charge. Stieltjes integration by parts, with the atom at N included in the finite sum, gives
$$
\delta_N-\kappa=E(N)d(N)+\int_N^\infty E(t)d'(t)dt,
 \quad E(t)=\psi(t)-t.
$$
Therefore
$$
|\delta_N-\kappa|\le\epsilon\left[2Nd(N)+T(N)\right]. \tag{6}
$$
The bracket decreases. Its derivative is $d(N)+2Nd'(N)<0$, since
$$
d(N)=\int_0^{N^{-1/2}}[(1-z^2)^{-1/2}-1]dz
 <N^{-1/2}[(1-N^{-1})^{-1/2}-1].
$$
Using the already established $0.2789<\kappa<0.279$, the accompanying Arb certificate verifies
$$
\epsilon[46d(23)+T(23)]<0.022672,
 \qquad \boxed{1/4<\delta_N<0.303\quad(N\ge23).} \tag{7}
$$

If x≥23 and N≥23, then for all y≥x,
$$
|E_N(y)|=|E(\min(y,N))|\le\epsilon\min(y,N)\le\epsilon y.
$$
Equations (4) and (7) imply
$$
\boxed{F_N(x)>\frac{0.17}{\sqrt x},\quad x\ge23,\ N\ge23.} \tag{8}
$$

For 1≤x≤23, reuse the full-source cell computation from [the actual-source primitive theorem](actual-source-successor-primitive.md) and its same-stem certificate. It proved that the full-source lower function $F_{0.279}$, obtained by replacing only κ by 0.279, is greater than 1/25 on [2,23]. For N≥24, the source agrees throughout every interval entering the cumulative primitive on this range. For N=23 it also agrees up to x=22; in the last cell 22<x≤23, its successor term increases by the nonnegative density
$$
\frac{x+1-23}{\sqrt x(x+1)}.
$$
Here there is no prime-power arrival in (23,24). Thus, in both cases,
$$
F_N(x)\ge F_{0.279}(x)
 -2(\delta_N-0.279)(1-x^{-1/2}).
$$
Since
$$
0.048(1-23^{-1/2})<1/25,
$$
this proves positivity on [2,23]. On the first cell 1<x≤2 the derivative numerator is
$x\log2-\delta_N(x+1)$; it is positive because
$\log2-2(0.303)>0$ and its slope is positive. The function starts at zero. This completes every N≥23 without repeating the full-source enumeration.

## The finite remainder 2≤N≤22

The reproducible calculation is [natural-cutoff-successor-primitive.py](certificates/natural-cutoff-successor-primitive.py). It uses Arb balls at 192 bits. Formula (2) evaluates each exact δ_N from logarithms, square roots, and arcsines, with no infinite numerical tail.

For an ordinary cell n<x<n+1 with n<N−1,
$$
F_N'(x)=\frac{x\Lambda(n+1)-\psi(n)-\delta_N(x+1)}{x^{3/2}(x+1)}. \tag{9}
$$
Its numerator is affine, so only endpoints or its single negative-to-positive zero can minimize the function. An exact increment is
$$
F_N(b)-F_N(a)=2\psi(n+1)(\arctan\sqrt b-\arctan\sqrt a)
 +2(\psi(n)+\delta_N)(b^{-1/2}-a^{-1/2}). \tag{10}
$$
In the last cell n=N−1 the numerator in (9) has the additional term $x(x+1-N)$. It is the increasing quadratic
$$
x^2+x(\Lambda(N)-N+1-\delta_N)-\psi(N-1)-\delta_N.
$$
Its derivative is positive throughout the cell. The increment in (10) receives the exact correction
$$
2(\sqrt b-\sqrt a)-2N(\arctan\sqrt b-\arctan\sqrt a). \tag{11}
$$
The certificate checks the first-cell derivative is positive, all later cell endpoints are positive, and every interior minimum is positive. Quadratic roots in the last cell are evaluated with Arb enclosures. Thus it proves F_N(x)>0 for 1<x≤N for each of these 21 cutoffs.

Finally, $0<z-\arctan z<z^3/3$ for z>0. The certificate checks δ_N>0 and
$$
\delta_N+\frac{\psi(N)-N}{3N}>0.09
$$
for every N=2,…,22. If ψ(N)−N≥0, (5) is positive directly. If it is negative, the preceding strict bound and x≥N prove positivity from (5). This proves all ages for every finite remaining cutoff. The smallest displayed sufficient tail coefficient is at N=2 and exceeds 0.09408.

## Distributional monotone-test consequence

For the full source, and also for every natural cutoff N≥2, let J denote the corresponding primitive. It is positive on (0,∞), vanishes at zero, and tends to zero at infinity. For every smooth bounded increasing real test φ on [0,∞],
$$
\langle (C-I)a,\phi\rangle=-\int_0^\infty J(v)\phi'(v)dv\le0, \tag{12}
$$
with the same statement for a_N. This follows first on finite intervals and then by the vanishing boundary term. The right side is absolutely convergent because J is bounded and φ has finite total variation. It also defines the pairing distributionally when this is the chosen formulation. The inequality is strict whenever φ increases somewhere in (0,∞). This is a monotone-test sign for the specified compensated transport. It is not a pointwise sign for its derivative, and does not assert a Weil or anticausal sign.
