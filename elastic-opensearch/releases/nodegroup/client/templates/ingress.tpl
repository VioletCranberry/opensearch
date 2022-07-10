{{- $hostname := printf "opensearch.%s" .Values.common.domain }}

- apiVersion: externaldns.k8s.io/v1alpha1
  kind: DNSEndpoint
  metadata:
    name: es-opensearch
  spec:
    endpoints:
      - dnsName: {{ $hostname }}
        recordType: CNAME
        targets:
          - {{ .Values.common.target }}

- apiVersion: cert-manager.io/v1
  kind: Certificate
  metadata:
    name: {{ $hostname }}-tls
  spec:
    secretName: {{ $hostname }}-tls
    issuerRef:
      name: {{ .Values.common.issuer }}
      kind: ClusterIssuer
    dnsNames:
      - {{ $hostname }}

- apiVersion: traefik.containo.us/v1alpha1
  kind: IngressRouteTCP
  metadata:
    name: es-opensearch
  spec:
    entryPoints:
      - websecure
    routes:
      - match: HostSNI(`{{ $hostname }}`)
        kind: Rule
        services:
          - name: {{ .Values.opensearch_cluster.name }}-{{ index .Values "nodegroup-client" "nodeGroup" }}
            port: 9200
    tls:
      secretName: {{ $hostname }}-tls
      passthrough: true
