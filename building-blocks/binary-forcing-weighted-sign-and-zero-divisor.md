# Binary forcing: weighted signs and the exact zero divisor

Independent deduction from the complete-history construction's complete binary cofactor identity and Wallis estimates. Written proof only; no novelty or Lean claim.

Put $E(x)=\psi(x)-x$, $h_n=\sum_{m\le n}(-1)^{m+1}/m$, and
$B(x)=\log(\lfloor x\rfloor!)-2\log(\lfloor x/2\rfloor!)-xh_{\lfloor x\rfloor}$.

## Every within-block primitive is negative

For $k\ge1$, write $b=B(2k)$ and $o=B(2k+1)$. The reviewed Wallis and harmonic bounds give

$$b<\tfrac12-\tfrac12\log(3k+1)<0,$$

and, since $o=b+\log(2k+1)-h_{2k}-1$,

$$b+o<\log\frac{2k+1}{3k+1}-h_{2k}<0.$$

Each integer cell is decreasing. Thus for $2k<t\le2k+1$ its prefix integral is negative. For $2k+1<t\le2k+2$, the first cell integral is at most $b$, while the second prefix is at most $\max(o,0)$. Their sum is negative by the two inequalities. Consequently

$$P_k(t):=\int_{2k}^t B(x)\,dx<0\qquad(2k<t\le2k+2).$$

For positive nonincreasing absolutely continuous $w$ on the block, integration by parts yields

$$\int_{2k}^{2k+2}wB=w(2k+2)P_k(2k+2)-\int_{2k}^{2k+2}w'P_k<0.$$

The origin block $[1,2)$ has $B(x)=-x$. Therefore, for every real $\sigma>0$,

$$\int_1^\infty B(x)x^{-\sigma-1}\,dx<0.$$

Absolute convergence follows from $B(x)=O(\log(2x))$. This is a genuine weighted consequence, not an inference from only the full-block sign.

## What the complete history multiplier does to zeros

For $\Re s>1$, finite cofactor Fubini followed by absolute convergence gives

$$\widehat B(s)=\eta(s)\widehat E(s),\qquad
\widehat E(s)=-\frac{\zeta'(s)}{s\zeta(s)}-\frac1{s-1},\qquad
\eta(s)=(1-2^{1-s})\zeta(s).$$

Hence the exact continued forcing transform is

$$\widehat B(s)=-(1-2^{1-s})\left(\frac{\zeta'(s)}s+\frac{\zeta(s)}{s-1}\right).$$

It extends holomorphically to $\Re s>0$ because its apparent singularity at $s=1$ is removable, with value $-(1+\gamma)\log2$. In particular the history multiplier cancels the logarithmic-derivative poles at every zeta zero, not only artificial dyadic replicas.

At a nontrivial zero $\rho$,

$$\widehat B(\rho)=-(1-2^{1-\rho})\frac{\zeta'(\rho)}\rho.$$

For a multiple zero the forcing transform also vanishes there; for a simple zero it generally does not. Thus the new weighted real sign cannot by itself exclude off-line zeros. Reconstructing $E$ requires division by $\eta$, including the actual zeta divisor, with its original phase retained. The constructive next target is a compatibility or divisibility constraint strong enough to bound this inverse, rather than positivity of the already regular forcing alone. The exact forcing identities and weighted signs remain useful arithmetic constraints.
