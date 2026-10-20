# Double Pole Preservation under Shifted Multiplier $\zeta(s+1/2)$

Type: theorem
Confidence: high
Source: Candidates 00, 01, 02, 03, 04, 05, 06, 07 (Level 0)
Relevant to: Preserving off-critical zero double poles in Frontier 1 Mellin transform

## Statement
Let $\mathcal{M}_W(s) = \frac{\zeta(s+1/2)}{s(s+1)} (G(s)^2 - H(s))$ where $G(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}$ and $H(s) = \sum_{n \ge 1} \frac{\Lambda(n)(\log n - \Lambda(n))}{n^s}$.
Let $\rho = \beta + i\gamma$ be any zero of $\zeta(s)$ with $\beta > 1/2$ and multiplicity $m \ge 1$.
Then $\mathcal{M}_W(s)$ has a pole of order exactly 2 at $s = \rho$ with leading Laurent coefficient:
$$\lim_{s \to \rho} (s - \rho)^2 \mathcal{M}_W(s) = \frac{m^2 \zeta(\rho + 1/2)}{\rho(\rho + 1)} \ne 0.$$
In particular, the pole is non-removable and cannot be canceled for any multiplicity $m \ge 1$.

## Proof
1. Laurent expansion of $G(s)$: Near $s = \rho$, $-\frac{\zeta'(s)}{\zeta(s)} = -\frac{m}{s-\rho} + O(1)$. Because $\beta > 1/2$, $\rho \ne 1$, so $-\frac{s}{s-1}$ is holomorphic at $\rho$. Thus $G(s) = -\frac{m}{s-\rho} + O(1)$, which gives:
   $$G(s)^2 = \frac{m^2}{(s-\rho)^2} + O\left(\frac{1}{s-\rho}\right).$$
2. Regularity of $H(s)$: Since $\Re \rho = \beta > 1/2$, the Dirichlet series $H(s)$ converges absolutely and defines a holomorphic function at $s = \rho$.
3. Non-vanishing of Shifted Zeta Factor: At $s = \rho$, the shifted argument satisfies:
   $$\Re(\rho + 1/2) = \beta + 1/2 > 1/2 + 1/2 = 1.$$
   In the half-plane $\Re w > 1$, $\zeta(w)$ is defined by the absolutely convergent Euler product $\zeta(w) = \prod_p (1 - p^{-w})^{-1} \ne 0$. Therefore:
   $$\zeta(\rho + 1/2) \ne 0.$$
4. Denominator Non-vanishing: Since $\beta \in (1/2, 1)$ and $|\gamma| > 14$, $\rho \ne 0$ and $\rho \ne -1$, so $\rho(\rho+1) \ne 0$.
5. Multiplying terms gives the leading Laurent coefficient $\frac{m^2 \zeta(\rho+1/2)}{\rho(\rho+1)} \ne 0$, establishing a pole of order exactly 2.

## Hypotheses / Conditions
- $\rho = \beta + i\gamma$ is a zero of $\zeta(s)$ with $\beta > 1/2$ and multiplicity $m \ge 1$.
- Multiplier must be shifted to $\zeta(s+1/2)$ (corresponding to square-root aggregation $\sum \sqrt{d} V(x/d)$).

## How It Applies
This proves why square-root aggregation $\sqrt{d}$ is the decisive structural feature of Frontier 1. In unshifted linear aggregation $\sum d V(x/d)$, the multiplier is $\zeta(s)$, which has a zero of order $m$ at $\rho$, yielding $(s-\rho)^m (s-\rho)^{-2} = (s-\rho)^{m-2}$. For multiple zeros ($m \ge 2$), unshifted aggregation cancels the pole completely, preventing Landau's theorem from detecting off-critical zeros. Shifted aggregation $\zeta(s+1/2)$ preserves the double pole for all $m \ge 1$.

## Caveats
Formalized in Lean 4 without sorries in `formalization/BuildingBlocks/CriticalTransformPoles.lean`.
Holds only for zeros strictly off the critical line ($\beta > 1/2$). On the critical line $\Re \rho = 1/2$, $\Re(\rho+1/2) = 1$, where $\zeta(1+i\gamma)$ does not vanish but requires boundary estimates.
