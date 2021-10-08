resource "tls_private_key" "linkerd" {
  for_each    = toset(["trust_anchor", "issuer"])
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_self_signed_cert" "linkerd-trust-anchor" {
  key_algorithm     = tls_private_key.linkerd["trust_anchor"].algorithm
  private_key_pem   = tls_private_key.linkerd["trust_anchor"].private_key_pem
  is_ca_certificate = true

  validity_period_hours = "1"

  allowed_uses = ["cert_signing", "crl_signing", "server_auth", "client_auth"]

  subject {
    common_name = "root.linkerd.cluster.local"
  }
}

resource "tls_self_signed_cert" "linkerd-issuer" {
  key_algorithm     = tls_private_key.linkerd["issuer"].algorithm
  private_key_pem   = tls_private_key.linkerd["issuer"].private_key_pem
  is_ca_certificate = true

  validity_period_hours = "1"

  allowed_uses = ["cert_signing", "crl_signing"]

  subject {
    common_name = "webhook.linkerd.cluster.local"
  }
}