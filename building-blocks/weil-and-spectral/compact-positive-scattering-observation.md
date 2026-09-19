# An actual compact test with an everywhere-positive observation

This written construction combines a classical compact bump with the [observed-growth theorem](zero-abscissa-scattering-growth.md) and [single-observation criterion](single-observation-scattering-criterion.md). It is not a Lean theorem. Write $\Theta$ for the supremum of the real parts of nontrivial zeta zeros. The full multiplier $\widehat U_X=U_X R V_{\log X}^+$, the negative-frequency Hardy projection $P$, and the trace norm use the [semilocal normalization](semilocal-weighted-scattering.md) and [rational correction](rational-scattering-pole-factor.md).


The observation in the growth theorem can be the squared Fourier modulus of one explicitly constructed actual test. This removes the need to choose an unrelated positive Schwartz weight.

Let $Y_n$, $n\ge1$, be independent uniform random variables on $[-2^{-n},2^{-n}]$. The series $Y=\sum_{n\ge1}Y_n$ converges for every outcome because $\sum2^{-n}=1$. Its law is an even probability measure supported in $[-1,1]$, and its Fourier transform is
$$
H(z)=\prod_{n=1}^\infty\operatorname{sinc}(z/2^n),
\qquad \operatorname{sinc}(z)=\frac{\sin z}{z},\quad\operatorname{sinc}(0)=1.
\tag{1}
$$
Indeed the finite products are the transforms of the partial sums, and bounded convergence gives their limit for every complex $z$. On a compact set in $\mathbb C$,
$\operatorname{sinc}(z/2^n)=1+O(4^{-n})$ uniformly. Thus the product converges locally uniformly, defines an entire even function, and is the entire transform of the limiting probability law. In particular $|H(z)|\le e^{|\Im z|}$ and $H(0)=1$.

There are no extra zeros contributed by the infinite tail. At any point where all the factors are nonzero, their tail deviations from one are absolutely summable, so the tail product is nonzero. The union of the factor zero sets is exactly
$$
\boxed{\{t\in\mathbb R:H(t)=0\}=2\pi\mathbb Z\setminus\{0\}.}
\tag{2}
$$
In fact these are all its complex zeros as well. At $t=2\pi k$, $k\ne0$, the multiplicity is $1+v_2(|k|)$; only finitely many factors vanish there. The multiplicity statement is not needed for the construction.

For $T=|t|\ge2$, put $N=\lfloor\log_2T\rfloor$. Using the first $N$ factors and bounding all others by one gives
$$
\begin{aligned}
|H(t)|&\le\prod_{n=1}^N\frac{2^n}{T}
 =2^{N(N+1)/2}T^{-N}\\
&\le\exp\left[-\frac{(\log T)^2}{2\log2}+\frac12\log T\right].
\end{aligned}
\tag{3}
$$
For the last inequality write $\log_2T=N+r$, $0\le r<1$; the residual term is $(r^2-r)/2\le0$. Consequently $t^kH(t)\in L^1(\mathbb R)$ for every nonnegative integer $k$.

Fourier inversion now defines
$$
h(u)=\frac1{2\pi}\int_{\mathbb R}H(t)e^{-itu}dt.
$$
Differentiation under this integral is justified to every order by (3). Uniqueness of Fourier transforms identifies $h(u)du$ with the law of $Y$, so $h\ge0$, $\int h=1$, and $h$ vanishes outside $[-1,1]$. Since the inverse is smooth on the whole line, it is flat at the support endpoints and belongs to $C_c^\infty(\mathbb R)$. Evenness of the law gives real even $h$. This also proves $H\in\mathcal S(\mathbb R)$, including its derivatives, by integration by parts against the now-established compact smooth density; one need not differentiate the infinite product to obtain that conclusion.

This is the classical compact bump described in Arias de Reyna, *An infinitely differentiable function with compact support: Definition and properties*, the author's translation of his 1982 paper, [arXiv:1702.05442, equations (4) and (9)](https://arxiv.org/pdf/1702.05442). The frequency normalization there is $e^{-2\pi iux}$, so its product at $x=t/(2\pi)$ is exactly (1). The proof above records the normalization and smoothness needed here independently.

Define the one complex even function
$$
g_0(u)=h(u)+\frac{i}{\sqrt2}h(u/\sqrt2),
\qquad
f_0(u)=\left(-\frac{d^2}{du^2}+\frac14\right)g_0(u).
\tag{4}
$$
Both belong to $C_c^\infty$, with support contained in $[-\sqrt2,\sqrt2]$. The exact scaling factor in (4) gives
$$
F_0(z)=\widehat f_0(z)
 =(z^2+\tfrac14)\,[H(z)+iH(\sqrt2z)].
\tag{5}
$$
For real $t$, both $H(t)$ and $H(\sqrt2t)$ are real. They cannot vanish simultaneously: a nonzero common zero would require $t=2\pi k$ and $\sqrt2t=2\pi\ell$ with nonzero integers $k,\ell$, contrary to irrationality of $\sqrt2$. At zero both values equal one. Therefore
$$
\boxed{
\chi_0(t):=|F_0(t)|^2
 =(t^2+\tfrac14)^2\,[H(t)^2+H(\sqrt2t)^2]>0
 \quad(t\in\mathbb R).}
\tag{6}
$$
It is an even real Schwartz function. The mixed terms in the squared modulus cancel exactly because the two components in (5) have relative phase $i$; no conjugated cross term has been dropped.

Integration by parts in (4) gives both pole-null conditions
$$
\int e^{u/2}f_0(u)du=\int e^{-u/2}f_0(u)du=0.
\tag{7}
$$
Equivalently $F_0(\pm i/2)=0$. Use the actual theta kernel $\Phi$ from the [derivative-kernel note](../theta-and-heat/theta-derivative-kernel-logconcavity.md), and $d\nu=2\cosh(u/2)\Phi(u)du$. Since $\Phi$ is smooth and strictly positive on the real axis,
$$
q_0(u)=f_0(u)/\Phi(u)
$$
is a compact smooth even theta vector. Its two moments imply
$\nu q_0=2\int\cosh(u/2)f_0(u)du=0$. The complex-valued test is legitimate in the complex Hilbert form, with its usual conjugated quadratic pairing. It is nonzero, since $F_0(0)=(1+i)/4$.

Fix this $f_0$ once and for all, and define
$$
\mathcal N_{f_0}(X)=
\|M_{|F_0|^2}\Delta(U_X R V_{\log X}^+)\|_1.
\tag{8}
$$
For every $X\ge\exp(2\sqrt2)$, the [theta ground-state identity](../theta-and-heat/theta-weil-jump-form.md) gives the exact signed readout
$$
\operatorname{Tr}(M_{|F_0|^2}\Delta(U_X R V_{\log X}^+))
 =Q(f_0)=E_{\rm jump}(q_0)-\tfrac12\|q_0\|_{L^2(\nu)}^2.
\tag{9}
$$
The sufficient support threshold uses the full diameter $2\sqrt2$. The same weight is locally bounded below on every finite height interval by (6), so every step of the norm-to-zero-free implication applies to (8).

Consequently the growth theorem and the RH criterion now have the following one-actual-test form:
$$
\boxed{
\limsup_{X\to\infty}
\frac{\log(1+\mathcal N_{f_0}(X))}{\log X}
 =\Theta-\tfrac12,
\qquad
\mathrm{RH}\ \Longleftrightarrow\
\forall\epsilon>0:\ \mathcal N_{f_0}(X)=O_\epsilon(X^\epsilon).}
\tag{10}
$$
Under RH, the proved upper theorem gives $\mathcal N_{f_0}(X)=O((\log X)^{9/2})$. The norm in (8) retains the full operator and growing actual prime history; it is not the absolute value of the constant scalar readout in (9). In particular (10) does not assert that the sign of the single number $Q(f_0)$ decides RH. This is a constructive domain refinement of the norm criterion, with no new unconditional positivity assertion.

## A tilted real test whose filter is nonzero at every nontrivial zero

There is a different useful construction from the same classical bump. It gives a real compact test whose bilateral pole filter has no zero in the open critical strip except the required zero at the origin. Its consumer is the actual translation kernel, rather than the trace norm (8).

Fix $0<2\epsilon<\log2$, shrinking it further if the local-positivity support bound in the [translation-kernel theorem](local-weil-extension-obstruction.md) is also required. Put $a_n=\epsilon2^{-n}$ and let $u_n=(2a_n)^{-1}\mathbf1_{[-a_n,a_n]}$. The finite convolutions $b_N=u_1*\cdots*u_N$ have Fourier transforms

$$
F_N(t)=\prod_{n=1}^N\frac{\sin(a_nt)}{a_nt}.
$$

An analytic construction of their smooth limit avoids a probabilistic limit theorem. For fixed $M$, retaining the first $M$ factors gives $|F_N(t)|\le C_M(1+|t|)^{-M}$ on the real axis, uniformly for $N\ge M$. The products converge on complex compact sets because each factor is $1+O_R(a_n^2)$ there. For $M\ge k+2$, Fourier inversion and dominated convergence therefore give

$$
\sup_u|b_N^{(k)}(u)-b_0^{(k)}(u)|
\le\frac1{2\pi}\int_{\mathbb R}|t|^k|F_N(t)-F(t)|dt\longrightarrow0.
$$

Only the sufficiently long finite convolutions need $C^k$ representatives. The common support is contained in $[-\epsilon,\epsilon]$. Uniform convergence gives $b_0\ge0$, $\int b_0=1$, and $b_0\in C_c^\infty$. Its derivatives vanish at the support endpoints. This retains a Fourier-inversion proof of the smooth limit distinct from the probability construction above.

Its bilateral transform is

$$
B_0(z)=\int b_0(u)e^{-zu}du
=\prod_{n\ge1}\frac{\sinh(a_nz)}{a_nz}.
\tag{11}
$$

The identity follows by passing from finite convolutions on the common support. Around any fixed point, the tail factors admit analytic logarithms with absolutely and locally uniformly convergent sum. Thus the tail is nonvanishing, and zero multiplicity is the sum of the finitely many vanishing initial factors. The zeros are exactly $2\pi im/\epsilon$, $m\ne0$, with multiplicity $1+v_2(|m|)$. These are the rescaled product and multiplicities of [Arias de Reyna, equations (4) and (9)](https://arxiv.org/pdf/1702.05442); the tilt and kernel application below are elementary consequences.

Set $b(u)=e^u b_0(u)$ and $\phi=b'''-b'/4$. The real function $\phi$ is smooth and compactly supported. Integration by parts gives

$$
\Phi_\phi(z)=\int\phi(u)e^{-zu}du
=z(z^2-\tfrac14)B_0(z-1).
\tag{12}
$$

Its mean and both pole moments vanish. It is nonzero because $\Phi_\phi(1)=3/4$; also $\Phi_\phi(-1)=-3B_0(-2)/4<0$. The tilt is not even and need not have unit mass. The real-test correlation identities require neither property.

The complete pole filter is

$$
E_\phi(z)=\Phi_\phi(z)\Phi_\phi(-z)
=-z^2(z^2-\tfrac14)^2B_0(z-1)B_0(-z-1).
\tag{13}
$$

Its zero set consists of $0,\pm1/2$, each of order two, and $\pm1+2\pi im/\epsilon$, $m\ne0$, each of order $1+v_2(|m|)$. In particular

$$
E_\phi(z)\ne0\quad\text{for }0<|\Re z|<1/2,
\qquad E_\phi(it)=|\widehat\phi(t)|^2>0\quad(t\ne0).
\tag{14}
$$

Positivity of the untilted bump alone would not give the off-axis statement. Here it follows from the exact displaced zero sets.

Let $C_\phi(L)=\int\phi(u)\phi(u+L)du$ and retain the full [translation kernel](local-weil-extension-obstruction.md), with its digamma multiplier $h$:

$$
\begin{aligned}
a_\phi(L)&=\frac1{2\pi}\int h(t)|\widehat\phi(t)|^2e^{itL}dt,\\
k_\phi(L)&=a_\phi(L)-\sum_{m\ge2}\frac{\Lambda(m)}{\sqrt m}
 [C_\phi(L-\log m)+C_\phi(L+\log m)].
\end{aligned}
\tag{15}
$$

Every prime power remains. Short support places each positively shifted arithmetic correlation wholly in $L>0$. The digamma contour proof in that chapter gives $a_\phi(L)=O_{\phi,\delta}(e^{-\delta|L|})$ for every $0<\delta<1/2$, and the exact one-sided transform is

$$
\int_0^\infty e^{-zL}k_\phi(L)dL
=\mathcal A_\phi(z)+E_\phi(z)
 \frac{\zeta'(z+1/2)}{\zeta(z+1/2)},\qquad \Re z>1/2.
\tag{16}
$$

Here $\mathcal A_\phi$ is holomorphic on $\Re z>-\delta$. The order-two filter zero at $z=1/2$ removes the logarithmic-derivative pole at one.

Suppose, as an unproved arithmetic hypothesis, that for every $\eta>0$ there is $C_\eta$ with $|k_\phi(L)|\le C_\eta e^{\eta L}$ for all $L\ge0$. The left side of (16) is then holomorphic on $\Re z>0$, by locally dominated differentiation. If $\rho$ is any nontrivial zero with $1/2<\Re\rho<1$, of multiplicity $m$, the right side has nonzero residue $mE_\phi(\rho-1/2)$ there by (14). Meromorphic continuation contradicts holomorphy. Known nonvanishing on $\Re\rho\ge1$ and functional-equation reflection then give RH, without simplicity, a height cutoff or a density argument for translates of the test.

More generally, a bound $|k_\phi(L)|\le Ce^{\alpha L}$ with $0\le\alpha<1/2$ excludes zeros with $\Re\rho>1/2+\alpha$. The filter nonvanishing used here is only required for $1/2+\alpha<\Re\rho<1$; it is not a claim that (13) has no zeros on the entire right half-plane.

Global positive definiteness of this actual $k_\phi$ would supply a bounded envelope by its $2\times2$ Gram matrices. A positive extension that agrees only near zero would be a different global kernel and does not suffice. The compact construction and pole coverage above prove neither that global positive definiteness nor the required arithmetic growth bound. These are written conditional implications, not new Lean theorems.
