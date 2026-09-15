# A ground-state constraint on outward prime-convolution sampling

Fix the actual exterior ground state $D_R\psi=\alpha\psi$, normalized in $L^2(\nu_O)$, and put $d=1/2-\alpha>0$. Let
$$
 g(u)=\Phi(u)\psi(u)1_{u>R},\quad h=g*g,\quad
 f=g+g^\vee,
$$
with the actual bounded positive ground state and all the conventions of [theta ground sign prime convolution](theta-ground-sign-prime-convolution.md). In particular $g\in H^{\log/2}$, it has a theta envelope, and the physical translation-invariant form is $K=A-S$, retaining every prime power.

For an outward displacement $t\ge0$, define
$$
 f_t(u)=g(u-t)+g(-u-t),\qquad
 N(t)=2\int_R^\infty\frac{b(u+t)}{\Phi(u+t)}g(u)^2du.
\tag{1}
$$
The two histories have both been displaced away from the hard core. The admissible displacement range used here is
$$
 0\le t<\tfrac12\log2.
\tag{2}
$$
For each such $t$, $N(t)<\infty$. Indeed the actual bound $g\le\|\psi\|_\infty\Phi$ makes the tail exponent in its integrand proportional to
$-\pi(2-e^{2t})e^{2u}$, which is strictly negative. Translation preserves the physical logarithmic form domain. The full form-domain identification then places $f_t/\Phi$ in the original exterior form domain: its weighted squared norm is exactly $N(t)$, and its support is contained in $O$. This argument does not differentiate the ground state or put a cross-profile vector in an operator domain.

We have $N(0)=1$, $N(t)\to1$ as $t\downarrow0$, and $N(t)\ge1$, because $b/\Phi$ increases on the positive half-line. Dominated convergence follows by first bounding $t$ in a compact subinterval of (2).

## The ground variational inequality couples shifted prime excesses

Define the exact displaced cross terms
$$
 C(t)=\int_{2R}^\infty r(v+2t)h(v)\,dv,
\qquad
 P(t)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                           h(\log n-2t).
\tag{3}
$$
Both sums and integrals converge absolutely. Their lower endpoints are fixed by the support of $h$, and terms at the support endpoint are zero. The same-side physical energy is unchanged by translation, while the reflected cross-distance has increased by $2t$. Therefore
$$
 K(f_t)=2K(g)-2[C(t)+P(t)].
\tag{4}
$$
Ground-state minimality gives
$K(f_t)\ge-dN(t)$, whereas $K(f_0)=-d$. Subtracting proves
$$
 \boxed{\quad
 P(0)\ge P(t)-[C(0)-C(t)]-\frac d2[N(t)-1].
 \quad}
\tag{5}
$$
Both displayed penalties are nonnegative. This is a restriction on the actual ground profile: arbitrary nonnegative $g$ need not satisfy it. Every same-side prime term canceled by exact translation invariance before the inequality was applied, rather than by an assumed sign or independence.

Let $G_- =G(-1/2)$. The exact prime-density value for the shifted test is $e^tG_-^2$. Define the signed shifted excess
$$
 \Delta(t)=4[P(t)-e^tG_-^2].
$$
Then $\Delta(0)=4\mathcal R_g$, and (5) becomes
$$
 \boxed{\quad
 \Delta(0)\ge\Delta(t)+4(e^t-1)G_-^2
           -4[C(0)-C(t)]-2d[N(t)-1].
 \quad}
\tag{6}
$$
Thus the actual excess at the original core cannot be varied independently of the shifted arithmetic samples and the ground state's exact weighted displacement cost.

## An exact positive average involving actual short intervals

For $0<T<\tfrac12\log2$, Tonelli gives
$$
 \frac1T\int_0^T P(t)dt
 =\frac1{2T}\int_{2R}^\infty h(v)
       \sum_{e^v\le n\le e^{v+2T}}
                    \frac{\Lambda(n)}{\sqrt n}\,dv.
\tag{7}
$$
Endpoint equalities do not affect the Lebesgue integral, and all prime powers remain. Averaging (5) gives the concrete lower bound
$$
\boxed{\begin{aligned}
 P(0)\ge{}&\frac1{2T}\int h(v)
       \sum_{e^v\le n\le e^{v+2T}}
                    \frac{\Lambda(n)}{\sqrt n}\,dv\\
 &-C(0)+\frac1T\int_0^TC(t)dt
 -\frac d{2T}\int_0^T[N(t)-1]dt.
\end{aligned}}
\tag{8}
$$
This exposes a positive short-interval prime average and the exact cost charged by the ground equation. For fixed $T$, ordinary PNT estimates can be applied to the inner interval sum; doing so does not remove the last term. Its normalization by $G_-^2$ is presently uncontrolled. In particular the product $dN(t)$ cannot be declared negligible from $d\to0$: the theta-weighted displacement norm may grow rapidly.

Equations (5)–(8) are the new actual-source constraint supplied here. They do not bound the transverse prime-profile norm in the [component comparison](theta-prime-component-cross-profile-bound.md). Turning them into that comparison would require a quantitative relation between the normalized displacement cost, the signed shifted excesses, and the actual profile direction. No such relation or passing core is asserted, and no higher regularity of $\psi$ has been assumed.

## A ground-equation tail bound for the displacement norm

The displacement cost has a bound independent of $\|\psi\|_\infty$. Take $R\ge1$. Write $b_S$ for the established hard-crossing operator norm bound at radius $S$, and $\delta_S$ for the exterior spectral defect, so
$L_{|u|>S}\ge1/2-\delta_S$. For $S>R$ with $\delta_S<d$, the hard split of the actual ground equation is
$$
 (L_{|u|>S}-\alpha)\psi_{|u|>S}
 =B_S\psi_{|u|\le S}.
$$
The inner part here is still zero on the original core. Therefore
$$
 \boxed{\quad
 \|\psi_{|u|>S}\|_\nu
 \le\frac{b_S}{d-\delta_S}
 \le\frac{2b_S}{d}\quad\text{if }\delta_S\le d/2.
 \quad}
\tag{9}
$$
No additional factor from the inner norm is needed, since the full ground state has norm one.

The actual theta estimates for the complete crossing norm and exterior defect permit constants $B_{\rm tail}\ge1$, $c_{\rm tail}>0$, independent of $S$, such that
$$
 b_S,\delta_S\le B_{\rm tail}\exp(-c_{\rm tail}e^{2S})
 \qquad(S\ge1).
\tag{10}
$$
Polynomial factors in the published tail bounds are absorbed by reducing $c_{\rm tail}$. Set
$$
 X_0=\max\left(e^{2R},e^2,c_{\rm tail}^{-1},
 c_{\rm tail}^{-1}\log\frac{2B_{\rm tail}}d\right).
\tag{11}
$$
Under the actual probability measure $\psi^2d\nu$, let $X=e^{2|u|}$. Equations (9)–(10) imply
$$
 \mathbb P(X>x)\le
 \exp[-2c_{\rm tail}(x-X_0)]\qquad(x\ge X_0).
\tag{12}
$$
For $x<X_0$, the bound by one suffices. Thus $X$ is stochastically dominated by $X_0+Y$, where $Y$ has exponential rate $2c_{\rm tail}$. The normalization is squared correctly in (12): the prefactor before shifting the exponential tail is $4B_{\rm tail}^2/d^2$.

In fact $d\le\delta_R\le B_{\rm tail}e^{-c_{\rm tail}e^{2R}}$. Hence the logarithmic entry of (11) dominates $e^{2R}$, and $X_0=O(\log(C/d))$ with fixed theta constants. This is an actual localization estimate from the ground equation, not a prescribed concentration hypothesis.

Let $J(u)=b(u)/\Phi(u)$ for $u>0$. The elementary full-theta score bound $|\Phi'/\Phi|\le80e^{2u}$ gives
$$
 0\le(\log J)'(u)\le81e^{2u}.
$$
For $0\le t<\tfrac12\log2<1$, put $L_0=729$. Then
$$
 1\le\frac{J(u+t)}{J(u)}\le\exp(L_0t e^{2u}).
$$
Since $N(t)$ is precisely the expectation of this ratio under $\psi^2d\nu$, stochastic domination proves
$$
 \boxed{\quad
 N(t)\le e^{L_0tX_0}
       \frac{2c_{\rm tail}}{2c_{\rm tail}-L_0t},
 \qquad L_0t<2c_{\rm tail}.
 \quad}
\tag{13}
$$
This restriction is in addition to the translation domain (2).

For the smaller range $0\le t\le1/(L_0X_0)$, we have $L_0t\le c_{\rm tail}$. Applying the same domination to $Xe^{L_0tX}$, and using $e^y-1\le ye^y$, gives the useful linear estimate
$$
 \boxed{\quad
 N(t)-1\le4eL_0tX_0,
 \qquad
 \frac{d[N(t)-1]}{G_-^2}
 \le4eL_0tX_0\frac d{G_-^2}.
 \quad}
\tag{14}
$$
Indeed $\mathbb E[Xe^{L_0tX}]\le e(2X_0+2/c_{\rm tail})\le4eX_0$. Thus the displacement cost depends on a logarithmic spectral-distance scale, rather than on an uncontrolled supremum of the ground state. The ratio $d/G_-^2$ remains explicit.

## Prime-window width versus the proved displacement budget

Define the unconditional relative Chebyshev error
$$
 \epsilon_R=\sup_{x\ge e^{2R}}
          \frac{|\psi_{\rm Ch}(x)-x|}{x}.
$$
Weighted partial summation, for almost every interval endpoint, gives
$$
 \sum_{e^v<n\le e^{v+2T}}\frac{\Lambda(n)}{\sqrt n}
 \ge2e^{v/2}(e^T-1)-2\epsilon_R e^{v/2+T}.
$$
The exceptional endpoint equalities form a countable set in $v$ and do not change (7). Also the exact continuous expansion gives
$$
 \frac1T\int_0^T[C(0)-C(t)]dt
 \le\frac T2G(1/2)^2
       \frac{1+3e^{-4R}}{(1-e^{-4R})^2}.
$$
Consequently (8) and (14) prove, for $0<T\le1/(L_0X_0)$,
$$
\boxed{\begin{aligned}
 \frac{P(0)}{G_-^2}\ge{}&\frac{e^T-1}{T}
       -\frac{\epsilon_R e^T}{T}\\
 &-\frac T2e^{-2R}
       \frac{1+3e^{-4R}}{(1-e^{-4R})^2}
       -eL_0TX_0\frac d{G_-^2}.
\end{aligned}}
\tag{15}
$$
This is an explicit sufficient inequality for any proposed finite core and displacement; all its normalization costs are visible.

The safe linear range in (14) has $T\le e^{-2R}/L_0$, whereas the classical unconditional relative PNT estimate available here is of order $\exp(-c\sqrt R)$, up to powers of $R$. Substituting that estimate in (15) cannot make its prime-window error small in this range. This is a limitation of this bound and this PNT input, not a claim that the true error is that large. Larger displacements are allowed by (13), but their normalized cost includes
$d e^{L_0TX_0}/G_-^2$, which is not controlled by present results. Thus the ground equation yields the nontrivial displacement estimate (13)–(14), while a passing normalized prime average still requires additional information about the actual relative spectral distance or a sharper ground-weighted arithmetic average.

## Attribution and formal scope

This is written mathematics, with no Lean formalization of the displayed domain, transport or sampling estimates. The linked ground-state, theta-form and classical boundary estimates supply the stated domains. All arithmetic arrival terms and normalization costs are retained. No RH conclusion or passing full affine comparison is asserted.
