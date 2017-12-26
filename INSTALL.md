# install

---

create [OVH Public Cloud account[(https://ovh.com)

---

generate SSH key for OVH

```shell
ssh-keygen -t rsa -b 8192 -f ~/.ssh/ovh
```

upload to OVH

---

create vRack and private network

---

provision new server for salt master

- name: salt.domain.tld
- os: Debian 9
- size: S1-2 (1 vCPU, 2 GB mem)
- private network: yes

---

connect to new server

```shell
ssh -i ~/.ssh/ovh debian@<public_ip_address>
```

[install salt stack (for Debian)](https://repo.saltstack.com/#debian)

```shell
wget -O - https://repo.saltstack.com/apt/debian/9/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/debian/9/amd64/latest stretch main" > /etc/apt/sources.list.d/saltstack.list
apt update
apt install -y salt-master salt-minion salt-cloud python-pygit2
```

---

generate salt master's ssh key for GitHub

```shell
ssh-keygen -t rsa -b 8192 /etc/salt/pki/github
```

upload to GitHub (or git provider): https://github.com/settings/keys

---

update master config

```shell
nano /etc/salt/master
```

```yaml
interface: <private_ip_address>
keysize: 8192

fileserver_backend:
  - git

gitfs_remotes:
  - git://github.com/saltstack-formulas/salt-formula
  - git://github.com/saltstack-formulas/docker-formula
  - git://github.com/ahdinosaur/butt-as-a-service:
    - root: salt/state

git_pillar_privkey: /etc/salt/pki/github
git_pillar_pubkey: /etc/salt/pki/github.pub
ext_pillar:
  - git:
    - master git@github.com:${user}/${repo}:
      - root: salt/pillar
```

---

update minion config

```shell
nano /etc/salt/minion
```

```yml
master: 127.0.0.1
```

---

restart salt servers

```shell
service salt-minion restart
service salt-master restart
```

---

list minion keys

```shell
salt-key --list all
```

---

accept new key

```shell
salt-key -a ${key}
```

---

test first minion

```shell
salt '*' test.ping
```

---

update master grains

```shell
nano /etc/salt/grains
``

```yaml
roles:
  - master
  - minion
```

---

run high state

```shell
salt '*' state.highstate
```
