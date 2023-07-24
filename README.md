# ansible-cli

##### ansible install
```
sudo apt-add-repository ppa:ansible/ansible
```
```
sudo apt-get update
```
```
sudo apt-get install -y ansible
```

##### ansible version
```
ansible --version
```

##### ansible ping test(ping module)
```
ansible -m ping localhost
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