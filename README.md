# ansible-cli

##### ansible version
```
ansible --version
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
