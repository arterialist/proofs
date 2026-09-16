# Two canceled moments in the integer-cell renewal primitive

This is a written refinement of the actual integer-minus-continuum renewal
kernel in [the Euler-discrepancy audit](causal-renewal-euler-discrepancy-audit.md).
It supplies an unconditional phase formula for each late logarithmic cell.
It does **not** bound the response to the distinguished prime forcing or
exclude an off-critical zero.

Use exactly the audit's right-continuous convention

\[
H(v)=S_{\lfloor e^v\rfloor}-\zeta(1/2)-2e^{v/2},\qquad
J(v)=\int_0^v H(w)\,dw,\qquad
\ell=\int_0^\infty H(w)\,dw=4+\zeta'(1/2).
\]

For \(z\in\mathbb C\), put

\[
I_n(z)=\int_{\log n}^{\log(n+1)}e^{-zv}(J(v)-\ell)\,dv.
\]

**Cell phase formula.** Uniformly for \(z\) in any fixed compact set
\(K\subset\mathbb C\), as \(n\to\infty\),

\[
\boxed{I_n(z)=-\frac{(2z+7)(2z+9)}{2880}
 n^{-z-9/2}+O_K(n^{-\Re z-11/2}).}                 \tag{1}
\]

In particular, for each fixed real \(x\ge0\), every sufficiently late
weighted cell has **negative signed area**, even though
\(J-\ell\) changes sign inside each cell. The double-primitive argument
below strengthens this to a cutoff uniform over all real \(x\ge0\).

Here is the calculation, including the endpoint terms. Write
\(v=\log(n+r)\), \(0\le r\le1\), and
\(A_n=S_n-\zeta(1/2)\). The Euler--Maclaurin expansion of the Hurwitz
tail ([DLMF 25.11.43](https://dlmf.nist.gov/25.11.E43)) gives

\[
A_n=2\sqrt n+\frac1{2\sqrt n}-\frac1{24n^{3/2}}
       +\frac1{384n^{7/2}}+O(n^{-11/2}).          \tag{2}
\]

On the full half-open cell, \(H(\log(n+r))=A_n-2\sqrt{n+r}\).
Expanding \(H\,dv=H(\log(n+r))\,dr/(n+r)\), uniformly for
\(0\le r\le1\), yields

\[
H\,dv=\left[n^{-3/2}h_0(r)+n^{-5/2}h_1(r)
       +n^{-7/2}h_2(r)+n^{-9/2}h_3(r)
       +O(n^{-11/2})\right]dr,                  \tag{3}
\]

where

\[
\begin{aligned}
h_0(r)&=\tfrac12-r,\\
h_1(r)&=\tfrac54r^2-\tfrac12r-\tfrac1{24},\\
h_2(r)&=-\tfrac{11}{8}r^3+\tfrac12r^2+\tfrac1{24}r,\\
h_3(r)&=\tfrac{93}{64}r^4-\tfrac12r^3-\tfrac1{24}r^2
          +\tfrac1{384}.
\end{aligned}                                      \tag{4}
\]

Integrating (3) over one cell gives the sharpened positive increment

\[
q_n=J(\log(n+1))-J(\log n)
 =\frac1{8n^{5/2}}-\frac5{32n^{7/2}}
  +\frac{889}{5760n^{9/2}}+O(n^{-11/2}).       \tag{5}
\]

Summing from \(n\) to infinity, with the ordinary endpoint
\(\frac12n^{-s}\) in each Hurwitz tail, gives

\[
\ell-J(\log n)
 =\frac1{12n^{3/2}}-\frac{23}{2880n^{7/2}}
  +O(n^{-9/2}).                                  \tag{6}
\]

The \(n^{-5/2}\) coefficient in (6) vanishes exactly:
\(\frac18\cdot\frac12-\frac5{32}\cdot\frac25=0\).
This cancellation is needed for the second vanishing moment below.

Integrate (3) only to \(r\), subtract (6), and set

\[
\begin{aligned}
f_0(r)&=\tfrac12r-\tfrac12r^2-\tfrac1{12}
       =-\tfrac12 B_2(r),\\
f_1(r)&=\tfrac5{12}r^3-\tfrac14r^2-\tfrac1{24}r,\\
f_2(r)&=-\tfrac{11}{32}r^4+\tfrac16r^3+\tfrac1{48}r^2
          +\tfrac{23}{2880},
\end{aligned}                                      \tag{7}
\]

where \(B_2(r)=r^2-r+1/6\). Then, uniformly on the cell,

\[
J(\log(n+r))-\ell
 =n^{-3/2}f_0(r)+n^{-5/2}f_1(r)
  +n^{-7/2}f_2(r)+O(n^{-9/2}).                  \tag{8}
\]

The first two Bernoulli moments and the next profile's mean vanish:

\[
\int_0^1f_0=0,\qquad \int_0^1r f_0=0,
\qquad\int_0^1 f_1=0.                        \tag{9}
\]

The surviving moments are

\[
\int_0^1r^2f_0=-\frac1{360},\qquad
\int_0^1r f_1=\frac1{144},\qquad
\int_0^1f_2=-\frac7{576}.                       \tag{10}
\]

Finally,
\(e^{-zv}dv=n^{-z-1}(1+r/n)^{-z-1}dr\). The constant and
linear terms of this weight vanish by (9). Its next coefficient is

\[
\begin{aligned}
\int_0^1\left[f_2-(z+1)r f_1
 +\frac{(z+1)(z+2)}2r^2 f_0\right]dr
&=-\frac7{576}-\frac{z+1}{144}
  -\frac{(z+1)(z+2)}{720}\\
&=-\frac{(2z+7)(2z+9)}{2880},
\end{aligned}
\]

which proves (1). Taylor remainders are uniform on compact \(K\).
The six exact polynomial moments in (9)--(10) and the real version of
the surviving coefficient are compiled in
[RenewalBernoulliCellMoments.lean](BuildingBlocks/RenewalBernoulliCellMoments.lean).
The Euler--Maclaurin expansion, complex uniform remainder and grouped
analytic continuation in this note remain written mathematics.

## A uniform real-frequency sign for every sufficiently late cell

The two leading profiles imply a stronger conclusion than the fixed-$x$
statement following (1):

\[
\boxed{\text{There is an integer }n_0\text{ such that }
I_n(x)<0\quad\text{for every }n\ge n_0
\text{ and every real }x\ge0.} \tag{11}
\]

In particular the cutoff $n_0$ is independent of the unbounded frequency
$x$. To see this, put
\[
F_n(r)=J(\log(n+r))-\ell,\qquad
G_n(r)=\int_0^r(r-t)F_n(t)\,dt,\qquad 0\le r\le1.
\]
Twice integrating the polynomials in (7) gives the exact identities
\[
\begin{aligned}
\int_0^r(r-t)f_0(t)\,dt
 &=-\frac{r^2(1-r)^2}{24},\\
\int_0^r(r-t)f_1(t)\,dt
 &=-\frac{r^3[1+3r(1-r)]}{144}.
\end{aligned} \tag{12}
\]
Both are nonpositive throughout the cell, and the second is strictly
negative for $r>0$. Integrating the uniform remainder in (8) twice gives
\[
G_n(r)=
-\frac{r^2(1-r)^2}{24n^{3/2}}
-\frac{r^3[1+3r(1-r)]}{144n^{5/2}}
+O(r^2n^{-7/2}) . \tag{13}
\]
The $O$ constant is uniform for $0\le r\le1$: the bounded $f_2$ and the
uniform remainder in (8) each acquire at most a factor $r^2/2$ under the
double integration. For $r\le1/2$, the first displayed negative term has
magnitude at least $r^2/(96n^{3/2})$; for $r\ge1/2$, the second has
magnitude at least $r^2/(288n^{5/2})$. Thus the two terms together are at
most $-r^2/(288n^{5/2})$, and (13) proves $G_n(r)<0$ for every
$0<r\le1$ once $n$ is sufficiently large.

The boundary mean is negative as well. Equations (8)--(10) give
\[
G_n'(1)=\int_0^1 F_n(t)\,dt
=-\frac7{576n^{7/2}}+O(n^{-9/2})<0
\quad(n\ge n_0). \tag{14}
\]
Finally write the cell integral as
\[
I_n(x)=\int_0^1 w_{n,x}(r)F_n(r)\,dr,\qquad
w_{n,x}(r)=(n+r)^{-x-1}.
\]
For every $x\ge0$, this weight is positive, decreasing, and convex.
Two integrations by parts, with $G_n(0)=G_n'(0)=0$, give
\[
I_n(x)=w_{n,x}(1)G_n'(1)
-w_{n,x}'(1)G_n(1)
+\int_0^1w_{n,x}''(r)G_n(r)\,dr<0. \tag{15}
\]
The signs use $G_n'(1)<0$, $G_n(1)<0$, $w_{n,x}'\le0$, and
$w_{n,x}''\ge0$. The exact polynomial identities and nonpositive
factors in (12) are compiled in
[RenewalBernoulliCellMoments.lean](BuildingBlocks/RenewalBernoulliCellMoments.lean);
the uniform analytic remainder and the all-$x$ conclusion remain written
mathematics. This signs each late *individual* real cell, not the finitely
many early cells or the complex-frequency prime-forcing response.

The grouped cell series \(\sum_{n\ge1}I_n(z)\) now converges locally
absolutely for \(\Re z>-7/2\), although the ungrouped Laplace integral
of \(J-\ell\) is absolutely convergent only for \(\Re z>-3/2\).
Subtracting the leading term in (1) gives a remainder series locally
absolutely convergent for \(\Re z>-9/2\). The corresponding term
\(-[(2z+7)(2z+9)/2880]\zeta(z+9/2)\) has a removable singularity at
\(z=-7/2\), so this subtraction continues the grouped transform
through that point. This is a cellwise analytic refinement of the
already known meromorphic zeta identity, not a new zero-free region.

The integer-cell cancellations constrain the **kernel** phase. The
remaining RH obstruction is the phase of its pairing with the actual
prime forcing; neither (1) nor the eventual negative area signs that
pairing.
