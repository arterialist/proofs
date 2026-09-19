# A Selberg mean-square bound for the complete actual prime packet

**Status:** unconditional written analytic estimate, 20 September 2026. The
analytic input is Lemma 7 of Saffari and Vaughan, specialized with Huxley's
zero-density exponent \(12/5\). The packet exponent comparisons are
formalized and axiom-audited in
[`ActualPrimePacketAlmostAllCenter.lean`](../../formalization/BuildingBlocks/ActualPrimePacketAlmostAllCenter.lean).
The Saffari--Vaughan theorem, the Stieltjes argument, and the proper-power
count are written mathematics, not Lean. This result concerns almost all real
packet centers. It does not prove the Riemann hypothesis.

Use the pole-null packet from the
[proper-cofactor cutoff transfer](actual-proper-cofactor-dirichlet-dual-cancellation.md):

\[
 g_N(x)=N^{-1/2}G_T\!\left(\frac{x-N}{H_N}\right),
 \qquad H_N=\frac NT,
 \qquad \int_0^\infty g_N(x)\,dx=0.
\tag{1}
\]

For fixed packet data, \(G_T\) and all its fixed derivatives are uniformly
Schwartz. Although \(g_N\) has a fixed multiplicative support, this decay
localizes its effective additive scale to \(H_N\). Define the complete
prime-power row

\[
 P_1(N,T)=\sum_{m\ge1}\Lambda(m)g_N(m).
\tag{2}
\]

Every power \(p^j\), \(j\ge1\), occurs in (2) with its exact weight
\(\log p\).

Let \(N_0=T^\lambda\), where \(\lambda\ge2\) is fixed. There is a constant
\(c>0\), depending only on the fixed packet data and on \(\lambda\), such
that

\[
\boxed{
 \left(\frac1{N_0}\int_{N_0}^{2N_0}|P_1(N,T)|^2\,dN\right)^{1/2}
 \ll
 \frac{\sqrt{N_0}}T
 \exp\!\left[-c\left(\frac{\log N_0}{\log\log N_0}\right)^{1/3}\right]
 +\frac{(\log N_0)^2}{T}.}
\tag{3}
\]

At \(\lambda=2\), the right side tends to zero. Markov's inequality gives

\[
 |P_1(N,T)|
 \ll
 \exp\!\left[-\frac c2
 \left(\frac{\log N_0}{\log\log N_0}\right)^{1/3}\right]
\tag{4}
\]

outside a subset of \([N_0,2N_0]\) of relative measure

\[
 \ll
 \exp\!\left[-c
 \left(\frac{\log N_0}{\log\log N_0}\right)^{1/3}\right].
\tag{5}
\]

The constants in (4)--(5) may be changed, and the polynomially smaller
proper-power term is absorbed. These are fixed-\(T\) statements for real
centers; no claim is made simultaneously for all \(T\) or specifically for
integer centers.

## Prime contribution

Write

\[
 \vartheta(x)=\sum_{p\le x}\log p,
 \qquad E_\vartheta(x)=\vartheta(x)-x.
\]

Saffari and Vaughan,
[*On the fractional parts of \(x/n\) and related sequences. II*](https://doi.org/10.5802/aif.649),
Lemma 7, prove from a density estimate

\[
 N(\sigma,U)\ll U^{C(1-\sigma)}(\log U)^B
\tag{6}
\]

that, for every fixed \(\epsilon>0\),

\[
 \int_X^{2X}\max_{0\le v\le Y}
 |E_\vartheta(u+v)-E_\vartheta(u)|^2\,du
 \ll_\epsilon
 Y^2X
 \exp\!\left[-c_0
 \left(\frac{\log X}{\log\log X}\right)^{1/3}\right]
\tag{7}
\]

whenever

\[
 X^{1+\epsilon-2/C}<Y\le X.
\tag{8}
\]

They cite Huxley,
[*On the difference between consecutive primes*](https://doi.org/10.1007/BF01418933),
for \(C=12/5\). Thus (7) is unconditional for
\(Y\ge X^{1/6+\epsilon}\). For \(\lambda\ge2\), choose any fixed
\(0<\epsilon<1/3\). Then

\[
 H_N=N/T\gg N^{1/6+\epsilon}.
\tag{9}
\]

This strict exponent implication is Lean theorem
`selberg_range_of_critical_or_larger`.

The zero moment in (1) and Stieltjes integration by parts give the exact
prime contribution

\[
 \sum_p(\log p)g_N(p)
 =-\frac1{\sqrt N}\int_{\mathbb R}G_T'(v)
 \left[E_\vartheta(N+H_Nv)-E_\vartheta(N)\right]\,dv.
\tag{10}
\]

Here the integrand is set to zero outside

\[
 I_T=[T(e^{-w}-1),T(e^w-1)].
\tag{10a}
\]

Indeed, on the support
\(\alpha=1+v/T\) satisfies \(e^{-w}\le\alpha\le e^w\), so
\(N+H_Nv=\alpha N>0\).

There is no density main term: it is exactly the zero moment in (1).
Decompose the \(v\)-integral into \(|v|\le1\) and dyadic shells
\(V<|v|\le2V\). On a positive shell, (7) is used with
\(Y\asymp VH_{N_0}\); on a negative shell, change the base point to
\(u=\alpha N\), so \(dN=du/\alpha\). The bounds
\(e^{-w}\le\alpha\le e^w\) make this Jacobian harmless. A fixed number of
dyadic \(u\)-ranges covers all base points. Minkowski's inequality and
uniform Schwartz decay give, for every fixed \(K>3\),

\[
 \sum_{V=2^j\ge1}
 V H_{N_0}\sup_{V<|v|\le2V}|G_T'(v)|\,V
 \ll H_{N_0}\sum_{j\ge0}2^{-j(K-2)}
 \ll H_{N_0}.
\tag{11}
\]

For the terminal shells, split the increment from \(N\) to \(\alpha N\) at
\(\sqrt\alpha N\), reversing the order when \(v<0\). Every resulting
positive increment has consecutive endpoint ratio

\[
 r\le e^{w/2}<\sqrt2.
\tag{11a}
\]

Writing its base as \(u=bN\), take \(X=bN_0\). Then
\(u\in[X,2X]\), the increment length is at most
\(2(r-1)X<X\), and on a terminal shell it remains comparable to \(N_0\).
Thus both the upper and lower length hypotheses of (7) hold. The
substitutions \(u=bN\) have bounded Jacobians because
\(e^{-w}\le b\le e^w\). This also supplies the fixed finite covering claimed
above.

Equations (7), (10), and (11) yield

\[
 \left(\frac1{N_0}\int_{N_0}^{2N_0}
 \left|\sum_p(\log p)g_N(p)\right|^2dN\right)^{1/2}
 \ll
 \frac{H_{N_0}}{\sqrt{N_0}}
 \exp\!\left[-c
 \left(\frac{\log N_0}{\log\log N_0}\right)^{1/3}\right].
\tag{12}
\]

## Proper powers

It remains to restore every \(p^j\), \(j\ge2\). In an interval of length
\(L\) at scale \(N_0\), the number of prime squares is
\(O(LN_0^{-1/2}+1)\). Summing the elementary root-spacing bound over
\(3\le j\ll\log N_0\) gives

\[
 \#\{p^j\in I:j\ge3\}
 \ll (\log N_0)(LN_0^{-2/3}+1).
\tag{13}
\]

Apply (13) on the same dyadic \(v\)-shells and use the uniform Schwartz
bound for \(G_T\). Since \(H_N=N/T\) and \(\lambda\ge2\), uniformly in
\(N\in[N_0,2N_0]\),

\[
 \frac1{\sqrt N}
 \sum_{j\ge2}\sum_p(\log p)
 \left|G_T\!\left(\frac{p^j-N}{H_N}\right)\right|
 \ll \frac{(\log N_0)^2}{T}
      +\frac{(\log N_0)^2}{\sqrt{N_0}}.
\tag{14}
\]

The last term is no larger than the first. Combining (12) and (14) proves
(3), with every proper power retained.

## Why this does not reach RH

The scale factor in (3) is

\[
 \frac{\sqrt{N_0}}T=T^{\lambda/2-1}.
\tag{15}
\]

It is \(1\) at \(\lambda=2\) and grows as a fixed power for every fixed
\(\lambda>2\). The identities and signs are Lean theorems
`critical_prefactor`, `prefactor_positive_above_critical`, and
`proper_power_below_prime_scale`.

There is also a direct off-line-zero test. The elementary packet upper bound
for the explicit-formula term of a zero \(\rho=\beta+i\gamma\) is, uniformly
in \(\gamma\),

\[
 O\!\left(H_NN^{\beta-3/2}\right)
 =O\!\left(T^{\lambda(\beta-1/2)-1}\right).
\tag{16}
\]

Ordinates \(|\gamma|\asymp T\) have this natural packet scale. The exponent
in (16) minus the envelope exponent in (15) is exactly

\[
 \lambda(\beta-1)<0\qquad(\beta<1).
\tag{17}
\]

This is formalized by `zeroMode_sub_prefactor` and
`offline_zero_below_envelope`. More explicitly, for every fixed
\(\beta<1\), the ratio of (16) to the first term of (3) is

\[
 O\!\left(
 T^{-\lambda(1-\beta)}
 \exp\!\left[c
 \left(\frac{\log N_0}{\log\log N_0}\right)^{1/3}\right]
 \right)=o(1).
\tag{18}
\]

Hence (3) is compatible with every fixed off-critical zero in the critical
strip: its envelope is weaker than RH scale. It is a new almost-all-center
constraint on the complete signed arithmetic packet, not an RH-scale law.
The strict \(\lambda>2\) hybrid prefix cannot be joined to the favorable
\(\lambda=2\) conclusion by taking a limit.
