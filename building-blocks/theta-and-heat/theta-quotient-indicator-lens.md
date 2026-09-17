# Growth and the exact indicator lens for actual divisible Fourier transforms

This is a written mathematical proof for the complete theta kernel and its actual weighted Hilbert space. It is not a Lean theorem or a positivity proof. The cited entire-function and functional-analysis tools are classical; no priority claim is made.

Use the actual normalization and Hilbert space from
[equality-space chapter](theta-equality-space.md):
$$
d\nu(u)=M^{-1}\cosh(u/2)\Phi(u)du,\quad M=\tfrac12,
\quad (Uh)(z)=\int_{\mathbb R}\Phi(u)h(u)e^{izu}du,
$$
$$
\Xi(z)=\xi(\tfrac12+iz),\qquad G(z)=(z^2+\tfrac14)\Xi(z).
$$
Suppose $h\in L^2(\nu)$ is even and mean zero, $F=Uh$, and $F/G$ extends to an entire function. Write $E=F/G$. The zero function is harmless; the discussion below assumes $F\not\equiv0$.

**Theorem.** The entire even function $E$ has finite exponential type. Its conjugate indicator diagram is contained in the compact convex lens
$$
\boxed{K=\left\{u+iv:
|u|\le\frac\pi6,\quad
|v|\le\frac12\log(2\cos(2u))\right\}.}
\tag{1}
$$
No assertion concerning the location or multiplicity of xi zeros is needed beyond the assumed entire divisibility. In particular there is no RH or zero-free-line premise.

## 1. The actual Hilbert evaluation bound

The full theta series on the positive real axis, together with evenness, gives
$$
0<\Phi(u)\le C\exp\{\tfrac92|u|-\pi e^{2|u|}\}.
$$
This bound holds globally after increasing the constant. For example, for $u\ge0$ the full series is bounded by its first exponential times a uniformly bounded sum of polynomial weights in the theta index. Therefore
$$
\frac{\Phi(u)}{\cosh(u/2)}
\le C\exp\{4|u|-\pi e^{2|u|}\}.
\tag{2}
$$
For $z=x+iy$, $Y=|y|$, Cauchy–Schwarz in the actual Hilbert norm yields
$$
|F(z)|\le\sqrt M\,\|h\|_{L^2(\nu)}
\left[\int_{\mathbb R}
\frac{\Phi(u)}{\cosh(u/2)}e^{-2yu}du\right]^{1/2}.
\tag{3}
$$
The integral is at most
$$
C\int_0^\infty e^{(2Y+4)u-\pi e^{2u}}du
\le C\pi^{-Y-2}\Gamma(Y+2).
$$
Real Stirling consequently gives, as $Y\to\infty$,
$$
\log|F(x+iy)|
\le\frac Y2\log\frac Y\pi-\frac Y2
+O_h(\log(Y+2)).
\tag{4}
$$
It is uniform in $x$. The corresponding bound with $Y\le R$, including bounded $Y$, also proves
$\log M_F(R)=O_h(R\log(R+2))$, hence order at most one.

## 2. The denominator asymptotic away from the real axis

In the upper half-plane put $z=x+iy$, $y>0$, and use the functional equation in the form
$$
\Xi(z)=\xi(\tfrac12+y-ix).
$$
For $z=Re^{i\theta}$, with $\theta$ in any compact subinterval of $(0,\pi)$, the real part of this xi argument tends to positive infinity. Its zeta factor is $1+O(2^{-y})$, by the absolutely convergent Dirichlet series. In particular it is nonzero there for large $R$. Complex Stirling for the gamma factor is uniform on this closed angular range and gives
$$
\log|\Xi(x+iy)|
=\frac y2\log\frac R{2\pi}
-\frac x2\arctan\frac xy-\frac y2
+O(\log R).
\tag{5}
$$
The arctangent takes values in $(-\pi/2,\pi/2)$; thus
$\arctan(x/y)=\pi/2-\theta$ throughout the upper half-plane, including negative $x$. The polynomial factor in $G$ changes (5) only by $O(\log R)$.

Subtracting (5) from (4) proves the upper angular estimate
$$
\log|E(Re^{i\theta})|
\le R\,b(\theta)+O_h(\log R),
\tag{6}
$$
where
$$
b(\theta)=\frac12\sin\theta\log(2\sin\theta)
+\frac12\cos\theta(\pi/2-\theta),
\qquad0<\theta<\pi.
\tag{7}
$$
The same bound holds on the reflected lower-half-plane ray. This reflection does not require real-valued $h$: (3) is symmetric in $y$, and the denominator has the required real symmetry. The uniformity in (6) is on compact angular subintervals, not initially at the real axis.

## 3. Entire division and the two real-axis sectors

Both $F$ and $G$ have order at most one. Write their Hadamard factorizations using the common genus-one factors
$E_1(w)=(1-w)e^w$. Entire divisibility means that every zero of $G$ occurs in $F$ with at least its multiplicity. Cancel those factors. The result is an exponential of an affine polynomial, the possible power of $z$ at zero, and a genus-one product over a subset of the zeros of $F$. Its order is at most one.

For an explicit sufficient growth estimate, Jensen's formula applied to the bound for $F$ gives $N_F(R)=O_h(R\log(R+2))$. Estimating the remaining genus-one product by splitting its zeros at modulus $2R$ gives
$$
\log M_E(R)=O_h(R\log^2(R+2)).
\tag{8}
$$
The terms $R/|\rho|$ from the near zeros account for the possible extra logarithm. This estimate is sufficient for the Phragmén–Lindelöf step; finite exponential type has not been assumed in deriving it.

Fix, for example, $\alpha=\pi/4$. Equation (6) bounds $E$ on the rays $\arg z=\pm\alpha$ by $C\exp(c|z|)$. Choose $A>c/\cos\alpha$. Then $E(z)e^{-Az}$ is bounded on those two rays. Its order is at most one, strictly below the critical order $\pi/(2\alpha)=2$ for their intervening sector. The sector Phragmén–Lindelöf principle therefore bounds it throughout $|\arg z|\le\alpha$. In particular $|E(z)|\le C e^{A|z|}$ there.

Apply the same argument to $E(z)e^{Az}$ in the sector around the negative real axis. On the remaining two closed angular sectors, (6) is already a uniform exponential bound. Together these prove finite exponential type on the entire plane. This step used entire division, not a denominator lower bound on either real axis or on a line containing possible zeros.

## 4. Optimize all the indicator halfplanes

Use the convention that the conjugate indicator diagram $K_E$ of an entire function of exponential type has support function
$$
h_E(\theta)=\limsup_{R\to\infty}
R^{-1}\log|E(Re^{i\theta})|
=\sup_{w\in K_E}\Re(we^{i\theta}).
\tag{9}
$$
Equivalently one may use the conjugate convention for the diagram; the final lens is invariant under conjugation. Pólya's indicator theorem identifies this compact convex diagram; see [Buterin–Freiling–Yurko, §6, Theorem 6.4](https://www.uni-due.de/imperia/md/content/mathematik/buterinfreilingyurko2014.pdf) for the convention and proof. Equation (6) places it in all the halfplanes bounded by (7) and their lower reflections.

Their exact intersection can be calculated without an approximation at the real axis. Write $w=u+iv$ and $t=\pi/2-\theta$, so $-\pi/2<t<\pi/2$. The paired upper and lower inequalities are equivalent to
$$
|v|\le g_t(u):=
\frac12\log(2\cos t)+(\tfrac12t-u)\tan t
\quad\hbox{for every }t.
\tag{10}
$$
For fixed $u$,
$$
\frac{\partial g_t(u)}{\partial t}
=(\tfrac12t-u)\sec^2t.
$$
If $|u|<\pi/4$, the unique minimum occurs at $t=2u$, with value
$$
\inf_tg_t(u)=\frac12\log(2\cos(2u)).
\tag{11}
$$
If $|u|\ge\pi/4$, the infimum is negative infinity, including the endpoints, so such a point cannot satisfy (10). In (11) feasibility also requires the minimum to be nonnegative. That is precisely $|u|\le\pi/6$. Conversely every point satisfying (1) satisfies (10). This proves that the intersection is exactly $K$, hence $K_E\subset K$.

The boundary function in (1) is concave, with second derivative $-2\sec^2(2u)$, so this really is a compact convex lens. Its support function in the upper half-plane is
$$
h_K(\theta)=
\begin{cases}
(\pi/6)\cos\theta,&0\le\theta\le\pi/6,\\
b(\theta),&\pi/6\le\theta\le5\pi/6,\\
-(\pi/6)\cos\theta,&5\pi/6\le\theta\le\pi.
\end{cases}
\tag{12}
$$
Reflection supplies the lower half-plane. Thus the real-direction bound is $\pi/6$, although the unoptimized expression (7) tends to $\pi/4$. The gap between those numbers is supplied by the convex indicator constraint, not by taking the naive angular endpoint limit.

In particular the usual global version of the indicator bound gives, for each $\varepsilon>0$,
$$
|E(z)|\le C_{\varepsilon,E}
\exp\{h_K(\arg z)|z|+\varepsilon|z|\}.
\tag{13}
$$
It follows either from the indicator theorem or by a finite angular cover and the same sector principle. Equation (13) describes the closed lens; it does not place the actual indicator diagram strictly inside it.

## 5. Translation domain and precise scope

Let $a=a_R+ia_I$ and $w=ia=-a_I+ia_R$. Within the original principal theta strip $|a_I|\le\pi/4$, (1) is equivalent to
$$
2e^{-2|a_R|}\cos(2a_I)\ge1.
\tag{14}
$$
It forces $|a_I|\le\pi/6$. Thus $K$ is exactly the rotation by $i$ of the closure of the allowed translation domain containing zero. The principal-strip qualification is necessary: (14) by itself has other periodically repeated components and is not globally equivalent to (1).

The quotient bound retains the Hilbert weight, gamma constants, polynomial divisor, zero multiplicities, and closed boundary. Approximation of boundary-type quotients by strict-interior translation multipliers in the Hilbert norm is a separate question. No synthesis theorem, positivity of the remaining jump form, or exclusion of discrete subthreshold modes follows from the growth statement alone.
