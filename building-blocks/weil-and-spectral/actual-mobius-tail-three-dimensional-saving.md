# A three-dimensional exponential-sum saving for the actual Möbius tail

**Status:** unconditional written analytic estimate, 20 September 2026. The finite convolution identities are elementary; the Poisson and exponential-sum estimates below are written analysis, not Lean formalizations. No priority claim is made.

This note bounds a longer initial segment of the Möbius representation of the separate prime row. The main input is Robert and Sargos, [*Three-dimensional exponential sums with monomials*, Theorem 1, equation (1.3)](https://perso.univ-st-etienne.fr/rool6510/robert-2006-crelle.pdf). The one-dimensional estimates use the classical second- and third-derivative tests; the latter is recorded in Robert and Sargos, [*A third derivative test for mean values of exponential sums*, equation (1.2)](https://perso.univ-st-etienne.fr/rool6510/robert-2003-acta.pdf).

## Statement

Use the normalized pole-null packet from the [reciprocal-prime estimate](actual-reciprocal-prime-high-cofactor-saving.md):

\[
N=T^\lambda,\qquad H=\frac NT,\qquad 2<\lambda<\frac{29}{14},
\]

\[
g_N(x)=x^{-1/2}C_T(\log(x/N)),\qquad
G_T(v)=\sqrt N\,g_N(N+Hv).
\]

For \(m\ge1\), put

\[
L_m(T)=\sum_{n\ge1}(\log n)g_N(mn).
\tag{1}
\]

Let \(I\) be any interval of integers contained in \([D,2D]\), and define

\[
S(D;I)=\sum_{m\in I}\mu(m)L_m(T).
\tag{2}
\]

Set

\[
d_\dagger=\frac{9\lambda-1}{15},
\qquad
\rho_\dagger=d_\dagger-(\lambda-1)
=\frac{14-6\lambda}{15}>0.
\tag{3}
\]

**Theorem.** Fix

\[
0<\eta<\rho_\dagger.
\]

Uniformly for

\[
H\le D\le T^{d_\dagger-\eta},
\tag{4}
\]

one has

\[
\boxed{S(D;I)\ll_{\lambda,\eta}T^{-\eta/4}.}
\tag{5}
\]

All logarithmic and divisor-function losses are included in the margin in (5).
The improvement over the first orientation of the three-dimensional estimate
comes from assigning its separated coefficient to the shorter Type II
variable.

The first orientation stopped at
\[
K_{\mathrm{new}}=HT^{(13-6\lambda)/21}.
\]
For a concrete cutoff, take \(\eta=\rho_\dagger/2\) and set

\[
K_\dagger=HT^{\rho_\dagger/2}
=HT^{(7-3\lambda)/15}
=T^{(12\lambda-8)/15}.
\tag{6}
\]

The raw estimates below, summed over the dyadic blocks after the earlier
cutoff, give

\[
\sum_{K_{\mathrm{old}}<m\le K_\dagger}
\mu(m)L_m(T)\ll T^{-\rho_\dagger/8}.
\tag{7}
\]

where

\[
K_{\mathrm{old}}=HT^{(29-14\lambda)/116}.
\]

The earlier reciprocal-Möbius estimate gives

\[
\sum_{m\le K_{\mathrm{old}}}\mu(m)L_m(T)
\ll T^{-(29-14\lambda)/60}.
\tag{8}
\]

Consequently, with

\[
c_\lambda=\min\!\left(
\frac{29-14\lambda}{60},
\frac{7-3\lambda}{60}
\right)>0,
\tag{9}
\]

\[
\boxed{
\sum_{m\le K_\dagger}\mu(m)L_m(T)
\ll T^{-c_\lambda}.}
\tag{10}
\]

Since the finite identity \(\log=\Lambda*1\) gives

\[
P_1(T):=\sum_{d\ge1}\Lambda(d)g_N(d)
=\sum_{m\ge1}\mu(m)L_m(T),
\tag{11}
\]

equation (10) moves the exact remaining tail to

\[
\boxed{
P_1(T)=
\sum_{m>K_\dagger}\mu(m)L_m(T)
+O(T^{-c_\lambda}).}
\tag{12}
\]

The sum on the right of (12) is not bounded here.

## Exact weighted Poisson formula

Put

\[
Q_T(v)=\log(1+v/T)G_T(v).
\]

The packet has two exact moments:

\[
\int_0^\infty g_N(x)\,dx=0,
\qquad
\int_0^\infty(\log x)g_N(x)\,dx=0.
\tag{13}
\]

Thus

\[
\widehat G_T(0)=\widehat Q_T(0)=0.
\]

Extend \(x\mapsto(\log x)g_N(mx)\) by zero to the negative half-line. The packet is supported in a compact subinterval of \((0,\infty)\), so this extension is smooth. Poisson summation then gives the exact identity

\[
\boxed{
L_m(T)=\frac{H}{m\sqrt N}\sum_{k\ne0}e(-kN/m)
\left[
\log(N/m)\widehat G_T(kH/m)+\widehat Q_T(kH/m)
\right].}
\tag{14}
\]

There is no zero-frequency remainder. The families \(G_T\) and \(Q_T\) have uniform Schwartz bounds, with the additional factor \(T^{-1}\) available for \(Q_T\).

## Möbius decomposition

Let

\[
a=\mu 1_{n\le U},\qquad b=\mu-a.
\]

Since \(\mu*1=\varepsilon\),

\[
\boxed{
\mu=2a-a*a*1+b*b*1.}
\tag{15}
\]

For \(D>2U\), the first term vanishes on \(m\asymp D\). The Type I term has a short factor \(q\le U^2\), with

\[
\gamma(q)=-\sum_{\substack{rs=q\\ r,s\le U}}\mu(r)\mu(s),
\qquad |\gamma(q)|\le\tau(q).
\tag{16}
\]

The Type II term is grouped as

\[
b*(b*1),
\]

then divided into rectangles

\[
A\ge B>U,\qquad AB\asymp D.
\tag{17}
\]

Its two coefficient sequences are divisor-bounded. Their contribution is absorbed into \(T^\varepsilon\).

## Initial reciprocal-Möbius range

The estimate used in (8) follows from the same decomposition with a one-dimensional reciprocal phase.

**Lemma.** Let \(W\) be a complex function of bounded variation supported in a fixed compact subinterval of \((0,\infty)\). Uniformly for

\[
D^{1/2}\le F\le D,
\]

\[
\boxed{
\sum_{d\ge1}\mu(d)W(d/D)e(\pm FD/d)
\ll D^{29/30}\|W\|_{\mathrm{BV}}.}
\tag{R1}
\]

To prove this, take \(U=D^{1/8}\) in (15). The Type I term has short factor at most \(D^{1/4}\); the second-derivative test gives

\[
S_{\mathrm I}\ll D^{o(1)}
\left(D^{1/4}\sqrt F+\frac D{\sqrt F}\right)
\|W\|_{\mathrm{BV}}
\ll D^{3/4+o(1)}\|W\|_{\mathrm{BV}}.
\tag{R2}
\]

For a Type II rectangle \(A\ge B\ge D^{1/8}\), Cauchy's inequality followed by the classical third-derivative test gives

\[
\frac{|S_{\mathrm{II}}|}{D\|W\|_{\mathrm{BV}}}
\ll D^{o(1)}
\left[
B^{-1/2}+F^{1/12}A^{-1/4}
+A^{-1/8}+F^{-1/8}
\right].
\tag{R3}
\]

The four terms in brackets are at most \(D^{-1/24}\). The slack from \(1/24\) to \(1/30\) absorbs divisor coefficients and dyadic logarithms, proving (R1). Endpoint jumps are included in the BV norm.

For the Poisson weights in (14), the total BV mass over all nonzero modes is \(O(\log T)\). Put \(s=\lambda-1\) and

\[
\alpha=\frac{s-1}{4}.
\]

Blocks \(D\le HT^{-\alpha}\) are rapidly decreasing by Schwartz decay. On

\[
HT^{-\alpha}\le D\le HT^\delta,
\]

truncate to \(|k|\le (D/H)T^{2\alpha}\). The omitted modes are rapidly decreasing, while the retained reciprocal parameter

\[
F=\frac{|k|N}{D}=T\frac{|k|}{D/H}
\]

satisfies \(D^{1/2}\le F\le D\) whenever \(2-s-3\delta>0\). Hence (R1) gives

\[
\sum_{m\le HT^\delta}\mu(m)L_m(T)
\ll \frac{(HT^\delta)^{29/30}\log T}{\sqrt N}.
\tag{R4}
\]

Taking \(\delta=(29-14\lambda)/116\) and absorbing the logarithm proves (8).

## Type I estimate

For \(q\le U^2\), the long variable has length \(D/q\). In a Poisson mode \(k\), put

\[
F=\frac{|k|N}{D}.
\]

The reciprocal phase has third derivative of size \(Fq^3/D^3\). The classical third-derivative estimate gives

\[
\sum_{\ell\asymp D/q}e\!\left(-\frac{kN}{q\ell}\right)
\ll
D^{1/2}F^{1/6}q^{-1/2}
+D^{3/4}q^{-3/4}
+DF^{-1/4}q^{-1}.
\tag{18}
\]

This form of the derivative estimate is used only while its normalized third-derivative parameter is in the small-parameter range. Write

\[
r=\frac{|k|}{D/H},\qquad F=Tr,\qquad
Q_{\min}=\frac{D}{U^2}.
\]

Split the Poisson modes at

\[
r_0=\frac{Q_{\min}^3}{10T}.
\tag{18a}
\]

For \(r\le r_0\), every long-variable length \(Q=D/q\), \(q\le U^2\), satisfies \(F/Q^3\le1/10\), so (18) applies uniformly. For \(r>r_0\), use the trivial long-sum bound and the arbitrary Schwartz decay of the Fourier weights in (14). In the range used below,

\[
\frac{Q_{\min}^3}{T}
\ge T^{9(\lambda-1)/7-1},
\]

which is a fixed positive power of \(T\). Choosing the Schwartz-decay index after all divisor and dyadic losses makes the modes \(r>r_0\) \(O_A(T^{-A})\). Thus the split introduces no additional term in (20).

The coefficient sums satisfy

\[
\sum_q|\gamma(q)|q^{-1/2}\ll U,
\qquad
\sum_q|\gamma(q)|q^{-3/4}\ll U^{1/2},
\qquad
\sum_q\frac{|\gamma(q)|}{q}\ll(\log U)^2.
\tag{19}
\]

Summing the Poisson modes with their Schwartz weights yields

\[
\boxed{
|S_{\mathrm I}(D;I)|
\ll \frac{T^\varepsilon(\log T)^C}{\sqrt N}
\left[
D^{1/2}UT^{1/6}
+D^{3/4}U^{1/2}
+DT^{-1/4}
\right].}
\tag{20}
\]

## Three-dimensional Type II estimate

Divide the nonzero Poisson modes into shells \(|k|\asymp J\), and write \(D=LH\). After restoring the factor \(H/(m\sqrt N)\) in (14), a Type II shell has size

\[
\frac1{L\sqrt N}
\sum_{k\asymp J}\sum_{b\asymp B}\alpha(k,b)
\sum_{a\asymp A}\beta(a)
e\!\left(-\frac{kN}{ab}\right),
\tag{21}
\]

up to a separated smooth amplitude and \(T^\varepsilon(\log T)^C\). Here \(|\alpha(k,b)|,|\beta(a)|\le1\) after extracting the divisor-function loss.

Robert and Sargos' theorem applies with

\[
(H_0,N_0,M_0)=(J,B,A),\qquad
(\beta_0,\gamma_0,\alpha_0)=(1,-1,-1),
\qquad
X=\frac{NJ}{AB}\asymp\frac{NJ}{D}=\frac{TJ}{L}.
\tag{22}
\]

Its nondegeneracy condition

\[
\alpha_0(\alpha_0-1)\beta_0\gamma_0\ne0
\]

is satisfied. For shells with \(X>1\), equation (1.3) of the cited paper gives

\[
|S_{\mathrm{II},J}|
\ll T^\varepsilon(\log T)^C
\frac{DJ}{L\sqrt N}
\left[
\left(\frac{X}{JBA^2}\right)^{1/4}
+(JB)^{-1/4}
+A^{-1/2}
+X^{-1/2}
\right].
\tag{23}
\]

This is a bound for the full trilinear block. It is not obtained by discarding the off-diagonal part of a Cauchy expansion.

The shells with \(J<L/T\), hence \(X\ll1\), are treated without Robert--Sargos. The zero in (13) makes the Fourier amplitude \(O(J/L)\); trivial summation in (21) therefore gives

\[
|S_{\mathrm{II},J}|
\ll T^\varepsilon(\log T)^C\frac{D}{\sqrt N}
\left(\frac JL\right)^2.
\]

Their dyadic sum is \(O(T^\varepsilon D/(\sqrt N T^2))\), which is dominated by (24). For \(L/T\ll J\ll L\), Robert--Sargos applies and the same zero supplies the small-mode factor needed when summing (23). Schwartz decay handles \(J\gg L\). Summing all shells gives

\[
\boxed{
|S_{\mathrm{II}}(D;I)|
\ll \frac{T^\varepsilon(\log T)^C D}{\sqrt N}
\left[
N^{1/4}D^{-5/8}
+(LU)^{-1/4}
+D^{-1/4}
+T^{-1/2}
\right].}
\tag{24}
\]

The phase is symmetric in \(a,b\), but the Robert--Sargos bound is not:
its \(M_0\)-variable is the one carrying the separated coefficient.  After
the amplitude separation below, the two arithmetic coefficient sequences
remain independent and divisor-bounded.  We may therefore interchange the
two factor variables and apply the same theorem with

\[
(H_0,N_0,M_0)=(J,A,B).
\]

This gives the dual estimate

\[
|S_{\mathrm{II},J}|
\ll T^\varepsilon(\log T)^C
\frac{DJ}{L\sqrt N}
\left[
\left(\frac{X}{JAB^2}\right)^{1/4}
+(JA)^{-1/4}
+B^{-1/2}
+X^{-1/2}
\right].
\tag{23d}
\]

Orient each rectangle so that \(A\ge B>U\).  Since \(AB\asymp D\),
the first term in (23d) is at most
\((N/(D^2U))^{1/4}\), the second is at most
\((L\sqrt D)^{-1/4}\), and the third is at most \(U^{-1/2}\).
The same summation over \(J\) therefore gives

\[
\boxed{
|S_{\mathrm{II}}(D;I)|
\ll \frac{T^\varepsilon(\log T)^C D}{\sqrt N}
\left[
N^{1/4}D^{-1/2}U^{-1/4}
+L^{-1/4}D^{-1/8}
+U^{-1/2}
+T^{-1/2}
\right].}
\tag{24d}
\]

The earlier obstruction \((LU)^{-1/4}\) in (24) was therefore caused by
the Cauchy orientation built into that application of the asymmetric
theorem. Estimate (24d) removes it. The generic
\(\sqrt{T/Y}\) loss remains unavoidable if the two Dirichlet polynomials
are first separated and only the standard sharp mean-value bounds for
arbitrary coefficients are retained. It is not a structural lower bound for
the original signed sum: the trilinear estimate bypasses that separation.
The first and third terms in (24d), together with the first Type I term in
(20), form the next barrier.

## Separation of the sharp product cutoff

The theorem cited above has rectangular ranges and permits a joint
coefficient in two variables and a separate coefficient in the third.
Thus it permits either a joint coefficient in \((k,b)\) and a separate
coefficient in \(a\), or the dual orientation used in (23d).  More
generally, insert a zero-extended BV weight \(W(ab/D)\), supported on a
fixed compact annulus. The interval in (2) is the specialization

\[
W_I(u)=1_{\{Du\in I\}},
\qquad
\|W_I\|_{\mathrm{BV}}=O(1),
\]

with the real endpoints chosen to select exactly the integers in \(I\). The amplitude in (14) also contains the smooth function

\[
\widehat G_T(kH/(ab))
\]

together with its logarithmic companion. The following standard separation keeps (23) valid for the literal interval \(I\).

Represent the BV cutoff as a Stieltjes superposition of product thresholds. Smooth each threshold over relative width

\[
\delta=T^{-C_0}.
\]

Mellin inversion separates the smoothed product cutoff with \(L^1\)-mass

\[
O(\|W\|_{\mathrm{BV}}\log(1/\delta)).
\tag{25}
\]

On normalized dyadic boxes, the remaining amplitude is smooth in

\[
\log(k/J),\qquad\log(a/A),\qquad\log(b/B).
\]

Its Fourier series is absolutely summable, with norm \(O((\log T)^C)\). Each separated factor has modulus one on the integer variables and therefore preserves the coefficient hypotheses in the three-dimensional theorem.

There are two discarded endpoint strips. Bound them in the original \(m\)-sum, before applying the Möbius decomposition. Together they contain \(O(\delta D+1)\) integers; counting there avoids any multiplicity from Type I or Type II factor pairs. From (14) and the uniform Schwartz bounds,

\[
|L_m(T)|\ll\frac{\log T}{\sqrt N}
\qquad(m\ge H).
\tag{26}
\]

Its total contribution is

\[
O\!\left(
\|W\|_{\mathrm{BV}}(\delta D+1)
\frac{\log T}{\sqrt N}
\right),
\tag{27}
\]

which is negligible when \(C_0\) is chosen large. This boundary-strip step is required; a bare truncated Perron formula is not uniform when \(ab\) lies at an endpoint.

## Exponent optimization

Write

\[
s=\lambda-1,\qquad
U=T^u,\qquad
u=\frac{3\lambda-2}{15},\qquad D=T^d.
\tag{28}
\]

The three powers of \(T\) in (20), after the factor \(N^{-1/2}\), are

\[
E_{\mathrm I,1}=\frac d2+u+\frac16-\frac\lambda2,
\quad
E_{\mathrm I,2}=\frac{3d}{4}+\frac u2-\frac\lambda2,
\quad
E_{\mathrm I,3}=d-\frac\lambda2-\frac14.
\tag{29}
\]

The four powers in the dual Type II estimate (24d) are

\[
E_{\mathrm{II},1}=\frac d2-\frac\lambda4-\frac u4,
\quad
E_{\mathrm{II},2}=\frac{5d}{8}-\frac\lambda2+\frac s4,
\quad
E_{\mathrm{II},3}=d-\frac\lambda2-\frac u2,
\quad
E_{\mathrm{II},4}=d-\frac\lambda2-\frac12.
\tag{30}
\]

The choice of \(u\) balances
\(E_{\mathrm I,1}\) with \(E_{\mathrm{II},1}\) and
\(E_{\mathrm{II},3}\). They vanish together at
\(d=d_\dagger\). At that endpoint the remaining exponents are

\[
E_{\mathrm I,2}=-\frac{7-3\lambda}{60},\qquad
E_{\mathrm I,3}=-\frac{19-6\lambda}{60},
\]

\[
E_{\mathrm{II},2}=-\frac{7-3\lambda}{24},\qquad
E_{\mathrm{II},4}=-\frac{17-3\lambda}{30}.
\tag{31}
\]

All four displayed gaps are positive for \(2<\lambda<29/14\).
For \(d\le d_\dagger-\eta\), the three active exponents are at most
\(-\eta/2,-\eta/2,-\eta\). After choosing the \(\varepsilon\) in
(20) and (24d) small enough and absorbing the logarithms, the weakest
remaining margin is at least \(\eta/4\). This proves (5).

The decomposition is valid uniformly on this range. Indeed \(2u<s\), so
\(D>2U^2\) for \(D\ge H\) and large \(T\). Moreover, in the high-mode
split used for (18),

\[
\frac{(D/U^2)^3}{T}
\ge T^{\,3(s-2u)-1}
=T^{(9s-7)/5},
\tag{32}
\]

a fixed positive power because \(s>1\). Thus the discarded Poisson modes
remain rapidly decreasing with the new value of \(U\).

Take \(\eta=\rho_\dagger/2\) and sum the raw estimates and (27) over
the \(O(\log T)\) dyadic blocks between \(K_{\mathrm{old}}\) and
\(K_\dagger\). This gives (7), after weakening the raw
\(\rho_\dagger/4\) margin to \(\rho_\dagger/8\). The extension beyond
the earlier cutoff is strict:

\[
\frac{7-3\lambda}{15}-\frac{13-6\lambda}{21}
=\frac{9\lambda-16}{105}>0.
\tag{33}
\]

More generally, every fixed \(0<\eta<\rho_\dagger\) gives

\[
\sum_{m\le HT^{\rho_\dagger-\eta}}\mu(m)L_m(T)
\ll
T^{-\min\{(29-14\lambda)/60,\,\eta/4\}}.
\tag{34}
\]

## Remaining term

The estimate proves a larger unconditional power-saving segment of the exact
Möbius tail. The farther sum

\[
\sum_{m>K_\dagger}\mu(m)L_m(T)
\]

remains the unresolved term in (12). Within the present Vaughan plus
Robert--Sargos framework, the precise next obstruction occurs at
\(d=d_\dagger\): the first Type I term in (20) and the first and third
dual Type II terms in (24d) all reach exponent zero simultaneously.
They are, before harmless powers \(T^\varepsilon\) and logarithms,

\[
\frac{D^{1/2}UT^{1/6}}{\sqrt N},\qquad
\frac{D}{\sqrt N}\,N^{1/4}D^{-1/2}U^{-1/4},\qquad
\frac{D}{\sqrt N}\,U^{-1/2}.
\tag{35}
\]

The first term decreases only when \(U\) is shortened, while the last two
then increase. Their simultaneous balance forces
\(u=(3\lambda-2)/15\) and \(d=(9\lambda-1)/15\).
Changing the Cauchy orientation again cannot improve all three terms.
