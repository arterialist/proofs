# Long-time rank-one approximation of the actual signed source square

This written proof combines the complete [birth Gram](original-l2-evolved-source-gram-work.md), classical Fourier/Plancherel estimates and the actual kernel tail. Its finite curvature signs have a bounded Arb certificate; none of its analytic source expansions is formalized in Lean.

Use the complete prime-only process, with $\Phi(s)=\int_0^\infty(1-e^{-sv})F(v)dv$, $F=B/v$, and probability law $\mu_t$. This note concerns original physical $L^2$, equivalently age $L^2(dv)$, not the weaker mixed energy.

For the literal frozen source put
$$
 a_N(v)=\mathbf1_{v\ge0}e^{-v/2}E_\psi(\min(e^v,N)),\quad
 Q_N(t)=\|T_ta_N\|_2^2,\quad L_N=1+\log N,
$$
$$
 D_N(s)=-1+\sum_{2\le n\le N}\Lambda(n)n^{-s}
                         -\int_1^Nx^{-s}dx,\qquad M_N=D_N(1/2).
\tag{1}
$$
Define the exact scalar return
$$
 k_t=\|T_ta_0\|_2^2,\qquad
 a_0(v)=e^{-v/2}\mathbf1_{v\ge0}.
$$
We prove, with absolute constants for this fixed complete process,
$$
 \boxed{|Q_N(t)-k_tM_N^2|
             \le C\,\frac{L_N^3Q_N(0)}{t^3},
                       \qquad N\ge2,\ t\ge1,}
\tag{2}
$$
$$
 \boxed{k_t=\frac{2}{\pi^2t}
                   +O\!\left(\frac{\log(2+t)}{t^2}\right).}
\tag{3}
$$
All source cross terms remain. No relative approximation is inferred when $M_N$ is small. A further signed correction below identifies the source curvature rather than hiding it in the error.

## 1. Exact source and full-history representations

The complete source innovation is the finite signed measure
$$
 \sigma_N=-\delta_0+
    \sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}\delta_{\log n}
            -e^{v/2}\mathbf1_{(0,\log N)}(v)dv,
 \qquad a_N=a_0*\sigma_N.
\tag{4}
$$
Its mass is $M_N$. The seed at zero, each actual prime power including an arrival at $N$, and the continuous cell density are present. The convolution produces the frozen exponential tail exactly; no terminal atom is added.

If $H_t,H_t'$ are independent complete ages, define
$$
 K_t(r)=\mathbb E\,e^{-|r+H_t-H_t'|/2},\qquad k_t=K_t(0).
$$
The exact square is
$$
 Q_N(t)=\iint K_t(v-w)\,\sigma_N(dv)\sigma_N(dw).
\tag{5}
$$
The measure is real signed. In the complex convention the first measure is conjugated. Absolute Fubini follows from finite total variation and the bound $K_t\le1$; (5) does not impose a sign on the arithmetic cross terms.

With $\widehat a(\xi)=\int e^{-i\xi v}a(v)dv$, the exact Fourier formula is
$$
 Q_N(t)=\frac1{2\pi}\int_{\mathbb R}
 e^{-2t\psi(\xi)}|\widehat a_N(\xi)|^2d\xi,\qquad
 \psi(\xi)=\operatorname{Re}\Phi(i\xi),
$$
$$
 \widehat a_N(\xi)=\frac{D_N(1/2+i\xi)}{1/2+i\xi},\qquad
 k_t=\frac1{2\pi}\int_{\mathbb R}
               \frac{e^{-2t\psi(\xi)}}{1/4+\xi^2}d\xi.
\tag{6}
$$
These are the formulas established with the actual frozen source in [the actual frozen-source correlation theorem](actual-short-time-psi-correlation.md). In particular
$$
 Q_N(0)=\int_1^N\frac{|E_\psi(x)|^2}{x^2}dx
                               +\frac{|E_\psi(N)|^2}{N}.
\tag{7}
$$
The process has finite activity: $\psi(\xi)\to\lambda$ at high frequency. Its no-jump contribution is retained in (5)--(6).

## 2. The needed actual process bounds

The [proved full prime-kernel expansion](collective-successor-seed-long-memory.md) $B(v)=2/v+O(v^{-2})$ gives
$$
 F(v)=2/v^2+O(v^{-3}),\qquad v\to\infty.
$$
It follows directly that
$$
 \boxed{\psi(\xi)=\pi|\xi|
       +O\!\left(\xi^2[1+\log(1/|\xi|)]\right),\quad \xi\to0.}
\tag{8}
$$
Indeed the $2/v^2$ term contributes $\pi|\xi|$, using
$\int_0^\infty(1-\cos u)u^{-2}du=\pi/2$.
Changing that model on a fixed bounded interval costs $O(\xi^2)$.
For its $O(v^{-3})$ remainder, split at $v=|\xi|^{-1}$ and use
$1-\cos(\xi v)\le C\min(\xi^2v^2,1)$. This gives (8) without differentiating the arithmetic remainder.

Choose fixed $\xi_0>0$ small enough that
$$
 \psi(\xi)\ge c|\xi|\quad (|\xi|\le\xi_0).
$$
There is also a fixed $\gamma>0$ such that
$$
 \psi(\xi)\ge\gamma\quad (|\xi|\ge\xi_0).
\tag{9}
$$
For nonzero $\xi$, positivity of the actual density on an interval makes
$\int(1-\cos(\xi v))F(v)dv>0$.
Continuity and the Riemann--Lebesgue limit $\psi(\xi)\to\lambda>0$ then prove the uniform gap away from zero.

On the small band, (8)--(9) imply
$$
 |e^{-2t\psi(\xi)}-e^{-2\pi t|\xi|}|
 \le Ct\xi^2[1+\log(1/|\xi|)]e^{-ct|\xi|}.
\tag{10}
$$
In (6), replace $(1/4+\xi^2)^{-1}$ by four on this band. Its error integrates to $O(t^{-3})$; (10) costs $O(\log(2+t)/t^2)$. On the complement use (9) and the integrability of $(1/4+\xi^2)^{-1}$. Since
$(4/2\pi)\int_{\mathbb R}e^{-2\pi t|\xi|}d\xi=2/(\pi^2t)$,
this proves (3).

## 3. Source moments bounded by the actual original square

Let
$$
 A_j=\int_0^\infty v^j a_N(v)dv,\qquad
 B_j=\int_0^\infty v^j|a_N(v)|dv.
$$
For each fixed integer $j\ge0$,
$$
 \boxed{B_j\le C_jL_N^{j+1/2}\sqrt{Q_N(0)}.}
\tag{11}
$$
On $0\le v\le\log N$, this is Cauchy using
$\int_0^{\log N}v^{2j}dv$.
On the frozen tail,
$$
 \int_{\log N}^\infty v^j|a_N(v)|dv
   =|E_\psi(N)|\int_{\log N}^\infty v^je^{-v/2}dv
   \le C_jL_N^j\,|E_\psi(N)|/\sqrt N.
$$
The last factor is bounded by $\sqrt{Q_N(0)}$ through the terminal term in (7). Thus the tail is part of (11), not a discarded endpoint error.

In particular $A_0=2M_N$ and $M_N^2\le C L_NQ_N(0)$. These estimates use the absolute moments of the complete signed source function $a_N$. They do not replace it by separate prime-density total variations.

Because $a_N$ is real, its Fourier modulus square has the exact cosine representation
$$
 |\widehat a_N(\xi)|^2
       =\iint a_N(v)a_N(w)\cos(\xi(v-w))dv\,dw.
$$
The linear term cancels. Consequently
$$
 \big||\widehat a_N(\xi)|^2-A_0^2\big|
       \le \tfrac12\xi^2
                 \iint |a_N(v)a_N(w)|(v-w)^2dv\,dw
       \le C\xi^2B_0B_2.
\tag{12}
$$
Combining (11)--(12) with
$(1/4+\xi^2)^{-1}=4+O(\xi^2)$ proves, on the fixed small band,
$$
 \left||\widehat a_N(\xi)|^2
                -\frac{M_N^2}{1/4+\xi^2}\right|
       \le C L_N^3Q_N(0)\xi^2.
\tag{13}
$$
The source cross term is included in this real-symmetry estimate; a bound on the Fourier difference alone would give a weaker linear-frequency error.

## 4. The absolute rank-one error and its range

Insert (13) in (6) only on $|\xi|\le\xi_0$. Equations (9) give the bound $C L_N^3Q_N(0)t^{-3}$. On the complement, use Plancherel directly:
$$
 \frac1{2\pi}\int_{|\xi|>\xi_0} e^{-2t\psi(\xi)}
 \left(|\widehat a_N(\xi)|^2+
                    \frac{M_N^2}{1/4+\xi^2}\right)d\xi
       \le C L_NQ_N(0)e^{-2\gamma t}.
\tag{14}
$$
This is bounded by the right side of (2) for $t\ge1$.
The polynomial bound (13) is not integrated over all frequencies. Such an integral would diverge for a finite-activity process, whose multiplier approaches a nonzero constant at high frequency. Estimate (14) retains that contribution in its proper original-$L^2$ domain.

Combining (2)--(3) yields the explicit absolute approximation
$$
 \boxed{
 Q_N(t)=\frac{2M_N^2}{\pi^2t}
 +O\!\left(\frac{M_N^2\log(2+t)}{t^2}
                +\frac{L_N^3Q_N(0)}{t^3}\right).}
\tag{15}
$$
For fixed $N$, the nonvanishing of $M_N$ proved below makes this a relative equivalent as $t\to\infty$. For growing cutoffs, $t/\log N\to\infty$ by itself does not imply a relative equivalent: the mass can be small compared with the original source square. A sufficient explicit condition is
$$
 \frac{L_N^3Q_N(0)}{t^2M_N^2}\longrightarrow0.
$$
No such arithmetic lower bound or cancellation comparison is assumed.

### Nonvanishing of the actual finite mass

For $N\ge2$, collect every proper power to obtain

$$
\sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}
=\sum_{p\le N}\left(\sum_{p^j\le N}p^{-j/2}\right)\log p.
$$

This is a strictly positive linear form in real logarithms of algebraic numbers with algebraic coefficients. Baker's [*Linear forms in the logarithms of algebraic numbers (III)*, opening statement on p.220](https://doi.org/10.1112/S0025579300003843), proves that such a nonzero form is transcendental. Subtracting the algebraic number $2\sqrt N-1$ shows that $M_N$ is transcendental and therefore nonzero. Also $M_1=-1$. This classical application gives no uniform lower bound as $N$ grows and assigns no sign to $M_N$.

## 5. The retained signed source curvature

One may identify the first source-dependent correction rather than only bound it. Define the actual finite arithmetic scalar
$$
 \mathcal C_N=D_N'(1/2)^2-M_ND_N''(1/2).
\tag{16}
$$
It retains the full signed source moments:
$$
 D_N'(1/2)=-\sum_{n\le N}\frac{\Lambda(n)\log n}{\sqrt n}
                  +\int_1^N\frac{\log x}{\sqrt x}dx,
$$
$$
 D_N''(1/2)=\sum_{n\le N}\frac{\Lambda(n)(\log n)^2}{\sqrt n}
                  -\int_1^N\frac{(\log x)^2}{\sqrt x}dx.
$$
The constant seed remains in $M_N$. No sign is assigned to (16).

Taylor expansion of the real cosine representation with its fourth-moment bound gives
$$
 |\widehat a_N(\xi)|^2
       =A_0^2+(A_1^2-A_0A_2)\xi^2
                       +O(L_N^5Q_N(0)\xi^4).
$$
Differentiating the exact finite Mellin identity $D_N(s)/s$ gives
$$
 A_1=-2D_N'(1/2)+4M_N,\quad
 A_2=2D_N''(1/2)-8D_N'(1/2)+16M_N.
$$
Therefore, with the seed denominator still present,
$$
 |\widehat a_N(\xi)|^2-\frac{M_N^2}{1/4+\xi^2}
       =4\mathcal C_N\xi^2+O(L_N^5Q_N(0)\xi^4),
 \qquad |\mathcal C_N|\le C L_N^3Q_N(0).
\tag{17}
$$
This exhibits the signed cross-moment cancellation exactly.

On the same fixed small band, (10) gives
$$
 \frac1{2\pi}\int_{|\xi|\le\xi_0}
             \xi^2e^{-2t\psi(\xi)}d\xi
       =\frac1{4\pi^4t^3}
                      +O(\log(2+t)/t^4).
$$
The fourth-power remainder costs $O(t^{-5})$, and (14) handles the complement. Thus a refined absolute identity is
$$
 \boxed{Q_N(t)-k_tM_N^2
 =\frac{\mathcal C_N}{\pi^4t^3}
 +O\!\left[
 Q_N(0)\left\{
 \frac{L_N^3\log(2+t)}{t^4}
 +\frac{L_N^5}{t^5}
 +L_Ne^{-2\gamma t}
 \right\}\right].}
\tag{18}
$$
This is a source-moment expansion within the established original norm, not a new derivative-sign assumption.

The long-time rank-one term is governed by the actual signed mass $M_N=D_N(1/2)$; its first shape correction is the equally actual scalar (16). Their relation to $Q_N(0)$ remains arithmetic information, rather than a consequence of the positive process. In particular (15) or (18) cannot be substituted for the unresolved logarithmic-time source target at small masses or at times where their displayed errors are not controlled.

## 6. Absorption using the uncentered moment bound

The [cutoff-centered prefix estimate](weighted-prefix-centered-source-gram.md) sharpens this method and removes its logarithmic restriction for every diverging subpolynomial schedule. This section retains the different uncentered-moment proof and its precise cost.

The absolute error in (2), divided by the original square, is at most $C(L_N/t)^3$. Thus at $t=A L_N$ it is as small as desired if the fixed constant $A$ is large enough. This observation alone is not an absorption argument for $Q_N(0)$: that quantity does not appear on the left of (2), and no reverse contraction estimate has been proved.

For the relevant source reconstruction, (3), positivity, and continuity give $k_t\ge c/t$ for all $t\ge1$. Equation (2) consequently implies
$$
 M_N^2\le C tQ_N(t)+C\frac{L_N^3}{t^2}Q_N(0).
\tag{19}
$$
The extra factor of $t$ must be retained. At $t=A L_N$, the coefficient of the original square in (19) is $CL_N/A^2$, which does not tend to zero. At $t/L_N^{3/2}\to\infty$, it does.

Here is a precise way to consume the latter small coefficient without assuming a pointwise relation between the mass and the square. Fix $b>0$ and a finite integer cutoff $R$, and set
$$
 \mathcal A_b(R)=\sup_{2\le n\le R}\frac{Q_n(0)}{n^{2b}},\qquad
 \mathcal B_b(R)=\sup_{2\le n\le R}\frac{|M_n|^2}{n^{2b}}.
$$
Both suprema are finite. On each real cell $[n,n+1)$,
$M_x-M_n=-\int_n^x y^{-1/2}dy$; the initial interval is bounded separately. The exact signed Abel identity
$$
 E_\psi(x)=\sqrt{x}M_x-\frac12\int_1^x y^{-1/2}M_y\,dy
$$
therefore bounds $|E_\psi(x)|$ by
$C_b(1+\sqrt{\mathcal B_b(R)})x^{b+1/2}$ for $1\le x\le R$. Substitution into the exact original norm, including its terminal term, yields
$$
 \mathcal A_b(R)\le C_b[1+\mathcal B_b(R)].
\tag{20}
$$

Suppose a subpolynomial schedule satisfies $t_N/L_N^{3/2}\to\infty$, and suppose its actual squares obey the still-unproved target $Q_N(t_N)=O_\epsilon(N^\epsilon)$ for every $\epsilon>0$. Then for every fixed $b>0$,
$\sup_N t_NQ_N(t_N)/N^{2b}<\infty$. For any chosen $\eta>0$, equation (19), with a sufficiently large initial interval retained in its constant, gives
$$
 \mathcal B_b(R)\le K_{b,\eta}+\eta\mathcal A_b(R).
$$
Choose $\eta<1/(2C_b)$ and use (20). This proves a uniform bound for $\mathcal A_b(R)$, hence $Q_N(0)=O_b(N^{2b})$. Since $b>0$ was arbitrary, the original source has subpower growth. Contraction proves the converse. This establishes a direct use of the full signed Gram estimate for this range of subpolynomial schedules. The variable-Laplace theorem in [the variable-time exponent theorem](variable-time-source-exponent.md) gives the stronger equivalence for every subpolynomial schedule; the argument here identifies the precise absorption cost of the rank-one expansion itself.

The necessary new arithmetic input remains a bound for the complete evolved square or for its signed mass and moments. Neither (19) nor (20) proves that input. In particular, a small absolute error relative to $Q_N(0)$ is not a relative equivalent to $k_tM_N^2$ at cutoffs with small $M_N$.

## 7. Both correction signs occur for actual cutoffs

The first signed correction in (18) cannot be given a universal sign even on this actual source family. The bounded Arb calculation in [the actual curvature certificate](certificates/source_curvature_signs.py), using python-flint 0.9.0 and 192-bit Arb interval arithmetic, proves
$$
 \frac{12}{100}<\mathcal C_2<\frac{13}{100},\qquad
 -\frac{39}{100}<\mathcal C_6<-\frac{38}{100}.
\tag{21}
$$
Only finite exact formulas enter these enclosures. Put
$S_j(N)=\sum_{n\le N}\Lambda(n)(\log n)^j/\sqrt n$, $r=\sqrt N$, and $h=\log N$. The script evaluates
$$
 M_N=-1+S_0(N)-2(r-1),
$$
$$
 D_N'(1/2)=-S_1(N)+2rh-4r+4,
$$
$$
 D_N''(1/2)=S_2(N)-2rh^2+8rh-16r+16.
$$
At cutoff six the admitted nonzero arrivals are exactly $2,3,4,5$, with $\Lambda(4)=\log2$. The seed and continuous moments in these formulas are retained. There is no prime or frequency truncation in (21).

For either fixed cutoff, the remainder in (18) is $o(t^{-3})$. Thus (21) proves that $Q_2(t)-k_tM_2^2>0$ for all sufficiently large $t$, whereas $Q_6(t)-k_tM_6^2<0$ for all sufficiently large $t$. This is an actual two-cutoff signed comparison. It rules out using the leading charge square as a universal upper bound or a universal lower bound for the evolved source square. It makes no claim about the sign of the full quadratic $W$ readout.
