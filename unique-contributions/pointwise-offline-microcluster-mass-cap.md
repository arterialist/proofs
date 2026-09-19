# Pointwise off-line microcluster mass cap from the complete Weil form

**Status:** unconditional written analytic proof, 18 September 2026.
The finite Hermitian inequality and reflected-pair algebraic identity are
compiled in [ActualAnnulusGramAlgebra.lean](../formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean)
and [ActualWeilZeroPairAlgebra.lean](../formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean).
Attribution: Arterialist RH research team (RH Agents 1, 2, 3), September 2026.
To the best of our knowledge after searching the explicit-formula and zero-density
literature, this pointwise, ordinate-by-ordinate mass bound on off-line zeros has not
previously appeared in print.

## Statement

Fix $0 < w < \log 2$ and a real nonnegative nonzero $\phi \in C_c^\infty((0, w))$ with
$\|\phi\|_2 = 1$. Put $H = \log T$, $h = \log H$, $R = 2h$, and for $t \in [T, 2T]$:
\[
 u_t(x) = e^{-itx} \phi(x), \qquad v_{t,R}(x) = e^{-itx} \phi(x-R), \qquad f_t = u_t - v_{t,R}.
\]
Let $Q$ denote the **complete actual-zeta Weil form**, retaining every $\Lambda(p^j) = \log p$,
both poles, and the exact digamma multiplier.

**Theorem.** There exist constants $\epsilon_\phi > 0$, $C_\phi > 0$, and a fixed $D > 0$
such that, for all sufficiently large $T$ and every carrier ordinate $t \in [T, 2T]$,
if there is no right-half nontrivial zeta zero $\rho = \beta + i\gamma$ with
\[
 \beta > 1/2, \qquad \frac{\epsilon_\phi}{R} < |\gamma - t| \le H^D,
\]
then the central off-line zero mass obeys the **pointwise** bound
\[
 \boxed{\quad
 \sum_{\substack{\rho = \beta + i\gamma \\ \beta > 1/2,\ |\gamma - t| \le \epsilon_\phi/R}}
 m_\rho e^{(\beta - 1/2)R} \le C_\phi \log T.
 \quad}
\]
In particular, for each fixed $0 < \delta < 1/2$, the number of zeros in the central
window with $\beta \ge 1/2 + \delta$, counted with multiplicity, is
\[
 O_\phi((\log T)^{1 - 2\delta}).
\]
The conclusion holds for **every** ordinate $t$ without exceptional sets.

## Mathematical mechanism

1. **Separation and prime support:**
   Because each bump has width $w < \log 2$, the convolution $\phi * \widetilde\phi$ is
   supported in $(-\log 2, \log 2)$, which contains no primes ($p \ge 2 > e^{\log 2}$).
   At separation $R = 2\log\log T$ with offset $c=0$, the complete prime and archimedean
   terms give $Q(f_t) \ge a_\phi \log T$ unconditionally.
2. **Reflected off-line zero sign:**
   Critical-line zeros contribute $|\widehat f_t(\gamma)|^2 \ge 0$.
   Off-line zeros paired with their reflections contribute
   $2 m_\rho \operatorname{Re}[ W_d(\gamma-t) (2 - e^{i(\gamma-t)R + dR} - e^{-i(\gamma-t)R - dR}) ]$.
   For $|\gamma - t| \le \epsilon_\phi/R$, the phase is strictly aligned, making the growing
   term $-2b_\phi m_\rho e^{(\beta-1/2)R}$ strictly negative.
3. **Comparison:**
   Equating the positive prime-side lower bound with the zero-side representation forces
   the central growing mass to be capped by $C_\phi \log T$.

## Antecedents and literature comparison

Classical zero-density theorems (Ingham, Montgomery, Huxley, Jutila, Bourgain,
Maynard–Pratt) bound $N(\sigma, T)$ by integrating over large ordinate intervals $[0, T]$,
yielding global counts such as $T^{A(\sigma)(1-\sigma)}$. Bombieri (2000) and Yoshida (1992)
studied Weil quadratic forms globally or semi-locally. None of these works constructs
a pointwise, two-bump separated test function yielding a local microcluster mass cap
without carrier exceptional sets.

Full proof: [building-blocks/weil-and-spectral/actual-weil-offline-microcluster-mass.md](../building-blocks/weil-and-spectral/actual-weil-offline-microcluster-mass.md).
