# Full-prime heat under a fixed observation

These are written mathematical results, not Lean formalizations. Every power of each admitted prime is retained. The transition comes from the pole on the line of absolute convergence and does not prove RH.

The [fixed-Cauchy covariance theorem](fixed-cauchy-prime-covariance-seed.md) supplies the boundary coordinates. The [uniform partial-prime cosine estimates](uniform-partial-prime-cosines.md) control the full frequency line before exponentiation. The proofs below retain two distinct transition methods: direct fixed-cutoff domination and the Euler-logarithm/remote-tail split in the final section. They also retain the source cancellation, successor-domain counterexample and strong physical profile. No publication-priority claim is made.

## 1. Actual generator and complete correction

For $P\ge2$, put $A=\log P$ and
$$
 U_p(\nu)=\frac{1-p^{-1/2}e^{i\nu\log p}}
 {1-p^{-1/2}e^{-i\nu\log p}},\quad
 L_P=\sum_{p\le P}|U_p-1|^2,\quad H_P=\sum_{p\le P}p^{-1},
 \quad G_P=L_P-2H_P.
 \tag{1}
$$
Use the fixed probability measure
$$
 d\mathsf C(\nu)=w(\nu)d\nu,\qquad
 w(\nu)=\frac1{2\pi(1/4+\nu^2)},\qquad
 Z_P(s)=\int e^{-sG_P}\,d\mathsf C.
 \tag{2}
$$
Each finite $G_P$ is bounded, so $Z_P$ is entire. No expanding observation window or independent-prime averaging is used.

The exact local denominator gives
$$
 |U_p-1|^2=\frac{2p^{-1}[1-\cos(2\nu\log p)]}
 {1-2p^{-1/2}\cos(\nu\log p)+p^{-1}}.
$$
Consequently
$$
 G_P=-2S_P+K_P,\qquad
 S_P(\nu)=\sum_{p\le P}\frac{\cos(2\nu\log p)}p,
 \tag{3}
$$
with the exact signed correction
$$
 K_P=2\sum_{p\le P}\left[
 p^{-3/2}\cos(\nu\log p)+p^{-2}\cos(2\nu\log p)
 -(1-p^{-1})\sum_{j\ge3}p^{-j/2}\cos(j\nu\log p)\right].
 \tag{4}
$$
It converges absolutely and uniformly on the real line to $K$. The denominator is at least $(1-2^{-1/2})^2$, so
$$
 |K_P(\nu)|\le C\sum_p p^{-3/2}
 \min\{1,\nu^2\log^2p\}\le C\min\{1,\nu^2\}.
 \tag{5}
$$
The same Fourier series converges normally on each closed strip $|\Im\nu|\le\eta<1/6$: its slowest prime majorant is $Cp^{-3/2+3\eta}$. Thus $K$ is even and analytic near zero, and $K(0)=0$.

## 2. Exact line-one zeta limit

The only prime distribution input is the unconditional remainder
$$
 \theta(x)=x+O(xe^{-c\sqrt{\log x}}).
 \tag{6}
$$
An explicit primary theorem implying it is [Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689); decrease $c$ to absorb its logarithmic factor. The pole of residue one and the absence of zeros on $\Re z=1$ are recorded in [DLMF 25.2](https://dlmf.nist.gov/25.2) and [DLMF 25.10](https://dlmf.nist.gov/25.10).

Partial summation from (6) proves convergence of $\sum_p p^{-1+2i\nu}$ for every fixed real $\nu\ne0$. Its main tail is $\int_A^\infty e^{2i\nu y}dy/y$; after integration by parts the error is absolutely integrable. Abel convergence and the Euler logarithm in $\Re z>1$ identify its real part:
$$
 \lim_{P\to\infty}S_P(\nu)=\log|\zeta(1-2i\nu)|-R(\nu),\qquad
 R(\nu)=\sum_p\sum_{k\ge2}\frac{\cos(2k\nu\log p)}{kp^k}.
 \tag{7}
$$
Only the real logarithm of the modulus is used. The $R$ series is absolutely convergent on the real line and normally convergent on every closed strip of width less than $1/4$.

Hence, for every $\nu\ne0$,
$$
 \boxed{G_P(\nu)\longrightarrow
 G(\nu)=-2\log|\zeta(1-2i\nu)|+2R(\nu)+K(\nu).}
 \tag{8}
$$
The value assigned at zero is immaterial. The exact limiting heat is
$$
 e^{-sG(\nu)}
 =\exp\!\left(2s\log|\zeta(1-2i\nu)|-s[2R(\nu)+K(\nu)]\right).
 \tag{9}
$$
This is an identity for the complete generator, including its convergent higher-power correction.

Put $R_0=R(0)$. The even function
$$
 Q(z)=4z^2\zeta(1-2iz)\zeta(1+2iz)
$$
extends analytically across zero with $Q(0)=1$, and is nonzero in a neighborhood of zero. Its local analytic logarithm gives
$$
 \boxed{G(\nu)=2\log|\nu|+c_0+h(\nu),\quad
 c_0=2\log2+2R_0,\quad h(0)=0,\quad h(\nu)=O(\nu^2),}
 \tag{10}
$$
where $h=-\log Q+2(R-R_0)+K$ is even and real analytic near zero.

If $B_1$ is the prime Mertens constant, then
$$
 B_1+R_0=\gamma.
 \tag{11}
$$
Here is a normalization check. Write
$$
 \sum_{p\le e^y}p^{-1}=\log y+B_1+r(y).
$$
Equation (6) gives $r(y)=O(e^{-c_1\sqrt y})$ for $y\ge1$; below the first prime, $r(y)=-\log y-B_1$. Thus $r\in L^1(0,\infty)$, and
$$
 \sum_p p^{-1-\epsilon}
 =\epsilon\int_0^\infty e^{-\epsilon y}(\log y+B_1+r(y))dy
 =-\log\epsilon-\gamma+B_1+o(1).
$$
The Euler logarithm and $\zeta(1+\epsilon)\sim1/\epsilon$ prove (11).

## 3. Fixed-observation convergence and complex heat

The actual successor-seed profiles are
$$
 B_p(v)=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}
 1_{v\ge\log p},\qquad B=\sum_pB_p,\qquad B_P=\sum_{p\le P}B_p.
$$
The [exact covariance theorem](fixed-cauchy-prime-covariance-seed.md), including its diagonal, states
$$
 \mathbb E_{\mathsf C}|U_p-1|^2=2/p,\qquad
 \operatorname{Cov}_{\mathsf C}(|U_p-1|^2,|U_q-1|^2)
 =2\int_0^\infty B_pB_q.
 \tag{12}
$$
Its kernel calculation uses
$$
 \int e^{ia\nu}d\mathsf C=e^{-|a|/2},\qquad
 e^{-|a-b|/2}-e^{-(a+b)/2}
 =e^{-(a+b)/2}\int_0^{\min(a,b)}e^v\,dv.
$$
For the full signed positive-displacement coefficients of $|U_p-1|^2$, the weighted tail is $-e^{-v/2}B_p(v)$, and its weighted total mass is zero. This last cancellation uses every geometric depth. In particular $\int B_p^2=p^{-2}$, so $\operatorname{Var}_{\mathsf C}(|U_p-1|^2)=2/p^2$.

Chebyshev's bound gives $B(v)\le C/(1+v)$. Also $B-B_P=0$ below $\log P$. Polarization and completion, then uniqueness of the limit in measure using (8), prove
$$
 \boxed{\|G_P-G\|_{L^2(\mathsf C)}^2
 =2\|B_P-B\|_2^2\le\frac C{1+\log P},\qquad
 \mathbb E_{\mathsf C}G=0.}
 \tag{13}
$$
This does not by itself justify exponentiation.

For that step, [direct partial summation](uniform-partial-prime-cosines.md) gives the estimates uniform in every actual final cutoff $P\ge2$:
$$
 S_P(\nu)=\log\min\{A,|\nu|^{-1}\}+O(1)
 \quad(0<|\nu|\le1/4),
 \tag{14}
$$
$$
 |S_P(\nu)|\le2\log\log(3+2|\nu|)+C
 \quad(|\nu|\ge1/4).
 \tag{15}
$$
For (15), split at $Y=\exp[C_1\log^2(3+2|\nu|)]$. The prefix is bounded by $\sum_{p\le Y}1/p$. With $C_1$ sufficiently large, (6) and an oscillatory integration by parts bound the entire remaining interval $(Y,P]$ by $O(1)$, including any final cutoff prime. For (14), add prime two explicitly, compare the cosine integral to $\log y$ below $y=1/(2|\nu|)$, and integrate by parts above it.

Let $\mathcal K\subset\{\Re s<1/2\}$ be compact, $\sigma_+=\max(0,\sup_{\mathcal K}\Re s)$, and $M=\sup_{\mathcal K}|\Re s|$. Equations (3), (5), (14), and (15) imply
$$
 \sup_{P,s\in\mathcal K}|e^{-sG_P(\nu)}|\le C_{\mathcal K}
 \begin{cases}
 1+|\nu|^{-2\sigma_+},&0<|\nu|\le1/4,\\
 [\log(3+|\nu|)]^{4M},&|\nu|>1/4.
 \end{cases}
 \tag{16}
$$
The envelope is Cauchy-integrable. For negative real parts use the lower bound in (14) and $\min(A,|\nu|^{-1})\ge\log2$. There is no additional singularity from negative heat parameters.

Pointwise convergence is uniform on a compact set of $s$'s. Dominating its supremum therefore proves
$$
 \boxed{\sup_{s\in\mathcal K}
 \|e^{-sG_P}-e^{-sG}\|_{L^1(\mathsf C)}\longrightarrow0,\qquad
 Z_P\longrightarrow Z,\quad Z(s)=\int e^{-sG}d\mathsf C.}
 \tag{17}
$$
The convergence is locally uniform on $\Re s<1/2$. Both the $L^1$-valued map and $Z$ are holomorphic there. A slightly larger compact envelope and Cauchy's formula justify derivatives; alternatively dominate powers of $G$ by neighboring real exponential parameters. The same proof gives $L^r$ convergence whenever $r\max(0,\sup_{\mathcal K}\Re s)<1/2$.

Equation (10) shows that the defining integral for $Z(s)$ is absolutely convergent exactly when $\Re s<1/2$. This is a statement about integration, independent of analytic continuation.

## 4. Actual critical and supercritical cutoff asymptotics

Set
$$
 J(x)=2\int_0^1\frac{1-\cos(2xv)}v\,dv,\qquad
 C_*=\frac2\pi e^{B_1-\gamma}=\frac2\pi e^{-R_0}.
$$
For fixed real $s>1/2$,
$$
 \boxed{Z_P(s)\sim C_s A^{2s-1},\qquad
 C_s=\frac2\pi e^{2sB_1}\int_{\mathbb R}e^{-sJ(x)}dx,}
 \tag{18}
$$
locally uniformly in $s\in(1/2,\infty)$, whereas
$$
 \boxed{Z_P(1/2)=C_*\log A+O(1).}
 \tag{19}
$$

Here is the actual matching argument. With the remainder $r$ from section 2 and
$$
 M_P(\nu)=2\sum_{p\le P}\frac{1-\cos(2\nu\log p)}p,
$$
Stieltjes integration by parts gives
$$
 M_P(\nu)-J(A\nu)
 =2[1-\cos(2\nu A)]r(A)
 -4\nu\int_0^A\sin(2\nu y)r(y)\,dy.
$$
Since $\int_0^\infty y|r(y)|dy<\infty$, equation (5) gives
$$
 L_P(\nu)=J(A\nu)+O(\nu^2+|r(A)|).
 \tag{20}
$$
Every proper-power effect has been controlled before scaling.

For fixed $\delta>0$, (15) and its compact extension away from zero give a uniform integrable envelope for $e^{-sG_P}$ on $|\nu|\ge\delta$, for $s$ in any compact set. Thus the entire remote region contributes $O(1)$ to the centered heat, including all large simultaneous phase alignments.

On $|\nu|\le\delta$, put $x=A\nu$. The cosine-integral identity gives
$$
 J(x)=2\log(2|x|)+2\gamma+O(|x|^{-1}),\qquad |x|\to\infty.
 \tag{21}
$$
For $s>1/2$, equation (20) yields the integrable rescaled majorant $C(1+|x|)^{-2s}$. Dominated convergence and $w(0)=2/\pi$ prove (18).

At $s=1/2$,
$$
 \int_{-D}^D e^{-J(x)/2}dx=e^{-\gamma}\log D+O(1).
$$
The errors in (20) and $w(\nu)-2/\pi=O(\nu^2)$, before centering, are bounded by
$$
 \frac CA\int_{|x|\le\delta A}
 \left(x^2/A^2+|r(A)|\right)e^{-J(x)/2}dx=O(A^{-1}).
$$
Also $r(A)\log A=o(1)$. Multiplying by $e^{H_P}=e^{B_1}A(1+O(r(A)))$ and adding the bounded remote contribution proves (19), including its $O(1)$ remainder.

## 5. Complete negative-port energy

Use the unitary Fourier transform with exponent $-iv\nu$, and put
$$
 a_0(v)=e^{-v/2}1_{v\ge0},\qquad
 |\widehat a_0(\nu)|^2=w(\nu).
$$
For an even Wiener symbol
$$
 F(\nu)=c+\int_{(0,\infty)}(e^{ia\nu}+e^{-ia\nu})\mu(da),
 \qquad |\mu|((0,\infty))<\infty,
$$
let $m_F=\mathbb E_{\mathsf C}F$ and
$$
 b_F(v)=e^{v/2}\int_{[v,\infty)}e^{-a/2}\mu(da),\qquad v>0.
$$
The [covariance isometry](fixed-cauchy-prime-covariance-seed.md#7-the-complete-rational-history-functional-survives-nonlinear-heat-composition), with complex conjugation retained, gives
$$
 \|F-m_F\|_{L^2(\mathsf C)}^2=2\|b_F\|_2^2,\qquad
 [F(D)a_0](-v)=b_F(v)\quad\text{a.e. }v>0.
 \tag{22}
$$
No weighted-mean condition on $\mu$ is required after centering. The atom at displacement zero affects the scalar coordinate only. The map
$$
 F\longmapsto(m_F,\sqrt2b_F)
$$
extends to a unitary map from even $L^2(\mathsf C)$ onto $\mathbb C\oplus L^2(0,\infty)$. Centered cosine symbols yield the weighted interval indicators, whose span is dense; constants supply the scalar coordinate. For general $F\in L^2(\mathsf C)$, $F(D)a_0$ is defined spectrally. No bounded action on arbitrary inputs is asserted.

The actual finite heat $F_{P,s}=e^{-sG_P}$ is an even Wiener symbol for every complex $s$. Its coefficient measure is the full signed convolution exponential, retaining all mixed rational displacements. Writing $\sigma=\Re s$, equation (22) proves
$$
 \boxed{\|F_{P,s}(D)a_0\|_2^2=Z_P(2\sigma),\qquad
 \|1_{v<0}F_{P,s}(D)a_0\|_2^2
 =\frac12[Z_P(2\sigma)-|Z_P(s)|^2].}
 \tag{23}
$$
The square is taken after all signed histories have been aggregated.

For $\sigma<1/4$, (17) in $L^2(\mathsf C)$ gives convergence of the full seed output and its negative port, whose limiting squared norm is
$$
 \frac12[Z(2\sigma)-|Z(s)|^2].
 \tag{24}
$$
At $\sigma=1/4$, the mean stays bounded and (19) gives
$$
 \boxed{\|1_{v<0}F_{P,s}(D)a_0\|_2^2
 =\frac{C_*}2\log A+O_s(1).}
 \tag{25}
$$
For fixed $s$ with $\sigma>1/4$,
$$
 \boxed{\|1_{v<0}F_{P,s}(D)a_0\|_2^2
 \sim\frac{C_{2\sigma}}2 A^{4\sigma-1}.}
 \tag{26}
$$
Indeed $|Z_P(s)|\le Z_P(\sigma)$. Its square is bounded below the scalar threshold, is $O(\log^2 A)$ at $\sigma=1/2$, and is $O(A^{4\sigma-2})$ above it. In all cases it is smaller than $Z_P(2\sigma)$. Exactly half the leading divergent energy lies in the negative port. For purely imaginary $s$, (24) equals $(1-|Z(s)|^2)/2\le1/2$.

These statements concern the actual initial ground seed. They do not place the infinite arithmetic arrival sum in the same heat domain.

## 6. Limiting generator and operator domains

Multiplication by the real measurable $G$, with domain $\{f:Gf\in L^2\}$, is self-adjoint on Fourier-space $L^2$. Its domain is dense because $G$ is finite away from zero. For nonreal $z$, the resolvents of multiplication by $G_P$ converge strongly to the resolvent of $G$: pointwise convergence and the bound $1/|\Im z|$ suffice.

For every $f\in L^2$,
$$
 e^{-itG_P(D)}f\longrightarrow e^{-itG(D)}f
 \quad\text{in }L^2,
 \tag{27}
$$
uniformly for real $t$ in compact intervals. This follows by dominated convergence of the unit-modulus multipliers, including the supremum over a compact time interval. It gives a limiting unitary group on the whole space.

For real $s>0$, $e^{-sG}$ is unbounded near zero. It defines a closed multiplication operator on its dense domain
$$
 \mathcal D_s=\{f:e^{-sG}\widehat f\in L^2\},
 \tag{28}
$$
not a bounded heat semigroup on all $L^2$. At finite cutoff, $L_P\ge0$, continuity, and $L_P(0)=0$ show that the centered heat operator norm is exactly $e^{2sH_P}\asymp A^{2s}$. The seed $a_0$ belongs to $\mathcal D_s$ exactly for $s<1/4$. Full arithmetic-source membership and cutoff convergence require their own estimates.

## 7. Meromorphic continuation and the first residue

Although its observation integral converges only for $\Re s<1/2$, $Z(s)$ has meromorphic continuation to all of $\mathbb C$, with only possible simple poles at
$$
 s=n+\tfrac12,\qquad n=0,1,2,\ldots.
 \tag{29}
$$
Fix a small $\delta>0$. Equations (8) and (15) give
$$
 |G(\nu)|\le C_\delta+4\log\log(3+2|\nu|)
 \quad (|\nu|\ge\delta).
$$
Thus the integral over that region is entire, with a Cauchy-integrable envelope on every compact parameter set.

The local part, by (10), equals
$$
 2e^{-sc_0}\int_0^\delta
 \nu^{-2s}w(\nu)e^{-sh(\nu)}d\nu.
$$
The even analytic factor expands as
$$
 w(\nu)e^{-sh(\nu)}=\sum_{n\ge0}a_n(s)\nu^{2n},
 \qquad a_0(s)=2/\pi,
$$
with coefficients entire in $s$. Subtracting its first $N$ Taylor terms continues the remainder to $\Re s<N+1/2$. The subtracted terms contribute
$$
 2e^{-sc_0}\sum_{n=0}^{N-1}
 \frac{a_n(s)\delta^{2n+1-2s}}{2n+1-2s}.
 \tag{30}
$$
The continuations agree on overlaps, proving (29). Higher residues may vanish. The first residue is explicitly nonzero:
$$
 \boxed{\operatorname*{Res}_{s=1/2}Z(s)
 =-\frac{e^{-R_0}}\pi=-\frac{C_*}2,\qquad
 \lim_{s\uparrow1/2}(1-2s)Z(s)=C_*.}
 \tag{31}
$$
The continuation is not the original observation integral beyond its convergence threshold. This fixed-observation transition, its full-power correction, and its seed-domain consequences leave the RH-relevant arithmetic sign and full-source readout unresolved.

The same local expansion also gives a distributional consequence, independently of analytic continuation:
$$
 \mathsf C\{G<-R\}=C_*e^{-R/2}+O(e^{-3R/2}),
 \qquad R\to\infty.
$$
Indeed $G'(\nu)=2/\nu+O(\nu)>0$ near zero on the positive side, so its local threshold is
$$
 \nu_R=e^{-(R+c_0)/2}(1+O(e^{-R})).
$$
Integration of $w$ over $(-\nu_R,\nu_R)$ gives the stated leading constant and error. Away from a fixed small neighborhood, the log-log bound forces $\{G<-R\}$ into a doubly exponentially distant Cauchy tail, smaller than this error. Enlarging the error constant covers all $R\ge0$. Therefore, for integers $k\ge1$, tail integration proves
$$
 \mathbb E_{\mathsf C}(G_-)^k
 =C_*\,2^k k!+O((2/3)^k k!),
 \qquad G_-=\max\{-G,0\},
$$
with one constant independent of $k$. This corollary identifies the same heat threshold from the actual observation law.

## 8. Critical-window law and actual heated statistics

The resonance matching also yields a uniform complex crossover. Write $\ell=\log A>0$, and define the entire function
$$
 \mathcal F(\lambda)=\int_0^1e^{\lambda t}dt
 =\frac{e^\lambda-1}{\lambda},\qquad \mathcal F(0)=1.
$$
Then, for every compact $\mathcal K\subset\mathbb C$,
$$
 \boxed{Z_P\!\left(\frac12+\frac{\lambda}{2\ell}\right)
 =C_*\ell\,\mathcal F(\lambda)+O_{\mathcal K}(1),
 \qquad \lambda\in\mathcal K.}
 \tag{32}
$$
This is additive at the complex zeros of $\mathcal F$.

To prove it, use (20) over the full matching interval and (21) to obtain
$$
 \int_{-\delta A}^{\delta A}
 e^{-(1/2+\lambda/(2\ell))J(x)}dx
 =e^{-\gamma}\ell\int_0^1e^{-\lambda t}dt+O_{\mathcal K}(1).
$$
The change $x=e^y$ proves uniformity at $\lambda=0$ without dividing by $\lambda$. The cosine-integral error is dominated by $C_{\mathcal K}x^{-2-\Re\lambda/\ell}$. The density and full-power matching errors are $O_{\mathcal K}(A^{-1})$ before centering. The centering factor is $Ae^\lambda e^{B_1}(1+O_{\mathcal K}(\ell^{-1})+O_{\mathcal K}(r(A)))$, and the entire remote region is $O_{\mathcal K}(1)$ after centering. These facts prove (32) with its stated remainder.

Under the actual critical heated probability
$$
 d\rho_P=\frac{e^{-G_P/2}}{Z_P(1/2)}d\mathsf C,
 \qquad T_P=-\frac{G_P}{2\ell},
$$
the exact moment-generating function is
$$
 \mathbb E_{\rho_P}e^{\lambda T_P}
 =\frac{Z_P(1/2+\lambda/(2\ell))}{Z_P(1/2)}.
$$
Equation (32) therefore proves
$$
 \boxed{T_P\ \xrightarrow[\rho_P]{\mathrm{law}}\
 \mathrm{Uniform}[0,1],\qquad
 \mathbb E_{\rho_P}T_P^j\longrightarrow\frac1{j+1}.}
 \tag{33}
$$
Characteristic functions give convergence in law; local holomorphic convergence gives every fixed moment. In particular $\operatorname{Var}_{\rho_P}(L_P)\sim\ell^2/3$. A fixed real $\lambda$ in the critical window produces the limiting density $e^{\lambda t}/\mathcal F(\lambda)$ on $[0,1]$.

For the ground-seed squared norm, the corresponding real heat time is $s=1/4+\lambda/(4\ell)$. Its ratio to $\ell$ converges to $C_*\mathcal F(\lambda)$, and (23) gives half that leading value for the negative port. These are statistics of the complete prime heat under the fixed observation.

## 9. Finite arithmetic sources: cancellation order and both pole moments

The following extension keeps the source cancellation and both pole moments. Let
$$
 a=\sum_{j=1}^J c_jT_{h_j}a_0\ne0,\qquad
 (T_hf)(v)=f(v-h),\qquad
 Q_a(\nu)=\sum_jc_je^{-ih_j\nu}.
$$
Then $|\widehat a|^2d\nu=|Q_a|^2d\mathsf C$. If
$$
 Q_a(\nu)=q_m\nu^m+O(\nu^{m+1}),\quad
 \kappa=|q_m|^2>0,
$$
its exact order is characterized by
$$
 \sum_jc_jh_j^k=0\ (k<m),\qquad
 q_m=\frac{(-i)^m}{m!}\sum_jc_jh_j^m\ne0.
 \tag{34}
$$
For $J$ distinct translations, $m\le J-1$ by the Vandermonde determinant.

The limiting source-weighted integral
$$
 Z_a(s)=\int |Q_a(\nu)|^2e^{-sG(\nu)}d\mathsf C
$$
is absolutely convergent exactly for $\Re s<m+1/2$. Its finite-cutoff counterparts converge locally uniformly there. This follows from (10), the bound $|Q_a(\nu)|\le C|\nu|^m$ near zero, boundedness of $Q_a$ on the real line, and (16).

For fixed real $s>m+1/2$, the actual cutoff asymptotic is
$$
 Z_{P,a}(s)\sim
 \frac{2\kappa}{\pi}e^{2sB_1}A^{2s-2m-1}
 \int_{\mathbb R}|x|^{2m}e^{-sJ(x)}dx.
 \tag{35}
$$
The corresponding rescaled limit holds locally uniformly for complex $\Re s>m+1/2$, without asserting that the complex limit is nonzero. At the real critical value,
$$
 \boxed{Z_{P,a}(m+1/2)=
 \frac{2^{1-2m}\kappa}{\pi}
 e^{(2m+1)(B_1-\gamma)}\log A+O_a(1).}
 \tag{36}
$$
For (35), rescale $\nu=x/A$ and use the integrable majorant $|x|^{2m}(1+|x|)^{-2\Re s}$. For (36), the even part of the source density is $(2\kappa/\pi)\nu^{2m}+O(\nu^{2m+2})$. Equation (21) supplies the $1/|x|$ term; the extra $\nu^2$ factors from both density and full-power correction yield bounded errors after centering. The remote region remains bounded by (15). For a probability observation, divide every constant by
$$
 \|a\|_2^2=\sum_{j,k}c_j\overline{c_k}e^{-|h_j-h_k|/2}.
$$

For actual additive birth profiles
$$
 h_n(x)=x^{-1}1_{x\ge n},\qquad H(x)=\sum_n b_nh_n(x),
$$
the unitary change $a(v)=e^{v/2}H(e^v)$ gives
$$
 a=\sum_n\frac{b_n}{\sqrt n}T_{\log n}a_0,\qquad
 Q_a(\nu)=\sum_n b_n n^{-1/2-i\nu},\qquad
 \|a\|_2^2=\sum_{n,l}\frac{b_n\overline{b_l}}{\max(n,l)}.
 \tag{37}
$$
Thus heat improvement requires the exact weighted logarithmic cancellations
$$
 \sum_n\frac{b_n}{\sqrt n}(\log n)^k=0\quad(k<m).
 \tag{38}
$$

These differ from compactness and the two ordinary pole moments. Compactness and
$$
 \int a(v)e^{v/2}dv=\int a(v)e^{-v/2}dv=0
$$
are equivalent, for these finite births, to
$$
 \sum_n b_n=0,\qquad \sum_n b_n\log n=0,\qquad
 \sum_n b_n/n=0.
 \tag{39}
$$
Indeed the first condition cancels the right tail; direct integration then gives the other two moments. In the Fourier convention above, the numerator $Q_a$ must have a double zero at $i/2$ and a zero at $-i/2$, since one zero at $i/2$ merely cancels the denominator $1/2+i\nu$.

The exact source
$$
 H=-h_1+6h_4-9h_{16}+4h_{64}
 \tag{40}
$$
satisfies all three conditions (39), yet $Q_a(0)=1/4$. Its heat threshold remains $1/2$. Both pole moments therefore do not by themselves force the local source cancellation relevant to this heat domain.

Conversely, every order $m\ge0$ can coexist with both pole moments. Expand
$$
 D_m(z)=(z-1)^2(4z-1)(2z-1)^m=\sum_{k=0}^{m+3}b_kz^k
$$
and choose births $n=4^k$ with coefficients $b_k$. The roots at $1$ and $1/4$ give (39), while
$$
 Q_a(\nu)=D_m(2^{-1}e^{-i(\log4)\nu}),\qquad
 q_m=\frac{(-i\log4)^m}{4}
 \tag{41}
$$
gives exact order $m$. Translation of the entire source leaves its spectral weight and every heat integral unchanged. These finite-source constructions specify the cancellation needed; they do not prove it for the completed arithmetic source.

## 10. The exact successor does not preserve the improved heat domain

The actual causal successor is $S=\Pi J_1\Pi$, with
$$
 J_1a(v)=\sqrt{\frac{e^v}{e^v+1}}a(\log(e^v+1)),\qquad
 \Pi=1_{v\ge0}.
$$
Under $(\mathcal Wa)(x)=x^{-1/2}a(\log x)$, it is exactly
$$
 \mathcal WS\mathcal W^{-1}H(x)=1_{x\ge1}H(x+1).
 \tag{42}
$$
The compression retains the initial interval. The [successor/source compatibility theorem](../successor-and-division/successor-collective-prime-compatibility.md) establishes its exact action and domain. The following calculation keeps that compression.

Take the two actual births $H=h_1-2h_4$. Then
$$
 a=\mathcal W^{-1}H=a_0-T_{\log4}a_0,\qquad
 \widehat a(\nu)=
 \frac{1-e^{-i\nu\log4}}{\sqrt{2\pi}(1/2+i\nu)}.
$$
Its zero at zero is exactly simple. Applying (42) gives
$$
 b(v):=(Sa)(v)=
 \frac{1_{v\ge0}(1-2\,1_{v\ge\log3})}{2\cosh(v/2)}.
 \tag{43}
$$
Direct integration, including the lower endpoint, yields
$$
 \int b(v)dv
 =\int_1^\infty\frac{1-2\,1_{x\ge3}}{\sqrt x(1+x)}dx
 =\frac\pi2-2\frac\pi3=-\frac\pi6.
 \tag{44}
$$
Thus $\widehat b(0)=-\pi/(6\sqrt{2\pi})\ne0$.

Both $a,b$ are causal and decay as $O(e^{-v/2})$, so their Fourier transforms are analytic on $\Im\nu<1/2$. Their distributional variations are finite: $|Da|(\mathbb R)=3$, and $|Db|(\mathbb R)=1+\sqrt3/2$. For $b$, this includes the jump $1/2$ at zero and the jump of magnitude $\sqrt3/2$ at $\log3$. Hence both Fourier transforms are $O(1/|\nu|)$ at infinity. By the log-log bound for $G$, their weighted Fourier tails are integrable for every fixed positive heat time.

At zero, equation (10) makes the squared domain integrands comparable to $|\nu|^{2-4s}$ for $a$ and $|\nu|^{-4s}$ for $Sa$. Therefore
$$
 \boxed{a\in\mathcal D_s\iff 0<s<3/4,\qquad
 Sa\in\mathcal D_s\iff 0<s<1/4.}
 \tag{45}
$$
At either endpoint the divergence is logarithmic. In particular
$$
 S(\mathcal D_s)\not\subseteq\mathcal D_s
 \quad\text{for every }s\in[1/4,3/4).
 \tag{46}
$$
Boundedness of the successor on ordinary $L^2$ does not transport the improved heat cancellation.

For a general finite birth combination, define the effective numerator
$$
 Q_S(\nu)=\sqrt{2\pi}(1/2+i\nu)\widehat{Sa}(\nu).
$$
It need not be an exponential polynomial. Its exact value is
$$
 Q_S(0)=\sum_n b_n
 \arctan\frac1{\sqrt{\max(1,n-1)}}
 =\sum_n b_n\left[\frac\pi2-\arctan\sqrt{n-1}\right]
 -\frac\pi4b_1.
 \tag{47}
$$
The last term is the initial-boundary correction: only the birth at one contributes on the removed negative output interval. In the example, the uncompressed integral is $\pi/3$; compression removes $\pi/2$, producing (44). The effective numerator is $Q_S(0)=-\pi/12$, one half of that integral. These formulas distinguish the original cancellation $\sum b_n/\sqrt n=0$ from the exact arctangent condition after succession. They assert no failure or success for the completed $\psi$ source.

## 11. The actual large-age heat profile

The same estimates determine the complete physical profile. For fixed complex $s$ with $\sigma=\Re s>1/4$, let $a_{P,s}=e^{-sG_P(D)}a_0$. Then
$$
 \boxed{A^{1-2s}a_{P,s}(Ay)\longrightarrow
 b_s(y)=e^{2sB_1}\sqrt{\frac2\pi}\,
 \mathcal F^{-1}[e^{-sJ}](y)
 \quad\text{in }L^2(\mathbb R_y).}
 \tag{48}
$$
The convergence is locally uniform in this half-plane. Complex powers of the positive number $A$ use its real logarithm.

Indeed the exact Fourier transform of the rescaled output is
$$
 A^{-2s}e^{-sG_P(x/A)}\widehat a_0(x/A)
 =e^{2sB_1+2sr(A)}e^{-sL_P(x/A)}\widehat a_0(x/A).
$$
On $|x|\le\delta A$, (20) gives pointwise convergence and the squared majorant $C(1+|x|)^{-4\sigma}$. On the complement its squared norm is
$$
 A^{1-4\sigma}\int_{|\nu|>\delta}
 e^{-2\sigma G_P(\nu)}|\widehat a_0(\nu)|^2d\nu
 =O(A^{1-4\sigma})\longrightarrow0.
$$
The remote estimate comes from the actual uniform cosine bounds. Plancherel proves (48) without requiring an absolutely convergent inverse integral.

For real $s>0$, let $D_s^\pm$ be independent positive Poisson integrals with jump intensity $s\,dv/v$ on $(0,1]$, and put $Z_s=D_s^+-D_s^-$. Construct both integrals on Poisson random measures and first restrict to jump sizes $v>\varepsilon$. The omitted expected positive mass is $s\varepsilon$, so the truncated sums converge in $L^1$ and almost surely as $\varepsilon\downarrow0$. The compound-Poisson characteristic functions therefore give
$$
 e^{-sJ(x)}=\mathbb E e^{ix(2Z_s)}.
$$
For $s>1/4$ this characteristic function is in $L^2$, so its law has an even $L^2$ density $p_{2Z_s}$. One proof mollifies the probability measure by Gaussians and uses Plancherel; testing the $L^2$ density limit against compact smooth functions identifies the original probability measure. Therefore the real profile is
$$
 \boxed{b_s(y)=2e^{2sB_1}p_{2Z_s}(y).}
 \tag{49}
$$
For $1/4<s\le1/2$, the characteristic function is not in $L^1$; (48)--(49) are $L^2$ inversion statements.

The profile is even, also for complex $s$. Strong convergence gives the more informative energy-density convergence
$$
 \frac{A|a_{P,s}(Ay)|^2}{\|a_{P,s}\|_2^2}
 \longrightarrow\frac{|b_s(y)|^2}{\|b_s\|_2^2}
 \quad\text{in }L^1(dy).
 \tag{50}
$$
The limiting norm is nonzero and equals $C_{2\sigma}$. In particular each age half-line receives half the leading energy. This supplies a physical-space derivation independent of the covariance isometry.

More generally, suppose $\widehat a(\nu)=d_m\nu^m+O(\nu^{m+1})$, $d_m\ne0$, and its squared Fourier transform has a Cauchy envelope away from every neighborhood of zero. Then, for $\Re s>m/2+1/4$,
$$
 \boxed{A^{m+1-2s}[e^{-sG_P(D)}a](Ay)
 \longrightarrow e^{2sB_1}d_m
 \mathcal F^{-1}[x^m e^{-sJ(x)}](y)
 \quad\text{in }L^2(dy).}
 \tag{51}
$$
The local squared majorant is $C|x|^{2m}(1+|x|)^{-4\sigma}$; the remote bound is $O(A^{2m+1-4\sigma})$. For finite translated seeds in section 9, $d_m=\sqrt{2/\pi}\,q_m$. The limiting profile has parity $(-1)^m$, so its squared modulus is even and each half-line again receives half the leading energy. This describes the complete finite-prime output at age scale $\log P$. Extending it to the actual infinite successor forcing requires a joint source-completion estimate.


## 12. A separate Euler-logarithm proof of remote control

For positive real heat parameters, an alternative argument controls the distant frequencies by positivity and the Cauchy tail. This proof is useful independently of the two-sided uniform bound (15).

Keep $r(y)=\sum_{p\le e^y}1/p-\log y-B_1$. Stieltjes partial summation gives, for real $w\ne0$, the exact tail

$$
\sum_{p>P}p^{-1+iw}
=\int_A^\infty\frac{e^{iwy}}y\,dy
-e^{iwA}r(A)-iw\int_A^\infty e^{iwy}r(y)\,dy.
\tag{52}
$$

The upper prime cutoff in the complementary prefix is inclusive. The main integral is at most $2/(|w|A)$, and the other terms are bounded by $|r(A)|+|w|\int_A^\infty|r(y)|\,dy$. Choose $c_1>0$ with $r(y)=O(e^{-c_1\sqrt y})$, and put $T_A=e^{c_1\sqrt A/4}$. Equations (7) and (52) give

$$
S_P(\nu)\le\log|\zeta(1-2i\nu)|+C_\delta
\qquad(\delta\le|\nu|\le T_A).
$$

For $s$ in a fixed compact subset of $(0,\infty)$,

$$
e^{-sL_P(\nu)}\le C_{s,\delta}A^{-2s}|\zeta(1-2i\nu)|^{2s}
\qquad(\delta\le|\nu|\le T_A).
\tag{53}
$$

The elementary line bound $|\zeta(1+it)|\le C_\delta\log(2+|t|)$ follows from Euler summation, taking an integer $N$ comparable to $|t|+2$ in

$$
\zeta(z)=\sum_{n\le N}n^{-z}+\frac{N^{1-z}}{z-1}
+O\!\left(N^{-\Re z}+\frac{|z|}{\Re z}N^{-\Re z}\right),
\qquad \Re z>0,\ z\ne1.
$$

Every fixed logarithmic power is integrable against the Cauchy density. Beyond $T_A$, the actual positivity $L_P\ge0$ bounds the uncentered heat by one. Therefore

$$
\int_{|\nu|\ge\delta}e^{-sL_P(\nu)}d\mathsf C
=O_{s,\delta}(A^{-2s})+O(e^{-c_1\sqrt A/4}).
\tag{54}
$$

After multiplication by $e^{2sH_P}$ this is $O_{s,\delta}(1)$. The argument includes all remote phase alignments. Complex parameters with positive real part are handled by taking absolute values and applying the estimate to that real part.

For general finite translates in section 9, the two pole moments have an equivalent explicit form. Write $a=\sum_jc_jT_{h_j}a_0$. Its right tail is $e^{-v/2}\sum_jc_je^{h_j/2}$. After canceling that tail,

$$
\int a(v)e^{v/2}\,dv=-\sum_jc_jh_je^{h_j/2},\qquad
\int a(v)e^{-v/2}\,dv=\sum_jc_je^{-h_j/2}.
\tag{55}
$$

Thus compactness and the two zero pole moments require the three displayed weighted sums to vanish. This retains the arbitrary-translation version of (39). Replacing the seed by one with a regular positive Fourier density at zero leaves the local source-weighted threshold $m+1/2$ unchanged, provided its remote density has the required integrability. A zero in that seed density changes the local order; no claim is made without those source assumptions.

The general analytic ingredients are classical. The PNT input is Trudgian's theorem cited in section 2; Euler summation and the pole normalization are standard zeta-function facts. The cosine-integral identity and its remainder used in (21) are recorded in [DLMF 6.6 and 6.12](https://dlmf.nist.gov/6.12). The positive Poisson integrals in (49) use the classical Lévy–Khintchine construction, described for subordinators in Schilling, Song and Vondraček, [*Bernstein Functions: Theory and Applications*](https://motapa.de/bernstein_functions/index.shtml). The physical profile is specified by its characteristic function and normalization, without requiring a naming convention for generalized Dickman laws.
