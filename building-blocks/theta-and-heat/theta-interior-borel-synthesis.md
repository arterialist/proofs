# Constructive synthesis for strict-interior exponential-type quotients

This is a written mathematical proof for the complete theta kernel and its actual weighted Hilbert space. It is not a Lean theorem or a positivity proof. The cited entire-function and functional-analysis tools are classical; no priority claim is made.

Use the actual full theta kernel and Hilbert space from [equality-space chapter](theta-equality-space.md):
$$
 d\nu(u)=M^{-1}\cosh(u/2)\Phi(u)du,\quad M=1/2,
 \quad (Uh)(z)=\int_{\mathbb R}\Phi(u)h(u)e^{izu}du.
$$
Let $H_e^0$ be the even mean-zero subspace of $L^2(\nu)$, and give $\mathcal H_e^0=UH_e^0$ its transported Hilbert norm. The actual equality space satisfies
$$
 US=\overline{G\mathbb C[z^2]}^{\mathcal H_e^0},\qquad
 G(z)=(z^2+1/4)\Xi(z).
 \tag{1}
$$
Put
$$
 K=\left\{w:\ |\Re w|<\pi/6,\quad
 |\Im w|<\tfrac12\log(2\cos(2\Re w))\right\}.
 \tag{2}
$$
This is the rotation by $i$ of the permitted complex theta-translation domain. It is open, bounded, convex, and contains zero. Convexity follows because $x\mapsto\tfrac12\log(2\cos2x)$ has second derivative $-2\sec^2(2x)<0$.

**Theorem.** Let $E$ be even entire of exponential type, with conjugate indicator diagram $C_E$ a compact subset of $K$. Then
$$
 GE\in\mathcal H_e^0\quad\text{and}\quad GE\in US.
 \tag{3}
$$
More concretely, the proof below constructs a sequence of even polynomials $P_n$ such that
$\|GP_n-GE\|_{\mathcal H_e^0}\to0$. Membership of $GE$ in the Hilbert space is a conclusion, not an additional assumption. No assertion for diagrams meeting $\partial K$ is made.

## 1. The actual translated generator, including the pole factor

Define the physical generator
$$
 \Psi(u)=-\Phi''(u)+\tfrac14\Phi(u).
$$
Its Fourier transform is exactly $G$. For $w\in K$, set
$$
 T(w)(u)=\frac{\Psi(u+iw)+\Psi(u-iw)}{2\Phi(u)}.
 \tag{4}
$$
Thus $w=ia$ corresponds to the permitted physical shifts $u\mp a$. The $\Phi''$ term in (4) is essential: shifting $\Phi$ alone would omit the factor $z^2+1/4$ and its mean-zero pole condition.

For a compact set $C\subset K$, let
$$
 \epsilon_C=\min_{w\in C}
 \{2e^{-2|\Im w|}\cos(2\Re w)-1\}>0.
$$
The complete theta bounds, with any fixed number of derivatives, give
$$
 \frac{\cosh(u/2)}{\Phi(u)}|\Psi(u\pm iw)|^2
 \le C_C\exp\{-\pi\epsilon_C e^{2|u|}+C_C|u|\}
 \quad(w\in C).
 \tag{5}
$$
Here the complex shift contributes the decay factor
$e^{-2|\Im w|}\cos(2\Re w)$, while the reciprocal real kernel contributes one copy of $\pi e^{2|u|}$ to the exponent. The same estimate with changed constants holds for each fixed $w$-derivative. This is precisely why a compact subset of the strict domain is used.

It follows that $T(w)\in L^2(\nu)$, locally uniformly in $w$, and that $w\mapsto T(w)$ is Hilbert-valued holomorphic on $K$. For example, the derivative bounds on a slightly larger compact neighborhood justify difference quotients in Hilbert norm by dominated convergence. Its exact norm is
$$
 \|T(w)\|_{L^2(\nu)}^2
 =\frac1M\int\frac{\cosh(u/2)}{\Phi(u)}
 \left|\frac{\Psi(u+iw)+\Psi(u-iw)}2\right|^2du.
 \tag{6}
$$
The inequality $|a+b|^2\le2(|a|^2+|b|^2)$, together with evenness and the substitution $u\mapsto-u$, bounds (6) by
$M^{-1}\int\cosh(u/2)|\Psi(u+iw)|^2/\Phi(u)du$. Formula (5) makes this bound uniform on $C$.

For small purely imaginary $w$, ordinary real translation gives
$$
 U[T(w)](z)=G(z)\cosh(wz).
 \tag{7}
$$
For each fixed $z$, both sides are holomorphic in $w\in K$; the Hilbert evaluation on the left is continuous. Analytic uniqueness therefore extends (7) to every $w\in K$. This argument avoids a formal complex contour shift outside the known weighted domain.

The vector $T(w)$ is even in $u$. Since $G(i/2)=G(-i/2)=0$, (7) also gives
$$
 \nu T(w)=\frac{U[T(w)](i/2)+U[T(w)](-i/2)}{2M}=0.
$$
Thus $T$ is holomorphic with values in the actual space $H_e^0$.

## 2. Constructive polynomial approximation of every permitted translation

At the origin, its Hilbert Taylor coefficients are explicit:
$$
 \frac{T^{(2n)}(0)}{(2n)!}
 =\frac{(-1)^n\Psi^{(2n)}}{(2n)!\Phi},\qquad
 T^{(2n+1)}(0)=0.
 \tag{8}
$$
Under $U$, the first coefficient is $Gz^{2n}/(2n)!$. Equivalently,
$\Psi^{(2n)}/\Phi=-e_{n+1}+e_n/4$, with $e_0=0$, so each coefficient is an actual finite equality combination.

The Taylor series at zero converges in Hilbert norm on its disk of analyticity. It must **not** be presumed to converge on all of the noncircular domain $K$. To reach an arbitrary $w\in K$, use the following finite Taylor-continuation construction.

The segment $[0,w]$ is compact in $K$. Choose $\rho>0$ such that all closed disks of radius $2\rho$ about this segment lie in $K$, and let $M_\rho$ bound $\|T\|$ on their union, using (5)–(6). Choose a subdivision $w_j=jw/m$ with $|\Delta|=|w|/m\le\rho/4$. For normalized derivatives
$b_{j,k}=T^{(k)}(w_j)/k!$, Cauchy's estimate and local Taylor expansion give
$$
 b_{j+1,k}=\sum_{n\ge0}\binom{k+n}{k}b_{j,k+n}\Delta^n,
 \qquad \|b_{j,k+n}\|\le M_\rho\rho^{-k-n}.
 \tag{9}
$$
The remainder after truncating at $n=N$ is bounded explicitly by
$$
 M_\rho\rho^{-k}\sum_{n>N}\binom{k+n}{k}
                    (|\Delta|/\rho)^n\longrightarrow0
 \quad(N\to\infty),
 \tag{10}
$$
for every fixed $k$.

To approximate $T(w)=b_{m,0}$ to a prescribed norm accuracy, truncate its last-step series so that (10) is within half the allowed error. Only finitely many derivatives at $w_{m-1}$ are then needed. Approximate each of those by its preceding-step series, assigning errors after multiplication by the finitely many coefficients in (9). Repeat backwards through the finite chain. At $w_0=0$, the required derivatives are exactly the finite polynomial vectors (8). This recursive, finite procedure yields a finite linear combination of those vectors with any prescribed error. The accumulated error is controlled by the finite coefficient sums and (10).

Consequently, for every $w\in K$ and $\varepsilon>0$, one can construct an even polynomial $P_{w,\varepsilon}$ such that
$$
 \|GP_{w,\varepsilon}-G\cosh(wz)\|_{\mathcal H_e^0}<\varepsilon.
 \tag{11}
$$
This is an explicit approximation within the true Hilbert topology. It does not assume a spectral-synthesis theorem or a form-core statement.

## 3. A Borel contour lying strictly inside the translation domain

The scalar theorem used here is the classical Borel–Pólya representation. With the normalization
$$
 \mathcal B_E(w)=\sum_{n\ge0}\frac{E^{(n)}(0)}{w^{n+1}}
$$
near infinity, the Borel transform continues holomorphically to the complement of the conjugate indicator diagram $C_E$, and for a positively oriented contour enclosing that diagram,
$$
 E(z)=\frac1{2\pi i}\oint_\Gamma\mathcal B_E(w)e^{wz}dw.
 \tag{12}
$$
This normalization and representation appear in [Buterin–Freiling–Yurko, *Lectures on the Theory of Entire Functions*, §6, Theorem 6.2](https://www.uni-due.de/imperia/md/content/mathematik/buterinfreilingyurko2014.pdf). The diagram convention is the Borel singularity convention: $e^{az}$ has diagram $\{a\}$. Equivalently its support function is $h_E(\theta)=\sup_{w\in C_E}\Re(we^{i\theta})$.

For clarity, the contour in this application can be specified concretely. If $E\equiv0$, the theorem is immediate. Otherwise choose
$$
 0<\delta<\operatorname{dist}(C_E,\mathbb C\setminus K),
 \qquad \Gamma=\partial(C_E+\delta\overline{\mathbb D}),
 \tag{13}
$$
with positive orientation. The parallel convex body has a rectifiable Jordan boundary, encloses $C_E$, and its whole closure lies in $K$. The Borel transform is holomorphic on a neighborhood of $\Gamma$, hence bounded there. One could equally replace it by a surrounding polygon still inside $K$.

Formula (12) follows first on a sufficiently large circle by integrating the convergent Laurent series termwise; each coefficient contributes $E^{(n)}(0)z^n/n!$. Holomorphic contour deformation outside $C_E$ then gives the chosen contour (13). Evenness of $E$ permits symmetrization without any additional contour assumption:
$$
 E(z)=\frac1{2\pi i}\oint_\Gamma
                   \mathcal B_E(w)\cosh(wz)dw.
 \tag{14}
$$

## 4. Bochner integration, the norm, and the actual polynomial sequence

Define the Hilbert-valued contour integral
$$
 h_E=\frac1{2\pi i}\oint_\Gamma\mathcal B_E(w)T(w)dw.
 \tag{15}
$$
The integrand is continuous on the rectifiable contour and has bounded norm by (5)–(6). Thus (15) is a convergent Bochner integral in $H_e^0$, with
$$
 \boxed{\ \|h_E\|_{L^2(\nu)}
 \le\frac1{2\pi}\oint_\Gamma
          |\mathcal B_E(w)|\,\|T(w)\|_{L^2(\nu)}\,|dw|.\ }
 \tag{16}
$$
In particular it is at most
$\operatorname{length}(\Gamma)\sup_\Gamma|\mathcal B_E|
 \sup_\Gamma\|T\|/(2\pi)$.

Every point evaluation on the transported Hilbert space is continuous. Applying it to (15), using (7) and (14), gives
$$
 (Uh_E)(z)=\frac1{2\pi i}\oint_\Gamma
                \mathcal B_E(w)G(z)\cosh(wz)dw=G(z)E(z)
 \tag{17}
$$
for every complex $z$. This proves $GE\in\mathcal H_e^0$ and supplies the norm bound (16) for that product.

There is also an explicit polynomial-approximation procedure. Approximate (15) by a finite contour Riemann sum
$\sum_{j=1}^N\alpha_jT(w_j)$ within $\varepsilon/2$ in Hilbert norm. The error is bounded by the contour length times the modulus of continuity of $\mathcal B_ET$ on its compact contour. For each node, use the finite Taylor-continuation construction (9)–(11) to replace $UT(w_j)$ by $GP_j$, choosing the errors so that their $|\alpha_j|$-weighted sum is below $\varepsilon/2$. Then the single even polynomial $P=\sum_j\alpha_jP_j$ satisfies
$$
 \|GP-GE\|_{\mathcal H_e^0}<\varepsilon.
 \tag{18}
$$
Taking $\varepsilon\downarrow0$ constructs the sequence asserted in (3). All norms are the original weighted theta Hilbert norms; local uniform convergence of entire functions alone was not substituted for them.

The proof relies on the positive margin in (5) and on a contour compactly contained in $K$. If $C_E$ meets $\partial K$, neither such a contour nor a uniform version of (16) is supplied here. In particular no passage from $E(rz)$ to $E(z)$ in Hilbert norm is inferred. That is a separate boundary question. The present strict-interior synthesis is compatible with the known infinite codimension of the equality space and makes no sharp-gap or RH claim.
