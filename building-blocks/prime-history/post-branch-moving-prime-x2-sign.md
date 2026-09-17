# A complete admission sign reversal at the fixed clock \(X=2\)

The complete sampled energy decreases when the prime \(23\) is admitted to
the old packet \(D=23^-\#=9{,}699{,}690\) at the fixed integer clock
\(X=2\). The [finite interval certificate](../../formalization/verification/post_branch_moving_prime_x2.py)
gives

\[
-1.493601799186246032\,10^{-11}
\leq \Delta\mathcal E_{2,23}
\leq -1.493601791786906219\,10^{-11}.                 \tag{1}
\]

The previously [certified complete \(p=5\) increment](post-branch-total-admission-p5-x2.md)
is positive. Thus even at one fixed clock the complete prime-admission
increment has no universal positive sign. The two finite signs imply no
eventual sign law as the admitted prime grows.

## Literal row and exact moving-prime formula

Use the [published sampled source](../analytic-methods/simultaneous-nonendpoint-remainder-adversarial-audit.md#literal-row-and-normalization)
at \(X=2\). Set \(q=e^{-1}\), \(h=(\log2)/2\), and
\(c_2(n)=\mu(n)1_{2\nmid n}\), including \(c_2(1)=1\). For the closed
Green atom

\[
v_m(j)=q^{m-j/2}1_{1\leq j\leq m},\qquad
\langle v_m,v_n\rangle_q
=(1-q)\sum_{j\geq1}v_m(j)v_n(j)
=G_q(m,n):=q^{\max(m,n)}-q^{m+n},                         \tag{2}
\]

all integer endpoints are retained. For any admitted odd prime \(p\), put
\(D=\prod_{\ell<p,\ \ell\text{ prime}}\ell\) and

\[
A_D(m)=\sum_{\substack{d\mid D\\d\mid m}}
            \mu(d)c_2(m/d).                                \tag{3}
\]

The *complete* old row is \(h\sum_{m\geq1}A_D(m)v_m\). The newly
admitted row is \(-h\sum_{k\geq1}A_D(k)v_{pk}\): this includes its
endpoint \(k=1\), every rough prime and squarefree composite, and the
literal zero at each squareful coefficient. Absolute convergence follows
from \(|A_D(m)|\leq\tau(D)\) and \(\|v_m\|\leq q^{m/2}\). Consequently

\[
\frac{\Delta\mathcal E_{2,p}}{h^2}
=\sum_{k,l\geq1}A_D(k)A_D(l)G_q(pk,pl)
-2\sum_{m,k\geq1}A_D(m)A_D(k)G_q(m,pk).             \tag{4}
\]

Both orientations of each cross are represented by the factor \(2\).
There is no unlisted source, endpoint, or prime-power term in (4).

The \(k=1\) mode makes the obstruction explicit. Define

\[
\begin{aligned}
S_D(p)&=\sum_{m\leq p}A_D(m),\\
F_D^{\leq p}(q)&=\sum_{m\leq p}A_D(m)q^m,\\
R_D(p;q)&=\sum_{r\geq1}A_D(p+r)q^r.
\end{aligned}
\]

Splitting the first cross at the *closed* endpoint \(m=p\) gives exactly

\[
\sum_{m\geq1}A_D(m)G_q(m,p)
=q^p\bigl[S_D(p)-F_D^{\leq p}(q)
            +(1-q^p)R_D(p;q)\bigr].                       \tag{5}
\]

With \(T=\tau(D)=2^{\pi(p-1)}\), \(r=q^p\), and \(c=q/(1-q)\), (4)
therefore yields the **uniform moving-\(D\) identity**

\[
\frac{\Delta\mathcal E_{2,p}}{h^2r}
=1-r-2\bigl[S_D(p)-F_D^{\leq p}(q)
              +(1-r)R_D(p;q)\bigr]+\varepsilon_p,       \tag{6}
\]

where the entire omitted \(k\geq2\) packet satisfies

\[
|\varepsilon_p|\leq T^2r
\left\{\frac{3-r+2p(2-r)}{(1-r)^2}
             +\frac{2c}{1-r}\right\}.                    \tag{7}
\]

Indeed, the self-pair tail is at most
\(T^2\sum_{\max(k,l)\geq2}r^{\max(k,l)}
=T^2r^2(3-r)/(1-r)^2\). For the cross tail, the exact scalar majorant
\(\sum_{m\geq1}q^{\max(m,pk)}=r^k(pk+c)\) gives
\(2T^2r^2\{p(2-r)/(1-r)^2+c/(1-r)\}\). This proves (7), with no
Möbius cancellation. Since \(T^2\leq2^{p-1}\) for odd primes, (7) is
\(O(p(2/e)^p)\). This is a genuine uniform asymptotic reduction for the
moving primorial; its displayed main term remains an arithmetic quantity
that can change sign.

The named prefix in (6) is not arbitrary. If
\(M_{\mathrm{odd}}(x)=\sum_{n\leq x,\ 2\nmid n}\mu(n)\), then

\[
S_D(p)=\sum_{d\mid D}\mu(d)
M_{\mathrm{odd}}\!\left(\left\lfloor\frac pd\right\rfloor\right).
                                                               \tag{8}
\]

For every \(n<p\), all squarefree divisors of \(n\) occur in \(D\), so
\(A_D(n)=(\mu*\mu_{\mathrm{odd}})(n)\), while \(A_D(p)=-1\).
Thus \(S_D(p)\) is the prefix of a doubled-Möbius convolution through
\(p-1\), minus one. The infinite convolution
\(\mu*\mu_{\mathrm{odd}}\), whose coefficients agree with \(A_D\) below
\(p\), has Dirichlet series \(1/[(1-2^{-s})\zeta(s)^2]\) for
\(\Re s>1\). Formula (6) also retains the local
Abel-weighted future \(R_D(p;q)\). Neither (8) nor a bound on the
single prefix alone controls the sign without this future and the
remaining \(k\geq2\) contribution. The sign reversal (1) is instead
certified from the complete expression (4).

## Finite certificate and rigorous tail

At \(p=23\), the checker builds the actual 256 signed divisors of
\(D=2\cdot3\cdot5\cdot7\cdot11\cdot13\cdot17\cdot19\). It computes
\(A_D(m)\) exactly for \(m\leq120\), and the complete new coefficient
\(A_D(k)\) for \(k\leq4\). By (2), their finite increment is an
integer-coefficient polynomial in \(q\), multiplied by \(h^2\).
Alternating rational exponential and positive rational logarithm series
enclose \(q\) and \(h\); outward 80-digit decimal operations enclose
the polynomial. The certificate verifies
\(q^{1/2}<5/8\), \(q^{23/2}<1/90000\), and \(h<1\).

For the unscaled old and new truncations, write
\(r_0=5/8\), \(s_0=1/90000\), and \(T=256\). The omitted Hilbert norms
and full truncation norms obey

\[
\begin{array}{ll}
\eta_o\leq T r_0^{121}/(1-r_0),&
N_o\leq T r_0/(1-r_0),\\
\eta_n\leq T s_0^5/(1-s_0),&
N_n\leq T s_0/(1-s_0).
\end{array}                                                     \tag{9}
\]

The discrepancy between the complete and finite increment is at most

\[
2N_n\eta_n+\eta_n^2+2\eta_oN_n+2N_o\eta_n
  +2\eta_o\eta_n<3.700\times10^{-20}.                 \tag{10}
\]

This bounds every omitted infinite source coefficient without assuming
its sign; multiplication by \(h^2<1\) can only reduce the bound. The
finite interval and (10) give (1). At \(p=23\), the prefix
\(S_D(23)=1\), but that single integer is not the certified sign
calculation: the Abel past/future and all remaining packets are included.
