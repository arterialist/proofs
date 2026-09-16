# A one-sided RH target in positive factorial residue loading

For an integer \(N\ge2\), retain the complete von Mangoldt weight,
including all prime powers, and define
\[
 A_N=\sum_{2\le d\le N}\Lambda(d)
          \left(1-\left\{\frac Nd\right\}\right),
 \qquad
 F(N)=\log N-\sum_{d\le N}\frac{\Lambda(d)}d+\frac{\psi(N)}N.
 \tag{1}
\]
Every summand of \(A_N\) is nonnegative. If \(d\mid N\), its bracket
is exactly one; otherwise the fractional part remains. Thus \(A_N\)
keeps prime-power divisibility and the nonterminal exact-division
histories together. It is the residue loading already used in the
[factorial ground source analysis](goldbach-literal-successor-counting-transport.md).

The complete divisor identity
\(\log m=\sum_{d\mid m}\Lambda(d)\), summed over \(1\le m\le N\),
gives \(\log N!=\sum_{d\le N}\Lambda(d)\lfloor N/d\rfloor\).
Since \(\{N/d\}=N/d-\lfloor N/d\rfloor\), finite algebra yields
\[
 \boxed{\quad NF(N)=N\log N-\log N!+A_N.\quad}          \tag{2}
\]
No PNT estimate, analytic continuation, or endpoint convention is
needed for (2). Put
\[
 B_N=N+\log N!-N\log N.
\]
Integral comparison for \(\log t\) gives \(B_N=O(\log(2N))\), so
\[
 N\bigl(F(N)-(1+\gamma_{\rm E})\bigr)
 =A_N-\gamma_{\rm E}N-B_N.                              \tag{3}
\]
The [one-point factorial-ground criterion](goldbach-factorial-rational-screw-matrices.md)
therefore has the following exact finite arithmetic form:
\[
 \boxed{\quad\mathrm{RH}\quad\Longleftrightarrow\quad
 \exists C,N_0\ \forall N\ge N_0:\
 A_N\ge\gamma_{\rm E}N-C\sqrt N.\quad}                 \tag{4}
\]
Indeed, (3) and \(B_N=O(\log N)=O(\sqrt N)\) transfer either
inequality to the other after changing \(C\). The analytic converse in
the linked note uses the actual zeta-zero spectrum and a positive
Laplace-abscissa argument. Equation (4) does **not** prove its required
lower bound; bare positivity \(A_N\ge0\) is much weaker than the
linear main term \(\gamma_{\rm E}N\).

Ordinary succession gives an exact source-specific curvature. Set
\(A_1=0\). From (2), or directly from (1),
\[
 A_{N+1}-A_N
 =\log(N+1)-\sum_{d\le N}\frac{\Lambda(d)}d,
 \qquad
 A_{N+2}-2A_{N+1}+A_N
 =\log\frac{N+2}{N+1}-\frac{\Lambda(N+1)}{N+1}.
 \tag{5}
\]
The second difference retains the literal prime-power arrival at
\(N+1\); it has no general sign. For \(n\ge2\), put
\[
 b_n=\frac{\Lambda(n)}n-\log\frac{n+1}{n}.
\]
Then \(b_n=-\Delta^2A_{n-1}\), and its finite additive square has the
exact coefficient, for \(k\ge4\),
\[
 \begin{aligned}
 \sum_{\substack{i+j=k\\i,j\ge2}}b_i b_j
 ={}&\sum_{\substack{i+j=k\\i,j\ge2}}\frac{\Lambda(i)\Lambda(j)}{ij}
   -2\sum_{\substack{i+j=k\\i,j\ge2}}\frac{\Lambda(i)}i
                    \log\frac{j+1}{j}\\
   &+\sum_{\substack{i+j=k\\i,j\ge2}}
      \log\frac{i+1}{i}\log\frac{j+1}{j}.
 \end{aligned}                                             \tag{6}
\]
All pairs are ordered; the first term is a weighted Goldbach
prime-power coefficient, and the two centering terms are indispensable.
Equation (6) is additive convolution of factorial curvature, not the
original multiplicative distinct-prime \(V/W\) coefficient. A positive
square of its generating series does not upper-bound the one-sided
loading deficit in (4). Establishing that deficit from the linked
successor and pair histories is the open arithmetic task.

The finite prime-power ground identity is formalized in
[FactorialHOneFinite.lean](BuildingBlocks/FactorialHOneFinite.lean).
The exact factorial residue identity (2) is formalized in
[FactorialResidueFinite.lean](BuildingBlocks/FactorialResidueFinite.lean),
using the already formalized loading, nonnegativity, and successor identities
in [ResidueLoadingSuccessor.lean](BuildingBlocks/ResidueLoadingSuccessor.lean).
The curvature convolution (6) and the analytic implication in (4)
remain Lean obligations. The lower bound in (4) remains unproved.
