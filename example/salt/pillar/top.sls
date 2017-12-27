base:
  '*':
    - docker
  'roles:master':
    - match: grain
    - salt
    - hub
  'roles:minion':
    - match: grain
    - salt
  'roles:hub':
    - match: grain
    - hub
