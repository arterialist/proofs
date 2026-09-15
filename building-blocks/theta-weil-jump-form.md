# The actual Weil form and a sharp theta jump inequality

This is a written mathematical reduction. It does not prove the required lower bound, RH, or a Lean theorem. The construction retains the complete prime-power sum and both pole evaluations.

## 1. Normalization and domain

Use the positive, even, smooth theta kernel

$$
\Phi(u)=\sum_{n\ge1}
\left(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2}\right)
e^{-\pi n^2e^{2u}},
\qquad
\widehat\Phi(t)=\int_{\mathbb R}\Phi(u)e^{itu}\,du
=\xi(\tfrac12+it).
$$

This is the normalization of the [published theta kernel](theta-derivative-kernel-logconcavity.md). In particular

$$
M=\int e^{u/2}\Phi(u)\,du
=\int\cosh(u/2)\Phi(u)\,du
=\xi(1)=\tfrac12.
$$

For $f\in C_c^\infty(\mathbb R;\mathbb C)$, put
$C_f(a)=\int f(u+a)\overline{f(u)}\,du$. The full Weil form is

$$
Q(f)=B(f)+\frac1{2\pi}\int_{\mathbb R}
\left[\Re\psi(\tfrac14+it/2)-\log\pi\right]|\widehat f(t)|^2dt
-2\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}\Re C_f(\log q),
$$
$$
B(f)=2\Re\left(\int e^{u/2}f(u)du\,
\overline{\int e^{-u/2}f(u)du}\right).
$$

Here $\psi$ in the multiplier denotes the digamma function. The sum over $q$ includes every prime power; terms with $\Lambda(q)=0$ vanish.

We also use this form on finite linear combinations of theta derivatives and on functions obtained by multiplying $\Phi$ by fixed derivative scores and their products. These insertions are justified as follows. For each fixed derivative order, theta decay gives an exponential-polynomial factor times $\exp(-c e^{2|u|})$; its ratio to $\Phi$ grows at most exponentially in $|u|$. Every fixed exponential-weighted Schwartz seminorm is finite. Correlations of two such functions decay faster than $e^{-Na}$ for every fixed $N$. Thus the complete prime sum, both pole moments, and the archimedean integral converge absolutely. Near $a=0$, the square-difference integrands below are $O(a^2)$, while their kernel is $O(1/a)$.

Smooth cutoff approximations converge in these weighted seminorms. On the zero side, repeated integration by parts gives uniform arbitrarily high polynomial decay in the strip $|\Im t|\le1/2$. Together with the unconditional zero count $N(T)=O(T\log T)$, this justifies passing the explicit formula through the cutoff limit.

An explicit sufficient extension domain is the space of smooth functions for which $e^{A|u|}f^{(j)}(u)\in L^1\cap L^\infty$ for every $A>0$ and every derivative order $j$. The insertions above belong to this space.

## 2. An unconditional radical identity

The polarized explicit formula evaluates one Fourier factor at
$z_\rho=(\rho-1/2)/i$ for each nontrivial zeta zero, counted with multiplicity. Since

$$
\widehat{\Phi^{(j)}}(z)=(-iz)^j\xi(\tfrac12+iz),
$$

every term vanishes when the first factor is $\Phi^{(j)}$. The preceding domain argument therefore gives

$$
Q(\Phi^{(j)},g)=0\qquad(j\ge0)
$$

for compact smooth $g$, and for the extended insertions just specified. This uses the defining zeros of $\xi$, not their location on the critical line. Multiplicities do not alter the vanishing.

## 3. Two positive jump energies

Set

$$
r(a)=\frac{e^{-a/2}}{1-e^{-2a}},\qquad
\Delta_a h(u)=h(u+a)-h(u),
$$
$$
E_{\rm arch}(h)=\int_0^\infty r(a)
\int_{\mathbb R}\Phi(u+a)\Phi(u)|\Delta_a h(u)|^2du\,da,
$$
$$
E_{\rm prime}(h)=\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
\int_{\mathbb R}\Phi(u+\log q)\Phi(u)|\Delta_{\log q}h(u)|^2du,
$$
$$
E_{\rm pole}(h)=\int_0^\infty2\cosh(a/2)
\int_{\mathbb R}\Phi(u+a)\Phi(u)|\Delta_a h(u)|^2du\,da.
$$

All three energies are nonnegative. Write $E_{\rm jump}=E_{\rm arch}+E_{\rm prime}$. Subtracting
$\Re Q(\Phi,\Phi|h|^2)=0$ from $Q(\Phi h)$ gives the exact identity

$$
\boxed{Q(\Phi h)=E_{\rm jump}(h)-E_{\rm pole}(h).}
$$

For the archimedean term, use the digamma representation

$$
A(f)=-(\gamma+\log\pi)\|f\|_2^2+
\int_0^\infty\frac{2e^{-2a}\|f\|_2^2-2e^{-a/2}\Re C_f(a)}{1-e^{-2a}}da.
$$

The diagonal terms cancel. Each remaining correlation difference is exactly the corresponding square difference above. The pole kernel has the opposite sign after this subtraction. No pole moment has been set to zero by assumption.

Define the probability measure and bounded odd function

$$
d\nu(u)=M^{-1}\cosh(u/2)\Phi(u)du,
\qquad \tau(u)=\tanh(u/2),\qquad \nu\tau=0.
$$

Using $\cosh((u-v)/2)=\cosh(u/2)\cosh(v/2)(1-\tau(u)\tau(v))$, one obtains

$$
\boxed{E_{\rm pole}(h)=2M^2
\left(\operatorname{Var}_\nu(h)+|\nu(\tau h)|^2\right).}
$$

The jump form is reversible with respect to $\nu$. Its continuous jump rate from $u$ to $v$ is
$M\Phi(v)r(|v-u|)/\cosh(u/2)\,dv$; at each $v=u\pm\log q$ it has rate
$M\Phi(v)\Lambda(q)/(\cosh(u/2)\sqrt q)$. The continuous total rate is infinite near zero, although the square-difference energy converges. This auxiliary real-variable form is distinct from the absorbing integer division process.

## 4. The score pays the odd pole term

Put $\lambda=2M^2=1/2$, $s=\Phi'/\Phi$, and

$$
R(h)=E_{\rm jump}(h)-\lambda\operatorname{Var}_\nu(h).
$$

Integration by parts gives $\nu s=0$ and $\nu(\tau s)=-1/2$. Polarizing the radical identity for $\Phi'$ yields

$$
R(h,s)=-\frac\lambda2\nu(\tau h),\qquad
R(s,h)=-\frac\lambda2\overline{\nu(\tau h)},\qquad
R(s)=\frac\lambda4,
$$

with the polarized form linear in its first argument. Hence

$$
Ph=h+2\nu(\tau h)s
$$

satisfies $\nu(\tau Ph)=0$, $P^2=P$, and

$$
\boxed{R(Ph)=R(h)-\lambda|\nu(\tau h)|^2=Q(\Phi h).}
$$

Consequently the ordinary sharp Poincare inequality

$$
\boxed{E_{\rm jump}(h)\ge\tfrac12\operatorname{Var}_\nu(h)}
\tag{*}
$$

would imply the full pole comparison. It suffices to prove (*) for compact smooth $h$: cutoffs of $s$, with the compact part of $Ph$, converge in $L^2(\nu)$ and in jump energy, so (*) extends to the needed $Ph$. Conversely full Weil positivity immediately implies (*).

Since $\Phi>0$ is smooth, every compact smooth Weil test $f$ can be written $f=\Phi h$ with compact smooth $h$. By the classical Weil criterion, (*) for all such $h$ is therefore equivalent to RH. This is a written equivalence; its lower-bound premise remains unproved.

## 5. The required constant is an unconditional upper limit

For every $j\ge1$, put

$$
h_{2j}=\frac{\Phi^{(2j)}}\Phi-2^{-2j}.
$$

These are even, have $\nu h_{2j}=0$, and have finite norm and energy. Integration by parts gives the displayed mean, while the derivative radical identity gives

$$
E_{\rm jump}(h_{2j})=E_{\rm pole}(h_{2j})
=\tfrac12\|h_{2j}\|_{L^2(\nu)}^2.
$$

They are nontrivial and linearly independent. A linear dependence would give a constant-coefficient differential equation for $\Phi$; Fourier transformation would force a nonzero polynomial to vanish on an interval where $\xi(1/2+it)\ne0$.

Cutoffs approximate these quotients in norm and energy. Thus, if

$$
\gamma_{\rm jump}=\inf_{h\in C_c^\infty,\ \operatorname{Var}_\nu(h)>0}
\frac{E_{\rm jump}(h)}{\operatorname{Var}_\nu(h)},
$$

then unconditionally $0\le\gamma_{\rm jump}\le1/2$, and

$$
\boxed{\mathrm{RH}\quad\Longleftrightarrow\quad\gamma_{\rm jump}=1/2.}
$$

In particular, the superficially sufficient bound
$E_{\rm jump}\ge\tfrac12(1+\nu\tau^2)\operatorname{Var}_\nu$
is false. The score projection is what avoids demanding this impossible stronger gap.

## 6. A failed arithmetic path comparison

For a pole displacement $a>0$, write $n=\lfloor e^a\rfloor$,
$a=\log n+\varepsilon$, and $0\le\varepsilon<\log(1+1/n)$.
Factor $n$ into its maximal prime-power blocks, traverse their logarithmic jumps, and append the short archimedean jump $\varepsilon$. This retains an actual division history and its successor cell.

If $m_n=\omega(n)+1$, the path comparison has the exact positive defect
$m_n\sum_i|d_i|^2-|\sum_i d_i|^2=\sum_{i<j}|d_i-d_j|^2$.
Its load on the last archimedean edge is

$$
C_{\rm arch}(z,\varepsilon)=\frac1{r(\varepsilon)}
\sum_{\varepsilon<\log(1+1/n)}m_n
2\cosh((\log n+\varepsilon)/2)
\frac{\Phi(z-\log n)}{\Phi(z)}.
$$

The sum is finite for fixed $\varepsilon>0$. But already $n=2$, for
$0<\varepsilon<\log(3/2)$, forces unbounded congestion, because

$$
\frac{\Phi(z-\log2)}{\Phi(z)}
\sim2^{-9/2}\exp\left(\frac{3\pi}{4}e^{2z}\right)
\qquad(z\to+\infty).
$$

This excludes that particular global bounded-congestion proof. It does not exclude other couplings. Its nonzero path defect also cannot be discarded in a constant-one comparison compatible with the nonconstant equality directions above.

## 7. The actual prime return law

Let $K_u$ be the finite prime destination measure, including jumps in both directions:

$$
K_u(f)=\frac1{2\cosh(u/2)}\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
\bigl[\Phi(u-\log q)f(u-\log q)+\Phi(u+\log q)f(u+\log q)\bigr].
$$

Define probabilities $d\mu_\pm(v)=2e^{\pm v/2}\Phi(v)dv$. Ordinary PNT gives

$$
K_u(f)\longrightarrow\tfrac12\mu_-(f)\quad(u\to+\infty),
\qquad K_u(f)\longrightarrow\tfrac12\mu_+(f)\quad(u\to-\infty).
\tag{7.1}
$$

This follows from an exact arithmetic identity. Write $F=\Phi f$,
$E(t)=\psi(t)-t$, and $\eta(t)=E(t)/t$, where $\psi$ now denotes the Chebyshev prime-power sum. Then

$$
\begin{aligned}
&e^{-u/2}\sum_{q\ge2}\Lambda(q)q^{-1/2}F(u-\log q)
-\int_{\mathbb R}e^{-v/2}F(v)dv\\
&=e^{-u/2}F(u)-\int_u^\infty e^{-v/2}F(v)dv
+\int_{-\infty}^u\eta(e^{u-v})e^{-v/2}
\bigl(F'(v)+F(v)/2\bigr)dv.
\end{aligned}
\tag{7.2}
$$

Integration by parts against $d\psi$, followed by $v=u-\log t$, proves this formula. Its first term retains the endpoint $E(1)=-1$.

For each $A\ge0$, set
$\|f\|_{A,1}=\sup_v e^{-A|v|}(|f(v)|+|f'(v)|)$ and
$\omega(T)=\sup_{t\ge T}|\psi(t)/t-1|$. There are constants $C_A,c>0$ such that

$$
|K_u(f)-\tfrac12\mu_-(f)|
\le C_A\|f\|_{A,1}
\{\omega(e^{u/2})+e^{-u}+e^{-c e^u}\}\qquad(u\ge2).
\tag{7.3}
$$

To prove it, split the last integral in (7.2) at $v=u/2$; use the PNT error below that point and theta decay above it. The upward destination sum is superexponentially small. Thus every displacement tail and every prime power is retained. Reflection gives the other end.

The normalized destination laws converge weakly and in every finite Wasserstein distance. They cannot converge in total variation to $\mu_\pm$: each is atomic, whereas the limits have continuous densities. Another exact identification is

$$
K_u(e^{zv})\to\xi(z)\quad(u\to+\infty),\qquad
K_u(e^{zv})\to\xi(z+1)\quad(u\to-\infty),
$$

locally uniformly in $z\in\mathbb C$. This does not locate those zeros.

With $\mathcal G=-\mathcal L$ denoting the Markov-sign generator, its archimedean part on bounded $C^1$ tests satisfies

$$
\mathcal G_{\rm arch}f(u)=
\frac{e^{-u}}{2(1+e^{-u})}\bigl(\mu_+(f)-f(u)\bigr)
+O_f(e^{-3u}+e^{-c e^{2u}}).
\tag{7.4}
$$

Expand $r(a)=e^{-a/2}+O(e^{-5a/2})$ for $a\ge1$, and keep the compensated difference for $a<1$. For exponentially growing smooth tests the error also contains $O_f(e^{-3u}|f(u)|)$. Infinite local activity is not replaced by a finite rate, and increasingly rapid bounded smooth oscillations are not covered without derivative control.

## 8. Closed form and the essential-spectrum threshold

Take the closure of the smooth compact core in
$\|h\|_{L^2(\nu)}^2+E_{\rm jump}(h)$. The form is closable: an $L^2$-convergent subsequence converges almost everywhere, also along all countably many prime-power translates outside a common null set. Fatou's lemma for the positive edge measure then identifies the limit of an energy-Cauchy sequence. Normal contractions preserve the energy bound, so the closure is a regular symmetric Dirichlet form. Let $\mathcal L\ge0$ be its selfadjoint generator.

Smooth cutoffs of $1$ converge in $L^2(\nu)$ with energy tending to zero. For small archimedean jumps this follows from the uniform Lipschitz cutoff bound and $r(a)a^2\in L^1(0,1)$; for the remaining jumps it follows from theta decay and the complete convergent prime sum. Thus $1$ is in the form domain with zero energy, and the finite-measure semigroup is conservative. The strictly positive archimedean pair kernel makes constants the entire zero eigenspace.

Conjugate by $H=\sqrt m\,h$, where $m(u)=2\cosh(u/2)\Phi(u)$. The prime form is

$$
E_{\rm prime}(h)=\langle H,(b-K_{\rm p})H\rangle,
\qquad b(u)=K_u(1)\to\lambda=\tfrac12.
$$

The off-diagonal operator is the sum of weighted shifts and their adjoints with coefficients

$$
b_q(u)=\frac{\Lambda(q)}{\sqrt q}
\frac{\sqrt{\Phi(u)\Phi(u+\log q)}}
{2\sqrt{\cosh(u/2)\cosh((u+\log q)/2)}}.
$$

Their suprema are summable. Indeed, at least one endpoint has absolute value at least $(\log q)/2$, and theta decay beats the resulting sum over all integers. More precisely, with $P_R=1_{[-R,R]}$,

$$
\|K_{\rm p}-P_RK_{\rm p}P_R\|\le\Gamma_R,
\qquad
\Gamma_R\le C(1+(R+1)e^R)e^{-c e^{2R}}\to0.
\tag{8.1}
$$

It follows for every form-domain function supported outside $[-R,R]$, with no frequency restriction, that

$$
E_{\rm jump}(h)\ge
\bigl[\lambda-\sup_{|u|>R}|b(u)-\lambda|-\Gamma_R\bigr]\|h\|_{L^2(\nu)}^2.
\tag{8.2}
$$

The positive archimedean energy is retained. The deficit tends to zero by (7.3), but its sign is not controlled. Section 11 strengthens this estimate to a superexponentially small deficit, using exact prime–archimedean cancellation without a PNT estimate.

There is also an exact IMS identity. Choose a smooth partition $\chi_R^2+\eta_R^2=1$ that equals $(1,0)$ on $[-R,R]$, equals $(0,1)$ outside $[-R-1,R+1]$, and has uniformly bounded derivatives. On every edge $(u,v)$, its error is the original conductance times

$$
\bigl[(\chi_R(v)-\chi_R(u))^2+(\eta_R(v)-\eta_R(u))^2\bigr]
\Re(h(u)\overline{h(v)}).
$$

Thus $E(\chi_Rh)+E(\eta_Rh)-E(h)=\langle H,K_RH\rangle$, where
$\|K_R\|\to0$ superexponentially. The squared partition difference removes the archimedean diagonal singularity, and (8.1) bounds all crossing prime powers. This error is signed. At fixed $R$, its prime part need not be compact: a nonzero weighted translation at displacement $\log2$ survives between suitable small intervals. The archimedean IMS part is Hilbert–Schmidt.

Local compactness follows from the small-jump kernel. For a fixed compact localization $g$, energy and norm control

$$
\int_0^1\frac{\|g(\cdot+a)-g\|_2^2}{a}da.
$$

Its Fourier multiplier grows as $\log(2+|t|)$, which yields local $L^2$ compactness. Therefore a unit weakly-null sequence of bounded energy has vanishing local mass. Equation (8.1) implies its $K_{\rm p}$ quadratic values tend to zero. The exact identity (11.1), together with the global archimedean lower bound $a(t)\ge a(0)$, then gives limiting lower energy at least $\lambda$: the remaining lower-order term is $a(0)\int w|H|^2$, and it tends to zero by local mass convergence and $w(u)\to0$. Thus a PNT estimate is not required for this essential-spectrum lower bound. The return law in section 7 remains a separate arithmetic statement.

This proves $\inf\sigma_{\rm ess}(\mathcal L)\ge\lambda$ directly, without imposing the additional Feller hypotheses of a general nonlocal Persson theorem. The independent even derivative-score eigenfunctions from section 5 belong to the operator domain by polarization and cutoff approximation. Their infinite multiplicity gives the reverse bound. Consequently

$$
\boxed{\inf\sigma_{\rm ess}(\mathcal L)=\tfrac12,
\qquad 0<\gamma_{\rm jump}\le\tfrac12.}
\tag{8.3}
$$

Zero is isolated and simple. Every spectral subspace below $1/2-\delta$, for $\delta>0$, is finite-dimensional. Possible discrete eigenvalues in $(0,1/2)$ remain uncontrolled; they can only accumulate at $1/2$. Excluding them is exactly the unresolved sharp-gap condition.

## 9. The pointwise curvature route fails

For the full actual jump kernel $q(u,dv)$, define

$$
\Gamma(f,g)(u)=\tfrac12\int(f(v)-f(u))(g(v)-g(u))q(u,dv),
\qquad
\Gamma_2(f)=\tfrac12\mathcal G\Gamma(f)-\Gamma(f,\mathcal Gf).
$$

The equality mode $h_2=\Phi''/\Phi-1/4$ satisfies
$\mathcal Gh_2=-\lambda h_2$, so exactly

$$
\Gamma_2(h_2)=\lambda\Gamma(h_2)+\tfrac12\mathcal G\Gamma(h_2).
\tag{9.1}
$$

Theta asymptotics give $h_2(u)\sim4\pi^2e^{4|u|}$. The weighted return law applies to $h_2,h_2^2$, and then to $\Gamma(h_2)$. It follows that

$$
\Gamma(h_2)(u)\sim\tfrac14h_2(u)^2\sim4\pi^4e^{8|u|},
\qquad
\frac{\mathcal G\Gamma(h_2)(u)}{\Gamma(h_2)(u)}\to-\tfrac12.
$$

The prime destination term remains bounded while the departure term grows. Equation (7.4), with its departure term retained, makes the archimedean ratio vanish. Therefore

$$
\boxed{\frac{\Gamma_2(h_2)(u)}{\Gamma(h_2)(u)}\to\tfrac14
\qquad(|u|\to\infty).}
\tag{9.2}
$$

All required functions and generator expressions lie in $L^2(\nu)$: their growth is at most exponential, and $\nu$ has superexponential tails. Differentiating the prime sums is justified by Chebyshev's bound on unit intervals of $\log q$ and theta decay. The compensated archimedean differences handle the diagonal singularity.

This also yields compact smooth counterexamples to every pointwise assertion $\Gamma_2\ge K\Gamma$ with $K>1/4$. Fix a sufficiently distant point where (9.2) gives a strict violation, and cut off $h_2$ farther out. Uniform exponential derivative bounds permit dominated convergence of $\Gamma$ and both iterated terms of $\Gamma_2$ at that point, including the full double prime sums. Continuity preserves the violation on a neighborhood.

The integrated equality nevertheless remains
$\int\Gamma_2(h_2)d\nu=\lambda\int\Gamma(h_2)d\nu$, since
$\int\mathcal G\Gamma(h_2)d\nu=0$. Thus the tail curvature deficit has compensation elsewhere. Failure of the pointwise curvature method does not disprove the sharp Poincare inequality.

## 10. Scope of finite-observation approaches

A finite-history obstruction also holds after the score projection, with the proof given below. Its precise statement is that no nonzero positive integral of squares of fixed functionals

$$
Lh=\sum_{i=1}^{m}c_i h(x_i)+a\nu h+b\nu(\tau h),\qquad m<\infty,
$$

can be universally dominated by $Q(\Phi h)$ on compact smooth tests. The number of evaluations may vary without a uniform bound, and the positive measure need not have finite mass. Data must be independent of $h$. This includes finite differences or evaluations of $Ph$.

The proof uses compact cutoffs of all null scores $s_j=\Phi^{(j)}/\Phi$. Fatou's lemma and a countable common null set force every observation to annihilate every score. The resulting analytic identity is

$$
\sum_i\frac{c_i}{\Phi(x_i)}\Phi(x_i+t)+a\cosh(t/2)-b\sinh(t/2)=0.
$$

Two-sided theta decay forces $a=b=0$. Fourier transformation near a point where $\Xi\ne0$, followed by a Vandermonde argument, eliminates the remaining finite translates. The actual Weil form is nonzero, as seen from a highly modulated smooth bump whose support has length below $\log2$, so an exact factorization in this class is impossible.

For the ordinary gap form $R$, there is a precise qualification. If positive squares of observations of the same enlarged type are universally dominated by $R$, annihilation of the projected null scores gives

$$
\sum_i\frac{c_i}{\Phi(x_i)}\Phi(x_i+t)
+a\cosh(t/2)-2L_0(s_1)\sinh(t/2)=0,
\qquad L_0h=\sum_i c_i h(x_i).
$$

Hence $a=0$ and $L_0=0$; only $b\nu(\tau h)$ can remain. Integrating these observations leaves $c|\nu(\tau h)|^2$, where $c=\int|b|^2\le\lambda$. The last bound follows by testing cutoffs of $s_1$, since $R(s_1)=\lambda/4$ and $\nu(\tau s_1)=-1/2$. Thus allowing the two pole moments adds no finite-history component to a dominated positive form. It does not assert that such a domination exists.

These exclusions concern fixed finite observations and the stated pole moments. They leave genuinely infinite-dimensional quotients, global phase integrals, and test-dependent optimizations outside their scope. They do not settle RH.

## 11. Exact tail cancellation without a PNT remainder

Write $\mathcal A(f)$ for the archimedean quadratic form with multiplier

$$
a(t)=\Re\psi(\tfrac14+it/2)-\log\pi,
\qquad a_0=a(0)<0,
$$

and write $A\Phi$ for the action of that multiplier on $\Phi$. The two pole moments satisfy the exact algebraic identity

$$
B(\Phi h)=\lambda\bigl(|\nu h|^2-|\nu(\tau h)|^2\bigr).
$$

Substituting this in the ground-state identity cancels both moments and yields, initially on the compact smooth core,

$$
\boxed{
E(h)-\lambda\|h\|_{L^2(\nu)}^2
=\mathcal A(\Phi h)
-2\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
       \Re C_{\Phi h}(\log q).
}
\tag{11.1}
$$

Every prime power remains in the sum. For $H=\sqrt m\,h$, put
$w=\Phi/(2\cosh(u/2))$, so $\Phi h=\sqrt w\,H$. The sum on the right is precisely $\langle H,K_{\rm p}H\rangle$.

The digamma partial-fraction expansion gives

$$
a(t)-a_0
=\sum_{n\ge0}
\frac{(t/2)^2}
{(n+\tfrac14)((n+\tfrac14)^2+(t/2)^2)}
\ge0.
\tag{11.2}
$$

This uses the classical series [DLMF 5.7.6](https://dlmf.nist.gov/5.7.E6). Consequently

$$
E(h)\ge
\lambda\|H\|_2^2+a_0\int w(u)|H(u)|^2du
-\langle H,K_{\rm p}H\rangle.
\tag{11.3}
$$

The identity extends to the closed form domain. Indeed, (11.1) identifies the nonnegative Fourier form with multiplier $a-a_0$, after multiplication by $\sqrt w$, as $E$ plus bounded quadratic forms. A sequence Cauchy in the original form norm is therefore Cauchy in this Fourier form norm. Closedness of the nonnegative Fourier multiplier gives the identity at its limit. In particular (11.3) requires no regularity assumption on a form-domain function.

For $h$ supported outside $[-R,R]$, (8.1) now gives

$$
\boxed{
E(h)\ge(\lambda-\delta_R)\|h\|_{L^2(\nu)}^2,\qquad
\delta_R=|a_0|\sup_{|u|>R}w(u)+\Gamma_R
\le C(1+(R+1)e^R)e^{-c e^{2R}}.
}
\tag{11.4}
$$

This estimate is uniform over all frequencies. It retains the full archimedean form, including its infinite local activity. It uses the actual theta radical identity and theta decay, rather than a prime-counting error bound. It does not assert that $\delta_R=0$.

The same cancellation explains the prime departure rate more precisely. Polarizing $Q(\Phi,g)=0$ against compact tests gives the pointwise identity

$$
\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
[\Phi(u+\log q)+\Phi(u-\log q)]
=A\Phi(u)+\cosh(u/2),
$$

and hence

$$
\boxed{2\cosh(u/2)\,[b(u)-\lambda]=A\Phi(u).}
\tag{11.5}
$$

For each fixed integer $J\ge1$, the digamma integral and the complete theta moments yield

$$
A\Phi(u)=
-\sum_{j=0}^{J-1}\xi(2j+1)e^{-(2j+1/2)|u|}
+O_J(e^{-(2J+1/2)|u|}),
$$

$$
\boxed{
b(u)=\frac12-
\frac{\displaystyle\sum_{j=0}^{J-1}\xi(2j+1)e^{-(2j+1)|u|}}
{1+e^{-|u|}}
+O_J(e^{-(2J+1)|u|}).
}
\tag{11.6}
$$

To justify this expansion, split the compensated digamma integral at a fixed positive displacement, such as $a=1$. The local piece is superexponentially small by uniform theta derivative bounds near $u$. On $a\ge1$, expand
$r(a)=\sum_{j=0}^{J-1}e^{-(2j+1/2)a}
+O_J(e^{-(2J+1/2)a})$.
The downward integral is evaluated after $v=u-a$; extending its endpoint to infinity changes it by a superexponentially small term. Its full moment is
$\int e^{(2j+1/2)v}\Phi(v)\,dv=\xi(2j+1)$.
The upward integral and the remaining diagonal terms are superexponentially small. Evenness handles the negative end. The constants may depend on $J$; no convergent infinite asymptotic series is asserted.

In particular,

$$
b(u)=\frac12-\frac12e^{-|u|}
+\frac12e^{-2|u|}
-\bigl(\tfrac12+\xi(3)\bigr)e^{-3|u|}
+O(e^{-4|u|}).
$$

The leading deficit of the prime departure rate is paid by the archimedean tail in the complete form. Equations (11.1)–(11.4) express that cancellation without truncating an asymptotic series.

## 12. Exact negative index, including compact-test realization

The finite-zero inertia and parity statements have classical predecessors: [Bombieri, *Remarks on Weil's quadratic functional in the theory of prime numbers I*, Lemma 10 and Theorems 8–9](https://www.bdim.eu/item?fmt=pdf&id=RLIN_2000_9_11_3_183_0) count distinct nonreal conjugate pairs; repeated zeros add null directions to his repeated-coordinate matrices. Compact zero isolation is also supplied by Yoshida's Lemma 1, used explicitly in [Suzuki, proof of Theorem 4.4](https://arxiv.org/pdf/2301.00421). The proof below implements isolation using the actual theta transform and then transports the index to this weighted jump operator. It does not infer the whole-line conclusion from a fixed finite-window spectral truncation.

Let $\mathcal Z$ be the set of distinct zeros of
$\Xi(z)=\xi(1/2+iz)$, and let $m_z$ be their multiplicities. On
$\ell^2(\mathcal Z,m)$, the map $(Jv)_z=v_{\bar z}$ is a selfadjoint unitary. The polarized explicit formula reads

$$
Q(f,g)=\langle\widehat f|_{\mathcal Z},
                    J(\widehat g|_{\mathcal Z})\rangle_{\ell^2(\mathcal Z,m)}.
\tag{12.1}
$$

Every real zero contributes a positive block. Every distinct nonreal conjugate pair contributes the block

$$
m_z\begin{pmatrix}0&1\\1&0\end{pmatrix},
$$

which has one negative direction. Multiplicity rescales this block; it does not create additional evaluation coordinates. This gives an upper bound for the negative index of $Q$ on compact smooth tests.

The reverse bound requires controlling all unselected zeros. For a chosen zero $z_j$ of exact multiplicity $m_j$, set

$$
c_j=\Xi^{(m_j)}(z_j)/m_j!\ne0,\qquad
I_j(z)=\frac{\Xi(z)}{c_j(z-z_j)^{m_j}}.
$$

The singularity is removable and
$I_j(z_k)=\delta_{jk}$ at every distinct zero. The actual theta representation makes $\Xi$, with all derivatives, Schwartz on every fixed horizontal strip. Each $I_j$ has the same property: division is harmless outside a fixed compact set, and removability handles that compact set. Contour shifting in its inverse Fourier transform $f_j$ gives, for every fixed $B,N,k$,

$$
\sup_u e^{B|u|}(1+|u|)^N|f_j^{(k)}(u)|<\infty.
$$

For an even smooth physical cutoff $\chi_R$, put $f_{j,R}=\chi_R f_j$. Weighted integration by parts then gives, for every fixed $K$,

$$
\sup_{|y|\le1/2}(1+|t|)^K
\left|\widehat f_{j,R}(t+iy)-I_j(t+iy)\right|\longrightarrow0.
$$

All actual zeros lie in $|\Im z|<1/2$, and their unconditional count, including multiplicities, is $O(T\log T)$. Therefore

$$
\sum_{z\in\mathcal Z}m_z
|\widehat f_{j,R}(z)-I_j(z)|^2\longrightarrow0.
\tag{12.2}
$$

For any finite collection of nonreal conjugate pairs, the vectors $I_z-I_{\bar z}$ have a negative-definite diagonal Weil Gram matrix with entries $-2m_z$. Equation (12.2) preserves that strict negativity for sufficiently large compact cutoffs. It follows that

$$
\operatorname{ind}_-(Q|_{C_c^\infty})
=\#\{\{z,\bar z\}:z\in\mathcal Z,\ z\notin\mathbb R\},
\tag{12.3}
$$

where either side may be infinite. The argument uses $f_{j,R}/\Phi$ only after making the numerator compact. It does not require a domain assertion for the uncut $f_j/\Phi$; that stronger domain assertion is not needed for the index proof here.

To transfer this index to the actual operator, use

$$
Q(\Phi h)=R(Ph)=R(h)-\lambda|\beta(h)|^2,\qquad
\beta(h)=\nu(\tau h).
$$

A negative compact Weil space maps injectively under $P$ to a negative $R$-space in the closed form domain. Conversely, approximate any finite-dimensional negative $R$-space by the compact form core. Its Gram matrix remains strictly negative, and $Q(\Phi h)\le R(h)$ gives a compact negative Weil space of the same dimension. Thus the two negative indices are equal. Constants are $R$-null, and on their orthogonal complement $R$ is the form of $\mathcal L-\lambda$. The spectral theorem proves

$$
\boxed{
\dim_{\mathbb C}\operatorname{Ran}1_{(0,1/2)}(\mathcal L)
=\#\{\text{distinct nonreal conjugate pairs of }\Xi\text{ zeros}\}.
}
\tag{12.4}
$$

There is also an exact parity count. Since $\Xi$ is even and real entire, its off-line zeros occur in quartets
$\{z,\bar z,-z,-\bar z\}$. There are no purely imaginary zeros: such a zero would correspond to a real zeta zero in $0<s<1$, whereas the positive alternating eta series and $1-2^{1-s}<0$ give $\zeta(s)<0$. Even and odd combinations of the isolators, followed by even physical cutoffs, give one negative direction in each parity per quartet. The projection $P$ preserves parity. Hence

$$
\boxed{
\dim 1_{(0,\lambda)}(\mathcal L_{\rm even})
=\dim 1_{(0,\lambda)}(\mathcal L_{\rm odd})
=\#\{\text{distinct off-critical quartets}\}.
}
\tag{12.5}
$$

In particular, the sharp gap restricted to even compact smooth tests is already equivalent to RH. Equation (12.5) compares dimensions, not individual eigenvalues. It supplies neither a canonical eigenvalue–zero correspondence nor a relation between zero height and distance of an eigenvalue below $1/2$. A finite census below $1/2-\delta$ still cannot exclude further spectrum approaching $1/2$.


## Attribution and scope

The theta normalization agrees with [Rodgers–Tao, equations (1)–(3)](https://arxiv.org/pdf/1801.05914) after the indicated variable convention. The polarized spectral Weil form is recorded in [Connes–Consani, equation (1.1)](https://content.ems.press/assets/public/full-texts/serials/lem/69/1/11033001/online/10.4171-lem-1049.pdf). The nonlocal square identity is an application of the classical ground-state-transform principle, for which [Frank–Seiringer, Proposition 2.3](https://arxiv.org/pdf/0803.0503) is a primary reference. No novelty claim is made for this principle or the Poincare framework.

The closed-form construction uses the usual representation of a regular symmetric Dirichlet form by a nonnegative selfadjoint generator. General decomposition and Persson theorems, such as [Lenz–Stollmann](https://arxiv.org/abs/1705.10398) and [BenAmor–Güneysu–Stollmann](https://link.springer.com/article/10.1007/s00020-023-02732-9), have additional hypotheses. The weakly-null argument above proves the threshold directly and does not assume those extra Feller hypotheses. Bombieri and Suzuki supply the precise negative-index predecessors cited in section 12.

The missing result is the lower bound $\gamma_{\rm jump}\ge1/2$, equivalently the exclusion of all spectrum in $(0,1/2)$. The equality modes, prime return law, essential threshold and negative-index identity do not establish it. Every theorem here is written mathematics. The separate Lean implication from the eventual sign of $W$ is documented in the [actual arithmetic criterion](actual-critical-sign-criterion.md).

The [regularity sequel](theta-jump-eigenfunction-regularity.md) proves stronger weighted localization, complete zero sums, smoothness and form-norm zero-mode expansion. Its two-sided isolator bounds also place the uncut witnesses in the actual form domain and quantify their zero-dependent Rayleigh deficits. The [semigroup sequel](theta-jump-tail-renewal.md) retains finite-time tail renewal and the distinct failures of folded stochastic order and positive Euclidean Lipschitz contraction.

The [complete killed-core return construction](theta-killed-core-return-comparison.md) gives a subsequent exact Schur reduction, preserving the excursion metric and both pole constraints. Its [clock-domain](theta-return-clock-domain-bound.md) and [boundary compactness](theta-return-clock-boundary-compactness.md) proofs justify the stronger weighted core space without asserting the missing sharp comparison.

## Compiled literal theta foundation

[PhysicalThetaSeries.lean](BuildingBlocks/PhysicalThetaSeries.lean) now defines the literal series in section 1, proves that index zero vanishes and reindexes to n ≥ 1, proves absolute convergence for every real u and measurability of the full series, and proves strict positivity for u ≥ 0. Each summand is continuous. See [the source and formal scope](physical-theta-series-lean-foundation.md). This does not yet formalize evenness, full-line positivity, infinite-sum continuity or smoothness, the xi transform, exponential moments, the actual jump operator or the sharp gap.
