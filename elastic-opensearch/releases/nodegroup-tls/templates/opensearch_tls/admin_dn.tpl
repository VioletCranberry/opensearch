{{- $tls_resources := index .Values "node-tls" "resources" }}

{{- range $tls_resources }}
  {{- $secret_name := .spec.secretName }}
  {{- $resource_name := .metadata.name }}
  {{- if or (contains "admin" $secret_name) (contains "admin" $resource_name) }}
    {{- $common_name := .spec.commonName }}
    - 'CN={{ $common_name }}'
  {{- end }}
{{- end -}}
