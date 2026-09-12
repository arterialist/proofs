# A collective quadratic energy for a signed scattering phase

This is a written theorem, with conventions and finite trace domains fixed in the [semilocal foundation](semilocal-weighted-scattering.md). It is not a Lean formalization.

Let $P$ project onto negative Fourier frequencies on $L^2(\mathbb R,dt)$, using the unitary Fourier transform with exponent $-it\xi$. Let $\chi$ be a real Schwartz function. Suppose a real signed measure $\mu$ on $(0,\infty)$ defines a bounded real phase
$$
\theta(t)=2\int_0^\infty\frac{\sin(at)}a\,\mu(da).
\tag{1}
$$
For the concrete application below, $\mu$ is a smooth bounded density near zero plus finitely many geometric prime-power tails. The sine integral in (1) then exists and is bounded. Measures supported away from zero with finite support are a simpler initial case.

Define, for $r>0$,
$$
T_{j,r}(t)=\int_{[r,\infty)}
\frac{(a-r)^j}{a}e^{iat}\,\mu(da),\quad j=0,1,2,
\qquad S_r=T_{0,r}.
\tag{2}
$$
Values at the countably many atomic endpoints $r=a$ do not affect any integral below.

## The exact Hilbert–Schmidt identity

The positive-frequency coefficient of (1) is $-i\mu(da)/a$, and the negative coefficient is its conjugate. For a negative input frequency $-r$, the physical-space column of $M_\chi[P,M_\theta]$ is
$$
\frac{i}{\sqrt{2\pi}}\chi(t)e^{-irt}S_r(t).
\tag{3}
$$
For a positive input frequency $r$, its column is the complex conjugate of (3), up to a constant sign. This follows directly from
$(1_{\xi<0}-1_{\xi-a<0})$, which is minus one on $0<\xi<a$. The two columns therefore have the same squared norm. Plancherel in the input variable proves
$$
\boxed{\|M_\chi[P,M_\theta]\|_{\mathcal S_2}^2
=\frac1\pi\int_0^\infty\int_{\mathbb R}
\chi(t)^2|S_r(t)|^2\,dt\,dr.}
\tag{4}
$$
An equivalent form retains every ordered pair of atoms or density points:
$$
\frac1\pi\iint_{(0,\infty)^2}
\frac{\min(a,b)}{ab}
\Re\left(\int\chi(t)^2e^{i(a-b)t}dt\right)
\mu(da)\mu(db).
\tag{5}
$$
The kernel $\min(a,b)$ is the Brownian covariance kernel, since it equals
$\int_0^\infty1_{r\le a}1_{r\le b}dr$. This is a positive quadratic form of the **signed** measure. Its positivity does not discard the prime–density or prime–prime cross terms.

## An explicit trace-norm consequence

Put $L=1+t^2-\partial_t^2$. Its eigenvalues are $2n+2$, $n\ge0$, so
$\|L^{-1}\|_{\mathcal S_2}=\pi/\sqrt{24}$. Define
$$
\mathcal J_\chi(\mu)=\int_0^\infty\int_{\mathbb R}
\left|
[(1+t^2)\chi-\chi'']S_r
-2i\chi'T_{1,r}+\chi T_{2,r}
\right|^2dt\,dr.
\tag{6}
$$
Indeed the expression in absolute values, multiplied by $e^{-irt}$, is precisely
$L(\chi e^{-irt}S_r)$. Applying the column calculation (3) after $L$ gives
$$
\|L M_\chi[P,M_\theta]\|_{\mathcal S_2}^2
=\mathcal J_\chi(\mu)/\pi.
$$
Hilbert–Schmidt factorization consequently proves
$$
\boxed{\|M_\chi[P,M_\theta]\|_{\mathcal S_1}
\le\sqrt{\pi/24}\,\mathcal J_\chi(\mu)^{1/2}.}
\tag{7}
$$
This is a sufficient quantitative bound, not an assertion that finiteness of the weaker energy (4) alone implies trace class.

For a bounded real phase, differentiating $e^{-isM_\theta}Pe^{isM_\theta}$ gives the exact Duhamel formula
$$
\Delta(M_{e^{i\theta}})
=-i\int_0^1e^{-isM_\theta}[P,M_\theta]e^{isM_\theta}ds.
\tag{8}
$$
Multiplication by $\chi$ commutes with both unitaries in the integral. Thus
$$
\boxed{N_\chi(M_{e^{i\theta}}):=
\|M_\chi\Delta(M_{e^{i\theta}})\|_1
\le\sqrt{\pi/24}\,\mathcal J_\chi(\mu)^{1/2}.}
\tag{9}
$$
The integral converges in trace norm whenever (7) is finite: strong continuity of the unitaries gives trace-norm continuity on trace-class operators by finite-rank approximation.

## The actual prime-history measure

After absorbing the stable rational factor into the gamma ratio as in [rational scattering pole factor](rational-scattering-pole-factor.md), take $A=\log X$ and
$$
\boxed{\mu_X(da)=e^{a/2}1_{(0,A)}(a)\,da
-\sum_{p\le X}\sum_{k\ge1}
(\log p)p^{-k/2}\,\delta_{k\log p}(da).}
\tag{10}
$$
Equation (1) is then exactly the growing-density counterphase plus the complete local-prime phase, because
$(\log p)/(k\log p)=1/k$. It retains every proper power, including powers beyond $X$, of every admitted prime. The corresponding renormalized unitary is
$$
\widetilde U_X(t)=
\pi^{-it}\frac{\Gamma(5/4+it/2)}{\Gamma(5/4-it/2)}
e^{i\theta_X(t)}.
\tag{11}
$$
The gamma factor is fixed; the growing arithmetic phase is the single signed object in (10). Applying (9) after forming (10) preserves density cancellation in the estimate.

For each finite $X$, (6) is finite. Near $r=0$, $S_r=O_X(1+|\log r|)$ uniformly in real $t$, while $T_{1,r}$ and $T_{2,r}$ are bounded; the logarithmic singularity is square integrable in $dr$. For large $r$, the finitely many prime-base geometric tails give exponential decay in $r$, with polynomial factors harmless. The Schwartz factors control the $t$ integral.

To justify (3)–(9) for (10), first truncate $a$ away from zero and infinity. The column formulas hold for these finite measures. The same estimates show convergence of the truncated column expressions after $L$ in $L^2(dt\,dr)$, hence trace-norm convergence by (7). The corresponding bounded phases converge pointwise with a common finite bound for fixed $X$; dominated convergence gives strong convergence of their multiplication operators. Their commutators therefore have the claimed trace-class limit. The near-zero part is controlled by its sine cancellation, rather than by the infinite total mass of $da/a$.

The ordinary cocycle also gives subadditivity of $N_\chi$ for commuting scalar multipliers. Consequently (9) controls the growing part of (11), up to the fixed finite quantity $N_\chi(\rho_{\infty,5/4})$. The fixed gamma quantity is trace class by the [Schwartz-weighted divided-difference proof](semilocal-weighted-scattering.md#3-ordinary-trace-class-and-positive-splitting-for-each-finite-place-set).

Equations (4), (6), and (9) supply a collective quadratic estimate with a direct history interpretation: at each log threshold $r$, the complete surviving prime-power phase is compared with the surviving continuum phase before it is squared. No independence or pointwise sign is assumed. An estimate for this arithmetic energy would control the observed scattering norm. Positivity of the full Weil form, and hence RH, does not follow merely from the positivity or finiteness of this auxiliary energy.
