# A uniform square-sum constraint for the actual successor driver

This written proof applies classical Fourier/Plancherel and one-dimensional Sobolev sampling to the exact arithmetic driver. Its completed-source membership uses the linked PNT-based cutoff theorem. No result below is formalized in Lean.

Use original physical $L^2(dx)$, with functions extended by zero below their causal support. For the actual frozen source $g_N$, $N\ge2$, define
$$
 e_N(u)=\frac12\int_1^\infty
       [g_N(x+u+1)-g_N(x+u)]x^{-1/2}dx,\qquad u\in\mathbb R.
\tag{1}
$$
At nonnegative integer $u=j$, this is exactly the driver
$e_{N,j}=\delta(S^jg_N)=Q(S^{j+1}g_N)-Q(S^jg_N)$
in [the literal compensated-iterate theorem](literal-compensated-successor-iterates.md). We prove
$$
 \boxed{\sum_{j\ge0}|e_{N,j}|^2
       \le\frac{64}{1-\cos1}\,\mathcal E(g_N).}
\tag{2}
$$
Thus the [established uniform original mixed-energy bound for the natural cutoffs](../dynamics-and-feedback/natural-arrival-cutoff-completion.md) gives a uniform square-sum bound for their entire actual arithmetic drivers. This statement does not invoke a bounded charge functional on unrestricted $L^2$.

We then compute the norm cost of using this constraint in the actual renewal representation. Its correlated seed synthesis has sharp order $\sqrt k$ as a map from $\ell^2$ to original $L^2$. That is a limitation of the bound alone, not a lower bound for the signed actual source.

## 1. The integral and its exact full-line multiplier

For fixed finite $N$, the integral (1) is absolute for every real $u$. The source is locally bounded, and sufficiently far to the right it is $E_\psi(N)/x$. Its unit difference is then $O_N(x^{-2})$, locally uniformly in $u$. Each of the two charge integrals is also absolute at this finite cutoff. All actual jumps, the frozen terminal tail, and the lower integration cutoff at $x=1$ remain.

Let
$$
 K(x)=\mathbf1_{x\ge1}x^{-1/2},\qquad
 \check K(x)=K(-x),\qquad \tau_1g(x)=g(x+1).
$$
Then (1) is exactly $\tfrac12\check K*(\tau_1-I)g_N$. With Fourier convention
$\widehat g(\xi)=\int e^{-i\xi x}g(x)dx$, its multiplier is
$$
 m(\xi)=\tfrac12(e^{i\xi}-1)I(\xi),\qquad
 I(\xi)=\int_1^\infty x^{-1/2}e^{i\xi x}dx,\quad \xi\ne0.
\tag{3}
$$
The integral in (3) is the actual oscillatory limit. Integration by parts gives
$$
 |I(\xi)|\le2/|\xi|,\qquad |\xi|\ge1.
\tag{4}
$$
For $0<|\xi|\le1$, split at $R=|\xi|^{-1}$. The first piece is bounded by $2\sqrt R$; integration by parts on the remaining tail bounds it by $2/(|\xi|\sqrt R)$. Consequently
$$
 |I(\xi)|\le4|\xi|^{-1/2}.
\tag{5}
$$
Combining $|e^{i\xi}-1|\le\min(|\xi|,2)$ with (4)--(5) proves
$$
 \boxed{(1+\xi^2)|m(\xi)|^2\le8\min(|\xi|,1).}
\tag{6}
$$
At zero set $m(0)=0$. The cancellation of the lower-frequency singularity by the literal unit difference justifies this assignment.

Here is a direct domain justification for (3). Truncate $K$ at $R$, obtaining an $L^1$ kernel. Its Fourier integral converges to $I(\xi)$ for every nonzero $\xi$. The same split and integration-by-parts arguments give uniform bounds $C|\xi|^{-1/2}$ below one and $2/|\xi|$ above one, independent of $R$. Hence the multiplied kernels converge in the $H^1$ output norm for each $g\in L^2$ of finite original energy, by dominated Plancherel. The truncated integral in (1) converges locally uniformly for the actual $g_N$, by its frozen-tail estimate. Thus the continuous $H^1$ representative of this multiplier is precisely the literal integral (1). There is no extra zero-frequency mass and no formal evaluation of $I(0)$.

## 2. The original energy controls the full $H^1$ norm

The exact original energy symbol is
$$
 \mathfrak m(\xi)=2\int_0^1(1-\cos(\xi h))dh
        +2\int_1^\infty(1-\cos(\xi h))\frac{dh}{h^2},
$$
$$
 \mathcal E(g)=\frac1{2\pi}\int_{\mathbb R}
                           \mathfrak m(\xi)|\widehat g(\xi)|^2d\xi.
\tag{7}
$$
In particular this is the original mixed additive metric, not an age-coordinate substitute.

Put $a=1-\cos1>0$. For $0<|\xi|\le1$, retain $h\in[1/|\xi|,2/|\xi|]$ in the long-increment part of (7), obtaining $\mathfrak m(\xi)\ge a|\xi|$. For $1\le|\xi|\le2$, the same interval lies in $[1/2,2]$, where the mixed weight is at least $1/4$; its length is at least $1/2$, giving $\mathfrak m(\xi)\ge a/4$. Finally, for $|\xi|\ge2$, the short-increment part is $2(1-\sin\xi/\xi)\ge1$. Therefore
$$
 \mathfrak m(\xi)\ge\frac a4\min(|\xi|,1).
$$
Equation (6) and Plancherel now give
$$
 \boxed{\|e_N\|_{H^1(\mathbb R)}^2
            \le\frac{32}{1-\cos1}\,\mathcal E(g_N).}
\tag{8}
$$

For every continuous $H^1$ representative $e$, the fundamental theorem on $[j,j+1]$, Cauchy, and integration of the free endpoint imply
$$
 |e(j)|^2\le2\int_j^{j+1}(|e(u)|^2+|e'(u)|^2)du.
$$
Sum over all integer $j$, and then restrict to $j\ge0$, to obtain (2). This sampling step is why a full $H^1$ estimate, rather than an unsampled $L^2$ estimate, was needed.

The result retains the actual signed driver at every integer. Neither $\Lambda(n)$ nor the continuum density is estimated separately in its square.

## 3. A completed driver without an uncut $L^2$ source assumption

There is also a literal completed driver, defined by the difference integral (1) with $g(x)=E_\psi(x)/x$ for $x\ge1$. The actual local jump estimate and Chebyshev give
$$
 |g_N(y+1)-g_N(y)|
       \le C(1+\log(y+1))/y,\qquad y\ge1,
\tag{9}
$$
uniformly in $N$; it also holds for the completed $g$. Thus for $u\ge0$ the integrand in (1) is absolutely integrable uniformly over cutoffs. Local source stabilization and dominated convergence give $e_N(u)\to e_\infty(u)$. Fatou and the uniform energy bound imply
$$
 \sum_{j\ge0}|e_\infty(j)|^2\le C.
\tag{10}
$$
This assertion is about the difference integral. It does not assert convergence of the individual uncut charge integrals or put $Ug$ in global $L^2$.

## 4. Exact norm cost in the actual renewal resolution

Recall the already proved seed charges and renewal coefficients
$$
 q_j=Q(S^jh_1)=\frac{\arctan\sqrt j}{\sqrt j}\quad(j>0),\quad q_0=1,
 \qquad d_j=q_j-q_{j+1},
$$
$$
 r_0=1,\qquad r_n=\sum_{m=1}^nd_{m-1}r_{n-m},\qquad
 \sum_{i=0}^nr_iq_{n-i}=1.
\tag{11}
$$
The actual seed iterates are
$$
 V_j=C^jh_1=\sum_{i=0}^j\frac{r_i}{x+j-i}\mathbf1_{x\ge1},
 \qquad V_j\ge0,\quad \|V_j\|_2\le1.
\tag{12}
$$
These are exact rational physical profiles generated by the same compensated successor, not arbitrary positive test functions.

Define $\mathscr V_k:\mathbb C^k\to L^2(dx)$ by
$\mathscr V_kc=\sum_{j=0}^{k-1}c_jV_j$. Then
$$
 \boxed{c_0\sqrt k\le\|\mathscr V_k\|_{\ell^2\to L^2}
                                 \le\sqrt k,\qquad k\ge k_0,}
\tag{13}
$$
for absolute constants $c_0>0,k_0$.

The upper bound follows from (12) and Cauchy. For the lower bound, let $R_j=\sum_{i=0}^jr_i$. From $q_j\ge(1+j)^{-1/2}$, (11) gives $R_j\le\sqrt{1+j}$. Conversely, sum (11) over $0\le n\le j$:
$$
 j+1=\sum_{i=0}^jr_i\sum_{\ell=0}^{j-i}q_\ell
                \le C\sqrt{1+j}\,R_j.
$$
Hence $R_j\ge c\sqrt{1+j}$. For $k/2\le j<k$ and $k\le x\le2k$, (12) now gives
$$
 V_j(x)\ge\frac{R_j}{3k}\ge c/\sqrt k.
$$
Choose a nonnegative unit vector supported on those $j$, with constant coefficients of size comparable to $k^{-1/2}$. Its synthesized function is bounded below by a positive absolute constant throughout an interval of length $k$. This proves the lower bound in (13). It also shows explicitly that the large eigenvalue of this actual Gram is due to coherent overlaps.

For the complete prime process, let $\mathscr V_{k,t}c=T_tU(\mathscr V_kc)$. Contraction gives the same upper bound. For the nonnegative vector used above, the exact no-jump term gives
$$
 \boxed{c_0e^{-\lambda t}\sqrt k
       \le\|\mathscr V_{k,t}\|_{\ell^2\to L^2}
       \le\sqrt k.}
\tag{14}
$$
This uses positivity only on the displayed seed combination. It retains all other age histories; they cannot negate the no-jump lower bound for this nonnegative input. At $k\asymp N$, $t=c\log N$, the lower operator cost has order $N^{1/2-\lambda c}$. It is not a lower bound for the actual signed driver.

## 5. What the new actual constraint supplies

The exact finite-iterate identity is
$$
 C^kg_N=S^kg_N-\sum_{i=0}^{k-1}e_{N,i}V_{k-1-i}.
$$
Thus (2) and (13), or contraction after applying $T_tU$, give
$$
 \left\|T_tU\sum_{i<k}e_{N,i}V_{k-1-i}\right\|_2
       \le C\sqrt{k\,\mathcal E(g_N)}\le C\sqrt k.
\tag{15}
$$
For $k\ge N-1$, the unchanged terminal term is
$S^kg_N=E_\psi(N)/(x+k)$; therefore
$$
 \|T_tUC^kg_N\|_2
       \le |E_\psi(N)|/\sqrt{k+1}+C\sqrt k.
\tag{16}
$$
The exact square behind (15) is
$$
 \sum_{i,j<k}\overline{e_{N,i}}e_{N,j}
     \left\langle T_tUV_{k-1-i},T_tUV_{k-1-j}\right\rangle,
\tag{17}
$$
with every signed cross term. The full two-age formula for these entries is in the [finite-iterate note](literal-compensated-successor-iterates.md).

Equation (2) gives a uniform constraint on the whole actual driver, stronger in that direction than its $O(\sqrt N)$ absolute sum bound. Equation (13) simultaneously shows the precise loss if that constraint is consumed without further signed information: the actual seed system itself has synthesis norm of order $\sqrt k$. No smaller generic cost follows from the square-sum bound alone. This leaves open cancellation of the specific driver in (17); it neither asserts such cancellation nor rules out the renewal method. In particular these results do not prove the logarithmic-time subpower source target or RH.
