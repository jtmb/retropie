# Cert Location, resolves certificate type
# Define the primary and fallback SSH certificate paths
PRIMARY_CERT="$HOME/.ssh/id_ed25519"
FALLBACK_CERT="$HOME/.ssh/id_rsa"
if [[ -f "$PRIMARY_CERT" ]]; then
SSH_CERT="$PRIMARY_CERT"
else
SSH_CERT="$FALLBACK_CERT"