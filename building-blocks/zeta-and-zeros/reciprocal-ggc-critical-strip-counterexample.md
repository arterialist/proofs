# A reciprocal GGC law with explicit off-line Mellin zeros in the critical strip

[Biane, Pitman, and Yor's gamma-convolution variable](https://arxiv.org/html/math/9912170) \(T\) has Mellin transform
\(E[T^s]=2\xi(2s)\), is a generalized gamma convolution (GGC), and obeys
\(E[g(T^{-1})]=E[T^{1/2}g(T)]\). These facts alone do not locate its Mellin
zeros. The following density has the same GGC and reciprocal properties,
but its Mellin transform has explicit zeros inside \(0<\Re s<1/2\) away
from \(\Re s=1/4\). This is a class-level counterexample, not a statement
about the zeros of \(\xi\).

Set \(a=\log 2\), \(p=1/5\), \(r_1=2\cosh a=5/2\), and
\(r_2=2\cosh(2a)=17/4\). Let \(T\) have density

\[
 f(x)=\frac{C x^{-5/4}}
 {(x^p+x^{-p}+r_1)(x^p+x^{-p}+r_2)},\qquad x>0.
 \tag{1}
\]

Here \(C>0\) normalizes its integral. At zero this is
\(O(x^{-17/20})\), and at infinity it is \(O(x^{-33/20})\), so \(C\)
exists. Each denominator is invariant under inversion. Hence

\[
 f(x)=x^{-5/2}f(1/x),\qquad
 E[g(T^{-1})]=E[T^{1/2}g(T)],\qquad
 M(s):=E[T^s]=M(1/2-s).
 \tag{2}
\]

## GGC property

Write \(H_r(x)=(x+x^{-1}+r)^{-1}\) for \(r\ge2\). For
\(U=u+u^{-1}\) and \(w=v+v^{-1}\), direct multiplication gives

\[
 \begin{aligned}
 &(uv+(uv)^{-1}+r)(u/v+v/u+r)\\
 &\quad=w^2+rUw+U^2+r^2-4
       =(w+\lambda_+)(w+\lambda_-),\\
 &\lambda_\pm=
 \frac{rU\pm\sqrt{(r^2-4)(U^2-4)}}2>0.
 \end{aligned}
 \tag{3}
\]

Thus \(H_r(uv)H_r(u/v)\) is completely monotone as a function of \(w\),
and \(H_r\) is hyperbolically completely monotone (HCM). Products,
multiplication by \(x^q\) for real \(q\), and composition with
\(x\mapsto x^p\) for \(0<p\le1\) preserve the HCM property. Equation
(1) is consequently an HCM density. By Bondesson's inclusion of HCM
densities in the GGC class, this *same* random variable \(T\) is GGC.
The class facts are stated, with references to Bondesson, in
[Pakes, *Structural properties of generalised Planck distributions*,
Proof of Theorem 12](https://link.springer.com/article/10.1186/s40488-021-00124-1).

## Exact Mellin transform and zeros

Put \(D_b(y)=2\cosh y+2\cosh b\), and

\[
 J(z)=\int_{\mathbb R}
 \frac{e^{zy}}{D_a(y)D_{2a}(y)}\,dy,
 \qquad |\Re z|<2.
\]

For \(-1<\Re z<0\), substitute \(x=e^y\), decompose
\((x+e^b)^{-1}(x+e^{-b})^{-1}\) into partial fractions, and use
\(\int_0^\infty t^z/(1+t)\,dt=-\pi/\sin(\pi z)\). Analytic continuation
within \(|\Re z|<1\) gives

\[
 \int_{\mathbb R}\frac{e^{zy}}{D_b(y)}\,dy
 =\frac{\pi\sinh(bz)}{\sinh b\sin(\pi z)}.
 \tag{4}
\]

Since
\(1/(D_aD_{2a})=(1/D_a-1/D_{2a})/(r_2-r_1)\), equation (4) yields

\[
 \begin{aligned}
 J(z)
 &=\frac{\pi}{(r_2-r_1)\sin(\pi z)}
 \left(\frac{\sinh(az)}{\sinh a}
       -\frac{\sinh(2az)}{\sinh(2a)}\right)\\
 &=\frac{\pi\sinh(az)}
 {(r_2-r_1)\sinh a\sin(\pi z)}
 \left(1-\frac{\cosh(az)}{\cosh a}\right).
 \end{aligned}
 \tag{5}
\]

The integral defining \(J\) is analytic for \(|\Re z|<2\), so (5)
continues there through its removable singularities at \(z=0,\pm1\).
The Mellin transform of (1) is

\[
 M(s)=\frac{C}{p}J\!\left(\frac{s-1/4}{p}\right),
 \qquad -\frac3{20}<\Re s<\frac{13}{20}.
 \tag{6}
\]

For every nonzero integer \(k\), the points
\(z=\pm1+2\pi i k/a\) make the final factor in (5) vanish, while
\(\sinh(az)\) and \(\sin(\pi z)\) are nonzero. The zeros are simple,
because the derivative of that factor is
\(-a\sinh(az)/\cosh a\ne0\). Therefore

\[
 \boxed{
 s=\frac1{20}+\frac{2\pi i k}{5\log2}
 \quad\text{or}\quad
 s=\frac9{20}+\frac{2\pi i k}{5\log2},
 \qquad k\in\mathbb Z\setminus\{0\}.}
 \tag{7}
\]

Both families lie inside \(0<\Re s<1/2\), away from the symmetry line
\(\Re s=1/4\).

The polynomial tails of (1) limit its Mellin convergence strip. An
entire-Mellin variant is obtained by multiplying its unnormalized density
by \(e^{-\varepsilon(x+x^{-1})}\) and renormalizing. This factor preserves
HCM and (2), while giving all positive and negative moments. As
\(\varepsilon\downarrow0\), the Mellin transforms converge locally
uniformly in the strip of (6). The zeros in (7) are simple, so Rouché's
theorem on a small disk around any one of them proves that, for every
sufficiently small \(\varepsilon>0\), the entire Mellin transform still
has a zero inside \(0<\Re s<1/2\) away from \(\Re s=1/4\). No explicit
threshold for \(\varepsilon\) is asserted.

The example does not establish additive Pólya-frequency total positivity
or the special \(n^2\) Thorin spectrum of the BPY law. Those additional
features would need their own argument. It strengthens the scope of the
[finite gamma symmetrization counterexample](finite-gamma-mellin-symmetrization-counterexample.md):
reciprocity and GGC hold for one law, and its off-line zeros lie in the
zeta-style strip. It gives no unconditional zeta or prime-error bound.
