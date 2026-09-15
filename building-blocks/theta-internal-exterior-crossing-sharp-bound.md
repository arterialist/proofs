# The internal exterior crossing retains both theta endpoint exponents

For 0≤R<T let
$$
 A_{R,T}=\{v:R<|v|\le T\},\qquad O_T=\{u:|u|>T\}.
$$
Let B_(T;R) be the actual incoming operator from L²(A_(R,T),ν) to L²(O_T,ν). It includes the full continuous kernel and every prime-power shift. In particular neither endpoint is allowed to return to the original core C_R. This extra restriction supplies a theta factor at R which the full-core crossing bound loses.

We prove the uniform estimate
$$
 \boxed{\quad
 \|B_{(T;R)}\|
 \le448\pi²e^{2R+3T}
 \exp\left[-\frac\pi2\left(e^{2R}+e^{2T}\right)\right].
 \quad}
 \tag{1}
$$
It holds for every 0≤R<T, hence in particular uniformly for 0<T−R≤1. The coefficient π/2 in the exponential has not been reduced.

## The complete theta envelope with its leading constant

Use ν=bΦdu, b(u)=2cosh(u/2), and ω=√(Φ/b). For s≥0 the positive theta series gives
$$
 \Phi(s)\le4\pi²e^{9s/2}e^{-\pi e^{2s}}
 \sum_{j\ge1}j^4e^{-\pi(j²-1)e^{2s}}
 \le8\pi²e^{9s/2}e^{-\pi e^{2s}}.
 \tag{2}
$$
The last series is less than 2. For example it is dominated by Σ_(j≥1)j⁶e^(−3(j²−1))<2, the elementary geometric-tail bound already used in the complete radius-two estimates. This retains the exact first exponential e^(−πe^(2s)); only the higher-theta summands enter the fixed prefactor.

Since b(s)≥e^(s/2), define
$$
 \Omega(s)=\sqrt8\,\pi e^{2s}
                         e^{-(\pi/2)e^{2s}}.
$$
Then ω(u)≤Ω(|u|). Also Ω decreases on [0,∞), because its logarithmic derivative is 2−πe^(2s)<0.

## Continuous crossing

Conjugate both spaces to ordinary Lebesgue L² using multiplication by √(bΦ). The continuous crossing kernel is
$$
 \omega(u)\omega(v)r(|u-v|),\qquad
 r(t)=e^{-t/2}/(1-e^{-2t})\le1/t.
$$
The endpoint restrictions give ω(u)ω(v)≤Ω(T)Ω(R). At u>T, v≤T, the remaining kernel is bounded by the Carleman kernel 1/[(u−T)+(T−v)], whose norm is π; restriction to A_(R,T) can only decrease this norm. The other target half-line is treated identically. Thus
$$
 \|B_{(T;R),c}\|\le2\pi\Omega(R)\Omega(T).
 \tag{3}
$$
This bound includes the singular crossing at ±T and the continuous arrivals from the opposite source component.

## Every prime-power shift

A branch of the normalized prime arrival has u=v±log n and coefficient
$$
 \frac{\Lambda(n)}{\sqrt n}\omega(u)\omega(v).
 \tag{4}
$$
Its partial translation has operator norm at most the supremum of (4) on u∈O_T,v∈A_(R,T). We sum these norms over both signs and every integer n≥2; Λ(n)=0 removes precisely the non-prime powers.

Set N=e^(2T), allowing N to be nonintegral. For n≤N the endpoint restrictions alone give the product bound Ω(R)Ω(T). The elementary actual Chebyshev estimate Ψ(X)≤4X and partial summation yield
$$
 \sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}\le8\sqrt N.
$$
Hence the contribution of both orientations with n≤N is at most
$$
 16e^T\Omega(R)\Omega(T).
 \tag{5}
$$
The endpoint n=N is included here when N is an integer.

If n>N, the source bound |v|≤T forces
$$
 |u|\ge\log n-T>T.
$$
Consequently the ratio of the target envelope to its value at T satisfies
$$
 \frac{\Omega(|u|)}{\Omega(T)}
 \le\left(\frac nN\right)^2
       \exp\left[-\frac\pi{2N}(n²-N²)\right]
 \le\left(\frac nN\right)^2e^{-\pi(n-N)}.
 \tag{6}
$$
The second inequality uses n+N≥2N. It does not weaken either endpoint exponent in (1).

Here is a direct bound uniform in the noninteger cutoff. Write the integers n>N as n=N+θ+j, j≥0, with 0<θ≤1. Since N≥1,
$$
 n/N\le j+2,\quad n^{-1/2}\le N^{-1/2},\quad
 \log n\le\log N+j+1.
$$
Also e^(−πj)≤8^(−j). Using Λ(n)≤log n, and (j+2)³≤8·4^j, gives
$$
 \begin{split}
 \sum_{n>N}\frac{\Lambda(n)}{\sqrt n}
       (n/N)^2e^{-\pi(n-N)}
 &\le\frac{1+\log N}{\sqrt N}
        \sum_{j\ge0}(j+2)^3\,8^{-j}\\
 &\le16\frac{1+\log N}{\sqrt N}.
 \end{split}
 \tag{7}
$$
Thus both orientations of the entire remaining prime-power tail contribute at most
$$
 32(1+2T)e^{-T}\Omega(R)\Omega(T)
 \le32e^T\Omega(R)\Omega(T),
 \tag{8}
$$
since 1+2T≤e^(2T). This proves absolute operator-norm convergence without truncating proper powers.

Combining (3), (5), and (8), and using 2π<8≤8e^T, gives
$$
 \|B_{(T;R)}\|\le56e^T\Omega(R)\Omega(T).
$$
Substituting the definition of Ω proves (1).

## Direct normalized ground-tail consequence

For the actual normalized ground of D=L_(O_R), write δ=λ−α>0 and split ψ into its restrictions to A_(R,T) and O_T. If the proved exterior lower estimate is L_(O_T)≥λ−δ_T and δ_T<δ, the exact hard-split ground equation gives
$$
 (\delta-\delta_T)\|\psi1_{O_T}\|_\nu
 \le\|B_{(T;R)}\|\,\|\psi1_{A_{R,T}}\|_\nu
 \le\|B_{(T;R)}\|.
 \tag{9}
$$
In particular the norm is bounded by the minimum of 1 and the right side of (1) divided by δ−δ_T. The two-endpoint exponential in this ratio is retained. Establishing a useful quantitative concentration scale still requires comparing the actual gap lower bound to δ_T and to (1); that comparison is not replaced by a fixed weakening of π/2.

## The matching exterior lower error retains the exact exponent

The same argument gives an equally sharp bound for the prime operator with both endpoints restricted to O_T:
$$
 \boxed{\quad
 \|1_{O_T}K_p1_{O_T}\|\le48e^T\Omega(T)^2.
 \quad}
 \tag{10}
$$
For n≤N=e^(2T), both endpoint factors are at most Ω(T), giving 16e^TΩ(T)² as before. For n>N, set l=log n, r=|u|, s=|v|. The displacement constraint gives r+s≥l. Since logΩ is concave and decreasing,
$$
 \Omega(r)\Omega(s)
 \le\Omega((r+s)/2)^2
 \le\Omega(l/2)^2
 =\Omega(T)^2(n/N)^2e^{-\pi(n-N)}.
$$
This includes both signs: for opposite half-lines r+s=l, and for a same-half shift the sum is larger. Since l/2>T in this range, the balanced envelope is admissible. Equation (7) now gives the remaining 32e^TΩ(T)². All prime powers remain.

In the exact normalized theta expression L=λ+ωAω−K_p, the physical archimedean multiplier is bounded below by a₀. Therefore
$$
 L_{O_T}\ge\lambda-\delta_T^{\rm sharp},\qquad
 \delta_T^{\rm sharp}:=(48e^T+|a_0|)\Omega(T)^2.
$$
Using the established |a₀|<10 and T≥0 proves
$$
 \boxed{\quad
 \delta_T^{\rm sharp}
 \le464\pi²e^{5T}e^{-\pi e^{2T}}.
 \quad}
 \tag{11}
$$
This is the actual exterior form bound, with both the full prime restriction and the archimedean lower endpoint included.

## Quantitative consequence for a supplied shrinking negative trial

The following implication consumes a lower bound from a retained actual physical trial; it does not construct or assume that bound without a trial. Suppose constants d₀>0 and C_*>0 and a positive width w=w_R give
$$
 \delta_R:=\lambda-\alpha_R
 \ge d_0e^R w\,\omega(R+h)^2,
 \qquad h=C_*w>0.
 \tag{12}
$$
Here δ_R denotes the actual ground deficit in this subsection, not an upper-error enclosure. The positive first theta summand and b(s)≤2e^(s/2) give, for s≥0,
$$
 \omega(s)^2\ge\pi²e^{4s}e^{-\pi e^{2s}}.
 \tag{13}
$$
Set T=R+3h. Dividing (11) by the lower bound (12)–(13) gives
$$
 \frac{\delta_T^{\rm sharp}}{\delta_R}
 \le\frac{464}{d_0w}
 \exp\{11h-\pi e^{2R}(e^{6h}-e^{2h})\}
 \le\frac{464}{d_0w}e^{11h-4\pi h e^{2R}}.
 \tag{14}
$$
Similarly (1) gives
$$
 \frac{\|B_{(T;R)}\|}{\delta_R}
 \le\frac{448}{d_0w}
 \exp\{5h-\tfrac\pi2e^{2R}(1+e^{6h}-2e^{2h})\}
 \le\frac{448}{d_0w}e^{5h-\pi h e^{2R}}.
 \tag{15}
$$
The elementary inequalities used here hold for every h≥0:
$e^{6h}-e^{2h}\ge4h$ and $1+e^{6h}-2e^{2h}\ge2h$.

In particular, if w_R=e^(−c√R) for a fixed c>0, the right side of (14) tends to zero. For all sufficiently large R it is at most 1/2, and the exact internal hard-split inequality (9) implies
$$
 \boxed{\quad
 \|\psi_R1_{O_{R+3C_*w_R}}\|_\nu
 \le\frac{896}{d_0w_R}
       \exp\{5C_*w_R-\pi C_*e^{2R}w_R\}.
 \quad}
 \tag{16}
$$
Thus it is at most exp(−c₁e^(2R)w_R) for some c₁>0 and sufficiently large R, with thresholds depending only on the supplied trial constants. Equations (14)–(16) retain the explicit inverse-width prefactors. They show precisely why the two-endpoint exponent is sufficient for this family, whereas replacing the original-core endpoint by a global supremum loses the required comparison.

The actual supplied trial is now proved in [theta shrinking even negative trial](theta-shrinking-even-negative-trial.md): it has w_R=e^(−√R/8), h=2w_R, and d₀=5/24, under the explicit eventually valid inequalities there, using the complete unconditional prime error bound. Substituting those constants in (14) and (16) gives, for all sufficiently large R,
$$
 \delta_{R+6w_R}^{\rm sharp}\le\delta_R/2,
\qquad
 \boxed{\quad
 \|\psi_R1_{O_{R+6w_R}}\|_\nu
 \le\frac{21504}{5w_R}
      \exp\{10w_R-2\pi e^{2R}w_R\}
 \le e^{-\pi e^{2R}w_R}.
 \quad}
 \tag{17}
$$
Thus the displayed concentration bound is an actual eventual theorem for this family after importing that proved trial. Its threshold is the maximum of the trial's stated threshold and the elementary exponential comparisons in (14)–(17). No RH hypothesis or ground-state supremum is used.

## Attribution and formal scope

This is written mathematics, with no Lean formalization of the displayed domain, transport or sampling estimates. The continuous crossing estimate uses the classical Carleman operator norm; theta-envelope bounds and the complete prime sum retain both restricted endpoints. No RH conclusion or passing full affine comparison is asserted.
