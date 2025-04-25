Looking through your original document again, I see that my copy-paste format doesn't include all the commands. Let me provide a more comprehensive list that captures everything from the original document.

## Complete List of Ansible Commands

### System Information

```bash
ansible -i inventory.yml all -a "uname -a"
ansible -i inventory.yml all -a "hostnamectl"
ansible -i inventory.yml all -a "uptime"
ansible -i inventory.yml all -a "whoami"
ansible -i inventory.yml all -a "arch"
ansible -i inventory.yml all -m setup
ansible -i inventory.yml all -m setup -a 'filter=ansible_architecture'
ansible -i inventory.yml all -m setup -a 'filter=ansible_kernel'
ansible -i inventory.yml all -m setup -a 'filter=ansible_distribution'
ansible -i inventory.yml all -m setup -a 'filter=ansible_hostname'
ansible -i inventory.yml all -m setup -a "filter=ansible_*"
ansible -i inventory.yml all -m setup -a "filter=ansible_os_family"
ansible -i inventory.yml all -m setup -a "filter=ansible_distribution*"
ansible -i inventory.yml all -m setup -a "filter=ansible_memtotal_mb"
ansible -i inventory.yml all -m setup -a "filter=ansible_processor*"
```

### Disk & Filesystem

```bash
ansible -i inventory.yml all -a "df -h"
ansible -i inventory.yml all -a "lsblk"
ansible -i inventory.yml all -a "mount"
ansible -i inventory.yml all -a "cat /etc/fstab"
ansible -i inventory.yml all -a "du -sh /*"
ansible -i inventory.yml all -a "find / -xdev -type f -size +100M"
ansible -i inventory.yml all -m setup -a 'filter=ansible_mounts'
ansible -i inventory.yml all -m shell -a "fdisk -l"
ansible -i inventory.yml all -m shell -a "du -sh /var/log"
ansible -i inventory.yml all -m find -a "paths=/var/log patterns=*.log age=7d"
ansible -i inventory.yml all -m shell -a "findmnt"
ansible -i inventory.yml all -m shell -a "pvs"
ansible -i inventory.yml all -m shell -a "vgs"
ansible -i inventory.yml all -m shell -a "lvs"
```

### Memory & CPU

```bash
ansible -i inventory.yml all -a "free -m"
ansible -i inventory.yml all -a "cat /proc/cpuinfo"
ansible -i inventory.yml all -a "vmstat"
ansible -i inventory.yml all -a "top -bn1 | head -n 20"
ansible -i inventory.yml all -m setup -a 'filter=ansible_processor'
ansible -i inventory.yml all -m setup -a 'filter=ansible_memory_mb'
ansible -i inventory.yml all -m shell -a "free -h"
ansible -i inventory.yml all -m shell -a "vmstat 1 5"
ansible -i inventory.yml all -m shell -a "uptime"
ansible -i inventory.yml all -m shell -a "mpstat"
ansible -i inventory.yml all -m shell -a "top -b -n 1"
ansible -i inventory.yml all -m shell -a "w"
ansible -i inventory.yml all -m shell -a "cat /proc/meminfo"
ansible -i inventory.yml all -m shell -a "iostat"
ansible -i inventory.yml all -m shell -a "sar -u 1 5"
```

### OS & Packages

```bash
ansible -i inventory.yml all -a "cat /etc/os-release"
ansible -i inventory.yml all -a "lsb_release -a"
ansible -i inventory.yml all -a "rpm -qa"
ansible -i inventory.yml all -a "dpkg -l"
ansible -i inventory.yml all -a "which python3"
ansible -i inventory.yml all -a "which pip3"
ansible -i inventory.yml all -m package_facts
ansible -i inventory.yml all -m shell -a "yum check-update"
ansible -i inventory.yml all -m shell -a "apt list --upgradable"
ansible -i inventory.yml all -m shell -a "apt-cache policy apache2"
ansible -i inventory.yml all -m shell -a "yum info httpd"
ansible -i inventory.yml all -m shell -a "dpkg -L nginx"
ansible -i inventory.yml all -m shell -a "rpm -ql httpd"
ansible -i inventory.yml all -m shell -a "apt-cache search java | grep jdk"
```

### Network

```bash
ansible -i inventory.yml all -a "ip a"
ansible -i inventory.yml all -a "ip r"
ansible -i inventory.yml all -a "cat /etc/hosts"
ansible -i inventory.yml all -a "cat /etc/resolv.conf"
ansible -i inventory.yml all -a "ss -tuln"
ansible -i inventory.yml all -a "netstat -tulnp"
ansible -i inventory.yml all -a "ping -c 4 google.com"
ansible -i inventory.yml all -m setup -a 'filter=ansible_default_ipv4'
ansible -i inventory.yml all -m setup -a 'filter=ansible_interfaces'
ansible -i inventory.yml all -m shell -a "ip addr"
ansible -i inventory.yml all -m shell -a "netstat -tuln"
ansible -i inventory.yml all -m shell -a "route -n"
ansible -i inventory.yml all -m shell -a "ip route"
ansible -i inventory.yml all -m shell -a "iptables -L -n"
ansible -i inventory.yml all -m shell -a "netstat -s"
ansible -i inventory.yml all -m shell -a "ifconfig -a"
ansible -i inventory.yml all -m shell -a "nmap -sP 192.168.1.0/24"
ansible -i inventory.yml all -m shell -a "traceroute google.com"
```

### Users & Groups

```bash
ansible -i inventory.yml all -a "cat /etc/passwd"
ansible -i inventory.yml all -a "cat /etc/group"
ansible -i inventory.yml all -a "id"
ansible -i inventory.yml all -a "groups"
ansible -i inventory.yml all -a "who"
ansible -i inventory.yml all -a "last"
ansible -i inventory.yml all -m shell -a "lastlog"
ansible -i inventory.yml all -m shell -a "cat /var/log/auth.log | grep Failed"
ansible -i inventory.yml all -m shell -a "cat /var/log/secure | grep Failed"
ansible -i inventory.yml all -m shell -a "getent passwd | cut -d: -f1"
ansible -i inventory.yml all -m shell -a "find / -perm -4000 -type f 2>/dev/null"
ansible -i inventory.yml all -m shell -a "grep -v \"^[#;]\" /etc/ssh/sshd_config"
ansible -i inventory.yml all -m shell -a "cat /etc/sudoers"
```

### Services

```bash
ansible -i inventory.yml all -a "systemctl list-units --type=service --state=running"
ansible -i inventory.yml all -a "service --status-all"
ansible -i inventory.yml all -a "journalctl -xe"
ansible -i inventory.yml all -m service_facts
ansible -i inventory.yml all -m shell -a "systemctl list-units --type=service"
ansible -i inventory.yml all -m shell -a "systemctl status sshd"
```

### Logs

```bash
ansible -i inventory.yml all -a "tail -n 50 /var/log/syslog"
ansible -i inventory.yml all -a "tail -n 50 /var/log/messages"
ansible -i inventory.yml all -a "tail -n 50 /var/log/dmesg"
ansible -i inventory.yml all -m shell -a "tail -n 100 /var/log/syslog"
ansible -i inventory.yml all -m shell -a "tail -n 100 /var/log/messages"
ansible -i inventory.yml all -m shell -a "journalctl -n 100"
ansible -i inventory.yml all -m shell -a "tail -n 50 /var/log/nginx/access.log"
ansible -i inventory.yml all -m shell -a "tail -n 50 /var/log/nginx/error.log"
ansible -i inventory.yml all -m shell -a "grep ERROR /var/log/syslog"
ansible -i inventory.yml all -m shell -a "grep -i fail /var/log/messages"
ansible -i inventory.yml all -m shell -a "journalctl --since '1 hour ago'"
ansible -i inventory.yml all -m shell -a "find /var/log -type f -mtime -1"
ansible -i inventory.yml all -m shell -a "dmesg"
```

### Security

```bash
ansible -i inventory.yml all -a "getenforce"
ansible -i inventory.yml all -a "sestatus"
ansible -i inventory.yml all -a "ufw status"
ansible -i inventory.yml all -a "iptables -L"
ansible -i inventory.yml all -a "auditctl -l"
```

### Storage Devices

```bash
ansible -i inventory.yml all -a "lsscsi"
ansible -i inventory.yml all -a "smartctl -a /dev/sda"
```

### Kernel & Boot

```bash
ansible -i inventory.yml all -a "uname -r"
ansible -i inventory.yml all -a "cat /boot/grub2/grub.cfg"
ansible -i inventory.yml all -a "ls /boot"
```

### Environment

```bash
ansible -i inventory.yml all -a "env"
ansible -i inventory.yml all -a "printenv"
ansible -i inventory.yml all -a "locale"
```

### Time

```bash
ansible -i inventory.yml all -a "date"
ansible -i inventory.yml all -a "timedatectl"
ansible -i inventory.yml all -a "chronyc tracking"
```

### SSH & Cron

```bash
ansible -i inventory.yml all -a "cat /etc/ssh/sshd_config"
ansible -i inventory.yml all -a "systemctl status sshd"
ansible -i inventory.yml all -a "crontab -l"
ansible -i inventory.yml all -a "ls /etc/cron.d"
```

### Docker & Containers

```bash
ansible -i inventory.yml all -a "docker ps -a"
ansible -i inventory.yml all -a "docker images"
ansible -i inventory.yml all -a "docker info"
ansible -i inventory.yml all -m shell -a "docker ps"
ansible -i inventory.yml all -m shell -a "podman ps -a"
ansible -i inventory.yml all -m shell -a "systemctl status docker"
ansible -i inventory.yml all -m shell -a "systemctl status kubelet"
```

### Python & Pip

```bash
ansible -i inventory.yml all -a "python3 --version"
ansible -i inventory.yml all -a "pip3 list"
```

### Git & Code

```bash
ansible -i inventory.yml all -a "git --version"
ansible -i inventory.yml all -a "git config --list"
```

### Custom Scripts

```bash
ansible -i inventory.yml all -a "bash /path/to/script.sh"
ansible -i inventory.yml all -a "/path/to/python_script.py"
```

### Files & Permissions

```bash
ansible -i inventory.yml all -a "ls -lah /etc"
ansible -i inventory.yml all -a "stat /etc/passwd"
ansible -i inventory.yml all -a "getfacl /var/log"
ansible -i inventory.yml all -a "find /home -perm 777"
```

### Package Managers

```bash
ansible -i inventory.yml all -a "yum repolist"
ansible -i inventory.yml all -a "apt list --installed"
```

### Backup & Snapshot

```bash
ansible -i inventory.yml all -a "rsnapshot configtest"
ansible -i inventory.yml all -a "rsync --version"
```

### Monitoring

```bash
ansible -i inventory.yml all -a "top -bn1"
ansible -i inventory.yml all -a "htop"
ansible -i inventory.yml all -a "iotop"
```

### Cloud & Virtualization

```bash
ansible -i inventory.yml all -a "virt-what"
ansible -i inventory.yml all -a "dmidecode | grep -A3 'System Information'"
```

### Ansible Facts

```bash
ansible -i inventory.yml all -m setup -a "filter=ansible_all_ipv4_addresses"
ansible -i inventory.yml all -m setup -a "filter=ansible_processor_cores"
ansible -i inventory.yml all -m setup -a "filter=ansible_userspace_architecture"
ansible -i inventory.yml all -m setup -a "filter=ansible_product_name"
```

### Process Information

```bash
ansible -i inventory.yml all -m shell -a "ps aux"
ansible -i inventory.yml all -m shell -a "ps aux --sort=-%mem | head -10"
ansible -i inventory.yml all -m shell -a "ps aux --sort=-%cpu | head -10"
ansible -i inventory.yml all -m shell -a "pstree"
ansible -i inventory.yml all -m shell -a "lsof"
ansible -i inventory.yml all -m shell -a "lsof -i"
ansible -i inventory.yml all -m shell -a "lsof -i :22"
```

### Application-Specific Information

```bash
ansible -i inventory.yml all -m shell -a "apache2ctl -S"
ansible -i inventory.yml all -m shell -a "httpd -S"
ansible -i inventory.yml all -m shell -a "nginx -T"
ansible -i inventory.yml all -m shell -a "mysql -e 'SHOW GLOBAL STATUS'"
ansible -i inventory.yml all -m shell -a "mysql -e 'SHOW PROCESSLIST'"
```

### Performance and Monitoring

```bash
ansible -i inventory.yml all -m shell -a "sar -r 1 5"
ansible -i inventory.yml all -m shell -a "sar -b 1 5"
ansible -i inventory.yml all -m shell -a "sar -n DEV 1 5"
ansible -i inventory.yml all -m shell -a "iostat -xz 1 5"
ansible -i inventory.yml all -m shell -a "vmstat -s"
ansible -i inventory.yml all -m shell -a "mpstat -P ALL 1 5"
ansible -i inventory.yml all -m shell -a "pidstat 1 5"
ansible -i inventory.yml all -m shell -a "netstat -i"
ansible -i inventory.yml all -m shell -a "dstat 1 5"
ansible -i inventory.yml all -m shell -a "atop -a 1 5"
```

### Others

```bash
ansible -i inventory.yml all -a "ls -lh /var"
ansible -i inventory.yml all -a "whoami && groups"
ansible -i inventory.yml all -a "ss -s"
ansible -i inventory.yml all -a "uptime && w"
```

### Ansible Module Cheat Sheet

```bash
# command (Default Module)
ansible all -a "uptime"
ansible all -m command -a "df -h"
ansible all -m command -a "ls /etc"

# shell
ansible all -m shell -a "echo $HOME"
ansible all -m shell -a "cat /etc/passwd | grep root"
ansible all -m shell -a "ps aux | sort -nk +4 | tail -10"

# setup
ansible all -m setup
ansible all -m setup -a "filter=ansible_hostname"
ansible all -m setup -a "filter=ansible_processor*"

# ping
ansible all -m ping

# copy
ansible all -m copy -a "src=/tmp/hello.txt dest=/tmp/hello.txt"

# fetch
ansible all -m fetch -a "src=/var/log/syslog dest=./logs/ flat=yes"

# file
ansible all -m file -a "path=/tmp/myfile state=touch"
ansible all -m file -a "path=/tmp/mydir state=directory mode=0755"

# yum / apt
ansible all -m yum -a "name=htop state=present"
ansible all -m apt -a "name=nginx state=latest update_cache=true"

# service
ansible all -m service -a "name=nginx state=restarted"
ansible all -m service -a "name=sshd state=started"

# user
ansible all -m user -a "name=devops state=present" 
ansible all -m user -a "name=devops state=absent"

# group
ansible all -m group -a "name=developers state=present"

# cron
ansible all -m cron -a "name='daily sync' minute=0 hour=1 job='/usr/bin/rsync -a /src /dest'"

# lineinfile
ansible all -m lineinfile -a "path=/etc/hosts line='127.0.0.1 example.local'"

# stat
ansible all -m stat -a "path=/etc/passwd"

# debug
ansible all -m debug -a "msg='Hello from Ansible!'"
```

### Ansible Playbook CLI Cheat Sheet

```bash
# Basic Commands
ansible-playbook playbook.yml
ansible-playbook playbook.yml -i inventory.ini
ansible-playbook --syntax-check playbook.yml
ansible-playbook --check playbook.yml
ansible-playbook -v playbook.yml
ansible-playbook -vvv playbook.yml

# Run a playbook with verbose output
ansible-playbook playbook.yml -v       # basic verbose
ansible-playbook playbook.yml -vvv     # more detailed (great for debugging)

# Run only specific tags
ansible-playbook playbook.yml --tags "install,restart"

# Skip specific tags
ansible-playbook playbook.yml --skip-tags "debug"

# Limit playbook to certain hosts
ansible-playbook playbook.yml --limit "webserver1,webserver2"

# Run a specific task using --start-at-task
ansible-playbook playbook.yml --start-at-task="Setup firewall"

# Use extra variables from CLI
ansible-playbook playbook.yml -e "env=production version=1.2"

# Pass variables from a file
ansible-playbook playbook.yml -e "@vars.json"
ansible-playbook playbook.yml -e "@vars.yml"

# Use a custom private SSH key
ansible-playbook playbook.yml --private-key ~/.ssh/id_rsa

# Force handlers to run after every task
ansible-playbook playbook.yml --force-handlers

# Flush all handlers immediately
ansible-playbook playbook.yml --flush-cache

# Check which tasks would run (dry run)
ansible-playbook playbook.yml --check

# Display the tasks that would be run (without executing them)
ansible-playbook playbook.yml --list-tasks

# List all plays and hosts without executing
ansible-playbook playbook.yml --list-hosts

# List all tags in a playbook
ansible-playbook playbook.yml --list-tags

# Disable host key checking (not safe for production)
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook playbook.yml

# Specify a different configuration file
ANSIBLE_CONFIG=custom-ansible.cfg ansible-playbook playbook.yml

# Privilege and Authentication
ansible-playbook --become playbook.yml
ansible-playbook --user ubuntu playbook.yml
```

This should now include all of the commands from your original document, organized by category and formatted for easy copying.