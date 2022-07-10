One way/example to deploy Elastic Opensearch cluster with helmfile.

`Opensearch` cluster nodegroups are treated as separate releases (which is a major difference from deprecated `opendistro` charts), such releases should have the same configuration applied.

What is managed by this `Helmfile` deployment:
- 3 nodegroups (master, client, data) - we are operating a successor of `elasticsearch-oss`
- cluster TLS 
- Opensearch security config + OpenID auth 
- Opensearch Dashboards (ex Kibana)
- ism_policy, index_template and configurator job for these

Ensure you have a separate nodegroup for this cluster (see `elastic-opensearch/values/common` for node affinity settings) with `max_map_count` and `ulimits` bumped up. 

Folder structure:
Common (shared) settings for releases go to `values`, each release under `releases` folder has it's own `values`, subgroups and templates for additional configuration.

```
├── elastic-opensearch
│   ├── config
│   │   ├── dashboards.tpl
│   │   ├── log4j2.properties.tpl
│   │   └── opensearch.tpl
│   ├── helmfile-templates
│   │   └── releases.yaml
│   ├── releases
│   │   ├── configurator
│   │   │   ├── opensearch
│   │   │   │   ├── index_template.gotmpl
│   │   │   │   └── ism_policy.gotmpl
│   │   │   ├── templates
│   │   │   │   ├── configurator.tpl
│   │   │   │   ├── job.tpl
│   │   │   │   └── secrets.tpl
│   │   │   └── values.yaml.gotmpl
│   │   ├── dashboards
│   │   │   ├── templates
│   │   │   │   ├── ingress.tpl
│   │   │   │   └── secrets.tpl
│   │   │   └── values.yaml.gotmpl
│   │   ├── nodegroup
│   │   │   ├── client
│   │   │   │   ├── templates
│   │   │   │   │   └── ingress.tpl
│   │   │   │   └── values.yaml.gotmpl
│   │   │   ├── data
│   │   │   │   └── values.yaml.gotmpl
│   │   │   └── master
│   │   │       └── values.yaml.gotmpl
│   │   ├── nodegroup-security-config
│   │   │   ├── opensearch
│   │   │   │   ├── action_groups.yml.gotmpl
│   │   │   │   ├── config.yml.gotmpl
│   │   │   │   ├── internal_users.yml.gotmpl
│   │   │   │   ├── roles.yml.gotmpl
│   │   │   │   ├── roles_mapping.yml.gotmpl
│   │   │   │   └── tenants.yml.gotmpl
│   │   │   ├── templates
│   │   │   │   ├── secrets.tpl
│   │   │   │   └── securityConfig.tpl
│   │   │   └── values.yaml.gotmpl
│   │   └── nodegroup-tls
│   │       ├── templates
│   │       │   ├── opensearch_tls
│   │       │   │   ├── admin_dn.tpl
│   │       │   │   ├── http.tpl
│   │       │   │   ├── nodes_dn.tpl
│   │       │   │   └── transport.tpl
│   │       │   └── secrets_mount.tpl
│   │       └── values.yaml.gotmpl
│   └── values
│       ├── node-common.yaml
│       ├── node-configurator.yaml
│       ├── node-security-config.yaml
│       └── node-tls.yaml
└── helmfile.yaml
```

This was tested on the cluster running `cert-manager`, `traefik` and `externalDNS` so some adjustment for `requrementes` release resources would be needed if setup is different.

