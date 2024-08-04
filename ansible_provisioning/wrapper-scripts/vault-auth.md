<h1> Hashicorp Vault Auth for Scripts

# <h3> Set vars from local secrets to not expose enviorment, you need this in your scripts to get pwd values
    AUTH_TOKEN=$(cat /$HOME/.secrets/vault_token)
    VAULT_SERVER=$(cat /$HOME/.secrets/vault_server)

# <h3> Export Values for use in vault, you need this in your scripts to get pwd values
    export VAULT_ADDR=$VAULT_SERVER
    export VAULT_TOKEN=$AUTH_TOKEN

# <h3> Authenticate with vault to retrieve secrets, you need this for every session ran
    vault login $VAULT_TOKEN

<!-- Commands -->
# Other Commands
# <h3> List secrets
    vault secrets list -detailed

# <h3> Insert value ( Will create with a value of redacted)
    vault kv put kv/admin_pass admin_pwd=redacted

# <h3> get value of admin_pwd (if using example would be redacted)
    vault kv get -field=admin_pwd kv/admin_pass

 # Create Token
vault token create -policy=default -period=26h -renewable  -ttl=72h