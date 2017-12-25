salt: 
  minion_remove_config: True
  master_remove_config: True

  master:
    fileserver_backend:
      - git

    gitfs_remotes:
      - git://github.com/saltstack-formulas/salt-formula.git
      - git://github.com/saltstack-formulas/docker-formula.git
      - git://github.com/ahdinosaur/butt-as-a-service.git:
        - root: salt/state

    git_pillar_privkey: /root/.ssh/id_rsa
    git_pillar_pubkey: /root/.ssh/id_rsa.pub
    ext_pillar:
      - git:
        - master git@github.com:ahdinosaur/salt.butt.nz.git:
          - root: salt/pillar

  minion:
    master: salt.butt.nz
