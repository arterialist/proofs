# Zero-free half-plane for the first boundary-sine Mellin multiplier

Define the entire function
\[
K(s)=\int_1^2 t^{s-1}\sin\!\bigl(\pi(t-1)\bigr)\,dt.
\]

**Proposition.** \(K(s)\ne0\) whenever \(\Re s\ge1/2\).

Let \(L=\log2\) and \(s=\sigma+i\tau\). Two integrations by parts, using the vanishing of the sine at both endpoints, give the exact recurrence
\[
s(s+1)K(s)+\pi^2K(s+2)=\pi(1+2^{s+1}). \tag{1}
\]

For low heights, write \(K(s)=\int_0^L e^{sx}g(x)\,dx\), where \(g(x)=\sin(\pi(e^x-1))\). If \(0<x<L/2\), set \(t=e^x\), \(a=t-1\), and \(b=2/t-1\). The inequalities \(t^2<2\) and \(t+2/t<3\) give \(0<a<b<1-a<1\), hence \(g(L-x)>g(x)\). Since \(\sigma\ge0\), the reflected density \(e^{\sigma(L-x)}g(L-x)\) is strictly larger than \(e^{\sigma x}g(x)\). Pairing \(x\) with \(L-x\) shows
\[
\Im\!\left(e^{-i\tau L/2}K(\sigma+i\tau)\right)
=\int_0^{L/2}\!\left[e^{\sigma(L-x)}g(L-x)-e^{\sigma x}g(x)\right]
\sin\!\left(\tau(L/2-x)\right)dx>0
\]
for \(0<\tau\le2\pi/L\). At \(\tau=0\), \(K(\sigma)>0\); negative heights follow by conjugation.

For higher heights, put \(F_\alpha(x)=e^{\alpha x}g(x)\) and \(M_\alpha=\max_{[0,L]}F_\alpha\). For \(\alpha=\sigma+2>0\), the logarithmic derivative in \(t=e^x\) is \(\alpha/t+\pi\cot(\pi(t-1))\), strictly decreasing from \(+\infty\) to \(-\infty\). Thus \(F_\alpha\) rises once and falls once, with total variation \(2M_\alpha\). Integration by parts in the Fourier integral gives
\[
|K(s+2)|\le\frac{2M_{\sigma+2}}{|\tau|}. \tag{2}
\]

We use \(\sin(\pi u)\le4u(1-u)\) for \(0\le u\le1\). To prove it, set \(v=|u-1/2|\). The function \(q(v)=1-4v^2-\cos(\pi v)\) vanishes at \(0\) and \(1/2\); its second derivative \(\pi^2\cos(\pi v)-8\) changes sign exactly once from positive to negative. Since \(q'(0)=0\), this gives \(q(v)\ge0\) throughout. Differentiating \(4t^{5/2}(t-1)(2-t)\) gives its unique maximum at \(t=5/3\), whence
\[
M_{5/2}\le\frac89\left(\frac53\right)^{5/2}<\frac{16}{5},
\qquad
M_{\sigma+2}<\frac{16}{5}\,2^{\sigma-1/2}
\quad(\sigma\ge1/2). \tag{3}
\]
The strict numerical inequality follows by squaring and comparing \(5{,}000{,}000<5{,}038{,}848\).

Suppose \(K(s)=0\). Equation (1) would give \(\pi|K(s+2)|=|1+2^{s+1}|\). Set \(y=2^{\sigma-1/2}\ge1\). If \(2\pi/L\le|\tau|\le5\pi/(2L)\), then \(\cos(\tau L)\ge0\), so the right side is at least \(2\sqrt2\,y\), whereas (2)–(3) make the left side less than \((16L/5)y<2\sqrt2\,y\). If \(|\tau|\ge5\pi/(2L)\), the right side is at least \(2\sqrt2\,y-1\), whereas the left side is less than \((64L/25)y\). The latter is smaller because \(2\sqrt2-64L/25>1\); for example \(\sqrt2>7/5\) and \(L<7/10\) suffice. Both cases contradict \(K(s)=0\), completing the proof.

The multiplier belongs to the *actual* first boundary-sine prime sum. For real \(X\ge1\), with every prime power retained, set
\[
T_1(X)=\sum_{X<n\le2X}\Lambda(n)\sin\!\left(\pi\left(\frac nX-1\right)\right)-\frac{2X}{\pi}.
\]
Absolute convergence for \(\Re s>1\) and the substitution \(t=n/X\) give
\[
\int_1^\infty T_1(X)X^{-s-1}\,dX
=K(s)\left(-\frac{\zeta'(s)}{\zeta(s)}\right)-\frac{2/\pi}{s-1}. \tag{4}
\]

The proposition removes a possible *kernel* zero in the critical strip. It supplies no bound on \(T_1(X)\), no new estimate for \(\psi(X)-X\), and no proof of the Riemann hypothesis. In particular, a bound known only at dyadic \(X\) does not by itself provide continuous-scale Mellin continuation; logarithmic frequencies can alias at dyadic samples.
