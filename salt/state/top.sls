base:
  'roles:master':
    - match: grain
    - salt.master
  'roles:minion':
    - match: grain
    - salt.minion
