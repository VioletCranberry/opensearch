{{- $tls_resources := index .Values "node-tls" "resources" }}

{{- range $tls_resources }}
  {{- $secret_name := .spec.secretName }}
  {{- $resource_name := .metadata.name }}
  {{- if or (contains "http" $secret_name) (contains "http" $resource_name) }}
    - name: {{ $resource_name }}
      secretName: {{ $secret_name }}
      path: /usr/share/opensearch-dashboards/config/certs/{{ $resource_name }}
  {{- end }}
{{- end }}
