# A sufficient reciprocal-defect region for quartic Jensen polynomials

Let $\gamma_n,\ldots,\gamma_{n+4}$ be positive. Put

```math
r_j=\frac{\gamma_{j+1}}{\gamma_j},\qquad
\delta_j=1-\frac{r_{j+1}}{r_j},\qquad \lambda_j=\delta_j^{-1},
```

for the three relevant defects, which are assumed positive. If

```math
\lambda_n\ge5,\qquad
1\le\lambda_{n+1}-\lambda_n\le3,\qquad
1\le\lambda_{n+2}-\lambda_{n+1}\le3,
```

then $J^{4,n}(X)=\sum_{j=0}^4\binom4j\gamma_{n+j}X^j$ has four distinct negative zeros. No ordering between the two displayed slopes is required.

This is a sufficient finite-coefficient region, not a characterization of hyperbolicity. In particular it establishes no all-degree criterion for the actual xi coefficients. The classical Hermite criterion and coefficient geometry are the methods; related five-coefficient quartic normalizations appear in [Dimitrov–Kostov, *Sharp Turán inequalities via very hyperbolic polynomials*](https://doi.org/10.1016/j.jmaa.2010.12.014). No priority claim is made for the region below.

## Reduction to strict Hermite positivity

Write $L=\lambda_n$, $S=\lambda_{n+1}-\lambda_n$, $T=\lambda_{n+2}-\lambda_{n+1}$, $M=L+S$, and $N=M+T$. Set

```math
q=1-L^{-1},\qquad p=1-M^{-1},\qquad w=1-N^{-1}.
```

After the positive rescaling $y=r_nX$ and division by $\gamma_n$, the polynomial is

```math
1+4y+6qy^2+4q^2py^3+q^3p^2wy^4.
```

Its monic coefficients are

```math
a=\frac4{qpw},\quad b=\frac6{q^2p^2w},\quad
c=\frac4{q^3p^2w},\quad d=\frac1{q^3p^2w}.
```

Translation by $-a/4$ gives $z^4+Az^2+Bz+C$, where

```math
A=b-3a^2/8,\quad B=c-ab/2+a^3/8,\quad
C=d-ac/4+a^2b/16-3a^4/256.
```

Newton's identities give the first four leading determinants of its Hermite matrix as

```math
\Delta_1=4,\quad \Delta_2=-8A,\quad
\Delta_3=-8A^3+32AC-36B^2,
```

```math
\Delta_4=256C^3-128A^2C^2+144AB^2C-27B^4+16A^4C-4A^3B^2.
```

Here

```math
A=-\frac{6L^2M^2N}{(L-1)^2(M-1)^2(N-1)^2}<0.
```

Define the polynomials $P_3,P_4$ by the following exact factorizations, together with the rational expressions above:

```math
\Delta_3=\frac{192L^5M^4N^2}{(L-1)^6(M-1)^6(N-1)^4}P_3,
\qquad
\Delta_4=\frac{256L^9M^6N^3}{(L-1)^{12}(M-1)^{10}(N-1)^6}P_4.
```

For example,

```math
\begin{aligned}
P_3={}&L^2(S-T+6)+L(2S^2+3S-3T^2+3T+1)\\
&+S^3+S^2T-3S^2-2ST+3S+T-1.
\end{aligned}
```

All exterior factors are positive on the stated region.

## The finite polynomial positivity calculation

Substitute $L=5+x$, $S=1+2u$, $T=1+2v$, where $x\ge0$ and $0\le u,v\le1$. Expand each coefficient of $x^j$ in the tensor Bernstein basis on the square. The following lower bounds hold for every Bernstein coefficient of the corresponding coefficient polynomial:

| Polynomial | Powers of $x$, descending | Lower bounds |
|---|---|---|
| $P_3$ | $2,1,0$ | $4,28,40$ |
| $P_4$ | $4,3,2,1,0$ | $64,1312,7248,14080,3200$ |

This is exact rational polynomial arithmetic. To specify the calculation completely, one may use common bidegree $(7,7)$ for every row. If the power expansion of a coefficient polynomial is $\sum c_{ab}u^av^b$, its Bernstein coefficient at $(i,j)$ is

```math
\beta_{ij}=\sum_{a\le i,\,b\le j}c_{ab}
\frac{\binom ia}{\binom7a}\frac{\binom jb}{\binom7b},
\qquad 0\le i,j\le7.
```

Substitution in the displayed definitions of $P_3,P_4$ gives the listed bounds. All these coefficient polynomials have bidegree at most $(7,7)$; elevation from their individual degrees preserves the bounds because it takes convex combinations of Bernstein coefficients. The basis is nonnegative and sums to one, so

```math
P_3\ge4x^2+28x+40>0,
```

```math
P_4\ge64x^4+1312x^3+7248x^2+14080x+3200>0.
```

Hence all four leading Hermite determinants are strictly positive. Strict Sylvester positivity implies that the Hermite matrix is positive definite. Its quadratic form on a real polynomial $f$ of degree at most three is the sum of $f$ evaluated at the four roots and squared. Repeated roots make it singular. For distinct roots with a nonreal pair, conjugation-compatible interpolation gives real $f$ taking values $i,-i$ on that pair and zero on the other roots, making the quadratic form $-2$. Both cases contradict positive definiteness. Thus the four roots are real and distinct. Their positive coefficients and positive constant term exclude nonnegative roots.

Strict positivity is essential here. Nonnegative leading determinants alone do not imply positive semidefiniteness in degenerate cases. Also, a Bernstein-basis polynomial certificate is unrelated to representing a sequence as samples of a Bernstein function.

The accompanying [exact symbolic checker](certificates/check_quartic_reciprocal_defect_region.py) derives both Hermite polynomials and verifies every displayed Bernstein bound. Install SymPy with `python3 -m pip install sympy`, then run `python3 certificates/check_quartic_reciprocal_defect_region.py` from this directory. It uses exact rational arithmetic and no external data.
