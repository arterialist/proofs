# From the actual heat source to the scaling derivative

The gamma cancellation transfers a heat frequency cutoff to the derivative of the centered scaling readout. Two corrections are essential. The scaling readout has a deterministic centering term, and the omitted source tail has slower decay for scaling than for heat. The resulting theorem concerns the actual arithmetic source, not regularity of the minimizing theta ground.

## Exact sources and endpoints

Let
$$
e(x)=\psi(x)-x\quad(x\ge1),\qquad
a(u)=e^{-u/2}e(e^u)1_{\{u\ge0\}},
$$
so $a(0)=-1$. Define
$$
\sigma=d\psi-1_{[1,\infty)}dx-\delta_1,\qquad
C(t)=\int e^{-tx}d\sigma(x).
$$
The complete prime powers are present in $d\psi$. Let $K_{\rm sc}$ be the [actual scaling kernel](../successor-and-division/successor-feedback-kernel-scaling.md) and set
$$
Q_\sigma(t)=\sqrt t\int K_{\rm sc}(tx)d\sigma(x),\qquad
q_\sigma(v)=Q_\sigma(e^{-v}),\quad b(v)=e^{-v/2}C(e^{-v}).
$$
Stieltjes integration by parts, including the atom at one, gives
$$
\boxed{\quad b=k*a,\qquad q_\sigma=\ell*a,\quad
k(y)=e^{-3y/2}e^{-e^{-y}},\quad
\ell(y)=-e^{-3y/2}K_{\rm sc}'(e^{-y}).\quad}
\tag{1}
$$
All these integrals converge at each finite $v$ by Chebyshev and the kernel endpoints.

The arithmetic readout differs from this centered one:
$$
\boxed{\quad
Q_{\rm ar}(t)=Q_\sigma(t)+D_0(t),\qquad
D_0(t)=\sqrt tK_{\rm sc}(t)+t^{-1/2}\int_t^\infty K_{\rm sc}(x)\,dx .
\quad}
\tag{2}
$$
The first term in $D_0$ restores the atom at one; the second restores the continuous density. The zero moment of the actual kernel and its endpoint expansion give $D_0(t)\to1$ as $t\downarrow0$. This deterministic term must also be differentiated when the desired readout is $Q_{\rm ar}$. Exactly,
$$
\frac{d}{dv}D_0(e^{-v})=\ell(v)+\tfrac12D_0(e^{-v}).
$$
The endpoint expansion $K_{\rm sc}(t)=-t^{-1/2}+c_0-2\sqrt t+O(t^{3/2})$ gives
$D_0(t)=1-\tfrac23t+O(t^2)$, and therefore
$\frac{d}{dv}D_0(e^{-v})=\tfrac23e^{-v}+O(e^{-2v})$.
The constant one remains in the undifferentiated readout.

For $U>0$, put $a_U=a1_{[0,U]}$, $X=e^U$.
Its corresponding measure is exactly
$$
\sigma_U=\sigma|_{[1,X]}-e(X)\delta_X.
\tag{3}
$$
If $X$ is a prime power, its genuine arrival is included before the terminal compensation. Equation (3) is the derivative of the compactly truncated cumulative error. It is not a truncation which deletes the terminal atom. Define $b_U=k*a_U$, $q_U=\ell*a_U$.

## Kernel endpoints and the critical-line multiplier

The exact identity
$$
K_{\rm sc}'(x)=-\frac1{2x}\left[
 \int_0^xe^{-z}(x-z)^{-1/2}dz-x^{-1/2}\right]
$$
gives
$$
\ell(y)=-\tfrac12+e^{-y}+O(e^{-2y})\quad(y\to+\infty),
$$
$$
\ell(y)=\tfrac14e^y+O(e^{2y})\quad(y\to-\infty).
\tag{4}
$$
The differentiated expansions hold as well. They follow by the Taylor expansion at zero and by expanding $(1-z/x)^{-1/2}$ on $z<x/2$, with an exponentially small remaining integral, at infinity. Consequently
$\ell'\in L^1\cap L^2$, $\int\ell'=-1/2$, and
$$
|\ell(y)|+|\ell'(y)|\le C e^y\qquad(y\in\mathbb R).
\tag{5}
$$

Use unitary Fourier transforms; a convolution multiplier is the unnormalized Fourier integral of its kernel. The heat multiplier is
$$
\mathcal F_{\rm mult}k(\omega)=\Gamma(3/2+i\omega).
$$
On the absolute Mellin strip $1/2<\Re s<3/2$, the accepted scaling identity is
$$
\frac{\mathcal M K_{\rm sc}(s)}{\Gamma(s)}
=\frac{\sqrt\pi}{2s}\tan(\pi s).
$$
For $0<\eta<1$, integrate the weighted kernel at $s=1/2+\eta+i\omega$. Integration by parts gives
$$
\int e^{-(\eta+i\omega)y}\ell'(y)dy
=(\eta+i\omega)s\mathcal M K_{\rm sc}(s).
$$
Passing to $\eta\downarrow0$ is justified by the differentiated endpoint bounds, even though the unweighted integral of $\ell$ itself is not absolutely convergent. It follows that
$$
\boxed{\quad
\widehat {q_U'}(\omega)=m(\omega)\widehat b_U(\omega),\qquad
m(\omega)=-\frac{\sqrt\pi\,\omega\coth(\pi\omega)}
                  {2(1/2+i\omega)},\qquad m(0)=-1/\sqrt\pi .
\quad}
\tag{6}
$$
This is a bounded multiplier. For instance
$$
|m(\omega)|\le M_*:=\frac{\sqrt\pi}{2}\sqrt{1+4/\pi^2},
$$
using $x\coth(\pi x)\le x+1/\pi$ for $x\ge0$.

The undifferentiated ratio has a $1/\omega$ singularity at the critical zero mode. Consistently,
$$
q_U(-\infty)=0,\qquad
q_U(+\infty)=-\tfrac12\int_0^Ua(u)du.
\tag{7}
$$
Thus $q_U$ is generally not in $L^2(\mathbb R)$, although its derivative is. No bounded $L^2$ transfer for $q_U$ is asserted.

There is also an actual signed constraint:
$$
\boxed{\quad
\operatorname{Re}\int q_U'(v)\overline{b_U(v)}\,dv
=-\sqrt\pi\int
 \frac{\omega\coth(\pi\omega)}{1+4\omega^2}
 |\widehat b_U(\omega)|^2d\omega\le0 .
\quad}
\tag{8}
$$
It is strict for a nonzero $a_U$. This is a global derivative--heat pairing, not a pointwise sign for either readout.

## Frequency and source-cutoff costs

Chebyshev gives $|a(u)|\le C e^{u/2}$, hence
$\|a_U\|_2^2\le Ce^U$.
The exact gamma modulus
$$
|\Gamma(3/2+i\omega)|^2
=\frac{\pi(\omega^2+1/4)}{\cosh(\pi\omega)}
$$
and (6) imply, for $\Omega\ge1$,
$$
\|(1-P_\Omega)q_U'\|_2^2
\le C(1+\Omega)^2e^{U-\pi\Omega},
$$
$$
\|(1-P_\Omega)q_U'\|_\infty
\le C(1+\Omega)e^{(U-\pi\Omega)/2}.
\tag{9}
$$
The second inequality is Fourier Cauchy--Schwarz against the complete gamma tail. Thus the known heat high-frequency estimate transfers with a uniform multiplier.

The omitted actual source tail has a different scale. Equation (5) gives, for all real $v$,
$$
\boxed{\quad
|q_\sigma(v)-q_U(v)|
+|q_\sigma'(v)-q_U'(v)|
\le C e^{v-U/2}.
\quad}
\tag{10}
$$
For comparison the heat kernel gives
$$
|b(v)-b_U(v)|
\le C e^{v/2}(e^{U-v}+1)e^{-e^{U-v}}.
$$
Consequently $U=T+\log T$ makes the heat tail exponentially small on $0\le v\le T$, but (10) gives only
$O(e^{T/2}/\sqrt T)$ there for scaling. This is an upper-bound limitation, not a lower bound on the actual scaling error.

A complete unconditional scaling approximation follows by choosing fixed $\eta,\epsilon>0$,
$$
U=(2+\eta)T,\qquad
\Omega=U/\pi+\epsilon T
       =((2+\eta)/\pi+\epsilon)T.
\tag{11}
$$
More generally require $U-2T\to+\infty$ and
$\pi\Omega-U$ larger than the needed logarithmic factors.
Retain an anchor by defining
$$
q_{\Omega,U}^{\rm anc}(v)=q_\sigma(0)
+\int_0^vP_\Omega q_U'(s)\,ds.
$$
Then
$$
\sup_{0\le v\le T}
|q_\sigma(v)-q_{\Omega,U}^{\rm anc}(v)|
\le C e^{T-U/2}
 +CT(1+\Omega)e^{(U-\pi\Omega)/2}.
\tag{12}
$$
The anchor $q_\sigma(0)$ is a convergent complete arithmetic readout, not set to zero. Adding $D_0(e^{-v})$ restores $Q_{\rm ar}$ exactly.

## The mixed ground row and its normalization

For a fixed actual positive physical ground $G_R$, let
$m_R=\int G_R>0$. Define the normalized centered row
$$
\mathcal I_{\sigma,R}(v)=\frac1{m_R}
 \int G_R(u)[q_\sigma(v+u)+q_\sigma(v-u)]du.
$$
For the truncated derivative, its Fourier multiplier relative to $q_U'$ is
$$
W_R(\omega)=\frac2{m_R}\int G_R(u)\cos(\omega u)\,du,
\qquad |W_R(\omega)|\le2.
\tag{13}
$$
Thus (9) transfers to this normalized truncated derivative with at most a factor two in norm. There is no hidden inverse ground-mass factor in (13).

The actual source-cutoff error does pay a ground moment:
$$
|\mathcal I_{\sigma,R}'(v)-\mathcal I_{\sigma,R,U}'(v)|
\le C e^{v-U/2}
 \frac1{m_R}\int e^{|u|}G_R(u)\,du.
\tag{14}
$$
The moment is finite for each fixed ground. The physical concentration theorem identifies it as $e^R(1+o(1))$ for growing $R$. Hence a simultaneous growing-core approximation needs a source cutoff satisfying the corresponding extra $R$-dependent cost; it is not obtained uniformly by $U=T+\log T$.

Restore the deterministic average of $D_0$ from (2) and the actual full Weil row identity:
$$
Q_{\rm W}(G_R,h_{e^{-v}})
=m_R\mathcal I_{{\rm ar},R}(v)+a_0m_R+O_\theta(e^{-v/2}).
$$
After dividing by $m_R$, the last error is
$O_\theta(e^{-v/2}/m_R)$. This normalization is separate from the bounded Fourier factor (13), and cannot be omitted. No ground theta-domain claim for the heat source is made.

The bounded derivative multiplier, the signed pairing (8), and the finite-band approximation are genuine actual-source consequences. They leave the integration constant and low-frequency arithmetic amplitudes, and the ground average (13) is not a nonnegative multiplier. Therefore they do not yield a pointwise signed bound for the mixed ground row or a translation-modulus estimate for the minimizing ground history. The new heat regularity transfers to the scaling derivative with the costs above; it does not transfer to the ground’s prime-grid sampling regularity.


## Quadratic band energy and two linked histories

The multiplier in (6) is bounded away from zero as well as from infinity. For $x\ge0$,
$$
x\coth(\pi x)\ge\max\{x,1/\pi\}.
$$
Splitting at $x=1/\pi$ therefore gives the uniform, nonoptimized bound
$$
\frac{\pi}{\pi^2+4}\le |m(\omega)|^2
\le \frac{\pi}{4}(1+4/\pi^2).
$$
Consequently, for every measurable frequency set $E$,
$$
\boxed{\quad
\frac{\pi}{\pi^2+4}\|P_Eb_U\|_2^2
\le\|P_Eq_U'\|_2^2
\le M_*^2\|P_Eb_U\|_2^2.
\quad}
\tag{15}
$$
This is a genuine quadratic transport of every finite band, including the zero mode. It also shows that the derivative bridge does not damp an unknown low-band energy by a factor tending to zero.

There is a linked-history statement preserving the Fourier phase. Set $f=q_U'$, $f_\ell=P_\Omega f$, $f_h=(I-P_\Omega)f$, with analogous notation for $b_U$. Convolution of two $L^2$ functions is a bounded continuous function, and its Fourier transform is the product of the two $L^2$ transforms. The disjoint bands therefore give
$$
f_\ell*f_h=f_h*f_\ell=0,\qquad
f*f=f_\ell*f_\ell+f_h*f_h.
$$
Thus
$$
\boxed{\quad
\sup_v|(q_U'*q_U')(v)
 -(P_\Omega q_U'*P_\Omega q_U')(v)|
\le\|(I-P_\Omega)q_U'\|_2^2
\le C(1+\Omega)^2e^{U-\pi\Omega}.
\quad}
\tag{16}
$$
Similarly,
$$
\sup_v|(q_U'*b_U)(v)
 -(P_\Omega q_U'*P_\Omega b_U)(v)|
\le M_*\|(I-P_\Omega)b_U\|_2^2 .
\tag{17}
$$
No mixed-band term was estimated by an absolute-value inequality; it vanishes identically before the final bound.

The exact Fourier quantities in these identities are
$$
\widehat{q_U'*q_U'}(\omega)
=\sqrt{2\pi}\,m(\omega)^2\widehat b_U(\omega)^2,\qquad
\widehat{q_U'*b_U}(\omega)
=\sqrt{2\pi}\,m(\omega)\widehat b_U(\omega)^2.
\tag{18}
$$
They are the actual complex squares, not the positive spectral energies
$|\widehat b_U|^2$ used in (8) and (15). Neither (8) nor (15) assigns a sign to the inverse Fourier transforms in (18).

For the source and frequency cutoffs in (11), the remainder in (16) is exponentially small up to a polynomial in $T$. This quadratic statement is for the compact-source histories on the full line. The uncut histories need not be globally $L^2$, so a global uncut version is not inferred. A finite observation-window product may instead be compared using the explicit pointwise source error (10), retaining its cross terms and the chosen window; cutting in the observation variable also destroys the exact disjoint-band cancellation and must be paid separately.

Finally, the normalized ground mixing in (13) has operator norm at most two on $L^2$. If both derivative histories are first mixed by that same normalized ground convolution, their discarded linked-history error is at most four times the right side of (16). This is a bound on that specified mixed derivative observable. It does not establish the sign of the original mixed Weil row, remove its deterministic $D_0$ and pole terms, or supply a modulus for the ground itself. The retained low band, the primitive anchor, and the actual ground-normalized source tail remain the quantities that need a signed estimate.


The signed Hermitian pairing also has a band coercivity consequence. Since
$$
\frac{\sqrt\pi\,x\coth(\pi x)}{1+4x^2}
 \ge\frac{\sqrt\pi}{4(\pi+1)(1+x)}\qquad(x\ge0),
$$
equation (8) gives
$$
\boxed{\quad
-\operatorname{Re}\langle q_U',b_U\rangle
\ge\frac{\sqrt\pi}{4(\pi+1)(1+\Omega)}
       \|P_\Omega b_U\|_2^2.
\quad}
\tag{19}
$$
The elementary bound follows from
$\max(x,1/\pi)\ge(1+x)/(\pi+1)$ and
$1+4x^2\le4(1+x)^2$.
This is a signed quadratic constraint for the linked actual heat and scaling-derivative histories. It does not give an upper bound for the magnitude of its left side, so it does not close the low-band growth estimate.

The exact band separation in (16)--(18) is specific to convolution of two histories: convolution becomes pointwise multiplication of their Fourier transforms. For a pointwise square, a product on a finite observation window, or the finite-horizon heat energy, low--high cross terms generally remain. In particular (16) must not be substituted as an error bound for the finite-horizon integral of $b_U(v)^2$.

## A sharp multiplier bound and a finite Goldbach energy consumer

Both multiplier constants in (15) can be sharpened without a new arithmetic estimate. For $x=|\omega|>0$,
$$
|m(\omega)|^2
=\frac{\pi}{4}\,
  \frac{x^2\coth^2(\pi x)}{x^2+1/4}.
\tag{20}
$$
The ratio $g(x)=x\coth(\pi x)/\sqrt{x^2+1/4}$ is strictly increasing. Indeed
$$
\frac{g'(x)}{g(x)}
=\frac1{4x(x^2+1/4)}-\frac{2\pi}{\sinh(2\pi x)}>0,
$$
since $\sinh(2\pi x)>2\pi x+(4/3)\pi^3x^3\ge2\pi x+8\pi x^3$; the last inequality uses $\pi^2>6$. Its endpoint values are $g(0+)=2/\pi$ and $g(+\infty)=1$. Thus
$$
\boxed{\quad\frac1\pi\le|m(\omega)|^2\le\frac\pi4\quad}
$$
with the lower value attained at zero and the upper value approached at high frequency. The $L^2$ multiplier norm is exactly $\sqrt\pi/2$, while its inverse on its range has norm exactly $\sqrt\pi$. These constants sharpen both sides of (15), and $\sqrt\pi/2$ may replace $M_*$ in (9) and (17).

There is a direct finite centered-Goldbach version. For any finitely supported real coefficients $(a_n)$, define
$$
D_a(t)=\sum_n a_ne^{-nt},\qquad
b_a(v)=e^{-v/2}D_a(e^{-v}),\qquad
q_a(v)=e^{-v/2}\sum_n a_n K_{\rm sc}(ne^{-v}).
$$
The kernel $\kappa(v)=e^{-v/2}K_{\rm sc}(e^{-v})$ tends to $-1$ at $+\infty$ and to zero at $-\infty$, while $\kappa'\in L^1\cap L^2$ by the endpoint expansions used in (4). The heat kernel $k_0(v)=e^{-v/2}e^{-e^{-v}}$ also belongs to $L^1\cap L^2$. Since
$$
q_a(v)=\sum_n\frac{a_n}{\sqrt n}\kappa(v-\log n),\qquad
b_a(v)=\sum_n\frac{a_n}{\sqrt n}k_0(v-\log n),
$$
the same boundary-value Mellin calculation as in (6) gives
$\widehat{q_a'}(\omega)=m(\omega)\widehat b_a(\omega)$, including the finite value $m(0)=-1/\sqrt\pi$. Plancherel and $t=e^{-v}$ now give the two-sided finite-arithmetic bound
$$
\boxed{\quad
\frac1\pi\sum_{m,n}\frac{a_ma_n}{m+n}
\le\int_{\mathbb R}|q_a'(v)|^2dv
\le\frac\pi4\sum_{m,n}\frac{a_ma_n}{m+n},
\qquad
\int_0^\infty|D_a(t)|^2dt
=\sum_{m,n}\frac{a_ma_n}{m+n}.
\quad}
\tag{21}
$$
The last equality is a finite ordered additive convolution, including every signed cross term. In particular $a_n=(\Lambda(n)-1)1_{n\le N}$ retains $a_1=-1$ and every prime power through $N$. The right side is nonnegative as a whole even though its individual Goldbach coefficients can have either sign.

For the actual even physical ground $G_R$, let $m_R=\int G_R>0$ and mix this finite packet by
$$
\mathcal I_{R,a}(v)=\frac1{m_R}\int G_R(u)
  [q_a(v+u)+q_a(v-u)]du.
$$
Its derivative has multiplier $2M_R(i\omega)/m_R$ relative to $q_a'$, with $|M_R(i\omega)|\le m_R$. Thus (21) yields
$$
\boxed{\quad
\int_{\mathbb R}|\mathcal I_{R,a}'(v)|^2dv
\le\pi\sum_{m,n}\frac{a_ma_n}{m+n}.
\quad}
\tag{22}
$$
This is a finite centered-source bound for the actual ground average, with no inverse ground-mass loss. It does not bound the undifferentiated readout: $q_a(+\infty)=-\sum_n a_n/\sqrt n$ is generally nonzero. In fact no universal constant $C$ can make
$$
\left|\sum_n\frac{a_n}{\sqrt n}\right|^2
\le C\sum_{m,n}\frac{a_ma_n}{m+n}
\tag{23}
$$
hold for all finite real packets. If it did, the functional on finite sums $D_a(t)=\sum a_ne^{-nt}$ would extend continuously to their $L^2(0,\infty)$ closure. Riesz representation would give a $g\in L^2(0,\infty)$ with $\int_0^\infty g(t)e^{-nt}dt=n^{-1/2}$ for every $n\ge1$. The locally integrable function $g_0(t)=t^{-1/2}/\sqrt\pi$ has exactly the same Laplace moments. After $x=e^{-t}$, both $g(-\log x)dx$ and $g_0(-\log x)dx$ are finite signed measures on $[0,1]$ with identical polynomial moments. Polynomial density forces them to agree, hence $g=g_0$ almost everywhere, contradicting $g_0\notin L^2(0,1)$. This no-go is for arbitrary finite packets; it does not exclude an arithmetic-specific charge estimate for $a_n=\Lambda(n)-1$.

Passing from the finite packet to the uncut prime source also requires the source-tail and deterministic-centering costs in (2), (10), and (14). In particular (21)--(22) do not establish the open critical Goldbach energy estimate or a sign for the full Weil row.

## The explicit additive pair kernel of the signed derivative pairing

For the same finite packet, the whole-line pairing in (8) has an exact ordered-pair expansion. Put $\mathscr P_a=-\int_{\mathbb R}q_a'(v)b_a(v)dv$. From $K_{\rm sc}'(x)=-b_0(x)/(2x)$ and $\mathcal Lb_0(p)=-\sqrt\pi\sqrt p/(1+p)$, integration by parts with the zero moment of $K_{\rm sc}$ gives, for $p>0$,
$$
\int_0^\infty e^{-px}K_{\rm sc}(x)dx
=-\sqrt\pi\,\frac{\sqrt p-\arctan\sqrt p}{p},
\qquad
\int_0^\infty e^{-px}xK_{\rm sc}'(x)dx
=\frac{\sqrt\pi}{2}\frac{\sqrt p}{1+p}.
\tag{24}
$$
Indeed the second identity says $(p\mathcal LK_{\rm sc}(p))'=-\sqrt\pi\sqrt p/[2(1+p)]$, while $p\mathcal LK_{\rm sc}(p)\to0$ at zero. Differentiating the finite $q_a$ and changing variables $x=mt$ now yields
$$
\boxed{\quad
\mathscr P_a=\sum_{m,n}a_ma_nJ(m,n),\qquad
J(m,n)=\frac{\sqrt\pi}{2n}
\left[\arctan\sqrt{\frac nm}-\frac{\sqrt{mn}}{m+n}\right].
\quad}
\tag{25}
$$
Every entry $J(m,n)$ is positive: for $r>0$, the derivative of $\arctan r-r/(1+r^2)$ is $2r^2/(1+r^2)^2>0$ and its value at zero is zero. In particular $J(m,m)=\sqrt\pi(\pi-2)/(8m)$. The kernel is not symmetric as written, but the quadratic form uses its symmetric part $(J(m,n)+J(n,m))/2$.

The Fourier identity (8) proves that this symmetric part is positive definite on every finite coefficient set:
$$
\mathscr P_a
=\int_{\mathbb R}
\frac{\sqrt\pi\,\omega\coth(\pi\omega)}{1+4\omega^2}
|\widehat b_a(\omega)|^2d\omega>0
\quad(a\ne0).
\tag{26}
$$
The weight tends to zero like $1/|\omega|$ at high frequency, so this positive pairing has no uniform lower bound by the full heat energy in (21). For $a_n=(\Lambda(n)-1)1_{n\le N}$, (25) is a complete finite centered-Goldbach pair form, with $a_1=-1$ and all admitted prime powers. Its weight depends on the ratio $n/m$ as well as the total $m+n$; entrywise positivity of $J$ does not remove the signed centered cross terms or give an RH-scale upper bound.

There is nevertheless a sharp universal *upper* comparison of these two positive forms. The elementary inequality $y\coth y\le1+y^2/3$ for $y>0$ follows by multiplying by $\sinh y$ and comparing the power-series coefficients: those of $y^{2k+1}$ are $4k(k-1)/(3(2k+1)!)\ge0$. Since $\pi^2<12$, it gives
$$
0<\frac{\sqrt\pi\,\omega\coth(\pi\omega)}{1+4\omega^2}
\le\frac1{\sqrt\pi},
$$
with the upper value approached at $\omega=0$. Therefore the symmetric arctangent matrix and the Goldbach heat matrix satisfy, on every finite coefficient set,
$$
\boxed{\quad
0<\sum_{m,n}a_ma_nJ(m,n)
\le\frac1{\sqrt\pi}\sum_{m,n}\frac{a_ma_n}{m+n}
\quad(a\ne0).
\quad}
\tag{27}
$$
The constant is the exact norm of the Fourier multiplier on the full $L^2$ heat space. The upper constant is also sharp across arbitrary finite packets, and no positive reverse constant holds there: their heat vectors are dense in $L^2(0,\infty)$, since a vector orthogonal to every $e^{-nt}$ gives, after $x=e^{-t}$, a finite signed measure with all polynomial moments zero and hence is zero. Density transfers both the near-zero-frequency supremum and the high-frequency decay of the multiplier in (26) to finite packets. The upper inequality still requires an arithmetic bound on its right side before it can control the actual uncut centered-prime source.


## A large-core actual-ground identity for finite Goldbach packets

The physical concentration of the actual even killed ground gives a limiting converse to the one-core upper bound (22). For $R$ admitting that ground, define the bounded two-shift operator on $L^2(\mathbb R)$ by
$$
(\mathcal A_Rf)(v)=\frac1{m_R}\int G_R(u)[f(v+u)+f(v-u)]\,du,
\qquad
W_R(\omega)=\frac2{m_R}\int G_R(u)\cos(\omega u)\,du.
$$
It has real Fourier multiplier $W_R$ and $|W_R|\le2$. The [actual physical-mass concentration theorem](theta-ground-physical-mass-concentration.md#weighted-physical-tail-and-shrinking-support) implies, for every fixed real $\omega$,
$$
W_R(\omega)-2\cos(\omega R)\longrightarrow0
\qquad(R\to\infty).
\tag{28}
$$

For $f,g\in L^2$, Plancherel writes the inner product of the two-shift outputs as the integral of $W_R(\omega)^2\widehat f(\omega)\overline{\widehat g(\omega)}$. By (28) and $|W_R|\le2$, dominated convergence makes the difference from the ideal multiplier $4\cos^2(\omega R)$ tend to zero. Now $4\cos^2(\omega R)=2+2\cos(2\omega R)$. The cross term tends to zero by the Riemann--Lebesgue lemma because $\widehat f\overline{\widehat g}\in L^1$. Thus the pointwise large-core limit is
$$
\boxed{\quad
\lim_{R\to\infty}
\langle\mathcal A_Rf,\mathcal A_Rg\rangle_{L^2}
=2\langle f,g\rangle_{L^2}
\qquad(f,g\in L^2(\mathbb R)).
\quad}
\tag{29}
$$
The limit holds along any admissible radii tending to infinity, with no averaging or regularity assertion for the ground as a function of $R$. In physical space the two distant translated copies become orthogonal.

Apply (29) to the finite packet $a=(a_n)$ from (21). Put $\mathcal B_{R,a}=\mathcal A_Rb_a$, so $\mathcal I'_{R,a}=\mathcal A_Rq_a'$ in the $L^2$ weak-derivative sense. Then the ordered centered-Goldbach heat form is recovered exactly:
$$
\boxed{\quad
\lim_{R\to\infty}\|\mathcal B_{R,a}\|_2^2
=2\sum_{m,n}\frac{a_ma_n}{m+n}.
\quad}
\tag{30}
$$
The derivative energy obeys the two-sided arithmetic comparison
$$
\frac2\pi\sum_{m,n}\frac{a_ma_n}{m+n}
\le\lim_{R\to\infty}\|\mathcal I'_{R,a}\|_2^2
\le\frac\pi2\sum_{m,n}\frac{a_ma_n}{m+n}.
\tag{31}
$$
The inequalities follow from the sharp multiplier bounds (20)--(21); the middle limit is exactly $2\|q_a'\|_2^2$.

The signed derivative--heat pairing survives the same ground mixing. For each radius, the real-packet Fourier identity is
$$
-\langle\mathcal I'_{R,a},\mathcal B_{R,a}\rangle
=\int_{\mathbb R}|W_R(\omega)|^2
\frac{\sqrt\pi\,\omega\coth(\pi\omega)}{1+4\omega^2}
|\widehat b_a(\omega)|^2\,d\omega\ge0.
$$
Its large-core limit recovers twice the full arctangent pair form (25):
$$
\boxed{\quad
\lim_{R\to\infty}
-\langle\mathcal I'_{R,a},\mathcal B_{R,a}\rangle
=2\sum_{m,n}a_ma_nJ(m,n)>0\quad(a\ne0).
\quad}
\tag{32}
$$
In particular these identities apply to $a_n=(\Lambda(n)-1)1_{n\le N}$, with $a_1=-1$ and all admitted prime powers. They preserve the signed additive cross terms. The limits are taken at fixed finite $N$ before $R\to\infty$; no uniformity in $N$, bound on the uncut heat form, optimizer edge-energy payment, or pointwise sign for the full mixed Weil row follows.

## The odd companion recovers the phase at each large core

The even two-shift readout has cosine notches at a single radius. The actual sign potential supplies a complementary odd channel without changing the ground or arithmetic packet. On the positive half-line let
$$
dp_R(u)=\frac{2G_R(u)}{m_R}\mathbf1_{\{u>R\}}du,
\qquad
F_R(\omega)=\int_{u>R}e^{i\omega u}dp_R(u).
$$
Evenness of $G_R$ makes $p_R$ a probability measure. Define, alongside $\mathcal A_R^+=\mathcal A_R$ from above,
$$
(\mathcal A_R^-f)(v)
=\frac1{m_R}\int_{\mathbb R}\operatorname{sgn}(u)G_R(u)
[f(v+u)-f(v-u)]\,du.
\tag{33}
$$
The respective Fourier multipliers are $2\operatorname{Re}F_R(\omega)$ and $2i\operatorname{Im}F_R(\omega)$. Hence their combined squared multiplier is exactly $4|F_R(\omega)|^2$. The physical concentration theorem gives
$e^{-i\omega R}F_R(\omega)\to1$ for each fixed $\omega$. Dominated convergence proves the fixed-radius two-channel identity
$$
\boxed{\quad
\lim_{R\to\infty}
\bigl(\|\mathcal A_R^+f\|_2^2
      +\|\mathcal A_R^-f\|_2^2\bigr)
=4\|f\|_2^2\qquad(f\in L^2(\mathbb R)).
\quad}
\tag{34}
$$
There is no frequency exception here: the sine channel fills the cosine notches. The sign-weighted kernel $\operatorname{sgn}(u)G_R(u)$ is the physical representative of the actual sign potential $\varepsilon\psi_R$ used in the matched theta action. Equation (33) only defines its translation observation; it does not identify that observation with the conditional edge residual.

The convergence has an explicit fixed-radius loss for $f\in H^1(\mathbb R)$. Put
$$
\eta_R^2=\int_{u>R}(u-R)^2dp_R(u).
$$
The shell $R<u\le R+6w_R$, $w_R=e^{-\sqrt R/8}$, contributes at most $36w_R^2$. On its complement $(u-R)^2\le e^{u-R}$, so the weighted physical tail theorem gives $\eta_R^2\le36w_R^2+o(1)$, with its tail term bounded explicitly by (13) of the [concentration theorem](theta-ground-physical-mass-concentration.md#weighted-physical-tail-and-shrinking-support). If $U,U'$ are independent with law $p_R$, then
$$
1-|F_R(\omega)|^2
=\mathbb E[1-\cos(\omega(U-U'))]
\le\omega^2\operatorname{Var}(U)
\le\omega^2\eta_R^2.
$$
Plancherel yields the nonnegative error bound
$$
\boxed{\quad
0\le4\|f\|_2^2
-\|\mathcal A_R^+f\|_2^2
-\|\mathcal A_R^-f\|_2^2
\le4\eta_R^2\|f'\|_2^2.
\quad}
\tag{35}
$$

For the finite centered-Goldbach packet in (21), $b_a,q_a'\in H^1$, so (34) applied to each and polarized between them gives
$$
\lim_{R\to\infty}
\bigl(\|\mathcal A_R^+b_a\|_2^2+
      \|\mathcal A_R^-b_a\|_2^2\bigr)
=4\sum_{m,n}\frac{a_ma_n}{m+n},
\tag{36}
$$
$$
\lim_{R\to\infty}
-\sum_{\epsilon\in\{+,-\}}
 \langle\mathcal A_R^\epsilon q_a',\mathcal A_R^\epsilon b_a\rangle
=4\sum_{m,n}a_ma_nJ(m,n)>0\quad(a\ne0).
\tag{37}
$$
The signed pairing is nonnegative at each radius in each channel, by the same positive Fourier weight as in (26). Equations (36)--(37) restore the finite additive energy and its ratio-sensitive pairing without hiding it at a cosine zero. Passing to the uncut prime source, or paying the actual odd affine covariance residual, still requires an independent arithmetic estimate and a source-domain link.

## Exact density-cell and terminal cost for the compact actual source

The compact cumulative-error history $b_U=k*a_U$ from (3) is not the finite discrete packet $b_a$ from (21). Their difference can be paid explicitly at an integer cutoff $N\ge2$, $U=\log N$. Let
$$
\mu_N=\sum_{n=1}^N(\Lambda(n)-1)\delta_n,
\qquad
\rho_N=\sum_{n=2}^N\delta_n-\mathbf1_{[1,N]}(x)\,dx,
\qquad E(N)=\psi(N)-N.
$$
The [literal source decomposition](../goldbach/goldbach-additive-source-consumer.md#preserve-continuous-density-cells-before-entering-the-source-norm) and the terminal compensation in (3) give
$$
\sigma_U=\mu_N+\rho_N-E(N)\delta_N.
\tag{38}
$$
The prime-power arrival at $N$, when present, is included before the last atom. The cumulative function of $\rho_N$ is $-\{x\}$ on $1\le x<N$ and zero for $x\ge N$. Stieltjes integration by parts therefore yields its exact heat correction
$$
R_N(t):=\int e^{-tx}\rho_N(dx)
=-t\int_1^N\{x\}e^{-tx}\,dx,
\qquad |R_N(t)|\le e^{-t},
\qquad\|R_N\|_{L^2(0,\infty)}\le\frac1{\sqrt2}.
\tag{39}
$$
The compensated atom has the separate exact norm
$\|E(N)e^{-Nt}\|_{L^2(0,\infty)}=|E(N)|/\sqrt{2N}$.

Write $D_N^{\rm disc}(t)=\sum_{n\le N}(\Lambda(n)-1)e^{-nt}$ and $H_N^{\rm disc}=\sum_{m,n\le N}(\Lambda(m)-1)(\Lambda(n)-1)/(m+n)=\|D_N^{\rm disc}\|_2^2$. Since $b_U(v)=e^{-v/2}\int e^{-e^{-v}x}\sigma_U(dx)$, the change $t=e^{-v}$ identifies $\|b_U\|_{L^2(\mathbb R)}$ with the heat norm of $\sigma_U$. Equations (38)--(39) and the reverse triangle inequality give the unconditional comparison
$$
\boxed{\quad
\left|\|b_{\log N}\|_{L^2(\mathbb R)}
-\sqrt{H_N^{\rm disc}}\right|
\le\frac1{\sqrt2}+\frac{|\psi(N)-N|}{\sqrt{2N}}.
\quad}
\tag{40}
$$
The bounded cell correction is harmless in an energy norm; the terminal term is not automatically small. In particular (40) does not turn a compact-source heat estimate into an RH-scale finite Goldbach bound unless that actual endpoint is controlled as well.

## Dependencies and proof status

The arithmetic source and gamma multiplier come from the [centered heat source](../goldbach/centered-goldbach-heat-lyapunov.md). The scaling Mellin transform is proved in the [scaling-kernel audit](../goldbach/goldbach-scaling-kernel-hard-wall.md), and the full ground row uses the [exponential weak-ground extension](theta-ground-exponential-weak-cross-row.md). The growing-core moment in (14) uses [physical ground concentration](theta-ground-physical-mass-concentration.md). Gamma cancellation and its modulus use the classical [gamma recurrence and reflection formulas](https://dlmf.nist.gov/5.5); the band and convolution identities are applications of Plancherel. These are written actual-source identities and estimates, independently checked in their stated domains. The linked heat Lean modules do not yet formalize the derivative multiplier, ground row or finite-band transfer. The [heat-range obstruction](heat-to-killed-ground-range-obstruction.md) records why this bounded derivative map does not give a bounded-cost reconstruction of the killed ground.
