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

[CoarsePrimitive.lean](../../formalization/BuildingBlocks/CoarsePrimitive.lean) verifies the finite primitive-energy inequalities and Mellin-block identity. [CoarsePrimitiveCriterion.lean](../../formalization/BuildingBlocks/CoarsePrimitiveCriterion.lean) now formalizes the sufficient implication from the all-epsilon, all-dyadic bound in statement 3 to full RH, including local uniform convergence, the zeta identity and zero exclusion. The converse from RH, the exact fourth-power version and the equivalence with eventual bounds remain written mathematics here. See the [formal theorem and verification](../zeta-and-zeros/coarse-conditional-rh.md).

## What a partial power saving would prove

The quartic criterion also has a quantitative intermediate form. It measures
any fixed improvement over the elementary fifth-power scale.

**Proposition.** Fix \(0<\delta\le1\). Suppose that for every
\(\varepsilon>0\),

$$
S_X\ll_\varepsilon X^{5-\delta+\varepsilon}.
\tag{8}
$$

at every sufficiently large dyadic \(X\). Then every nontrivial zero
\(\rho\) of \(\zeta\) satisfies

$$
\Re\rho\le1-\frac{\delta}{2}.
\tag{9}
$$

In particular, \(\delta=1\) implies RH.

To prove the proposition, first assume that, for some \(c\ge0\),

$$
e(t)\ll_\varepsilon t^{1-c+\varepsilon}.
\tag{10}
$$

Chebyshev's bound supplies the initial case \(c=0\). On a dyadic block put

$$
L_X=\sup_{X\le t\le2X}|e(t)|,\qquad
I_X=\int_X^{2X}|P_X(t)|^2dt.
$$

The function \(P_X\) starts at zero and is \(L_X\)-Lipschitz. The case
\(L_X=0\) is immediate. Otherwise, if the maximum modulus of \(P_X\) is
\(A\), an interval of length at least \(A/(2L_X)\) exists on which its
modulus is at least \(A/2\). Therefore

$$
\|P_X\|_\infty^3\le8L_XI_X.
\tag{11}
$$

Equations (8), (10), and \(I_X\le S_X\) give

$$
\|P_X\|_\infty
\ll_\varepsilon X^{\,2-(\delta+c)/3+\varepsilon}.
\tag{12}
$$

Let \(D(x)=\int_1^x e(t)\,dt\). Summing (12) across dyadic blocks gives the
same bound for \(D(x)\). For \(\Re s>1\), two integrations give

$$
\int_1^\infty D(x)x^{-s-2}\,dx
=\frac1{s+1}\left(
-\frac{\zeta'(s)}{s\zeta(s)}-\frac1{s-1}\right).
\tag{13}
$$

The bound for \(D\) continues the left side holomorphically to

$$
\Re s>1-\frac{\delta+c}{3}.
$$

The right side of (13) would have a pole at every zeta zero in that
half-plane. Hence no such zero exists. The classical equivalence between a
zero-free half-plane \(\Re s>\theta\) and the estimate
\(\psi(x)-x\ll_\varepsilon x^{\theta+\varepsilon}\), obtained by truncated
Perron inversion, then improves (10) to

$$
c_{\mathrm{new}}=\frac{\delta+c}{3}.
\tag{14}
$$

Starting from \(c_0=0\) and iterating (14) gives

$$
c_n=\frac{\delta}{2}(1-3^{-n}).
$$

Letting \(n\) increase proves (9). When \(\delta=1\), the functional
equation reflects any zero with real part below \(1/2\) to one above
\(1/2\), so all nontrivial zeros lie on the critical line.

This argument permits cancellation among zeros and uses only the assembled
energy. It does not infer a lower bound from one isolated zero. Conversely,
it explains why a fixed power saving in the remaining Möbius block is already
a zero-free-region theorem rather than a routine large-sieve refinement.
No novelty claim is made for this interpolation argument.
