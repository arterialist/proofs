# A Bourgain and dual-trilinear extension of the actual Möbius tail

**Status:** unconditional written analytic estimate, 20 September 2026. The
finite convolution and Poisson identities are exact. The analytic inputs are
Bourgain's exponent-pair theorem and the dual orientation of the
Robert--Sargos three-dimensional monomial-sum theorem proved in the companion
note. No priority claim is made.

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
 \rho_\dagger=\frac{14-6\lambda}{15},
 \qquad
 d_{B,0}=\frac{126\lambda-13}{210},
 \qquad
 d_B=d_{B,0}-\frac1{420}=\frac{84\lambda-9}{140},
\tag{1}
\]

and

\[
 K_B=T^{d_B}=H T^{\rho_\dagger+1/420}.
\tag{2}
\]

More generally, put

\[
 \rho_B=d_{B,0}-(\lambda-1)
 =\frac{197-84\lambda}{210}>0.
\]

For every fixed \(0<\eta<\rho_B\), every integer interval
\(I\subseteq[D,2D]\), and

\[
 H\le D\le T^{d_{B,0}-\eta},
\]

the original signed block satisfies

\[
 \boxed{
 \sum_{m\in I}\mu(m)L_m(T)
 \ll_{\lambda,\eta}T^{-\eta/4}.}
\tag{2a}
\]

Consequently,

\[
 \sum_{m\le H T^{\rho_B-\eta}}\mu(m)L_m(T)
 \ll_{\lambda,\eta}
 T^{-\min\{(29-14\lambda)/60,\eta/4\}}.
\tag{2b}
\]

The cutoff in (2) is the specialization \(\eta=1/420\).

Then

\[
 \boxed{
 \sum_{m\leq K_B}\mu(m)L_m(T)
 \ll T^{-c_B},\qquad
 c_B=\min\!\left(\frac{29-14\lambda}{60},\frac1{1500}\right)>0.}
\tag{3}
\]

Consequently,

\[
 \boxed{
 P_1(T)=\sum_{m>K_B}\mu(m)L_m(T)+O(T^{-c_B}).}
\tag{4}
\]

The earlier analytic endpoint was

\[
 d_\dagger=\frac{9\lambda-1}{15}
 =d_{B,0}-\frac1{210}.
\tag{5}
\]

Thus (2) passes that endpoint by the factor \(T^{1/420}\). Relative to the
concrete cutoff \(K_\dagger=HT^{\rho_\dagger/2}\) in the companion note,
the gain is

\[
 \frac{K_B}{K_\dagger}=T^{\rho_\dagger/2+1/420}.
\tag{6}
\]

The sum beyond \(K_B\) remains unresolved.

## Bourgain's exponent pair in the Type I term

Bourgain's Theorem 6 in
[*Decoupling, exponential sums and the Riemann zeta function*](https://doi.org/10.1090/jams/860),
J. Amer. Math. Soc. 30 (2017), 205--224, states that

\[
 \left(\frac{13}{84}+\varepsilon,
       \frac{55}{84}+\varepsilon\right)
\tag{7}
\]

is an exponent pair. The discussion immediately following that theorem
explains how to treat arbitrary subintervals, at a harmless logarithmic cost.

Retain the exact decomposition

\[
 \mu=2a-a*a*1+b*b*1,
 \qquad a=\mu1_{n\leq U},\quad b=\mu-a.
\tag{8}
\]

On a block \(m\asymp D\), the Type I term has a short product
\(c\leq U^2\), with

\[
 \gamma(c)=-\sum_{rs=c,\ r,s\leq U}\mu(r)\mu(s),
 \qquad |\gamma(c)|\leq\tau(c),
\tag{9}
\]

and a long variable of length \(Q=D/c\). On a Poisson shell
\(|k|\asymp J\), set

\[
 L=D/H,\qquad r=J/L,\qquad F=Tr.
\tag{10}
\]

The long-variable phase is \(-kN/(cq)\), with
\(|f^{(j)}(q)|\asymp FQ^{-j}\). If \(Q\ll F\), (7) gives, uniformly on
subintervals,

\[
 \sum_{q\in I}e(f(q))
 \ll_\varepsilon F^{13/84+\varepsilon}Q^{1/2+\varepsilon}.
\tag{11}
\]

The ordinarily included \(Q/F\) term is absorbed in this range. If
\(Q\gg F\), the reciprocal phase has constant-sign derivative of size
\(F/Q<1/2\), and Kusmin--Landau gives

\[
 \sum_{q\in I}e(f(q))\ll Q/F.
\tag{12}
\]

Split (9) at \(c\asymp D/F\). The divisor estimates give

\[
 \sum_{c\ll D/F}|\gamma(c)|\frac{D}{cF}
 \ll \frac{D}{F}(\log T)^C,
\tag{13}
\]

and

\[
 \sum_{D/F\ll c\leq U^2}
 |\gamma(c)|F^{13/84}(D/c)^{1/2}
 \ll D^{1/2}UF^{13/84}T^\varepsilon.
\tag{14}
\]

The Poisson shell contributes \(r/\sqrt N\). For \(r<1\), the two exact
zero modes of the packet supply the additional factor \(r\); for \(r>1\),
uniform Schwartz decay absorbs every displayed power of \(r\). Summing the
signed shells and inserting the bounded-variation product cutoff yields

\[
 \boxed{
 |S_{\mathrm I}(D;I)|
 \ll_\varepsilon \frac{T^\varepsilon}{\sqrt N}
 \left(D^{1/2}UT^{13/84}+\frac DT\right).}
\tag{15}
\]

This estimate retains the literal interval \(I\). The endpoint-strip
argument is unchanged from the companion note.

## Dual Type II estimate and optimization

The dual Robert--Sargos orientation in the companion note gives

\[
 |S_{\mathrm{II}}(D;I)|
 \ll \frac{T^\varepsilon(\log T)^C D}{\sqrt N}
 \left[
 N^{1/4}D^{-1/2}U^{-1/4}
 +L^{-1/4}D^{-1/8}
 +U^{-1/2}
 +T^{-1/2}
 \right].
\tag{16}
\]

Write \(D=T^d\), \(U=T^u\). The Type I term in (15), and the first and
third Type II terms in (16), have exponents

\[
 E_{\mathrm I,1}=\frac d2+u+\frac{13}{84}-\frac\lambda2,
\tag{17}
\]

\[
 E_{\mathrm{II},1}=\frac d2-\frac\lambda4-\frac u4,
 \qquad
 E_{\mathrm{II},3}=d-\frac\lambda2-\frac u2.
\tag{18}
\]

The two inequalities in (18) are both equivalent to

\[
 u>2d-\lambda.
\tag{19}
\]

The Type I inequality is

\[
 u<\frac\lambda2-\frac d2-\frac{13}{84}.
\tag{20}
\]

Compatibility of (19) and (20) is exactly

\[
 d<\frac{126\lambda-13}{210}=d_{B,0}.
\tag{21}
\]

The value in (21) exceeds the endpoint (5) by \(1/210\).

For a uniform explicit margin, take

\[
 d=d_B=d_{B,0}-\frac1{420},
 \qquad
 u=2d_{B,0}-\lambda=\frac{21\lambda-13}{105}.
\tag{22}
\]

Substitution gives

\[
 E_{\mathrm I,1}=E_{\mathrm{II},1}=-\frac1{840},
 \qquad
 E_{\mathrm{II},3}=-\frac1{420}.
\tag{23}
\]

The other Type II exponents are

\[
 E_{\mathrm{II},2}=\frac\lambda8-\frac{65}{224},
 \qquad
 E_{\mathrm{II},4}=\frac{14\lambda-79}{140}.
\tag{24}
\]

The Kusmin--Landau term in (15) has exponent

\[
 d_B-1-\frac\lambda2=\frac\lambda{10}-\frac{149}{140}.
\tag{25}
\]

Every quantity in (24)--(25) is strictly smaller than
the active margin in (23) throughout \(2<\lambda<29/14\). The fixed choice
of \(u\) only improves the estimates when \(d<d_B\).
Moreover,

\[
 2u<\lambda-1,
\]

so every block \(D\geq H\) satisfies \(D>2U^2\) for large \(T\), as
required by the decomposition.

Choose the exponent-pair, divisor, Fourier-separation, and dyadic losses
inside the gap between \(1/840\) and \(1/1500\). Combining the resulting
block estimate with the existing initial-prefix bound
\(O(T^{-(29-14\lambda)/60})\) proves (3). The exact identity
\(P_1=\sum_m\mu(m)L_m\) then proves (4).

Within this Bourgain plus dual Robert--Sargos decomposition, the next
endpoint is (21): the Type I upper constraint and the two dual Type II lower
constraints meet there. Advancing farther requires an improvement in at
least one of those three terms or cancellation between the decomposed pieces.
