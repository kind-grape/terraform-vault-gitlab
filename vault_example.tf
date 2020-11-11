# vars for tf to login to Vault 
variable "ci_jwt" {
  type = string
  description = "jwt token associated to the CI job, an ENV variable"
}

variable "ci_role" {
  type = string
  description = "CI role associated to the CI job, an ENV variable, this is the repo id"
}

provider "vault" {
  # It is strongly recommended to configure this provider through the
  # environment variables described above, so that each user can have
  # separate credentials set in the environment.
  #
  # This will default to using $VAULT_ADDR
  # But can be set explicitly
  # address = "https://vault.example.net:8200"
  # use gitlab CDP login (jwt token)
  auth_login {
    path = "auth/cdp/login"

    parameters = {
      jwt   = var.ci_jwt
      role  = var.ci_role
    }
  }
}

resource "vault_generic_secret" "example" {
  path = "secret/vault_tf_gitlab_demo"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}

resource "vault_policy" "example" {
  name = "vault-terraform-gitlab-demo"

  policy = <<EOT
path "secret/my_app" {
  capabilities = ["update"]
}
EOT
}