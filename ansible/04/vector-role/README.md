# vector-role

Ansible role to install Vector from its versioned archive, install a systemd unit, deploy its YAML configuration, and enable/start the service. Based on the Vector tasks and templates from the Netology MNT lesson 3 playbook.

## Requirements

- Ansible 2.14 or newer.
- Ubuntu/Debian host with systemd and network access to the configured Vector archive.
- Run with privilege escalation (`become: true`).

## Role variables

| Variable | Default | Purpose |
|---|---|---|
| `vector_version` | `0.61.0` | Vector release. |
| `vector_arch` | `x86_64-unknown-linux-musl` | Archive target architecture. |
| `vector_download_url` | Derived from version and architecture | Archive URL; override for a mirror. |
| `vector_data_dir` | `/var/lib/vector` | Vector state directory. |
| `vector_config_dir` | `/etc/vector` | Configuration directory. |
| `vector_install_dir` | `/opt/vector` | Extracted installation directory. |
| `vector_service_user` / `vector_service_group` | `vector` | Dedicated service account. |
| `vector_config` | Demo JSON logs to console | Complete Vector configuration mapping, rendered as YAML. |

Internal paths (`vector_archive_path`, `vector_binary_path`, `vector_systemd_unit`) are defined in `vars/main.yml` and are not intended as user overrides.

## Example

```yaml
- hosts: vector
  become: true
  roles:
    - role: vector
      tags: [vector]
```

Set any defaults in inventory/group vars or pass them under the role entry. The sample config is a demonstration pipeline; replace `vector_config` for production use.

## License

MIT
