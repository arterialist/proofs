# Successor-clock energy of the actual scattering unitary

This written theorem identifies an exact nonlinear Hilbert–Schmidt energy. The [second-increment companion](../successor-and-division/successor-second-increment-trace-criterion.md) proves the distinct trace-norm criterion. Neither supplies an arithmetic growth bound, and neither is a Lean formalization.

Use the unitary Fourier transform with exponent $-it\xi$. Use the negative-frequency Hardy projection of the [semilocal normalization](semilocal-weighted-scattering.md), and write
$$
\Delta_u=P-M_u^*PM_u,\qquad |u(t)|=1.
$$
Changing the Hardy projection changes the sign of $\Delta_u$, and leaves every norm below unchanged. Physical causal support corresponds to the negative-frequency projection under the Mellin convention used in the signed Weil trace.

## Exact localization, valid for every Schatten norm

For a real Schwartz observation $\chi$, put $v=\chi u$. The exact identity is
$$
M_\chi[P,M_u]=[P,M_v]-[P,M_\chi]M_u.                 \tag{1}
$$
Also $\Delta_u=-M_u^*[P,M_u]$, so multiplication by $\chi$ and the unitary factor commute. Consequently, for every Schatten norm with $1\le q\le\infty$ for which these quantities are defined,
$$
\left|\|M_\chi\Delta_u\|_{\mathcal S_q}
-\|[P,M_v]\|_{\mathcal S_q}\right|
\le \|[P,M_\chi]\|_{\mathcal S_q}.                 \tag{2}
$$
In particular the error is independent of the arithmetic cutoff. The assertion is a triangle inequality. It also asserts simultaneous finiteness; outside the ideal, read it as the corresponding two upper bounds rather than subtracting two infinite quantities. For Schwartz $\chi$, the fixed commutator is trace class.

The Hardy kernel and Plancherel give the exact normalization
$$
\|[P,M_v]\|_{\mathcal S_2}^2
=\frac1{4\pi^2}\iint\frac{|v(t)-v(s)|^2}{|t-s|^2}\,dt\,ds
=\frac1{2\pi}\int |\xi||\widehat v(\xi)|^2d\xi.  \tag{3}
$$

## The literal half-neighbor clock

Set
$$
h_n=\log\frac{2n+1}{2n},\qquad
\mathcal E_{\rm clk}(v)=\sum_{n\ge1}\|v(\cdot+h_n)-v\|_2^2,
\qquad
\psi(\xi)=\sum_{n\ge1}|e^{i\xi h_n}-1|^2.
$$
Tonelli and Plancherel prove
$$
\mathcal E_{\rm clk}(v)=\int\psi(\xi)|\widehat v(\xi)|^2d\xi. \tag{4}
$$
These are the exact ratios of an even successor state to the next odd state. They agree with the half-neighbor form in the unitary prime-phase construction.

The [unitary phase-lift proof](../prime-distribution/unitary-prime-phase-lift.md) establishes the full symbol estimates, including the improper Riemann-sum endpoints:

$$
\psi(\xi)\sim\xi^2\sum_{n\ge1}h_n^2\quad(\xi\to0),
\qquad \psi(\xi)\sim\frac\pi2|\xi|\quad(|\xi|\to\infty).
\tag{5}
$$

The only zero of $\psi$ is zero. A nonzero zero would force both $\xi\log(3/2)$ and $\xi\log(5/4)$ to be integer multiples of $2\pi$, contradicting prime factorization. Continuity, the preceding endpoint estimates, and compactness therefore give universal constants such that
$$
\psi(\xi)\le C|\xi|,\qquad
|\xi|\le C(1+\psi(\xi)).                         \tag{6}
$$
Thus $\|v\|_2^2+\mathcal E_{\rm clk}(v)$ is an equivalent inhomogeneous $H^{1/2}$ norm squared. Pure point spectrum is unnecessary.

## Exact nonlinear arithmetic energy

Suppose now that $\chi\ge0$. Unitarity yields an exact decomposition, without choosing a global phase branch:
$$
\mathcal E_{\rm clk}(\chi u)=\mathcal E_{\rm clk}(\chi)+\mathcal C_\chi(u),
$$
$$
\boxed{\mathcal C_\chi(u)=
\sum_{n\ge1}\int\chi(t+h_n)\chi(t)
|u(t+h_n)\overline{u(t)}-1|^2dt.}                 \tag{7}
$$
Combining (2), (3), (6), and the fixed equality $\|\chi u\|_2=\|\chi\|_2$ proves
$$
\boxed{C^{-1}\mathcal C_\chi(u)-C_\chi
\le\|M_\chi\Delta_u\|_{\mathcal S_2}^2
\le C\mathcal C_\chi(u)+C_\chi.}                \tag{8}
$$
Here $C$ is universal and $C_\chi<\infty$ depends only on the fixed window. These bounds also show equivalence of finiteness for arbitrary measurable unimodular $u$.

Apply this to the actual renormalized finite-prime multiplier
$$
u_X(t)=g_\infty(t)e^{i\theta_X(t)},\quad
g_\infty(t)=\pi^{-it}\frac{\Gamma(5/4+it/2)}{\Gamma(5/4-it/2)},
$$
$$
\theta_X(t)=2\int_0^\infty\frac{\sin(at)}a\mu_X(da),\qquad
\mu_X(da)=e^{a/2}1_{(0,\log X)}da
-\sum_{p\le X}\sum_{k\ge1}(\log p)p^{-k/2}\delta_{k\log p}(da). \tag{9}
$$
The ratio in (7) is exactly
$$
\frac{g_\infty(t+h)}{g_\infty(t)}
\exp\left(4i\int_0^\infty
\frac{\sin(ah/2)}a\cos(a(t+h/2))\mu_X(da)\right).             \tag{10}
$$
All admitted-prime proper powers, including those above $X$, remain in this formula. Near $a=0$, the sine difference regularizes the integral.

If $u_X=e^{i\Theta_X}$ locally, each summand in (7) is
$$
4\int\chi(t+h_n)\chi(t)
\sin^2\frac{\Theta_X(t+h_n)-\Theta_X(t)}2\,dt.                \tag{11}
$$
This is a nonlinear coherent quantity. The full signed phase is formed before the periodic function and the square are applied. Replacing the sine by its argument gives a sufficient upper bound, but can lose the phase cancellation that this construction is intended to explore.

## What this construction asks arithmetic to control

The exact consumer (8) replaces the localized Hilbert–Schmidt energy by increments along the ordinary successor clock. It does not bound that energy as $X$ grows, nor does Hilbert–Schmidt control alone give the trace norm used in the zero-free criterion. Equation (1) exposes a separate scalar route to trace norm, through the Besov trace-class criterion for the windowed actual unitary. That route is developed in the companion note.

The finite-prime Bohr mean removes cross terms with different global frequencies. The localized clock functional (7) retains them, together with the continuum and gamma phase. It therefore supplies a concrete test of which coherent interactions survive a fixed observation window. An estimate for the unexpanded increments must retain the signed phase before taking its periodic modulus.

The fixed-window commutator identity and the Hilbert–Schmidt kernel formula are elementary. For the separate trace-class criterion, a primary source is V. V. Peller, *Besov spaces in operator theory*, [arXiv:2402.09853, Theorem 5.7 and section 2.2](https://arxiv.org/abs/2402.09853).
