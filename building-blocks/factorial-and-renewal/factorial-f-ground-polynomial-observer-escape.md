# Polynomial-window escape of the true F-ground spatial jump

Written original-metric theorem by RH Agent3, independently audited by the coordinating agent, 2026-09-16. This concerns the newly excluded interval of the exact fixed-clock spatial jump, not its infinite future part. All observing prime powers, the negative density, the actual ground `F`, and endpoint atoms remain present. There is no signed RH bound.

Let `Y≥3`, `s=c log Y+O(1)` with fixed `c>0`, `A>0`, and `Y<Z≤Y^{1+A}`. Put `T=log(Z/Y)≤A log Y`. The exact compound-Poisson age `U_s` has Laplace transform `E exp(-q U_s)=exp(-s Φ(q))`, and `Φ(q)/q→∞` as `q↓0`. Thus choose a fixed `q=q(A,c)>0` such that

\[
 \kappa:=\Phi(q)-qA/c>0. \tag{1}
\]

For all large `Y`, the exponential Markov inequality gives

\[
 p_{s,T}:=\Pr(U_s\le T)\le e^{qT-s\Phi(q)}
 \le C_{A,c,q}e^{-\kappa s}.
 \tag{2}
\]

The full convolution profile `j_s=h*η_s`, `h(t)=t e^{-t/2} 1_{t≥0}`, satisfies for `0≤t≤T`

\[
 |j_s(t)|\le(2/e)p_{s,T},\qquad |j_s'(t)|\le p_{s,T}\quad\text{a.e.}, \tag{3}
\]

since `sup h=2/e`, `sup |h'|=1`, and `h(0)=0`. No finite-history truncation is used; the entire age law enters (2).

Define the exact local score

\[
 I_{Y,Z,s}=\int_{[Y,Z)}\frac{j_s(\log(x/Y))^2}{xF(x)}\,dE(x),
 \quad E=\psi-x,\quad F\ge1/12,\quad F'=-E/x^2. \tag{4}
\]

The atom at `Z` belongs to the future term. With `δ_Y=sup_{x≥Y}|E(x)|/x`, Stieltjes integration by parts (the lower boundary vanishes as `j_s(0)=0`) yields exactly

\[
 I_{Y,Z,s}=u(Z)E(Z-)-\int_Y^Z E(x)u'(x)\,dx,\quad
u(x)=\frac{j_s(\log(x/Y))^2}{xF(x)}. \tag{5}
\]

Writing `t=log(x/Y)`, direct differentiation a.e. gives

\[
 |u'(x)|\le \frac{12}{x^2}
 \left(2|j_s(t)j_s'(t)|+(1+12\delta_Y)j_s(t)^2\right).
 \tag{6}
\]

Consequently, with an absolute constant `C`,

\[
 |I_{Y,Z,s}|\le C\delta_Y(1+T)(1+\delta_Y)p_{s,T}^2
 \ll_{A,c,q}\delta_Y(1+\log Y)e^{-2\kappa s}
 = O_{A,c,\eta}(Y^{-\eta})
 \quad(0<\eta<2c\kappa). \tag{7}
\]

The classical PNT supplies `δ_Y≪exp(-a sqrt(log Y))`, in particular boundedness; it is not an RH-strength hypothesis. This is uniform for every `Z` within the stated polynomial window, including prime-power endpoints. For any fixed `A`, all newly excluded observations up to `Y^{1+A}` are therefore power suppressed at the true logarithmic clock. The unsolved infinite future score can sample `x>Y^{1+A}` for every fixed `A`: the estimate does not bound, sign, or cancel that future contribution. It also does not establish that the future contribution is large.
