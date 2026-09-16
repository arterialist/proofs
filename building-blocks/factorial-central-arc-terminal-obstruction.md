# Central-arc terminal obstruction

This independently reviewed written proof attacks the remaining central term from the audited angular Poisson
reduction. The result is a source-specific lower bound. It retains the
complete Möbius birth series, including every prime and composite history,
and shows that an upper bound of the desired size already controls a
smoothed Mertens sum at square-root scale.

Let

\[
r=e^{-1/X},\qquad \rho=r^2,
\qquad \Delta=X^{-1/2},
\]

and write

\[
H(z,t)=(1-e^{-t})\sum_{d\ge1}mu(d)
 \frac{z^d}{1-e^{-t}z^d},qquad
P(z)=\sum_{d\ge1}\mu(d)z^d. \tag{1}
\]

The central-arc term is

\[
A_X=\int_0^\infty w(t)
 \frac1{2\pi}\int_{|\theta|<\Delta}
 \frac{|H(re^{i\theta},t)|^2}
 {|1-re^{i\theta}|^2}\,d\theta\,dt. \tag{2}
\]

All norms and integrals in (2) are the actual original clock. No sector of
the Möbius source is removed.

## Uniform terminal approximation

Put \(q=e^{-t}\) and \(z=re^{i\theta}\). From (1),

\[
H(z,t)-(1-q)P(z)
=(1-q)\sum_{d\ge1}\mu(d)
 \frac{qz^{2d}}{1-qz^d}. \tag{3}
\]

Since \(|1-qz^d|\ge1-q\),

\[
|H(z,t)-(1-q)P(z)|
\le q\sum_{d\ge1}r^{2d}
=q\frac{\rho}{1-\rho}
\le\frac{qX}{2}. \tag{4}
\]

Also

\[
q|P(z)|\le q\sum_{d\ge1}r^d
=\frac q{e^{1/X}-1}\le qX. \tag{5}
\]

Thus, uniformly on the full circle and for every \(t>0\),

\[
|H(re^{i\theta},t)-P(re^{i\theta})|
\le\frac32Xe^{-t}\le2Xe^{-t}. \tag{6}
\]

This is the complete all-order terminal decomposition. The error includes
all quotient histories \(N/d\ge2\); it was not obtained by deleting
composites or truncating a composition expansion.

## Central Poisson mass controls the terminal mean

Let

\[
d\omega_r(\theta)=
 \frac{1-r^2}{|1-re^{i\theta}|^2}\frac{d\theta}{2\pi}.
\]

Poisson's formula gives

\[
\int_{-\pi}^{\pi}P(re^{i\theta})\,d\omega_r(\theta)=P(r^2). \tag{7}
\]

The chord bound

\[
|1-re^{i\theta}|^2\ge4r\theta^2/\pi^2
\]

implies

\[
\omega_r(|\theta|\ge\Delta)
\le\frac{\pi(1-r^2)}{4r\Delta}
\le\frac{\pi e}{2\sqrt X}. \tag{8}
\]

Moreover \(|P(re^{i\theta})|\le r/(1-r)\le X\). Therefore the contribution
of the outer arc to the mean in (7) has absolute value at most

\[
B_X:=\frac{\pi e}{2}\sqrt X. \tag{9}
\]

Cauchy-Schwarz on the central arc now gives

\[
\int_{|\theta|<\Delta}|P(re^{i\theta})|^2d\omega_r(\theta)
\ge\bigl(|P(r^2)|-B_X\bigr)_+^2. \tag{10}
\]

Since \((1-r^2)^{-1}\ge X/2\), the unnormalized central energy obeys

\[
J_X:=\frac1{2\pi}\int_{|\theta|<\Delta}
 \frac{|P(re^{i\theta})|^2}{|1-re^{i\theta}|^2}\,d\theta
\ge\frac X2\bigl(|P(r^2)|-B_X\bigr)_+^2. \tag{11}
\]

## Lower bound in the original clock

For \(t\ge1\), the actual weight satisfies

\[
\frac{\kappa}{t^2}\le w(t)\le\frac1{t^2},
\qquad \kappa=1-\frac1{e-1}>0. \tag{12}
\]

Choose

\[
T_X=2\log(2X)>1.
\]

The elementary inequality \(|a+b|^2\ge|a|^2/2-|b|^2\), applied to
(6), gives after restricting (2) to \(t\ge T_X\),

\[
A_X\ge\frac12\left(\int_{T_X}^\infty w(t)dt\right)J_X-\mathcal E_X. \tag{13}
\]

The full angular Poisson integral bounds the error:

\[
\begin{aligned}
\mathcal E_X
&\le \frac{4X^2}{1-r^2}
 \int_{T_X}^\infty e^{-2t}w(t)dt\\
&\le\frac{4X^2}{1-r^2}
 \frac{e^{-2T_X}}{2T_X^2}\\
&\le\frac{e^2X^3e^{-2T_X}}{T_X^2}
=\frac{e^2}{16XT_X^2}.
\end{aligned}\tag{14}
\]

Here \((1-r^2)^{-1}\le e^2X/2\), a deliberately uniform bound for all
\(X\ge1\). From (12),

\[
\int_{T_X}^\infty w(t)dt\ge\frac\kappa{T_X}. \tag{15}
\]

Combining (11), (13), and (15) proves the source-specific estimate

\[
\boxed{
A_X\ge
 \frac{\kappa X}{4T_X}
 \left(|P(e^{-2/X})|-\frac{\pi e}{2}\sqrt X\right)_+^2
 -\frac{e^2}{16XT_X^2}.}
\tag{16}
\]

No full-circle derivative estimate appears in this proof.

## Arithmetic content and obstruction

The terminal value in (16) is the exact Abel-smoothed Mertens sum

\[
P(e^{-2/X})=\sum_{n\ge1}\mu(n)e^{-2n/X}. \tag{17}
\]

Equivalently, Abel summation gives

\[
P(e^{-2/X})
=(1-e^{-2/X})\sum_{N\ge1}M(N)e^{-2N/X},
\qquad M(N)=\sum_{n\le N}\mu(n). \tag{18}
\]

Consequently, a bound

\[
A_X\ll_\varepsilon X^{2+\varepsilon}
\]

forces

\[
\left|\sum_{n\ge1}\mu(n)e^{-2n/X}\right|
\ll \sqrt X+X^{1/2+\varepsilon/2}\sqrt{\log(2X)}. \tag{19}
\]

Thus the unresolved central-arc upper bound already contains
square-root-scale cancellation for a standard smooth Mertens sum, up to
the displayed logarithm and epsilon loss. Complete birth renewal and the
positive Poisson variance do not supply this cancellation by themselves.

The argument also identifies where an upper-bound attack must act. The
large clock has the terminal polynomial \(P\) plus the exponentially small
uniform error (6). Hence any source-specific upper estimate for \(A_X\)
must control the central Poisson mass of the complete Möbius polynomial.
It cannot come only from bounding the nonterminal quotient histories, and
it cannot discard the hard-clock terminal reserve.

Equation (16) is a precise new obstruction rather than a closure. It is
compatible with the audited outer-arc reduction and retains all actual
prime and composite histories.

The companion [Abel-smoothed Mertens criterion](abel-mertens-rh-criterion.md) proves that the uniform target `A_X=O_epsilon(X^(2+epsilon))` would imply RH. That target remains unproved. No Lean formalization of the analytic estimates in this note is asserted.
