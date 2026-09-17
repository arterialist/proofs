# The first new prime atom beyond Zhu's compact window

[Zhu's version 2 certificate](https://arxiv.org/html/2608.24827v2)
proves \(Q(f)\geq 8.9\cdot10^{-18}\|f\|_2^2\) for arbitrary complex
tests supported in \([-0.8,0.8]\). This note computes the exact first
new prime interaction and tests whether his one-stroke reduction with
frequency cutoff \(T=200\) can be carried unchanged across it. The
answer for that reduction is no. The calculation makes **no claim**
that the full Weil form has a negative direction.

## Normalization and threshold

For \(f\in C_c^\infty((-L,L);\mathbb C)\), set

\[
 F(t)=\int f(x)e^{itx}\,dx,\quad
 E_\pm(f)=\int f(x)e^{\pm x/2}\,dx,\quad
 c_n=\frac{2\Lambda(n)}{\sqrt n},\quad d_n=\log n.
\]

The geometric Weil form in Zhu's normalization, with the complex pole
written explicitly, is

\[
 Q_L(f)=2\operatorname{Re}\bigl(E_+(f)\overline{E_-(f)}\bigr)
 +\frac1{2\pi}\int_{\mathbb R}|F(t)|^2
 \left[H(t)-\sum_{d_n<2L}c_n\cos(td_n)\right]dt,
 \quad H(t)=\operatorname{Re}\psi(\tfrac14+\tfrac{it}{2})-\log\pi.
 \tag{1}
\]

Zhu's displayed rank-one pole formula is for real even tests; his
Section 6 supplies the odd sign and complex splitting. The equivalent
complex normalization is also written directly in
[Liu's later manuscript](https://github.com/luciferyu666/certified-weil-positivity/blob/b6cd2183c1e79c6c27a34267812a7b2d73ed1b59/frozen-source/publication/manuscript.tex).
The prime sum retains every von Mangoldt atom admitted by the support.

At \(L=0.8\) the admitted prime powers are \(2,3,4\). The next one is
\(5\), at

\[
 b=\tfrac12\log5=0.804718956\ldots,
 \qquad c_5=\frac{2\log5}{\sqrt5}=1.439525031\ldots .
 \tag{2}
\]

For \(b<L<\tfrac12\log7\), the prime list is exactly \(2,3,4,5\).
At \(L=b\), the endpoint autocorrelation at \(\log5\) is zero, so the
term starts continuously on each fixed test.

## Exact boundary-strip operator

Put \(d=\log5\) and \(w=2L-d>0\). Parseval gives the **new** term

\[
 -c_5\operatorname{Re}\int_{-L}^{L-d}
       f(x+d)\overline{f(x)}\,dx.
 \tag{3}
\]

It couples the left strip \(I_-=[-L,L-d]\) to the right strip
\(I_+=[d-L,L]\); both have width \(w\). For \(b<L<d\) they are
disjoint. Translation by \(d\) is a unitary map
\(V:L^2(I_-)\to L^2(I_+)\). On their direct sum, the self-adjoint
operator represented by (3) has block matrix

\[
 -\frac{c_5}{2}
 \begin{pmatrix}0&V^*\\ V&0\end{pmatrix}.
 \tag{4}
\]

Its norm is exactly \(c_5/2\) for every \(b<L<\log5\), however
small \(w>0\) becomes. Thus shrinking
the overlap to zero does not make this prime perturbation small in
operator norm. This is a statement about the prime-shift operator;
the full form also contains the archimedean frequency cost of
concentrating inside narrow strips.

## Failure of the unchanged \(T=200\) reduction

Let \(A_L=\sum_{d_n<2L}c_n\) and

\[
 \beta_{L,T}=\log\frac{T}{2\pi}-\frac1T-A_L,
 \qquad \Psi_L(t)=H(t)-\sum_{d_n<2L}c_n\cos(td_n).
 \tag{5}
\]

Zhu's high-frequency envelope implies \(Q_L\geq R_{L,T}\) on the
legal smooth domain, where

\[
 R_{L,T}(f)=\beta_{L,T}\|f\|_2^2
 +2\operatorname{Re}\bigl(E_+(f)\overline{E_-(f)}\bigr)
 +\frac1{2\pi}\int_{-T}^{T}
      (\Psi_L(t)-\beta_{L,T})|F(t)|^2\,dt.
 \tag{6}
\]

His positive certificate at \(L=0.8\) uses \(T=200\) in the even
sector, with \(\beta_{0.8,200}=0.5134667749\ldots\). Immediately
after \(5\) enters,

\[
 \beta_{L,200}
   =\beta_{0.8,200}-c_5
   =-0.9260582561\ldots<0
   \qquad (b<L<\tfrac12\log7).
 \tag{7}
\]

On \(L^2(-L,L)\), the pole operator in (6) has rank at most two.
The finite-band multiplier has a continuous kernel on a compact
square and is Hilbert--Schmidt. Therefore \(R_{L,200}\) is
\(\beta_{L,200}I\) plus a compact operator. Its essential spectrum
contains the negative number in (7), and it has no positive lower
bound. More concretely, for any fixed normalized
\(h\in C_c^\infty((-L,L))\), the modulated tests
\(f_j(x)=h(x)e^{ijx}\) satisfy

\[
 R_{L,200}(f_j)\longrightarrow\beta_{L,200}<0.
 \tag{8}
\]

The pole and finite-band terms vanish by Fourier translation and the
Riemann--Lebesgue lemma. The **full** \(Q_L(f_j)\), however, retains
the omitted gamma tail; its archimedean contribution grows like
\(\log j\), while the finite prime terms remain bounded. Hence (8)
is a failure of this \(T=200\) lower comparison as a positivity
certificate, not a counterexample to Weil positivity.

A positive scalar tail floor from the same pointwise envelope first
requires \(T\) above the root of
\(\log(T/(2\pi))-1/T=A_L\), approximately \(503.39\) in this
four-atom cell. A certificate using that scalar pointwise envelope
therefore needs the larger frequency range. A different estimate could
retain the discarded tail or exploit the exact prime-shift structure.

## Scope and later literature

The argument proves a precise obstruction to **carrying Zhu's
\(T=200\) reduction unchanged** across the \(5\)-atom threshold. It
does not bound the lowest eigenvalue of \(Q_L\) there.

[Liu's 15 September 2026 preprint](https://www.alphaxiv.org/abs/2609.weil-positivity-riemann-zeta-bounds)
reports computer-assisted coercivity at \(L=1\) and \(L=17/16\), with
all admitted prime powers retained. Its author provides a
[frozen reproduction release](https://github.com/luciferyu666/certified-weil-positivity/releases/tag/v1.0-mcom-submission)
and states that external independent reproduction and peer review have
not yet been completed. Those claims, if verified, pass well beyond
Zhu's \(0.8\) window. The present note does not audit their finite
certificates.
