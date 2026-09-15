# Exact quotient renewal for the factorial Möbius response

RH Proof supplied this finite arithmetic calculation while auditing the factorial cross-size energy candidate. It retains every integer quotient and all Möbius coefficients. Most identities remain written mathematics. The binary carry and finite response identity now have Lean theorems as specified below; no RH proof is asserted. The divisor identities and finite geometric summation are classical; no priority claim is made.

For an integer N>=1 put q_n=floor(N/n), M(x)=sum_(n<=x)mu(n), and

\[
 g_N(t)=\sum_{n=1}^N\mu(n)(1-e^{-q_nt}).
\]

The associated compensated factorial kernel is

\[
 B(x,y)=(x+y)\log(x+y)-x\log x-y\log y
       -\log\binom{x+y}{x},
\]

on positive integer sizes, and the proposed energy is Q_N=sum_(n,m<=N)mu(n)mu(m)B(q_n,q_m). Its positive-kernel representation does not by itself supply the required RH-scale upper bound on Q_N.

## All quotient constraints, not just the first moment

Let S_N be the set of distinct q_n and group the actual coefficients as A_q=sum_(n:q_n=q)mu(n). For every integer 1<=k<=N,

\[
 \sum_{q\in S_N} A_q\left\lfloor\frac qk\right\rfloor=1.
\tag{1}
\]

Indeed floor(floor(N/n)/k)=floor(N/(nk)), so the left side equals sum_(n<=floor(N/k))mu(n)floor(floor(N/k)/n). The exact divisor identity sum_(d|m)mu(d)=1_(m=1), summed over m<=floor(N/k), gives 1. This is the complete family of finite quotient constraints; the familiar first moment is only k=1.

Moreover these constraints uniquely determine the grouped vector on S_N. Order S_N from largest to smallest and use k equal to each successive quotient. The coefficient of A_k is 1, all smaller quotients contribute zero, and every larger coefficient is already determined. The resulting system is triangular. Therefore a counterexample using arbitrary signed coefficients with only the first moment does not test this full arithmetic system. Uniqueness does not prove the proposed energy bound: it identifies the actual vector whose bound remains to be established.

## Exact Abel polynomial and finite renewal

For z=e^{-t}, t>0, finite geometric expansion gives

\[
 g_N(t)=(1-z)\sum_{k=1}^N z^{k-1}M(\lfloor N/k\rfloor).
\tag{2}
\]

To see this, expand 1-z^{q_n}=(1-z)sum_(j=0)^(q_n-1)z^j and interchange finite sums. The coefficient of z^(k-1) is sum_(n:q_n>=k)mu(n)=M(floor(N/k)). Thus the response is a positive Abel averaging kernel applied to a signed Mertens history, not an average of nonnegative prime counts.

There is also an exact finite renewal equation, valid for every real t:

\[
 \sum_{k=1}^N g_{\lfloor N/k\rfloor}(t)=1-e^{-Nt}.
\tag{3}
\]

Expand the left side and group m=kn. The coefficient of 1-exp(-floor(N/m)t) is sum_(n|m)mu(n), which vanishes except at m=1. Nested integer quotients are equal to floor(N/(kn)), so no floor endpoint is changed. In particular g_N(t)=1-e^{-Nt}-sum_(k=2)^N g_floor(N/k)(t). The bounded positive forcing does not make every individual response positive.

## An actual sign-changing response

At N=13 the only nonzero grouped coefficients are A_13=1, A_6=-1, A_4=-1 and A_1=-2. Hence exactly

\[
 g_{13}(t)=-3+2z+z^4+z^6-z^{13},\qquad z=e^{-t},
\]
\[
 g_{13}(\log2)=-15745/8192<0.
\tag{4}
\]

At zero, g_13(0)=0 and g_13'(0)=sum mu(n)floor(13/n)=1, so g_13(t)>0 for all sufficiently small positive t. Continuity therefore gives a genuine sign change before log2. This uses the actual Möbius vector satisfying every constraint (1), not a fabricated first-moment example. It excludes a nonnegative-response argument for this finite renewal. It does not disprove the positive quadratic energy, its candidate upper bound or RH.

## Bounded exploratory test and remaining estimate

A quotient-grouped floating-point search tested 241 selected horizons, including 13 and horizons from 5001 up to 2000000. It found no violation of Q_N<=D_N, where D_N=sum_(n<=N)mu(n)^2B(q_n,q_n). The largest observed ratio was about 0.7802966926 at N=13. The kernel was evaluated using log gamma for small sizes and the Stirling correction for larger sizes. These are exploratory numerics, not certified inequalities, not every horizon in that range, and not evidence of an all-scale proof.

Separate exact integer checks confirmed sieve values at selected indices and all k in S_N, together with k=1,2,3,N, in (1) for N=13,24,5001,10007,99991,2000000. They corroborate the implementation; the finite divisor proof establishes (1) for every N and k. The analytic representation uses the classical digamma integral and its derivative, as in [DLMF 5.9.16](https://dlmf.nist.gov/5.9.E16).

The open target is a quantitative upper bound on the coherent Q_N for the actual grouped vector, or a useful signed inequality from the entire constraint system (1). Equations (1)-(3), the sign change and finite passing tests prove no such upper bound. Their Lean formalization also remains unfinished.

## A proved energy upper bound and the exact discarded variance

This is a bounded attempt to estimate the coherent energy, rather than just solve the quotient constraints. Use the positive factorial representation

\[
 Q_N=\int_0^\infty g_N(t)^2w(t)\,dt,\qquad
 w(t)=t^{-2}-[t(e^t-1)]^{-1}>0.
\]

At each t>0 put z=exp(-t), Y_k=M(floor(N/k)), p_k=(1-z)z^(k-1) for 1<=k<=N, and add p_0=z^N with Y_0=0. These nonnegative weights sum to one. Equation (2) is their exact mean g_N(t). The finite variance identity gives

\[
 g_N(t)^2=\sum_{k=1}^N p_kY_k^2
 -\sum_{1\le k<l\le N}p_kp_l(Y_k-Y_l)^2
 -p_0\sum_{k=1}^N p_kY_k^2.
\tag{5}
\]

Every term is integrable against w. Near zero, w=O(1/t) and p_k=O(t); at infinity, w=O(1/t^2) and the finite Y values are bounded. The two variance terms are nonnegative and bounded by the first term. Thus

\[
 Q_N=U_N-V_N\le U_N,
 \qquad U_N=\sum_{k=1}^N c_kM(\lfloor N/k\rfloor)^2,
\tag{6}
\]

where V_N is the integral of the two variance terms in (5). This is an unconditional inequality for the actual Möbius response. It makes no independence assumption about distinct quotient histories.

The weights have an exact closed form:

\[
 c_k=\int_0^\infty w(t)(1-e^{-t})e^{-(k-1)t}\,dt,
 \qquad c_1=1,
 \qquad c_k=1-(k-1)\log\frac{k}{k-1}\quad(k\ge2).
\tag{7}
\]

Indeed B(1,y)=y log(1+1/y) for integer y>=1, and its limit as y tends to infinity is 1. The positive kernel representation and monotone convergence imply integral w(t)(1-exp(-t))dt=1. Subtracting B(1,k-1) from this integral gives c_k. At k=1 the subtracted term is zero, so no expression with log(1/0) is introduced.

For k>=2, c_k=int_0^1 u/(k-1+u)du. Hence

\[
 \frac1{2k}\le c_k\le\frac1{2(k-1)}\le\frac1k.
\tag{8}
\]

The inequality (6) is a genuine energy bound, but it does not have the required scale. The elementary |M(x)|<=x yields only U_N<=(sum_(k>=1)k^(-3))N^2. More decisively, U_N>=M(N)^2 because c_1=1. Proving U_N<=C_epsilon N^(1+epsilon) for every epsilon>0 would already prove the usual RH-sufficient Mertens bound. That arithmetic estimate is not supplied by averaging positivity.

For the proposed diagonal bound Q_N<=D_N, the exact compensation still required is

\[
 V_N\ge U_N-D_N,\qquad
 D_N=\sum_{n=1}^N\mu(n)^2B(q_n,q_n).
\tag{9}
\]

It is not proved here. Dropping V_N erases the coherent difference-history terms that could pay this deficit. The attempt therefore gives an explicit unconditional upper inequality and locates its loss, without a new RH-scale estimate or a claim that every joint energy method fails. Equations (5)-(9) remain written mathematics requiring Lean formalization.


## Binary-horizon signed work with exact density dissipation

A different bounded energy attempt compares complete horizons, rather than demanding monotonic work at each birth. Let N>=1, b in {0,1}, r=2N+b, and extend q_n=floor(N/n) to n<=r, allowing q_n=0. Define the actual quotient-parity carries

\[
\epsilon_{n,N,b}=\left\lfloor\frac{2N+b}{n}\right\rfloor
-2\left\lfloor\frac Nn\right\rfloor\in\{0,1\}.
\]

Indeed, writing N=nq+a with 0<=a<n gives epsilon=floor((2a+b)/n); the numerator is between zero and 2n-1. Thus every old and newly admitted divisor history remains in the finite innovation

\[
 d_{N,b}(t)=(1-e^{-t})\sum_{n=1}^{r}\mu(n)
 \epsilon_{n,N,b}e^{-2q_nt},\qquad
 \boxed{g_r(t)=g_N(2t)+d_{N,b}(t)}.
\tag{10}
\]

This follows term by term from 1-exp(-(2q+epsilon)t). Since both r and N are positive, the complete floor identities give sum_(n<=r)mu(n)epsilon=1-2=-1. Therefore d_(N,b)(t)=-t+O_N(t^2) at zero. At infinity its limit is M(r)-M(N), from the newly admitted histories with q_n=0. No sign of this innovation is asserted.

The factorial density weight has the exact scaling identity

\[
\frac12w(u/2)=2w(u)-\frac1{u(e^{u/2}+1)}.
\]

To check it, put a=exp(u/2) and use 1/(a-1)-2/(a^2-1)=1/(a+1). Consequently

\[
\begin{aligned}
 R_N&=\int_0^\infty\frac{g_N(u)^2}{u(e^{u/2}+1)}\,du\ge0,\\
 W_{N,b}&=\int_0^\infty
 \bigl[2g_N(2t)d_{N,b}(t)+d_{N,b}(t)^2\bigr]w(t)\,dt,\\
 \boxed{Q_{2N+b}-2Q_N&=W_{N,b}-R_N.}
\end{aligned}
\tag{11}
\]

All terms converge individually. At zero both finite responses are O(t), while w=O(1/t); at infinity both are bounded and w=O(1/t^2). R_N has an exponentially decaying tail. It is the exact positive density dissipation, not a remainder discarded from the factorial kernel. Expanding W retains every ordered pair of carry histories, the mixed history terms and their Möbius signs.

The sufficient signed-work budget W_(N,b)<=R_N+CN, uniformly for both b and every N, would give Q_(2N+b)<=2Q_N+CN. Iterating along the full binary ancestry of any integer horizon yields Q_n=O(n log(2n)), hence the RH-sufficient energy bounds for every positive epsilon. This budget remains unproved. Merely renaming Q_(2N+b)-2Q_N as net work supplies no new arithmetic estimate; (10) isolates the actual carry correlations which an estimate must use.

The strongest simple rule W_(N,b)<=R_N, or Q_(2N+b)<=2Q_N, is already false for actual arithmetic. For N=2 and b=0, keeping all ordered histories and the complete density gives

\[
 Q_2=8\log2-5\log3,\qquad
 Q_4=31\log2-7\log3-7\log5-\log7,
\]
\[
 \boxed{Q_4-2Q_2=\log\frac{2^{15}3^3}{5^7 7}>0},
 \qquad 884736>546875.
\tag{12}
\]

Thus positive work also occurs across a dyadic horizon. This refutes the zero-budget rule only; it leaves the linear budget and integrated diagonal hypothesis open. RH Proof derived the binary carry and density identities during the signed-energy attempt and independently recomputed (12) from the exact factorial kernel using integer prime exponents. The calculation produced no upper estimate for the full carry correlations. These are reviewed written results with no priority claim; Lean formalization remains unfinished.


### Formal binary carry and complete response

[FactorialBinaryCarry](BuildingBlocks/FactorialBinaryCarry.lean) proves seven unconditional theorems. They establish the binary quotient bounds for every positive divisor and both b=0,1, the carry bound epsilon<=1, the exact quotient decomposition, extension of the actual finite response without changing its value, and the literal identity g_(2N+b)(t)=g_N(2t)+d_(N,b)(t) for every real t. The two final theorems extend the integer floor mass through the new cutoff and prove sum_(n<=2N+b)mu(n)epsilon=-1 for N>0. They use the existing actual Möbius floor-mass theorem; no coefficient vector or response is substituted.

All seven theorems compile without warnings and depend only on propext, Classical.choice and Quot.sound. RH Proof supplied this formalization using standard finite arithmetic and exponential algebra, with no priority claim. The full infinite density scaling integral, signed energy identity (11), exact logarithmic counterexample (12), and required correlation bound remain further Lean obligations. The pointwise density scale and finite-interval work identity are now formalized below. The module proves no upper energy estimate.


### Formal density scale and finite-interval signed energy

[FactorialBinaryEnergy](BuildingBlocks/FactorialBinaryEnergy.lean) adds twelve unconditional theorems for the same literal finite Möbius response. It proves w(u/2)/2=2w(u)-1/[u(exp(u/2)+1)] for every u>0, positivity of both weights, continuity, and nonnegativity of the actual energy and density rows. It proves the complete binary square identity with the mixed innovation and its square retained. Integrability of all three rows on every interval 0<a<=c is proved from their actual continuity; no integrability premise is assumed. Consequently the module proves

\[
 \int_a^c\frac{g_{2N+b}(u/2)^2w(u/2)}2\,du
 =2\int_a^c g_N(u)^2w(u)\,du
 -\int_a^c\frac{g_N(u)^2}{u(e^{u/2}+1)}\,du
 +\int_a^c\frac{[2g_N(u)d_{N,b}(u/2)+d_{N,b}(u/2)^2]w(u/2)}2\,du.
\]

All twelve theorems compile without warnings and depend only on propext, Classical.choice and Quot.sound. RH Proof supplied this formalization using standard real exponential algebra and integration. This finite-interval theorem is part of the full identity's proof; it does not substitute a compact interval for the infinite energy requirement. Positive-endpoint exhaustion, infinite integrability and the full signed-work estimate remain unformalized and unproved where indicated above. The actual factorial-kernel identification is also still a written proof. No new unconditional RH estimate follows from these calculus identities.
