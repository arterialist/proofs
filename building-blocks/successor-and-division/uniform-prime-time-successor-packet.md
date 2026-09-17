# Uniform prime-cutoff and time crossover of the signed successor packet

This consumes the [finite-transport theorem](compensated-successor-finite-transport.md) and the physical L1 completion and charge decay in [positive history averaging](positive-history-successor-charge-relaxation.md). The new step is uniform concentration in the prime cutoff, including fixed finite cutoffs. It does not compare process laws in total variation as time grows.

For P in [2,infinity], retain the actual full profiles

$$
 B_P(v)=\sum_{p\le P}e^{v/2}p^{-\lfloor v/\log p\rfloor-1}
 \mathbf1_{v\ge\log p},\qquad B_\infty=B.
$$

Let X_{P,t} be the positive compound-Poisson process whose jump measure is nu_P(dv)=B_P(v)dv/v, and let U_{P,t} denote convolution by its full probability law. Every geometric power interval is included. At finite P its no-jump atom is exp(-t nu_P((0,infinity))) at zero, and the same formula holds for P=infinity because nu is finite. No atom or jump history is discarded below.

## 1. Uniform truncated first and second moments

Put A=log P, with A=infinity for P=infinity. The support of each omitted prime profile gives the exact identity

$$
 B_P(v)=B(v),\qquad v\le A.
 \tag{1}
$$

This includes the cutoff endpoint when P is prime. The established tail and full finite-prime masses are

$$
 0\le B_P(v)\le B(v)\le C/(1+v),\qquad
 \int_0^\infty B_P(v)dv=2H_P,\quad H_P=\sum_{p\le P}p^{-1}.
$$

The actual long-memory expansion and Mertens estimate give, uniformly in their arguments,

$$
 \int_0^R B(v)dv=2\log(1+R)+O(1),\qquad
 2H_P=2\log(1+A)+O(1),\quad P\ge2.
$$

Consequently, uniformly for R>=0 and P in [2,infinity],

$$
 \boxed{\int_0^R B_P(v)dv
 =2\log(1+\min\{R,A\})+O(1).}
 \tag{2}
$$

For R<=A this is (1). For R>A and finite P, positivity sandwiches the integral between integral_0^A B and the exact mass 2H_P. Both endpoints differ from 2log(1+A) by a bounded constant. The bounded initial range, including P=2, is absorbed in this same absolute constant. No infinite total mass is used for P=infinity, since the case R>A does not then occur.

Also, uniformly P,

$$
 \nu_P((R,\infty))\le C/R\quad(R\ge1),\qquad
 \int_0^R v^2\nu_P(dv)=\int_0^R vB_P(v)dv\le CR.
 \tag{3}
$$

## 2. Uniform bounded-Lipschitz concentration

For t>=e define

$$
 R_t=t\log t,\qquad
 m_{P,t}=\frac{2\log(1+\min\{R_t,\log P\})}{\log t}.
$$

The infinity convention applies at P=infinity. For every bounded Lipschitz b on [0,infinity),

$$
 \boxed{\left|\mathbb E b(X_{P,t}/R_t)-b(m_{P,t})\right|
 \le C\left[\frac{\|b\|_\infty}{\log t}
 +\frac{\operatorname{Lip}(b)}{\sqrt{\log t}}\right],}
 \tag{4}
$$

uniformly in P, including fixed finite P and P=infinity.

To prove this, split the actual Poisson jumps into those <=R_t and those >R_t, and let X^{<=R_t}_{P,t} be their smaller-jump sum. The probability of at least one omitted large jump is at most t nu_P((R_t,infinity))<=C/log t. The smaller-jump sum has exactly

$$
 \mathbb EX^{\le R_t}_{P,t}=t\int_0^{R_t}B_P(v)dv,
 \qquad
 \operatorname{Var}(X^{\le R_t}_{P,t})
 =t\int_0^{R_t}vB_P(v)dv\le CtR_t.
$$

By (2), its normalized mean differs from m_{P,t} by O(1/log t). Its normalized mean absolute deviation is at most the square root of its normalized variance, O((log t)^{-1/2}). Apply the Lipschitz bound to this truncated sum and the boundedness bound on the event of a large jump. This proves (4). Both compound-Poisson components include their no-jump events.

The full all-prime process has infinite mean, so (4) is not a uniform Wasserstein-one estimate and does not apply to unbounded linear tests. The bounded part of the test norm is essential in treating large jumps.

## 3. The prime/time crossover

For any cutoff path P=P(t) in [2,infinity],

$$
 m_{P,t}=2\min\left\{
 \frac{\log(1+t\log t)}{\log t},
 \frac{\log(1+\log P(t))}{\log t}\right\}.
$$

The first entry tends to one. Hence if

$$
 \frac{\log(1+\log P(t))}{\log t}\longrightarrow\alpha
 \quad\text{in }[0,\infty],
$$

then

$$
 \boxed{X_{P(t),t}/(t\log t)\longrightarrow
 2\min\{\alpha,1\}\quad\text{in probability}.}
 \tag{5}
$$

This follows directly from the preceding truncated proof, or from the bounded-Lipschitz estimate. For a fixed finite P the center is zero. For log P(t)=t^{alpha+o(1)} it is 2min(alpha,1). P=infinity gives center two. There is no condition t/log P(t)->0. If the cutoff path has no limiting alpha, equation (4) still tracks its exact deterministic center m_{P,t} uniformly.

## 4. Exact signed successor readout

Use the original successor S, the relative-charge functional delta, and C=S-a0 delta with a0(v)=exp(-v/2) on v>=0. For an additive source g in E_c write a for its physical representative and delta_a=delta(a). The proved primitive estimate is uniform over every positive causal probability law mu:

$$
 \|[C,U_\mu]g\|_{\rm pr}\le C\|g\|_E.
$$

For the actual laws here, the separately proved physical L1 completion identifies this primitive distribution with the literal L1 commutator, whose integral is zero. Therefore for bounded Lipschitz b,

$$
 \left|\int b(v/R_t)[C,U_{P,t}]a(v)dv\right|
 \le C\operatorname{Lip}(b)\|g\|_E/R_t.
 \tag{6}
$$

This bound is independent of P and t. It is not an L1 or total-variation bound uniform in time.

The full original successor identity, with both rank terms retained, is

$$
 [S,U_{P,t}]a=[C,U_{P,t}]a
 +a_0\delta(U_{P,t}a)-(U_{P,t}a_0)\delta_a.
 \tag{7}
$$

Its charge term satisfies the uniform decay estimate

$$
 |\delta(U_{P,t}a)|\le Ce^{-t\Phi_P(1)}\|g\|_E
 \le Ce^{-t\Phi_2(1)}\|g\|_E,
 \tag{8}
$$

where Phi_2(1)>0. This follows directly from |k(u+w)|<=Ce^{-u-w}, weighted source coercivity, and the exact Laplace transform of the process. In particular the initial negative branch of k and the process's no-jump atom are both retained.

If E is an independent mean-two exponential random variable, the exact packet law is

$$
 (U_{P,t}a_0)(v)dv=2\,\operatorname{Law}(X_{P,t}+E)(dv).
 \tag{9}
$$

The factor two is the full integral of a0. Its no-jump component is exp(-t nu_P((0,infinity)))a0, not an omitted boundary term. The added exponential changes a bounded Lipschitz observation at scale R_t by at most 2 Lip(b)/R_t in probability normalization.

Combining (4) and (6)-(9) yields the fully signed estimate

$$
 \begin{aligned}
 &\left|\int b(v/R_t)[S,U_{P,t}]a(v)dv
       +2\delta_a b(m_{P,t})\right|\\
 &\quad\le C|\delta_a|\left[
 \frac{\|b\|_\infty}{\log t}
 +\frac{\operatorname{Lip}(b)}{\sqrt{\log t}}
 +\frac{\operatorname{Lip}(b)}{R_t}\right]\\
 &\qquad\quad+C\|g\|_E\left[
 \frac{\operatorname{Lip}(b)}{R_t}
 +\|b\|_\infty e^{-t\Phi_2(1)}\right].
 \end{aligned}
 \tag{10}
$$

It holds uniformly in every finite cutoff P>=2 and for the completed all-prime process. The coherent mass-zero remainder is controlled before taking absolute values of its separate histories.

## 5. Actual natural cutoffs and the repaired scope

Apply (10) to the actual natural source family g_N, including its completed member g, with physical representatives a_N and coefficients delta_N. The proved source results give uniformly bounded E norms, delta_N->kappa>0 as N tends to infinity, and the corresponding uniform scalar bounds. Hence

$$
 \sup_{P\in[2,\infty],\,N}
 \left|\int b(v/R_t)[S,U_{P,t}]a_N(v)dv
 +2\delta_N b(m_{P,t})\right|
 \le\frac{C_b}{\sqrt{\log t}}.
 \tag{11}
$$

For any cutoff path with limiting alpha as in (5), the error in replacing m_{P,t} by 2min(alpha,1) also tends to zero, uniformly in N. If N=N(t) tends to infinity, or the completed source is used throughout, this proves the exact limit

$$
 \boxed{\int b\!\left(\frac v{t\log t}\right)
 [S,U_{P(t),t}]a_{N(t)}(v)dv
 \longrightarrow -2\kappa\,b(2\min\{\alpha,1\}).}
 \tag{12}
$$

For a fixed natural cutoff N the coefficient is delta_N instead. If N(t) has no limiting coefficient, (11) remains the precise statement with that coefficient tracked.

In particular a fixed finite prime cutoff is now included and produces the value -2kappa b(0), not -2kappa b(2). A test supported away from zero therefore need not see a nonzero limiting packet at fixed P. This repairs the previous exclusion of finite P without changing any arithmetic coefficient. The convergence is signed bounded-Lipschitz convergence at the moving observation scale, not total variation and not an anticausal or Weil-sign conclusion.

The probabilistic argument is classical compound-Poisson truncation and Chebyshev concentration. Its arithmetic inputs are the [complete long-memory seed](collective-successor-seed-long-memory.md), its [Mertens calibration](../factorial-and-renewal/successor-clock-arithmetic-calibration.md), and the [actual natural-source convergence](../dynamics-and-feedback/natural-arrival-cutoff-completion.md). This moving-scale theorem is written, not Lean formalized.
