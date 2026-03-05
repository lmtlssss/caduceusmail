---
name: caduceusmail
description: "☤CaduceusMail lets your OpenClaw automate an enterprise-level communications stack with one domain/mailbox combo."
homepage: https://github.com/lmtlssss/caduceusmail
metadata: {"openclaw":{"emoji":"☤","skillKey":"caduceusmail","requires":{"bins":["bash","python3","jq"],"env":["ENTRA_CLIENT_ID","ENTRA_TENANT_ID","EXCHANGE_DEFAULT_MAILBOX"]}}}
---

# ☤CaduceusMail 5.1.0

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
