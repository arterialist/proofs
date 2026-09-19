# Free-factor pruning in the actual Möbius Type-II tail

**Status:** unconditional written analytic estimate, 20 September 2026. The
dyadic grouping and exponent identities are formalized and axiom-audited in
[`ActualMobiusFreeFactorPruning.lean`](../../formalization/BuildingBlocks/ActualMobiusFreeFactorPruning.lean).
The applications of the Robert--Sargos and Bordellès exponential-sum
theorems are written mathematics, not Lean. This result removes new
fixed-power regions from the actual uncollapsed Möbius convolution. It does
not control the residual balanced block, enlarge the complete Möbius cutoff,
or prove the Riemann hypothesis.

Retain

\[
 N=T^\lambda,\qquad H=N/T,
 \qquad 2<\lambda<29/14,
\]

and the exact Vaughan decomposition

\[
 \mu=2a-a*a*1+b*b*1,
 \qquad a=\mu1_{n\leq U},\quad b=\mu-a.
\]

The uncollapsed Type-II contribution is

\[
 \sum_{r,s>U}\sum_{t\geq1}\mu(r)\mu(s)L_{rst}(T).
\tag{1}
\]

Unlike a recombination into \(\mu*\mu\), equation (1) retains both actual
Möbius coefficients and the free factor. Put

\[
 d_*=\frac{2(\lambda+1)}5,
 \qquad D=T^{d_*+\delta},
 \qquad U=T^u,
 \qquad u=\frac{42\lambda-55}{126}.
\tag{2}
\]

Throughout the extension past the component endpoint, assume
\(\delta\geq0\). A requested final margin has \(\eta>0\).

For an integer interval \(I\subset[D,2D]\) and \(V=T^v\), define

\[
 S_{\geq V}(D;I)=
 \sum_{\substack{r,s>U,\ t\geq V\\rst\in I}}
 \mu(r)\mu(s)L_{rst}(T).
\tag{3}
\]

## Forced separation from balance

On a dyadic triple write

\[
 r\asymp T^x,\qquad s\asymp T^y,\qquad t\asymp T^z,
 \qquad x+y+z=d.
\]

Take the smaller **dyadic scale** of \(r,s\) as the separate factor \(B\),
and group the other dyadic Möbius variable with \(t\) as \(A\). This is a
rectangle-level orientation; it is not a pointwise split according to
whether an individual integer \(r\) is smaller than \(s\). The coefficient
on \(A\) is a dyadic piece of \(b*1\), hence remains divisor-bounded. Since
\(x,y\geq u\) and \(z\geq v\), writing \(A=T^a\) gives

\[
 \boxed{\frac{d+v}{2}\leq a\leq d-u.}
\tag{4}
\]

This elementary grouping implication is the theorem `freeFactor_grouping`
in the Lean module cited above.

There is a sharper joint form. Put

\[
 \xi=z+|x-y|.
\tag{4a}
\]

Choosing the smaller of \(r,s\) separately gives the exact identity

\[
 2a-d=\xi.
\tag{4b}
\]

Thus a large free factor and an imbalance between the two Möbius variables
are interchangeable sources of separation from the critical line. Identity
(4b) is the Lean theorem `exact_grouping_separation`.

Apply Robert and Sargos,
[*Three-dimensional exponential sums with monomials*](https://perso.univ-st-etienne.fr/rool6510/robert-2006-crelle.pdf),
Theorem 1, equation (1.3), near balance, and Bordellès,
[*Short sums of restricted Möbius functions*](https://doi.org/10.4064/aa142-4-5),
Lemma 2.7, after the switch, exactly as in the
[rectangle-wise hybrid](actual-mobius-tail-robert-sargos-bordelles-saving.md).
Use the existing hybrid switch

\[
 a_0=\frac{3d-\lambda}{2}.
\tag{5}
\]

For \(a\leq a_0\), the Robert--Sargos exponents satisfy

\[
 R_1\leq-\frac{\lambda-2-5\delta}{8},
 \qquad
 R_2=-\frac{\xi-5\delta}{8}
     \leq-\frac{v-5\delta}{8},
 \qquad
 R_3\leq-\frac{\lambda-2-5\delta}{4}.
\tag{6}
\]

For \(a\geq a_0\), the Bordellès exponents satisfy

\[
 B_1\leq-\frac{\lambda-2-5\delta}{12},
 \qquad
 B_2\leq-\frac{103-42\lambda}{1260}+\frac\delta2,
 \qquad
 B_3\leq-\frac{3\lambda-2}{20}+\frac\delta4.
\tag{7}
\]

The common fourth exponent is

\[
 R_4=B_4=-\frac{\lambda+1}{10}+\delta.
\tag{8}
\]

Equations (4), (6), (7), and (8), including the three active final-margin
inequalities, are Lean-checked real algebra. The Lean module does not
formalize either external exponential-sum theorem, the smoothing transfer,
or the packet summation.

For completeness, the analytic loss transfer is the same as in the parent
hybrid. There are \(O((\log T)^3)\) dyadic triples. The grouped coefficient
is divisor-bounded (by \(\tau_3\) after harmless regrouping), so its
normalization costs \(T^\varepsilon\). Smooth the literal product cutoff at
relative width \(T^{-C_0}\) before the decomposition. The endpoint strips
cost

\[
 \ll_\varepsilon
 (T^{-C_0}D+1)T^\varepsilon N^{-1/2},
\tag{8a}
\]

and the Mellin separation has logarithmic total mass. The nonphysical
Poisson shells retain the summable powers established in the parent hybrid:
zero-mode cancellation handles small shells and Schwartz decay handles large
shells. Choosing \(C_0\) sufficiently large absorbs (8a) and every
polylogarithmic loss.

Under the admissibility conditions

\[
 0<v<d-2u,
 \qquad v>5\delta,
 \qquad 5\delta<\lambda-2,
 \qquad \delta<\frac{103-42\lambda}{630},
\tag{8b}
\]

applying the cited rectangular estimates gives

\[
 \boxed{
 S_{\geq V}(D;I)
 \ll_\varepsilon T^{-c_{\rm free}+\varepsilon},
 \qquad
 c_{\rm free}=
 \min\left\{
 \frac{v-5\delta}{8},
 \frac{\lambda-2-5\delta}{12},
 \frac{103-42\lambda}{1260}-\frac\delta2
 \right\}.}
\tag{9}
\]

More generally, the union of dyadic triples satisfying \(\xi\geq w\) obeys
the same estimate with

\[
 c_{\rm sep}=
 \min\left\{
 \frac{w-5\delta}{8},
 \frac{\lambda-2-5\delta}{12},
 \frac{103-42\lambda}{1260}-\frac\delta2
 \right\}.
\tag{9a}
\]

Only logarithmically many dyadic triples occur, so their union is absorbed
by \(T^\varepsilon\). Equation (9) is the corollary \(z\geq v\Rightarrow
\xi\geq v\).

The omitted exponents in (7) and (8) have larger margins in the following
range. A sufficient strict window for a final saving \(T^{-\eta}\) is

\[
 5\delta+8\eta<v<d-2u,
\tag{10}
\]

\[
 5\delta+12\eta<\lambda-2,
 \qquad
 \delta+2\eta<\frac{103-42\lambda}{630}.
\tag{11}
\]

For \(t\geq V\) and \(rst\in[D,2D]\), the pruned range obeys

\[
 U^2<rs\leq\frac{2D}{V}.
\tag{11a}
\]

Thus the upper bound \(v<d-2u\) in (10) is only the condition that this
admissible range be nonempty up to dyadic constants; it is not a lower bound
on \(rs\). At the exact endpoint \(\delta=0\), every sufficiently small
fixed \(v>0\) removes all free factors \(t\geq T^v\) with a fixed power
saving.

## Common-square pruning in the residual range

In the complementary sum \(t<T^v\), put \(g=(r,s)\). Nonzero Möbius
weights make \(r\) and \(s\) squarefree. Using the established pointwise
packet bound \(|L_m(T)|\ll T^\varepsilon/\sqrt N\), divisor counting gives

\[
\begin{aligned}
 \left|
 \sum_{\substack{t<T^v,\ r,s>U,\ rst\in I\\(r,s)>T^\gamma}}
 \mu(r)\mu(s)L_{rst}(T)
 \right|
 &\ll_\varepsilon
 \frac{T^\varepsilon}{\sqrt N}
 \sum_{t<T^v}\sum_{g>T^\gamma}\frac{D}{tg^2}\\
 &\ll_\varepsilon T^{d-\lambda/2-\gamma+\varepsilon}.
\end{aligned}
\tag{12}
\]

Thus this part saves \(T^{-\eta}\) whenever

\[
 \gamma>\frac{4-\lambda}{10}+\delta+\eta.
\tag{13}
\]

Combining (9) and (12) leaves the exact residual region

\[
 \boxed{
 \sum_{\substack{t<T^v,\ r,s>U,\ rst\in I\\(r,s)\leq T^\gamma}}
 \mu(r)\mu(s)L_{rst}(T).}
\tag{14}
\]

It still contains \(t=1\), \((r,s)=1\), and
\(r,s\asymp D^{1/2}\). No estimate proved here controls that balanced
signed block.

The joint form (9a) localizes this block further. For a final margin
\(T^{-\eta}\), every dyadic triple with

\[
 z+|x-y|>5\delta+8\eta
\tag{15}
\]

is power-saving, subject to (11). Hence, writing \(R=T^x\) and \(S=T^y\),
the unresolved rectangles satisfy

\[
 t\leq T^{5\delta+8\eta+o(1)},
 \qquad
 \max(R/S,S/R)\leq T^{5\delta+8\eta+o(1)}.
\tag{16}
\]

At the exact endpoint this simultaneously forces the free factor and the
aspect ratio into an arbitrarily small fixed-power neighborhood of
\(t=1\) and \(R=S\).

## Coprime-support falsifier

Small greatest common divisor and squarefree support do not by themselves
improve the reciprocal spacing exponent. For \((r,s)=1\), every nonzero
factorization of \(n=rs\) has

\[
 \mu(r)\mu(s)=\mu(n).
\tag{17}
\]

Thus all representations of one product have the same sign. For example,
\(210=10\cdot21=14\cdot15\) gives two distinct balanced coprime squarefree
representations with sign \(+1\).

There is also a power-scale falsifier for any proposed reciprocal-energy
gain based uniformly only on this support information. Restrict a coefficient
sequence to primes by

\[
 \beta_b=\mu(b)1_{\{b\text{ prime},\ B<b\leq2B\}}.
\tag{18}
\]

These are actual Möbius values, all equal to \(-1\). For the nonnegative
continuous kernel \(\Phi\) in the balanced energy, \(\Phi(0)>0\). Partition
the \(P^2\) pair sums \(B/p+B/q\), where
\(P=\pi(2B)-\pi(B)\), into \(O(T)\) intervals of sufficiently small length
\(1/T\). Cauchy's inequality and the prime number theorem give

\[
 \mathcal C_\beta(B;T)
 \gg \frac{P^4}{T}
 \gg \frac{B^4}{T(\log B)^4}.
\tag{19}
\]

Every coefficient product counted in (19) is positive. At
\(B=T^{d/2}\) with \(d>1\), this has power \(T^{2d-1-o(1)}\). Therefore no
bound uniform over such prime or coprime restrictions can replace the
spacing term by \(B^4T^{-1-\rho}\) for fixed \(\rho>0\). This does not lower
bound the full signed Möbius energy: composite sectors may cancel the prime
sector. It rules out only a gain deduced from squarefree or coprime support
without using cancellation between different products.
