# A rational upper enclosure for the radius-two value J(3)

The radius-two Rayleigh certificate uses

J(3)=b(3)/Phi(3),
b(u)=2cosh(u/2),                                      (1)

and the actual positive theta series, for u>=1,

Phi(u)=sum_(n>=1) 2 pi n^2 exp(5u/2)
       [2 pi n^2 exp(2u)-3]
       exp[-pi n^2 exp(2u)].                         (2)

These are the exact definitions in the public radius-two certificate. This note gives the explicit rational enclosure

J(3)<10^544.                                         (3)

The companion exact-rational checker is `verification/theta_radius_two_J3_rational_upper_check.py`.

At u=3 every summand in (2) is positive. Retaining n=1 gives

Phi(3)>=2 pi exp(15/2)[2 pi exp(6)-3]
                 exp[-pi exp(6)].                   (4)

Also

b(3)=exp(3/2)+exp(-3/2)<2exp(3/2).                  (5)

Consequently

J(3)
 < exp[-6] exp[pi exp(6)]
   /{pi[2 pi exp(6)-3]}.                             (6)

All remaining estimates will be rational.

Use the bounds

2721/1001<e<1457/536,
333/106<pi<355/113.                                  (7)

The exponential bounds follow directly from the series for e. The lower bound is below sum_(k=0)^10 1/k!. For the upper bound, sum through k=9 and bound the tail beginning at 1/10! by the geometric series with ratio 1/11:

e<sum_(k=0)^9 1/k! + 11/(10*10!)
 =4697191/1728000
 <1457/536.                                          (8)

For completeness, the pi bounds can be checked without decimal approximations from Machin's identity

pi=16 arctan(1/5)-4 arctan(1/239).                  (9)

For each arctangent, four alternating terms give a lower bound and five give an upper bound. Substitution in (9) gives a lower rational greater than 333/106 and an upper rational smaller than 355/113. The companion exact-integer checker performs these comparisons.

The upper bounds in (7) give the exact rational inequality

pi e^6
 <(355/113)(1457/536)^6
 <2535/2.                                            (10)

The lower bounds give

pi[2 pi e^6-3]
 >(333/106)[2(333/106)(2721/1001)^6-3]
 =:L.                                                (11)

Here L is a positive rational, numerically about 7953 only for orientation; no decimal value is used in the proof.

Combining (6), (10), and (11),

J(3)<e^(2523/2)/L.                                   (12)

The final comparison is again exact rational arithmetic. From e<1457/536 it is enough, after squaring, to check

(1457/536)^2523 < L^2 10^1088.                      (13)

Cross multiplication turns (13) into one integer inequality. It holds, as verified by `theta_radius_two_J3_rational_upper_check.py`. Equations (12)-(13) prove (3).

This improves the deliberately coarse public enclosure J(3)<10^2916 while using the same one-term lower bound for Phi(3). The exponent 544 is close to the limit of this simple one-term strategy with short rational enclosures for e and pi. A materially smaller certified power would benefit from retaining sharper rational intervals or additional positive theta terms, but neither is needed for (3).

Combined with the reviewed compact Rayleigh certificate, this enclosure yields the explicit gap and barrier constants recorded in `theta-radius-two-rational-gap-propagation.md`. The analytic inequalities here are reviewed written mathematics; the companion checker certifies the finite rational comparisons.
