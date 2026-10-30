#!/usr/bin/env python3
"""
Dedicated Test Harness: Host Storage & Disk Hygiene Check.
Ensures available filesystem space strictly exceeds the mandatory 6.0 GiB guardrail.

Usage:
  python3 tests/harness_disk_check.py
"""

import shutil
import sys
from pathlib import Path

# Add project root to sys.path
REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))

from tests.conftest_utils import (
    MIN_DISK_FREE_GIB,
    check_disk_space_gib,
)


def main():
    print("=== Host Storage & Disk Space Hygiene Harness ===")
    free_gib = check_disk_space_gib(REPO_ROOT)
    usage = shutil.disk_usage(str(REPO_ROOT))
    total_gib = usage.total / (1024 ** 3)
    used_gib = usage.used / (1024 ** 3)
    headroom_gib = free_gib - MIN_DISK_FREE_GIB

    print(f"  Target Path:      {REPO_ROOT}")
    print(f"  Total Capacity:   {total_gib:.2f} GiB")
    print(f"  Used Space:       {used_gib:.2f} GiB ({usage.used / usage.total * 100:.1f}%)")
    print(f"  Available Space:  {free_gib:.2f} GiB")
    print(f"  Required Minimum: {MIN_DISK_FREE_GIB:.2f} GiB")
    print(f"  Safety Headroom:  {headroom_gib:.2f} GiB")

    if free_gib <= MIN_DISK_FREE_GIB:
        print(f"\n[CRITICAL FAILURE] Free disk space ({free_gib:.2f} GiB) violates minimum threshold ({MIN_DISK_FREE_GIB:.2f} GiB)!")
        sys.exit(1)

    print(f"\n[PASS] Disk hygiene verified: {free_gib:.2f} GiB free exceeds {MIN_DISK_FREE_GIB:.2f} GiB guardrail by {headroom_gib:.2f} GiB.")
    sys.exit(0)


if __name__ == "__main__":
    main()
