# Actual factorial-ground pullback of finite screw increments

This note uses the actual factorial potential and the established original-$L^2$ domain theorem in [the domain source](factorial-ground-state-original-l2-domain.md). The normalization of the screw function is [Matsumoto–Suzuki, Proposition 6.1, equation (6.2)](https://arxiv.org/html/2409.00888v2#S6). Their Theorem 1.3 identifies positivity for all finite configurations with RH. No such positivity is assumed or proved below.

The construction gives an explicit positive ground-state square and its exact residual for each finite configuration. In particular, it distinguishes absolute integer observation points in the ground form from ratio/translation prime correlations in the screw kernel.

## 1. Actual normalization and the origin

Write
$$
 A(X)=\log(2\pi)+\frac12\log(1-X^{-2})
       +\frac X2\log\frac{X+1}{X-1}-1,\qquad X>1,
$$
and extend the following functions evenly:
$$
 f(t)=e^{|t|/2}F(e^{|t|}),\qquad
 b(t)=e^{-|t|/2}A(e^{|t|}),\qquad
 e(t)=e^{|t|/2}.
\tag{1}
$$
Their continuous values at zero are
$$
 f(0)=0,\quad b(0)=\log(4\pi)-1,\quad e(0)=1.
$$
The exact actual function is
$$
 S=(1+\gamma)e-f-b,\qquad S(0)=\gamma+2-\log(4\pi).
\tag{2}
$$
The limiting value of $b$ follows, without subtracting divergent terms, from
$$
 \frac12\log(1-X^{-2})+
 \frac X2\log\frac{X+1}{X-1}
 =
 \frac{X+1}{2}\log(X+1)-\log X
 -\frac{X-1}{2}\log(X-1).
$$

There is also a useful independent check on the causal contact. For $t>0$, put
$$
 a(t)=e^{-t/2}\bigl(\psi(e^t)-e^t\bigr),\qquad
 B(t)=e^{-t/2}\left[\log(2\pi)+\tfrac12\log(1-e^{-2t})\right].
$$
Direct differentiation of the actual expression (2) gives
$$
 (D-\tfrac12)S=a+B\quad(t>0).
$$
Here $B$ is locally integrable at zero. For zero extension to the negative half-line the distributional statement is precisely
$$
 a_+=(D-\tfrac12)S_+-B_+-S(0)\delta_0.
\tag{3}
$$
Thus the causal origin contact has not been discarded. We will not differentiate the archimedean function $b$ twice or split its singular derivative into unjustified separate pairings.

## 2. Finite configurations produce actual original-$L^2$ sources

For real $t_i$ and complex $c_i$, let
$$
 \mu=\sum_i c_i(\delta_{t_i}-\delta_0).
$$
Then the finite screw quadratic form is
$$
 \mathfrak S(\mu)
 =\sum_{i,j}c_i\overline{c_j}
   [S(t_i-t_j)-S(t_i)-S(t_j)+S(0)]
 =\iint S(t-u)\,\mu(dt)\overline{\mu(du)}.
\tag{4}
$$
This explicitly accounts for $S(0)$; the last expression uses the exact zero total mass of $\mu$.

Translate all atoms by the same real constant so their support is contained in $[0,T]$. This changes neither side of (4). Combine coincident atoms and write the resulting measure as $\sum_j\alpha_j\delta_{s_j}$, where $0\le s_j\le T$ and $\sum_j\alpha_j=0$. Define
$$
 v(t)=\mu((-\infty,t]),\qquad
 g(x)=x^{-1/2}v(\log x)\quad(x>1),\qquad h=Hg.
\tag{5}
$$
The step function $v$ is compactly supported modulo endpoints, and
$$
 \|g\|_{L^2(dx)}^2=\|v\|_{L^2(dt)}^2.
$$
This is the original physical $L^2(dx)$, with the exact unitary change of variables, not a replacement metric.

The Hardy pullback is completely explicit:
$$
 h(x)=\frac2x\sum_j\alpha_j
             \bigl(\sqrt x-e^{s_j/2}\bigr)_+.
\tag{6}
$$
In particular $h$ belongs to the established form domain
$$
 \mathcal D=\{h\in L^2:\ h\in AC_{\rm loc},\ xh'\in L^2,\ h(1+)=0\}.
$$
For $x\ge e^T$,
$$
 h(x)=-\frac2x\sum_j\alpha_j e^{s_j/2}.
\tag{7}
$$
This tail must be kept. If there is an atom at $s=0$, then $h/F$ may have its nonzero coefficient as its limit at one; the form imposes $h(1)=0$, not $h/F\to0$.

Let
$$
 C_v(s)=\int_{\mathbb R}v(u+s)\overline{v(u)}\,du.
\tag{8}
$$
It is continuous, supported in $[-T,T]$, and satisfies $C_v(-s)=\overline{C_v(s)}$.

## 3. The actual factorial distribution supplies the contact and all prime correlations

The equation $(x^2F')'=dx-\sum_{n\ge2}\Lambda(n)\delta_n$ gives, on the entire real line,
$$
 \boxed{
 f''=2\delta_0+
       [\tfrac14f(t)+e^{|t|/2}]\,dt
       -\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                    (\delta_{\log n}+\delta_{-\log n}).
 }
\tag{9}
$$
Indeed on $t>0$, differentiating $e^{t/2}F(e^t)$ twice yields
$f/4+e^{t/2}(x^2F')'$, with the change-of-variable weight $n^{-1/2}$ at each atom. Also $f'(0+)=1$, because $F(x)=\log x$ before the first prime. Even extension therefore contributes exactly $2\delta_0$.

Since $D v=\mu$, two integrations by parts give
$$
 -\iint f(t-u)\,\mu(dt)\overline{\mu(du)}
 =\langle f'',C_v\rangle
 =2\|g\|_2^2+\mathcal V_F(v)-\mathcal P(v),
\tag{10}
$$
where
$$
 \mathcal V_F(v)=\int_{\mathbb R}
        [f(s)/4+e^{|s|/2}]C_v(s)\,ds,\qquad
 \mathcal P(v)=2\sum_{n\ge2}
            \frac{\Lambda(n)}{\sqrt n}\operatorname{Re}C_v(\log n).
\tag{11}
$$
These expressions are real. Only $n<e^T$ can contribute to the latter sum: $C_v(T)=0$. Thus a prime-power collision at the upper endpoint is retained with its exact zero overlap, not deleted by a limiting convention.

For rigor, mollify the compact step function $v$. Its derivatives converge weakly as finite measures to $\mu$; the kernel $f$ is continuous on a common compact set. The autocorrelations converge uniformly by Cauchy–Schwarz. The right side of (9) has finite total variation on that compact set. Consequently (10) follows by passing the two integrations by parts to the limit. No differentiability of $v$, or of an arithmetic sample at a jump, is required.

## 4. Exact positive square and the retained signed residual

Set
$$
 \mathcal A(\mu)=\iint e^{|t-u|/2}\,\mu(dt)\overline{\mu(du)},\qquad
 \mathcal B(\mu)=\iint b(t-u)\,\mu(dt)\overline{\mu(du)}.
$$
These are finite, literal configuration sums, including diagonal values from (1).
Combining (2), (10), and the established original-$L^2$ ground identity gives
$$
 \boxed{\mathfrak S(\mu)=2\|R_Fg\|_2^2+\mathcal R_F(\mu),}
\tag{12}
$$
with the explicit residual
$$
 \boxed{\begin{aligned}
 \mathcal R_F(\mu)={}&
 (1+\gamma)\mathcal A(\mu)-\mathcal B(\mu)
 +\mathcal V_F(v)-\mathcal P(v)\\
 &-2\int_1^\infty\frac{|h(x)|^2}{F(x)}\,dx
 +2\sum_{n\ge2}\frac{\Lambda(n)}{F(n)}|h(n)|^2 .
 \end{aligned}}
\tag{13}
$$
The positive term is the actual factor
$$
 R_Fg=g-(1+xF'/F)Hg.
$$
Every term in (13) is well-defined separately. In particular the last two terms are bounded quadratic forms in $g$, by the existing domain theorem. The infinite atomic tail in the last term is
$$
 8\left|\sum_j\alpha_j e^{s_j/2}\right|^2
 \sum_{n>e^T}\frac{\Lambda(n)}{n^2F(n)},
$$
apart from any endpoint atom $n=e^T$, whose value is supplied by (6). It is finite and remains in (13), even though the correlation sum $\mathcal P$ has finite support.

Equation (12) is a constructive finite-configuration source pullback: (5)–(6) give the source directly, without using the sign of $\mathfrak S$, inverting a conjecturally positive kernel, or invoking a zero expansion. Polarization gives the full sesquilinear identity, with $C_{v,w}(s)=\int v(u+s)\overline{w(u)}du$ and the conjugated atomic products.

The two arithmetic observations in (13) are different:
$$
 \frac{\Lambda(n)}{\sqrt n}C_v(\log n)
 \quad\hbox{versus}\quad
 \frac{\Lambda(n)}{F(n)}h(n)\overline{h(n)}.
\tag{14}
$$
The former compares pairs at multiplicative ratio $n$; the latter samples the Hardy primitive at the absolute point $n$. Ground-state positivity controls the latter together with its continuous partner. It supplies no comparison replacing (14), and (13) retains their difference before any absolute estimate. Changing the common translate of the configuration changes this particular decomposition, but not the exact total (12).

## 5. A precise small-configuration test of the residual

Take $\mu=\delta_\varepsilon-\delta_0$, $0<\varepsilon<\log2$. Then $v=-\mathbf1_{[0,\varepsilon)}$, so
$$
 \|g\|_2^2=\varepsilon,\qquad
 0\le2\|R_Fg\|_2^2\le114\varepsilon.
\tag{15}
$$
The bound uses the already established $\|R_Fg\|^2\le57\|g\|^2$.

On this same interval the actual source is $a(t)=-e^{t/2}$, and (3) gives
$$
 S'(t)=\frac12\log t+O(1),\qquad
 S(t)-S(0)=\frac12t\log t+O(t).
$$
Consequently
$$
 \mathfrak S(\delta_\varepsilon-\delta_0)
   =\varepsilon\log(1/\varepsilon)+O(\varepsilon),\qquad
 \boxed{\mathcal R_F(\delta_\varepsilon-\delta_0)
   =\varepsilon\log(1/\varepsilon)+O(\varepsilon).}
\tag{16}
$$
Thus the residual is not zero; for these configurations it is positive and larger than the ground-state square by an unbounded ratio of scales. In particular the archimedean term cannot be absorbed as a discarded origin constant. This is a scoped obstruction to identifying the screw form with this factorial-ground square alone, not an obstruction to other positive representations.

The construction leaves the exact collective residual (13), including its ratio-prime correlations and full archimedean readout. No sign for that residual on arbitrary configurations is asserted. The original-$L^2$ factorization and its coercivity remain unconditional.

## Dependencies and formal scope

The [factorial maximal domain and inverse](factorial-ground-state-original-l2-domain.md) justify the complete Hardy observations, including their infinite prime tail. The [Picone identity](../dynamics-and-feedback/picone-frozen-source-work.md) fixes their sign and normalization. The Matsumoto–Suzuki explicit formula supplies the classical screw function. This written finite-configuration decomposition leaves the full residual visible and makes no Lean or general residual-sign claim. The [coherent-core screw observation](../weil-and-spectral/actual-core-screw-increment-readout.md) is a distinct full-kernel consumer of the same source map.
