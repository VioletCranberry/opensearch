{{- $hostname := printf "dashboards.%s" .Values.common.domain }}

enabled: true
annotations:
  cert-manager.io/cluster-issuer: {{ .Values.common.issuer }}
  external-dns.alpha.kubernetes.io/target: {{ .Values.common.target }}
hosts:
  - host: {{ $hostname }}
    paths:
      - path: /
        backend:
          serviceName: dashboards-opensearch-dashboards
          servicePort: 5601
tls:
  - secretName: "{{ $hostname }}-tls"
    hosts:
      - {{ $hostname }}
