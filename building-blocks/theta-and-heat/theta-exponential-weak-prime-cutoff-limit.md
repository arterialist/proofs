# Hard-cutoff limit through the complete weak prime row

Let \(G=\Phi\psi1_O\) be the actual killed physical ground. Let \(z\) have the weak row's exponential bound at a fixed \(\beta>1/2\), and set \(z_k(w)=1_{|w|\le k}z(w)\), \(k\in\mathbb N\). Retain every integer \(n\ge2\), its actual Mangoldt weight, and both shift orientations.

For \(s\in\{+1,-1\}\), the cutoff overlap is exactly
\[
A_{k,n,s}=\int G(v)z_k(v+s\log n)\,dv
=\int 1_{|v+s\log n|\le k}G(v)z(v+s\log n)\,dv.
\]
For each fixed \(n,s\), the indicator is eventually one at every \(v\). Its overlap norm is bounded by \(G(v)|z(v+s\log n)|\), integrable by the exponential-moment result in [the prime-tail prerequisites](theta-exponential-weak-prime-tail-lean-prerequisites.md). Bochner dominated convergence therefore gives \(A_{k,n,s}\to A_{n,s}\).

The complete row has the fixed nonnegative majorant
\[
B_n=\frac{\Lambda(n)}{\sqrt n}
\left[\int G(v)|z(v+\log n)|\,dv
+\int G(v)|z(v-\log n)|\,dv\right].
\]
The previous complete-integral theorem proves \(\sum B_n<\infty\). The triangle inequality gives
\[
\left|\frac{\Lambda(n)}{\sqrt n}(A_{k,n,+}+A_{k,n,-})\right|\le B_n.
\]
Dominated convergence for series now proves
\[
\boxed{\quad
\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}(A_{k,n,+}+A_{k,n,-})
\longrightarrow
\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}(A_{n,+}+A_{n,-}).
\quad}
\]
The cutoff is on the translated test coordinate. Neither the ground nor the prime-power series is replaced by a truncated arithmetic measure. The same proof applies to a fixed pole-corrected test once its exponential bound and moment hypotheses are verified.

[WeakGroundPrimeCutoff.lean](../../formalization/BuildingBlocks/WeakGroundPrimeCutoff.lean) formalizes measurable hard overlap cutoffs, norm domination, pointwise eventual equality, each Bochner overlap limit, and the full prime-row limit above. It imports the unchanged `WeakGroundPrimeTail` prerequisite module. Its measure is arbitrary on the real line; the actual application uses Lebesgue measure and the written ground-moment and source-measurability identifications. No archimedean limit, ground equation, core arrival identity, covariance sign, or RH bound is inferred from this prime-row convergence theorem.

Agent2 supplied the proofs and source map. RH Proof independently reviewed the translated cutoff and full arithmetic series against the actual weak ground chapter. The five printed declarations compile with only `propext`, `Classical.choice`, and `Quot.sound`.
