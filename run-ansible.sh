# VARS
source ansible_provisioning/vars/vars.sh

# Ansible Playbook Consumes VARS
cd ansible_provisioning && \
     ANSIBLE_CONFIG=./ansible_provisioning/ansible.cfg ansible-playbook -i inventory.ini main.yml \
    --limit 'all' --skip-tags "none" --tags "all" \
    --extra-vars "ssh_port=$SSH_PORT RETROPIE_IP=$RETROPIE_IP \
    ssh_cert=$SSH_CERT \
    ssh_user=$ANSIBLE_SSH_USER ansible_sudo_pass=$ANSIBLE_SUDO_PASS \
    EMULATORS=$EMULATORS OPT_PACKAGES=$OPT_PACKAGES \
    OVERCLOCK_RETROPIE=$OVERCLOCK_RETROPIE  \
    OC_CPU_FREQ=$OC_CPU_FREQ OC_CPU_OVERVOLT=$OC_CPU_OVERVOLT OC_GPU_FREQ=$OC_GPU_FREQ"

# TAGS 
    # config
    # smb 
    # ssh
    # alias
    # cron
    # packages
    # bios
    # overclock
