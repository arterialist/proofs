# The inverse-theta weighted metric does not symmetrize the theta pencil

**Status.** This is an unconditional obstruction for one natural singular
target metric in [Hedenmalm's actual theta pencil](https://arxiv.org/html/2606.17494),
on the span of its actual real-zero eigenfunctions. It gives no estimate for
off-line zeros and does not prove the Riemann hypothesis.

Use logarithmic coordinates and write

\[
 K(x)=\varTheta_{00}(ie^{2x})>0,\qquad
 p(x)=-\frac{K'(x)}{K(x)},\qquad
 A=-iK\partial_x(\,\cdot\,/K).
\]

For each real zero \(\Xi(\alpha)=0\), Hedenmalm's eigenfunction is

\[
 u_\alpha(x)=e^{-i\alpha x}\int_{-\infty}^{x}e^{i\alpha y}K(y)\,dy.
\]

The inverse-theta weighted target form is

\[
 q_w(u,v)=\int_{\mathbb R}\frac{(Au)\overline{(Av)}}{K^2}\,dx
 =\int_{\mathbb R}(u/K)'\,\overline{(v/K)'}\,dx. \tag{1}
\]

It is positive on the diagonal and is well-defined on every finite span of
real-zero eigenfunctions. Its weight grows too rapidly at the endpoints to
be covered by the bounded-target obstruction in the
[unweighted metric note](hedenmalm-theta-natural-l2-real-zero-obstruction.md).

**Theorem.** As \(\alpha\to+\infty\) through real zeros of \(\Xi\),

\[
 \alpha^2q_w(u_\alpha,u_{-\alpha})\longrightarrow-\frac23,
 \qquad
 \alpha^2q_w(u_\alpha,u_\alpha)\longrightarrow2. \tag{2}
\]

Consequently this positive target metric fails the pair-symmetry condition
of Hedenmalm's Definition 4.2.1 already on the real-zero eigenfunction span.
The negative number in (2) is an off-diagonal Gram entry, not a negative
norm.

*Proof.* Put \(h_\alpha=u_\alpha/K\). Since \(\Xi(\alpha)=0\), the
lower-tail integral defining \(u_\alpha\) equals minus the upper tail.
For \(x\in\mathbb R\), set
\(F_x(s)=K(x+s)/K(x)\) for \(s\ge0\). Differentiation gives the exact
identities

\[
 h_\alpha(x)=-\int_0^\infty e^{i\alpha s}F_x(s)\,ds,
 \qquad
 h_\alpha'(x)=\int_0^\infty e^{i\alpha s}
       [p(x+s)-p(x)]F_x(s)\,ds. \tag{3}
\]

The evenness of the theta kernel and the zero condition imply
\(h_\alpha(-x)=-\overline{h_\alpha(x)}\), so
\(h_\alpha'(-x)=\overline{h_\alpha'(x)}\). Also
\(h_{-\alpha}=\overline{h_\alpha}\). Therefore

\[
 q_w(u_\alpha,u_{-\alpha})
   =2\operatorname{Re}\int_0^\infty(h_\alpha'(x))^2\,dx,
 \qquad
 q_w(u_\alpha,u_\alpha)=2\int_0^\infty|h_\alpha'(x)|^2\,dx. \tag{4}
\]

The actual theta series is
\[
 K(x)=\pi e^{9x/2}\sum_{n\ge1}n^2
       (2\pi n^2-3e^{-2x})e^{-\pi n^2e^{2x}}.
\]
Its \(n=1\) term dominates with a double-exponentially small relative
remainder. Thus, as \(x\to+\infty\),

\[
 p(x)=2\pi e^{2x}-\frac92+O(e^{-2x}),\qquad
 p^{(j)}(x)=2^j(2\pi)e^{2x}+O_j(e^{-2x})\quad(j=1,2). \tag{5}
\]

Choose \(x_0\) so that \(P=p(x)\ge8\) and \(p\) is increasing for
\(x\ge x_0\). Uniformly for \(s\ge0\) in this region,
\(p^{(j)}(x+s)=O(Pe^{2s})\) for \(j=0,1,2\),
\(0\le p(x+s)-P\ll P(e^{2s}-1)\), and
\(F_x(s)\le e^{-Ps}\). Taking absolute values in (3) yields
\(|h_\alpha'(x)|\ll P^{-1}\); the first identity of (3) also gives
\(|h_\alpha(x)|\le P^{-1}\). Reflection proves that the form (1) is
finite on the stated span.

Oscillation is needed where \(P\ll\alpha\). Let
\(G_x(s)=[p(x+s)-P]F_x(s)\). Then \(G_x(0)=0\),
\(G_x'(0)=p'(x)\), and

\[
 G_x''(s)=\bigl(p''(x+s)-2p'(x+s)p(x+s)
 -[p(x+s)-P]p'(x+s)
 +[p(x+s)-P]p(x+s)^2\bigr)F_x(s).
\]

The four terms, integrated against \(e^{-Ps}\), are bounded in order by
constant multiples of
\[
 \frac{P}{P-2},\quad \frac{P^2}{P-4},\quad
 P^2\left(\frac1{P-4}-\frac1{P-2}\right),\quad
 P^3\left(\frac1{P-6}-\frac1{P-4}\right).
\]
Their sum is \(O(P)\) for \(P\ge8\), so
\(\int_0^\infty|G_x''(s)|\,ds\ll P\).
The double-exponential theta tail makes \(G_x(s)\) and \(G_x'(s)\)
vanish at infinity. Two integrations by parts in (3) therefore give

\[
 |h_\alpha'(x)|\ll\frac{P}{\alpha^2},\qquad
 |\alpha h_\alpha'(x)|\ll
       \min\!\left(\frac{P}{\alpha},\frac{\alpha}{P}\right)
       \quad(x\ge x_0). \tag{6}
\]

For \(0\le x\le x_0\), the same integration-by-parts argument has a
uniformly integrable \(G_x''\), by the double-exponential theta tail.
Hence \(h_\alpha'=O_{x_0}(\alpha^{-2})\) there; after multiplying the
integrals in (4) by \(\alpha^2\), this compact interval disappears.

Now set \(X_\alpha=\frac12\log(\alpha/(2\pi))\) and
\(x=X_\alpha+r\). For fixed real \(r\), (5) gives
\(p(x)/\alpha\to t=e^{2r}\) and \(p'(x)/\alpha\to2t\).
Rescale \(s=v/\alpha\) in (3). For fixed \(r\), eventually
\(F_x(v/\alpha)\le e^{-tv/2}\) and
\(p(x+v/\alpha)-p(x)\ll_t v e^{2v/\alpha}\).
Taking \(\alpha\) large enough that \(2/\alpha<t/4\) supplies an
integrable multiple of \(v e^{-tv/4}\). Dominated convergence yields

\[
 \alpha h_\alpha'(X_\alpha+r)
 \longrightarrow 2t\int_0^\infty v e^{-(t-i)v}\,dv
 =\frac{2t}{(t-i)^2}. \tag{7}
\]

This convergence can also be passed through the \(r\)-integral:
\(P/\alpha\asymp e^{2r}\) for \(x\ge x_0\), so (6) gives the
integrable majorant
\(|\alpha h_\alpha'(X_\alpha+r)|^2
 \ll\min(e^{4r},e^{-4r})\), extending the integrand by zero below
\(x_0-X_\alpha\). The elementary integrals in (4), with
\(t=e^{2r}\), are then

\[
 4\operatorname{Re}\int_0^\infty\frac{t}{(t-i)^4}\,dt=-\frac23,
 \qquad
 4\int_0^\infty\frac{t}{(1+t^2)^2}\,dt=2.
\]

This proves (2). Hardy's theorem supplies unbounded positive real zeros,
and the negative zero \(-\alpha\) is distinct. At such a pair, the pencil
equation gives \(ADu_\alpha=-\alpha Au_\alpha\) and
\(ADu_{-\alpha}=\alpha Au_{-\alpha}\). Pair symmetry would force the
first Gram entry of (2) to be zero, which it is not for sufficiently high
zeros. \(\square\)

This result excludes the specific \(K^{-2}\) target metric. It does not
exclude more general singular, nonlocal, or zero-span-specific metrics, nor
does it supply the missing arithmetic inequality needed for RH.
