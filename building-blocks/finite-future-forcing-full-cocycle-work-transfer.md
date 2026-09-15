# Finite future forcing controls the full cocycle tail at squared-log depth

This is a structural deduction for the actual fixed compact full-factor
integer cocycle. It consumes the exact factorial forcing, the stable
binary inverse, and the actual full-factor scalar transport. It gives
power-small future truncation and absolutely summable signed-work
transport. It does not bound the remaining upper signed-work budget.
Written research proof; independent review and Lean formalization remain. No priority claim is made.

Keep the actual real pole-null packet φ, its correlation C=C_φ, full
digamma row a_φ, and full even Weil translation kernel k_φ from Agent
3's fixed-pair consumer. Let d be the support radius of C, T_n=log n+c,
and

$$
 \widehat C_n=k_\phi(T_n)+r_n,\qquad r_n=O_\phi(n^{-5/2}).  \tag{1}
$$

Equation (1) is the already-proved scalar transport of the compact
full scattering filter. Its error includes the opposite-shift
denominators and complete histories. The representation below is of
that scalar, not a replacement of the full filter by its causal
numerator as an operator.

## The fixed compact observation removes the cofactor growth exactly

Put a(v)=e^{-v/2}E(e^v), causal. As distributions on the age line,

$$
 (\partial_v+1/2)a=
   \sum_{m\ge2}\frac{\Lambda(m)}{\sqrt m}\delta_{\log m}
   -e^{v/2}1_{v\ge0}-\delta_0.                           \tag{2}
$$

This retains the actual seed E(1)=-1 and every prime power. For T>d,
the negative arithmetic orientation vanishes by support, while the
continuous term in (2) vanishes after convolution with C because
int e^{-u/2}C(u)du=0. The seed term is C(T)=0. Therefore the complete
row has the exact linear representation

$$
 k_\phi(T)=a_\phi(T)-\langle a,h_T\rangle,
 \qquad h_T(v)=C'(T-v)+\tfrac12C(T-v).                    \tag{3}
$$

Here h_T is compact smooth on [T-d,T+d], has fixed L1 and L2 norms,
and is literally null at both pole moments. For example,

$$
 \int e^{v/2}h_T(v)dv
 =e^{T/2}\int e^{-u/2}[C'(u)+C(u)/2]du=0.
$$

The other moment follows by integration by parts. Its mean is also
zero because the original φ has zero mean. No quadratic Weil
positivity is asserted for this linear test.

Use the actual factorial source f(y)=-κy+ε(y), κ=1+γ_E, where
|ε(y)|<=C(1+log y) for y>=1. Its binary forcing is B=f-2f(./2).
Let c(v)=e^{-v/2}f(e^v) and b(v)=e^{-v/2}B(e^v). For all primes
through P define the complete finite causal prime filter

$$
 M_P=\prod_{p\le P}(I-p^{-1/2}Q_{\log p}),\quad
 C_P=\prod_{p\le P}(1-p^{-1}),\quad
 g_P=M_Pb,\quad d_P=M_Pc+\kappa C_Pe^{v/2}.
$$

The preceding stable-binary mixed-work note proves d_P in L2 and
d_P=Ug_P, where U=-sum_{j>=1}2^{-j/2}R_{jlog2}. If P>=e^{T+d},
complete divisor inversion gives M_Pc=a throughout the support of h_T.
Consequently pole nullity removes the actual deterministic field:

$$
 \langle d_P,h_T\rangle=\langle a,h_T\rangle.             \tag{4}
$$

Thus the large global cofactor growth obstructing a uniform d_P norm
does not contaminate this particular actual compact scalar.

## A Rankin bound for the entire finite-history future boundary

Let Q_P=product_{p<=P}p. Finite expansion, including all squarefree
cofactors and the true terminal condition, gives for x=e^v>=1

$$
 d_P(v)=x^{-1/2}\sum_{\substack{m\mid Q_P\\m\le x}}
       \mu(m)\varepsilon(x/m)
       +\kappa\sqrt x\sum_{\substack{m\mid Q_P\\m>x}}\frac{\mu(m)}m.
                                                               \tag{5}
$$

For 0<θ<=1/2, 1+log y<=C y^{1-θ} uniformly for y>=1. Rankin's
elementary inequality applied separately to both sums in (5) proves

$$
 |d_P(v)|\le C x^{1/2-\theta}
             \prod_{p\le P}(1+p^{\theta-1}).              \tag{6}
$$

The same exponent pays both the factorial residual and the incomplete
Euler-cofactor port. Dropping the latter would give an invalid bound
before the full primorial history has been observed.

For P>=e^2 choose θ=1/log P. Since p^θ<=e and
sum_{p<=P}1/p<=sum_{m<=P}1/m<=1+log P, the entirely elementary bound is

$$
 \prod_{p\le P}(1+p^{\theta-1})\le e^eP^e.               \tag{7}
$$

A sharper prime harmonic estimate improves the constant but is
unnecessary. No PNT or RH input is used in (6)-(7).

For U_R=-sum_{j=1}^R2^{-j/2}R_{jlog2}, the exact future telescope is

$$
 d_P=U_Rg_P+2^{-R/2}R_{Rlog2}d_P.                       \tag{8}
$$

At every v<=log P, (6)-(7) imply

$$
 2^{-R/2}|d_P(v+R\log2)|
 \le C P^{e+1/2}\exp\left(-\frac{R\log2}{\log P}\right). \tag{9}
$$

For any A>0 set

$$
 R_A(P)=\left\lceil\frac{(A+4)(\log P)^2}{\log2}\right\rceil.
$$

Since e+1/2<4, the right side of (9) is O(P^{-A}). Pairing on the
fixed support of h_T gives the uniform scalar tail estimate

$$
 \left|\langle d_P-U_{R_A(P)}g_P,h_T\rangle\right|
 \le C_\phi P^{-A},\qquad T+d\le\log P.                 \tag{10}
$$

The future physical integer observations reach size at most
exp(O_A(log^2 P)). This is not a fast computation claim. The important
point is that the required future age is O(log^2 P), rather than the
total primorial delay, and that no unobserved future channel remains
larger than the displayed power-small scalar error.

## A compact, pole-null finite forcing test

Choose P_n=exp(T_n+d) and R_n=R_A(P_n). Define

$$
 H_n=U_{R_n}^*h_{T_n}
   =-\sum_{j=1}^{R_n}2^{-j/2}Q_{jlog2}h_{T_n},
$$
$$
 F_n=a_\phi(T_n)-\langle g_{P_n},H_n\rangle.              \tag{11}
$$

Every H_n is compact smooth, has zero mean and both literal pole
moments zero, and

$$
 \|H_n\|_2\le(\sqrt2+1)\|h_{T_n}\|_2.
$$

Its support is contained in [T_n+log2-d,T_n+R_n log2+d]. The infinite
future adjoint test in the stable-inverse note had a genuine noncompact
tail; (10) shows that the scalar admits these compact approximants with
controlled error. It does not claim their theta form norms are bounded.

The complete positive causal clock law also respects the tail bound.
The preceding binary note gives
D T_s d_P=T_sg_P+κC_PT_sχ, with χ=e^{v/2}1_[0,log2), so the finite
future telescope applied to this corrected forcing gives, uniformly
for every s>=0,

$$
 \langle T_sd_P,h_T\rangle=
   \langle T_sg_P,U_R^*h_T\rangle
   +\kappa C_P\langle T_s\chi,U_R^*h_T\rangle+O_\phi(P^{-A}).
                                                               \tag{11a}
$$

Indeed positive causal averaging preserves the exponential bound (6):
its extra factor is int e^{-(1/2-θ)u} μ_s(du)<=1. The clock port in
(11a) remains exact. Its absolute value is bounded by
κC_P(sqrt2+1)||χ||_2||h_T||_2, independently of T,s,R. At s=0 it
vanishes because U_Rχ=0. Equation (11a) does not identify a clocked
linear source observation with the quadratic full Weil scalar.

All coefficients are actual finite arithmetic. If desired the last
pairing is exactly

$$
 \langle g_{P_n},H_n\rangle
 =\left\langle b,
   \sum_{m\mid Q_{P_n}}\frac{\mu(m)}{\sqrt m}R_{\log m}H_n
   \right\rangle.                                      \tag{12}
$$

The half-line future shifts in (12) retain their initial truncation.
That final test need not remain pole-null after the prime adjoints;
no such claim is made. The forcing b is the exact actual factorial
binary forcing, including its origin cell and all powers.

Equations (1), (3), (4), and (10) give

$$
 \widehat C_n=F_n+e_n,\qquad
 |e_n|\le C_\phi(n^{-A}+n^{-5/2}).                       \tag{13}
$$

The complete archimedean row is retained in F_n. Complete full-factor
scattering is retained through the exact scalar bridge (1). Neither
denominator, mixed orientation, nor pole contribution is discarded.

## Absolute transport of the coherent upper-work question

Choose A>=3. From (13), e_n=O(n^{-5/2}) and Δe_n=O(n^{-5/2}),
without requiring smooth dependence of R_n or of admitted prime sets.
The existing Chebyshev bounds give |widehat C_n|=O(sqrt n) and
|Δwidehat C_n|=O(n^{-1/2}); hence the same value and increment bounds
hold for F_n. Write W_n^F=2F_nΔF_n and L_n^F=(ΔF_n)^2.
Exact expansion gives

$$
 \widehat W_n-W_n^F=
    2[e_n\Delta F_n+F_n\Delta e_n+e_n\Delta e_n],
$$
$$
 \widehat L_n-L_n^F=2\Delta F_n\Delta e_n+(\Delta e_n)^2.
$$

Therefore the absolute work and loading transport tails satisfy

$$
 \sum_{n\ge N}|\widehat W_n-W_n^F|=O_\phi(N^{-1}),
 \qquad
 \sum_{n\ge N}|\widehat L_n-L_n^F|=O_\phi(N^{-2}).        \tag{14}
$$

In particular the proved finite positive loading and the exact lower
work bound transfer to F. More significantly, the open UPPER coherent
work budget can now be studied in the finite actual forcing formula
(11)-(12), with no uncontrolled infinite-future error. This is an
actual approximation theorem, not an assumed equivalent upper bound.

## Route selected and the remaining obstruction

Binary stabilization alone does not pay the upper budget. The new
deduction rules out uncontrolled future depth and the deterministic
cofactor growth as the sole obstacles for this fixed pole-null scalar.
The surviving quantity is the coherent signed pairing of actual binary
forcing with the finite prime-adjoint test in (12), accumulated as
2F_nΔF_n. Its norm may grow with the admitted prime set; the stable
inverse does not bound it.

A finite phase/Pick construction can use this explicit finite family
without silently adding an infinite-future channel. Herglotz/Pick
positivity, locally bounded analytic continuation, or an upper coherent
work inequality for that family remains unproved. A modulus Gram or
the already-finite loading does not supply any of those properties.
Nor is (12) identified with the additive Goldbach heat norm. The odd
centered-input bridge and the complete high-zero tail estimate supplied
by the other workers can be combined only after their scalar/source
pairings are matched explicitly.
