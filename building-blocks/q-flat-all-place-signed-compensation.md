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

## Density-cancelled recurrence and the exact discrete Green identity

The raw sign observation above does not weaken global compensation.
Its exponentially large density pieces cancel deterministically.
The following identity performs that cancellation before estimating
anything. Extend the kernels to all integers by symmetry and write

\[
 W_0=\Gamma(\eta)+2D=:A,\qquad W_m=-P_{|m|}-E_{|m|}\quad(m\ne0).
\]

The raw all-place kernel is

\[
 W_m^{\rm raw}=W_m-D(r^m+r^{-m})\quad(m\in\mathbb Z).
\]

In particular its diagonal is Gamma(eta), not A. Put a=r+r^-1=2-h
and define the two-sided difference operator

\[
 (\mathcal D_a W)_m=W_{m+1}-aW_m+W_{m-1}.
\]

Both r^m and r^-m are annihilated by this operator at EVERY integer,
including zero. Thus

\[
 \mathcal D_a^2 W^{\rm raw}=\mathcal D_a^2 W.
\]

Moving the physical coefficient filter q=(1,-a,1) to the kernel is
exactly this squared operator. Its filtered kernel is

\[
 V_m=(a^2+2)W_m-2a(W_{m-1}+W_{m+1})+W_{m-2}+W_{m+2}.
\]

For the flat carrier of length J, the FULL form therefore equals

\[
 Q(f_J)=JV_0+2\sum_{m=1}^{J-1}(J-m)V_m.                 \tag{6}
\]

No bound, prime-density asymptotic, discarded pole, or positivity
assumption is used. The entire raw density disappears pointwise
from V, rather than being declared a small endpoint correction.

Let Delta W_m=W_(m+1)-2W_m+W_(m-1), and
B_J(W)=JW_0+2 sum_(m=1)^(J-1)(J-m)W_m. Summation by parts of the
finite triangular weights gives

\[
 B_J(\Delta W)=2(W_J-W_0),\qquad
 B_J(\Delta^2 W)=2(\Delta W_J-\Delta W_0).
\]

Since D_a=Delta+h, the density-cancelled Green identity is

\[
 Q(f_J)=h^2 B_J(W)+4h(W_J-W_0)
                    +2(\Delta W_J-\Delta W_0).         \tag{7}
\]

Equations (6)--(7) are valid for any symmetric kernel, and hence for
the actual complete arithmetic and gamma kernel above. Expanding
(7) recovers (5) with the same diagonal and endpoint factors. The
symbolic audit verifies both routes for arbitrary symbolic W_m,
not just a numerical prime model.

For the actual arithmetic residual alone define the signed quantity

\[
 \mathcal R_J(E)=\frac2J\sum_{m=1}^{J-1}(J-m)E_m
 +\frac{2}{Jh^2}\bigl(\Delta E_J+2hE_J-2E_1\bigr).     \tag{8}
\]

Define R_J(P) by the same formula, and retain the exact known term

\[
 \mathcal K_J=A\left(1+\frac{4-4h}{Jh^2}\right)
                    -\mathcal R_J(P).
\]

Then the actual finite signed comparison is exactly

\[
 \frac{Q(f_J)}{Jh^2}=\mathcal K_J-\mathcal R_J(E).       \tag{9}
\]

The quantitative compensation still required is R_J(E)<=K_J,
including BOTH the triangular residual average and the Delta E_J+2hE_J
endpoint expression. Neither can be replaced by an absolute budget
or dropped independently. P_m has an exponential tail, so
K_J=A-2 sum_(m>=1)P_m+O(1/J), with the error controlled by its finite
first absolute moment. No O(J) bound on the actual residual or Q
is inferred: that would require the cancellation being sought.

## Comparison with the full explicit formula

[Suzuki's formula (5.15) and Section 3.2](https://londmathsoc.onlinelibrary.wiley.com/doi/10.1112/jlms.12785)
retain all complex nontrivial zeros with multiplicity. Applied to
shifted R, they identify W with the zero-spectral kernel after
adding the two pole terms. The filter above then multiplies each
mode exp(z mL) by (exp(zL)+exp(-zL)-a)^2, where z=rho-1/2.
On the critical line this multiplier is (2cos(Im(z)L)-a)^2>0.
Off the critical line it does not give a positive spectral measure.
Thus (9) is an arithmetic realization of a restricted Weil test;
positivity of this one carrier family is not the full criterion.
Full positivity for all compact smooth tests remains equivalent to
RH, and is not assumed here.

The gamma sign and quarter-argument normalization agree with
[Connes--Consani, Appendix B, (153)--(154)](https://alainconnes.org/wp-content/uploads/Selecta.pdf).
The new finite recurrence needs no spectral formula for its proof.
The spectral comparison explains why eliminating density is not
itself a proof of the remaining signed inequality.

The root independently supplied the exact selected-prime identity

\[
 \sum_{m=1}^{J+1}a_mr^m
   =\frac{J(1-r)^3-(1-r)^2}{r}-2r.
\]

For p=2 its sign changes between J=43 and J=44. This only delimits
the selected-prime row; it is not a full-Q sign threshold. No
arithmetic isolation by narrowing eta is used in (1)--(9); the
packet width stays fixed, and all actual other-prime powers remain.
Narrowing exponentially with J would change the gamma cost and is
a different regime.

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

This identifies the actual consumer without redefining the source or assuming a globally square-integrable infinite source. V_J is signed; neither nonnegativity of eta nor the finite-source identification proves a sign for the last integral. The needed uniform arithmetic comparison in (10) remains open. Formalization of the Stieltjes integration-by-parts bridge and of the full window calculation remains an additional Lean obligation.

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
