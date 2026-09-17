# The actual coherent core as a signed screw-increment observation

This note consumes the classical explicit formula in Matsumoto–Suzuki, [Proposition 6.1, equation (6.2)](https://arxiv.org/html/2409.00888v2#S6), and their [Theorem 1.3](https://arxiv.org/html/2409.00888v2#Thmtheorem1.3). It gives an exact increment observation of the existing coherent Weil cross row and the original scalar feedback. The observation has signed weights. A concrete test below shows that it is not a positive functional on the general screw cone, even with the actual endpoint value fixed. No sign conclusion for the actual zeta kernel follows from this test.

The source conventions are those of [the complete kernel](../successor-and-division/successor-feedback-kernel-scaling.md), [the correlated cross family](actual-core-explicit-weil-cross-family.md), [the full archimedean row and radical projection](actual-core-Weil-arch-row-radical-projection.md), and [the positive integer-birth quadrature](../successor-and-division/actual-integer-birth-positive-quadrature.md). Every von Mangoldt sum below includes all prime powers.

## 1. The explicit first-order map, with its causal contact

Use the factorial primitive and actual source
$$
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
\qquad a(v)=e^{v/2}\left(\frac{\psi(e^v)}{e^v}-1\right),\quad v>0.
\tag{1}
$$
Matsumoto–Suzuki give the absolutely convergent zero sum
$$
S(v)=\sum_\rho\frac{e^{(\rho-1/2)v}}{\rho(1-\rho)}
=e^{v/2}[1+\gamma_E-F(e^v)]-e^{-v/2}A(e^v),
\tag{2}
$$
where the sum includes multiplicities, and
$$
A(x)=\log(2\pi)+\tfrac12\log(1-x^{-2})
+\frac{x}{2}\log\frac{x+1}{x-1}-1.
\tag{3}
$$
The combined expression has $A(1+)=\log(4\pi)-1$. Thus
$$
S_0=S(0)=\gamma_E+2-\log(4\pi),\qquad
\ell(v)=\log(2\pi)+\tfrac12\log(1-e^{-2v}).
$$
The even extension of $S$ follows from zero symmetry. The paper's screw function is $g(v)=S(v)-S_0$; its kernel is
$$
G_g(v,w)=g(v-w)-g(v)-g(-w)+g(0),
\qquad D_S(v):=G_g(v,v)=2[S_0-S(v)].
\tag{4}
$$
Theorem 1.3 identifies the screw property with RH. Here (2), including its endpoint, is used unconditionally; the screw property is not assumed in the identities below.

Differentiating the literal deterministic expression gives
$xA'(x)-A(x)=-\ell(\log x)$. Also $xF'(x)=1-\psi(x)/x$ almost everywhere. The prime-power arrivals cause no jumps in $F$, since their two contributions in (1) cancel at the birth. Consequently
$$
a=(D-\tfrac12)S-e^{-v/2}\ell(v)\quad(v>0).
$$
With every function extended by zero to negative ages, the distributional statement is
$$
\boxed{a_+=(D-\tfrac12)S_+
-e^{-v/2}\ell(v)\mathbf1_{v>0}-S_0\delta_0.}
\tag{5}
$$
The last term cannot be discarded. The logarithm in $\ell$ is locally integrable at zero. Formula (2) implies local absolute continuity of $S$ on the positive half-line and continuity at zero, sufficient for (5). Unconditionally $|S(v)|\le C e^{|v|/2}$ by the absolute zero sum.

## 2. The actual full-kernel weight

Put $f(z)=-\sqrt zK(z)$ and $h_t(v)=f(te^{|v|})$. The checked kernel identities are
$$
K'(z)=-\frac{b(z)}{2z},\qquad b'(z)+b(z)=\frac1{2z^{3/2}},
\qquad b(z)=2\operatorname{Dawson}(\sqrt z)-z^{-1/2}.
\tag{6}
$$
For positive ages define, with $z=te^v$,
$$
k_t(v)=h_t'(v)-\tfrac12h_t(v)=\tfrac12\sqrt z\,b(z),
$$
$$
\boxed{j_t(v)=-k_t'(v)-\tfrac12k_t(v)
=\tfrac14h_t(v)-h_t''(v)
=(z-1)\tfrac12\sqrt z\,b(z)-\tfrac14.}
\tag{7}
$$
These are the full kernels, not their leading small-argument approximations. The final equality follows directly by substituting (6).

The original arithmetic core has the exact source representation
$$
Q(t)=\sqrt t\sum_{n\ge2}\Lambda(n)K(tn)
=I_0(t)+\int_0^\infty a(v)k_t(v)\,dv,
\qquad I_0(t)=-\frac1{2\sqrt t}\int_0^t b(z)\,dz.
\tag{8}
$$
Here $I_0$ is the entire contribution from $0<x<1$, where $\psi(x)-x=-x$. For example, (8) follows by changing variables $x=e^v$ in
$Q(t)=\frac{\sqrt t}{2}\int_0^\infty(\psi(x)-x)b(tx)\,dx/x$.
At fixed $t$, the source is $O(e^{v/2})$ and $k_t,j_t=O_t(e^{-v})$, so all the integrals used here converge absolutely. No conditional cancellation of source charges is used.

Pair (5) with $k_t$. Integration by parts retains the initial value and yields
$$
Q(t)=I_0(t)-S_0k_t(0)+\int_0^\infty S(v)j_t(v)\,dv-I_\ell(t),
\quad I_\ell(t)=\int_0^\infty e^{-v/2}\ell(v)k_t(v)\,dv.
\tag{9}
$$
Since $\int_0^\infty j_t=k_t(0)-\frac12\int_0^\infty k_t$, this is equivalently
$$
\boxed{Q(t)=Q_{\rm det}(t)-\frac12\int_0^\infty j_t(v)D_S(v)\,dv,}
$$
$$
Q_{\rm det}(t)=I_0(t)-\frac{S_0}{2}\int_0^\infty k_t(v)\,dv-I_\ell(t).
\tag{10}
$$
Thus the deterministic density, archimedean logarithm and causal contact are explicit in the increment observation.

## 3. Full correlated Weil row and its cusp

For fixed $1/2<\beta<1$ retain the actual pair
$$
u(v)=\sqrt{2\beta}e^{-\beta v}\mathbf1_{v\ge0},\qquad
z_t=(\beta-D)h_t/\sqrt{2\beta},\qquad
u*\widetilde z_t=h_t.
\tag{11}
$$
Write $\mathcal W$ for the full Weil form and $\mathcal G_t$ for its archimedean-plus-pole row. The accepted source identity is
$\mathcal W(u,z_t)=\mathcal G_t+2Q(t)$.

There is a particularly short complete increment formula:
$$
\boxed{\mathcal W(u,z_t)
=\frac{S_0}{4}\int_{\mathbb R}h_t(v)\,dv
-\int_0^\infty j_t(v)D_S(v)\,dv.}
\tag{12}
$$
To prove it without differentiating an infinite zero sum pointwise, observe that
$$
(\tfrac14-D^2)h_t=j_t(|v|)\,dv-2h_t'(0+)\delta_0.
\tag{13}
$$
Pair this finite weighted measure with the absolutely convergent series (2). It is dominated by a constant times $\sum_\rho|\rho(1-\rho)|^{-1}$, since $j_t$ decays exponentially and $|\Re(\rho-1/2)|<1/2$. For each individual zero, integration by parts, including the contact in (13), gives
$$
\int e^{(\rho-1/2)v}(\tfrac14-D^2)h_t
=\rho(1-\rho)\int e^{(\rho-1/2)v}h_t(v)\,dv.
$$
This also proves absolute convergence after cancellation of the denominator. The usual explicit formula, in the already established source domain (11), therefore gives
$$
\mathcal W(u,z_t)=2\int_0^\infty S(v)j_t(v)\,dv-2S_0h_t'(0+).
\tag{14}
$$
Finally $\int_0^\infty j_t=h_t'(0+)+\frac14\int_0^\infty h_t$ gives (12). Equations (9) and (14) also give an exact check of every archimedean and contact term:
$$
\boxed{\mathcal G_t=-2I_0(t)-S_0h_t(0)+2I_\ell(t).}
\tag{15}
$$
No theta quotient norm is asserted. The previously proved source-space radical extension and common-cutoff repairs remain in force: $\mathcal W(u,z_t)=\mathcal W(u^\circ,z_t^\circ)$ after the exact $\Phi,\Phi'$ projection. Separate prime ports are not projection-invariant; all their mixed terms remain those in the linked radical-projection proof. Formula (12) evaluates the original full row, rather than dropping those terms.

## 4. Literal scalar feedback, including the positive birth correction

Keep the original definitions
$$
C(t)=(e^t-1)\sum_{j\ge2}e^{-tj}
\frac{\arctan(j^{-1/2})}{\sqrt j}\psi(j),\qquad b_t=\frac{t}{1-e^{-t}}.
$$
For $n\ge2$ let
$$
q_n(u)=\begin{cases}u^{-1/2}\arcsin\sqrt{u/n},&0<u<n,\\
\pi/(2\sqrt u),&u\ge n,\end{cases}
\quad q_n(0)=n^{-1/2},\quad U_n=q_n-n^{-1/2}.
$$
If $\mathcal I U_n$ is its integer linear interpolant, the exact positive correction is
$$
D_{\rm quad}(t)=b_t t\sum_{n\ge2}\Lambda(n)
\int_0^\infty e^{-tu}[\mathcal I U_n(u)-U_n(u)]\,du>0.
\tag{16}
$$
The zero initial value $U_n(0)=0$ and the complete prime-power cusps are retained. The established quadrature identity now becomes
$$
\boxed{E(e^{-t})=b_tQ_{\rm det}(t)
-\frac{b_t}{2}\int_0^\infty j_t(v)D_S(v)\,dv-C(t)+D_{\rm quad}(t).}
\tag{17}
$$
An equivalent full-row form is
$$
E(e^{-t})=\frac{b_tS_0}{8}\int_{\mathbb R}h_t
-\frac{b_t}{2}\int_0^\infty j_tD_S
-\frac{b_t}{2}\mathcal G_t-C(t)+D_{\rm quad}(t).
\tag{18}
$$
In particular neither the return $C$ nor the interpolation correction has been absorbed into a presumed screw positivity bound.

## 5. What the signed observation costs

The exact kernel (7) has
$$
j(z)=\tfrac14-\tfrac32z+O(z^2)\quad(z\downarrow0),\qquad
j(1)=-\tfrac14,\qquad
j(z)=\frac1{8z}+O(z^{-2})\quad(z\to\infty).
\tag{19}
$$
Thus for all sufficiently small $t$ its age weight has both signs, with a negative value exactly at $v=\log(1/t)$. No assertion about the exact number of sign changes is needed. With $V=\log(1/t)$,
$$
\int_0^\infty(j_t)_+\,dv=\frac V4+O(1),\qquad
\int_0^\infty(j_t)_-\,dv=O(1),\qquad
\int_{\mathbb R}h_t(v)\,dv=2V+O(1).
\tag{20}
$$
For the first two estimates change variables to $z=te^v$. The difference $j(z)-1/4$ is integrable against $dz/z$ near zero, and $j(z)$ is integrable against that measure at infinity; its negative part vanishes on a fixed interval next to zero. The last estimate uses $f(z)=1+O(\sqrt z)$ at zero and $f(z)=O(1/z)$ at infinity. These estimates use the full kernel throughout the moving transition.

Even under RH, when the positive zero weights give $|S(v)|\le S_0$ and $0\le D_S(v)\le4S_0$, the direct lower estimate from (12) is only
$$
\mathcal W(u,z_t)\ge-\frac{S_0}{2}\log(1/t)-O(1),
\quad Q(t)\ge-\frac{S_0}{4}\log(1/t)-O(1).
\tag{21}
$$
Here $\mathcal G_t=O(1)$ is the already proved full archimedean cancellation. This is a precise loss in the elementary diagonal budget, not an asymptotic assertion that the actual row attains the bound. Constant-scale control requires coherent cancellation inside the increment integral.

There is also an exact test of positivity on the entire screw cone. For any $\omega>0$, take $S_\omega(v)=S_0\cos(\omega v)$. Its increment kernel is
$$
G_\omega(v,w)=S_0[(\cos\omega v-1)(\cos\omega w-1)
+\sin\omega v\sin\omega w],
$$
which is positive semidefinite and has the same endpoint normalization. The observation in (12), applied to this kernel, equals
$$
S_0(\omega^2+1/4)\widehat h_t(\omega),
\quad\widehat h_t(\omega)=\int_{\mathbb R}e^{-i\omega v}h_t(v)\,dv.
\tag{22}
$$
The established full-kernel scaling $h_t(Vy)\to\mathbf1_{|y|<1}$ in $L^1$ gives
$V^{-1}\widehat h_t(\xi/V)\to2\sin\xi/\xi$. Hence (22) is strictly negative for $\omega=3\pi/(2V)$ and strictly positive for $\omega=\pi/(2V)$, once $t$ is sufficiently small. This is an analytic all-history test, without prime or zero truncation.

The single-frequency examples are not replacements for the actual zeta kernel. They show precisely that global screw positivity, even with fixed $S_0$, does not make this particular observation a positive functional. The useful output is the exact signed budget (17)–(18): its uncontrolled term is the literal weighted increment integral with weight (7), while the density, causal contact, full archimedean row, return and positive birth correction are all explicit. The existing radical projection repairs its domain and pole coordinates; it does not change that full cross-row budget.

## Dependencies and formal scope

The [Matsumoto–Suzuki source map](../goldbach/goldbach-literal-successor-counting-transport.md#primary-literature-connection-and-its-limits), [complete scaling kernel](../successor-and-division/successor-feedback-kernel-scaling.md), [correlated cutoff](../theta-and-heat/coherent-core-theta-domain-and-cutoff.md) and [radical projection](actual-core-Weil-arch-row-radical-projection.md) fix the original row and all contacts. The [positive birth quadrature](../successor-and-division/actual-integer-birth-positive-quadrature.md) retains its correction in the scalar readout. This is a written identity and a general screw-cone functional counterexample, not a counterexample to the actual zeta screw property. The [factorial-ground configuration decomposition](../factorial-and-renewal/factorial-ground-screw-increment-consumer.md) gives another positive square with its separate full residual; neither construction signs the remaining actual observation. No Lean formalization of these screw readouts is asserted.
