{{- $job_name := index .Values "node-configurator" "jobName" -}}

- apiVersion: batch/v1
  kind: Job
  metadata:
    name: {{ $job_name }}
  spec:
    template:
      metadata:
        name: {{ $job_name }}
      spec:
        restartPolicy: OnFailure
        containers:
          - name: configurator
            image: curlimages/curl:7.70.0
            env:
              - name: OPENSEARCH_CLIENT
                value: https://es-opensearch-client:9200
              - name: OPENSEARCH_PASSWORD
                value: change_me!
            command:
              - "/bin/sh"
              - "/configurator/configurator.sh"
            volumeMounts:
              - name: configurator
                mountPath: /configurator
        volumes:
          - name: configurator
            secret:
              secretName: {{ index .Values "node-configurator" "secretName" }}
              items:
                - key: configurator.sh
                  path: configurator.sh
                {{- range index .Values "node-configurator" "include_config_files" }}
                - key: {{ . }}.json
                  path: {{ . }}.json
                {{- end }}
