This dependency-free Lean 4.34.1 package walks the loaded types and bodies of a bound set of imported declarations. It bypasses Lean's cached `exportedAxiomsExt` summaries and rejects axioms outside the exact allowlist `propext`, `Classical.choice`, `Quot.sound`.

Run the core regression suite with an already installed native Lean 4.34.1 compiler:

```sh
python3 run_core_fixtures.py
# Or select the native executable explicitly:
python3 run_core_fixtures.py --lean /path/to/toolchain/bin/lean
```

The runner checks the version, compiles this collector first, and compiles only tiny core fixtures in a fresh temporary directory. It invokes no Lake commands, installs, network access, cache retrieval or Mathlib build. It rejects recognized elan shims before invocation, including configured `ELAN_HOME/bin` paths and hardlinks to sibling or discoverable elan executables. An explicitly supplied executable must still be trusted as native; this guard cannot identify arbitrary wrappers. JSON receipts retain source and compiled artifact hashes, command arguments, exits, outputs and marker assertions under `audit-results/`; temporary build files are removed. Compiler and temporary-directory arguments use documented placeholders in the receipt.

The separate `python3 test_compiler_guard.py` regression checks compiler selection with temporary fake files, hardlinks and symlinks; it invokes no executable. Its JSON receipt records each expected selection/rejection.

The eleven audit cases cover the exact allowed-axiom union; a forbidden external axiom behind imported private and opaque proofs; empty roots; unresolved constants; wrong module scope; wrong root count; a resource limit; a restricted module view; a missing private artifact; a custom module prefix; and rejection of the wrong prefix. Successful cases require the pass marker and body traces; all negative cases require the intended failure markers and forbid the pass marker.

To audit another project already compiled on this same toolchain, first compile the collector into a task-owned object directory. The fixture runner removes its temporary binaries, so they cannot be reused. On a POSIX shell, using a trusted native executable:

```sh
LEAN_434=/path/to/toolchain/bin/lean
AUDIT_PACKAGE=/path/to/lean434-axiom-audit
AUDIT_OBJECTS=/path/to/task-owned/audit-objects
mkdir -p "$AUDIT_OBJECTS"
cd "$AUDIT_PACKAGE"
LEAN_PATH="$AUDIT_OBJECTS" "$LEAN_434" -o "$AUDIT_OBJECTS/UncachedBodyAudit.olean" UncachedBodyAudit.lean
```

Create a **non-module** driver in the target project's source directory that imports the collector and the exact target modules. Replace the module array and count with independently inventoried values:

```lean
import UncachedBodyAudit
import MyProject.Target

run_cmd UncachedBodyAudit.verifyModules #[`MyProject.Target] 42 `MyProject
```

Run that driver with the collector objects and the project's complete compiled import path, including its matching dependencies:

```sh
cd /path/to/project
PROJECT_IMPORT_PATH=/path/to/project/compiled/modules:/path/to/compiled/dependency/modules
LEAN_PATH="$AUDIT_OBJECTS:$PROJECT_IMPORT_PATH" "$LEAN_434" AuditActual.lean
```

`PROJECT_IMPORT_PATH` is a colon-separated POSIX example; it must contain the actual full search path of the already compiled project. Keep every artifact on Lean 4.34.1 and the project's exact compatible package pins. This setup does not prove that an arbitrary project wrapper resolves or builds correctly.

`42` is an example, not an inferred count. The module prefix defaults to `BuildingBlocks` when the third argument is omitted. Selection uses each declaration's physical declaring module, including declarations in unrelated namespaces. The driver must import exactly the listed modules within the selected prefix. The prefix limits root selection only: the traversal follows dependencies in every namespace and module. All declarations in the expected modules become roots, so auxiliary, private, definition and theorem declarations count too.

The collector requires a full non-module/private import view with data and `importAll` for every effective import. It rejects an empty scope, scope/count mismatches, unresolved constants, unsafe or partial definitions, nonclosed expressions and resource exhaustion. It traverses declaration types, theorem/opaque/definition values, mutual inductive members, constructors and recursor rules. A nonallowlisted `axiomInfo` fails even if it could represent an erased theorem body. It never treats unavailable bodies as permission to skip a dependency. `BODY_VISITED` reports bodies from expected root modules; `DEPENDENCY_BODY_VISITED` reports other bodies reached recursively.

A pass means that this walk of the **loaded checked environment** found only the three allowed axiom names. It is not an independent kernel replay, a check that source files match compiled artifacts, a verification of standard axiom identity or a proof of RH. Allowed axiom types are traversed, but their types are not compared with a separately trusted canonical definition. Quotient and other kernel-generated declaration kinds have types and structural references checked as described above; their kernel semantics are a trust boundary. The collector and the Lean runtime/imported environment must themselves be trusted. Use separate kernel replay, source/definition comparison and foundation checks where those claims are required. A fresh kernel replay by itself does not enforce this allowlist.

This is an Apache-2.0 adaptation of Lean's `Lean/Util/CollectAxioms.lean`, originally by Leonardo de Moura, copyright Microsoft Corporation. The preserved license and `SOURCE-PROVENANCE.json` record the official v4.34.1 source hashes and the changes made here. The minimal `lakefile.toml` declares only this library and no external dependencies; the fixture runner does not execute it.
