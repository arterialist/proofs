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
Equivalently $F_0(\pm i/2)=0$. Use the actual theta kernel $\Phi$ from the [derivative-kernel note](theta-derivative-kernel-logconcavity.md), and $d\nu=2\cosh(u/2)\Phi(u)du$. Since $\Phi$ is smooth and strictly positive on the real axis,
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
For every $X\ge\exp(2\sqrt2)$, the [theta ground-state identity](theta-weil-jump-form.md) gives the exact signed readout
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
