backend "consul" {
  advertise_addr = "http://{{ ansible_default_ipv4.address }}:{{ vault_port }}"
  address = "{{ ansible_default_ipv4.address }}:{{ consul_https_port }}"
  scheme = "http"
  path = "vault"
}

listener "tcp" {
  address = "0.0.0.0:{{ vault_port }}"
  tls_disable = 1
}

max_lease_ttl = "8760h"
