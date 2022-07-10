#!/bin/sh

# TODO: refactor

auth=$(echo "admin:$OPENSEARCH_PASSWORD" | base64)
opensearch_url="$OPENSEARCH_CLIENT"

upload_file() {
  opensearch_url="$1" file_path="$2"
  curl -X PUT --insecure --no-progress-meter `
  `--fail `
  `--header "Content-Type: application/json" `
  `--header "Authorization: Basic $auth" `
  `--data "@$file_path" "$opensearch_url"
}

delete_file() {
  opensearch_url="$1" file_path="$2"
  curl -X DELETE --insecure --no-progress-meter `
  `--fail `
  `--header "Content-Type: application/json" `
  `--header "Authorization: Basic $auth" `
  `--data "@$file_path" "$opensearch_url"
}

cluster_init() {
  until curl --insecure --silent --fail --output /dev/null `
    `--header "Authorization: Basic $auth" "$opensearch_url";
  do
    printf "\n%s" "opensearch cluster is not initialised!"
    sleep 5
  done
}

main() {

  cluster_init

  delete_file "$opensearch_url/_plugins/_ism/policies/default_retention_workflow" `
                                                 `'/configurator/ism_policy.json'
  delete_file "$opensearch_url/_index_template/default_index_template" `
                                             `'/configurator/index_template.json'

  upload_file "$opensearch_url/_plugins/_ism/policies/default_retention_workflow" `
                                                 `'/configurator/ism_policy.json'
  upload_file "$opensearch_url/_index_template/default_index_template" `
                                             `'/configurator/index_template.json'

}

main