# Netology MNT 08 — Ansible roles

This directory is organized as three repository-ready projects required by the assignment:

- `../vector-role/` — reusable Vector role.
- `../lighthouse-role/` — reusable LightHouse role.
- `./` — playbook and pinned role requirements.

The ClickHouse role is consumed from `AlexeySetevoi/ansible-clickhouse` at version `1.13`; only the database-creation task remains in this playbook because it is specific to this deployment. Vector and LightHouse are separate roles, each configuring one product. LightHouse deploys its own Nginx configuration and does not depend on the Vector or ClickHouse roles.

## Install and run

The two role repositories and their `1.0.0` tags are published. Install and run:

```sh
ansible-galaxy role install -r requirements.yml -p roles
ansible-playbook site.yml
```

Update the TEST-NET addresses in `inventory/prod.yml` before connecting to recreated hosts. The current sample addresses (`192.0.2.10`–`.12`) are documentation-only and are not reachable targets.

## Tags

- `clickhouse` — upstream ClickHouse role and database creation.
- `database` — only the ClickHouse database task.
- `vector` — Vector role.
- `lighthouse` — LightHouse role.

Example: `ansible-playbook site.yml --tags lighthouse`.

## Assignment answers / deliverables

1. Requirements include ClickHouse `1.13` and both project roles pinned at semantic version `1.0.0`.
2. Created Vector and LightHouse role skeletons with `ansible-galaxy role init`; role tasks, defaults, internal vars, handlers, templates, and documentation are filled in.
3. Playbook uses roles, role/task tags, and a separate deployment-specific task after ClickHouse role.
4. Published repository links:
   - Vector role (`1.0.0`): https://github.com/Voltor-90/vector-role/tree/1.0.0
   - LightHouse role (`1.0.0`): https://github.com/Voltor-90/lighthouse-role/tree/1.0.0
   - Playbook: https://github.com/Voltor-90/netology/tree/main/ansible/04/playbook

The answer file for submission is `../README.md`.

## Validation status

Inventory contains TEST-NET placeholders because the previous cloud VMs were deleted. Syntax and role-template checks can run locally; live installation, idempotence, and HTTP/service checks require recreated hosts.
