# Exact other-prime compensation on the q-flat carriers

Written arithmetic derivation, 16 September 2026. This follows the
coordinator's request to test the full all-place form on the actual
gamma-plus-binary negative family. The identities below are proved by
finite expansions and elementary integrals. They are not a Lean
formalization or a proof of the full Weil sign.

Let L=log 2, r=1/sqrt 2, h=2-r-r^(-1)<0 and b=h-1. Choose the actual
even nonnegative smooth packet eta from the gamma-binary mechanism
test, of support width d<=1/5. Set

    C_J(z)=(1-(r+r^(-1))z+z^2)(1+z+...+z^(J-1)), J>=3,
    f_J=sum_j c_j eta(. - jL).

Its coefficients are (1,b,h,...,h,b,1), with J-2 copies of h. Both
global physical Mellin moments at +/-1/2 vanish. Local packets need
not be individually pole-null. This is a real, smooth, compact test.

Put R(x)=integral eta(u+x)eta(u) du and N=R(0). Then R is even,
nonnegative, and supported in [-d,d]. Define the literal other-prime
window sums

\[
 K_m^{\rm odd}=\sum_{\substack{p\ne2\ {
m prime},\ k\ge1}}
    (\log p)p^{-k/2}R(k\log p-mL),\qquad m\ge1.
\]

Every sum is finite: only p^k in [2^m e^-d,2^m e^d] can contribute.
Every prime power and its proper weight is retained. All these window
sums are nonnegative. Also K_1^odd=0, since 2e^(1/5)<3 and the first
window contains only the integer 2.

## Exact coefficients and an unconditional other-prime inequality

Write a_m=sum_i c_(i+m)c_i. Direct finite expansion gives

\[
\begin{aligned}
 a_0&=Jh^2+4-4h,\\
 a_1&=(J-1)h^2-2,\\
 a_m&=(J-m)h^2 &&(2\le m\le J-2),\\
 a_{J-1}&=h^2+1,\\
 a_J&=2(h-1)=2b<0,\\
 a_{J+1}&=1.
\end{aligned}
\]

For the middle lags, the overlap has J+2-m terms. Four endpoint
terms contribute 2h(1+b)=2h^2; the remaining J-m-2 terms contribute
(J-m-2)h^2. This proves the stated middle formula for every J, not
just an asymptotic endpoint estimate. The other four cases follow
from their explicit overlap lists.

Consequently the FULL literal other-prime quadratic is exactly

\[
 A_{\rm odd}(f_J)=2\left[
 h^2\sum_{m=2}^{J-1}(J-m)K_m^{\rm odd}
 +K_{J-1}^{\rm odd}+2bK_J^{\rm odd}+K_{J+1}^{\rm odd}\right]. \tag{1}
\]

In particular, the following actual inequality holds without any
RH or positivity premise:

\[
 A_{\rm odd}(f_J)\ \ge\ 4bK_J^{\rm odd}.                 \tag{2}
\]

More precisely, every summand in the brackets of (1), except the
penultimate-lag term 2bK_J^odd, is nonnegative. The first-lag
coefficient can be negative, but its other-prime window is empty.
Thus compensation of the gamma-binary negative form cannot come
from the literal bulk other-prime incidences. They increase the
arithmetic quadratic and hence decrease the full Weil form. Only
the single penultimate-lag negative coefficient can compensate.
The raw bulk other-prime windows cannot supply the missing positive energy on this family. Keeping the endpoint term is essential. This statement does not refute compensation by the jointly centered signed row: the bulk and endpoint windows also carry large density terms that cancel, as the next section shows.

For clarity, the full sign remains unproved. If the already audited
partial form G_J=Gamma(f_J)-A_2(f_J) is <=-nu||f_J||_2^2, a
nonnegative full form would require the genuinely arithmetic bound

\[
 2(1-h)K_J^{\rm odd}\ \ge\
 h^2\sum_{m=2}^{J-1}(J-m)K_m^{\rm odd}
 +K_{J-1}^{\rm odd}+K_{J+1}^{\rm odd}
 +\frac{\nu}{2}\|f_J\|_2^2.                              \tag{3}
\]

Equation (3) is a necessary target, not a proved inequality. It
exhibits the signed long-lag prime-window comparison that a proposed
completion must actually establish. Inequality (2) alone gives no
upper bound of the required sign.

## Density regularization with both pole cancellations retained

Let

\[
 K_m=\sum_{n\ge2}\Lambda(n)n^{-1/2}R(\log n-mL)
     =K_m^{\rm odd}+Lr^m N.
\]

This includes the complete binary history: the only power of 2 in
the m-th packet window is 2^m. Define

\[
 D=M_{-1/2}(\eta)M_{1/2}(\eta)>0,\qquad
 E_m=K_m-Dr^{-m}.
\]

The subtraction is precisely the prime-density integral, not an
assertion about an asymptotic prime distribution:

\[
 \int_0^\infty e^{x/2}R(x-mL)\,dx
   =r^{-m}\int_{\mathbb R}e^{y/2}R(y)\,dy=Dr^{-m}.
\]

The last identity follows by substituting t=u+y in the two-packet
integral. The support condition mL>d justifies replacing the lower
limit by -infinity.

The actual off-origin gamma kernel from [the gamma-plus-binary partial-form calculation](gamma-binary-partial-form-counterexample.md) is

\[
 \gamma_m=-Dr^m-P_m,\qquad
 P_m=\sum_{s\ge1}
 M_{-(2s+1/2)}(\eta)M_{2s+1/2}(\eta)e^{-(2s+1/2)mL}.
\]

The entire first exponential is retained. The two global pole roots
give the exact finite relation

\[
 0=C_J(r)C_J(r^{-1})
   =a_0+\sum_{m=1}^{J+1}a_m(r^m+r^{-m}).
\]

It follows that the FULL all-place form is exactly

\[
 Q(f_J)=(\Gamma(\eta)+2D)a_0
          -2\sum_{m=1}^{J+1}a_m(P_m+E_m).                \tag{4}
\]

The +2D diagonal is compulsory. Dropping the density term, or
dropping the first gamma exponential independently, loses this
pole cancellation. All odd-prime powers remain in E_m. Formula (4)
does not replace them by density or discard their signed errors.

With T_m=P_m+E_m, (4) has the explicit finite form

\[
 Q(f_J)=(\Gamma(\eta)+2D)(Jh^2+4-4h)
 -2\left[h^2\sum_{m=1}^{J-1}(J-m)T_m-2T_1
          +T_{J-1}+2bT_J+T_{J+1}\right].                \tag{5}
\]

This identifies the bulk Fejer average and the indispensable
endpoint residuals. The binary row's bounded endpoint argument
cannot be transferred to these residuals without proving an actual
bound on E_m.

## What a symbol regularization does and does not justify

The formal symbol is

\[
 S(\theta)=\Gamma(\eta)+2D
             -2\sum_{m\ge1}(P_m+E_m)\cos(m\theta).
\]

Compactness of eta makes P_m absolutely summable. It does not make
E_m absolutely summable. Indeed, the elementary actual bound
Lambda(n)<=log n and 0<=R<=N gives

\[
 K_m\le N e^{d/2}(2\sinh(d)r^{-m}+2r^m)(mL+d),
\]

by counting the integers in the packet window. Hence the initially
justified absolutely convergent Abel symbol has damping e^-epsilon m
with epsilon>L/2. No continuation to epsilon=0 follows from this
bound. Calling the boundary symbol continuous, or even distributional,
requires additional arithmetic control. Pole nulls do not supply it.
For each fixed J, finite coefficient cutoffs and then removal of
damping recover (5); interchanging this with J tending to infinity
would require a separate uniform argument.

These results locate a precise remaining comparison, rather than
assume it. The actual lower inequality (2) and the sign geometry
reject bulk compensation; they do not prove (3), full positivity,
or RH. The exact symbolic audit checks the autocorrelation formulas
for J=3,...,40 and the two pole/density identities for J=3,...,10.
The displayed finite-expansion proofs apply to every J>=3.

## Independent review and exact original-source consumer

RH Agent3 supplied the preceding finite window calculation. RH Proof independently reviewed the full prime-power indexing, the autocorrelation endpoints, the factor of two, the density integral and the diagonal term in (4). This is written mathematics, not a compiled Lean theorem. No literature priority claim is made.

The selected-prime row also has an exact finite closed form. For every J>=3 and any 0<r<1, set h=2-r-r^(-1). Then

\[
 S_J(r)=\sum_{m=1}^{J+1}a_m r^m
 =\frac{J(1-r)^3}{r}-\frac{(1-r)^2}{r}-2r.
\tag{6}
\]

Indeed the triangular part sums to

\[
 h^2\left(\frac{Jr}{1-r}-\frac{r(1-r^J)}{(1-r)^2}\right),
\]

and the remaining terms are -2r+r^(J-1)+2(h-1)r^J+r^(J+1). Substitution of h=-(1-r)^2/r makes their exponential remainder cancel exactly. At r=1/sqrt2 the zero-crossing threshold is J=22+15sqrt2. Thus S_J is negative for integer 3<=J<=43 and positive for J>=44. This is the sign of the binary arithmetic row, which the Weil form subtracts. It is not the sign of the full form.

Pole cancellation gives a second exact identity:

\[
 \sum_{m=1}^{J+1}a_m r^{-m}=-a_0-S_J(r).
\tag{7}
\]

Consequently the raw density contribution, after removing the binary row, is

\[
 2\sum_{m=1}^{J+1}a_m\bigl(Dr^{-m}-LN r^m\bigr)
 =-2Da_0-2(D+LN)S_J(r).
\tag{8}
\]

Each density window can be exponential in J, but their complete weighted sum in (8) is only linear in J. Discarding the final windows invalidates this cancellation. A relative prime-counting error small compared with each exponential window does not bound the resulting signed sum on its linear scale.

There is also an exact connection to the original source in the goal. Define

\[
 \psi(x)=\sum_{n\le x}\Lambda(n),\qquad
 a(v)=e^{-v/2}\bigl[\psi(e^v)-e^v\bigr]\mathbf1_{v\ge0},
 \qquad W(y)=R'(y)-\tfrac12R(y).
\]

Since R is smooth and compactly supported, the literal window error satisfies

\[
 E_m=-\int_{\mathbb R}a(mL+y)W(y)\,dy.
\tag{9}
\]

To prove this, put F_m(x)=x^(-1/2)R(log x-mL). Its support is contained in [2^m e^(-d),2^m e^d], strictly above 1. Thus

\[
 E_m=\int_1^\infty F_m(x)\,d(\psi(x)-x)
     =-\int_1^\infty[\psi(x)-x]F_m'(x)\,dx.
\]

All boundary terms vanish because F_m vanishes outside a compact interval. Atoms at integer endpoints are retained in the Stieltjes integral; smooth compact support makes the endpoint weights zero. The derivative is x^(-3/2)W(log x-mL). Substituting x=2^m e^y proves (9). No global L2 or L1 membership of a is assumed. Every integral uses only a compact portion of the actual source.

Let Ncut be any integer at least 2^(J+1)e^d, and use the ORIGINAL frozen source

\[
 a_{Ncut}(v)=e^{-v/2}
 [\psi(\min(e^v,Ncut))-\min(e^v,Ncut)]\mathbf1_{v\ge0}.
\]

It agrees with a on every window in (9). With the finite signed test

\[
 V_J(v)=\sum_{m=1}^{J+1}a_m W(v-mL),
\]

the complete form therefore has the exact finite-source readout

\[
 Q(f_J)=(\Gamma(\eta)+2D)a_0
       -2\sum_{m=1}^{J+1}a_m P_m
       +2\int_{\mathbb R}a_{Ncut}(v)V_J(v)\,dv.
\tag{10}
\]

This identifies the actual consumer without redefining the source or assuming a globally square-integrable infinite source. V_J is signed; neither nonnegativity of eta nor the finite-source identification proves a sign for the last integral. The needed uniform arithmetic comparison in (10) remains open. The finite arithmetic integration-by-parts step, signed finite-window frozen-source pairing and autocorrelation density moment are now formalized below under their explicit calculus hypotheses; the packet seed's derivative/support instantiation and complete gamma/form identification remain additional Lean obligations.

### Formalized finite original-source integration by parts

[FinitePrimeSourceIntegration.lean](BuildingBlocks/FinitePrimeSourceIntegration.lean) now formalizes the finite arithmetic integration-by-parts step. For every integer N>=1, globally continuous D, and F with HasDerivAt F (D x) x at every real x, its original-source theorem proves

\[
\sum_{n=2}^N\Lambda(n)F(n)-\int_1^NF(x)\,dx
=-\int_1^N[\psi(\lfloor x\rfloor)-x]D(x)\,dx
+[\psi(N)-N]F(N)+F(1).
\]

The zero-endpoint specialization removes only the displayed boundary values. The module proves integrability of the literal finite counting prefix, the open/closed birth-atom FTC identities, and identification with CoarsePrimitive.primeErrorReal on the full covered interval. Every prime power remains through the actual von Mangoldt function. All ten theorems compile without new warnings and depend only on propext, Classical.choice and Quot.sound.

The nine finite-atom and source-identification theorems were contributed by RH Agent3; the original-source theorem retaining arbitrary endpoint values was added during independent root review. These use standard FTC and integration by parts, with no novelty claim. The logarithmic-window specialization, exponential change of variables, density moment and signed finite-window frozen-source pairing are now formalized below under their explicit calculus hypotheses. The packet seed's derivative/support instantiation and the full gamma/form identity (10) remain further formalization obligations. No arithmetic sign is proved here.

### Formalized logarithmic-window calculus and original-source pairing

[LogarithmicPrimeWindow.lean](BuildingBlocks/LogarithmicPrimeWindow.lean) specializes that identity to the literal window F(x)=x^(-1/2)R(log(x)-s). For continuous R,D with D the derivative of R at every real point, both zero when |y|>=d, and 0<=d<=s, it proves

\[
F'(x)=x^{-3/2}\bigl[D(\log x-s)-R(\log x-s)/2\bigr]\quad(x>0).
\]

The module proves the endpoint weights vanish once N>=1 and log(N)>=s+d, and proves integrability of the derivative on positive cutoff intervals. To apply the existing global FTC theorem, it extends the window by zero on x<=0 and proves this extension globally differentiable, with globally continuous extended derivative. Support above one makes the extension locally zero near the added boundary; no boundary charge is assumed away. The final theorem identifies the unextended positive-window prime-minus-density sum with minus its derivative paired against the ORIGINAL CoarsePrimitive.primeErrorReal on 1..N. It retains every von Mangoldt atom and proves both endpoint zeros.

Six further theorems prove the exact exponential image of the half-open interval, the change of variables for arbitrary integrands (allowing the step-function prime error), and the normalized logarithmic-source identity. They identify that source with the EXISTING ChargeFrozenSource.causalSource on the covered interval, retaining its original min(exp(v),C) and causal branch. For integers 1<=N<=C with log(N)>=s+d, the final theorem proves

\[
\sum_{n=2}^N\Lambda(n)n^{-1/2}R(\log n-s)
-\int_1^N x^{-1/2}R(\log x-s)\,dx
=-\int_{\mathbb R}a_C(v)\bigl[D(v-s)-R(v-s)/2\bigr]\,dv.
\]

The kernel is proved zero outside the covered interval, including the endpoint weights. The full source is retained; its uncovered tail contributes zero through this compact test. No global integrability of an unfrozen source is assumed.

Nine additional theorems evaluate the complete density window and identify its physical moments for the literal real autocorrelation

\[
R_f(y)=\int_{\mathbb R}f(v+y)f(v)\,dv,\qquad
M_f(a)=\int_{\mathbb R}f(v)e^{av}\,dv.
\]

For continuous compactly supported real f, the existing compiled complex correlation Mellin theorem gives

\[
\int_{\mathbb R}e^{ay}R_f(y)\,dy=M_f(a)M_f(-a).
\]

The real/complex dictionary and conjugation are proved explicitly. In particular, the window density is exp(s/2)M_f(1/2)M_f(-1/2), retaining the opposite-sign moments. With the stated derivative and support hypotheses for R_f,D, the final theorem proves the full individual residual

\[
\sum_{n=2}^N\Lambda(n)n^{-1/2}R_f(\log n-s)
-e^{s/2}M_f(1/2)M_f(-1/2)
=-\int_{\mathbb R}a_C(v)\bigl[D(v-s)-R_f(v-s)/2\bigr]\,dv.
\]

Two further theorems prove integrability of every compact kernel against the existing frozen causal source and justify combining arbitrary finite real window coefficients at one common covered cutoff. They retain negative and endpoint coefficients, proving

\[
\sum_{i\in T}c_i\left[\sum_{n=2}^N\Lambda(n)F_{s_i}(n)
-e^{s_i/2}\int_{\mathbb R}e^{y/2}R(y)\,dy\right]
=-\int_{\mathbb R}a_C(v)\sum_{i\in T}c_i[D(v-s_i)-R(v-s_i)/2]\,dv.
\]

Integrability uses the already proved L1 membership of the ORIGINAL frozen source at each finite C and the bounded compact kernel. It supplies no uniform bound in C and assumes no L1 or L2 membership of the infinite unfrozen source.

All twenty-seven theorems compile without warnings and depend only on propext, Classical.choice and Quot.sound. They were contributed by RH Agent3 and independently reviewed by RH Proof, using standard calculus with no novelty claim. The packet seed's derivative/support instantiation is now formalized below. The complete gamma/form identity remains a further obligation. The signed arithmetic estimate remains open.

### Formal smooth seed and literal autocorrelation regularity

[AutocorrelationRegularity](BuildingBlocks/AutocorrelationRegularity.lean) proves eight additional unconditional theorems. For a smooth real seed f that vanishes whenever |v|>=r, it derives compact support directly from that radius condition. It identifies the literal R_f with reflected convolution and uses mathlib's smooth compact convolution theorem to prove R_f is smooth. It also proves R_f(y)=0 when |y|>=2r and that its closed support lies in [-2r,2r]. The derivative-support theorem then gives R_f'(y)=0 when |y|>=d for any buffer d>2r.

The final theorem instantiates the entire signed finite-window identity above with R=R_f and D=deriv R_f. Its assumptions are smoothness of f, the explicit seed radius bound, 2r<d, and the existing ordinary window/cutoff geometry 1<=N<=C, 0<=d<=s_i, s_i+d<=log N. Continuity of R and D, the global derivative identity, their support bounds, and compact support of f are proved rather than assumed separately. The original frozen source a_C, every actual von Mangoldt atom, every real signed coefficient, and the density factor M_f(1/2)M_f(-1/2) remain unchanged.

All eight theorems compile without warnings and use only propext, Classical.choice and Quot.sound. RH Agent3 contributed the seven-theorem convolution and support handoff; RH Proof independently reviewed the substitution, support geometry and literal source specialization, derived compact support from the radius bound, and integrated the resulting eight theorems. These are standard smooth convolution and finite-window calculus, with no priority claim. No gamma-form identification, uniform source bound, or signed arithmetic upper estimate follows from this regularity theorem.

## Finite Green identity after density cancellation

A subsequent RH Agent3 calculation, independently checked by RH Proof, makes the same cancellation local in a two-sided sequence. This section uses H for the sequence kernel, to distinguish it from the physical test kernel W(y) in (9).

Set A=Gamma(eta)+2D, H_0=A and H_m=-P_|m|-E_|m| for m!=0. The raw all-place sequence is H_m-D(r^m+r^(-m)), including its diagonal Gamma(eta). Put alpha=r+r^(-1) and

\[
 (\mathcal D_\alpha H)_m=H_{m+1}-\alpha H_m+H_{m-1},
 \qquad (\Delta H)_m=H_{m+1}-2H_m+H_{m-1}.
\]

Both density sequences r^m and r^(-m) are annihilated at every integer, including zero. Moving the coefficient filter (1,-alpha,1) from each test to the sequence therefore gives the exact filtered kernel

\[
 (\mathcal D_\alpha^2 H)_m
 =(\alpha^2+2)H_m-2\alpha(H_{m-1}+H_{m+1})+H_{m-2}+H_{m+2}.
\]

For B_J(H)=JH_0+2 sum_(m=1)^(J-1)(J-m)H_m, direct finite summation by parts gives

\[
 B_J(\Delta H)=2(H_J-H_0),\qquad
 B_J(\Delta^2 H)=2(\Delta H_J-\Delta H_0).
\]

Since D_alpha=Delta+h, the full form is

\[
 Q(f_J)=h^2 B_J(H)+4h(H_J-H_0)
                    +2(\Delta H_J-\Delta H_0).
\tag{11}
\]

These identities hold for every symmetric sequence, without a summability or asymptotic hypothesis. For example the summation-by-parts identity follows by collecting coefficients: every interior H_m cancels, the coefficient of H_J is 2 and that of H_0 is -2. Applying the same identity to Delta H proves the second one.

Define, for any positive-index sequence X,

\[
 \mathcal R_J(X)=\frac2J\sum_{m=1}^{J-1}(J-m)X_m
 +\frac{2}{Jh^2}(X_{J+1}+X_{J-1}+2(h-1)X_J-2X_1).
\]

Equation (11), or equivalently the already checked coefficient formula (5), yields

\[
 \frac{Q(f_J)}{Jh^2}=\mathcal K_J-\mathcal R_J(E),
 \qquad
 \mathcal K_J=A\left(1+\frac{4-4h}{Jh^2}\right)
                 -\mathcal R_J(P).
\tag{12}
\]

The exponential tail of P gives K_J=A-2 sum_(m>=1)P_m+O(1/J), by its finite first absolute moment. There is no corresponding proved estimate on R_J(E). Full positivity on this family requires R_J(E)<=K_J, retaining the signed triangular average and the final-window second difference together. Equations (9)-(10) express those same terms in the original frozen source. Density cancellation and the Green identity prove neither their required bound nor RH. Positivity on this fixed packet family is itself a restricted test, not asserted to be the full RH criterion.

## Exact response to exponential modes

RH Proof supplied the following bounded test of what the finite filter itself can remove. Extend the finite linear residual R_J to complex sequences. For X_m=q^m with q!=0,1, put d=q+q^(-1)-2. The exact response for every J>=3 is

\[
 \mathcal R_J(X)=\frac{2q}{1-q}
 -\frac{2q}{J}\left(\frac1{(1-q)^2}+\frac2{h^2}\right)
 +\frac{2q^J}{Jh^2}\frac{(d+h)^2}{d}.
\tag{13}
\]

The finite triangular geometric sum is

\[
 \sum_{m=1}^{J-1}(J-m)q^m
 =\frac{Jq}{1-q}-\frac{q(1-q^J)}{(1-q)^2}.
\]

Substitute this in the definition of R_J. The coefficient of q^J is h^2/d+d+2h=(d+h)^2/d, proving (13). The triangular sum follows by summing the geometric progressions for the J-m copies of each q^m, so no infinite convergence or analytic continuation is used. Exact symbolic checks at J=3,...,15 corroborate the algebra; the displayed finite proof applies to every J>=3.

The denominator d=(q-1)^2/q is nonzero under the stated hypotheses. Since alpha=r+r^(-1)=2-h,

\[
 d+h=q+q^{-1}-\alpha
     =\frac{(q-r)(q-r^{-1})}{q}.
\]

Thus the growing coefficient in (13) vanishes exactly for the two pole modes q=r,r^(-1). At the excluded constant mode q=1, direct finite summation instead gives R_J(1)=J-1+4(h-1)/(Jh^2).

For L=log2 and q=exp(zL) with 0<Re z<1/2, one has 1<|q|<r^(-1), so neither pole root is possible. Equation (13) then gives the nonzero limit

\[
 \lim_{J\to\infty}\frac{J\mathcal R_J((q^m)_m)}{q^J}
 =\frac2{h^2}\frac{(d+h)^2}{d}\ne0.
\]

Consequently the complex modal response has magnitude of order |q|^J/J. Removing the exact density and pole modes does not bound arbitrary growing modes inside the critical strip.

This is a response calculation, not an assumption that the actual arithmetic error is a single exponential or has a convergent zero expansion. It supplies no actual error growth or sign. In particular the required comparison is an upper bound on a real residual: a surviving mode with a negative real coefficient can behave differently from one with a positive coefficient, and distinct modes can interfere. Sampling also retains phases modulo 2pi/L. A proof for this fixed carrier family cannot be promoted to RH without a further argument covering the full required test space. Equation (13) and its finite triangular-sum prerequisite are now compiled as described below. Its asymptotic limit remains unformalized.

## Compiled finite weighted sums and exact response

[FiniteTriangularGeometric.lean](BuildingBlocks/FiniteTriangularGeometric.lean) contains six theorems supplied and independently checked by RH Proof. It proves the recurrence for the literal finite reversed weighted sum, its polynomial identity for every complex q and every natural length, and equality to the forward weighted sum by exact index reflection. Removing its k=0 term gives precisely the positive-lag triangular sum. Its rational closed form requires only q!=1. The exact finite mode-residual theorem retains both endpoint powers and the first-window correction and proves (13) for q!=0,1, h!=0 and positive length.

The mode residual is defined from the actual finite weighted sum; no infinite geometric convergence, prime-error estimate, spectral expansion or RH premise appears. All six assumption checks report only propext, Classical.choice and Quot.sound, without new warnings or admitted proofs. These are formalizations of standard finite-sum algebra and its application to the published signed residual, with no novelty claim for the geometric identities. The limit, pole-root specialization, full correlation and frozen-source specialization of the logarithmic-window bridge, full Green identity and signed bound remain additional Lean obligations.

[Compact-window certificate scope](compact-window-weil-certificate-carrier-scope.md) checks Zhu’s September 2026 v2 theorem statements against the actual q-flat carrier. Its nonzero endpoint packets are separated by (J+1)log2, so no translation fits the reported support-1.6 certificate for J>=3. The support argument for any nonzero seed in an interval narrower than log2 is now compiled in FinitePacketSupportSeparation; the paper certificate was not recomputed and no RH bound follows. Mixed packet terms remain uncontrolled by that small-window theorem alone.

[Formal packet support separation](BuildingBlocks/FinitePacketSupportSeparation.lean) proves nine unconditional theorems, including the literal q-flat coefficient endpoint identities and exclusion of every translated support-1.6 window for J>=3. The general result assumes any nonzero seed supported in an interval of width less than log2; seed positivity and a nonzero value at zero are unnecessary. It retains all finite packet coefficients. The full form, smooth seed construction and mixed arithmetic estimate remain separate obligations.
