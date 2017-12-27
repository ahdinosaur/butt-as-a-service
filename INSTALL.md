# install

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

install dependencies

```shell
sudo apt update
sudo apt install -y git python-pygit2 # gitfs / git_pillar deps
```

install salt stack

```shell
wget -O - https://bootstrap.saltstack.com | sudo sh -s -- -P -M -L git develop
```

> at the moment we depend on the latest git version for recent changes to OpenStack cloud
>
> when this is released, we can follow the [normal install process for Debian](https://repo.saltstack.com/#debian)
>
> ```shell
> wget -O - https://repo.saltstack.com/apt/debian/9/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
> echo "deb http://repo.saltstack.com/apt/debian/9/amd64/latest stretch main" | sudo tee /etc/apt/sources.list.d/saltstack.list
> sudo apt update
> sudo apt install -y salt-master salt-minion salt-cloud
> ```

---

generate salt master's ssh key for GitHub

```shell
sudo ssh-keygen -t rsa -b 8192 -f /etc/salt/pki/github
```

upload to GitHub (or git provider): https://github.com/settings/keys

```shell
sudo cat /etc/salt/pki/github.pub
```

---

update master and minion config

```shell
# CHANGE ME
user=ahdinosaur
name=salt.butt.nz
private_ip_address=192.168.0.100

private_config_repo=git@github.com:${user}/${name}
keysize=8192

sudo tee /etc/salt/master << EOF
interface: ${private_ip_address}
keysize: ${keysize}

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
    - master ${private_config_repo}:
      - root: salt/pillar
EOF

sudo tee /etc/salt/minion << EOF
master: ${private_ip_address}
keysize: ${keysize}
grains:
  id: ${name}
  roles:
    - master
    - minion
EOF
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

yay! :tada:

---

> (not currently used)
>
> update mine
>
> ```shell
> sudo salt '*' mine.update
> ```

---

apply state

```shell
sudo salt '*' state.apply
```

---

install nova

```
sudo apt install -y python-novaclient
```

get OpenStack credentials from provider

```shell

tee ~/rc.sh << EOF
export OS_AUTH_URL=https://auth.cloud.ovh.net/v2.0/
export OS_TENANT_ID=cca6608c1346428d9c0ea5748bf91272
export OS_TENANT_NAME="3526803835773644"
export OS_USERNAME="qrGGDwAZZKhC"
echo "Please enter your OpenStack Password: "
read -sr OS_PASSWORD_INPUT
export OS_PASSWORD=\$OS_PASSWORD_INPUT
export OS_REGION_NAME="WAW1"
EOF
```

source with `source ~/rc.sh`

> to find available flavors
> 
> ```shell
> nova flavor-list
> ```

> to find available images
> 
> ```shell
> nova image-list
> ```

> to find available networks
> 
> ```shell
> nova tenant-network-list
> ```

---

generate salt master's ssh key for Open Stack provider

```shell
sudo ssh-keygen -t rsa -b 8192 -f /etc/salt/pki/ovh
```

add our new keypair to provider

```
debian@salt:~$ nova keypair-list
+------+-------------+
| Name | Fingerprint |
+------+-------------+
+------+-------------+
debian@salt:~$ sudo -i
root@salt:~# source /home/debian/rc.sh
Please enter your OpenStack Password: 
root@salt:~# nova keypair-add --pub-key /etc/salt/pki/ovh.pub salt
root@salt:~# nova keypair-list
+-----------+-------------------------------------------------+
| Name | Fingerprint                                     |
+-----------+-------------------------------------------------+
| salt | aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99 |
+-----------+-------------------------------------------------+
root@salt:~# exit
```

---

provision your first hub(s)!

```shell
sudo salt-cloud -p hub_ovh_b2_15 green.butt.nz
```

:cake:

```shell
sudo salt '*' test.ping
```

```shell
sudo salt '*' grains.items
```

---

apply the state to the new minion(s)

```shell
sudo salt '*' state.apply
```

---

login to the hub from the salt master

```shell
hub_ip_address=192.168.0.200
sudo ssh -i /etc/salt/pki/ovh debian@${hub_ip_address}
```
