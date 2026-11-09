# lighthouse-role

Ansible role to install Nginx, deploy a pinned LightHouse static-site archive, configure a virtual host, and enable the site. Based on the LightHouse tasks and template from the Netology MNT lesson 3 playbook.

## Requirements

- Ansible 2.14 or newer.
- Ubuntu/Debian host with systemd and network access to GitHub codeload.
- Run with privilege escalation (`become: true`). The role installs Nginx and `unzip` itself.

## Role variables

| Variable | Default | Purpose |
|---|---|---|
| `lighthouse_commit` | `d701335c25cd1bb9b5155711190bad8ab852c2ce` | Pinned upstream revision used for reproducible download. |
| `lighthouse_archive_url` | Codeload URL for that commit | Archive URL; override to use a mirror. |
| `lighthouse_listen_port` | `80` | Nginx HTTP port. |
| `lighthouse_server_name` | `_` | Nginx server name. |
| `lighthouse_web_root` | `/var/www/lighthouse-<commit>` | Document root. |
| `lighthouse_site_name` | `lighthouse` | Nginx site file/link name. |
| `lighthouse_packages` | `[nginx, unzip]` | Packages installed by this role. |

Internal archive and Nginx directory paths in `vars/main.yml` are implementation details.

## Example

```yaml
- hosts: lighthouse
  become: true
  roles:
    - role: lighthouse
      tags: [lighthouse]
```

## Dependencies

No Ansible role dependencies. Nginx and `unzip` are installed by the role.

## License

MIT
