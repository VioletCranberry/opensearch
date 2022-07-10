{{- range index .Values "node-security-config" "include_config_files" }}

  {{- $config_file := . }}
  {{- $config_path := printf "./opensearch/%s.yml.gotmpl" $config_file }}
  {{- $config_data := tpl (readFile $config_path ) $ | nindent 8 }}

  {{- $secret_name := printf "security-%s-secret" $config_file | replace "_" "-" }}

  - apiVersion: v1
    kind: Secret
    metadata:
      name: {{ $secret_name }}
    data:
      {{ $config_file }}.yml: {{ $config_data | b64enc }}

{{- end }}
