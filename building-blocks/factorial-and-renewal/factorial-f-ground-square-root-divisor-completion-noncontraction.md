# Square-root divisor completion need not contract the actual full-F energy

2026-09-16. This is a finite, actual-source counterexample to a universal
signed covariance inequality. It does not disprove an eventual asymptotic
inequality and gives no new RH estimate.

Put
\[
 F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
 \qquad
 w_Y(x)=\frac{Y\log^2(x/Y)}{x^2F(x)}\mathbf1_{[Y,2Y)}(x).
\]
The clock is initially zero. A finite first-block clock simply multiplies
each score below by its positive no-jump factor \(p_s^2\), and every energy
by \(p_s^4\), so none of the conclusions changes.

For an integer cutoff \(D\), use the literal Euler splitting
\[
 a_D(n)=\sum_{\substack{d\mid n\\d\le D}}\mu(d)\log(n/d),
 \qquad t_D(n)=\Lambda(n)-a_D(n).
\]
Define the complete low, high, and actual scores by
\[
 L_D(Y)=\sum_n a_D(n)w_Y(n)-\int_Y^{2Y}w_Y(x)\,dx,
 \quad T_D(Y)=\sum_n t_D(n)w_Y(n),
 \quad B(Y)=L_D(Y)+T_D(Y).
\]
Thus the continuous density belongs to the low block, and every prime
power and divisor history remains in the combined source. The atom at
\(2Y\) is excluded and the lower atom has zero weight. Write
\(\langle f,g\rangle_X=\int_X^{2X}f(Y)g(Y)\,dY/Y\).

## The counterexample

For the actual von Mangoldt and Möbius functions, at
\[
 X=128,\qquad D=11=\lfloor\sqrt{128}\rfloor,
\]
the following rigorous, deliberately widened enclosures hold:
\[
\begin{array}{c|c}
\text{quantity}&\text{enclosure, in units of }10^{-6}\\ \hline
\|B\|_X^2 &[1.776,1.779]\\
\|L_D\|_X^2 &[0.758,0.761]\\
\|T_D\|_X^2 &[1.750,1.753]\\
\langle L_D,T_D\rangle_X &[-0.368,-0.365].
\end{array}
\]
In particular,
\[
 \boxed{\quad
 2\langle L_D,T_D\rangle_X+\|T_D\|_X^2
 =\|B\|_X^2-\|L_D\|_X^2
 \in[1.015,1.021]\,10^{-6}>0.
 \quad}
\]
Consequently the natural proposed dissipative inequality
\[
 2\langle L_D,T_D\rangle_X\le-\|T_D\|_X^2
\]
is false, even at the literal square-root cutoff. Completing the Euler
divisor sum more than doubles the low-block energy. The complete energy
also exceeds the high-block energy. Negative covariance alone does not
make either block a contractive approximation to the actual score.

This is a statement about the complete global logarithmic covariance,
not a selected pair, an unsigned majorant, or a frozen-ground model.

## Verification with explicit integration errors

The accompanying certificate is
`certificates/full_f_divisor_completion_noncontraction.py`. It computes
all coefficients from finite prime factorizations, uses outward interval
arithmetic, and isolates the eight Gauss-Legendre nodes in rational
intervals using the exact polynomial
\[
 P_8(z)=(6435z^8-12012z^6+6930z^4-1260z^2+35)/128.
\]
The weights are evaluated as intervals from
\(2/[(1-z^2)P_8'(z)^2]\). No floating-point root approximation is treated
as exact.

On an integer cell, the ground is evaluated literally as
\[
 F_n(x)=\log x-S_n+\Psi_n/x,
 \quad S_n=\sum_{m\le n}\Lambda(m)/m,\quad \Psi_n=\psi(n).
\]
The finite interval check gives, for \(127\le n\le514\),
\[
 F(n)>1.56,\qquad |\Psi_n-n|<11.
\]
Hence \(F(x)>1.5\) on these cells: its derivative there has magnitude
at most \(12/127^2\). For \(|z-x|\le4\), using the analytic continuation
of the same cell formula,
\[
 |F_n(z)-F_n(x)|\le4\frac{4+12}{123^2}<0.005.
\]
Thus \(|F_n(z)|>1.49\), and each
\[
 f_{k,n}(z)=\frac{(\log z)^k}{z^2F_n(z)},\qquad k=0,1,2,
\]
is analytic in that disk and has modulus less than 1. Cauchy's estimate
bounds its sixteenth derivative by \(16!/4^{16}\).

For eight-node Gauss-Legendre quadrature on an interval of length \(h\),
the error is bounded by
\[
 c_8h^{17}\sup|f^{(16)}|,
 \qquad c_8=\frac{(8!)^4}{17(16!)^3}.
\]
The density moments are integrated over complete integer cells and their
two partial endpoint cells. Fewer than 390 such pieces suffice for any
\([Y,2Y]\), \(128\le Y\le256\). Consequently every density score has
absolute quadrature error at most
\[
 \epsilon_{\rm den}
 =390c_8\frac{16!}{4^{16}}\,256(1+2\cdot6+6^2)
 <4.1\cdot10^{-13}.
\]
The three density moments are combined with the exact polynomial
\(Y[(\log x)^2-2\log Y\log x+(\log Y)^2]\).

The outer integration uses 512 intervals of length \(1/4\). Their
endpoints include every possible upper atom admission \(Y=n/2\), as
well as every change of density endpoint cell. On each open interval the
admitted finite atom set is fixed. Its score formula has an analytic
continuation to every radius-one disk centered on the interval, using
the same endpoint-cell formulas for the density. These continuations
do not assert that the physical score is continuous through its jumps.

For completeness, the continued atomic low score has modulus below 20:
\(\sum_{d\le11}1/d<4\), \(\log512<7\), and the number of multiples
of \(d\) in a window of length \(Y\) is at most \(Y/d+1\).
Also \(|\log(n/z)|<1\) for \(|z-Y|\le1\) and admitted \(n\).
The corresponding actual atomic score is below 5. The continued density
is below 2, by integrating on the real window and adding endpoint paths
of total length at most 3. Therefore \(|B|<7\), \(|L_D|<22\), and
\(|T_D|<29\) there. The much looser bound \(10^6\) is valid for every
outer integrand \(B^2/z,L_D^2/z,T_D^2/z,L_DT_D/z\).
Its total outer quadrature error is at most
\[
 \epsilon_{\rm out}
 =512c_8(1/4)^{17}16!10^6
 <1.1\cdot10^{-11}.
\]
Changing the approximate density to its exact value changes any of the
four energy integrals by less than \(100\epsilon_{\rm den}\).
The positive quadrature weights have total \(\sum w/Y\le1\) on
\([128,256]\), so the same error bound applies to the computed outer
sum. The certificate adds a uniform \(10^{-9}\) allowance to each
interval result, exceeding
\(\epsilon_{\rm out}+100\epsilon_{\rm den}\).
The displayed enclosures include this allowance.

Before adding that allowance, the interval quadrature centers are
\[
\begin{split}
 \|B\|^2&=1.7774708472123525\ldots\,10^{-6},\\
 \|L_D\|^2&=0.7594635739942742\ldots\,10^{-6},\\
 \|T_D\|^2&=1.7514154382812960\ldots\,10^{-6},\\
 \langle L_D,T_D\rangle&=-0.3667040825316088\ldots\,10^{-6}.
\end{split}
\]

## Why composite cancellation does not imply contraction

The rough semiprime histories are retained. For example, at
\(n=221=13\cdot17\), both prime factors exceed 11, so
\[
 a_{11}(221)=\log221,\qquad t_{11}(221)=-\log221,
 \qquad\Lambda(221)=0.
\]
They cancel exactly at that integer, as do the other completed composite
histories. At \(169=13^2\), completion instead changes
\(2\log13\) to the correct \(\log13\); proper powers are not discarded.
These identities enforce the correct source coefficients but do not
make the high-divisor correction dissipative in the global Gram norm.
Here \(\langle B,T_D\rangle=\|T_D\|^2+\langle L_D,T_D\rangle>0\),
and adding the high block increases the energy despite its negative
correlation with the low block.

One finite counterexample disproves the asserted universal contraction.
It does not exclude a modified cutoff, an additive-error inequality, or
an inequality asserted only for sufficiently large \(X\). None of those
remaining possibilities is established here.
