---
name: caduceusmail
description: "☤CaduceusMail lets your OpenClaw automate an enterprise-level communications stack with one domain/mailbox combo."
homepage: https://github.com/lmtlssss/caduceusmail
metadata: {"openclaw":{"emoji":"☤","skillKey":"caduceusmail","requires":{"bins":["bash","pwsh","python3","jq","rg"],"env":["ENTRA_TENANT_ID","ENTRA_CLIENT_ID","ENTRA_CLIENT_SECRET","EXCHANGE_DEFAULT_MAILBOX","EXCHANGE_ORGANIZATION","ORGANIZATION_DOMAIN","CLOUDFLARE_API_TOKEN","CLOUDFLARE_ZONE_ID"]}}}
---

# ☤CaduceusMail 5.2.0

☤CaduceusMail turns one Microsoft 365 mailbox and one Cloudflare zone into an operator controlled mail fabric.

## What this skill can do

* bootstrap Graph and Exchange auth posture
* audit credential and DNS posture
* optimize root mail records
* provision reply and no reply lanes under subdomains
* verify lane readiness
* retire lanes with reply continuity
* generate awareness snapshots and machine readable state artifacts

## First move

Run the doctor before you do anything theatrical.

```bash
python3 {baseDir}/scripts/caduceusmail-doctor.py --json
```

## Quick start

```bash
cp {baseDir}/credentials/entra.txt.template {baseDir}/credentials/entra.txt
cp {baseDir}/credentials/cloudflare.txt.template {baseDir}/credentials/cloudflare.txt

bash {baseDir}/scripts/caduceusmail.sh \
  --organization-domain "example.com" \
  --mailbox "ops@example.com" \
  --bootstrap-auth-mode device
```

## Daily headless run after bootstrap

```bash
bash {baseDir}/scripts/caduceusmail.sh \
  --organization-domain "example.com" \
  --mailbox "ops@example.com" \
  --skip-m365-bootstrap
```

## Lane operations

```bash
python3 {baseDir}/scripts/email_alias_fabric_ops.py provision-lane \
  --mailbox "ops@example.com" \
  --local "support" \
  --domain "support-reply.example.com"

python3 {baseDir}/scripts/email_alias_fabric_ops.py verify-lane \
  --mailbox "ops@example.com" \
  --alias-email "support@support-reply.example.com" \
  --domain "support-reply.example.com"

python3 {baseDir}/scripts/email_alias_fabric_ops.py retire-lane \
  --mailbox "ops@example.com" \
  --alias-email "support@support-reply.example.com"
```

## Probe sending bridge

The skill ships a real `entra-exchange.sh` bridge used by probe sends. It routes to a Graph app only helper and uses `/users/{mailbox}/sendMail` with the lane alias in the `from` field.

## Sandbox and CI smoke path

```bash
bash {baseDir}/scripts/caduceusmail-sandbox-smoke.sh
```

That smoke flow uses `--simulate-bootstrap`, so it does not require PowerShell on the test host.

## OpenClaw runtime pattern

Prefer secret injection through `skills.entries.caduceusmail.env` over editing files in a sandbox. See `examples/openclaw.config.json5` and `docs/openclaw.md`.
Persistence is opt-in through `--persist-env` and `--persist-secrets`.

## Security and Privilege Disclosure

This skill performs high-privilege operations by design:

* Microsoft Graph app role grants
* Exchange service principal and RBAC role assignments
* Exchange accepted-domain tuning (optional flags)
* Cloudflare DNS mutations for lane records

Runtime state artifacts are written under `~/.caduceusmail/intel`. Env/secret persistence to `~/.caduceusmail/.env` is disabled by default and only occurs if you pass `--persist-env` or `--persist-secrets`.

The PowerShell bootstrap may install Microsoft modules from PSGallery (`Install-Module`) when they are missing.

External script resolution is disabled by default. It is only enabled if `CADUCEUSMAIL_ALLOW_EXTERNAL_SCRIPT_RESOLUTION=1` is explicitly set.
