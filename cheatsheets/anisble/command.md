# Ansible Commands for Server Information Collection

Looking at your document, I see it contains several collections of Ansible commands for gathering information from remote servers. I've extracted and organized the commands in a format that's easy to copy and use.

## System Information Commands

```bash
ansible -i inventory.yml all -m setup
ansible -i inventory.yml all -m setup -a "filter=ansible_*"
ansible -i inventory.yml all -m setup -a "filter=ansible_os_family"
ansible -i inventory.yml all -m setup -a "filter=ansible_distribution*"
ansible -i inventory.yml all -m setup -a "filter=ansible_kernel"
ansible -i inventory.yml all -m setup -a "filter=ansible_memtotal_mb"
ansible -i inventory.yml all -m setup -a "filter=ansible_processor*"
ansible -i inventory.yml all -m setup -a "filter=ansible_hostname"
ansible -i inventory.yml all -m setup -a "filter=ansible_default_ipv4"
ansible -i inventory.yml all -m setup -a "filter=ansible_all_ipv4_addresses"
```

## Disk and File System Commands

```bash
ansible -i inventory.yml all -m shell -a "df -h"
ansible -i inventory.yml all -m shell -a "lsblk"
ansible -i inventory.yml all -m shell -a "fdisk -l"
ansible -i inventory.yml all -m shell -a "du -sh /var/log"
ansible -i inventory.yml all -m find -a "paths=/var/log patterns=*.log age=7d"
ansible -i inventory.yml all -m shell -a "mount"
ansible -i inventory.yml all -m shell -a "findmnt"
ansible -i inventory.yml all -m shell -a "pvs"
ansible -i inventory.yml all -m shell -a "vgs"
ansible -i inventory.yml all -m shell -a "lvs"
```

## Memory and CPU Commands

```bash
ansible -i inventory.yml all -m shell -a "free -h"
ansible -i inventory.yml all -m shell -a "vmstat 1 5"
ansible -i inventory.yml all -m shell -a "uptime"
ansible -i inventory.yml all -m shell -a "cat /proc/cpuinfo"
ansible -i inventory.yml all -m shell -a "mpstat"
ansible -i inventory.yml all -m shell -a "top -b -n 1"
ansible -i inventory.yml all -m shell -a "w"
ansible -i inventory.yml all -m shell -a "cat /proc/meminfo"
ansible -i inventory.yml all -m shell -a "iostat"
ansible -i inventory.yml all -m shell -a "sar -u 1 5"
```

## Network Information Commands

```bash
ansible -i inventory.yml all -m shell -a "ip addr"
ansible -i inventory.yml all -m shell -a "netstat -tuln"
ansible -i inventory.yml all -m shell -a "ss -tuln"
ansible -i inventory.yml all -m shell -a "route -n"
ansible -i inventory.yml all -m shell -a "ip route"
ansible -i inventory.yml all -m shell -a "iptables -L -n"
ansible -i inventory.yml all -m shell -a "netstat -s"
ansible -i inventory.yml all -m shell -a "ifconfig -a"
ansible -i inventory.yml all -m shell -a "nmap -sP 192.168.1.0/24"
ansible -i inventory.yml all -m shell -a "traceroute google.com"
```

## Process Information Commands

```bash
ansible -i inventory.yml all -m shell -a "ps aux"
ansible -i inventory.yml all -m shell -a "ps aux --sort=-%mem | head -10"
ansible -i inventory.yml all -m shell -a "ps aux --sort=-%cpu | head -10"
ansible -i inventory.yml all -m shell -a "pstree"
ansible -i inventory.yml all -m shell -a "lsof"
ansible -i inventory.yml all -m shell -a "lsof -i"
ansible -i inventory.yml all -m shell -a "lsof -i :22"
ansible -i inventory.yml all -m shell -a "systemctl list-units --type=service"
ansible -i inventory.yml all -m shell -a "systemctl status sshd"
ansible -i inventory.yml all -m service_facts
```

## User and Security Information Commands

```bash
ansible -i inventory.yml all -m shell -a "cat /etc/passwd"
ansible -i inventory.yml all -m shell -a "cat /etc/group"
ansible -i inventory.yml all -m shell -a "lastlog"
ansible -i inventory.yml all -m shell -a "last"
ansible -i inventory.yml all -m shell -a "cat /var/log/auth.log | grep Failed"
ansible -i inventory.yml all -m shell -a "cat /var/log/secure | grep Failed"
ansible -i inventory.yml all -m shell -a "getent passwd | cut -d: -f1"
ansible -i inventory.yml all -m shell -a "find / -perm -4000 -type f 2>/dev/null"
ansible -i inventory.yml all -m shell -a "grep -v \"^[#;]\" /etc/ssh/sshd_config"
ansible -i inventory.yml all -m shell -a "cat /etc/sudoers"
```

## Package and Update Information Commands

```bash
ansible -i inventory.yml all -m package_facts
ansible -i inventory.yml all -m shell -a "dpkg -l"
ansible -i inventory.yml all -m shell -a "rpm -qa"
ansible -i inventory.yml all -m shell -a "yum check-update"
ansible -i inventory.yml all -m shell -a "apt list --upgradable"
ansible -i inventory.yml all -m shell -a "apt-cache policy apache2"
ansible -i inventory.yml all -m shell -a "yum info httpd"
ansible -i inventory.yml all -m shell -a "dpkg -L nginx"
ansible -i inventory.yml all -m shell -a "rpm -ql httpd"
ansible -i inventory.yml all -m shell -a "apt-cache search java | grep jdk"
```

## Log Information Commands

```bash
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

## Application-Specific Commands

```bash
ansible -i inventory.yml all -m shell -a "apache2ctl -S"
ansible -i inventory.yml all -m shell -a "httpd -S"
ansible -i inventory.yml all -m shell -a "nginx -T"
ansible -i inventory.yml all -m shell -a "mysql -e 'SHOW GLOBAL STATUS'"
ansible -i inventory.yml all -m shell -a "mysql -e 'SHOW PROCESSLIST'"
ansible -i inventory.yml all -m shell -a "docker ps"
ansible -i inventory.yml all -m shell -a "docker images"
ansible -i inventory.yml all -m shell -a "podman ps -a"
ansible -i inventory.yml all -m shell -a "systemctl status docker"
ansible -i inventory.yml all -m shell -a "systemctl status kubelet"
```

## Performance and Monitoring Commands

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

## Ansible Module Quick Reference

```bash
# Command module (default)
ansible all -a "uptime"
ansible all -m command -a "df -h"
ansible all -m command -a "ls /etc"

# Shell module
ansible all -m shell -a "echo $HOME"
ansible all -m shell -a "cat /etc/passwd | grep root"
ansible all -m shell -a "ps aux | sort -nk +4 | tail -10"

# Ping module
ansible all -m ping

# Copy module
ansible all -m copy -a "src=/tmp/hello.txt dest=/tmp/hello.txt"

# Fetch module
ansible all -m fetch -a "src=/var/log/syslog dest=./logs/ flat=yes"

# File module
ansible all -m file -a "path=/tmp/myfile state=touch"
ansible all -m file -a "path=/tmp/mydir state=directory mode=0755"

# Package management
ansible all -m yum -a "name=htop state=present"
ansible all -m apt -a "name=nginx state=latest update_cache=true"

# Service module
ansible all -m service -a "name=nginx state=restarted"
ansible all -m service -a "name=sshd state=started"

# User module
ansible all -m user -a "name=devops state=present"
ansible all -m user -a "name=devops state=absent"

# Group module
ansible all -m group -a "name=developers state=present"

# Cron module
ansible all -m cron -a "name='daily sync' minute=0 hour=1 job='/usr/bin/rsync -a /src /dest'"

# Lineinfile module
ansible all -m lineinfile -a "path=/etc/hosts line='127.0.0.1 example.local'"

# Stat module
ansible all -m stat -a "path=/etc/passwd"

# Debug module
ansible all -m debug -a "msg='Hello from Ansible!'"
```

## Ansible Playbook Commands

```bash
# Basic commands
ansible-playbook playbook.yml
ansible-playbook playbook.yml -i inventory.ini
ansible-playbook --syntax-check playbook.yml
ansible-playbook --check playbook.yml
ansible-playbook -v playbook.yml
ansible-playbook -vvv playbook.yml

# Targeting & selection
ansible-playbook playbook.yml --limit "host1,host2"
ansible-playbook playbook.yml --start-at-task="Task Name"
ansible-playbook playbook.yml --tags "tag1,tag2"
ansible-playbook playbook.yml --skip-tags "tag3"
ansible-playbook playbook.yml --list-hosts
ansible-playbook playbook.yml --list-tasks
ansible-playbook playbook.yml --list-tags

# Authentication
ansible-playbook --become playbook.yml
ansible-playbook --user ubuntu playbook.yml
ansible-playbook --private-key ~/.ssh/id_rsa playbook.yml

# Variables
ansible-playbook playbook.yml -e "key=value"
ansible-playbook playbook.yml -e "@vars.yml"

# Other options
ansible-playbook playbook.yml --force-handlers
ansible-playbook playbook.yml --flush-cache
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook playbook.yml
ANSIBLE_CONFIG=custom.cfg ansible-playbook playbook.yml
```

All of these commands are formatted in code blocks for easy copying. Just select the block you need and copy it to your clipboard.