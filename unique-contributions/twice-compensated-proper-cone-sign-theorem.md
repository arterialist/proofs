# A sign barrier for twice-compensated divisor cones

**Status:** complete written proof; not yet formalized in Lean. Attribution: Arterialist–Codex RH research collaboration, 16 September 2026. To the best of our knowledge after a targeted search of divisor-sum, Mellin-transform, and vanishing-moment literature, the specific proper-cofactor sign theorem below has not appeared in a public source. Mellin convolution and Laplace uniqueness used in its proof are classical; this priority assessment is provisional.

Let \(w:(0,1]\to\mathbb R\) be measurable and nonzero in \(L^1\), with
\[
\int_0^1|w(u)|(1+|\log u|^2)\,du<\infty,
\qquad \int_0^1w(u)\,du=\int_0^1w(u)\log u\,du=0.
\]
Define its proper-divisor cone response
\[
S_w(u)=\sum_{\substack{m\ge2\\mu\le1}}w(mu),\qquad 0<u\le\tfrac12,
\]
and assume \(S_w\in L^1(0,1/2)\).

**Theorem.** Both \(\{u:S_w(u)>0\}\) and \(\{u:S_w(u)<0\}\) have positive Lebesgue measure. Thus a nonzero clock probe cannot annihilate both the density and logarithmic moments while retaining a one-sided proper-cone response.

**Proof.** Put \(W(s)=\int_0^1u^{s-1}w(u)\,du\). For real \(s>1\), absolute convergence and \(v=mu\) give
\[
\int_0^{1/2}u^{s-1}S_w(u)\,du
=\sum_{m\ge2}m^{-s}W(s)=(\zeta(s)-1)W(s).
\]
The two moment conditions and the weighted integrability imply \(W(s)=O((s-1)^2)\) as \(s\downarrow1\). Since \(\zeta(s)-1\sim(s-1)^{-1}\), dominated convergence yields \(\int_0^{1/2}S_w=0\). If either strict-sign set had measure zero, this zero integral would force \(S_w=0\) almost everywhere. The displayed Mellin identity and \(\zeta(s)-1>0\) would then give \(W(s)=0\) for all real \(s>1\). With \(u=e^{-x}\), these are the Laplace transforms of the \(L^1\) function \(e^{-x}w(e^{-x})\). Laplace uniqueness forces \(w=0\) almost everywhere, a contradiction. ∎

The [full divisor-cone analysis](../building-blocks/signed-proper-cone-wavelet.md) supplies the explicit probe \(w(u)=(\log u)^2+4\log u+2\), checks the required integrability, and shows how positive and negative cone populations each have order \(X\) under the von Mangoldt measure. The theorem is a **no-go for one-sided cone positivity**, not a bound on their signed difference and not a proof of RH. The closest prior mechanism is the classical Mellin identity for a divisor dilation sum; the additional sign conclusion is the contribution recorded here.
