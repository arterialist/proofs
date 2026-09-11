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
