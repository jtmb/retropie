# ###########################################################################################################################################################
# #                                                              !!!SET VARS HERE!!!                                                                      # #
# #   Vars must be set in order for ansible deploy to work. If you are unsure about what these VARS do, search for them in the project and get familiar.  # #
#############################################################################################################################################################

# VAULT AUTH
source ansible_provisioning/wrapper-scripts/vault-auth.sh 

# ANSIBLE VARS
ANSIBLE_SUDO_PASS=$(vault kv get -field=admin_pwd kv/admin_pass)
ANSIBLE_SSH_USER=pi
SSH_PORT=2002

# Cert Location, resolves certificate type
# Define the primary and fallback SSH certificate paths
    PRIMARY_CERT="$HOME/.ssh/id_ed25519"
    FALLBACK_CERT="$HOME/.ssh/id_rsa"
    if [[ -f "$PRIMARY_CERT" ]]; then
    SSH_CERT="$PRIMARY_CERT"
    else
    SSH_CERT="$FALLBACK_CERT"
    fi

# INSTANCE IP's
RETROPIE_IP=192.168.0.28

# List of pre-installed emulators aand optional packages in JSON format
EMULATORS='[\"arcade\",\"atari7800\",\"gba\",\"gbc\",\"genesis\",\"mame-liberto\",\"megadrive\",\"ports\",\"snes\",\"psx\",\"n64\"]'
OPT_PACKAGES='["steamlink","skyscraper","lr-prboom","darkplaces-quake","eduke32","ioquake3","kodi","lzdoom"]'

# OVERCLOCKING - ALL VALUES IN MHz (PROCEED AT OWN RISK)
OVERCLOCK_RETROPIE=true
OC_CPU_FREQ=1750 #default 800
OC_CPU_OVERVOLT=600 #default 0
OC_GPU_FREQ=740  #default 700