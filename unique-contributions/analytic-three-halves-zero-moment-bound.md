# Certified analytic three-halves zero-moment bound under RH

**Status:** rigorous analytic proof via digamma Jensen inequality and Mellin resolvent integration, September 2026.
Note location:
- [building-blocks/zeta-and-zeros/zero-three-halves-moment-analytic-bound.md](../building-blocks/zeta-and-zeros/zero-three-halves-moment-analytic-bound.md)

Attribution: Arterialist RH research team, September 2026.
In the literature on explicit bounds for sums over zeros $\sum_\rho |\gamma_\rho|^{-\alpha}$ (e.g., Lehman 1966,
Ramare & Rumely 1996, Trudgian 2014, Mossinghoff & Trudgian 2015), evaluations of fractional moments
typically rely on certified numerical counts of the first $N$ zeros (such as Platt's certified zero tables up to $3 \times 10^{12}$)
combined with asymptotic explicit formulas for $N(T)$.
This theorem provides an exact, **table-free and multiplicity-retaining** analytical bound for the $3/2$-moment
$S_{3/2}$ under RH, proved entirely through fractional Mellin resolvent integration and Jensen's inequality.

## Statement

Assume the Riemann Hypothesis, so that every non-trivial zero is $\rho = 1/2 + i\gamma_\rho$.
Retaining all multiplicities $m_\rho$ and both signs of ordinates, define the fractional moment:
\[
 S_{3/2} := \sum_{\rho} \frac{m_\rho}{|\gamma_\rho|^{3/2}}.
\]

**Theorem.**
\[
 \boxed{\quad S_{3/2} < \frac{509}{1000} < 0.51. \quad}
\]
The proof uses zero numerical zero tables, zero verification up to a finite height, and makes no assumption of zero simplicity.

## Proof mechanism

1. **Quadratic Normalization & Spectral Gap:**
   Logarithmic differentiation of $\xi(s)$ at $s=1$ gives the exact classical identity:
   \[
    S_2 := \sum_\rho \frac{m_\rho}{\gamma_\rho^2 + 1/4} = 2 + \gamma_E - \log(4\pi) < 0.047.
   \]
   This immediately forces $|\gamma_\rho| > 13/2 = 6.5$ for all zeros, since any lower zero would exceed $S_2$.
2. **Fractional Resolvent Mellin Representation:**
   Applying Tonelli's theorem to the beta integral $\int_0^\infty \frac{t^{-1/2}}{\gamma^2 + t^2}\,dt = \frac{\pi}{\sqrt{2}} |\gamma|^{-3/2}$ gives:
   \[
    S_{3/2} = \frac{\sqrt{2}}{\pi} \int_0^\infty t^{-1/2} A(t)\,dt, \qquad A(t) = \frac{1}{t} \frac{\xi'}{\xi}\left(\frac{1}{2} + t\right).
   \]
3. **Jensen's Inequality for Digamma:**
   Expressing $\psi(y) = \Gamma'(y)/\Gamma(y) = \mathbb{E}\log U$ for $U \sim \operatorname{Gamma}(y, 1)$ yields by strict Jensen convexity:
   \[
    \psi(y) < \log y \qquad (y > 0).
   \]
4. **Three-Region Rational Integration:**
   Splitting the integral into $[0, 1/2]$, $[1/2, 10]$, and $[10, \infty)$ and using $\zeta'/\zeta(s) < 0$ for $s > 1$ yields:
   \[
    S_{3/2} < \frac{850218424348087}{1672693386000000} < 0.509.
   \]

Full proof:
- [building-blocks/zeta-and-zeros/zero-three-halves-moment-analytic-bound.md](../building-blocks/zeta-and-zeros/zero-three-halves-moment-analytic-bound.md)
