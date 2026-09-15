# A factorial cross-size energy and its missing Möbius upper bound

This note constructs an exact positive quadratic kernel from factorial multinomial counts and their entropy density. It gives a quantitative Mertens consumer and one falsifiable arithmetic upper-bound hypothesis. It does not prove that hypothesis or RH. The kernel representation belongs to classical gamma-integral and positive-kernel methods; no priority claim is made.

Publication scope: independently reviewed written mathematics, including exact integer verification of the N=13 common-divisor blocks below. Lean formalization remains unfinished. The [quotient-renewal companion](factorial-mobius-quotient-renewal.md) records the complete renewal constraints and the exact Jensen upper bound with its retained variance. That upper bound leaves M(N)^2 with coefficient one; it supplies no unconditional RH-scale estimate.

## The full factorial kernel, with density retained

For positive integers n,m define

\[
B(n,m)=(n+m)\log(n+m)-n\log n-m\log m-\log\binom{n+m}{n}.
\tag{1}
\]

Its diagonal is the central-binomial entropy defect

\[
b(n)=B(n,n)=2n\log2-\log\binom{2n}{n}.
\]

The factorial term retains every prime power:

\[
\log\binom{n+m}{n}
=\sum_{d\le n+m}\Lambda(d)
\left(\left\lfloor\frac{n+m}{d}\right\rfloor
-\left\lfloor\frac nd\right\rfloor
-\left\lfloor\frac md\right\rfloor\right).
\tag{2}
\]

The carry in parentheses is zero or one. Integrality yields nonnegative valuations, but does not make each carry kernel positive semidefinite: at d=3, on sizes 1 and 2, its matrix is

\[
\begin{pmatrix}0&1\\1&1\end{pmatrix},\qquad\det=-1.
\]

The combined density-minus-factorial kernel has the stronger exact representation

\[
\boxed{B(x,y)=\int_0^\infty(1-e^{-xt})(1-e^{-yt})w(t)dt},
\qquad
w(t)=\frac1{t^2}-\frac1{t(e^t-1)}>0,
\tag{3}
\]

where the real extension replaces the factorial by gamma functions. A short proof differentiates both sides in x and y. Both mixed derivatives equal

\[
\frac1{x+y}-\psi'(x+y+1)
=\int_0^\infty e^{-(x+y)t}\left(1-\frac{t}{e^t-1}\right)dt.
\]

Both kernels vanish at either coordinate zero, which fixes the integration constants. The trigamma integral is classical; see [DLMF 5.9.16](https://dlmf.nist.gov/5.9.E16) and its derivative. At zero, w(t)=1/(2t)+O(1); at infinity it is asymptotic to 1/t². Thus (3) converges.

Consequently, for every finite real coefficient vector a,

\[
\boxed{\sum_{i,j}a_i a_j B(x_i,x_j)
=\int_0^\infty\left|\sum_i a_i(1-e^{-x_i t})\right|^2w(t)dt\ge0.}
\tag{4}
\]

This retains coherent signed cross-size terms, rather than applying b(n)≥0 separately. The positivity uses the full compensated factorial kernel; (2) cannot prove it prime by prime.

## The actual finite Möbius adjoint

Put

\[
q_n=\lfloor N/n\rfloor,\quad
M(N)=\sum_{n\le N}\mu(n),\quad
g_N(t)=\sum_{n\le N}\mu(n)(1-e^{-q_n t}),
\]
\[
Q_N=\sum_{n,m\le N}\mu(n)\mu(m)B(q_n,q_m)
=\int_0^\infty |g_N(t)|^2w(t)dt.
\tag{5}
\]

No divisor histories or finite-adjoint terms have been removed. The exact floor identity gives

\[
\sum_{n\le N}\mu(n)q_n=1,
\qquad g_N(t)=t+O_N(t^2)\quad(t\downarrow0).
\tag{6}
\]

At the opposite boundary,

\[
|g_N(t)-M(N)|\le N e^{-t}.
\tag{7}
\]

If M(N)≠0, take

\[
T=\max\{2,\log(2N/|M(N)|)\}.
\]

Then |g_N(t)|≥|M(N)|/2 for t≥T. Also w(t)≥1/(2t²) for t≥2, since e^t−1≥2t there. Integrating this actual tail proves

\[
\boxed{Q_N\ge\frac{|M(N)|^2}{8T}
\ge\frac{|M(N)|^2}{8(2+\log(2N))}.}
\tag{8}
\]

The zero case is immediate. Thus a bound Q_N≪_εN^{1+ε} for every ε>0 would imply the usual RH-sufficient Mertens estimate. This is a consumer of an upper bound, not a proof of that upper bound.

## Exact hyperbola convolution and the converse energy bound

The root calculation gives a second exact arithmetic expression, using every μ coefficient:

\[
\boxed{g_N(t)=(1-e^{-t})\sum_{j=1}^N e^{-(j-1)t}M(\lfloor N/j\rfloor).}
\tag{10}
\]

Indeed, expand \(1-e^{-qt}=(1-e^{-t})\sum_{j=1}^{q}e^{-(j-1)t}\), interchange finite sums, and observe that \(q_n\ge j\) exactly when \(n\le N/j\). This is the finite hyperbola grouping, with no approximation to the floor boundary.

Assume RH, and choose \(a=1/2+\delta<1\). Its classical Mertens consequence \(|M(x)|\le C_\delta x^a\), inserted in (10), gives

\[
|g_N(t)|\le C_\delta N^a(1-e^{-t})
\sum_{j\ge1}e^{-(j-1)t}j^{-a}.
\]

For \(0<t\le1\), comparison with the integral of \(e^{-tx}x^{-a}\) bounds the last expression by \(C_aN^at^a\); for \(t\ge1\) it is at most \(C_aN^a\). Since \(w(t)=O(1/t)\) at zero and \(w(t)=O(1/t^2)\) at infinity, integration yields

\[
Q_N\le C_\delta N^{1+2\delta}.
\tag{11}
\]

Combining (8) and (11), and absorbing the logarithm into an arbitrarily small power, proves

\[
\mathrm{RH}\quad\Longleftrightarrow\quad
Q_N\ll_\epsilon N^{1+\epsilon}\ \text{for every }\epsilon>0.
\]

This equivalence does not establish any unconditional upper control. The exact convolution and this converse implication were contributed by the research coordinator during the RH Proof branch calculation, using classical finite hyperbola grouping and the classical RH–Mertens estimate.

## Simultaneous-horizon coercivity without a logarithmic loss

A bound supplied at every horizon has a stronger Mertens consumer than the single-horizon tail estimate (8). For a>=0 and N>=1 put

\[
R_a(N)=\max_{1\le n\le N}\frac{|M(n)|^2}{n^{2a}},\qquad
S_a(N)=\max_{1\le n\le N}\frac{Q_n}{n^{2a}},\qquad
c=\frac{(1-2e^{-2})^2}{4}>0.
\]

Then the actual complete responses satisfy

\[
\boxed{cR_a(N)\le S_a(N)}.
\tag{13}
\]

Choose k attaining the finite maximum R_a(N). For every integer m between 1 and k,

\[
|M(m)|\le\sqrt{R_a(N)}m^a
\le\sqrt{R_a(N)}k^a=|M(k)|.
\]

Thus the normalized maximizing horizon is also an absolute Mertens record through k. With z=e^{-t}, the exact full hyperbola identity (10) gives

\[
g_k(t)-M(k)=-zM(k)
+(1-z)\sum_{j=2}^kz^{j-1}M(\lfloor k/j\rfloor).
\]

The finite sum retains every quotient boundary. Each Mertens value on its right is bounded by |M(k)|; geometric summation therefore yields

\[
|g_k(t)-M(k)|\le2e^{-t}|M(k)|\qquad(t>0).
\]

For t>=2, this proves |g_k(t)|>=(1-2e^{-2})|M(k)|. The actual factorial kernel obeys w(t)>=1/(2t^2) there. Integrating the full tail gives Q_k>=c|M(k)|^2, and dividing by k^{2a} proves (13). No sign condition on other horizons is needed. A sign-changing actual response is allowed; the estimate uses a horizon chosen from the whole prefix, not an arbitrary fixed horizon.

For a>0 the retained Jensen bound in the [renewal companion](factorial-mobius-quotient-renewal.md), with c_j<=1/j, also gives

\[
Q_n\le\sum_{j=1}^n\frac{|M(\lfloor n/j\rfloor)|^2}{j}
\le R_a(N)n^{2a}\sum_{j=1}^\infty j^{-1-2a}.
\]

Consequently

\[
\boxed{cR_a(N)\le S_a(N)\le\zeta(1+2a)R_a(N)}\qquad(a>0).
\tag{14}
\]

In particular, the uniform bound Q_N=O(N) is equivalent to the uniform bound M(N)=O(sqrt(N)), without the logarithmic loss in (8). This is a stronger consequence of the candidate diagonal hypothesis than the earlier single-horizon consumer: (H) implies this uniform Mertens bound.

Such a bound also forces every nontrivial zeta zero to be simple. It first implies RH. For Re(s)>1/2 the classical identity 1/zeta(s)=s integral_1^infinity M(x)x^{-s-1}dx then gives |1/zeta(s)|<=C|s|/(Re(s)-1/2). A zero of order r>=2 on the critical line would make the left side grow as u^{-r} at s=rho+u, contradicting the u^{-1} upper bound as u decreases to zero. This implication and the Mellin identity are classical; see Section 2 of [Odlyzko–te Riele](https://ir.cwi.nl/pub/1823/1823D.pdf). Necessity of (H) under RH is not asserted.

The simultaneous-horizon inequality (13) was derived by RH Proof during the arithmetic energy attempt. It controls the consequence of an upper bound and supplies no unconditional upper bound itself. The residue-loading recurrence did not produce the missing signed estimate, and this record argument does not repair that failure. Further equivalent norm comparisons will not be treated as an energy-bound mechanism. These statements are written proofs; their Lean formalization remains unfinished.

## A specific cross-base arithmetic hypothesis

Consider the precise statement

\[
\boxed{Q_N\le D_N:=\sum_{n\le N}\mu(n)^2B(q_n,q_n)\quad\text{for every }N.}
\tag{H}
\]

It asserts that the total signed offdiagonal energy is nonpositive. It supplies information beyond positive semidefiniteness.

The central binomial coefficient is the largest coefficient in the expansion of 2^{2q}, so

\[
b(q)\le\log(2q+1).
\]

Therefore

\[
D_N\le\sum_{n\le N}\log(1+2N/n)
\le N\int_0^1\log(1+2/x)dx
=(3\log3-2\log2)N.
\tag{9}
\]

Together, (H), (8), and (9) give the single-horizon consumer M(N)=O(√(N log N)); the simultaneous-horizon estimate (13) strengthens this to M(N)=O(√N), hence RH and simplicity of every nontrivial zero. We have not proved (H), and do not claim it is equivalent to RH or necessary for RH.

Floating-point finite tests through N=5000 found no violation of (H); the largest observed ratio Q_N/D_N was approximately 0.7802966926 at N=13. These tests grouped identical quotient sizes and evaluated the exact kernel through log gamma. They are exploratory numerics, not certified assertions.

## Where special signed arithmetic must enter

Factorial integrality and the first-moment identity alone cannot imply (H). At N=24 choose integer coefficients

\[
a_n=\begin{cases}1,&13\le n\le21,\\-1,&9\le n\le12,\\0,&\text{otherwise}.\end{cases}
\]

They satisfy the same exact moment neutrality,

\[
\sum_{n\le24}a_n\lfloor24/n\rfloor=9-8=1.
\]

Their coherent quadratic energy and diagonal cost are

\[
Q(a)=81B(1,1)+16B(2,2)-72B(1,2)
=273\log2-160\log3,
\]
\[
D(a)=9B(1,1)+4B(2,2)=21\log2-4\log3.
\]

Thus

\[
Q(a)-D(a)=12(21\log2-13\log3)>0,
\]

because 2^{21}=2097152>1594323=3^{13}. This is an exact counterexample to deriving the desired upper inequality from signed integer coefficients, the floor moment, and all individual factorial identities alone.

For the actual μ coefficients, the unresolved input is precisely the cross-size offdiagonal inequality in (H), or a weaker upper bound on Q_N. Multiplicative μ structure must enter there. Gamma positivity and Stirling estimates do not supply it.

## What multiplicative regrouping does and does not cancel

A successor-by-successor proof of (H) would follow if C_N=Q_N-D_N were nonincreasing, since C_1=0. This stronger compensation mechanism is false for the actual sequence. At N=4 the nonzero Möbius coefficients have quotient sizes 4,2,1 and signs +,-,-. At N=5 their quotient sizes are 5,2,1,1 with signs +,-,-,-. Thus the complete ordered cross terms are

\[
C_4=-2B(4,2)-2B(4,1)+2B(2,1)
=20\log2-6\log3-6\log5,
\]
\[
C_5=-2B(5,2)-4B(5,1)+4B(2,1)+2B(1,1)
=-22\log2-10\log3+30\log5-12\log7.
\]

The last term retains the two ordered histories from distinct indices 3 and 5 sharing quotient size one; the diagonal still counts their two individual squares. Consequently

\[
\boxed{C_5-C_4=\log\frac{5^{36}}{2^{42}3^4 7^{12}}>0}.
\]

The exact numerator is 14551915228366851806640625 and the denominator is 4930844615567266465972224. Direct integer comparison proves the sign. Both C_4 and C_5 remain negative, as respectively 2^{20}<3^6 5^6 and 5^{30}<2^{22}3^{10}7^{12}. Thus the actual prime birth at 5 disproves monotonic offdiagonal compensation, not (H). Any successful successor energy argument must retain a reserve across horizons or prove a different total bound. RH Proof derived and independently checked these complete expressions by exact integer arithmetic; Lean formalization remains unfinished.

Write every contributing squarefree pair as \(n=da,m=db\), with \(d=\gcd(n,m)\). Then \(d,a,b\) are pairwise coprime and squarefree, and \(\mu(n)\mu(m)=\mu(a)\mu(b)\). Consequently the exact offdiagonal expression is

\[
Q_N-D_N=
\sum_{\substack{d\le N\\d\ \mathrm{squarefree}}}
\ \sum_{\substack{a\ne b,\ da,db\le N\\d,a,b\ \mathrm{pairwise\ coprime\ and\ squarefree}}}
\mu(a)\mu(b)B(\lfloor N/(da)\rfloor,\lfloor N/(db)\rfloor).
\tag{12}
\]

The common divisor's Möbius sign squares away. The remaining coprime branch signs do not. At the actual N=13, the d=1 history block is exactly

\[
\log\frac{5^{34}13^{104}}{2^{80}3^{36}7^{16}17^{30}19^{36}}>0.
\]

The integer numerator exceeds the denominator by direct integer comparison; its logarithm is approximately 4.3430394053. The d=2,3,5 blocks are respectively

\[
\log\frac{3^{28}}{2^{20}7^{10}},\quad
\log\frac{2^8 5^2}{3^{10}},\quad
4\log(2/3),
\]

all negative, approximately −2.5609010190, −2.2220696173, and −1.6218604324. The full sum is negative, but the common-history blocks do not have a common sign. Thus this exact multiplicative regrouping does not give the desired negative measure.

There is also a rigorous obstruction to pointwise negativity in the natural Laplace variable. Define

\[
p_N(t)=g_N(t)^2-\sum_{n\le N}\mu(n)^2(1-e^{-q_n t})^2.
\]

Then \(Q_N-D_N=\int_0^\infty p_N(t)w(t)dt\), while

\[
\lim_{t\to\infty}p_N(t)=M(N)^2-\sum_{n\le N}\mu(n)^2.
\]

The [Odlyzko–te Riele disproof of the Mertens conjecture](https://ir.cwi.nl/pub/1823) proves the existence of actual integer cutoffs with \(M(N)^2>N\). At any such cutoff the displayed limit is strictly positive, so \(p_N(t)>0\) throughout a sufficiently late tail. Hence the signed measure \(p_N(t)w(t)dt\) is not universally nonpositive for the actual Möbius coefficients.

This does not falsify the integrated hypothesis (H). It shows that any proof of (H) must establish compensation between different t regions; pointwise domination of the coherent square by the diagonal square cost is already false for actual μ. No exact telescoping identity or integrated upper inequality establishing that compensation has been found here.

## Classical context

Gamma-integral and complete-monotonicity methods have an extensive literature; see [Berg, *Integral representation of some functions related to the Gamma function*](https://arxiv.org/abs/math/0411550). Möbius-weighted Hilbert-space criteria also have classical predecessors, including [Báez-Duarte, *New versions of the Nyman–Beurling criterion for the Riemann hypothesis*](https://www.kurims.kyoto-u.ac.jp/EMIS/journals/HOA/IJMMS/Volume31_7/242719.pdf). These references provide methodological context, not attribution of the exact candidate (H). No literature priority audit establishing novelty of (1)–(8) or (H) has been completed.
