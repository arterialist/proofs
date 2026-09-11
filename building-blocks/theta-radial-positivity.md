# Positivity of the actual theta radial weights

Every complete radial weight in the folded theta expansion below is strictly positive. The proof retains the lower endpoint and combines a classical Bessel product formula with Abel inversion and a differential identity. The arithmetic divisor coefficients remain signed, so this theorem does not establish positivity of the full Fourier transform or prove RH. No originality or Lean formalization claim is made.

## Normalization and statement

Use

$$
\xi(s)=\tfrac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s),\qquad
\Xi(z)=\xi(\tfrac12+iz)=\int_{\mathbb R}\Phi(u)e^{izu}\,du,
$$

$$
\Phi(u)=\sum_{n\ge1}
\left(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2}\right)
e^{-\pi n^2e^{2u}}.
\tag{1}
$$

The full kernel $\Phi$ is even. This is the convention in [Gasper, equations (1.1)–(1.2)](https://arxiv.org/pdf/0801.2996). For $y>0$, define

$$
\mathcal D_y(b)=\frac12\int_{\mathbb R}a\sinh(ya)
\Phi((a+b)/2)\Phi((a-b)/2)\,da.
$$

Its Fourier transform is $\partial_y|\Xi(x+iy)|^2$; see the [shifted Fourier identities](shifted-fourier-density.md). Folding the $a$ integral by evenness gives the exact expansion

$$
\widehat{\mathcal D_y}(x)=\sum_{k\ge1}D_k(x)W_y(k,x),\qquad
D_k(x)=\sum_{d\mid k}e^{ix\log(d^2/k)}.
\tag{2}
$$

Here the Fourier convention is $\widehat h(x)=\int h(b)e^{ixb}\,db$. Put $t_0=\pi k$ and $f(a)=a\sinh(ya)$. The radial weight is

$$
W_y(k,x)=8\pi^2k^2\int_0^\infty e^{5a/2}
\left[f''(a)-f'(a)+(1/4+x^2)f(a)\right]
K_{ix}(2\pi ke^a)\,da,
\tag{3}
$$

where $K_\nu$ denotes the modified Bessel function of the second kind.

**Theorem.** For every integer $k\ge1$, real $y>0$ and real $x$, one has $W_y(k,x)>0$. More precisely, define

$$
F_f(t)=t_0^{-5/2}t^{3/2}f(\log(t/t_0)),\qquad
\mu_f(c)=\frac c\pi\int_{t_0}^c\frac{F_f'(t)}{\sqrt{c^2-t^2}}\,dt,
\qquad v(c)=K_{ix/2}(c).
$$

Then $\mu_f(c)>0$ for $c>t_0$ and

$$
\boxed{W_y(k,x)=8\pi^2k^2\int_{t_0}^\infty\mu_f(c)
\left[2\bigl(c v'(c)+3v(c)\bigr)^2
 +(2c^2+x^2/2-9)v(c)^2\right]dc>0.}
\tag{4}
$$

## Identification of the radial weight

Write $q_n(u)$ for the $n$th summand of (1) and $A(u)=\sum_n|q_n(u)|$. Gaussian sum estimates give

$$
A(u)\le Ce^{-u/2}\quad(u\le0),\qquad
A(u)\le Ce^{9u/2-\pi e^{2u}}\quad(u\ge0).
$$

For $a\ge0$, these imply

$$
A((a+b)/2)A((a-b)/2)
\le C\exp\{9a/2+5|b|/2-\pi e^{a+|b|}\}.
$$

The right side remains integrable after multiplication by any polynomial in $a,b$ and any fixed exponential $e^{Ya+Z|b|}$. Thus the folded theta expansion, Fourier integration and the differentiations below are absolutely justified. Folding must precede expansion; no absolute convergence on the original negative $a$ half-line is asserted.

For a pair $n,m$, put $\eta=\pi^2n^2m^2$ and $\lambda=\pi n^2e^b+\pi m^2e^{-b}$. Its product in the folded integrand is

$$
q_n((a+b)/2)q_m((a-b)/2)
=4\eta e^{5a/2}\left(4\eta e^{2a}-6\lambda e^a+9\right)e^{-\lambda e^a}.
$$

Set $k=nm$, $h=b+\log(n/m)$ and $t=\pi ke^a$. Then $\lambda e^a=2t\cosh h$. The Bessel integral representation evaluates the Fourier integral in $h$ as

$$
H(t,x)=2(4t^2+9)K_{ix}(2t)+12t\partial_tK_{ix}(2t).
$$

Consequently

$$W_y(k,x)=4\pi^2k^2\int_0^\infty f(a)e^{5a/2}H(\pi ke^a,x)\,da.$$

The phase is $e^{-ix\log(n/m)}$. Pairing divisors replaces its sign without changing $D_k(x)$ in (2). With $D=t\partial_t$, the Bessel equation gives

$$H(t,x)=2\bigl((D+3)^2+x^2\bigr)K_{ix}(2t).$$

Two integrations by parts give (3). Their lower boundary terms vanish because $f(0)=f'(0)=0$; the upper terms vanish by Bessel decay. In particular, the polynomial terms in the original theta summands have not been discarded.

## Abel inversion and the square identity

The classical product formula [DLMF 10.32.17](https://dlmf.nist.gov/10.32.E17), with equal orders $ix/2$, gives

$$
K_{ix/2}(c)^2
=2\int_0^\infty K_{ix}(2c\cosh s)\,ds
=2\int_c^\infty\frac{K_{ix}(2t)}{\sqrt{t^2-c^2}}\,dt.
\tag{5}
$$

For a continuously differentiable function $F$ on $[t_0,\infty)$, the inverse of the Abel transform is

$$
\mu_F(c)=\frac c\pi\left[
\frac{F(t_0)}{\sqrt{c^2-t_0^2}}+
\int_{t_0}^c\frac{F'(t)}{\sqrt{c^2-t^2}}\,dt\right],
\qquad
F(t)=2\int_{t_0}^t\frac{\mu_F(c)}{\sqrt{t^2-c^2}}\,dc.
\tag{6}
$$

The substitutions $s=t^2$, $u=c^2$ reduce (6) to ordinary Abel inversion. Its composition constant is $B(1/2,1/2)=\pi$, including the displayed endpoint term. Equations (5) and (6) imply

$$
\int_{t_0}^\infty F(t)K_{ix}(2t)\,dt
=\int_{t_0}^\infty\mu_F(c)v(c)^2\,dc.
\tag{7}
$$

For the functions used here, all weights and their derivatives grow at most polynomially at infinity. Their endpoint singularities are integrable. Fubini follows by replacing $|K_{ix}|$ with $K_0$ and applying (5) at $x=0$.

Now put $g=(\partial_a-1/2)^2f$ and $F_g(t)=t_0^{-5/2}t^{3/2}g(\log(t/t_0))$. Since $F_f(t_0)=0$,

$$
\mu_f(c)=\frac c\pi\int_{t_0}^c
\frac{t_0^{-5/2}t^{1/2}\left[\tfrac32f(\log(t/t_0))+f'(\log(t/t_0))\right]}
{\sqrt{c^2-t^2}}\,dt>0.
\tag{8}
$$

Positivity follows from $f(a)>0$ and $f'(a)=\sinh(ya)+ya\cosh(ya)>0$ for $a>0$.

The exact differential relation is

$$F_g=(D-2)^2F_f.$$

To transfer it through the Abel transform, the lower endpoint matters. Writing $\varepsilon=c-t_0$, Taylor expansion in (8) gives

$$
\mu_f(c)=\frac{8y}{3\pi\sqrt2\,t_0^{5/2}}\varepsilon^{3/2}
+O(\varepsilon^{5/2}).
\tag{9}
$$

The expansion is differentiable through order two, as follows by setting $t=t_0+\varepsilon r$ in (8). Therefore $\mu_f$ and $D\mu_f$ vanish at $t_0$, while $D^2\mu_f=O(\varepsilon^{-1/2})$ is locally integrable. After the substitution $c=tv$ in (6), differentiation shows that the Abel transform commutes with $D$ when the density vanishes at $t_0$. Apply this first to $\mu_f$ and then to $D\mu_f$. Uniqueness of Abel inversion yields

$$\mu_g=(D-2)^2\mu_f.\tag{10}$$

The second derivative retains the nonzero endpoint contribution of $F_g$: its leading term is $\sqrt2\,y(\pi\sqrt{t_0})^{-1}\varepsilon^{-1/2}$, matching (6) with $F_g(t_0)=2y/t_0$.

Under integration against $dc$, the adjoint of $D$ is $-D-1$. Equations (9) and (10), together with exponential Bessel decay, justify two integrations by parts without boundary terms. Equation (7) applied to (3) now gives

$$
\frac{W_y(k,x)}{8\pi^2k^2}
=\int_{t_0}^\infty\mu_f(c)\bigl[(D+3)^2+x^2\bigr](v(c)^2)\,dc.
$$

The [Bessel equation](https://dlmf.nist.gov/10.25.E1) is $D^2v=(c^2-x^2/4)v$. Expanding the last integrand gives

$$
\bigl[(D+3)^2+x^2\bigr](v^2)
=2(Dv+3v)^2+(2c^2+x^2/2-9)v^2,
$$

which proves (4). The second coefficient is at least $2\pi^2-9>0$. The function $v$ is real and nontrivial, and $v,Dv$ cannot vanish simultaneously by uniqueness for its differential equation. Together with (8), this proves strict positivity.

## Use and precedent

The proof removes the radial sign question for the actual weights (3). It does not replace the coefficients $D_k(x)$ in (2) by positive numbers. For example, $D_3(x)=2\cos(x\log3)$ changes sign. Controlling the full signed sum remains necessary to establish positivity of $\partial_y|\Xi(x+iy)|^2$.

The Bessel product formula and Abel inversion are classical. DLMF attributes the product formulas to Watson, *A Treatise on the Theory of Bessel Functions*, pages 439–441, and Erdélyi et al., *Higher Transcendental Functions*, volume II, pages 97–98. A primary precedent for proving Fourier-modulus positivity through integrals of Bessel squares is [Gasper, *Using integrals of squares of certain real-valued special functions…*, §2, equations (2.6)–(2.11)](https://arxiv.org/pdf/0801.2996). Those formulas treat individual Bessel transforms; §3 discusses Pólya approximants. They do not supply positivity of the signed full-theta sum (2). The proof here uses the explicit relation $F_g=(D-2)^2F_f$ and retains the actual lower endpoint $\pi k$.
