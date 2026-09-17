# Prime transport in the mixed additive completion

Use the Hilbert completion and the actual-source estimates (5), (7)–(10) from [actual-source-mixed-dirichlet-completion.md](../dynamics-and-feedback/actual-source-mixed-dirichlet-completion.md). Its norm is
$$
\|f\|_{\mathcal E}^2=\int_{\mathbb R}m(\xi)|\widehat f(\xi)|^2\,d\xi,
\quad
m(\xi)=2\int_0^1(1-\cos\xi h)\,dh+
2\int_1^\infty\frac{1-\cos\xi h}{h^2}\,dh.
\tag{1}
$$
In particular $m(\xi)\sim\pi|\xi|$ at zero, $m(\xi)\to4$ at infinity, and
$c_m\min(|\xi|,1)\le m(\xi)\le C_m\min(|\xi|,1)$.
The arguments below take place directly in $L^2(m(\xi)d\xi)$, which represents the completion modulo constants. No unweighted norm for the actual full source is assumed.

## Dilation norms and the critical inverse

For $D_af(x)=\sqrt a\,f(ax)$, the unitary additive Fourier convention gives
$$
\widehat{D_af}(\xi)=a^{-1/2}\widehat f(\xi/a),\qquad
\|D_af\|_{\mathcal E}^2=\int m(a\xi)|\widehat f(\xi)|^2d\xi.
\tag{2}
$$
The increment kernel comparison in the source note's (6) gives
$m(a\xi)\le a m(\xi)$ for $a\ge1$. The low-frequency limit gives $m(a\xi)/m(\xi)\to a$. Thus
$$
\boxed{\|D_a\|_{\mathcal E\to\mathcal E}=\sqrt a\quad(a\ge1).}
\tag{3}
$$
For $0<a\le1$, comparison with $\min(|\xi|,1)$ instead gives the uniform bound
$$
\|D_a\|\le\kappa:=\sqrt{C_m/c_m}.
\tag{4}
$$
The high-frequency limit in (2) also gives $\|D_a\|\ge1$ for every fixed $a>0$. We do not assume that $m$ is monotone.

Fix a prime $p$, put $r=p^{-1/2}$, $S=D_p$, and define
$$
C_+=I-rS,\qquad C_-=I-rS^{-1},\qquad
R_-=C_-^{-1},\qquad U=C_+R_-.
\tag{5}
$$
All prime powers are retained by
$$
R_-=\sum_{j\ge0}r^jD_{p^{-j}},\qquad
\|R_-\|\le1+\frac{\kappa r}{1-r}
\le1+\frac{\kappa}{\sqrt2-1}=:R_*.
\tag{6}
$$
Indeed (4) proves operator-norm convergence. Moreover the spectral radius of $rS^{-1}$ is exactly $r<1$: the norm of its $j$th power lies between $r^j$ and $\kappa r^j$. Consequently $U$ and $K:=U-I$ are bounded, uniformly over all primes. One can use
$$
\|U\|\le2R_*,\qquad
K=r(S^{-1}-S)R_-,\qquad
\|K\|\le(1+\kappa/\sqrt2)R_*.
\tag{7}
$$

The opposite geometric series has a different operator meaning. By (3),
$$
\|(rS)^j\|=1\qquad(j\ge0).
\tag{8}
$$
There is an actual approximate null sequence for $C_+$, not merely a failed norm estimate. On positive frequencies set $\xi=e^s$ and use the isometry
$$
v(s)=\sqrt{e^s m(e^s)}\,\widehat f(e^s).
$$
Writing $\ell=\log p$, the operator $rS$ becomes
$$
v(s)\longmapsto w_p(s)v(s-\ell),\qquad
w_p(s)=r\sqrt{\frac{m(e^s)}{m(e^{s-\ell})}}\longrightarrow1
\quad(s\to-\infty).
\tag{9}
$$
Choose $\varphi\in C_c^\infty(-1,0)$ of norm one and
$v_j(s)=j^{-1/2}\varphi((s+j^2)/j)$.
These have norm one and support tending to negative infinity. Their translation difference has norm at most $\ell\|\varphi'\|_2/j$, and the weight in (9) tends uniformly to one on the shifted supports. Hence $\|C_+f_j\|_{\mathcal E}\to0$. Each $\widehat f_j$ has compact support away from zero, so the construction already lies in the original dense Fourier domain.

It follows that $C_+$ is not bounded below. Taking $y_j=C_-f_j$, one has $\|y_j\|\ge R_*^{-1}$, while $Uy_j=C_+f_j\to0$. Thus $U$ has no bounded inverse on the full completion.

For completeness, $U$ is injective and has dense range. For $a>1$ and $\xi\ne0$, the kernel comparison proving (3) is strict: on $0<h<1$, its difference contains the positive coefficient $a-a^{-1}$ times $1-\cos\xi h$. Thus $m(a\xi)<a m(\xi)$, and $\|rSf\|<\|f\|$ for every nonzero $f$. This excludes fixed vectors of $rS$. It also excludes fixed vectors of its adjoint: such a vector would force equality in $|\langle f,rSf\rangle|\le\|f\|\|rSf\|$. Hence $C_+$, and therefore $U$, are injective with dense range. The inverse of $U$ is a closed unbounded operator on $\operatorname{Ran}U$.

## Exact adjoint and metric defect

Let $\dagger$ denote the adjoint for $\mathcal E$. Changing variables in the Fourier pairing gives
$$
\widehat{D_a^\dagger f}(\xi)
=\sqrt a\,\frac{m(a\xi)}{m(\xi)}\widehat f(a\xi),
\qquad
D_a^\dagger=M_{m(a\xi)/m(\xi)}D_{1/a}.
\tag{10}
$$
Here $M_b$ means multiplication by $b$ in additive Fourier coordinates. In particular $D_a^\dagger$ is generally different from $D_{1/a}$. If
$\alpha(\xi)=m(p\xi)/m(\xi)$ and
$\beta(\xi)=m(\xi/p)/m(\xi)$, then
$$
S^\dagger=M_\alpha S^{-1},\qquad
(S^{-1})^\dagger=M_\beta S,
$$
$$
U^\dagger=(I-rM_\beta S)^{-1}(I-rM_\alpha S^{-1}).
\tag{11}
$$
The inverse in (11) is the bounded adjoint of (6). It must not be replaced by the generally unbounded $U^{-1}=C_-C_+^{-1}$.

An explicit full metric defect, retaining the quadratic same-prime term, is
$$
U^\dagger U-I=R_-^\dagger\mathfrak M_pR_-,
$$
$$
\mathfrak M_p
=r\bigl[S^{-1}+(S^{-1})^\dagger-S-S^\dagger\bigr]
+r^2M_{\alpha-\beta}.
\tag{12}
$$
This follows by expanding $C_+^\dagger C_+-C_-^\dagger C_-$. The resolvents in (12) contain every inverse-dilation power.

The positive completed-space Laplacian and the actual transported expression are
$$
L_p^{\mathcal E}=K^\dagger K,
\qquad L_p=2I-U-U^{-1},\qquad
B_p=U^\dagger-U^{-1}.
$$
On $\operatorname{Ran}U$, which is invariant under $U$ and $K$, their exact relationship is
$$
\boxed{L_p^{\mathcal E}=L_p+B_pK.}
\tag{13}
$$
Indeed $(U^\dagger-U^{-1})(U-I)=U^\dagger U-U^\dagger-I+U^{-1}$. For a source in this domain,
$$
\|Kg\|_{\mathcal E}^2
=\operatorname{Re}\langle g,L_pg\rangle_{\mathcal E}
+\operatorname{Re}\langle g,B_pKg\rangle_{\mathcal E}.
\tag{14}
$$
Neither term on the right is given a sign. In particular positivity of the left side does not identify $L_p$ as a positive operator in this metric.

## Actual-source convergence and a quantitative bulk correction

Let $g_T$ and $g$ be the complete actual sources from the cited completion. Its equation (7) implies, uniformly in $T$,
$$
\sum_{j\ge0}\|r^jD_{p^j}g_T\|_{\mathcal E}<\infty.
$$
Define $R_+g_T$ by this full series. Its terms tend to zero; telescoping gives $C_+R_+g_T=g_T$. The same holds for $g$, and dominated convergence gives $R_+g_T\to R_+g$. Hence these actual sources lie in $\operatorname{Ran}U$, with
$$
U^{-1}g_T=C_-R_+g_T\longrightarrow C_-R_+g=U^{-1}g.
\tag{15}
$$
This is a source-conditioned inverse, despite the full-space obstruction above.

Using the commutation in (7), the uniform actual bound for inverse dilations, and the source's positive-dilation estimate gives
$$
\|Kg_T\|_{\mathcal E}
\le rR_*\bigl(\|D_{1/p}g_T\|_{\mathcal E}+\|D_pg_T\|_{\mathcal E}\bigr)
\le C\left[p^{-1/2}+e^{-c\sqrt{\log p}}\right].
\tag{16}
$$
No power in (6) was removed to obtain this bound. The complete all-power expansion is
$$
L_pg_T=2p^{-1}g_T+p^{-3/2}(D_p+D_{1/p})g_T
-(1-p^{-1})\sum_{j\ge2}p^{-j/2}(D_{p^j}+D_{p^{-j}})g_T.
\tag{17}
$$
Its norm is at most $C[p^{-1}+\sum_{j\ge2}e^{-c\sqrt{j\log p}}]$. Integral comparison, uniformly for $\log p\ge\log2$, bounds the last sum by $C'e^{-c'\sqrt{\log p}}$. Thus (7), (13), and (16) give
$$
\boxed{\|B_pKg_T\|_{\mathcal E}
\le\|K\|\|Kg_T\|_{\mathcal E}+\|L_pg_T\|_{\mathcal E}
\le C\left[p^{-1/2}+e^{-c'\sqrt{\log p}}\right].}
\tag{18}
$$
There is no claim that $B_p$ is bounded on arbitrary elements of the completion.

Chebyshev's upper bound $\pi(P)\ll P/\log P$ now gives, after changing positive constants, for $P\ge3$,
$$
\sum_{p\le P}\|Kg_T\|_{\mathcal E}^2
\le C\frac{P}{\log P}e^{-c_1\sqrt{\log P}},
$$
$$
\sum_{p\le P}\|B_pKg_T\|_{\mathcal E}
\le C\frac{P}{\log P}e^{-c_2\sqrt{\log P}}.
\tag{19}
$$
To verify the exponential prime sums, split at $\sqrt P$: the lower primes cost at most $\sqrt P$, and the remaining primes have the stated exponential factor times $\pi(P)$. The lower cost and the elementary sums of $p^{-1}$ or $p^{-1/2}$ are absorbed by the displayed upper bounds for sufficiently large $P$; enlarge the constants on the remaining compact range. No RH estimate is used.

For fixed finite admission, every term in (13) converges as $T\to\infty$: the bounded $K^\dagger K$ consumes convergence in $\mathcal E$, and the actual $L_p$ consumes (17). The same estimates hold for the limiting source. Since $\sup_T\|g_T\|_{\mathcal E}<\infty$, (18)–(19) also bound the absolute difference between the actual collective quadratic pairing and its positive completed-space energy. They do not show that this correction has a sign, is relatively smaller than that energy, or remains bounded as the prime admission grows. The initial source jump, all admitted-prime powers, and the cutoff endpoints are retained through the cited source estimates and the complete series (6), (15), and (17).

## A negative quadratic form for the actual operator

The metric distinction can be tested on the exact domain of $L_p$. This gives a counterexample to transferring unweighted positivity to $\mathcal E$, without making a claim about the actual prime-error source.

Retain $\ell=\log p$, and modulate the packets from (9) by
$$
v_j(s)=j^{-1/2}e^{-i\pi s/\ell}\varphi((s+j^2)/j).
\tag{20}
$$
They still have norm one. The limiting dilation weights at negative infinity and their slowly varying envelopes give
$$
\|Sf_j+\sqrt p\,f_j\|_{\mathcal E}\to0,
\qquad
\|S^{-1}f_j+p^{-1/2}f_j\|_{\mathcal E}\to0.
\tag{21}
$$
The second formula follows either directly from the inverse shift or by applying the bounded $S^{-1}$ to the first residual. Set
$$
d=1+p^{-1},\qquad u=\frac2{1+p^{-1}}.
$$
Equations (21) imply $C_+f_j-2f_j\to0$ and $C_-f_j-df_j\to0$. Since $R_-$ is bounded,
$$
R_-f_j-d^{-1}f_j=-d^{-1}R_-(C_-f_j-df_j)\longrightarrow0,
\quad
Uf_j-uf_j\longrightarrow0.
\tag{22}
$$
Now choose $h_j=C_+f_j$. This places the test exactly in the domain of the full inverse: $h_j=U(C_-f_j)$, so
$$
U^{-1}h_j=C_-f_j
\tag{23}
$$
for every $j$, not just in a limiting model. Also $h_j-2f_j\to0$, $Uh_j-2u f_j\to0$, and $U^{-1}h_j-df_j\to0$. Thus
$$
\boxed{
\frac{\operatorname{Re}\langle h_j,L_ph_j\rangle_{\mathcal E}}
{\|h_j\|_{\mathcal E}^2}
\longrightarrow 2-u-u^{-1}
=-\frac{(1-p^{-1})^2}{2(1+p^{-1})}<0.}
\tag{24}
$$
For each fixed prime, sufficiently long packets therefore give a strictly negative quadratic form for the actual full operator $L_p$. Hermitian reflection of the positive-frequency packets onto negative frequencies, followed by normalization, makes all physical tests real and leaves the limits unchanged. Every test remains in the exact domain by the construction $h_j=C_+f_j$.

At the same time,
$$
\frac{\langle h_j,L_p^{\mathcal E}h_j\rangle_{\mathcal E}}
{\|h_j\|_{\mathcal E}^2}\longrightarrow(u-1)^2
=\frac{(1-p^{-1})^2}{(1+p^{-1})^2}.
$$
By the exact metric identity (13), the bulk correction tends to
$$
\frac{(1-p^{-1})^2(3+p^{-1})}{2(1+p^{-1})^2}.
\tag{25}
$$
For $p=2$, these three limits are respectively $-1/12$, $1/9$, and $7/36$. The correction is therefore essential even for one fixed generator. In particular $L_p$ is not accretive on this completed metric and cannot, on its stated domain, be the negative of a contraction-semigroup generator. The bounded positive operator $L_p^{\mathcal E}$ does generate its own contraction semigroup, but (13) and (24) show that this is a different operator. The synthetic witnesses establish the operator obstruction only; the source-conditioned bounds (15)–(19) and the signed pairing of the actual $g$ remain separate statements.

All domain, transport and readout assertions in this note are written mathematics. They make no Lean or arithmetic-sign claim.
