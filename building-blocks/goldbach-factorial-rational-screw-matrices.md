# Rational-scale screw matrices for the actual factorial ground

The Matsumoto–Suzuki screw criterion can be tested on a countable set of
matrices whose entries use the actual factorial ground. This is an exact
reformulation of RH, not an unconditional positivity theorem. Its zero-sum
input is [Matsumoto and Suzuki, Theorem 1.3 and Proposition 6.1](https://arxiv.org/html/2409.00888v2).

Use the right-continuous complete Chebyshev function
\(\psi(x)=\sum_{n\le x}\Lambda(n)\), including every prime power, and put
\[
 F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
 \qquad \kappa=1+\gamma_{\rm E}.
\]
The two atomic jumps in \(F\) cancel, so \(F\) is continuous, with
\(F(1)=0\). For \(x>1\), define the explicit archimedean term
\[
 A(x)=\log(2\pi)+\tfrac12\log(1-x^{-2})
       +\tfrac{x}{2}\log\frac{x+1}{x-1}-1,
 \qquad A(1):=\log(4\pi)-1.
\]
The value at one is the continuous right limit: the two logarithmic
singularities cancel. Define, for \(x\ge1\),
\[
 S_F(x)=\sqrt{x}\,\bigl(\kappa-F(x)\bigr)-x^{-1/2}A(x),
 \qquad S_F(1)=\gamma_{\rm E}+2-\log(4\pi).
 \tag{1}
\]
The unconditional finite explicit formula already recorded in
[the literal successor transport](goldbach-literal-successor-counting-transport.md)
gives \(S_F(x)=H_1(x)\) for \(x>1\), where
\(H_1(x)=\sum_\rho x^{\rho-1/2}/[\rho(1-\rho)]\). The zero series
converges absolutely and uniformly on compact logarithmic intervals.
The symmetry \(\rho\mapsto1-\rho\) gives
\(H_1(e^{-t})=H_1(e^t)\), so the values in (1) determine the whole even
logarithmic function.

For rational \(q,r\ge1\), let
\[
 \mathcal K_F(q,r)
 =S_F\!\left(\max\{q/r,r/q\}\right)-S_F(q)-S_F(r)+S_F(1).
 \tag{2}
\]
Then the following countable collection of purely arithmetic matrix
inequalities is **equivalent to RH**:
\[
 \sum_{i,j=1}^{k}z_i\overline{z_j}\,
      \mathcal K_F(q_i,q_j)\ge0
 \quad\text{for every }k\ge1,\ q_i\in\mathbb Q_{\ge1},\ z_i\in\mathbb C.
 \tag{3}
\]
Indeed, setting \(t_i=\log q_i\) turns (2) into the screw kernel
\(H_1(e^{t_i-t_j})-H_1(e^{t_i})-H_1(e^{-t_j})+H_1(1)\).
RH implies (3) by the cited Theorem 1.3. Conversely, the logarithms
of positive rationals at least one are dense in \([0,\infty)\), and the
kernel is continuous; hence (3) holds for every finite set of
nonnegative \(t_i\). To obtain an arbitrary real configuration, shift
all its points by their common minimum into \([0,\infty)\). For
coefficients whose sum is zero, the quadratic form of the even function
\(H_1(e^t)-H_1(1)\) depends only on pairwise differences and is
unchanged by this shift. Expanding the zero-sum coefficient at an
anchor point shows that positivity of the nonnegative-time matrices is
exactly positivity of the full screw kernel. Theorem 1.3 then gives RH.

## The one-point row is sufficient

In fact the one-point bound is itself equivalent to RH:
\[
 \boxed{\quad S_F(x)\le S_F(1)\quad\text{for every real }x\ge1
        \quad\Longleftrightarrow\quad\mathrm{RH}.\quad}             \tag{4}
\]
More weakly, it is enough that \(S_F(x)\) be bounded above for all
sufficiently large \(x\). RH gives (4) immediately: each zero has
\(\rho=1/2+i\gamma\), so its coefficient
\(1/[\rho(1-\rho)]=1/(1/4+\gamma^2)>0\), and the absolutely
convergent cosine sum cannot exceed its value at zero.

Here is a direct converse, with no assumed zero-free strip. Put
\(h(t)=H_1(e^t)=\sum_\rho a_\rho e^{\lambda_\rho t}\), where
\(a_\rho=1/[\rho(1-\rho)]\) and \(\lambda_\rho=\rho-1/2\).
Suppose \(h(t)\le C\) for \(t\ge T\ge0\), and set
\(f(t)=C-h(t)\ge0\). Absolute convergence gives
\(|h(t)|\le C_0e^{t/2}\); hence the tail Laplace transform
\(L_T(s)=\int_T^\infty f(t)e^{-st}dt\) converges for \(\Re s>1/2\).
There it has the exact expansion
\[
 L_T(s)=\frac{Ce^{-sT}}s
       -\sum_\rho\frac{a_\rho e^{-(s-\lambda_\rho)T}}
                            {s-\lambda_\rho}.                \tag{5}
\]
The series on the right converges normally on compact subsets of
\(\Re s>0\) away from its poles: the zero count is
\(O(U\log U)\), \(a_\rho=O(|\Im\rho|^{-2})\), and the extra
denominator is \(O(|\Im\rho|^{-1})\) at high ordinates. It is
meromorphic there, analytic at every positive real \(s\) because zeta
has no real zero in \((0,1)\), and has a
nonzero pole at \(s=\rho-1/2\) for each zero with
\(\Re\rho>1/2\). Multiplicity only multiplies the nonzero residue.

Let \(\sigma_c\le1/2\) be the real convergence abscissa of the
nonnegative transform \(L_T\). A pole of (5) with real part
\(b>0\) forces \(\sigma_c\ge b\): otherwise the original Laplace
integral would be holomorphic at that pole, contradicting analytic
continuation of (5) from \(\Re s>1/2\). Thus an off-line zero would
give \(\sigma_c>0\). But a nonnegative Laplace transform with finite
abscissa has a singularity at the **real** point \(s=\sigma_c\).
For completeness, if it extended analytically across that point,
choose a real \(s_0>\sigma_c\) close enough that its Taylor series
converges at some \(s_0-v<\sigma_c\). Its derivatives satisfy
\((-1)^nL_T^{(n)}(s_0)=\int_T^\infty t^nf(t)e^{-s_0t}dt\).
The nonnegative Taylor series at \(s_0-v\), by monotone convergence,
would make \(\int_T^\infty f(t)e^{-(s_0-v)t}dt\) finite, a
contradiction. Formula (5) is analytic at every positive real point,
including \(\sigma_c\). Therefore no zero has \(\Re\rho>1/2\),
and the functional equation gives RH.

Since \(A(x)=O(1)\) for \(x\ge2\), this gives a particularly simple
**one-sided actual-arithmetic criterion**: RH holds if and only if
there is a constant \(C\) such that
\[
 F(x)\ge\kappa-\frac C{\sqrt x}
 \quad\text{for every sufficiently large }x.              \tag{6}
\]
It even suffices to check this at **integer** \(x=N\). Between
consecutive integers, \(F'(x)=-[\psi(x)-x]/x^2\) almost everywhere;
Chebyshev's \(\psi(x)=O(x)\) gives
\(|F(x)-F(N)|=O(1/N)\) for \(N\le x\le N+1\).
Thus a bound \(F(N)\ge\kappa-C/\sqrt N\) for all sufficiently large
integers extends to (6), after enlarging \(C\). The converse is
immediate. This integer version uses exactly the complete finite
prime-power row formalized in the Lean file below; its uniform lower
bound remains unproved.
Under RH, (4) gives the sharper explicit barrier
\(F(x)\ge\kappa-S_F(1)/\sqrt x-A(x)/x\) for every \(x>1\).
No unconditional lower estimate of the strength (6) is proved here.

The two-point integer minor and its finite \(H_1\) arithmetic rows are
discussed in [the lowest-minors audit](goldbach-screw-lowest-minors-audit.md),
and [FactorialHOneFinite.lean](BuildingBlocks/FactorialHOneFinite.lean)
formalizes the integer finite-row identity. Neither the rational-grid
extension nor the analytic one-point converse is formalized in Lean.

The useful feature of (3) is its exact source dictionary: every matrix
entry is a value of the original complete-prime-power \(F\) plus the
explicit archimedean correction. Goldbach representation existence and
positivity of its uncentered coefficients do not establish (3).
