{{- $tls_resources := index .Values "node-tls" "resources" }}

{{- range $tls_resources }}
  {{- $secret_name := .spec.secretName }}
  {{- $resource_name := .metadata.name }}
  {{- if or (contains "http" $secret_name) (contains "http" $resource_name) }}
    enabled: true
    pemcert_filepath: certs/{{ $resource_name }}/tls.crt
    pemkey_filepath: certs/{{ $resource_name }}/tls.key
    pemtrustedcas_filepath: certs/{{ $resource_name }}/ca.crt
  {{- end }}
{{- end -}}
