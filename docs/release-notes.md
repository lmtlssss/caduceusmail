# Release notes for 5.2.0

This release hardens metadata and disclosure coherence for security scanners and operators.

Highlights:

* `SKILL.md` now declares the full sensitive env set used by runtime paths (`ENTRA_CLIENT_SECRET`, Cloudflare token/zone, and organization keys).
* `SKILL.md` now declares complete runtime binaries (`pwsh` and `rg` added).
* Skill docs now explicitly disclose high-privilege operations, opt-in secret persistence behavior, and PowerShell module installation behavior.
* Regression tests now enforce the sensitive env and binary declaration set so future releases cannot silently drift.
