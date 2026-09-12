# Sharp centered-prime cutoff law for a fixed finite source

This written proof refines the [centered birth-kernel theorem](centered-infinite-prime-birth-kernel.md) by a common-tail approximation and Bochner integration against any fixed finite complex measure. It gives different exact constants for original $L^2$ norm and the [mixed additive energy](actual-source-mixed-dirichlet-completion.md), including the polarized cross terms. The measure remains fixed in the limit. These statements are not formalized in Lean.

Let $A_P=\mathcal C_Ph_1$ and $A=\mathcal C_\infty h_1$ be the actual centered birth kernels from [centered infinite prime birth kernel](centered-infinite-prime-birth-kernel.md). Use the unitary logarithmic identification
$$
 (Uf)(v)=e^{v/2}f(e^v),\qquad
 k_P=UA_P,\qquad k=UA,
 \qquad d_P=k-k_P.
\tag{1}
$$
If $\mu$ is any finite complex Borel measure on $\mathbb R$, then
$$
 \boxed{\lim_{P\to\infty}(\log P)
          \|(k-k_P)*\mu\|_2^2=4|\mu(\mathbb R)|^2.}
\tag{2}
$$
In particular, when its mass is nonzero the squared norm is equivalent to $4|\mu(\mathbb R)|^2/\log P$. When the mass is zero it is $o(1/\log P)$. The measure may have signed atoms and a complex density; neither positivity nor separation of these parts is used.

For the original additive-coordinate mixed energy, the corresponding constant is eight:
$$
 \lim_{P\to\infty}(\log P)
       \mathcal E\!\left(U^{-1}[(k-k_P)*\mu]\right)
                               =8|\mu(\mathbb R)|^2.
\tag{2a}
$$
Section 5 proves this with the energy applied after the inverse logarithmic identification. Sections 1--5 first treat compactly supported measures; section 6 removes that restriction without imposing a support or moment condition.

## 1. A common explicit tail profile

Put $L=\log P$. The proved kernel equivalents at the two physical endpoints give
$$
 k(v)\sim-\frac2{|v|}\qquad(v\to+\infty\text{ or }v\to-\infty).
\tag{3}
$$
The cutoff estimates in sections 4 and 5 of the birth-kernel theorem also give
$$
 d_P(v)=0\quad(|v|<L)\quad\text{almost everywhere},
$$
$$
 \int_{L\le|v|\le2L}|d_P(v)|^2dv=O(L^{-2}),
 \qquad
 \int_{|v|\ge2L}|k_P(v)|^2dv=O(L^{-2}).
\tag{4}
$$
The positive transition estimate there is even smaller. Unitarity of $U$ transfers those physical-coordinate estimates directly to (4), with no density factor omitted.

Define the two-ended tail
$$
 q_L(v)=-\frac2{|v|}\mathbf1_{|v|\ge2L}.
\tag{5}
$$
Its exact norm is
$$
 \|q_L\|_2^2=2\int_{2L}^\infty\frac4{v^2}dv=\frac4L.
\tag{6}
$$
The relative error in (3) tends uniformly to zero over $|v|\ge2L$. Therefore
$$
 \int_{|v|\ge2L}|k(v)-q_L(v)|^2dv=o(L^{-1}).
$$
Inside this range $d_P-q_L=(k-q_L)-k_P$. In the transition region use (4), and inside $(-L,L)$ both functions vanish. We obtain the stronger form of the cutoff asymptotic
$$
 \boxed{\|d_P-q_L\|_2=o(L^{-1/2}).}
\tag{7}
$$
Thus both actual endpoint tails have the same signed model. This conclusion is more than the scalar norm equivalent $\|d_P\|_2^2\sim4/L$.

## 2. Fixed translations agree at the leading scale

Write $(T_af)(v)=f(v-a)$, consistently with convolution against a measure. For any fixed $M>0$ and $L>M+1$,
$$
 \sup_{|a|\le M}\|T_aq_L-q_L\|_2^2
                   \le C\left(\frac M{L^2}+\frac{M^2}{L^3}\right).
\tag{8}
$$
To prove this, separate the neighborhoods of the two moving cutoffs $\pm2L$. Their total length is $O(M)$, and the squared amplitude there is $O(L^{-2})$. Where both translated arguments belong to the tail, the derivative of $-2/|v|$ has magnitude $2/|v|^2$. The mean-value bound and integration of $|v|^{-4}$ give the second term of (8). These two estimates also apply uniformly to every smaller shift in the displayed range.

Translations are unitary on $L^2$. Applying (7) to their difference and using (8) shows
$$
 \boxed{\sup_{|a|\le M}\|T_ad_P-d_P\|_2=o(L^{-1/2}).}
\tag{9}
$$
This is a fixed-translation result. The allowed support interval is held fixed as $P\to\infty$; no growing-shift estimate is implicit.

## 3. Integration against the full complex measure

Let $m_\mu=\mu(\mathbb R)$, let $|\mu|$ be its total-variation measure, and enclose its support in $[-M,M]$. The convolution exists as an $L^2$ Bochner integral. Since every translate has the same $L^2$ norm, its norm is at most $|\mu|(\mathbb R)\|d_P\|_2$.

Keep the complex signs in the integral. Equation (9) gives
$$
 \begin{aligned}
 \|d_P*\mu-m_\mu d_P\|_2
 &=\left\|\int(T_ad_P-d_P)\,d\mu(a)\right\|_2\\
 &\le |\mu|(\mathbb R)
                   \sup_{|a|\le M}\|T_ad_P-d_P\|_2
   =o(L^{-1/2}).
 \end{aligned}
\tag{10}
$$
Equivalently, by (7),
$$
 \boxed{d_P*\mu=m_\mu q_L+o_{L^2}(L^{-1/2}).}
\tag{11}
$$
Squaring the norm is justified because $\|q_L\|_2=2/\sqrt L$. The cross term with the remainder in (11) is $o(L^{-1})$, as is its squared norm. Equation (6) now proves (2), including the zero-mass case. The coefficient is the squared modulus of the total complex mass, not the square of its total variation.

## 4. The actual finite-source innovation and its seed

Fix a real cutoff $N\ge1$. The actual innovation in logarithmic coordinates is
$$
 \boxed{\mu_N=-\delta_0
       +\sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}\delta_{\log n}
       -e^{v/2}\mathbf1_{(0,\log N)}(v)\,dv.}
\tag{12}
$$
It is a finite signed measure with compact support. Its initial atom, all prime powers in $\Lambda(n)$, and the complete continuous density are retained. The exact mass is
$$
 \boxed{M_N:=\mu_N(\mathbb R)
       =\sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}
                         -2\sqrt N+1.}
\tag{13}
$$
In particular the seed changes the constant in (13); it cannot be omitted. The upper arithmetic endpoint is included. The choice of open endpoints for the continuous density does not change its integral.

There is an exact discrepancy form of the same mass. Put $E_\psi(x)=\psi(x)-x$. Partial summation, with $\psi(1)=0$, gives
$$
 \sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}
     =\frac{\psi(N)}{\sqrt N}
                       +\frac12\int_1^N\frac{\psi(x)}{x^{3/2}}dx,
$$
and hence
$$
 \boxed{M_N=\frac{E_\psi(N)}{\sqrt N}
                   +\frac12\int_1^N\frac{E_\psi(x)}{x^{3/2}}dx.}
\tag{14}
$$
No sign, nonvanishing, or asymptotic cancellation of this finite mass is presumed.

To identify the actual finite source acted on by the centered operators, define
$$
 g_N=-h_1+\sum_{n\le N}\Lambda(n)h_n-\int_1^N h_tdt.
\tag{15}
$$
This has the exact physical form
$$
 g_N(x)=\begin{cases}
 0,&x<1,\\
 \psi(x)/x-1,&1\le x<N,\\
 [\psi(N)-N]/x,&x\ge N.
 \end{cases}
\tag{16}
$$
Thus the cutoff retains the natural source up to $N$ and its frozen endpoint tail afterward. It is an $L^2$ finite combination and integral of birth profiles.

The birth scaling is
$$
 U(\mathcal C_Ph_t)(v)
                   =t^{-1/2}k_P(v-\log t),
 \qquad
 U(\mathcal C_\infty h_t)(v)
                   =t^{-1/2}k(v-\log t).
\tag{17}
$$
For the integral in (15), the substitution $t=e^a$ makes
$t^{-1/2}dt=e^{a/2}da$, which is exactly the density in (12). Therefore, with no missing scale factor,
$$
 U[(\mathcal C_\infty-\mathcal C_P)g_N]
                                      =(k-k_P)*\mu_N.
\tag{18}
$$
Unitarity of $U$ and (2) prove the sharp fixed-source law
$$
 \boxed{\lim_{P\to\infty}(\log P)
       \|(\mathcal C_\infty-\mathcal C_P)g_N\|_2^2
          =4\left|\sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}
                                      -2\sqrt N+1\right|^2.}
\tag{19}
$$
For nonzero $M_N$ this is the claimed equivalent; for zero $M_N$ the squared error is $o(1/\log P)$. The same reasoning applies to any fixed finite complex combination of these innovations.

The source cutoff $N$ is fixed in (19). The total variation and support size of $\mu_N$ enter (10), so this proof does not pass to $N\to\infty$, couple $N$ with $P$, or establish a centered infinite-prime operator on the full natural source. It gives the exact leading cutoff error for each finite actual source while preserving its seed and signed arithmetic density.

## 5. The sharp constant in the original mixed energy

We now use exactly the additive-coordinate energy from the source construction:
$$
 \mathcal E(f)=\int_0^1\|\tau_hf-f\|_2^2dh
             +\int_1^\infty\|\tau_hf-f\|_2^2\frac{dh}{h^2}.
$$
Its kernel representation, valid for complex $L^2$ functions, is
$$
 \mathcal E(f)=4\|f\|_2^2-\langle f,\mathsf K*f\rangle,
 \qquad
 \mathsf K(r)=\min(1,|r|^{-2}),
 \qquad \mathcal E(f)\le8\|f\|_2^2.
\tag{20}
$$
The inner product is real in (20), since the kernel is real and even. Its Hermitian polarization is denoted by $\mathcal B$. The coefficient four follows from $\int_{\mathbb R}\mathsf K=4$, consistently with the original translation normalization.

Put $R=e^{2L}=P^2$. The inverse logarithmic image of (5) splits exactly as
$$
 U^{-1}q_L=f_{-,R}+f_{+,R},
$$
$$
 f_{-,R}(x)=-\frac2{\sqrt x\log(1/x)}
                          \mathbf1_{0<x\le R^{-1}},
 \qquad
 f_{+,R}(x)=-\frac2{\sqrt x\log x}\mathbf1_{x\ge R}.
\tag{21}
$$
Each function has squared $L^2$ norm exactly $4/\log R$. Both are zero on the negative axis.

The first function is supported in an interval of length at most one. The short-support identity follows directly from (20), since $\mathsf K(y-x)=1$ on a support interval of length at most one. It applies here even though the function is unbounded near zero: it is in both $L^1$ and $L^2$, so the kernel integral is absolute. It gives
$$
 \mathcal E(f_{-,R})
       =\frac{16}{\log R}
                     -\left|\int_0^{1/R}f_{-,R}(x)dx\right|^2.
$$
Moreover
$$
 \left|\int_0^{1/R}f_{-,R}(x)dx\right|
       \le\frac2{\log R}\int_0^{1/R}x^{-1/2}dx
       =\frac4{\sqrt R\log R}.
$$
Therefore
$$
 \boxed{\mathcal E(f_{-,R})
             =\frac{16}{\log R}
                        +O\!\left(\frac1{R\log^2R}\right).}
\tag{22}
$$
This is the endpoint that supplies the leading energy.

For the high-coordinate piece, take $R\ge e$ and write
$g(x)=2x^{-1/2}/\log x$ for $x\ge R$. It is decreasing, and
$$
 |g'(x)|=x^{-3/2}\left(\frac1{\log x}
                                    +\frac2{\log^2x}\right),
 \qquad
 \int_R^\infty|g'(x)|^2dx
                         \ll\frac1{R^2\log^2R}.
$$
For $0<h\le R$, separate the translated threshold interval from the smooth tail. Its squared increment satisfies
$$
 \begin{aligned}
 \|\tau_h f_{+,R}-f_{+,R}\|_2^2
 &\le h g(R)^2+h^2\int_R^\infty|g'(x)|^2dx\\
 &\ll\frac h{R\log^2R}.
 \end{aligned}
\tag{23}
$$
The first term retains the jump at $R$. For the second use Cauchy--Schwarz on each smooth segment and then Fubini. For $h>R$, use
$\|\tau_h f_{+,R}-f_{+,R}\|_2^2\le4\|f_{+,R}\|_2^2=16/\log R$.
Splitting the energy integral at $1$ and $R$ now gives
$$
 \boxed{\mathcal E(f_{+,R})
                        =O\!\left(\frac1{R\log R}\right).}
\tag{24}
$$
Thus its half of the leading $L^2$ error contributes only a lower-order amount to this energy.

The two pieces in (21) have disjoint supports. Their cross term is not omitted. Formula (20) gives
$$
 \mathcal B(f_{-,R},f_{+,R})
    =-\int_0^{1/R}\int_R^\infty
       \mathsf K(y-x)f_{-,R}(x)f_{+,R}(y)\,dy\,dx.
$$
It is nonpositive. For $R\ge2$, $\mathsf K(y-x)\le C/y^2$ on this rectangle. The preceding low-coordinate $L^1$ bound and
$$
 \int_R^\infty\frac{|f_{+,R}(y)|}{y^2}dy
                           \ll\frac1{R^{3/2}\log R}
$$
show
$$
 |\mathcal B(f_{-,R},f_{+,R})|
                          \ll\frac1{R^2\log^2R}.
\tag{25}
$$
Combining (22), (24), and twice the cross term proves the explicit model-energy estimate
$$
 \boxed{\mathcal E(U^{-1}q_L)
     =\frac{16}{\log R}
                     +O\!\left(\frac1{R\log R}\right)
     =\frac8L+O\!\left(\frac1{P^2L}\right).}
\tag{26}
$$

It remains to transfer this model to the actual cutoff error. For the same fixed complex measure as in sections 1--3, (11) says
$$
 U^{-1}[d_P*\mu]
            =m_\mu U^{-1}q_L+r_P,
 \qquad \|r_P\|_2=o(L^{-1/2}),
\tag{27}
$$
using unitarity of $U$. By (20), $\mathcal E(r_P)=o(L^{-1})$. The energy Cauchy--Schwarz inequality and (26) bound the cross term in (27) by $o(L^{-1})$. Therefore
$$
 \boxed{\mathcal E\!\left(U^{-1}[(k-k_P)*\mu]\right)
       =\frac{8|\mu(\mathbb R)|^2}{\log P}
                                      +o(1/\log P).}
\tag{28}
$$
This also covers a zero complex mass. The transfer uses the energy bound in the original additive coordinate after applying $U^{-1}$; it does not treat that energy as translation invariant in the logarithmic coordinate.

For the exact innovation (12), equation (18) consequently gives
$$
 \boxed{\lim_{P\to\infty}(\log P)
       \mathcal E\bigl((\mathcal C_\infty-\mathcal C_P)g_N\bigr)
       =8\left|\sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}
                                      -2\sqrt N+1\right|^2.}
\tag{29}
$$
Here $N$ is still fixed. The seed, the signed atomic contributions, and the continuous density enter through their exact combined mass. No interchange with an infinite natural-source limit is made.

## 6. Every finite complex innovation measure

The support restriction can be removed completely. Let $\mu$ be a complex Borel measure on $\mathbb R$ with finite total variation $|\mu|(\mathbb R)<\infty$. No moment, exponential decay, or one-sided support hypothesis is required.

For every $f\in L^2(\mathbb R)$, the map $a\mapsto T_af$ is strongly continuous and has constant norm. Hence
$$
 f*\mu=\int_{\mathbb R}T_af\,d\mu(a)
$$
exists as an $L^2$ Bochner integral, with
$\|f*\mu\|_2\le|\mu|(\mathbb R)\|f\|_2$. For a complex measure one may express $d\mu=\vartheta\,d|\mu|$, with $|\vartheta|=1$ almost everywhere, and use the strongly measurable integrand $\vartheta(a)T_af$. This gives the same integral and retains its complex signs.

For each fixed real $a$, equation (9) gives
$$
 \sqrt L\,\|T_ad_P-d_P\|_2\longrightarrow0.
$$
There is also a bound uniform in every $a\in\mathbb R$:
$$
 \boxed{\sqrt L\,\|T_ad_P-d_P\|_2
           \le2\sqrt L\,\|d_P\|_2\le C}
\tag{30}
$$
for all sufficiently large $P$, by (6)--(7). Dominated convergence against the finite positive measure $|\mu|$ therefore proves
$$
 \begin{aligned}
 \sqrt L\,\|d_P*\mu-m_\mu d_P\|_2
 &\le\int_{\mathbb R}\sqrt L\,
                      \|T_ad_P-d_P\|_2\,d|\mu|(a)\\
 &\longrightarrow0.
 \end{aligned}
\tag{31}
$$
In particular the same common-tail statement holds:
$$
 \boxed{d_P*\mu=m_\mu q_L+o_{L^2}(L^{-1/2})
            \quad\text{for every finite complex }\mu.}
\tag{32}
$$
Equations (6) and (26), followed by the same norm and energy remainder estimates, give
$$
 \boxed{\begin{aligned}
 (\log P)\|(k-k_P)*\mu\|_2^2
                   &\longrightarrow4|m_\mu|^2,\\
 (\log P)\mathcal E\!\left(U^{-1}[(k-k_P)*\mu]\right)
                   &\longrightarrow8|m_\mu|^2.
 \end{aligned}}
\tag{33}
$$
The little-oh terms can depend on the full fixed measure. No rate uniform over a family of measures, or simultaneous change of that measure with $P$, is asserted.

There is an explicit source domain for this extension. Let
$$
 g_0(v)=Uh_1(v)=e^{-v/2}\mathbf1_{v\ge0},
 \qquad f_\mu=U^{-1}(g_0*\mu).
\tag{34}
$$
Since $g_0\in L^2$ and $\mu$ is finite, this is an original-coordinate $L^2$ function. For each finite prime cutoff, the logarithmic form of $\mathcal C_P$ is a bounded sum of translations. The full power series for each admitted prime converges in $L^2$ operator norm. It therefore commutes with the Bochner integral in (34), giving
$$
 U\mathcal C_P f_\mu=k_P*\mu.
$$
The birth-kernel convergence and the convolution bound give the actual limit
$$
 \boxed{\mathcal C_\infty f_\mu=U^{-1}(k*\mu),}
\tag{35}
$$
both in $L^2$ and in the original mixed energy. Formula (33) is consequently a sharp cutoff law on this concrete domain, not just a formal convolution identity. If two representations produce the same $f_\mu$, their finite operator images agree and hence so do the limits; the construction is unambiguous.

For completeness, the corresponding cutoff cross terms also depend only on the masses. Let $\mu,\nu$ be two fixed finite complex measures. Polarizing (32), and its inverse-logarithmic energy version, yields
$$
 \begin{aligned}
 (\log P)\langle d_P*\mu,d_P*\nu\rangle
                  &\longrightarrow4m_\mu\overline{m_\nu},\\
 (\log P)\mathcal B\!\left(U^{-1}(d_P*\mu),
                                U^{-1}(d_P*\nu)\right)
                  &\longrightarrow8m_\mu\overline{m_\nu},
 \end{aligned}
\tag{36}
$$
where the Hermitian forms in (36) are taken linear in the first argument. Thus adding an innovation of mass $\delta$ changes the leading original-energy coefficient by
$$
 8\left(2\operatorname{Re}(m_\mu\overline\delta)+|\delta|^2\right).
\tag{37}
$$
This formula retains both the scalar square and the cross term. Applying it to a particular successor requires that successor's exact finite-variation innovation and its exact mass to be identified independently. The extension itself does not presume those arithmetic identities or pass to an infinite natural-source limit.
