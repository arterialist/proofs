# Strict original-energy decrease for the actual prime-two source

For the smallest natural cutoff $N=2$, admit the prime $2$ with all its powers. The complete actual anticausal comparison satisfies
$$
\boxed{\mathcal E(y_-^C)-\mathcal E(y_-)<-1/10.}
 \tag{1}
$$
This proves the sign of the integrated quadratic change in the same example whose drift curvature contains derivatives of Dirac masses. That distributional obstruction does not prevent a strictly negative full pairing here.

We use the [actual finite-history conventions](actual-finite-history-curvature-domains.md) and the [original energy and contact forms](all-prime-fixed-source-drift-curvature.md). The age map $Uf(v)=e^{v/2}f(e^v)$ is unitary. All physical outputs below are supported on $x>0$, extended by zero to $x\le0$. In particular the physical interval $0<x<1$, corresponding to negative ages, is retained throughout.

## 1. Both actual inputs and every prime-two power

Put
$$
L=\log2,\qquad A=2-L,\qquad
 \kappa=\kappa_2
 =2\sqrt2-1-\frac L{\sqrt2}-\frac{\pi A}{4}>0.
 \tag{2}
$$
The two literal source functions are
$$
g(x)=\begin{cases}0,&x<1,\\-1,&1\le x<2,\\-A/x,&x\ge2,\end{cases}
\qquad
 h(x)=Cg(x)=\mathbf1_{x\ge1}\left[-\frac A{x+1}-\frac\kappa x\right].
 \tag{3}
$$
Thus both the initial source boundary and the actual jump at $x=2$ remain in $g$. The compensation in $h$ uses its exact finite-source charge (2), not the different complete-source charge.

For either input the full anticausal response is
$$
Y_f(x)=\frac12 f(2x)-\frac12\sum_{k\ge2}f(2^kx).
 \tag{4}
$$
These series converge absolutely for every $x>0$. They also converge in physical $L^2$, since $g,h\in L^2$ and $\|f(2^k\,\cdot)\|_2=2^{-k/2}\|f\|_2$. The age outputs in (1) are $y_-=UY_g$ and $y_-^C=UY_h$. We evaluate their original energy by using $Y_g,Y_h$ directly in physical coordinates.

## 2. Exact old energy

For $x\ge1$, the geometric tail in (4) cancels its first term exactly, giving $Y_g(x)=0$. For $1/2\le x<1$,
$$
Y_g(x)=-\frac12+\frac A{4x}.
 \tag{5}
$$
For $j\ge2$ and $2^{-j}\le x<2^{1-j}$, put $z=2^jx\in[1,2)$. The first activated power is $k=j$, including the initial jump of $g$, and all higher powers give
$$
Y_g(x)=\frac12+\frac A{2z}.
 \tag{6}
$$
Since $\sum_{j\ge2}2^{-j}=1/2$, exact integration yields
$$
\int_0^\infty Y_g(x)\,dx=\frac{AL}{2},
\qquad
 \|Y_g\|_2^2=\frac14+\frac{A^2}{8}.
 \tag{7}
$$
For example, the two regions in the squared norm contribute
$$
\int_{1/2}^1Y_g^2=\frac18-\frac{AL}{4}+\frac{A^2}{16},
\qquad
 \int_0^{1/2}Y_g^2=\frac18+\frac{AL}{4}+\frac{A^2}{16}.
$$
Their cancellation keeps every negative-age interval, not just a finite selection.

The original energy is
$$
\mathcal E(f)
 =\int_0^1\|\Delta_h f\|_2^2\,dh
 +\int_1^\infty\|\Delta_h f\|_2^2\,\frac{dh}{h^2}
 =4\|f\|_2^2-\iint K(x-y)f(x)f(y)\,dx\,dy,
$$
$$
K(u)=\min(1,|u|^{-2}).
 \tag{8}
$$
As $Y_g$ is supported in $[0,1]$, the kernel in its double integral is identically one. Hence
$$
\boxed{\mathcal E(Y_g)
 =1+\frac{A^2}{2}-\frac{A^2L^2}{4}
 >1.648795.}
 \tag{9}
$$

## 3. Exact new output and its positivity

Define
$$
R(z)=\sum_{k\ge0}\frac1{1+2^kz},\qquad z\ge1.
$$
For $j\ge2$, $2^{-j}\le x<2^{1-j}$, and $z=2^jx$, formula (4) gives exactly
$$
Y_h(x)=F(z),\qquad F(z)=\frac A2R(z)+\frac\kappa z.
 \tag{10}
$$
Thus $F$ is positive and decreasing on $[1,2]$, and
$$
\int_0^{1/2}Y_h(x)^2\,dx
 =\frac12\int_1^2F(z)^2\,dz.
 \tag{11}
$$

For $x\ge1/2$, the full $-\kappa/x$ contribution in (4) cancels geometrically, leaving
$$
Y_h(x)=\frac A2D(2x),\qquad
 D(z)=\sum_{k\ge1}\frac1{1+2^kz}-\frac1{1+z}.
 \tag{12}
$$
Retaining the entire sum, use $\sum_{k\ge1}2^{-k}=1$ to obtain
$$
D(z)=\sum_{k\ge1}
 \left[\frac1{1+2^kz}-\frac{2^{-k}}{1+z}\right]
 =\sum_{k\ge1}
 \frac{1-2^{-k}}{(1+z)(1+2^kz)}>0.
 \tag{13}
$$
Moreover
$$
D(z)\le\frac1{z(1+z)}
       \sum_{k\ge1}(2^{-k}-4^{-k})
 =\frac2{3z(1+z)}.
$$
Consequently the new output is nonnegative everywhere and has the global bound
$$
0\le Y_h(x)\le\frac A{6x(1+2x)}
 \qquad(x\ge1/2).
 \tag{14}
$$
Its whole unbounded tail therefore satisfies
$$
\int_{1/2}^\infty Y_h(x)^2\,dx
 \le\frac{A^2}{18}\int_1^\infty\frac{dz}{z^2(1+z)^2}
 =\frac{A^2}{18}\left(\frac32-2L\right).
 \tag{15}
$$
There is no finite physical-window cutoff in this estimate.

## 4. A finite rigorous bound for the remaining integral

For $J\ge1$, the omitted prime-two powers obey, uniformly on $1\le z\le2$,
$$
0\le R(z)-\sum_{k=0}^{J-1}\frac1{1+2^kz}
 \le\frac{2^{1-J}}z.
$$
Set
$$
F_J^+(z)=
 \frac A2\sum_{k=0}^{J-1}\frac1{1+2^kz}
 +\frac{\kappa+A2^{-J}}z.
 \tag{16}
$$
Then $0<F(z)\le F_J^+(z)$. Since $F$ is decreasing, a left-endpoint sum with $M$ equal cells gives
$$
\frac12\int_1^2F(z)^2\,dz
 \le\frac1{2M}\sum_{i=0}^{M-1}
 \left[F_J^+\left(1+\frac iM\right)\right]^2.
 \tag{17}
$$
This is an inequality with analytic tail control, rather than an unbounded quadrature approximation.

The accompanying [prime-two-anticausal-energy.py](certificates/prime-two-anticausal-energy.py) evaluates (2), (9), and (15)–(17) using 192-bit Arb balls, with $J=16$ and $M=64$. Its strict outward enclosures give
$$
\int_0^{1/2}Y_h^2<0.374738,\qquad
 \int_{1/2}^\infty Y_h^2<0.010789,
$$
and, using the tighter balls directly,
$$
\boxed{4\|Y_h\|_2^2<1.542105.}
 \tag{18}
$$

Finally, positivity of $Y_h$ and the original pointwise positive kernel $K$ makes the double integral in (8) nonnegative. Therefore
$$
\mathcal E(Y_h)\le4\|Y_h\|_2^2.
 \tag{19}
$$
This step does not assume that convolution by $K$ is positive on all signed functions. It uses the proved sign of this particular complete output.

Combining (9) and (18)–(19), the certificate proves
$$
\mathcal E(Y_h)-\mathcal E(Y_g)
 \le 4\|Y_h\|_2^2-
       \left(1+\frac{A^2}{2}-\frac{A^2L^2}{4}\right)
 <-0.10669<-1/10.
 \tag{20}
$$
This establishes (1) for the full quadratic increment. It neither deletes the midpoint cross term nor estimates only the first variation.

The example has a strict original-energy decrease even though its drift curvature is not a nonnegative measure. It tests the integrated mechanism on the specified actual finite source and full powers of prime two. It does not establish a uniform statement for larger sources or prime sets, or a sign for the reflected W readout.


This is a written proof with a bounded Arb certificate, using geometric summation, monotone quadrature bounds and the classical translation-kernel energy identity. It makes no priority claim. The general finite-energy and kernel identities have the separate [Lean mapping](all-prime-fixed-source-drift-curvature.md#formalized-energy-and-contact-forms); this particular numerical energy decrease is not formalized in Lean.

The [full-prime companion](full-prime-two-energy-certificate.md) now proves the same direction for the unit-coefficient sum over every prime at this fixed source, with a separate coherent certificate. This does not extend the prime-two estimate by termwise positivity.
