# Changelog

## 5.1.0

This release turns ☤CaduceusMail into a full repository grade skill bundle.

### Added

* `VERSION`, `CHANGELOG.md`, `pyproject.toml`, `Makefile`, and test suite
* `scripts/caduceusmail-doctor.py` plus `src/caduceusmail/doctor.py`
* `scripts/entra-exchange.sh` and `scripts/send_mail_graph.py` for probe sends
* `examples/openclaw.config.json5`
* `docs/architecture.md`, `docs/openclaw.md`, and `docs/node-bootstrap.md`
* `--simulate-bootstrap` path in the shell wrapper for smoke tests and CI like environments

### Changed

* `SKILL.md` stays ClawHub safe with single line JSON metadata
* shell wrapper now skips PowerShell dependency when bootstrap is simulated or skipped
* bootstrap script is shipped as both `.ps1` and `.ps1.txt`
* repo layout is now ready for GitHub release zips and ClawHub publishing

### Fixed

* missing `entra-exchange.sh` bridge used by probe sends
* sandbox smoke flow no longer depends on a local browser or installed PowerShell
* normalized canonical identity to `☤CaduceusMail` + `caduceusmail` across scripts, docs, and metadata
* default behavior is non-persistent; env/secret writes now require explicit `--persist-env`/`--persist-secrets`
* external script resolution is now opt-in via `CADUCEUSMAIL_ALLOW_EXTERNAL_SCRIPT_RESOLUTION=1`
