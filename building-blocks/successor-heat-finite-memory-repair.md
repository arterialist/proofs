# Finite retained memory repairs successor heat-domain invariance

This written proof retains successor-generated moments as separate coordinates and proves a bounded remainder in a stated heat graph space. The [fixed-observation heat theorem](fixed-observation-prime-heat.md#10-the-exact-successor-does-not-preserve-the-improved-heat-domain) proves the actual symbol bounds and the original successor-domain obstruction. The [charge-cocycle theorem](actual-successor-resonance-charge-cocycle.md) supplies the mixed-space successor bound. No theorem in this note is formalized in Lean, and no priority claim is made for the classical finite-rank moment cancellation or Fourier Taylor argument.

Use causal physical profiles a(v)=0 for v<0, with the actual successor

$$
 (Sa)(v)=1_{v\ge0}(1+e^{-v})^{-1/2}
             a(\log(e^v+1)).                             \tag{1}
$$

On the original physical L^2 space, S is a contraction. For positive heat strength sigma, let D_sigma be the domain of the multiplier exp(-sigma G). The checked actual symbol satisfies

$$
 G(\xi)=2\log|\xi|+O(1)\quad(\xi\to0),\qquad
 |G(\xi)|\le C\log\log(3+|\xi|)+C\quad(|\xi|\ge1/4).
                                                               \tag{2}
$$

## 1. Every relative successor jet is bounded on both source spaces

For j>=0 define, initially on rapidly decaying causal inputs,

$$
 \delta_j(a)=\frac12\int_0^\infty v^j[(Sa)(v)-a(v)]dv.
$$

Let L=log 2, A(u)=(1-e^(-u))^(-1/2), and ell(u)=log(e^u-1). Changing variables through the exact warp gives

$$
 \delta_j(a)=\frac12\int_0^\infty a(u)\,k_j(u)du,
 \quad k_j(u)=1_{u\ge L}A(u)\ell(u)^j-u^j.              \tag{3}
$$

For j=0, u^0 and ell(u)^0 mean 1. On the initial interval [0,L), the second term in (3) is the literal removed strip. At infinity,

$$
 k_j(u)=O_j((1+u)^j e^{-u}).
$$

This follows from A(u)-1=O(e^(-u)) and ell(u)-u=O(e^(-u)). Therefore k_j belongs to L^2, and (3) defines a bounded relative-jet functional on every causal L^2 input even if its separate absolute moments do not exist.

In additive coordinates the same functional is integration against

$$
 \varphi_j(x)=\frac12\left[
 1_{x\ge2}\frac{\log^j(x-1)}{\sqrt{x-1}}
 -1_{x\ge1}\frac{\log^j x}{\sqrt x}\right].              \tag{4}
$$

The two shifted tails have equal limiting boundary values, so integral phi_j=0. More explicitly, the integral to R is minus one half the integral of x^(-1/2)log^j x over [R-1,R], tending to zero. The kernel is in L^1 intersection L^2 and has tail O_j(x^(-3/2)(1+log x)^j). Splitting its mean-zero Fourier integral at x=1/|xi| yields

$$
 |\widehat\varphi_j(\xi)|
 \le C_j\sqrt{|\xi|}(1+|\log|\xi||)^j\quad(0<|\xi|\le1).
$$

Consequently integral |phihat_j|^2/m is finite for m(xi) comparable to min(|xi|,1). Every delta_j is thus also a bounded functional on the accepted mixed E completion. It is the relative change of a moment, not an extension of the absolute moment itself.

## 2. A finite-rank compensation has an m-th order Fourier zero

Fix m>=1. Choose real smooth counterprofiles rho_0,...,rho_(m-1), all supported in a fixed interval inside (0,log 2), with

$$
 \frac12\int_0^\infty v^k\rho_j(v)dv=\delta_{kj}
 \quad(0\le k,j<m).                                    \tag{5}
$$

Such profiles can be constructed from a positive fixed bump eta on that interval: the moment Gram matrix of 1,v,...,v^(m-1) against eta is positive definite, and its inverse supplies the required linear combinations of v^j eta. These smooth corrections do not change existing arithmetic jump atoms.

Define

$$
 C_m a=Sa-\sum_{j=0}^{m-1}\delta_j(a)\rho_j.             \tag{6}
$$

It is bounded both on causal L^2 and, after the critical coordinate change, on causal E, using the causal successor bound in the [charge-cocycle theorem](actual-successor-resonance-charge-cocycle.md). If the first m absolute moments exist, C_m preserves them exactly. Otherwise the relative functionals in (3)--(4) still define (6).

The stronger Fourier gain is

$$
 \boxed{|\widehat{(C_m-I)a}(\xi)|
 \le C_m|\xi|^m\|a\|_2\quad(|\xi|\le1).}              \tag{7}
$$

Here is a proof not requiring a to be in L^1. For compact causal inputs, the unnormalized Fourier transform of (S-I)a pairs a with

$$
 K_\xi(u)=1_{u\ge L}A(u)e^{-i\xi\ell(u)}-e^{-i\xi u}.
$$

For every fixed derivative order k, partial_xi^k K_xi is bounded in L^2 uniformly for |xi|<=1. On [0,L) this is immediate; on the rest of the half-line, subtraction leaves an exponentially decaying bound O_k((1+u)^(k+1)e^(-u)). The derivatives at xi=0 are (-i)^k k_k(u), with k_k as in (3). The counterprofiles (5) remove exactly the first m Taylor coefficients. Taylor's theorem in L^2 therefore proves (7). Approximate arbitrary causal L^2 inputs by compact ones: the operator converges in L^2, while its low-frequency representatives converge uniformly by the kernel bound. This establishes (7) on the stated domain.

## 3. Boundedness in the actual centered-heat graph space

Define the causal BV core

$$
 X_\sigma=\{a\in L^2\cap BV:\ a=0\text{ on }(-\infty,0),\ a\in D_\sigma\},
\quad
 \|a\|_{X_\sigma}=\|a\|_2+\mathrm{TV}(a)+\|e^{-\sigma G}\widehat a\|_2.
$$

The total variation is that of the whole-line zero extension. A BV function in L^2 has limiting value zero at infinity and hence supremum bounded by its variation. Applying the literal smooth warp and its bounded monotone prefactor in (1), including the jump at zero, shows TV(Sa)<=C TV(a). Equations (3), (5), and (6) then give

$$
 \mathrm{TV}(C_m a)\le C_m(\mathrm{TV}(a)+\|a\|_2).
$$

Near zero frequency, (2) and (7) bound the heat norm of (C_m-I)a by a constant times

$$
 \|a\|_2^2\int_{|\xi|<1}|\xi|^{2m-4\sigma}d\xi.
$$

This is finite precisely in the useful range sigma<(2m+1)/4. For |xi|>=1, the BV Fourier bound is O(TV/|xi|), while (2) gives at most a fixed power of log(3+|xi|) in the squared heat weight. That tail is integrable. Thus

$$
 \boxed{C_m:X_\sigma\to X_\sigma\text{ is bounded whenever }
                  0<\sigma<(2m+1)/4.}                  \tag{8}
$$

The same assertion uses sigma=Re z for complex heat time z. In particular, one retained charge coordinate repairs the actual first domain obstruction throughout sigma<3/4 on this whole BV core, not only on a chosen finite birth pair. At any fixed finite heat strength, sufficiently many retained relative jets give (8). Constants are for fixed m and sigma; no bound uniform in their growth is asserted here.

## 4. Exact memory reconstruction and the scope of the repair

Let J(a) be the vector of first m absolute half-moments when they exist, and let R c=sum_j c_j rho_j. Write a=a_rem+R c with J(a_rem)=0. With D(a)=(delta_j(a))_j and the fixed matrix B=I+D R, the exact successor update is

$$
 c'=D(a_{\rm rem})+B c,\qquad
 a_{\rm rem}'=C_m a_{\rm rem}+[S R-R B]c.                \tag{9}
$$

The finite family in the brackets has zero first m moments, is causal BV, and belongs to X_sigma in the range (8). Thus (9) is a bounded operator on X_sigma direct-sum C^m. Applying this graph-space statement requires the input remainder to belong to X_sigma; existence of its first m absolute moments alone does not imply that graph-domain hypothesis. It reconstructs Sa=a_rem'+R c'. A scalar square or mixed term from this memory cannot be removed from the original readout merely because the remainder has a better heat domain.

For the specific counterprofiles chosen before log 2, the initial port makes this even more explicit: S rho_j=0, hence B=0 and the bracket in (9) is zero. Thus c'=D(a_rem) and a_rem'=C_m a_rem. The old counterprofile does not vanish from a complete uncompressed history: its entire successor image exits through the literal negative-output port $Q_-J_1\rho_j$. Here $Q_-$ is multiplication by $\mathbf1_{v<0}$, and $J_1$ is the uncompressed warp in (1), so its input always has coordinate $\log(e^v+1)>0$. For a=a_rem+R c that port is Q_-J_1 a_rem+(J_1R)c, with the fixed smooth packet J_1R supported in a bounded negative interval. It must be retained in any full boundary readout. There is also no resulting estimate for the actual absolute charge: the remainder a_N-RJ(a_N) itself contains the possibly large counterprofile coefficient, so its graph norm need not be uniformly bounded.

The literal relative-jet vector D extends to the actual E source by (4), and its m=1 value is the strictly positive arithmetic kappa already proved in the [charge-cocycle theorem](actual-successor-resonance-charge-cocycle.md). Absolute initial jets of the completed source are not supplied by this extension. The actual finite cutoffs may carry nonzero or growing memory coordinates.

The [positive seed process](positive-successor-seed-jump-process.md) is a contractive multiplier in the original L^2 and centered-heat graph norms; convolution with its probability measure also does not increase variation. Hence it preserves X_sigma. For charged memory profiles, its infinite mean age produces logarithmic low-frequency terms. For m>1 those cannot be absorbed into a falsely closed finite Taylor-jet update. They must remain as explicitly propagated memory packets, or be given additional history coordinates. The one-charge remainder T_u rho_0-rho_0 has Fourier size O(|xi| log(1/|xi|)) and belongs to X_sigma for sigma<3/4, but higher-strength assertions require keeping the actual logarithmic memory.

The construction therefore replaces the failed assertion that the unmodified successor preserves heat domains by a precise finite-memory statement with a bounded remainder and explicit feedback. A next quantitative test is how its constants and memory packet readouts behave as m and heat strength grow, and whether actual signed arrival identities control the restored mixed terms. No such bound or RH conclusion is assumed.
