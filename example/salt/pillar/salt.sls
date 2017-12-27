{% set master = '192.168.0.100' %}
{% set keysize = 8192 %}

{% set id = salt['grains.get']('id') %}

salt: 
  install_packages: False

  minion_remove_config: True
  master_remove_config: True

  master:
    keysize: {{ keysize }}

    fileserver_backend:
      - git

    gitfs_remotes:
      - git://github.com/saltstack-formulas/salt-formula.git
      - git://github.com/saltstack-formulas/docker-formula.git
      - git://github.com/ahdinosaur/butt-as-a-service.git:
        - root: salt/state

    git_pillar_privkey: /etc/salt/pki/github
    git_pillar_pubkey: /etc/salt/pki/github.pub
    ext_pillar:
      - git:
        - master git@github.com:ahdinosaur/salt.butt.nz.git:
          - root: salt/pillar

  minion:
    master: {{ master }}
    keysize: {{ keysize }}

    mine_functions:
      public_ip_addrs:
        mine_function: network.ip_addrs
        type: public
      private_ip_addrs:
        mine_function: network.ip_addrs
        type: private

    {# TODO make a formula to do /etc/salt/grains #}
    grains:
      id: {{ id }}

      {% set roles = salt['grains.get']('roles', []) %}
      {% if roles %}
      roles:
        {% for role in roles %}
        - {{ role }}
        {% endfor %}
      {% endif %}

  cloud:
    providers:
      ovh.conf:
        ovh:
          driver: openstack
          region_name: WAW1
          auth:
            auth_url: https://auth.cloud.ovh.net/v2.0/
            username: qrGGDwAZZKhC
            password: abcdefghijklmnopqrstuvwxyz012345
            project_id: cca6608c1346428d9c0ea5748bf91272
          nics:
            - net-id: 0781b9ed-45f1-40e6-abf1-6d87cd189714
            - net-id: 6c928965-47ea-463f-acc8-6d4a152e9745

    profiles:
      base.conf:
        hub:
          provider: ovh
          minion:
            master: {{ master }}
            grains:
              roles:
                - minion

      ovh.conf:
        hub_ovh:
          provider: ovh
          size: s1-2
          image: Debian 9
          sudo: True
          ssh_username: debian
          ssh_key_name: salt
          ssh_key_file: /etc/salt/pki/ovh
          minion:
            master: {{ master }}
            grains:
              roles:
                - minion

        hub_ovh_b2_15:
          provider: ovh
          size: b2-15
          image: Debian 9
          sudo: True
          ssh_username: debian
          ssh_key_name: salt
          ssh_key_file: /etc/salt/pki/ovh
          minion:
            master: {{ master }}
            grains:
              roles:
                - minion
