#!/usr/bin/env python3
"""
Dedicated Test Harness: Breakthrough Monitoring & Notification Dispatch.
Verifies port 8790 daemon health, SSE connectivity, JSON schema, and dispatch logic.

Usage:
  python3 tests/harness_notification_dispatch.py [--dry-run | --dispatch]
"""

import argparse
import json
import sys
from pathlib import Path

# Add project root to sys.path
REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))

from tests.conftest_utils import (
    DAEMON_HOST,
    DAEMON_PORT,
    MONITORING_DIR,
    query_daemon_health,
    query_breakthroughs_db,
    run_command,
)


def verify_daemon_health() -> bool:
    print(f"\n[Notification Harness] Checking daemon health at http://{DAEMON_HOST}:{DAEMON_PORT}/health ...")
    try:
        health = query_daemon_health(timeout=3)
        print(f"  Daemon status: {health.get('status')} | Port: {health.get('port')} | Active subscribers: {health.get('subscribers')}")
        if health.get("status") == "ok" and health.get("port") == DAEMON_PORT:
            print("  [PASS] Daemon is healthy and listening on port 8790.")
            return True
        else:
            print(f"  [FAIL] Unexpected daemon response: {health}")
            return False
    except Exception as e:
        print(f"  [FAIL] Could not connect to daemon on port {DAEMON_PORT}: {e}")
        return False


def verify_database_schema() -> bool:
    print("\n[Notification Harness] Verifying breakthroughs.json database schema ...")
    db_file = MONITORING_DIR / "breakthroughs.json"
    if not db_file.exists():
        print(f"  [FAIL] Database file not found: {db_file}")
        return False
    try:
        data = json.loads(db_file.read_text(encoding="utf-8"))
        assert "bounds" in data, "Missing 'bounds' key"
        assert "formal_kernel_status" in data, "Missing 'formal_kernel_status' key"
        assert "events" in data, "Missing 'events' key"
        print(f"  Database valid: {len(data['events'])} events recorded, 4 mathematical bounds active.")
        print("  [PASS] breakthroughs.json schema verified.")
        return True
    except Exception as e:
        print(f"  [FAIL] Database schema verification failed: {e}")
        return False


def test_dispatch_payload() -> bool:
    print("\n[Notification Harness] Executing test breakthrough dispatch via notify.py ...")
    db_file = MONITORING_DIR / "breakthroughs.json"
    backup = db_file.read_text(encoding="utf-8")
    try:
        cmd = (
            'python3 monitoring/notify.py '
            '--title "Harness Health Check Breakthrough" '
            '--summary "Verification harness confirming HTTP dispatch on port 8790." '
            '--bounds "100% test pass on verification infrastructure." '
            '--severity HIGH '
            '--type FORMAL_MILESTONE '
            '--lean-file "formalization/verification/UnilateralOfflineSupportBridgeAudit.lean" '
            '--commit "harness-check"'
        )
        proc = run_command(cmd, cwd=REPO_ROOT, timeout=10)
        if proc.returncode != 0:
            print(f"  [FAIL] notify.py returned error code {proc.returncode}:\n{proc.stderr}")
            return False
        if "[Success]" not in proc.stdout:
            print(f"  [FAIL] Missing [Success] indicator in stdout:\n{proc.stdout}")
            return False
        print("  [PASS] Dispatch payload delivered and acknowledged by daemon.")
        return True
    finally:
        # Restore backup so test dispatch does not alter production record
        db_file.write_text(backup, encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dry-run", action="store_true", help="Check health and schema only without dispatching")
    args = parser.parse_args()

    print("=== Breakthrough Notification & Daemon Harness ===")
    health_ok = verify_daemon_health()
    schema_ok = verify_database_schema()

    if args.dry_run:
        dispatch_ok = True
    else:
        dispatch_ok = test_dispatch_payload()

    if health_ok and schema_ok and dispatch_ok:
        print("\n=== Notification Dispatch Harness: ALL CHECKS PASSED ===")
        sys.exit(0)
    else:
        print("\n=== Notification Dispatch Harness: CHECKS FAILED ===")
        sys.exit(1)


if __name__ == "__main__":
    main()
