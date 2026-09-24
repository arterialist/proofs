# Actual BPY negative dependence and a three-coordinate stability failure

This note concerns the actual Biane–Pitman–Yor law, with its full infinite remainder. It proves pairwise negative dependence under the exact logarithmic tilt, then falsifies strong Rayleigh stability for three actual threshold indicators. It gives no conclusion against RH or against the real-zero property of the actual xi transform.

## The probability measure

Under the independent product measure $P$, let
\[
X_i=\frac{G_i}{\pi i^2},\quad G_i\sim\operatorname{Gamma}(2,1),\quad
T=\sum_{i\ge1}X_i,\quad \alpha=\tfrac14.
\]
Thus $X_i$ has gamma shape two and rate $\lambda_i=\pi i^2$, and
\[
E_PT=\frac\pi3,
\quad Z=E_PT^{1/4}=2\xi(1/2)>0,
\quad dQ=\frac{T^{1/4}}Z\,dP.
\tag{1}
\]
The actual tilted log variable $U=\log T$ under $Q$ has characteristic function
\[
E_Qe^{izU}=\frac{\xi(1/2+2iz)}{\xi(1/2)}.
\tag{2}
\]
The gamma coordinates under $Q$ are not independent.

## A genuine negative-dependence inequality

For distinct $i,j$ and bounded increasing real functions $f,g$,
\[
\operatorname{Cov}_Q(f(X_i),g(X_j))\le0.
\tag{3}
\]
To prove this, put $R=\sum_{k\ne i,j}X_k$ and $w(t)=E_P(R+t)^{1/4}$ for $t>0$. The two-coordinate marginal density under $Q$ is
\[
Z^{-1}f_i(x)f_j(y)w(x+y),\qquad x,y>0,
\]
where $f_i,f_j$ are the original gamma densities. Differentiating at positive $t$ is justified by domination on compact subsets of $(0,\infty)$, and gives
\[
w'(t)>0,\qquad w''(t)<0,\qquad
(\log w)''(t)=\frac{w''w-(w')^2}{w^2}<0.
\]
For $x_2>x_1$, the ratio of the conditional densities of $X_j$ given $X_i=x_2$ and $X_i=x_1$ is decreasing in $y$, because its logarithmic derivative is
\[
(\log w)'(x_2+y)-(\log w)'(x_1+y)<0.
\]
The two conditional densities have total mass one, so this decreasing likelihood ratio implies that the conditional expectation of increasing $g(X_j)$ decreases with $X_i$. Finally, the covariance of an increasing and a decreasing function of the same real variable is nonpositive. For example, this follows by introducing an independent copy and expanding the expected product of the two differences. This proves (3). Truncation extends it to increasing functions whenever the needed products are integrable.

In particular, all pairwise covariances of the threshold indicators below are nonpositive. No assertion of full negative association is required for the argument.

## Exact finite threshold probabilities

Fix the integer $A=10^6$ and define, under the actual measure $Q$,
\[
I_i=1_{\{X_i\ge A\}},\qquad i=1,2,3.
\]
There is no cutoff on the remaining gamma coordinates. Let
\[
p_i=P(X_i\ge A)=e^{-\lambda_iA}(1+\lambda_iA),\qquad
E_S=\{I_i=1\text{ exactly for }i\in S\},
\]
for $S\subseteq\{1,2,3\}$. These events have strictly positive product-measure probabilities
\[
P(E_S)=\prod_{i\in S}p_i\prod_{i\notin S}(1-p_i).
\]
The actual probabilities are exactly
\[
Q(E_S)=\frac{A^{1/4}}Z P(E_S)b_S,
\qquad b_S=E_P[(T/A)^{1/4}\mid E_S].
\tag{4}
\]
We bound the $b_S$ without evaluating tiny exponentials.

For a shape-two gamma variable of rate $\lambda$,
\[
E[X-A\mid X\ge A]
=\frac{\lambda A+2}{\lambda(\lambda A+1)}\le\frac2\lambda=EX.
\tag{5}
\]
This follows by integrating the survival function $e^{-\lambda x}(1+\lambda x)$ from $A$ to infinity and dividing by the survival probability at $A$. Also $E[X\mid X<A]\le EX$, by monotonicity of upper versus lower conditional means.

Conditional on $E_S$, the original independent coordinates remain independent. If $k=|S|$, then $T=kA+Y_S$ with $Y_S\ge0$ and
\[
E[Y_S\mid E_S]\le\sum_{i\ge1}EX_i=\pi/3.
\tag{6}
\]
For high coordinates subtract $A$ and use (5); for low coordinates use the truncated-mean inequality; leave every coordinate $i>3$ unchanged. Tonelli justifies summing the full nonnegative remainder.

For $k\ge1$, concavity and the tangent-line bound give the exact enclosures
\[
k^{1/4}\le b_S
\le k^{1/4}+\frac\pi{12A}k^{-3/4}
<k^{1/4}+\frac1A.
\tag{7}
\]
For the empty pattern, Jensen gives
\[
0<b_\varnothing\le\left(\frac\pi{3A}\right)^{1/4}<\frac1{25}.
\tag{8}
\]
The last strict inequality uses $\pi<4$ and $4/(3\cdot10^6)<(1/25)^4$. Equations (4), (7) and (8) are probability enclosures with explicit exact prefactors. All gamma tails, the tilt normalization, and the infinite remainder are retained.

## A negative cubic discriminant

Let $F_A(z_1,z_2,z_3)=E_Q\prod_i z_i^{I_i}$ be the actual probability generating polynomial. Apply only positive external-field rescaling and a positive scalar normalization:
\[
B_A(z)=\frac{Z}{A^{1/4}\prod_i(1-p_i)}
F_A\!\left(\frac{1-p_1}{p_1}z_1,
\frac{1-p_2}{p_2}z_2,\frac{1-p_3}{p_3}z_3\right)
=\sum_{S\subseteq[3]}b_Sz^S.
\tag{9}
\]
Thus $F_A$ is real stable if and only if $B_A$ is. This equivalence follows directly because multiplication by positive numbers preserves the open upper half-plane.

If $B_A$ were real stable, its nonzero diagonal specialization would be a real-rooted polynomial. Write this actual specialization as
\[
B_A(t,t,t)=at^3+bt^2+ct+d.
\]
The coefficient bounds (7)–(8), with rational fourth-power comparisons for $2^{1/4}$ and $3^{1/4}$, yield
\[
\frac{1316}{1000}<a<\frac{1317}{1000},\quad
\frac{3567}{1000}<b<\frac{3568}{1000},\quad
3\le c<\frac{3001}{1000},\quad
0<d<\frac1{25}.
\tag{10}
\]
The asymmetry of the three rates has not been ignored: $b$ is the sum of three individually bounded two-high coefficients, and $c$ is the sum of three individually bounded one-high coefficients.

The cubic discriminant is
\[
\Delta=b^2c^2-4ac^3-4b^3d-27a^2d^2+18abcd.
\]
Since every coefficient is positive, discarding the two negative terms involving $d$ and substituting (10) gives
\[
\begin{aligned}
\Delta&\le
\left(\frac{3568}{1000}\right)^2\left(\frac{3001}{1000}\right)^2
-4\left(\frac{1316}{1000}\right)3^3\\
&\quad+18\left(\frac{1317}{1000}\right)
\left(\frac{3568}{1000}\right)
\left(\frac{3001}{1000}\right)\frac1{25}\\
&=-\frac{8458321897}{488281250}
=-17.322643245056<0.
\end{aligned}
\tag{11}
\]
Thus the cubic has one real zero and a nonreal conjugate pair. One member of that pair lies in the upper half-plane, contradicting stability of $B_A$. Therefore the three actual threshold indicators at $A=10^6$ are **not strongly Rayleigh**.

## Meaning and limits

This tests a concrete proposal: promote the actual gamma-coordinate negative dependence to real stability of every finite threshold encoding, then try to use stable-polynomial machinery. That proposal already fails for three coordinates, even though all pairwise increasing-coordinate covariances have the correct negative sign.

Strong Rayleigh stability concerns a multiaffine generating polynomial. It would still require a proved preservation argument to reach the characteristic function of the nonlinear observable $\log\sum X_i$. We do not assume such an argument, and its failure is not needed for the counterexample. The nonreal zeros in (11) belong to the threshold probability generating polynomial after a positive field change. They are not zeros of actual xi.

Demanding directly that all actual xi Jensen polynomials be real-rooted would simply restate the missing global zero property. No such premise is introduced here. The bounded test stops at the finite stability failure.

The BPY law is given in Biane, Pitman and Yor, [author manuscript](https://statistics.berkeley.edu/sites/default/files/tech-reports/569.pdf), equations (5)–(8). The relevant framework is Borcea, Brändén and Liggett, [*Negative dependence and the geometry of polynomials*](https://arxiv.org/pdf/0707.2340), §2.2, Definitions 2.9–2.10, and Theorem 4.9. Their distinction between pairwise negative correlation and strong Rayleigh stability is essential here. The present calculation is a specialization to the actual tilted BPY gamma law; no priority claim is made.

The accompanying [rational certificate](../../certificates/bpy_tilted_threshold_discriminant.py) verifies every rational enclosure used after (7)–(8), using Python's exact `Fraction` arithmetic. It does not numerically approximate the exponentially small tail probabilities, replace the infinite remainder, or rely on floating-point signs.
