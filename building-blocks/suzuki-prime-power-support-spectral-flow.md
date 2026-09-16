# Prime-power onset in Suzuki's localized Weil form

Independently reviewed written proof, 2026-09-17. This studies the *actual* von Mangoldt
weights in Suzuki's localized form. It does not assert Weil positivity or RH.
The [first-prime odd-remainder indefiniteness](suzuki-odd-pole-null-density-first-prime-indefiniteness.md)
already has a separate proof; the point here is the precise support-growth
and spectral behavior of a new prime-power shift. No Lean formalization is
claimed.

Put
\[
 u_n=\log n,\qquad w_n=\Lambda(n)n^{-1/2},\qquad
 m(\xi)=\Re\psi(1/4+i\xi/2)-\log\pi,
\]
and use the Fourier convention \(\widehat f(\xi)=\int f(x)e^{i\xi x}dx\).
For \(\phi\in L^2([-1,1])\), extended by zero, set
\(U_a\phi(x)=a^{-1/2}\phi(x/a)\). The common form domain is
\[
 \mathcal D_{\log}=\left\{\phi:\frac1{2\pi}\int
 \log(2+|\eta|)|\widehat\phi(\eta)|^2d\eta<\infty\right\}.
\]
Indeed, \(m(\xi)=\log|\xi|-\log(2\pi)+O(|\xi|^{-2})\) at infinity;
the pole and the finitely many prime shifts are bounded on \(L^2\) for
each fixed \(a\). The exact pullback of the Weil form is
\[
\begin{split}
 q_a(\phi):=Q_W(U_a\phi)
 &=2a\Re\bigl(I_+(a)\overline{I_-(a)}\bigr)
 +\frac1{2\pi}\int_{\mathbb R}m(\eta/a)|\widehat\phi(\eta)|^2d\eta\\
 &\quad-2\sum_{u_n<2a}w_n\Re C_\phi(u_n/a),                 \tag{1}\\
 I_\pm(a)&=\int_{-1}^1\phi(s)e^{\pm as/2}ds,\\
 C_\phi(\tau)&=\int_{-1}^{1-\tau}\phi(s+\tau)\overline{\phi(s)}ds
 \quad (0\le\tau\le2).
\end{split}
\]
The strict endpoint is immaterial because \(C_\phi(2)=0\). Formula (1)
retains both zeta poles, the complete gamma factor, and every admitted
prime power. It is Suzuki's full form, not the odd physical remainder.

## Exact birth of one prime-power operator

Fix \(n=p^k\) and \(a_n=u_n/2\). For \(a>a_n\) close enough that no
other threshold is crossed, let \(\tau=u_n/a\in(1,2)\) and
\(\varepsilon=2-\tau\). On \(L^2([-1,1])\), define
\[
 (T_\tau\phi)(s)=\mathbf1_{[-1,1]}(s)\phi(s-\tau),
 \qquad S_\tau=T_\tau+T_\tau^*.
\]
The new summand in (1) is \(-w_n\langle S_\tau\phi,\phi\rangle\).
The operator \(T_\tau\) translates the left collar
\(E_\varepsilon=[-1,-1+\varepsilon]\) isometrically onto the right
collar \(F_\varepsilon=[1-\varepsilon,1]\). These collars are disjoint.
Thus \(S_\tau\) is an off-diagonal unitary swap on
\(L^2(E_\varepsilon)\oplus L^2(F_\varepsilon)\), zero elsewhere, and
\[
 \operatorname{spec}(-w_nS_\tau)=\{-w_n,0,w_n\},
 \qquad \|w_nS_\tau\|=w_n.                         \tag{2}
\]
Both nonzero eigenvalues have infinite multiplicity: if \(V_\tau\) is
the translation from \(L^2(E_\varepsilon)\) to
\(L^2(F_\varepsilon)\), their eigenspaces are
\(\{(f,\pm V_\tau f):f\in L^2(E_\varepsilon)\}\). Equivalently,
\(S_\tau^2=P_{E_\varepsilon}+P_{F_\varepsilon}\). At \(a=a_n\), the
shift is zero a.e.; hence its operator norm jumps from zero to \(w_n\).
Nevertheless \(S_\tau\to0\) strongly as \(a\downarrow a_n\), because
the \(L^2\) mass of any fixed \(\phi\) in the two shrinking collars
tends to zero. This is the distinction between an operator-norm birth
and its effect on a low-energy state.

For any \(\phi\in C^1([-1,1])\),
\[
 C_\phi(2-\varepsilon)
 =\varepsilon\phi(1)\overline{\phi(-1)}+o(\varepsilon),
 \qquad \varepsilon=\frac{2(a-a_n)}{a_n}+O((a-a_n)^2).
\]
The pole, gamma, and previously admitted shifts have ordinary derivatives
at \(a_n\) for this fixed profile. In particular, the *right-minus-left
derivative of the trial form* is exactly
\[
 \partial_+q_{a_n}(\phi)-\partial_-q_{a_n}(\phi)
 =-\frac{4w_n}{a_n}\Re\bigl(\phi(1)\overline{\phi(-1)}\bigr). \tag{3}
\]
For real even \(\phi\), this is nonpositive; for real odd \(\phi\), it
is nonnegative. The normalized constant \(\phi=1/\sqrt2\) gives
\(-2w_n/a_n\); the normalized odd linear function
\(\phi(s)=\sqrt{3/2}\,s\) gives \(+6w_n/a_n\). Both have finite
logarithmic form energy. For \(\phi\in C_c^\infty(-1,1)\), the new term
is identically zero on a right neighborhood of \(a_n\): it has no
nonzero Taylor coefficient there.

To justify the ordinary gamma derivative used in (3), the digamma
series or its asymptotic gives \(\sup_{\xi\in\mathbb R}|\xi m'(\xi)|<\infty\).
Hence \(\partial_a m(\eta/a)=-(\eta/a^2)m'(\eta/a)\) is a bounded
multiplier for \(a\) in a compact positive interval, even on the full
form domain. For a \(C^1\) profile the old finite shift terms are
differentiable by the correlation integral. Thus only the new shift
contributes to the derivative jump.

## Why the norm birth does not move the ground abruptly

For \(\|\phi\|_2=1\) supported on
\(E_\varepsilon\cup F_\varepsilon\), Cauchy--Schwarz gives
\(\|\widehat\phi\|_\infty^2\le\|\phi\|_1^2\le2\varepsilon\).
For any fixed \(0<\delta<1\) and \(T=\varepsilon^{-1+\delta}\),
\[
 \frac1{2\pi}\int_{|\eta|\le T}|\widehat\phi(\eta)|^2d\eta
 \le \frac{2}{\pi}\varepsilon^\delta.
\]
Uniformly for \(a\) near \(a_n\), \(m(\eta/a)\ge\log|\eta|-C_n\) on
\(|\eta|\ge1\), and it is bounded below everywhere. Thus
\[
 \frac1{2\pi}\int m(\eta/a)|\widehat\phi(\eta)|^2d\eta
 \ge (1-\delta)(1-O(\varepsilon^\delta))\log(1/\varepsilon)-C_n. \tag{4}
\]
The pole and the finite set of prime shifts are uniformly bounded on
the \(L^2\) unit sphere near this fixed threshold. Consequently every
form-domain unit vector in an exact \(\pm w_n\) shock eigenspace has full Weil energy
going to \(+\infty\) as \(\varepsilon\downarrow0\). The new prime edge
has full operator norm but its eigenvectors escape every bounded
logarithmic-energy set.

There is also a quantitative weak estimate. Write
\(\mathcal E_{\log}(\phi)=(2\pi)^{-1}\int\log(2+|\eta|)
|\widehat\phi(\eta)|^2d\eta\). If \(\|\phi\|_2=1\) and
\(\mathcal E_{\log}(\phi)\le M\), Fourier projection at
\(T=\varepsilon^{-1/2}\) gives
\[
 \|\mathbf1_{E_\varepsilon\cup F_\varepsilon}\phi\|_2^2
 \le \frac{4}{\pi}\sqrt\varepsilon
 +\frac{2M}{\log(2+\varepsilon^{-1/2})}.             \tag{5}
\]
Indeed the low-frequency projection has pointwise square at most
\(T/\pi\), while the high-frequency squared norm is at most
\(M/\log(2+T)\); apply \(|x+y|^2\le2|x|^2+2|y|^2\).
Since \(|C_\phi(\tau)|\le\frac12\|\mathbf1_{E\cup F}\phi\|_2^2\),
the absolute value of the newborn prime contribution is at most
\(w_n\) times the right side of (5). Localized ground or almost-ground
vectors have a uniform \(M\): the gamma multiplier dominates the log
energy up to a constant, the other finitely many terms are bounded,
and a fixed smooth trial bounds the infimum above. Let
\(\lambda_a^{\setminus n}\) be the infimum for the
same pole, gamma and other actual prime-power terms with this one atom
deleted. Apply (5) to unit \(\delta\)-almost-minimizers of the two
forms, with \(0<\delta<1\). The coercivity argument above gives a
common log-energy bound \(M_n\), independent of \(\delta\). The
variational comparison in both directions, followed by
\(\delta\downarrow0\), gives
\[
 |\lambda_a-\lambda_a^{\setminus n}|
 \le w_n\left[\frac4\pi\sqrt\varepsilon+
 \frac{2M_n}{\log(2+\varepsilon^{-1/2})}\right].           \tag{6}
\]
Thus the single newly admitted atom changes the lowest Rayleigh
infimum by \(O_n(1/\log(1/(a-a_n)))\) as \(a\downarrow a_n\).
This local estimate does not give a derivative or a global positive
margin.

Finally, the genuine localized ground value
\(\lambda(a)=\inf_{\|f\|_2=1,\,\operatorname{supp}f\subset[-a,a]}Q_W(f)\)
is nonincreasing in \(a\) simply because the admissible support spaces
are nested. Suzuki proves it is continuous. Monotonicity does not use
the exact zeta amplitudes or functional equation; continuity uses local
finiteness of the shifts and compactness of the logarithmic form domain.
Formula (3) is a derivative of a *transported trial profile*, not a
Hellmann--Feynman formula for \(\lambda(a)\). A ground eigenbranch may
change profile at the threshold and no boundary trace or uniqueness
needed for such a formula has been established at every window.
The exact functional equation fixes the pole and gamma terms in (1),
but (2)--(5) reveal no one-sided ground-specific barrier preventing
\(\lambda(a)\) from crossing zero. A positive lower bound at every
window would be the missing RH assertion.

Primary source: [Suzuki, *Weil's quadratic form via the screw function*,
arXiv:2606.09096v2, §§1.2, 2.3--2.5 and Theorem 1.3](https://arxiv.org/html/2606.09096v2).
Zhu's [compact-window study, arXiv:2608.24827v2](https://arxiv.org/html/2608.24827v2) treats a certified finite
positive window and the even/odd ground ordering there; its even
window infimum is not by itself the full \(\lambda(a)\) here.
No priority claim is made for the elementary threshold calculation.
