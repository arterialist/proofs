# Stability obstructions for squarefree cutoff polynomials

For an integer $N\ge1$, define

```math
Z_N(\mathbf z)=\sum_{\substack{n\le N\\n\text{ squarefree}}}\prod_{p\mid n}z_p,
\qquad P_N(t)=Z_N(t,t,\ldots).
```

This is the face-generating polynomial of the simplicial complex of prime subsets whose product is at most $N$. In particular $P_N(-1)=\sum_{n\le N}\mu(n)$. This squarefree-prime complex and its relation to the Mertens function are classical; see [Björner, *A cell complex in number theory*](https://arxiv.org/abs/1101.5704). The finite examples below distinguish its cutoff law from several sufficient positivity mechanisms. They do not determine the sign or size of the Mertens function.

## Real stability fails for the actual cutoff

A real polynomial is real stable if it is nonzero whenever all its variables have positive imaginary part. At $N=6$,

```math
Z_6=1+z_2+z_3+z_5+z_2z_3.
```

Its Rayleigh difference for $z_2,z_3$ is

```math
\partial_2Z_6\,\partial_3Z_6-Z_6\partial_2\partial_3Z_6=-z_5.
```

It is negative at positive $z_5$. Thus $Z_6$ fails the necessary Rayleigh inequality for real multiaffine stable polynomials. This criterion and its probabilistic consequences belong to [Borcea–Brändén–Liggett, *Negative dependence and the geometry of polynomials*](https://arxiv.org/abs/0707.2340).

The same support cannot be repaired by any strictly positive coefficient tilt. Indeed, for $a,b,c,d,e>0$, the polynomial $a+bx+cy+dz+exy$ has Rayleigh difference $bc-ae-edz$, which is negative for sufficiently large positive $z$. This excludes every positive Boltzmann tilt on this exact support, rather than merely its uniform law.

Diagonal real-rootedness also fails, though it is weaker than multivariate stability. Counting prime subsets gives

```math
P_{114}(t)=1+30t+32t^2+9t^3.
```

There are $30$ primes at most $114$. The counts of pairs with least prime $2,3,5,7$ are respectively $15,10,5,2$. There are six triples $2\cdot3\cdot p$, two triples $2\cdot5\cdot p$, and the triple $3\cdot5\cdot7$; no four-prime product is at most $114$. The discriminant is $-28139$, so this cubic has two nonreal roots. No claim that $114$ is the first failure is needed.

## Conditioning on the number of prime factors does not repair stability

The degree-two layer at $N=15$ has polynomial

```math
Q=z_2z_3+z_2z_5+z_2z_7+z_3z_5.
```

The upper-half-plane values

```math
z_2=i,\qquad z_3=z_5=1+i/4,\qquad z_7=-5/2+7i/16
```

give $Q=0$ by direct substitution. Its support also fails the basis-exchange property: between $\{2,7\}$ and $\{3,5\}$, removing $2$ from the former admits neither $3$ nor $5$ as a replacement.

The degree-two support also fails under every positive coefficient tilt: for $Q=axy+bxz+cxw+dyz$ with $a,b,c,d>0$, its Rayleigh difference in $x,w$ is $-cd\,yz<0$ at positive $y,z$.

Under the uniform law on its four monomials, let $C$ be the covariance matrix of the prime-indicator vector, in the order $2,3,5,7$. Direct counting gives

```math
C=\frac1{16}\begin{pmatrix}
3&-2&-2&1\\-2&4&0&-2\\-2&0&4&-2\\1&-2&-2&3
\end{pmatrix}.
```

In particular the indicators of $2$ and $7$ have positive covariance. For $v=(1,0,0,-1)$,

```math
v^TCv=1/4,\qquad |v|^TC|v|=1/2.
```

Thus this covariance energy does not satisfy the usual absolute-value contraction of a graph Dirichlet form.

## A general constraint on projected covariance

Let $C$ be any real covariance matrix on a fixed-cardinality law, so $C\mathbf1=0$. For a vector $\ell$ with $\ell^TC\ell>0$, remove its linear regression direction:

```math
C_\perp=C-\frac{C\ell\ell^TC}{\ell^TC\ell}.
```

Then $C_\perp$ is positive semidefinite and annihilates both $\mathbf1$ and $\ell$. If its off-diagonal entries were all nonpositive, the row-sum identity would give

```math
v^TC_\perp v=\sum_{i<j}(-C_{\perp,ij})(v_i-v_j)^2.
```

Taking $v=\ell$, if all entries of $\ell$ are distinct, forces every off-diagonal entry to vanish, and then every diagonal entry vanishes too. Therefore a nonzero projected covariance of this kind cannot simultaneously be a graph Laplacian. For prime coordinates the entries $\ell_p=\log p$ are distinct.

These results exclude specific stability and Dirichlet-form arguments for the actual cutoff law. They neither exclude other correlations nor turn these finite failures into an assertion about zeta zeros. The inputs are exact enumeration, the classical real-stability criterion and elementary covariance projection; no novelty or Lean-formalization claim is made.
