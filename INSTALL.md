# install

---

provision new Scaleway server

---

install salt stack

```shell
cd ~
apt update
apt install -y python-pygit2
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh -P -M git v2017.7.2
```

---

update master config

```shell
ssh-keygen -t rsa -b 8192
nano /etc/salt/master
```

```
ext_pillar:
  - git:
    - master git@github.com:${user}/${repo}:
      - root: salt/pillar
      - privkey: /root/.ssh/id_rsa
      - pubkey: /root/.ssh/id_rsa.pub
```

```yml
master: 127.0.0.1
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
sudo salt-key --list all
```

---

accept new key

```shell
sudo salt-key -a ${key}
```

---

test first minion

```shell
sudo salt '*' test.ping
```

---

## references

- https://www.digitalocean.com/community/tutorials/saltstack-infrastructure-installing-the-salt-master
- https://www.digitalocean.com/community/tutorials/saltstack-infrastructure-configuring-salt-cloud-to-spin-up-digitalocean-resources
