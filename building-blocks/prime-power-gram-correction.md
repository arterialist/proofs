# A positive square formula for the complete prime-power overlap correction

This is a written mathematical proof for the full finite cutoff law. Its conclusions concern the stated auxiliary comparison or generator, not a sign of the full Weil form.

The [allocation identity](prime-allocation-critical-identity.md) supplies the arithmetic consumer. The proof below also gives an elementary decreasing-weight argument, so it does not require the stronger integer-dilation theorem.


Let $x>1$ and use the actual probability

$$
P_x(n)=\frac{x-n}{\sqrt n Z_x},\qquad
Z_x=\sum_{n<x}\frac{x-n}{\sqrt n}.
$$

Write

$$
F_x(d)=\sum_{kd<x}\frac{x-kd}{\sqrt k}
=dZ_{x/d},
\quad
\Gamma_x(d,e)=\sum_{n<x}\frac{x-n}{\sqrt n}
\mathbf 1_{d\mid n}\mathbf 1_{e\mid n}.
$$

Thus $\Gamma_x$ is a positive divisor Gram kernel and

$$
F_x(de)=Z_x\sqrt{de}\,P_x(de\mid n),\qquad
\sqrt{de}\,\Gamma_x(d,e)
=Z_x\sqrt{de}\,P_x([d,e]\mid n).
\tag{1}
$$

On the set of all actual prime powers, the full difference

$$
\boxed{K_x(d,e)=\sqrt{de}\,\Gamma_x(d,e)-F_x(de)}
\tag{2}
$$

is positive semidefinite. This holds for arbitrary finitely supported **signed** coefficients on prime powers, not only positive von Mangoldt weights. All powers are included and no scale or shared-prime correction is discarded. It is a statement about the auxiliary Gram comparison (2), not positivity of the Weil form or a sign of $W$.

## Actual divisibility tails are convex along every prime chain

Fix a prime $p$. Put

$$
t_j=P_x(p^j\mid n)\quad(j\ge1),\qquad
b_j=t_j-2t_{j+1}+t_{j+2}.
$$

These sequences eventually vanish. If $p^j<x$, exact divisibility conditioning gives

$$
\frac{t_{j+1}}{t_j}=P_{x/p^j}(p\mid n).
$$

The [integer-dilation theorem](prime-score-negative-covariance.md) implies

$$
P_y(p\mid n)=\frac{F_p(y)}{\sqrt p}\le\frac1p,
\qquad F_p(y)=\frac{pZ_{y/p}}{Z_y},
$$

where $F_p$ is increasing and tends to $p^{-1/2}$ as $y$ tends to infinity. If the lower cutoff is inactive the same inequality follows by zero extension. Hence

$$
0\le t_{j+1}\le t_j/p\le t_j/2,
\qquad
\boxed{b_j\ge0.}
\tag{3}
$$

In fact $b_j>0$ whenever $t_j>0$: the finite-cutoff divisibility probability is strictly below $1/p$, so $t_j-2t_{j+1}>0$ for $p=2$ as well. Only nonnegativity is needed below.

There is also a simpler finite proof of the strict divisibility bound, which removes any dependency on the dilation theorem. The weights $(y-n)/\sqrt{n}$ strictly decrease for $1\le n<y$. For every active multiple $pm<y$, the complete block $(m-1)p+1,\ldots,pm$ has total weight strictly greater than $p$ times the weight of $pm$. Summing these disjoint blocks and retaining the remaining nonnegative weights gives $P_y(p|n)<1/p$. If no multiple is active the probability is zero. Together with the exact conditional law this proves (3) directly.

## Exact discrete square decomposition

Let $(c_j)_{j\ge1}$ be any finitely supported real sequence and put

$$
u_j=\sum_{\ell=1}^j c_\ell,\qquad u_0=0.
$$

All sums weighted by $t_j$ or $b_j$ below are finite, even though the sequence $u_j$ may eventually be a nonzero constant. Discrete summation by parts gives

$$
\sum_{\ell,r\ge1}c_\ell c_r t_{\max(\ell,r)}
=\sum_{j\ge1}(t_j-t_{j+1})u_j^2,
\tag{4}
$$
$$
\sum_{\ell,r\ge1}c_\ell c_r t_{\ell+r}
=\sum_{\ell,r\ge1}b_{\ell+r}u_\ell u_r.
\tag{5}
$$

For (4), expand $t_{\max(\ell,r)}$ as the tail sum of $t_j-t_{j+1}$. For (5), substitute $c_j=u_j-u_{j-1}$ twice and shift the finite sums; no term remains at infinity because $t$ has finite support. At zero, $u_0=0$ eliminates both lower endpoint terms.

The exact row sum is

$$
\sum_{r\ge1}b_{\ell+r}=t_{\ell+1}-t_{\ell+2}.
$$

Subtracting (5) from (4) and completing differences therefore yields

$$
\boxed{
\begin{aligned}
\sum_{\ell,r\ge1}c_\ell c_r
\bigl[t_{\max(\ell,r)}-t_{\ell+r}\bigr]
={}&\sum_{j\ge1}b_j u_j^2\\
&+\frac12\sum_{\ell,r\ge1}b_{\ell+r}(u_\ell-u_r)^2.
\end{aligned}}
\tag{6}
$$

Both terms on the right are nonnegative by (3). Formula (6) is a positive square representation of the whole overlap correction, including its otherwise signed off-diagonal terms.

## Reassembling all actual prime generators

For two distinct primes $p\ne q$, the prime powers $p^\ell$ and $q^r$ are coprime. Their lcm is their product, so (1) gives

$$
K_x(p^\ell,q^r)=0.
$$

For one prime, (1) gives

$$
K_x(p^\ell,p^r)
=Z_x p^{(\ell+r)/2}
\bigl[t_{\max(\ell,r)}-t_{\ell+r}\bigr].
$$

Given finitely supported real coefficients $a_{p^j}$, apply (6) on each prime chain with $c_j=p^{j/2}a_{p^j}$, and then sum over primes. This proves (2) is positive semidefinite on the complete prime-power index set.

The identity also holds for complex coefficients after replacing products by their Hermitian polarization and all squares by absolute squares. Equivalently, apply the real formula to real and imaginary parts. No claim of matrix domination on **all** positive integers is made here; composite indices sharing several primes would require additional terms.

For the actual von Mangoldt coefficients the correction specializes to the already retained difference between the lcm same-prime moment $\mathbb E_x\sum_p m_p^2$ and the literal two-history same-prime allocation moment $\mathbb E_x\sum_p t_p(v_p(n))$. Formula (6) supplies its positive square decomposition for arbitrary signed coefficients on each prime-power chain. The density reference has composite divisor coefficients, so this theorem alone does not control its interaction with the prime vector or prove the full $W$ sign.
