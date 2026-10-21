# Báez-Duarte Strengthening of the Nyman-Beurling Criterion

Type: reference
Confidence: high
Source: Candidates explorer_r2_L00_N08, explorer_r2_L00_N09 (Iteration 1, Round 2, Level 0)
Relevant to: Nyman-Beurling approximation, $L^2(0, 1)$ dilation subspaces, RKHS approaches, and arithmetic distance bounds for RH.

## Bibliographic Info
- Authors: Luis Báez-Duarte
- Title: A strengthening of the Nyman-Beurling criterion for the Riemann hypothesis
- Year: 2003
- ArXiv/DOI: Atti Accad. Naz. Lincei Cl. Sci. Fis. Mat. Natur. Rend. Lincei (9) Mat. Appl. 14 (2003), no. 1, 5–11.
- Theorem/Lemma Number: Main Theorem
- Verified via web search: yes

## Key Result
Let $\rho(x) = \{x\} = x - \lfloor x \rfloor$ denote the fractional part function, and let $\chi_{(0,1)}$ be the constant function 1 on $(0, 1)$. Define the sequence of finite-dimensional subspace projection distances:
$$d_N^2 := \inf_{c_1, \dots, c_N \in \mathbb{C}} \int_0^1 \left| 1 - \sum_{k=1}^N c_k \rho\left(\frac{k}{x}\right) \right|^2 dx$$
Then the Riemann Hypothesis holds if and only if:
$$\lim_{N \to \infty} d_N = 0$$
Furthermore, if RH holds, Báez-Duarte, Balazard, Landreau, and Saias (2000/2005) established the precise asymptotic rate:
$$d_N^2 \asymp \frac{1}{\log N}$$

## Hypotheses / Conditions
- The coefficients $c_k$ are unconstrained complex (or real) numbers.
- The dilations $\rho_k(x) = \{k/x\}$ are evaluated on $x \in (0, 1)$.
- The metric is the standard $L^2(0, 1)$ Hilbert norm.

## How It Applies
This result replaces the general Beurling continuous dilations $\rho_\alpha(x) = \{\alpha/x\}$ ($\alpha \in (0, 1)$) with integer dilations $k=1, 2, \dots, N$. Any proof strategy asserting $d_N \to 0$ unconditionally carries 100% of the analytical depth of the Riemann Hypothesis. Furthermore, to distinguish an off-critical zero at height $\gamma \ge 3 \times 10^{12}$ from critical zeros, $N$ must satisfy $\log N \gg \gamma^2$, requiring $N \ge 10^{6.84 \times 10^{24}}$, rendering finite numerical verification computationally blind.

## Caveats
Proving $d_N \to 0$ unconditionally is circularly equivalent to RH. Finite dimensional projections $G_N = (\langle \rho_j, \rho_k \rangle)_{j,k=1}^N$ are extremely ill-conditioned ($\kappa(G_6) \approx 50$, growing exponentially), and naive approximations choosing arithmetic coefficients like $c_k = -\mu(k)$ diverge in $L^2$.
