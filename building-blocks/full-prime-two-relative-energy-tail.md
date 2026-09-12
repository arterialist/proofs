# The coherent all-prime energy remainder for the actual source at two

Keep the actual $N=2$ inputs $g,h$, constants $A=2-\log2$, and $\kappa=\kappa_2$ from [the complete source formulas](full-prime-two-energy-certificate.md#appendix-a-complete-per-prime-profiles-and-their-domains). Let
$$
O=\sum_pY_{p,g},\qquad N=\sum_pY_{p,h},\qquad
y=UO,\qquad z=U(N-O).
$$
These are the complete original $L^2$ prime-cutoff limits, with every proper power. The full corrected output $N$ is positive; $O$ is supported in $[0,1]$.

The later [complete certificate](full-prime-two-energy-certificate.md)
now proves $\mathcal E(O)-\mathcal E(N)>1/200$ for this actual
full-prime source at two. The present note supplies its earlier
analytical tail reduction and the signed, sharper joint tail formula:
$$
\boxed{
\int_0^{e^{-H}}(O(x)^2-N(x)^2)\,dx
=\frac{C_0M_P}{H^2}+O(H^{-3}),\qquad C_0M_P>0.
} \tag{1}
$$
It includes all omitted primes coherently. It is not obtained by subtracting separate $O(H^{-1})$ squared-norm tails. Below we give an explicit error functional in the actual prime-kernel remainder, as well as a useful positive part of the retained $K$ form.

## 1. Exact full-energy reduction and an additional positive margin

Write
$$
m=\int O=A\sum_p\frac{\log p}{p(p-1)},\qquad
c=\int_0^1N.
$$
The original physical energy gives the exact identity
$$
\mathcal E(O)-\mathcal E(N)
=4I-m^2+\iint K(x-y)N(x)N(y)\,dx\,dy,
\qquad I=\int(O^2-N^2),
\tag{2}
$$
where $K(v)=\min(1,|v|^{-2})$. Since $N\ge0$ and $K=1$ on $[0,1]^2$,
$$
\mathcal E(O)-\mathcal E(N)\ge 4I+c^2-m^2. \tag{3}
$$
This retains a strictly positive part of the new-output kernel form, with all cross-prime products. The part not used in this lower bound is nonnegative for this actual positive output.

There is an elementary all-prime sign for the mass difference. For each prime,
$$
c_p=\frac A p\sum_{k\ge1}p^{-k}
 \log\frac{1+p^{k+1}}{1+p^k}
 +\frac{\kappa\log p}{p(p-1)},\qquad
m_p=\frac{A\log p}{p(p-1)} .
\tag{4}
$$
Consequently
$$
c_p-m_p
=\frac{\kappa\log p}{p(p-1)}
-\frac A p\sum_{k\ge1}p^{-k}
 \log\frac{1+p^{-k}}{1+p^{-k-1}} .
\tag{5}
$$
The last sum, including all powers, is at most
$$
\sum_{k\ge1}p^{-k}(p^{-k}-p^{-k-1})
=\frac1{p(p+1)}.
$$
Thus
$$
c_p-m_p\ge
\frac{\kappa\log p}{p(p-1)}-\frac A{p^2(p+1)}>0
\qquad(p\ge3). \tag{6}
$$
For the strict inequality, $\kappa>.31$, $A<1.31$, $\log p\ge\log3>1$, and $p(p+1)/(p-1)\ge6$ suffice. At $p=2$ the previously certified exact series gives $c_2>.4779333237>m_2$. Therefore $c>m>0$. In fact the checked $p=2,3$ bounds alone imply
$$
c-m>.051,\qquad c+m>1.43,\qquad
\boxed{c^2-m^2>.0729.} \tag{7}
$$
All further primes increase both quantities used in this product bound. Thus proving merely $I>-.018225$ would already suffice in (3); the stronger condition $4I>m^2$, which discards the entire new $K$ form, is unnecessary.

## 2. Fixed-source continuum comparisons, with the actual stepped error

Set $a=Ug$, $f=Uh-Ug=P'$, and
$$
P(v)=\int_0^v f(u)\,du,\qquad
M_P=\int_0^\infty P(v)\,dv>0,\qquad
P_1=\int_0^\infty vP(v)\,dv .
$$
The actual primitive is positive, as proved in Section 5 of the complete certificate, vanishes at zero, and has an exponential tail; $\int f=0$. Also $a\le0$. Define
$$
C_0=-\int_0^\infty a(v)\,dv
=2(\sqrt2-1)+\sqrt2 A>0,\qquad
C_1=-\int_0^\infty va(v)\,dv<\infty .
\tag{8}
$$
Both first moments here are moments of the fixed actual source, not new arithmetic estimates.

Use the established complete prime kernel and its smooth comparison:
$$
B(t)=\sum_p e^{t/2}p^{-\lfloor t/\log p\rfloor-1}
\mathbf1_{t\ge\log p},\qquad
C(t)=\int_0^\infty\frac{e^{-tu}}{u+1/2}\,du,
$$
$$
e(h)=\sup_{t\ge h}|B(t)-C(t)|.
\tag{9}
$$
One-sided choices at the prime-power jumps do not affect the energy integrals. The ordinary PNT value estimate gives $e(h)\le C_*e^{-c_*\sqrt h}$ for some constants. For completeness, use the exact power-sector decomposition (13) of the certificate. Partial summation of the classical estimate $\theta(x)=x+O(xe^{-c\sqrt{\log x}})$ makes the first sector differ from $C(t)$ by $O(e^{-c_1\sqrt t})$. Its removed upper tail is exponentially small. The sum of sectors $j\ge2$ is $O((1+t)e^{-c_2t})$ by the elementary bounds (15)–(16). This proves the asserted value estimate. [Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689) supplies an explicit primary PNT bound of this form. No derivative of the stepped error is taken.

Let
$$
\nu_a=(D+\tfrac12)a,\qquad \nu_f=(D+\tfrac12)f,
\qquad V_a=\|\nu_a\|_{\rm TV},\quad V_f=\|\nu_f\|_{\rm TV}.
$$
For this fixed source both are finite measures, including their initial atoms and the $v=\log2$ arrival. Explicitly,
$$
\nu_a=-\delta_0+\frac{\log2}{\sqrt2}\delta_{\log2}
-e^{v/2}\mathbf1_{(0,\log2)}\,dv,
$$
$$
\nu_b=-(A/2+\kappa)\delta_0
-A\frac{e^{v/2}}{(1+e^v)^2}\mathbf1_{v>0}\,dv,
\qquad \nu_f=\nu_b-\nu_a.
\tag{10}
$$
Hence
$$
V_a=2\sqrt2-1+\frac{\log2}{\sqrt2},\qquad
V_f\le V_a+\|\nu_b\|_{\rm TV}=4\sqrt2-2 .
\tag{11}
$$
Here $\|\nu_b\|_{\rm TV}=\kappa+\pi A/4$. These formulas retain both source endpoints; there is no artificial terminal atom.

The exact anticausal measure representation gives, almost everywhere in $h>0$,
$$
y(-h)=-\int B(h+v)\,\nu_a(dv),\qquad
z(-h)=-\int B(h+v)\,\nu_f(dv).
\tag{12}
$$
At the countable collision ages a complementary representative gives the same $L^2$ function. We use (12) only in integrals, so no endpoint contribution is suppressed from its measure or from the resulting energy.

Integration by parts against the smooth $C$, using
$C'(t)-C(t)/2=-1/t$, gives
$$
Y(h):=-\int_0^\infty\frac{a(v)}{h+v}\,dv>0,\qquad
J(h):=\int_0^\infty\frac{P(v)}{(h+v)^2}\,dv>0.
$$
Consequently
$$
y(-h)=Y(h)+\epsilon_y(h),\qquad
z(-h)=-J(h)+\epsilon_z(h),
$$
$$
|\epsilon_y(h)|\le V_a e(h),\qquad
|\epsilon_z(h)|\le V_f e(h).
\tag{13}
$$
The zero integral of $f$, equivalently the two endpoints of $P$, is what changes the leading relative return from order $h^{-1}$ to order $h^{-2}$.

## 3. An explicit coherent norm-tail enclosure

Since $U$ is unitary and $z=UN-UO$, the exact small-$x$ norm difference is
$$
I_{\rm tail}(H)
=\int_H^\infty -z(-h)\,[2y(-h)+z(-h)]\,dh.
\tag{14}
$$
Substituting (13), its continuum principal integrand is
$$
J(h)\,[2Y(h)-J(h)].
$$
Using $Y(h)\le C_0/h$, $J(h)\le M_P/h^2$, the absolute pointwise error is bounded by
$$
\mathfrak e(h)=
\frac{2C_0V_f}{h}e(h)
+\frac{2M_P(V_a+V_f)}{h^2}e(h)
+(2V_aV_f+V_f^2)e(h)^2 .
\tag{15}
$$
Every mixed term in the quadratic increment is accounted for in this bound.

The elementary reciprocal inequalities give
$$
\left|Y(h)-\frac{C_0}{h}\right|\le\frac{C_1}{h^2},
\qquad
\left|J(h)-\frac{M_P}{h^2}\right|\le\frac{2P_1}{h^3}.
$$
Therefore, with
$$
K_{\rm mom}=2C_1M_P+4C_0P_1+M_P^2,
$$
one obtains the explicit two-sided bound
$$
\boxed{
\left|I_{\rm tail}(H)-\frac{C_0M_P}{H^2}\right|
\le \frac{K_{\rm mom}}{3H^3}
+\int_H^\infty\mathfrak e(h)\,dh .
} \tag{16}
$$
This proves (1) from the PNT value estimate, and also proves that the actual omitted negative-age norm difference is eventually strictly positive. The bound is on the joint arithmetic output, not on two separately estimated energy tails.

The $K$-form has an even smaller physical truncation error. For example
$$
\int_0^{e^{-H}}|O(x)|\,dx
\le\int_H^\infty e^{-h/2}
\left(\frac{C_0}{h}+V_a e(h)\right)dh,
$$
and the corresponding bound for $N$ adds
$M_P/h^2+V_f e(h)$. Since $K\le1$, the omitted part of each $K$-quadratic integral is at most twice the full $L^1$ norm times this tail mass. Thus it is $O(e^{-H/2}/H)$. In particular, if $O_H,N_H$ are cut only at $x=e^{-H}$, then
$$
\mathcal E(O)-\mathcal E(N)
-[\mathcal E(O_H)-\mathcal E(N_H)]
=\frac{4C_0M_P}{H^2}+O(H^{-3}).
\tag{17}
$$
No original-metric boundary term has been replaced by an age-translation metric.

## 4. An alternative finite-certificate criterion

A finite certified lower bound $I_{\rm core}(H)$ for the actual
$\int_{e^{-H}}^\infty(O^2-N^2)$, together with
$$
I_{\rm core}(H)+\frac{C_0M_P}{H^2}
-\frac{K_{\rm mom}}{3H^3}
-\int_H^\infty\mathfrak e(h)\,dh>-.018225,
\tag{18}
$$
would prove the all-prime energy decrease by (3) and (7).
Prime truncation inside this core must still be controlled. For $P\ge2e^H$, old primes above $P$ vanish there exactly, whereas their new-output tail satisfies
$$
0\le\sum_{p>P}N_p(x)
\le A x^{-2}\sum_{p>P}\frac1{p^2(p+1)}
\qquad(x\ge e^{-H}).
\tag{19}
$$
The full tail of (19) can be bounded by the integer series or a sharper proved prime estimate. A more efficient large-prime approximation may avoid such a large $P$, but must retain its signed old contribution before it vanishes.

This asymptotic method alone supplies no certified numerical onset for (18). The later complete certificate instead uses the explicit Dusart envelope (17), proves a stronger mass margin, and closes the sign by whole-cell interval convolution. Thus (18) remains a distinct sufficient criterion, rather than an unresolved status for the full-prime energy theorem.

The rigorous results here are the exact joint remainder (14), the
explicit enclosure (16), its positive leading coefficient, and the
additional kernel margin (7). The subsequent complete certificate
uses an explicit Dusart bound, a larger retained kernel margin, and
interval bounds on the coherent full-prime kernel to close the
original-energy sign. That sign is not inferred from the two-prime
Loewner theorem and does not assert a full-prime Loewner comparison
for arbitrary signed prime coefficients.

This chapter is a written analytical proof. The original-energy sign is certified in the linked companion; no Lean formalization of this tail asymptotic is claimed.
