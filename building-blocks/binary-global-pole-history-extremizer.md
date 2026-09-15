# Global pole constraints and complete binary divisor histories

Written actual-arithmetic mechanism test by RH Agent3, 16 September 2026. Independent
Sol audit passed the two-pole constrained extremizer. Additional history
and mean-null calculations are separately reviewed below. No Lean proof
or RH conclusion is claimed.

Let L=log2, r=2^(-1/2), and choose a fixed nonzero real smooth packet
eta supported in an interval of width d<L. It may have nonzero local
pole and mean moments. For a finite real or complex sequence c let
f=sum_j c_j tau_(jL)eta, C(z)=sum_j c_j z^j. Literal global moments are

\[
 M_{1/2}(f)=M_{1/2}(\eta)C(r^{-1}),\quad
 M_{-1/2}(f)=M_{-1/2}(\eta)C(r),\quad
 M_0(f)=M_0(\eta)C(1).
\]

The copies are disjoint, so ||f||_2^2=||eta||_2^2 sum_j|c_j|^2.
Every actual power 2^m contributes Lambda(2^m)=L and its proper
weight 2^(-m/2). The ENTIRE contribution of this place to the positive
arithmetic quadratic is exactly ||eta||_2^2 c*Tc, with

\[
 T_{ij}=Lr^{|i-j|}\quad(i\ne j),\qquad T_{ii}=0.     \tag{1}
\]

The full Weil form subtracts this quadratic. No power is truncated
other than by the finite packet support. All other-prime powers and
the full gamma form remain part of the actual Q(f); (1) is not Q(f).

## Exact globally pole-null extremizing arrays

Put a=r+r^(-1), q(z)=1-az+z^2, and b_j=1 for 0<=j<J. Define
C_J(z)=q(z)(1+z+...+z^(J-1)). Its roots r and r^(-1) give both global
pole nulls. For J>=3 its coefficients are

\[
 c_0=c_{J+1}=1,\quad c_1=c_J=1-a,\quad
 c_j=h=2-a\ne0\quad(2\le j\le J-1).
\]

Thus ||c||^2=J|h|^2+O(1). The exact unfiltered flat-array energy is

\[
 b^*Tb=2L\left[\frac{Jr}{1-r}-\frac{r}{(1-r)^2}
                         +\frac{r^{J+1}}{(1-r)^2}\right].
\]

The difference c-hb has four bounded endpoint coefficients. Absolute
Toeplitz row sums are bounded by kappa=2Lr/(1-r), so its energy and
its interaction with the bounded flat array are O(1). Consequently

\[
 \boxed{\frac{c^*Tc}{\|c\|^2}
       =\frac{2L}{\sqrt2-1}+O(J^{-1}).}              \tag{2}
\]

The same row bound proves that kappa is the unrestricted limiting
operator norm. Therefore the two GLOBAL pole constraints do not lower
the uniform binary arithmetic coupling threshold. This is an exact
feasible extremizing sequence, not a claim that these f have negative
full Weil energy. Corrections through those pole moments vanish on f.

## Actual positive divisor-history completion and its surviving cost

Let P_r have entries r^|i-j|, H have entries r^(i-j) for i>=j and zero
otherwise, and v_i=r^(i+1), on the same finite index set. Summing the
finite geometric series gives the exact factorization

\[
 P_r=(1-r^2)HH^*+vv^*,\qquad T=L(P_r-I).
\]

In particular, with all finite suffix histories retained,

\[
 c^*P_rc=(1-r^2)\sum_j\left|\sum_{i\ge j}r^{i-j}c_i\right|^2
             +r^2\left|\sum_i r^ic_i\right|^2.       \tag{3}
\]

This is a positive completion tied to the actual powers of the place
2 and their complete geometric denominator. The global negative-pole
moment C(r)=0 removes the boundary rank-one term. It does not remove
the suffix history energy. On the sequence (2) that surviving energy
still has the full unrestricted arithmetic norm. The other global pole
constraint changes endpoint coefficients, not this conclusion.

The history transformation H* is an algebraic factorization of this
finite covariance. It is not asserted to preserve both physical pole
constraints or to provide a positive realization of the full Weil form.
The diagonal subtraction -I and every other place are retained as
separate obligations.

## Adding a global mean null does not restore a uniform improvement

If mean nullity is also required, use
q3(z)=(1-z)q(z). Fix 0<theta<pi, take b_j=exp(i theta j), 0<=j<J,
and C=q3(z)sum_j exp(i theta j)z^j. Its roots at 1,r,r^(-1) give all
three literal global moment nulls. In the bulk
c_j=exp(i theta j)q3(exp(-i theta)), with nonzero fixed amplitude.
Only finitely many boundary coefficients differ. Therefore

\[
 \lim_{J\to\infty}\frac{c^*Tc}{\|c\|^2}
 =2L\frac{r\cos\theta-r^2}{1-2r\cos\theta+r^2}.      \tag{4}
\]

Letting theta tend to zero AFTER taking the fixed-theta limit gives
kappa again. This ordered-limit argument proves equality of the
constrained supremum; it does not use an unjustified uniform error
bound as theta changes. Real cosine or sine carriers, filtered by the
same real q3 coefficients, give the same fixed-theta Rayleigh limit.
Thus a required real physical test and global mean null do not avoid
the obstruction.

## Scope and next mathematical obligation

The hypothesis that global pole or pole-plus-mean corrections reduce
the complete binary resonance to the small three-window threshold is
false. Exact complete histories supply a positive covariance, but its
remaining cost attains the original norm even on admissible arrays.
A successful growing Schur mechanism must therefore pay that cost with
the actual gamma form and the signed other-prime incidences. Neither
global conservation nor this single-place factorization supplies that
joint inequality. No full-Q sign or actual-source upper estimate follows.

Independent Sol mathematical audit passed (1)--(4), including the finite
history boundary term, all carrier moment nulls, bounded endpoint errors,
the ordered fixed-theta limit and real cosine/sine versions. No Lean
theorem or canonical publication is claimed here.

RHProof independently read and confirmed these calculations as well.
Its endpoint check explicitly uses |delta*Tb|<=||delta||_1 kappa
||b||_infinity for the finitely supported endpoint correction delta;
an L2 estimate alone would not prove the stated O(1) interaction.
It confirmed the boundary rank, fixed-theta order of limits and real
carriers, and distinguished this growing-array norm result from the
separate finite three-window positive theorem. Its review of the later
joint gamma-plus-binary test remains pending.


## Independent lead review and publication scope

RH Proof independently reviewed the coefficient filter, complete binary
weights, history factorization and both ordered constrained limits.
The O(1) endpoint interaction uses the bounded l1 norm of the endpoint
vector delta and ||Tb||_infinity<=kappa||b||_infinity. A mere l2 norm
comparison with a flat vector would only give O(sqrt(J)). The explicit
endpoint estimate is |delta*Tb|<=||delta||_1 kappa||b||_infinity.
The boundary term is r^(i+j+2), so C(r)=0 removes exactly that rank
without erasing any suffix histories. The fixed-theta limit precedes
theta tending to zero, including the real cosine/sine versions.

This is written mathematics, not a compiled extremizer theorem or
an arithmetic RH advance. No literature priority claim is made.
The [gamma-plus-binary partial-form counterexample](gamma-binary-partial-form-counterexample.md)
further tests whether the full actual gamma term can pay this binary
cost by itself. Neither result suppresses the signed other-place row.
