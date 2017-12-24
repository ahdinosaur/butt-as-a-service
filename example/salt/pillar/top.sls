base:
  '*':
    - agents
  'roles:master':
    - match: grain
    - salt
  'roles:minion':
    - match: grain
    - salt
