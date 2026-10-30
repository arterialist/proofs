#!/usr/bin/env python3
"""
CLI utility to dispatch a mathematical breakthrough notification to the local monitoring portal
and trigger Google Chrome to open/display the event.

Usage:
  python3 monitoring/notify.py \
    --title "Unconditional Bound Extension: σ ≥ 0.9" \
    --summary "Rigorous Lean 4 verified extension of zero-free region." \
    --bounds "σ ≥ 0.9 (Power saving beyond Vinogradov-Korobov)" \
    --severity CRITICAL \
    --type BREAKTHROUGH \
    --lean-file "formalization/BuildingBlocks/ZeroFreeRegionPowerSaving.lean" \
    --commit "abc1234"
"""

import argparse
import json
import os
import subprocess
import sys
import urllib.request

PORT = 8790
HOST = "127.0.0.1"


def dispatch(title, summary, bounds, severity="CRITICAL", kind="BREAKTHROUGH", lean_file="", commit=""):
    payload = {
        "title": title,
        "summary": summary,
        "bounds_impact": bounds,
        "severity": severity,
        "type": kind,
        "lean_file": lean_file,
        "commit": commit
    }

    url = f"http://{HOST}:{PORT}/api/notify"
    data = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(
        url,
        data=data,
        headers={"Content-Type": "application/json"},
        method="POST"
    )

    try:
        with urllib.request.urlopen(req, timeout=5) as resp:
            res_body = resp.read().decode("utf-8")
            print(f"[Success] Breakthrough dispatched to monitoring portal: {res_body}")
    except Exception as e:
        print(f"[Warning] Could not reach running server on port {PORT}: {e}")
        print("Writing directly to breakthroughs.json and opening Google Chrome...")

        # Direct file fallback
        base_dir = os.path.dirname(os.path.abspath(__file__))
        data_file = os.path.join(base_dir, "breakthroughs.json")
        try:
            with open(data_file, "r", encoding="utf-8") as f:
                db = json.load(f)
            if "events" not in db:
                db["events"] = []
            db["events"].append(payload)
            with open(data_file, "w", encoding="utf-8") as f:
                json.dump(db, f, indent=2)
            print("[Success] Written to breakthroughs.json")
        except Exception as fe:
            print(f"[Error] Failed to write directly: {fe}")

        # Open in Chrome
        try:
            subprocess.run(["open", "-a", "Google Chrome", f"http://{HOST}:{PORT}"], check=False)
        except Exception:
            pass


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Dispatch mathematical breakthrough alert.")
    parser.add_argument("--title", required=True, help="Title of the breakthrough")
    parser.add_argument("--summary", required=True, help="Scientific summary")
    parser.add_argument("--bounds", required=True, help="Direct impact on mathematical bounds")
    parser.add_argument("--severity", default="CRITICAL", help="CRITICAL, HIGH, MEDIUM")
    parser.add_argument("--type", default="BREAKTHROUGH", help="BREAKTHROUGH, FORMAL_BOUND_IMPROVEMENT")
    parser.add_argument("--lean-file", default="", help="Path to Lean 4 formalization file")
    parser.add_argument("--commit", default="", help="Git commit hash")

    args = parser.parse_args()
    dispatch(
        title=args.title,
        summary=args.summary,
        bounds=args.bounds,
        severity=args.severity,
        kind=args.type,
        lean_file=args.lean_file,
        commit=args.commit
    )
