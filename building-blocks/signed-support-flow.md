# Pole-preserving support flow and its logarithmic continuity modulus

This note gives an exact parametrization and support derivative for the pole-null Weil form. The actual first-prime term prevents a uniform scalar relative differential bound, while finite support changes have a sharp logarithmic continuity modulus. These are statements about a propagation mechanism, not a positivity proof or an RH conclusion. No novelty or Lean-formalization claim is made.

## The form and its complete smooth core

Use zero extension to $\mathbb R$ and the conventions

```math
\widehat f(t)=\int_{\mathbb R}f(x)e^{-itx}\,dx,
\qquad C_f(v)=\int_{\mathbb R}f(x+v)\overline{f(x)}\,dx.
```

For functions supported in $[-B,B]$, with $\int f(x)e^{x/2}dx=\int f(x)e^{-x/2}dx=0$, the form is

```math
q[f]=\frac1{2\pi}\int_{\mathbb R}h(t)|\widehat f(t)|^2dt
-2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}\Re C_f(\log n),
\quad h(t)=\Re\psi_\Gamma(1/4+it/2)-\log\pi.             \tag{1}
```

Here $\psi_\Gamma$ is the digamma function. Every prime power is retained. Terms with $\log n\ge2B$ vanish, including equality. The form domain is the supported $L^2$ functions with $\int\log(2+|t|)|\widehat f(t)|^2dt<\infty$ and the two stated moments. The formula $A-J$ also defines a Hermitian polarization on compact smooth functions without moment restrictions; the identification with the pole-null Weil expression is made only with those restrictions. For the explicit-formula background, see [Suzuki, *Aspects of the screw function corresponding to the Riemann zeta-function*](https://arxiv.org/html/2206.03682v4).

Put $a=1/2$, $L=\partial_x^2-a^2$, $U_Bg(x)=B^{-1/2}g(x/B)$ and $T_Bg=LU_Bg$. Then

```math
T_B:C_c^\infty(-1,1)\longrightarrow
\left\{f\in C_c^\infty(-B,B):\int f e^{ax}=\int f e^{-ax}=0\right\}
```

is a bijection. Indeed integration by parts gives the zero boundary expression $[e^{\pm ax}(u'\mp au)]_{-B}^B$ for $f=Lu$. Conversely

```math
u(x)=-\frac1{2a}\int_{\mathbb R}e^{-a|x-y|}f(y)\,dy       \tag{2}
```

solves $Lu=f$. To the right of the support it equals $-e^{-ax}(2a)^{-1}\int e^{ay}f(y)dy=0$, and the left formula uses the other moment. Thus $u$ is compact smooth with the same support hull, and $g=U_B^{-1}u$ is allowed. Uniqueness follows from the nonvanishing Fourier multiplier $-(t^2+a^2)$. This is the elementary Green function of $\partial_x^2-a^2$, used with both boundary moments.

Writing $r_B=B^{-2}g''-a^2g$, one has

```math
f_B=T_Bg=U_Br_B,\qquad
\widehat f_B(t)=-(t^2+a^2)\sqrt B\,\widehat g(Bt),
```

```math
C_{f_B}(v)=\left[B^{-4}C_g^{(4)}-2a^2B^{-2}C_g''+a^4C_g\right](v/B). \tag{3}
```

## Exact support and divisor flux

A dot denotes $\partial_{\log B}$. Let $\mathcal G=x\partial_x+1/2$ and $R=\partial_x^2L^{-1}$, whose Fourier multiplier is $t^2/(t^2+a^2)$. Equation (2) makes $Rf$ compactly supported on the pole-null core, although $Rf$ need not itself be pole-null. The commutator $[L,\mathcal G]=2\partial_x^2$ gives

```math
\dot f_B=-\mathcal G f_B-2Rf_B.
```

Consequently the exact Ward identity is

```math
\boxed{\dot q[f_B]=
-\frac1{2\pi}\int t h'(t)|\widehat f_B(t)|^2dt
+2\sum_{n\ge2}\frac{\Lambda(n)\log n}{\sqrt n}\Re C_{f_B}'(\log n)
-4\Re q(Rf_B,f_B).}                                  \tag{4}
```

For pure dilation, $\dot C(v)=-vC'(v)$, fixing the plus sign in the prime term. The remaining $-2Rf_B$ gives the last polarized term. For a fixed compact smooth $g$, its correlations are flat at their support endpoints. Thus prime powers entering the support contribute no extra jump terms; the arithmetic sum is locally finite in $B$.

The digamma series gives

```math
t h'(t)=\sum_{k\ge0}\frac{2(k+1/4)(t/2)^2}{((k+1/4)^2+(t/2)^2)^2}\ge0. \tag{5}
```

The complete archimedean form can also be written

```math
A[f]=h(0)\|f\|_2^2+
\int_0^\infty\frac{2e^{-v/2}}{1-e^{-2v}}
(\|f\|_2^2-\Re C_f(v))\,dv.
```

The diagonal and correlation terms must remain together near zero. This formula retains the archimedean tail even where $C_f$ vanishes.

Multiplication of an arithmetic function by $\log n$ is a derivation of Dirichlet convolution. Differentiating $\Lambda=\mu*\log$ and $\mu*\mathbf1=\delta_1$ gives the classical Selberg identity

```math
\Lambda(n)\log n=(\mu*\log^2)(n)-(\Lambda*\Lambda)(n). \tag{6}
```

Thus (4) has exactly this difference as its arithmetic coefficient. At $n=p^j$ the two coefficients are $(2j-1)\log^2p$ and $(j-1)\log^2p$; at $n=pq$ with distinct primes they are equal and cancel. No divisor term may be discarded. See [Selberg's 1949 paper](https://www.math.lsu.edu/~mahlburg/teaching/handouts/2014-7230/Selberg-ElemPNT1949.pdf) and the [finite formalization](prime-filter-selberg-identities.md).

## The actual first prime excludes scalar differential propagation

Choose a smooth real bump $b\in C_c^\infty(-1,1)$ positive exactly on $(-0.9,0.9)$ and zero outside $[-0.9,0.9]$, for example $b(y)=\exp[-1/(0.81-y^2)]$ inside that interval. Let $g_\kappa(y)=e^{i\kappa y}b(y)$. Fix

```math
\frac{\log2}{1.8}<B_0<\frac{\log3}{1.8},\qquad
w_0=\log2/B_0,\quad N_0=\int b^2,\quad E_b(w)=\int b(y+w)b(y)\,dy.
```

Only the prime $2$ contributes near $B_0$, and $E_b(w_0)>0$. Expanding the differential operator in (3), locally uniformly in $B$, gives

```math
\|T_Bg_\kappa\|_2^2=B^{-4}\kappa^4N_0(1+O(\kappa^{-2})),
```

```math
\frac{C_{T_Bg_\kappa}(v)}{\|T_Bg_\kappa\|_2^2}
=e^{i\kappa v/B}\left(\frac{E_b(v/B)}{N_0}
-\frac{4iE_b'(v/B)}{\kappa N_0}+O(\kappa^{-2})\right). \tag{7}
```

These expressions are finite polynomials in $\kappa$ times smooth overlap integrals before normalization; their differentiated remainder is $O(\kappa^{-1})$. The [digamma asymptotic](https://dlmf.nist.gov/5.11.E2), $h(t)=\log(|t|/(2\pi))+O(t^{-2})$, and the Schwartz decay of $\widehat b$ give normalized archimedean energy $\log(\kappa/(2\pi B))+O(\kappa^{-1})$, with logarithmic $B$ derivative $-1+O(\kappa^{-1})$. Splitting the translated Fourier integral into frequencies near $\kappa$ and its Schwartz tail justifies differentiating this estimate.

Take $\kappa_j=B_0(\pi/2+2\pi j)/\log2$. For $\mathcal E_B=q[T_Bg]/\|T_Bg\|_2^2$, equation (7) yields

```math
\mathcal E_{B_0}(g_{\kappa_j})=\log\kappa_j+O(1)>0,
```

```math
\left.\partial_{\log B}\mathcal E_B(g_{\kappa_j})\right|_{B_0}
=-\frac{2\log2\,w_0E_b(w_0)}{\sqrt2N_0}\kappa_j+O(1). \tag{8}
```

Also $\partial_{\log B}\log\|T_Bg_\kappa\|_2^2=-4+O(\kappa^{-2})$. Therefore $\dot q[T_Bg]/q[T_Bg]$ is unbounded below at each such $B_0$. No finite scalar $k(B_0)$ independent of $g$ can give $\dot q[T_Bg]\ge-k(B_0)q[T_Bg]$ on the complete smooth pole-null core. This does not exclude positivity of the form; it excludes this differential method of propagating it.

## A sharp finite-step replacement

Fix $0<B_-\le B,C\le B_+$ and use the common finite prime-power list $n\le e^{2B_+}$. For supported $s$, put $H_B[s]=q[U_Bs]$, where $A-J$ is evaluated even without moment constraints. Then

```math
H_B[s]=\frac1{2\pi}\int\left[h(u/B)-2\sum_{n\le e^{2B_+}}
\frac{\Lambda(n)}{\sqrt n}\cos(u\log n/B)\right]|\widehat s(u)|^2du.
```

Translations beyond the actual smaller support vanish after integration. Define

```math
\|s\|_{\log}^2=\frac1{2\pi}\int\log(2+|u|)|\widehat s(u)|^2du,
\quad S=\sum_{n\le e^{2B_+}}\frac{\Lambda(n)}{\sqrt n},
\quad v_* =\max_{\substack{n\le e^{2B_+}\\\Lambda(n)>0}}\log n.
```

If the list is empty its contribution is zero. Otherwise, for $0<\epsilon=v_*|B^{-1}-C^{-1}|<1$, set

```math
\omega(\epsilon)=\max\left\{\frac{\sqrt\epsilon}{\log2},
\frac2{\log(2+\epsilon^{-1/2})}\right\}.
```

Then

```math
|H_B[s]-H_C[s]|
\le4|\log(B/C)|\|s\|_2^2+2S\omega(\epsilon)\|s\|_{\log}^2. \tag{9}
```

Indeed, the cosine difference is at most $\min(2,\epsilon|u|)$. Divide by $\log(2+|u|)$ and split at $|u|=\epsilon^{-1/2}$. For the other term, (5) gives $th'(t)<4$: its $k=0$ summand is at most $2$; for $k\ge1$, the nonnegative unimodal function $2ay^2/(a^2+y^2)^2$ has integral at most $1$ on $a\ge5/4$ and supremum at most $2/5$. Comparing its unit-spaced sum with the integral incurs at most its total variation, $4/5$. Integration in $\log B$ proves the archimedean part of (9).

The order $1/\log(1/\epsilon)$ is sharp. In the first-prime interval above, set $\alpha=\log2/B_0$, $u_j=2\pi j/\alpha$ and choose $C_j$ with $\log2/C_j=\alpha+\pi/u_j$. For $s_j(y)=e^{iu_jy}b(y)$,

```math
|J[U_{B_0}s_j]-J[U_{C_j}s_j]|
=\frac{2\log2}{\sqrt2}\{E_b(\alpha)+E_b(\alpha+\pi/u_j)\}
\longrightarrow\frac{4\log2}{\sqrt2}E_b(\alpha)>0,
```

while $\|s_j\|_{\log}^2=N_0\log u_j+O(1)$. Here $\epsilon\asymp1/u_j$, and the archimedean difference is $O(1/u_j)$. Hence no uniform $o(1/\log(1/\epsilon))$ modulus holds for $H_B-H_C$ in this norm.

Finally the exact pole-preserving family is recovered, without changing its parametrization, by

```math
q[T_Bg]=H_B[r_B],\qquad r_B=B^{-2}g''-a^2g,
```

```math
q[T_Bg]-q[T_Cg]=(H_B-H_C)[r_B]
+2\Re H_C(r_B-r_C,r_C)+H_C[r_B-r_C].                  \tag{10}
```

The last terms are continuous in the logarithmic form norm and $r_B-r_C=(B^{-2}-C^{-2})g''$. Equations (9)–(10) permit finite-step estimates with explicit margins, but do not supply those margins uniformly through all supports. They preserve the exact arithmetic phases that the failed scalar differential estimate would suppress.
