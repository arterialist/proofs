# Clocked native probe: terminal metric and synthesis cost

Attribution: RH Proof, independent transfer review and terminal metric calculation.

Written independent review and consequence of Agent3's `clocked-cofactor-native-birth-probe-transfer.md`, 16 September 2026. The exact transfer, deterministic correction, seed and terminal identities check out. This note evaluates the actual finite native probe's metric. No RH bound or Lean certification of this additional calculation is claimed.

Keep b=n-1, s=c log n in the established central-positive kernel regime, and

    w(x)=x^-1/2 K_s(log(n/x)),
    theta_k=w(k)-w(k+1) for 1<=k<b, theta_b=w(b),
    H_k=k(k+1)theta_k for 1<=k<=b, H_0=H_(b+1)=0.

The native source identity follows by rearranging the literal F successor difference. Its residual r_k=k(k+1)log(1+1/k)-k lies strictly between zero and one. The exact odd-count/even-power correction q_k has |q_k|<=1+log k. Thus the correction sum theta_k(r_k+q_k) is O(s^-5), because the interior weights are at most C s^-5 k^-3/2 and the terminal weight is at most C s^-5 b^-1/2. In particular the endpoint correction has been paid rather than discarded.

## Exact finite physical probe

Let alpha_(k+1)=H_(k+1)-H_k for 0<=k<=b and use the literal births b_m(v)=exp(-v/2)1_{v>=log m}. Define

    P_n(v)=sum_{k=0}^b alpha_(k+1)b_(k+1)(v).

The last coefficient is -H_b. Finite telescoping gives, on every cell log k<=v<log(k+1),

    P_n(v)=exp(-v/2)H_k,  1<=k<=b.

It vanishes below zero and after log(b+1), apart from inconsequential endpoint values. It is a finite integrable-square physical state. It is nonnegative because H_k>=0, although its birth coefficients have both signs. Exact cell integration in the original dv metric gives

    ||P_n||_2^2=sum_{k=1}^b H_k^2/[k(k+1)].

This also agrees with the full finite Gram quadratic using 1/max(m,l). Positivity of this metric does not sign its pairing with the actual source.

## Terminal cell dominates the metric

For k<b the row derivative bounds give H_k<=C s^-5 sqrt k. Therefore

    sum_{k=1}^{b-1} H_k^2/[k(k+1)]<=C s^-10 log(b+1).

The last cell has the exact contribution

    H_b^2/[b(b+1)]=(b+1)K_s(log(n/b))^2.

Since log(n/b)=O(1/b), the uniform scaled kernel profile implies s^5 K_s(log(n/b)) -> G_0=G(0)>0. Consequently

    ||P_n||_2^2=[G_0^2+o(1)] b/s^10.

The interior contribution divided by b/s^10 tends to zero. This is a genuine norm asymptotic, with no cancellation of signed Gram terms omitted.

## Normalized birth synthesis cost grows

Let C_n=sum_{m=1}^{b+1}|alpha_m|/sqrt m. The two last coefficients give

    C_n >= (H_b-H_(b-1))/sqrt b + H_b/sqrt(b+1)
         =[2G_0+o(1)] b/s^5.

Here H_(b-1)=[G_0/2+o(1)]sqrt b/s^5, whereas H_b=[G_0+o(1)]b^1.5/s^5. For an upper bound, use H>=0 and |H_m-H_(m-1)|<=H_m+H_(m-1). Each interior term H_k/sqrt k is O(s^-5), and there are b such terms; the terminal term has the same total order. Thus C_n<=C b/s^5. The normalized synthesis cost is of order b/s^5, rather than bounded.

This conclusion concerns this exact cofactor-row probe. It does not exclude a different representation with a separately controlled boundary error or a different arithmetic mechanism. Removing its terminal cell would leave an unestimated pairing with the frozen cumulative source. Its large norm also does not by itself refute the desired signed arithmetic work bound, which depends on the coherent source pairing rather than probe norm alone.
