# A rational pole factor inside the continuum phase

This is a written theorem, with conventions and finite trace domains fixed in the [semilocal foundation](semilocal-weighted-scattering.md). It is not a Lean formalization.

Use the negative-frequency Hardy projection from [the semilocal normalization](semilocal-weighted-scattering.md), and write
$\Delta(U)=P-U^*PU$ for a unitary multiplication operator. Changing Hardy orientation reverses signed traces and preserves the operator norm estimates below. For the signed readout we use the established convention
$$
\operatorname{Tr}(M_\chi\Delta(M_v))
=\frac1{2\pi}\int\chi(t)(-i\overline v(t)v'(t))\,dt.
$$

The pole-canceling phase separates as
$$
V_A=V_A^+V_A^-,\qquad
v_A^\pm(t)=\exp\left(2i\int_0^A e^{\pm a/2}\frac{\sin(at)}a\,da\right).
\tag{1}
$$
The two factors have different scale behavior. The decaying part has a rational limit:
$$
v_\infty^-(t)=R(t):=\exp(2i\arctan(2t))
=\frac{1+2it}{1-2it}.
\tag{2}
$$
Indeed differentiating the absolutely convergent sine integral gives
$2\int_0^\infty e^{-a/2}\cos(at)da=(t^2+1/4)^{-1}$, and both phases vanish at zero.

Gamma recurrence then gives an exact, useful normalization:
$$
\boxed{\rho_\infty(t)R(t)
=\pi^{-it}\frac{\Gamma(5/4+it/2)}{\Gamma(5/4-it/2)}.}
\tag{3}
$$
Thus the corresponding real multiplier is
$$
b(t)=\Re\psi(1/4+it/2)-\log\pi+\frac1{t^2+1/4}
=\Re\psi(5/4+it/2)-\log\pi.
\tag{4}
$$
Here $\psi$ is the digamma function. This absorbs one part of the continuum subtraction into the actual archimedean factor; it does not require transporting a test through a new theta Hilbert space.

## A uniform operator approximation, independent of the prime product

Set
$$
\delta_A(t)=2\int_A^\infty e^{-a/2}\frac{\sin(at)}a\,da,
\qquad m_A=e^{i\delta_A}=R/v_A^-.
$$
For every $A>0$,
$$
\|\delta_A\|_\infty\le \frac{4e^{-A/2}}A,
\quad
\|\delta_A'\|_\infty\le4e^{-A/2},
\tag{5}
$$
and the sine and cosine Plancherel identities give
$$
\|\delta_A\|_2^2
=4\pi\int_A^\infty\frac{e^{-a}}{a^2}\,da
\le\frac{4\pi e^{-A}}{A^2},
\qquad
\|\delta_A'\|_2^2=4\pi e^{-A}.
\tag{6}
$$
Since $|m_A-1|\le|\delta_A|$ and $|m_A'|=|\delta_A'|$, the real-line Hardy kernel yields
$$
\begin{aligned}
\|\Delta(M_{m_A})\|_{\mathcal S_2}^2
&=\frac1{4\pi^2}\iint
\frac{|m_A(t)-m_A(s)|^2}{|t-s|^2}\,dt\,ds\\
&=\frac1{2\pi}\int |\xi|\,
|\mathcal F_{\rm unitary}(m_A-1)(\xi)|^2\,d\xi\\
&\le\frac1{2\pi}\|m_A-1\|_2\|m_A'\|_2
\le\frac{2e^{-A}}A.
\end{aligned}
\tag{7}
$$
The double integral follows from the Hardy kernel away from its diagonal; the diagonal delta term cancels in the commutator. The middle identity follows by integrating
$\int |e^{i\xi h}-1|^2h^{-2}dh=2\pi|\xi|$.

For **any** scalar unitary multiplier $U$, commutativity and the exact cocycle imply
$$
\Delta(UM_R)-\Delta(UM_{v_A^-})
=(UM_{v_A^-})^*\Delta(M_{m_A})(UM_{v_A^-}).
\tag{8}
$$
Consequently
$$
\boxed{\|\Delta(UM_R)-\Delta(UM_{v_A^-})\|_{\mathcal S_2}
\le\sqrt{2/A}\,e^{-A/2}.}
\tag{9}
$$
There is also the elementary operator norm bound
$$
\|\Delta(UM_R)-\Delta(UM_{v_A^-})\|
\le2\|m_A-1\|_\infty
\le8e^{-A/2}/A.
\tag{10}
$$
These estimates are independent of every prime already present in $U$, including every proper power. In particular one may take $U=U_XV_A^+$ and $A=\log X$; the error in (9) is at most $\sqrt{2/(X\log X)}$. The growing continuum phase remains in $U$, where it can cancel the prime density before a norm estimate.

## Exact readout on the actual tests

For $F(t)=\int f(u)e^{itu}du$, $\chi=|F|^2$, and
$C_f(a)=\int f(u+a)\overline{f(u)}du$, the trace difference in (8) is
$$
\frac1{2\pi}\int\chi(t)\delta_A'(t)dt
=2\int_A^\infty e^{-a/2}\Re C_f(a)da.
\tag{11}
$$
For compact smooth $f$, it is exactly zero once $A$ exceeds its support diameter. This statement keeps $f$ fixed. It does not assert that multiplication by $V_A^+$ preserves the entire-function image of the actual theta space.

If both pole moments of $f$ vanish, the full continuum identity is
$$
-2\int_0^\infty e^{a/2}\Re C_f(a)da
=2\int_0^\infty e^{-a/2}\Re C_f(a)da
=\frac1{2\pi}\int\frac{|F(t)|^2}{t^2+1/4}\,dt.
\tag{12}
$$
Equations (3)–(12) identify the stable rational part of the renormalization, with explicit operator and signed-readout control. The remaining term is the actual signed prime discrepancy. No convergence of an unregularized Euler product on the critical line is used.

For scope, the shifted archimedean baseline is not positive by itself. Its exact minimum is
$$
b(0)=4-\gamma-\frac\pi2-3\log2-\log\pi<0,
$$
and the digamma series gives
$$
b(t)-b(0)=\sum_{n=0}^\infty
\frac{(t/2)^2}{(n+5/4)((n+5/4)^2+(t/2)^2)}\ge0.
$$
The rational normalization therefore supplies a simpler operator and a controlled limit, while leaving a nontrivial arithmetic positivity obligation.
