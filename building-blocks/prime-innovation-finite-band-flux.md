# A finite-band flux for the actual dyadic prime innovation

The actual dyadic innovation gives a positive finite-band probe of the one-prime scattering defect. Its full-band flux is exactly $1/2$, and an unconditional Fourier-tail estimate controls the effect of a low-pass cutoff. This is a statement about a particular coherent input to the $p=2$ factor, not positivity for all Weil tests or for the completed arithmetic and archimedean form.

The multiplier and projection conventions below agree with the [semilocal scattering normalization](semilocal-weighted-scattering.md). Fourier transformation carries the causal projection in the variable $v$ to the negative-frequency Hardy projection in the spectral variable. The sharper cutoff uses Sections 1–3 of the [actual successor frequency-cutoff theorem](actual-successor-frequency-cutoff.md), retaining its initial atom, clustered integer jumps, and continuous cutoff. All results here are written analysis. No RH assumption or mean-energy hypothesis is used.

## The actual input and orientation

Use every prime power in $\psi(x)=\sum_{n\le x}\Lambda(n)$, and set

$$
a(v)=e^{-v/2}\bigl(\psi(e^v)-e^v\bigr)\quad(v\ge0),
\qquad a(v)=0\quad(v<0).
$$

Thus $a(0)=-1$. Put $L=\log2$, $r=2^{-1/2}$, and on $L^2(\mathbb R)$ define

$$
T_\pm f(v)=f(v\pm L),\qquad P f=\mathbf1_{[0,\infty)}f,
\qquad
U=(I-rT_+)(I-rT_-)^{-1},\qquad \Delta=P-U^*PU.
$$

The inverse is the norm-convergent series $\sum_{j\ge0}r^jT_-^j$. With Fourier convention $\widehat f(\tau)=\int f(v)e^{-i\tau v}dv$, the multiplier of $U$ is

$$
u_2(\tau)=\frac{1-r e^{i\tau L}}{1-r e^{-i\tau L}}.
$$

It has modulus one, so $U$ is unitary. This is the stated scattering factor, with advance in the numerator and delay in the denominator.

Let $f$ be any causal $L^2$ truncation agreeing with $a$ on $[0,L)$. Define

$$
d=(I-rT_-)f,\qquad y=Ud=(I-rT_+)f.
$$

For the hard cutoff $f=a\mathbf1_{[0,T]}$, $T>L$, the initial part of $d$ is $a$ on $[0,L)$. For $L<v<T$,

$$
d(v)=b_2(v-L),\qquad
b_2(t)=a(t+L)-r a(t)
=\frac{\psi(2x)-\psi(x)-x}{\sqrt{2x}},\quad x=e^t.
$$

The terminal part $d(v)=-r a(v-L)$ for $T<v<T+L$ remains present. Endpoint values at individual points do not affect these $L^2$ identities.

Since $a(v)=-e^{v/2}$ for $0\le v<L$, the negative-time output is the fixed seed

$$
h=(I-P)y=-r a(v+L)\mathbf1_{(-L,0)}(v)
=e^{v/2}\mathbf1_{(-L,0)}(v),\qquad
\|h\|_2^2=\frac12.
$$

The input $d$ is causal. Unitarity therefore gives the exact full-band flux

$$
\langle d,\Delta d\rangle
=\|d\|_2^2-\|Py\|_2^2=\|(I-P)y\|_2^2=\frac12.
\tag{1}
$$

## The low-pass identity retains the commutator

Let $Q=Q_\Omega$ be the orthogonal Fourier projection to $|\tau|\le\Omega$, put $R=I-Q$, and write $[P,Q]=PQ-QP$. The projections $Q,R$ commute with $U$, but generally do not commute with $P$.

Define $F_{f,\Omega}=\langle Qd,\Delta Qd\rangle$. Since $UQd=Qy$ and $\|Qd\|_2=\|Qy\|_2$,

$$
\begin{aligned}
F_{f,\Omega}
&=\|(I-P)Qy\|_2^2-\|(I-P)Qd\|_2^2\\
&=\boxed{\|Qh-[P,Q]y\|_2^2-\|[P,Q]d\|_2^2.}
\end{aligned}
\tag{2}
$$

Indeed, $Pd=d$ gives $(I-P)Qd=-[P,Q]d$, while $Py=y-h$ gives $(I-P)Qy=Qh-[P,Q]y$.
Equivalently, expanding $(I-P)Qy=h-(I-P)Ry$ yields

$$
\boxed{
F_{f,\Omega}
=\frac12-2\Re\langle Rh,URd\rangle
+\langle Rd,\Delta Rd\rangle.
}
\tag{3}
$$

For the cross term, $h=(I-P)h$ and the selfadjoint projection $R$ give
$\langle h,(I-P)Ry\rangle=\langle Rh,Ry\rangle$.
For the last term, unitarity gives
$\langle Rd,\Delta Rd\rangle=\|(I-P)Ry\|_2^2-\|(I-P)Rd\|_2^2$.

Put $E=\|Rd\|_2^2=\|Ry\|_2^2$ and $E_h=\|Rh\|_2^2$. Since $\Delta$ is a difference of two orthogonal projections, $\|\Delta\|\le1$, and (3) proves

$$
\boxed{\left|F_{f,\Omega}-\frac12\right|\le2\sqrt{E_hE}+E.}
\tag{4}
$$

The bound $\|\Delta\|\le1$ is enough for every estimate below.
The seed transform is explicit:

$$
\widehat h(\tau)=\frac{1-r e^{i\tau L}}{1/2-i\tau},\qquad
E_h\le\frac{(1+r)^2}{\pi\Omega}.
\tag{5}
$$

This estimates the cross error by its seed-frequency overlap rather than by the full, potentially large norm of the arithmetic input.

## Two unconditional cutoff bounds

Fix an elementary Chebyshev constant $B$ with $\psi(x)\le Bx$ for $x\ge1$. The innovation filter gives

$$
E\le(1+r)^2\|Rf\|_2^2.
\tag{6}
$$

For the literal hard cutoff $f=a\mathbf1_{[0,T]}$, its whole-line total variation is $O_B(e^{T/2})$, including both endpoint jumps. To see this, between prime-power arrivals
$a'=-a/2-e^{v/2}$ and $|a(v)|\le(B+1)e^{v/2}$, so its continuous variation is $O_B(e^{T/2})$. Its positive jump variation is

$$
\sum_{n<e^T}\frac{\Lambda(n)}{\sqrt n}=O_B(e^{T/2})
$$

by partial summation from Chebyshev's bound. The cutoff adds the initial jump and a terminal jump of size $|a(T-)|=O_B(e^{T/2})$.
If $V_f$ is this whole-line variation, then $|\widehat f(\tau)|\le V_f/|\tau|$. Thus

$$
E\le\frac{(1+r)^2V_f^2}{\pi\Omega}
\ll_B\frac{e^T}{\Omega}.
$$

Equations (4)–(5), with $\Omega=e^{(1+\delta)T}$ for any fixed $\delta>0$, give

$$
\boxed{F_{f,\Omega}=\frac12+O_B(e^{-\delta T}).}
\tag{7}
$$

In particular, the fixed exponential choice $\Omega=e^{2T}$ gives error $O_B(e^{-T})$.

For the sharper alternative, use the actual successor theorem's continuous cutoff

$$
f_T(v)=\chi_T(v)a(v),\qquad
\chi_T(v)=
\begin{cases}
1,&0\le v\le T,\\
T+1-v,&T<v<T+1,\\
0,&v\ge T+1,
\end{cases}
$$

and zero on the negative half-line. It preserves the same seed and hence the exact flux (1). Sections 1–3 of the [successor-tail theorem](actual-successor-frequency-cutoff.md) prove, without RH,

$$
\|Rf_T\|_2^2\ll_B
\frac{(1+T)^2}{\Omega}
+\frac{e^T(1+T)}{\Omega^2}.
\tag{8}
$$

In its explicit notation, the upper bound is
$2Q_T/\Omega+(16R_T+8\mathcal W_T)/(3\Omega^2)$, where the initial atom is included in $Q_T,R_T$. That theorem derives the bound by averaging the exact translation estimate for clustered integer-located jumps. No terminal hard-cutoff atom is omitted; this is a different, continuous truncation.

Equations (4)–(6) and (8) yield

$$
\boxed{
\begin{aligned}
\Omega=e^T&\quad\Longrightarrow\quad
F_{f_T,\Omega}=\frac12+O_B((1+T)^2e^{-T}),\\
\Omega=e^{T/2}(1+T)^2&\quad\Longrightarrow\quad
F_{f_T,\Omega}=\frac12+O_B((1+T)^{-3}).
\end{aligned}}
\tag{9}
$$

Both cutoff constructions therefore give a strictly positive actual finite-band flux for sufficiently large $T$, for example $F_{f,\Omega}\ge1/4$ eventually. The second frequency scale must not be assigned to the hard cutoff using the continuous-cutoff estimate.

The arithmetic history determines the finite-band input, but the full-band value $1/2$ depends only on the retained initial seed. This proves neither positivity on arbitrary inputs nor a uniform lower bound after normalization by the input norm. The prime $2$ factor here also does not include the archimedean term or a sum over the other primes.
