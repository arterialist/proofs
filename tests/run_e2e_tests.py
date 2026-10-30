#!/usr/bin/env python3
"""
Master E2E Test Suite Runner for Riemann Hypothesis Verification.
Requirement-driven, 4-tier verification orchestrator.

Usage:
  python3 tests/run_e2e_tests.py [--tier 1|2|3|4] [-v]
"""

import argparse
import sys
import time
import unittest
from pathlib import Path

# Add project root to sys.path
REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))

TIERS = [
    ("Tier 1", "Feature Coverage (Inventory F1-F8)", "tests/tier1_feature_coverage"),
    ("Tier 2", "Boundary & Corner Cases", "tests/tier2_boundary_corner"),
    ("Tier 3", "Cross-Feature Interactions", "tests/tier3_cross_feature"),
    ("Tier 4", "Real-World Workload Scenarios", "tests/tier4_workload_scenarios"),
    ("Tier 5", "Adversarial Coverage Hardening", "tests/tier5_adversarial_hardening"),
]


def run_tier(tier_num: int, tier_name: str, tier_dir: str, verbose: int) -> dict:
    loader = unittest.TestLoader()
    suite = loader.discover(tier_dir)
    runner = unittest.TextTestRunner(verbosity=verbose)
    start_time = time.time()
    result = runner.run(suite)
    duration = time.time() - start_time

    return {
        "tier_num": tier_num,
        "name": tier_name,
        "run": result.testsRun,
        "failures": len(result.failures),
        "errors": len(result.errors),
        "passed": result.testsRun - len(result.failures) - len(result.errors),
        "duration": duration,
        "success": result.wasSuccessful(),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tier", type=int, choices=[1, 2, 3, 4, 5], help="Run specific tier only")
    parser.add_argument("-v", "--verbose", action="count", default=1, help="Verbosity level")
    args = parser.parse_args()

    print("=" * 80)
    print("      E2E VERIFICATION TEST RUNNER — RIEMANN HYPOTHESIS PROOF")
    print("      Foundational Axiom Set: [propext, Classical.choice, Quot.sound]")
    print("      Zero-Tolerance Quality Guards: 0 sorry, 0 sorryAx, 0 custom axioms")
    print("=" * 80)

    selected_tiers = [t for i, t in enumerate(TIERS, 1) if args.tier is None or args.tier == i]
    results = []

    for i, (tier_label, tier_name, tier_dir) in enumerate(selected_tiers, 1):
        actual_tier_num = args.tier if args.tier else i
        print(f"\n>>> Running {tier_label}: {tier_name} ({tier_dir})")
        res = run_tier(actual_tier_num, tier_name, tier_dir, args.verbose)
        results.append(res)

    print("\n" + "=" * 80)
    print(f"{'Tier':<10} | {'Scope Description':<36} | {'Tests':<6} | {'Pass':<6} | {'Fail':<6} | {'Time (s)':<8}")
    print("-" * 80)

    total_run = 0
    total_passed = 0
    total_failures = 0
    total_duration = 0.0
    all_ok = True

    for r in results:
        total_run += r["run"]
        total_passed += r["passed"]
        total_failures += (r["failures"] + r["errors"])
        total_duration += r["duration"]
        if not r["success"]:
            all_ok = False
        print(
            f"Tier {r['tier_num']:<5} | {r['name'][:36]:<36} | {r['run']:<6} | {r['passed']:<6} | {r['failures'] + r['errors']:<6} | {r['duration']:<8.3f}"
        )

    print("-" * 80)
    print(
        f"{'TOTAL':<10} | {'All Active Tiers':<36} | {total_run:<6} | {total_passed:<6} | {total_failures:<6} | {total_duration:<8.3f}"
    )
    print("=" * 80)

    if all_ok:
        print("\n[VERDICT: PASSED] 100% of E2E verification test cases passed successfully.")
        sys.exit(0)
    else:
        print(f"\n[VERDICT: FAILED] {total_failures} test case(s) failed.")
        sys.exit(1)


if __name__ == "__main__":
    main()
