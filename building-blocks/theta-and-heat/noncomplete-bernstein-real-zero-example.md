# A real-zero Bessel example outside the complete Bernstein class

A Bernstein function with a positive decreasing Lévy density can produce an entire characteristic function with only real zeros even when its reciprocal coefficient interpolant has nonreal zeros. The following explicit example separates these requirements.

Write $B_J$ for the Bernstein functions whose Lévy measure has a nonnegative nonincreasing density, as in Konstantopoulos–Patie–Sarkar, equation (5.4). Put

```math
C=\frac{11!}{244},\qquad
F(s)=C\frac{(s+1)((s+10)^2+1)}{\Gamma(s+11)},
```

```math
\phi(s)=\frac{F(s)}{F(s+1)}
=\frac{(s+11)(s+1)((s+10)^2+1)}{(s+2)((s+11)^2+1)},
\qquad \Psi(s)=s\phi(s).
```

Then $F(1)=1$, $\phi\in B_J$ but $\phi$ is not complete Bernstein, and $F$ has nonreal zeros. Nevertheless

```math
\mathcal J_\Psi(z)=\sum_{n=0}^{\infty}
\frac{(-1)^nz^{2n}}{\prod_{j=1}^n\Psi(j)}
```

is a characteristic function in the Laguerre–Pólya class. The empty product is one. In the notation of Konstantopoulos–Patie–Sarkar, $\mathcal J_\Psi\in D_P\cap D_L$.

## The Lévy density

Partial fractions give

```math
\phi(s)=s+8-\frac{585}{82(s+2)}
+\frac{93(s+11)+181}{82((s+11)^2+1)}.
```

Equivalently,

```math
\phi(s)=\frac{1111}{244}+s+
\int_0^\infty(1-e^{-sr})k(r)\,dr,
\qquad
k(r)=\frac{585e^{-2r}-e^{-11r}(93\cos r+181\sin r)}{82}.
```

The derivative is

```math
k'(r)=\frac{-1170e^{-2r}+e^{-11r}(842\cos r+2084\sin r)}{82}.
```

For $r\ge0$, use $\cos r\le1$, $\sin r\le r$, and

```math
\frac{d}{dr}\left[e^{-9r}(842+2084r)\right]
=e^{-9r}(-5494-18756r)<0.
```

It follows that $k'(r)<0$. Since $k(r)\to0$, also $k(r)>0$. Exponential decay proves the Lévy integrability condition, so $\phi\in B_J$. With $\mu(dr)=-k'(r)\,dr$, integration by parts gives

```math
\Psi(s)=\frac{1111}{244}s+s^2+
\int_0^\infty(e^{-sr}-1+sr)\mu(dr).
```

Thus $\Psi$ is a spectrally negative Lévy exponent with Gaussian variance $2$, no killing, positive mean, and largest nonnegative zero $0$. It lies in the class $N_D$ of [Konstantopoulos–Patie–Sarkar, §4 and Proposition 5.2](https://www.numdam.org/item/10.5802/aif.3600.pdf).

The poles $-11\pm i$ of $\phi$ are genuine. A complete Bernstein function is holomorphic on $\mathbb C\setminus(-\infty,0]$, so $\phi$ is not complete Bernstein. Likewise $F$ has genuine zeros at $-10\pm i$ and is not Laguerre–Pólya. This uses the standard analytic characterization of complete Bernstein functions in Schilling–Song–Vondraček, *Bernstein Functions*, Theorem 6.2.

## The coefficient identity

Let

```math
g(x)=\sum_{n=0}^{\infty}\frac{(-x)^n}{n!\Gamma(n+12)},
\qquad D=x\frac{d}{dx}.
```

Telescoping the factors $\phi(j)=F(j)/F(j+1)$ gives

```math
\mathcal J_\Psi(z)=H(z^2),\qquad
H(x)=C(D+2)((D+11)^2+1)g(x).
```

The equation $xg''+12g'+g=0$ implies

```math
D^2g=-11Dg-xg,\qquad D^3g=(121-x)Dg+10xg.
```

Expanding the cubic differential operator therefore yields the exact reduction

```math
H(x)=C\big[(23-x)Dg(x)+(244-14x)g(x)\big].
```

## The zeros

The function $g(x)=x^{-11/2}J_{11}(2\sqrt{x})$, interpreted by its entire series, has the classical product

```math
g(x)=\frac1{11!}\prod_{j=1}^{\infty}\left(1-\frac{x}{\lambda_j}\right),
\qquad \lambda_j=\frac{j_{11,j}^2}{4}>0,
\qquad \sum_j\lambda_j^{-1}<\infty.
```

The Bessel zero and product statements are [DLMF §10.21(i), equation 10.21.15](https://dlmf.nist.gov/10.21). Their reality can also be seen directly. If $g(x)=0$, then $v(t)=g(xt^2)$ satisfies

```math
(t^{23}v')'+4x t^{23}v=0,\qquad v(1)=0,\quad v(0)=1/11!.
```

Integration against $\overline v$ gives

```math
4x\int_0^1t^{23}|v|^2\,dt
=\int_0^1t^{23}|v'|^2\,dt>0,
```

so $x>0$. The coefficient bound $|g(x)|\le e^{2\sqrt{|x|}}/11!$ gives order at most $1/2$ and hence a genus-zero Hadamard product. For nonreal $x$ this product implies

```math
\operatorname{Im}\frac{Dg(x)}{g(x)}
=-\operatorname{Im}x\sum_j\frac{\lambda_j}{|\lambda_j-x|^2}.
```

A nonreal zero of $H$ would instead require

```math
\frac{Dg(x)}{g(x)}=\frac{14x-244}{23-x}
=-14+\frac{78}{23-x}.
```

Its right side has imaginary part $78\operatorname{Im}x/|23-x|^2$, the opposite sign. This is impossible. No nonreal point was lost through division, because the zeros of $g$ and the exceptional point $23$ are real.

For real $x\le0$, every term in

```math
H(x)=C\sum_{n=0}^{\infty}
\frac{(n+2)((n+11)^2+1)(-x)^n}{n!\Gamma(n+12)}
```

is nonnegative and its constant term is one. Thus every zero of $H$ is positive, and every zero of $H(z^2)$ is real. Multiplication of the coefficients by a cubic polynomial preserves order at most $1/2$ in $x$. Consequently $H(z^2)$ is a real entire function of order at most one with only real zeros, and Hadamard factorization places it in the Laguerre–Pólya class. Finally, the characteristic-function assertion follows from [Konstantopoulos–Patie–Sarkar, Theorem 4.1](https://www.numdam.org/item/10.5802/aif.3600.pdf).

The Lévy representation, Bessel product, and logarithmic-derivative sign argument are established methods. This is an explicit specialization separating complete Bernstein structure from real-zero output. It concerns an auxiliary function, not the actual Riemann xi function; it establishes no membership result for the latter and makes no priority claim.
