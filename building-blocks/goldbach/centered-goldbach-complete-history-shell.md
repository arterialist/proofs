# Complete Möbius histories in the finite Goldbach heat shell

Fix $Y\geq1$ and retain the literal ordered additive pairs
$1\leq m,n\leq Y$ with $m+n=N$. Every von Mangoldt coefficient has its
complete divisor history

$$
\Lambda(m)=\sum_{de=m}\mu(d)\log e.
\tag{1}
$$

The identity includes every prime power. Substitution into the prime-prime
part $P_Y(N)$ of the centered heat shell gives the finite quadruple sum

$$
P_Y(N)=
\sum_{\substack{d,e,f,g\geq1\\de,fg\leq Y\\de+fg=N}}
\mu(d)\mu(f)\log e\log g.
\tag{2}
$$

There is no infinite rearrangement. Equation (2) simply reindexes the
ordered pair $(m,n)$ by both divisor pairs $(d,e)$ and $(f,g)$. The
conditions $de,fg\leq Y$ keep the upper transition layer exactly.

Split (2) by equal and distinct divisor labels:

$$
P_Y(N)=D_Y(N)+O_Y(N),
\tag{3}
$$

where $D_Y$ contains $d=f$ and $O_Y$ contains $d\ne f$. In the matching
part, $N=d(e+g)$, so $d\mid N$. Equivalently,

$$
\boxed{
D_Y(N)=\sum_{d\mid N}\mu(d)^2
 \sum_{\substack{e,g\geq1\\de,dg\leq Y\\e+g=N/d}}
 \log e\log g.
}
\tag{4}
$$

This formula makes the parity restriction explicit. An odd total has only
odd matching labels $d$, and then $e+g$ is odd. At an even total, both
parities of $d$ may occur. Every summand of (4) is nonnegative.

## A signed arithmetic constraint and its limit

The $d=1$ part of $D_Y(N)$ is already the full bounded logarithmic
convolution. For each ordered pair $m,n\geq1$,

$$
\operatorname{diag}(m,n)\geq\log m\log n
\geq\Lambda(m)\Lambda(n).
\tag{5}
$$

The second inequality follows from $0\leq\Lambda(k)\leq\log k$. Since
$\Lambda(m)\Lambda(n)=\operatorname{diag}(m,n)+
\operatorname{off}(m,n)$, this proves the **pairwise sign**

$$
\boxed{\operatorname{off}(m,n)\leq0,
\qquad O_Y(N)\leq0.}
\tag{6}
$$

This is a genuine finite sign constraint for the complete Möbius
histories, stronger than merely knowing the full prime-prime packet is
nonnegative. It is not a quantitative cancellation estimate: the
matching-label block contains the much larger $d=1$ logarithmic pair,
and (6) provides no lower bound on the magnitude of its negative
correction. Dropping $O_Y$ would replace the prime-prime term by this
coarse logarithmic convolution and lose the centering needed for a heat
scale upper bound.

The first nonzero correction appears in the literal block $Y=4,N=6$.
The ordered pairs are $(2,4),(3,3),(4,2)$, and the $4=2^2$ history is
retained. Direct evaluation gives

$$
O_4(6)=-2(\log2)^2<0,
\quad
P_4(6)=2(\log2)^2+(\log3)^2,
\quad
D_4(6)=4(\log2)^2+(\log3)^2.
\tag{7}
$$

The centered coefficient still includes the two ordered density
marginals and pair count:

$$
c_4(6)=P_4(6)-2(2\log2+\log3)+3.
\tag{8}
$$

Thus the sign (6) alone does not control the centered shell increment.
The missing arithmetic input would be a *quantitative* lower bound for
$-O_Y(N)$, or a cancellation estimate after weighting all additive
totals by the positive shell kernel, at the scale needed to offset the
matching-label and density terms.

## Lean scope

[CenteredGoldbachHistoryShellFinite.lean](../../formalization/BuildingBlocks/CenteredGoldbachHistoryShellFinite.lean)
formalizes the complete divisor-pair substitution, matching/distinct
split, the necessary condition $d\mid N$ and its odd-total consequence,
diagonal nonnegativity, inequality (5), pairwise and aggregate
nonpositivity in (6), and the exact negative value in (7). The compact
single-sum presentation (4) is derived here by finite reindexing; the
Lean module certifies its divisor and sign ingredients but does not state
that display as a standalone theorem. All public axiom reports list only
`propext`, `Classical.choice`, and `Quot.sound`. No bound toward RH follows.
