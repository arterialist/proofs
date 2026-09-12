# Total-variation relaxation to the retained successor packet

This written proof extracts a fixed uniform component from the actual prime-two density and retains the independent residual process. It uses the [positive process](positive-successor-seed-jump-process.md), the [uniform density BV bound](positive-history-successor-charge-relaxation.md), and the [finite-transport primitive](compensated-successor-finite-transport.md). The compound-Poisson splitting is classical; see Schilling–Song–Vondraček, [*Bernstein Functions*, chapters 3 and 5]$https://motapa.de/bernstein_functions/index.shtml$. The analytic estimates below are not formalized in Lean.

For the actual complete prime process, write
$$
 \mu_t=e^{-\lambda t}\delta_0+m_t(v)dv,
 \qquad T_ta=\mu_t*a.
$$
All derivatives of densities below are whole-line distributional derivatives, and their norms are total variations of signed measures. We prove
$$
 \boxed{\|Dm_t\|_{\mathrm{TV}}\le C t^{-1/2}\quad(t\ge1),}
\tag{1}
$$
uniformly also for every finite prime cutoff $P\ge2$. With the same compensated successor $C=S-a_0\delta$ and original causal space $E_c$, this gives
$$
 \boxed{\|[C,T_t]a\|_1\le C t^{-1/2}\|H\|_{E_c}\quad(t\ge1).}
\tag{2}
$$
For a real source, put $a(v)=e^{v/2}H(e^v)$, $\kappa=\delta(a)$, and $q_t=T_ta_0$, where $a_0=e^{-v/2}\mathbf1_{v\ge0}$ has mass two. Then
$$
 \boxed{\|[S,T_t]a+\kappa q_t\|_1
                  \le C t^{-1/2}\|H\|_{E_c}\quad(t\ge1).}
\tag{3}
$$
This is physical total-variation relaxation to the actual transported reference packet. Every other prime and proper-power contribution remains in the process. No arithmetic sign is inferred for an unbounded quadratic readout.

## 1. Extract a fixed component from the actual prime two

Let $L=\log2$. On the open interval $(L,2L)$, the exact complete density contributed by the prime two is
$$
 F_2(v)=\frac{e^{v/2}}{4v}>0.
\tag{4}
$$
Choose any fixed closed interval $I=[b,b+\ell]$ inside $(L,2L)$, with $\ell>0$. Put
$$
 u_I=\ell^{-1}\mathbf1_I,
 \qquad \alpha=\frac\ell2\min_{v\in I}F_2(v)>0.
\tag{5}
$$
Thus $\alpha u_I\le F_2/2$ on $I$. For either the complete density $F$ or a finite prime cutoff $F_P$ with $P\ge2$, write
$$
 F=\alpha u_I+F_r,
 \qquad F_r\ge0,\quad F_r\in L^1\cap BV.
\tag{6}
$$
Here and below the same notation covers both cases. The [proved density theorem](positive-history-successor-charge-relaxation.md) gives a common bound $V_*$ on the variations of all $F_P$ and $F$. Hence
$$
 \lambda_r=\|F_r\|_1=\lambda-\alpha\ge\lambda_2/2>0,
 \qquad \operatorname{Var}(F_r)\le V_*+2\alpha/\ell.
\tag{7}
$$
The lower mass bound follows because $\alpha\le\frac12\int_I F_2\le\lambda_2/2$. No component is deleted: (6) is an exact positive decomposition, including every discontinuity of $F_r$ at the endpoints of $I$.

## 2. Convolution powers of the uniform density

For every integer $j\ge1$,
$$
 \boxed{\operatorname{Var}(u_I^{*j})
      =2\|u_I^{*j}\|_\infty
      \le\frac C{\ell\sqrt j}.}
\tag{8}
$$
To verify the variation identity, translate $u_I$ to the interval centered at zero. Its convolution powers are symmetric and nonincreasing on the positive half-line. Indeed, convolution of an even nonincreasing function $f$ with the centered uniform density has derivative
$(f(x+\ell/2)-f(x-\ell/2))/\ell\le0$ for $x\ge0$, almost everywhere. Approximation or the integral formula proves this statement also at the first step. Induction proves the claimed shape. A nonnegative symmetric unimodal integrable BV function has total variation twice its maximum, including endpoint jumps. This includes $j=1$, where the derivative consists of two atoms.

For the maximum bound, $j=1$ is immediate. For $j\ge2$, Fourier inversion and absolute integrability give
$$
 \|u_I^{*j}\|_\infty
 \le\frac1{\pi\ell}\int_{\mathbb R}
                         \left|\frac{\sin z}{z}\right|^j dz.
\tag{9}
$$
On $|z|\le1$, the sinc modulus is at most $e^{-c z^2}$, so this part is $O(j^{-1/2})$. On $1\le|z|\le2$, its maximum is some fixed number smaller than one. On $|z|\ge2$, use $|\sin z/z|\le|z|^{-1}$, whose $j$-th power has integral $2^{2-j}/(j-1)$. This proves (8) with an absolute constant. Translation of the center has no effect on either norm.

## 3. Poisson averaging and every no-jump atom

Let the uniform-component law and residual law be
$$
 \mu_{u,t}=e^{-\alpha t}\delta_0+m_{u,t}(v)dv,
 \qquad
 m_{u,t}=e^{-\alpha t}\sum_{j\ge1}
                     \frac{(\alpha t)^j}{j!}u_I^{*j},
$$
$$
 \mu_{r,t}=e^{-\lambda_rt}\delta_0+m_{r,t}(v)dv.
\tag{10}
$$
The exact compound-Poisson convolution identity gives $\mu_t=\mu_{u,t}*\mu_{r,t}$. If $J$ is Poisson with mean $z=\alpha t$, equation (8) gives
$$
 \|Dm_{u,t}\|_{\mathrm{TV}}
 \le\frac C\ell\mathbb E[J^{-1/2}\mathbf1_{J\ge1}]
 \le\frac C\ell\begin{cases}z,&0\le z\le1,\\z^{-1/2},&z\ge1.
 \end{cases}
\tag{11}
$$
For large $z$, split at $J=z/2$. Above it the integrand is at most $\sqrt{2/z}$. Below it the Poisson Chernoff bound is $e^{-c z}$; for example applying Markov to $e^{-J}$ proves such a bound directly. For $z\le1$, use $J^{-1/2}\le1$ and $\mathbb P(J\ge1)\le z$.

The residual density satisfies the uniform bound already proved for a BV jump density,
$$
 \|Dm_{r,t}\|_{\mathrm{TV}}
 \le\frac{\operatorname{Var}(F_r)}{\lambda_r}
                                    (1-e^{-\lambda_rt})
 \le C,
\tag{12}
$$
by (7). Extracting the density from the convolution identity gives exactly
$$
 m_t=m_{u,t}*\mu_{r,t}+e^{-\alpha t}m_{r,t}.
\tag{13}
$$
The total no-jump atom is $e^{-(\alpha+\lambda_r)t}\delta_0$, as required. The residual atom remains inside $\mu_{r,t}$ in the first term of (13). Differentiation gives
$$
 Dm_t=(Dm_{u,t})*\mu_{r,t}+e^{-\alpha t}Dm_{r,t}.
\tag{14}
$$
Probability convolution contracts total variation. Equations (11)--(14) imply (1), with constants depending only on the fixed interval and the common density bounds. These constants are uniform for all $P\ge2$, including the complete process. The same estimates and the earlier small-time bound also give
$\|Dm_t\|_{\mathrm{TV}}\le C\min(t,t^{-1/2})$ for all $t>0$.

## 4. Compensated and full successor relaxation

The [finite-transport primitive](compensated-successor-finite-transport.md) and the [positive-history response identity](positive-history-successor-charge-relaxation.md) give, for every causal $E_c$ source,
$$
 (C-I)a=DP_a,\qquad \|P_a\|_1\le C\|H\|_{E_c},
$$
$$
 [C,T_t]a=-(Dm_t)*P_a+R_t,
 \qquad \|R_t\|_1\le C e^{-t\Phi(1)}\|H\|_{E_c}.
\tag{15}
$$
These identities are established on the completed source space, with all derivatives interpreted on the whole line. Since $\Phi_P(1)\ge\Phi_2(1)>0$, the exponential constants are uniform in $P\ge2$. Applying (1) to (15) proves (2).

The exact full successor identity is
$$
 [S,T_t]a=[C,T_t]a+a_0\delta(T_ta)-\kappa T_ta_0,
\qquad \kappa=\delta(a).
\tag{16}
$$
Use $\|a_0\|_1=2$ and the proved relative-charge estimate
$|\delta(T_ta)|\le C e^{-t\Phi(1)}\|H\|_{E_c}$. This proves (3). In particular, the result applies uniformly to all actual natural cutoffs, whose original $E_c$ norms are uniformly bounded. There is no replacement of the natural source or the reference packet by an independently chosen density.

For the real actual source, whose $\kappa>0$ is established, let $r_t=[S,T_t]a$. Equation (3) implies
$$
 \|r_t\|_1=2\kappa+O_g(t^{-1/2}),\qquad
 \int(r_t)_+\le C_g t^{-1/2},\qquad
 \int(r_t)_-=2\kappa+O_g(t^{-1/2}).
\tag{17}
$$
The positive-part bound follows from $-\kappa q_t\le0$, and the negative-part conclusion also uses the exact mass identity or the norm estimate. The negative packet is retained at its actual time-dependent location.

## 5. Bounded observations and the complete two-history readout

Equation (3) gives, for every bounded measurable test $b_t$,
$$
 \left|\int b_t(v)[r_t(v)+\kappa q_t(v)]dv\right|
       \le C_g\|b_t\|_\infty t^{-1/2}.
\tag{18}
$$
There is no Lipschitz or variation hypothesis on this observation, and it may depend on $t$. This strengthens the preceding weak and primitive-norm comparisons.

For every bounded measurable kernel $B_t(v,w)$, the tensor identity and $\|q_t\|_1=2$ give
$$
 \boxed{\left|\iint B_t(v,w)
     [r_t(v)r_t(w)-\kappa^2q_t(v)q_t(w)]dv\,dw\right|
              \le C_g\|B_t\|_\infty t^{-1/2}.}
\tag{19}
$$
Indeed write $r_t=-\kappa q_t+e_t$, with $\|e_t\|_1=O_g(t^{-1/2})$, and retain both mixed tensors and $e_t\otimes e_t$. The Hermitian version follows by conjugating the second factor and replacing $\kappa^2$ by $|\kappa|^2$.

This removes derivative conditions from the earlier bounded two-history comparison. A limit for the packet tensor itself still depends on the selected observation and the actual history law. In particular (19) does not authorize testing an unbounded or singular energy kernel without its separate integrability estimate, and it does not supply the missing RH sign.

The [dyadic extraction proof](dyadic-prime-process-variation.md) uses the full arithmetic tail to improve the complete-process rate to $t^{-1}$ and gives the finite-cutoff crossover. The fixed-component proof above remains a separate method requiring only one positive interval and uniform BV control.
