salt:
  master:
    fileserver_backend:
      - git

    gitfs_remotes:
      - https://github.com/saltstack-formulas/salt-formula
      - https://github.com/ahdinosaur/butt-as-a-service:
        - root: salt/state

    ext_pillar_privkey: /root/.ssh/id_rsa
    ext_pillar_pubkey: /root/.ssh/id_rsa.pub
    ext_pillar:
      - git:
        - master git@github.com:ahdinosaur/salt.butt.nz:
          - root: salt/pillar

  minion:
    master: salt.butt.nz
