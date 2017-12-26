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
echo "deb http://repo.saltstack.com/apt/debian/9/amd64/latest stretch main" | sudo tee /etc/apt/sources.list.d/saltstack.list
sudo apt update
sudo apt install -y salt-master salt-minion salt-cloud git python-pygit2 python-setuptools python-novaclient python-glanceclient python-netaddr
```

---

generate salt master's ssh key for GitHub

```shell
sudo ssh-keygen -t rsa -b 8192 -f /etc/salt/pki/github
```

upload to GitHub (or git provider): https://github.com/settings/keys

```shell
cat /etc/salt/pki/github.pub
```

---

update master config

```shell
sudo nano /etc/salt/master
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
sudo nano /etc/salt/minion
```

```yml
master: <private_ip_address>
keysize: 8192
```

---

restart salt servers

```shell
sudo service salt-minion restart
sudo service salt-master restart
```

---

list minion keys

```shell
sudo salt-key --list all
```

---

accept new key

```shell
sudo salt-key -a ${key}
```

---

test minion

```shell
sudo salt '*' test.ping
```

---

update mine

```shell
sudo salt '*' mine.update
```

---

on local machine,

copy example pillar to new repo

```shell
cp -r example ../salt.domain.tld
cd ../salt.domain.tld
git init
# edit values
git push origin master
```

---

back on the remote server,

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
sudo salt '*' state.highstate
```
