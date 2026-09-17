# Endpoint-smooth actual κ frames retain zeros and both raw signs

This deduction consumes the complete-history construction's partially clipped Abel frame, its
off-critical separation, and its exact original κ scores. It strengthens
the finite arithmetic comparison, then applies the complete explicit
formula. Written proof, independent review pending. No Lean or novelty
claim. It proves neither a joint-work sign nor RH.

Fix 0<a<b<1 and real β in C_c^infinity(a,b). Set

$$
 \omega(\theta)=-\beta(\theta)-2\theta\beta'(\theta),
 \qquad W(t)=\int_0^t\frac{\beta(\theta)}{\sqrt{t-\theta}}d\theta
             -\frac{B}{\sqrt t},\quad B=\int\beta=\int\omega.
$$

The actual mixture is

$$
 C_N^\omega=\int_0^1\omega(\theta)
       \sum_{j<\lfloor\theta N\rfloor}e_{j,N}\,d\theta
       =\int_{[1,N]}w_N^\omega(x)\,\nu_N(dx),              \tag{1}
$$
$$
 w_N^\omega(x)=\int\omega(\theta)
       [r_{\lfloor\theta N\rfloor}(x)-x^{-1/2}]d\theta,
 \quad \nu_N=-\delta_1+\sum_{2\le n\le N}\Lambda(n)\delta_n-dx_{[1,N]}.
$$

The source includes every prime power, density, seed, and the frozen
endpoint. N may be real, using the displayed integer cutoffs and the
actual continuous density interval. This extends the integer definition
without changing its values there.

## Additional cancellations preserve off-critical detection

Impose the existing density and cofactor constraints and finitely many
additional endpoint constraints:

$$
 B=0,\qquad \int_0^1W(t)dt=0,\qquad
 \int_0^1\sqrt t W(t)dt=0,\qquad
 W^{(j)}(1)=0\quad(0\le j\le r),                         \tag{2}
$$

where r>=3 is fixed. These are finitely many real linear functionals
on β. They leave an infinite-dimensional generated class. Because B=0,
W vanishes for t<a. It is smooth on (0,1], including across the flat
support edges of β. Extending it by zero for t>=1 makes a compactly
supported C^r test on the positive multiplicative line. The Abel inverse
shows W=0 only if β=0.

For Re z>=1/2, z not real and Re z<1, every such z is detected by some
real β obeying (2). To prove this, write

$$
 L_z(W)=\int_0^1W(t)t^{z-1}dt,
 \quad A_z(\theta)=\int_\theta^1\frac{t^{z-1}}{\sqrt{t-\theta}}dt.
$$

On the B=0 subspace, L_z(W)=int β A_z. The finite constraint kernels
are 1, 2sqrt(1-θ),

$$
 K(\theta)=\sqrt{1-\theta}
       +\theta\log\frac{1+\sqrt{1-\theta}}{\sqrt\theta},
 \qquad (-1)^j(1/2)_j(1-\theta)^{-1/2-j}.
$$

All except K are analytic at θ=0. K is an analytic function plus an
analytic multiple of θ log θ. the complete-history construction's subtracted beta calculation,
which also holds on Re z=1/2 when Im z is nonzero, gives

$$
 A_z(\theta)=\frac1{z-1/2}
  +\frac{\Gamma(1/2)\Gamma(1/2-z)}{\Gamma(1-z)}
      \theta^{z-1/2}+O_z(\theta).                         \tag{3}
$$

The coefficient is finite and nonzero. For Re z>1/2 its nonconstant
term dominates θ|log θ| after a constant is removed. For Re z=1/2
it has an oscillation of fixed nonzero amplitude as θ decreases to zero.
Neither behavior occurs in the constraint span. All kernels are real
analytic on (0,1), so a linear relation on (a,b) would extend to that
whole interval and contradict (3). The annihilator argument therefore
supplies the claimed real β. Thus fixed support away from zero and any
finite degree of endpoint smoothing still retain access to every
off-critical mode and every actual critical zero.

The cofactor source is still nonzero:

$$
 H(y)=\frac{W(e^{-y})}{e^{-y/2}\lfloor e^y\rfloor},
 \quad \int H\,dM=0,\quad \int|H|^2dM>0,
 \quad dM=e^{-2y}\lfloor e^y\rfloor dy.                   \tag{4}
$$

It is a bounded piecewise-smooth profile of compact y support. Thus the
actual cofactor covariance theorem applies with its exact integer jumps.
The positive residual in (4) has not been identified with a signed mean.

There is a joint-source constraint surviving all these signed
cancellations. For finitely many generated β_i and fixed integer
successor offsets q, define the literal divisor states

$$
 Z_{i,N}(n+q)=\sum_{d\mid n+q}\Lambda(d)\sqrt d\,
                 H_i(\log(N/d)).
$$

Sample n uniformly with all n+q<=N. The cofactor theorem and its
two-form-sieve successor extension give

$$
 \frac{\operatorname{Cov}(Z_{i,N}(n+q),Z_{j,N}(n+q'))}{N\log N}
 \longrightarrow\mathbf1_{q=q'}\int H_i\overline{H_j}\,dM. \tag{4a}
$$

The same limit holds for the exact finite cofactor profiles formed from
w_N^omega by counting floor(N/d) multiples. Their piecewise convergence
and common bounded envelope follow from (5). Each generated mean is
asymptotically orthogonal to the constant cofactor row, but the residual
Gram is strictly positive on every linearly independent generated
family. Indeed Abel injectivity makes a nonzero linear combination of
W_i nonzero, and the positive measure in (4) detects it. This is an
actual additive-successor and complete-history covariance statement,
without a favorable sign being imposed on the arithmetic means.

## A uniform finite-score expansion improves the arithmetic error to o(1)

Define V(t)=int_t^1 omega(θ)/θ dθ. Uniformly for 1/N<=t<=1,

$$
 w_N^\omega(Nt)=N^{-1/2}W(t)-N^{-1}V(t)+O_{\beta,a,b}(N^{-3/2}).
                                                               \tag{5}
$$

Here is why the literal origin clipping does not produce a large
uncontrolled error. Put j=floor(θN), u=j/N. Apart from the clipped
branch, the exact score is N^{-1/2}R_u(t). For t<=u its clipped value is

$$
 \frac{\arctan\sqrt j}{\sqrt j}
 =N^{-1/2}\frac\pi{2\sqrt u}-\frac1j+O(j^{-2}).
$$

The interface u<t<=u+1/N has score discrepancy O(N^{-1}), but occurs
for a θ interval of length O(N^{-1}); its mixed integral is O(N^{-2}).
Consequently the leading clipping correction is
-N^{-1}int_{θ>=t} omega(θ)/θ dθ, with O(N^{-2}) mixed error.

For each t, θ maps to R_θ(t) increases to its maximum at θ=t and then
decreases. On [a/2,b+1/N] its variation is bounded independently of t,N.
The left-cell rounding error therefore obeys

$$
 \int_a^b |R_{\lfloor\theta N\rfloor/N}(t)-R_\theta(t)|d\theta
 \le N^{-1}\operatorname{TV}(R_\cdot(t))=O(N^{-1}).
$$

After its N^{-1/2} prefactor this is O(N^{-3/2}). These two estimates
prove (5), including t=1/N and t=1. The x^{-1/2} baseline cancels exactly
because B=0, rather than being omitted.

Chebyshev gives TV(ν_N)=O(N). Pairing the uniform remainder in (5)
therefore costs O(N^{-1/2}). The profile V is bounded and continuous.
PNT, by Stieltjes integration or weak convergence of scaled prime-power
measures, gives

$$
 \frac1N\int_{[1,N]} V(x/N)\nu_N(dx)=o(1).               \tag{6}
$$

This uses the full Λ measure. The seed has size O(N^{-1}); its treatment
requires no cancellation hypothesis. Since W vanishes below a and its
whole density integral is zero, (1), (5), and (6) imply

$$
 C_N^\omega=N^{-1/2}\sum_{n\ge2}\Lambda(n)W(n/N)+o(1).
                                                               \tag{7}
$$

The endpoint contributes its exact finite weight throughout the proof;
the endpoint conditions in (2) only remove the endpoint of the limiting
test. Formula (7) is much stronger than an error o(sqrt N).

## Complete actual explicit formula

Write F_W(N)=N^{-1/2}sum_n Λ(n)W(n/N). For N>1/a the untruncated
prime-power explicit formula yields

$$
 F_W(N)=-\sum_{\rho}N^{\rho-1/2}L_\rho(W)
        -\sum_{k\ge1}N^{-2k-1/2}L_{-2k}(W).               \tag{8}
$$

Nontrivial zeros occur with full multiplicity. The density term is
sqrt N L_1(W)=0 by (2). Support away from zero and r>=3 integrations
by parts give |L_s(W)|=O_W((1+|Im s|)^{-r}) uniformly for 0<=Re s<=1.
The ordinary zero-count O(T log T) therefore makes the nontrivial-zero
sum absolutely convergent for each N. The trivial-zero sum is absolutely
convergent because Na>1. No gamma, prime power, or artificial dyadic
factor has been suppressed.

For attribution, this is the classical smoothed explicit formula, not a
new zeta formula. [Ben Green's prime-number notes, Theorem 7.1](https://people.maths.ox.ac.uk/greenbj/papers/primenumbers.pdf)
prove its smooth version and state the support extension used here.
The finite C^r version follows by smooth approximation with common
C^r bounds and the displayed absolutely summable Mellin decay.

An independent exact pole audit avoids rearranging the zero sum. For
Re z>1/2, absolute Fubini gives

$$
 \int_1^\infty F_W(N)N^{-z}\frac{dN}N
 =-L_{z+1/2}(W)\frac{\zeta'(z+1/2)}{\zeta(z+1/2)}.         \tag{9}
$$

Its density pole at z=1/2 is removable because L_1(W)=0. At a zero ρ
of multiplicity m it has residue -m L_ρ(W) at z=ρ-1/2. In contrast to
the binary forcing multiplier η, this test need not cancel any zero.
The o(1) error in (7) has a holomorphic Mellin transform on Re z>0.
Thus all detected off-critical poles survive in the exact finite history
readout, with the original multiplicity and phase.

## The actual raw constrained mixture cannot keep one sign

Choose any actual critical zero ρ0=1/2+iγ0 and a β satisfying (2) with
L_{ρ0}(W) nonzero. Such zeros exist unconditionally; see the
[critical-zero discussion in DLMF 25.10](https://dlmf.nist.gov/25.10).
Let R=m(ρ0)|L_{ρ0}(W)|>0. Then for every 0<c<R,

$$
 \limsup_{N\to\infty}C_N^\omega\ge c,\qquad
 \liminf_{N\to\infty}C_N^\omega\le-c.                    \tag{10}
$$

This is unconditional even if off-critical zeros exist. Here is a
Landau proof keeping the actual o(1) correction. Suppose C_N^omega>=-c
eventually and put g(N)=C_N^omega+c on that tail. It is nonnegative and
of finite exponential order in log N. Its Mellin convergence abscissa
σc is finite. Equation (9) and the o(1) correction imply σc>=0: as σ
decreases to zero, its transform at σ+iγ0 has size R/σ+o(1/σ), whereas
a transform converging left of zero would be locally bounded there.

If σc>0, Landau's positive-transform theorem forces a singularity at
the real point σc. Equation (9) is analytic at every real z>0, including
the removed density pole, since zeta has no real zero there. The error
transform is holomorphic on Re z>0, and c/z is also analytic at σc.
This is a contradiction. Hence σc=0.

For σ>0, positivity on the tail gives the elementary inequality
|G(σ+iγ0)|<=G(σ), with bounded initial-interval corrections if needed.
But (9) is analytic at the real point z=0, and the o(1) correction has
transform o(1/σ) both at σ and at σ+iγ0. Thus

$$
 G(\sigma)=c/\sigma+o(1/\sigma),\qquad
 |G(\sigma+i\gamma_0)|=R/\sigma+o(1/\sigma),
$$

contradicting c<R. Apply the same argument to -C_N^omega for the other
sign. This proves (10). It also holds along integer N: the ideal smooth
sum has derivative O_W(N^{-1/2}) by Chebyshev, so its variation over a
unit interval is o(1), and (7) is uniform as N tends to infinity.

## What survives for joint work

The frame removes density and the constant cofactor direction at bounded
history-mixture cost, retains a positive cofactor residual, and now has
a complete actual zero-mode map with o(1) arithmetic transfer error.
Nevertheless its raw actual signed mean has both signs. An eventual sign
induction on these raw mixtures is therefore excluded in this exact
subframe. This does not exclude a signed two-history work inequality,
causal covariance, or an absolute subpower estimate. Those observables
combine phases before taking their sign and can behave differently.

The next joint-source question is whether the partially clipped centered
relative-age kernel can be expanded through this same bounded-variation
frame with a signed arithmetic error comparable to (6). Its presently
known uniform o((sqrt N log N)^{-1}) kernel error still costs
o(sqrt N/log N) after TV pairing. The score comparison above shows how
retaining a smooth clipping correction and pairing it with the full
prime-minus-density measure can improve that loss. No corresponding
relative-age correction expansion has been proved here.
