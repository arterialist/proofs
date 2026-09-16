# Microscopic anti-concentration of the actual theta ground at every large radius

Let \(G_R=\Phi\psi_R1_{O_R}\) be the physical history of the actual normalized even positive killed theta ground, and put \(q_R=\|G_R\|_2^2\). This written theorem keeps every prime power and applies at every sufficiently large real radius. Set
\[
 L_R=R^{-2},\qquad T_R=R+L_R,\qquad x_R=e^{2R}.
\]
There are absolute constants \(C,R_0\) such that, for \(R\ge R_0\), every interval \(I\) contained in either \((R,T_R)\) or \((-T_R,-R)\) with \(|I|\le1/(4x_R)\) satisfies
\[
 \boxed{\qquad\frac{\|1_I G_R\|_2^2}{q_R}\le\frac C{R^2}.\qquad} \tag{0}
\]
The complete midpoint windows in the [moving integer-log gap test](theta-ground-moving-log-gap-arrival-inequality.md) have two components of length asymptotic to \(1/(8x_R)\) and lie in this collar eventually. Thus (0) also bounds their total physical \(L^2\) mass fraction by \(2C/R^2\). This anti-concentration estimate does not bound the effective width, \(\delta_R/H_R^2\), the full affine covariance, or RH.

## Localized actual-ground equation

By evenness it suffices to take \(I\subset(R,T_R)\). Put \(F=1_I G_R\), \(Q=G_R-F\), \(q_F=\|F\|_2^2\), \(q_Q=\|Q\|_2^2\). The complete prime-power physical translation operator is
\[
 S=\sum_{m\ge2}\frac{\Lambda(m)}{\sqrt m}
       (\tau_{\log m}+\tau_{-\log m}).
\]
Every prime displacement has length at least \(\log2\), while \(|I|<\log2\). Thus \(\langle F,SF\rangle=0\).

The exact hard-interval argument in the [moving-gap source test](theta-ground-moving-log-gap-arrival-inequality.md) applies to any such \(I\). With unitary Fourier normalization,
\[
 \int_{|\xi|\le M}|\widehat F(\xi)|^2d\xi
 \le \frac{M|I|}{\pi}q_F.
\]
Take \(M=\pi/(4|I|)\). The low-frequency mass is at most \(q_F/4\); the digamma multiplier is bounded below and is \(\log|\xi|+O(1)\) at high frequency. Since \(|I|\le e^{-2R}/4\),
\[
 \langle F,AF\rangle\ge(3R/2-C_A)q_F.                 \tag{1}
\]
The bounded commutator of \(A\) with one interval indicator has norm at most \(2\pi\), hence
\[
 |\langle F,AQ\rangle|\le2\pi\sqrt{q_Fq_Q}.           \tag{2}
\]
It also justifies the hard projection in the logarithmic form domain. Test the actual weak exterior equation \(AG_R=SG_R-\delta_R\mathsf JG_R\), where \(\delta_R>0\) and \(\mathsf J=b_\theta/\Phi>0\), by \(F\). Equations (1)–(2) and the zero self-prime sample give
\[
 \langle F,SQ\rangle\ge(3R/2-C_A)q_F
       -2\pi\sqrt{q_Fq_Q}+\delta_R\int_I\mathsf JF^2. \tag{3}
\]
All arrival pairings here are nonnegative.

## Integer spacing bounds the near arrival

Split \(Q=Q_{\rm near}+Q_{\rm far}\) at \(|u|=T_R\). No same-half prime shift joins two points in \(A_{R,T_R}=\{R<|u|<T_R\}\), because \(L_R<\log2\). A label \(m\) carrying \(F\) to the negative near collar must satisfy
\[
 e^{2R}<m<e^{2T_R}=x_Re^{2L_R}.                     \tag{4}
\]
This interval contains at most \(x_R(e^{2L_R}-1)+1\le Cx_RL_R\) integers for all large \(R\). Each has \(m\ge x_R\) and \(\Lambda(m)\le\log m\le3R\). Consequently
\[
 \sum_{m\ {\rm relevant}}\frac{\Lambda(m)^2}{m}
       \le C R^2L_R=C.                              \tag{5}
\]
Proper prime powers are included. The translated intervals \(I-\log m\) are pairwise disjoint: their width is at most \(1/(4x_R)\), whereas consecutive integer logarithms below \(2x_R\) are separated by at least \((1+o(1))/(2x_R)\). Translation isometry and this disjointness yield
\[
 \|1_{A_{R,T_R}}SF\|_2^2\le Cq_F,\qquad
 0\le\langle F,SQ_{\rm near}\rangle
       \le C\sqrt{q_Fq_Q}.                          \tag{6}
\]
No prime-number-theorem estimate is needed for (5).

## Two-endpoint theta decay removes the remote arrival

Let \(w_R=e^{-\sqrt R/8}\) and \(T_0=R+6w_R\). The proved [actual normalized and physical concentration](theta-ground-physical-mass-concentration.md) gives \(\|\psi_R1_{O_{T_0}}\|_\nu\to0\). Since \(\|\psi_R\|_\nu=1\) and \(\omega^2=\Phi/b_\theta\) eventually decreases,
\[
 q_R=\int\omega^2\psi_R^2\,d\nu\ge\tfrac12\omega(T_0)^2. \tag{7}
\]
The physical remote-prime pairing equals that of the corresponding normalized pieces under the theta prime operator, and both normalized norms are at most one. The prime estimates (5) and (8) in the [sharp internal/exterior crossing theorem](theta-internal-exterior-crossing-sharp-bound.md) give
\[
 0\le\langle F,SQ_{\rm far}\rangle
    \le48e^{T_R}\Omega(R)\Omega(T_R),\quad
 \Omega(s)=\sqrt8\pi e^{2s}e^{-(\pi/2)e^{2s}}.       \tag{8}
\]
The lower theta envelope is \(\omega(T_0)^2\ge\pi^2e^{4T_0}e^{-\pi e^{2T_0}}\). Therefore
\[
 \log\frac{96e^{T_R}\Omega(R)\Omega(T_R)}{\omega(T_0)^2}
 \le-\frac\pi2[1+e^{2L_R}-2e^{12w_R}]e^{2R}+O(R).  \tag{9}
\]
Because \(w_R=o(R^{-2})\), the bracket is \(2R^{-2}(1+o(1))\). The right side is at most \(-c e^{2R}/R^2\) for an absolute \(c>0\) and all large \(R\). Hence
\[
 \langle F,SQ_{\rm far}\rangle/q_R
       \le\exp(-c e^{2R}/R^2).                      \tag{10}
\]

Drop the positive last term in (3), use \(q_Q\le q_R\), and combine (6) and (10). For \(f=q_F/q_R\), once \(3R/2-C_A\ge R\),
\[
 Rf\le C\sqrt f+\exp(-c e^{2R}/R^2).
\]
Setting \(y=R\sqrt f\) gives \(y^2\le Cy+R\exp(-c e^{2R}/R^2)\), so \(y\) is bounded uniformly in \(I\) and \(R\). This proves (0). The \(R^{-2}\) rate arises from the bounded hard-boundary commutator after the near-prime cost has become bounded. The result is written analysis; no Lean formalization of this ground-state estimate is claimed.
