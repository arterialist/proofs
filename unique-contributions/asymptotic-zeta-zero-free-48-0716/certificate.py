#!/usr/bin/env python3
"""Exact certificate for an asymptotic zeta zero-free constant < 48.0716.

Only Python standard-library exact rational arithmetic is used.
"""
from fractions import Fraction as F
import json

# Exact factors for two normalized Fejer squares. The first is the published
# MTY P46 factor; the second is the optimized factor found in this project.
C_MTY = [F(x) for x in ['1', '338377844758599/1000000000000', '-219537480547081/1000000000000', '-368390656424483/500000000000', '914902037465737/1000000000000', '47894673618929/25000000000', '-65514300297953/50000000000', '-211865869869/62500000', '86623030458109/50000000000', '694301235038993/100000000000', '-278171504957099/1000000000000', '-115949052445657/10000000000', '-42798222109347/10000000000', '145397736361703/10000000000', '117103298598379/10000000000', '-188240950949349/10000000000', '-41654987558489/1250000000', '-132753870312609/200000000000', '85406998011561/2500000000', '371250687198081/50000000000', '-284100974519303/5000000000', '-605831989268389/10000000000', '272783371854473/10000000000', '6325431776119/62500000', '1971315549713/40000000', '-1415429034619/19531250', '-200859463959807/2500000000', '130557454262211/1000000000', '114163916397431/250000000', '343183127890933/500000000', '690091748824027/1000000000', '126096732006011/250000000', '256781756010027/1000000000', '302027298520153/5000000000', '-370394291423529/10000000000', '-498299664619879/10000000000', '-56741481381299/2500000000', '84478642800313/50000000000', '244524675081883/25000000000', '103360633101459/10000000000', '999304428459519/100000000000', '955878229646887/100000000000', '393084392071263/50000000000', '166443226519143/25000000000', '473689926522741/100000000000', '27913088335699/12500000000', '504683217557847/1000000000000']]
C_OPT = [F(x) for x in ['2.3930922810355928e-11', '0.00021215959980676709', '-5.7871544211055603e-05', '-0.00061316208681863637', '0.00060579702614135084', '0.0014985403003232236', '-0.00091524302731537809', '-0.0025631115739387046', '0.0014146092619416479', '0.0051594269783088731', '-0.00037945525805127583', '-0.0085336290347174312', '-0.0031826174951752988', '0.011103383116827898', '0.008643836436573852', '-0.014853058440026008', '-0.024860414961020569', '0.00094279085072113177', '0.026327815676264785', '0.002302559392803796', '-0.048754121754761862', '-0.04753370353491701', '0.026890449176106796', '0.0861133712005165', '0.041887058691471253', '-0.059101151442618821', '-0.065691351653626551', '0.10590547863222964', '0.36962995055863396', '0.55302604914259335', '0.55475265208524915', '0.40578606087561386', '0.20849027780706167', '0.051177530450645652', '-0.029373976376492059', '-0.042707613794133154', '-0.023003154574261862', '-0.0024873782222908261', '0.0067325262010088987', '0.009126397777620877', '0.010035452759560796', '0.0094125337846415972', '0.0069596085611132964', '0.0047658782744762008', '0.0032815081089194132', '0.0013393213714375882', '1.7841783123463139e-10']]
assert len(C_MTY) == len(C_OPT) == 47

def coefficients(c):
    denominator = sum(x*x for x in c)
    return [F(1)] + [
        2*sum(c[i]*c[i+k] for i in range(47-k))/denominator
        for k in range(1, 47)
    ]

b_mty = coefficients(C_MTY)
b_opt = coefficients(C_OPT)
# A convex combination of nonnegative normalized squares is nonnegative and
# still has constant coefficient one.
bk = [F(1,3)*b_mty[k] + F(2,3)*b_opt[k] for k in range(47)]
assert all(x > 0 for x in bk[1:])
assert bk[1] > 1
b1 = bk[1]
b = sum(bk[1:])
B = F(443795, 100000)

def sin_bounds(x, n=34):
    term = x
    partial = term
    for k in range(n):
        term = -term*x*x/F((2*k+2)*(2*k+3))
        partial += term
    nxt = -term*x*x/F((2*n+2)*(2*n+3))
    return min(partial, partial+nxt), max(partial, partial+nxt)

def cos_bounds(x, n=34):
    term = F(1)
    partial = term
    for k in range(n):
        term = -term*x*x/F((2*k+1)*(2*k+2))
        partial += term
    nxt = -term*x*x/F((2*n+1)*(2*n+2))
    return min(partial, partial+nxt), max(partial, partial+nxt)

def root_function_bounds(x):
    sl, su = sin_bounds(x)
    cl, cu = cos_bounds(x)
    assert sl > 0 and cl > 0
    # f(x)=sin(x)^2-b1+b1*x*cos(x)/sin(x).
    return sl*sl-b1+b1*x*cl/su, su*su-b1+b1*x*cu/sl

lo = F(1132670959, 10**9)
hi = F(1132670962, 10**9)
assert 0 < lo < hi < F(3,2) and hi*hi < 2
flo = root_function_bounds(lo)
fhi = root_function_bounds(hi)
assert flo[0] > 0 and fhi[1] < 0

# The unique MTY root theta lies in (lo,hi). Cosine decreases there.
cos_hi_lower, _ = cos_bounds(hi)
target = F(240358, 5000)  # 48.0716
# R^3=(9/16)*b^2*(b+1)*B^2/cos(theta)^6.
lhs = F(9,16)*b*b*(b+1)*B*B
rhs = target**3*cos_hi_lower**6
assert lhs < rhs

result = {
    "degree": 46,
    "all_bk_positive": True,
    "b1_gt_1": True,
    "minimum_bk_index": min(range(1,47), key=lambda k: bk[k]),
    "minimum_bk_decimal": format(float(min(bk[1:])), ".17g"),
    "theta_bracket": ["1.132670959", "1.132670962"],
    "R_strictly_below": "48.0716",
    "exact_cube_margin_decimal": format(float(rhs-lhs), ".17g")
}
print(json.dumps(result, indent=2))
