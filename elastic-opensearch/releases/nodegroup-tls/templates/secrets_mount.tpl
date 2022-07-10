{{- $tls_resources := index .Values "node-tls" "resources" }}

{{- range $tls_resources }}
  {{- $secret_name := .spec.secretName }}
  {{- $resource_name := .metadata.name }}
  - name: {{ $resource_name }}
    secretName: {{ $secret_name }}
    path: /usr/share/opensearch/config/certs/{{ $resource_name }}
{{- end }}
