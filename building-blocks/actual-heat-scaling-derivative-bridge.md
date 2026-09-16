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
The complete prime powers are present in $d\psi$. Let $K_{\rm sc}$ be the [actual scaling kernel](successor-feedback-kernel-scaling.md) and set
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
This is a finite centered-source bound for the actual ground average, with no inverse ground-mass loss. It does not bound the undifferentiated readout: $q_a(+\infty)=-\sum_n a_n/\sqrt n$ is generally nonzero. Passing from the finite packet to the uncut prime source also requires the source-tail and deterministic-centering costs in (2), (10), and (14). In particular (21)--(22) do not establish the open critical Goldbach energy estimate or a sign for the full Weil row.


## Dependencies and proof status

The arithmetic source and gamma multiplier come from the [centered heat source](centered-goldbach-heat-lyapunov.md). The scaling Mellin transform is proved in the [scaling-kernel audit](goldbach-scaling-kernel-hard-wall.md), and the full ground row uses the [exponential weak-ground extension](theta-ground-exponential-weak-cross-row.md). The growing-core moment in (14) uses [physical ground concentration](theta-ground-physical-mass-concentration.md). Gamma cancellation and its modulus use the classical [gamma recurrence and reflection formulas](https://dlmf.nist.gov/5.5); the band and convolution identities are applications of Plancherel. These are written actual-source identities and estimates, independently checked in their stated domains. The linked heat Lean modules do not yet formalize the derivative multiplier, ground row or finite-band transfer. The [heat-range obstruction](heat-to-killed-ground-range-obstruction.md) records why this bounded derivative map does not give a bounded-cost reconstruction of the killed ground.
