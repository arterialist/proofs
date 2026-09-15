# The complete integer-history constraint on the actual low-band pair

This note derives a paired-history identity for the actual joint weighted
prefix and endpoint datum. Complete integer division connects it to the
factorial ground and a signed Euler edge memory. The resulting exact
pairing keeps their cancellation visible. Ordinary unconditional PNT
bounds each component but does not sign or exhaust their cross pairing.

Let $E(x)=\psi(x)-x$, with every prime power admitted at its right
endpoint, and let $N\ge3$ be an integer. Put
$$
U=\log N,\qquad a_U(v)=e^{-v/2}E(e^v)\mathbf1_{[0,U]}(v),
\qquad s=1/2+i\xi,
$$
$$
D_N(s)=-1+\sum_{2\le n\le N}\Lambda(n)n^{-s}-\int_1^Nx^{-s}\,dx.
$$
The actual low-band datum and norm are
$$
A_U(\xi)=\widehat a_U(\xi)
=\frac{D_N(s)-E(N)N^{-s}}s,
\qquad
I_U=\frac1{2\pi}\int_{|\xi|\le1/U}|A_U(\xi)|^2\,d\xi.
\tag{1}
$$
No global discrepancy source is assumed to lie in $L^2$.

## 1. Origin and endpoint in the complete birth pair

For the literal finite signed innovation measure
$$
\nu_N=-\delta_1+\sum_{2\le n\le N}\Lambda(n)\delta_n
-\mathbf1_{[1,N]}dx,
$$
one has the exact finite Stieltjes formula
$$
A_U(\xi)=\int_{[1,N]}K_s(x)\,\nu_N(dx),
\qquad
K_s(x)=\frac{x^{-s}-N^{-s}}s
=\int_x^Ny^{-s-1}\,dy.
\tag{2}
$$
The origin atom $-\delta_1$ is included. At the terminal prime-power
endpoint $N$, $K_s(N)=0$: its atom cancels exactly between
$D_N(s)$ and $E(N)N^{-s}$. This is a retained endpoint cancellation,
not a change to left-continuous arithmetic. It agrees with the fact that
a value at the single endpoint has no effect on the age integral.

Consequently $I_U$ is an exact paired form in the complete births,
with kernel
$$
\frac1{2\pi}\int_{|\xi|\le1/U}K_s(x)\overline{K_s(y)}\,d\xi.
\tag{3}
$$
Equivalently, in the discrepancy variables,
$$
I_U=\int_0^U\int_0^Ua_U(v)a_U(w)
\frac{\sin((v-w)/U)}{\pi(v-w)}\,dv\,dw,
\tag{4}
$$
with diagonal value $1/(\pi U)$. The kernel has a nonnegative Fourier
representation. Its pointwise positivity on this square does not justify
replacing the signed products by positive ones or provide an upper bound
from cancellation.

## 2. Complete exact division supplies the factorial constraint

For every real $x\ge1$, write $m=\lfloor x\rfloor$. The classical
prime-power identity $\sum_{d\mid n}\Lambda(d)=\log n$ gives
$$
\sum_{k\le x}\psi(x/k)
=\sum_{d\le x}\Lambda(d)\lfloor x/d\rfloor
=\log(m!).
$$
Subtracting the continuous term yields
$$
\boxed{
\sum_{k\le x}E(x/k)=\log(m!)-xH_m,
\qquad H_m=\sum_{k=1}^m\frac1k.
}
\tag{5}
$$
Every integer division history is present. At an integer $x$, the
history $k=x$ ends at one and contributes $E(1)=-1$; it is not
omitted. Formula (5) is a direct consequence of the actual arithmetic
births, not an engineered spectral signal.

Let
$$
a(v)=e^{-v/2}E(e^v)\mathbf1_{v\ge0},\qquad
f(v)=e^{-v/2}[\log(\lfloor e^v\rfloor!)-e^vH_{\lfloor e^v\rfloor}],
\qquad v\ge0.
$$
Equation (5) becomes the exact causal integer-history relation
$$
\sum_{k\le e^v}k^{-1/2}a(v-\log k)=f(v).
\tag{6}
$$
Fourier transformation only on $[0,U]$, followed by finite Fubini,
gives
$$
\widehat f_U(\xi)=\int_0^Ua(v)e^{-i\xi v}
\sum_{k\le e^{U-v}}k^{-s}\,dv,
\qquad f_U=f\mathbf1_{[0,U]}.
\tag{7}
$$
All sums are finite and all inputs are locally square integrable.

## 3. Exact Euler edge memory and its uniform low-band bound

Define for real $y\ge1$
$$
r_s(y)=\sum_{k\le y}k^{-s}-\frac{y^{1-s}}{1-s}-\zeta(s).
\tag{8}
$$
For $m=\lfloor y\rfloor$, classical Euler summation gives the literal
signed cell formula
$$
r_s(y)=s\int_m^\infty\{t\}t^{-s-1}\,dt-\int_m^yt^{-s}\,dt.
\tag{9}
$$
The first integral converges absolutely for $\Re s>0$. In particular,
on $|\xi|\le1/U$, $U\ge1$,
$$
|r_s(y)|\le(2|s|+1)m^{-1/2}\le5y^{-1/2}.
\tag{10}
$$
Here $|s|\le\sqrt5/2$, $m\ge y/2$, and
$\sqrt2(\sqrt5+1)<5$. No critical-line Dirichlet series is substituted
for a convergent infinite sum; (9) is the Euler continuation formula.

Insert (8) into (7). The growing continuum term contains
$$
\int_0^Ua(v)e^{-v/2}\,dv
=\int_1^N\frac{E(x)}{x^2}\,dx=-F(N),
\tag{11}
$$
where $F(1)=0$ and $F'=-E/x^2$ are the full actual factorial
identities. Therefore
$$
\boxed{
\zeta(s)A_U(\xi)=G_U(s)-R_U(s),
}
\tag{12}
$$
with
$$
G_U(s)=\widehat f_U(\xi)+\frac{F(N)e^{(1-s)U}}{1-s},
\qquad
R_U(s)=\int_0^Ua(v)e^{-i\xi v}r_s(e^{U-v})\,dv.
\tag{13}
$$
The two large terms inside $G_U$ stay grouped. The edge memory
$R_U$ contains all truncated integer histories, including those
touching the origin cell. It is not set to zero at large cutoff.

## 4. The exact paired inequality and the actual missing cancellation

Since $\zeta(1/2)<0$, continuity gives constants $z_0>0,U_0$ such
that $|\zeta(1/2+i\xi)|\ge z_0$ when $U\ge U_0$ and
$|\xi|\le1/U$. The real sign follows directly from the positive
alternating eta series and $1-\sqrt2<0$.

For functions on this actual band, use the weighted pairing
$$
\langle X,Y\rangle_U=\frac1{2\pi}\int_{|\xi|\le1/U}
\frac{X(s)\overline{Y(s)}}{|\zeta(s)|^2}\,d\xi.
$$
Equation (12) proves the exact complete-history pair identity
$$
\boxed{
I_U=\|G_U\|_U^2+\|R_U\|_U^2
-2\Re\langle G_U,R_U\rangle_U.
}
\tag{14}
$$
Thus the surviving joint prefix/endpoint datum is constrained by a
specific signed cross pairing of factorial forcing and integer edge
memory. This is not an isolated endpoint estimate.

Here is the unconditional bound supplied by the existing inputs. The
ordinary PNT gives, for some $\nu>0$,
$$
|E(e^v)|\le Ce^ve^{-\nu\sqrt v},\qquad
|F(N)-(1+\gamma)|\le Ce^{-\nu\sqrt U},
\tag{15}
$$
after adjusting constants on a finite initial interval and decreasing
$\nu$ if necessary. The classical Stirling and harmonic expansions
give
$$
f(v)=-(1+\gamma)e^{v/2}
+O((1+v)e^{-v/2}).
\tag{16}
$$
The remainder in (16) is integrable on $[0,\infty)$. Grouping its
Fourier transform with the main term in (13) yields
$$
|G_U(s)|\le C[\sqrt N e^{-\nu\sqrt U}+1].
\tag{17}
$$
The edge bound (10), used only after the exact signed expression, gives
$$
|R_U(s)|\le5e^{-U/2}\int_0^U|E(e^v)|\,dv
\le C\sqrt N e^{-\nu\sqrt U}.
\tag{18}
$$
For the final integral, the logarithmic derivative of
$e^ve^{-\nu\sqrt v}$ is at least $1/2$ for large $v$, so its
integral is controlled by the upper endpoint. No RH-scale error is used.

Equations (14), (17), and (18), or the elementary inequality
$|G_U-R_U|^2\le2|G_U|^2+2|R_U|^2$, give
$$
\boxed{
I_U\le\frac C U[Ne^{-2\nu\sqrt U}+1].
}
\tag{19}
$$
This is a genuine unconditional paired-history bound for the actual
datum. Its nonnegative power scale is still one. It does not give a
subpower estimate.

The missing step is a signed estimate for
$\Re\langle G_U,R_U\rangle_U$ that makes (14) much smaller than the
individual positive components. Positivity of the factorial ground,
positivity of complete division weights, and the uniform Euler bound
(10) do not provide that estimate. The memory term (18) has exactly the
same available power scale as (17); treating it as a negligible boundary
error would assume the desired cancellation.

This attempt links the actual arithmetic prefix, endpoint, factorial
potential, and complete integer divisions. It does not supply the new
scale-recursive arithmetic constraint needed for RH. Neither a growing
finite bandwidth nor the nonzero low-band zeta multiplier is a finite RH
certificate. All results here are written mathematics, with no Lean
formalization or RH conclusion claimed.

## 5. The linked successor jumps turn the leading chirp into exact synthesis

Classical Euler summation refines (9), uniformly on the current compact
set of $s$, to
$$
r_s(y)=(1/2-\{y\})y^{-s}+O(y^{-3/2}).
\tag{20}
$$
At integer $y$, the leading coefficient is $+1/2$, not zero or
$-1/2$. Substitution into the exact edge integral gives
$$
R_U(s)=N^{-s}J_N+\mathcal E_U(s),\qquad
J_N=\int_1^NE(x)(1/2-\{N/x\})\frac{dx}{x}.
\tag{21}
$$
The exact residual $\mathcal E_U$ is retained. Indeed (15) and (20)
only give
$$
|\mathcal E_U(s)|\le CN^{-3/2}\int_0^U|E(e^v)|e^v\,dv
\le C\sqrt N e^{-\nu\sqrt U},
\tag{22}
$$
the same available power scale as the full $R_U$. The terminal cells
have $y=e^{U-v}$ of order one, so their Euler remainder is not a
small large-$y$ error.

Let $\mathcal B_2(t)=\{t\}^2-\{t\}+1/6$, the continuous periodic
second Bernoulli polynomial. Almost everywhere,
$$
\frac d{dx}\mathcal B_2(N/x)
=\frac{2N}{x^2}(1/2-\{N/x\}).
$$
Its continuity across integer division cells produces no extra atomic
term. Stieltjes integration by parts, using the exact successor jump
$dE=\sum_{n\ge2}\Lambda(n)\delta_n-dx$ on $(1,N]$, gives
$$
\boxed{\begin{aligned}
J_N={}&\frac{E(N)}{12}+\frac1{12N}\\
&-\frac1{2N}\left[
\int_1^N(E(x)-x)\mathcal B_2(N/x)\,dx
+\sum_{2\le n\le N}n\Lambda(n)\mathcal B_2(N/n)
\right].
\end{aligned}}
\tag{23}
$$
Here $d(xE)=(E-x)dx+\sum n\Lambda(n)\delta_n$.
The origin boundary is $E(1)\mathcal B_2(N)=-1/6$, giving
$+1/(12N)$. The final jump at $N$ cancels between $E(N)/12$
and its term in the sum because $\mathcal B_2(1)=1/6$. Every prime
power remains.

The complete division identity evaluates the weighted Bernoulli sum
exactly. Write $M_n=\lfloor N/n\rfloor$. Expanding the periodic
polynomial gives
$$
\mathcal B_2(N/n)
=N^2/n^2-N/n+1/6-2(N/n)M_n+M_n^2+M_n.
$$
The ordinary factorial identity is
$\sum\Lambda(n)M_n=\log(N!)$. Moreover,
$$
\sum_{n\le N}n\Lambda(n)(M_n^2+M_n)
=2\sum_{nk\le N}nk\Lambda(n)
=2\sum_{m\le N}m\log m.
$$
Thus
$$
\boxed{\begin{aligned}
\sum_{2\le n\le N}n\Lambda(n)\mathcal B_2(N/n)
={}&N^2\sum_{2\le n\le N}\frac{\Lambda(n)}n-N\psi(N)
+\frac16\sum_{2\le n\le N}n\Lambda(n)\\
&-2N\log(N!)+2\sum_{m\le N}m\log m.
\end{aligned}}
\tag{24}
$$
This is a genuine linked successor-and-division identity, rather than an
arbitrary input estimate. However, inserting the full factorial formula
$\sum\Lambda(n)/n=\log N+\psi(N)/N-F(N)$ reduces it to
$$
N^2(\log N-F(N))
+\frac16\sum_{n\le N}n\Lambda(n)
-2N\log(N!)+2\sum_{m\le N}m\log m.
\tag{25}
$$
The remaining weighted prime sum is itself exactly
$$
\sum_{n\le N}n\Lambda(n)
=NE(N)+\frac{N^2+1}{2}-\int_1^NE(x)\,dx.
\tag{26}
$$
Therefore the leading chirped arithmetic in (23) reduces to the existing
factorial potential, the original endpoint, and an original discrepancy
integral. The Bernoulli polynomial also changes sign within each cell,
so positive birth weights alone assign no sign to the centered pairing.

This completes the bounded attempt to force the missing cross pairing
from linked successor jumps and complete division. It yields exact
synthesis of the same actual $E$ data, and the unreduced Euler residual
retains the same available power scale. It supplies no independent
arithmetic inequality improving (19). A further attempt must use a
different signed mechanism rather than repeating this reduction.

## Dependencies and attribution

The [original-source low-Laplace theorem](actual-short-time-psi-correlation.md) and [heat-generator endpoint formula](heat-generator-origin-flux.md) fix the actual joint datum. The factorial potential is defined in the [original-domain proof](factorial-ground-state-original-l2-domain.md). The identity $\sum_{d\mid n}\Lambda(d)=\log n$, Stirling expansion, [Euler–Maclaurin formula](https://dlmf.nist.gov/25.11#iii) and [Bernoulli polynomials](https://dlmf.nist.gov/24.2) are classical. Their exact integer-history synthesis here does not supply the missing cross-pair estimate. The [coupled Bernoulli energy](coupled-bernoulli-history-energy.md) retains the resulting partial-divisor overlaps in a full quadratic form.
