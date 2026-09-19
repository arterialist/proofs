# A Chebyshev envelope and dyadic falsifier for the coarse primitive

## Status and scope

This note gives an unconditional full-range upper bound for the exact coarse primitive energy and a certified finite counterexample to a natural coefficient-one dyadic contraction. Both prefix and suffix ports, the terminal mass, every prime power, and every integer cell are retained. The estimate remains one full power above the RH consumer, and the counterexample does not rule out a larger constant or an eventual scale-dependent inequality. No originality claim is made.

For real (X\ge1), write

$$
 e(x)=\psi(\lfloor x\rfloor)-x,
 \quad
 P_X(t)=\int_X^t e(x)\,dx,
 \quad
 R_X(t)=\int_t^{2X}e(x)\,dx,
$$

and

$$
 S_X=\int_X^{2X}\bigl(P_X(t)^2+R_X(t)^2\bigr)\,dt.
$$

These are the quantities used by `CoarsePrimitiveBound`.

## An unconditional (X^5) envelope with an explicit constant

The compiled Chebyshev estimate

$$
 0\le\psi(N)\le(4\log2)N
$$

implies, for (x\ge1),

$$
 |e(x)|\le c x,
 \qquad c=4\log2-1.
\tag{1}
$$

Indeed (e(x)\ge-x), while

$$
 e(x)\le(4\log2)\lfloor x\rfloor-x\le(4\log2-1)x,
$$

and (c>1). Hence, for (X\le t\le2X),

$$
 |P_X(t)|\le\frac c2(t^2-X^2),
 \qquad
 |R_X(t)|\le\frac c2(4X^2-t^2).
\tag{2}
$$

After (t=Xu), exact polynomial integration gives

$$
\begin{aligned}
 S_X
 &\le \frac{c^2X^5}{4}
 \int_1^2\bigl((u^2-1)^2+(4-u^2)^2\bigr)\,du\\
 &=\boxed{\frac{91}{60}(4\log2-1)^2X^5}.
\end{aligned}
\tag{3}
$$

The polynomial factor (91/60) is exact for the negative linear envelope at (X=1): away from the measure-zero endpoint (2),

$$
 e(x)=-x,
 \quad
 P_1(t)=-\frac{t^2-1}{2},
 \quad
 R_1(t)=-\frac{4-t^2}{2},
$$

so (S_1=91/60). The extra factor (c^2) in (3) pays the positive Chebyshev envelope and is not asserted to be sharp. The estimate gives an unconditional inequality over the complete stated range, but its exponent is (5). The required all-ε scale is (X^{4+\varepsilon}); this pointwise-envelope mechanism loses one full power whenever (0<\varepsilon<1).

## Exact integer-cell formula

For an integer (X\ge1), let

$$
 A_m=P_X(m),\qquad b_m=\psi(m)-m
 \qquad (X\le m<2X).
$$

On the half-open cell (t=m+u), (0\le u<1),

$$
 A_m=\sum_{j=X}^{m-1}\left(\psi(j)-j-\frac12\right),
 \qquad
 P_X(m+u)=A_m+b_mu-\frac{u^2}{2}.
\tag{4}
$$

If (M_X=P_X(2X)=A_{2X}), adjacent-interval additivity gives

$$
 R_X(m+u)=M_X-P_X(m+u).
\tag{5}
$$

For (q(u)=a+bu+cu^2),

$$
 \int_0^1q(u)^2\,du
 =a^2+ab+\frac{b^2+2ac}{3}+\frac{bc}{2}+\frac{c^2}{5}.
\tag{6}
$$

Equations (4)--(6) evaluate (S_X) by a finite exact polynomial calculation once certified intervals for the logarithms in every von Mangoldt coefficient are supplied. Integer endpoint values have measure zero, while the inclusive convention for ψ determines every adjacent cell and the terminal mass.

## Failure of coefficient-one quartic dyadic contraction

The verification script [coarse_primitive_dyadic_falsifier.py](../../formalization/verification/coarse_primitive_dyadic_falsifier.py) uses all prime powers through (1024), rational atanh-series enclosures for each logarithm, outward-rounded 60-digit decimal interval arithmetic, and the exact cell integral (6). It certifies

$$
\begin{aligned}
 S_{256}&\in[21257567.5863301076106898093564551,\\
 &\hspace{49mm}21257567.5863301076106898093570401],\\
 S_{512}&\in[712797784.3295671242736481035106145,\\
 &\hspace{49mm}712797784.3295671242736481035359748].
\end{aligned}
$$

Therefore

$$
 \boxed{S_{512}-16S_{256}>372676702.9482854025},
 \qquad
 \boxed{\frac{S_{512}}{16S_{256}}>2.09571774097268688749}.
\tag{7}
$$

Thus the natural coefficient-one recursion (S_{2X}\le16S_X) already fails at (X=256). The result does not refute `CoarsePrimitiveBound`: that condition permits an ε-dependent global constant and does not assert monotone contraction at each dyadic step. It shows that a proof cannot obtain the quartic scale by iterating this coefficient-one local contraction without a reserve that pays the finite positive excursion.

## Verification

Run

```text
python3 formalization/verification/coarse_primitive_dyadic_falsifier.py
```

The script uses only the Python standard library. Its SHA-256 digest at publication is `a18e958da49c7c1f6bcacb88249246b24d216c1bd9a096a9562871df5f890b5a`.
