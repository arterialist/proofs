# Titchmarsh Zero-Spacing Lemma for Ordinate-Avoiding Horizontal Contours

Type: reference
Confidence: high
Source: Candidate 04, Falsers 04, 05, 07 (Level 1)
Relevant to: Justifying Perron contour shifting across the critical strip without intersecting zero singularities.

## Bibliographic Info
- Authors: E. C. Titchmarsh (revised by D. R. Heath-Brown)
- Title: The Theory of the Riemann Zeta-Function
- Year: 1986
- Publisher: Oxford University Press (Clarendon Press), Oxford Science Publications
- Edition: 2nd edition
- Section/Theorem: Section 9.3 (Theorem 9.4 and Lemma 9.3 on zero spacing)
- Verified via web search: yes

## Key Result
Let $N(T)$ denote the number of zeros of $\zeta(s)$ in the critical strip $0 < \sigma < 1$ with $0 < t \le T$. Since $N(T+1) - N(T) = O(\log T)$ as $T \to \infty$, for every sufficiently large $T$, there exists an ordinate $T_k \in [T, 2T]$ such that:
$$\min_{\rho = \beta + i\gamma} |T_k - \gamma| \gg \frac{1}{\log T_k}.$$
Along the horizontal segment $s = \sigma + i T_k$ with $-1 \le \sigma \le 2$:
$$\left| \frac{\zeta'}{\zeta}(\sigma + i T_k) \right| \ll \log^2 T_k, \qquad |\zeta(\sigma + i T_k)| \ll T_k^{1/4}.$$
In particular, the centered logarithmic derivative satisfies $|G(\sigma + i T_k)|^2 \ll \log^4 T_k$. Combined with the quadratic decay of the denominator factor $|s(s+1)|^{-1} \asymp T_k^{-2}$, the horizontal contour integral in the truncated Perron inversion formula satisfies:
$$\int_{1/2+\varepsilon}^c \left| \frac{\zeta(\sigma + 1/2 + i T_k)}{(\sigma + i T_k)(\sigma + 1 + i T_k)} G(\sigma + i T_k)^2 \right| x^{\sigma+1} \, d\sigma \ll T_k^{-7/4} \log^4 T_k \cdot x^{c+1} \longrightarrow 0 \quad \text{as } T_k \to \infty.$$

## Hypotheses / Conditions
- The ordinate $T_k$ must be selected from the discrete zero-avoiding sequence, not as an arbitrary continuous limit $T \to \infty$.
- Requires the Montgomery-Vaughan / Riemann-von Mangoldt zero density bound $N(T+1) - N(T) = O(\log T)$.

## How It Applies
This lemma provides the essential, missing mathematical foundation required to make the converse asymptotic contour shift $W(x) \sim -\frac{1}{6} x^{3/2} \log^2 x$ rigorous under RH. Without ordinate-avoiding selection, horizontal contour integrals passing through zero ordinates diverge as $(\sigma - 1/2)^{-2}$, invalidating the contour shift.

## Caveats
Mathlib 4 currently lacks the complex analysis infrastructure for zero-spacing lemmas and vertical zero density counting $N(T+1) - N(T) = O(\log T)$, making formalization of this contour shift a significant prerequisite debt.
