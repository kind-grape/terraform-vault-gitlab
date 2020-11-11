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
Following gitlab var would need to be setup. Currently it's set as gitlab CI var
```
VAULT_ADDR='https://vault-dev.npe-services.t-mobile.com'
# skip tf vault provider tls check
VAULT_SKIP_VERIFY=1
```
## Need to be improved
Currently no state backend defined, relying gitlab runner in mem state (flushes after each run)
So could not keep state data. Would need to use remote state if drift-detection is required