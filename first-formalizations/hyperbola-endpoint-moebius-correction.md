# Exact integer-endpoint correction for Möbius hyperbola sum in Lean 4

**Status:** complete Lean 4 formalization, September 2026.
Compiled in:
- [HyperbolaEndpoint.lean](../formalization/BuildingBlocks/HyperbolaEndpoint.lean)

Attribution: Arterialist RH research team, September 2026.
Classical Dirichlet hyperbola method: Dirichlet (1849).
A search across Mathlib4, Isabelle/AFP, and Coq/ROC indicates that while Mathlib has basic
arithmetic functions and Möbius inversion, this exact integer-endpoint formula evaluating
the square-root divisor counting convolution with Möbius $\mu$:
\[
 2 \sum_{d \mid N} \mu(d) \cdot \#\{m \mid (N/d) : 1 \le m \le \lfloor\sqrt{N/d}\rfloor\} = 1 + (-1)^{\Omega(N)}
\]
and its identity with the double-sum jump count had not previously been formalized in any theorem prover.

## Mathematical content

For a positive integer $q$, let $c(q) = \#\{m \mid q : 1 \le m \le \lfloor\sqrt{q}\rfloor\}$ be the number of
divisors of $q$ up to $\sqrt{q}$.
Define the Möbius convolution:
\[
 E(N) = \sum_{d \mid N} \mu(d) c(N/d).
\]

1. **Parity divisor pairing:**
   Pairs each divisor $m \mid q$ with its complementary divisor $q/m$, retaining the diagonal term when $q$ is a square:
   \[
    2 c(q) = \tau(q) + \mathbf{1}_{\{q \text{ is a square}\}} \qquad (q \ge 1).
   \]
2. **Convolution evaluation:**
   Evaluates the two convolutions via Mathlib arithmetic identities:
   - $\sum_{d \mid N} \mu(d) \tau(N/d) = 1$ (`moebius_divisorCard_sum`).
   - $\sum_{d \mid N} \mu(d) \mathbf{1}_{\{N/d \text{ is a square}\}} = (-1)^{\Omega(N)}$ (`moebius_square_quotient_sum`),
     where $\Omega(N)$ is `ArithmeticFunction.cardFactors N`.
3. **Exact binary value:**
   Proves `twice_hyperbolaEndpointCorrection`:
   \[
    2 E(N) = 1 + (-1)^{\Omega(N)} \implies E(N) \in \{0, 1\} \quad (N \ge 1).
   \]
4. **Double-sum jump representation:**
   Proves `hyperbolaEndpointCorrection_eq_jump_sum`:
   \[
    E(N) = \sum_{n=1}^N \mu(n) \sum_{m=1}^{\lfloor\sqrt{\lfloor N/n\rfloor}\rfloor} \mathbf{1}_{\{nm \mid N\}}.
   \]

### Sawtooth convention conversion
In analytic number theory, when applying the Dirichlet hyperbola method to the summatory function
$M(x) = \sum_{n \le x} \mu(n)$, one frequently needs to change conventions for the sawtooth function
$\sigma(x) = \{x\} - 1/2$ at integer points. This theorem proves that the total correction is:
\[
 \sum_{n=1}^N \mu(n) \sum_{m \le \sqrt{N/n}} \sigma(N/(nm)) - \sum_{n=1}^N \mu(n) \sum_{m \le \sqrt{N/n}} \sigma_0(N/(nm)) = -\frac{1 + (-1)^{\Omega(N)}}{4},
\]
which is strictly $0$ or $-1/2$.

### Verification and dependencies
- Lean version: 4.24.0.
- Mathlib commit: `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`.
- Axiom dependencies: `[propext, Classical.choice, Quot.sound]`.
- Zero custom axioms, zero `sorry`.
