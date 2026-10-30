"""
Shared test utilities, fixtures, and execution helpers for the E2E verification suite.
"""

import json
import os
import shutil
import subprocess
import sys
import urllib.request
import urllib.error
from pathlib import Path

# Repository root and key paths
REPO_ROOT = Path("/Users/arterialist/Projects/proofs").resolve()
FORMALIZATION_DIR = REPO_ROOT / "formalization"
BUILDING_BLOCKS_DIR = FORMALIZATION_DIR / "BuildingBlocks"
VERIFICATION_DIR = FORMALIZATION_DIR / "verification"
INTEGRATIONS_DIR = FORMALIZATION_DIR / "integrations"
AXIOM_AUDIT_DIR = INTEGRATIONS_DIR / "lean434-axiom-audit"
MONITORING_DIR = REPO_ROOT / "monitoring"

# Toolchain configuration
ELAN_BIN = Path.home() / ".elan" / "bin"
LEAN_BIN = ELAN_BIN / "lean"
LAKE_BIN = ELAN_BIN / "lake"
NATIVE_LEAN_BIN = (
    Path.home()
    / ".elan"
    / "toolchains"
    / "leanprover--lean4---v4.34.1"
    / "bin"
    / "lean"
)

# Operational guardrails
MIN_DISK_FREE_GIB = 6.0
DAEMON_HOST = "127.0.0.1"
DAEMON_PORT = 8790
DAEMON_BASE_URL = f"http://{DAEMON_HOST}:{DAEMON_PORT}"

# Foundational Lean 4 axioms allowed by R2
STANDARD_FOUNDATIONAL_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}


def get_elan_env():
    """Return environment dict with elan bin prepended to PATH."""
    env = os.environ.copy()
    current_path = env.get("PATH", "")
    if str(ELAN_BIN) not in current_path:
        env["PATH"] = f"{ELAN_BIN}:{current_path}"
    return env


def run_command(cmd, cwd=REPO_ROOT, timeout=120):
    """Execute shell command with elan PATH and return CompletedProcess."""
    env = get_elan_env()
    return subprocess.run(
        cmd,
        shell=True if isinstance(cmd, str) else False,
        cwd=str(cwd),
        env=env,
        capture_output=True,
        text=True,
        timeout=timeout,
    )


def check_disk_space_gib(path=REPO_ROOT):
    """Return available disk space in GiB."""
    usage = shutil.disk_usage(str(path))
    return usage.free / (1024 ** 3)


def query_daemon_health(timeout=3):
    """Query GET /health from the monitoring daemon."""
    req = urllib.request.Request(f"{DAEMON_BASE_URL}/health")
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return json.loads(resp.read().decode("utf-8"))


def query_breakthroughs_db(timeout=3):
    """Query GET /api/breakthroughs from the monitoring daemon."""
    req = urllib.request.Request(f"{DAEMON_BASE_URL}/api/breakthroughs")
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return json.loads(resp.read().decode("utf-8"))
