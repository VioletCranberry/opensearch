{{- $tls_resources := index .Values "node-tls" "resources" }}

{{- range $tls_resources }}
  {{- $secret_name := .spec.secretName }}
  {{- $resource_name := .metadata.name }}
  {{- if or (contains "transport" $secret_name) (contains "transport" $resource_name) }}
    enforce_hostname_verification: false
    resolve_hostname: false
    pemcert_filepath: certs/{{ $resource_name }}/tls.crt
    pemkey_filepath: certs/{{ $resource_name }}/tls.key
    pemtrustedcas_filepath: certs/{{ $resource_name }}/ca.crt
  {{- end }}
{{- end -}}
