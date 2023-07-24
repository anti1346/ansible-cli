# ansible-cli

##### ansible version
```
ansible --version
```

##### ansible.cfg
```
ansible-config init --disabled -t all > ansible.cfg
```
```
vim ansible.cfg
```
```
[defaults]
inventory = ~/git-root/ansible-cli/inventory/hosts.ini
host_key_checking = False
```

##### ansible inventory
```
ansible-inventory --graph
```

##### ansible-playbook 명령어
```
ansible-playbook check-icmp-ping.yml --limit localhost
```

```
ansible-playbook -i ~/ansible-spec/inventory check-icmp-ping.yml --limit localhost
```

```
ansible-playbook -i ~/ansible-spec/inventory edit_hosts_file.yml --tags "add_hosts_entry"
```