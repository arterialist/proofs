# Two-prime unilateral transport and the common resonance

Let $\ell=\log2$, $m=\log3$, $S=\ell+m=\log6$, and $r_j=j^{-1/2}$. Take the actual causal history
$$
a(v)=e^{-v/2}(\psi(e^v)-e^v),\qquad a(0)=-1,
$$
and its continuous cutoff $f=f_t=\chi_ta$, with $t\ge S$. The cutoff is one through $t$, linear to zero at $t+1$, and zero thereafter. No PNT or RH hypothesis is needed for any finite-cutoff identity below.

For $j=2,3$, write $L_2=\ell,L_3=m$,
$$
D_j=I-r_jT_{-L_j},\quad A_j=I-r_jT_{+L_j},\quad
D=D_2D_3,\quad A=A_2A_3.
$$
Here $T_{+L}F(v)=F(v+L)$. Define
$$
Z=D^{-1}f,\qquad p=AZ=U_2U_3f,
\qquad q=DA^{-1}f=U_2^{-1}U_3^{-1}f.
\tag{1}
$$
All resolvents are norm-convergent geometric series on $L^2$. The inverse advance history is pointwise a finite double sum for each fixed argument, because $f$ has compact support. The positive part of $q$ is supported through $t+1+S$. In contrast, the intermediate history $U_2f$ is not causal, and is never treated as causal here.

## Complete finite boundary sources

Let $P$ denote projection to nonnegative time. The forward negative source $\eta=(I-P)p$ is supported on $[-S,0]$. For $0<u<S$,
$$
\eta(-u)=-r_2Z(\ell-u)1_{u<\ell}
-r_3Z(m-u)1_{u<m}+r_6Z(S-u).
\tag{2}
$$
The causal resolvent $Z$ vanishes at negative arguments. Define a second compact negative-time source by
$$
\beta(-u)=r_2q(\ell-u)1_{u<\ell}
+r_3q(m-u)1_{u<m}-r_6q(S-u),\qquad 0<u<S.
\tag{3}
$$
Expansion of the advance polynomial, separately on negative and positive time, gives the exact whole-line identities
$$
p_+=AZ-\eta,\qquad A q_+=Df-\beta.
\tag{4}
$$
Thus, using commutation of convolution with translations and $DZ=f$,
$$
\boxed{f*f-p_+*q_+=\eta*q_++\beta*Z.}
\tag{5}
$$
In particular, for $s\ge0$,
$$
\boxed{
(f*f)(s)=\int_0^sp(v)q(s-v)\,dv
+\int_0^S[\eta(-u)q(s+u)+\beta(-u)Z(s+u)]\,du.
}
\tag{6}
$$
This is the complete mixed two-history storage/flux identity. Every source is finite in time, while its values retain the complete actual finite input. Both terms in the second integral keep the upper cutoff whenever $s+u>t$.

The two terms on the right side of (5) can individually have negative-time support; those parts cancel in their sum. Consequently a product of transforms of one negative source and one causal history must not, by itself, be identified with a unilateral boundary integral without its complementary term.

## Unilateral transforms derived from finite recurrences

Write
$$
F_t(z)=\int_0^\infty f(v)e^{-zv}\,dv,
\quad P_+(z)=\int_0^\infty p(v)e^{-zv}\,dv,
\quad Q_+(z)=\int_0^\infty q(v)e^{-zv}\,dv.
$$
The scalar symbols are
$$
D(z)=(1-r_2e^{-z\ell})(1-r_3e^{-zm}),\qquad
A(z)=(1-r_2e^{z\ell})(1-r_3e^{zm}).
$$
Define the entire source transforms
$$
H_{23}(z)=\int_0^S\eta(-u)e^{zu}\,du,\qquad
B_{23}(z)=\int_0^S\beta(-u)e^{zu}\,du.
$$
Expanding the two advances in (4) and transforming causal delays gives, initially for $\Re z>0$,
$$
\boxed{P_+(z)=\frac{A(z)}{D(z)}F_t(z)-H_{23}(z),
\qquad A(z)Q_+(z)=D(z)F_t(z)-B_{23}(z).}
\tag{7}
$$
No bilateral transform of an uncut arithmetic history is used. More explicitly, if $I_q(c;z)=\int_0^cq(v)e^{-zv}dv$, then
$$
B_{23}(z)=r_2e^{z\ell}I_q(\ell;z)
+r_3e^{zm}I_q(m;z)-r_6e^{zS}I_q(S;z).
\tag{8}
$$
The positive inverse history is compactly supported, so $Q_+$, $F_t$, and $B_{23}$ are entire. Equation (7) is an identity of actual finite histories, not a definition that assumes pole cancellation.

## Value and derivative constraints at the common resonance

The two advance factors have a common zero only at $z_c=1/2$. Indeed, any other common zero would give a nonzero rational relation between $\log2$ and $\log3$. At this point
$$
A(z_c)=A'(z_c)=0,\quad A''(z_c)=2\ell m,
\quad D(z_c)=\frac13,\quad D'(z_c)=\frac{2\ell+m}{6}.
$$
Integrating the actual recurrence and differentiating its finite integrals gives the two exact mixed constraints
$$
\boxed{B_{23}(1/2)=\frac13F_t(1/2),
\quad B_{23}'(1/2)=\frac{2\ell+m}{6}F_t(1/2)+\frac13F_t'(1/2).}
\tag{9}
$$
These can be written as concrete strip moment identities. Put $b(v)=e^{-v/2}q(v)$, and let
$$
\omega(v)=\begin{cases}
v,&0\le v\le\ell,\\
\ell,&\ell\le v\le m,\\
S-v,&m\le v\le S.
\end{cases}
$$
Then (8) gives
$$
B_{23}(1/2)=\int_0^\ell b(v)dv-\int_m^S b(v)dv,
\qquad B_{23}'(1/2)=-\int_0^S\omega(v)b(v)dv.
\tag{10}
$$
The right sides of (9) are finite actual division-error moments:
$$
F_t(1/2)=\int_0^\infty\chi_t(v)
\left[\frac{\psi(e^v)}{e^v}-1\right]dv,
\quad
F_t'(1/2)=-\int_0^\infty v\chi_t(v)
\left[\frac{\psi(e^v)}{e^v}-1\right]dv.
$$
Thus both the edge-strip difference and the trapezoidal moment are fixed by the actual finite input. No sign for either integrand is inferred.

At a noncommon resonance $z_{2,k}=1/2+2\pi ik/\ell$, $k\ne0$, or $z_{3,k}=1/2+2\pi ik/m$, only the value constraint
$$
B_{23}(z_{j,k})=D(z_{j,k})F_t(z_{j,k})
\tag{11}
$$
is required: the advance zero is simple there. The derivative need not vanish. At the common resonance the finite value of the inverse transfer is
$$
Q_+(1/2)=\frac{(DF_t-B_{23})''(1/2)}{2\ell m}.
$$
The forward values at noncommon resonances are $-H_{23}(z_{j,k})$; a one-prime forward zero cannot simply be carried through a second transport after causality has been lost.

## The actual mixed seed uses the arrival at four

All forward source data in (2) come from times at most $S$, where
$$
a(v)=e^{-v/2}\{\log2\,1_{v\ge\ell}
+\log3\,1_{v\ge m}+\log2\,1_{v\ge2\ell}
+\log5\,1_{v\ge\log5}\}-e^{v/2}.
\tag{12}
$$
The second $\log2$ is the actual prime-power arrival at $4$. There is no new prime-power arrival at $6$; the mixed scale $6$ enters through the two generators. On $[0,S]$, the causal resolvent is the complete finite expression
$$
Z(v)=\sum_{d\in\{1,2,3,4,6\}}d^{-1/2}a(v-\log d),
\tag{13}
$$
with negative arguments interpreted as zero.

These formulas give the exact normalization
$$
\boxed{P_+(1/2)=\frac{\log2}{4}+\frac{\log3}{12}-\frac{\log5}{30}>0.}
\tag{14}
$$
A direct finite integration displays why retaining the intermediate negative history matters. Let $\vartheta(v)=e^{-v/2}f(v)$, and $\vartheta_2(v)=e^{-v/2}U_2f(v)$. On the initial negative strip $\vartheta_2=1$. The second transport gives exactly
$$
P_+(1/2)=\int_0^m\vartheta_2(v)dv
+\frac13\int_{-\ell}^0\vartheta_2(v)dv.
\tag{15}
$$
For $E_0(y)=\int_0^{\log y}\vartheta(v)dv$, the needed early values are
$$
\begin{split}
E_0(2)&=-\ell,&E_0(3/2)&=\ell-m,\\
E_0(3)&=\ell/6-m,&
E_0(6)&=-7\ell/12-5m/6+\log5/30.
\end{split}
$$
They follow from the exact finite formula
$E_0(y)=\sum_{n\le y}\Lambda(n)/n-\psi(y)/y-\log y$, with the arrival at $4$ included. Consequently
$$
\int_0^m\vartheta_2
=-E_0(6)+E_0(2)+\tfrac12E_0(3)+\tfrac14E_0(3/2)
=-\ell/12+m/12-\log5/30<0.
$$
The missing negative-strip contribution would be $+\ell/3$; retaining it yields (14), which is positive. Both signs are exact: multiply by $60$, then use $(3/2)^5<25$ for the first and $2^{15}3^5>25$ for the second. Thus falsely projecting the intermediate history to causal time changes even the sign of this finite normalization.

## Storage correspondence and scope

The unilateral transform of causal storage is $P_+Q_+$. Equation (7) gives the particularly useful boundary identity
$$
\boxed{F_t^2-P_+Q_+=\frac{B_{23}}D F_t+H_{23}Q_+.}
\tag{16}
$$
This is the transform of the complete boundary sum (5), not a separate unilateral interpretation of each factor product. All apparent common and noncommon advance resonances cancel through (9)--(11).

If one subsequently passes to the uncut actual history using the ordinary PNT remainder, the finite-strip sources converge, including all their transform derivatives on compact sets. The same transfer then uses
$$
F(z)=-\frac{\zeta'(z+1/2)}{(z+1/2)\zeta(z+1/2)}-\frac1{z-1/2}
$$
initially for $\Re z>1/2$. At a true zero $\rho$ with $\Re\rho>1/2$, both $A$ and $D$ are nonzero at $z=\rho-1/2$. Thus storage retains the double-pole coefficient $m_\rho^2/\rho^2$, while (16) has at most a simple pole. This establishes the actual zeta correspondence of the mixed storage; it supplies no sign or RH-scale bound for that storage.

The cutoff-limit assertion follows from the complete smooth-history estimates in [late-age transfer](late-age-prime-boundary-transfer.md), which use Trudgian's classical PNT remainder. The finite identities above follow directly from geometric resolvents and causal projection; they are written proofs, not Lean theorems.
