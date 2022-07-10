enabled: true
path: "/usr/share/opensearch/plugins/opensearch-security/securityconfig"

{{- range index .Values "node-security-config" "include_config_files" }}

{{- $config_file := . }}
{{- $secret_name := printf "security-%s-secret" $config_file | replace "_" "-" }}

{{- if contains "action-groups-secret" $secret_name }}
actionGroupsSecret: {{ $secret_name }}
{{- end }}

{{- if contains "roles-mapping-secret" $secret_name }}
rolesMappingSecret: {{ $secret_name }}
{{- end }}

{{- if contains "config-secret" $secret_name }}
configSecret: {{ $secret_name }}
{{- end }}

{{- if contains "internal-users" $secret_name }}
internalUsersSecret: {{ $secret_name }}
{{- end }}

{{- if contains "roles-secret" $secret_name }}
rolesSecret: {{ $secret_name }}
{{- end }}

{{- if contains "tenants-secret" $secret_name }}
tenantsSecret: {{ $secret_name }}
{{- end }}

{{- end }}
