# Theta cutoffs, positive even completions, and a real-zero obstruction

Finite cutoffs of the integer-indexed Riemann theta kernel have a nonzero endpoint derivative. This forces their cosine transforms to violate the Laguerre inequality at large real arguments. An explicit positive even completion removes every odd endpoint derivative, but transfers the same defect to complex square-root branches. Its transforms also violate the Laguerre inequality. Both statements hold for every real heat parameter and require no information about individual zeta zeros.

## Normalization and the arithmetic boundary identity

Put $a_n=\pi n^2$ and

$$
g_n(u)=(2a_n^2e^{9u}-3a_ne^{5u})e^{-a_ne^{4u}},\qquad
\Phi(u)=\sum_{n=1}^{\infty}g_n(u),\qquad
\Phi_Q(u)=\sum_{n=1}^{Q}g_n(u).
$$

Here $Q\ge1$ is an integer. The full series and its derivatives converge locally uniformly for real $u$. For $u\ge0$, each $g_n(u)>0$, and all derivatives decay rapidly as $u\to+\infty$.

The heat deformation is

$$
H_t(z)=\int_0^\infty e^{tu^2}\Phi(u)\cos(zu)\,du,
\qquad t\in\mathbb R.
$$

With $\xi(s)=\tfrac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)$, this convention gives

$$
H_0(z)=\frac18\xi\!\left(\frac12+\frac{iz}{2}\right),\qquad
\partial_tH_t=-\partial_z^2H_t.
\tag{1}
$$

This is the normalization in [Rodgers and Tao, equations (1)–(4)](https://arxiv.org/pdf/1801.05914). Real-zero preservation goes toward increasing $t$. De Bruijn proved that the full $H_t$ has only real zeros for $t\ge1/2$. Moving from there toward $t=0$ reverses that preservation direction. The integer cutoff $Q$ and the heat parameter $t$ are distinct variables.

The exact boundary cancellation follows from the classical theta transformation. Define

$$
\vartheta(x)=\sum_{k\in\mathbb Z}e^{-\pi k^2x},\qquad
\vartheta(x)=x^{-1/2}\vartheta(1/x),\qquad
V(u)=e^u\vartheta(e^{4u}).
$$

Then $V(-u)=V(u)$, and direct differentiation shows

$$
\Phi(u)=\frac{V''(u)-V(u)}{16}.
$$

Thus $\Phi$ is even and all its odd derivatives at zero vanish. The theta transformation follows from Poisson summation; see also [Newman and Wu, equation (4) and §2.1](https://arxiv.org/pdf/1901.06596).

On the other hand,

$$
g_n'(0)=-a_ne^{-a_n}(8a_n^2-30a_n+15).
$$

Consequently

$$
A_Q:=\Phi_Q'(0)
=\sum_{n>Q}a_ne^{-a_n}(8a_n^2-30a_n+15)>0.
\tag{2}
$$

Every summand on the right is positive, since $n>Q\ge1$ implies $a_n\ge4\pi$. In particular,

$$
A_{Q+1}=A_Q-a_{Q+1}e^{-a_{Q+1}}
(8a_{Q+1}^2-30a_{Q+1}+15),\qquad A_Q\downarrow0.
\tag{3}
$$

Multiplication by $e^{tu^2}$ leaves the first derivative at zero unchanged. More generally, for $j_m(t)=\partial_u^m(e^{tu^2}F(u))|_{u=0}$,

$$
\partial_tj_0=\partial_tj_1=0,\qquad
\partial_tj_m=m(m-1)j_{m-2}\quad(m\ge2).
\tag{4}
$$

The full kernel's vanishing odd derivatives are preserved in either time direction, whereas the finite cutoff's positive $A_Q$ cannot be removed by changing $t$.

## Raw cutoff theorem

**Theorem 1.** For every finite $Q\ge1$ and every real $t$, the entire function

$$
H_{t,Q}(z)=\int_0^\infty G_{t,Q}(u)\cos(zu)\,du,
\qquad G_{t,Q}(u)=e^{tu^2}\Phi_Q(u),
$$

has infinitely many nonreal zeros. Its Laguerre expression satisfies

$$
(H_{t,Q}'(x))^2-H_{t,Q}(x)H_{t,Q}''(x)
=-\frac{2A_Q^2}{x^6}+O_{t,Q}(x^{-8})
\quad(x\to+\infty).
\tag{5}
$$

**Proof.** All derivatives of $G_{t,Q}$ are integrable on the positive real axis and vanish at infinity. Integration by parts gives

$$
H_{t,Q}(x)=-\frac{G_{t,Q}'(0)}{x^2}
-\frac1{x^2}\int_0^\infty G_{t,Q}''(u)\cos(xu)\,du.
$$

Repeating this calculation yields

$$
H_{t,Q}(x)=-\frac{A_Q}{x^2}+\frac{B_{t,Q}}{x^4}+O_{t,Q}(x^{-6}),
\qquad B_{t,Q}=G_{t,Q}'''(0).
\tag{6}
$$

The expansion can be differentiated twice with the corresponding differentiated error bounds. This follows by applying integration by parts separately to the integrals for $H_{t,Q}^{(j)}$, whose kernels are $u^jG_{t,Q}(u)$, for $j=0,1,2$. In particular,

$$
H_{t,Q}'(x)=\frac{2A_Q}{x^3}+O(x^{-5}),\qquad
H_{t,Q}''(x)=-\frac{6A_Q}{x^4}+O(x^{-6}).
$$

Substitution proves (5).

For completeness, for fixed $t,Q$ the real kernel is bounded by $C e^{-c e^{4u}}$ for some $C,c>0$, after absorbing $e^{tu^2+9u}$ into half of its double-exponential decay. Thus, for $R\ge4$, its maximum modulus is at most

$$
\frac C4\int_1^\infty v^{R/4-1}e^{-cv}\,dv
\le\frac C4c^{-R/4}\Gamma(R/4).
$$

Stirling's estimate gives $\log M(R)=O_{t,Q}(R\log(R+2))$, hence order at most one. It is real and even. If its zeros were all real, its Hadamard product would give, away from its zeros,

$$
\frac{(H')^2-HH''}{H^2}=-(\log|H|)''
=\sum_r\frac{m_r}{(x-r)^2}\ge0,
\tag{7}
$$

where $r$ ranges over the real zeros with multiplicities $m_r$. This contradicts (5).

In fact (6) implies that only finitely many zeros are real. There must be infinitely many zeros in total: an entire function of order at most one with finitely many zeros has the form $e^{az+b}P(z)$; evenness forces $a=0$. It would then be a polynomial, incompatible with $H_{t,Q}(x)\to0$ and $H_{t,Q}(0)>0$. Thus infinitely many zeros are nonreal. ∎

## A positive even completion with an explicit error bound

For $0<\delta<\pi/8$, define

$$
\widetilde\Phi_{Q,\delta}(u)
=\Phi_Q\!\left(\sqrt{u^2+\delta^2}\right),\qquad
\widetilde H_{t,Q,\delta}(z)
=\int_0^\infty e^{tu^2}\widetilde\Phi_{Q,\delta}(u)\cos(zu)\,du.
\tag{8}
$$

The square root is positive for real $u$. This kernel is positive, even and real analytic on $\mathbb R$. Every odd derivative at zero vanishes. It uses the displayed theta summands, evaluated at $v=\sqrt{u^2+\delta^2}$. Its double-exponential decay makes $\widetilde H$ real even entire of order at most one. Entire continuation of the kernel itself is not required for this conclusion.

An explicit comparison with the full kernel is available. Set

$$
B=2\left(10e^9+\frac53e^5+8e^{13}\right),\qquad
m=Q+1,\qquad r_m=(1+1/m)^2e^{-\pi(2m+1)}<1.
$$

For $0\le t\le1/2$,

$$
\int_0^\infty(1+u^2)e^{tu^2}
|\widetilde\Phi_{Q,\delta}(u)-\Phi(u)|\,du
\le B\delta+\frac{3\pi m^2e^{-\pi m^2}}{1-r_m}.
\tag{9}
$$

To prove the smoothing part, use $0\le\sqrt{u^2+\delta^2}-u\le\delta<1$ and

$$
|g_n'(v)|\le e^{-a_ne^{4v}}
(30a_n^2e^{9v}+15a_ne^{5v}+8a_n^3e^{13v}).
$$

For $u\le v\le u+1$, the inequalities $e^{4u}\ge1+4u+8u^2$ and $a_n>3$ bound the weighted derivative integral by

$$
(30a_n^2e^9+15a_ne^5+8a_n^3e^{13})e^{-a_n}
\int_0^\infty(1+u^2)e^{u-23u^2}\,du.
$$

The integral is less than one: use $u\le u^2+1/4$ and integrate $(1+u^2)e^{1/4-22u^2}$. Also $\sum_{n\ge1}a_n^3e^{-a_n}<2$, for example by comparison with $27\sum_{n\ge1}n^6e^{-3n^2}$ and a geometric bound on its tail. The mean-value theorem now gives $B\delta$.

For the omitted theta terms, put $a=a_n$ and $b=4a-9\ge a$. Positivity and the same exponential inequality give

$$
\int_0^\infty(1+u^2)e^{tu^2}g_n(u)\,du
\le2a^2e^{-a}\left(\frac1b+\frac2{b^3}\right)
\le3ae^{-a}.
$$

The ratio of consecutive terms $n^2e^{-\pi n^2}$ for $n\ge m$ is at most $r_m$. Summing proves (9). In particular, the choice $\delta_Q=e^{-\pi(Q+1)^2}$ gives a bound of order $(Q+1)^2e^{-\pi(Q+1)^2}$, with an absolute constant.

## The completion still fails real-zero positivity

**Theorem 2.** For every finite $Q\ge1$, every $0<\delta<\pi/8$ and every real $t$, the completed transform in (8) has infinitely many nonreal zeros. Writing

$$
C_{t,Q,\delta}=A_Qe^{-t\delta^2}\sqrt{\frac{\pi\delta}{2}}>0,
$$

its large-real-argument asymptotics are

$$
\widetilde H_{t,Q,\delta}(x)
=-C_{t,Q,\delta}e^{-\delta x}x^{-3/2}
\left(1+O_{t,Q,\delta}(x^{-1})\right),
\tag{10}
$$

$$
(\widetilde H')^2-\widetilde H\widetilde H''
=-\frac32C_{t,Q,\delta}^{\,2}e^{-2\delta x}x^{-5}
\left(1+O_{t,Q,\delta}(x^{-1})\right).
\tag{11}
$$

**Proof.** Let $w(z)=\sqrt{z^2+\delta^2}$ be the branch positive on the real axis, with cuts along $i[\delta,\infty)$ and $-i[\delta,\infty)$. Although the completed kernel is analytic at every real point, it has a branch at $z=i\delta$. The coefficient causing this branch is exactly $A_Q$ from (2).

Choose $\delta<b<\pi/8$. In each half of the line $\operatorname{Im}z=b$, one has $\operatorname{Re}w(z)\sim|\operatorname{Re}z|$ at infinity and $|\operatorname{Im}w(z)|\le b$. Therefore $\cos(4\operatorname{Im}w(z))\ge\cos(4b)>0$, and the completed kernel decays doubly exponentially along that line, even after multiplication by $e^{tz^2}$ and any fixed polynomial in $z$.

For $\delta<v<b$, the right and left boundary values of $w(iv)$ are respectively $+i\sqrt{v^2-\delta^2}$ and $-i\sqrt{v^2-\delta^2}$. The corresponding jump of $e^{tz^2}\Phi_Q(w(z))$ is

$$
2i e^{-tv^2}\operatorname{Im}\Phi_Q\!\left(i\sqrt{v^2-\delta^2}\right).
$$

Apply Cauchy's theorem separately in the left and right half-strips. The real-line Fourier integral equals the two top-line integrals plus $i$ times the integral of the right-minus-left jump. Thus the jump contributes with a minus sign. Since the full Fourier integral is twice the cosine integral,

$$
\widetilde H_{t,Q,\delta}(x)
=-\int_\delta^b e^{-xv-tv^2}
\operatorname{Im}\Phi_Q\!\left(i\sqrt{v^2-\delta^2}\right)\,dv
+O_{t,Q,\delta,b}(e^{-bx}).
\tag{12}
$$

Small circles about the branch point contribute zero in the limit because the kernel is bounded there. The vertical boundaries at infinity vanish by the preceding decay bounds.

Put $s=v-\delta$. The Taylor expansion of the finite entire function $\Phi_Q$ gives

$$
e^{-t(\delta+s)^2}
\operatorname{Im}\Phi_Q\!\left(i\sqrt{2\delta s+s^2}\right)
=s^{1/2}\left(A_Qe^{-t\delta^2}\sqrt{2\delta}+c_1s+O(s^2)\right).
$$

Integrating this expansion against $e^{-xs}$ in (12), and using $\Gamma(3/2)=\sqrt\pi/2$, proves (10).

Here differentiated asymptotics do not follow merely by differentiating a bare $O$-term. Instead, inserting $(iz)^j$ in the contour integrals, or differentiating their absolutely convergent Laplace integrals, proves the corresponding expansions for $j=1,2$. More explicitly, after separating a fixed neighborhood of $s=0$, the normalized expansion has the form

$$
e^{\delta x}x^{3/2}\widetilde H(x)
=-C_{t,Q,\delta}\left(1+\frac{d_1}{x}+R(x)\right),
\qquad R^{(j)}(x)=O(x^{-2-j})\quad(j=0,1,2).
$$

These bounds follow by integrating the $s^{5/2}$ Taylor remainder and its Laplace moments; the remaining contour terms are exponentially smaller. Consequently

$$
(\log|\widetilde H(x)|)''=\frac{3}{2x^2}+O(x^{-3}).
$$

The identity $(H')^2-HH''=-H^2(\log|H|)''$ proves (11). This violates (7). Equation (10) gives only finitely many real zeros; the same order and Hadamard argument as in Theorem 1 gives infinitely many total zeros. Hence infinitely many are nonreal. ∎

## Mathematical use and scope

The completed kernels satisfy positivity, evenness, all odd endpoint cancellations and the quantitative approximation (9), but none has the real-zero property. The heat multiplier only changes the branch coefficient by $e^{-t\delta^2}$; it cannot eliminate the branch. For this completion class, elimination would require $\Phi_Q(iv)=\Phi_Q(-iv)$ near zero, contrary to $A_Q>0$.

The completions with $\delta_Q\to0$ also converge to the full transform locally uniformly in the complex Fourier variable. This follows by the same estimates with the additional factor $e^{R u}$ on a compact set $|z|\le R$; double-exponential decay still dominates. At $t\ge1/2$, where the full transform has only real zeros, nonreal zeros of these approximants can therefore escape to infinity or approach the real axis. Their existence does not imply a nonreal zero of the limit.

The Laguerre inequality (7) is classical; see [Csordas, equation (2.1) and Theorem 2.4](https://arxiv.org/pdf/1309.0055). The differentiated asymptotics above establish its failure, while the main nonreal-zero conclusion already follows from the undifferentiated asymptotic and Hadamard factorization.

The relevant classical mechanisms are Pólya's universal factors and de Bruijn's real-zero theorems for special even kernels, including $e^{-a\cosh u}$ with $a>0$. They require additional analytic structure beyond evenness and positivity. See [de Bruijn, *The roots of trigonometric integrals*, Duke Mathematical Journal 17 (1950), 197–226](https://repository.tudelft.nl/file/File_524a4d3c-0858-4c55-b425-8c8ce1fb89da) and the explicit statements in [Newman–Wu, §§2.2–2.3](https://arxiv.org/pdf/1901.06596). [Newman's 1976 theorem](https://sites.math.northwestern.edu/~auffing/papers/Newman.pdf) and [Rodgers–Tao's lower bound](https://arxiv.org/pdf/1801.05914) concern the full heat family and do not provide preservation toward decreasing heat time.

[Newman and Wu, §3.2.1, Case 3 and Proposition 19](https://arxiv.org/pdf/1901.06596) already give even measures with every Gaussian exponential moment finite but with no real heat parameter producing only real zeros. Their construction uses atomic measures and weak limits. The present proof supplies the explicit endpoint and square-root-branch calculation for these theta cutoff families; it does not claim the general phenomenon is new.

These are obstruction theorems for two specified approximation families. They identify a branch cancellation that a different completion would have to address. They establish neither a nonreal zero of the actual Riemann xi function nor a new bound on its de Bruijn–Newman constant. No claim of mathematical novelty or Lean formalization is made.
