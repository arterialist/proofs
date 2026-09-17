# A sparse prime-weight test of the Suzuki--Goldbach bridge

**Status:** written countermodel to a qualitative inference, not a result about zeros of the actual Riemann zeta function. The construction keeps every actual prime-power location, one positive weight per prime base, a stretched-exponential prime-number-theorem error, the positive factorial ground, positive coefficients of a Suzuki-type Euler quotient, its first pole normalization, and the nonnegative complete centered Goldbach heat square. Its completed first prime-clock variation still fails every one-sided bound of order \(x^\delta\), \(\delta<1/2\), and its centered Goldbach heat energy has logarithmic growth exponent exactly \(1\). Thus these properties do not supply the missing estimate in the [actual Suzuki criterion](suzuki-first-variation-weighted-prime-clock.md) or the [actual centered heat criterion](../goldbach/centered-goldbach-heat-lyapunov.md). The exact amplitudes \(\Lambda(p^r)=\log p\), the actual functional equation, or another constraint excluding this deformation must enter a successful argument.

This strengthens the qualitative PNT and factorial-ground test in the [earlier coherent-weight model](../prime-distribution/sparse-prime-weight-ground-positive-terminal-sign-countermodel.md) for the particular [pole-normalized Suzuki--Goldbach source](../goldbach/suzuki-goldbach-pole-normalizer-bridge.md). A [balanced-band companion](suzuki-balanced-prime-bands-pole-ground-countermodel.md) also preserves the actual factorial-ground limit and the first two right-hand Euler-pole coefficients while retaining the same bad clock and heat exponents. Neither construction asserts a Goldbach representation or transfers the actual Suzuki analytic continuation to its deformed Euler product.

## Construction and the completed prime clock

Choose \(A,a>0\) so that the unconditional complete Chebyshev estimate and its partially summed and heat-damped versions give, for large nonintegral \(x\) and small positive \(t\),
\[
 |\psi(x)-x|\le A x e^{-a\sqrt{\log x}},\qquad
 |r_1(x)|\le A\sqrt{x}e^{-a\sqrt{\log x}},\qquad
 |D(t)|\le A t^{-1}e^{-a\sqrt{\log(1/t)}},                 \tag{1}
\]
where the *actual* completed first variation is
\[
 r_1(x)=2\sum_{2\le n<x}\frac{\Lambda(n)}{\sqrt n}
       -4\sqrt x+\kappa-J(x),\quad
 \kappa=\gamma+\frac\pi2+\log(8\pi),\quad
 J(x)=\int_0^{x^{-2}}\frac{u^{1/4}}{1-u}\,du.             \tag{2}
\]
The first bound follows from [Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689), after reducing its exponential constant to absorb its logarithmic prefactor. For the second, Stieltjes partial summation gives
\(\sum_{n<x}\Lambda(n)n^{-1/2}=\psi(x^-)/\sqrt x+
\tfrac12\int_1^x\psi(y)y^{-3/2}dy\); the error integral is
\(O(\sqrt x e^{-a\sqrt{\log x}})\) after reducing \(a\) once more. The bounded \(\kappa-J(x)\) is absorbed. For the third, \(D(t)=\sum_{n\ge1}(\Lambda(n)-1)e^{-nt}\), and Stieltjes integration gives \(\sum\Lambda(n)e^{-nt}=t\int_1^\infty\psi(x)e^{-tx}dx\). The \(\psi(x)=x\) contribution differs from \(1/(e^t-1)\) by \(O(1)\). Split the PNT-error integral at \(x=t^{-1/2}\): its lower part is \(O(1)\), and the upper part is at most \(O(t^{-1}e^{-a_0\sqrt{\log(1/t)}/\sqrt2})\) for the original PNT exponent \(a_0\). We use the *same* smaller \(a\) in all three estimates.

Choose disjoint integer-scale bands
\(B_j=(X_j/2,X_j]\), with \(X_{j+1}>4X_j\),
\(\log X_j\ge j^4\), and the first \(X_j\) large enough that
\(\varepsilon_j=e^{-(a/2)\sqrt{\log X_j}}<1/2\).
Thus \(\sum_j\varepsilon_j<\infty\). For each prime set
\[
 \lambda_p=\begin{cases}1-\varepsilon_j,&p\in B_j,\\1,&p\notin\bigcup_jB_j,\end{cases}
 \qquad
 \Lambda_*(p^r)=\lambda_p\log p\quad(r\ge1),             \tag{3}
\]
and put \(\Lambda_*(n)=0\) off prime powers. In particular the same reduction applies to *every* power of each affected prime, and \(1/2<\lambda_p\le1\) with \(\lambda_p\to1\).

Define \(\psi_*(x)=\sum_{n\le x}\Lambda_*(n)\) and define
\(r_{1,*}(x)\) by (2) with \(\Lambda_*\) in place of \(\Lambda\), keeping the complete archimedean term \(\kappa-J(x)\) unchanged. At \(x_j=X_j+1/2\), ordinary PNT and partial summation give
\[
 \sum_{X_j/2<p\le X_j}\frac{\log p}{\sqrt p}
       =(2-\sqrt2+o(1))\sqrt{X_j}.                       \tag{4}
\]
Every changed weight is a reduction, so other bands and all their proper powers only lower \(r_{1,*}\). Consequently
\[
 r_{1,*}(x_j)
 \le r_1(x_j)-2\varepsilon_j
       \sum_{X_j/2<p\le X_j}\frac{\log p}{\sqrt p}
 \le-c\varepsilon_j\sqrt{X_j}                            \tag{5}
\]
for some \(c>0\) and all large \(j\): the error in (1) is
\(o(\varepsilon_j\sqrt{X_j})\). For every fixed \(\delta<1/2\),
\[
 \boxed{\displaystyle
 \lim_{j\to\infty}\frac{r_{1,*}(x_j)}{x_j^\delta}=-\infty.}
                                                               \tag{6}
\]
Indeed \(\varepsilon_j X_j^{1/2-\delta}=
\exp((1/2-\delta)\log X_j-(a/2)\sqrt{\log X_j})\to\infty\).
For the actual coefficient system the all-\(\delta>0\) one-sided bound is RH-equivalent; (6) is a countermodel to deriving it from the qualitative properties below.

## PNT strength and factorial ground survive

Write \(\Delta(x)=\psi(x)-\psi_*(x)\ge0\). For a changed base
\(p\in B_j\), \(\varepsilon_j\le e^{-(a/2)\sqrt{\log p}}\).
Split the prime bases in \(\Delta(x)\) at \(\sqrt x\).
Those at most \(\sqrt x\), including *all* their powers \(p^r\le x\), contribute at most
\[
 \sum_{p\le\sqrt x}\left\lfloor\frac{\log x}{\log p}\right\rfloor
                  \log p
 \le \pi(\sqrt x)\log x\le\sqrt x\log x.              \tag{7}
\]
For \(p>\sqrt x\) only \(r=1\) occurs; their contribution is at most
\(e^{-a\sqrt{\log x}/(2\sqrt2)}\vartheta(x)=
O(xe^{-a\sqrt{\log x}/(2\sqrt2)})\).
Combining this with (1), for some \(c_0>0\),
\[
 \boxed{\psi_*(x)=x+O(xe^{-c_0\sqrt{\log x}}).}       \tag{8}
\]
This retains every prime power and a strong PNT-quality envelope, though with a smaller exponent constant.

Let \(F\) be the actual positive factorial ground and put
\[
 F_*(x)=\log x-\sum_{n\le x}\frac{\Lambda_*(n)}n
                +\frac{\psi_*(x)}x.
\]
The exact comparison is
\[
 \boxed{F_*(x)-F(x)=
 \sum_{n\le x}(\Lambda(n)-\Lambda_*(n))
                    \left(\frac1n-\frac1x\right)\ge0.}   \tag{9}
\]
Thus \(F_*(x)>0\) for every \(x>1\), without requiring a small total perturbation. It is continuous through each prime-power atom and has the same distributional ground equation \((x^2F_*')'=dx-d\psi_*\). The [finite ground comparison](../../formalization/BuildingBlocks/FactorialGroundDownweightFinite.lean) compiles the exact integer-endpoint version of (9), its monotonicity under arbitrary downweighting, and its specialization to the actual von Mangoldt ground, with only standard logical axioms. The real-variable identity and this construction's infinite bounds remain written analysis.

The perturbation also satisfies
\(\sum_n(\Lambda(n)-\Lambda_*(n))/n<\infty\): for each band,
\[
 \sum_{p\in B_j}\sum_{r\ge1}\frac{\log p}{p^r}
 =\sum_{p\in B_j}\frac{\log p}{p-1}=O(1),              \tag{10}
\]
by the Chebyshev bound \(\vartheta(X)=O(X)\), and this is multiplied by summable \(\varepsilon_j\). Since \(\Delta(x)/x\to0\), (9) shows that \(F_*(x)\) tends to the actual positive limit \(1+\gamma\) plus the nonnegative convergent sum in (10).

## Positive Euler quotient, pole centering, and additive square

On \(\Re s>1\) define the generalized Euler product
\[
 Z_*(s)=\prod_p(1-p^{-s})^{-\lambda_p}=\zeta(s)H(s),
 \qquad H(s)=\prod_{p\in\bigcup_jB_j}(1-p^{-s})^{\varepsilon(p)}.
                                                               \tag{11}
\]
The logarithms use their absolutely convergent Euler expansions. Since
\(\sum_p\varepsilon(p)/p<\infty\) (each band has
\(\sum_{p\in B_j}1/p\le2\) and \(\sum_j\varepsilon_j<\infty\)),
\(H(s)\) is continuous from the right at \(s=1\) and
\(0<H(1)<\infty\). In particular
\(Z_*(s)\sim H(1)/(s-1)\) as real \(s\downarrow1\).
No meromorphic continuation across \(\Re s=1\) or functional equation is claimed.
Its logarithmic derivative has the complete deformed source:
\[
 -\frac{Z_*'(s)}{Z_*(s)}=\sum_{n\ge1}\frac{\Lambda_*(n)}{n^s}.
                                                               \tag{12}
\]
For \(\omega>0\) and \(\Re s>1+\omega\), write
\[
 \frac{Z_*(s-\omega)}{Z_*(s+\omega)}
 =\sum_{n\ge1}\frac{c^*_\omega(n)}{n^s},\qquad
 \log\frac{Z_*(s-\omega)}{Z_*(s+\omega)}
 =\sum_{p,r\ge1}\frac{\lambda_p}{r}
      (p^{r\omega}-p^{-r\omega})p^{-rs}.              \tag{13}
\]
All coefficients of the logarithm after its constant term are positive; exponentiation proves \(c^*_\omega(1)=1\) and \(c^*_\omega(n)>0\) for every \(n>1\). Coefficientwise differentiation at zero, using the odd logarithm, yields
\[
 c^*_0=\delta_1,\qquad
 (c^*_\omega)'_{0+}=2\Lambda_*,\qquad
 (c^*_\omega)''_{0+}=4(\Lambda_*\mathbin{*}\Lambda_*), \tag{14}
\]
where \(*\) in the last formula is **multiplicative** Dirichlet convolution. For \(\omega>0\), the *right-hand pole-strength coefficient* of the quotient in (13) at \(s=1+\omega\) is
\[
 a^*_\omega=\frac{H(1)}{Z_*(1+2\omega)}\sim2\omega,
 \qquad (a^*_\omega)'_{0+}=2.                         \tag{15}
\]
The wording “right-hand” is essential: (11) has only been defined on the convergence side of its boundary.

For \(n\ge1\) put
\(d^*_\omega(n)=c^*_\omega(n)-\delta_{n1}-a^*_\omega n^\omega\).
Then \(d^*_0(n)=0\) and its right derivative is
\(2(\Lambda_*(n)-1)\), including \(d^{*\prime}_0(1)=-2\).
For every fixed total \(N\ge2\), the finite ordered additive square therefore satisfies
\[
 \boxed{\displaystyle
 \lim_{\omega\downarrow0}\frac1{\omega^2}
    \sum_{a+b=N}d^*_\omega(a)d^*_\omega(b)
 =4\{R_*(N)-2\psi_*(N-1)+(N-1)\},}                  \tag{16}
\]
where \(R_*(N)=\sum_{a+b=N}\Lambda_*(a)\Lambda_*(b)\).
No multiplicative convolution is substituted for this Goldbach **additive** pair sum. At every \(t>0\) the real series
\(D_*(t)=\sum_{n\ge1}(\Lambda_*(n)-1)e^{-nt}\) converges absolutely, so its complete heat square \(D_*(t)^2\ge0\), with the coefficients in braces in (16). Thus even this centered positivity and the correct first pole normalization do not restrict the one-sided prime-clock error.

## The centered Goldbach heat exponent is exactly one

The positive square just identified can be large despite the strong PNT. Define its complete finite-horizon energy
\[
 \mathscr H_*(T)=1+\int_{e^{-T}}^1D_*(t)^2\,dt
 =1+\sum_{N\ge2}c_N^*
    \frac{e^{-Ne^{-T}}-e^{-N}}N,\qquad
 c_N^*=R_*(N)-2\psi_*(N-1)+(N-1).                       \tag{17}
\]
The series is absolutely convergent for each finite \(T\), because \(\Lambda_*\le\Lambda\le\log n\), and its identity with the integral is the exponential Cauchy product. It retains all signed centered coefficients, rather than truncating them or claiming they are nonnegative.

Let \(t\in[X_j^{-1},2X_j^{-1}]\). The current band's ordinary primes alone lower-bound the removed heat mass by
\[
 \sum_{n\ge1}(\Lambda(n)-\Lambda_*(n))e^{-nt}
 \ge\varepsilon_j e^{-2}
       \sum_{X_j/2<p\le X_j}\log p
 \ge \frac{e^{-2}}3\varepsilon_jX_j                  \tag{18}
\]
for all sufficiently large \(j\), by \(\vartheta(X_j)-\vartheta(X_j/2)\sim X_j/2\). Uniformly on this time interval, (1) gives
\(|D(t)|=O(X_j e^{-a\sqrt{\log X_j}})=
o(\varepsilon_jX_j)\). Hence
\(D_*(t)=D(t)-\sum(\Lambda-\Lambda_*)e^{-nt}
\le-c_1\varepsilon_jX_j\) for a fixed \(c_1>0\). At \(T_j=\log X_j\), the interval in (18) lies inside the energy horizon and has length \(X_j^{-1}\), so
\[
 \mathscr H_*(T_j)\ge c_1^2\varepsilon_j^2X_j
 =c_1^2\exp\{T_j-a\sqrt{T_j}\}.                       \tag{19}
\]
Conversely \(0\le\sum\Lambda_*(n)e^{-nt}\le
\sum\Lambda(n)e^{-nt}=O(t^{-1})\), while
\(\sum_{n\ge1}e^{-nt}=O(t^{-1})\). Thus \(|D_*(t)|=O(t^{-1})\),
\(\mathscr H_*(T)=O(e^T)\), and (19) proves the exact rate
\[
 \boxed{\displaystyle
 \limsup_{T\to\infty}\frac{\log\mathscr H_*(T)}T=1.}   \tag{20}
\]
The corresponding actual-source rate is \(0\) if and only if RH. Equation (20) concerns only the deformed weights. It shows directly that the listed positivity, complete histories, first pole centering, factorial ground, and stretched-exponential PNT do not control the **critical centered Goldbach energy**; the gap is as large in logarithmic exponent as the elementary heat bound permits.

For clarity, the actual finite Suzuki kernel can also be used with \(c^*_\omega\) in place of \(c_\omega\) to define a deformed arithmetic kernel. Its first variation at a fixed noninteger \(x\) is exactly \(r_{1,*}(x)\): at zero only the state-one coefficient contributes to the gamma derivative, while (14) supplies the deformed prime-power sum. This finite first-variation identity does **not** furnish the deformed kernel with Suzuki's actual zeta functional equation or his analytic RH criterion.

The countermodel leaves the support of ordinary primes unchanged, so it also leaves the truth value of any support-only Goldbach assertion unchanged. It proves only that the listed positive and first-order structural facts cannot imply the actual completed one-sided Suzuki bound or critical centered heat-energy bound. The [theta-form stress test](../theta-and-heat/theta-sparse-prime-form-stability-test.md) independently shows that the exact actual radical identity detects these bands at their full \(\varepsilon_j\sqrt{X_j}\) scale, despite small operator perturbations; that source-specific identity remains an open route to a signed bound. The infinite Euler-product assertions and the sparse-band asymptotics above remain written proofs; the finite ground comparison is the sole Lean formalization here. No RH proof is claimed.
