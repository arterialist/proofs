# Prime-subset successor bars and a constant Hodge gap

Status: an exact finite-dimensional obstruction to deriving Möbius cancellation from a weighted Hodge gap or successor exactness alone. No RH progress is claimed. Checked 2026-09-16.

The underlying complex is the squarefree prime-subset complex studied by Anders Björner, [*A cell complex in number theory*, arXiv:1101.5704](https://arxiv.org/pdf/1101.5704), especially Theorem 3.1. Its homology dimensions are known. The argument below writes the standard cone contraction as an explicit filtered chain reduction and chooses a compatible positive inner product. It does not assert a new topological invariant.

## Exact filtered decomposition

For \(X\ge1\), let \(C_q(X)\) have basis \(e_S\), where \(S\) is a finite set of primes, \(|S|=q\), and \(m(S):=\prod_{p\in S}p\le X\). Include \(e_\varnothing\) in degree zero. Use the ordered simplicial boundary, with \(\partial e_{\{p\}}=e_\varnothing\). This is the augmented simplicial complex with degrees shifted by one. Thus

\[
\operatorname{Str}I_{C(X)}
=\sum_q(-1)^q\dim C_q(X)
=\sum_{n\le X}\mu(n)=M(X).
\]

For each subset \(S\) of odd primes, write \(h e_S=e_{\{2\}\cup S}\), with \(2\) ordered first, and define

\[
b_S=h e_S,\qquad z_S=e_S-h\partial e_S.
\]

The cone identity \(\partial h+h\partial=I\) gives

\[
\partial z_S=0,\qquad \partial b_S=z_S.
\tag{1}
\]

The basis change is filtration preserving. Every term of \(h\partial e_S\) has product \(2m(S)/p<m(S)\), since \(p\ge3\). Consequently \(z_S\) is born at \(m(S)\), while \(b_S\) is born at \(2m(S)\). Also \(e_S=z_S+h\partial e_S\), so the change of basis is invertible at every cutoff.

Therefore the complete filtered chain complex is the direct sum, over odd squarefree \(m=m(S)\), of the elementary complexes

\[
\mathbb C b_S\xrightarrow{\;1\;}\mathbb C z_S,
\quad
\deg b_S=|S|+1,\quad\deg z_S=|S|,
\]

with the two generators entering at \(2m\) and \(m\), respectively. Its persistent homology consists exactly of bars \([m,2m)\), in degree \(\Omega(m)\) under our shifted convention. The case \(m=1\) is included.

## A positive metric with spectral gap one

Declare all \(z_S,b_S\) orthonormal once and for all, and restrict this inner product to each \(C(X)\). It is positive and compatible with every successor inclusion. It is generally not diagonal in the original face basis; no uniformly bounded comparison with that original metric is asserted.

For \(\Delta_X=\partial\partial_X^*+\partial_X^*\partial\), equation (1) gives

\[
\Delta_X=
\begin{cases}
I&\text{on each completed pair }(z_S,b_S),\quad 2m\le X,\\
0&\text{on each surviving }z_S,\quad m\le X<2m.
\end{cases}
\]

Thus every nonzero eigenvalue is exactly one, unconditionally and at every cutoff. Nevertheless, for every \(t\ge0\),

\[
\operatorname{Str}e^{-t\Delta_X}
=\sum_{\substack{X/2<m\le X\\m\ {\rm odd,\ squarefree}}}\mu(m)
=M(X).
\tag{2}
\]

Completed pairs cancel in the supertrace. The unpaired harmonic states carry the entire signed sum. Their total number is asymptotic to \(2X/\pi^2\), as in Björner's theorem. A uniform gap on the nonzero spectrum therefore cannot, by itself, supply RH-scale cancellation between their two parities.

This conclusion also applies to the original orthonormal face metric, by established results. The prime-subset complex is shifted: replacing a prime by a smaller absent prime decreases the product. Duval and Reiner proved that shifted complexes have integral combinatorial Laplacian spectra in [*Shifted simplicial complexes are Laplacian integral*, Trans. AMS 354 (2002), 4313–4344](https://doi.org/10.1090/S0002-9947-02-03082-9). The precise convention is verified in [Duval, *A common recursion for Laplacians of matroids and shifted simplicial complexes*](https://arxiv.org/pdf/math/0310327), introduction and Section 2: the full operator is \(L_i=\partial_{i+1}\partial_{i+1}^*+\partial_i^*\partial_i\), in the natural face basis, with reduced homology as its kernel. Its nonzero eigenvalues are therefore at least one at every cutoff. This canonical-metric gap is prior art, not a consequence peculiar to the custom metric above.

## What weights and successor cones preserve

More generally, consider a boundary supported on the original face incidences,
\[
d e_S=\sum_{p\in S}(-1)^{\operatorname{pos}(p,S)-1}
a(S,p)e_{S\setminus\{p\}},
\qquad a(S,p)\ne0.
\]
The condition \(d^2=0\) forces
\[
a(S,p)a(S\setminus\{p\},q)
=a(S,q)a(S\setminus\{q\},p).
\]
Products along deletion paths to \(\varnothing\) are therefore independent of the path. They define nonzero \(w(S)\) with
\[
a(S,p)=\frac{w(S)}{w(S\setminus\{p\})},
\qquad d=W^{-1}\partial W,\quad We_S=w(S)e_S.
\]
This is the usual flat scalar incidence reweighting. Even arbitrary differentials on the same finite graded spaces preserve their Euler characteristic by rank-nullity. For any positive graded inner product, the corresponding Hodge heat supertrace remains \(M(X)\).

Finally, the successor quotient \(C(N+1)/C(N)\) is zero unless \(N+1\) is squarefree. In that case it has one generator in degree \(\Omega(N+1)\) and zero differential, because every proper face has already entered. The inclusion mapping cone has the same relative homology. Its Euler identity is precisely
\[
M(N+1)-M(N)=\mu(N+1).
\]
Thus the exact boundary-of-boundary and successor laws already couple the complete filtration, but their remaining signed boundary flux is the original Möbius sequence. A stronger conclusion requires an estimate on those unpaired states or additional structure beyond these identities and the nonzero Hodge gap.
