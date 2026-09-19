# A Cao--Zhai large-sieve extension of the actual Möbius tail

**Status:** unconditional written analytic estimate, 20 September 2026. The
finite convolution and Poisson identities are exact. The new input is Lemma 8
of Cao and Zhai, used only in the range where its phase-size hypothesis holds.
No priority claim is made.

## Statement

Keep the packet and notation of the
[Bordellès extension](actual-mobius-tail-bordelles-saving.md):

\[
 N=T^\lambda,\qquad H=N/T,\qquad 2<\lambda<29/14,
\]

\[
 L_m(T)=\sum_{n\geq1}(\log n)g_N(mn),
 \qquad P_1(T)=\sum_{m\geq1}\mu(m)L_m(T).
\]

Put

\[
 d_D=\frac{3\lambda+1}{6}-\frac1{420},
 \qquad
 \kappa_D=d_D-(\lambda-1)=\frac{163-70\lambda}{140}>0,
\tag{1}
\]

and set

\[
 K_D=T^{d_D}=HT^{\kappa_D}.
\tag{2}
\]

Then

\[
 \boxed{
 \sum_{m\leq K_D}\mu(m)L_m(T)
 \ll T^{-c_D},\qquad
 c_D=\min\!\left(\frac{29-14\lambda}{60},\frac1{1500}\right)>0.}
\tag{3}
\]

Consequently,

\[
 \boxed{
 P_1(T)=\sum_{m>K_D}\mu(m)L_m(T)+O(T^{-c_D}).}
\tag{4}
\]

The new cutoff exceeds the Bordellès cutoff
\(K_C=T^{4\lambda/7-1/420}\) by the fixed power

\[
 d_D-d_C=\frac{7-3\lambda}{42}>0.
\tag{5}
\]

The improvement comes from a hybrid estimate. Cao--Zhai's large-sieve bound
controls the nearly balanced Type II rectangles. Bordellès' bound becomes
stronger as the separated variable moves away from balance, and controls the
remaining rectangles.

## The Cao--Zhai input

Lemma 8 of Cao and Zhai,
[*The distribution of square-free numbers of the form
\(\lfloor n^c\rfloor\)*](https://jtnb.centre-mersenne.org/item/10.5802/jtnb.229.pdf),
is stated under the hypotheses of their Lemma 7. In the notation

\[
 \mathcal S=
 \sum_{m\asymp M}a_m
 \sum_{m_1\asymp M_1}\sum_{m_2\asymp M_2}
 b_{m_1,m_2}
 e\!\left(y m^\alpha m_1^{\beta_1}m_2^{\beta_2}\right),
\]

with unit-bounded coefficients, put

\[
 F=|y|M^\alpha M_1^{\beta_1}M_2^{\beta_2}.
\]

When \(F\gg M\), their lemma gives, apart from a factor
\(\log^3(2MM_1M_2)\),

\[
\begin{aligned}
 |\mathcal S|\ll{}&
 (M_1M_2)^{19/22}M^{13/22}F^{3/22}\\
 &+M_1M_2M^{5/8}(1+M^7F^{-4})^{1/16}\\
 &+\bigl((M_1M_2)^3M^4(1+FM^{-2})\bigr)^{1/4}.
\end{aligned}
\tag{6}
\]

The general exponent-pair estimate in their Lemma 7 does not give this
extension. For an exponent pair \((k,\ell)\), its balanced physical term is

\[
 N^{-1/(2(1+k))}D^{(3+\ell)/(4(1+k))}.
\]

Its endpoint is \(d=2\lambda/(3+\ell)\), which cannot exceed
\(4\lambda/7\) because \(\ell\geq1/2\). The gain below uses the separate
large-sieve estimate (6), not a substitution of a newer exponent pair.

Use the same coefficient separation and hard-cutoff transfer as in the
Bordellès note. For a Type II rectangle, orient the variables so that

\[
 A\geq B\gg U,\qquad AB\asymp D.
\]

On a Poisson shell \(k\asymp J\), apply (6) with

\[
 M=A,\qquad M_1=B,\qquad M_2=J,
 \qquad (\alpha,\beta_1,\beta_2)=(-1,-1,1),
\]

and

\[
 F\asymp\frac{NJ}{AB}.
\tag{7}
\]

These exponents satisfy Cao--Zhai's conditions
\(\alpha(\beta_1-1)\beta_2\ne0\) and \(\alpha\notin\mathbb N\).

The order \(M_1=B,M_2=J\) matters only for checking the hypotheses of
Lemma 7; its bound depends on their product. On the physical shell
\(J\asymp D/H\), equation (7) gives \(F\asymp T\).

After restoring the factor \((D/H)^{-1}N^{-1/2}\) from the exact Poisson
formula, (6) becomes

\[
\boxed{
\begin{aligned}
 |S_{\mathrm{II}}(D;I)|\ll_\varepsilon T^\varepsilon\bigg[{}&
 N^{-4/11}A^{5/11}B^{8/11}\\
 &+\frac{A^{5/8}B}{\sqrt N}
   \left(1+\frac{A^7}{T^4}\right)^{1/16}\\
 &+\frac{A^{3/4}B^{1/2}}{(NT)^{1/4}}
   \left(1+\frac{T}{A^2}\right)^{1/4}
 \bigg].
\end{aligned}}
\tag{8}
\]

For the Cao--Zhai part of the hybrid estimate, restrict to
\(A\leq T^{2/3}\) and \(D\leq T^{d_*}\). Every nonzero dyadic shell has
\(J\geq1\), and therefore

\[
 \frac FA\asymp\frac{NJ}{A^2B}
 \asymp\frac{NJ}{AD}
 \gg T^{\lambda-d_*-2/3}
 =T^{\lambda/2-5/6}\gg1.
\]

Thus Lemma 8 applies to every nonzero shell in this range. Write
\(J=rD/H\). For \(0<r\leq1\), its three terms are bounded by their
physical-shell values times \(r,r^{3/4},r^{3/4}\). The exact zero-mode
cancellations supply an additional factor \(r\), making their dyadic sums convergent.
Uniform Schwartz decay handles \(r>1\). Rectangles with \(A>T^{2/3}\)
are treated throughout by the Bordellès estimate.

## Hybrid rectangle estimate

Write

\[
 D=T^d,\qquad A=T^a,\qquad B=T^{d-a}.
\]

It is enough to treat the new blocks above the earlier cutoff, so
\(d\geq4\lambda/7-1/420\). First suppose \(a\leq2/3\). In this range
\(a<1\), so the hypothesis \(F\gg M\) in (6) holds on the shells specified
above, and \(2a>1\). The first and third exponents in (8) are

\[
 E_{8,1}=-\frac{4\lambda}{11}+\frac{8d}{11}-\frac{3a}{11},
\tag{9}
\]

\[
 E_{8,3}=-\frac\lambda4-\frac14+\frac d2+\frac a4.
\tag{10}
\]

For the second term, the exponent is

\[
 E_{8,2}=
 \begin{cases}
  -\lambda/2+d-3a/8,&a\leq4/7,\\
  -\lambda/2+d+a/16-1/4,&a\geq4/7.
 \end{cases}
\tag{11}
\]

The first exponent decreases with \(a\), and the third increases. The two
branches in (11) attain their maximum at an endpoint of their respective
\(a\)-interval. At

\[
 d_*=\frac{3\lambda+1}{6},
\tag{12}
\]

one has, uniformly for \(d/2\leq a\leq2/3\),

\[
 E_{8,1}\leq\frac{13-9\lambda}{132}\leq-\frac5{132},
 \qquad E_{8,2}\leq-\frac1{24},
 \qquad E_{8,3}\leq0.
\tag{13}
\]

Now suppose \(a\geq2/3\). The first term in Bordellès' bound has exponent

\[
 E_{B,1}=-\frac\lambda3+\frac{2d}{3}-\frac a6.
\tag{14}
\]

It decreases with \(a\), and at \(d=d_*\), \(a=2/3\), it equals zero.
The other three Bordellès terms have exponents

\[
 \frac{a-1}{2},\qquad d-\frac a2-\frac\lambda2,
 \qquad d-\frac{\lambda+1}{2}.
\tag{15}
\]

They are uniformly negative here. In particular, with the choice of \(U\)
below, \(a\leq d-u<1\); at the switching point the middle exponent in
(15) is \(-1/6\), and the last exponent is \(-1/3\).

Take

\[
 d\leq d_*-\eta.
\]

On \(a\leq2/3\), equation (10) gains at least \(\eta/2\). On
\(a\geq2/3\), equation (14) gains at least \(2\eta/3\). Equations
(9) and (11), together with the remaining Bordellès terms, retain larger
fixed margins.
This proves a Type II saving on every rectangle, including the balanced
one that produced \(N^{-1/3}D^{7/12}\).

## Type I terms and optimization

Keep the parameter from the Bordellès argument,

\[
 U=T^u,\qquad u=\frac{42\lambda-55}{126}.
\tag{16}
\]

The Type I exponent and the truncation exponent are

\[
 E_{\mathrm I}=\frac d2+u+\frac{13}{84}-\frac\lambda2,
 \qquad
 E_{\mathrm{tr}}=\frac{d-1-u}{2}.
\tag{17}
\]

At \(d=d_*\), both equal

\[
 \frac\lambda{12}-\frac{25}{126}\leq-\frac{13}{504}.
\tag{18}
\]

The decomposition conditions also persist: \(u>0\), \(2u<\lambda-1\),
and \(d-u<1\) throughout \(2<\lambda<29/14\).

Choose \(\eta=1/420\). The smallest raw hybrid margin is \(1/840\).
Put all divisor, Fourier-separation, Mellin, and dyadic losses inside the
gap between \(1/840\) and \(1/1500\). The Bordellès note already controls
\(m\leq K_C\). Summing the new blocks \(K_C<m\leq K_D\) and combining
them with that prefix proves (3), with the earlier
\(O(T^{-(29-14\lambda)/60})\) term retained in \(c_D\).

## The new swapped remainder

The support swap at the new cutoff is still exact. Put

\[
 Y_D=\frac N{K_D}=T^{1-\kappa_D}
     =T^{(70\lambda-23)/140}<T
\tag{19}
\]

and \(G_T(v)=\sqrt N\,g_N(N+Hv)\). If the logarithmic packet has support
in the fixed annulus \(Ne^{-w}\leq x\leq Ne^w\), then the remainder in
(4) is

\[
 \boxed{
 \sum_{m>K_D}\mu(m)L_m(T)
 =\frac1{\sqrt N}
  \sum_{n<e^wY_D}(\log n)
  \sum_{m>K_D}\mu(m)
  G_T\!\left(\frac{mn-N}{H}\right).}
\tag{20}
\]

Thus every remaining companion has length below \(T\). The estimate above
has removed a fixed-power segment of the former \(m>K_C\) remainder; it
does not bound the farther tail in (20).
