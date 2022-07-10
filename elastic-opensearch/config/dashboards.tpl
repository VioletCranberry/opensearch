opensearch.username: "kibanaserver"
opensearch.password: {{ .Values.opensearch.password }}
opensearch.requestHeadersWhitelist: [ "authorization" ]
opensearch.ssl.verificationMode: certificate
opensearch.ssl.certificateAuthorities: [ "/usr/share/opensearch-dashboards/config/certs/opensearch-http/ca.crt" ]
opensearch_security.multitenancy.enabled: false
opensearch_security.readonly_mode.roles: ["opensearch_dashboards_read_only"]
opensearch_security.auth.type: openid
opensearch_security.openid.client_id: change_me!
opensearch_security.openid.client_secret: change_me!
opensearch_security.openid.base_redirect_url: https://dashboards.{{ .Values.common.domain }}
opensearch_security.openid.connect_url: {{ .Values.openid.url }}
logging.verbose: false
