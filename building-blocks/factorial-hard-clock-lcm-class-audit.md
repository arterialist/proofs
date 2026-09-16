# Audit of the hard-clock LCM class collapse

This audits `central-arc-lcm-class-collapse.md` and develops the obstruction
caused by rows whose LCM lies beyond the Abel horizon. The complete fixed
class coefficient is correct. It includes every ordered orientation and
the diagonal endpoint. Its favorable sign is not uniform when the class
label grows with \(X\): the radial kernel softly truncates the large-LCM
orientations that perform the cancellation.

Use the actual births

\[
h_n(t)=(1-e^{-t})\sum_{d\mid n}\mu(d)e^{-(n/d-1)t}
\]

and the audited centered kernel

\[
\kappa_X(i,j)=\frac1{2\pi}\int_{|\theta|<X^{-1/2}}
\frac{\operatorname{Re}\!\left[(r^ie^{\mathrm{i}i\theta}-r^{2i})
(r^je^{-\mathrm{i}j\theta}-r^{2j})\right]}
{|1-re^{i\theta}|^2}\,d\theta,
\qquad r=e^{-1/X}. \tag{1}
\]

## Complete hard-clock class coefficient

For an integer \(k\ge1\), define

\[
S(k)=\sum_{\operatorname{lcm}(i,j)=k}\mu(i)\mu(j)ij. \tag{2}
\]

If \(k\) is not squarefree, every pair with LCM \(k\) has at least one
nonsquarefree member, so its Möbius product vanishes. Hence \(S(k)=0\).

Suppose that \(k\) is squarefree. The sum is multiplicative over its prime
divisors. At one prime \(p\mid k\), the local exponent pairs whose maximum
is one are

\[
(1,0),\qquad(0,1),\qquad(1,1). \tag{3}
\]

Their signed weighted contributions are respectively

\[
-p,\qquad-p,\qquad p^2. \tag{4}
\]

Both orientations are present, and the last term is the diagonal endpoint.
Therefore

\[
\boxed{
S(k)=\prod_{p\mid k}p(p-2)
\quad(k\text{ squarefree}).}
\tag{5}
\]

The only diagonal pair in the class is \((k,k)\), with contribution
\(\mu(k)^2k^2=k^2\). Thus the complete ordered off-diagonal coefficient is

\[
\boxed{
S_{\ne}(k)=
\prod_{p\mid k}p(p-2)-k^2
\le0.}
\tag{6}
\]

Indeed,

\[
\prod_{p\mid k}p(p-2)
=k\prod_{p\mid k}(p-2)\le k\prod_{p\mid k}p=k^2. \tag{7}
\]

Equality holds only for \(k=1\), whose off-diagonal class is empty. For
every squarefree \(k>1\), (6) is strict. This proves the claimed sign with
all orientations and endpoints.

The unweighted complete LCM sum is

\[
\sum_{\operatorname{lcm}(i,j)=k}\mu(i)\mu(j)=\mu(k), \tag{8}
\]

because its local factor is \(-1-1+1=-1\). Removing the diagonal gives
\(\mu(k)-1\). Consequently the kernel-difference coefficient is exactly

\[
\sum_{\operatorname{lcm}(i,j)=k\atop i\ne j}
\mu(i)\mu(j)(ij-k^2)
=\prod_{p\mid k}p(p-2)-\mu(k)k^2. \tag{9}
\]

For a prime \(p\), (9) is \(2p(p-1)>0\). Thus the audit also confirms the
source note's warning: the distortion remainder alone has the wrong sign
on every prime class.

## Exact finite-row distortion

For a hard cutoff \(Y\), define the partial class coefficient

\[
S_Y(k)=\sum_{i,j\le Y\atop\operatorname{lcm}(i,j)=k}
 \mu(i)\mu(j)ij. \tag{10}
\]

If \(k\le Y\), every divisor of \(k\) is present and \(S_Y(k)=S(k)\).
If \(k>Y\), the row is incomplete and no sign survives.

The simplest exact example is \(k=pq\), where \(p\ne q\) are primes at
most \(Y\) but \(pq>Y\). The complete class contains the nine ordered
pairs

\[
(p,q),(q,p),(1,pq),(pq,1),(p,pq),(pq,p),
(q,pq),(pq,q),(pq,pq). \tag{11}
\]

The cutoff keeps only the first two. Hence

\[
\boxed{S_Y(pq)=2pq>0,} \tag{12}
\]

whereas the complete off-diagonal coefficient is

\[
pq(p-2)(q-2)-p^2q^2<0. \tag{13}
\]

The missing orientations in (11), including the diagonal endpoint, are
exactly what reverse the sign. This is a finite, explicit obstruction to
using complete-row negativity before the index cutoff is removed.

## The Abel kernel creates the same incomplete rows

The central problem has no literal hard cutoff, but its radial factor is a
soft cutoff. The full-circle version of the kernel is

\[
K_X(i,j)=
\frac{\rho^{\max(i,j)}-\rho^{i+j}}{1-\rho},
\qquad \rho=e^{-2/X}. \tag{14}
\]

For \(X\le i,j\le2X\), (14) satisfies

\[
K_X(i,j)\ge cX. \tag{15}
\]

The omitted angular arc \(|\theta|\ge X^{-1/2}\) has absolute kernel mass
\(O(\sqrt X)\), since the numerator factors are bounded and
\(|1-re^{i\theta}|^{-2}\ll\theta^{-2}\). Therefore, uniformly on this
dyad and for all sufficiently large \(X\),

\[
\boxed{\kappa_X(i,j)\ge c_1X.} \tag{16}
\]

Now take distinct primes \(p,q\in[X,2X]\). Their class label satisfies
\(pq\asymp X^2\). The prime births have the literal form

\[
h_p(t)=(1-e^{-t})(e^{-(p-1)t}-1)<0, \tag{17}
\]

so

\[
\langle h_p,h_q\rangle_{\mathcal H}>0. \tag{18}
\]

More quantitatively, on \(t\ge\log10\), both absolute values are at least
\(81/100\). Hence

\[
\langle h_p,h_q\rangle_{\mathcal H}\ge c_w>0 \tag{19}
\]

with a constant independent of \(p,q,X\).

By contrast, every other pair in the same LCM class (11) contains the
index \(pq\). Its radial factors are bounded by a polynomial in \(X\)
times

\[
r^{pq}\le e^{-X}. \tag{20}
\]

The proved variation estimate gives \(\|h_{pq}\|_{\mathcal H}^2\le C_0pq=O(X^2)\), while prime-birth norms are also polynomially bounded. Thus the combined contribution of the seven orientations in (11) containing \(pq\) is
\(O(X^Ce^{-X})\) for an absolute fixed \(C\). The two unsuppressed
orientations give

\[
2\kappa_X(p,q)\langle h_p,h_q\rangle_{\mathcal H}\ge c_2X. \tag{21}
\]

Therefore each such growing semiprime class is positive for large \(X\),
despite the negative complete fixed-class coefficient (6). This is the
exact soft-truncation distortion.

By the prime number theorem, \([X,2X]\) contains \(\gg X/\log X\) primes.
Summing (21) over ordered distinct prime pairs gives the positive subfamily

\[
\boxed{
\sum_{p\ne q\in[X,2X]}
\kappa_X(p,q)\langle h_p,h_q\rangle_{\mathcal H}
\gg\frac{X^3}{\log^2X}.}
\tag{22}
\]

Every term in (22) belongs to a different orientation of an actual
squarefree semiprime LCM row. No prime power or endpoint has been deleted;
the missing effect is caused by their exponentially smaller radial weight.

## Consequence for an aggregate upper bound

The exact complete-row decomposition remains valid:

\[
\mathfrak C_X=\mathfrak I_X+\mathfrak R_X, \tag{23}
\]

and the audited argument

\[
\mathfrak I_X\le O(X^2) \tag{24}
\]

is sound. The negative \(-h_k^2\) term is retained before estimating the
linear collapsed row, and the clock multiplier used there is square
integrable.

What fails is any classwise proof of

\[
\mathfrak R_X\le O_\varepsilon(X^{2+\varepsilon}) \tag{25}
\]

based only on (6). The semiprime rows in (22) already contribute
\(\gg X^3/\log^2X\) positively to the distortion. Negative contributions
from other incomplete classes must cancel them before (25) can hold.
Taking absolute values, treating classes separately, or discarding rows
whose LCM exceeds the Abel horizon loses that required cancellation.

This does not prove that the full \(\mathfrak R_X\) exceeds the target.
The remaining prime-composite and composite-composite rows can be negative.
It proves that exact LCM completeness alone cannot yield the aggregate
upper bound: the operative rows are not complete in the radial metric.

The obstruction is sharp in scale. A collision or positive-subfamily
budget pays at least \(X^3/\log^2X\), one power of \(X\) above the desired
central estimate. Any successful argument must establish cancellation
between different large-LCM distorted rows, rather than within each fixed
LCM class.

## Useful exact identities retained

The following pieces survive the audit and can be used safely:

1. The complete LCM ghost identity
   \[
   \sum_{\operatorname{lcm}(i,j)=k}h_i(t)h_j(t)
   =\beta(t)h_k(2t)
   \]
   is exact for every fixed \(k\) and every clock.
2. The frozen complete-row contribution has the unconditional one-sided
   payment \(\mathfrak I_X\le O(X^2)\).
3. The complete hard-clock coefficient (6) is nonpositive.
4. The exact distortion coefficient is (9), and prime classes make it
   positive.
5. At finite or radially soft horizons, semiprime rows obey the explicit
   positive distortion (12) and (21).

These facts isolate the remaining consumer. It is a cross-class signed
estimate for the incomplete rows, strong enough to cancel the positive
semiprime reservoir (22). No unconditional estimate of that strength is
proved here.

[HardClockWeightedLcmClass.lean](BuildingBlocks/HardClockWeightedLcmClass.lean) formalizes the actual prime-local weighted class, finite factor bounds and conditional squarefree induction/off-diagonal conclusion. The general actual squarefree multiplicativity recurrence and the soft-kernel estimates remain written obligations.
