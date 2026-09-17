# Exact counterexample to one Table 1 bound

Bellotti, Trudgian, and Yang, [*Zero-free regions inspired by work of
Heath-Brown*](https://arxiv.org/abs/2603.21490v1), Table 1, state the
certified bound
\[
G_5(1,x)>0.00735709\qquad(x\in\mathbb R).
\]
Their stated coefficients do not satisfy this bound. With
\(y=\cos x=-78647/1000000\), the exact rational evaluation of their
polynomial and all fifteen retained prime powers gives
\[
0.00735649<G_5(1,\arccos y)<0.00735650<0.00735709.
\]
The [integer-arithmetic certificate](bellotti-trudgian-yang-table1-p5.py)
reconstructs the paper's coefficients \(a_k\) from its integers \(c_k\),
checks its printed \(a_0\) and \(a_1\), and proves both strict comparisons by
integer cross-multiplication. It uses the recurrence
\[
U_0=1,\quad U_1=-78647,\quad
U_j=2(-78647)U_{j-1}-1000000^2U_{j-2},
\quad U_j=1000000^jT_j(y).
\]

This refutes the individual \(p=5\) certificate, not Lemma 10 or the
paper's zero-free theorem. Their aggregate estimate has slack, but a
replacement global lower bound for \(G_5\) needs its own certificate.

Original claim and coefficients: Bellotti, Trudgian, and Yang (2026).
Counterexample and exact-arithmetic check: proofs project (17 September 2026).
