# The Newman Conjecture (Rodgers-Tao 2020)

Type: reference
Confidence: high
Source: Candidate 15 (Level 0), Candidate L01_N02, explore_falser_L01_N02, explore_merger_L04_N00, explore_falser_L04_N00
Relevant to: Ruling out proofs of real-rootedness or Herglotz-Nevanlinna properties for Fourier/Mellin transforms of theta kernels based purely on qualitative positivity, monotonicity, or decay; auditing de Bruijn-Newman parameter claims.

## Bibliographic Info
- Authors: Brad Rodgers, Terence Tao
- Title: The Newman conjecture of the Riemann zeta function
- Year: 2020
- ArXiv/DOI: Forum of Mathematics, Pi, Vol. 8 (2020), e6, doi:10.1017/fmp.2020.6; arXiv:1801.01314
- Theorem/Lemma Number: Theorem 1.1 (Newman's Conjecture)
- Verified via web search: yes

## Key Result
Let $H_t(z)$ denote the Fourier transform of the deformed Jacobi theta kernel:
$$H_t(z) := \int_0^\infty e^{t u^2} \Phi(u) \cos(z u) \, du,$$
where $\Phi(u) = \sum_{n=1}^\infty (2\pi^2 n^4 e^{9u} - 3\pi n^2 e^{5u}) \exp(-\pi n^2 e^{4u})$. The de Bruijn-Newman constant $\Lambda \in \mathbb{R}$ is the infimum of all $t \in \mathbb{R}$ such that $H_t(z)$ has only real zeros.
Rodgers and Tao proved Newman's conjecture:
$$\Lambda \ge 0.$$
Consequently, for every $t < 0$, the entire function $H_t(z)$ possesses at least one non-real zero (and in fact infinitely many non-real zeros).

## Hypotheses / Conditions
- $t < 0$.
- $\Phi(u)$ is the standard Jacobi theta kernel associated with the completed Riemann zeta function $\Xi(z) = H_0(z)$.

## How It Applies
The deformed kernels $\Phi_t(u) = e^{t u^2}\Phi(u)$ for $t < 0$ satisfy every qualitative property of $\Phi(u)$: they are strictly positive, smooth, symmetric, and exponentially decaying (even faster than $\Phi(u)$ as $u \to \infty$).
Because $\Lambda \ge 0$, any proof technique that relies solely on qualitative properties of $\Phi(u)$ (such as positivity, unimodality, or rapid decay) to deduce that $H_0(z)$ or $\Xi_0(z)$ has only real zeros must also apply to $H_t(z)$ for small $t < 0$, which is impossible because $H_t(z)$ has non-real zeros for all $t < 0$. Thus, qualitative kernel estimates cannot prove RH.

## Caveats
1. The theorem establishes $\Lambda \ge 0$. Polymath15 established $\Lambda \le 0.22$. The Riemann Hypothesis is equivalent to $\Lambda \le 0$, which would imply $\Lambda = 0$.
2. **Reversed Inequality Caution**: Citing Rodgers-Tao (2020) as proving $\Lambda \le 0$ to deduce zero-freeness (as attempted in Candidate L01_N02) is a fatal sign-bound reversal: Rodgers-Tao proved the lower bound $\Lambda \ge 0$, which guarantees non-real zeros for $t < 0$ and provides zero evidence that all zeros of $H_0(z)$ are real.
3. **Real Zero Simplicity Counterexample**: The claim that RH is equivalent to real zero simplicity is refuted by the exact polynomial solution $H_t(z) = z^2 - 2t$, which satisfies $\partial_t H_t = -\partial_{zz} H_t$ and has all real roots for all $t \ge 0$ (so $\Lambda = 0$), but at $t = 0$ develops a double root at $z = 0$ ($H_0(0) = 0, H_0'(0) = 0$). Simplicity is strictly stronger than RH and cannot be deduced from $\Lambda = 0$.
