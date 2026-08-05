# Project instructions

Before planning or modifying files, read:

`~/projects/AGENTS.md`

If the workspace policy cannot be read, stop and report that it is unavailable.

The rules below supplement or tighten the workspace policy for this repository.

## Project boundary

- This maintenance Python utility reads local RAID topology and SMART state, stores JSON snapshots, and is used on operator systems.
- Preserve the documented JSON structure, raw SMART preservation, conservative OK/WARN/FAIL rules, and exit codes.
- Future tests must use synthetic command output and temporary configuration; do not query real disks, controllers, or stored operator snapshots.

## Operational boundary and done criteria

- `raidmon build-config`, `collect`, and `check` are hardware/runtime operations, not development checks. Run none without a direct diagnostic request.
- `make install` and `make uninstall` write system locations and require an explicit installation request; do not invoke `sudo` as verification.
- There is no automated test suite, safe check target, or CI workflow.
- Changes are complete only after static review and documented synthetic validation, with hardware verification explicitly deferred unless requested.
