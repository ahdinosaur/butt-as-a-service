{# TODO 

apt update
apt upgrade -y
apt install -y apt-transport-https ca-certificates curl software-properties-common
wget https://download.docker.com/linux/debian/gpg -O docker-gpg
sudo apt-key add docker-gpg
echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee -a /etc/apt/sources.list.d/docker.list
apt update
apt install -y docker-ce
systemctl start docker
systemctl enable docker

docker pull ahdinosaur/ssb-pub

mkdir /root/ssb-pub-data
chown -R 1000:1000 /root/ssb-pub-data

docker run -d --name sbot \
   -v ~/ssb-pub-data/:/home/node/.ssb/ \
   -e ssb_host="<hostname.yourdomain.tld>" \
   -p 8008:8008 --restart unless-stopped \
   ahdinosaur/ssb-pub

#}

ahdinosaur/ssb-pub:
  docker_image.present

ahdinosaur/healer:
  docker_image.present

healer:
  docker_container.running:
    - image: ahdinosaur/healer
    - require:
      - docker_image: ahdinosaur/healer

{% set pubs = salt['grains.get']('pub.list', []) %}
{% for pub in pubs %}

{% set name = pub.name %}

/root/bots/{{name}}
  file.directory

/root/bots/{{name}}/secret
  file.managed:
    - mode:
    - require:
      - file: /root/bots/{{name}}

/root/bots/{{name}}/gossip.json
  file.managed:
    - require:
      - file: /root/bots/{{name}}

{{name}}:
  docker_container.running:
    - image: ahdinosaur/ssb-pub
    - env:
      - ssb_host: {{name}}
    - binds:
      - /root/bots/{{name}}:/home/node/.ssb/
    - ports:
      - 8008
    - restart_policy: unless-stopped
    - require:
      - docker_image: ahdinosaur/ssb-pub
      - file: /root/bots/{{name}}/secret
      - file: /root/bots/{{name}}/gossip.json

{% endfor %}
