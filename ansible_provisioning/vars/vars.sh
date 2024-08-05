# ###########################################################################################################################################################
# #                                                              !!!SET VARS HERE!!!                                                                      # #
# #   Vars must be set in order for ansible deploy to work. If you are unsure about what these VARS do, search for them in the project and get familiar.  # #
#############################################################################################################################################################

# VAULT AUTH
source $homedir/ansible_provisioning/wrapper-scripts/vault-auth.sh 

# ANSIBLE VARS
ANSIBLE_SUDO_PASS=$(vault kv get -field=admin_pwd kv/admin_pass)
ANSIBLE_SSH_USER=pi
SSH_PORT=2002

# INSTANCE IP's
RETROPIE_IP=192.168.0.28