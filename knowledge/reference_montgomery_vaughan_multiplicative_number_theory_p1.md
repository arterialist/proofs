# Montgomery & Vaughan (2007) — Multiplicative Number Theory I

Type: reference
Confidence: high
Source: Candidates 00, 01, 05, 06, 07 (Level 0)
Relevant to: Landau singularity lemma and bilinear sieve bounds for von Mangoldt convolutions

## Bibliographic Info
- Authors: Hugh L. Montgomery and Robert C. Vaughan
- Title: Multiplicative Number Theory I: Classical Theory
- Year: 2007
- ArXiv/DOI: Cambridge Studies in Advanced Mathematics, Vol. 97, Cambridge University Press
- Theorem/Lemma Number: Lemma 15.1 (Landau's Theorem), Chapter 13 (Bilinear Forms)
- Verified via web search: yes

## Key Result
1. Lemma 15.1 (Landau's Theorem): If $A(x) \ge 0$ for all $x \ge 1$ and the Dirichlet integral $\int_1^\infty A(x) x^{-s} dx$ converges for $\Re s > \sigma_c$, then the function represented by the integral has a singularity at $s = \sigma_c$.
2. Chapter 13 (Bilinear Forms and Sieve Bounds): Unconditional estimates on bilinear sums of von Mangoldt functions $\sum_m \sum_n a_m b_n K(mn)$ via Vaughan's identity and the large sieve yield error bounds saving powers of $\log x$ or sub-exponential factors $\exp(-c(\log x)^{3/5})$ over the trivial scale $x^2$. They cannot achieve power savings $x^{1/2}$ without assuming an analytic zero-free region.

## Hypotheses / Conditions
- Nonnegativity of the arithmetic integrand/measure for Lemma 15.1.
- Bilinear decompositions require Type I and Type II ranges, subject to the Selberg parity barrier.

## How It Applies
1. Lemma 15.1 provides the standard textbook formulation of Landau's positive-measure singularity criterion utilized in the Lean formalization of Frontier 1.
2. Chapter 13 provides the rigorous justification for why attempting to prove $N_*(x) = o(x^{3/2}\log^2 x)$ via Vaughan/Heath-Brown sieve methods unconditionally is mathematically impossible (Selberg parity barrier).

## Caveats
None. The text is standard reference material for analytic number theory.
