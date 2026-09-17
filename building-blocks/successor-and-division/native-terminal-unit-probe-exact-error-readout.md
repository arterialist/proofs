# Native terminal unit probe: exact error readout

Attribution: RH coordination lead; independent mathematical review by RH Proof.

Written mathematical deduction from the reviewed clocked native-probe transfer and terminal metric. No new arithmetic bound, priority claim, or Lean certification is asserted.

Let $b\ge1$ be an integer, $E(b)=\psi(b)-b$, and retain the literal frozen source $a_b(v)=e^{-v/2}E(\min(e^v,b))$ for $v\ge0$. On the open cell $b<x<b+1$ this equals $E(b)/\sqrt{x}$. The native terminal probe is

$$p_b(v)=H_b e^{-v/2}\mathbf 1_{[\log b,\log(b+1))}(v),\qquad H_b>0.$$

In the original $dv$ metric, direct integration gives

$$\|p_b\|_2=\frac{H_b}{\sqrt{b(b+1)}},\qquad
\left\langle a_b,\frac{p_b}{\|p_b\|_2}\right\rangle
=\frac{E(b)}{\sqrt{b(b+1)}}.$$

Thus for the *frozen* source the unit terminal readout is $E(b)/b$ to relative error $O(1/b)$, not $E(b)/\sqrt b$. This matters: a terminal cell has logarithmic width $\asymp1/b$, so its unit normalization includes that resolution factor. Under Chebyshev's bound, this readout stays bounded unconditionally. It does not yield square-root cancellation.

If instead the source continues its density drift within the cell, $a(v)=e^{-v/2}(\psi(b)-e^v)$ there, the exact formula is

$$\left\langle a,\frac{p_b}{\|p_b\|_2}\right\rangle
=\frac{E(b)-r_b}{\sqrt{b(b+1)}},\qquad
r_b=b(b+1)\log(1+1/b)-b\in(0,1).$$

The distinction between frozen and drifting source is retained rather than silently changing the terminal convention.

For the row probe $H_b=b(b+1)w(b)$, the unnormalized terminal pairing is exactly $w(b)E(b)$ in the frozen convention, and $w(b)(E(b)-r_b)$ in the drifting convention. Since $w(b)\sim G_0/(\sqrt b\,s^5)$, the unnormalized pairing retains the square-root-scale error $E(b)/\sqrt b$, multiplied by $G_0/s^5$. Normalizing the probe removes that growing sensitivity along with its growing norm. Consequently a bounded normalized terminal observation cannot be substituted for the required bound on the unnormalized coherent row.

This is a precise normalization check, not an obstruction to a signed terminal-plus-interior cancellation mechanism. It supplies no bound on that joint pairing.
