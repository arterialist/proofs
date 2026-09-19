# A self-dual Hermitian partition function with off-line zeros

Self-adjoint time evolution and a reflection symmetry of a partition
function do not, by themselves, put its complex zeros on the symmetry
line. The following finite system is an explicit test of that inference;
it says nothing against an argument using the additional arithmetic of
the Riemann zeta function.

Let $H$ be diagonal with energy $-\log 5$ of multiplicity $1$,
energy $0$ of multiplicity $5$, and energy $+\log 5$ of
multiplicity $5$. It is self-adjoint. Its partition function is

$$
 Z(s)=\operatorname{Tr}(e^{-sH})=5^s+5+5^{1-s}.
 \tag{1}
$$

Every Boltzmann weight is positive for real $s$, and the functional
equation $Z(s)=Z(1-s)$ holds exactly. Put
$u=5^{s-1/2}$. The equation $Z(s)=0$ becomes

$$
 u^2+\sqrt 5\,u+1=0,
 \qquad
 u=-\frac{\sqrt5+1}{2}\quad\text{or}\quad
 u=-\frac{\sqrt5-1}{2}.
 \tag{2}
$$

Writing $\varphi=(1+\sqrt5)/2$, all zeros are therefore

$$
 \boxed{\displaystyle
 s=\frac12\pm\frac{\log\varphi}{\log5}
       +\frac{(2k+1)\pi i}{\log5},\qquad k\in\mathbb Z.}
 \tag{3}
$$

Since $1<\varphi<\sqrt5$, these zeros lie strictly inside the strip
$0<\Re s<1$ and strictly off its middle line. In fact
$Z(1/2+it)=5+2\sqrt5\cos(t\log5)>0$, so this system has *no*
zeros on the middle line.

Thus Hermiticity, positive real-temperature weights, and exact
$s\leftrightarrow1-s$ duality do not imply an RH-type zero-location
theorem. Any quantum or geometric route to RH must use an additional
constraint specific to the actual prime spectrum and its signed
arithmetic coupling. The example is an elementary obstruction, with
no claim of priority or of an RH estimate.
