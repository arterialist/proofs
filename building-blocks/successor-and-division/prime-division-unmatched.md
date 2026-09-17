# Unmatched vertices in the prime-division graph

Every matching of squarefree integers using one-prime division edges leaves at least
```math
\boxed{\left(\frac{3}{\pi^2\sqrt{2\pi}}+o(1)\right)
\frac{N}{\sqrt{\log\log N}}}
\tag{1}
```
vertices unmatched as the actual integer cutoff $N$ tends to infinity. This excludes a square-root estimate obtained by matching along these edges and taking the absolute value of every unmatched Möbius coefficient. It does not bound their signed sum.

The graph has vertices the squarefree integers (1\le n\le N), including (1). An edge joins (n) and (pn\le N) for a prime (p\nmid n). Thus every edge reverses the actual sign $\mu(n)=(-1)^{\omega(n)}$. A matching means vertex-disjoint edges, with no acyclicity requirement on any associated discrete Morse construction. The bound concerns this one-prime edge graph; it is not an exclusion of all strict-divisor moves, successor-mediated moves, or endpoint pairings joined by longer paths.

Write
```math
Q_k(x)=\#\{n\le x:n\text{ squarefree},\ \omega(n)=k\},
\qquad A_K(x)=\sum_{k=0}^K Q_k(x).
```
For (x\ge1), (Q_0(x)=1). For every integer (K\ge1), take
```math
S=\{N/2<n\le N:n\text{ squarefree},\ \omega(n)\le K\}.
```
No vertex of (S) has an upward neighbor, because any proper multiple is at least (2n>N). Each downward neighbor is (n/p\le N/2) and has at most (K-1) prime factors. Hence (S) is independent and
```math
|S|=A_K(N)-A_K(N/2),\qquad
|\Gamma(S)|\le A_{K-1}(N/2).
```
A matching can cover at most $|\Gamma(S)|$ vertices of (S), since their matched neighbors must be distinct. This remains true although (S) contains both Möbius signs. Therefore the following finite inequality is exact:
```math
\boxed{\operatorname{unmatched}\ge
A_K(N)-2A_K(N/2)+Q_K(N/2).}
\tag{2}
```
The right side can be replaced by its positive part when it is negative.

The asymptotic input is the squarefree specialization of Selberg's uniform counting theorem. For fixed (B>0), uniformly over (1\le k\le B\log\log x), it gives
```math
Q_k(x)=W_k(x)\left[
G\!\left(\frac{k-1}{\lambda_x}\right)
+O_B\!\left(\frac{k}{\lambda_x^2}\right)\right],
\quad
W_k(x)=\frac{x}{\log x}\frac{\lambda_x^{k-1}}{(k-1)!},
\quad \lambda_x=\log\log x,
\tag{3}
```
where
```math
G(z)=\frac1{\Gamma(1+z)}
\prod_p(1+z/p)(1-1/p)^z,
\qquad G(1)=\prod_p(1-p^{-2})=\frac6{\pi^2}.
```
Selberg's Theorem 4 and its squarefree Euler-product specialization are on printed pages 85–86 of [*Note on a paper by L. G. Sathe*](https://people.clas.ufl.edu/alladik/files/selberg-note-on-a-paper-by-sathe-1953.pdf). The deduction here uses that uniform theorem, not a fixed-(k) asymptotic or the central limit theorem alone.

Put $\lambda=\log\log N$ and (K=\lfloor\lambda\rfloor). For sufficiently large (N), (3) applies at both (N) and (N/2) to every (k\le K), for example with (B=2). The error sum is (O(N/\lambda)), since (k=O(\lambda)) and
```math
\sum_{k\ge1}W_k(x)=\frac{x}{\log x}e^{\lambda_x}=x.
```
Also
```math
\lambda_{N/2}-\lambda=O(1/\log N).
```
For (k\le K), the ratios of the factorial weights at (N) and twice those at (N/2) are (1+O(1/\log N)), uniformly. The arguments of (G) differ by (O(1/(\lambda\log N))); (G) and (G') are bounded on the relevant compact real interval. Thus the summed main-term difference is (O(N/\log N)). Retaining (Q_0(N)-2Q_0(N/2)=-1), we obtain
```math
A_K(N)-2A_K(N/2)=O(N/\lambda).
\tag{4}
```
Finally (K-1=\lambda_{N/2}+O(1)). Stirling's formula in (3), together with (G(1)=6/\pi^2), gives
```math
Q_K(N/2)\sim
\frac{3}{\pi^2\sqrt{2\pi}}\frac{N}{\sqrt\lambda}.
\tag{5}
```
Substitution into (2) proves (1). No tail estimate, unimodality assertion, or estimate for the Mertens sum enters the argument. The conclusion is a lower bound on unmatched vertices, not an asymptotic formula for the maximum matching.

Longer paths change the problem. For example, a prime $\ell>N/2$ has only the neighbor (1), but it reaches any squarefree semiprime (pq\le N) by the three-edge path $\ell\to1\to p\to pq$. Endpoint matchings in this path closure may reuse the interior vertex (1), so the original leaf obstruction does not transfer to them. If the realizing paths must themselves be vertex-disjoint, at most one large-prime leaf can be matched, regardless of path length. These are different notions of pairing and should not be interchanged.

This is a written application of finite neighborhood counting and Selberg’s uniform squarefree-factor theorem, not a claim of a new counting theorem. Exact priority of this specialization is unresolved; no Lean formalization is claimed.
