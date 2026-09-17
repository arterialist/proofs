# A finite arithmetic certificate for actual norm-preserving comparison failure

This refutes universal norm-preserving finite-history monotonicity at one concrete actual prime, avoiding a PNT threshold. It complements the narrower-envelope positive comparison in the [finite-history chapter](finite-history-full-weil-monotonicity-obstruction.md). It concerns the actual full signed form and is not an RH counterexample or a Lean proof. The modulation frequencies exist by the finite prime-logarithm phase argument, but an explicit frequency threshold is not claimed.

Fix p=10007. Choose a nonnegative smooth compact real eta with 0<=eta<=1, eta=1 on [-1/16,1/16], and support in [-1/8,1/8]. Such a smooth plateau exists. Put N=||eta||^2 and R(y)=integral eta(v+y)eta(v)dv. Then

\[
 0\le R(y)\le N\le1/4,\qquad
 R(y)\ge1/16\quad(|y|\le1/16).
\tag{1}
\]

The lower bound uses the overlap of the plateau intervals: its length is at least 1/8-|y|. Use the real exactly pole-null f_t=-t^(-2)(partial^2-1/4)(eta cos(tv)), the actual V_(p,1)=(1-1/p)I-p^(-1/2)tau_(log p), and alpha=1-1/p+1/p^2. The disjoint translates give exactly ||V_(p,1)f_t||^2=alpha||f_t||^2. The gamma contribution to Q(Vf_t)-alpha Q(f_t) tends to zero. Both pole terms vanish exactly.

Take arbitrarily large frequencies with t log p tending to 0 modulo 2pi and t log q tending to pi modulo 2pi for every other observing base prime q. To justify arbitrarily late visits, distinct prime logarithms have no nonzero integer linear relation, by unique factorization. For each nonzero integer tuple k, the time average of exp(i t sum k_q log q) tends to zero. Uniform approximation by finite trigonometric polynomials then gives the Haar average of each continuous function on the finite phase torus. A nonnegative bump around any prescribed phase tuple has positive Haar integral and therefore arbitrarily late visits. Shrinking neighborhoods yield the required unbounded sequence. This is the classical continuous-time Kronecker–Weyl argument; no independence from 2pi is required. The limiting complete arithmetic readout is

\[
 F=\frac{1-1/p}{\sqrt p}
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                  R(\log(n/p))\sigma_p(n),
\tag{2}
\]

where sigma_p(p)=1 and sigma_p(q^k)=(-1)^k for q!=p. All observing prime powers remain in this sum. No higher base-p power can occur at this cutoff.


## Derivation of the full limiting readout

Use Q, A, B, C and the Fourier normalization from the finite-history chapter. Put L=log p and a=1-1/p. For u>=log2, the disjoint-support correlation identity is

\[
 C_{Vf_t}(u)=\alpha C_{f_t}(u)-a p^{-1/2}
 [C_{f_t}(u-L)+C_{f_t}(u+L)]
 =-a p^{-1/2}C_{f_t}(u-L).
\]

The correlations at u and u+L vanish since the packet support diameter is 1/4<log2. Compact support leaves only finitely many observing n at this fixed p. The full gamma asymptotic established in the companion chapter gives A(g_t)=log(t/(2pi))||g_t||²+o(1), for both f_t and Vf_t. Exact norm equality cancels its leading term. This uses the classical [digamma expansion, DLMF 5.11.2](https://dlmf.nist.gov/5.11.E2), not a zeta-zero assumption. Twice integrating by parts gives M_(±1/2)(f_t)=0, and translations preserve these zero moments. Thus

\[
 Q(Vf_t)-\alpha Q(f_t)=\frac{2a}{\sqrt p}
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}C_{f_t}(\log(n/p))+o(1).
\]

The literal derivative packet expands as eta cos(tv)+2eta' sin(tv)/t-(eta''-eta/4)cos(tv)/t². Trigonometric multiplication and integration by parts in the oscillatory 2t term give C_(f_t)(y)=R(y)cos(ty)/2+O_eta(1/t), uniformly for y in its compact support. Summing finitely many remainders and taking the stated phase sequence proves (2). In particular an observing q^k retains sign (-1)^k; even powers are never assigned a negative sign.

Both individual forms are positive at sufficiently high frequency because their gamma terms have positive leading coefficients N/2 and alpha N/2 multiplying log t, while the finite prime terms are bounded. Dividing the displayed difference by alpha is the exact quadratic normalization. No negative Weil test is produced.

## Twenty-four negative first-prime contributions

The following 24 actual primes lie in [9695,10319], and all differ from p:

9697, 9719, 9721, 9733, 9739, 9743, 9749, 9767,
9769, 9781, 9787, 9791, 9803, 9811, 9817, 9829,
9833, 9839, 9851, 9857, 9859, 9871, 9883, 9887.

Each satisfies |q-p|<=312<p/32, so |log(q/p)|<=1/31<1/16. Thus its R weight is at least 1/16. Also q>2^13 and q<102^2, giving log q/sqrt q>13 log2/102. Their total contribution to the sum in (2) is therefore at most

\[
 -\frac{24\cdot13}{1632}\log2.            \tag{3}
\]

All omitted first primes have nonpositive contributions, except p itself. Its positive contribution is at most

\[
 N\frac{\log p}{\sqrt p}<\frac{14}{400}\log2,
\tag{4}
\]

since N<=1/4, p<2^14, and sqrt p>100.

## Every possible positive proper power

The support condition R(y)=0 for |y|>1/4 restricts observing integers to p exp(-1/4)<=n<=p exp(1/4). This interval is contained in [3p/4,4p/3], since log(4/3)>1/4 (integrate 1/x on [1,4/3]). The complete even prime powers in the larger interval are exactly

89^2=7921, 97^2=9409, 101^2=10201, 103^2=10609,
107^2=11449, 109^2=11881, 113^2=12769.

For completeness: squares require a prime base between sqrt(3p/4) and sqrt(4p/3), namely the seven listed primes. No fourth power lies there: bases 7 and 11 bracket the interval with 7^4=2401 and 11^4=14641. No sixth power lies there: 3^6=729 and 5^6=15625 bracket it. For even exponent at least 8, only bases 2 or 3 could be small enough; 3^8=6561 and 3^10=59049 bracket the interval, while 2^12=4096 and 2^14=16384 bracket it. The lower even powers of 2 are smaller still, and bases at least 5 have eighth powers larger than the interval. Hence no other even power is omitted.

Each listed positive proper-power weight satisfies log q/q<7 log2/86, with R<=1/4. Their total positive contribution is at most

\[
 \frac{49}{344}\log2.                      \tag{5}
\]

Every odd proper power of another base prime contributes nonpositively and may be dropped for this upper bound. Base-p proper powers lie outside the whole observing range. Thus (5) retains a bound on all possible positive proper powers, including powers which the smaller actual support might already kill.

Combining (3)–(5), the finite sum in (2) is strictly negative because

\[
 \frac{24\cdot13}{1632}-\frac{14}{400}-\frac{49}{344}
                   =\frac{251}{18275}>0.
\tag{6}
\]

Consequently F<0 at this concrete actual prime. Dividing by alpha gives the negative limiting difference Q(alpha^(-1/2)V_(10007,1)f_t)-Q(f_t). Both individual forms are positive at sufficiently high frequency; this is a failure of norm-preserving monotonicity, not of Weil positivity.

The accompanying [exact integer verifier](../../certificates/finite-weil-prime-certificate.py) checks primality of p and the listed 24 primes by complete trial division. It exhaustively enumerates q^k in [3p/4,4p/3] and verifies the seven even powers, all window bounds, and the rational margin. The elementary completeness argument is also given above. These integer checks are not claimed as Lean certificates. The proof uses no PNT, artificial local factor, hypothetical prime vector, or dropped gamma/pole term. The narrow-envelope pointwise-positive comparison has a different support condition and remains compatible with this result.

## Formal arithmetic scope and attribution

[FiniteWeilPrimeCertificate](../../formalization/BuildingBlocks/FiniteWeilPrimeCertificate.lean) formalizes five finite arithmetic facts: primality of 10007, primality of all 24 selected integers, their exact integer window inequalities, their distinct count, and the rational margin. These compiled theorems use only Lean's standard axioms. [FiniteWeilEvenPowerCertificate](../../formalization/BuildingBlocks/FiniteWeilEvenPowerCertificate.lean) now adds four compiled theorems proving the exhaustive classification for every actual prime base q and every even exponent k>=2. The inequalities 3*10007<=4*q^k and 3*q^k<=4*10007 hold exactly when k=2 and q belongs to the seven listed bases. The proof derives k<14 from 2^14 exceeding the upper window and q<116 from q^2<=q^k; the remaining bounded implication is ordinary kernel-checked decide. The converse proves primality and both window inequalities for every listed base. Thus neither the base nor exponent cutoff is assumed. All four theorems use only propext, Classical.choice and Quot.sound. The smooth plateau, gamma asymptotic, phase-sequence existence and full form comparison also remain written mathematics requiring formalization.

RH Agent3 supplied the finite certificate and the broader fixed-envelope phase mechanism. RH Proof independently checked the exact shift and correlation signs, full prime-power enumeration, rational inequalities, gamma cancellation and pole-null convention, ran the exact integer calculation, and supplied the five initial Lean arithmetic proofs. RH Agent3 supplied the four-theorem exhaustive power classification; RH Proof independently checked its global bounds and integrated it. The method uses classical finite-dimensional approximation and gamma asymptotics, with no priority claim. It refutes this universal comparison only. It does not refute the prescribed fixed gamma-binary growing-history carrier or prove an arithmetic RH bound.
