# Finite odd heat from the original frozen metric

Written proof by RH Proof, independently mathematically audited by RH Agent3. The original frozen source and actual odd
coefficient conventions are retained. This is a one-direction norm map,
not an RH estimate or a Lean theorem.

Let N>=2 be an integer and, for x>=1, put u=min(x,N). Define

    E_N(x)=psi(u)-u,
    A_N(x)=sum over odd positive n<=u of (Lambda(n)-2),
    q_N(x)=u-2 #{odd positive n<=u}
             -(log 2) #{k>=1:2^k<=u}.

Complete even Mangoldt support gives exactly A_N=E_N+q_N. The
state-one values are E_N(1)=-1, q_N(1)=-1 and A_N(1)=-2. All odd
proper prime powers and every even power correction remain.

The odd count is floor((u+1)/2), including for noninteger u. Hence
|u-2 #{odd positive n<=u}|<=1. Also
(log 2) #{k>=1:2^k<=u}<=log u. Consequently

    |q_N(x)|<=1+log x,
    integral from 1 to infinity q_N(x)^2/x^2 dx <=5.

Both E_N and q_N freeze at the actual terminal x=N. No terminal
square or constant cumulative tail is dropped.

Let O_N(t)=sum over odd positive n<=N of (Lambda(n)-2)exp(-nt).
Finite sum integration, with t>0, gives

    O_N(t)=t integral from 1 to infinity A_N(x)exp(-tx) dx.

Indeed each coefficient contributes t integral from n to infinity
exp(-tx)dx=exp(-nt), including n=1. This equality does not use an
asymptotic formula or infinite arithmetic interchange.

Use the literal original causal source

    a_N(v)=exp(-v/2) E_N(exp v), v>=0,
    r_N(v)=exp(-v/2) q_N(exp v), v>=0,

and extend both by zero to negative ages. Their metric is dv.
The exact correction bound is ||r_N||_2^2<=5, uniformly in N.
The already proved frozen-source norm is finite for each finite N;
no completed-source L2 membership is assumed.

Put y_N(U)=exp(-U/2)O_N(exp(-U)) on the full real line. The change
of variable x=exp v gives the exact convolution

    y_N=h*(a_N+r_N),
    h(w)=exp(-3w/2)exp(-exp(-w)).

The positive kernel has

    ||h||_1=Gamma(3/2)=sqrt(pi)/2.

This follows by t=exp(-w); its Fourier transform with convention
integral exp(-i xi w)h(w)dw is Gamma(3/2+i xi). Young's inequality
therefore proves, uniformly in the arithmetic cutoff,

    (integral from 0 to infinity |O_N(t)|^2 dt)^(1/2)
      =||y_N||_2
      <=sqrt(pi)/2 (||a_N||_2+sqrt(5)).

In particular, for every epsilon>0,

    integral |O_N|^2 dt
      <=(pi/4)(1+epsilon)||a_N||_2^2
          +(5pi/4)(1+1/epsilon).

The metric constant pi/4 is the squared operator norm for unrestricted
full-line L2 input: the convolution multiplier attains its maximum at
xi=0. No claim of arithmetic saturation is made. The map has no bounded
inverse on L2 because its gamma multiplier decays at high frequency.

Combining this with RH Agent3's [fixed-band process estimate](actual-clocked-window-odd-heat-transfer.md) for the
literal cutoff window j_N gives

    ||T_(c log N) tau_(log 2) j_N||_2^2
      <=C_R (pi/4)(1+epsilon)||a_N||_2^2
          +C_(R,epsilon)+C_Z N^(-A),

for A>0 and c>(1+A)/(2 delta_R), with the same complete causal
prime-history process and fixed-band gap delta_R. This comparison uses
the cutoff window before process evolution. It asserts neither a
commutation with an observation of evolved a_N nor an identification
with unitary scattering or a signed Weil row.

The original norm still contains |psi(N)-N|^2/N, and its required
subpower bound is unproved. Thus this explicit finite-source map does
not settle RH, Goldbach existence or an accumulated-work estimate.
