# Exact quotient renewal for the factorial Möbius response

RH Proof supplied this finite arithmetic calculation while auditing the factorial cross-size energy candidate. It retains every integer quotient and all Möbius coefficients. The identities are written mathematics, not Lean theorems or an RH proof. The divisor identities and finite geometric summation are classical; no priority claim is made.

For an integer N>=1 put q_n=floor(N/n), M(x)=sum_(n<=x)mu(n), and

\[
 g_N(t)=\sum_{n=1}^N\mu(n)(1-e^{-q_nt}).
\]

The associated compensated factorial kernel is

\[
 B(x,y)=(x+y)\log(x+y)-x\log x-y\log y
       -\log\binom{x+y}{x},
\]

on positive integer sizes, and the proposed energy is Q_N=sum_(n,m<=N)mu(n)mu(m)B(q_n,q_m). Its positive-kernel representation does not supply an upper bound on Q_N.

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
