# Exact causal charge signs and the positive-process crossing law

The causal mixed source space, complete memory $K=B*$, derivative $A=(1/2-\partial)K$, and relative charge $\delta$ are those of the [original derivative response](charge-compensated-clock-response.md). The [anchoring theorem](charge-compensated-successor-memory.md#weighted-coercivity-and-the-bounded-extension) gives $\|e^{-u/2}f\|_2\le\|g\|_{\mathcal E}$ for $f(u)=e^{u/2}g(e^u)$. The actual source is $g(x)=1_{x\ge1}[\psi(x)-x]/x$, with physical representative $a(u)=e^{-u/2}[\psi(e^u)-e^u]$ and [relative charge](actual-successor-resonance-charge-cocycle.md) $\delta(a)=\kappa>0$.

This written proof gives exact signs for two scalar causal functionals and an entire scalar charge under the complete positive process. It uses every prime power. No statement about the sign of the full Weil form or a thermodynamic singularity follows.

## Exact scalar-column constants and prime cutoffs

Write $\ell=\log2$, $\widehat B(j)=\int e^{-jv}B(v)\,dv$ and $J=\widehat B(1)>0$. The [proved column identities](charge-compensated-clock-response.md), with $c_j=\binom{2j}{j}/4^j$, are

$$
 d_K(u)=\frac12\sum_{j\ge1}c_j e^{-ju}\widehat B(j),\qquad
 d_A(u)=\frac12\sum_{j\ge1}(1/2-j)c_j e^{-ju}\widehat B(j).
$$

The minimum delay makes these series and every fixed $u$-derivative uniformly convergent on $u\ge0$. A direct integration over every floor interval gives

$$
 J=\sum_p\sum_{j\ge1}p^{-j-1}
       \int_{j\log p}^{(j+1)\log p}e^{-v/2}dv
   =\sum_p\frac{2(1-p^{-1/2})}{p(p^{3/2}-1)}.
$$

For $0<z\le1/2$, rationalization gives

$$
 \frac z2\le(1-z)^{-1/2}-1
 =\frac{z}{\sqrt{1-z}(1+\sqrt{1-z})}
 \le2(\sqrt2-1)z.
$$

Every argument of the smooth charge branch in the columns is at least $\ell$. Hence

$$
 \frac J4e^{-u}\le d_K(u)\le(\sqrt2-1)Je^{-u}.
$$

Also $-[k'(v)+k(v)/2]=\sum_{j\ge1}(j-1/2)c_jz^j$ for $z=e^{-v}\le1/2$. Its ratio to $z$ increases from $1/4$ to $1$, the latter value following from $k'(\ell)+k(\ell)/2=-1/2$. Thus

$$
 -\frac J2e^{-u}\le d_A(u)\le-\frac J8e^{-u}.
$$

The column at the single input endpoint $u=0$ is its right limit. This convention does not cross a charge-kernel atom and does not alter integration against locally $L^2$ inputs. Weighted Cauchy–Schwarz gives

$$
 |\delta(Kf)|\le(\sqrt2-1)J\|g\|_{\mathcal E},\qquad
 |\delta(Af)|\le\frac J2\|g\|_{\mathcal E}.
$$

The original double integrals are absolutely convergent by these bounds, so Fubini identifies the functionals with their actual relative charges. In additive coordinates the first kernel is $x^{-1/2}d_K(\log x)>0$, of size $O(x^{-3/2})$. Its boundedness uses the causal anchor; no zero-integral condition on this kernel is asserted on an unanchored space. Individually divergent charges are not subtracted.

For $B_P=\sum_{p\le P}B_p$ and $J_P=\widehat B_P(1)$, the same comparisons applied to the positive difference show that both scalar functional tails are bounded by a fixed constant times $J-J_P$. The explicit summands above are $O(p^{-5/2})$. Chebyshev partial summation, or dyadic shells with $O(Y/\log Y)$ primes, gives

$$
 J-J_P\le\frac{C}{P^{3/2}\log P},\qquad
 \|\delta K-\delta K_P\|_{\mathcal E_c\to\mathbb C}
 +\|\delta A-\delta A_P\|_{\mathcal E_c\to\mathbb C}
 \le\frac{C}{P^{3/2}\log P}\quad(P\ge2).
$$

This is a scalar operator-norm estimate. It does not claim $K:\mathcal E_c\to\mathcal E_c$ is bounded or that the distributional derivative of $B$ is an $L^1$ function.

## 6. Actual arithmetic Laplace coefficients and the signs of the two ports

For the actual physical history
$$
 a(u)=e^{-u/2}[\psi(e^u)-e^u],\qquad u\ge0,
$$
define $L_a(j)=\int_0^\infty e^{-ju}a(u)du$, j≥1. Set s=j+1/2. Tonelli on the nonnegative Mangoldt part, followed by the elementary density integral, gives
$$
 \boxed{L_a(j)=\frac{-\zeta'/\zeta(s)}s-\frac1{s-1},
 \qquad s=j+\tfrac12.}
 \tag{17}
$$
This uses the full $\psi$, including every prime power. Both integrals converge absolutely because s>1.

For completeness, a discrete probability argument supplies a sufficient elementary inequality. Under
$$
 \mathbb P_s(N=n)=\frac{n^{-s}}{\zeta(s)},\qquad s>1,
$$
group the integers n≥m, for an integer m≥2, as n=mk+r with k≥1 and 0≤r<m. Then
$$
 \sum_{n\ge m}n^{-s}
 =\sum_{k\ge1}\sum_{r=0}^{m-1}(mk+r)^{-s}
 <m\sum_{k\ge1}(mk)^{-s}=m^{1-s}\zeta(s).
$$
Strictness holds because m≥2 and every r>0 term is strictly smaller. For every real x>1 use m=ceil(x), obtaining
$$
 \mathbb P_s(N\ge x)<x^{1-s}.
$$
Tonelli's tail formula and integration against dx/x now give
$$
 -\frac{\zeta'}{\zeta}(s)=\mathbb E_s\log N
 <\int_1^\infty x^{-s}dx=\frac1{s-1}.
 \tag{18}
$$
Strictness is retained under this integral. Equation (17) implies
$$
 -\frac1{j-1/2}\le L_a(j)<-\frac1{j+1/2}<0,
 \qquad |L_a(j)|\le\frac2j.
 \tag{19}
$$

The underlying zeta inequality is known, and a stronger sharp bound is available: Alzer--Kwong, *Some inequalities for the Riemann zeta function* (2021), Theorem 1.1, proves
$$
 \gamma<s\left(\frac{\zeta'}{\zeta}(s)+\frac1{s-1}\right)
 \quad(s>1).
$$
The primary statement is recorded in [Alzer–Kwong, *Some inequalities for the Riemann zeta function*](https://www.openstarts.units.it/handle/10077/31872). It strengthens (19) to
$$
 L_a(j)<-\frac1{j+1/2}-\frac\gamma{(j+1/2)^2}.
$$
The discrete argument above is an alternative elementary route to the weaker bound actually needed here, not a claim of a new underlying zeta inequality.

Expanding the exact columns above and using (17) gives
$$
 \boxed{\delta(Ka)=\tfrac12\sum_{j\ge1}c_j\widehat B(j)L_a(j)<0,}
 \tag{20}
$$
$$
 \boxed{\delta(\mathcal Aa)
 =\tfrac12\sum_{j\ge1}(\tfrac12-j)c_j\widehat B(j)L_a(j)>0.}
 \tag{21}
$$
For the first strict bound, for example,
$$
 \delta(Ka)<-\tfrac12\sum_{j\ge1}
 \frac{c_j\widehat B(j)}{j+1/2}.
$$
Both series are absolutely convergent. This follows directly from $\widehat B(j)\le2^{-(j-1)}J$ and (19). To justify exchanging the original signed source integral with the column expansion, the anchoring inequality gives
$$
 \int_0^\infty |a(u)|e^{-ju}du
 \le\|g\|_{\mathcal E}/\sqrt{2j-1},
$$
which supplies an absolute summable majorant before the signs are used. These are signs of the two specified scalar causal ports, not of their full operators or of the Weil form.

## 7. A unique charge crossing under the actual positive delay process

Let
$$
 \nu(dv)=B(v)\frac{dv}{v},\qquad
 \lambda=\nu((0,\infty)),\qquad
 \Phi(s)=\int(1-e^{-sv})\nu(dv).
$$
The rate is finite and positive; the measure is supported on v≥log 2. Let X_t have the compound Poisson law with jump measure ν and real process time t≥0, and let
$$
 \mathcal U_tg=\mathbb E R_{X_t}g.
$$
This is the [proved bounded causal action](positive-successor-seed-jump-process.md) on $\mathcal E$. Since δ is continuous on $\mathcal E_c$, the actual relative charge
$$
 Q_{\rm rel}(t)=\delta(\mathcal U_ta)
$$
is well-defined, with critical-coordinate conjugation understood. Its initial value is the established arithmetic constant $\delta(a)=\kappa>0$.

For any delay v≥log 2, the initial negative interval of k is inaccessible, and
$$
 \boxed{\delta(R_va)=\tfrac12\sum_{j\ge1}c_j e^{-jv}L_a(j)<0.}
 \tag{22}
$$
This identity is not asserted at v=0: the zero-delay history retains the original positive charge κ. The compound Poisson law has atom $e^{-\lambda t}$ at zero, and every other history has delay at least log 2. Keeping that atom separate and using its exact Laplace transform yields
$$
 \boxed{Q_{\rm rel}(t)=e^{-\lambda t}\kappa
 +\tfrac12\sum_{j\ge1}c_j L_a(j)
       [e^{-t\Phi(j)}-e^{-\lambda t}].}
 \tag{23}
$$
The exchange with the positive process law follows either from the continuous E-valued Bochner expectation and (22), or by absolute convergence: $c_j=O(j^{-1/2})$ and $|L_a(j)|\le2/j$. The series is locally normally convergent for complex t as well, since $0<\Phi(j)<\lambda$, so it defines an entire scalar function. Positivity of the process is used only for real t≥0.

Put
$$
 b_j=-\tfrac12c_jL_a(j)>0,\qquad
 \eta_j=\widehat\nu(j)>0,\qquad
 \beta=\sum_{j\ge1}b_j<\infty.
$$
Then $\Phi(j)=\lambda-\eta_j$, with $\eta_1>\eta_2>\cdots>0$. Equation (23) is exactly
$$
 \boxed{e^{\lambda t}Q_{\rm rel}(t)
 =\kappa-\sum_{j\ge1}b_j(e^{t\eta_j}-1).}
 \tag{24}
$$
The right side starts at κ, has strictly negative derivative for every real t≥0, and tends to minus infinity, already because of its j=1 term. Hence Q_rel has one and only one zero t_* on (0,∞), and that zero is simple. Quantitatively,
$$
 \boxed{\frac1{\eta_1}\log\left(1+\frac\kappa\beta\right)
 \le t_*\le
 \frac1{\eta_1}\log\left(1+\frac\kappa{b_1}\right).}
 \tag{25}
$$
Finally, $0<\Phi(1)<\Phi(2)<\lambda$, so (23) gives the stronger asymptotic with an explicit next exponential rate,
$$
 \boxed{Q_{\rm rel}(t)=-b_1e^{-t\Phi(1)}
 +O(e^{-t\Phi(2)}),\qquad t\to\infty.}
 \tag{26}
$$
This is a reversal of an actual arithmetic relative charge under the specified positive delay law. It is an ordinary zero of an entire scalar observable, not a thermodynamic singularity, a change in convergence domain, or an RH conclusion.

## 8. Exact initial normalization and all derivative crossing times

Define the positive branch on the full open half-line,
$$
 k_+(u)=(1-e^{-u})^{-1/2}-1,\qquad u>0.
$$
It differs from the actual relative-charge kernel k on the initial interval (0,log 2). There the actual source is exactly $a(u)=-e^{u/2}$, so $k_+(u)|a(u)|=O(u^{-1/2})$ at zero. On u≥log 2, $k_+(u)=O(e^{-u})$, and the anchoring inequality gives $\int e^{-u}|a(u)|du<\infty$. Therefore
$$
 \int_0^\infty k_+(u)|a(u)|du<\infty.
$$
The positive Taylor expansion of k_+ can consequently be exchanged with this signed source integral. It gives the exact identity
$$
 \beta=\sum_{j\ge1}b_j=-\tfrac12\int_0^\infty k_+(u)a(u)du.
$$
Adding the actual initial relative charge cancels the entire tail:
$$
 \begin{aligned}
 \kappa+\beta
 &=-\tfrac12\int_0^{\log2}[1+k_+(u)]a(u)du\\
 &=\tfrac12\int_0^{\log2}
       \frac{e^{u/2}}{\sqrt{1-e^{-u}}}du
 =\tfrac12\int_1^2\frac{dx}{\sqrt{x-1}}=1.
 \end{aligned}
 \tag{27}
$$
The improper endpoint at x=1 is integrable. Values at x=2 have no effect. Since κ>0 and every b_j>0, this also proves $0<\beta<1$ and $0<\kappa<1$.

Thus the entire charge observable has the normalized form
$$
 \boxed{Q_{\rm rel}(t)=e^{-\lambda t}
            -\sum_{j\ge1}b_j e^{-t\Phi(j)},
 \qquad\sum_{j\ge1}b_j=1-\kappa<1.}
 \tag{28}
$$
The coefficient one is forced by the actual initial interval, not chosen by rescaling the process.

For each integer n≥0, termwise differentiation is justified locally uniformly because $0<\Phi(j)<\lambda$ and $\sum b_j<\infty$. Hence
$$
 (-1)^nQ_{\rm rel}^{(n)}(t)
 =\lambda^n e^{-\lambda t}[1-F_n(t)],\qquad
 F_n(t)=\sum_{j\ge1}b_j
      \left(\frac{\Phi(j)}\lambda\right)^n e^{\eta_jt}.
 \tag{29}
$$
On the real axis F_n is strictly increasing, $F_n(0)\le\beta<1$, and its j=1 term forces $F_n(t)\to\infty$. Thus $(-1)^nQ_{\rm rel}^{(n)}$ has exactly one zero $\tau_n$ on (0,∞). It is positive before that zero and negative afterward. Moreover $F_{n+1}(t)<F_n(t)$ for every real t, so
$$
 \boxed{0<\tau_0<\tau_1<\tau_2<\cdots.}
 \tag{30}
$$
All these zeros are simple. In particular Q_rel strictly decreases until $\tau_1$, then strictly increases to zero from below. Its unique strict global minimum occurs after its unique zero $\tau_0$.

There is an explicit linear lower bound and an exact asymptotic slope. Since $\eta_j=\lambda-\Phi(j)$, the inequality $\log(1-x)\le-x$ gives $F_n(n/\lambda)\le\beta<1$. Write $\tau_n=n/\lambda+s$, so s>0. Using $0<\eta_j\le\eta_1$,
$$
 1=F_n(\tau_n)
 \le\sum_jb_j e^{\eta_js}
 \le\beta e^{\eta_1s}.
$$
Consequently
$$
 \boxed{\tau_n\ge\frac n\lambda+
                  \frac{\log(1/\beta)}{\eta_1},\qquad n\ge0.}
 \tag{31}
$$
For each fixed j, retaining its single positive term gives the upper bound
$$
 \tau_n\le
 \frac{-\log b_j-n\log(1-\eta_j/\lambda)}{\eta_j}.
 \tag{32}
$$
Here j is fixed before taking n to infinity. The finite positive jump measure, supported away from zero, satisfies $\eta_j\to0$. Therefore (32) implies
$$
 \limsup_{n\to\infty}\frac{\tau_n}{n}
 \le\frac{-\log(1-\eta_j/\lambda)}{\eta_j}
 \longrightarrow\frac1\lambda\quad(j\to\infty).
$$
Together with (31), this proves
$$
 \boxed{\lim_{n\to\infty}\frac{\tau_n}{n}=\frac1\lambda.}
 \tag{33}
$$
These are exact consequences for this normalized arithmetic charge observable and its positive delay process. They do not locate zeta zeros or assert positivity of the original signed readout.
