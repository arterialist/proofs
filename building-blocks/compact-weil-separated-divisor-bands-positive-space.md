# Positive separated divisor bands at critical packet frequency

The [boundary-packet theorem](compact-weil-boundary-packet-growing-positive-space.md)
proves positivity on every resolved divisor label when the packet
frequency (T) grows faster than (N\asymp e^{2L}). Its scalar
off-center gamma estimate loses control at (T=cN). At that critical
frequency, one can still combine a low divisor band with the top half
of the labels. The low band has a logarithmic gamma surplus over its
prime cost. The top band has no internal prime edge, and its
off-center gamma loss has coefficient below one. The complete mixed
prime and pole blocks cost only (O(\sqrt{\log N})).

Fix (0<\alpha<1), (0<\delta<1), and (c>4). Let the fixed
real, nonnegative, (L^2)-normalized profiles be
(p_-\in C_c^\infty(-\delta,0)) and
(p_+\in C_c^\infty(0,\delta)). Put
\[
 L_N=\tfrac12\log(N+1),\qquad T_N=cN,\qquad
 x_n=L_N-\log n,\qquad
 f_{n,\sigma}(x)=\sqrt{T_N}\,p_\sigma(T_N(x-x_n)),
\]
\[
 M_N=\lfloor N^\alpha\rfloor,\qquad
 I_{\rm lo}=\{1,\ldots,M_N\},\qquad
 I_{\rm hi}=\{\lfloor N/2\rfloor+1,\ldots,N\}.
\]
Use the (-) profile at every retained label and the (+) profile
at every retained label except (1). For large (N), these packets
are orthonormal, supported in ((-L_N,L_N)), and their prime
compression is the exact divisor matrix. Write (V_{\alpha,N}) for
their span. It has dimension (N+2N^\alpha+O(1)).

**Theorem.** Let (Q_{L_N}) be the complete compact Weil form with
the actual gamma multiplier, both pole moments, and every admitted
von Mangoldt prime power. Set
\[
 \vartheta=\min\{1-\alpha,\ 1-4\delta/c\}>0.
\]
There is a constant (C), depending on the fixed profiles,
(\alpha,\delta,c), such that for all sufficiently large (N) and
all (f\in V_{\alpha,N}),
\[
 \boxed{\qquad
 Q_{L_N}(f)\ge
 \bigl(\vartheta\log N-C\sqrt{\log N}-C\bigr)\|f\|_2^2.
 \qquad} \tag{1}
\]
In particular (Q_{L_N}) is positive on this growing space for large
(N). The assertion concerns these separated labels, not the
omitted middle band or the full compact-test space.

## Exact prime blocks

The [divisor-matrix addendum](compact-weil-divisor-matrix-sharpness.md)
and the packet-support argument give the prime compression
(A_N\oplus A_N^{[2,N]}). On the low band, its norm is at most
(\log M_N+C_0). On the high band its diagonal block is zero:
if (m,n>N/2) are distinct, neither can be an integer multiple
(dn) of the other with (d\ge2).

The low-to-high block (B_p) has a smaller norm than the global
Schur bound. Use the positive weights (w_n=n^{-1/2}). For
(n\in I_{\rm lo}),
\[
 \frac{(B_pw)_n}{w_n}
 =\sum_{N/(2n)<d\le N/n}\frac{\Lambda(d)}d
 \le 2\frac{\psi(N/n)}{N/n}\le C_1. \tag{2}
\]
For (m\in I_{\rm hi}), the reverse row obeys
\[
 \frac{(B_p^*w)_m}{w_m}
 =\sum_{\substack{d\mid m\\m/d\le M_N}}\Lambda(d)
 \le\sum_{d\mid m}\Lambda(d)=\log m\le\log N.
 \tag{3}
\]
Weighted Schur therefore gives
(\|B_p\|\le\sqrt{C_1\log N}). The same block occurs in
each profile, with no mixed-profile prime entry. Equations (2)--(3)
retain the complete prime-power divisor packet.

## Gamma blocks at (T=cN)

Let (H(t)=\Re\psi(1/4+it/2)-\log\pi), and put
(q(t)=H(t)-\log(|t|/(2\pi))\). The digamma expansion at infinity
and the integrable logarithm at zero give (q\in L^1(\mathbb R)).
For a fixed pair of profiles, the matrix entry from (q(T_Nu)) is
(O(T_N^{-1})), uniformly in the two labels. The term (\log T_N)
is exactly (\log T_N I), because distinct packets have disjoint
support and the two profiles at one center are orthogonal. The
same-center remainder is a fixed bounded (2\times2) profile matrix.

For distinct centers, let (s=T_N\log(m/n)). The Fourier kernel of
(\log|u|) gives, as in the
[two-profile Perron calculation](compact-weil-two-profile-perron-crossover.md),
\[
 G_{\sigma\tau}(s)
 =-\frac12\iint
   \frac{p_\sigma(v)p_\tau(w)}{|s+v-w|}\,dv\,dw
 \qquad(|s|>2\delta). \tag{4}
\]
Every distinct-center separation satisfies (|s|>4\delta) for all
large (N). With (m_\sigma=\int p_\sigma\le\sqrt\delta),
(4) yields
\[
 |G_{\sigma\tau}(s)|
 \le\frac{m_\sigma m_\tau}{|s|}.
 \tag{5}
\]
For either band,
(|\log(m/n)|\ge |m-n|/N_{m band}), where
(N_{\rm band}=M_N) on the low band and (N) on the high band.
Summing (5) over both sides of a label and both profiles gives
\[
 \|\Gamma_{\rm lo}^{\rm off}\|
 \le\frac{4\delta M_N}{T_N}\log M_N+O(M_N/T_N)=o(1),
 \tag{6}
\]
\[
 \|\Gamma_{\rm hi}^{\rm off}\|
 \le\frac{4\delta N}{T_N}\log N+O(N/T_N)
 =\frac{4\delta}{c}\log N+O(1).
 \tag{7}
\]
The (O(1/T_N)) digamma remainder contributes (O(M_N/T_N))
and (O(N/T_N)) to these row sums. The fixed same-center matrix
contributes (O(1)).

Between the two bands,
(|\log(m/n)|\ge\log(N/(2M_N))
=(1-\alpha)\log N-O(1)). Equations (5) and the uniform
(O(1/T_N)) remainder give a Hilbert-Schmidt estimate
\[
 \|\Gamma_{\rm lo,hi}\|
 \le C\frac{\sqrt{M_NN}}{T_N}
       \left(1+\frac1{\log(N/(2M_N))}\right)=o(1).
 \tag{8}
\]
The (O(\log N)) high-band term in (7) cannot be replaced by
(O(1)) at critical frequency; its coefficient is what makes the
high-band margin positive.

## Both pole moments

For (a_\sigma^\pm(T)=\int p_\sigma(s)e^{\pm s/(2T)}ds), the
exact packet loadings are
\[
 E_+(f_{n,\sigma})
 =T_N^{-1/2}e^{L_N/2}a_\sigma^+(T_N)n^{-1/2},
 \qquad
 E_-(f_{n,\sigma})
 =T_N^{-1/2}e^{-L_N/2}a_\sigma^-(T_N)n^{1/2}.
 \tag{9}
\]
Since the profile integrals are bounded, their functional norms on
the two bands satisfy
\[
 \begin{array}{ll}
 \|E_+|_{\rm lo}\|^2=O(N^{-1/2}\log N),&
 \|E_-|_{\rm lo}\|^2=O(M_N^2N^{-3/2}),\\
 \|E_+|_{\rm hi}\|^2=O(N^{-1/2}),&
 \|E_-|_{\rm hi}\|^2=O(N^{1/2}).
 \end{array} \tag{10}
\]
The pole form is (2\Re(E_+\overline{E_-})). Its low diagonal
block has norm (O((M_N/N)\sqrt{\log N})=o(1)), its high diagonal
block has norm (O(1)), and its mixed block has norm
\[
 O(\sqrt{\log N})+O(M_N/N).
 \tag{11}
\]
The first term in (11) is real and cannot be called bounded:
(\|E_+|_{\rm lo}\|\asymp N^{-1/4}\sqrt{\log N}) and
(\|E_-|_{\rm hi}\|\asymp N^{1/4}) for the nonnegative
profiles. Both pole moments and their possibly signed quadratic
coupling remain in these norm bounds.

## The block lower bound

Write the exact complete Weil matrix on
(V_{\alpha,N}=V_{\rm lo}\oplus V_{\rm hi}) as
(\begin{psmallmatrix}D_{\rm lo}&B\\B^*&D_{\rm hi}\end{psmallmatrix}).
The prime, gamma, and pole estimates above give
\[
 D_{\rm lo}\succeq[(1-\alpha)\log N-C]I,
 \qquad
 D_{\rm hi}\succeq[(1-4\delta/c)\log N-C]I,
 \qquad \|B\|\le C\sqrt{\log N}+C.
 \tag{12}
\]
For (f=f_{\rm lo}+f_{\rm hi}), bound the mixed term by
(2\|B\|\|f_{\rm lo}\|\|f_{\rm hi}\|
\le\|B\|(\|f_{\rm lo}\|^2+\|f_{\rm hi}\|^2)).
This proves (1). It is an unconditional signed theorem on a
subspace of dimension (N+2N^\alpha+O(1)) at (T=cN). The middle
labels, possible overlapping packets when (T/N\to0), and the
actual full-window Weil sign remain outside its scope. No Lean
formalization or RH proof is claimed.
