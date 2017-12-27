base:
  '*':
    - base
    - docker
  'roles:master':
    - match: grain
    - salt.master
    - salt.cloud
    - cloud
  'roles:minion':
    - match: grain
    - salt.minion
  'roles:hub':
    - match: grain
    - hub
