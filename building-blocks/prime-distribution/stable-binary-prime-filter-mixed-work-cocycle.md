# A stable binary inverse with an exact prime-filter mixed-work cocycle

This consumes the complete-history construction's stable future binary inverse and dyadic causal
prime-filter identity. It proves an admission-uniform work relation in
the original critical-age L2 metric, including its clock port. It does
not sign the remaining cofactor work or prove RH. Written proof,
independent review pending; no Lean or novelty claim.

Use the literal actual factorial forcing f and B=f-2f(./2), the actual
κ=1+γ_E, and the causal half-line profiles

$$
 c(v)=e^{-v/2}f(e^v),\quad b(v)=e^{-v/2}B(e^v),\quad
 d(v)=c(v)+\kappa e^{v/2},\qquad v\ge0.
$$

The stable-inverse theorem gives b,d in L2. Put L=log2, r=2^{-1/2},
Qh(v)=h(v-L)1_{v>=L}, Rh(v)=h(v+L), and

$$
 U=-\sum_{j\ge1}r^jR^j,\qquad \|U\|\le\sqrt2+1,
 \quad D=I-\sqrt2Q,\quad \chi(v)=e^{v/2}1_{[0,L)}(v).
$$

The sum converges in operator norm. Since RQ=I, direct telescoping
gives UD=I on L2. In particular D is bounded below by sqrt2-1.
The actual forcing equation is Dc=b and Dd=b+κχ. Since Uχ=0,
d=Ub. The initial cell is part of this equation.

For a finite admitted prime set S, write

$$
 M_S=\prod_{p\in S}(I-p^{-1/2}Q_{\log p}),\quad
 C_S=\prod_{p\in S}(1-p^{-1}),\quad
 g_S=M_Sb,\quad d_S=M_Sc+\kappa C_Se^{v/2}.
$$

Each causal prime shift is a half-line isometry. M_S is bounded on L2,
but c itself has its actual non-L2 growth. The expression defining d_S
must therefore be interpreted through the finite sum before claiming
membership.

## Stable reconstruction and the complete cofactor port

Let Q_S=product_{p in S}p and H_S=log Q_S. Finite exact division gives

$$
 M_Sc(v)=e^{-v/2}\sum_{\substack{m\mid Q_S\\m\le e^v}}
                     \mu(m)f(e^v/m).
$$

For v>=H_S every term is admitted. Stirling's actual boundary then
gives e^{-v/2}M_Sc(v)=-κC_S+O_S((1+v)e^{-v}). Thus d_S is L2
and has no residual growing homogeneous branch. D commutes with M_S,
so

$$
 Dd_S=g_S+\kappa C_S\chi.                                \tag{1}
$$

Applying U and Uχ=0 proves the exact reconstruction

$$
 d_S=Ug_S.                                               \tag{2}
$$

This is uniform in S as an inverse bound, although it gives no uniform
bound on its actual forcing g_S. The exact failure of commuting U
through the prime history is

$$
 UM_Sb-M_Sd
 =\kappa e^{v/2}\left[C_S-
        \sum_{\substack{m\mid Q_S\\m\le e^v}}\frac{\mu(m)}m\right]
 =\kappa e^{v/2}\sum_{\substack{m\mid Q_S\\m>e^v}}\frac{\mu(m)}m.
                                                               \tag{3}
$$

This signed cofactor port has compact support [0,H_S]. All terminal
histories are retained. Its coefficients cannot be replaced by a
positive prime-only loading.

## The complete process produces a specific clock port

Let T_s be the complete positive causal age law from the actual seed,
acting by convolution on zero-extended half-line L2. It is a contraction
and commutes with every causal shift, hence with D and M_S. It does
not commute with the future inverse U. From (1),

$$
 DT_sd_S=T_sg_S+\kappa C_ST_s\chi=:k_{S,s}.                \tag{4}
$$

Applying UD=I gives the exact clock commutator on this actual family:

$$
 T_sUg_S-UT_sg_S=\kappa C_SUT_s\chi.                     \tag{5}
$$

The right side generally does not vanish: although Uχ=0, the complete
causal process spreads χ into future ages. Its coefficient is the
actual Euler cofactor mass C_S, rather than a free compensating scalar.

For h=T_sd_S, the critical binary shift yields

$$
 \|k_{S,s}\|^2=3\|h\|^2-2\sqrt2\Re\langle h,Qh\rangle.  \tag{6}
$$

Consequently

$$
 (3-2\sqrt2)\|h\|^2\le\|k_{S,s}\|^2
                  \le(3+2\sqrt2)\|h\|^2.                \tag{7}
$$

These constants do not depend on the admitted generators, history
depth, source cutoff, or process clock. The original metric is used.
The forcing on the left is the corrected actual forcing in (4).

## Admission work and multiscale clocks retain one coherent mixed term

Take a finite increasing prime-set path S_0,...,S_J and nondecreasing
common clocks t_0,...,t_{J-1}. At admission j define

$$
 W_j=\|T_{t_j}d_{S_{j+1}}\|^2-\|T_{t_j}d_{S_j}\|^2,
 \quad B_j=\|k_{S_{j+1},t_j}\|^2-\|k_{S_j,t_j}\|^2,
$$
$$
 R_j=\Re\langle T_{t_j}d_{S_{j+1}},QT_{t_j}d_{S_{j+1}}\rangle
     -\Re\langle T_{t_j}d_{S_j},QT_{t_j}d_{S_j}\rangle.
$$

The exact signed work relation is

$$
 B_j=3W_j-2\sqrt2R_j.                                    \tag{8}
$$

If Δ_j=d_{S_{j+1}}-d_{S_j} and m_j=(d_{S_{j+1}}+d_{S_j})/2,
the mixed term contains both orders:

$$
 R_j=\Re\langle T_{t_j}m_j,QT_{t_j}\Delta_j\rangle
     +\Re\langle T_{t_j}\Delta_j,QT_{t_j}m_j\rangle.        \tag{9}
$$

In particular the innovation square is already included by midpoint
polarization; it is not silently lost. Moreover Δ_j=U(g_{S_{j+1}}-g_{S_j})
exactly, with the deterministic C_S port changing simultaneously in (4).

Let Γ[h,k] be the real polarized complete-process dissipation, with
Γ(h)>=0 and multiplier 2Re Φ(iξ). The bounded complete generator
licenses differentiation on all these L2 states. Q is an isometry for
Γ and commutes with its generator, so

$$
 |\Gamma[h,Qh]|\le\Gamma(h),\quad
 \Gamma(Dh)=3\Gamma(h)-2\sqrt2\Gamma[h,Qh].                \tag{10}
$$

Set h_in=T_{t_0}d_{S_0}, h_out=T_{t_{J-1}}d_{S_J}, and on each
intermediate clock interval set h_j(s)=T_sd_{S_j}. Exact telescoping
with the clock dissipation gives

$$
 \sum_{j<J}W_j=\|h_{out}\|^2-\|h_{in}\|^2+
 \sum_{j=1}^{J-1}\int_{t_{j-1}}^{t_j}\Gamma(h_j(s))ds,    \tag{11}
$$

and, retaining the mixed clock order,

$$
 \sum_{j<J}(B_j-3W_j)=-2\sqrt2\left[
 \Re\langle h_{out},Qh_{out}\rangle-
 \Re\langle h_{in},Qh_{in}\rangle+
 \sum_{j=1}^{J-1}\int_{t_{j-1}}^{t_j}
          \Gamma[h_j(s),Qh_j(s)]ds\right].                \tag{12}
$$

Thus the accumulated coherent mixed work obeys the admission-uniform
inequality

$$
 \left|\sum_{j<J}(B_j-3W_j)\right|
 \le2\sqrt2\left[\|h_{out}\|^2+\|h_{in}\|^2+
       \sum_{j=1}^{J-1}\int_{t_{j-1}}^{t_j}\Gamma(h_j(s))ds\right].
                                                               \tag{13}
$$

The corrected forcing action also controls the actual reconstructed
action with the same sharp binary constants:

$$
 (3-2\sqrt2)\sum_j\int\Gamma(h_j)
 \le\sum_j\int\Gamma(k_{S_j,s})
 \le(3+2\sqrt2)\sum_j\int\Gamma(h_j).                    \tag{14}
$$

No unsigned sum over individual prime coefficients appears in these
relations. The total admitted history is combined before evaluating
either work or dissipation. The remaining signed term is specifically
the adjacent binary-age dissipation covariance, not an arbitrary norm.

## A local dyadic cocycle linking ordinary succession and prime admission

There is a direct relation to the complete-history construction's positive first-arrival correction.
Let P_0>2, P_j=2^jP_0, I_j=[log P_j,log P_j+L], and let d_j=d_{p<=P_j}.
Glue a finite block field X=sum_{j=0}^J 1_{I_j}d_j. Apart from endpoints
of measure zero, on each I_j with j>=1,

$$
 DX=g_{p\le P_j}+\sqrt2 Q(d_j-d_{j-1}).                  \tag{15}
$$

There is no origin χ on those blocks. On the preceding block I_{j-1},
the actual first-arrival identity says exactly

$$
 d_j-d_{j-1}=\delta_{P_{j-1}}+
       \kappa(C_{p\le P_j}-C_{p\le P_{j-1}})e^{v/2},     \tag{16}
$$

where δ_P(v)=e^{v/2}sum_{P<p<=e^v}1/p on I_P. This includes every
actual admitted endpoint. Equation (15) is therefore a multiscale
forcing identity containing the positive new-prime loading and its
negative Euler-mass change in the same adjacent-age transport.

For the full compact glued field, (6) holds with h=X and k=DX, and
Re<X,QX> is the sum of adjacent-block mixed orders. Applying T_s after
gluing preserves that complete identity because D commutes with T_s.
No window/process commutation is asserted. The left initial port and
the right extra block DX=-sqrt2 QX beyond the last I_J must remain in
the whole norm. Restricting (15) to the interior and dropping either
port would change the work relation.

## Exact limitations and a ruled-out global bound

Binary stabilization removes amplification from the binary inverse.
It does not bound the actual Möbius prime-filter forcing g_S. For p<=P,
d_S(v)=a(v)+κC_Se^{v/2} whenever e^v<=P, where
a(v)=e^{-v/2}E(e^v) is the original actual source. The additional field
is a real deterministic cofactor boundary, not part of a.

Uniform global L2 boundedness of g_{p<=P} is false. If it held, (2)
would bound d_{p<=P} uniformly. Since C_{p<=P} tends to zero, pointwise
convergence and Fatou would put the actual a in global L2. But a is
not L2: its Laplace transform has a nonzero simple boundary pole at
every actual critical zero, whereas an L2 Laplace transform is bounded
by ||a||_2/sqrt(2σ) at σ+iγ. A nonzero pole grows as 1/σ. If off-critical
zeros exist, their interior poles contradict L2 holomorphy even earlier.
Thus no RH assumption repairs this proposed global forcing bound.

Weighted/growing-clock or localized compensated-action targets remain
available. Equations (12), (15), and (16) specify the coherent mixed work
they must control. These are Hilbert-space quadratic relations for the
actual causal prime filter. They are not a pole-null compact Weil scalar,
do not restore the opposite-shift denominator, and give no license to
identify positivity of a norm with the linear signed source pairing.
