# Full-symbol square tests for Suzuki's fixed-parameter sign problem

This note tests two nonlocal positivity routes for the **complete** Suzuki symbol
\[
\Theta_\omega(z)=
\frac{\xi(1/2-\omega-iz)}{\xi(1/2+\omega-iz)}
\qquad(0<\omega<1/2).
\tag{1}
\]
They retain the gamma factor and all Jordan coefficients. The boundary Hilbert-space square is unconditional but measures *Hardy-space leakage*; making it vanish is precisely the missing innerness assertion. An exact theta-kernel decomposition has a signed midpoint density, despite positivity of Riemann's theta kernel. Neither route supplies a fixed-\(\omega\) sign for Suzuki's arithmetic Hankel function.

## The unitary square measures the missing condition

Use logarithmic coordinates and the unitary Fourier transform \((\mathcal Ff)(u)=(2\pi)^{-1/2}\int_{\mathbb R}f(y)e^{iuy}\,dy\). Let
\[
U_\omega=\mathcal F^{-1}M_{\Theta_\omega}\mathcal F,\qquad
P_+=\mathbf1_{(0,\infty)}(y),\quad P_-=\mathbf1_{(-\infty,0)}(y).
\tag{2}
\]
The functional equation gives \(|\Theta_\omega(u)|=1\) for real \(u\), so \(U_\omega\) is unitary for every \(\omega>0\), with no zero-free assumption. For every \(f=P_+f\),
\[
\boxed{\quad
\|f\|_2^2-\|P_+U_\omega f\|_2^2
=\|P_-U_\omega f\|_2^2\ge0.
\quad}
\tag{3}
\]
This is a genuine Hilbert-space factorization of the full boundary symbol. It gives a contraction after projection. It gives Hardy-space invariance only if its square vanishes **for every** \(f\in P_+L^2\):
\[
P_-U_\omega P_+=0
\ \Longleftrightarrow\
\Theta_\omega H^2(\mathbb C^+)\subset H^2(\mathbb C^+)
\ \Longleftrightarrow\
\Theta_\omega\text{ is inner}.
\tag{4}
\]
The last equivalence is [Suzuki's Lemma 3.1 and Theorem 2.2](https://arxiv.org/html/1204.1827v2). For all sufficiently small \(\omega>0\), (4) would imply RH: if \(\rho=\beta+i\gamma\) were an off-line zero with \(\beta>1/2\), then at \(z_\rho=i(\rho-1/2-\omega)\) the denominator of (1) would vanish in the upper half-plane for every sufficiently small \(\omega<\beta-1/2\), while its numerator would be nonzero by isolation of zeros. Taking the Hardy function \(F(z)=(z+i)^{-1}\), which does not vanish at \(z_\rho\), makes \(\Theta_\omega F\) have that pole. Its negative-time projection, and hence the square in (3) for \(f=\mathcal F^{-1}F\), is nonzero.

A rational all-pass symbol shows the logical gap without zeta: for \(a>0\), set \(B_a(u)=(u+ia)/(u-ia)\). Multiplication by \(B_a\) is unitary on the Fourier boundary, but it has an upper-half-plane pole. Its inverse Fourier convolution kernel is \(\delta_0(y)-2ae^{ay}\mathbf1_{y<0}\). For \(f\) supported on \(y>0\),
\[
(P_-\mathcal F^{-1}M_{B_a}\mathcal Ff)(y)
=-2ae^{ay}\int_0^\infty e^{-av}f(v)\,dv
\qquad(y<0),
\]
and its squared norm is \(2a\left|\int_0^\infty e^{-av}f(v)\,dv\right|^2\). Thus exact conservation of the full-line norm can coexist with backward leakage.

Suzuki's **causal arithmetic kernel** is
\[
h_\omega(x)=\frac1x\sum_{n\le x}c_\omega(n)g_\omega(n/x),
\qquad
c_\omega(n)=n^\omega\prod_{p\mid n}(1-p^{-2\omega}),
\tag{5}
\]
whose Mellin transform equals \(\Theta_\omega\) on the high line \(\Im z>1/2+\omega\). The boundary multiplier \(U_\omega\) in (2) is always unitary, but identifying its action on positive-logarithm inputs, after the usual \(x^{1/2}\) unitary weight, with convolution by (5) is **equivalent to innerness** by [Suzuki's Theorem 2.2(1)](https://arxiv.org/html/1204.1827v2). This is the point at which a proposed positive square for the causal kernel can silently assume the desired Hardy invariance. Poles crossed between the high Mellin line and the boundary obstruct that identification when off-line zeros exist. The [exact signed-discrepancy representation for the integrated kernel](suzuki-hankel-exponential-boundary-layer.md) is consistent with this obstruction.

For clarity that (1) includes every prime power, write \(s=1/2-iz\). In the absolutely convergent half-plane \(\Re s>1+\omega\),
\[
\log\frac{\xi(s+\omega)}{\xi(s-\omega)}
=\int_{-\omega}^{\omega}
\left[
 \frac1{s+t}+\frac1{s+t-1}
 -\frac12\log\pi+\frac12\psi\!\left(\frac{s+t}{2}\right)
 -\sum_{n\ge2}\frac{\Lambda(n)}{n^{s+t}}
\right]dt.
\tag{6}
\]
Here \(\psi=\Gamma'/\Gamma\), and the \(\Lambda(n)\) sum runs over all prime powers. Formula (6) follows by integrating the logarithmic derivative of the completed zeta function along a zero-free horizontal segment. Its prime terms have real parts proportional to \(\cos(\Im s\log n)\), so they do not form termwise nonnegative squares. The series is not available in the strip \(1/2<\Re s\le1+\omega\) where (4) is difficult; analytic continuation does not preserve a termwise sign argument.

## Theta-kernel midpoint test

Let \(\Xi(z)=\xi(1/2+iz)\). [Riemann's theta-kernel formula, in Romik's normalization](https://math.ucdavis.edu/~romik/data/uploads/papers/riemannxi.pdf), is
\[
\Xi(z)=\int_{\mathbb R}\Phi(t)e^{izt}\,dt,
\tag{7}
\]
where \(\Phi\) is real, even, strictly positive, smooth, and rapidly decreasing. Put
\[
Q_u(m)=\int_{\mathbb R}
\Phi(m+b)\Phi(m-b)\cos(2ub)\,db
\qquad(m,u\in\mathbb R).
\tag{8}
\]
Expanding \(|\Xi(u+ia)|^2\), then setting \(m=(t+r)/2\), \(b=(t-r)/2\) in its double integral, gives the exact identity
\[
|\Xi(u+ia)|^2
=4\int_0^\infty\cosh(2am)Q_u(m)\,dm.
\tag{9}
\]
Consequently, for \(v,\omega>0\),
\[
\boxed{\quad
|\xi(1/2+v+\omega-iu)|^2
-|\xi(1/2+v-\omega-iu)|^2
=8\int_0^\infty
\sinh(2vm)\sinh(2\omega m)Q_u(m)\,dm.
\quad}
\tag{10}
\]
The left side is \(|E_\omega(u+iv)|^2-|E_\omega^\#(u+iv)|^2\), the de Branges modulus gap whose positivity would make \(\Theta_\omega\) inner. The weights before \(Q_u(m)\) on the right are strictly positive for \(m>0\).

**The midpoint density \(Q_u(m)\) takes negative values for the actual theta kernel.** Up to a positive factor and the sign of the frequency, (8) is the Wigner distribution of the pure state \(\Phi/\|\Phi\|_2\). [Hudson's theorem](https://www-users.york.ac.uk/~slow500/reprints/1974HudsonNonnegativeWignerfct.pdf) says that a pure state's Wigner distribution is everywhere nonnegative only when the state is an exponential of a quadratic polynomial. Romik's explicit theta series gives
\[
\log\Phi(t)=-\pi e^{2t}+\frac92t+O(1)
\qquad(t\to+\infty),
\tag{11}
\]
so \(\Phi\) is not Gaussian. Hudson's theorem therefore gives some \((m,u)\) with \(Q_u(m)<0\). Since \(Q_u\) is continuous and even in \(m\), the negative value occurs for some \(m>0\).

Equation (10) is an exact completed-theta identity, but its integrand is **not** an integral of squares or a pointwise nonnegative density. A negative \(Q_u(m)\) does **not** make the integrated gap negative: its weighted integral may still be positive. The missing inequality is global in \(m\) and \(u\), and by (4) a proof for all \(v,\omega>0\) would settle RH.

The two tests isolate the same fixed-parameter frontier. Boundary unitarity supplies the nonnegative leakage square (3); a proof that the leakage vanishes must control the entire causal arithmetic kernel. Theta positivity supplies (7), but its exact midpoint density has both signs. Neither fact can be promoted to a sign for \(R_\omega(x)=\sqrt x\,h_\omega^{\langle1\rangle}(x)\) without a new global cancellation argument.
