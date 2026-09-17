# Integer birth probes give a bounded-cost joint history observable

Attribution: Creative Research Anchor; independent mathematical review by RH Proof.

This proves a constructive growing-scale alternative to the source-dependent
centered-frame range obstruction. It uses the same actual source and a
source-independent family of integer birth seeds. It identifies the fixed
full-factor scalar through a joint energy polarization, with an absolutely
summable signed-work error. The arithmetic upper budget remains unproved.
Written proof; independently reviewed by RH Proof. The finite algebra and native seed Gram are separately compiled; the remaining analytic estimates are written proofs.

Keep the fixed real compact pole-null packet, correlation C, complete
digamma row a_phi, and full-factor scalar from
`finite-future-forcing-full-cocycle-work-transfer.md`. Write

    h_T(v)=C'(T-v)+C(T-v)/2,
    k_phi(T)=a_phi(T)-<a,h_T>,
    a(v)=e^(-v/2)E(e^v),  E(x)=psi(x)-x.

The negative prime orientation, density and state-1 port were paid in that
exact identity. They are not dropped afresh here. The actual integer scalar
is hatC_n=k_phi(log n+c)+r_n, r_n=O(n^(-5/2)), with all original
denominator factors retained.

## Native source-independent birth seeds

For m>=1 set b_m(v)=e^(-v/2)1_{v>=log m}. The frozen actual source is

    a_N=-b_1+sum_{m<=N} Lambda(m)b_m-integral_1^N b_t dt.       (1)

This equals a for e^v<=N and equals E(N)e^(-v/2) afterward. Thus (1)
retains the seed, continuous density, and every prime power. Chebyshev's
psi(x)<=Cx gives ||a_N||_2<=C sqrt N. These are genuine integer birth
states, b_m=m^(-1/2)Q_(log m)b_1, rather than the source-dependent
relative-age frames whose compact range is obstructed.

Let H_T(x)=sqrt x h_T(log x), extended by zero outside its compact
physical support, and define

    alpha_m(T)=H_T(m)-H_T(m-1),
    R_T=sum_m alpha_m(T)b_m.

For T sufficiently large all terms are finite and

    R_T(v)=e^(-v/2)H_T(floor(e^v)),  sum_m alpha_m(T)=0.       (2)

In particular the probe has no frozen terminal tail. The telescoping
zero is exact and source-independent.

Uniformly in T, on the support x comparable to e^T,
|partial_x H_T(x)|<=C exp(-T/2). The same estimate holds after one
T derivative because C is smooth. There are O(exp T) relevant integers.
Consequently

    sum_m |alpha_m(T)|/sqrt m <= C,
    ||R_T-h_T||_1+||R_T-h_T||_2 <= C exp(-T),                 (3)
    ||partial_T(R_T-h_T)||_1+||partial_T(R_T-h_T)||_2
        <= C exp(-T).

Here the L1 and L2 norms are in v. To verify the error, use the mean
value theorem on H_T(x)-H_T(floor x), then multiply by x^(-1/2).
Its pointwise error is O(exp(-T)) on an age interval of fixed length.
For the cost, bound the sum by the variation integral of H_T, weighted
by x^(-1/2); the weight is comparable on its support. Smooth extension
by zero handles both ends. Applying these arguments to partial_T H_T
proves the last estimate, with no moving-grid differentiation.

The number of seeds grows like exp T, but their normalized total
variation cost stays bounded. The precision in (3) is compatible with
the original O(sqrt N) actual source norm when N is comparable to exp T.

## Exact joint arithmetic identity

The birth-seed Gram kernel is

    <b_m,b_l>=1/max(m,l).                                  (4)

Choose N beyond the probe support. For every relevant integer l<=N,
(1) and (4) give

    <a_N,b_l>=psi(l)/l-1
              +sum_{l<m<=N} Lambda(m)/m-log(N/l).

Put

    F(l)=log l-sum_{m<=l}Lambda(m)/m+psi(l)/l.

The preceding expression is F(l) plus the constant
sum_{m<=N}Lambda(m)/m-log N-1. The exact zero sum in (2) therefore
proves the N-independent identity

    <a_N,R_T>=sum_l alpha_l(T)F(l)
      =sum_l H_T(l)[psi(l)/(l(l+1))-log(1+1/l)].             (5)

For the second equality, finite summation by parts uses

    F(l+1)-F(l)=log(1+1/l)-psi(l)/(l(l+1)).                 (6)

At the next integer, the full Lambda(l+1) contribution cancels
between -sum Lambda(m)/m and psi(l+1)/(l+1). Thus (6) is an exact
successor constraint on complete cumulative division histories, not a
prime-only truncation. It displays precisely which historical charge
is paired with the signed local profile. Positivity of F does not
decide the sign of (5), since alpha is signed.

Define the storage-corrected joint observable

    J_N(T)=||a_N+R_T||_2^2-||a_N||_2^2-||R_T||_2^2.

Then J_N(T)=2<a_N,R_T> exactly. Equivalently it is one half the
difference of the two energies ||a_N+R_T||^2 and ||a_N-R_T||^2.
This cancels storage explicitly rather than treating the centered
frame's own storage as a fixed Weil quadratic.

## Growing integer scale and paid work transport

Set T_n=log n+c and

    G_n=a_phi(T_n)-J_(N_n)(T_n)/2,

where any integer N_n above exp(T_n+d)+1 is allowed. Equation (5)
makes G_n independent of that choice. From (3) and ||a_N||<=C sqrt N,
with N comparable to exp T, the scalar error e(T)=<a,h_T-R_T> obeys

    |e(T)|+|e'(T)|<=C exp(-T/2).                           (7)

For the derivative, freeze one sufficiently large N across each
bounded T interval; a_N agrees with a on all local supports. There
is no derivative of a cutoff and no unaccounted integer birth jump.
Hence G_n=K_n+e_n, K_n=k_phi(T_n), with

    |e_n|<=C n^(-1/2),  |Delta e_n|<=C n^(-3/2).           (8)

The independently established unconditional actual PNT envelopes are
|K_n|<=C sqrt n exp(-b sqrt(log n)) and
|Delta K_n|<=C n^(-1/2)exp(-b sqrt(log n)). For real sequences define
W_n(X)=2X_n Delta X_n and L_n(X)=(Delta X_n)^2. Equations (8) give

    |W_n(G)-W_n(K)|
      <=C[n^(-1)exp(-b sqrt(log n))+n^(-2)],
    |L_n(G)-L_n(K)|<=C[n^(-2)exp(-b sqrt(log n))+n^(-3)].    (9)

The full scalar correction r_n and its increment O(n^(-5/2)) have
already-paid smaller work errors. Therefore

    sum_{n>=M}|W_n(G)-W_n(hatC)|
      <=C[(1+sqrt(log M))exp(-b sqrt(log M))+M^(-1)],
    sum_{n>=M}|L_n(G)-L_n(hatC)|<=C/M.                     (10)

The integral substitution u=sqrt(log x) proves the first tail.
This is absolute transport of coherent signed work, stronger than
using bounded scalar errors alone. Both value-error/increment-charge
and charge/increment-error mixed orders are retained in (9).

## Exact scope and next route

This is a bounded observable map to the fixed full-factor scalar,
using actual integer seeds and a fully paid form error. The compact
grid probe R_T is an observation probe; it need not itself be an
exact pole-null Weil packet. The fixed row's original pole correction,
full archimedean term and denominator transport stay in a_phi and r_n.
No positivity of its linear probe or of its signed work is asserted.

There is also a precise clock lift. With the full literal Levy law,
let G_s=T_s^*T_s and q_(T,s)=G_s^(-1)R_T. The bounded compound-Poisson
generator gives ||G_s^(-1)||<=exp(4 lambda s), as proved in the range
obstruction note. Thus

    2<T_s a_N,T_s q_(T,s)>=2<a_N,R_T>=J_N(T),
    ||q_(T,s)||<=C exp(4 lambda s).                         (11)

Polarization with q_(T,s), with its actual storage subtracted, gives
the same observable exactly. All atoms and full powers of the clock
are retained. For s proportional to log log N, this costs a fixed
power of log N; no growing exponential source cost is hidden. The
inverse probe is signed and generally noncompact, so (11) is not a
positive Weil test. Polarization with R_T itself at nonzero s reads
2<T_s a_N,T_s R_T>, which remains a different observation. In
particular (11) does not identify q_(T,s) with the adaptive centered
frame or make its independent storage free. Equation (10) retains
the original external integer clock and transports the exact scalar
in (11), rather than silently changing its metric.

The testable mechanism is now the exact successor pairing (5), with
bounded normalized synthesis cost and summable work transport. An
arithmetic upper bound would have to control the accumulated coherent
work of this actual signed cumulative-history observable. The identity
does not supply that control: it selects a concrete native-history
route without introducing another unproved norm premise.
