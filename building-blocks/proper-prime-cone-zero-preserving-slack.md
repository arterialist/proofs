# Proper prime cones retain zeta zeros, but their concave inequalities have large slack

Research note, 16 September 2026. This is a finite structural result and a quantitative obstruction to one proposed use of it. It does not prove a new prime-error bound or the Riemann hypothesis.

## The apex-excluded cone

For an integer $X\ge2$, write $\bar f_X=X^{-1}\sum_{n\le X}f(n)$ and $q_X(d)=\lfloor X/d\rfloor$. Define

$$L_{X,f}(d)=\sum_{2\le m\le q_X(d)}(f(dm)-\bar f_X),\qquad 1\le d\le X.$$

If $f$ is increasing and concave on $\{1,\ldots,X\}$, then **$L_{X,f}(d)\ge0$ for every $d$**. The preceding finite clock theorem proves that the full-cone score $K_{X,f}(d)=\sum_{1\le m\le q_X(d)}(f(dm)-\bar f_X)$ is nonnegative. If $f(d)\le\bar f_X$, deleting its nonpositive first summand can only increase the score. If $f(d)\ge\bar f_X$, each summand of the proper cone is nonnegative because $f$ increases. This also covers the empty proper cone $q_X(d)=1$.

The cofactor sequence here is $a(1)=0$ and $a(m)=1$ for $m\ge2$, so its Dirichlet series is $\zeta(s)-1$. Since $\zeta(\rho)-1=-1$ at any zeta zero $\rho$, this transform **retains** every zero pole. More concretely, the exact arithmetic identity is

$$\sum_{d\le X}\Lambda(d)L_{X,f}(d)
=\sum_{n\le X}(\log n-\Lambda(n))(f(n)-\bar f_X)\ge0.$$

It follows from $\sum_{d\mid n}\Lambda(d)=\log n$ after removing the $d=n$ term. The Dirichlet series of $\log n-\Lambda(n)$ is $-\zeta'(s)+\zeta'(s)/\zeta(s)$ for $\Re s>1$. Its continuation has a pole with residue equal to the multiplicity of every nontrivial zero. This is a zero-sensitive positivity statement, unlike the full-cone multiplier $\zeta(s)$.

The positivity of $\sum_d\Lambda(d)L_{X,f}(d)$ itself uses only $\Lambda(d)\ge0$. The same sign holds with any nonnegative substitute for $\Lambda$, including sequences with arbitrarily large counting spikes. Actual arithmetic enters through $\Lambda*1=\log$, which converts the sign into the stated deterministic upper budget. Thus the sign alone carries no prime-distribution estimate.

At a fixed horizon, $L_{X,f}(d)=0$ for $d>X/2$. The proper-cofactor sequence has $a(1)=0$, so its finite divisor-convolution map is strictly triangular and cannot directly recover births in the newest half-window. Nonvanishing of $\zeta-1$ at global zeta zeros should not be mistaken for finite-horizon invertibility.

For $f(n)=\log n$, let $\ell_X=X^{-1}\log(X!)$, $V_X=\sum_{n\le X}(\log n-\ell_X)^2$, and $A_X=\sum_{n\le X}\Lambda(n)(\log n-\ell_X)$. The inequality says

$$A_X\le V_X=X+O(\log^2X).$$

The prime number theorem gives $A_X=o(X)$, so the positive proper-cone score $V_X-A_X=X+o(X)$. Its actual margin is therefore of order $X$.

Indeed, with $E(x)=\psi(x)-x$ and $\psi(x)=\sum_{n\le x}\Lambda(n)$, partial summation and Stirling give the exact-error relation

$$A_X=(\log X-\ell_X)E(X)-\int_1^X\frac{E(u)}u\,du+1-\tfrac12\log(2\pi X)+O(X^{-1}).$$

The $O(X)$ positivity budget does not yield an $O(X^{1/2+\varepsilon})$ estimate for this zero-sensitive score.

## Optimization over the entire increasing-concave cone

For $2\le t\le X$, set $r_t(n)=\min(n,t)$. Every increasing concave $f$ on $\{1,\ldots,X\}$ can be written as a constant plus $\sum_{t=2}^X c_t r_t$ with $c_t\ge0$. Explicitly, if $\Delta_j=f(j+1)-f(j)$ and $\Delta_X=0$, take $c_t=\Delta_{t-1}-\Delta_t$. Thus any linear inequality optimized over this cone reduces to one capped ramp.

Put $\delta_{X,t}=t(t-1)/(2X)$ and

$$C_{X,t}=\sum_{n\le X}\log n\,(r_t(n)-\bar r_{X,t}),\qquad
P_{X,t}=\sum_{n\le X}\Lambda(n)(r_t(n)-\bar r_{X,t}).$$

Since $\bar r_{X,t}=t-\delta_{X,t}$, direct summation gives

$$C_{X,t}=\delta_{X,t}\log(X!)-\sum_{j=1}^{t-1}\log(j!),$$

$$P_{X,t}=\delta_{X,t}\psi(X)-\sum_{k=1}^{t-1}\psi(k)
=\delta_{X,t}E(X)-\sum_{k=1}^{t-1}E(k).$$

The density terms cancel exactly in $P_{X,t}$. This shows that the ramps detect prime error, yet also shows the scale of the positive comparison. Uniformly for $2\le t\le X$, $C_{X,t}\ge C_{t,t}\ge(t^2-1)/12$: $\ell_X$ increases with $X$, and $\log m-\log n\ge(m-n)/t$ for $1\le n<m\le t$, so the last bound is $t^{-1}\sum_{n\le t}(n-(t+1)/2)^2$.

For $t\to\infty$ with $t\le X$, a summation or Euler--Maclaurin estimate gives

$$C_{X,t}=t^2\left(\tfrac12\log\frac Xt+\tfrac14\right)
+O\!\left(t\log X+\frac{t^2\log X}{X}\right).$$

In particular, a macroscopic ramp $t=\alpha X$ has deterministic margin of order $X^2$ before scaling $r_t$ by $X^{-1}$. A fixed $t\ge2$ has $C_{X,t}=\tfrac12t(t-1)\log X+O_t(1)$.

**Uniform slack theorem.** Using only the prime number theorem $E(x)=o(x)$,

$$\sup_{2\le t\le X}\frac{|P_{X,t}|}{C_{X,t}}\longrightarrow0,
\qquad
\sup_{\substack{f\text{ increasing concave}\\f\text{ nonconstant}}}
\frac{\left|\sum_{n\le X}\Lambda(n)(f(n)-\bar f_X)\right|}
{\sum_{n\le X}\log n(f(n)-\bar f_X)}\longrightarrow0.$$

To prove the first limit, fix $\epsilon>0$ and choose $T$ so $|E(k)|\le\epsilon k$ for $k\ge T$. For $X\ge T$, the exact ramp identity yields $|P_{X,t}|\le\epsilon t^2+B_T$, where $B_T=\sum_{k<T}|E(k)|$. The lower bound $C_{X,t}\ge(t^2-1)/12$ handles all sufficiently large $t$. For each of the finitely many remaining $t$, $P_{X,t}=-\sum_{k<t}E(k)+o(1)=O_t(1)$, whereas $C_{X,t}\sim\tfrac12t(t-1)\log X$. This proves uniformity. The second limit follows from the nonnegative ramp representation and the triangle inequality.

Hence no choice of increasing-concave clock test can nearly saturate this family of positive **linear** inequalities asymptotically. The result does not rule out a different nonlinear or phase-sensitive relation among cone channels. It does specify the missing step: positivity and zero retention alone supply no square-root cancellation.

## Provenance and scope

The full-cone increasing-concave order was proved in the [finite-clock building block](prime-cone-clock-variance-and-zero-annihilation.md). The proper-cone law, its exact prime identity, and the uniform slack theorem above are derived here. The prime number theorem input $\psi(x)=x+o(x)$ and the standard RH comparison $\psi(x)=x+O_\varepsilon(x^{1/2+\varepsilon})$ are recorded by the [NIST Digital Library of Mathematical Functions, §25.16(i)](https://dlmf.nist.gov/25.16.i). No claim of historical novelty is made for the finite inequality without a literature audit. The spectral calculation is a direct Dirichlet-series identity; it says the zeros remain visible, not that their location has been bounded.
