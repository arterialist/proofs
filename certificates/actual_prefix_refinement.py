#!/usr/bin/env python3
"""Exact checks of actual-prefix residue refinement. Standard library only."""
from fractions import Fraction as F
import argparse
from math import comb, lcm


def counts(N, m):
    out = [0] * m
    for n in range(1, N + 1):
        out[(n - 1) % m] += 1
    return out


def run(max_n=160, max_m=32):
    checks = dict(refinement=0, two_row=0, energy=0, self_bias=0,
                  density_energy=0, saturation=0, mean_zero_criterion=0)
    for N in range(1, max_n+1):
        for m in range(1, max_m+1):
            Q, R = divmod(N, m)
            cm = counts(N, m)
            chi = sum((F(m*c, N)-1)**2 for c in cm) / m
            assert chi == F(R*(m-R), N*N)
            for p in (2, 3, 4, 5, 7):
                cmp = counts(N, m*p)
                s = Q % p
                E = F(0)
                self_bias = F(0)
                density_innovation_energy = F(0)
                for a in range(1, m+1):
                    t = cm[a-1] % p
                    row_energy = F(0)
                    for j in range(p):
                        eta = F(cmp[a-1+m*j]) - F(cm[a-1], p)
                        direct_law = F(j < t) - F(t, p)
                        assert eta == direct_law
                        checks['refinement'] += 1
                        two_row = F(j < s) - F(s, p)
                        if a <= R:
                            two_row += F(j == s) - F(1, p)
                        assert eta == two_row
                        checks['two_row'] += 1
                        row_energy += eta*eta
                        self_bias += cmp[a-1+m*j] * eta / N
                        diff = F(m*p*cmp[a-1+m*j], N) - F(m*cm[a-1], N)
                        density_innovation_energy += diff*diff / (m*p)
                    assert row_energy == F(t*(p-t), p)
                    checks['energy'] += 1
                    E += row_energy
                assert self_bias == E/N
                checks['self_bias'] += 1
                assert (self_bias == 0) == (N % (m*p) == 0)
                checks['mean_zero_criterion'] += 1
                chip = sum((F(m*p*c, N)-1)**2 for c in cmp) / (m*p)
                assert chip - chi == density_innovation_energy == F(m*p, N*N)*E
                checks['density_energy'] += 1
                if m >= N:
                    assert max(cm) <= 1
                    assert chi == F(m, N)-1
                    assert density_innovation_energy == F(m*(p-1), N)
                    assert self_bias == F(p-1, p)
                    checks['saturation'] += 1
    example = {
        'N': 2, 'm': 2, 'refinement_factor': 3,
        'actual_conditional_new_information': 0,
        'haar_density_innovation_L2_squared': '2',
        'actual_mean_of_haar_centered_count_contrast': '2/3',
    }
    # Direct sign failures for a p-divisible child with weights mu(1)=1, mu(2)=-1.
    signs = []
    for N in (3, 7):
        m, p = 2, 3
        cm, fine = counts(N, m), counts(N, m*p)
        val = F(0)
        for a, w in ((1, 1), (2, -1)):
            j = next(j for j in range(p) if (a+m*j) % p == 0)
            val += w * (F(fine[a-1+m*j])-F(cm[a-1], p))
        signs.append({'N': N, 'value': str(val)})
    assert [x['value'] for x in signs] == ['2/3', '-1/3']
    L=1
    for k in range(1,151):
        L=lcm(L,k)
        for j in range(k):
            assert L % (k*comb(k-1,j)) == 0
        assert L >= 2**(k-1)
    for N in range(1,100001):
        k=(N-1).bit_length()+1
        assert 2**(k-1)>=N
        assert lcm(*range(1,k+1))>=N
    print(f'PASS: residue laws for N=1..{max_n}, m=1..{max_m}, factors 2,3,4,5,7.')
    print('PASS: empirical bias, density energies, saturation and both exact phase signs.')
    print('PASS: binomial divisibility through k=150 and saturation through N=100000.')

if __name__ == '__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--quick',action='store_true',help='Use N<=24, m<=8 for the residue checks.')
    args=parser.parse_args()
    run(24,8) if args.quick else run()
