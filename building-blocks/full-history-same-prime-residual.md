# The unchanged same-prime subtraction under full causal histories

Use the original critical-age quantities
$$
\tau(v)=e^{-3v/2}T(e^v),\qquad
T(x)=\sum_{p^m\le x,\ m\ge2}(m-1)(\log p)^2(x-p^m),
$$
$$
\rho_* =\sum_{d\ge1}d^{-1}\delta_{\log d},\qquad
s=\rho_* *\tau,\qquad
\mathcal L_0=I-e^{-3v/2}\mathbf1_{v\ge0}*.
$$
All functions are causal and extended by zero to negative ages. Every prime power and each multiplicity $m-1$ remain in $T$. This $s$ is a function of physical age, not a complex transform parameter.

The complete actual readout is
$$
w_a=\rho_* *\mathcal L_0(a*a)-s
=e^{-3v/2}W(e^v).
$$
The source convention, exact arithmetic identities, and strict cumulative
comparison are given in
[the actual W analysis](actual-W-positive-primitive-analysis.md).
Applying the same causal probability history to both compared sources
preserves that cumulative order by positive convolution. This note
addresses the individual readout's additional same-prime term.
Section 4 gives an elementary global sign proof, proved below, uniformly over causal probability laws. Sections 1–3
retain separate PNT asymptotics; they are not needed for this global sign.

## 1. Direct prime-square calculation, including the constant

Let
$$
A_2(y)=\sum_{p\le y}(\log p)^2.
$$
The classical quantitative PNT, followed by partial summation, gives
$$
A_2(y)=y\log y-y+O(ye^{-c\sqrt{\log y}}).
\tag{1}
$$
Here and below a smaller positive $c$ can absorb logarithmic factors. An unconditional primary source is [Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689), which bounds the error in $\psi(y)$. Subtracting the higher powers, whose total is $O(\sqrt y\log y)$ by Chebyshev's bound, gives $\theta(y)=y+O(ye^{-c_0\sqrt{\log y}})$. Partial summation then proves (1); its boundary factor $\log y$ is absorbed after decreasing $c_0$. On bounded initial intervals the error constant is enlarged. This is the only asymptotic prime-distribution input.

The square contribution is
$$
T_2(x)=\sum_{p\le\sqrt x}(\log p)^2(x-p^2)
=2\int_0^{\sqrt x}yA_2(y)dy.
\tag{2}
$$
Use $A_2(y)=0$ below the first prime. Extending the integrable main expression $y\log y-y$ to zero only changes a bounded error. Inserting (1) gives
$$
T_2(x)=\frac13x^{3/2}\log x-\frac89x^{3/2}
+O(x^{3/2}e^{-c\sqrt{\log x}}).
\tag{3}
$$
The two constants follow from the literal integral
$$
2\int_0^Y(y^2\log y-y^2)dy
=\frac23Y^3\log Y-\frac89Y^3.
$$
The integrated PNT error has the form in (3), by splitting the integral at $\sqrt Y$ and decreasing $c$ if necessary.

Write $\tau_2(v)=e^{-3v/2}T_2(e^v)$. At every nonbirth age, and with the corresponding one-sided values at square births,
$$
\tau_2'(v)=e^{-v/2}A_2(e^{v/2})-\frac32\tau_2(v).
\tag{4}
$$
Equations (1), (3), and (4) therefore give
$$
\tau_2(v)=\frac v3-\frac89+O(e^{-c\sqrt v}),\qquad
\tau_2'(v)=\frac13+O(e^{-c\sqrt v}).
\tag{5}
$$
There is no differentiated PNT error in this argument. The derivative uses $A_2$ itself. At $v=2\log p$, the derivative jump has size $(\log p)^2/p$, which is also covered by the error envelope. The original tent is continuous at its birth.

## 2. All higher powers and their derivatives

For $m\ge3$ put
$$
\tau_m(v)=e^{-3v/2}
\sum_{p\le e^{v/m}}(m-1)(\log p)^2(e^v-p^m).
$$
Only $m\le v/\log2$ contribute. Positivity and the elementary prime-count upper bound by the number of integers give
$$
0\le\sum_{m\ge3}\tau_m(v)
\le e^{-v/2}\sum_{3\le m\le v/\log2}
(m-1)\sum_{p\le e^{v/m}}(\log p)^2
\le C(1+v)^3e^{-v/6}.
\tag{6}
$$
For the last inequality, use $(\log p)^2\le v^2/m^2$, $e^{v/m}\le e^{v/3}$, and sum the finite range of exponents. No exponent cutoff independent of $v$ is imposed.

Between births, a single summand has derivative
$$
(m-1)(\log p)^2e^{-v/2}
\left[-\frac12+\frac32p^me^{-v}\right]
\mathbf1_{v>m\log p}.
$$
The bracket has absolute value at most two on its support. The right derivative at a birth uses the same expression with the endpoint included; the left derivative omits it. Thus the same estimate gives
$$
\left|\sum_{m\ge3}\tau_m'(v)\right|
\le C(1+v)^3e^{-v/6}
\tag{7}
$$
for both one-sided conventions, and almost everywhere in the ordinary sense.

Combining (5)–(7), the complete function obeys
$$
\boxed{\tau(v)=\frac v3-\frac89+O(e^{-c\sqrt v}),\qquad
\tau'(v)=\frac13+O(e^{-c\sqrt v}).}
\tag{8}
$$
The derivative assertion is an almost-everywhere assertion with uniform one-sided versions at births, not a claim of classical differentiability at every prime power. The function is locally absolutely continuous and identically zero on $v<\log4$, including all negative ages. In particular $\tau(0)=\tau'(0+)=0$.

## 3. Harmonic aggregation and its derivative

For $v\ge0$ define
$$
R(v)=\tau(v)-v/3+8/9.
$$
Then $R(0)=8/9$, $R$ is locally absolutely continuous, and
$$
|R(v)|+|R'(v)|\le Ce^{-c\sqrt v}\quad(v\ge1),
\qquad \int_0^\infty R'(v)dv=-8/9.
\tag{9}
$$
On compact intervals $R'$ is bounded and piecewise continuous, with finitely many jumps. All the norms and integrals in (9) are ordinary ones after this explicit centering.

For $x=e^v$ and $M=\lfloor x\rfloor$,
$$
\begin{aligned}
s(v)
&=\sum_{d\le x}\frac1d\tau(v-\log d)\\
&=\left(\frac v3-\frac89\right)H_M
-\frac13\sum_{d\le x}\frac{\log d}{d}
+\sum_{d\le x}\frac1dR(v-\log d).
\end{aligned}
\tag{10}
$$
The standard elementary harmonic estimates, valid for real $x\to\infty$, are
$$
H_M=v+\gamma+O(e^{-v}),\qquad
\sum_{d\le x}\frac{\log d}{d}=\frac12v^2+O(1).
\tag{11}
$$
The error in the second formula is bounded by integral comparison, since the derivative of $(\log u)/u$ is absolutely integrable beyond a fixed point.

Every unit age interval has bounded $\rho_*$ mass:
$$
\rho_*([r,r+1])\le2\qquad(r\ge0).
\tag{12}
$$
Integral comparison for the corresponding harmonic sum proves this bound, with the possible first integer kept separately. Equation (9), summed over unit intervals, implies that the final term of (10) is uniformly bounded. Therefore
$$
\boxed{s(v)=\frac{v^2}{6}+cv+O(1),\qquad
c=\frac\gamma3-\frac89.}
\tag{13}
$$

The derivative needs more than differentiating the $O(1)$ remainder in (13). Directly from the locally finite sum and $\tau(0)=0$,
$$
s'(v)=\sum_{d\le e^v}\frac1d\tau'(v-\log d)
=\frac13H_M+\sum_{d\le e^v}\frac1dR'(v-\log d).
\tag{14}
$$
This holds almost everywhere and for the relevant one-sided versions. A new aggregation atom at $v=\log d$ introduces no value jump, because $\tau(0)=0$. The equality $\tau'(0+)=0$ also retains the derivative endpoint; in the last expression its two contributions $1/3$ and $R'(0+)=-1/3$ cancel.

We claim that
$$
\sum_{d\le e^v}\frac1dR'(v-\log d)
\longrightarrow\int_0^\infty R'(u)du=-8/9.
\tag{15}
$$
To prove this without a renewal or formal inversion assumption, fix $V$. In the range $0\le v-\log d\le V$, put $y=d/e^v$. The sum is a Riemann sum of mesh $e^{-v}$ for
$$
\int_{e^{-V}}^1\frac{R'(-\log y)}y\,dy
=\int_0^V R'(u)du.
$$
The integrand is bounded and Riemann integrable on this compact interval, including the finitely many actual prime-power discontinuities. This remains true for the right or left representatives. For the remaining ages, (9) and the uniform unit-interval mass bound (12) give a bound by
$C\sum_{j\ge V-1}e^{-c\sqrt j}$, independently of $v$. This tends to zero with $V$, proving (15).

Equations (11), (14), and (15) prove the complete derivative asymptotic
$$
\boxed{s'(v)=\frac v3+c+o(1),\qquad c=\frac\gamma3-\frac89.}
\tag{16}
$$
The limit is again uniform along the one-sided choices at births. This proof retains the higher powers and all integer aggregation endpoints. It uses prime sums and Riemann sums directly, not a residue calculation or Mellin inversion.

## 4. Elementary global monotonicity of the complete same-prime term

The following arithmetic mechanism, proved below, strengthens the eventual monotonicity that follows from (16). It uses no PNT estimate and requires no early-age maximum or unspecified threshold.

Set
$$
\vartheta(v)=(e^{-v/2}-e^{-3v/2})\mathbf1_{v\ge0},
\qquad h=\rho_* *\vartheta.
$$
For $x=e^v\ge1$, $k=\lfloor x\rfloor$, write
$$
A_k=\sum_{d=1}^k d^{-1/2},\qquad B_k=\sum_{d=1}^k\sqrt d.
$$
The exact harmonic aggregation is
$$
h(v)=x^{-1/2}A_k-x^{-3/2}B_k.
\tag{17a}
$$
A newly admitted summand at $x=d$ is zero. Thus $h$ is continuous at every integer birth, equals zero at $v=0$, and is zero at negative ages. On an open integer cell,
$$
h'(v)=\frac{3B_k-xA_k}{2x^{3/2}}.
\tag{17b}
$$
Define $F_k=3B_k-(k+1)A_k$. Direct calculation gives
$$
F_1=1,\qquad F_{k+1}-F_k
=\frac{2k+1}{\sqrt{k+1}}-A_k>0.
\tag{17c}
$$
Indeed $A_k\le1+\int_1^k u^{-1/2}du=2\sqrt k-1$, while
$$
\left(\frac{2k+1}{\sqrt{k+1}}\right)^2
=4k+\frac1{k+1}>4k.
$$
In fact every increment in (17c) is greater than one. Since $x<k+1$ on the cell, $3B_k-xA_k\ge F_k>0$. Equation (17b), continuity at births, and local absolute continuity prove that $h$ is strictly increasing on the entire nonnegative age line.

The exact finite coefficient bound has been compiled in the module
[SamePrimeAggregationKernel.lean](BuildingBlocks/SamePrimeAggregationKernel.lean):
its theorems prove
$F_k\ge k$ and $3B_k-xA_k\ge k>0$ throughout the closed cell
$x\in[k,k+1]$, for $k\ge1$. They reuse the already proved bound
$A_k\le2\sqrt k-1$. The exact closed-cell identity, derivative, endpoint
gluing, and monotonicity of the literal floor-sum kernel are compiled in
[SamePrimeAggregationMonotone.lean](BuildingBlocks/SamePrimeAggregationMonotone.lean).
The complete finite prime-power sum, coverage of every active power,
vanishing of inactive terms and exact birth terms, global nonnegativity
and monotonicity of $s$, and $s(v-r)\le s(v)$ for $r\ge0$ are compiled in
[SamePrimeHistoryResidual.lean](BuildingBlocks/SamePrimeHistoryResidual.lean).
The probability consumer is compiled in
[SamePrimeHistoryProbability.lean](BuildingBlocks/SamePrimeHistoryProbability.lean).
It derives measurability and integrability of the actual delayed
function and proves $-s(v)\le\int s(v-r)\,d\mu(r)-s(v)\le0$ for every
probability measure with nonnegative delays almost everywhere.
No extra integrability or monotonicity premise is assumed.
The first-square endpoint and strict activation are compiled in
[SamePrimeFirstSquare.lean](BuildingBlocks/SamePrimeFirstSquare.lean):
$s(v)=0$ through $v=\log4$, and $s(v)>0$ exactly when $v>\log4$.
[SamePrimeStrictDelay.lean](BuildingBlocks/SamePrimeStrictDelay.lean)
proves strict growth of the actual floor kernel across integer boundaries,
strict growth of $s$ on $[\log4,\infty)$, and
$s(v-r)<s(v)$ for $v>\log4$ and $r>0$.
Its theorem `samePrime_residual_neg` proves
$\int s(v-r)\,d\mu(r)-s(v)<0$ whenever $\mu$ is a probability measure,
its delays are nonnegative almost everywhere, $\mu((0,\infty))>0$,
and $v>\log4$. It derives the required integrability from these hypotheses.
These modules use only `propext`, `Classical.choice`, and `Quot.sound`.
The PNT asymptotics, polynomial bound, full $W$ identities, and process
transform theorems remain outside this formalization.

The literal same-prime tent has the exact shifted decomposition
$$
\tau(v)=\sum_p\sum_{m\ge2}(m-1)(\log p)^2p^{-m/2}
\vartheta(v-m\log p).
$$
Consequently
$$
\boxed{s(v)=\sum_p\sum_{m\ge2}(m-1)(\log p)^2p^{-m/2}
 h(v-m\log p).}
\tag{17d}
$$
Each sum is finite on every compact age interval. Every coefficient is positive, every shifted $h$ is nondecreasing, and new summands vanish at their birth endpoints. This proves that $s$ is globally nondecreasing and continuous. It is identically zero for $v\le\log4$. The single retained term $p=2,m=2$ has coefficient $(\log2)^2/2>0$ and is strictly increasing after that age. Hence $s$ is strictly increasing on $[\log4,\infty)$.

In particular the exact global delay comparison is
$$
\boxed{s(v-r)\le s(v)\qquad(v\in\mathbb R,\ r\ge0).}
\tag{17}
$$
For $v>\log4$ and $r>0$ it is strict, even when $v-r\le\log4$, because the earlier value is then zero. This proves the required endpoint statement directly from the first actual square, with all higher proper powers still present.

## 5. The full-history residual has the required sign

Let $\mu$ be any positive probability measure on causal ages, and let $f=\mu*a$. Keep the literal original same-prime subtraction unchanged:
$$
w_{\mu,a}=\rho_* *\mathcal L_0(f*f)-s.
$$
Local absolute Fubini gives the exact identity
$$
\boxed{w_{\mu,a}=(\mu*\mu)*w_a+\bigl[(\mu*\mu)*s-s\bigr].}
\tag{18}
$$
All exchanges can be made on a fixed age interval: the sources are locally bounded, the arithmetic measure is locally finite, and $\mu$ has finite total mass. This also covers laws with unbounded or infinite first moment.

Let $\nu=\mu*\mu$. Since it is a causal probability measure, (17) implies
$$
\boxed{[(\mu*\mu)*s-s](v)
=\int_{[0,\infty)}[s(v-r)-s(v)]\nu(dr)\le0
\quad(v\in\mathbb R).}
\tag{19}
$$
Equation (19) holds at every age for every causal probability law, including a law chosen as a function of observation age. Its left side is zero for $v\le\log4$. It is strictly negative for $v>\log4$ whenever $\mu\ne\delta_0$, since $(\mu*\mu)((0,\infty))=1-\mu(\{0\})^2>0$. For $\mu=\delta_0$ it is identically zero. There is no uniform strictly negative margin over laws approaching $\delta_0$.

In particular the individual full-history readout satisfies the genuine signed comparison
$$
\boxed{w_{\mu,a}(v)\le[(\mu*\mu)*w_a](v),\qquad v\in\mathbb R.}
\tag{20}
$$
For a compound-Poisson history its no-jump atom is retained: its contribution to (19) is exactly zero. At $v>\log4$, every positive-delay contribution is strictly negative. For an actual positive-time nontrivial process this makes (19) strict at precisely those ages; through the first-square endpoint the residual remains zero. No prime power has been evolved in the subtraction without being recorded; the extra term exists precisely because the original subtraction $s$ stays fixed.

## 6. Uniform whole-window remainder for the two actual readouts

Nonnegativity of $s$ and (19) give the two-sided bound
$$
\boxed{-s(v)\le[(\mu*\mu)*s-s](v)\le0}
\tag{20a}
$$
at every age, uniformly over all causal probability laws. This includes every process time and retains the exact same-prime subtraction.

There is an elementary polynomial upper bound, independent of the PNT asymptotics. From (17a), $0\le h(v)\le x^{-1/2}A_{\lfloor x\rfloor}\le2$. The square contribution in (17d) is at most
$$
2\sum_{p\le e^{v/2}}\frac{(\log p)^2}{p}
\le v\sum_{p\le e^{v/2}}\frac{\log p}{p}
\le C(1+v)^2.
$$
The last estimate follows by Abel summation from Chebyshev's bound $\theta(y)\le Cy$. Every higher-power contribution is bounded by the fixed convergent series
$$
2\sum_p(\log p)^2\sum_{m\ge3}(m-1)p^{-m/2}<\infty.
$$
Indeed the inner sum is at most $Cp^{-3/2}$ uniformly for $p\ge2$, and even $\sum_{n\ge2}(\log n)^2n^{-3/2}$ converges. Thus
$$
\boxed{0\le s(v)\le C(1+v)^2\qquad(v\ge0).}
\tag{20b}
$$
This bound and the global sign require no PNT; the more precise constants and derivative asymptotics in Sections 1–3 remain separate information.

Define the fully evolved-subtraction readout by
$$
w_{\mu,a}^{\rm evolved}
=\rho_* *\mathcal L_0[(\mu*a)*(\mu*a)]-(\mu*\mu)*s
=(\mu*\mu)*w_a.
$$
Then (18) and (20a)–(20b) give, on every complete window $[0,T]$,
$$
\boxed{\sup_{0\le v\le T}
|w_{\mu,a}(v)-w_{\mu,a}^{\rm evolved}(v)|
\le C(1+T)^2,}
\tag{20c}
$$
with the same constant for every law and every time. Both sides must use the same law: this is precisely the uniform error for switching between the literal and fully evolved same-prime subtraction in a same-time window argument. In the original unnormalized $x$ variable the corresponding bound is $Cx^{3/2}(1+\log x)^2$, since $w(v)=e^{-3v/2}W(e^v)$. No polynomial bound for the unnormalized $W$ in the age variable is asserted.

## 7. Fixed-time poles and limitations of the comparison

For a fixed causal probability law, write $M_\mu(z)=\int e^{-zr}\mu(dr)$, holomorphic on $\Re z>0$. The transform of the residual is
$$
[M_\mu(z)^2-1]\,\mathcal L_s(z).
\tag{21}
$$
Equation (13) makes $\mathcal L_s$ holomorphic throughout $\Re z>0$. Thus the residual introduces no pole at an off-critical source zero in that half-plane.

For an actual fixed-time subordinator law, $M_{\mu_t}(z)=e^{-t\Omega(z)}$ is nonzero and holomorphic there. Every off-critical double pole of the source-square readout survives in $w_{\mu_t,a}$, with its coefficient multiplied by $e^{-2t\Omega(z)}$. Its order is unchanged for every zero multiplicity. This assertion is specific to the nonvanishing fixed-time transform; an arbitrary positive probability law may have complex zeros in its Laplace transform. A law varying with observation age does not define the same fixed convolution transform.

The positive convolution in (20) cannot be inverted as a sign-preserving operation. More importantly, this result does not supply a sign for $(\mu*\mu)*w_a$ itself. Thus it establishes the actual additional same-prime residual's global nonpositive sign, its strict negative sign after the first square for nontrivial laws, and its uniformity over complete causal histories, while leaving the sign of the original $W$, an evolved readout, and RH unproved.

The written one-sided diagonal-history sign criterion, a further consumer of the [diagonal transform](diagonal-process-time-W-transform.md), consumes this remainder at time $\theta v$. For every fixed $\theta>0$,
infinite mean gives
$(T_{\theta v}s)(v)=O_\theta((1+v)^2e^{-\delta_\theta v})$ for some
$\delta_\theta>0$. The literal subtraction therefore contributes
$-s(v)$ up to an exponentially small error. An eventual nonpositive
sign, or even a polynomial upper bound, for the complete literal
readout along a sequence $\theta\downarrow0$ would imply RH.
That arithmetic sign is not supplied by this remainder theorem.


## Formal arithmetic dependencies and exact scope

[ChronologicalPowerRatio.lean](BuildingBlocks/ChronologicalPowerRatio.lean) proves the distinct integer-moment monotonicity
$$\frac{B_{n+1}}{(n+2)A_{n+1}}<\frac{B_n}{(n+1)A_n}\qquad(n\ge1),$$
where $A_n=\sum_{d=1}^n d^{-1/2}$ and $B_n=\sum_{d=1}^n\sqrt d$. Its proof first bounds $A_n\le2\sqrt n-1$, then proves strict growth of $A_n/\sqrt{n+1}+1/(n+1)$. This controls the ratio of successive moment increments.

[ChronologicalDivisibility.lean](BuildingBlocks/ChronologicalDivisibility.lean) retains the complete chronological tent
$$S(x)=\sum_{d\le x}\frac{x-d}{\sqrt d}.$$
For every positive integer $r$, `probability_monotoneOn` proves that $\sqrt r\,S(x/r)/S(x)$ increases on $x>1$. It is precisely the divisibility probability for the positive weights $(x-d)/\sqrt d$. The proof compares the exact affine expressions on closed integer cells, whose newly born summand is zero, and glues them by finite induction. `determinant_nonneg` and `probability_mul_le` then prove
$$S(x/a)S(x/b)\ge S(x)S(x/(ab)),\qquad p_{ab}(x)\le p_a(x)p_b(x)$$
for all integers $a,b\ge1$ and $x>1$. No coprimality hypothesis is needed; $p_{ab}$ here denotes divisibility by the product $ab$, not the intersection event for arbitrary noncoprime $a,b$.

The eight adapted modules in this dependency chain compile in the central repository. The integral probability theorem is about the literal complete prime-power sum (17d), with all inactive/birth terms proved zero. The [filtered prime-block calibration](actual-W-positive-primitive-analysis.md#formal-prime-block-calibration-distinct-pairs-and-density-terms) is now formalized separately for the unaggregated $\tau$. Subsequent harmonic aggregation remains a separate formal identification. The written equalities (18)–(21), PNT asymptotics, polynomial estimate, and RH consumer remain outside this Lean batch. The methods use classical finite-sum inequalities, differentiation on exact cells and integration of monotone functions; no priority claim is made.
