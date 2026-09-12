# Actual inverse-boundary constraints and the first resolvent pairing

This is a written mathematical proof, not a Lean formalization. The [successor cutoff](actual-successor-frequency-cutoff.md) and [semilocal normalization](semilocal-weighted-scattering.md) fix the actual input and operator conventions.

Let $L=\log2$, $r=2^{-1/2}$, and $c_0=1-r^2=1/2$. The actual causal input is

$$
a(s)=e^{-s/2}(\psi(e^s)-e^s),\qquad
\beta(s)=e^{-s/2}a(s)=e^{-s}\psi(e^s)-1,
\quad \beta(0)=-1.
$$

Here psi includes every prime power with its von Mangoldt weight. For the finite-cutoff statements assume $\chi_T$ is continuous, compactly supported, $0\le\chi_T\le1$, and $\chi_T(0)=1$. For limiting statements assume $\chi_T(s)\to1$ for every fixed $s$. The actual taper used in the two-history construction equals 1 through T, decreases linearly to zero at T+1, and is zero thereafter.

On $0<u<L$ define

$$
q_T(-u)=c_0e^{-u/2}\sum_{j\ge1}\chi_T(jL-u)\beta(jL-u),
\qquad Q_T(u)=e^{u/2}q_T(-u).
\tag{1}
$$

These are finite sums for every fixed T. They are the actual inverse strip in [two history bilinear storage](two-history-bilinear-storage.md), not an independently chosen boundary seed.

## Exact moments and the normalization of the Fourier coefficients

For $\omega_k=2\pi k/L$, let $C_k(T)=\int_0^L Q_T(u)e^{-i\omega_k u}du$. These are unnormalized coefficients; Fourier-series coefficients divide them by L. They are coefficients of Q_T, not of q_T without its exponential weight.

Substitution $s=jL-u$ partitions the positive half-line into adjacent strips and gives exactly

$$
C_k(T)=c_0\int_0^\infty\chi_T(s)\beta(s)e^{i\omega_k s}\,ds.
\tag{2}
$$

In particular the weighted strip integral is $c_0\int\chi_T\beta$.

The classical PNT error implies $|\beta(s)|\le Ce^{-c\sqrt s}$ for sufficiently large s, hence beta belongs to L1. An explicit primary bound sufficient here is [Johnston–Yang, Theorem 1.1](https://arxiv.org/abs/2204.01980), as used in the [division-renewal theorem](division-renewal-dyadic-average.md). Zero-freeness at $1+i\tau$ for $\tau\ne0$ also follows from this input and (4): its Laplace integral stays bounded as $z\to i\tau$ from the right, whereas a zero there would force a pole of the displayed logarithmic derivative. No RH hypothesis is used here.

If Q denotes (1) without the cutoff, then

$$
\|Q_T-Q\|_{L^1(0,L)}
\le c_0\int_0^\infty |\chi_T-1|\,|\beta|\longrightarrow0.
\tag{3}
$$

For Re(z)>0, direct integration of the actual psi series gives

$$
\int_0^\infty e^{-zs}\beta(s)\,ds
=-\frac{\zeta'(1+z)}{(1+z)\zeta(1+z)}-\frac1z.
\tag{4}
$$

The pole at z=0 cancels, leaving the value $-(1+\gamma)$. This also follows from the exact division renewal $\mathcal H\beta=e^{-s}\log(\lfloor e^s\rfloor!)-H_{\lfloor e^s\rfloor}$ proved in the [division-renewal note](division-renewal-dyadic-average.md). At a nonzero imaginary boundary point, L1 domination and Re=1 zero-freeness justify taking the limit in (4). Therefore

$$
\boxed{C_0=-c_0(1+\gamma),}
$$

$$
\boxed{C_k=c_0\left[
-\frac{\zeta'(1-i\omega_k)}{(1-i\omega_k)\zeta(1-i\omega_k)}
+\frac1{i\omega_k}\right],\quad k\ne0.}
\tag{5}
$$

In particular the nonconstant coefficients are retained. Reality gives $C_{-k}=\overline{C_k}$.

## The finite seam requires no PNT

Write $h_T=\chi_T\beta$ and $Ph_T(\theta)=\sum_{j\ge0}h_T(\theta+jL)$ for $0\le\theta<L$. Then $Q_T(u)=c_0Ph_T(L-u)$. At $\theta=0$, the initial value contributes -1. At every positive dyadic endpoint the actual jump of beta is $\log2/2^j$; continuity of chi_T introduces no additional jump. Thus

$$
P h_T(0+)-P h_T(L-)
=-1+\sum_{j\ge1}\chi_T(jL)\frac{\log2}{2^j},
$$

$$
\boxed{Q_T(0+)-Q_T(L-)
=\frac12\left[1-\sum_{j\ge1}\chi_T(jL)\frac{\log2}{2^j}\right]
\ge\frac{1-\log2}{2}>0.}
\tag{6}
$$

The sum is finite, and no asymptotic prime theorem is needed. The assumption $\chi_T(0)=1$ is essential for the displayed initial term; without it, replace 1 by $\chi_T(0)$.

For the limiting source, PNT makes the strip periodization uniformly convergent, including its one-sided limits, so its seam is exactly $(1-\log2)/2$. Since the two one-sided limits differ, neither Q_T nor Q is almost everywhere constant. Fourier uniqueness therefore implies that at least one nonconstant coefficient is nonzero.

The same computation for one fixed prime p, with $L_p=\log p$, $r_p=p^{-1/2}$ and $c_p=1-1/p$, gives the finite seam

$$
c_p\left[1-\sum_{j\ge1}\chi_T(jL_p)\frac{\log p}{p^j}\right]
\ge\frac{p-1-\log p}{p}>0.
\tag{7}
$$

Its limiting value is the right-hand side. This computation uses only the seam; it does not assert that beta is -1 throughout the first p-strip when p>2.

## A positive arithmetic-rotation inequality retaining nonconstant modes

For epsilon>0 define

$$
P_\varepsilon f(\theta)
=\sum_{j\ge0}e^{-\varepsilon(\theta+jL)}f(\theta+jL),
\qquad 0\le\theta<L,
$$

and extend periodically, using the actual right-continuous representative at zero. For bounded causal f, absolute convergence allows exact rearrangement:

$$
P_\varepsilon(Hf)(\theta)
=\sum_{d\ge1}d^{-1-\varepsilon}
 P_\varepsilon f((\theta-\log d)\bmod L).
\tag{8}
$$

Every positive-time term occurs once: after subtracting log d, the first retained point is the representative in $[0,L)$.

Let $v=e^{-s/2}b_2(s)=(2\beta(s+L)-\beta(s))/\sqrt2$ and $V=Hv$. The [formal actual integer divisor theorem](division-renewal-dyadic-average.md) gives $V(\log N)<-\delta/\sqrt2$ for every integer N>=1, where $\delta=3/2-\log4>0$. In particular

$$
\sum_{d\ge1}d^{-1-\varepsilon}
 P_\varepsilon v((-\log d)\bmod L)
< -\frac{\delta}{\sqrt2(1-2^{-\varepsilon})}.
\tag{9}
$$

The first dyadic strip has beta=-1. Shifting its periodization therefore gives

$$
P_\varepsilon v(\theta)=\frac1{\sqrt2}
\left[(2\cdot2^\varepsilon-1)P_\varepsilon\beta(\theta)
+2\cdot2^\varepsilon e^{-\varepsilon\theta}\right].
\tag{10}
$$

Equations (9)--(10) are an explicit upper bound for a positive rotation average of the Abel-regularized boundary, with a known positive forcing term. At fixed epsilon, the operator in (8) has Fourier multipliers $\zeta(1+\varepsilon+i\omega_k)$ in the theta coordinate. None is zero in this absolute-convergence half-plane, so this is not a projection onto the constant mode.

For a compact cutoff use $e^{-\varepsilon s}\chi_T(s)$. Uniform convergence of its strip periodization to the Abel source follows from the PNT tail and the actual taper. The error after the rotation operator is at most $\zeta(1+\varepsilon)$ times the uniform strip error. Thus (9)--(10) also give the corresponding finite-cutoff inequality with this explicit vanishing error. They do not give a pointwise sign for Q_T or for Q.

## The actual resolvent weight and its rotation action

For the same cutoff, let $f_T=\chi_Ta$, $z=(I-rT_-)^{-1}f_T$, and consider the specified boundary pairing

$$
\mathcal E_T(s)=\int_0^Lq_T(-u)z(s+u)\,du
=\int_0^L Q_T(u)W_{s,T}(u)\,du.
$$

The weight is fixed by the actual causal division history:

$$
\boxed{W_{s,T}(u)=e^{-u/2}z(s+u)
=e^{s/2}\sum_{k\ge0}2^{-k}h_T(s+u-kL).}
\tag{11}
$$

Terms with negative arguments vanish; the terminal taper is retained.

To see what arithmetic rotations do to this weight, use theta=L-u and extend

$$
w_s(y)=e^{s/2}\sum_{k\ge0}2^{-k}h_T(s+L-y-kL)
$$

to real y before periodization. For $\theta\in[0,L)$, set $m_d=\lfloor(\theta+\log d)/L\rfloor$. The adjoint of the rotation operator in (8) acts by

$$
R_\varepsilon^*w_s(\theta)
=\sum_{d\ge1}d^{-1-\varepsilon}w_s((\theta+\log d)\bmod L).
$$

Its actual summands satisfy

$$
w_s((\theta+\log d)\bmod L)
=2^{-m_d}\left[w_s(\theta+\log d)
+e^{s/2}\sum_{j=-m_d}^{-1}2^{-j}
h_T(s+L-\theta-\log d-jL)\right].
\tag{12}
$$

The second sum is the exact wrap correction. It contains actual signed input values. Neither positivity of the rotation weights nor (9) gives a positive preimage for w_s. Thus a general signed pairing bound cannot be inferred from that pointwise rotation inequality.

## A controlled first-prime nonconstant pairing

There is nevertheless a concrete local bound for the actual weight, with its mixed term explicit. Assume T>=1 and $0<s<1-L$. Then the taper is identically one throughout the arguments in (11), and only the arrival at 2 is encountered. Since $1<\log3$ and $1<2L$,

$$
W_s(u)=
\begin{cases}
-e^{s/2},&0<u<L-s,\\
e^{s/2}[L e^{-s-u}-3/2],&L-s\le u<L.
\end{cases}
\tag{13}
$$

This weight is nonconstant. Its pairing is exactly

$$
\boxed{\mathcal E_T(s)=e^{s/2}\left[-M_T+
\int_{L-s}^L Q_T(u)[L e^{-s-u}-1/2]\,du\right],
\quad M_T=\int_0^LQ_T.}
\tag{14}
$$

The integral is the retained first-prime mixed term. Its absolute value is at most $\frac12\int_{L-s}^L|Q_T|$, since the bracket lies between -1/2 and 0. No sign is assigned to that integral.

For a uniform local consequence put $C=1+\gamma$ and

$$
K=c_0\sup_{0\le\theta<L}\sum_{j\ge0}|\beta(\theta+jL)|<\infty.
$$

PNT proves finiteness, and $|Q_T|\le K$ for every cutoff. By (2)--(3), there exists T0>=1 such that $M_T\le-C/4$ for T>=T0. Therefore, whenever

$$
0<s<\min\{1-L,C/(4K)\},\qquad T\ge T_0,
$$

$$
\boxed{\mathcal E_T(s)\ge e^{s/2}C/8>0.} \tag{15}
$$

This conclusion uses the exact nonconstant weight and a quantitative bound for its mixed correction, not the negative mean alone. It concerns this boundary term on the first-prime window. The other boundary term and interior storage in the full bilinear identity remain, so (15) is not a sign or RH-scale bound for their sum or for W.

## Exact folding of the causal two-history storage

Use the same finite input $f_T=\chi_Ta$ and the two opposite transports from [two history bilinear storage](two-history-bilinear-storage.md). Write $p_T=U f_T$, $q_T=U^{-1}f_T$, and, on the positive half-line,

$$
\alpha_T(v)=e^{-v/2}p_T(v),\qquad
\gamma_T(v)=e^{-v/2}q_T(v),
$$

extending both by zero to negative arguments. The complete geometric actions are

$$
\alpha_T(v)=-h_T(v+L)
+\frac12\sum_{k\ge0}2^{-k}h_T(v-kL),
\tag{16}
$$

$$
\gamma_T(v)=-\frac12h_T(v-L)
+\frac12\sum_{k\ge0}h_T(v+kL).
\tag{17}
$$

The distinct geometric coefficients in these two formulas are essential. In particular, the forward-history coefficient after the exponential conjugation is $2^{-k}$, not $r^k$.

For $0\le\theta<L$, write $h_j=h_T(\theta+jL)$. Folding (16) and summing its geometric series gives

$$
\sum_{j\ge0}\alpha_T(\theta+jL)
=-\sum_{j\ge1}h_j
+\frac12\sum_{j\ge0}\sum_{k=0}^j2^{-k}h_{j-k}
=h_0=-1.
\tag{18}
$$

The actual taper is one before L and beta=-1 there. No PNT is used. Folding (17) counts each future entry exactly $j+1$ times before the delayed subtraction:

$$
\sum_{j\ge0}\gamma_T(\theta+jL)
=\frac12\sum_{j\ge0}j\,h_T(\theta+jL).
\tag{19}
$$

These identities include theta=0 with the actual right-continuous values and h_T(0)=-1.

For completeness, alpha_T is integrable and has an exponentially decreasing tail after the finite cutoff, while gamma_T is bounded and supported in $[0,T+1+L]$. Directly from (16)--(17),

$$
\|\alpha_T\|_1\le2\|h_T\|_1,
\qquad
\|\gamma_T\|_1
\le\frac12\int_0^\infty(\lfloor v/L\rfloor+2)|h_T(v)|\,dv.
$$

Thus all fold and convolution interchanges below are absolutely convergent.

The actual causal storage is

$$
I_f(s)=\int_0^s p_T(v)q_T(s-v)\,dv,
\qquad e^{-s/2}I_f(s)=(\alpha_T*\gamma_T)(s).
$$

Periodization of a causal convolution equals the unnormalized circular convolution of the two folds. Applying (18)--(19) yields

$$
\boxed{\sum_{j\ge0}e^{-(\theta+jL)/2}I_f(\theta+jL)
=-\int_0^\infty\gamma_T(v)\,dv
=-\frac12\int_0^\infty\lfloor v/L\rfloor\chi_T(v)\beta(v)\,dv.}
\tag{20}
$$

There is no factor $1/L$ in (20). The circular convolution integrates over a strip of length L without normalization. The storage is continuous, and its periodization converges uniformly by the exponential tail just noted. Hence (20) holds everywhere for that continuous representative, not only almost everywhere.

Every nonzero dyadic Fourier mode of the weighted causal storage therefore vanishes exactly at each finite cutoff:

$$
\int_0^\infty e^{-s/2}I_f(s)e^{-i\omega_k s}\,ds=0
\qquad(k\ne0).
\tag{21}
$$

Its zeroth coefficient is L times the constant in (20). This is a bilinear cancellation, not a Hermitian energy assertion or a statement that the inverse strip is constant.

The constant also connects the temporal first moment to a nonconstant strip weight:

$$
-\int\gamma_T
=-\frac1{2L}\int_0^\infty v\chi_T(v)\beta(v)\,dv
+\frac1L\int_0^L(L-u)Q_T(u)\,du.
\tag{22}
$$

For the limiting cutoff, classical PNT implies $\int(1+v)|\beta(v)|dv<\infty$. Dominated convergence therefore sends the constant to

$$
-\frac12\int_0^\infty\lfloor v/L\rfloor\beta(v)\,dv.
$$

No sign is assigned to this moment.

Finally let E_T(s) denote the sum of both exterior strip terms in the exact identity $f_T*f_T=I_f+E_T$. Multiplying by $e^{-s/2}$ gives the full convolution $h_T*h_T$ on the left. Equation (21) forces, for every nonzero dyadic mode,

$$
\boxed{\int_0^\infty e^{-s/2}E_T(s)e^{-i\omega_k s}\,ds
=\left[\int_0^\infty h_T(s)e^{-i\omega_k s}\,ds\right]^2
=4C_{-k}(T)^2.}
\tag{23}
$$

Thus all nonconstant modes of the weighted full convolution are carried by the combined exterior boundary. The right-hand side remains the complex square, not its absolute square. The finite seam (6) guarantees that the inverse strip itself retains nonconstant information even though the folded causal storage annihilates all such modes.
