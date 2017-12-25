base:
  '*':
    - docker
  'roles:master':
    - match: grain
    - salt.master
  'roles:minion':
    - match: grain
    - salt.minion
  'roles:pub'
    - match: grain
    - pub
