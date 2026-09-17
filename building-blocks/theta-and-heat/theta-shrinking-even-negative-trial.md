# A shrinking even negative physical trial from the full prime number theorem

This construction proves a negative trial for the physical form $\mathscr K=A-S$, retaining all prime powers. It does not assert that the full pole-compensated Weil form is negative. Let $J=b/\Phi$, and let $\delta_R=1/2-\alpha_R$ denote the actual exterior ground spectral distance.

Use the explicit nonnegative bump
$$
 \eta(x)=\sqrt{30}\,x(1-x)1_{(0,1)}(x).
$$
Its zero extension lies in $H^1(\mathbb R)$; smoothness of the original ground is unnecessary. The exact normalizations are
$$
 \|\eta\|_2=1,\quad \|\eta'\|_2^2=10,
 \quad \|\eta\|_1=\sqrt{30}/6,
 \quad \|\eta'\|_1=\sqrt{30}/2.
\tag{1}
$$
A fixed nonnegative $C_c^\infty(0,1)$ bump gives the same result with its corresponding constants. The explicit $H^1$ choice is already in the actual logarithmic form domain and provides convenient exact constants.

Set
$$
 w=w_R=e^{-\sqrt R/8},\qquad
 g_R(u)=w^{-1/2}\eta\!\left(\frac{u-R-w}{w}\right),
 \qquad f_R=g_R+g_R^\vee.
\tag{2}
$$
Thus $\|g_R\|_2=1$, and the positive support is contained strictly between $R+w$ and $R+2w$. The even trial has no hard-boundary trace or atom. It is compactly supported in the exterior, has finite theta norm, and belongs to the full actual form domain. In particular the ground variational principle applies to $f_R/\Phi$.

## The exact opposite-prime convolution and its PNT error

For $H=\eta*\eta$,
$$
 (g_R*g_R)(v)=H\!\left(\frac{v-2R-2w}{w}\right),
 \qquad
 \int H=5/6,
 \quad \|H'\|_1\le5/2.
\tag{3}
$$
The last inequality follows from Young's inequality and (1). The positive convolution is supported in $(2R+2w,2R+4w)$ and is zero at both endpoints. Put
$$
 P_R^{\rm trial}=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                         (g_R*g_R)(\log n),
 \qquad G_-^{\rm trial}=\int e^{u/2}g_R(u)du.
$$
The exact prime-density integral is
$$
 \int e^{v/2}(g_R*g_R)(v)dv=(G_-^{\rm trial})^2
 =we^{R+w}\left(\int_0^1e^{wx/2}\eta(x)dx\right)^2
 \ge\frac56 e^Rw.
\tag{4}
$$
Let $E(x)=\psi_{\rm Ch}(x)-x$ for the full Chebyshev function, and let $\epsilon_R$ bound $|E(x)|/x$ for all $x\ge e^{2R}$. Stieltjes integration by parts, with the zero endpoint values in (3), gives exactly
$$
 P_R^{\rm trial}-(G_-^{\rm trial})^2
 =-\int E(e^v)\frac{d}{dv}
       \left[e^{-v/2}(g_R*g_R)(v)\right]dv.
$$
Hence for $w\le1$,
$$
 \left|P_R^{\rm trial}-(G_-^{\rm trial})^2\right|
 \le\epsilon_R e^{R+2w}
       \left(\|H'\|_1+\frac w2\|H\|_1\right)
 \le\frac{35}{12}e^2 e^R\epsilon_R.
\tag{5}
$$
All prime powers are present. If a prime power equals either real support endpoint, its test value is zero, so no endpoint mass has been suppressed.

For definiteness, Trudgian's primary Theorem 1 gives
$$
 \epsilon_R=\sqrt{\frac8{17\pi}}
 \left(\frac{2R}{6.455}\right)^{1/4}
 \exp\!\left[-\sqrt{\frac{2R}{6.455}}\right]
\tag{6}
$$
for $R\ge2$; the theorem holds for the full $\psi_{\rm Ch}$ for $x\ge23$, and its displayed error decreases throughout this range. Source: [Updating the error term in the prime number theorem, Theorem 1](https://arxiv.org/pdf/1401.2689).

Since $\sqrt{2/6.455}>1/2>1/8$, (6) implies
$\epsilon_R/w_R\to0$. In particular the explicit sufficient condition
$$
 \epsilon_R\le\frac{w_R}{7e^2}
\tag{7}
$$
holds for all sufficiently large $R$. Equations (4)–(5) then give
$$
 P_R^{\rm trial}\ge\frac5{12}e^Rw_R.
\tag{8}
$$
This is uniform smooth prime quadrature for this specified explicit trial, not for an arbitrary ground profile.

## Logarithmic kinetic cost and the complete physical sign

The actual multiplier satisfies an elementary global upper bound
$$
 \mathfrak a(\xi)\le C_a+2\log(1+|\xi|),
 \qquad C_a=|\mathfrak a(0)|+12.
\tag{9}
$$
For example, use
$\mathfrak a(\xi)-\mathfrak a(0)=2\int_0^\infty r(s)(1-\cos\xi s)ds$,
$r(s)\le(2s)^{-1}+1$ for $0<s\le1$, and
$r(s)\le e^{-s/2}/(1-e^{-2})$ for $s\ge1$. Split the first interval at $(1+|\xi|)^{-1}$, use the quadratic cosine bound below it, and the bound two above it. These estimates give (9) with room in the stated constant.

Scaling the unitary Fourier transform and applying Jensen's inequality to $\log(1+\xi^2)$, with (1), yield
$$
 \begin{aligned}
 \mathscr A[g_R]
 &\le C_a+2\log(1/w_R)
          +2\int\log(1+|\xi|)|\widehat\eta(\xi)|^2d\xi\\
 &\le C_a+2\log(1/w_R)+\log22.
 \end{aligned}
\tag{10}
$$
The last bound uses $(1+|\xi|)^2\le2(1+\xi^2)$, Plancherel, and $\|\eta'\|_2^2=10$.

When $w_R<\log2$, no same-half prime shift connects two points of the positive bump or two points of the negative bump. Thus the complete same-half prime term is zero. The opposite continuous cross term
$C_R^{\rm trial}=\int r(v)(g_R*g_R)(v)dv$ is nonnegative and is retained in the exact identity
$$
 \mathscr K[f_R]=2\mathscr A[g_R]
                     -2C_R^{\rm trial}-2P_R^{\rm trial}.
\tag{11}
$$
Since $e^Rw_R$ grows faster than $\log(1/w_R)=\sqrt R/8$, the further explicit sufficient condition
$$
 C_a+2\log(1/w_R)+\log22
 \le\frac5{24}e^Rw_R
\tag{12}
$$
holds for all sufficiently large $R$. Under (7), (12), and $w_R<\log2$,
$$
 \boxed{\quad \mathscr K[f_R]\le-\frac5{12}e^Rw_R<0.\quad}
\tag{13}
$$
This proves the claimed shrinking negative even physical trial. The argument uses the full prime measure, not prime-only asymptotics with proper powers removed.

## The resulting spectral-distance bound retains the theta displacement

The exact weighted trial norm is
$$
 \|f_R/\Phi\|_\nu^2=2\int J(u)g_R(u)^2du
 \le2J(R+2w_R),
$$
because the actual $J$ increases on the positive half-line. The physical form relation and the exterior variational principle now give
$$
 \boxed{\quad
 \delta_R\ge\frac{5}{24}
       \frac{e^Rw_R}{J(R+2w_R)}.
 \quad}
\tag{14}
$$
No estimate replaces $J(R+2w_R)$ by $J(R)$. In fact this very small geometric width can still cause a very large theta-weight change. Bound (14) controls an actual spectral distance; it does not by itself prove concentration of the normalized ground mass, a lower bound for $M_{0,R}=\int\Phi\psi$, or a normalized bound for the arithmetic ground-row convolution. Those conclusions require the separately retained spectral-tail and moment conversion estimates. Nor does (13) assert negativity after adding the two full Weil pole terms.

## Attribution and formal scope

This is written mathematics, with no Lean formalization of the displayed domain, transport or sampling estimates. The prime estimate is Trudgian's classical PNT error theorem; the negative trial uses all prime powers and concerns the physical form before adding Weil poles. No RH conclusion or passing full affine comparison is asserted.
