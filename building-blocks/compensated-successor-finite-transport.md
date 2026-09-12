# Finite signed transport cost of the charge-preserving successor

This written theorem uses the exact source space and causal conventions of [positive history averaging](positive-history-successor-charge-relaxation.md). It proves a time-uniform primitive estimate and a complete two-history moving-observation theorem. The original scalar packet and both mixed terms remain part of the response.

## 1. The space measured by primitives

For a finite signed mass-zero measure r on the real line with finite first absolute moment, put
$$
\|r\|_{\mathrm{pr}}=\int_{\mathbb R}|r(( -\infty,v])|dv.
$$
This is the one-dimensional Kantorovich--Rubinstein norm. We use its concrete completion: distributions r=partial_v R with R in L1, norm equal to norm(R)1. For causal distributions the primitive R is causal. This identifies the completion isometrically with L1 and fixes the integration constant. In particular,
$$
\|\delta_x-\delta_y\|_{\mathrm{pr}}=|x-y|.                    \tag{1}
$$
Positive probability convolution contracts this norm, even when its own first moment is infinite, because it convolves the L1 primitive. There is no assertion here about contraction in E.

For an actual L1 function r whose primitive belongs to L1, its integral is zero. For every bounded Lipschitz b, integration by parts gives
$$
\left|\int b(v)r(v)dv\right|
\le\operatorname{Lip}(b)\|r\|_{\mathrm{pr}}.                  \tag{2}
$$
Indeed its absolutely continuous primitive tends to zero at both ends, and the boundary terms vanish. This permits signed bilinear testing without discarding the primitive's sign.

## 2. The exact point response of the causal successor

Let rho=a0/2, a probability density of mean two. For u>=L=log 2 set
$$
A(u)=(1-e^{-u})^{-1/2},\qquad \ell(u)=\log(e^u-1).
$$
The distributional point-source response is
$$
\mathscr C_u=C\delta_u=
\begin{cases}
\rho,&0\le u<L,\\
A(u)\delta_{\ell(u)}-(A(u)-1)\rho,&u\ge L.
\end{cases}                                                  \tag{3}
$$
The coefficient A comes from the exact change of variable for S, not a unit-Jacobian translation. Each signed measure has mass one. The value at the single endpoint u=L is immaterial in the source-column integrals below. It can be chosen by the second branch.

Define the mass-zero birth defect E_u=mathscr C_u-delta_u. For u>=L its useful exact decomposition is
$$
E_u=A(u)(\delta_{\ell(u)}-\delta_u)
 +(A(u)-1)(\delta_u-\rho).                                   \tag{4}
$$
Since |ell(u)-u|<=Ce^-u, A(u)-1<=Ce^-u, and rho has mean two, (1) gives
$$
\|E_u\|_{\mathrm{pr}}\le Ce^{-u}(1+u),\qquad u\ge0.            \tag{5}
$$
For u<L this follows directly from E_u=rho-delta_u and its cost at most 2+u. Thus the extracted initial interval is part of the finite cost.

Let f(v)=e^(v/2)H(e^v), with H in causal E. The [anchoring inequality](charge-compensated-successor-memory.md) is norm(e^-u/2 f)2<=norm(H)E. Therefore
$$
\int_0^\infty \|E_u\|_{\mathrm{pr}}|f(u)|du
\le C\left(\int_0^\infty e^{-u}(1+u)^2du\right)^{1/2}\|H\|_E.
$$
Bochner integration of the explicit primitives in (4) proves
$$
\boxed{C-I:E_c\longrightarrow\{\partial_v R:R\in L^1\}
\text{ is bounded}.}                                        \tag{6}
$$
On compact causal sources it is the literal C-I. Its distributional extension agrees with the bounded E extension on their common domain. The estimate neither defines an absolute charge on E nor assumes integrability of f.

## 3. Any positive delay law preserves a uniform commutator bound

Let mu be any probability measure on nonnegative ages, and Tmu f=integral D_w f mu(dw). The [proved dilation estimate](positive-successor-seed-jump-process.md) gives norm(Tmu on E)<=M, uniformly in the law. On the primitive space its norm is at most one. Since C-I is bounded from E to that space,
$$
[C,T_\mu]=(C-I)T_\mu-T_\mu(C-I)
$$
has the uniform bound
$$
\boxed{\|[C,T_\mu]H\|_{\mathrm{pr}}\le C(M+1)\|H\|_E.}        \tag{7}
$$
The identity is first literal on the compact core and then extends in distributions. It retains all delays in mu and has no first-moment premise on that law.

For the actual complete-prime semigroup Tt, the preceding L1 theorem separately proves [C,Tt]H is a physical L1 function with zero integral, with L1 norm O(t). Combining that theorem with (7) yields, for bounded Lipschitz b and every R>0,
$$
\left|\int b(v/R)[C,T_t]H(v)dv\right|
\le\frac{C\operatorname{Lip}(b)}R\|H\|_E,\qquad t\ge0.        \tag{8}
$$
The primitive bound is uniform in time. It is stronger for slowly varying observations than the L1 estimate; it is a different output norm, not an improved L1 assertion.

The full successor identity retains the packet and charge correction:
$$
\begin{split}
\int b(v/R)[S,T_t]a(v)dv={}&-\kappa\int b(v/R)T_ta0(v)dv\\
&+\delta(T_ta)\int b(v/R)a0(v)dv+\epsilon_{t,R},\qquad
|\epsilon_{t,R}|\le C\operatorname{Lip}(b)\|g\|_E/R.           \tag{9}
\end{split}
$$
Here g is the actual additive source and delta(a)=kappa>0. Equation (9) is the promised signed cross-term comparison. It controls the coherent mass-zero remainder before taking absolute values of individual histories.

## 4. Location of the retained negative packet

The positive process has jump density F=B/v and the proved tail B(v)=2/v+O(v^-2). Let Zt have its compound Poisson law. Put Rt=t log t, t>1. Then
$$
Z_t/R_t\longrightarrow2\quad\text{in probability}.            \tag{10}
$$
Here is a direct proof retaining the infinite first moment. Separate jumps larger than Rt. Their probability of occurring is at most
$$
t\int_{R_t}^\infty F(v)dv=O(1/\log t).
$$
The sum of the remaining jumps has mean
$$
t\int_0^{R_t}vF(v)dv=2t\log R_t+O(t)
$$
and variance
$$
t\int_0^{R_t}v^2F(v)dv=O(tR_t).
$$
After division by Rt the mean tends to two and the variance tends to zero. This proves (10) without assigning a finite mean to Zt itself. For bounded Lipschitz b it also gives
$$
\left|\mathbb E b(Z_t/R_t)-b(2)\right|
\le C(\|b\|_\infty+\operatorname{Lip}(b))
\left((\log t)^{-1/2}+\frac{\log\log t}{\log t}\right).         \tag{11}
$$

The density Tt a0 has total mass two and is the law of Zt plus an independent mean-two exponential variable, multiplied by two. Also the completed relative-charge bound gives |delta(Tt a)|<=C exp(-t Phi(1)) norm(g)E. Substitution into (9) proves
$$
\boxed{\lim_{t\to\infty}\int_0^\infty b\!\left(\frac v{t\log t}\right)
[S,T_t]a(v)dv=-2\kappa b(2)}                                 \tag{12}
$$
for every bounded Lipschitz b. The error is bounded by the right side of (11) times C|kappa|, plus
$$
C\operatorname{Lip}(b)\|g\|_E/(t\log t)
 +C\|b\|_\infty e^{-t\Phi(1)}\|g\|_E.
$$
This is a signed bounded-Lipschitz limit, not convergence in total variation. A nonnegative moving observation with b(2)>0 has a strictly negative actual successor response for all sufficiently large times.

The same proof is uniform over natural cutoffs N>=2 with kappa replaced by deltaN, using their uniformly bounded E norms. It concerns the already completed all-prime process. Fixed finite-prime processes have finite mean and a different large-time age scale. The [uniform prime/time theorem](uniform-prime-time-successor-packet.md) gives the separate crossover, including fixed and growing prime cutoffs.

## 5. The next actual-readout test

The transport theorem distinguishes the relevant condition on a proposed actual bilinear readout: after writing its second factor as an age test b, one must estimate its Lipschitz variation at the scale where Tt a0 is observed. Equation (9) makes that condition explicit. It does not control exponentially weighted or arbitrarily oscillatory test factors merely from their amplitude, and it does not transfer the sign to anticausal self-work or to the Weil form. Those readouts require their actual kernels, metric and boundary terms. The finite signed transport estimate is available without changing any prime coefficient or deleting the transported reference packet.

## 6. A complete two-history readout

There is a quadratic consequence that does not follow merely from the signed weak limit (12). Let
$$
r_t=[S,T_t]a,\quad R_t=[C,T_t]a,\quad q_t=T_ta0,\quad
\epsilon_t=\delta(T_ta).
$$
Thus rt=Rt-kappa qt+epsilon_t a0 exactly. The preceding results give
$$
\|R_t\|_{\mathrm{pr}}\le C\|g\|_E,
\quad\|q_t\|_1=2,
\quad|\epsilon_t|\le C e^{-t\Phi(1)}\|g\|_E.                  \tag{13}
$$
Take a bounded C2 kernel B(x,y) on the nonnegative quadrant, with bounded first partial derivatives and bounded mixed derivative. It need not be positive, separable or translation invariant. For R>=1, integration by parts in one or both variables gives
$$
\begin{split}
\left|\iint B(v/R,w/R)R_t(v)q_t(w)\,dv\,dw\right|
&\le 2\|\partial_1 B\|_\infty\|R_t\|_{\mathrm{pr}}/R,\\
\left|\iint B(v/R,w/R)R_t(v)R_t(w)\,dv\,dw\right|
&\le\|\partial_1\partial_2B\|_\infty
       \|R_t\|_{\mathrm{pr}}^2/R^2.                          \tag{14}
\end{split}
$$
The first estimate with the arguments reversed uses partial2 B. The functions Rt are L1 and their L1 primitives vanish at the endpoints, so these are genuine integral identities. They can also be proved with compact cutoffs followed by the L1 primitive bounds. No uniform total-variation estimate of rt is used.

Expand both factors of rt, retaining every term. Equations (13)--(14) imply
$$
\begin{split}
&\iint B(v/R,w/R)r_t(v)r_t(w)\,dv\,dw\\
&\qquad=\kappa^2\iint B(v/R,w/R)q_t(v)q_t(w)\,dv\,dw
 +O_{B,g}\big(R^{-1}+R^{-2}+e^{-t\Phi(1)}\big).               \tag{15}
\end{split}
$$
The tensor containing two compensated remainders is controlled by the mixed derivative in (14). The scalar packet square and both scalar-packet mixed terms are present in (15). The real arithmetic source makes a bilinear and Hermitian version equivalent after conjugating the appropriate kernel; the same bounds apply directly in the complex version.

At R=t log t, the packet concentration proof applies to the product measure qt(v)qt(w)dv dw. This use of a product measure simply evaluates the displayed double integral; it is not an independence assertion about prime histories or arithmetic arrivals. It yields the exact full moving-observation limit
$$
\boxed{\lim_{t\to\infty}\iint
B\!\left(\frac v{t\log t},\frac w{t\log t}\right)
[S,T_t]a(v)[S,T_t]a(w)\,dv\,dw=4\kappa^2 B(2,2).}            \tag{16}
$$
In particular, the sign of a nonsingular limiting kernel at the observed packet is transferred to this actual two-history response. A proposed W or Weil kernel must still be shown to obey the scaled derivative bounds used here, with its proper subtraction and endpoint terms. Equation (16) supplies a sufficient quantitative test, not that missing identification.


The primitive norm is the classical one-dimensional Kantorovich–Rubinstein norm on mass-zero measures with finite first absolute moment; the proof explicitly constructs its $L^1$-primitive completion. Convolution and the Poisson truncation argument above then require no first moment of the full probability law. The scalar and two-history limits remain written analytic theorems, with no Lean claim.
