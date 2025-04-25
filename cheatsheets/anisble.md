Ansible Remote Server Info Gathering - 100 Useful Commands

This document provides 100 useful Ansible commands to run against remote servers using a specified inventory file (inventory.yml). These commands use various Ansible modules and ad-hoc commands to collect system and environment information.

Usage Format

ansible -i inventory.yml all -a "<COMMAND>"
ansible -i inventory.yml all -m <MODULE> -a "<ARGUMENTS>"


---

System Information

1. ansible -i inventory.yml all -a "uname -a"


2. ansible -i inventory.yml all -a "hostnamectl"


3. ansible -i inventory.yml all -a "uptime"


4. ansible -i inventory.yml all -a "whoami"


5. ansible -i inventory.yml all -a "arch"


6. ansible -i inventory.yml all -m setup


7. ansible -i inventory.yml all -m setup -a 'filter=ansible_architecture'


8. ansible -i inventory.yml all -m setup -a 'filter=ansible_kernel'


9. ansible -i inventory.yml all -m setup -a 'filter=ansible_distribution'


10. ansible -i inventory.yml all -m setup -a 'filter=ansible_hostname'



Disk & Filesystem

11. ansible -i inventory.yml all -a "df -h"


12. ansible -i inventory.yml all -a "lsblk"


13. ansible -i inventory.yml all -a "mount"


14. ansible -i inventory.yml all -a "cat /etc/fstab"


15. ansible -i inventory.yml all -a "du -sh /*"


16. ansible -i inventory.yml all -a "find / -xdev -type f -size +100M"


17. ansible -i inventory.yml all -m setup -a 'filter=ansible_mounts'



Memory & CPU

18. ansible -i inventory.yml all -a "free -m"


19. ansible -i inventory.yml all -a "cat /proc/cpuinfo"


20. ansible -i inventory.yml all -a "vmstat"


21. ansible -i inventory.yml all -a "top -bn1 | head -n 20"


22. ansible -i inventory.yml all -m setup -a 'filter=ansible_processor'


23. ansible -i inventory.yml all -m setup -a 'filter=ansible_memory_mb'



OS & Packages

24. ansible -i inventory.yml all -a "cat /etc/os-release"


25. ansible -i inventory.yml all -a "lsb_release -a"


26. ansible -i inventory.yml all -a "rpm -qa"


27. ansible -i inventory.yml all -a "dpkg -l"


28. ansible -i inventory.yml all -a "which python3"


29. ansible -i inventory.yml all -a "which pip3"



Network

30. ansible -i inventory.yml all -a "ip a"


31. ansible -i inventory.yml all -a "ip r"


32. ansible -i inventory.yml all -a "cat /etc/hosts"


33. ansible -i inventory.yml all -a "cat /etc/resolv.conf"


34. ansible -i inventory.yml all -a "ss -tuln"


35. ansible -i inventory.yml all -a "netstat -tulnp"


36. ansible -i inventory.yml all -a "ping -c 4 google.com"


37. ansible -i inventory.yml all -m setup -a 'filter=ansible_default_ipv4'


38. ansible -i inventory.yml all -m setup -a 'filter=ansible_interfaces'



Users & Groups

39. ansible -i inventory.yml all -a "cat /etc/passwd"


40. ansible -i inventory.yml all -a "cat /etc/group"


41. ansible -i inventory.yml all -a "id"


42. ansible -i inventory.yml all -a "groups"


43. ansible -i inventory.yml all -a "who"


44. ansible -i inventory.yml all -a "last"



Services

45. ansible -i inventory.yml all -a "systemctl list-units --type=service --state=running"


46. ansible -i inventory.yml all -a "service --status-all"


47. ansible -i inventory.yml all -a "journalctl -xe"



Logs

48. ansible -i inventory.yml all -a "tail -n 50 /var/log/syslog"


49. ansible -i inventory.yml all -a "tail -n 50 /var/log/messages"


50. ansible -i inventory.yml all -a "tail -n 50 /var/log/dmesg"



Security

51. ansible -i inventory.yml all -a "getenforce"


52. ansible -i inventory.yml all -a "sestatus"


53. ansible -i inventory.yml all -a "ufw status"


54. ansible -i inventory.yml all -a "iptables -L"


55. ansible -i inventory.yml all -a "auditctl -l"



Storage Devices

56. ansible -i inventory.yml all -a "lsscsi"


57. ansible -i inventory.yml all -a "smartctl -a /dev/sda"



Kernel & Boot

58. ansible -i inventory.yml all -a "uname -r"


59. ansible -i inventory.yml all -a "cat /boot/grub2/grub.cfg"


60. ansible -i inventory.yml all -a "ls /boot"



Environment

61. ansible -i inventory.yml all -a "env"


62. ansible -i inventory.yml all -a "printenv"


63. ansible -i inventory.yml all -a "locale"



Time

64. ansible -i inventory.yml all -a "date"


65. ansible -i inventory.yml all -a "timedatectl"


66. ansible -i inventory.yml all -a "chronyc tracking"



SSH & Cron

67. ansible -i inventory.yml all -a "cat /etc/ssh/sshd_config"


68. ansible -i inventory.yml all -a "systemctl status sshd"


69. ansible -i inventory.yml all -a "crontab -l"


70. ansible -i inventory.yml all -a "ls /etc/cron.d"



Docker & Containers

71. ansible -i inventory.yml all -a "docker ps -a"


72. ansible -i inventory.yml all -a "docker images"


73. ansible -i inventory.yml all -a "docker info"



Python & Pip

74. ansible -i inventory.yml all -a "python3 --version"


75. ansible -i inventory.yml all -a "pip3 list"



Git & Code

76. ansible -i inventory.yml all -a "git --version"


77. ansible -i inventory.yml all -a "git config --list"



Custom Scripts

78. ansible -i inventory.yml all -a "bash /path/to/script.sh"


79. ansible -i inventory.yml all -a "/path/to/python_script.py"



Files & Permissions

80. ansible -i inventory.yml all -a "ls -lah /etc"


81. ansible -i inventory.yml all -a "stat /etc/passwd"


82. ansible -i inventory.yml all -a "getfacl /var/log"


83. ansible -i inventory.yml all -a "find /home -perm 777"



Package Managers

84. ansible -i inventory.yml all -a "yum repolist"


85. ansible -i inventory.yml all -a "apt list --installed"



Backup & Snapshot

86. ansible -i inventory.yml all -a "rsnapshot configtest"


87. ansible -i inventory.yml all -a "rsync --version"



Monitoring

88. ansible -i inventory.yml all -a "top -bn1"


89. ansible -i inventory.yml all -a "htop"


90. ansible -i inventory.yml all -a "iotop"



Cloud & Virtualization

91. ansible -i inventory.yml all -a "virt-what"


92. ansible -i inventory.yml all -a "dmidecode | grep -A3 'System Information'"



Ansible Facts

93. ansible -i inventory.yml all -m setup -a "filter=ansible_all_ipv4_addresses"


94. ansible -i inventory.yml all -m setup -a "filter=ansible_processor_cores"


95. ansible -i inventory.yml all -m setup -a "filter=ansible_userspace_architecture"


96. ansible -i inventory.yml all -m setup -a "filter=ansible_product_name"



Others

97. ansible -i inventory.yml all -a "ls -lh /var"


98. ansible -i inventory.yml all -a "whoami && groups"


99. ansible -i inventory.yml all -a "ss -s"


100. ansible -i inventory.yml all -a "uptime && w"




---

Use these commands regularly to audit, monitor, and gather diagnostics from remote servers. Customize them as needed for specific modules or inventory groups.

# Ansible Commands for Server Information Gathering

This README contains 100 useful Ansible ad-hoc commands for gathering information from remote servers. These commands use the `-i` flag to specify an inventory file and various modules to collect system data.

## System Information

1. `ansible -i inventory.yml all -m setup` - Gather all facts about hosts
2. `ansible -i inventory.yml all -m setup -a "filter=ansible_*"` - Show all Ansible facts
3. `ansible -i inventory.yml all -m setup -a "filter=ansible_os_family"` - Get OS family
4. `ansible -i inventory.yml all -m setup -a "filter=ansible_distribution*"` - Get distribution information
5. `ansible -i inventory.yml all -m setup -a "filter=ansible_kernel"` - Get kernel version
6. `ansible -i inventory.yml all -m setup -a "filter=ansible_memtotal_mb"` - Get total memory
7. `ansible -i inventory.yml all -m setup -a "filter=ansible_processor*"` - Get processor details
8. `ansible -i inventory.yml all -m setup -a "filter=ansible_hostname"` - Get hostname
9. `ansible -i inventory.yml all -m setup -a "filter=ansible_default_ipv4"` - Get default IPv4 information
10. `ansible -i inventory.yml all -m setup -a "filter=ansible_all_ipv4_addresses"` - List all IPv4 addresses

## Disk and File System

11. `ansible -i inventory.yml all -m shell -a "df -h"` - Check disk space usage
12. `ansible -i inventory.yml all -m shell -a "lsblk"` - List block devices
13. `ansible -i inventory.yml all -m shell -a "fdisk -l"` - List disk partitions
14. `ansible -i inventory.yml all -m shell -a "du -sh /var/log"` - Check size of log directory
15. `ansible -i inventory.yml all -m find -a "paths=/var/log patterns=*.log age=7d"` - Find log files older than 7 days
16. `ansible -i inventory.yml all -m shell -a "mount"` - List mounted filesystems
17. `ansible -i inventory.yml all -m shell -a "findmnt"` - Show mount points in tree format
18. `ansible -i inventory.yml all -m shell -a "pvs"` - List physical volumes (LVM)
19. `ansible -i inventory.yml all -m shell -a "vgs"` - List volume groups (LVM)
20. `ansible -i inventory.yml all -m shell -a "lvs"` - List logical volumes (LVM)

## Memory and CPU

21. `ansible -i inventory.yml all -m shell -a "free -h"` - Display memory usage
22. `ansible -i inventory.yml all -m shell -a "vmstat 1 5"` - Virtual memory statistics (5 samples)
23. `ansible -i inventory.yml all -m shell -a "uptime"` - System uptime and load averages
24. `ansible -i inventory.yml all -m shell -a "cat /proc/cpuinfo"` - CPU information
25. `ansible -i inventory.yml all -m shell -a "mpstat"` - Processor statistics
26. `ansible -i inventory.yml all -m shell -a "top -b -n 1"` - Current processes (batch mode)
27. `ansible -i inventory.yml all -m shell -a "w"` - Show who is logged in and what they're doing
28. `ansible -i inventory.yml all -m shell -a "cat /proc/meminfo"` - Detailed memory information
29. `ansible -i inventory.yml all -m shell -a "iostat"` - CPU and I/O statistics
30. `ansible -i inventory.yml all -m shell -a "sar -u 1 5"` - CPU utilization report (5 samples)

## Network Information

31. `ansible -i inventory.yml all -m shell -a "ip addr"` - IP address information
32. `ansible -i inventory.yml all -m shell -a "netstat -tuln"` - List listening ports
33. `ansible -i inventory.yml all -m shell -a "ss -tuln"` - Alternative to netstat for socket statistics
34. `ansible -i inventory.yml all -m shell -a "route -n"` - Kernel routing table
35. `ansible -i inventory.yml all -m shell -a "ip route"` - IP routing table
36. `ansible -i inventory.yml all -m shell -a "iptables -L -n"` - List iptables rules
37. `ansible -i inventory.yml all -m shell -a "netstat -s"` - Network statistics
38. `ansible -i inventory.yml all -m shell -a "ifconfig -a"` - Interface configuration
39. `ansible -i inventory.yml all -m shell -a "nmap -sP 192.168.1.0/24"` - Scan network for hosts (requires nmap)
40. `ansible -i inventory.yml all -m shell -a "traceroute google.com"` - Trace route to google.com

## Process Information

41. `ansible -i inventory.yml all -m shell -a "ps aux"` - List all running processes
42. `ansible -i inventory.yml all -m shell -a "ps aux --sort=-%mem | head -10"` - Top 10 memory consuming processes
43. `ansible -i inventory.yml all -m shell -a "ps aux --sort=-%cpu | head -10"` - Top 10 CPU consuming processes
44. `ansible -i inventory.yml all -m shell -a "pstree"` - Display processes in tree format
45. `ansible -i inventory.yml all -m shell -a "lsof"` - List open files
46. `ansible -i inventory.yml all -m shell -a "lsof -i"` - List open network connections
47. `ansible -i inventory.yml all -m shell -a "lsof -i :22"` - Show processes using port 22
48. `ansible -i inventory.yml all -m shell -a "systemctl list-units --type=service"` - List systemd services
49. `ansible -i inventory.yml all -m shell -a "systemctl status sshd"` - Check SSH service status
50. `ansible -i inventory.yml all -m service_facts` - Gather service facts

## User and Security Information

51. `ansible -i inventory.yml all -m shell -a "cat /etc/passwd"` - List user accounts
52. `ansible -i inventory.yml all -m shell -a "cat /etc/group"` - List groups
53. `ansible -i inventory.yml all -m shell -a "lastlog"` - Show last login time for all users
54. `ansible -i inventory.yml all -m shell -a "last"` - Show listing of last logged in users
55. `ansible -i inventory.yml all -m shell -a "cat /var/log/auth.log | grep Failed"` - Failed login attempts
56. `ansible -i inventory.yml all -m shell -a "cat /var/log/secure | grep Failed"` - Failed login attempts (RHEL/CentOS)
57. `ansible -i inventory.yml all -m shell -a "getent passwd | cut -d: -f1"` - List all usernames
58. `ansible -i inventory.yml all -m shell -a "find / -perm -4000 -type f 2>/dev/null"` - Find SUID files
59. `ansible -i inventory.yml all -m shell -a "grep -v \"^[#;]\" /etc/ssh/sshd_config"` - Show non-commented SSH config
60. `ansible -i inventory.yml all -m shell -a "cat /etc/sudoers"` - Show sudoers configuration

## Package and Update Information

61. `ansible -i inventory.yml all -m package_facts` - Gather package facts
62. `ansible -i inventory.yml all -m shell -a "dpkg -l"` - List installed packages (Debian/Ubuntu)
63. `ansible -i inventory.yml all -m shell -a "rpm -qa"` - List installed packages (RHEL/CentOS)
64. `ansible -i inventory.yml all -m shell -a "yum check-update"` - Check for updates (RHEL/CentOS)
65. `ansible -i inventory.yml all -m shell -a "apt list --upgradable"` - Check for updates (Debian/Ubuntu)
66. `ansible -i inventory.yml all -m shell -a "apt-cache policy apache2"` - Check specific package info (Debian/Ubuntu)
67. `ansible -i inventory.yml all -m shell -a "yum info httpd"` - Check specific package info (RHEL/CentOS)
68. `ansible -i inventory.yml all -m shell -a "dpkg -L nginx"` - List files installed by package (Debian/Ubuntu)
69. `ansible -i inventory.yml all -m shell -a "rpm -ql httpd"` - List files installed by package (RHEL/CentOS)
70. `ansible -i inventory.yml all -m shell -a "apt-cache search java | grep jdk"` - Search for packages (Debian/Ubuntu)

## Log Information

71. `ansible -i inventory.yml all -m shell -a "tail -n 100 /var/log/syslog"` - Last 100 syslog entries
72. `ansible -i inventory.yml all -m shell -a "tail -n 100 /var/log/messages"` - Last 100 messages log entries
73. `ansible -i inventory.yml all -m shell -a "journalctl -n 100"` - Last 100 journal entries
74. `ansible -i inventory.yml all -m shell -a "tail -n 50 /var/log/nginx/access.log"` - Last 50 nginx access log entries
75. `ansible -i inventory.yml all -m shell -a "tail -n 50 /var/log/nginx/error.log"` - Last 50 nginx error log entries
76. `ansible -i inventory.yml all -m shell -a "grep ERROR /var/log/syslog"` - Find ERROR entries in syslog
77. `ansible -i inventory.yml all -m shell -a "grep -i fail /var/log/messages"` - Find failure entries in messages log
78. `ansible -i inventory.yml all -m shell -a "journalctl --since '1 hour ago'"` - Journal entries from last hour
79. `ansible -i inventory.yml all -m shell -a "find /var/log -type f -mtime -1"` - Log files modified in last day
80. `ansible -i inventory.yml all -m shell -a "dmesg"` - Kernel ring buffer messages

## Application-Specific Information

81. `ansible -i inventory.yml all -m shell -a "apache2ctl -S"` - Apache virtual host configuration
82. `ansible -i inventory.yml all -m shell -a "httpd -S"` - Apache virtual host configuration (RHEL/CentOS)
83. `ansible -i inventory.yml all -m shell -a "nginx -T"` - Test nginx configuration
84. `ansible -i inventory.yml all -m shell -a "mysql -e 'SHOW GLOBAL STATUS'"` - MySQL status (requires access)
85. `ansible -i inventory.yml all -m shell -a "mysql -e 'SHOW PROCESSLIST'"` - MySQL processes (requires access)
86. `ansible -i inventory.yml all -m shell -a "docker ps"` - List running containers
87. `ansible -i inventory.yml all -m shell -a "docker images"` - List Docker images
88. `ansible -i inventory.yml all -m shell -a "podman ps -a"` - List all Podman containers
89. `ansible -i inventory.yml all -m shell -a "systemctl status docker"` - Docker service status
90. `ansible -i inventory.yml all -m shell -a "systemctl status kubelet"` - Kubernetes node agent status

## Performance and Monitoring

91. `ansible -i inventory.yml all -m shell -a "sar -r 1 5"` - Memory utilization (5 samples)
92. `ansible -i inventory.yml all -m shell -a "sar -b 1 5"` - I/O and transfer rate stats (5 samples)
93. `ansible -i inventory.yml all -m shell -a "sar -n DEV 1 5"` - Network statistics (5 samples)
94. `ansible -i inventory.yml all -m shell -a "iostat -xz 1 5"` - Extended disk stats (5 samples)
95. `ansible -i inventory.yml all -m shell -a "vmstat -s"` - Detailed virtual memory statistics
96. `ansible -i inventory.yml all -m shell -a "mpstat -P ALL 1 5"` - CPU stats for all processors (5 samples)
97. `ansible -i inventory.yml all -m shell -a "pidstat 1 5"` - Statistics for Linux tasks (5 samples)
98. `ansible -i inventory.yml all -m shell -a "netstat -i"` - Network interface statistics
99. `ansible -i inventory.yml all -m shell -a "dstat 1 5"` - Combined system resource statistics (5 samples)
100. `ansible -i inventory.yml all -m shell -a "atop -a 1 5"` - Advanced system & process monitor (5 samples)

## Best Practices and Tips

- Always use the `-i` flag with your inventory file
- For large inventories, consider using `--limit` to target specific hosts
- Use `-b` or `--become` when commands require elevated privileges
- For commands that produce a lot of output, consider using `--one-line` for concise output
- Save command output to files using the `-o` flag for later analysis
- Consider grouping your hosts in the inventory file for easier targeting 


Ansible Module Cheat Sheet

This README contains commonly used Ansible ad-hoc commands to run on remote servers using different modules. Perfect for gathering system information, managing services, and automating quick tasks.


---

1. command (Default Module)

Run basic commands (no shell features like pipes or variables).

ansible all -a "uptime"
ansible all -m command -a "df -h"
ansible all -m command -a "ls /etc"


---

2. shell

Run commands using the shell. Supports variables, pipes, redirects.

ansible all -m shell -a "echo $HOME"
ansible all -m shell -a "cat /etc/passwd | grep root"
ansible all -m shell -a "ps aux | sort -nk +4 | tail -10"


---

3. setup

Gather system facts.

ansible all -m setup
ansible all -m setup -a "filter=ansible_hostname"
ansible all -m setup -a "filter=ansible_processor*"


---

4. ping

Check connectivity.

ansible all -m ping


---

5. copy

Copy files from local to remote.

ansible all -m copy -a "src=/tmp/hello.txt dest=/tmp/hello.txt"


---

6. fetch

Download files from remote to local.

ansible all -m fetch -a "src=/var/log/syslog dest=./logs/ flat=yes"


---

7. file

Manage files/directories.

ansible all -m file -a "path=/tmp/myfile state=touch"
ansible all -m file -a "path=/tmp/mydir state=directory mode=0755"


---

8. yum / apt

Install or manage packages.

ansible all -m yum -a "name=htop state=present"
ansible all -m apt -a "name=nginx state=latest update_cache=true"


---

9. service

Manage services.

ansible all -m service -a "name=nginx state=restarted"
ansible all -m service -a "name=sshd state=started"


---

10. user

Create or delete users.

ansible all -m user -a "name=devops state=present"
ansible all -m user -a "name=devops state=absent"


---

11. group

Manage user groups.

ansible all -m group -a "name=developers state=present"


---

12. cron

Create or manage cron jobs.

ansible all -m cron -a "name='daily sync' minute=0 hour=1 job='/usr/bin/rsync -a /src /dest'"


---

13. lineinfile

Ensure a particular line exists in a file.

ansible all -m lineinfile -a "path=/etc/hosts line='127.0.0.1 example.local'"


---

14. stat

Check file/directory info.

ansible all -m stat -a "path=/etc/passwd"


---

15. debug

Print a message (mainly in playbooks).

ansible all -m debug -a "msg='Hello from Ansible!'"


---

Feel free to copy and modify these examples to suit your automation tasks. Let me know if you'd like to expand this with more modules!


# Ansible Playbook CLI Cheat Sheet

## Basic Commands

| Command | Description |
|--------|-------------|
| `ansible-playbook playbook.yml` | Run a playbook |
| `ansible-playbook playbook.yml -i inventory.ini` | Use a custom inventory file |
| `ansible-playbook --syntax-check playbook.yml` | Check playbook syntax |
| `ansible-playbook --check playbook.yml` | Dry run (no changes made) |
| `ansible-playbook -v playbook.yml` | Verbose output |
| `ansible-playbook -vvv playbook.yml` | Debug mode (very verbose) |

## Targeting & Selection

| Command | Description |
|--------|-------------|
| `--limit "host1,host2"` | Limit play to specific hosts |
| `--start-at-task="Task Name"` | Start playbook at a specific task |
| `--tags "tag1,tag2"` | Run only tasks with these tags |
| `--skip-tags "tag3"` | Skip tasks with these tags |
| `--list-hosts` | Show list of targeted hosts |
| `--list-tasks` | Show list of tasks without running |
| `--list-tags` | Show all available tags in the playbook |

## Privilege & Authentication

| Command | Description |
|--------|-------------|
| `--become` | Run tasks with privilege escalation (sudo) |
| `--user ubuntu` | Run as a different SSH user |
| `--private-key ~/.ssh/id_rsa` | Use a custom SSH key |

## Variables

| Command | Description |
|--------|-------------|
| `-e "key=value"` | Pass extra variables inline |
| `-e "@vars.yml"` | Pass variables from a YAML/JSON file |

## Miscellaneous

| Command | Description |
|--------|-------------|
| `--force-handlers` | Force all handlers to run |
| `--flush-cache` | Clear the fact cache |
| `ANSIBLE_HOST_KEY_CHECKING=False` | Disable SSH host key checking |
| `ANSIBLE_CONFIG=custom.cfg` | Use a custom config file |

---

**Tip:** Combine flags for powerful control, e.g.:

```bash
ansible-playbook -i inventory.ini playbook.yml --limit "web" --tags "deploy" -e "@prod.yml" -vv 


# 1. Run a playbook with verbose output
ansible-playbook playbook.yml -v       # basic verbose
ansible-playbook playbook.yml -vvv     # more detailed (great for debugging)

# 2. Run only specific tags
ansible-playbook playbook.yml --tags "install,restart"

# 3. Skip specific tags
ansible-playbook playbook.yml --skip-tags "debug"

# 4. Limit playbook to certain hosts
ansible-playbook playbook.yml --limit "webserver1,webserver2"

# 5. Run a specific task using --start-at-task
ansible-playbook playbook.yml --start-at-task="Setup firewall"

# 6. Use extra variables from CLI
ansible-playbook playbook.yml -e "env=production version=1.2"

# 7. Pass variables from a file
ansible-playbook playbook.yml -e "@vars.json"
ansible-playbook playbook.yml -e "@vars.yml"

# 8. Use a custom private SSH key
ansible-playbook playbook.yml --private-key ~/.ssh/id_rsa

# 9. Force handlers to run after every task
ansible-playbook playbook.yml --force-handlers

# 10. Flush all handlers immediately
ansible-playbook playbook.yml --flush-cache

# 11. Check which tasks would run (dry run)
ansible-playbook playbook.yml --check

# 12. Display the tasks that would be run (without executing them)
ansible-playbook playbook.yml --list-tasks

# 13. List all plays and hosts without executing
ansible-playbook playbook.yml --list-hosts

# 14. List all tags in a playbook
ansible-playbook playbook.yml --list-tags

# 15. Disable host key checking (not safe for production)
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook playbook.yml

# 16. Specify a different configuration file
ANSIBLE_CONFIG=custom-ansible.cfg ansible-playbook playbook.yml


# 1. Run a playbook
ansible-playbook playbook.yml

# 2. Specify inventory file
ansible-playbook -i inventory.ini playbook.yml

# 3. Use privilege escalation
ansible-playbook --become playbook.yml

# 4. Run a playbook as a specific user
ansible-playbook -u ubuntu playbook.yml

# 5. Check syntax of a playbook
ansible-playbook --syntax-check playbook.yml

# 6. Run in check mode (dry run)
ansible-playbook --check playbook.yml

# 7. Limit execution to a specific host/group
ansible-playbook -l webservers playbook.yml

# 8. Start at a specific task
ansible-playbook playbook.yml --start-at-task="Install Nginx"
