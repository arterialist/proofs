# The actual-prime budget of a microscopic successor band

This note bounds the part of the odd Weil prime graph coming from
shifts in one short band next to the maximal displacement \(2a\).
It explains why control of adjacent-prime or \(+1\) differences in
such a band cannot by itself pay the full \(e^a\) Schur row. Every
prime power in the band is retained. The estimate says nothing about
the sum across many bands.

Let \(a\ge1\), \(0<w\le1\), \(X=e^{2a}\), and
\[
\mathcal B_a(w)=\{n\ge2:\Lambda(n)>0,
                         \ 2a-w<\log n<2a\},
\qquad
M_a(w)=\sum_{n\in\mathcal B_a(w)}\frac{\Lambda(n)}{\sqrt n}.
\tag{1}
\]
On \(I_a=(-a,a)\), let \(P_{a,w}\) be the sum of the two
zero-extended shifts with these coefficients. For
\(\phi(x)=\cosh(x/2)\), set
\(r_{a,w}=P_{a,w}\phi/\phi\) and let \(D_{a,w}\) be its exact
weighted graph form, as in
[the complete graph identity](../prime-distribution/prime-shift-weighted-schur-window-asymptotic.md).

**Band-budget lemma.** Uniformly for \(a\ge1\) and \(0<w\le1\),
\[
\boxed{\begin{aligned}
M_a(w)&\le 2a e^{-a+w/2}\bigl(e^{2a}w+1\bigr),\\
\|P_{a,w}\|&\le2M_a(w),\\
0\le r_{a,w}(x)&\le e^{w/2}M_a(w)\quad\text{a.e.},\\
0\le D_{a,w}[F]&\le2e^{w/2}M_a(w)\|F\|_2^2.
\end{aligned}}
\tag{2}
\]
The same inequalities hold after restriction to odd functions.
At the logarithmic spacing of successive integers near \(X\), namely
\(w\asymp X^{-1}=e^{-2a}\), all four budgets in (2) are
\(O(ae^{-a})=o(1)\). Even the wider band \(w=e^{-a}\) has
\(M_a(w)=O(a)=o(e^a)\).

For every *fixed* \(w>0\), the prime number theorem and partial
summation give
\[
M_a(w)=\bigl(2+o(1)\bigr)e^a(1-e^{-w/2}).
\tag{3}
\]
Consequently, if \(w_a\downarrow0\) in any manner, then
\(M_a(w_a)=o(e^a)\), and the same is true for the operator and graph
budgets in (2). This last assertion requires no prime number theorem
uniform in shrinking short intervals: for any fixed \(\delta>0\),
eventually \(w_a<\delta\), so monotonicity and (3) bound the
limsup of \(M_a(w_a)/e^a\) by
\(2(1-e^{-\delta/2})\), which tends to zero with \(\delta\).

**Proof of (2).** The interval \((Xe^{-w},X)\) contains at most
\(X(1-e^{-w})+1\le Xw+1\) integers. On it,
\(\Lambda(n)\le\log n<2a\) and
\(n^{-1/2}\le X^{-1/2}e^{w/2}\). Multiplying these bounds proves
the first line. Each translated zero-extension has \(L^2\) norm at
most one, proving the second.

Every displacement in the band exceeds \(a\), since
\(2a-w\ge a\). Thus each edge joins two opposite endpoint strips.
If \(y=x+\log n\in I_a\), write \(x=-a+s\), \(y=a-t\), with
\(0<s,t<w\). Then
\(|\log\phi(y)-\log\phi(x)|\le|s-t|/2\le w/2\), since
\(|(\log\phi)'|\le1/2\). The same bound holds in the reverse
orientation. For each \(n\), the two orientations cannot contribute
at the same \(x\). Hence the weighted row is at most
\(e^{w/2}\sum_{n\in\mathcal B_a(w)}\Lambda(n)/\sqrt n\), which is
the third line. Finally, \(|z-z'|^2\le2(|z|^2+|z'|^2)\) in the
exact graph identity gives
\(D_{a,w}[F]\le2\int r_{a,w}|F|^2\), proving the fourth.
\(\square\)

The full prime row satisfies \(C_a=(1+o(1))e^a\). A microscopic
successor band can therefore account for only a vanishing fraction of
the full Schur-scale graph budget, even if its local phase or
adjacent-prime relations are controlled perfectly. A successful
all-prime signed estimate would have to combine information across a
nonshrinking logarithmic range of prime shifts, or supply a different
mechanism for the remaining terms. Equation (2) neither bounds the
complete graph deficit nor determines the sign of the Weil form.
