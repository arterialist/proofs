# Unilateral transfer of the actual two-history storage

This is a written mathematical proof, not a Lean formalization. The [successor cutoff](actual-successor-frequency-cutoff.md) and [semilocal normalization](semilocal-weighted-scattering.md) fix the actual input and operator conventions.

This identifies the arithmetic spectrum retained by the opposite-transport
construction. The boundary cancels the artificial resonances of the
single-prime filter. Every hypothetical off-critical zeta zero still
produces its original quadratic pole in the causal bilinear storage.
No zero is excluded by this identification alone.

Let a(v)=exp(-v/2)(psi(exp v)-exp v) for v>=0, with causal extension and
every prime power retained. Set L=log 2 and r=2^(-1/2). Use

$$
D=I-rT_-,\quad A=I-rT_+,\quad
z=D^{-1}a,\quad w=A^{-1}a,\quad
p=Az,\quad q=Dw.
$$

The causal inverse defining z is a finite sum at every argument. The
advance inverse defining w is justified here by the classical
unconditional PNT remainder: for beta(v)=exp(-v/2)a(v),

$$
|\beta(v)|\le C(1+v)^b e^{-c\sqrt v}
$$

after enlargement on a fixed initial interval. In fact
r^j a(v+jL)=exp(v/2) beta(v+jL). The resulting series is absolutely
and locally uniformly convergent, including one-sided values, and its
tail has the same kind of bound with an extra polynomial factor.
Thus p,q are locally integrable on the positive half-line, grow at
most exp(v/2) times a polynomial, and have unilateral Laplace transforms
for Re z>1/2. This construction does not assume they lie in unweighted
L² on the entire line.

Write

$$
F(z)=\int_0^\infty a(v)e^{-zv}\,dv
=-\frac{\zeta'(z+1/2)}{(z+1/2)\zeta(z+1/2)}
-\frac1{z-1/2},\qquad \Re z>1/2.
\tag{1}
$$

The pole at z=1/2 in the continued expression is removable. Define the
scalar filter factors and the two finite-strip transforms

$$
d(z)=1-r e^{-zL},\qquad a_0(z)=1-r e^{zL},
$$
$$
h(z)=\int_0^L e^{(z-1/2)u}\,du,
\qquad b(z)=\int_0^L q(-u)e^{zu}\,du.
\tag{2}
$$

Both h and b are entire. In (2), q(-u) is the complete uncut inverse
boundary source, whose convergence was justified above. It is not a
freely chosen boundary datum.

## The unilateral recurrences retain both boundary strips

Let P_+(z), Q_+(z) denote the unilateral Laplace transforms of p and q.
The exact formulas are

$$
\boxed{
P_+(z)=\frac{a_0(z)}{d(z)}F(z)-h(z),
\qquad
Q_+(z)=\frac{d(z)F(z)-b(z)}{a_0(z)}.
}
\tag{3}
$$

To derive the first formula, z(v) is causal and has transform F/d.
The transform of its advance is
exp(zL)[F/d-integral_0^L z(v)exp(-zv)dv]. On that initial interval,
z(v)=a(v)=-exp(v/2). The advance correction is exactly -h(z).

For the inverse direction, put
W_+(z)=integral_0^infinity w(v)exp(-zv)dv and
W_0(z)=integral_0^L w(v)exp(-zv)dv. The relation Aw=a gives

$$
W_+=\frac{F-r e^{zL}W_0}{a_0}.
$$

Since w(v-L)=r w(v) on 0<v<L, the transform of q=Dw is
d W_+-r²W_0. Also
q(-u)=r(1-r²)w(L-u), whence
b(z)=r(1-r²)exp(zL)W_0(z). Substitution gives the second formula in (3).
This is a unilateral derivation. An unproved common strip for bilateral
transforms of the uncut histories is not being used.

## Actual boundary data cancel every artificial prime resonance

For k an integer, put omega_k=2pi k/L and z_k=1/2+i omega_k.
The exact boundary periodization gives

$$
\boxed{b(z_k)=(1-r^2)F(z_k).}
\tag{4}
$$

Indeed, multiply
q(-u)=(1-r²)exp(-u/2) sum_{j>=1} beta(jL-u)
by exp(z_k u), and substitute v=jL-u in each interval. Absolute
convergence follows from the PNT remainder. The right side is
(1-r²) integral_0^infinity beta(v)exp(-i omega_k v)dv.

At z_k, d(z_k)=1-r² and a_0 has a simple zero. Equation (4) cancels its
numerator in Q_+. The zeta expression F is holomorphic near every z_k:
this uses the classical zero-free line Re s=1, and the removable
singularity at s=1. Thus all apparent a_0-poles in (3) are removable.
No simplicity or independence of nontrivial zeros is involved.

For the actual dyadic initial seed there is a complementary exact
identity

$$
h(z)=-\frac{a_0(z)}{z-1/2},
\qquad
P_+(z_k)=0\ (k\ne0),\qquad P_+(1/2)=-L.
\tag{5}
$$

The quotient in (5) is understood by continuation at z=1/2. These
values express a constraint on the causal forward history; they are
not a claim that the inverse boundary has no nonconstant modes.

## The quadratic storage keeps the true zeta poles

Define the causal storage and its exact boundary difference by

$$
I(s)=\int_0^s p(v)q(s-v)\,dv,\qquad
C(s)=(a*a)(s)-I(s).
$$

They are the uncut limits of the finite-strip construction in
[two history bilinear storage](two-history-bilinear-storage.md). That limit is justified on each
compact interval by the locally uniform inverse-series convergence.
Unilateral convolution transforms, initially for Re z>1/2, give

$$
\widehat I_{\rm L}(z)=P_+(z)Q_+(z),
$$
$$
\boxed{
\widehat C_{\rm L}(z)
=F(z)^2-P_+(z)Q_+(z)
=\frac{F(z)b(z)}{d(z)}+h(z)Q_+(z).
}
\tag{6}
$$

The seed corrections in (3) are essential to (6).
Using the exact dyadic identity h=-a_0/(z-1/2), there is also the
particularly explicit cancellation

$$
P_+Q_+=\left[\frac Fd+\frac1{z-1/2}\right](dF-b),
\qquad
\widehat C_{\rm L}
=\left[\frac bd-\frac d{z-1/2}\right]F
+\frac b{z-1/2}.
\tag{6a}
$$

The a_0 denominator has disappeared from the stored product itself.
The apparent remaining singularity at z=1/2 is resolved by the exact
boundary relation (4), not by deleting the seed term.
The zeros of a_0 have real part 1/2; the zeros of d have real part
-1/2. Hence both are nonzero in 0<Re z<1/2.

If rho is a nontrivial zeta zero of multiplicity m with Re rho>1/2,
put z_0=rho-1/2. Equation (1) has the exact local principal part

$$
F(z)=-\frac{m}{\rho(z-z_0)}+O(1).
$$

By (3), P_+ and Q_+ have opposite nonzero filter factors multiplying
this residue. Therefore

$$
\boxed{
\widehat I_{\rm L}(z)
=\frac{m^2}{\rho^2(z-z_0)^2}+O((z-z_0)^{-1}),
\qquad
\widehat C_{\rm L}\text{ has at most a simple pole at }z_0.
}
\tag{7}
$$

The boundary separation has not removed any hypothetical off-critical
zero or altered its multiplicity coefficient. It has separated a
quadratic pole from terms of at most first order.

Finally the full harmonic and causal-filter readout multiplies these
Laplace transforms by

$$
\zeta(z+1)\frac{z+1/2}{z+3/2}.
$$

At z_0 its nonzero double-pole coefficient for the storage is exactly

$$
\frac{m^2\zeta(\rho+1/2)}{\rho(\rho+1)}.
\tag{8}
$$

This matches the actual W transform, with every multiplicity retained.
The [literal same-prime term](harmonic-convolution.md) is analytic for $\Re z>0$ and cannot alter
(8). The statement identifies the RH-relevant content of the new
storage construction. It provides no bound for that storage and does
not infer RH from the known boundary moments or the artificial-pole
cancellations.
