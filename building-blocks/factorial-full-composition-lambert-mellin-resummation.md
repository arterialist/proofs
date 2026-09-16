# Full primitive-composition resummation by a Lambert--Mellin observable

Independently reviewed written proof. This resums every Möbius
composition order exactly, retains the actual source signs and original
clock weight, and proves a uniform large-clock bound for a nonlocal
horizon observable. It also identifies a sharp analytic obstruction to
moving this bound to the original pointwise horizon energy. No RH premise
or finite composition truncation is used.

## Exact all-order resummation

Let q=exp(-t), g_N(t)=sum_{d<=N}mu(d)(1-q^floor(N/d)), and
h_N=g_N-g_(N-1), with g_0=0. The literal divisor birth law gives

    h_N(t)=(1-q)sum_{d|N}mu(d)q^(N/d-1).

For |z|<1 its complete horizon generating function is therefore

    H(z,t)=sum_{N>=1}h_N(t)z^N
      =(1-q)sum_{d>=1}mu(d) z^d/(1-q z^d),                (1)
    sum_{N>=1}g_N(t)z^N=H(z,t)/(1-z).                    (2)

This is the exact Euler/primitive-composition resummation. Expanding
mu by ordered prime filters is unnecessary and no fixed composition
degree remains. Absolute convergence in |z|<1 justifies every exchange.

Put z=exp(-x), x>0. For Re(s)>1, termwise Mellin integration is
absolutely convergent and gives

    integral_0^infinity x^(s-1)H(exp(-x),t)dx
      =Gamma(s)(1-q) Li_s(q)/(q zeta(s)),                 (3)

with Li_s(q)/q read as one at q=0. Indeed expand
(exp(dx)-q)^(-1)=sum_{k>=1}q^(k-1)exp(-kdx), then use the
actual Dirichlet identity sum mu(d)d^(-s)=1/zeta(s).
Thus the entire unbounded composition tower has become one explicit
gamma/polylogarithm multiplier and the actual inverse-zeta source.

## A uniform signed horizon-energy inequality

Mellin Plancherel applied to (3) proves, for every fixed sigma>1,

    integral_0^infinity x^(2sigma-1)|H(exp(-x),t)|^2 dx
       <= C_sigma,                                       (4)
    C_sigma=zeta(sigma)^4 Gamma(2sigma)/2^(2sigma).

The normalization follows from
(2pi)^(-1)integral_R|Gamma(sigma+iy)|^2dy
=Gamma(2sigma)/2^(2sigma). The bounds
|1/zeta(sigma+iy)|<=zeta(sigma) and
|Li_(sigma+iy)(q)/q|<=zeta(sigma) retain all signs before taking
the justified multiplier majorant. Equation (4) is uniform in
t>0 and in every horizon; it is not a Mertens estimate.

By (2), its physical observable is

    H(exp(-x),t)=(1-exp(-x))sum_{N>=1}g_N(t)exp(-Nx).

It is a signed nonlocal Laplace average across ALL horizons, with
the exact successor factor. Keeping the original clock weight
w(t)=t^(-2)-[t(exp(t)-1)]^(-1), w(t)<=t^(-2), yields the genuine
large-clock consumer

    integral_T^infinity w(t) integral_0^infinity
      x^(2sigma-1)|(1-exp(-x))sum_N g_N(t)exp(-Nx)|^2 dx dt
       <=C_sigma/T.                                      (5)

This holds in particular for T=X^(-1/2), giving O_sigma(sqrt X)
for the whole omitted clock of this resummed signed observable.
Every Möbius sign and the original compensated clock remain.

## Why this does not yet control the diagonal horizon energy

The map in (5) is a horizon Laplace transform, not a diagonal norm.
Its kernel admits cancellations between different N. Stable inversion
at a fixed growing horizon would require complex-direction or boundary
control absent from the positive real Laplace ray. The inverse problem
is exponentially ill-conditioned; positivity of its square does not
make the coefficient squares positive.

This failure has an explicit finite certificate. Let

    a_(K+j)=(-1)^j binom(K,j)/B_K,  0<=j<=K,
    B_K=max_j binom(K,j),

and set all other coefficients to zero. Every |a_N|<=1 and
sum_N|a_N|^2>=1, while its physical real-ray transform is exactly

    B_K^(-1) exp(-Kx)(1-exp(-x))^(K+1).

Its weighted real-ray norm decays exponentially in K. Thus no
polynomially stable real-ray inversion can recover even these finite
dyadic coefficient vectors.

There is also a decisive analytic boundary in the exact formula.
The multiplier in (3) has poles at every zeta zero unless the specific
polylogarithm numerator happens to vanish there. At q=0 that numerator
is identically one, so no cancellation is possible. Consequently a
uniform continuation of the same Mellin L2 argument from sigma>1 to
every line sigma>1/2 would already require the corresponding zero-free
half-plane. On a line through critical zeros the multiplier itself has
poles, even if RH is true. This warning is conditional on first proving
existence and L2 control of the original Mellin transform on the shifted
line; the meromorphic right side alone does not prove that continuation.
Hence shifting this exact resummation to a critical-line coercivity bound
is not an independent elementary step; it would import essentially the
missing zero information.

This obstruction is specific and falsifiable: one may still seek a
different two-variable transform whose numerator has the actual zero
divisor and whose inverse is stable in the original horizon metric.
Angular Parseval would exactly recover weighted coefficient squares:
applied to H it gives weights |h_N|^2/N^(2sigma), and applied to H/(1-z)
it gives |g_N|^2/N^(2sigma). But the latter requires an angular estimate
with the singular |1-z|^(-2) factor. The positive-real-ray Mellin bound
supplies neither angular estimate. The present transform supplies a
proved all-order signed inequality (4)-(5), but no stable inverse or
angular bound. Therefore it cannot be used as a renamed RH criterion or
as proof of the escaped-LCM diagonal upper bound. Full actual RH remains
open.
