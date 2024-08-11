<h1 align="center">
  <a href="https://github.com/jtmb">
    <img src="https://www.petrockblock.com/wp-content/uploads/2015/06/RetroPieLogo2015Download.png" alt="Logo" width="140" height="125">
  </a>
</h1>

<div align="center">
  <b>RETROPIE</b> - A simple repo for retropie env specific configs and setups.
  <br />
  <br />
  <a href="https://github.com/jtmb/retropie/issues/new?assignees=&labels=bug&title=bug%3A+">Report a Bug</a>
</div>
<br>
<details open="open">
<summary>Table of Contents</summary>


- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started) 
- [Environment Variables Explained](#environment-variables-explained)
- [Contributing](#contributing)
- [License](#license)

</details>
<br>

---  
## Prerequisites
- Debian based Operating system with RetroPie with ssh enabled
- [Ansible](how-to/How-to-install-ansible.md) installed on your machine

### Getting Started


A simple run command gets your instance running:

( *Make sure to set your vars in ansible_provisioning/vars/vars.sh* )
```shell
./run-ansible.sh
```

or pass in the vars yourself at run time:
```shell
./run-ansible.sh \
    RETROPIE_IP=192.168.0.XX SSH_PORT=2002 \
    ANSIBLE_SSH_USER=pi ANSIBLE_SUDO_PASS=raspberry \
```

## Environment Variables explained

```shell
    ANSIBLE_SUDO_PASS=raspberry
```  
The password to connect to over ssh, default retro pie ssh pass is raspberry
```shell
    ANSIBLE_SSH_USER=pi
```  
The user to connect to over ssh, default retro pie ssh pass is pi
```shell
    SSH_PORT=22
```  
SSH port to connect to PI, default is 22.

```shell
    RETROPIE_IP=192.168.0.xx
```  
IP of your retropi.
## Contributing

First off, thanks for taking the time to contribute! Contributions are what makes the open-source community such an amazing place to learn, inspire, and create. Any contributions you make will benefit everybody else and are **greatly appreciated**.

Please try to create bug reports that are:

- _Reproducible._ Include steps to reproduce the problem.
- _Specific._ Include as much detail as possible: which version, what environment, etc.
- _Unique._ Do not duplicate existing opened issues.
- _Scoped to a Single Bug._ One bug per report.

## License

This project is licensed under the **GNU GENERAL PUBLIC LICENSE v3**. Feel free to edit and distribute this template as you like.

See [LICENSE](LICENSE) for more information. 

