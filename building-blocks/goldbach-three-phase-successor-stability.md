# The three-phase Goldbach harmonic under literal succession

The literal successor spreads each arithmetic birth through a positive
probability law. Its complete additive pair count can change by order
\(N\), but the first three-adic harmonic changes by at most
\(O(\log N\log\log N)\). An elementary argument gives an explicit
\(O(\log^2N)\) bound first. These are unconditional stability bounds for the
**actual** von Mangoldt source, with all prime powers, ordered pairs,
the odd-lattice reference, and the initial endpoint retained. It does
not bound the harmonic itself at the RH scale.

## The transported birth, including label one

Let \(w(n)=\Lambda(n)\), \(r(n)=2\mathbf1_{n\text{ odd}}\), and
\(\chi_\theta(n)=e^{iv_3(n)\theta}\). A label \(n\ge1\) is sent by the
raw successor to a physical coordinate \(x\ge1\). Put \(U_n=x+1\)
and \(B_n=\max(2,n)\). The completed birth law is

\[
\Pr(U_n\le u)=
\begin{cases}
0,&u<B_n,\\
1-u^{-1},&u\ge B_n.
\end{cases}                                                   \tag{1}
\]

Thus \(U_n\) has an atom \(1-B_n^{-1}\) at \(B_n\) and density
\(u^{-2}du\) above it. In particular the reference label \(n=1\)
is **clamped at \(x=1\)**, so \(B_1=2\), rather than being allowed at
\(x=0\). Formula (1) follows by differentiating the literal
successor's completed counting function
\(x\psi(x+1)/(x+1)\), with its prescribed zero lower branch,
term by term; the same transport applies to \(r\). It also has the
coupling \(U_n=\max(B_n,V)\), where
\(\Pr(V\le u)=1-u^{-1}\) for \(u\ge1\). Consequently the law is
monotone in its birth label.

For an even \(N\ge6\), write
\(p_{a,b}(N)=\Pr(U_a+U_b\le N)\) for independent births and
\(\epsilon_{a,b}(N)=1-p_{a,b}(N)\). The original parity of the
**labels** is retained after transport; the continuous physical
coordinates have no integer parity. With \(B_a+B_b\le N\), the
exact escape formula from
[the literal successor calculation](goldbach-literal-successor-counting-transport.md)
is

\[
\epsilon_{a,b}(N)=
\frac{N-1}{N}\left(\frac1{N-B_a}+\frac1{N-B_b}\right)
+\frac1{N^2}\log\frac{(N-B_a)(N-B_b)}{B_aB_b}.
                                                               \tag{2}
\]

If \(B_a+B_b>N\), then \(p_{a,b}(N)=0\). The latter case matters for
some pairs involving label one. No pair with \(a+b>N\) enters the
transported cutoff, because \(B_a+B_b\ge a+b\).

## Exact first-harmonic row

Set \(F_n(\theta)=w(n)\chi_\theta(n)-r(n)\). The transported even
triangle and its first harmonic are

\[
\mathcal C_N^S(\theta)=
\sum_{\substack{a,b\ge1,\ a+b\le N\\a+b\text{ even}}}
F_a(\theta)\overline{F_b(\theta)}p_{a,b}(N),\qquad
\mathfrak H_N^S=\frac1\pi\int_0^{2\pi}
\mathcal C_N^S(\theta)\cos\theta\,d\theta.              \tag{3}
\]

The sum is real: swapping \(a,b\) conjugates a summand and leaves
both the domain and \(p_{a,b}\) unchanged. Fourier orthogonality and
the complete von Mangoldt support give the exact finite identity

\[
\boxed{\begin{aligned}
\mathfrak H_N^S=2\log3\bigg[&
\sum_{\substack{1\le b\le N-3\\b\text{ odd},\ v_3(b)=0}}
\Lambda(b)p_{3,b}(N)
-2\sum_{\substack{1\le b\le N-3\\b\text{ odd}}}p_{3,b}(N)\\
&+(\log3)\sum_{\substack{k\ge1\\4\cdot3^k\le N}}
p_{3^{k+1},3^k}(N)\bigg].
\end{aligned}}                                                \tag{4}
\]

Indeed, in a \(\Lambda\Lambda\) term with adjacent three-adic
labels, the label-one leg is \(3\) when the other label is zero;
otherwise both legs are adjacent powers of three. A mixed
\(\Lambda r\) term at frequency one has \(3\) on its Mangoldt leg
and every odd reference partner through \(N-3\), including partner
one. Ordered-pair symmetry supplies the factor two. Setting every
\(p_{a,b}=1\) gives the original harmonic \(\mathfrak H_N\) proved
in [the even three-phase note](goldbach-even-three-phase-prime-error.md).

There is also a positive prefix-average form of the first two sums.
List the odd labels as \(b_j=2j+1\le N-3\), put
\(f_j=\mathbf1_{v_3(b_j)=0}\Lambda(b_j)-2\),
\(F_j=\sum_{i=0}^j f_i\), and \(p_j=p_{3,b_j}(N)\). The coupling in
(1) gives \(p_j\ge p_{j+1}\ge0\). With \(p_{J+1}=0\), finite
summation by parts says

\[
\sum_{j=0}^{J}f_jp_j
=\sum_{j=0}^{J}F_j(p_j-p_{j+1}),
\qquad \sum_{j=0}^{J}(p_j-p_{j+1})=p_0\le1.          \tag{5}
\]

Thus the transported main row is a positive subprobability average
of complete odd prime-error prefixes. The separate powers-of-three
ladder remains in (4); positivity of the averaging weights does not
sign those prefixes.

## A polylogarithmic stability bound

For any odd \(3\le b\le N-3\), the tail in (1) is
\(\Pr(U_n>u)=u^{-1}\) whenever \(u\ge B_n\). If
\(U_3+U_b>N\), at least one of

\[
U_3>\frac{N+3-b}{2},\qquad
U_b>\frac{N+b-3}{2}
\]

holds. A union bound gives

\[
\epsilon_{3,b}(N)
\le\frac2{N+3-b}+\frac2{N+b-3}.                \tag{6}
\]

For \(b=1\), keep the clamp and simply use
\(\epsilon_{3,1}\le1\). Dropping the odd restriction in the
remaining positive sum and using
\(H_N=\sum_{j=1}^N j^{-1}\le1+\log N\) gives

\[
\begin{aligned}
\sum_{\substack{1\le b\le N-3\\b\text{ odd}}}
\epsilon_{3,b}(N)
&\le1+2\sum_{b=3}^{N-3}\frac1{N+3-b}
       +2\sum_{b=3}^{N-3}\frac1{N+b-3}\\
&\le 5+2\log N.                                         \tag{7}
\end{aligned}
\]

The sum over all \(b\) in this estimate is deliberately larger than
the odd-lattice sum. Every complete prime-power weight obeys
\(0\le\Lambda(b)\le\log N\) for \(b\le N\). The number of ladder
exponents in (4) is at most \(\log N/\log3\), and every escape
probability is at most one. Subtracting (4) with \(p=1\) from (4)
therefore proves the explicit unconditional estimate

\[
\boxed{\left|\mathfrak H_N^S-\mathfrak H_N\right|
\le 2\log3\left[(\log N+2)(5+2\log N)+\log N\right]
\qquad(N\ge6\text{ even}).}                              \tag{8}
\]

This improvement over the \(O(N)\) leakage of the full ordered
Goldbach count comes from first-frequency support, not cancellation
of unknown prime errors.

The bound can be sharpened using the arbitrary-interval
[Brun--Titchmarsh theorem of Yamada, Theorem 2](https://arxiv.org/pdf/2312.16090).
Only the weighted \(\Lambda(b)\) part of (7) needs improvement. Its
second reciprocal from (6) is \(O(1)\) by the elementary Chebyshev
bound \(\psi(N)=O(N)\). For the first, put \(x=N+3\) and consider

\[
S(x)=\sum_{3\le b\le N-3}\frac{\Lambda(b)}{x-b}.
\]

The range \(x-b>x/4\) costs \(O(1)\), again by Chebyshev. In the
remaining range, group \(j=x-b\) into dyadic blocks
\(h\le j<2h\), where \(h=2^r\), \(h\le x/4\), and
\(b\in(x-2h,x-h]\subset[x/2,x]\). For ordinary primes, the cited
theorem with modulus one bounds their number in this interval by
\(2h/(\log h+0.8601)\). Their weighted block is therefore at most
\(2\log x/(\log h+0.8601)\). Summing the dyadic blocks gives
\(O(\log x\log\log x)\).

Keep proper powers separately. For a fixed exponent
\(2\le k\le\log_2x\), the number of integer \(k\)-th powers in
\((x-2h,x-h]\) is at most

\[
1+\frac{h}{k(x/2)^{1-1/k}}.
\]

Each prime power \(p^k\) has its actual weight
\(\Lambda(p^k)=\log p\le(\log x)/k\), so this block contributes at
most

\[
\frac{\log x}{kh}
+\frac{\log x}{k^2(x/2)^{1-1/k}}.
\]

The first term sums to \(O(\log x\log\log x)\) over geometric
\(h\) and all allowed \(k\); the second sums to
\(O(\log^2x/\sqrt x)\). Counting a prime power more than once can
only enlarge this upper bound. Thus \(S(x)=O(\log x\log\log x)\).
The unweighted reference row in (7) and the ladder in (4) each cost
\(O(\log N)\). Consequently

\[
\boxed{\mathfrak H_N^S-\mathfrak H_N
=O(\log N\log\log N)\quad(N\to\infty,\ N\text{ even}).} \tag{9}
\]

The reciprocal prime-sum estimate is an established sieve application:
[Cully-Hugill, §3](https://arxiv.org/pdf/2107.14468) uses
Brun--Titchmarsh for a comparable terminal sum in an explicit-formula
error. The point here is its application to the literal successor's
three-phase row, with the clamped reference endpoint and every proper
power included. No priority claim is made for the scalar sieve bound.

In particular the transported harmonic has
the same \(\Omega_\pm(\sqrt N\log\log\log N)\) excursions supplied
by classical Littlewood oscillation for \(\mathfrak H_N\), and the
all-\(\varepsilon\) \(O(N^{1/2+\varepsilon})\) criterion transfers
unchanged. Neither statement proves that critical bound. In view of
the exact reconstruction of \(\psi(N-3)-(N-3)\) from
\(\mathfrak H_N\), this transport estimate gives no stronger global
prime-error estimate or Weil-form sign than was already available.

The phase and untransported finite harmonic are compiled in
[GoldbachThreePhaseFourier.lean](BuildingBlocks/GoldbachThreePhaseFourier.lean).
The arbitrary-survival complex Fourier identity and the exact
finite prefix-average algebra in (5) are compiled in
[GoldbachThreePhaseTransportFinite.lean](BuildingBlocks/GoldbachThreePhaseTransportFinite.lean).
The literal birth and pair-escape formulas are written analysis in
[the successor note](goldbach-literal-successor-counting-transport.md).
The actual-kernel instantiation, equations (4), (8)--(9), and the
monotone coupling remain Lean obligations. This note uses only the
actual von Mangoldt source and does not assert a new RH estimate.
