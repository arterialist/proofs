# An obstruction to reversing damping of the compensated Weil form

This note separates the full Weil distribution from its pole-subtracted version. They agree on admissible correlations before damping and disagree afterward. For the actual pole-subtracted distribution, downward preservation of positivity is false. These are written analytic proofs using classical digamma, Euler-product and Poisson-kernel identities; no novelty claim is made for those methods.

For $f\in C_c^\infty(\mathbb R)$ put $C_f(v)=\int f(u+v)\overline{f(u)}du$, with Fourier convention $\widehat f(t)=\int f(u)e^{-itu}du$. Admissibility means $\int f(u)e^{u/2}du=\int f(u)e^{-u/2}du=0$.

Let $q(v)=e^{-v/2}/(1-e^{-2v})$, $h_0=\psi_\Gamma(1/4)-\log\pi$, and define

```math
K[g]=h_0g(0)+\int_0^\infty q(v)(2g(0)-g(v)-g(-v))dv
-\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}(g(\log n)+g(-\log n)).
```

The full distribution is $W=K+P$, where $P(v)=2\cosh(v/2)$. For admissible $f$, $P[C_f]=0$ by the two moment conditions.

For $\sigma\ge0$, define $Q^K_\sigma(f)=K[e^{-\sigma|v|}C_f(v)]$ and likewise $Q^W_\sigma$. The displayed formula defines these even though the multiplier has a cusp: its subtracted numerator is $O(v)$ near zero and $q(v)\sim1/(2v)$. Compact support makes the prime sum finite. Dominated convergence gives $Q^K_\sigma(f),Q^W_\sigma(f)\to K[C_f]$ as $\sigma\downarrow0$ for each admissible test.

## Exact multipliers and an actual failure

For $\sigma>1/2$ write $s=1/2+\sigma+it$. The digamma integral and absolutely convergent prime-power series give

```math
Q^K_\sigma(f)=\frac1{2\pi}\int H_\sigma(t)|\widehat f(t)|^2dt,
\qquad H_\sigma(t)=\Re\psi_\Gamma(s/2)-\log\pi
+2\Re\frac{\zeta'(s)}{\zeta(s)}.
```

For $\sigma\ge10$, the digamma integral gives $\Re\psi_\Gamma(a+ib)\ge\psi_\Gamma(a)$ for $a>0$. Monotonicity of the real digamma function and $\psi_\Gamma(a)>\log a-1/a$ then give

```math
H_\sigma(t)>
\log\frac{21}{4\pi}-\frac4{21}-\frac5{1024}>0.30.
```

Here $2\sum_{n\ge2}\Lambda(n)n^{-1/2-\sigma}\le2\sum_{n\ge2}n^{-9}\le5/1024$. Thus the damped form is uniformly positive on every compact smooth test at this damping.

At $\sigma=1$, however,

```math
H_1(0)=\psi_\Gamma(3/4)-\log\pi+
2\zeta'(3/2)/\zeta(3/2)<0.
```

Every term has the stated sign: $\psi_\Gamma(3/4)<\psi_\Gamma(1)=-\gamma$, and the logarithmic zeta derivative is negative on the real axis above 1.

Choose nonzero real $b\in C_c^\infty$ and set $g_R(u)=R^{-1/2}b(u/R)$, $f_R=g_R''-g_R/4$. Integration by parts proves both exact pole moments vanish. Since

```math
\widehat f_R(t)=-(t^2+1/4)\sqrt R\,\widehat b(Rt),
```

scaling and Schwartz decay yield

```math
\frac{Q^K_1(f_R)}{\|f_R\|^2}\longrightarrow H_1(0)<0.
```

The multiplier grows only logarithmically, so dominated convergence is justified. Fixing any sufficiently large finite $R$ gives an admissible compact smooth test that is positive at damping 10 and negative at damping 1. This disproves the proposed downward positivity implication for the actual compensated family. It does not assert negativity at damping zero.

## Keeping the poles gives a different statement

For $\sigma>1/2$, the damped pole term has strictly positive Fourier multiplier

```math
r_\sigma(t)=\frac{2(\sigma-1/2)}{(\sigma-1/2)^2+t^2}
+\frac{2(\sigma+1/2)}{(\sigma+1/2)^2+t^2}.
```

It is positive on every nonzero test, including admissible tests. The original vanishing moments do not remove it after damping. For $\xi(s)=\tfrac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)$, the full multiplier is

```math
G_\sigma(t)=H_\sigma(t)+r_\sigma(t)=2\Re\xi'(s)/\xi(s).
```

The classical product gives

```math
\Re\frac{\xi'(s)}{\xi(s)}=
\sum_{\rho=\beta+i\gamma}
\frac{\Re s-\beta}{(\Re s-\beta)^2+(\Im s-\gamma)^2}.
```

The real-part sum converges absolutely. Its constant vanishes by reflection at $s=1/2$. Since unconditionally $0<\beta<1$, every summand is positive when $\Re s>1$. Thus $Q^W_\sigma\ge0$ for $\sigma>1/2$, and fixed-test continuity includes $\sigma=1/2$. This is the familiar logarithmic-derivative positivity discussed by [Lagarias](https://websites.umich.edu/~lagarias/doc/positivity.pdf), not a proof at damping zero.

## Direction of the positive semigroup

In the strong-damping region, multiplication by $e^{-\delta|v|}$ corresponds to convolution with the positive Poisson kernel $p_\delta(t)=\delta/[\pi(\delta^2+t^2)]$. Therefore

```math
H_{\sigma+\delta}=p_\delta*H_\sigma,
\qquad G_{\sigma+\delta}=p_\delta*G_\sigma.
```

The positive operation moves toward larger damping. Its inverse is not positivity preserving: the would-be positive-type kernel $e^{\delta|v|}$ has the two-point matrix with diagonal 1 and off-diagonal $e^{\delta L}>1$, whose determinant is negative.

This generic obstruction does not show the full actual family is negative below $1/2$. A special theorem for that family remains unproved. The actual counterexample above concerns the pole-subtracted family and keeps every prime power and the complete archimedean term. For normalization and the explicit-formula setting, see [Connes–Consani](https://arxiv.org/html/2006.13771) and the [digamma integral](https://dlmf.nist.gov/5.9.E16).
