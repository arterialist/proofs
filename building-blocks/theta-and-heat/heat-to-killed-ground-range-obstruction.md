# The actual heat filter cannot be inverted onto a killed ground with bounded L² cost

This tests the specified existing heat and continuous-resolvent maps. It does not rule out a different arithmetic construction with additional input. All Fourier transforms below are unitary; a convolution multiplier is written without the unitary normalization factor.

The exact actual heat source is
$$
 b=k*a,\qquad k(v)=\exp[-3v/2-e^{-v}],\qquad
 m(\omega)=\Gamma(3/2+i\omega),
$$
$$
 |m(\omega)|^2=\frac{\pi(\omega^2+1/4)}{\cosh\pi\omega}.
\tag{1}
$$
The finite arithmetic input $a_U=1_{[0,U]}e^{-u/2}[\psi_{\rm Ch}(e^u)-e^u]$ belongs to L², and the complete filtered input is $b_U=k*a_U$. The endpoint, initial value, continuous density, and every prime-power jump are included in this source; the assertion below uses its exact multiplier, not a substitute prime sequence.

## Exact range test for the actual killed ground

Let H be convolution by k on L²(R). For every 0<η<π/2,
$$
 \int e^{2\eta|\omega|}|\widehat{Hf}(\omega)|^2d\omega
 \le C_\eta\|f\|_2^2.
\tag{2}
$$
This follows directly from (1). Cauchy–Schwarz with any slightly wider η shows that the inverse Fourier integral converges absolutely and locally uniformly at complex v with |Im v|<π/2, as do all its derivatives. Thus every Hf has a holomorphic representative on that strip.

The actual nonzero physical killed ground
$$
 G_R=\Phi\psi_R1_{|v|>R},\qquad \|\psi_R\|_\nu=1,
$$
is in physical L² but vanishes on the open interval (-R,R). It follows from the identity theorem that
$$
 \boxed{\qquad G_R\notin H(L^2(\mathbb R)),\quad R>0.\qquad}
\tag{3}
$$
Equality here would mean equality almost everywhere: the continuous analytic representative would then vanish everywhere on the core and hence everywhere on the line, contradicting the nonzero ground. The same argument applies to every nonzero compact ground truncation, or compact smooth history. This is a failure for the actual target and the exact proposed map, independent of any unknown higher regularity of the ground.

Multiplication by any bounded real-frequency multiplier after H preserves the conclusion (2). In particular both the [bounded derivative-scaling bridge](actual-heat-scaling-derivative-bridge.md) and the physical continuous resolvent
$(A+\kappa)^{-1}$, $\kappa>-a_0$, still have analytic-strip range when composed after H. Their composition cannot produce G_R or a nonzero compact history from an L² heat input. The resolvent's logarithmic high-frequency factor does not undo gamma smoothing.

## The exact finite-band inverse and its normalization cost

Let PΩ be the whole-line spectral projection onto |ω|≤Ω. It commutes with H. Since m has no zeros, there is one bandlimited inverse of PΩG_R, with squared norm
$$
 \boxed{\quad
 \|H^{-1}P_\Omega G_R\|_2^2
 =\int_{|\omega|\le\Omega}
 \frac{\cosh(\pi\omega)}{\pi(\omega^2+1/4)}
                 |\widehat G_R(\omega)|^2d\omega.
 \quad}
\tag{4}
$$
These nondecreasing costs tend to infinity. Otherwise monotone convergence would make $\widehat G_R/m$ an L² function and produce an L² preimage, contradicting (3). The conclusion is unchanged after dividing G_R by its positive physical norm, its positive physical mass, or any fixed nonzero normalization depending on R. It gives divergence for every fixed actual core; it does not assert a uniform growth rate in Ω or R.

For the heat followed by the continuous resolvent the cost is instead
$$
 \int_{|\omega|\le\Omega}
 \frac{|\mathfrak a(\omega)+\kappa|^2\cosh(\pi\omega)}
      {\pi(\omega^2+1/4)}|\widehat G_R(\omega)|^2d\omega,
$$
and again diverges. This is the exact normalization needed for that resolvent bridge, not merely an operator-norm upper ceiling.

There is also a uniform obstruction to approximate inverses. If $Hf_j\to G_R$ strongly in L² and $\sup_j\|f_j\|_2<\infty$, weak compactness gives a subsequence f_j converging weakly to f. Boundedness of H gives Hf_j converging weakly to Hf, so Hf=G_R, contradicting (3). Thus every strongly convergent reconstruction has unbounded input norm, not only the spectral reconstruction (4).

## Why the actual finite-band heat estimate does not pay this cost

The exact inverse multiplier on a band has amplification
$$
 A_\Omega=\sup_{|\omega|\le\Omega}
  \left[\frac{\cosh\pi\omega}{\pi(\omega^2+1/4)}\right]^{1/2},
 \qquad A_\Omega\asymp\frac{e^{\pi\Omega/2}}{1+\Omega}
 \quad(\Omega\to\infty).
\tag{5}
$$
The existing actual heat approximation on a horizon T uses Ω=2T/π and gives a local error bounded by a polynomial times e^(-T/2). Even if that error were promoted to a global error in the same band, multiplying its stated upper bound by (5) would give a polynomial times e^(T/2), not a vanishing reconstruction bound. In fact the known estimate is local, so this hypothetical promotion itself is not authorized. This observation is a limitation of those supplied upper bounds, not a lower bound on the actual reconstruction error.

The source-tail estimate for $b-b_U$ is retained separately in the actual heat theorem. Inverting H would recover the unsmoothed source and its literal initial and prime-power jumps. The exponential Fourier damping in (1) cannot survive that inverse as a free estimate.

## Hard localization is not an uncharged repair

For a hard observation interval I and its multiplier P_I, the exact commutator is
$$
 [P_I,H]f(v)=\int k(v-u)
       [1_I(v)-1_I(u)]f(u)du.
\tag{6}
$$
This is a genuine source term, containing both directions across the observation boundary. At nonzero finite arithmetic horizon U, the heat b_U is analytic and nonzero. Every nonzero compact localization P_I b_U is outside H(L²), by the same identity-theorem argument; an exact deconvolution after that localization has infinite L² cost. Smooth compact localization has the same range obstruction, even though it avoids jump discontinuities.

A localization followed by renormalization may be used as a new trial, but it has not been identified with the minimizing ground, and (6) must then be retained in any claimed operator intertwining. The earlier continuous Green counterprofiles remove slow resolvent moments in an admissible weak row; they do not provide a norm-preserving heat-to-ground map or remove the inverse gamma cost (4).

The valid conclusion is therefore precise: finite-band control of the actual heat source does not transfer to the actual killed ground, or to a nonzero compact ground history, through the specified heat multiplier, bounded derivative bridge, or continuous resolvent with bounded L² input normalization. A different source map would have to supply its own arithmetic identity and control its localization and normalization costs. No inference against such a map, or against RH, is made.

## The full quadratic Gram map retains the same normalization obstruction

A quadratic representation needs to be distinguished from matching one scalar form value. Let $\widetilde f(u)=\overline{f(-u)}$. If heat outputs $b_j=Hf_j$ satisfy
$$
 \sum_j b_j*\widetilde b_j=G_R*\widetilde G_R,
 \qquad \sum_j\|f_j\|_2^2<\infty,
\tag{7}
$$
then Fourier transformation and positivity imply, almost everywhere,
$$
 |m(\omega)|^2\sum_j|\widehat f_j(\omega)|^2
                         =|\widehat G_R(\omega)|^2.
$$
The same common convolution normalization factor cancels on both sides. Tonelli then identifies the total factor norm with the divergent full integral in (4). Therefore (7) is impossible. Infinite families with finite total factor energy are covered; this is not only a finite-rank obstruction.

There is a corresponding signed two-source result. Suppose
$$
 \sum_j Hf_j*\widetilde{Hg_j}=G_R*\widetilde G_R,
 \qquad \sum_j\|f_j\|_2\|g_j\|_2<\infty.
\tag{8}
$$
The Fourier series divided by $|m|^2$ converges in L¹, since
$\sum_j\int|\widehat f_j\overline{\widehat g_j}|\le\sum_j\|f_j\|_2\|g_j\|_2$.
Equality (8) would make $|\widehat G_R|^2/|m|^2$ integrable, contradicting (4). Thus indefinite cross terms do not bypass the range failure at a finite total factor cost. The exact band-restricted version requires
$$
 \sum_j\|f_j\|_2\|g_j\|_2\ge
 \int_{|\omega|\le\Omega}\frac{|\widehat G_R(\omega)|^2}{|m(\omega)|^2}d\omega
\tag{9}
$$
whenever the Fourier target agrees on that band. Its required cost diverges as the band grows.

For the real even G_R, the actual reflected bilinear convolution G_R*G_R has Fourier transform proportional to $\widehat G_R^2=|\widehat G_R|^2$. A factorization by nonconjugated heat pairs has multiplier $m(\omega)^2$, whose modulus is $|m(\omega)|^2$. The same L¹ argument and lower bound (9) apply. No ratio-location norm or unrequested conjugation has been substituted for that two-history readout.

## Odd histories and the exact pole coordinates

The actual odd score history $Y_R=\Phi'1_O$, and every nonzero compact truncation of it, are physical L² functions vanishing on the open core. Replacing G_R by Y_R gives the same linear and autocorrelation obstructions. The Fourier transform of the real odd history is purely imaginary on the real axis. Its nonconjugated self-convolution therefore has a Fourier transform whose absolute value is proportional to $|\widehat Y_R|^2$; the signed bilinear argument is unchanged. Thus keeping only an even diagonal would not resolve the full odd residual requirement.

The actual two-pole projection of any of these exponentially integrable histories is
$$
 Z^\circ=Z-[M_{1/2}(Z)+M_{-1/2}(Z)]\Phi
 -2[M_{-1/2}(Z)-M_{1/2}(Z)]\Phi'.
\tag{10}
$$
Neither original pole is discarded. The two subtracted theta profiles are real analytic on the real line. If $Z^\circ$ had a bounded heat preimage, (2) would make it real analytic, and adding the fixed analytic pole profiles would make Z real analytic as well. Since Z is nonzero and vanishes on the core, this is impossible. In particular pole projection does not turn the actual target into an L² heat-range element; its own band inverse norm diverges, and the Gram arguments (7)–(9) apply to $Z^\circ$ itself.

For an entire two-port Gram matrix, equality of the kernels includes its diagonal autocorrelations. Either of the nonzero histories above therefore already rules out a representation with finite total heat factor norm. This retains the odd and pole-null directions rather than suppressing them. If instead only one fixed scalar energy or a finite observation matrix is requested, the preceding theorem does not apply automatically: such compressed values can be reproduced by unrelated heat inputs. What is missing in that case is an exact arithmetic operator/source identity linking those inputs to the actual minimizing histories and their full affine constraints. The existing heat and resolvent maps provide no such identity.


## Dependencies and attribution

The literal source and gamma filter are those of the [centered heat construction](../goldbach/centered-goldbach-heat-lyapunov.md). The actual killed ground and its physical domain are retained from the [weak-ground theorem](theta-ground-exponential-weak-cross-row.md), with the [continuous Green repair](theta-continuous-green-weak-row-repair.md) kept separate from heat inversion. The exact modulus follows from classical [gamma recurrence and reflection](https://dlmf.nist.gov/5.5). The analytic-strip argument is proved above by exponential Fourier integrability; the identity theorem, weak compactness and Fourier factorization are standard functional-analytic tools. The result applies these tools to the specified actual histories and both pole corrections. It is a written proof, not Lean formalization, and makes no priority claim or obstruction to an unspecified alternative arithmetic map.
