- apiVersion: v1
  kind: Secret
  metadata:
    name: {{ index .Values "node-configurator" "secretName" }}
  stringData:
    configurator.sh: |-
      {{- tpl (readFile "./templates/configurator.tpl" ) $ | nindent 8 }}

    {{- range index .Values "node-configurator" "include_config_files" }}
    {{- $config_file := . }}
    {{- $config_path := printf "./opensearch/%s.gotmpl" $config_file }}

    {{- $config_data := tpl (readFile $config_path ) $ | nindent 8 }}

    {{ $config_file }}.json: |-
      {{- $config_data }}

    {{- end }}
