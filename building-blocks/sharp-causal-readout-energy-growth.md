# Sharp growth of the complete causal readout in additive energy

The complete physical harmonic/filter form is bounded on the causal additive-energy space at each fixed observation time. Its operator norm grows exactly on the scale $e^{t/2}$. Both signs occur on bounded-energy synthetic histories at this scale, even after the harmonic coefficients and causal filter have been retained. This determines the cost of an estimate using only the energy norm; it does not determine the sign on the actual arithmetic source.

Let $\mathcal E_c$ denote the closed subspace of the anchored positive-support energy completion whose representatives vanish below $x=1$. The exact boundary-energy decomposition in [additive-energy-reflection-domain.md](additive-energy-reflection-domain.md), equations (15)–(19), gives
$$
\int_1^\infty |f(x)|^2\frac{dx}{x}\le\|f\|_{\mathcal E}^2,
\qquad f\in\mathcal E_c.
\tag{1}
$$
Thus $\beta_f(v)=f(e^v)$, extended by zero to $v<0$, belongs to $L^2(dv)$, with norm at most $\|f\|_{\mathcal E}$. The critical logarithmic history is still $a_f(v)=e^{v/2}\beta_f(v)$; no global $L^2$ norm is asserted for it.

For real causal histories define the physical symmetric bilinear form
$$
b_s(f,h)=e^{s/2}(\beta_f*\beta_h)(s)
=e^{s/2}\int_1^{e^s}f(x)h(e^s/x)\frac{dx}{x},\qquad s\ge0.
\tag{2}
$$
Cauchy–Schwarz gives
$$
|b_s(f,h)|\le e^{s/2}\|f\|_{\mathcal E}\|h\|_{\mathcal E}.
\tag{3}
$$
The convolution of two $L^2$ functions has a continuous bounded representative, so (2) defines a continuous readout at every finite $s$, not just almost everywhere. All statements below concern the real Hilbert space of real histories; complex bilinear extension is possible without replacing the readout by a modulus square.

Retain the complete harmonic sum and filter:
$$
\mathcal Q_t(f,h)=\sum_{d\le e^t}\frac{b_{t-\log d}(f,h)}d
-\int_0^t e^{-3(t-v)/2}\sum_{d\le e^v}\frac{b_{v-\log d}(f,h)}d\,dv.
\tag{4}
$$
Every sum is the literal finite sum at its observation point. Formula (3) yields
$$
\begin{split}
|\mathcal Q_t(f,h)|
&\le \zeta(3/2)\left[e^{t/2}
+\int_0^t e^{-3(t-v)/2}e^{v/2}\,dv\right]
\|f\|_{\mathcal E}\|h\|_{\mathcal E}\\
&=\zeta(3/2)e^{t/2}\left[1+\frac{1-e^{-2t}}2\right]
\|f\|_{\mathcal E}\|h\|_{\mathcal E}.
\end{split}
\tag{5}
$$
In particular its representing selfadjoint operator $Q_t$ on the real causal energy space satisfies
$$
\boxed{\|Q_t\|\le\frac32\zeta(3/2)e^{t/2}.}
\tag{6}
$$
This is a representation of the original physical readout through its continuous bilinear form. It does not identify $Q_t$ with the unmodified reciprocal reflection acting in $\mathcal E$.

## The exponential scale is necessary, with either sign

Fix $0<\delta<\tfrac12\log2$. Choose a nonzero real smooth $F$ supported in $(-\delta,\delta)$, first even and then odd. Set
$$
f_t(x)=F(\log x-t/2),\qquad H=F*F.
\tag{7}
$$
For $t>2\delta$, these are smooth compact causal histories. Their translated logarithmic profiles give the exact physical convolution
$$
b_s(f_t,f_t)=e^{s/2}H(s-t).
\tag{8}
$$
For every $0\le v\le t$ and every $d\ge2$, the argument of $H$ in $b_{v-\log d}$ is at most $-\log2<-2\delta$. Therefore all those harmonic terms vanish by their actual supports. The $d=1$ term and the full filter remain, giving exactly
$$
\boxed{\mathcal Q_t(f_t,f_t)
=e^{t/2}\left[H(0)-\int_0^{2\delta}e^{-2u}H(-u)\,du\right].}
\tag{9}
$$
The discarded harmonic terms here are zero by support, not approximated or omitted. Also $|H(u)|\le\|F\|_2^2$. For even $F$, $H(0)=\|F\|_2^2$, so the bracket in (9) is at least $\tfrac12\|F\|_2^2>0$. For odd $F$, $H(0)=-\|F\|_2^2$, so it is at most $-\tfrac12\|F\|_2^2<0$.

These histories have bounded, nonvanishing energy as $t\to\infty$. To verify this, put $f_0(x)=F(\log x)$, extended by zero to negative $x$, and $a=e^{-t/2}$. Since $f_t(x)=f_0(ax)$, the exact Fourier scaling is
$$
\|f_t\|_{\mathcal E}^2
=\int_{\mathbb R}\frac{m(a\xi)}a|\widehat f_0(\xi)|^2d\xi
\longrightarrow\pi\int_{\mathbb R}|\xi|\,|\widehat f_0(\xi)|^2d\xi\in(0,\infty).
\tag{10}
$$
Dominated convergence follows from $m(a\xi)/a\le C|\xi|$ and smooth compact support of $f_0$. After normalization, (9)–(10) give constants $c_+,c_->0$ and unit-energy causal histories $f_t^+,f_t^-$ such that, for sufficiently large $t$,
$$
\mathcal Q_t(f_t^+,f_t^+)\ge c_+e^{t/2},\qquad
\mathcal Q_t(f_t^-,f_t^-)\le-c_-e^{t/2}.
\tag{11}
$$
Together with (6), this proves
$$
\boxed{\|Q_t\|\asymp e^{t/2},}
\tag{12}
$$
and both the positive and negative quadratic extremal values have that scale. It is therefore impossible to replace (6) by a bound polynomial in $t$ on the whole causal energy space.

The complete arithmetic quantities use the [harmonic-convolution normalization](harmonic-convolution.md):

$$
T(x)=\sum_{p^j\le x}(x-p^j)(j-1)(\log p)^2,\qquad
S_{\rm crit}(x)=\sum_{d\le x}\sqrt d\,T(x/d),\qquad
s_{\rm crit}(t)=e^{-3t/2}S_{\rm crit}(e^t).
$$

Here $W$ is exactly the complete sum in the [actual sign criterion](actual-critical-sign-criterion.md). The harmonic-convolution theorem proves its full identity and $s_{\rm crit}(t)=t^2/6+O(t)$ without discarding prime powers.

For the actual arithmetic source the exact criterion remains
$$
e^{-3t/2}W(e^t)=\mathcal Q_t(g,g)-s_{\rm crit}(t).
\tag{13}
$$
The same-prime quantity here is literal and includes all proper powers; it has not been replaced by an asymptotic in the identity. It is a fixed scalar subtraction, so it does not alter the bilinear operator norm (12). Its already established growth $s_{\rm crit}(t)=t^2/6+O(t)$ also means that the synthetic unit-energy examples in (11) continue to give opposite signs after this same scalar is subtracted, for large $t$. They are not the arithmetic source and make no sign assertion about $W$.

The complete two-port identity in [paired-metric-conservation-and-source-ports.md](paired-metric-conservation-and-source-ports.md), equations (10)–(12), expresses (13) with the actual transported storage and both ports. Their sum is exactly the same $\mathcal Q_t(g,g)$. Hence an improvement along the arithmetic source must use that source or the retained relations between its histories; positivity or boundedness of its additive energy alone cannot improve the sharp whole-space scale (12).

All domain, transport and readout assertions in this note are written mathematics. They make no Lean or arithmetic-sign claim.
