# Cosh-base universal-factor approximation obstruction

The actual Riemann theta kernel cannot be approximated, even locally in $L^1$ on the positive real axis, by kernels $e^{-a_j\cosh(b_ju)}B_j(u)$ with $a_j\ge0$, real $b_j$, and positive even Pólya universal factors $B_j$. All parameters may vary without bounds. The proof uses logarithmic concavity to control their possible escape, then Montel compactness and a theta boundary singularity.

This is a written building block using classical results. No priority, proof of RH, or Lean formalization is claimed.

## Statement and factor class

Let $\mathcal{LP}$ denote the Laguerre–Pólya class, the locally uniform limits of real polynomials with only real zeros. A nonzero even entire function $B$, nonnegative on $\mathbb R$ and satisfying $B(i\,\cdot)\in\mathcal{LP}$, has the product

$$
B(u)=Cu^{2m}e^{\alpha u^2}
\prod_\nu\left(1+\frac{u^2}{\lambda_\nu}\right),
\quad C>0,\quad m\in\mathbb Z_{\ge0},\quad \alpha\ge0,
\quad \lambda_\nu>0,\quad \sum_\nu\lambda_\nu^{-1}<\infty.
\tag{1}
$$

Finite and empty products are allowed. Pairing opposite real zeros in the canonical product for $B(iz)$ gives (1); evenness removes the remaining linear exponential. Nonnegativity fixes the sign of $C$. Strict positivity at zero forces $m=0$; allowing $m>0$ only enlarges the class. By Pólya's universal-factor characterization, (1) includes every positive even universal factor.

**Theorem.** Let

$$
F_j(u)=e^{-a_j\cosh(b_ju)}B_j(u),\qquad a_j\ge0,\quad b_j\in\mathbb R,
$$

where each $B_j$ has form (1). Suppose that $f:(0,\infty)\to(0,\infty)$ is continuous and

$$
\int_A^B|F_j(u)-f(u)|\,du\longrightarrow0
\quad\text{for every }0<A<B<\infty.
\tag{2}
$$

Then $f$ is the restriction of an entire function. No uniform bound on the displayed parameters or zero locations is assumed.

In particular, (2) is impossible for the actual theta kernel

$$
\Theta(t)=\sum_{n\in\mathbb Z}e^{-\pi n^2t},\qquad
\Phi(u)=e^{u/2}\bigl(2t^2\Theta''(t)+3t\Theta'(t)\bigr),
\quad t=e^{2u}.
\tag{3}
$$

Here $\Theta$ is initially defined for $\Re t>0$. On the real axis, $\Phi$ is even, positive and integrable; this is the normalization
$\Xi(x)=\int_{\mathbb R}\Phi(u)e^{ixu}\,du$. For $u>0$, its positivity follows term by term from

$$
\Phi(u)=\sum_{n\ge1}
\bigl(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2}\bigr)
 e^{-\pi n^2e^{2u}}.
$$

## Real curvature controls parameter escape

Define the entire function

$$
C_b(t)=\cosh(b\sqrt t)=\sum_{r\ge0}\frac{b^{2r}t^r}{(2r)!},
$$

using its power series, so no square-root branch is involved. For real $t>0$, put $h_j(t)=\log F_j(\sqrt t)$. Differentiating the convergent products gives

$$
-h_j''(t)=a_jC_{b_j}''(t)+\frac{m_j}{t^2}
       +\sum_\nu\frac1{(t+\lambda_{j,\nu})^2}\ge0.
\tag{4}
$$

The Gaussian coefficient contributes no curvature. Every term remaining in (4) has the same sign.

Condition (2), after $t=u^2$, implies local $L^1$ convergence of $F_j(\sqrt t)$ to the positive continuous function $f(\sqrt t)$. Concavity of $h_j$ then implies local uniform convergence to $h(t)=\log f(\sqrt t)$. For completeness, from any subsequence extract a further subsequence converging almost everywhere. Its logarithms converge at those points. Choose two such points bracketing a given compact interval, and a further point on each outer side. The inner chord bounds the concave functions below; the outer secant slopes bound them above. Applying these bounds on a larger interval bounds their slopes on the original interval. They are therefore locally bounded and equicontinuous. Their locally uniform subsequential limits agree almost everywhere, hence everywhere, with $h$. This argument for every subsequence proves the claimed convergence.

Derivatives at each fixed positive point lie between neighboring secant slopes. Thus $h_j(1)$ and $h_j'(1)$ are bounded, and $h_j'(A)-h_j'(B)$ is bounded for every fixed $0<A<B$. Integrating (4) on $[1,2]$ yields

$$
m_j+S_j\le2[h_j'(1)-h_j'(2)]\le C,
\qquad S_j=\sum_\nu(1+\lambda_{j,\nu})^{-2},
\tag{5}
$$

because $\int_1^2t^{-2}dt=1/2$ and
$\int_1^2(t+\lambda)^{-2}dt\ge[2(1+\lambda)^2]^{-1}$.
The coefficients of $C_b''$ are nonnegative for real $b$, so it is nondecreasing on $[0,\infty)$. Consequently, for each fixed $T\ge1$,

$$
a_jC_{b_j}''(T)
\le\int_T^{T+1}a_jC_{b_j}''(t)\,dt
\le h_j'(T)-h_j'(T+1)\le C_T.
\tag{6}
$$

These bounds follow from convergence; they are not extra assumptions on the parameters.

## Entire compactness from the centered product

For complex $u$, put $t=u^2$. Exact normalization at $t=1$ gives

$$
\begin{aligned}
F_j(u)={}&F_j(1)e^{h_j'(1)(t-1)}
 e^{-a_j[C_{b_j}(t)-C_{b_j}(1)-C_{b_j}'(1)(t-1)]}\\
&\times[t e^{-(t-1)}]^{m_j}
\prod_\nu\left[
\frac{t+\lambda_{j,\nu}}{1+\lambda_{j,\nu}}
 e^{-(t-1)/(1+\lambda_{j,\nu})}\right].
\tag{7}
\end{aligned}
$$

The normalized product converges locally uniformly. Its linear compensation is essential: the possibly unbounded sum $\sum_\nu(1+\lambda_{j,\nu})^{-1}$ is absorbed into $h_j'(1)$, along with the Gaussian and linear cosh terms.

For every complex $w$,

$$
|(1+w)e^{-w}|\le e^{|w|^2/2},
\tag{8}
$$

since $|1+w|^2=1+2\Re w+|w|^2\le e^{2\Re w+|w|^2}$. Applying this to $w=t-1$ and $w=(t-1)/(1+\lambda)$ bounds the second line of (7) by $\exp\{(m_j+S_j)|t-1|^2/2\}$.

Taylor's integral remainder and coefficient positivity also give

$$
|C_b(t)-C_b(1)-C_b'(1)(t-1)|
\le\tfrac12|t-1|^2 C_b''(\max(1,|t|)).
\tag{9}
$$

Indeed the straight segment from $1$ to $t$ stays in that disk, and $|C_b''(z)|\le C_b''(|z|)$. Thus, on $|u|\le R$, with $T_R=\max(1,R^2)$,

$$
|F_j(u)|\le F_j(1)\exp\!\left\{
|h_j'(1)|(R^2+1)
+\tfrac12(R^2+1)^2[m_j+S_j+a_jC_{b_j}''(T_R)]\right\}.
\tag{10}
$$

Equations (5)–(6) bound this uniformly in $j$. Montel's theorem supplies a subsequence converging locally uniformly on $\mathbb C$ to an entire function $F$. By (2), its positive real restriction equals $f$ almost everywhere; continuity gives equality everywhere. This proves the closure assertion, including all parameter escape. There is no division by $a_j$ or $b_j$, so zero values cause no exception.

## The theta kernel does not extend to an entire function

Formula (3) defines a holomorphic function in $|\Im u|<\pi/4$. The theta series and Jacobi's transformation give

$$
\Theta(t+2i)=\Theta(t),\qquad
\Theta(\varepsilon)=\varepsilon^{-1/2}\Theta(1/\varepsilon)
\quad(\varepsilon>0).
\tag{11}
$$

The latter identity and its differentiated series imply

$$
\begin{aligned}
\Theta'(\varepsilon)
 &= -\tfrac12\varepsilon^{-3/2}
    +O(\varepsilon^{-5/2}e^{-\pi/\varepsilon}),\\
\Theta''(\varepsilon)
 &= \tfrac34\varepsilon^{-5/2}
    +O(\varepsilon^{-9/2}e^{-\pi/\varepsilon}).
\end{aligned}
\tag{12}
$$

These are differentiated identities, not derivatives of an unspecified error: differentiate
$\varepsilon^{-1/2}(1+2\sum_{n\ge1}e^{-\pi n^2/\varepsilon})$ term by term. For each fixed nonnegative integer $j$, the remaining sums satisfy
$\sum_{n\ge1}n^{2j}e^{-\pi n^2/\varepsilon}=O_j(e^{-\pi/\varepsilon})$ as $\varepsilon\downarrow0$, which gives (12).

Take

$$
t_\varepsilon=2i+\varepsilon,\qquad
u_\varepsilon=\tfrac12\operatorname{Log}(2i+\varepsilon),\qquad
u_0=\tfrac12\log2+\tfrac{\pi i}{4}.
$$

The points $u_\varepsilon$ lie inside the strip and tend to $u_0$. Periodicity applies to both derivatives of $\Theta$. Substituting (12) into (3), using $t_\varepsilon^2=-4+O(\varepsilon)$, yields

$$
\Phi(u_\varepsilon)
=-6e^{u_0/2}\varepsilon^{-5/2}
 +O(\varepsilon^{-3/2}).
\tag{13}
$$

Thus $\Phi$ is unbounded along an interior path to the finite boundary point $u_0$. If an entire function agreed with $\Phi$ on $(0,\infty)$, the identity theorem would make it agree throughout the strip, contradicting (13). This proves the theta exclusion. $\square$

## Scope and sources

The theorem excludes local positive-axis $L^1$ approximation in the displayed cosh-base/universal-factor class, including unbounded base parameters and Gaussian degenerations. Global $L^1$ convergence, or convergence in a weighted $L^1$ norm with weight at least one, would imply the excluded local convergence.

It does **not** exclude arbitrary entire-kernel approximations or arbitrary approximants with only-real-zero Fourier transforms. A convolution of such kernels is not covered merely because its Fourier transform has only real zeros. The proof requires the specific product (1), nonnegative cosh amplitude, and real cosh parameter. It makes no assumption about the zeros of $\Xi$.

The classical inputs are Pólya's universal-factor theorem and the Laguerre–Pólya product, concave-function compactness, Jacobi's theta transformation, and Montel's theorem. The closure obstruction is their application; no assertion of originality is made.

- G. Pólya, [*Über trigonometrische Integrale mit nur reellen Nullstellen*](https://doi.org/10.1515/crll.1927.158.6), *Journal für die reine und angewandte Mathematik* **158** (1927), 6–18. For the precise modern formulation used here, see C. M. Newman and W. Wu, [*Constants of de Bruijn–Newman type in analytic number theory and statistical physics*](https://arxiv.org/abs/1901.06596), §2.2, Theorems 1–2. Their equation (7) gives the theta normalization (3).
- [DLMF 20.7.32](https://dlmf.nist.gov/20.7.E32), Jacobi's theta transformation; setting the argument to zero and the lattice parameter to $i\varepsilon$ gives the inversion in (11). Theta periodicity follows directly from its defining series.
- P. Montel, [*Sur les suites infinies de fonctions*](https://www.numdam.org/item/ASENS_1907_3_24__233_0/), *Annales scientifiques de l'École Normale Supérieure*, series 3, **24** (1907), 233–334. Equation (10) establishes the local boundedness needed for the normal-family theorem.
