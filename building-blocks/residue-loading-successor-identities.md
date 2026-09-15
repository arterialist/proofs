# Exact successor identities for the actual residue loading

The residue loading in the research objective retains all multiplicative histories at successive integer horizons:

\[
A_N=\sum_{1\le n\le N}\Lambda(n)\bigl(1-\{N/n\}\bigr).
\]

Here the braces mean the ordinary fractional part, including value zero at exact division. Every prime power remains through the actual von Mangoldt function. [ResidueLoadingSuccessor.lean](BuildingBlocks/ResidueLoadingSuccessor.lean) formalizes this literal definition and its two successor identities.

Put \(L_N=\sum_{n\le N}\Lambda(n)/n\). The exact compensated factorial representation is

\[
A_N=\psi(N)+\log(N!)-NL_N.
\]

Indeed, the fractional part equals \(N/n-\lfloor N/n\rfloor\), and the complete factorial double count gives \(\sum_{n\le N}\Lambda(n)\lfloor N/n\rfloor=\log(N!)\). The Lean proof reuses the repository's existing factorial double count and verifies that the integer floor and natural quotient agree, rather than substituting a different loading.

At the next horizon, all three complete prefixes change together:

\[
\psi(N+1)-\psi(N)=\Lambda(N+1),\qquad
\log((N+1)!)-\log(N!)=\log(N+1),
\]
\[
L_{N+1}-L_N=\frac{\Lambda(N+1)}{N+1}.
\]

Substituting these exact increments cancels the new atom from the first loading difference, but retains it in the second:

\[
\boxed{A_{N+1}-A_N=\log(N+1)-L_N},
\]
\[
\boxed{A_{N+2}-2A_{N+1}+A_N
=\log\frac{N+2}{N+1}-\frac{\Lambda(N+1)}{N+1}}.
\]

Both identities hold for every natural N, including zero. The denominator N+1 is strictly positive; no asymptotic hypothesis, PNT, RH, sign assumption or omitted boundary is used. The separate theorem \(A_N\ge0\) follows term by term from \(\Lambda(n)\ge0\) and \(\{N/n\}<1\). This positivity does not sign the second difference or bound its accumulated centered arithmetic response.

The five theorems were formalized by RH Proof, using standard finite-sum algebra, floor identities and the already published factorial arithmetic. Their target build and repository umbrella build pass; every assumption check reports only propext, Classical.choice and Quot.sound. No priority claim is made for these elementary identities. The original-source energy and coherent-core inequalities remain open. This formalization preserves the linked histories needed by those consumers; it supplies no unconditional RH-scale estimate.
