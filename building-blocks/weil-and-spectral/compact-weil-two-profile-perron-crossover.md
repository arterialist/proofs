# The two-profile Perron packet at critical frequency

The [critical packet crossover](compact-weil-critical-packet-crossover.md)
computes the complete Weil form on one normalized divisor vector at
frequency (T=cN). The [boundary-packet construction](compact-weil-boundary-packet-growing-positive-space.md)
has two profiles on opposite sides of each packet center. Keeping both
gives an exact limiting (2\times2) matrix. Its mixed entry includes
the local gamma interaction and both pole moments. The prime matrix has
no mixed entry.

Fix (0<\delta<1), real nonnegative (p_-\in C_c^\infty(-\delta,0))
and (p_+\in C_c^\infty(0,\delta)), each of (L^2)-norm one. Let
(c>4), and for integer (N\to\infty) put
\[
 L_N=\tfrac12\log(N+1),\qquad T_N=cN,\qquad
 x_n=L_N-\log n,\qquad
 f_{n,\sigma}(x)=\sqrt{T_N}\,p_\sigma(T_N(x-x_n)).
\]
Use labels (I_- =\{1,\ldots,N\}) and
(I_+=\{2,\ldots,N\}), and write
\[
 H_{\sigma,N}=\sum_{n\in I_\sigma}\frac1n,\qquad
 W_{\sigma,N}=H_{\sigma,N}^{-1/2}
       \sum_{n\in I_\sigma}n^{-1/2}f_{n,\sigma}.
 \tag{1}
\]
For all large (N), these two real packets are orthonormal, supported
inside ((-L_N,L_N)), and have the exact full-prime compression of the
boundary-packet theorem. Define
\[
 m_\sigma=\int_{\mathbb R}p_\sigma(x)\,dx,\qquad
 g_{\sigma\tau}=\frac1{2\pi}\int_{\mathbb R}
 \log\frac{|u|}{2\pi}\,
 \widehat p_\sigma(u)\overline{\widehat p_\tau(u)}\,du,
 \qquad \sigma,\tau\in\{-,+\}.
 \tag{2}
\]
The (g_{\sigma\tau}) are real, and (m_\sigma>0). Let
(Q_{L_N}) be the complete compact Weil form, with the actual gamma
multiplier, both pole moments, and every admitted von Mangoldt prime
power. Its polarized matrix on (1) has the entrywise limit
\[
 \boxed{\quad
 \bigl(Q_{L_N}(W_{\sigma,N},W_{\tau,N})\bigr)_{\sigma,\tau}
 \longrightarrow
 \begin{pmatrix}
  \log c+\gamma+g_{--}+m_-^2/c & g_{-+}+m_-m_+/c\\
  g_{-+}+m_-m_+/c & \log c+\gamma+1+g_{++}+m_+^2/c
 \end{pmatrix}.
 \quad} \tag{3}
\]
Here (\gamma) is Euler's constant. In particular, the mixed limit
is strictly negative. The result is a form limit on this two-dimensional
space, not a uniform lower bound for the full growing packet space.

## The complete prime quotient

The prime compression is (A_N\oplus A_N^{[2,N]}), so its mixed
entry is zero. The [sharpness addendum](compact-weil-divisor-matrix-sharpness.md)
gives the exact full-block numerator
\[
 \langle w,A_Nw\rangle
 =2\sum_{d\le N}\frac{\Lambda(d)}d H_{\lfloor N/d\rfloor}
 =2\sum_{m\le N}\frac{\log m}{m},\qquad w_n=n^{-1/2}.
 \tag{4}
\]
Since (\sum_{m\le N}(\log m)/m
=\frac12(\log N)^2+O(1)) and
(H_N=\log N+\gamma+o(1)), the (W_-) prime quotient is
(\log N-\gamma+o(1)). Removing label one subtracts
(2\sum_{d\le N}\Lambda(d)/d=2\log N+O(1)) from (4) and one from
the squared norm. Thus the (W_+) quotient is
(\log N-\gamma-1+o(1)). These identities include proper prime
powers and use no prime number theorem.

## Off-center gamma and the pole

Write (H(t)=\Re\psi(1/4+it/2)-\log\pi). The function
\[
 q(t)=H(t)-\log\frac{|t|}{2\pi}
\]
belongs to (L^1(\mathbb R)): its singularity at zero is logarithmic,
and its tail is (O(t^{-2})). For the fixed Schwartz products in (2),
the Fourier integral of (q(T_Nu)) is (O(T_N^{-1})), uniformly in
the center separation. Summing all weighted entries of the
normalized (2\times2) packet matrix costs at most
\[
 O\left(\frac{(\sum_{n\le N}n^{-1/2})^2}
                   {T_N\log N}\right)
 =O((\log N)^{-1}). \tag{5}
\]

The constant (\log T_N) contributes (\log T_N) on each diagonal
and zero elsewhere: distinct centers have disjoint supports, while
(p_-) and (p_+) are orthogonal at the same center. The remaining
same-center entries tend to (g_{\sigma\tau}). To evaluate different
centers, set
\[
 G_{\sigma\tau}(s)=\frac1{2\pi}\int
 \log\frac{|u|}{2\pi}\,
 \widehat p_\sigma(u)\overline{\widehat p_\tau(u)}e^{isu}\,du.
\]
The inverse Fourier transform of (\log|u|) equals
(-1/(2|s|)) away from the origin, with a contact distribution at
the origin. The profile correlations are compactly supported, so for
(|s|>2\delta) the contact term vanishes and
\[
 G_{\sigma\tau}(s)
 =-\frac12\iint
   \frac{p_\sigma(v)p_\tau(w)}{|s+v-w|}\,dv\,dw
 =-\frac{m_\sigma m_\tau}{2|s|}+O(|s|^{-2}).
 \tag{6}
\]
Every distinct-center separation
(s=T_N\log(m/n)) has (|s|>2\delta) for large (N), since
(c>4). The elementary divisor-label sum is
\[
 B_N=\sum_{1\le n<m\le N}
 \frac1{\sqrt{nm}\log(m/n)}=N\log N+O(N).
 \tag{7}
\]
For (7), set (j=m-n). If (j\le n), its summand is
(1/j+O(1/n)); summing these errors over (j,n) costs (O(N)).
If (n<j), the sum over (n) is (O(1)) for each (j).
Similarly, the sum obtained by squaring the reciprocal logarithm in
(7) is (O(N^2)). Hence the (O(|s|^{-2})) term in (6) contributes
(O(1/\log N)) after normalization. Deleting label one in the (+)
packet changes neither limit. The off-center gamma entry is therefore
\[
 -\frac{m_\sigma m_\tau}{T_N\log N}B_N+o(1)
 =-\frac{m_\sigma m_\tau}{c}+o(1).
 \tag{8}
\]

The pole loading has an exact finite formula. Put
(a_\sigma^\pm(T)=\int p_\sigma(s)e^{\pm s/(2T)}ds) and
(N_\sigma=|I_\sigma|). Then
\[
 E_+(W_{\sigma,N})
 =\frac{e^{L_N/2}}{\sqrt{T_N}}a_\sigma^+(T_N)
       \sqrt{H_{\sigma,N}},\qquad
 E_-(W_{\sigma,N})
 =\frac{e^{-L_N/2}}{\sqrt{T_N}}a_\sigma^-(T_N)
       \frac{N_\sigma}{\sqrt{H_{\sigma,N}}}.
 \tag{9}
\]
Consequently the polarized pole entry
(E_+(W_\sigma)E_-(W_\tau)
+E_-(W_\sigma)E_+(W_\tau)) tends to
(+2m_\sigma m_\tau/c). Combining this with (8) leaves the positive
rank-one term (m_\sigma m_\tau/c) in (3).

The local mixed gamma entry has a fixed sign. The two supports are
disjoint, so the same Fourier kernel gives
\[
 g_{-+}=-\frac12\iint
   \frac{p_-(v)p_+(w)}{|v-w|}\,dv\,dw
 <-\frac{m_-m_+}{4\delta}.
 \tag{10}
\]
Because (c>4) and (\delta<1), (10) makes the mixed entry in
(3) negative even after the positive pole correction.

As a calibration, take normalized interval indicators of common
length (\ell<1) immediately left and right of zero. These rough
profiles belong to the logarithmic form domain; smooth profiles
approximate them in that norm. Direct integration gives
(m_\sigma^2=\ell),
(g_{\sigma\sigma}=1-\gamma-\log(2\pi\ell)), and
(g_{-+}=-\log2). Formula (3) becomes
\[
 \begin{pmatrix}
 1+\log(c/(2\pi\ell))+\ell/c&-\log2+\ell/c\\
 -\log2+\ell/c&2+\log(c/(2\pi\ell))+\ell/c
 \end{pmatrix}. \tag{11}
\]
This calculation checks the sign and the factor of the pole term.

## What reaches the actual theta covariance

The divisor vector in (1) lives in a compact Weil window. The
exterior killed-theta covariance uses a different Hilbert space. Its
available matched-action analogue is the span of
(\varepsilon=\operatorname{sgn}) and (\varphi=y/\psi), with
(y=\sigma_O). In the notation of the
[score-matched affine gap](../theta-and-heat/theta-score-matched-affine-gap.md), put
\[
 X=\delta S_y-t_{\rm score}S_q,\qquad
 t_{\rm score}=\frac{1/2+\delta U(y,q)}{U(q,q)},\qquad
 v=\widehat M^{-1}X.
\]
The (\widehat M)-energy projection of (v) onto that span has the
exact Gram matrix and forcing column
\[
 G=\begin{pmatrix}E_s&k\\k&E_y\end{pmatrix},\qquad
 b=\binom{\delta H_y-t_{\rm score}H_q}
          {\delta\|y\|_\nu^2-t_{\rm score}\langle y,q\rangle_\nu}.
 \tag{12}
\]
Here (H_z=\langle S_z,\varepsilon\rangle_\gamma),
(E_s=k[\varepsilon]), (k=k(\varepsilon,\varphi)), and
(E_y=k[\varphi]). The projection coefficient is (G^{-1}b);
its energy is (b^{\mathsf T}G^{-1}b). The exact score relation
(m_C+\langle y,q\rangle_\nu=-1/2) retains the affine pole input.
The comparison matches both operator actions, so the residual
(n=k-m_{\widehat M}) annihilates this projection exactly:
\[
 n[v]=n[v-P_Gv]. \tag{13}
\]
This holds even if (b) is large. It does not bound the remaining
continuous same-half energy, prime same-half energy, or separate
cross-edge variances in the
[conditional edge estimator](../theta-and-heat/theta-affine-comparison-conditional-edge-energy.md).
The [radius-transport obstruction](../theta-and-heat/theta-common-score-radius-transport-obstruction.md)
constructs admissible odd high-frequency tests whose residual energy
diverges. Subtracting their matched-action projections makes their
forcing column zero without changing that energy. Thus the two
projection coefficients alone cannot bound arbitrary-source residuals.
No form-preserving map from (1) to this exterior residual is known.
The distinguished affine source still needs a source-specific bound;
neither (3) nor (13) proves RH.

The Fourier-log kernel, nonnegative-form projection, and finite-rank
identities used here are classical. Equations (3) and (12) are written
mathematics, with no Lean formalization claim.
