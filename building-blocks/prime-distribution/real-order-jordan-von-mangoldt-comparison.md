# Uniform comparison of real-order Jordan and von Mangoldt coefficients

The real-order Jordan function, divided by its positive order, approximates the actual von Mangoldt function from above with an explicit error. This comparison passes to the complete prime-error integral on every real dyadic interval. An averaged estimate removes one logarithm from the comparison error when the order is small. These results bound the difference between the two centered sums; the centered prime-error sum still requires a cancellation estimate.

All logarithms are natural. Let \(\mu\) be the actual Möbius function and \(\Lambda(p^v)=\log p\) for every prime \(p\) and integer \(v\ge1\), with \(\Lambda(n)=0\) elsewhere. Dirichlet convolution is
\[
 (f*g)(n)=\sum_{d\mid n}f(d)g(n/d).
\]
For a real order \(a>0\), define
\[
 J_a(n)=(\mu*\operatorname{id}^a)(n)
       =\sum_{d\mid n}\mu(d)(n/d)^a
       =n^a\prod_{p\mid n}(1-p^{-a}).                  \tag{1}
\]
This is the established generalized Jordan function. [Apostol and Tóth, §2](https://arxiv.org/html/1304.2699v2) define the same family for real orders. The parameter \(a\) is the order of an arithmetic function, not physical time. The unit has \(J_a(1)=1\); it will be kept separate from the comparison with \(\Lambda(1)=0\).

## A pointwise comparison at every positive order

For every real \(a>0\) and every integer \(n\ge2\),
\[
 \boxed{\quad
 0\le\frac{J_a(n)}a-\Lambda(n)
   \le\frac a2 n^a(\log n)^2.
 \quad}                                                \tag{2}
\]
There is no restriction on \(a\log n\). In particular, the estimate includes every proper prime power.

To prove (2), first let \(n=p^v\), with \(v\ge1\), and put \(z=a\log p>0\). The exact prime-power value is
\[
 J_a(p^v)=e^{vz}-e^{(v-1)z}
         =\int_{(v-1)z}^{vz}e^u\,du\ge z.
\]
Moreover,
\[
\begin{aligned}
 J_a(p^v)-z
 &=\int_{(v-1)z}^{vz}(e^u-1)\,du\\
 &\le e^{vz}\int_{(v-1)z}^{vz}u\,du
   =e^{vz}(v-\tfrac12)z^2
   \le\tfrac12 e^{vz}v^2z^2.
\end{aligned}
\]
Here \(e^u-1\le ue^u\le ue^{vz}\), and the final inequality is
\((v-1)^2\ge0\). Divide by \(a\), use \(v\log p=\log n\), and recall \(\Lambda(p^v)=\log p\).

If \(n\) has distinct prime divisors \(p,q\), then \(\Lambda(n)=0\). Every factor in (1) is between zero and one, and \(1-e^{-u}\le u\) for \(u\ge0\), so
\[
 \frac{J_a(n)}a
 \le a n^a\log p\log q
 \le\frac a4n^a(\log p+\log q)^2
 \le\frac a4n^a(\log n)^2.
\]
The last step uses \(n\ge pq\). This covers the remaining integers and proves (2). The restriction \(n\ge2\) is necessary because \(J_a(1)/a=1/a\).

Finite differentiation of (1) also gives
\[
 J_0(n)=\mathbf1_{n=1},\qquad
 \left.\partial_aJ_a(n)\right|_{a=0}
   =\sum_{d\mid n}\mu(d)\log(n/d)=\Lambda(n).           \tag{3}
\]
The identity \(\mu*\log=\Lambda\) fixes the actual amplitude at every prime power. Pointwise convergence as \(a\downarrow0\) alone does not justify a limit over an unbounded arithmetic cutoff; (2) supplies an explicit finite-cutoff error.

## The complete terminal comparison at real cutoffs

For real \(t\ge1\), put \(\psi(t)=\sum_{n\le t}\Lambda(n)\). For every real \(X\ge1\), define
\[
 M(X)=\int_X^{2X}(\psi(t)-t)\,dt,
 \qquad
 W_X(n)=(2X-n)_+-(X-n)_+.
\]
The weight is \(X\) when \(n\le X\), is \(2X-n\) when \(X<n\le2X\), and is zero afterward. Thus \(0\le W_X(n)\le X\), including fractional cutoffs, and \(W_X(2X)=0\). Integrating the actual step function gives
\[
 M(X)=\sum_{2\le n\le\lfloor2X\rfloor}W_X(n)\Lambda(n)
        -\frac32X^2.                                   \tag{4}
\]
Use the same weights and the same continuous density term to define
\[
 T_a(X)=\frac1a\sum_{2\le n\le\lfloor2X\rfloor}W_X(n)J_a(n)
         -\frac32X^2.                                  \tag{5}
\]
The deformation excludes \(J_a(1)=1\). Including it would add \(X/a\); the actual coefficient \(\Lambda(1)=0\) in (4) is unchanged.

For every real \(a>0\) and \(X\ge1\),
\[
 \boxed{\quad
 0\le T_a(X)-M(X)
   \le aX^2(2X)^a\log^2(2X).
 \quad}                                                \tag{6}
\]
Indeed, (2) bounds each coefficient, while
\[
 \sum_{2\le n\le\lfloor2X\rfloor}W_X(n)
 \le X\lfloor2X\rfloor\le2X^2.
\]
The common term \(-3X^2/2\) cancels exactly. Every admitted prime power and every divisor in \(J_a\) remains. At an integer upper endpoint the last weight is zero, so no endpoint correction is omitted. At \(X=1\), both centered sums equal \(-3/2\) and their difference is zero.

For example, the pointwise estimate alone gives
\[
 0\le T_{a(X)}(X)-M(X)\le eX^{7/4},\qquad
 a(X)=\frac{X^{-1/4}}{\log^2(2X)},\quad X\ge2.           \tag{7}
\]
This specialization uses \(a(X)\log(2X)<1\). The averaged estimate below permits a larger order while retaining a prescribed polynomial comparison error.

## Averaging the generalized von Mangoldt coefficients

Let
\[
 \Lambda_k=\mu*\log^k,\qquad k\ge1,                    \tag{8}
\]
where the power is pointwise. These are the classical generalized von Mangoldt functions studied by [Robles and Roy](https://doi.org/10.1017/S1446788719000715). Their recurrence and positivity appear in [Banks and Sinha, Lemma 2.1](https://arxiv.org/pdf/2209.11768). [Balazard's exact summatory formula](https://scispace.com/pdf/sur-la-fonction-sommatoire-de-la-fonction-de-von-mangoldt-fqlq5uuvi9.pdf), Theorem and equation (10), gives complementary fixed-index information. The proof here needs a majorant uniform over all integer \(k\); no novelty claim is made for the family, recurrence or comparison estimates.

We use the unconditional bound \(\psi(u)\le2u\) for every real \(u\ge1\). It follows, with room in the constant, from [Rosser and Schoenfeld, Theorem 12, equation (3.35)](https://doi.org/10.1215/ijm/1255631807), which gives \(\psi(u)<1.03883u\) for \(u>0\).

For every integer \(k\ge1\) and every real \(t\ge1\),
\[
 \boxed{\quad
 A_k(t):=\sum_{n\le t}\Lambda_k(n)
   \le2\cdot7^{k-1}t\log^{k-1}(2t).
 \quad}                                                \tag{9}
\]
We give the recurrence and the endpoint calculation to make the constants explicit.

For arithmetic functions, multiplication by \(\log n\) obeys the finite convolution Leibniz rule. Apply it to \(\mu*\mathbf1=\delta_1\), where \(\mathbf1(n)=1\), to obtain
\((\mu\log)=-\mu*\Lambda\). Consequently,
\[
 \Lambda_{k+1}=\Lambda_k\log+\Lambda*\Lambda_k.          \tag{10}
\]
Since \(\Lambda_1=\Lambda\ge0\), (10) proves \(\Lambda_k(n)\ge0\) for all \(k\ge1\). Also \(\Lambda_k(1)=0\).

Put \(c=\log2\), \(L=\log(2t)\), and
\[
 B_k(t)=\sum_{d\le t}\frac{\Lambda(d)}d
                   \log^{k-1}(2t/d).
\]
For \(k=1\), partial summation gives
\[
 B_1(t)=\frac{\psi(t)}t+\int_1^t\frac{\psi(u)}{u^2}\,du
       \le2(1+\log t).
\]
For \(k\ge2\), write \(r(u)=\log(2t/u)\). The exact formula is
\[
 B_k(t)=\frac{\psi(t)}t c^{k-1}
  +\int_1^t\frac{\psi(u)}{u^2}
      \bigl[r(u)^{k-1}+(k-1)r(u)^{k-2}\bigr]\,du.
\]
The atom at \(d=t\), when \(t\) is an integer, is contained in the boundary term. The lower boundary has \(\psi(1)=0\). Substitute the Chebyshev bound and integrate in \(r\); for every \(k\ge1\),
\[
\begin{aligned}
 B_k(t)
 &\le2\left[\frac{L^k}{k}+L^{k-1}-\frac{c^k}{k}\right]\\
 &\le2\left[\frac{L^k}{k}+L^{k-1}\right]
 \le6L^k.                                              \tag{11}
\end{aligned}
\]
The last inequality uses \(L\ge c\ge1/2\). The separate \(k=1\) formula verifies the same bound without a negative power of \(r\). At \(t=1\), the exact sums are zero.

Now sum (10) through the real cutoff \(t\):
\[
 A_{k+1}(t)=\sum_{n\le t}\Lambda_k(n)\log n
          +\sum_{d\le t}\Lambda(d)A_k(t/d).
\]
The base case of (9) is \(A_1(t)=\psi(t)\le2t\). If (9) holds at order \(k\), its first contribution at order \(k+1\) is at most \(2\cdot7^{k-1}tL^k\). The second is at most
\[
 2\cdot7^{k-1}t B_k(t)
 \le12\cdot7^{k-1}tL^k.
\]
Their sum is \(2\cdot7^ktL^k\), proving (9). Every cofactor argument \(t/d\) is a real number at least one; the induction does not replace it with an integer center.

## A complementary terminal error with one logarithm

For each fixed \(n\ge2\), the finite divisor formula and the exponential series give
\[
 J_a(n)=\sum_{k\ge1}\frac{a^k}{k!}\Lambda_k(n).
\]
The zeroth coefficient vanishes at \(n\ge2\); at the excluded unit it is one. Finite divisor summation justifies the series identity, and all its displayed coefficients are nonnegative. Hence, with \(z=7a\log(2t)>0\), (9) gives
\[
\begin{aligned}
 \sum_{2\le n\le t}\left[\frac{J_a(n)}a-\Lambda(n)\right]
 &\le2t\sum_{k\ge2}\frac{z^{k-1}}{k!}\\
 &=2t\frac{e^z-1-z}{z}
 \le tz e^z\\
 &=7at\log(2t)(2t)^{7a}.                               \tag{12}
\end{aligned}
\]
The remainder bound follows from
\(e^z-1-z=\int_0^z(z-u)e^u\,du\le z^2e^z/2\). No small-order assumption is used in (12).

Because \(W_X(n)\le X\), apply (12) at \(t=2X\). Combining it with (6) proves, for every real \(a>0\) and \(X\ge1\),
\[
 \boxed{\quad
 0\le T_a(X)-M(X)
 \le\min\left\{
   aX^2(2X)^a\log^2(2X),\;
   14aX^2\log(4X)(4X)^{7a}
 \right\}.
 \quad}                                                \tag{13}
\]
On \(7a\log(4X)\le1\), the second expression is at most \(14eaX^2\log(4X)\). Its ratio to the first expression is at most
\(14e\log(4X)/\log^2(2X)\), which tends to zero as \(X\) grows. Thus the averaged estimate removes one logarithm in this range. It need not be smaller at a small cutoff; the minimum in (13) preserves both bounds over their full ranges.

For every real \(X\ge1\) and \(1\le\theta\le2\), choose
\[
 a_\theta(X)=\frac{X^{\theta-2}}{7\log(4X)}.
\]
Then \(7a_\theta(X)\log(4X)=X^{\theta-2}\le1\), so
\[
 \boxed{\quad
 0\le T_{a_\theta(X)}(X)-M(X)\le2eX^\theta.
 \quad}                                                \tag{14}
\]
The constant is independent of both \(X\) and \(\theta\) on the stated range. Equation (14) controls a difference; it supplies no estimate for the size of either centered sum.

## The remaining signed input

The ordinary factorization identity
\[
 \log n=\sum_{p^v\parallel n}v\log p
       =\sum_{d\mid n}\Lambda(d)
\]
fixes the prime-power amplitudes and the logarithmic budget in (2). The coefficient proof also holds for free unit-generator models with a multiplicative numerical norm and this additive logarithm. The averaged proof additionally needs a bound on the cumulative generator weights, here the actual Chebyshev estimate for \(\psi\). A generalized model satisfying the same cumulative estimate inherits that proof as well. The comparison does not exclude such models. Ordinary integer cutoff counts and the actual prime coefficients identify (4) with the actual prime-error integral.

The Möbius convolution retains the inverse zeta factor. For fixed \(a>0\), initially in \(\Re s>1+a\),
\[
 \sum_{n\ge2}J_a(n)n^{-s}
   =\frac{\zeta(s-a)}{\zeta(s)}-1.                     \tag{15}
\]
The subtraction of one is the exact unit term. If
\(P_a(x)=a^{-1}\sum_{n\ge2}(x-n)_+J_a(n)\), direct integration yields
\[
 \int_1^\infty P_a(x)x^{-s-2}\,dx
 =\frac{\zeta(s-a)/\zeta(s)-1}{a\,s(s+1)}.             \tag{16}
\]
At any existing critical-line zero \(\rho\), isolation of zeros gives \(\zeta(\rho-a)\ne0\) for every sufficiently small positive \(a\). Thus the pole contributed by \(1/\zeta(s)\) remains; no simplicity assumption is needed. The existence of these zeros is unconditional. [DLMF §25.10](https://dlmf.nist.gov/25.10). For fixed \(\Re s>1\), the ratio in (15), divided by \(a\), tends to \(-\zeta'(s)/\zeta(s)\). The order parameter therefore approaches the actual \(\Lambda\) source with its signed cancellation still present.

For the adaptive order in (14), an independent estimate
\[
 |T_{a_\theta(X)}(X)|\ll_\varepsilon X^{\theta+\varepsilon}
 \quad\text{for every }\varepsilon>0
 \text{ and all sufficiently large real }X             \tag{17}
\]
would give the same bound for \(|M(X)|\). Conversely, that bound for \(|M(X)|\) gives (17). The approximation error has not produced an independently weaker centered estimate. Positivity of \(J_a\) gives only \(T_a(X)\ge-3X^2/2\); it does not prove (17).

To state the existing consumer precisely, put
\[
 D(x)=\sum_{n\le x}(x-n)\Lambda(n)-\frac{x^2}{2},
 \qquad x\ge1.
\]
Then \(D(1)=-1/2\), \(D(x)+1/2=\int_1^x(\psi(t)-t)\,dt\), and \(M(X)=D(2X)-D(X)\). Suppose \(|M(X)|\le CX^\eta\) for every real \(X\ge1\), with \(\eta>0\). Choose \(m=\lfloor\log_2x\rfloor\), so \(y=x/2^m\in[1,2)\). Exact telescoping gives
\[
 D(x)=D(y)+\sum_{j=1}^m M(x/2^j),\qquad
 |D(x)|\le B+\frac{C}{2^\eta-1}x^\eta,
\]
where \(B=\sup_{1\le y\le2}|D(y)|<\infty\). If the terminal bound starts at a larger cutoff, retain a larger initial compact interval. Thus \(|D(x)|\ll x^\eta\), and both complete primitives on \([X,2X]\) have that size. Squaring them and integrating over an interval of length \(X\) gives
\[
 S_X:=\int_X^{2X}
  \left([D(t)-D(X)]^2+[D(2X)-D(t)]^2\right)dt
 \ll X^{2\eta+1}.                                     \tag{18}
\]
An estimate only at dyadic terminal centers does not establish this all-real telescoping step. With epsilon renaming, the hypothetical bounds at \(\theta=7/4\) would give \(S_X\ll_\varepsilon X^{9/2+\varepsilon}\). At \(\theta=3/2\), they would give \(S_X\ll_\varepsilon X^{4+\varepsilon}\), meeting the existing \(\mathrm{CoarsePrimitiveBound}\) premise at every dyadic \(X=2^k\), after absorbing the finite initial scales. The repository's kernel-checked `target_of_coarsePrimitiveBound` consumes that premise and implies Mathlib's Riemann hypothesis. The required centered bound (17) remains unproved.

## Formal verification and analytic scope

The Lean 4.24.0 [module](../../formalization/BuildingBlocks/JordanVonMangoldtComparison.lean) checks the literal \(\mu*\operatorname{id}^a\) coefficients, actual prime-power values, general-integer casework, finite weights, every real cutoff and the original continuum terminal integral. Its five comparison and identification declarations are audited with only `propext`, `Classical.choice` and `Quot.sound`, with no placeholders, custom axioms or hypothetical arithmetic comparison premises.

| Claim | Verification coverage |
| --- | --- |
| Pointwise comparison (2), including the actual Möbius coefficients and all prime powers | Kernel checked by `BuildingBlocks.JordanVonMangoldtComparison.actual_pointwise_comparison` |
| Nonnegative finite weighted comparison and terminal bound (6) | Kernel checked by `BuildingBlocks.JordanVonMangoldtComparison.actual_finite_weighted_comparison` and `BuildingBlocks.JordanVonMangoldtComparison.actual_terminal_comparison` |
| Identification of the complete finite terminal with the original real integral, and the continuum version of (6) | Kernel checked by `BuildingBlocks.JordanVonMangoldtComparison.lambdaTerminal_eq_coarsePrefix` and `BuildingBlocks.JordanVonMangoldtComparison.actual_continuum_terminal_comparison` |
| Order differentiation (3), generalized-coefficient averaged bound (9), resummation (12), the second branch of (13), and adaptive estimates (7), (14) | Written proofs; finite differentiation, Chebyshev input, partial summation, uniform induction, infinite Taylor summation and adaptive specialization are not newly formalized |
| Dirichlet and Mellin identities (15), (16), pole persistence and all-real terminal-to-energy transfer (18) | Written analysis; not newly formalized |
| `CoarsePrimitiveBound` implies full Mathlib RH | Existing kernel-checked conditional consumer; its growth premise is unproved |

The current elementary Lean Chebyshev lemma gives \(\psi(N)\le4\log2\,N\). The written averaged proof uses the stronger published \(\psi(t)\le2t\) input. The constants \(7\) and \(14\) in that proof have not been claimed from the weaker Lean lemma.

The bounds in this note approximate the actual complete terminal. They prove no stronger upper for \(|M|\), the whole coarse energy, \(N_{\rm full}\), or the signed critical sum \(W\), and establish no unconditional RH chain. The real-order family and generalized von Mangoldt methods are established; this note makes no priority claim.
