ahdinosaur/ssb-pub:
  docker_image.present

ahdinosaur/healer:
  docker_image.present

healer:
  docker_container.running:
    - image: ahdinosaur/healer
    - name: healer
    - binds:
      - /var/run/docker.sock:/tmp/docker.sock
    - restart_policy: unless-stopped
    - require:
      - docker_image: ahdinosaur/healer

{% set seeds = salt['pillar.get']('hub:seeds', []) %}
{% set pubs = salt['pillar.get']('hub:pubs', []) %}

{% for pub in pubs %}

{% set name = pub.name %}
{% set port = pub.port or 8008 %}

{% set secret = pub.secret %}
{% set curve = secret.curve %}
{% set public = secret.public %}
{% set private = secret.private %}

{{ name }}/:
  file.directory:
    - name: /root/bots/{{ name }}/
    - mode: 755
    - user: debian
    - group: debian
    - recurse:
      - user
      - group

{{ name }}/secret:
  file.managed:
    - name: /root/bots/{{ name }}/secret
    - dataset:
      curve: {{ curve }}
      public: {{ public }}.{{ curve }}
      private: {{ private }}.{{ curve }}
      id: "@{{ public }}.{{ curve }}"
    - mode: 0400
    - user: debian
    - group: debian
    - formatter: json
    - merge_if_exists: True
    - require:
      - file: {{ name }}/

{{ name }}/config:
  file.serialize:
    - name: /root/bots/{{ name }}/config
    - dataset:
      seeds:
        - net:{{ name }}:{{ port }}~shs:{{ public }}
        {% for seed in seeds %}
        - {{ seed }}
        {% endfor %}
    - formatter: json
    - mode: 644
    - user: debian
    - group: debian
    - merge_if_exists: True
    - require:
      - file: {{ name }}/

{{ name }}:
  docker_container.running:
    - image: ahdinosaur/ssb-pub
    - name: {{ name }}
    - env:
      - ssb_host: {{ name }}
    - binds:
      - /root/bots/{{ name }}:/home/node/.ssb/
    - ports:
      - 8008
    - restart_policy: unless-stopped
    - require:
      - docker_image: ahdinosaur/ssb-pub
      - file: {{ name }}/secret
      - file: {{ name }}/config

{% endfor %}
