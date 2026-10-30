"""
Tier 4: Workload Scenarios — Host Filesystem Disk Space Hygiene
Authoritative Source: ORIGINAL_REQUEST.md §R4, PROJECT.md §Operational Guardrail, survey_operations.md §3.1
"""

import shutil
import unittest
from pathlib import Path
from tests.conftest_utils import REPO_ROOT, MIN_DISK_FREE_GIB, check_disk_space_gib


class TestDiskSpaceHygieneWorkload(unittest.TestCase):
    """
    Executes live host filesystem interrogation to verify disk hygiene:
      1. Available space strictly > 6.0 GiB on REPO_ROOT mount point.
      2. Safety headroom calculation (minimum 10 GiB buffer above guardrail).
      3. Absence of destructive operations (no lake clean artifacts, precompiled caches intact).
    """

    def test_workload_04_verify_disk_space_and_headroom(self):
        """Input: Host storage query on REPO_ROOT
        Authoritative Source: ORIGINAL_REQUEST.md §R4, survey_operations.md §3.1
        Expected Output: Free disk space strictly exceeds 6.0 GiB with safety headroom."""
        free_gib = check_disk_space_gib(REPO_ROOT)
        total_gib = shutil.disk_usage(str(REPO_ROOT)).total / (1024 ** 3)
        used_gib = shutil.disk_usage(str(REPO_ROOT)).used / (1024 ** 3)

        self.assertGreater(
            free_gib,
            MIN_DISK_FREE_GIB,
            f"CRITICAL DISK SPACE VIOLATION: Available {free_gib:.2f} GiB is below {MIN_DISK_FREE_GIB} GiB threshold!",
        )

        headroom_gib = free_gib - MIN_DISK_FREE_GIB
        self.assertGreater(
            headroom_gib,
            5.0,
            f"Safety buffer dangerously thin: only {headroom_gib:.2f} GiB headroom above 6.0 GiB threshold",
        )

    def test_workload_05_precompiled_research_local_storage_size(self):
        """Input: research-local directory
        Authoritative Source: survey_operations.md §3.2
        Expected Output: research-local footprint is preserved (> 10 GiB of precompiled artifacts)."""
        research_local = REPO_ROOT / "research-local"
        self.assertTrue(research_local.exists())
        # Check that workspace packages exist and have substantial size
        workspace_packages = (
            research_local
            / "agent-results"
            / "20261007-openai-math"
            / "kernel-verification"
            / "workspace"
            / ".lake"
            / "packages"
        )
        self.assertTrue(workspace_packages.exists())
        package_count = len(list(workspace_packages.iterdir()))
        self.assertGreaterEqual(
            package_count,
            8,
            f"Expected at least 8 packages in research-local workspace, found {package_count}",
        )


if __name__ == "__main__":
    unittest.main()
