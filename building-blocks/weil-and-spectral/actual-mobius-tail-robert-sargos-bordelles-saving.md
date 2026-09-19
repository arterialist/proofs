# A Robert--Sargos--Bordellès extension of the actual Möbius tail

**Status:** unconditional written analytic estimate, 20 September 2026. The
finite convolution and Poisson identities are exact. The new step applies the
dual Robert--Sargos estimate rectangle by rectangle near balance and the
Bordellès estimate after an explicit switch. No claim about the farther tail
is made.

## Statement

Retain the normalized pole-null packet and notation of the
[Cao--Zhai extension](actual-mobius-tail-cao-zhai-large-sieve-saving.md):

\[
N=T^\lambda,\qquad H=N/T,\qquad 2<\lambda<29/14,
\]

\[
L_m(T)=\sum_{n\geq1}(\log n)g_N(mn),
\qquad P_1(T)=\sum_{m\geq1}\mu(m)L_m(T).
\]

Put

\[
d_E=\frac{2(\lambda+1)}5-\frac1{420},
\qquad
\kappa_E=d_E-(\lambda-1)
=\frac{587-252\lambda}{420}>\frac{13}{84},
\tag{1}
\]

and set

\[
K_E=T^{d_E}=HT^{\kappa_E}.
\tag{2}
\]

Then

\[
\boxed{
\sum_{m\leq K_E}\mu(m)L_m(T)
\ll T^{-c_E},\qquad
c_E=\min\!\left(\frac{29-14\lambda}{60},\frac1{2000}\right)>0.}
\tag{3}
\]

Consequently,

\[
\boxed{
P_1(T)=\sum_{m>K_E}\mu(m)L_m(T)+O(T^{-c_E}).}
\tag{4}
\]

The new analytic endpoint exceeds the Cao--Zhai endpoint by

\[
\frac{2(\lambda+1)}5-\frac{3\lambda+1}{6}
=\frac{7-3\lambda}{30}>0.
\tag{5}
\]

Even the concrete exponent in (1) exceeds the previous untrimmed analytic
endpoint:

\[
d_E-\frac{3\lambda+1}{6}
=\frac{97-42\lambda}{420}>\frac1{42}.
\tag{6}
\]

## Robert--Sargos input and coefficient placement

Robert and Sargos, [*Three-dimensional exponential sums with
monomials*](https://perso.univ-st-etienne.fr/rool6510/robert-2006-crelle.pdf),
Theorem 1, equation (1.3), bound

\[
\sum_{h\asymp H_0}\sum_{n\asymp N_0}\alpha(h,n)
\sum_{m\asymp M_0}\beta(m)
e\!\left(X(h/H_0)^{\beta_0}(n/N_0)^{\gamma_0}
(m/M_0)^{\alpha_0}\right)
\]

by

\[
(H_0N_0M_0)^{1+\varepsilon}
\left[
\left(\frac{X}{H_0N_0M_0^2}\right)^{1/4}
+(H_0N_0)^{-1/4}+M_0^{-1/2}+X^{-1/2}
\right],
\tag{7}
\]

for unit-bounded joint and separate coefficients, provided \(X>1\) and

\[
\alpha_0(\alpha_0-1)\beta_0\gamma_0\ne0.
\]

For a Type-II rectangle, orient the arithmetic variables so that

\[
A\geq B\gg U,\qquad AB\asymp D.
\]

On a Poisson shell \(k\asymp J\), use

\[
(H_0,N_0,M_0)=(J,A,B),\qquad
(\beta_0,\gamma_0,\alpha_0)=(1,-1,-1),
\tag{8}
\]

and

\[
X=\frac{NJ}{AB}.
\tag{9}
\]

The nondegeneracy product is \(-2\). After the established Fourier and
Mellin separation, each separated term has the form

\[
[c_A(a)\chi_k(k)\chi_A(a)a^{it}]
[c_B(b)\chi_B(b)b^{it}],
\]

which is precisely the joint \((k,a)\) and separate \(b\) coefficient
architecture in (7). The arithmetic coefficients are divisor bounded, so
their normalization costs only \(T^\varepsilon\). The opposite phase sign is
handled by conjugation. The product cutoff is smoothed before the Vaughan
decomposition; its boundary error is

\[
O\!\left((T^{-C_0}D+1)N^{-1/2}\log T\right),
\]

and its Mellin mass is logarithmic.

## Rectangle bounds

Let \(L=D/H\). On the physical shell \(J\asymp L\), restoring the exact
Poisson factor \((L\sqrt N)^{-1}\) in (7) gives

\[
\begin{aligned}
|S_{\rm RS}(D;A,B)|\ll_\varepsilon T^\varepsilon\bigg[{}&
N^{-1/4}A^{1/2}B^{1/4}
+D^{3/4}A^{-1/4}(NT)^{-1/4}\\
&+AB^{1/2}N^{-1/2}
+D(NT)^{-1/2}\bigg].
\end{aligned}
\tag{10}
\]

Write

\[
D=T^d,\qquad A=T^a,\qquad B=T^{d-a}.
\]

The four exponents in (10) are

\[
R_1=\frac{d+a-\lambda}{4},\qquad
R_2=\frac{3d-\lambda-1-a}{4},\qquad
R_3=\frac{d+a-\lambda}{2},\qquad
R_4=d-\frac{\lambda+1}{2}.
\tag{11}
\]

The rectangle-specific Bordellès estimate from
[the preceding extension](actual-mobius-tail-bordelles-saving.md) has
exponents

\[
B_1=-\frac\lambda3+\frac{2d}{3}-\frac a6,\qquad
B_2=\frac{a-1}{2},\qquad
B_3=d-\frac a2-\frac\lambda2,\qquad
B_4=d-\frac{\lambda+1}{2}.
\tag{12}
\]

## Hybrid switch

Let

\[
d_* = \frac{2(\lambda+1)}5,
\qquad d_D=\frac{3\lambda+1}{6}-\frac1{420},
\qquad d_D\leq d\leq d_*-\eta,
\tag{13}
\]

and retain

\[
u=\frac{42\lambda-55}{126}.
\tag{14}
\]

The actual Type-II range is

\[
\frac d2\leq a\leq d-u.
\]

Define the switch

\[
a_0=\frac{3d-\lambda}{2}.
\tag{15}
\]

It lies strictly inside the rectangle range. Indeed,

\[
a_0-\frac d2=d-\frac\lambda2\geq\frac{23}{140}>0,
\tag{16}
\]

and

\[
d-u-a_0=\frac{\lambda-d-2u}{2}
\geq\frac{149-21\lambda}{630}
>\frac{211}{1260}>0.
\tag{17}
\]

Use Robert--Sargos when \(d/2\leq a\leq a_0\). Since \(R_1,R_3\)
increase with \(a\) and \(R_2\) decreases,

\[
R_2\leq\frac{5d-2\lambda-2}{8}\leq-\frac{5\eta}{8},
\tag{18}
\]

and

\[
R_1\leq\frac{5d-3\lambda}{8}
\leq-\frac{\lambda-2+5\eta}{8}\leq-\frac{5\eta}{8},
\qquad R_3=2R_1.
\tag{19}
\]

Also \(R_4\leq-(\lambda+1)/10-\eta\).

Use Bordellès when \(a_0\leq a\leq d-u\). Its first exponent decreases
with \(a\), and

\[
B_1(a_0)=\frac{5d-3\lambda}{12}
\leq-\frac{\lambda-2+5\eta}{12}\leq-\frac{5\eta}{12}.
\tag{20}
\]

The other exponents retain fixed margins:

\[
B_2\leq-\frac4{315}-\frac\eta2,
\qquad
B_3\leq\frac{d-\lambda}{4}<0,
\qquad
B_4\leq-\frac{\lambda+1}{10}-\eta.
\tag{21}
\]

Thus every Type-II rectangle saves at least \(5\eta/12\).

## Poisson shells

Write \(J=rL\). Before the packet multiplier, the four terms in (7) carry
the shell powers

\[
r,\qquad r^{3/4},\qquad r,\qquad r^{1/2}.
\]

The exact zero-mode cancellations supply another factor \(r\) for
\(r\leq1\), giving

\[
r^2,\qquad r^{7/4},\qquad r^2,\qquad r^{3/2}.
\]

These powers are dyadically summable. Uniform Schwartz decay handles
\(r>1\), including the harmless positive powers and the
\(X^\varepsilon\) loss in (7). If \(X\leq1\), the direct zero-mode estimate
gives

\[
O_\varepsilon\!\left(T^\varepsilon\frac{D}{\sqrt N\,T^2}\right).
\]

In the new-block interval this case is empty for sufficiently large \(T\),
since \(J\geq1\) implies \(X\gg N/D\gg T^{4/5}\).

## Type I and loss budget

Keep the inherited Type-I bound

\[
|S_{\rm I}|\ll_\varepsilon T^\varepsilon N^{-1/2}
\left(D^{1/2}UT^{13/84}+\frac DT\right).
\tag{22}
\]

At \(d=d_*-\eta\), its first exponent satisfies

\[
E_{\rm I}=\frac{42\lambda-103}{1260}-\frac\eta2
\leq-\frac4{315}-\frac\eta2,
\tag{23}
\]

while the second satisfies

\[
d-1-\frac\lambda2
\leq-\frac{\lambda+6}{10}-\eta<-\frac45-\eta.
\tag{24}
\]

The decomposition conditions are uniform:

\[
\frac{29}{126}<u<\frac{16}{63},\qquad
(\lambda-1)-2u=\frac{21\lambda-8}{63}>\frac{34}{63},
\tag{25}
\]

and

\[
d-u\leq\frac{307}{315}-\eta<1.
\tag{26}
\]

Choose \(\eta=1/420\). The limiting raw Type-II margin is

\[
\frac{5\eta}{12}=\frac1{1008}.
\]

The gap

\[
\frac1{1008}-\frac1{2000}=\frac{31}{63000}
\]

absorbs the divisor, Fourier, Mellin, theorem, and dyadic logarithmic losses;
for example, allocate their combined power loss below \(1/4000\). Combining
the new blocks with the prefix from the Cao--Zhai extension proves (3).

## Exact remaining tail

Put

\[
Y_E=\frac N{K_E}=T^{(252\lambda-167)/420}<T^{71/84}.
\tag{27}
\]

Define \(G_T(v)=\sqrt N\,g_N(N+Hv)\).

If the logarithmic packet is supported in
\(Ne^{-w}\leq x\leq Ne^w\), the support swap gives

\[
\boxed{
P_1(T)=
\frac1{\sqrt N}
\sum_{n<e^wY_E}(\log n)
\sum_{m>K_E}\mu(m)
G_T\!\left(\frac{mn-N}{H}\right)
+O(T^{-c_E}).}
\tag{28}
\]

The theorem removes another fixed-power part of the original signed Möbius
sum. It does not bound the farther tail in (28).
