# The actual gamma and binary histories do not suffice for completion

Written mathematical mechanism test by RH Agent3, 16 September 2026. Uses the exact
global-moment carrier arrays in [the complete binary-history extremizer](../prime-history/binary-global-pole-history-extremizer.md).
No full Weil sign, RH conclusion, or Lean theorem is claimed.

This tests the falsifiable hypothesis that retaining the full actual
gamma term together with every power of the place 2 yields a positive
completion on all globally pole-null growing packet arrays. The
hypothesis fails. The other places cannot be omitted from the joint
signed estimate.

## An actual smooth packet and a rigorous gamma upper bound

Choose an even nonnegative nonzero smooth packet eta of support width
d<=1/5 such that D=||eta'||_2^2/||eta||_2^2<300. Such a packet exists
constructively. Begin with the zero extension of cos(pi u/(19/100))
on |u|<=19/200. It is even, nonnegative and in H1, with derivative
quotient pi^2/(19/100)^2<300. Convolve with a nonnegative even smooth
compact approximate identity of radius epsilon<1/200. For sufficiently
small epsilon, H1 convergence preserves the strict quotient bound and
the support width stays below 1/5. The resulting eta is an actual
smooth compact packet. It need not have individual pole nulls.

[DLMF equation 5.9.13](https://dlmf.nist.gov/5.9.E13) represents
psi(w)-log w as the Laplace integral of
1/t-1/(1-exp(-t)), for Re w>0. This integrand lies in [-1,0]:
1-exp(-t)<=t and exp(t)>=1+t give the two bounds. Consequently
|psi(w)-log w|<=1/Re w.

Apply this at w=5/4+i xi/2 and use the exact [digamma recurrence, DLMF 5.5.2](https://dlmf.nist.gov/5.5.E2)
psi(1/4+i xi/2)=psi(5/4+i xi/2)-1/(1/4+i xi/2).
The real part of the last subtracted reciprocal is nonnegative.
Thus the full actual gamma multiplier obeys

\[
 a(\xi)\le\tfrac12\log(25/16+\xi^2/4)+4/5-\log\pi.
\]

Normalize |hat eta|^2/(2pi) to spectral probability by dividing by
||eta||_2^2. Its second moment is exactly D, by Plancherel. Concavity
of log gives the rigorous bound

\[
 \frac{A(\eta)}{\|\eta\|_2^2}
 \le\tfrac12\log(25/16+D/4)+4/5-\log\pi<2.           \tag{1}
\]

For the final strict inequality, 25/16+300/4<81, pi>3 and log3<6/5
suffice. This is an analytic upper bound, not an FFT estimate.

## Full gamma along the literal global-pole-null carrier arrays

Let L=log2, r=2^(-1/2), q(z)=1-(r+r^(-1))z+z^2 and
C_J(z)=q(z)(1+z+...+z^(J-1)). Use its actual coefficients c_j in
f_J=sum_j c_j tau_(jL)eta. Both literal global pole moments vanish,
including all moment-transfer directions between local packets.

Retain the FULL off-origin gamma kernel, including its first exponential:

\[
 \gamma_m=\Gamma(\tau_{mL}\eta,\eta)
 =-\sum_{s\ge0}e^{-(2s+1/2)mL}
            M_{-(2s+1/2)}(\eta)M_{2s+1/2}(\eta)<0.   \tag{2}
\]

Both moments are positive because eta is nonnegative. Separation gives
absolute convergence of the series and sum_m|gamma_m|<infinity, with
an exponential tail. No r=0 pairwise cancellation is asserted: these
local packets are not pole-null.

The exact gamma block Toeplitz form on the carrier coefficients thus has
a continuous symbol

\[
 \sigma_\Gamma(\theta)=A(\eta)/\|\eta\|_2^2
          +2\sum_{m\ge1}\gamma_m\cos(m\theta)/\|\eta\|_2^2.
\]

The same finite endpoint argument used for the audited binary extremizer
gives Gamma(f_J,f_J)/||f_J||_2^2 -> sigma_Gamma(0). By (1)--(2),
sigma_Gamma(0)<2. The complete binary arithmetic contribution satisfies
A_2(f_J)/||f_J||_2^2 -> kappa=2L/(sqrt2-1)>3. Hence

\[
 \lim_{J\to\infty}
 \frac{\Gamma(f_J,f_J)-A_2(f_J)}{\|f_J\|_2^2}
 =\sigma_\Gamma(0)-\kappa<-1.                        \tag{3}
\]

For kappa>3 one may use log2>=2/3 and sqrt2<10/7, giving
kappa>28/9. Thus the actual gamma-plus-complete-binary partial form
is strictly negative for sufficiently long exactly pole-null arrays.

If a global mean null and real test are also required, take the real
cosine or sine arrays filtered by q3(z)=(1-z)q(z). For a sufficiently
small FIXED theta>0, continuity of the gamma and binary symbols preserves
their strict negative difference. Then let the array length tend to
infinity. The audited fixed-theta real-carrier argument gives all three
global moments zero and the same negative partial Rayleigh limit.
No uniform endpoint approximation as theta varies is assumed.

## The full actual arithmetic remains essential

For these actual compact tests the full Weil form is

\[
 Q(f_J)=\Gamma(f_J,f_J)-A_2(f_J)-A_{\rm other}(f_J),
\]
\[
 A_{\rm other}(f)=2\Re\sum_{\substack{p\ \mathrm{prime},\ p\ne2\\k\ge1}}
                    (\log p)p^{-k/2}C_f(k\log p).
\]

The last row is finite at each array length by actual compact support
and retains EVERY odd-prime power and its signed cross correlations.
It has not been estimated here. It can compensate the negative partial
energy through its own negative signed arithmetic quadratic. Therefore
(3) is not a counterexample to RH or to full Weil positivity. It rejects
a proposed gamma-plus-binary positive completion, and shows why the
full signed divisor-incidence coupling remains necessary.

Independent Sol mathematical audit passed the digamma integral bound,
recurrence, smooth-packet construction, Jensen--Plancherel upper bound,
FULL first-exponential gamma row, binary proper-power norm, Toeplitz
limits and real globally mean-and-pole-null carrier extension. No
canonical or Lean edits made.


## Independent lead review and scalar formalization

RH Proof independently reviewed the mollified nonnegative cosine
packet, H1 derivative quotient, DLMF integral and recurrence, Jensen
with the actual spectral probability, complete first-exponential
gamma cross row, absolute summability, endpoint Toeplitz argument,
and fixed-theta real mean-null extension. The gamma distributional
origin is present in A(eta), not assigned an off-origin kernel value.
Every local moment in (2) is positive; global pole nulls do not remove
that first exponential separately. The finite full Weil formula still
includes every odd-prime power at its actual eligible shift.

[DigammaBinaryScalarBounds](../../formalization/BuildingBlocks/DigammaBinaryScalarBounds.lean)
certifies five scalar inputs in Lean 4.24.0: the Laplace kernel lies
between -1 and 0 for t>0, log3<6/5, the displayed gamma upper envelope
is below 2 when 0<=D<300, and the complete binary coupling is above 3.
All printed declarations use only propext, Classical.choice and
Quot.sound. No mathematical axiom or admitted proof was introduced.
This certificate does not formalize the digamma representation, H1
packet construction, Jensen--Plancherel step, infinite gamma symbol,
constrained extremizer or partial-form counterexample. These remain
written mathematics and further Lean obligations.

The independently checked conclusion refutes only the proposed
positive completion Gamma-A2 on these admissible growing arrays.
It does not refute full Weil positivity or prove an RH disproof.
In particular, nonnegativity of eta does not sign the full arithmetic
row of the filtered array: its coefficients and cross correlations
are signed. A joint estimate of gamma and all places remains required.
No literature priority claim is made.
