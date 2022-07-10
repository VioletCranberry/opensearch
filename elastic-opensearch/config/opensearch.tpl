network.host: 0.0.0.0
plugins:
  security:
    allow_unsafe_democertificates: false
    allow_default_init_securityindex: true
    nodes_dn:
      {{- tpl (readFile "../../nodegroup-tls/templates/opensearch_tls/nodes_dn.tpl") . | indent 2 }}
    ssl:
      transport:
        {{- tpl (readFile "../../nodegroup-tls/templates/opensearch_tls/transport.tpl") . | indent 4 }}
      http:
        {{- tpl (readFile "../../nodegroup-tls/templates/opensearch_tls/http.tpl") . | indent 4 }}
    authcz:
      admin_dn:
        {{- tpl (readFile "../../nodegroup-tls/templates/opensearch_tls/admin_dn.tpl") . | indent 4 }}
    audit.type: internal_opensearch
    restapi:
      roles_enabled:
        - "all_access"
