# Zero modes hidden by the exact theta radical smoothing

The [actual theta radical identity](theta-weil-jump-form.md#11-exact-tail-cancellation-without-a-pnt-remainder) detects a positive sparse downweighting of Mangoldt's coefficients pointwise. That fact does not invert the theta smoothing in the identity. The same kernel annihilates every exponential mode associated with a zero of the completed zeta function, including a hypothetical off-critical zero. This note isolates that exact limitation before using the radical identity to estimate the unsmoothed Suzuki prime clock or the signed theta covariance.

Let
\[
 \mathcal M(s)=\int_{\mathbb R}\Phi(v)e^{sv}\,dv
              =\xi(\tfrac12+s).
\tag{1}
\]
The two-sided theta envelope makes this an entire function and permits differentiation under the integral to every fixed order. Evenness of \(\Phi\), equivalently the completed functional equation, gives \(\mathcal M(-s)=\mathcal M(s)\). With the ordinary full-line convolution
\((\Phi*f)(u)=\int_{\mathbb R}\Phi(v)f(u-v)\,dv\), it follows exactly that
\[
 \boxed{\qquad
 (\Phi*e^{s\cdot})(u)
 =e^{su}\mathcal M(-s)
 =e^{su}\mathcal M(s).
 \qquad}
\tag{2}
\]
If \(\rho\) is any nontrivial zero of \(\xi\) and \(s_\rho=\rho-\tfrac12\), then
\[
 \boxed{\quad \Phi*e^{s_\rho\cdot}=0.\quad}
\tag{3}
\]
No assumption on the location of \(\rho\) was made. Were \(\Re\rho>1/2\), the unsmoothed mode \(e^{s_\rho u}\) would grow with the power \(x^{\Re\rho-1/2}\) under \(x=e^u\), yet (3) would still erase it. This is a null-mode calculation, not an assertion that an arbitrary signed mode may be added to the actual positive prime measure.

There is a precise hierarchy at a multiple zero. Differentiate (2) \(m\) times in \(s\):
\[
 \boxed{\quad
 \bigl(\Phi*(u^m e^{s u})\bigr)(x)
 =e^{sx}\sum_{k=0}^m {m\choose k}
                 x^{m-k}\mathcal M^{(k)}(s).
 \quad}
\tag{4}
\]
Here the \(u\) inside the convolution on the left is the argument of the input function, while \(x\) is the output coordinate. If \(\mathcal M\) has a zero of exact order \(d\) at \(s_\rho\), then every \(u^m e^{s_\rho u}\) with \(m<d\) is annihilated, while
\[
 \Phi*(u^d e^{s_\rho u})
 =\mathcal M^{(d)}(s_\rho)e^{s_\rho u}\ne0.
\tag{5}
\]
For a simple zero, the first nonvanishing polynomial test is \(u e^{s_\rho u}\), whose output is \(\mathcal M'(s_\rho)e^{s_\rho u}\). This derivative test is no longer annihilated by the convolution. Its complex phase and the complete Weil or affine quadratic terms still need a sign or quantitative estimate; (5) alone provides neither.

The loss is not an artifact of allowing globally exponential functions. Choose a smooth \(0\le\chi_T\le1\) with \(\chi_T=1\) on \([-T/2,T/2]\) and support in \([-T,T]\), and put \(f_{s,T}(u)=\chi_T(u)e^{su}\). At a zero \(s=s_\rho\), (3) and \(|x|\le T/4\) give
\[
 |(\Phi*f_{s,T})(x)|
 \le |e^{s x}|
       \int_{|v|\ge T/4}\Phi(v)e^{-\Re(s)v}\,dv
 \le C_s |e^{s x}|\exp(-c_s e^{T/2}).
\tag{6}
\]
The last bound follows from the two-sided theta tail, after absorbing the ordinary exponential factor. Thus compact truncations of a zero mode have a superexponentially small theta-smoothed signal throughout a growing central interval, even though the input there equals \(e^{su}\). This rules out a stable local inversion based only on the radical convolution.

The [sparse-weight comparison](theta-sparse-prime-form-stability-test.md#the-exact-radical-identity-sees-the-missing-weight) shows the other side of the distinction: a positive coefficient downweighting gives a visible pointwise radical defect of order \(\varepsilon_j\sqrt{X_j}\). Exact Mangoldt weights exclude that deformation, but the radical identity is still compatible with the zero modes (3). Any RH-scale conclusion from this identity must add a constraint that controls those modes in the complete unsmoothed source or supplies a valid signed estimate for the derivative tests. No such estimate, RH proof, or Lean formalization is asserted here.
