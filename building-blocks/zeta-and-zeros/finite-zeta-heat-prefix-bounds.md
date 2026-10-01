# Uniform denominators for heated finite zeta prefixes

For an integer \(M\ge1\), real \(t\ge0\), and complex \(s\), define the literal finite sum

\[
F_{M,t}(s)=\sum_{n=1}^{M}e^{t(\log n)^2/4}n^{-s}.
\]

The following bounds hold at every imaginary height, with no exceptional cutoff or omitted integer:

\[
\begin{array}{c|c|c}
\text{prefix and time range}&\text{real-part range}&\text{lower bound}\\ \hline
M\ge649999,\ t=0&\Re s\ge61/50&|F_{M,0}(s)|>13/500\\
M\ge649999,\ t\ge0&\Re s\ge22/15+(t/4)\log M&|F_{M,t}(s)|>3/100\\
\log M\ge100,\ t\ge0&\Re s\ge61/50+(t/4)\log M&|F_{M,t}(s)|>1/10.
\end{array}
\tag{1}
\]

These are unconditional written analytic proofs, independently checked. The [Lean module](../../formalization/BuildingBlocks/FiniteZetaHeatPrefix.lean) checks the literal finite-sum recentering and the final rational margins. It does not formalize the analytic denominator inequalities. The [standard-library certificate](../../certificates/finite_zeta_heat_prefix_certificate.py) checks every numerical corner using exact fractions and integer roots; its [report](../../certificates/finite-zeta-heat-prefix-certificate.json) contains diagnostic decimals separately.

The domains in (1) begin to the right of one at time zero. They do not constrain critical-strip zeta zeros or prove RH. They can supply denominators for finite-source heat calculations. An application to a completed source must still account for the reflected term, analytic remainder, derivatives and actual cutoff changes.

## A uniform finite comparison

Put \(a>1\), \(\delta=a-1\), \(L=\log M\), \(\tau=t/4\), and \(q=\tau L\). Assume \(M>1\) and \(\sigma=\Re s\ge a+q\). Subtract the ordinary, unheated zeta series:

\[
F_{M,t}(s)-\zeta(s)
=\sum_{n\le M}n^{-s}(e^{q(\log n)^2/L}-1)-\sum_{n>M}n^{-s}.
\tag{2}
\]

For \(2\le n\le\sqrt M\), write \(\ell=\log n\). The inequality \(e^v-1\le ve^v\), for \(v\ge0\), gives

\[
|n^{-s}(e^{q\ell^2/L}-1)|
\le\frac qL\ell^2 n^{-a-q/2}.
\]

For every \(q\ge0\) and \(\ell>0\),

\[
q e^{-q\ell/2}\le\frac2{e\ell}<\frac3{4\ell}.
\]

The low range is therefore bounded by \(3/(4L)\) times \(\sum_{n\ge2}(\log n)n^{-a}\). This sum is at most its integral plus its maximum:

\[
\sum_{n\ge2}(\log n)n^{-a}
\le\frac1{\delta^2}+\frac1{ae}<\frac1{\delta^2}+1.
\]

Layer-cake integration proves this comparison for the nonnegative unimodal function \((\log u)u^{-a}\): each superlevel interval contains at most its length plus one integers. Its integral is \(1/\delta^2\) and its maximum is \(1/(ae)\).

For \(\sqrt M<n\le M\), the full heated difference is at most \(n^{-a}\), since \(\ell\le L\) and \(-q\ell+q\ell^2/L\le0\). The ordinary omitted tail is also bounded by \(n^{-a}\). These ranges are disjoint, so the complete high contribution is at most \(\sum_{n>\sqrt M}n^{-a}\). Thus

\[
\boxed{
|F_{M,t}(s)-\zeta(s)|
<\frac3{4\log M}\left(\frac1{\delta^2}+1\right)
+\frac{\lfloor\sqrt M\rfloor^{-\delta}}{\delta}.
}
\tag{3}
\]

For positive \(t\), the infinite heated series diverges at every finite real part. Equation (2) keeps heating confined to the finite prefix.

The ordinary unit Euler factors supply the all-height lower bound

\[
|\zeta(s)|\ge\frac{\zeta(2\sigma)}{\zeta(\sigma)}
=\prod_p(1+p^{-\sigma})^{-1}
\ge\frac{\zeta(2a)}{\zeta(a)}.
\tag{4}
\]

The last lower envelope increases with \(\sigma\). This does not assert monotonicity of the finite prefix's pointwise modulus.

## The entry-size corner

Take \(a=22/15\), \(\delta=7/15\). Exact enclosures using 100 terms of zeta and an upper integral tail prove

\[
\frac{\zeta(44/15)}{\zeta(22/15)}>\frac{883}{2000}.
\]

For \(M\ge649999\), one has \(\lfloor\sqrt M\rfloor\ge806\). A rational Taylor upper bound proves \(e^{40/3}<640000<649999\), hence \(L>40/3\). The two errors in (3) satisfy

\[
\frac3{4L}(225/49+1)<\frac{1233}{3920},
\qquad
\frac{15}{7\,806^{7/15}}<\frac{59}{625}.
\]

Consequently

\[
|F_{M,t}(s)|>
\frac{883}{2000}-\frac{1233}{3920}-\frac{59}{625}>\frac3{100}.
\tag{5}
\]

The exponent enclosures are exact: the certificate obtains lower and upper bounds for \(n^{7/15}\) from the checked integer fifteenth root of \(n^7S^{15}\), with integer scale \(S\). Reciprocal inequalities are taken in the appropriate directions. The last strict inequality in (5) is entry_corner_margin in Lean. The analytic Euler, tail and exponential estimates remain written steps.

## The larger prefix and the smaller real-part cone

Take \(a=61/50\), \(\delta=11/50\). The certificate proves

\[
\frac{\zeta(61/25)}{\zeta(61/50)}>\frac{53}{200}.
\]

For \(M\ge4\), \(\lfloor\sqrt M\rfloor\ge\sqrt M/2\). Equation (3) therefore gives

\[
|F_{M,t}(s)-\zeta(s)|
<\frac{7863}{484\log M}+\frac{100}{11}M^{-11/100}.
\tag{6}
\]

Both terms decrease with \(M\). If \(\log M\ge100\), a positive Taylor sum proves \(e^{11}>50000\), so

\[
|F_{M,t}(s)|>
\frac{53}{200}-\frac{7863}{48400}-\frac1{5500}
=\frac1{10}+\frac{571}{242000}>\frac1{10}.
\tag{7}
\]

Lean checks the equality and strict rational margin in (7). The smaller real-part requirement is obtained with the explicitly larger size threshold; it is not an entry-size bound throughout that smaller cone.

At time zero the comparison is simpler:

\[
|F_{M,0}(s)|\ge
\frac{\zeta(2\sigma)}{\zeta(\sigma)}
-\frac{M^{1-\sigma}}{\sigma-1}.
\]

The lower envelope increases with both \(M\) and \(\sigma\). The independently reproduced corner at \(M=649999,\sigma=61/50\) is greater than \(13/500\). This proves the first row of (1).

## Exact recentering and cutoff conventions

For any real \(b,t\), including negative \(t\), define

\[
G_{M,t,b}(z)=\sum_{n=1}^M
e^{t(b-\log n)^2/4}e^{(b-\log n)z}.
\]

Termwise exponential algebra gives

\[
\boxed{
F_{M,t}(s)=e^{-bs+(t/4)b^2}
G_{M,t,b}(s-(t/2)b).
}
\tag{8}
\]

heatedPrefix_recenter checks (8) for every integer prefix, including the empty prefix, all real \(b,t\), and every complex \(s\). The analytic estimates (1) still require \(t\ge0\).

For \(M\ge2\), choosing \(b=\tfrac12\log M\) gives real endpoint frequencies \(\pm b\). A strict real cutoff \(\sum_{n<N}\) has actual last integer \(M=\lceil N\rceil-1\); an inclusive cutoff uses \(M=\lfloor N\rfloor\). Centering at the real number \(N\) instead need not produce both endpoints. When \(N\ge650000\), either convention has \(M\ge649999\). For \(t\ge0\), replacing \(\log M\) with the larger \(\log N\) imposes a stronger real-part requirement and gives a smaller domain for the same bound.

## Source comparison and limits

The finite heat polynomial occurs in [Polymath15's effective approximation, Theorem 1.3](https://arxiv.org/html/1904.12438v2). Equations (3)–(7) are an elementary finite-prefix comparison based on ordinary Euler factors and integer counting; no novelty or optimality claim is made. The exact corner certificate can be reproduced with

~~~sh
python3 certificates/finite_zeta_heat_prefix_certificate.py
~~~

The comparison and denominator bounds also apply to completely multiplicative twists \(\chi(1)=1\), \(|\chi(n)|\le1\), using
\[
L_\chi(s)=\sum_{n\ge1}\chi(n)n^{-s}
=\prod_p(1-\chi(p)p^{-s})^{-1},\qquad \Re s>1.
\]
Each factor satisfies \(|1-\chi(p)p^{-s}|\le1+p^{-\sigma}\), and the tail comparison is unchanged. Thus the bounds use more information than arbitrary coefficient magnitudes, but do not identify a special untwisted prime phase. The complete source, critical-strip continuation, a global heat-flow barrier and any RH implication are separate mathematical obligations.

The unformalized steps are the Euler-product lower bound, the uniform finite comparison, integral and Taylor estimates, and monotonicity of the analytic envelopes. The Python program certifies their finite rational corners; Lean certifies finite recentering and final rational arithmetic. These verification scopes are distinct.
