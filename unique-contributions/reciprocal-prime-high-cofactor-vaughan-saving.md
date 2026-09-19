# Reciprocal-prime high-cofactor Vaughan saving

**Status:** independently audited written analytic proof, 18 September 2026.
The finite complex-weighted divisor identity and hard-cutoff rearrangement are
compiled in [ActualPrimeCofactorFutureFinite.lean](../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean).
Attribution: Arterialist RH research team (RH Agents 2, Proof, and 1), September 2026.
To the best of our knowledge, the combination of Vaughan's identity with the
Robert–Sargos third-derivative test to establish a power saving on high-cofactor slices
of Weil test packets has not appeared in prior literature.

## Statement

Let $W$ be any complex weight of bounded variation supported in $[c, C] \subset (0, \infty)$.
For $D$ sufficiently large, $D^{1/2} \le F \le D$, and either sign $\varepsilon \in \{-1, 1\}$:
\[
 \boxed{\quad
 \left| \sum_{n \ge 1} \Lambda(n) W(n/D) e(\varepsilon FD/n) \right| \ll_{c,C} D^{1 - 1/30} \|W\|_{BV}.
 \quad}
\]
When transferred to the exact pole-null packet $g_N(x) = x^{-1/2} C_T(\log(x/N))$ for
$N = T^\lambda$ with $2 < \lambda < 29/14$, this gives:
\[
 \boxed{\quad
 \sum_{d \le H T^{\delta_*}} \Lambda(d) \sum_{k \ge 1} g_N(dk) \ll_{\lambda, a, w, \eta} T^{-(29 - 14\lambda)/60} = o(1),
 \quad}
\]
where $H = N/T$ and $\delta_* = \min\left\{\frac{\lambda-2}{100}, \frac{3-\lambda}{100}, \frac{29-14\lambda}{3000}\right\} > 0$.

## Mathematical mechanism

1. **Vaughan decomposition:** Uses Vaughan's identity with $U = V = D^{1/8}$ to split
   $\Lambda$ into Type I and Type II sums.
2. **Robert–Sargos third-derivative test:** On Type II blocks $ab \sim D$ with $A \ge B \ge D^{1/8}$,
   the phase in the long variable has $|f'''(a)| \asymp Fh / (B A^3)$. Applying Robert and
   Sargos's third-derivative estimate (Acta Arith. 2003) yields saving $D^{-1/24}$, which
   absorbs divisor coefficients to deliver $D^{1 - 1/30}$.
3. **Poisson summation on the packet:** Because $\int_0^\infty g_N = 0$ and $\int_0^\infty (\log x) g_N = 0$,
   Poisson summation on $k \mapsto g_N(dk)$ yields modes with reciprocal parameter $F = |m|N/D$,
   precisely within the Robert–Sargos regime for the high-cofactor slice $d \le H T^{\delta_*}$.

Full proof: [building-blocks/weil-and-spectral/actual-reciprocal-prime-high-cofactor-saving.md](../building-blocks/weil-and-spectral/actual-reciprocal-prime-high-cofactor-saving.md).
Formalization: [formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean](../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean).
