# The collective successor seed has an explicit logarithmic memory

The exact initial-boundary calculation in [successor/source compatibility theorem](successor-collective-prime-compatibility.md) gives
$$
B_p(v)=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}1_{v\ge\log p},
\qquad B(v)=\sum_pB_p(v).
\tag{1}
$$
The sum is pointwise finite. The baseline note proves $B\in L^2$ and a prime-cutoff tail estimate. This note identifies its leading memory and a density subtraction. The proof below is written mathematics, with no Lean formalization claim.

For large $v$, the floor-equals-one sector is exactly
$$
B^{(1)}(v)=e^{v/2}\sum_{e^{v/2}<p\le e^v}\frac1{p^2}.
\tag{2}
$$
The open lower endpoint is essential: a prime at $p=e^{v/2}$ belongs to the next floor sector. Define the independent density reference
$$
b_0(v)=e^{v/2}\int_{e^{v/2}}^{e^v}\frac{dx}{x^2\log x}.
\tag{3}
$$
For a global reference, multiply this by a fixed smooth cutoff that vanishes near zero and is one for $v\ge3$.

The Vinogradov–Korobov PNT remainder, with $\Phi(v)=v^{3/5}/(\log v)^{1/5}$, and Stieltjes partial summation against $\theta(x)=\sum_{p\le x}\log p$, give
$$
|B^{(1)}(v)-b_0(v)|\le C e^{-c\Phi(v)}.
\tag{4}
$$
To see the endpoint factors, integrate $(x^2\log x)^{-1}$ against $d(\theta(x)-x)$ on $(e^{v/2},e^v]$. The lower endpoint and the integral remainder are $O(e^{-v/2}e^{-c\Phi(v/2)}/v)$; multiplication by $e^{v/2}$ leaves the asserted stretched-exponential bound. The upper endpoint is smaller. The primary PNT source and its exact scope are recorded in [Vinogradov–Korobov history estimate](../prime-history/late-age-vk-history-entropy.md).

Every higher floor sector is exponentially smaller. For $j\ge2$, put $y=e^{v/(j+1)}$. Its contribution is at most
$$
e^{v/2}\sum_{n>y}n^{-j-1}
\le e^{-v/2}+\frac1j\exp\!\left(\frac v2-\frac{jv}{j+1}\right).
$$
There are at most $v/\log2$ nonempty sectors. Consequently
$$
0\le B(v)-B^{(1)}(v)
\le Cve^{-v/2}+C(1+\log v)e^{-v/6}.
\tag{5}
$$
All prime powers have been retained in this estimate, including exact powers at sector boundaries. Combining (4)–(5), the full remainder $B-b_0$, with the fixed origin cutoff understood, has every polynomially weighted $L^1$ and $L^2$ moment.

Substitute $u=\log x$ in (3) and integrate twice by parts:
$$
b_0(v)=e^{v/2}\int_{v/2}^v\frac{e^{-u}}u\,du
=\frac2v-\frac4{v^2}+O(v^{-3}).
\tag{6}
$$
Hence
$$
B(v)=\frac2v+O(v^{-2}),\qquad B\in L^2(0,\infty)\setminus L^1(0,\infty).
\tag{7}
$$
This identifies a nonzero long-memory coefficient, beyond an upper bound of order $1/v$.

There is an exact resonance interpretation. Since $B(v)-2/(1+v)$ is integrable, its Laplace transform for $\Re z>0$ satisfies, as $z\downarrow0$ on the positive axis,
$$
\int_0^\infty e^{-zv}B(v)dv
=-2\log z+C_B+o(1),
\quad
C_B=-2\gamma+\int_0^\infty\left(B(v)-\frac2{1+v}\right)dv.
\tag{8}
$$
Use the [classical exponential-integral expansion, DLMF 6.6.2](https://dlmf.nist.gov/6.6.E2): $\int_0^\infty e^{-zv}(1+v)^{-1}dv=e^zE_1(z)=-\log z-\gamma+o(1)$. No analytic continuation through $z=0$ is asserted.

For a source-driven collective heat equation, this supplies an explicit density memory to retain in the resonant channel. The remainder has integrable tails and all polynomial moments. Removing the reference without retaining its logarithmic forcing would alter the actual initial-boundary response. This refinement does not estimate the bulk arithmetic source or the signed Weil readout.

The PNT input is the classical Vinogradov–Korobov estimate; a primary quantitative source is Johnston, [*Zero-density estimates and the optimality of the error term in the prime number theorem*](https://arxiv.org/html/2411.13791v2), with the precise form recorded in the linked history-entropy chapter. The asymptotic integration in (6) and the resonance calculation in (8) are separate consequences of that input. No priority claim is made.

The [local arithmetic clock calibration](../factorial-and-renewal/successor-clock-arithmetic-calibration.md) identifies the constant in (8) with the prime Mertens constant and proves the exact local cancellation of all further logarithmic terms in the original boundary response. The [maximal-translation theorem](successor-seed-maximal-translation.md) separately supplies uniform finite-prime variable-shift estimates needed by the compensated-memory kernel.
