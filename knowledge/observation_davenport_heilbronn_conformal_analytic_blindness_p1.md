# Davenport-Heilbronn Counterexample to Purely Conformal Complex-Analytic Proof Engines

Type: observation
Confidence: high
Source: Candidate explorer_r3_L00_N06, Falser explore_falser_r3_L00_N06 (Level 0)
Relevant to: Complex-analytic proof strategies that reduce RH to the non-vanishing of $\Xi_*(z)$ on $\mathbb{C}^-$ or Carleman/Green spectral dispersion without explicit Euler product / arithmetic input.

## Statement
Any proof strategy for the Riemann Hypothesis that operates exclusively in the complex-analytic domain using only:
1. Symmetrized conformal uniformization $z(s) = s(1-s)$ quotienting out functional reflection $s \mapsto 1-s$;
2. Order reduction to $\rho_* = 1/2 < 1$ and genus-0 canonical Hadamard factorization $\Xi_*(z) = \Xi_*(0)\prod (1 - z/\lambda_n)$ with absolutely convergent reciprocal zero sum;
3. Real-axis positivity on $(-\infty, 1/4]$; and
4. Carleman-Green spectral dispersion identities on the lower half-plane $\mathbb{C}^-$;
is mathematically insufficient and blind to the Davenport-Heilbronn counterexample class.

Specifically, the Davenport-Heilbronn zeta function:
$$f(s) = \frac{1 - i\kappa}{2} L(s, \chi) + \frac{1 + i\kappa}{2} L(s, \bar{\chi}), \qquad \kappa = \frac{\sqrt{10-2\sqrt{5}} - 2}{\sqrt{5}-1},$$
is a linear combination of Dirichlet $L$-functions associated with character $\chi \pmod 5$ that:
- Satisfies the exact same functional reflection equation $\xi_f(s) = \xi_f(1-s)$;
- Under $z(s) = s(1-s)$, maps to an entire function $\Xi_{f,*}(z)$ of exact order $\rho_* = 1/2$ and genus $p = 0$;
- Admits an absolutely convergent Hadamard product and satisfies real-segment positivity;
- Satisfies the exact same Carleman-Green dispersion identity $\mathcal{D}_{\text{offline}}[f] = \mathcal{I}[\Xi_{f,*}]$;
YET possesses infinitely many off-line zeros in the critical strip $1/2 < \operatorname{Re}(s) < 1$ (and hence infinitely many zeros in $\mathbb{C}^-$), forcing $\mathcal{D}_{\text{offline}}[f] > 0$ and $\mathcal{I}[\Xi_{f,*}] > 0$.

## Evidence
- Davenport and Heilbronn (1936) proved that $f(s)$ has infinitely many zeros in $\operatorname{Re}(s) > 1/2$.
- Functional reflection $\xi_f(1-s) = \xi_f(s)$ and Stirling growth identical to $\xi(s)$ confirmed analytically and symbolically.
- Under $z = s(1-s)$, growth order $\rho_* = 1/2$ and genus 0 hold identically for $\Xi_{f,*}(z)$.

## Implications
No purely complex-analytic or potential-theoretic argument based solely on functional reflection symmetry, order $1/2$, genus 0, and boundary dispersion can prove $\Xi_*(z) \ne 0$ on $\mathbb{C}^-$ or $\mathcal{I}[\Xi_*] \le 0$ without incorporating the Euler product or the arithmetic distribution of primes. Any valid proof engine must contain an arithmetic or operator-theoretic ingredient that distinguishes the Riemann zeta function from Davenport-Heilbronn functions.

## Caveats
Davenport-Heilbronn functions lack an Euler product $\prod_p (1 - \chi(p)p^{-s})^{-1}$. Incorporating prime multiplicativity, Landau singularity transfer on arithmetic Dirichlet series, or automorphic trace formulas is necessary to break this blindness.
