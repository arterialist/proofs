# Terminal compensation makes the actual heat prime trace convergent, but does not fix its phase

This is a written source-domain and arithmetic-phase theorem for the complete
von Mangoldt source. It joins the [actual compact heat endpoint](actual-moving-core-centered-heat-gram.md)
to the [local occupation diagonal](bost-connes-weil-local-occupation-diagonal.md).
Every prime power, the initial coefficient at one, the continuous density
cells, and the terminal atom remain visible. Absolute convergence of the
prime trace is not a sign for the full Weil form or an RH estimate.

For an integer \(N\ge2\), write
\[
a_n=\Lambda(n)-1\quad(1\le n\le N),\qquad
E_N=\sum_{n\le N}a_n=\psi(N)-N.
\]
There are two related zero-charge finite sources:
\[
 d\tau_N=\sum_{n\le N}a_n\delta_n-E_N\delta_N,
 \qquad
 d\sigma_N=1_{[1,N]}d\psi-1_{[1,N]}dx-\delta_1-E_N\delta_N.
 \tag{1}
\]
The arrival at a prime-power endpoint is included before the terminal
subtraction. The first source is the terminal-compensated *discrete*
Goldbach packet; the second is the literal compact cumulative-error source.
Their difference is the signed density-cell measure in the linked heat
theorem. For \(1\le x<N\), their cumulative functions are respectively
\[
 B_N(x)=\psi(x)-\lfloor x\rfloor,
 \qquad E(x)=\psi(x)-x,
 \qquad B_N(x)-E(x)=\{x\}.
 \tag{2}
\]
Both cumulative functions vanish outside \([1,N)\). For either source
\(\nu\in\{\tau_N,\sigma_N\}\), denote its cumulative function on this
interval by \(A_\nu\), and put
\[
 F_\nu(t)=\int e^{-tx}\,d\nu(x),\qquad
 b_\nu(v)=e^{-v/2}F_\nu(e^{-v}).
\]
Stieltjes integration by parts, including the atom at one, gives
\[
 F_\nu(t)=t\int_1^N A_\nu(x)e^{-tx}dx.                 \tag{3}
\]
In particular \(F_\nu(t)=O_N(t)\) as \(t\downarrow0\). Hence
\(b_\nu(v)=O_N(e^{-3v/2})\) at positive infinity; it and all its
derivatives decay superexponentially at negative infinity. The two
ordinary Weil pole moments therefore converge absolutely. Changing
variables \(t=e^{-v}\) in (3) evaluates them without dropping an
endpoint:
\[
 \begin{aligned}
 M_+(\nu)&:=\int_{\mathbb R}e^{v/2}b_\nu(v)dv
       =\int_1^N\frac{A_\nu(x)}x dx,\\
 M_-(\nu)&:=\int_{\mathbb R}e^{-v/2}b_\nu(v)dv
       =\int_1^N\frac{A_\nu(x)}{x^2}dx.             \tag{4}
 \end{aligned}
\]
For the discrete packet these are also the exact finite formulas
\[
 M_+(\tau_N)=\sum_{n\le N}a_n\log\frac Nn,
 \qquad
 M_-(\tau_N)=\sum_{n\le N}a_n\left(\frac1n-\frac1N\right).
 \tag{5}
\]
Equation (2) shows precisely what the continuous cells pay:
\[
 M_+(\tau_N)-M_+(\sigma_N)
   =\int_1^N\frac{\{x\}}x dx
   =\tfrac12\log N+O(1),
 \qquad
 M_-(\tau_N)-M_-(\sigma_N)
   =\int_1^N\frac{\{x\}}{x^2}dx=1-\gamma+o(1).
 \tag{6}
\]
The last equality follows by summing
\(\int_m^{m+1}(x-m)x^{-2}dx
=\log(1+1/m)-1/(m+1)\).

## The complete prime row and its late phase

For real \(b_\nu\), set
\(C_\nu(s)=\int_{\mathbb R}b_\nu(v+s)b_\nu(v)dv\).
For every integer \(k\ge2\), finite-measure Fubini and (3) give
\[
 \begin{aligned}
 q_\nu(k)
 &:=\frac{C_\nu(\log k)}{\sqrt k}
   =\int_0^\infty F_\nu(kt)F_\nu(t)dt\\
 &=\iint_{[1,N]^2}\frac{d\nu(x)d\nu(y)}{ky+x}
   =2k\int_1^N\!\int_1^N
       \frac{A_\nu(x)A_\nu(y)}{(kx+y)^3}dxdy.
                                                        \tag{7}
 \end{aligned}
\]
The denominator \(ky+x\) in the measure expression and \(kx+y\)
in the cumulative expression agree after swapping the two dummy
variables; both source factors are the same \(\nu\).
Thus the standard Weil prime contribution of this autocorrelation is
the *absolutely convergent* signed series
\[
 \mathcal P(\nu)
   =-2\sum_{k\ge2}\frac{\Lambda(k)}{\sqrt k}
                      C_\nu(\log k)
   =-2\sum_{k\ge2}\Lambda(k)q_\nu(k).
                                                        \tag{8}
\]
Here (8) specifies the prime contribution only; the archimedean and
both pole terms of the full Weil form are separate. Equivalently, for
the finite positive occupation operator
\(J_Yb=(\sqrt{\Lambda(k)/\sqrt k}(I-R_{\log k})b)_{2\le k\le Y}\),
the exact square expansion gives
\[
 \lim_{Y\to\infty}
 \left(\|J_Yb_\nu\|_2^2
       -2\|b_\nu\|_2^2\sum_{2\le k\le Y}
                                  \frac{\Lambda(k)}{\sqrt k}\right)
 =\mathcal P(\nu).                                      \tag{9}
\]
The divergent diagonal is required even on this zero-charge source.

Define two *finite* endpoint quantities
\[
 \mathcal A_\nu(N)=\int_1^N A_\nu(x)dx
       =-\int x\,d\nu(x),
 \qquad
 \mathcal T_\nu(N)=\int x^{-2}d\nu(x)
       =2\int_1^N\frac{A_\nu(x)}{x^3}dx.            \tag{10}
\]
Expanding the rational kernel in (7), with \(\int d\nu=0\), proves
the sharper fixed-packet asymptotic
\[
 \boxed{\quad
 q_\nu(k)=\frac{\mathcal A_\nu(N)\mathcal T_\nu(N)}{k^2}
                         +O_\nu(k^{-3}),\qquad
 C_\nu(\log k)=
   \frac{\mathcal A_\nu(N)\mathcal T_\nu(N)}{k^{3/2}}
                         +O_\nu(k^{-5/2}).\quad}       \tag{11}
\]
This also proves (8) directly, since
\(\sum_k\Lambda(k)/k^2<\infty\). The constants in (11) depend on
\(N\); no uniform growing-cutoff estimate is claimed.
At fixed \(N\), the prime number theorem and partial summation give
\(\sum_{k>Y}\Lambda(k)/k^2\sim1/Y\), while the remainder in (11)
contributes \(O_\nu(\log(2Y)/Y^2)\). Thus the *tail of the complete
prime row* has the exact first order
\[
 -2\sum_{k>Y}\Lambda(k)q_\nu(k)
   =-\frac{2\mathcal A_\nu(N)\mathcal T_\nu(N)}Y
       +o_\nu(Y^{-1})\qquad(Y\to\infty).             \tag{11a}
\]
The order of limits is fixed packet first, then prime cutoff.

The two first factors retain the exact density and endpoint difference:
\[
 \mathcal A_{\sigma_N}(N)=J(N):=\int_1^N E(x)dx,
 \qquad
 \mathcal A_{\tau_N}(N)=J(N)+\frac{N-1}{2}
                      =\sum_{n\le N}a_n(N-n).           \tag{12}
\]
The second factors have strictly negative limits:
\[
 \begin{aligned}
 \mathcal T_{\tau_N}(N)
   &\longrightarrow\sum_{n\ge1}\frac{\Lambda(n)-1}{n^2}
     =-\frac{\zeta'(2)}{\zeta(2)}-\zeta(2)<0,\\
 \mathcal T_{\sigma_N}(N)
   &\longrightarrow\sum_{n\ge2}\frac{\Lambda(n)}{n^2}-2
     =-\frac{\zeta'(2)}{\zeta(2)}-2<0.             \tag{13}
 \end{aligned}
\]
Indeed \(E_N=O(N)\) by Chebyshev, so its terminal inverse-square
contribution tends to zero. An elementary sign certificate avoids
decimal approximations: \(\Lambda(n)\le\log n\), and
\[
 \sum_{n\ge2}\frac{\log n}{n^2}
 \le\frac{\log2}{4}+\int_2^\infty\frac{\log x}{x^2}dx
 =\frac12+\frac34\log2<\frac54<\zeta(2).
\]

The actual first factor changes sign at arbitrarily large integer
cutoffs, with more than a linear margin. For every
\(0<\delta<1/2\),
\[
 J(N)=\Omega_\pm(N^{3/2-\delta}),
 \qquad
 \mathcal A_{\tau_N}(N)=\Omega_\pm(N^{3/2-\delta}).
                                                        \tag{14}
\]
Here is a direct Landau proof with no RH assumption. For
\(\Re s>1\), absolute Fubini gives
\[
 \int_1^\infty J(X)X^{-s-2}dX
 =\frac1{s+1}
   \left(\frac{-\zeta'(s)/\zeta(s)}s-\frac1{s-1}\right).
                                                        \tag{15}
\]
The apparent pole at \(s=1\) cancels. The right side is holomorphic
on the real interval \([1/2,1]\): for \(0<s<1\), the positive
alternating eta series and \(1-2^{1-s}<0\) give \(\zeta(s)<0\).
At any nonreal critical-line zero
\(\rho=1/2+i\gamma\) of multiplicity \(r\), its residue is
\(-r/[\rho(\rho+1)]\ne0\). Such a zero exists by Hardy's theorem,
as used in the [actual packet phase proof](actual-centered-packet-lag-autocorrelation.md#a-critical-zero-forces-a-signed-actual-packet-phase).
If \(J(X)+C X^{3/2-\delta}\) were eventually nonnegative for a
fixed \(C>0\), discard the finite initial interval, whose Mellin
transform is entire. The remaining nonnegative Mellin integral would
have a real convergence abscissa at most one, because
\(J(X)=O(X^2)\).
The nonreal pole at \(\rho\) forces that abscissa to be at least
\(1/2\). Landau's positive-Mellin theorem then requires a singularity
at that *real* abscissa. But (15) and the added term
\(C/(s-1/2+\delta)\) have no real singularity in \([1/2,1]\), a
contradiction. Apply the same argument to
\(-J(X)+C X^{3/2-\delta}\). Chebyshev gives
\(|J(X)-J(\lfloor X\rfloor)|=O(X)\) on unit intervals; since
\(3/2-\delta>1\), both excursions pass to integer cutoffs.
Equation (12) then proves (14).

For every sufficiently large packet in either of the two sign
subsequences from (14), (11)--(13) fix the sign of its sufficiently
far-lag autocorrelation and (11a) fixes the opposite sign of the
corresponding prime-row tail. Both signs occur for actual complete
prime-power packets, even after terminal compensation makes the full
prime series converge. The lag threshold may depend on the packet.

## The surviving uniform pole cost

The discrete positive pole moment in (5) is the first Riesz mean
\(R(X)=\sum_{n\le X}(\Lambda(n)-1)\log(X/n)\) at \(X=N\).
Absolute Fubini for \(\Re s>1\) gives
\[
 \int_1^\infty R(X)X^{-s-1}dX
 =\frac{-\zeta'(s)/\zeta(s)-\zeta(s)}{s^2}.       \tag{16}
\]
Consequently the family of bounds
\[
 M_+(\tau_N)=O_\varepsilon(N^{1/2+\varepsilon})
 \quad\hbox{for every }\varepsilon>0                \tag{17}
\]
is equivalent to RH. Under RH, the standard all-\(\varepsilon\)
bound for \(\psi(x)-x\) and partial summation prove (17). Conversely,
between consecutive integers \(R(X)-R(\lfloor X\rfloor)=O(1)\),
because \(\sum_{n\le X}a_n=O(X)\). Thus (17) makes (16)
holomorphic on \(\Re s>1/2\). A zero there would give an uncancelled
pole of \(-\zeta'/\zeta-\zeta\); the functional equation completes
RH. By (6), the same all-\(\varepsilon\) criterion holds for
\(M_+(\sigma_N)\).

Terminal compensation therefore repairs the individual packet's
pole *domain* and makes its full prime row convergent, while leaving
a square-root-scale uniform pole estimate as an explicit RH-strength
arithmetic obligation. The signed archimedean term and the entire
prime row still have to be controlled together for Weil positivity.
The finite identities and analytic oscillation argument above are
written mathematics; no new Lean theorem or RH proof is asserted.
