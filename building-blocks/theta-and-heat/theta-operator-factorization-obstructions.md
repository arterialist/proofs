# Restrictions on factorizations of the theta coefficient multiplier

Let $I$ be the positive theta mixing law defined in [the Bessel factorization note](theta-bessel-factorization-obstructions.md), and write

```math
m_n=\mathbb E I^n,\qquad \lambda_n=m_n/n!,\qquad
L(z)=F(z+1)=\frac{\mathbb E I^z}{\Gamma(z+1)}.
```

The last expression initially defines $L$ on $\Re z>-1$. Its entire continuation, and a nonreal zero of $F$, are established in [the theta Mellin obstruction](theta-mellin-bernstein-obstruction.md). That zero concerns this auxiliary function, not the zeros of the Riemann xi function.

We exclude a specified sufficient construction of a real-root preserver. General multiplier sequences and general Bernstein classes are not excluded.

## The evaluation class

Consider normalized Laguerre–Pólya functions with strictly negative zeros:

```math
G(z)=e^{bz-az^2}\prod_j(1+z/r_j)e^{-z/r_j},
\qquad a\ge0,\ b\in\mathbb R,\ r_j>0,\quad
\sum_jr_j^{-2}<\infty.                                      \tag{1}
```

Finite products correspond to compositions of positive dilations, Euler factors $1+x\partial_x/r_j$, and diagonal Gaussian factors $x^n\mapsto e^{-an^2}x^n$. Evaluation of (1) at nonnegative integers gives a multiplier sequence by the classical Laguerre evaluation theorem; see [Craven–Csordas, Theorem 2.4(3)](https://math.hawaii.edu/~tom/mathfiles/wright-l.pdf).

**Theorem.** No function (1) satisfies $G(n)=\lambda_n$ for all $n\ge0$. Nor can a sequence of functions (1), normalized by $G(0)=1$, converge to these samples at every nonnegative integer. Thus the actual diagonal operator is not a coefficientwise limit of the stated Euler–Gaussian compositions.

## Moment growth

For large $u>0$, the complete theta kernel obeys

```math
c e^{9u/2-\pi e^{2u}}\le\Phi(u)\le C e^{9u/2-\pi e^{2u}}.
```

Put $M(2n)=2\int_0^\infty u^{2n}\Phi(u)\,du$. Split the upper bound at $u_0=\tfrac12\log n$. Beyond $u_0$, the logarithmic derivative of $u^{2n}e^{9u/2-\pi e^{2u}}$ is at most $-\pi n$ for sufficiently large $n$. The portion below $u_0$ is bounded by a constant times $u_0^{2n}$. For a lower bound, integrate over $[u_n,u_n+1]$, where $u_n=\tfrac12\log n-\log\log n$: the theta exponential costs $e^{-o(n)}$ there. Hence

```math
M(2n)^{1/n}\sim\frac{(\log n)^2}{4},\qquad
m_n^{1/n}\sim\frac{(\log n)^2}{16}.
```

The second relation uses the exact beta-moment formula from the companion note. Stirling's formula gives

```math
\ell_n:=\log\lambda_n
=-n\log n+2n\log\log n+(1-\log16)n+o(n),
\qquad 2\ell_n-\ell_{2n}=2n\log2+o(n).                 \tag{2}
```

## Uniqueness from the actual samples

For $t\ge0$,

```math
\frac12\log(1+t^2)\le2\{2\log(1+t)-\log(1+2t)\},       \tag{3}
```

because

```math
(1+t)^8-(1+t^2)(1+2t)^4
=3t^2+16t^3+30t^4+24t^5+12t^6+8t^7+t^8\ge0.
```

Applied to (1), including its Gaussian factor, this yields

```math
\log|G(iy)|\le2\{2\log G(y)-\log G(2y)\}\quad(y\ge0).  \tag{4}
```

If the samples were $\lambda_n$, (2) would bound (4) at integer $y=n$ by $(4\log2)n+o(n)$. The product shows that $|G(iy)|$ is nondecreasing in $y\ge0$, so rounding upward extends the bound to real $y$. Directly from each canonical factor,

```math
|G(x+iy)|\le G(x)|G(iy)|\qquad(x\ge0).                 \tag{5}
```

The logarithm of $G(x)$ is concave on this axis. Since $G(n)\to0$, it has a negative secant slope somewhere and is bounded above thereafter. Equations (4)–(5) therefore bound $G$ on the closed right half-plane by $C_\varepsilon e^{(4\log2+\varepsilon)|y|}$.

The actual interpolant has a separate bound. Set $C=\mathbb E e^I<\infty$. The tail-moment formula gives $m_x\le C\Gamma(x+1)$ for $x\ge0$. The gamma product gives

```math
\frac{\Gamma(x+1)}{|\Gamma(x+1+iy)|}
=\prod_{k\ge0}\left(1+\frac{y^2}{(x+1+k)^2}\right)^{1/2}
\le\left(\frac{\sinh(\pi|y|)}{\pi|y|}\right)^{1/2}
\le e^{\pi|y|/2}.
```

Since $|\mathbb E I^{x+iy}|\le m_x$, we have $|L(x+iy)|\le Ce^{\pi|y|/2}$. Carlson's uniqueness theorem on the right half-plane, with type strictly below $\pi$, now implies $G=L$ from their nonnegative-integer samples. See [Pila, opening statement of Carlson's theorem](https://people.maths.ox.ac.uk/pila/carlson.pdf). Entire continuation would then put every zero of $F$ on the real axis, contrary to the cited nonreal zero. This proves the first assertion without treating sample agreement alone as analytic continuation.

## Limits of preserving factors

Suppose $G_m(n)\to\lambda_n$ for every fixed $n\ge0$. The positive limits at $n=1,2$ bound

```math
D_m=2\log G_m(1)-\log G_m(2)
=2a_m+\sum_j\log\left(1+\frac1{r_{mj}(r_{mj}+2)}\right). \tag{6}
```

Every summand is nonnegative. Thus $a_m$ is bounded, all $r_{mj}$ stay uniformly away from zero, and $\sum_jr_{mj}^{-2}$ is bounded. The last assertion follows because the summand in (6) is comparable to $r^{-2}$ on $r\ge r_0>0$. Since

```math
\log G_m(1)=b_m-a_m+\sum_j\{\log(1+1/r_{mj})-1/r_{mj}\},
```

$b_m$ is bounded too. These bounds imply local boundedness of the canonical products on the entire plane. Montel's theorem supplies a locally uniform subsequential limit $G$. Closure of the Laguerre–Pólya class and Hurwitz's theorem, together with $G(0)=1$, put it back in (1). Its integer samples are $\lambda_n$, contradicting the first assertion. The same argument applies whether each original product is finite or infinite.

## Scope and two elementary distinctions

The algebraic factorization $T=B\circ A_I$, where $B[x^n]=x^n/n!$ and $A_Ip(x)=\mathbb E p(Ix)$, does not separate into two preserving factors: $A_I(1+x)^2=1+2m_1x+m_2x^2$ has discriminant $-4\operatorname{Var}(I)<0$.

Equation (2) also excludes any fixed finite gamma-quotient formula with factors $\Gamma(\alpha n+\beta)$, fixed $\alpha>0$ and real $\beta$, multiplied by finitely many nonzero Euler polynomial factors, a positive geometric factor and $e^{-an^2}$. If its values are eventually positive, its logarithm has the form $-an^2+C_1n\log n+C_2n+O(\log n)$, which cannot produce $2n\log\log n$. Infinite products and unrestricted affine gamma arguments are outside this conclusion.

The distinction from arbitrary multiplier sequences matters: $\gamma_n=n^2+n+1$ is a multiplier sequence, since its exponential generating function is $e^z(z+1)^2$, although its polynomial interpolation has nonreal zeros.

The classical antecedents include the Pólya–Schur and Laguerre evaluation theorems and Carlson uniqueness. [Craven–Csordas, §4, Theorems 4.14–4.15](https://math.hawaii.edu/~tom/mathfiles/czdssurvey.pdf) give related converses for complex-zero-decreasing sampled sequences under global exponential-type and imaginary-indicator restrictions. Those global hypotheses are not asserted for the actual $F$ here; the proof above supplies the required right-half-plane bound directly. [Csordas, *Complex Zero Decreasing Sequences and the Riemann Hypothesis II* (2003)](https://doi.org/10.1007/978-1-4757-3741-7_9) studies precisely growth restrictions that permit inference from sampled values to an interpolating function, including theta Mellin functions. Its complete theorem-by-theorem relation to this argument has not been established here. No mathematical novelty or first-formalization claim is made. These exclusions do not settle preservation by the actual operator or the Riemann hypothesis.
