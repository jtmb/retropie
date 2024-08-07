# VARS
source ansible_provisioning/vars/vars.sh

# Ansible Playbook Consumes VARS
cd ansible_provisioning && \
     ANSIBLE_CONFIG=./ansible_provisioning/ansible.cfg ansible-playbook -i inventory.ini main.yml \
    --limit 'all' --skip-tags "packages" --tags "all" \
    --extra-vars "ssh_port=$SSH_PORT RETROPIE_IP=$RETROPIE_IP \
    ssh_cert=$HOME/.ssh/id_ed25519 homedir=$homedir EMULATORS=$EMULATORS \
    ssh_user=$ANSIBLE_SSH_USER ansible_sudo_pass=$ANSIBLE_SUDO_PASS "

# TAGS 
    # config
    # smb 
    # ssh
    # alias
    # cron