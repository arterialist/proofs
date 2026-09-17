# Prime reflection atoms obstruct odd Perron positivity

This note proves a specific obstruction for the actual theta–Weil jump operator. It does not prove or disprove its sharp spectral gap, and it does not exclude nonlocal changes of variables or coupled spectral comparisons.

## Kernel and folding conventions

Use the positive even theta kernel and the jump form in [the theta–Weil construction](theta-weil-jump-form.md):

\[
E(h)=\int_0^\infty r(a)\int_{\mathbb R}\Phi(u+a)\Phi(u)|h(u+a)-h(u)|^2\,du\,da
+\sum_{q\ge2}c_q\int_{\mathbb R}\Phi(u+\log q)\Phi(u)|h(u+\log q)-h(u)|^2\,du,
\]
\[
r(a)=\frac{e^{-a/2}}{1-e^{-2a}},\qquad c_q=\frac{\Lambda(q)}{\sqrt q}.
\]

The sum includes every prime power. The semigroup conclusion below concerns a nonnegative selfadjoint realization \(\mathcal L\) of this form, with semigroup \(e^{-t\mathcal L}\), on \(L^2(\nu)\), where \(d\nu=2\cosh(u/2)\Phi(u)du\). Reflection preserves the form. Identify its odd subspace with functions on \((0,\infty)\) by the odd extension

\[
(Of)(u)=\begin{cases}f(u),&u>0,\\-f(-u),&u<0.\end{cases}
\]

Equip the halfline with measure \(2\nu|_{(0,\infty)}\), so \(O\) is unitary, and write \(E_o(f,g)=E(Of,Og)\), using the real polarized form. This normalization explains the factors of two below.

For nonnegative smooth \(f,g\) with disjoint compact supports strictly inside the halfline, the continuous part is exactly

\[
E_{o,\mathrm{arch}}(f,g)
=2\int_0^\infty\!\int_0^\infty
\Phi(u)\Phi(v)\bigl[r(u+v)-r(|u-v|)\bigr]f(u)g(v)\,du\,dv.
\tag{1}
\]

Here \(r\) is strictly decreasing and \(|u-v|<u+v\). Thus the continuous odd offdiagonal conductance is strictly positive almost everywhere. Its apparent diagonal singularity causes no difficulty for these separated supports.

The prime term at displacement \(a=\log q\) is exactly

\[
\begin{aligned}
E_{o,q}(f,g)=2c_q\bigg\{&\int_0^a\Phi(u)\Phi(a-u)f(u)g(a-u)\,du\\
-&\int_0^\infty\Phi(u)\Phi(u+a)
\bigl[f(u)g(u+a)+g(u)f(u+a)\bigr]\,du\bigg\}.
\end{aligned}
\tag{2}
\]

The positive first term is an odd-sector reflection atom supported on \(u+v=\log q\). Equivalently, it is a negative offdiagonal conductance. The remaining atoms are same-side translations with positive conductance.

## A compact-test violation of positivity

Put

\[
a=\log2,\qquad u_0=1/5,\qquad v_0=a-u_0.
\]

Let \(\eta\ge0\) be a nonzero even smooth bump supported in \((-1,1)\), and set

\[
f_\epsilon(u)=\eta((u-u_0)/\epsilon),\qquad
g_\epsilon(v)=\eta((v-v_0)/\epsilon).
\]

For sufficiently small \(\epsilon>0\), these supports are positive, separated, and contained in \((0,a)\). Their pairwise sums lie close to \(a\), and stay below \(\log3\). Consequently all same-side prime terms vanish, and every cross-reflection prime term except \(q=2\) vanishes. No prime truncation has been imposed: the other terms vanish by support.

The surviving prime term satisfies

\[
E_{o,2}(f_\epsilon,g_\epsilon)
=2\frac{\log2}{\sqrt2}\Phi(u_0)\Phi(v_0)
\epsilon\int_{-1}^{1}\eta(x)^2\,dx+O(\epsilon^2).
\tag{3}
\]

In contrast, the full continuous gamma term in (1) is \(O(\epsilon^2)\), and is negative. All its coefficients are smooth and bounded on this separated support rectangle. Therefore

\[
\boxed{E_o(f_\epsilon,g_\epsilon)>0}
\qquad\text{for all sufficiently small }\epsilon>0.
\tag{4}
\]

These odd extensions belong to the literal finite-energy domain. They are globally smooth and compactly supported away from zero. For small a their squared difference integral is O(a^2), since their derivatives are bounded and the union of their shifted supports has bounded length. The kernel r(a)=O(1/a) is therefore integrable against that difference. For a bounded away from zero, its integrable exponential tail and bounded Phi give finite continuous energy. On a long prime shift, one endpoint lies in a fixed compact set and the other theta factor is at most a fixed constant times exp(-a). The complete prime energy is consequently bounded by a constant times the convergent sum of Lambda(n)/n^(3/2), with finitely many short shifts treated separately. Theta boundedness and its exponential tail are proved in the published theta moment foundation, and complete von Mangoldt summability is proved in the prime-arrival foundation. Thus no form-domain membership is being assumed for the compact tests.

This is an analytic compact-test proof, not a numerical observation.

For a positivity-preserving selfadjoint semigroup \(T_t\), nonnegative disjoint form-domain functions satisfy

\[
E_o(f,g)=\lim_{t\downarrow0}\frac{\langle(I-T_t)f,g\rangle}{t}
=-\lim_{t\downarrow0}\frac{\langle T_tf,g\rangle}{t}\le0.
\]

Thus (4) proves that the odd restriction, when identified with halfline functions, does **not** generate a positivity-preserving semigroup. This is the necessary direction of the classical first Beurling–Deny criterion; a primary discussion is [Ma–Röckner, *Markov processes associated with positivity preserving coercive forms* (1995)](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/854EE0337B55AEB438AA685D2F84769F/S0008414X00046447a.pdf/markov_processes_associated_with_positivity_preserving_coercive_forms.pdf).

Subtracting any scalar spectral threshold adds only a diagonal form and does not change this disjoint-test obstruction. It therefore also applies to \(\mathcal L_o-1/2\).

## No multiplication sign gauge repairs the obstruction

Consider a real measurable multiplication gauge \(Uf=\sigma f\), with \(\sigma(u)\in\{-1,1\}\) almost everywhere. Transport the closed operator and its form domain by U, and suppose its transformed semigroup is positivity preserving. There is a domain point to establish before using smooth test functions for this transported form.

Positivity implies that its form domain is stable under absolute value and that the energy of |v| is at most that of v. Indeed positivity of T_t gives \(\langle T_t|v|,|v|\rangle\ge\langle T_tv,v\rangle\), while their norms agree. Taking the increasing spectral form limit \(t^{-1}\langle(I-T_t)v,v\rangle\) proves both the domain inclusion and the inequality. Now take an original nonnegative smooth compact halfline test f. Since f lies in the original domain, Uf=\sigma f lies in the transported domain. Its absolute value is f, so f also lies in the transported domain. Equivalently, \(\sigma f\) lies in the original domain. This supplies every nonnegative smooth separated test needed below, even when sigma itself is irregular.

For disjoint such f,g, the transported polarized form is the integral of \(\sigma(u)\sigma(v)\) times the original offdiagonal signed measure, with an overall negative factor. The explicit folding formulas (1) and (2) remain valid for these finite-energy measurable tests. On separated compact rectangles, all kernels are bounded and only finitely many prime displacements can connect the two supports, so these integrals are absolutely defined. Positivity therefore requires this transformed conductance measure to be nonnegative off the diagonal.

Here is why product tests suffice for that last statement. On any compact rectangle whose coordinate projections are disjoint, the signed measure is finite. If it were negative somewhere, continuous nonnegative tests on that rectangle would detect its negative part by regularity. Such tests are uniformly approximated by sums of nonnegative product tests using a rectangular partition of unity. Smooth approximation of each factor then gives a contradiction to the disjoint-test inequality. Covering the complement of the diagonal by these rectangles proves the claimed measure nonnegativity without assuming that the transported form has a smooth core.

The absolutely continuous odd conductance is

\[
\Phi(u)\Phi(v)\bigl[r(|u-v|)-r(u+v)\bigr]du\,dv,
\]

and is strictly positive for almost every distinct pair \(u,v>0\). After the gauge it is multiplied by \(\sigma(u)\sigma(v)\). Nonnegativity therefore forces \(\sigma(u)\sigma(v)\ge0\) for almost every pair. If both sign sets had positive measure, their product rectangle would violate that condition. Hence \(\sigma\) must be constant almost everywhere.

A constant gauge leaves the negative reflection atom at \(u+v=\log2\) unchanged, and (4) still applies. Thus

\[
\boxed{\text{No admissible real measurable }\{\!-1,1\}\text{ multiplication gauge makes the odd semigroup positive.}}
\]

The separation of the absolutely continuous and atomic measures matters: an atom cannot repair a negative density on a product rectangle, and a positive density cannot repair a negative measure concentrated on a reflection line. Translations and reflections preserve null sets, so an almost-everywhere constant gauge is also constant on the prime edges almost everywhere with respect to their one-dimensional edge measure.

## Spectral meaning and limits

The full-line jump semigroup remains positivity preserving. The obstruction arises from identifying an antisymmetric sector with the ordinary positive cone on a halfline: crossing a prime reflection edge reverses the sign.

Consequently a direct halfline Perron argument for the lowest odd mode, or a scalar sign-gauge version of that argument, is unavailable for a closed selfadjoint realization with this literal form. This does not settle the ordering of nonconstant eigenvalues, and it does not exclude a comparison using a genuinely nonlocal transform or a vector-valued cone. Such a replacement would require an additional proved comparison; full-line positivity by itself orders only the constant ground state.

The kernel and theta normalization are those of the cited theta–Weil construction. Folding and the compact reflection-atom calculation are the specific deductions here. No novelty claim is made for the Beurling–Deny criterion or the general ground-state-transform framework.

Review and status: the coordinator supplied the folding and compact-test proof. RH Proof independently checked its signs, the complete prime support exclusions and the semigroup necessary condition, and supplied the compact-test domain bounds and the absolute-value argument needed for arbitrary measurable gauges. This is written mathematics, not a Lean formalization. The closed-realization semigroup conclusions have the stated realization hypothesis.
