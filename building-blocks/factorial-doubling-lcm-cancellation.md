# Doubling blocks for the distorted LCM rows

The positive semiprime obstruction comes from ordered prime pairs
\((p,q)\) with \(p,q\asymp X\). Their LCM is \(pq\asymp X^2\), so the
radial kernel retains the prime pair and suppresses the orientations
containing the class endpoint \(pq\). This note identifies the negative
rows that can cancel that contribution.

The cancellation is not within one LCM class. It couples the class \(pq\)
to the classes \(2pq\) and \(4pq\) through the divisor involution
\(n\mapsto2n\).

## Exact terminal involution

Let

\[
P(z)=\sum_{n\ge1}\mu(n)z^n,
\qquad |z|<1.
\]

Every squarefree even integer is uniquely \(2m\), with \(m\) odd and
squarefree, and \(\mu(2m)=-\mu(m)\). Integers divisible by four have zero
Möbius coefficient. Hence

\[
\boxed{
P(z)=\sum_{m\ \text{odd}}\mu(m)(z^m-z^{2m}).}
\tag{1}
\]

This retains the endpoint \(m=1\): its block is \(z-z^2\). No prime,
squarefree composite, or proper-power zero has been dropped.

Squaring on a complex circle gives the exact two-point expansion

\[
|P(z)|^2=\sum_{m,n\ \text{odd}}\mu(m)\mu(n)
(z^m-z^{2m})(\overline z^{\,n}-\overline z^{\,2n}). \tag{2}
\]

For two odd primes \(p,q\), the four ordered orientations in (2) are

\[
(p,q),\qquad(p,2q),\qquad(2p,q),\qquad(2p,2q), \tag{3}
\]

with Möbius signs

\[
+1,\qquad-1,\qquad-1,\qquad+1. \tag{4}
\]

The positive row \((p,q)\) has LCM \(pq\). The two negative rows have LCM
\(2pq\), and the final positive row also has LCM \(2pq\). Thus the first
available cancellation crosses LCM classes. A proof that treats each class
separately cannot see it.

## Exact paired birth

The same involution has a finite-clock identity. If \(m\) is odd, split
the divisors of \(2m\) into \(d\mid m\) and \(2d\), with
\(\mu(2d)=-\mu(d)\). Directly from the complete birth formula,

\[
\boxed{
h_m(t)+h_{2m}(t)
=(1-e^{-t})\sum_{d\mid m}\mu(d)
 e^{-(2m/d-1)t}.}
\tag{5}
\]

The right side tends to zero as \(t\to\infty\), exactly canceling the
terminal values \(\mu(m)+\mu(2m)=0\). It retains every quotient history in
both births.

For an odd prime \(p\), (5) simplifies to

\[
b_p(t):=h_p(t)+h_{2p}(t)
=(1-e^{-t})(e^{-(2p-1)t}-e^{-t})<0. \tag{6}
\]

Consequently

\[
b_p(t)b_q(t)>0\qquad(t>0). \tag{7}
\]

If all four orientations in (3) carried the same kernel weight, their
actual clock sum would be the positive pairing

\[
\langle b_p,b_q\rangle_{\mathcal H}>0, \tag{8}
\]

not zero or negative. The negative prime-semiprime rows cancel the hard
terminal reserve, but a finite quotient-history reserve remains. This is
why terminal sign counting alone does not prove the required upper bound.

## The exact four-row soft-kernel block

For any odd \(m,n\), define the second-difference kernel

\[
\boxed{
K_X^{(2)}(m,n)=
\kappa_X(m,n)-\kappa_X(m,2n)
-\kappa_X(2m,n)+\kappa_X(2m,2n).}
\tag{9}
\]

At the hard clock, where \(h_j\) is replaced by \(\mu(j)\), the complete
four-row contribution is

\[
\mu(m)\mu(n)K_X^{(2)}(m,n). \tag{10}
\]

Thus the terminal part of the central covariance is exactly the
two-point Möbius correlation

\[
\boxed{
\sum_{m,n\ \text{odd}}\mu(m)\mu(n)K_X^{(2)}(m,n),}
\tag{11}
\]

with the diagonal removed or retained according to the central covariance
decomposition. Formula (11) contains every orientation in (3). It is the
minimal signed block that pairs the positive semiprime row with its
negative doubled rows.

The matrix \(K_X^{(2)}\) is positive semidefinite before multiplication by
the Möbius signs. Indeed, if

\[
v_j(\theta)=r^je^{ij\theta}-r^{2j},
\]

then (9) is the central weighted Gram kernel of
\(v_m-v_{2m}\). This proves

\[
K_X^{(2)}(m,m)\ge0, \tag{12}
\]

but gives no sign for its off-diagonal entries or for the signed
correlation (11).

## Location and size of the negative rows

Take distinct odd primes \(p,q\in[X,2X]\). The audited kernel estimate is

\[
\kappa_X(i,j)\asymp X
\]

for indices in any fixed multiple of this dyad, up to constants depending
only on that multiple. At hard clock the rows have signs

\[
\begin{aligned}
\mu(p)\mu(q)&=+1,\\
\mu(p)\mu(2q)&=-1,\\
\mu(2p)\mu(q)&=-1,\\
\mu(2p)\mu(2q)&=+1.
\end{aligned}\tag{13}
\]

The negative orientations therefore have the same individual scale as the
positive prime-prime reservoir. On the literal clock this is also visible
without a limiting argument. For \(t\ge\log10\),

\[
h_p(t)<-c,
\qquad h_{2q}(t)>c, \tag{14}
\]

uniformly for odd primes, so

\[
\int_{\log10}^\infty h_p(t)h_{2q}(t)w(t)dt<-c_w. \tag{15}
\]

There are \(\gg X^2/\log^2X\) ordered prime pairs. Hence each of the
positive and negative subfamilies in (13) has absolute aggregate scale

\[
\gg X^3/\log^2X. \tag{16}
\]

This identifies enough negative mass to cancel the semiprime obstruction.
It does not prove the cancellation, because the four kernel weights in
(9) differ by fixed-scale radial and angular amounts.

## Radial distortion is not a small error

On the positive real radius \(r=e^{-1/X}\), the paired terminal feature is

\[
r^m-r^{2m}. \tag{17}
\]

For \(m\asymp X\), both terms in (17) are fixed nonzero constants of
different sizes. Thus doubling is not a perturbation at the Abel scale.
The differences

\[
\kappa_X(m,2n)-\kappa_X(m,n),
\qquad
\kappa_X(2m,2n)-\kappa_X(2m,n) \tag{18}
\]

are generally of order \(X\), the same size as the original kernel. A
Lipschitz estimate cannot make (9) a lower-order remainder.

This is the precise failure of a direct involutive cancellation. The
involution cancels terminal coefficients algebraically, but the soft
horizon resolves the two members of each pair at different radial scales.

## Finite-clock proper-power remainder

Identity (1) is exact for the terminal Möbius source. The finite-clock birth
series also contains indices divisible by four, although their terminal
Möbius value is zero. The exact decomposition is

\[
\sum_{n\ge1}h_n(t)z^n
=\sum_{m\ \text{odd}}
 [h_m(t)z^m+h_{2m}(t)z^{2m}]
 +\sum_{4\mid n}h_n(t)z^n. \tag{19}
\]

The last sum is the complete proper-power and higher-two-adic reserve. It
cannot be deleted from the original clock. The linear birth-variation bound
controls its diagonal loading, but supplies no sign for its covariance with
the paired odd blocks.

Within each odd block, insert (5):

\[
h_mz^m+h_{2m}z^{2m}
=z^m(h_m+h_{2m})+(z^{2m}-z^m)h_{2m}. \tag{20}
\]

The first term has no terminal reserve. The second is the exact radial
distortion, and for \(m\asymp X\) its scalar coefficient is of constant
size. Equations (19) and (20) retain both finite-clock remainders explicitly.

## Minimal unresolved estimate

After paying the diagonal, the terminal cancellation needed for an
\(O_\varepsilon(X^{2+\varepsilon})\) central estimate contains the bound

\[
\sum_{m\ne n\ \text{odd}}
\mu(m)\mu(n)K_X^{(2)}(m,n)
\le O_\varepsilon(X^{2+\varepsilon}). \tag{21}
\]

This is an explicit two-point Möbius correlation. Expanding
\(K_X^{(2)}\) recovers the positive prime-prime rows, the two negative
prime-semiprime rows, and the positive semiprime-semiprime row with their
actual radial weights.

Estimate (21) is not supplied by the divisor involution. It is a smoothed
two-point cancellation statement for Möbius values at odd integers. The
finite-clock problem additionally contains the quotient-history block in
(5), the radial distortion in (20), and the proper-power reserve in (19).

The useful conclusion is exact but bounded. The negative distorted LCM
classes are identified, all four orientations are paired, and their
individual mass matches the positive obstruction. The remaining estimate
is the signed correlation (21), together with the displayed finite-clock
reserves. No unconditional aggregate cancellation at the requested scale
is proved.

This is written analysis. The odd-doubling and finite-clock block identities have not been formalized in Lean.
