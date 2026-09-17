# A quantum speed bound for the theta Mellin function

Classical log-concavity of the actual theta kernel controls the variance of a logarithmic random variable. The Mandelstam–Tamm bound then gives a zero-free region for the auxiliary Mellin function. This is an application of established results to the complete theta kernel; it is not a global zero enclosure or a proof of RH.

## The actual Mellin law

Use $\Phi$, $Z$, and $L(z)=F(z+1)$ from the [theta Mellin obstruction](theta-mellin-bernstein-obstruction.md), and set

$$
A(p)=\int_0^\infty v^{p-1}\Phi(\sqrt v)\,dv,\qquad p>0.
$$

Substituting $v=u^2$ gives

$$
L(z)=\frac{\sqrt\pi}{Z}\,4^{-z}
\frac{A(z+1/2)}{\Gamma(z+1/2)}
\qquad(\Re z>-1/2).
$$

The complete theta kernel satisfies that $v\mapsto\Phi(\sqrt v)$ is positive, integrable and log-concave on $[0,\infty)$. This is the classical theta-kernel log-concavity theorem recorded by Csordas in Theorem 2.2(b). With the normalization in that paper, the present kernel is $\Phi(u)=2\Phi_{\mathrm{Csordas}}(u/2)$; positive scaling preserves the property.

For a positive log-concave function on the positive half-line, the normalized Mellin transform $A(p)/\Gamma(p)$ is log-concave for $p>0$. Consider the probability law

$$
d\mu_p(v)=\frac{v^{p-1}\Phi(\sqrt v)}{A(p)}\,dv,\qquad Y=\log v.
$$

The kernel's behavior at zero and its rapid decay at infinity give all logarithmic moments. Differentiation under the integral gives

$$
\Delta_p^2:=\operatorname{Var}_{\mu_p}(Y)
=(\log A)''(p)
\le\psi_1(p),
$$

where $\psi_1=(\log\Gamma)''$ is the trigamma function.

## The finite-variance speed inequality

Let $Y$ be any real random variable with finite variance $\Delta^2$, put $X=Y-\mathbb EY$, and define $\chi(t)=\mathbb E e^{itX}$. Cauchy–Schwarz and $\mathbb EX=0$ give

$$
|\chi'(t)|
=\left|\mathbb E\left[X(e^{itX}-\chi(t))\right]\right|
\le \Delta\sqrt{1-|\chi(t)|^2}.
$$

For $r(t)=|\chi(t)|$, this implies $|r'|\le\Delta\sqrt{1-r^2}$ almost everywhere. To handle $r=1$ without dividing by zero, integrate the derivative inequality for $\arccos((1-\varepsilon)r)$ and let $\varepsilon\downarrow0$. Since $r(0)=1$,

$$
\arccos r(t)\le\Delta |t|.
$$

Consequently,

$$
|\mathbb E e^{itY}|\ge\cos(|t|\Delta)
\qquad\text{when }|t|\Delta\le\frac\pi2.
$$

Nonvanishing requires the strict inequality $|t|\Delta<\pi/2$ in this general statement. The two-point law at $\pm\Delta$ attains equality, so the constant cannot be improved using variance alone.

Equivalently, in $L^2$ of the probability law, multiplication by $X$ is self-adjoint and the initial unit vector is the constant function $1$. The overlap with its unitary evolution is $\chi(t)$. The estimate is the Mandelstam–Tamm bound on the time needed to reach an orthogonal state.

## Zero-free regions for the actual function

Let $\sigma>-1/2$ and $p=\sigma+1/2$. Since $A(p+it)/A(p)=\mathbb E_{\mu_p}e^{itY}$ and $|4^{-it}|=1$,

$$
|L(\sigma+it)|
\ge L(\sigma)\frac{\Gamma(p)}{|\Gamma(p+it)|}
\cos\left(|t|\sqrt{\psi_1(p)}\right)
$$

whenever $|t|\sqrt{\psi_1(p)}\le\pi/2$. In particular,

$$
t^2\psi_1(\sigma+1/2)<\frac{\pi^2}{4},
\qquad \sigma>-1/2
\quad\Longrightarrow\quad L(\sigma+it)\ne0.
$$

For $\sigma>0$, strict convexity and the midpoint inequality on each unit interval imply

$$
\psi_1(\sigma+1/2)
=\sum_{n=0}^\infty\frac1{(n+\sigma+1/2)^2}
<\int_0^\infty\frac{dx}{(x+\sigma)^2}
=\frac1{\sigma}.
$$

Thus the simpler closed parabolic region is also zero-free:

$$
\boxed{\ \sigma>0,\qquad
t^2\le\frac{\pi^2}{4}\sigma
\quad\Longrightarrow\quad L(\sigma+it)\ne0.\ }
$$

The boundary is included here because the trigamma comparison is strict. The estimate improves the constant $2$ supplied by the elementary quadratic cosine bound to $\pi^2/4$.

## Scope and attribution

This is a right-opening zero-free region for an auxiliary Mellin function. It gives neither the left-half-plane confinement required by a global multiplier construction nor a Bernstein-function representation. It does not locate the zeros of the Riemann xi function.

The Hilbert-space interpretation is exact for this probability law. It does not identify Mellin time $t$ with the additive progression of integers.

The [derivative-kernel theorem](theta-derivative-kernel-logconcavity.md) supplies a further positive log-concave Mellin representation and extends the displayed region one unit to the left.

Sources:

- G. Csordas, [*Convexity and the Riemann ξ-function*](https://web.math.pmf.unizg.hr/glasnik/33.1/33105.pdf), Theorem 2.2(b), for the actual theta-kernel log-concavity.
- M. Fradelizi, J. Li and M. Madiman, [*Concentration of information content for convex measures*](https://arxiv.org/html/1512.01490), Proposition 3.2 at concavity parameter zero, for normalized Mellin log-concavity.
- J. Anandan and Y. Aharonov, [*Geometry of quantum evolution*](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.65.1697), for the geometric quantum-speed framework. The finite-variance estimate needed here is proved above.

No claim of publication priority is made for this application. The result is a written mathematical proof, not a Lean formalization.
