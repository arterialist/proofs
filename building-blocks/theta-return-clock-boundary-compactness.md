# Boundary decay and compactness for the actual return clock

For every fixed $0<z<1/2$, choose the actual core $C=[-R,R]$ sufficiently large for the exterior killing estimate in [the clock-domain proof](theta-return-clock-domain-bound.md). Put $O=\mathbb R\setminus C$,

$$
D(u)=2\cosh(u/2),\quad d\nu=D\Phi\,du,\quad
u_z=(L_O-z)^{-1}1_O,\quad g_z=1_C+B^*u_z.
$$

The full continuous kernel and every prime-power atom are retained. This written proof applies the primary boundary theorem below to the exact theta equation. No result in this chapter is formalized in Lean. This note proves

$$
u_z(R+y)=O_{R,z}\!\left(\frac1{\sqrt{\log(1/y)}}\right),\qquad
g_z(R-d)=O_{R,z}\!\left(\sqrt{\log(1/d)}\right),
\tag{1}
$$

with the corresponding bounds at the left endpoint. It follows that

$$
\boxed{D(E_C)\hookrightarrow L^2(C,g_z\,d\nu)
\text{ is compact when }D(E_C)\text{ has its form norm}.}
\tag{2}
$$

The constants depend on the fixed $z,R$. Bounds for the resolvent and clock are understood almost everywhere; the boundary theorem supplies a continuous representative for the resolvent near either endpoint. No lower boundary asymptotic, uniform limit as $z\uparrow1/2$, or sharp spectral gap is asserted.

## The primary boundary theorem

We use Hernández-Santamaría–López Ríos–Saldaña, [*Optimal boundary regularity and a Hopf-type lemma for Dirichlet problems involving the logarithmic Laplacian*, Theorem 1.1](https://arxiv.org/html/2401.18033v2). For a bounded domain satisfying a uniform exterior sphere condition, a bounded weak solution in $\mathbb H(\Omega)$ of the zero-exterior Dirichlet problem for the multiplier $2\log|\xi|$, with bounded forcing, is bounded at the boundary by a constant times $\ell(\operatorname{dist}(x,\partial\Omega))^{1/2}$. Here $\ell(t)=|\log(\min(t,0.1))|^{-1}$. Their definition (1.15) requires zero exterior values and finiteness of the local squared-difference integral with kernel $|x-y|^{-1}$ in dimension one. No sign of the forcing or coercivity of the Dirichlet operator is a hypothesis of this theorem.

## The exact physical equation

Extend $u_z$ by zero on $C$, and write this extension as $h$. The established hard-boundary operator decomposition gives
$h\in D(L)$, with
$Lh=1+zu_z$ on $O$. The exterior killing argument gives

$$
0\le u_z\le\frac{2}{1/2-z}.
\tag{3}
$$

Set $f=\Phi h$. Then $f$ is bounded, integrable, square-integrable, zero on $C$, and theta-decaying at both infinite ends. The exact closed form-domain identification in [the regularity sequel, (16.1)](theta-jump-eigenfunction-regularity.md) gives

$$
f\in H^{\log/2}(\mathbb R),\qquad
\int\log(2+|\xi|)|\widehat f(\xi)|^2d\xi<\infty.
\tag{4}
$$

Let $A$ have Fourier multiplier
$a(\xi)=\operatorname{Re}\psi(1/4+i\xi/2)-\log\pi$, and keep the complete prime operator

$$
(Sf)(u)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [f(u+\log n)+f(u-\log n)].
$$

The actual ground-state identity, polarized against compact tests, is
$Af-Sf=D(Lh-h/2)$. Therefore, as a distribution on $O$,

$$
\boxed{Af=Sf+D\,[1+(z-1/2)u_z].}
\tag{5}
$$

The right side is locally bounded, including on either exterior side of a finite boundary. Indeed (3) bounds $u_z$, and
$|Sf|\le \|u_z\|_\infty S\Phi$. The complete series for $S\Phi$ is bounded on every fixed compact interval by theta decay and the elementary bound $\Lambda(n)\le\log n$. This retains all prime powers; no differentiability of $u_z$ is used to bound that sum.

## Localization gives the precise Dirichlet problem required by the theorem

Choose $0<a<\min(R,0.1)$ and $\chi\in C_c^\infty((R-a,R+a))$, with $0\le\chi\le1$ and $\chi=1$ near $R$. Put

$$
\Omega=(R,R+a),\qquad F=\chi f.
$$

Then $F$ is bounded and zero outside $\Omega$: to the left it vanishes because $f=0$ on $C$, and at the other endpoint it vanishes because of the cutoff. Multiplication by $\chi$ preserves (4). This follows directly by expanding translation differences; the term involving $\Delta\chi$ has an extra factor $\min(1,|a|)$, and hence finite local logarithmic energy.

For an $L^2$ function, the translation integral

$$
\iint_{|x-y|\le1}\frac{|F(x)-F(y)|^2}{|x-y|}\,dx\,dy
$$

has Fourier multiplier comparable, after addition of the $L^2$ norm, to $\log(2+|\xi|)$. Thus (4) and the support condition prove exactly $F\in\mathbb H(\Omega)$ in the primary theorem's convention.

The commutator with the physical archimedean operator is bounded without any boundary regularity assumption on $f$. Its compensated integral representation gives

$$
[A,\chi]f(u)=\int_{\mathbb R}r(|v-u|)
 [\chi(u)-\chi(v)]f(v)\,dv,
\quad r(t)=\frac{e^{-t/2}}{1-e^{-2t}}.
\tag{6}
$$

Consequently

$$
\|[A,\chi]f\|_\infty
\le\|f\|_\infty\int_{\mathbb R}r(|a|)
 \min(\|\chi'\|_\infty|a|,2\|\chi\|_\infty)\,da<\infty.
\tag{7}
$$

The small-jump singularity is canceled by the Lipschitz difference, and the large-jump kernel is integrable. Formula (6) holds distributionally by truncation and Fubini; it does not require a pointwise untruncated value of $Af$.

To match the logarithmic Laplacian exactly, define

$$
q(\xi)=a(\xi)-\log|\xi|+\log(2\pi).
$$

The digamma expansion [DLMF 5.11.2](https://dlmf.nist.gov/5.11.E2) gives
$q(\xi)=O(|\xi|^{-2})$ at infinity. Near zero $a$ is bounded and $\log|\xi|$ is integrable, so $q\in L^1(\mathbb R)$. Define
$$
k(x)=\frac1{2\pi}\int q(\xi)e^{i\xi x}\,d\xi,
\qquad \|k\|_\infty\le\frac{\|q\|_1}{2\pi}.
$$
With this convention the multiplier $q$ acts on $F$ as $k*F$. Because $F\in L^1$, that convolution is bounded. The exact distributional identity is

$$
\boxed{L_\Delta F=2AF+2\log(2\pi)F-2k*F.}
\tag{8}
$$

Combining (5)–(8), the forcing on $\Omega$ is

$$
2\chi\{Sf+D[1+(z-1/2)u_z]\}
 +2[A,\chi]f+2\log(2\pi)F-2k*F,
\tag{9}
$$

and belongs to $L^\infty(\Omega)$. The distributional equality is the primary theorem's weak equality against $C_c^\infty(\Omega)$: for $F\in\mathbb H(\Omega)$, the logarithmic Fourier distribution agrees with its stated Dirichlet bilinear form. The low-frequency logarithm is integrable here, and the high-frequency pairing is controlled by (4).

The domain is a bounded interval and therefore satisfies the uniform exterior sphere condition. We have now verified the weak space, exterior condition, boundedness of the solution, and bounded forcing required by Theorem 1.1. It gives a continuous representative of $F$, with
$F(R+y)=O(\ell(y)^{1/2})$. Since $\chi=1$ there and $\Phi$ has a positive lower bound near the fixed point $R$, division by $\Phi$ proves the first bound in (1). The same localization at $-R$ proves the other boundary estimate.

## The return clock grows only as the square root of the boundary logarithm

At the right core endpoint write $v=R-d$. The only possibly unbounded contribution to $B^*u_z(v)$ is its nearby continuous crossing integral

$$
\frac1{D(R-d)}\int_0^a
 \Phi(R+y)r(d+y)u_z(R+y)\,dy.
\tag{10}
$$

The preceding boundary estimate bounds (10) by

$$
C_{R,z}\int_0^a\frac{dy}{(d+y)\sqrt{\log(1/y)}}.
$$

For $0<d<a$, its part below $d$ is at most $1/\sqrt{\log(1/d)}$. The rest is bounded by

$$
\int_d^a\frac{dy}{y\sqrt{\log(1/y)}}
=2\left(\sqrt{\log(1/d)}-\sqrt{\log(1/a)}\right).
\tag{11}
$$

The remaining continuous lengths are bounded uniformly for $v$ near this endpoint. All prime crossings are bounded by $\|u_z\|_\infty$ times the full prime departure rate, which is bounded on the compact core. Thus no atomic contribution creates another boundary singularity. This proves the second bound in (1), and likewise at the left endpoint. Away from the two endpoints, $g_z$ is bounded by the original estimate $g_z\le1+\|u_z\|_\infty\kappa_C$.

The exact continuous killing asymptotic from the clock-domain proof is

$$
\kappa_C(R-d)=\frac{\Phi(R)}{2D(R)}\log(1/d)+O_R(1),
\tag{12}
$$

and the leading coefficient is positive. Consequently, for all sufficiently small $\eta>0$,

$$
\boxed{
\int_{\operatorname{dist}(u,\partial C)<\eta}
 g_z(u)|x(u)|^2\,d\nu(u)
\le\frac{C_{R,z}}{\sqrt{\log(1/\eta)}}\,E_C[x]
\qquad(x\in D(E_C)).
}
\tag{13}
$$

Indeed $g_z/\kappa_C\le C_{R,z}/\sqrt{\log(1/\eta)}$ throughout these collars, and the killed core form includes the entire nonnegative cost $\int\kappa_C|x|^2d\nu$. This retains the actual boundary killing coefficient rather than replacing it by an assumed Hardy inequality.

## Compactness in the changed clock space

Let $x_n$ be bounded in the original killed core form norm. The established local logarithmic compactness on the fixed core supplies a subsequence converging in $L^2(C,d\nu)$. On the interior $\{\operatorname{dist}(u,\partial C)\ge\eta\}$, the weight $g_z$ is bounded, so this subsequence is Cauchy in the weighted norm there. On the collars apply (13) to $x_n-x_m$; its energy is uniformly bounded, and the right side tends to zero uniformly in $n,m$ as $\eta\downarrow0$. Combining the interior and collar estimates proves (2).

For clarity, the input here is the compactness of the original fixed-core embedding into $L^2(\nu_C)$. It follows from the actual logarithmic Fourier form and the positivity and smoothness of the theta weights on that compact interval. The new conclusion is compactness in the stronger clock norm; it does not follow merely from the previously known continuous clock bound.

Let $\mathsf N_z$ be the duration-weighted return measure and let

$$
e_z[x]=s_0[x]+\frac z2\iint|x(u)-x(v)|^2\,
 \mathsf N_z(du,dv).
$$

This is the positive jump form with the direct core measure plus the complete $\Sigma_z$ return measure. The [return comparison](theta-killed-core-return-comparison.md) and the clock-domain bound identify its domain with $D(E_C)$, and its form norm in $L^2(g_z\nu_C)$ is equivalent to the original killed core form norm. Explicitly, positivity of $N_z$ gives
$$
0\le e_{N_z}[x]\le(\kappa_*-z)^{-1}E_C[x],
$$
while $s_0=E_C-\langle\Sigma_0x,x\rangle$ differs from $E_C$ by a bounded form. These estimates, together with
$\|x\|_\nu^2\le\|x\|_{g_z\nu}^2
\le\|x\|_\nu^2+(\kappa_*-z)^{-1}E_C[x]$, give the two norm comparisons. The positive jump expression is Markovian; its domain is dense in the clock Hilbert space, since it contains the smooth tests compactly supported inside the core.

It follows from (2) that the selfadjoint generator of $e_z$ in $L^2(g_z\nu_C)$ has compact resolvent. Constants form its zero eigenspace; the direct continuous core kernel rules out any other zero-energy functions. This is a fixed-core, fixed-$z$ conclusion. It does not bound its first positive eigenvalue below by $z$, and supplies no uniform compactness as the core expands toward the threshold. Both pole constraints and the signed Schur comparison remain exactly those of the complete return construction.
