# Positive history averaging and exact successor charge relaxation

This written proof uses the [complete positive process](positive-successor-seed-jump-process.md), the [bounded actual source and relative charge](actual-successor-resonance-charge-cocycle.md), and the [full compensated-kernel algebra](charge-compensated-successor-memory.md). Compound-Poisson averaging is classical; all arithmetic profiles, the initial strip and both signed charge terms are retained.

## 1. Notation and finite variation of the jump density

Write physical age as v and process time as t. Causal delays are
$$
(D_w f)(v)=1_{v\ge w}f(v-w).
$$
The physical representative of an additive source H is f(v)=e^{v/2}H(e^v). The causal additive completion is denoted E. Its proved weighted estimate is
$$
\|e^{-v/2}f\|_2\le\|H\|_E.                                      \tag{1}
$$
The delay operators are uniformly bounded on E, although they need not be contractions in that norm. They are contractions in physical L1.

Let L=log 2, a0(v)=e^{-v/2}1_{v\ge0}, and
$$
Sf(v)=\sqrt{e^v/(1+e^v)}f(\log(1+e^v)),\qquad C=S-a0\delta,
$$
$$
\delta(f)=\tfrac12\int_0^\infty k(v)f(v)dv,\quad
k(v)=\begin{cases}-1&0\le v<L,\\(1-e^{-v})^{-1/2}-1&v\ge L.\end{cases} \tag{2}
$$
This C preserves the charge Q(f)=half the physical integral whenever Q exists. The functional delta extends to E.

For each admitted prime retain the entire floor profile
$$
B_p(v)=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}1_{v\ge\log p},
\quad F_P(v)=\sum_{p\le P}B_p(v)/v,\quad F=B/v.
$$
All densities are extended by zero. Each has support in [L,infinity). The exact profile integrals and variation give
$$
\int B_p=2/p,\qquad \operatorname{Var}(B_p)=2/p+2/p^{3/2}.
$$
Consequently
$$
\|B_p/v\|_1+\operatorname{Var}(B_p/v)
\le C\left(\frac1{p\log p}+\frac1{p\log^2p}\right).              \tag{3}
$$
For the variation, use the distributional product rule, bound 1/v on the support by 1/log p, and bound the absolutely continuous product term by (integral Bp)/log squared p. Chebyshev's prime-counting bound and dyadic summation give
$$
\sum_{p>P}\frac1{p\log p}\le\frac C{\log P}.
$$
Thus F is a nonnegative L1 and BV function, with
$$
\|F-F_P\|_1+\operatorname{Var}(F-F_P)\le C/\log P.                \tag{4}
$$
This is finite variation of B/v, not a claim of finite variation of B.

Put lambda=integral F and
$$
\Phi(s)=\int(1-e^{-sw})F(w)dw,\quad
\mu_t=e^{-t\lambda}\sum_{n\ge0}\frac{t^n}{n!}(F\,dw)^{*n},
\quad T_t f=\int D_w f\,\mu_t(dw).                              \tag{5}
$$
The same definitions with subscript P retain every proper power of every admitted prime. The positive-process theorem supplies a constant M independent of t,P with norm(Tt on E)<=M. On physical L1 its norm is one. Its bounded generator on both spaces is G=lambda I-F*.

## 2. A short-memory compensated commutator

For any causal BV density F with support in [L,infinity), define qF=F*a0 and
$$
d_F(u)=\tfrac12\int_0^\infty k(u+w)F(w)dw.
$$
The literal compact-source commutator JF=[C,F*] has kernel
$$
\begin{split}
J_F(v,u)={}&j(v)F(\sigma(v)-u)
-1_{u\ge L}A(u)F(v-\ell(u))\\
&+\tfrac12q_F(v)k(u)-a0(v)d_F(u),                              \tag{6}
\end{split}
$$
where j(v)=sqrt(e^v/(1+e^v)), sigma(v)=log(1+e^v), A(u)=(1-e^-u)^(-1/2), and ell(u)=log(e^u-1).

Here and below a signed BV density is allowed. Its absolute L1 and variation norms replace positive masses. There is an absolute constant such that
$$
\|J_F(\cdot,u)\|_1
\le Ce^{-u}\big(\|F\|_1+\operatorname{Var}(F)\big).              \tag{7}
$$
For u>=L split the first three terms exactly into
$$
(j-1)F(\sigma-u)
+[F(\sigma-u)-F(v-\ell(u))]
+(A(u)-1)[q_F/2-F(v-\ell(u))].
$$
Their respective L1 bounds are Ce^-u times the L1 norm, variation, and L1 norm of F. In the middle term both arguments are below the support when v<u. Otherwise their distance is at most 2e^-u. For a BV function the integrated maximal translation difference over a displacement interval of length h is at most h Var(F), by Tonelli applied to its variation measure. This justifies the variable shift. The first term can use the bounded Jacobian of sigma and |j-1|<=Ce^-v on its nonzero support v>=u. In the third term both qF/2 and the translate of F have L1 norm at most norm(F)1. Also |dF(u)|<=Ce^-u norm(F)1, because u+w>=L.

For 0<=u<L the first three terms instead equal j(v)F(sigma(v)-u)-qF(v)/2. Direct change of variable bounds their L1 norm by C norm(F)1. This covers the entire initial strip; it is bounded by the right side of (7) after enlarging C.

Equation (1), Cauchy--Schwarz and (7) now give a bounded extension
$$
J_F:E\longrightarrow L^1,\qquad
\|J_F\|\le C(\|F\|_1+\operatorname{Var}(F)).                    \tag{8}
$$
For compact sources the integral of JF is zero: both C and convolution by F preserve the appropriate finite charge, with convolution multiplying it by integral F. Density and continuity of integration on L1 extend this identity to every causal E source. In particular,
$$
\int J_F H=0,\qquad \|J_F-J_{F_P}\|_{E\to L^1}\le C/\log P.     \tag{9}
$$
No finite absolute charge of H is required.

## 3. Finite-time transport and both retained charge terms

Bounded-generator Duhamel on E, first on the core and then by extension, gives
$$
[C,T_t]H=\int_0^t T_{t-s}\,J_F\,T_s H\,ds.                    \tag{10}
$$
The sign is positive because G=lambda I-F* and Tt=exp(-tG). On the right the leftmost semigroup acts on physical L1, while the rightmost acts on E. Thus
$$
\|[C,T_t]\|_{E\to L^1}\le CMt,
\qquad \int[C,T_t]H=0.                                       \tag{11}
$$
The kernel on compact sources agrees with the literal commutator. E convergence then defines the completed commutator. For the actual source it also agrees locally with CTt a-Tt Ca: finite-age convolution only samples a bounded input interval, and the actual source is locally integrable.

The full successor response retains both rank-one terms:
$$
[S,T_t]f=[C,T_t]f+a0\,\delta(T_t f)-(T_t a0)\delta(f).          \tag{12}
$$
It is physical L1 for every causal E source, and its integral is exactly
$$
\boxed{\int[S,T_t]f=2\delta(T_t f)-2\delta(f).}                 \tag{13}
$$
The last term is the transported reference packet, with its actual negative coefficient when delta(f)>0. Dropping it would erase the signed response.

The probability coupling and (4) imply uniform E and L1 operator differences O(t/log P). Substituting these and (9) into (10) yields
$$
\|[C,T_t]-[C,T_{P,t}]\|_{E\to L^1}
\le C(t+t^2)/\log P,                                        \tag{14}
$$
and the same estimate for the full successor commutator, after adding the rank terms. Constants can be fixed for all t>=0 with the displayed polynomial time cost. Natural-source convergence in E therefore gives a joint N,P completion at every fixed t, with no order restriction.

## 4. Exponential decay of the relative charge and actual negative mass

For every w>=0, a change of variable gives
$$
\delta(D_w f)=\tfrac12\int_0^\infty k(u+w)f(u)du.
$$
When w>=L the kernel is positive and bounded by Ce^(-u-w). For 0<=w<L, its possible negative initial piece stays inside u<L, and its remaining tail has the same exponential bound. Equation (1) in either case proves
$$
|\delta(D_w f)|\le Ce^{-w}\|H\|_E.                            \tag{15}
$$
The finite initial strip is included in the constant, not deleted. Bochner integration in E and the exact Laplace transform of the probability law give
$$
\boxed{|\delta(T_t f)|\le C e^{-t\Phi(1)}\|H\|_E.}             \tag{16}
$$
Phi(1)>0. The finite-prime estimate holds with PhiP(1), and PhiP(1)>=Phi_{2}(1)>0 for every P>=2.

For the actual completed arithmetic source
$$
g(x)=1_{x\ge1}(\psi(x)-x)/x,
\qquad a(v)=e^{v/2}g(e^v),
$$
the [charge theorem](actual-successor-resonance-charge-cocycle.md) gives delta(a)=kappa>0. Combining (13) and (16) proves the unconditional finite-time signed response
$$
\boxed{\int[S,T_t]a=-2\kappa+O(e^{-t\Phi(1)}\|g\|_E).}        \tag{17}
$$
For every natural cutoff N>=2, the same exact identity has deltaN in place of kappa. The known bounds supN norm(gN)E<infinity and infN>=2 deltaN>0 show that one finite time threshold makes this integral strictly negative for every N>=2 and every finite prime cutoff P>=2, as well as the all-prime process.

This is a sign of an actual nonlinear history-averaged successor response. It is not a statement that its pointwise sign is everywhere negative, nor that the full bilinear readout has a sign.

## 5. The fixed-observation limitation and the next pairing

Every jump has age at least L. On a fixed age interval [0,V], the Poisson series therefore has at most floor(V/L) nonzero convolution terms. For any fixed locally bounded actual source, Tt f on that interval tends to zero at an exponential rate times a polynomial in t. The same holds for STt f-Tt Sf, allowing the input endpoint sigma(V). Thus the negative mass in (17) is transported to increasing ages; it is not automatically visible in a fixed observation.

The precise decomposition to use in a bilinear test b is
$$
\langle b,[S,T_t]a\rangle
=\langle b,[C,T_t]a\rangle
+\delta(T_t a)\langle b,a0\rangle
-\kappa\langle b,T_t a0\rangle.                              \tag{18}
$$
The first term is a signed L1 remainder with zero integral and bound O(t), the second decays exponentially, and the third is the explicit retained packet. For bounded b, every term is defined. Any stronger negative cross-work assertion must control the first pairing at the observation scale of the last packet, rather than infer it from zero total mass. This isolates a concrete further estimate while preserving the proved arithmetic sign.

## 6. Strict sign at every positive time from the actual scalar law

The [exact scalar charge law](actual-source-causal-charge-law.md) supplies the exact actual-source formula
$$
 Q_{\rm rel}(t)=\delta(T_ta)=e^{-\lambda t}-\sum_{j\ge1}b_j e^{-t\Phi(j)},\qquad
 b_j>0,\quad\sum_jb_j=1-\kappa,\quad0<\Phi(j)<\lambda.
$$
Consequently Qrel(t)<=kappa exp(-lambda t), with strict inequality when t>0. Equation (13), whose L1 completion is proved here, therefore gives
$$
 \int[S,T_t]a<-2\kappa(1-e^{-\lambda t})<0\qquad(t>0).       \tag{19}
$$
This corollary consumes their scalar derivation rather than repeating it. The [natural-cutoff proof](natural-cutoff-positive-history-charge.md) establishes strict negative mass uniformly over every $N\ge2$, every finite or infinite prime cutoff $P\ge2$, and every positive time. Section 4 retains the separate exponential-decay method for the eventual sign.

The finite-activity compound-Poisson framework is classical; see Schilling–Song–Vondraček, [*Bernstein Functions*, chapters 3 and 5](https://motapa.de/bernstein_functions/index.shtml). Duhamel here uses the specified two output spaces and the actual BV density, rather than a general signed-energy contraction. No operator theorem in this chapter is claimed formalized in Lean.
