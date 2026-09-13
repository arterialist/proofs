# Centered additive Lambda pairs and the original frozen source

This note uses precisely Bhowmik--Ruzsa, arXiv:1711.06442,
Theorem 2.1, and Goldston--Suriajaya, arXiv:2110.14250v2.
It concerns ordered additive representations weighted by the complete
von Mangoldt function. Ordinary Goldbach existence is a different,
nonquantitative assertion. The original physical norm and literal
frozen source are retained throughout.

The main consumer below is the unconditional inequality (15):
a positive circle majorant for the centered additive convolution
controls the actual frozen-source norm and accumulated clock
dissipation. The corresponding signed convolution remainder is
not replaced by that majorant in an equality.

## 1. Exact integer centering and the initial coefficient

Put
$$
 a_n=\Lambda(n)-1\quad(n\ge1),\qquad a_1=-1,\qquad
 E(N)=\sum_{n=1}^N a_n=\psi(N)-N.
$$
For ordered pairs define
$$
 G(k)=\sum_{\substack{i,j\ge1\\i+j=k}}\Lambda(i)\Lambda(j),
 \quad S(N)=\sum_{k\le N}G(k),
$$
$$
 c(k)=\sum_{i+j=k}a_i a_j,\qquad
 C(N)=\sum_{k\le N}c(k).
$$
Expansion before any estimate gives, for $k\ge2$,
$$
 c(k)=G(k)-2\psi(k-1)+(k-1).
$$
Therefore, for every integer $N\ge2$,
$$
 \boxed{
 C(N)=S(N)-2\sum_{j=1}^{N-1}\psi(j)+\frac{N(N-1)}2.
 }
 \tag{1}
$$
The lower endpoint $a_1=-1$, the ordered-pair convention, and
all prime powers enter this identity.

For the following integral only, extend $E(x)=\psi(x)-x$ to
$0\le x<1$, where it equals $-x$. Then
$$
 \sum_{j=1}^{N-1}\psi(j)=\int_0^N\psi(x)\,dx
$$
and (1) becomes
$$
 \boxed{
 S(N)=\frac{N^2}2+\frac N2+2\int_0^N E(x)\,dx+C(N).
 }
 \tag{2}
$$
The extension on $[0,1)$ is a bookkeeping device for (2);
the physical source below still vanishes for $x<1$.

For $0<r<1$, write $e(t)=e^{2\pi it}$ and
$$
 A(r,\alpha)=\sum_{n\ge1}a_nr^ne(n\alpha),\qquad
 I_N(1/r,-\alpha)=\sum_{j=1}^N r^{-j}e(-j\alpha).
$$
Absolute power-series convergence and Fourier orthogonality give
$$
 \boxed{
 C(N)=\int_0^1 A(r,\alpha)^2 I_N(1/r,-\alpha)\,d\alpha,\quad
 E(N)=\int_0^1 A(r,\alpha) I_N(1/r,-\alpha)\,d\alpha.
 }
 \tag{3}
$$
The first integrand is an ordinary complex square, not a squared
modulus. Both identities are independent of the chosen $r$.

## 2. The cited average formula keeps its complete zero sum

Goldston--Suriajaya's Theorem 1 gives the following unconditional
identity for the same integer endpoints and the same $C(N)$:
$$
 \boxed{\begin{aligned}
 S(N)={}&\frac{N^2}2
 -2\sum_\rho\frac{N^{\rho+1}}{\rho(\rho+1)}
 -(2\log(2\pi)-\tfrac12)N
 +2\frac{\zeta'}{\zeta}(-1)\\
 &-\sum_{k\ge1}\frac{N^{1-2k}}{k(2k-1)}+C(N).
 \end{aligned}}
 \tag{4}
$$
The nontrivial zeros are counted with multiplicities and are not
restricted to the critical line. The zero sum and trivial-zero
series converge absolutely for each fixed $N$.
Their Theorems 2--4 distinguish the signed remainder from its
positive circle majorant; under RH the latter is
$O(N\log^3N)$.
[Goldston--Suriajaya, v2, Theorems 1--4](https://arxiv.org/pdf/2110.14250v2).

Formula (2) also identifies exactly where the zero sum in (4)
occurs: it belongs to the integrated first-order discrepancy,
together with the displayed endpoint and archimedean terms.
An estimate for the remainder $C(N)$ is not an estimate for
$S(N)-N^2/2$ with those terms deleted.

Bhowmik--Ruzsa's Theorem 2.1 assumes
$S(x)=x^2/2+O(x^{2-\delta})$ for a fixed $\delta>0$ and
concludes a fixed zero-free strip to the left of one.
Their proof yields
$$
 E(N)=O_\delta\!\left(
 N^{1-\delta/6}\sqrt{\log N}\right)
 \tag{5}
$$
after reducing $\delta$, if necessary, to $0<\delta\le1$.
This is a quantitative average hypothesis, not Goldbach existence.
We use this direct bound without claiming that its elementary
argument alone gives the optimal zero-abscissa exponent.
[Bhowmik--Ruzsa, Theorem 2.1 and its proof](https://arxiv.org/pdf/1711.06442).

## 3. Parity is an actual lower-order contribution

An odd sum of two prime powers has exactly one even summand.
Let
$$
 \psi_{\rm odd}(y)=\psi(y)-(\log2)\lfloor\log_2y\rfloor
 \quad(y\ge1),
$$
and set it to zero for $y<1$. Directly from the ordered-pair
definition,
$$
 \boxed{
 \sum_{\substack{k\le N\\k\ {\rm odd}}}G(k)
 =2\log2\sum_{\substack{j\ge1\\2^j\le N-1}}
                         \psi_{\rm odd}(N-2^j).
 }
 \tag{6}
$$
The endpoint with residual summand one contributes zero.
This includes all powers of two and every odd prime power.

Goldston--Suriajaya's Theorem 7 proves the following asymptotic.
For clarity, we give its direct actual-power proof from (6):
$$
 S_{\rm odd}(N)=2N\log N+O(N)
 \tag{7}
$$
using the usual strong PNT envelope.
Indeed, if $J=\lfloor\log_2(N-1)\rfloor$, the sum of the density
terms is
$$
 \sum_{j=1}^J(N-2^j)=NJ-2^{J+1}+2
                  =N\log_2N+O(N).
$$
For $j<J$, $N-2^j\ge N/2$, so the total PNT error is
$O(N\log N e^{-b\sqrt{\log N}})=O(N)$.
The last term has error $O(N)$ by Chebyshev.
Removing even prime powers inside $\psi_{\rm odd}$ costs
$O(\log^2N)$. This proves (7) without independence assumptions.

Thus the even-only weighted sum is (4) minus the exact expression
(6), and has the additional term $-2N\log N+O(N)$.
Neither parity nor proper powers can be suppressed when discussing
the lower-order average. No assertion about two-prime existence
for every even integer follows from this calculation.

## 4. Preserve continuous density cells before entering the source norm

The actual finite source measure is
$$
 \nu_N=-\delta_1+\sum_{2\le n\le N}\Lambda(n)\delta_n
                         -\mathbf1_{[1,N]}(x)\,dx.
$$
Its cumulative function on $x\ge1$ is exactly
$E(\min(x,N))$; its cumulative function is zero below one.
Define two finite measures
$$
 \mu_N=\sum_{n=1}^Na_n\delta_n,\qquad
 \rho_N=\sum_{n=2}^N\delta_n-\mathbf1_{[1,N]}(x)\,dx.
$$
Then
$$
 \boxed{\nu_N=\mu_N+\rho_N,\qquad
 \nu_N*\nu_N=\mu_N*\mu_N+2\mu_N*\rho_N+\rho_N*\rho_N.}
 \tag{8}
$$
The cumulative value of $\rho_N$ is $-\{x\}$ on $1\le x<N$
and zero for $x\ge N$, including the integer endpoint $N$.
These are the exact density-ramp and cross corrections, not
discarded errors.

For $\beta_b(x)=\mathbf1_{x\ge b}/x$,
$\langle\beta_b,\beta_c\rangle=1/\max(b,c)$. Consequently
$$
 \boxed{
 Q_N(0):=\|g_N\|_2^2
 =\iint\frac{\nu_N(db)\nu_N(dc)}{\max(b,c)}
 =\int_1^N\frac{E(x)^2}{x^2}\,dx+\frac{E(N)^2}{N}.
 }
 \tag{9}
$$
The last term is the literal frozen tail, not a dispensable
boundary convention.

There is a precise distinction between the additive sum and this
Gram kernel:
$$
 \frac1{\max(b,c)}
 =\frac2{b+c}
  -\frac{2|b-c|}{(b+c)(b+c+|b-c|)}.
 \tag{10}
$$
The second term retains the difference coordinate as well as the
additive coordinate. Inserting the signed measure $\nu_N$ in
(10) gives an exact residual, including all three cell terms
in (8); no favorable sign follows from the pointwise sign of
its kernel.

This issue already occurs within the actual integer source.
At $N=3$, $a_1,a_2<0<a_3$. The correction in (10) paired
with $(1,2)$ is negative, whereas its pairing with $(1,3)$
is positive. Both pairs are part of the same fixed actual source.
This does not prove that a quantitative Goldbach theorem cannot
control the source norm; it shows why the sum-coordinate identity
alone is not that norm identity. The entire centered convolution
does determine the sequence through its square root and the fixed
coefficient $a_1=-1$; no interpolation ambiguity is asserted.

## 5. A positive circle majorant gives an unconditional source inequality

Now choose $r_N=e^{-1/N}$ and define
$$
 \mathcal E_G(N)=\int_0^1
       |A(r_N,\alpha)|^2\,|I_N(1/r_N,-\alpha)|\,d\alpha.
 \tag{11}
$$
It is finite and nonnegative for each $N$.
The geometric sum has the elementary bound
$$
 |I_N(1/r_N,-\alpha)|
 \le C\min\!\left(N,\frac1{\|\alpha\|}\right),\qquad
 \int_0^1|I_N(1/r_N,-\alpha)|\,d\alpha\le C\log(2N).
$$
For example its numerator is bounded because $r_N^{-N}=e$,
and its denominator is bounded below by a constant times
$\sqrt{N^{-2}+\|\alpha\|^2}$.
Weighted Cauchy--Schwarz in the second exact identity (3) proves
$$
 |E(N)|^2\le C\mathcal E_G(N)\log(2N).
 \tag{12}
$$
This is precisely Goldston--Suriajaya's Theorem 3 estimate,
reproduced to fix the normalization before its original-source
and action consumers (13)--(15).
In contrast the first identity in (3) gives only
$|C(N)|\le\mathcal E_G(N)$, in that direction.

On each actual open cell $n\le x<n+1$,
$E(x)=E(n)-(x-n)$. Hence
$$
 \int_n^{n+1}\frac{E(x)^2}{x^2}\,dx
 \le\frac{2E(n)^2}{n(n+1)}
       +2\int_n^{n+1}\frac{(x-n)^2}{x^2}\,dx.
$$
The density-cell error sums to a finite constant over all $n$.
Together with (9) and (12), this proves the unconditional bound
$$
 Q_N(0)\le C\left[
 1+\sum_{n=2}^{N-1}\frac{\mathcal E_G(n)\log n}{n^2}
       +\frac{\mathcal E_G(N)\log N}{N}\right].
 \tag{13}
$$
The $n=1$ cell and the initial charge are in the fixed constant;
the frozen endpoint remains displayed separately.

There is a direct clock-action consumer as well. Put
$a(v)=e^{-v/2}E(e^v)$ for $v\ge0$. The actual charge satisfies
$$
 m(v)=M(e^v)=a(v)+\frac12\int_0^v a(u)\,du.
$$
Finite-interval Hardy, retaining its nonpositive upper boundary,
gives
$$
 \int_1^R\frac{|m(v)|^2}{v^2}\,dv
 \le2\int_1^R|a(v)|^2\,dv+
       \frac12\int_0^R\frac{|\int_0^v a(u)du|^2}{v^2}\,dv
 \le4\int_0^R|a(v)|^2\,dv .
 \tag{14}
$$
This requires no completed $L^2$ source; all intervals are finite.

Use the proved [action comparison and exact integer density-cell bridge](total-clock-dissipation-and-signed-work.md).
For each fixed $c>0$, (14) and (12) imply
$$
 \mathbf D_c(N)\le C_c\left[
      1+\sum_{n=2}^{N-1}\frac{\mathcal E_G(n)\log n}{n^2}\right].
$$
Since the complete process contracts the original norm,
$J_N=\|T_{c\log N}a_N\|_2^2\le Q_N(0)$.
The exact seeded signed budget therefore satisfies
$$
 \boxed{\begin{aligned}
 1+2W_N+L_N
 &=J_N+\mathbf D_c(N)\\
 &\le C_c\left[
 1+\sum_{n=2}^{N-1}\frac{\mathcal E_G(n)\log n}{n^2}
       +\frac{\mathcal E_G(N)\log N}{N}\right].
 \end{aligned}}
 \tag{15}
$$
Here $W_N$ is the actual process-weighted birth work, $L_N$
its full diagonal loading, and $\mathbf D_c$ its clock action.
All quantities have their existing normalization.
No individual work term is assigned a sign.

## 6. Quantitative hypotheses and the remaining distinction

If the positive quantity (11) satisfies, for every $\epsilon>0$,
$$
 \mathcal E_G(N)=O_\epsilon(N^{1+\epsilon}),
 \tag{16}
$$
then (13)--(15) give subpower original source growth and subpower
actual signed-budget growth. Conversely RH gives (16), by the
positive-majorant estimate cited after (4). Thus (16) is
RH-equivalent: its forward implication already follows directly
from (12), or from the established original-source criterion.
It is not presently an unconditional estimate.

More explicitly, the RH estimate
$\mathcal E_G(N)=O(N\log^3N)$ yields from this particular
consumer
$$
 Q_N(0)+\mathbf D_c(N)=O_c(\log^5N).
$$
This is a deliberately coarse consequence of the positive circle
bound; sharper conditional source/action estimates already proved
elsewhere need not be replaced by it.

The separate Bhowmik--Ruzsa average hypothesis gives, through its
actual bound (5), the weaker but nontrivial quantitative transfer
$$
 Q_N(0)+\mathbf D_c(N)
 =O_{c,\delta}(N^{1-\delta/3}\log N),
 \qquad 0<\delta\le1.
 \tag{17}
$$
Here one uses (9), (14), and the full pointwise bound (5).
This records a power saving for the original norm/action from
that precise average hypothesis; it is not an unconditional
power saving or an optimal exponent claim.

The obstruction to going further is specific. The signed average
remainder $C(N)$ is $\int A^2I_N$, while the transferable
quantity is $\int|A|^2|I_N|$. The inequality between them goes
only toward the latter. The full zero sum in (4), the parity term
in (6), and the max-versus-sum residual (10) remain present.
Ordinary Goldbach existence supplies none of the quantitative
bounds used in (12)--(17). These identities and conditional
consumers do not prove RH.

## Dependencies and formal scope

The [literal additive successor transport](goldbach-literal-successor-counting-transport.md) gives the related shifted counting comparison. The original source, complete clock and signed work here use the [growing-time cocycle](growing-time-actual-source-cocycle.md) and [clock-action theorem](total-clock-dissipation-and-signed-work.md). The classical Goldston–Suriajaya and Bhowmik–Ruzsa inputs are stated with their hypotheses above; the original-source and clock bounds are their explicit consumers. These are written proofs, with no Lean formalization of the circle majorant or its source/action transfer. The majorant estimate equivalent to RH remains an unproved arithmetic target.
