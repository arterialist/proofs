# Literal successor transport of the additive Goldbach source

The literal successor transports each full prime-power birth through a positive probability kernel. Its additive pair count has an exact escape formula and an $O(X)$ deficit using Chebyshev alone. Compensation retains both rank terms and a finite weighted constant. This written proof does not assert an additive prime-pair existence theorem, a global screw sign or an RH bound.

## Actual source and its counting measure

Write $\psi(x)=\sum_{n\le x}\Lambda(n)$, retaining every prime power, and

$$
g(x)=\psi(x)/x-1\quad(x\ge1),\qquad
a(v)=e^{v/2}g(e^v)1_{v\ge0}.
$$

The [literal causal successor and charge](actual-successor-resonance-charge-cocycle.md) give $Sg(x)=g(x+1)$ for $x\ge1$ and zero below one. Its compensated version is $Cg=Sg-\kappa/x$ on $x\ge1$, where

$$
\kappa=\sum_{n\ge2}\Lambda(n)
 [\arcsin(n^{-1/2})-n^{-1/2}]>0.
\tag{1}
$$

The completed counting functions associated with these sources are zero below 1 and, for x>=1,

$$
\Psi_S(x)=\frac{x}{x+1}\psi(x+1),\qquad
\Psi_C(x)=\Psi_S(x)-\kappa.
\tag{2}
$$

Thus their locally finite Stieltjes measures satisfy

$$
\mu_S=\sum_{n\ge2}\Lambda(n)K_n,\qquad
\mu_C=\mu_S-\kappa\delta_1,
$$
$$
K_n=\left(1-\frac1n\right)\delta_{n-1}
       +1_{x\ge n-1}\frac{dx}{(x+1)^2}.
\tag{3}
$$

Each K_n is a positive probability measure: its atom has mass 1-1/n, its complete tail has mass 1/n, and its cumulative function is x/(x+1) for x>=n-1 and zero otherwise. Every bounded interval sees finitely many n, so the sum in (3) is an exact local measure identity. In particular n=2 contributes the initial atom (log 2)/2 at x=1. The compensated initial atom is (log 2)/2-kappa; its sign is not assumed.

Integration by parts gives the useful normalization

$$
\int x^{-1/2}K_n(dx)
 =\frac12\int_{n-1}^\infty\frac{x^{-1/2}}{x+1}dx
 =\arcsin(n^{-1/2}).
\tag{4}
$$

Therefore kappa is precisely the absolutely convergent excess of these transported half-moments over the original n^{-1/2}. Subtracting kappa delta_1 cancels this excess. This is an identity of convergent differences, not subtraction of two infinite arithmetic moments.

## Exact additive pair leakage and its cofactor bound

Set

$$
\mathcal G(X)=\sum_{m+n\le X}\Lambda(m)\Lambda(n),\quad
\mathcal G_S(X)=(\mu_S*\mu_S)([0,X]).
$$

This convolution uses addition of physical coordinates. Convolution in logarithmic age instead encodes products. Since K_m*K_n is a probability supported on [m+n-2,infinity),

$$
0\le\mathcal R(X):=\mathcal G(X+2)-\mathcal G_S(X).
\tag{5}
$$

For s=X+2>=m+n its exact escape probability is

$$
r_{m,n}(X)=\frac{s-1}{s}
 \left(\frac1{s-m}+\frac1{s-n}\right)
 +\frac1{s^2}\log\frac{(s-m)(s-n)}{mn}.
\tag{6}
$$

To verify it, integrate the cumulative function of K_n against K_m, separating the atom. One obtains

$$
r_{m,n}=\frac1{s-n}+
 \frac{m-1}{m(s-m)}+
 \int_m^{s-n}\frac{dz}{z^2(s-z)}.
$$

An antiderivative of the integrand is

$$
\frac1{s^2}\log\frac z{s-z}-\frac1{sz}.
$$

Substitution and simplification yield (6). At the contact s=m+n the logarithm is zero and (6) equals 1/m+1/n-1/(mn), exactly the mass outside the initial pair atom. In the whole allowed region its logarithm is nonnegative. No tail has been removed.

Consequently

$$
\mathcal R(X)=
\frac{2(s-1)}s\sum_{m\le s-2}
 \Lambda(m)\frac{\psi(s-m)}{s-m}
+\frac1{s^2}\sum_{m+n\le s}\Lambda(m)\Lambda(n)
 \log\frac{(s-m)(s-n)}{mn}.
\tag{7}
$$

Both terms are nonnegative. Chebyshev's bound psi(y)<=C y makes the first term O(s). The second is O(1), since its logarithm is bounded above by log(s/m)+log(s/n), and

$$
\sum_{m\le s}\Lambda(m)\log(s/m)
 =\int_1^s\frac{\psi(u)}u du=O(s).
$$

Thus the complete arithmetic pair deficit satisfies

$$
\boxed{0\le\mathcal G(X+2)-\mathcal G_S(X)\le C(X+2).}
\tag{8}
$$

This improves the crude O(X log X) estimate by keeping the cofactor psi(s-m)/(s-m) before taking bounds. The proof requires no RH or prime-pair theorem.

PNT additionally yields R(X)=2X+o(X). For the first sum in (7), split m<=s-Y and m>s-Y. On the first part psi(s-m)/(s-m) tends uniformly to 1 as Y tends to infinity; on the second, Chebyshev bounds it while psi(s)-psi(s-Y)=o(s) for each fixed Y by PNT. First let s tend to infinity and then Y tend to infinity. The second term stays O(1).

## Exact compensated pair and the weighted constant

The rank-one port is retained before squaring:

$$
\mu_C*\mu_C=\mu_S*\mu_S-2\kappa\,\tau_1\mu_S
                         +\kappa^2\delta_2.
$$

For every X>=2 this gives

$$
\boxed{\mathcal G_C(X)=\mathcal G(X+2)-\mathcal R(X)
 -2\kappa\frac{X-1}{X}\psi(X)+\kappa^2.}
\tag{9}
$$

In particular the difference from the shifted original count is O(X), with every continuous pair contribution and both charge terms present. No positivity of mu_C or its convolution is asserted.

For the ordinary weighted readout define

$$
B_C(X)=\int_{[2,X]}u^{-2}(\mu_C*\mu_C)(du),\qquad
B(X)=\sum_{n\le X}n^{-2}\sum_{m+k=n}\Lambda(m)\Lambda(k).
$$

Let $D_G(X)=\mathcal G_C(X)-\mathcal G(X)$. The elementary bound G(X+2)-G(X)=O(X log X) follows from at most three integer pair-sum levels and r_2(n)<=log(n)psi(n). Equation (9) therefore gives D_G(X)=O(X log X). All measures vanish below 2. Stieltjes integration by parts proves

$$
B_C(X)-B(X)=\frac{D_G(X)}{X^2}
             +2\int_2^X\frac{D_G(u)}{u^3}du
=d_C+O\!\left(\frac{\log X}{X}\right),
$$
$$
d_C:=2\int_2^\infty\frac{D_G(u)}{u^3}du.
\tag{10}
$$

The integral for d_C is absolutely convergent. This constant must be restored before multiplication by sqrt(X). After that restoration the relative secondary readout tends to zero at rate O(log X/sqrt X). This comparison does not bound either preserved secondary term.

## Primary-literature connection and its limits

Matsumoto and Suzuki, JNT 280 (2026), 918–946, [arXiv v2](https://arxiv.org/html/2409.00888v2), Proposition 6.1 supplies an unconditional explicit formula for H_1. Their Theorem 1.1 requires RH and rational independence of distinct positive zero ordinates, with multiplicities retained. Theorem 1.2's converse uses every locally Riemann-integrable test, including unbounded tests. Theorem 1.3's screw condition is equivalent to RH, without the independence assumption. Their zero-based infinitely divisible law is not the project's unconditional prime-age law.

Substituting the project's literal F into their formula identifies

$$
H_1(X)=\sqrt X[1+\gamma-F(X)]-X^{-1/2}A(X),
$$
$$
A(X)=\log(2\pi)+\tfrac12\log(1-X^{-2})
 +\tfrac X2\log\frac{X+1}{X-1}-1.
\tag{11}
$$

Here $F$ is the [actual factorial potential](factorial-ground-state-original-l2-domain.md). Write $S(v)=H_1(e^v)$. Differentiating (11) using the literal $F′$ gives, for $v>0$,

$$
a(v)=(\partial_v-\tfrac12)S(v)
-e^{-v/2}[\log(2\pi)+\tfrac12\log(1-e^{-2v})].
\tag{12}
$$

For causal extension, the right-hand side also contains -S(0)delta_0, with S(0)=gamma+2-log(4pi). The logarithmic singularity is locally integrable; it cancels only in the full expression. These are classical explicit-formula specializations, not a priority claim.

The source-action calculation (3)–(10) supplies a coupled additive constraint on precisely that source, including its compensation. It does not derive a global screw sign from Goldbach existence. The repeated raw-successor bound below retains the evolving actual reference measure, but its growing-j cost is too large at the critical scale. Iterates of the compensated operator additionally retain their signed rank-one ports; one cannot replace the actual measure by an arbitrary positive measure and drop compensation.

## Uniform actual pair leakage for repeated raw succession

For an integer j>=1 the literal raw successor iterate is g_j(x)=g(x+j) on x>=1 and zero below one. Its completed counting function and positive measure are

\[
\Psi_j(x)=\frac{x}{x+j}\psi(x+j)\quad(x\ge1),\qquad
\mu_j=\sum_{n\ge2}\Lambda(n)K_{n,j}.
\]

Put a_n=max(1,n-j) and A_n=a_n+j=max(j+1,n). The exact birth law is

\[
K_{n,j}=\left(1-\frac{j}{A_n}\right)\delta_{a_n}
+\mathbf1_{x\ge a_n}\frac{j\,dx}{(x+j)^2}.
\]

Its atom and full tail sum to one, and its cumulative is x/(x+j) for x>=a_n, zero otherwise. Thus every n<=j+1 contributes to the actual atom at one; these early histories are retained. This is the raw iterate S^j, not the compensated iterate C^j.

Let G_j(X)=(mu_j*mu_j)([0,X]), with addition in physical coordinates, and assume X>=2. If psi(y)<=C_psi y for all y>=1, then

\[
\boxed{0\le\mathcal G(X+2j)-G_j(X)
\le5C_\psi^2j(X+2j).}
\tag{13}
\]

Here is a full proof with constants uniform in j. Set s=X+2j. First clamp each integer label n to A_n, retaining its original mass Lambda(n), and let nu_j denote this label measure. Its cumulative is zero below j+1 and is exactly psi(y) for y>=j+1. Its admitted pair count is

\[
\overline G_j(X)=\sum_{A_m+A_n\le s}\Lambda(m)\Lambda(n).
\]

Clamping can only remove pairs from G(s). Every removed pair contains an index at most j, since the label j+1 itself is unchanged. Therefore

\[
0\le\mathcal G(s)-\overline G_j(X)
\le2\psi(j)\psi(s)\le2C_\psi^2js.
\]

Next transport each clamped birth through its complete probability law. In the coordinate u=x+j, a birth at A has atom 1-j/A and tail density j/u^2 on u>=A. For A+B<=s the exact pair escape probability is

\[
r_{A,B,j}(s)=\frac{j(s-j)}s
\left(\frac1{s-A}+\frac1{s-B}\right)
+\frac{j^2}{s^2}\log\frac{(s-A)(s-B)}{AB}.
\tag{14}
\]

Indeed its unsimplified expression, separating the first atom, is

\[
\frac{j}{s-B}+\frac{j(A-j)}{A(s-A)}
+j^2\int_A^{s-B}\frac{du}{u^2(s-u)}.
\]

Use the antiderivative s^{-2}log(u/(s-u))-(su)^{-1} and collect the two rational coefficients to obtain (14). At pair contact it is j/A+j/B-j^2/(AB), the full mass outside the initial pair atom. All denominators are positive and the logarithm is nonnegative, since (s-A)(s-B)-AB=s(s-A-B)>=0.

Summing the first term of (14) against the actual clamped masses retains the complete cofactor psi(s-A)/(s-A). Its total is bounded by

\[
\frac{2j(s-j)}s\sum_A\nu_j(\{A\})
\frac{\psi(s-A)}{s-A}
\le2C_\psi j\psi(s)\le2C_\psi^2js,
\]

where the sum covers A<=s-(j+1). For the logarithmic term use

\[
\log\frac{(s-A)(s-B)}{AB}\le\log(s/A)+\log(s/B),
\]
\[
\sum_A\nu_j(\{A\})\log(s/A)
\le\sum_{n\le s}\Lambda(n)\log(s/n)
=\int_1^s\frac{\psi(u)}u\,du\le C_\psi s.
\]

Its total is at most 2C_psi^2j^2<=C_psi^2js, because s>=2j+2. Thus 0<=overline G_j-G_j<=3C_psi^2js. Adding the clamping loss proves (13). For j=0 the raw transport is the original atomic measure and the leakage is zero.

This is an unconditional inequality for the complete weighted Goldbach counts, derived by RH Proof from the actual repeated successor. It extends the fixed-successor comparison while keeping every early history and continuous tail; no priority claim is made. It does not establish Goldbach existence, a screw sign, or an RH-scale error. In particular j comparable to X permits an O(X^2) loss, so the estimate cannot control the X^{3/2} secondary scale in that regime. A bound for C^j would also need its actual signed compensation ports. Lean formalization of this uniform-j result remains unfinished.

### The critical-scale quadratic leakage is intrinsic

The quadratic cost at growing j is not merely a loss from Chebyshev estimates. Fix theta>0 and let j=floor(theta X). PNT implies the unconditional actual asymptotic

\[
\boxed{\mathcal G(X+2j)-G_j(X)
=2jX+2j^2+o(X^2)},\qquad
\frac{\mathcal G(X+2j)-G_j(X)}{X^2}\longrightarrow2\theta(1+\theta)>0.
\tag{15}
\]

To prove this without a Goldbach error assumption, use only the positive counting measures. If a positive locally finite measure on [0,infinity) has cumulative F and epsilon_X=sup_{0<=u<=X}|F(u)-u|, its additive pair count G_F obeys

\[
\left|G_F(X)-\frac{X^2}{2}\right|
\le\epsilon_X(2X+\epsilon_X).
\]

Indeed, compare the convolution integral integral_[0,X] F(X-u)dmu(u) with integral_[0,X](X-u)dmu(u)=integral_0^X F(u)du. The first error is at most epsilon_X F(X), and the second at most X epsilon_X; also F(X)<=X+epsilon_X. All integrals are finite on the indicated interval, and every boundary atom remains.

For the actual transported cumulative F=Psi_j, PNT gives delta_j=sup_{y>=j}|psi(y)/y-1| tending to zero. On 1<=u<=X, |Psi_j(u)-u|<=u delta_j, because u+j>=j; on 0<=u<1 the error is at most one. Thus epsilon_X<=1+X delta_j=o(X). The preceding estimate proves G_j(X)=X^2/2+o(X^2). PNT likewise gives the uniform cumulative approximation for the original psi on [0,s], hence G(s)=s^2/2+o(s^2), where s=X+2j is comparable to X. Their difference is (s^2-X^2)/2+o(X^2), exactly (15).

This rules out a uniform O(X^{3/2}) bound on the uncentered leakage at j proportional to X for the actual arithmetic. It does not rule out cancellation after subtracting the explicit density loss 2jX+2j^2 and retaining all compensation ports. The remaining centered error has only the o(X^2) control proved here; the required RH-scale estimate remains open. RH Proof derived this PNT consequence during the growing-successor attempt. It is written mathematics, not Lean-formalized, and no priority claim is made.

### A finite lower bound from both complete tails

For every real X>=2 and integer j>=1, set s=X+2j. There is also an unconditional lower bound using only the exact probability laws and actual finite Mangoldt counts:

\[
\boxed{\left[1-\left(\frac{X-1}{X+j-1}\right)^2\right]
\mathcal G(X+2j)
\le\mathcal G(X+2j)-G_j(X).}
\tag{16}
\]

To prove it, use the label coordinates U=x+j and V=y+j for an ordered birth pair m,n. Their independent laws have lower endpoints A=max(m,j+1), B=max(n,j+1), and cumulative probabilities 1-j/u above the respective endpoints. If A+B>s, their contribution to G_j(X) is zero. If A+B<=s, put q=j/(s-j-1), which lies strictly between zero and one. The events U>s-B and V>s-A each force U+V>s. Their probabilities are j/(s-B) and j/(s-A), both at least q, because A,B>=j+1. Independence makes the probability of their union at least 2q-q^2. Thus this pair's survival probability is at most (1-q)^2.

Every contributing clamped pair has m+n<=s. Summing the survival bound with the original nonnegative weights Lambda(m)Lambda(n) gives G_j(X)<=(1-q)^2 G(s). Pairs removed by clamping contribute their full weight to the leakage, so they also satisfy the lower bound. Since 1-q=(X-1)/(X+j-1), this proves (16). Strict tail events preserve all contact atoms, including the initial pair atom at X=2. No tail truncation or prime-pair existence assumption is used.

In particular, j>=X-1 forces at least three quarters of the shifted original weighted count to leak. More generally G(s)>=psi(s/2)^2, so the right side of (16) is bounded below by the displayed coefficient times psi(s/2)^2, using only pairs with both labels at most s/2. This is a finite arithmetic lower bound independent of PNT. It explains why an upper estimate of raw leakage cannot remove the density loss at growing shifts. It gives no sign or RH-scale bound after density centering, and it does not apply to the signed compensated iterate. RH Proof derived this bound from the complete birth laws. It remains written mathematics, with no priority claim and no Lean formalization yet.

### Mesoscopic successor leakage has a uniform first term

The exact escape formula gives a sharper result when the number of raw
successor steps is smaller than the Goldbach cutoff.  Let
\(\Delta_X=\sup_{X/2\le y\le 2X}|\psi(y)-y|\) and
\(\delta_Y=\sup_{y\ge Y}|\psi(y)/y-1|\).  For real \(X\ge16\) and
integers \(1\le j\le X/4\), the Chebyshev constant in (13) also gives
the **finite error estimate**
\[
\boxed{\quad
\left|\mathcal G(X+2j)-G_j(X)-2jX\right|
 \le Cj\left(j+\sqrt X+\Delta_X+X\delta_{\sqrt X}\right).
\quad}                                                        \tag{17}
\]
Here \(C\) is absolute once a Chebyshev constant is fixed.  Consequently,
uniformly over any range \(1\le j\le\eta(X)X\) with \(\eta(X)\to0\),
\[
\mathcal G(X+2j)-G_j(X)=2jX+o(jX).                       \tag{18}
\]
In particular \(j=\lfloor\sqrt X\rfloor\) has leakage
\(2jX+o(X^{3/2})\).  This is an unconditional asymptotic for the
**uncentered transport loss**.  It does not bound the centered original
Goldbach error or the signed ports of the compensated iterate.

To prove (17), write \(s=X+2j\), \(M=s-j-1=X+j-1\), and use the
clamped label measure \(\nu_j\) from the proof of (13).  If a pair
\((m,n)\) admitted by \(m+n\le s\) is removed by clamping, at least
one label, say \(m\), is at most \(j\).  The other must satisfy
\(n>M\): if \(n\le j+1\), both clamped labels add to \(2j+2\le s\),
while if \(n>j+1\) its clamped value is \(n\).  Hence the complete
ordered clamping loss is bounded by
\[
0\le\mathcal G(s)-\overline G_j(X)
 \le2\psi(j)\{\psi(s)-\psi(M)\}
 \le Cj(j+\Delta_X).                                      \tag{19}
\]
All endpoints here use the right-continuous \(\psi\); the inequality
\(n>M\) keeps a possible atom at \(M\) on the admitted side.
[`GoldbachSuccessorClampFinite.lean`](BuildingBlocks/GoldbachSuccessorClampFinite.lean)
compiles the removed-pair endpoint implication and the ordered-pair
product bound for the actual von Mangoldt weights.  Its two finite
factors are exactly the early \(\psi(j)\) mass and the moving terminal
strip mass in (19); it does not formalize the continuous escape kernel.

For the transport loss, split (14) into its rational and logarithmic
terms.  The latter is \(O(j^2)\) by the logarithmic estimate already
used in (13).  The rational term is exactly
\[
2j\frac{s-j}{s}Q,
\qquad
Q=\sum_{A\le M}\nu_j(\{A\})\frac{\psi(s-A)}{s-A}.
\]
The total clamped mass in this sum is \(\psi(M)\), since
\(M\ge j+1\).  On \(s-A\ge\sqrt X\), the ratio in \(Q\) differs
from one by at most \(\delta_{\sqrt X}\), costing at most
\(C X\delta_{\sqrt X}\).  On \(s-A<\sqrt X\), the clamped mass is
at most \(\psi(s)-\psi(s-\sqrt X)\le\sqrt X+2\Delta_X\), and
both the ratio and one are bounded by a Chebyshev constant.  Thus
\[
|Q-\psi(M)|\le C\{X\delta_{\sqrt X}+\sqrt X+\Delta_X\},
\qquad
|Q-X|\le C\{j+X\delta_{\sqrt X}+\sqrt X+\Delta_X\}.
\]
Because \((s-j)/s=1+O(j/X)\), these bounds and (19) prove (17).
The prime number theorem gives \(\Delta_X=o(X)\) and
\(\delta_{\sqrt X}=o(1)\), yielding (18) uniformly.  Every
prime-power label, early clamped atom and continuous tail of (14) is
retained.  The finite estimate and its PNT corollary are written
analysis; only the finite clamping factor is Lean-formalized.

The mesoscopic estimate also joins the macroscopic PNT argument into a
single density law **uniform over every integer successor depth**:
\[
\boxed{\quad
\lim_{X\to\infty}\sup_{j\ge1}
\frac{|\mathcal G(X+2j)-G_j(X)-2j(X+j)|}{j(X+j)}=0.
\quad}                                                        \tag{20}
\]
For completeness, fix \(0<\varepsilon\le1/4\).  When
\(j\le\varepsilon X\), (17) and the additional \(2j^2\) in (20)
bound the displayed quotient by \(C\varepsilon+o(1)\), uniformly in
\(j\).  When \(j\ge\varepsilon X\), put \(s=X+2j\).  The positive-measure
convolution estimate used to prove (15), together with PNT, gives
\(\mathcal G(s)=s^2/2+o(s^2)\) uniformly for \(s\ge X\).
The transported cumulative satisfies
\(|\Psi_j(u)-u|\le u\delta_{\varepsilon X}\) for \(1\le u\le X\)
and is zero below one, so the same estimate gives
\(G_j(X)=X^2/2+o(X^2)\) uniformly for \(j\ge\varepsilon X\).
As \((s^2-X^2)/2=2j(X+j)\) and both \(s^2/[j(X+j)]\) and
\(X^2/[j(X+j)]\) are bounded in this range by constants depending
only on \(\varepsilon\), the quotient tends uniformly to zero there.
Letting \(\varepsilon\downarrow0\) proves (20).  This relative density
law does not control the centered Goldbach fluctuation at the
\(X^{3/2}\) scale.

## Dependencies and formal scope

The [actual successor charge](actual-successor-resonance-charge-cocycle.md) fixes $\kappa$ and its convergent half-moment difference. The [factorial potential](factorial-ground-state-original-l2-domain.md) fixes the source in (11)–(12). The positive transport, additive convolution and Stieltjes integration use classical measure and summation tools; Matsumoto–Suzuki supply the attributed explicit formula and its separate conditional consumers. Every complete prime-power tail and both compensation terms are retained. The finite clamping product is compiled in Lean; the continuous transport, escape bound, PNT asymptotics and weighted comparison remain written proofs.

The [centered circle-majorant consumer](goldbach-additive-source-consumer.md) gives a separate quantitative route to the original source norm and clock action. Its positive majorant cannot be replaced by the signed additive remainder.
