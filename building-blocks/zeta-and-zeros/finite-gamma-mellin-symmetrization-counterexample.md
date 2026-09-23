# A finite gamma approximation with an off-line Mellin zero

Biane, Pitman and Yor identify the completed zeta function with the Mellin transform of a positive random variable. Let $G_j$ be independent gamma variables of shape $2$ and unit rate, and put

$$
T_N=\frac1\pi\sum_{j=1}^{N}\frac{G_j}{j^2},\qquad
M_N(s)=\mathbb E[T_N^s],\qquad
F_N(s)=M_N(s)+M_N(\tfrac12-s).
$$

For each finite $N$, $M_N$ is defined at least on $\Re s>-2N$, and $F_N$ is holomorphic on $-2N<\Re s<2N+\tfrac12$. The finite function satisfies $F_N(s)=F_N(\tfrac12-s)$. The limiting law $T=\lim_NT_N$ satisfies $\mathbb E[T^s]=2\xi(2s)$, so $F_N\to4\xi(2s)$ locally uniformly on the complex plane, interpreted on the expanding domains of the $F_N$. For a compact set with $-A\le\Re s\le B$, choose $m>A/2$; then for $N\ge m$, $|T_N^s|\le T^B+T_m^{-A}$, an integrable bound that justifies locally uniform convergence. The infinite-law identity is from [Biane–Pitman–Yor, §2.2 and (6)–(8)](https://arxiv.org/html/math/9912170); they also discuss approximations from partial gamma sums in §5. This note makes no priority claim for the finite approximation.

A tempting route would be to prove that every $F_N$ has all its zeros on $\Re s=\tfrac14$, then pass to the limit. That finite statement is false. The attached interval certificate proves that $F_{128}$ has a zero in the disk of radius $10^{-20}$ around

$$
s_0=0.28697936359458129186726727883478092687107342745132051469284157211
+34453.494087897740158977956570756121584446430646858921341269243062\,i.
$$

The disk lies strictly to the right of $\Re s=\tfrac14$. This is a zero of a **finite approximation**, not a zero of $\xi$ or $\zeta$. The example rules out the proposed finite-line-zero implication; it gives no unconditional zeta zero bound.

## Exact finite formula

Set

$$
r_{N,j}=\frac{(N!)^2}{(N-j)!(N+j)!},\qquad
c_{N,j}=-2j^2\sum_{\substack{1\le k\le N\\k\ne j}}\frac1{k^2-j^2},
$$

and

$$
Q_N(s)=\sum_{j=1}^{N}r_{N,j}^2j^{-2s}(s+1+c_{N,j}).
$$

The Laplace transform of $T_N$ is

$$
\mathbb E[e^{-zT_N}]
 =\prod_{j=1}^{N}\left(1+\frac{z}{\pi j^2}\right)^{-2}.
$$

Partial fractions at the double poles $z=-\pi j^2$, followed by termwise Mellin integration first in $\Re s>-1$, give

$$
M_N(s)=4\Gamma(s+1)\pi^{-s}Q_N(s).
$$

Both sides then continue to the larger half-plane $\Re s>-2N$. The partial-fraction expression has removable singularities at some negative integers. The coefficient $r_{N,j}$ follows by cancelling the factors $k^2-j^2$ in the product, while differentiation at the pole gives $c_{N,j}$. As a basic normalization check, this formula yields $M_N(0)=1$ and $M_N(1)=2\pi^{-1}\sum_{j\le N}j^{-2}$.

Near $s_0$, divide $F_N(s)$ by the nonzero factor $4\Gamma(s+1)\pi^{-s}$. The resulting analytic function is

$$
H_N(s)=Q_N(s)+
 \frac{\Gamma(\tfrac32-s)}{\Gamma(1+s)}
 \pi^{2s-\tfrac12}Q_N(\tfrac12-s).
$$

The certificate evaluates $H_{128}$, its first derivative at $s_0$, and its second derivative on the radius $10^{-20}$ disk using Arb complex interval arithmetic at 320-bit precision. It obtains

$$
|H_{128}(s_0)|<2.50\times10^{-56},\qquad
|H'_{128}(s_0)|>64712,\qquad
\sup_{|s-s_0|\le10^{-20}}|H''_{128}(s)|<653307.
$$

Hence

$$
|H_{128}(s_0)|+\tfrac12(653307)(10^{-20})^2
 <64712\cdot10^{-20}.
$$

Rouché's theorem against the nonconstant linear Taylor polynomial gives exactly one zero in the disk.

Run the certificate from the repository root with:

```sh
uv run --with python-flint==0.9.0 python certificates/finite_gamma_symmetrization_offline.py
```

The symmetrization has a positive reciprocal density: if $f_N$ is the density of $T_N$, then $g_N(x)=f_N(x)+x^{-5/2}f_N(1/x)>0$ and $g_N(1/x)=x^{5/2}g_N(x)$. The original $f_N$ is an additive Pólya-frequency convolution, but this argument does **not** establish that $g_N$ remains Pólya-frequency. Thus positive density and exact reciprocal symmetry alone are insufficient; this example does not settle a theorem that additionally assumes additive total positivity of the symmetrized density.
