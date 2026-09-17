# Uniform zero-free-region PNT error for the rough-prime Green row

This note separates the classical input from the new uniform divisor-face deduction.

## Classical input

Assume an explicit de la Vallée Poussin error in the form

\[
 |\pi(u)-\operatorname{li}(u)|
 \le C_\pi u\exp(-c_\pi\sqrt{\log u})
 \qquad(u\ge X_0),
\tag{1}
\]

for fixed positive constants `C_pi,c_pi,X_0`. This is the only analytic number-theory input. Any published explicit version of (1) may be substituted; the deduction below keeps its constants symbolic rather than silently choosing numerical values outside the cited theorem's range.

## One dilated face

Let `X>=max(X_0,e)`, `L=log X`, `y=j/X`,

\[
 t=X\max(1,y/d),\qquad \lambda=2d/X,qquad w(u)=e^{-\lambda u}.
\]

Use the exact closed/open endpoint convention from the moving-ceiling note. After its possible single atom is separated, Stieltjes partial summation with
`E(u)=pi(u)-li(u)` gives

\[
 \left|\int_{[t,\infty)}w\,dE\right|
 \le C_\pi e^{-c_\pi\sqrt L}e^{-\lambda t}
 \left(2t+\lambda^{-1}\right).
\tag{2}
\]

Indeed `u>=t>=X`, so the zero-free factor is at most its value at `X`, and

\[
 \lambda\int_t^\infty ue^{-\lambda u}du
 =e^{-\lambda t}(\lambda t+1).
\]

Multiplying (2) by the exact normalized profile factor `(L/X)e^y` yields

\[
 C_\pi L e^{-c_\pi\sqrt L}
 e^{y-2d\max(1,y/d)}
 \left(2\max(1,y/d)+\frac1{2d}\right).
\tag{3}
\]

This retains the moving lower endpoint.

## Complete divisor packet

Taking absolute values and enlarging the divisor set to all positive integers gives a bound independent of `P`. Split at `d<y`.

For `d>=y`, (3) is bounded by a constant times

\[
 L e^{-c_\pi\sqrt L}e^y\sum_{d\ge\lceil y\rceil}e^{-2d}.
\]

For `d<y`, it is bounded by

\[
 L e^{-c_\pi\sqrt L}e^{-y}(2y+1/2)
 \sum_{d<y}\frac1d.
\]

Using `sum_{d<y}1/d <= 1+log(1+y)` and `log(1+y)<=y`, their sum is at most

\[
 10 C_\pi L e^{-c_\pi\sqrt L}(1+y^2)e^{-y}.
\tag{4}
\]

The block estimate already used for the second-log remainder shows that the sampled Green norm of `10(1+y²)e^{-y}` is at most `50`. Hence the complete actual Möbius prime-row error satisfies

\[
 \|R_{\mathrm{PNT},X,P}\|_{G,X}
 \le 50 C_\pi L e^{-c_\pi\sqrt L}.
\tag{5}
\]

Finally

\[
 L e^{-c_\pi\sqrt L}
 \le\frac{16}{c_\pi^2e^2}
 e^{-(c_\pi/2)\sqrt L},
\]

because the maximum of `z² exp(-(c_pi/2)z)` is `16/(c_pi²e²)`. Thus one explicit common constant is

\[
 \boxed{
 \|R_{\mathrm{PNT},X,P}\|_{G,X}
 \le \frac{800C_\pi}{c_\pi^2e^2}
 \exp\left[-\frac{c_\pi}{2}\sqrt{\log X}\right].}
\tag{6}
\]

This estimate is uniform over every divisor face and every `P<=X`; it does not require `P<=X^(1/2-epsilon)` or a friable endpoint theorem.

## Prime powers and rough composites

Nothing is deleted from the actual source. Exactly

\[
 c_X=\delta_1-1_{\{p>X:p\text{ prime}\}}+r_X,
\]

where `r_X` contains the squarefree `X`-rough composites with their actual Möbius coefficients. Nonsquarefree prime powers have coefficient zero in `c_X`; they are not replaced by a prime surrogate. The support of `r_X` lies beyond `X²`. Formula (6) concerns only the prime row. The `r_X` contribution remains the separate exponentially weighted rough-composite remainder; no PNT estimate is applied to it.

## Strongest justified range

The PNT propagation itself is uniform for all `P<=X`. It is one component of the proposed simultaneous expansion, not a complete energy theorem. The second-log, sampling, moving-ceiling, and endpoint components are treated in separate notes; the `X`-rough composite row and final exact assembly must still be checked in the same normalization. In particular, (6) alone does not prove a range such as `P<=X^(1/2-epsilon)` or even the older logarithmic complete-energy claim.

`FinitePNTErrorPropagation.lean` formalizes linear subtraction of the main counting function and the finite boundary-plus-interior absolute error propagation. The passage from (1) to (2) is classical Stieltjes partial summation; the divisor-envelope deduction (3)--(6) is new elementary analysis.
