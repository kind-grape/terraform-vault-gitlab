# terraform-vault-gitlab
Prerequisite: 
1) Vault JWT auth with gitlab should be set up before hand  
2) Also need to create a role for which this gitlab repo CI job will be running  
3) Need to associate a policy to this particular role so that it has right permissions  

```
vault write auth/cdp/role/<project_id> - <<EOF
  {
    "role_type": "jwt",
    "policies": [<policy_name>],
    "user_claim": "user_email",
    "bound_claims_type": "glob",
    "bound_claims": {
    "project_id": <project_id>
  }
}
EOF
```