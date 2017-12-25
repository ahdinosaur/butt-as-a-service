base:
  '*':
    - docker
  'roles:master':
    - match: grain
    - salt
  'roles:minion':
    - match: grain
    - salt
  'roles:hub':
    - match: grain
    - hub
