# Exact additive heat dissipation, origin flux, and signed birth remainder

This note computes the complete prime-history generator on the actual
additive heat source. Global process dissipation has a sign. Finite heat
horizons retain a subtractive origin-memory flux, and ordinary cutoff
succession retains a signed birth pairing. Neither the positive generator
nor the factorial ground identities sign the resulting scale remainder.

Write $\ell(a)\,da$ for the complete positive finite Lévy measure,
$\lambda=\int_0^\infty\ell(a)\,da$, and
$$
\Phi(z)=\int_0^\infty(1-e^{-za})\ell(a)\,da,\qquad
T_s=\exp(-s\mathsf A),\quad
\mathsf A h=\lambda h-\int_0^\infty\tau_a h\,\ell(a)\,da,
$$
where $\tau_a h(v)=h(v-a)$. Every prime depth, the full continuous
Lévy density, and the no-jump atom of $T_s$ remain.

For compactly supported finite real signed $\nu$ on $[1,\infty)$,
define
$$
F_\nu(t)=\int e^{-tx}\nu(dx),\qquad
h_\nu(v)=e^{-v/2}F_\nu(e^{-v}),\qquad h_s=T_sh_\nu.
\tag{1}
$$
The [max-to-sum transfer](max-sum-process-transfer.md) proves
$$
\mathcal S_s(\nu)=\|h_s\|_2^2
=\frac1{2\pi}\int
e^{-2s\rho(\xi)}\frac{\pi|\widehat\mu(\xi)|^2}{\cosh(\pi\xi)}\,d\xi,
\quad \rho(\xi)=\Re\Phi(i\xi),\quad
\mu(du)=e^{-u/2}\nu(de^u).
\tag{2}
$$

## 1. Global generator energy and the centered two-history source

Bounded-generator differentiation gives
$$
\boxed{
-\frac d{ds}\mathcal S_s(\nu)
=2\Re\langle h_s,\mathsf A h_s\rangle
=\int_0^\infty\ell(a)\|h_s-\tau_a h_s\|_2^2\,da\ge0.
}
\tag{3}
$$
To verify the last equality, expand each square and use the whole-line
translation isometry. Absolute Fubini follows from
$\|h_s-\tau_a h_s\|^2\le4\|h_s\|^2$ and $\ell\in L^1$.
Spectrally, the same identity is
$$
-\frac d{ds}\mathcal S_s(\nu)
=\frac1{2\pi}\int 2\rho(\xi)e^{-2s\rho(\xi)}
\frac{\pi|\widehat\mu(\xi)|^2}{\cosh(\pi\xi)}\,d\xi.
\tag{4}
$$

If $F_s(t)=t^{-1/2}h_s(-\log t)$, then translation of $h_s$
is multiplicative dilation of this signed heat amplitude. Thus
$$
-\frac d{ds}\mathcal S_s(\nu)
=\int_0^\infty\ell(a)\int_0^\infty
|F_s(t)-e^{a/2}F_s(e^at)|^2\,dt\,da.
\tag{5}
$$
The amplitude itself has the complete-history formula
$$
F_s(t)=\int e^{a/2}F_\nu(e^at)\,\eta_s(da),\qquad t>0,
\tag{6}
$$
with $\eta_s$ the full process law. This integral is finite: compact
support in $[1,\infty)$ bounds its absolute integrand by
$\|\nu\|_{\rm TV}e^{a/2}e^{-te^a}$. No positive age moment is used.

The centered two-history source is
$\Gamma_s(r)=\int h_s(v)h_s(v+r)\,dv$. Its exact symmetric generator
is
$$
\boxed{
\partial_s\Gamma_s(r)=\int_0^\infty\ell(a)
[\Gamma_s(r-a)+\Gamma_s(r+a)-2\Gamma_s(r)]\,da.
}
\tag{7}
$$
It follows by differentiating both factors. The complete difference-age
law convolves the original $\Gamma_0$, and (3) is (7) at $r=0$.
The correlation $\Gamma_s(r)$ itself need not be positive.

## 2. Finite horizons keep the origin-memory flux

For $E_T(s)=\int_0^T|h_s(v)|^2\,dv$, direct square expansion gives
$$
\boxed{\begin{aligned}
-\partial_sE_T(s)
={}&\int_0^\infty\ell(a)\int_0^T
|h_s(v)-h_s(v-a)|^2\,dv\,da\\
&+\int_0^\infty\ell(a)
\left[\int_{T-a}^T|h_s(w)|^2\,dw
-\int_{-a}^0|h_s(w)|^2\,dw\right]da.
\end{aligned}}
\tag{8}
$$
The bracket equals $E_T(s)-\int_{-a}^{T-a}|h_s|^2$, including when
$a>T$. Its second term is the negative-age origin memory. It has a
minus sign and must not be discarded. If the input is causal, that term
vanishes; logarithmic additive heat profiles are not causal.

The same local formula applies to the actual completed centered heat
profile
$$
b(v)=e^{-v/2}[P(e^{-v})-(1+e^v)e^{-e^{-v}}],
\quad P(t)=\sum_{n\ge2}\Lambda(n)e^{-nt}.
\tag{9}
$$
It is the locally defined $h_{\nu_\infty}$, where
$\nu_\infty=-\delta_1+\sum_{n\ge2}\Lambda(n)\delta_n
-\mathbf1_{[1,\infty)}dx$: its Laplace transform converges for every
$t>0$ and equals $C(t)$. It also has the exact source relation
$$
b=k*a,\qquad a(v)=e^{-v/2}E(e^v)\mathbf1_{v\ge0},\qquad
k(w)=\exp(-3w/2-e^{-w}),
\tag{9a}
$$
from $C(t)=t\int_1^\infty E(x)e^{-tx}\,dx$. Thus the process clock
in (8) is the same complete prime-history convolution acting on both
$a$ and $b$; it is distinct from the external succession clock
$n\mapsto n+1$.
Here $b$ is locally square integrable and belongs to $L^2(-\infty,0)$.
One defines $T_sb$ locally by causal convolution. Its values on any
fixed $( -\infty,T]$ use only the corresponding square-integrable
restriction of $b$, so bounded-generator differentiation is valid
there without assuming $b\in L^2(\mathbb R)$. Causal contraction on
the negative half-line gives
$$
\|T_sb\|_{L^2(-\infty,0)}\le\|b\|_{L^2(-\infty,0)}.
\tag{10}
$$
Consequently the negative flux in (8) has absolute value at most
$\lambda\|b\|_{L^2(-\infty,0)}^2$, uniformly in $s,T$.
This is a finite origin correction, not a spectral gap or scale-doubling
bound.

## 3. Ordinary succession leaves an exactly signed remainder

Use the literal frozen signed measure
$$
\nu_N=-\delta_1+\sum_{2\le n\le N}\Lambda(n)\delta_n
-\mathbf1_{[1,N]}dx.
$$
Its heat amplitude is
$$
F_N(t)=-e^{-t}+\sum_{2\le n\le N}\Lambda(n)e^{-nt}
-\int_1^Ne^{-tx}\,dx.
\tag{11}
$$
Thus the origin is present, and the exact next innovation is
$$
\Delta_n=\Lambda(n)\delta_n-\mathbf1_{[n-1,n]}dx,
\qquad q_n=h_{\Delta_n},\qquad h_{\nu_n}=h_{\nu_{n-1}}+q_n.
\tag{12}
$$
There is no replacement of the density cell by an atom.

For $s_n=c\log n$, define
$$
w_n=\Re\langle T_{s_n}h_{\nu_{n-1}},T_{s_n}q_n\rangle,
\qquad L_n=\|T_{s_n}q_n\|^2,
$$
$$
D_n=\int_{s_{n-1}}^{s_n}\int_0^\infty
\ell(a)\|T_sh_{\nu_{n-1}}-\tau_aT_sh_{\nu_{n-1}}\|^2\,da\,ds.
$$
The exact one-step energy recursion is
$$
\boxed{
\mathcal S_{s_n}(\nu_n)-\mathcal S_{s_{n-1}}(\nu_{n-1})
=2w_n+L_n-D_n.
}
\tag{13}
$$
Only $D_n,L_n$ have automatic signs. The scale-recursive remainder
$2w_n+L_n-D_n$ remains signed.

At zero process time its mixed work is exactly
$$
w_n(0)=\Lambda(n)A_{n-1}(n)-\int_{n-1}^nA_{n-1}(y)\,dy,
$$
$$
A_{n-1}(y)=-\frac1{1+y}
+\sum_{2\le m<n}\frac{\Lambda(m)}{m+y}
-\log\frac{y+n-1}{y+1}.
\tag{14}
$$
The actual arithmetic pairing has both signs:
$$
0.174<w_2(0)<0.175,\qquad
-0.134<w_5(0)<-0.133,\qquad
0.185<w_6(0)<0.186.
\tag{15}
$$
These are certified rational intervals, not floating-point sign tests.
The accompanying script bounds each logarithm by the rational series
$\log x=2\sum_{k\ge0}y^{2k+1}/(2k+1)$,
$y=(x-1)/(x+1)$, with 64 terms and remainder at most
$2y^{129}/[129(1-y^2)]$ for $x\ge1$. Reciprocals treat
$x<1$. The script preserves $\Lambda(4)=\log2$, the origin atom,
and every full density integral. By bounded-process continuity the two
opposite signs persist at small positive process times. This rules out a
universal work sign from positivity alone; it says nothing about an
eventual arithmetic sign.

## 4. The actual low band retains the endpoint datum

For $U=\log N$, truncate the actual discrepancy source only in age:
$$
a_U(v)=e^{-v/2}E(e^v)\mathbf1_{[0,U]}(v),\qquad
D_N(z)=-1+\sum_{2\le n\le N}\Lambda(n)n^{-z}-\int_1^Nx^{-z}\,dx.
$$
The exact frozen-source Mellin identity minus its retained tail yields
$$
\boxed{
\widehat a_U(\xi)=
\frac{D_N(1/2+i\xi)-E(N)N^{-1/2-i\xi}}{1/2+i\xi}.
}
\tag{16}
$$
This identifies the linked signed arithmetic datum: a weighted prime
prefix together with its actual endpoint. No global $a\in L^2$ is
assumed.

The source-specific heat filter $k$ has
$\widehat k(\xi)=\Gamma(3/2+i\xi)$. Its exponential frequency decay
allows an actual finite-horizon bandwidth of order $U$, but this band
contains $|\xi|\lesssim1/U$, where
$\rho(\xi)\sim\pi|\xi|$. Neither high-frequency suppression nor
the positive dissipation (3) bounds (16) in this surviving region.

For the diagnostic causal mode $a(v)=e^{zv}\mathbf1_{v\ge0}$,
$\Re z=\alpha>0$, one has
$$
k*a(v)\sim\Gamma(3/2+z)e^{zv},\qquad
\widehat a_U(\xi)=\frac{e^{(z-i\xi)U}-1}{z-i\xi}.
\tag{17}
$$
Its truncated low-band amplitude still grows like $e^{\alpha U}$,
even if $\Im z$ is large. The gamma factor is nonzero and changes
the coefficient, not the growth exponent. This mode is a diagnostic,
not a replacement for the actual prime source. Excluding all such
growing oscillatory contributions for the actual datum (16) requires
new signed arithmetic control; none of the generator, successor, or
factorial identities proved here supplies it.

The open obligation is to bound the actual signed low-band prefix and endpoint pairing, or the scale recursion (13), with subpower constants. None of the global dissipation or finite-horizon flux identities above proves that estimate.

## Dependencies, certificate and formal scope

The [complete prime-history semigroup](positive-successor-seed-jump-process.md), [actual source correlation and frozen Mellin formula](actual-short-time-psi-correlation.md), and [centered heat criterion](critical-heat-lyapunov-exponent.md) fix the process and source domains. The finite-measure square identity and Fourier/Plancherel formulas are classical; the actual application retains the density cell and origin flux. The [rational sign certificate](heat-birth-sign-certificate.py) proves exactly the three intervals in (15), using an elementary logarithm-series remainder. It is a mathematical rational-arithmetic certificate, not a Lean proof. The analytic generator and Mellin identities here remain written mathematics.
