# brew install --cask google-cloud-sdk
# gcloud init
# gcloud auth application-default login

provider "google" {
  project = var.project_id
  region = var.region
}

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: https://${module.gke.endpoint}
    certificate-authority-data: ${module.gke.ca_certificate}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: gke
  name: gke
current-context: gke
kind: Config
preferences: {}
users:
- name: gke
  user:
    auth-provider:
      config:
        cmd-args: config config-helper --format=json
        cmd-path: "/opt/homebrew/bin/gcloud"
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
KUBECONFIG
}