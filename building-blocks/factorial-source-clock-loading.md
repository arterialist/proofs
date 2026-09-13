# Actual growing-clock loading in the factorial ground-state decomposition

The [original-domain theorem](factorial-ground-state-original-l2-domain.md) and [finite-source Picone identity](picone-frozen-source-work.md) fix the forms and arithmetic endpoints used below. The ground-state algebra is classical. The deduction here concerns the actual all-prime arithmetic loading and the complete growing-clock work, in the unchanged original metric.

All physical norms are in $L^2((1,\infty),dx)$. Let
$$
Hg(x)=\frac1x\int_1^x g(y)\,dy,\qquad
b_F(x)=\frac{xF'(x)}{F(x)},\qquad
R_F=I-H-b_FH.
$$
The actual positive factorial potential F, every prime-power atom and the frozen source g_N are those in the cited notes. Their proved bounded observation forms are
$$
B_C(f,g)=\int_1^\infty\frac{\overline{Hf}\,Hg}{F}\,dx,\quad
B_P(f,g)=\sum_{m\ge2}\frac{\Lambda(m)\overline{Hf(m)}\,Hg(m)}{F(m)},\quad
B_R(f,g)=\langle R_Ff,R_Fg\rangle.
$$
They satisfy, on every pair of original L2 inputs,
$$
\boxed{\langle f,g\rangle=B_R(f,g)+B_P(f,g)-B_C(f,g).}
\tag{1}
$$
All three forms are nonnegative on their diagonal. Their mixed terms are signed.

## 1. The actual factorial tail coefficient

The [unconditional PNT envelope](actual-short-time-psi-correlation.md) is
$$
|\psi(x)-x|\le Cx e^{-a\sqrt{\log x}}.
\tag{2}
$$
It is used here unconditionally, not replaced by an RH-strength error.
Since F'(x)=-(\psi(x)-x)/x^2 and F(1)=0,
$$
F(x)\longrightarrow\kappa_F=1+\gamma>0,\qquad
|F(x)-\kappa_F|
\le C(1+\sqrt{\log x})e^{-a\sqrt{\log x}}.
\tag{3}
$$
For the constant, absolute convergence supplied by (2) permits taking the real limit s down to 1 in
$$
\int_1^\infty(\psi(x)-x)x^{-s-1}\,dx
=-\frac{\zeta'(s)}{s\zeta(s)}-\frac1{s-1}.
$$
The ordinary Laurent expansion of zeta at 1 makes this limit -1-gamma. This proves the stated value of F's limit, including the initial density term.

Together with the unconditional positive lower bound for F on x>=2, (2)--(3) imply, for some nu>0,
$$
\boxed{\sup_{x\ge X}
\left(|b_F(x)|+\left|F(x)^{-1}-\kappa_F^{-1}\right|\right)
\le C e^{-\nu\sqrt{\log X}}\qquad(X\ge2).}
\tag{4}
$$
The polynomial factor in (3) is absorbed by decreasing the exponential constant. No sign of F' is required.

## 2. Preserve the full original prime process

Let $T_s$ be the [actual causal compound-Poisson evolution](positive-successor-seed-jump-process.md), conjugated to the physical space by Ug(v)=e^(v/2)g(e^v). Its complete exponent is Phi, with every proper-power interval of its Levy measure. It is an original-L2 contraction and preserves support to the right:
$$
\operatorname{supp} f\subset[X,\infty)
\quad\Longrightarrow\quad
\operatorname{supp}T_sf\subset[X,\infty).
\tag{5}
$$
The Hardy map becomes convolution by e^(-v/2) on v>=0, so H commutes with T_s. R_F generally does not commute with T_s; no such commutation is used.

Fix c>0, set s_n=c log n, and retain the exact birth
$$
v_n=g_n-g_{n-1}
=\Lambda(n)\beta_n-\int_{n-1}^n\beta_y\,dy,
\qquad \beta_y(x)=\frac{\mathbf1_{x\ge y}}x.
\tag{6}
$$
In particular the density ramp remains, and supp v_n is contained in [n-1,infinity). Write
$$
f_n=T_{s_n}v_n,\qquad
L_N=\sum_{n=2}^N\|f_n\|_2^2,\qquad
L_N^X=\sum_{n=2}^N B_X(f_n,f_n),\quad X=R,P,C.
\tag{7}
$$
Equation (1) gives exactly L_N=L_N^R+L_N^P-L_N^C at every finite cutoff.

## 3. The signed prime-minus-density diagonal has a finite total

For any original L2 input f supported in [X,infinity), X>=2, Hf has the same support. The isometry ||(I-H)f||=||f|| and ||H||<=2 give the exact expression
$$
B_P(f,f)-B_C(f,f)
=2\operatorname{Re}\langle(I-H)f,b_FHf\rangle-\|b_FHf\|_2^2.
\tag{8}
$$
If beta_X=sup_(x>=X)|b_F(x)|, then
$$
|B_P(f,f)-B_C(f,f)|
\le4\beta_X(1+\beta_X)\|f\|_2^2.
\tag{9}
$$
This estimates the combined actual prime-minus-density form. It does not separately replace either observation by a density.

The literal increment (6) obeys
$$
\|v_n\|_2^2
\le 2\Lambda(n)^2/n+2/(n-1)
\le C\frac{\Lambda(n)^2+1}{n-1}.
\tag{10}
$$
Apply (4)--(5) and (9) to f_n. The n=2 term is handled by the globally bounded forms; all n>=3 have X=n-1>=2. It follows that
$$
\boxed{\sum_{n\ge2}
|B_P(f_n,f_n)-B_C(f_n,f_n)|<\infty.}
\tag{11}
$$
In fact (11) holds uniformly over every choice of nonnegative times s_n: contraction and right-support preservation suffice. Convergence follows even from Lambda(n)<=log n, since
$$
\sum_{n\ge3}\frac{1+\log^2n}{n}
e^{-\nu\sqrt{\log(n-1)}}<\infty.
$$
Thus no signed diagonal contribution is hidden by taking separate infinite positive limits.

## 4. The individual prime and density loadings have the same explicit coefficient

For the logarithmic clock, the Hardy observation has an additional summable diagonal comparison:
$$
\boxed{\sum_{n\ge2}
\left|\,\|Hf_n\|_2^2-4\|f_n\|_2^2\,\right|<\infty.}
\tag{12}
$$
Here is a direct Fourier proof retaining all frequencies. With rho(xi)=Re Phi(i xi), the complete process has rho(xi) comparable to |xi| near zero and a strictly positive lower bound outside a fixed small band. These are the [complete-kernel estimates](long-time-signed-source-rank-one.md) used in the [growing-time Gram proof](growing-time-actual-source-cocycle.md).

The literal Fourier numerator of Uv_n is
$$
\Lambda(n)n^{-1/2-i\xi}
-\int_{n-1}^n y^{-1/2-i\xi}\,dy,
$$
divided by 1/2+i xi. The numerator has absolute value at most
C(\Lambda(n)+1)/sqrt(n), uniformly in xi. We use the unnormalized Fourier transform and the Plancherel factor 1/(2 pi). Since H's multiplier is 1/(1/2+i xi),
$$
0\le4\|T_sv_n\|_2^2-\|HT_sv_n\|_2^2
\le C\frac{\Lambda(n)^2+1}{n}
\int_{\mathbb R}\frac{\xi^2e^{-2s\rho(\xi)}}{(1/4+\xi^2)^2}\,d\xi.
\tag{13}
$$
For s>=1, the small-band integral is O(s^(-3)); the complementary integrable tail is exponentially small. In particular (13) is bounded by
C(\Lambda(n)^2+1)/(n s^3). The finitely many n with c log n<1 are kept.

Chebyshev gives sum_(n<=x)Lambda(n)^2<=log(x)psi(x)<=Cx log x. Partial summation therefore proves
$$
\sum_{n>N}\frac{\Lambda(n)^2+1}{n\log^3n}
=O(1/\log N),
\tag{14}
$$
which proves (12) with a quantitative tail bound. In particular no prime power is dropped in the square-loading estimate.

The second part of (4), support preservation and ||Hf_n||<=2||v_n|| also give
$$
\sum_{n\ge2}
\left|B_C(f_n,f_n)-\kappa_F^{-1}\|Hf_n\|_2^2\right|<\infty.
\tag{15}
$$
The tail of this series, and that of (11), decrease faster than every fixed negative power of log N.

Consequently there are finite real constants d_C,d_P,d_R, depending on the actual source and fixed c, such that
$$
\boxed{
\begin{aligned}
L_N^C&=\frac4{1+\gamma}L_N+d_C+O_c(1/\log N),\\
L_N^P&=\frac4{1+\gamma}L_N+d_P+O_c(1/\log N),\\
L_N^R&=L_N+d_R+O_c(1/\log N).
\end{aligned}}
\tag{16}
$$
Their constants satisfy d_R+d_P-d_C=0 by (1). The [actual diagonal loading theorem](growing-time-actual-source-cocycle.md#complete-diagonal-loading)
$$
L_N=\frac{2}{\pi^2c}\log N
+O_c((1+\log\log N)^2)
$$
therefore gives
$$
L_N^P,\ L_N^C=
\frac{8}{(1+\gamma)\pi^2c}\log N
+O_c((1+\log\log N)^2),
\qquad
L_N^R=\frac{2}{\pi^2c}\log N
+O_c((1+\log\log N)^2).
\tag{17}
$$
The two large positive potential loadings cancel in their signed difference up to a convergent constant. The actual ground-state loading still has the original coefficient.

## 5. The complete signed work and clock terms

Let $\mathsf A$ be the bounded generator of the actual $T_s=\exp(-s\mathsf A)$. For each X=R,P,C define
$$
\Gamma_X(f)=2\operatorname{Re}B_X(f,\mathsf A f),
$$
$$
J_N^X=B_X(T_{s_N}g_N,T_{s_N}g_N),\quad
W_N^X=\sum_{n=2}^N
\operatorname{Re}B_X(T_{s_n}g_{n-1},T_{s_n}v_n),
$$
$$
D_N^X=\sum_{n=2}^N
\int_{s_{n-1}}^{s_n}\Gamma_X(T_sg_{n-1})\,ds.
\tag{18}
$$
All operations are legitimate for bounded forms and the bounded full process generator. Differentiation and the exact finite birth expansion give
$$
\boxed{J_N^X+D_N^X=B_X(g_1,g_1)+2W_N^X+L_N^X.}
\tag{19}
$$
The initial physical source is g_1=-1/x and is nonzero in every retained formula. Both mixed orders are included through twice the real pairing.

Combining (1) and (19) recovers the original cocycle, with exactly
$$
\boxed{
J_N=J_N^R+J_N^P-J_N^C,\quad
D_N=D_N^R+D_N^P-D_N^C,\quad
W_N=W_N^R+W_N^P-W_N^C.}
\tag{20}
$$
In particular (16) settles the total signed diagonal correction in this new arithmetic representation. It does not sign the mixed prime-minus-density work or the individual component clock terms. Nonnegativity of B_X does not make Gamma_X nonnegative: the observing arithmetic weights are not asserted invariant under the process.

The original total D_N is the actual nonnegative accumulated dissipation from the RH action theorem. Its unconditional finiteness is still unproved. Likewise the R_F isomorphism preserves the original source-norm scale; it supplies no uniform estimate of that norm. The new information is the unconditional all-prime loading comparison (11)--(17), together with the exact seeded, signed clock identities (19)--(20), not a replacement action or a claimed RH bound.

## Dependencies and formal scope

The bounded positive forms come from the [factorial domain and inverse](factorial-ground-state-original-l2-domain.md); the [Picone source proof](picone-frozen-source-work.md) supplies the initial source and every beyond-cutoff prime observation. The [complete process](positive-successor-seed-jump-process.md), [growing-time source cocycle](growing-time-actual-source-cocycle.md), and [clock-action criterion](total-clock-dissipation-and-signed-work.md) retain the original norm and clock normalization. PNT, Hardy convolution and Plancherel are classical inputs. All statements of this chapter are written proofs; no Lean coverage of these observation forms or loading asymptotics is asserted. The absolutely summable diagonal difference does not bound the mixed arithmetic work.
