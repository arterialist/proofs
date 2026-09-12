# Reciprocal quotient windows and finite coefficient repairs

These Lean modules give an exact reciprocal Gram isometry, local window estimates and necessary conditions for convergence of a particular family of fractional-part sums. The arithmetic exclusion uses an explicit Mertens oscillation premise. It is not a new proof of that premise, a proof of RH, or a first-formalization claim.

Write $\rho(x)=x-\lfloor x\rfloor$, $M(N)=\sum_{n\le N}\mu(n)$ and

$$
c_N(q)=\sum_{\substack{1\le k\le N\\\lfloor N/k\rfloor=q}}\mu(k)
=M(\lfloor N/q\rfloor)-M(\lfloor N/(q+1)\rfloor).
$$

Finite grouping and Möbius inversion give $\sum_{q=1}^Nc_N(q)=M(N)$ and $\sum_{q=1}^Nq c_N(q)=1$ for $N\ge1$. The definitions are shared with [MertensArithmetic](BuildingBlocks/MertensArithmetic.lean); [QuotientMass](BuildingBlocks/QuotientMass.lean) proves the weighted identity used here.

## Mean correction and its second window

Define

$$
d_N(x)=\sum_{q=1}^N c_N(q)\rho\left(\frac q{Nx}\right)-\rho\left(\frac1{Nx}\right),
\qquad \beta(y)=\rho(2y)-2\rho(y),
$$

$$
\widetilde d_N(x)=d_N(x)+(M(N)+1)\beta\left(\frac1{Nx}\right).
$$

The reciprocal error $1+d_N(1/(Ny))$ is periodic with period one and mean $(M(N)+1)/2$. Since $\beta$ has period one and mean $-1/2$, the corrected reciprocal error has mean zero exactly. For $N\ge2$, $\widetilde d_N(x)=0$ when $x>1$. All squared-error integrals used below are finite. See [FractionalApproximation](BuildingBlocks/FractionalApproximation.lean) and [MeanCorrection](BuildingBlocks/MeanCorrection.lean).

Removing this mean does not prove $L^2$ convergence. To see the remaining information, use the kernels

$$
f_\theta(x)=\rho(\theta/x),\qquad
r_\theta(x)=\frac\theta x\rho(x/\theta),\qquad \theta>0.
$$

For every $\theta,\eta>0$,

$$
\int_0^\infty f_\theta(x)f_\eta(x)\,dx
=\int_0^\infty r_\theta(x)r_\eta(x)\,dx.               \tag{1}
$$

Both products are integrable: the kernels are bounded by $\min(1,\theta/x)$. The change of variable $x=\theta\eta/y$ proves (1). Finite bilinear expansion therefore gives an isometry on the spans of these kernels, including distances between sums with different parameters. This is a Gram identity, not a single parameter-independent pointwise substitution. The full statement is [ReciprocalIsometry](BuildingBlocks/ReciprocalIsometry.lean), `kernelSum_distance_eq`.

Write the corrected coefficients as

$$
\widetilde c_N(q)=c_N(q)-(2M(N)+3)\mathbf1_{q=1}
+(M(N)+1)\mathbf1_{q=2},
$$

so $\widetilde d_N=\sum_q\widetilde c_N(q)f_{q/N}$. Its isometric image $\widetilde r_N=\sum_q\widetilde c_N(q)r_{q/N}$ satisfies

$$
\widetilde r_N(x)=\begin{cases}
-2,&0<x<1/N,\\
-2+\dfrac{M(N)+M(\lfloor N/2\rfloor)+3}{Nx},&1/N<x<2/N.
\end{cases}                                         \tag{2}
$$

Thus, for integers $N\ge2K\ge4$, putting $b_N=M(N)+M(\lfloor N/2\rfloor)+3$,

$$
\|\widetilde d_N-\widetilde d_K\|_{L^2(0,\infty)}^2
\ge \frac{b_N^2}{2N}.                               \tag{3}
$$

On the interval $(1/N,2/N)$, the smaller image is still $-2$, so the integral is $b_N^2\int_{1/N}^{2/N}(Nx)^{-2}dx=b_N^2/(2N)$. Endpoint values are irrelevant to this integral. These are `correctedImage_second_window` and `corrected_second_window_distance_lower` in [SecondWindow](BuildingBlocks/SecondWindow.lean).

If $\int_0^1(1+\widetilde d_N)^2dx\to0$, the supported sequence is Cauchy in $L^2(0,\infty)$, and (3) gives $b_N=o(\sqrt N)$. The elementary halving recursion

$$
a_N+a_{\lfloor N/2\rfloor}=o(\sqrt N)
\quad\Longrightarrow\quad a_N=o(\sqrt N)             \tag{4}
$$

then gives $M(N)=o(\sqrt N)$. For a quantitative proof of (4), if the left side has absolute value at most $\delta\sqrt N$ beyond a fixed cutoff, strong induction and $\sqrt{\lfloor N/2\rfloor}\le3\sqrt N/4$ give $|a_N|\le4\delta\sqrt N+B$, where $B$ bounds the finite prefix. This is [HalvingRecovery](BuildingBlocks/HalvingRecovery.lean).

## Any fixed finite repair leaves an arithmetic coefficient

More generally, let $a_N(q)$ be arbitrary real coefficients and

$$
F_N(x)=\sum_{q=1}^N a_N(q)f_{q/N}(x),\qquad
W_{N,j}=\sum_{q=1}^j q\lfloor j/q\rfloor a_N(q).
$$

The local window calculation and the reciprocal variance estimate give, for $j\ge1$, $K\ge1$ and $N\ge(j+1)K$,

$$
\frac{W_{N,j}^2}{N}
\le24(j+1)^4\|F_N-F_K\|_{L^2(0,\infty)}^2.           \tag{5}
$$

Indeed the difference of the reciprocal images on $(j/N,(j+1)/N)$ has the form $B-W_{N,j}/(Nx)$. Rescaling to $(j,j+1)$ and applying $A^2\le24(j+1)^4\int_j^{j+1}(B-A/u)^2du$ proves (5). If $F_N$ is Cauchy, every fixed $W_{N,j}/\sqrt N$ tends to zero. The triangular relation defining $W_{N,j}$, with diagonal coefficient $j$, then proves $a_N(j)=o(\sqrt N)$ for every fixed $j\ge1$. This is `fixed_coefficient_tendsto_of_cauchy` in [FixedCoefficient](BuildingBlocks/FixedCoefficient.lean), using [WindowVariance](BuildingBlocks/WindowVariance.lean).

For any fixed $q\ge1$, $c_N(q)=o(\sqrt N)$ already implies $M(N)=o(\sqrt N)$. Substitute $N=qL$ in its exact Mertens formula and apply the contraction recursion to $T(L)=\lfloor qL/(q+1)\rfloor$. More generally, if $T(N)<N$ for $N>0$ and $\sqrt{T(N)}\le r\sqrt N$ with $r<1$, then

$$
a_N-a_{T(N)}=o(\sqrt N)\quad\Longrightarrow\quad a_N=o(\sqrt N).
$$

The finite-prefix proof has constant $1/(1-r)$. See [ContractionRecovery](BuildingBlocks/ContractionRecovery.lean), `mertens_ratio_tendsto_of_fixed_quotient`.

Consequently, under the explicit premise

$$
\neg\left(M(N)^2/N\longrightarrow0\right),            \tag{6}
$$

no sequence obtained by changing only a fixed finite initial set of the coefficients $c_N(q)$ can be Cauchy in this $L^2$ space. Changes may depend arbitrarily on $N$. The theorem `finite_quotient_repair_not_cauchy` requires eventual agreement for every $q>K$ with $q\le N$. The corresponding nonconvergence theorem also states the integrability of the squared distance to its proposed limit. Neither theorem postulates (6) as an axiom or proves it inside this package.

The relevant classical context is the Nyman–Beurling approximation problem and the failure of several natural approximation sequences, treated by [Báez-Duarte, *Arithmetical aspects of Beurling's real variable reformulation*](https://arxiv.org/abs/math/0011254) and [*A strengthening of the Nyman–Beurling criterion*](https://arxiv.org/abs/math/0202141). Mertens oscillation belongs to the classical analytic literature, including [Ingham, *On two conjectures in the theory of numbers*](https://personal.math.ubc.ca/~gerg/teaching/592-Fall2018/papers/1942.Ingham.pdf); the formal implications above deliberately retain the exact input (6). These results exclude the specified approximants and finite repairs, not other ways of using the Nyman–Beurling criterion.

All linked new modules compile with Lean 4.24.0 against the existing pinned dependencies. The mathematical tools are finite Möbius grouping, a reciprocal change of variables, interval integration, triangular recovery and geometric contraction. Their complete transitive axiom dependencies are the standard Lean axioms only.

## Direct first-window proof and exact tail enclosures

There is a separate direct proof for the original approximation $d_N$, before the mean correction or reciprocal Gram isometry. Let
$$
P_N(y)=1+\sum_{q=1}^N c_N(q)\rho(qy)-\rho(y),\qquad
T_N=\int_0^1(1+d_N(x))^2\,dx.
$$
For $N\ge1$, the two finite coefficient sums at the start of this note give
$$
1+d_N(1/(Ny))=P_N(y),\qquad
P_N(y)=1-\sum_{q=1}^N c_N(q)\lfloor qy\rfloor+\lfloor y\rfloor.
\tag{A1}
$$
The second identity follows because the linear terms cancel exactly. Thus $P_N$ is a one-periodic step function. It is bounded by $2+\sum_q|c_N(q)|$; this is used only for finite-cutoff integrability.

For a positive integer $q$, substitution followed by periodicity gives $\int_0^1\rho(qy)dy=1/2$. Hence
$$
\int_1^2P_N(y)dy=\frac{M(N)+1}{2}.
$$
Nonnegativity of the integral of the square after subtracting this mean, and the lower bound $y^{-2}\ge1/4$ on $[1,2]$, yield
$$
\int_1^2\frac{P_N(y)^2}{y^2}dy\ge\frac{(M(N)+1)^2}{16}.
$$
The smooth injective substitution $x=1/(Ny)$ on $[1,2]$ is valid for these bounded measurable functions, despite their finitely many jumps. Therefore
$$
\boxed{T_N\ge\int_{1/(2N)}^{1/N}(1+d_N(x))^2dx
=\frac1N\int_1^2\frac{P_N(y)^2}{y^2}dy
\ge\frac{(M(N)+1)^2}{16N}.}                         \tag{A2}
$$
The endpoints have measure zero and the smaller interval is contained in $[0,1]$. Since $M(N)^2\le2(M(N)+1)^2+2$,
$$
\frac{M(N)^2}{N}\le32T_N+\frac2N.                  \tag{A3}
$$
This again excludes convergence of the full sequence $T_N$ to zero under the explicit oscillation premise (6). It does not exclude every subsequence, and gives the zero lower bound at a cutoff where $M(N)=-1$.

These statements are already formalized in [FractionalApproximation.lean](BuildingBlocks/FractionalApproximation.lean): `dualWindowEnergy_eq_weighted`, `dualWindowEnergy_lower`, `mertens_sq_le_dual_error`, `mertens_sq_normalized_tendsto_of_dual_error`, and `dual_error_not_tendsto_of_mertens_oscillation`. The implication is unconditional except where the named nonconvergence theorem explicitly assumes the oscillation premise. The same dual approximation is defined in [Báez-Duarte, equation (1.19)](https://arxiv.org/html/math/0011254); Proposition 4.6 proves its full $L^2$ nonconvergence by the paper's unitary-operator method. The mean-window argument above is a different proof of the necessary arithmetic obstruction.

There is also an exact enclosure method for the full integral, rather than only its first reciprocal window. Write
$$
A_N=\int_0^1P_N(y)^2dy.
$$
For every integer $K\ge2$ and $j\ge K$, periodicity and positivity give
$$
\frac{A_N}{(j+1)^2}
\le\int_j^{j+1}\frac{P_N(y)^2}{y^2}dy
\le\frac{A_N}{j^2}.
$$
Summing the nonnegative integrals and comparing the two series with integrals of $t^{-2}$ proves
$$
\boxed{\frac{A_N}{N(K+1)}
\le\frac1N\int_K^\infty\frac{P_N(y)^2}{y^2}dy
\le\frac{A_N}{N(K-1)}.}                            \tag{A4}
$$
In particular the tail is integrable. Substitution on finite intervals and monotone convergence give
$$
T_N=\frac1N\int_{1/N}^{K}\frac{P_N(y)^2}{y^2}dy
+\frac1N\int_K^\infty\frac{P_N(y)^2}{y^2}dy.         \tag{A5}
$$
All jumps of $P_N$ occur at rational points $j/q$, $1\le q\le N$. Its constant value $v$ on a rational interval $[a,b)$ contributes the exact rational quantity $v^2(b-a)$ to its unweighted square integral. On the translated interval $[j+a,j+b)$, with positive endpoints, its weighted contribution is exactly
$$
v^2\left(\frac1{j+a}-\frac1{j+b}\right).
$$
Thus the finite part of (A5), together with (A4), gives rigorous rational enclosures without evaluating a discontinuous integrand numerically. For the fixed cutoff $N$ their width tends to zero as $K\to\infty$. The same method applies to the mean-corrected periodic error, retaining its extra rational half-period jump. Equations (A4)–(A5) are written integral arguments, not additional Lean theorems.

The smallest cutoffs check the normalization. At $N=1$, $d_1=0$, hence $T_1=1$. At $N=2$, $P_2$ is one on the first half of each period and zero on the second; the starting reciprocal half-period contributes zero. Therefore
$$
T_2=\frac12\sum_{j=1}^\infty\left(\frac1j-\frac1{j+1/2}\right)=1-\log2.
$$
Indeed its first $J$ terms equal $1+H_J-H_{2J+1}$ and converge to $1-\log2$. The corrected periodic error at $N=2$ is $+1$ on the first half and $-1$ on the second, so its squared error is exactly one. Zero reciprocal mean and small squared error are different requirements; the second-window proof above is what excludes the full corrected sequence.
