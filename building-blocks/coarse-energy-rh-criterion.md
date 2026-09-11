# A dyadic primitive-energy criterion for RH

This written theorem concerns the actual Chebyshev function, including every prime power. It uses standard Mellin analysis and a classical conditional mean-square theorem. No originality claim is made.

For real $`x\ge1`$, define

```math
\psi(x)=\sum_{n\le x}\Lambda(n),\qquad e(x)=\psi(x)-x,
```

where $`\Lambda(p^a)=\log p`$ for primes p and integers $`a\ge1`$, and $`\Lambda(n)=0`$ otherwise. For $`X=2^k`$, $`k\ge0`$, put

```math
P_X(t)=\int_X^t e(x)\,dx,\quad
R_X(t)=\int_t^{2X}e(x)\,dx,\quad
S_X=\int_X^{2X}\bigl(|P_X(t)|^2+|R_X(t)|^2\bigr)\,dt.
```

**Theorem.** The following statements are equivalent.

1. The Riemann hypothesis holds.
2. There is a finite constant C such that $`S_{2^k}\le C2^{4k}`$ for every integer $`k\ge0`$.
3. For every $`\epsilon>0`$, there is a finite constant $`C_\epsilon`$, independent of k, such that $`S_{2^k}\le C_\epsilon2^{k(4+\epsilon)}`$ for every integer $`k\ge0`$.

In statements 2 and 3, it is equivalent to require the estimate only for all sufficiently large k. In statement 3 the starting index may depend on $`\epsilon`$.

**Proof.** Under RH, the classical conditional mean-square estimate is

```math
\int_X^{2X}|\psi(x)-x|^2\,dx\ll X^2.
```

This is stated in Brent, Platt and Trudgian, *The mean square of the error term in the prime number theorem*, Journal of Number Theory 238, 2022, printed p. 741, equation (1); their Theorem 1 gives an explicit asymptotic upper bound. The qualitative estimate is attributed there to Cramér. Cauchy–Schwarz on the prefix and suffix gives

```math
S_X\le X^2\int_X^{2X}|e(x)|^2\,dx\ll X^4.
```

Thus 1 implies 2, and 2 plainly implies 3. [Primary source](https://maths-people.anu.edu.au/~brent/pd/rpb274-final.pdf).

Assume 3. Set $`M_X=\int_X^{2X}e(x)\,dx`$. Since $`P_X(t)+R_X(t)=M_X`$,

```math
X|M_X|^2\le2S_X,\qquad \int_X^{2X}|P_X(t)|^2dt\le S_X.
\tag{1}
```

The function e is locally bounded and its primitive is absolutely continuous. For complex s, define the entire function

```math
I_X(s)=\int_X^{2X}e(x)x^{-s-1}\,dx,
\qquad x^{-s-1}=\exp(-(s+1)\log x).
```

Entire dependence follows by differentiating under this compact-interval integral. Integration by parts retains the terminal mass:

```math
I_X(s)=M_X(2X)^{-s-1}
+(s+1)\int_X^{2X}P_X(x)x^{-s-2}\,dx.
\tag{2}
```

For every nonempty compact $`K\subset\{\Re s>1/2\}`$, set $`a=\min_K\Re s>1/2`$. Equations (1)–(2) and Cauchy–Schwarz imply

```math
\sup_{s\in K}|I_X(s)|\le C_K\sqrt{S_X}\,X^{-a-3/2}.
\tag{3}
```

Choose a single $`0<\epsilon<2a-1`$. The right side of (3) is at most a constant times $`X^{1/2+\epsilon/2-a}`$, which is summable over $`X=2^k`$. Hence

```math
F(s)=\sum_{k=0}^{\infty}I_{2^k}(s)
\tag{4}
```

converges locally uniformly and is holomorphic on $`\Re s>1/2`$. Finitely many omitted initial blocks are entire and do not affect this conclusion. The construction uses complete dyadic blocks; no estimate for an arbitrary truncated endpoint is needed.

For $`\Re s>1`$, the integral defining F over $`[1,\infty)`$ converges absolutely, since $`\psi(x)\le x\log x`$. The absolutely convergent Euler product gives
$`-\zeta'(s)/\zeta(s)=\sum_{n\ge1}\Lambda(n)n^{-s}`$. Interchanging this sum with the integral therefore gives

```math
F(s)=\int_1^\infty e(x)x^{-s-1}\,dx
=-\frac{\zeta'(s)}{s\zeta(s)}-\frac1{s-1}.
\tag{5}
```

Here $`\int_n^\infty x^{-s-1}dx=n^{-s}/s`$ and $`\int_1^\infty x^{-s}dx=1/(s-1)`$. There is no missing endpoint constant at 1, and values at isolated jump points do not change the integrals. The Euler product and meromorphic continuation are the standard zeta identities recorded in [DLMF §25.2](https://dlmf.nist.gov/25.2).

For clarity, the normalized transform is

```math
G(s):=sF(s)=-\frac{\zeta'(s)}{\zeta(s)}-\frac{s}{s-1}.
\tag{6}
```

Consequently the alternative compensation $`-\zeta'/\zeta-1/(s-1)`$ equals $`1+G`$. Both sides of (6) are meromorphic on the connected half-plane $`\Re s>1/2`$, and agree on $`\Re s>1`$. The identity theorem extends their equality throughout that half-plane. The apparent singularity at 1 cancels because $`-\zeta'/\zeta=1/(s-1)+O(1)`$ there.

If ζ had a zero $`\rho`$ in this half-plane with multiplicity $`m\ge1`$, the right side of (6) would have residue $`-m`$ at $`\rho`$. Its compensation term is analytic there, since $`\rho\ne1`$. This contradicts the holomorphy of G from (4). Thus ζ has no zeros with $`\Re s>1/2`$. The functional equation reflects every nontrivial zero on the left of the critical line to one on its right, so RH follows. This covers all multiplicities. See the standard [reflection formulas](https://dlmf.nist.gov/25.4) and [nontrivial-zero symmetry](https://dlmf.nist.gov/25.10).

Finally, every $`S_{2^k}`$ is finite by local boundedness. Any finite initial range can therefore be absorbed into C or $`C_\epsilon`$, proving the stated eventual versions. ∎

The theorem reduces a proof of RH to an estimate on this actual energy. It establishes no such estimate unconditionally. A bound on finitely many dyadic blocks is insufficient; a single fixed positive $`\epsilon`$ only gives the smaller continuation region $`\Re s>1/2+\epsilon/2`$ by this argument. No separate intermediate-scale hypothesis is needed when statement 3 is available.

The companion [CoarsePrimitive.lean](BuildingBlocks/CoarsePrimitive.lean) verifies finite primitive-energy inequalities and the finite Mellin-block integration-by-parts identity. Local uniform convergence of (4), the global zeta identification, pole exclusion, and the conditional converse above are written mathematics in this page. They are not asserted to be Lean-checked by that finite module.
