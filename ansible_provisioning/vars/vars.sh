# ###########################################################################################################################################################
# #                                                              !!!SET VARS HERE!!!                                                                      # #
# #   Vars must be set in order for ansible deploy to work. If you are unsure about what these VARS do, search for them in the project and get familiar.  # #
#############################################################################################################################################################


# GENERAL VARS
userid=$(whoami)
homedir=/home/$userid/repos/retropie
public_ip=$(curl icanhazip.com)
admin_pub_ip=$(echo ['"'$public_ip/32'"'])

# VAULT AUTH
source $homedir/ansible_provisioning/wrapper-scripts/vault-auth.sh 

# ANSIBLE VARS
ANSIBLE_SUDO_PASS=$(vault kv get -field=admin_pwd kv/admin_pass)
ANSIBLE_SSH_USER=pi
SSH_PORT=22

# INSTANCE IP's
retropie=192.168.0.28