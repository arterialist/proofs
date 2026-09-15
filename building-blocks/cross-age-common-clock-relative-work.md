# Cross-age kernels and relative work in the original metric

This note uses the actual complete source g(x)=psi(floor x)/x-1
on x>=1. All formulas here are written proofs. No RH estimate is
assumed and no Lean certification of this note is asserted.

## Source times innovation before the process clock

For x=e^v define f_j(v)=sqrt(x)g(x+j) and
u_j(v)=sqrt(x)[g(x+j+1)-g(x+j)], with zero lower branch.
The original metric is dv, so

$$
 \|u_j\|^2=\int_1^\infty [g(x+j+1)-g(x+j)]^2dx.
$$

Although f_j need not belong to global L2, its pairing with u_j
is absolutely convergent. Indeed the interval (y,y+1] contains at
most one integer, and Chebyshev gives

$$
 |g(y+1)-g(y)|\le C\log(2y)/y.
$$

The unconditional PNT bound |g(y)|<=C exp(-a sqrt(log y)) makes
the product integrable, since its dominating tail has integral
bounded by a constant times
integral log(y) exp(-a sqrt(log y)) dy/y.
The innovation square is integrable as well.

Consequently the finite-interval square identity passes to the
limit without assigning a finite norm to f_j:

$$
 2\langle f_j,u_j\rangle+\|u_j\|^2
 =-\int_{j+1}^{j+2}g(y)^2dy\le0.                    \tag{1}
$$

To prove the endpoint exactly, integrate the difference of squares
over [1,R]. Translation leaves the upper cell
integral from R+j to R+j+1 of g^2, minus the lower cell in (1).
The upper cell tends to zero by g(y) tending to zero.
Thus the source-times-increment term before transport is not an
uncontrolled sign. Its combined relative work is negative.
This is an argument-translation identity for any g with the stated
relative convergence and tail limit. Its application to the actual
source is valid, but it is not a new prime-specific cancellation or
an identity for cutoff birth admission without its density term.

The charge compensation is a separate term. If e_j is the original
relative-charge driver and a0(v)=exp(-v/2)1_(v>=0), then

$$
 \int[(f_j+u_j-e_ja_0)^2-f_j^2]dv
 =-\int_{j+1}^{j+2}g^2-2e_jJ_{j+1}+e_j^2,
 \quad J_{j+1}=\int_1^\infty g(x+j+1)\frac{dx}{x}.       \tag{2}
$$

The integral defining J is absolutely convergent by PNT. Formula
(2) retains both seed cross terms together and ||a0||^2=1.
It does not identify J with e_j or claim a sign for (2).

## Exact transported birth kernel

Let delta_(n,j)(x) be the literal birth-density difference and
U_(n,j)(v)=2e^v delta_(n,j)(e^v). Write
A_(n,j)=max(1,n-j-1), B_(n,j)=max(1,n-j).
For a dilation history alpha=e^y>=1,

$$
 U_{n,j}(v-y)=\sqrt{\alpha x}
 \left[\frac{1_{x\ge\alpha A_{n,j}}}{x+\alpha(j+1)}
       -\frac{1_{x\ge\alpha B_{n,j}}}{x+\alpha j}\right].
                                                               \tag{3}
$$

This includes the shifted lower branch x>=alpha. Let

$$
 L(p,q;c)=\int_c^\infty\frac{dx}{(x+p)(x+q)}
 =\begin{cases}
 \log((c+q)/(c+p))/(q-p),&p\ne q,\\
 1/(c+p),&p=q.
 \end{cases}
$$

The formula holds for p,q>=0 and c>=1. With C_1=A, C_0=B,
epsilon_1=1, epsilon_0=-1, the full original-metric cross kernel is

$$
 G_{nj,mk}(\alpha,\beta)=\sqrt{\alpha\beta}
 \sum_{a,b\in\{0,1\}}\epsilon_a\epsilon_b
 L\left(\alpha(j+a),\beta(k+b);
       \max(\alpha C_{a,nj},\beta C_{b,mk})\right).       \tag{4}
$$

Equation (4) follows by multiplying (3) and integrating dx/x.
It is finite for every pair of histories. If pi_s is the actual
causal probability law, the transported finite-birth Gram is the
pi_s times pi_s expectation of (4), using two independent histories.
No positive exponential moment is needed for an individual kernel:
causal shifts are isometries on the zero-extended dv Hilbert space,
so its absolute value is bounded by ||U_(n,j)|| ||U_(m,k)||.
Complete-source sums must pass through the weighted L2 cutoff
limit and process contraction. This statement does not license an
unproved absolutely convergent double birth series.

At alpha=beta=1, aligned active strips n-j=m-k>=2 make both factors
have the same sign on their common strip and common tail. Their
Gram is strictly positive. In particular the actual primes
(n,j)=(2,0) and (m,k)=(3,1) already give a positive cross-age term.
Same-age negative mixing therefore cannot be copied to all ages.

For the compensated innovation u_j-e_j a0, write A_s=T_s a0.
Its transported cross-age quadratic is exactly

$$
 \langle T_su_j,T_su_k\rangle
 -e_k\langle T_su_j,A_s\rangle
 -e_j\langle A_s,T_su_k\rangle
 +e_je_k\|A_s\|^2.                                  \tag{5}
$$

All terms in (5) are defined in L2. It is the innovation covariance,
not yet the complete source relative work.

## The mismatch left by two distinct clock histories

For fixed alpha,beta let B=max(alpha,beta) and
H_j(x)=g(x/alpha+j)g(x/beta+j). The relative product work is

$$
 R_j(\alpha,\beta)=\frac1{\sqrt{\alpha\beta}}
 \int_B^\infty[H_{j+1}(x)-H_j(x)]dx.
$$

For each fixed pair this is absolutely convergent by PNT and the
bounded-length increment estimate. Shifting x by alpha gives

$$
 \sqrt{\alpha\beta}R_j(\alpha,\beta)
 =-\int_B^{B+\alpha}H_j(x)dx
 +\int_B^\infty g(x/\alpha+j+1)
   [g(x/\beta+j+1)-g(x/\beta+j+\alpha/\beta)]dx.       \tag{6}
$$

The upper product boundary vanishes by g tending to zero.
For alpha=beta the mismatch integral vanishes and the boundary
is a negative square, recovering (1) after change of variable.
For distinct histories the boundary is a signed product, and the
second integral survives. One can also write the beta-shift version
and average the two exact identities to retain symmetry.

Neither pointwise-in-history convergence nor probability
conservation proves that (6) can be averaged over the full law.
The law may have no positive exponential moments. A complete clock
consumer must prove a uniform integrable bound, or first use actual
frozen L2 sources with their density and endpoint and then prove the
relative-work limit. Dropping the mismatch or replacing it by the
same-history negative square would omit the live signed term.

## Symmetrization retains a sign-changing actual frozen port

Use the true frozen source
g_N(y)=E(min(y,N))/y for y>=1, with zero lower branch.
This freezes the continuum together with psi. Thus it has terminal
tail E(N)/y and belongs to the source L2 space after physical lift.
Define H and R as above using g_N. The alpha and beta versions of
(6) can be averaged exactly:

$$
 2\sqrt{\alpha\beta}R_j(\alpha,\beta)
 =-\int_B^{B+\alpha}H_j-\int_B^{B+\beta}H_j+M_\alpha+M_\beta,
$$

where M_alpha is the second integral in (6) and

$$
 M_\beta=\int_B^\infty g_N(x/\beta+j+1)
 [g_N(x/\alpha+j+1)-g_N(x/\alpha+j+\beta/\alpha)]dx.
$$

All terms exist for fixed N and histories. Symmetry exchanges the
two mismatches; it does not make their sum vanish. In fact the
symmetric work R has both signs for one actual frozen source.

Take N=14, j=12, alpha=1, beta=10. Put
P=psi(13)=log(360360) and e=P-14. Since Lambda(14)=0,

$$
 g_{14}(y)=P/y-1\quad(13\le y<14),\qquad
 g_{14}(y)=e/y\quad(y\ge14).
$$

The common lower endpoint is x=10. Before succession, the first
history is already in the frozen tail and the second crosses its
terminal corner at x=20. After succession both are in the frozen
tail for all x>=10. Direct rational integration therefore gives

$$
 \sqrt{10}R_{12}(1,10)=D,
$$
$$
 D=\frac{10e^2}{117}\log\frac{140}{23}
 -\frac{10eP}{108}\log\frac{104}{77}
 +e\log\frac{16}{11}
 -\frac{10e^2}{108}\log\frac{35}{8}>0.                  \tag{8}
$$

The strict sign has an exact rational certificate. For each positive
r used here, put z=(r-1)/(r+1) and bound log(r) by

$$
 2\sum_{k=0}^{127}\frac{z^{2k+1}}{2k+1}
 \quad\text{with error at most}\quad
 \frac{2|z|^{257}}{257(1-z^2)}.
$$

For P use 3log2+2log3+log5+log7+log11+log13.
Rational interval addition and multiplication in (8) yield
33/10000<D<34/10000. The displayed bound follows by summing the
remaining geometric series and replacing its denominators by 257.
These rational comparisons were evaluated directly; no floating
point sign is used. They are not yet Lean-certified.

In contrast, with this same N and j, equal histories give
R_12(1,1)=-integral from 13 to 14 of g_14^2<0.
The positive port in (8) is unchanged by exchanging alpha and beta.
It consequently survives exact history symmetrization. The moving
terminal corner, together with the unequal-dilation mismatch, is
the specific sign-changing port. This refutes a universal
nonpositive symmetric work kernel, not a polylogarithmic estimate
for its average under the complete actual process law. Charges and
their seed terms from (2) and (5) remain additional consumers.

## The complete actual clock average also changes sign

For this same frozen example, the full uncharged process work has
both signs. This conclusion uses the exact multiplier of the actual
process, so no history-law quadrature or positive age moment is needed.
Set f(v)=sqrt(x)g_14(x+12), h(v)=sqrt(x)g_14(x+13).
Both causal functions belong to L1 and L2, since their terminal tail
is O(exp(-v/2)). Let m0=integral f dv and m1=integral h dv.
Elementary integration with u=sqrt(x) gives

$$
 m_0=\frac{2e}{\sqrt{12}}\arctan\sqrt{12}+c,
 \quad m_1=\frac{2e}{\sqrt{13}}\arctan\sqrt{13},
$$
$$
 c=2\left[\frac{14}{\sqrt{12}}
   (\arctan(1/\sqrt6)-\arctan(1/\sqrt{12}))
                         -(\sqrt2-1)\right].
$$

An exact interval calculation proves

$$
 81/10000<m_1^2-m_0^2<82/10000.                        \tag{9}
$$

Here is a reproducible rational certificate specification. Bound
sqrt(n), for n=2,6,12,13, between k/10^12 and (k+1)/10^12,
where k is the integer square root of n times 10^24. Use monotonicity
to bound reciprocals and arctangents. For each rational argument
0<=r<1 use the 24-term alternating sum for arctan(r), with error
at most r^49/49. Replace arctan(sqrt(j)) by
pi/2-arctan(1/sqrt(j)). Bound pi by Machin's exact identity
16arctan(1/5)-4arctan(1/239), using the same series. Bound e by
the log series from (8). Rational interval operations give (9).
These exact rational inequalities were evaluated, but are not
yet Lean formalizations.

For the actual complete process, write
rho(xi)=integral (1-cos(xi y)) nu_B(dy).
The measure nu_B has finite positive mass lambda and an integrable
density positive on an interval. Hence rho is continuous, vanishes
only at zero, and tends to lambda as |xi| tends to infinity.
The last assertion is the Riemann-Lebesgue lemma; the zero assertion
follows because cos(xi y)=1 cannot hold almost everywhere on an
interval at nonzero xi. Thus

$$
 \inf_{|\xi|\ge\delta}\rho(\xi)>0\quad\text{for every }\delta>0.
$$

Define D(xi)=|hat(h)(xi)|^2-|hat(f)(xi)|^2 using the unnormalized
Fourier transform. It is continuous, integrable, and D(0)>0 by (9).
Plancherel and the exact process symbol give

$$
 \|T_s h\|^2-\|T_s f\|^2
 =\frac1{2\pi}\int e^{-2s\rho(\xi)}D(\xi)d\xi.        \tag{10}
$$

Choose delta>0 with D positive on [-delta,delta], and let eta be
the strictly positive rho gap outside this interval. By continuity
at zero choose epsilon in (0,delta) with rho<=eta/2 on
[-epsilon,epsilon] and D>=d>0 there. The positive part of (10)
is at least 2epsilon d exp(-s eta)/(2pi). Its negative part has
absolute value at most exp(-2s eta)||D||_1/(2pi). Thus (10) is
strictly positive for all sufficiently large s.

At s=0, (1) instead gives
||h||^2-||f||^2=-integral from 13 to 14 of g_14^2<0.
Therefore the COMPLETE actual process average changes sign for
the actual frozen source N=14 and ordinary successor age j=12.
This disproves a universal nonpositive uncharged relative-work
inequality for all frozen sources and process times. It does not
disprove a polylogarithmic accumulated-work bound, the specified
growing-cutoff clock, or a compensated sign with the exact charges.
Those are different claims. The counterexample also does not
identify ordinary age translation with arithmetic birth admission.


## Dependencies and certificate

The ordinary successor and original relative charge are those of the [successor charge construction](actual-successor-resonance-charge-cocycle.md); the finite-source density and terminal convention agree with the [original-source heat criterion](actual-short-time-psi-correlation.md). The process is the [complete positive prime-history law](positive-successor-seed-jump-process.md), not a diagonal choice of two equal histories. The convergence proof uses classical [effective PNT bounds](https://arxiv.org/abs/2204.01980), Fourier Plancherel and the Riemann–Lebesgue lemma. The negative initial relative-work identity is an exact translation boundary calculation.

[The exact rational certificate](cross-age-common-clock-certificate.py) independently evaluates both strict intervals in (8) and (9). It uses rational logarithm and alternating arctangent bounds with integer-square-root enclosures; no floating-point sign decision enters the proof. The complete-process sign conclusion then follows from the spectral gap away from frequency zero as proved above. This is written mathematics with an executed rational certificate, not Lean formalization. The positive-time threshold depends on this fixed source. No uniform cutoff threshold, charge-compensated sign or RH bound is asserted.
