# A Bordellès trilinear extension of the actual Möbius tail

**Status:** unconditional written analytic estimate, 20 September 2026. The
finite convolution and Poisson identities are exact. The analytic inputs are
Bourgain's exponent pair and Bordellès' trilinear reciprocal-sum estimate.
No priority claim is made.

## Statement

Use the packet and notation of the
[three-dimensional Möbius-tail estimate](actual-mobius-tail-three-dimensional-saving.md):

\[
 N=T^\lambda,\qquad H=N/T,\qquad 2<\lambda<29/14,
\]

\[
 L_m(T)=\sum_{n\geq1}(\log n)g_N(mn),
 \qquad P_1(T)=\sum_{m\geq1}\mu(m)L_m(T).
\]

Put

\[
 d_C=\frac{4\lambda}{7}-\frac1{420}
 =\frac{240\lambda-1}{420},
 \qquad
 \kappa_C=d_C-(\lambda-1)=\frac{419-180\lambda}{420},
\tag{1}
\]

and set

\[
 K_C=T^{d_C}=HT^{\kappa_C}.
\tag{2}
\]

Then

\[
 \boxed{
 \sum_{m\leq K_C}\mu(m)L_m(T)
 \ll T^{-c_C},\qquad
 c_C=\min\!\left(
 \frac{29-14\lambda}{60},
 \frac1{1000}
 \right)>0.}
\tag{3}
\]

Consequently,

\[
 \boxed{
 P_1(T)=\sum_{m>K_C}\mu(m)L_m(T)+O(T^{-c_C}).}
\tag{4}
\]

The Bourgain plus dual Robert--Sargos endpoint is

\[
 d_{B,0}=\frac{126\lambda-13}{210}.
\]

The endpoint supplied below is \(4\lambda/7\). The concrete exponent in
(1) exceeds the earlier endpoint by

\[
 d_C-d_{B,0}=\frac{25-12\lambda}{420}>0.
\tag{5}
\]

The inequality is strict throughout \(2<\lambda<29/14\). The tail beyond
\(K_C\) remains unresolved.

## Type I estimate

Use the exact decomposition

\[
 \mu=2a-a*a*1+b*b*1,
 \qquad a=\mu1_{n\leq U},\quad b=\mu-a.
\tag{6}
\]

The Bourgain exponent-pair argument in the
[companion note](actual-mobius-tail-bourgain-dual-saving.md), including its
Kusmin--Landau treatment of long variables exceeding the phase size, gives

\[
 \boxed{
 |S_{\mathrm I}(D;I)|
 \ll_\varepsilon \frac{T^\varepsilon}{\sqrt N}
 \left(D^{1/2}UT^{13/84}+\frac DT\right).}
\tag{7}
\]

This bound is uniform for literal integer intervals \(I\subset[D,2D]\).

## Bordellès' Type II estimate

Lemma 2.7 of Bordellès,
[*Short sums of restricted Möbius functions*](https://doi.org/10.4064/aa142-4-5),
Acta Arith. 142 (2010), 367--375, states that, for \(z>0\), integers
\(J,A,B\geq1\), and arbitrary coefficients
\(|\alpha_a|,|\beta_{k,b}|\leq1\),

\[
 \begin{aligned}
 &\sum_{a\asymp A}\sum_{k\asymp J}\sum_{b\asymp B}
 \alpha_a\beta_{k,b}e\!\left(\frac{kz}{ab}\right)\\
 &\quad\ll
 J(zA^3B^4)^{1/6}
 +A(JB)^{1/2}
 +A^{1/2}JB
 +(Jz^{-1})^{1/2}(AB)^{3/2},
 \end{aligned}
\tag{8}
\]

apart from a factor \(\log^3(2JAB)\). For the opposite phase sign, conjugate
the whole sum and both coefficient sequences, then apply (8) with \(z>0\).

For a Type II rectangle, orient the variables so that

\[
 A\geq B\gg U,\qquad AB\asymp D,
\]

and use \(z=N\), \(J\asymp L=D/H\). Here is the separation needed before
applying the rectangular theorem. On normalized dyadic boxes, the smooth
packet amplitude has an absolutely summable Fourier expansion in

\[
 \log(k/J),\qquad \log(a/A),\qquad \log(b/B),
\]

with \(L^1\)-norm \(O((\log T)^C)\). Put the \(a\)-factor into
\(\alpha_a\), and the \(k\)- and \(b\)-factors into the arbitrary joint
coefficient \(\beta_{k,b}\). Each Fourier character has modulus one.

Before applying the decomposition, replace the literal \(m\)-interval cutoff
globally. Denote its zero-extended BV weight by \(W=W_I\). Write \(W\) as a
Stieltjes superposition of product thresholds and smooth each threshold over relative width
\(\delta=T^{-C_0}\). Mellin inversion separates a smoothed threshold with
total mass

\[
 O\!\left(\|W\|_{\mathrm{BV}}\log(1/\delta)\right),
\]

and \((ab)^{it}=a^{it}b^{it}\) preserves the same separated-a and
joint-\((k,b)\) coefficient pattern. Bound the discarded endpoint strips in
the original \(m\)-sum, before the Möbius decomposition. They contain
\(O(\delta D+1)\) integers, and the exact Poisson formula gives

\[
 |L_m(T)|\ll\frac{\log T}{\sqrt N}\qquad(m\geq H).
\]

Their total is therefore

\[
 O\!\left((\delta D+1)\frac{\log T}{\sqrt N}\right),
\]

which is negligible after choosing \(C_0\) large. This establishes the hard
cutoff transfer independently of Lemma 2.7. Divisor coefficients, dyadic
subdivisions, and all separation integrals cost only \(T^\varepsilon\).

Writing \(\nu_U=\mu1_{n>U}\) and \(c_U=\nu_U*1\), one has
\(|\nu_U|\leq1\) and \(|c_U(n)|\leq\tau(n)\ll_\varepsilon n^\varepsilon\).
After either dyadic orientation, extract the corresponding \(A^\varepsilon\)
or \(B^\varepsilon\) factor before applying (8). The Fourier and Mellin
characters have modulus one, so the normalized coefficient sequences then
satisfy the unit bounds in Lemma 2.7.

More explicitly, the shell to which (8) is applied is

\[
 \frac1{L\sqrt N}
 \sum_{a\asymp A}\alpha_a
 \sum_{k\asymp J}\sum_{b\asymp B}\beta_{k,b}
 e\!\left(-\frac{kN}{ab}\right).
\tag{8a}
\]

Put \(r=J/L\). After the factor \((L\sqrt N)^{-1}\) and the packet
multiplier \(\omega_C(r)=\min(r,r^{-C})\), the four terms of (8) carry,
respectively, the shell factors

\[
 r\omega_C(r),\qquad
 r^{1/2}\omega_C(r),\qquad
 r\omega_C(r),\qquad
 r^{1/2}\omega_C(r).
\tag{8b}
\]

These are summable over all signed dyadic shells. For \(r<1\), the exact
zero modes give \(\omega_C(r)=r\); for \(r>1\), uniform Schwartz decay
absorbs every displayed power. It is therefore valid, up to logarithms, to
put \(J=L\) in the four physical terms below.

Restoring the physical factor \((L\sqrt N)^{-1}\) in the Poisson formula,
the four terms in (8) become

\[
 N^{-1/3}A^{1/2}B^{2/3},\qquad
 \left(\frac{D}{BT}\right)^{1/2},\qquad
 \frac{D^{1/2}B^{1/2}}{\sqrt N},\qquad
 \frac{D}{\sqrt{NT}}.
\tag{9}
\]

Since \(U\ll B\leq D^{1/2}\), with \(B\asymp U\) allowed in the first
truncated dyadic rectangle, (9) gives the uniform bound

\[
 \boxed{
 |S_{\mathrm{II}}(D;I)|
 \ll_\varepsilon T^\varepsilon
 \left[
 N^{-1/3}D^{7/12}
 +\left(\frac{D}{UT}\right)^{1/2}
 +\frac{D^{3/4}}{\sqrt N}
 +\frac{D}{\sqrt{NT}}
 \right].}
\tag{10}
\]

Every actual Möbius and logarithmic weight remains in the coefficient
sequences or packet amplitude; (10) does not replace them by a different
arithmetic function.

## Exponent optimization

Write \(D=T^d\), \(U=T^u\), and choose

\[
 u=\frac{42\lambda-55}{126}.
\tag{11}
\]

The first term in (7), and the four terms in (10), have exponents

\[
 E_{\mathrm I}=\frac d2+u+\frac{13}{84}-\frac\lambda2,
\tag{12}
\]

\[
 E_1=\frac{7d}{12}-\frac\lambda3,
 \qquad
 E_2=\frac{d-1-u}{2},
 \qquad
 E_3=\frac{3d}{4}-\frac\lambda2,
 \qquad
 E_4=d-\frac{\lambda+1}{2}.
\tag{13}
\]

At \(d=4\lambda/7\),

\[
 E_1=0,
 \qquad
 E_{\mathrm I}=E_2=-\frac{71-30\lambda}{252},
 \qquad
 E_3=-\frac\lambda{14},
 \qquad
 E_4=-\frac{7-\lambda}{14}.
\tag{14}
\]

All exponents other than \(E_1\) have a fixed negative margin throughout
\(2<\lambda<29/14\). The second term in (7) has exponent
\(d-1-\lambda/2\), which is also uniformly negative here.

For any fixed \(\eta>0\), putting

\[
 d\leq\frac{4\lambda}{7}-\eta
\]

makes the leading exponent

\[
 E_1\leq-\frac{7\eta}{12}.
\tag{15}
\]

The decomposition is valid on every block \(D\geq H\): (11) satisfies
\(u>0\) and \(2u<\lambda-1\), so \(D>2U^2\) for large \(T\).

Take \(\eta=1/420\). Then (15) gives the raw margin

\[
 \frac{7\eta}{12}=\frac1{720}.
\]

Choose all exponent-pair, divisor, Fourier-separation, Mellin, and dyadic
losses inside the gap between this exponent and
\(1/1000\). Summing the blocks and combining them with the
existing initial-prefix estimate
\(O(T^{-(29-14\lambda)/60})\) proves (3). The exact identity
\(P_1=\sum_m\mu(m)L_m\) proves (4).

Within this combination of Bourgain Type I and Bordellès Type II estimates,
the next endpoint is \(d=4\lambda/7\), where the first term of (10) reaches
the trivial scale. A further extension requires improving that balanced
trilinear term or exploiting cancellation between the decomposed pieces.
