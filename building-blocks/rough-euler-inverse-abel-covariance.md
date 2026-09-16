# Rough Euler inversion does not order the Abel energies

Keep the notation $M$, $F_y$, and $Z_N$ from
[the log-squared cutoff note](log-squared-smooth-transport-boundary.md).
Define $r_y(d)=1$ when every prime factor of $d$ exceeds $y$, including
$d=1$, and $r_y(d)=0$ otherwise. Euler products give the exact arithmetic
identity

$$
\mu(n)\mathbf1_{P^+(n)\le y}=(\mu*r_y)(n),
\qquad
F_y(m)=\sum_{\substack{d\le m\\P^-(d)>y}}
 M(\lfloor m/d\rfloor).\tag{1}
$$

All coefficients of $r_y$ are nonnegative, and all rough prime powers
are included. Nevertheless, the Abel inner products between the dilates
in (1) have both signs for the actual Möbius source. With
$\rho=e^{-2/N}$ and $M_d(m)=M(\lfloor m/d\rfloor)$, direct finite
evaluation gives

$$
\begin{aligned}
N=5,\ d=3:&\quad
\langle M,M_3\rangle_N
  =(1-\rho)(-\rho^3-\rho^4-2\rho^5)<0,\\
N=97,\ d=97:&\quad
\langle M,M_{97}\rangle_N=(1-\rho)\rho^{97}>0.
\end{aligned}\tag{2}
$$

Both $d$ are rough at their moving cutoffs $y=(\log N)^2$. Thus
positivity of the inverse coefficients is not positivity or orthogonality
of their *prefixes*.

There is a quantitative cancellation load. The Abel prefix Gram kernel
is $K_N(a,b)=\rho^{\max(a,b)}-\rho^{N+1}$. In the full-minus-smooth
energy at $y=(\log N)^2$, the diagonal contribution of rough squarefree
labels is

$$
\begin{aligned}
\mathcal D_N(y)
 &=\sum_{\substack{n\le N\\\mu(n)^2=1\\P^+(n)>y}}
   (\rho^n-\rho^{N+1})\\
 &=\left[\frac3{\pi^2}(1-3e^{-2})+o(1)\right]N
  =(0.180552571152\ldots+o(1))N.\tag{3}
\end{aligned}
$$

The proof uses the standard squarefree count
$\sum_{n\le x}\mu(n)^2=6x/\pi^2+O(\sqrt x)$ and partial summation.
Only $N^{1/2+o(1)}$ squarefree labels are smooth at this cutoff, so
removing them changes the diagonal by $o(N)$. If the complete transport
$T_N(y)=Z_N(M)-Z_N(F_y)$ is eventually nonpositive, its rough–rough
and rough–smooth *off-diagonal* terms must therefore total at most
$-(0.180552571152\ldots+o(1))N$. Equation (3) is a necessary
correlation budget, not a proof that the budget is met.

For comparison, the Dirichlet-Hardy coefficient norm for $\sigma>1/2$
has the opposite exact order:

$$
\sum_{n\ge1}\frac{\mu(n)^2}{n^{2\sigma}}
=\prod_p(1+p^{-2\sigma})
>\prod_{p\le y}(1+p^{-2\sigma})
=\sum_{n\ge1}\frac{\mu(n)^2\mathbf1_{P^+(n)\le y}}{n^{2\sigma}}.
$$

The rough inverse also has no pointwise modulus order on vertical lines.
For each $\sigma>1$, the absolutely convergent product
$R_y(s)=\prod_{p>y}(1-p^{-s})^{-1}$ has
$\lvert R_y(\sigma)\rvert>1$, while
$\lvert R_y(\sigma+it)\rvert<1$ for some real $t$. Indeed
$\log\lvert R_y(\sigma+it)\rvert$ has vertical mean zero, positive
mean square, and a positive value at $t=0$; its Fourier expansion
converges absolutely. Neither coefficient-space orthogonality nor an
Euler-product modulus bound can supply the signed Abel covariance.

This is a written no-go for those specific positivity certificates.
It leaves the actual off-diagonal estimate, and RH, open.
