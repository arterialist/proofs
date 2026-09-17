# Fixed-prime transport: the actual boundary strip and a bilinear cutoff

This is a written mathematical proof, not a Lean formalization. The [successor cutoff](../successor-and-division/actual-successor-frequency-cutoff.md) and [semilocal normalization](../weil-and-spectral/semilocal-weighted-scattering.md) fix the actual input and operator conventions.

Fix one prime $p$, write $\ell=\log p$, $r=p^{-1/2}$, and let
$$
T_\pm F(s)=F(s\pm\ell),\qquad
U=(I-rT_+)(I-rT_-)^{-1}.
$$
The constants $C_p$ below can also depend on a fixed elementary Chebyshev constant and the fixed Fourier cutoff. They are not asserted uniform in a growing set of primes.

Use the complete actual history $a(s)=e^{-s/2}(\psi(e^s)-e^s)$, zero for $s<0$, and $a(0)=-1$. Let $t\ge\max(1,\ell)$, $H=1+t$, and let $\chi_t$ be the upper cutoff equal to one through $t$, linear down to zero at $t+1$, and zero thereafter. Its definition below zero is immaterial before multiplication by the causal projection. Put
$$
f=\chi_ta,\qquad b=Uf,\qquad c=U^{-1}f,\qquad
z=(I-rT_-)^{-1}f,
\qquad P=\mathbf1_{[0,\infty)}.
$$
The inverse series are norm convergent on $L^2(\mathbb R)$. No arithmetic hypothesis is needed for their action on this compact input.

With $\widehat f(\xi)=\int f(s)e^{-i\xi s}ds$, the actual local phase is
$$
u_p(\xi)=\frac{1-re^{i\xi\ell}}{1-re^{-i\xi\ell}}
=\exp\left(-2i\sum_{k\ge1}\frac{p^{-k/2}}k\sin(k\xi\log p)\right).
$$
This agrees with the orientation in [prime innovation finite band flux](prime-innovation-finite-band-flux.md) and the local factors in [the signed phase transport](../weil-and-spectral/signed-scattering-phase-transport.md). All proper powers remain in the absolutely convergent phase series. The unprojected cancellation is simply
$$
\widehat b\,\widehat c=u_pu_p^{-1}\widehat f^{\,2}=\widehat f^{\,2},
\qquad b*c=f*f.
$$
The products are bilinear, without conjugation; all new information below concerns projection and the retained boundary.

## Physical action and truncation

The exact physical formulas are
$$
b(s)=-r f(s+\ell)+(1-r^2)\sum_{i\ge0}r^if(s-i\ell),
\tag{1}
$$
$$
c(s)=-r f(s-\ell)+(1-r^2)\sum_{j\ge0}r^jf(s+j\ell).
\tag{2}
$$
For the untruncated actual history, (1) is locally a finite sum. For $x\ge1$,
$$
\sqrt x\,(Ua)(\log x)
=(1-p^{-1})\sum_{p^i\le x}e(x/p^i)-p^{-1}e(px).
\tag{3}
$$
The untruncated inverse requires its entire future history. Its series converges absolutely under the classical unconditional PNT remainder and gives
$$
\sqrt x\,(U^{-1}a)(\log x)
=-\mathbf1_{x\ge p}e(x/p)
+(1-p^{-1})\sum_{j\ge0}p^{-j}e(xp^j).
\tag{4}
$$
The compact-input construction and the frequency estimate below do not need this PNT passage.

For a multiplication cutoff $M_\chi$, the exact physical commutators are
$$
\begin{split}
[M_\chi,U]a(s)={}&-r[\chi(s)-\chi(s+\ell)]a(s+\ell)\\
&+(1-r^2)\sum_{i\ge0}r^i[\chi(s)-\chi(s-i\ell)]a(s-i\ell),
\end{split}
\tag{5}
$$
$$
\begin{split}
[M_\chi,U^{-1}]a(s)={}&-r[\chi(s)-\chi(s-\ell)]a(s-\ell)\\
&+(1-r^2)\sum_{j\ge0}r^j[\chi(s)-\chi(s+j\ell)]a(s+j\ell).
\end{split}
\tag{6}
$$
For a compact input these follow directly from the norm-convergent translation series. For untruncated $a$, the inverse formula follows by the absolutely convergent PNT limit just described. In particular, for $0\le s\le t$,
$$
Ua(s)-Uf(s)=-r[1-\chi_t(s+\ell)]a(s+\ell),
\tag{7}
$$
$$
U^{-1}a(s)-U^{-1}f(s)
=(1-r^2)\sum_{j\ge0}r^j[1-\chi_t(s+j\ell)]a(s+j\ell).
\tag{8}
$$
The first error lies in the last prime-length strip. The second is a future-boundary sum affecting the whole retained interval; it cannot be replaced by a terminal point value. The global formulas (5)–(6) also retain the initial boundary.

## The inverse strip is the division-error average

For $0<u<\ell$, the exact inverse strip is
$$
\boxed{c(-u)=(1-p^{-1})e^{-u/2}
\sum_{j\ge1}\chi_t(j\ell-u)
\left[\frac{\psi(p^je^{-u})}{p^je^{-u}}-1\right].}
\tag{9}
$$
Every summand is an actual prime-power-inclusive counting error. The sum is finite. Changing variables on the adjacent intervals $[(j-1)\ell,j\ell]$ gives
$$
\boxed{\int_0^\ell e^{u/2}c(-u)\,du
=(1-p^{-1})\int_0^\infty\chi_t(v)
\left[\frac{\psi(e^v)}{e^v}-1\right]dv.}
\tag{10}
$$
For the hard cutoff through $t$, the last integral is exactly
$$
\sum_{n\le e^t}\frac{\Lambda(n)}n-\frac{\psi(e^t)}{e^t}-t.
\tag{11}
$$
At an integer upper endpoint the newly included summand in (11) cancels between the two prime terms, so (11) has the correct continuous endpoint convention.

The classical PNT remainder makes the integrand in (10) absolutely integrable. Its integral over the half-line is $-1-\gamma$. One direct calculation is to integrate against $e^{-sv}$, $s>0$, obtaining
$$
\frac{-\zeta'(1+s)/\zeta(1+s)}{1+s}-\frac1s;
$$
the Laurent expansion at $s=0$, followed by dominated convergence, gives the asserted value. Hence (10), for either the hard cutoff or the retained continuous taper, tends to
$$
-(1-p^{-1})(1+\gamma)<0.
\tag{12}
$$
The strip itself converges uniformly: for example the unconditional bound in Johnston–Yang, Theorem 1.1, arXiv:2204.01980v2, bounds the omitted geometric-scale tail uniformly in $0\le u\le\ell$ by a constant times a convergent sum of $(1+j\ell)^{1.515}e^{-0.8274\sqrt{j\ell}}$. This is a statement about the strip; no global $L^2$ norm of the untruncated inverse is being asserted.

For $p=2$, the forward negative strip is the fixed seed $b(-u)=e^{-u/2}$. For general fixed $p$, retain its actual formula
$$
b(-u)=-r a(\ell-u)
=e^{-u/2}-p^{-1}e^{u/2}\psi(pe^{-u}).
\tag{13}
$$
It includes the primes below $p$ and is not replaced by the dyadic seed.

The companion proof [two history bilinear storage](../prime-history/two-history-bilinear-storage.md) gives, in the dyadic case,
$$
(f*f)(s)=\mathcal I_f(s)+\mathcal B_f(s),\quad
\mathcal I_f=(Pb)*(Pc),
$$
$$
\mathcal B_f(s)=\int_0^\ell
[e^{-u/2}c(s+u)+c(-u)z(s+u)]\,du,\qquad s\ge0.
\tag{14}
$$
For a general prime replace the first coefficient by (13). Formula (12) signs a weighted strip average only. It does not sign the correlation $c(-u)z(s+u)$ in (14), nor its sum with the seed term. The actual terminal taper remains in $c(s+u)$ and $z(s+u)$, including when $s+u>t$.

## Separately projected histories retain a quarter-power bilinear cutoff

Define the smoothly retruncated causal histories
$$
F=\chi_tPb,\qquad G=\chi_tPc.
$$
They agree with $Pb,Pc$ on $[0,t]$. Therefore $F*G(s)=\mathcal I_f(s)$ simultaneously for every $0\le s\le t$. Both functions have support in $[0,t+1]$. The proof that follows concerns the signed Fourier product $\widehat F\widehat G$, not either modulus-square norm.

Write the actual input derivative as
$$
Df=\sum_{1\le n\le e^{t+1}}c_n\delta_{\log n}+w(s)ds,
\quad c_1=-1,\quad c_n=\chi_t(\log n)\Lambda(n)/\sqrt n\ (n\ge2).
\tag{15}
$$
Chebyshev and the continuous input cutoff give
$$
|w(s)|\le C e^{s/2}\mathbf1_{[0,t+1]},\quad
|c_n|\le(1+\log n)/\sqrt n.
$$
There are no terminal cutoff atoms in (15).

Put $\alpha_{-1}=-r$, $\alpha_i=(1-r^2)r^i$ for $i\ge0$. Then (1)–(2) read
$$
b(s)=\sum_{i\ge-1}\alpha_if(s-i\ell),\qquad
c(s)=\sum_{j\ge-1}\alpha_jf(s+j\ell),
\quad |\alpha_i|\le r^i.
\tag{16}
$$
On the positive support of $F,G$, it suffices to keep indices
$$
-1\le i,j\le J_t:=\left\lfloor\frac{t+1}{\ell}\right\rfloor.
\tag{17}
$$
Indeed, positive delays have $i\ell\le s\le t+1$, while an inverse advance requires $s+j\ell\le t+1$. The index $-1$ is the separate advance/delay term in each transport. Prime-power arrivals exactly at a support endpoint are retained with the cutoff value there, which is zero at $t+1$.

The derivative measures of $F,G$ each have three parts: shifted atoms at strictly positive locations, a new causal-projection atom at zero, and an ordinary density. The projection atoms are exactly
$$
b(0+)\delta_0,\qquad c(0+)\delta_0,
\quad |b(0+)|\le C_p,\quad |c(0+)|\le C_pH.
\tag{18}
$$
These values already include any shifted input atoms reaching zero; such atoms must not be counted a second time as exact terms. Positive shifted atoms may be bounded in absolute value by the entire list from (16), which is harmless overcounting for an upper bound. The second estimate in (18) follows because each $r^jf(j\ell)$ is $O(1)$, and there are $O_p(H)$ indices. No PNT input is used here.

More explicitly, because $t\ge\ell$, the right-hand values are
$$
b(0+)=\frac{1-\psi(p)}p,\qquad
c(0+)=(1-p^{-1})\sum_{j\ge0}\chi_t(j\ell)
\left[\frac{\psi(p^j)}{p^j}-1\right].
$$
The $j=0$ summand in the second formula is $-1$. Values at $p^j$ include the arriving prime power. These right-hand values generally differ from the negative-strip limits; the difference is precisely why the projection atoms cannot be omitted.

The ordinary derivative densities include both the transported $w$ and the new cutoff derivatives $\chi_t'b,\chi_t'c$. Geometric summation gives, on $0\le s\le t+1$,
$$
|b(s)|+|w_b(s)|\le C_pe^{s/2},\qquad
|c(s)|+|w_c(s)|\le C_pHe^{s/2}.
$$
For the delays, $r^ie^{(s-i\ell)/2}=p^{-i}e^{s/2}$ is summable. For inverse advances, $r^je^{(s+j\ell)/2}=e^{s/2}$, and (17) costs $O_p(H)$. The same bounds therefore hold for the densities of $DF,DG$. In particular
$$
\|DF\|_{\mathrm{TV}}\le C_pe^{t/2},\qquad
\|DG\|_{\mathrm{TV}}\le C_pHe^{t/2},\qquad
\|DF*DG\|_{\mathrm{TV}}\le C_pHe^t.
\tag{19}
$$

### Paying the rational product denominators

Two positive shifted input atoms have product-history location
$$
\log n+i\ell+\log m-j\ell=\log(nm p^{i-j})
$$
and absolute product coefficient at most
$$
C H^2p^{-(i+j)/2}/\sqrt{nm}.
\tag{20}
$$
Fix $0\le u\le t+1$, $0<h\le1$, and put $Y=p^{j-i}e^u$. The window of radius $h$ requires $e^{-h}Y\le nm\le e^hY$. The elementary divisor hyperbola bound implies
$$
\#\{(n,m):|\log(nm/Y)|\le h\}
\le C\{Yh\log(2+Y)+\sqrt Y\}
\tag{21}
$$
whenever the window contains an integer product. If $Y<e^{-1}$ it contains none; on the remaining bounded range the same bound holds after enlarging $C$. Endpoint products are covered by the $\sqrt Y$ term. In the present index range, $\log(2+Y)\le C_pH$.

Combining (20)–(21) gives, for fixed $i,j$, the bound
$$
C_p\left[H^3p^{-i}e^{u/2}h+H^2p^{-(i+j)/2}\right].
\tag{22}
$$
Here the exact exponents matter: $p^{-(i+j)/2}\sqrt Y=p^{-i}e^{u/2}$, while the divisor-count remainder cancels the factor $1/\sqrt Y$. Summing $i,j$ in (17), the first term costs $O_p(H)$ from the advances and a convergent geometric sum from the delays. Both sums in the second term are geometric. Thus the positive shifted-atom pairs contribute at most
$$
C_p[H^4e^{u/2}h+H^2].
\tag{23}
$$
Collisions of different indices at one rational location are covered by this total-variation domination; distinctness of the rational locations is not assumed.

The projection atoms (18) require separate checks. For the positive atoms of $DF$, summing the individual integer-window bounds in (16) gives
$$
|\mu_F|([u-h,u+h])\le C_p[(1+u)e^{u/2}h+1].
\tag{24}
$$
In detail, the delay count's remainder is bounded by $C_p(1+u)^2e^{-u/2}\le C_p$, since only $i\ell\le u+1$ can occur. The corresponding inverse-advance bound is
$$
|\mu_G|([u-h,u+h])\le C_p[H^2e^{u/2}h+1].
\tag{25}
$$
Its remainder is bounded by the convergent sum
$e^{-u/2}\sum_{j\ge-1}p^{-j}(1+u+j\ell)_+$, with the bounded exceptional index absorbed into $C_p$. Multiplying (24) by the $O_p(H)$ atom of $DG$, and (25) by the $O_p(1)$ atom of $DF$, is absorbed by (23). Their atom-at-zero product is $O_p(H)$, also absorbed. These are upper bounds on the positive-location atomic parts; the atoms at zero themselves are kept separately as in (18).

Finally, the continuous parts of $DF*DG$ have density at most
$$
C_pH(1+s)e^{s/2},\qquad s\ge0.
\tag{26}
$$
For the mixed parts, use the prefix-variation bounds $C_pe^{s/2}$ and $C_pHe^{s/2}$, and partial summation against $e^{-s/2}$. This gives weighted prefix masses $O_p(1+s)$ and $O_p(H(1+s))$. For the density product, integrate the two exponential bounds over an interval of length $s$. Thus all density terms, including the new cutoff derivatives, are covered. Equations (23)–(26) prove
$$
\boxed{|D^2(F*G)|([u-h,u+h])
\le C_p[H^4e^{u/2}h+H^2],
\quad 0\le u\le t+1,\ 0<h\le1.}
\tag{27}
$$

### Frequency consequence and the retained signed boundary

Use the fixed smooth flat-top multiplier and inverse kernel from [product location frequency cutoff](../analytic-methods/product-location-frequency-cutoff.md):
$$
R_\Omega=\mathcal F^{-1}\left[\frac{1-m(\xi/\Omega)}{(i\xi)^2}\right],
\qquad |R_\Omega(z)|\le C_M\Omega^{-1}(1+\Omega|z|)^{-M}.
$$
The exact error is $R_\Omega*(DF*DG)$. Local dyadic shells use (27), and the far region uses (19). Uniformly for $0\le s\le t$,
$$
\left|\mathcal I_f(s)-\frac1{2\pi}\int
m(\xi/\Omega)\widehat F(\xi)\widehat G(\xi)e^{i\xi s}\,d\xi\right|
\le C_{p,M}\left[
\frac{H^4e^{s/2}}{\Omega^2}+\frac{H^2}{\Omega}
+\frac{He^t}{\Omega^{M+1}}\right].
\tag{28}
$$
The entire future support of $F*G$, through $2t+2$, is included in the far bound. The initial projection atoms are covered by the $H^2/\Omega$ term.

Harmonic sampling and the complete filter $I-k*$ give, even using just their uniform-norm bounds, an error at most
$$
\boxed{C_{p,M}\left[
\frac{H^5e^{t/2}}{\Omega^2}+\frac{H^3}{\Omega}
+\frac{H^2e^t}{\Omega^{M+1}}\right].}
\tag{29}
$$
In particular $\Omega=e^{t/4}H^3$, $M\ge4$, gives $O_p(H^{-1})$. The exact signed integrand is
$m(\xi/\Omega)\widehat F(\xi)\widehat G(\xi)\mathcal M_t(\xi)$, where the full multiplier $\mathcal M_t$ includes the endpoint term from the successor note.

Since $\mathcal B_f=f*f-\mathcal I_f$ on the whole interval $[0,t]$, subtracting (28) from the original product-location formula gives the same cutoff for the boundary readout, with signed integrand
$$
m(\xi/\Omega)
[\widehat f(\xi)^2-\widehat F(\xi)\widehat G(\xi)]\mathcal M_t(\xi).
\tag{30}
$$
This is additional arithmetic regularity of weighted rational product locations. It is not signed cancellation, and it is not an estimate for a ratio-location norm involving $\lvert\widehat f\rvert^2$. The remaining signed quantity is precisely the harmonic/filter readout of (14); its strip average (12) does not determine its sign. No uniform extension to a growing collection of prime transports is proved here.
